if not Gilza then
	dofile("mods/Gilza/lua/1_GilzaBase.lua")
end

-- convert melee damage to % based on the weapon's stat
Hooks:PreHook(CopDamage, "damage_melee", "Gilza_CopDamage_damage_melee_pre", function(self,attack_data)
	-- if incoming melee was a bullet_taze, apply headshot dmg increase. this is needed for electric boolets upgrade
	if attack_data.bullet_taze == true then
		local head = self._head_body_name and attack_data.col_ray.body and attack_data.col_ray.body:name() == self._ids_head_body_name
		if not self._char_tweak.ignore_headshot and not self._damage_reduction_multiplier and head then
			if self._char_tweak.headshot_dmg_mul then
				attack_data.damage = attack_data.damage * self._char_tweak.headshot_dmg_mul
			end
		end
		return -- dont do the usual % damage stuff since this damage is already taken from weapon's bullet damage
	end
	
	if not attack_data.Gilza_melee_damage_tweak_applied then
	
		local dmg_multiplier = 1
		
		-- new zerk melee skills
		if managers.player:has_category_upgrade("temporary", "new_berserk_melee_damage_multiplier_2") then -- split into 2 upgrades cause this code is ancient when i did not know better. dont judge me.
			dmg_multiplier = dmg_multiplier * managers.player:temporary_upgrade_value("temporary", "new_berserk_melee_damage_multiplier_2", 1)
		elseif managers.player:has_category_upgrade("temporary", "new_berserk_melee_damage_multiplier_1") then
			dmg_multiplier = dmg_multiplier * managers.player:temporary_upgrade_value("temporary", "new_berserk_melee_damage_multiplier_1", 1)
		end
		
		dmg_multiplier = dmg_multiplier + managers.player:upgrade_value("player", "melee_damage_newzerk_addin", 0)
		
		attack_data.damage = attack_data.damage * dmg_multiplier
	
		if self._char_tweak.Gilza_boss_tag then
			attack_data.damage = (self._HEALTH_INIT * (attack_data.damage / 200)) -- bosses take 20x the amount of hits
		elseif self._char_tweak.Gilza_boss_tag_deep then
			attack_data.damage = (self._HEALTH_INIT * (attack_data.damage / 400)) -- crude awakening boss takes 40x the amount of hits, because this fucker is tanky and techically last boss of the game
		elseif self._char_tweak.Gilza_winters_tag then
			attack_data.damage = (self._HEALTH_INIT * (attack_data.damage / 20)) -- winters takes 2x the amount of hits
		elseif self._char_tweak.Gilza_headless_dozer_tag then
			local reduction = 150
			if Global.game_settings and Global.game_settings.difficulty and Global.game_settings.difficulty == "sm_wish" then -- 2x for DS
				reduction = 300
			end
			attack_data.damage = (self._HEALTH_INIT * (attack_data.damage / reduction)) -- headless dozers take 15x the amount of hits, cuz thats like their only weakness
		elseif self._char_tweak.access == "tank" then
			local reduction = 100
			if Global.game_settings and Global.game_settings.difficulty and Global.game_settings.difficulty == "sm_wish" then
				reduction = 200
			end
			attack_data.damage = (self._HEALTH_INIT * (attack_data.damage / reduction)) -- dozers take 10-20x the amount of hits
		else
			attack_data.damage = self._HEALTH_INIT * (attack_data.damage / 10) + 0.1 -- +1 dmg is needed due to rounding calculations with low hp targets, like street cops, that leave them with 0.1 hp instead of killing them sometimes
		end
		-- failsafe to prevent from overwriting damage twice, which should never happen anyway
		attack_data.Gilza_melee_damage_tweak_applied = true
	end
end)

local mvec_1 = Vector3()
local mvec_2 = Vector3()
local local_shotgun_shot_id = -1
Gilza.was_first_pellet_proccessed = {}
Gilza.first_pellet_headshot_bonus = {}
Gilza.is_current_shotgun_critical = {}
Gilza.rolled_shotgun_crit_already = {}

-- override damage_bullet function to add new armor pen skills, allow throawble weapons like axes to perice body armour
-- and to add the new shotgun damage, loosely based on COD:BO3 shotgun mechanics. also added bodyshot buckshot ammo dmg increase
Hooks:OverrideFunction(CopDamage, "damage_bullet", function (self, attack_data)
	
	if self._dead or self._invulnerable then
		return
	end

	if self:is_friendly_fire(attack_data.attacker_unit) then
		return "friendly_fire"
	end

	if self:chk_immune_to_attacker(attack_data.attacker_unit) then
		return
	end

	if self._char_tweak.bullet_damage_only_from_front then
		mvector3.set(mvec_1, attack_data.col_ray.ray)
		mvector3.set_z(mvec_1, 0)
		mrotation.y(self._unit:rotation(), mvec_2)
		mvector3.set_z(mvec_2, 0)

		local not_from_the_front = mvector3.dot(mvec_1, mvec_2) > 0.3

		if not_from_the_front then
			return
		end
	end
	
	local attackerIsPlayer = attack_data.attacker_unit == managers.player:player_unit()
	
	-- reduce bullet damage for headless dozers, since they ignore headshot damage, and Gilza's avg bodyshot damage is higher with lower HS muls
	-- cant change their health because of explosive weapon's breakpoints
	if self._char_tweak.Gilza_headless_tag and attackerIsPlayer then
		attack_data.damage = attack_data.damage * 0.55
	end

	local is_civilian = CopDamage.is_civilian(self._unit:base()._tweak_table)
	local allow_pen = true
	local allow_pen_from_rng = false
	
	if self._has_plate and attack_data.col_ray.body and attack_data.col_ray.body:name() == self._ids_plate_name and not attack_data.armor_piercing then
		local armor_pierce_roll = math.rand(1)
		local armor_pierce_value = 0

		if attack_data.attacker_unit == managers.player:player_unit() and not attack_data.weapon_unit:base().thrower_unit then
			armor_pierce_value = armor_pierce_value + attack_data.weapon_unit:base():armor_piercing_chance()
			armor_pierce_value = armor_pierce_value + managers.player:upgrade_value("player", "armor_piercing_chance", 0)
			armor_pierce_value = armor_pierce_value + managers.player:upgrade_value("weapon", "armor_piercing_chance", 0)
			armor_pierce_value = armor_pierce_value + managers.player:upgrade_value("weapon", "armor_piercing_chance_2", 0)

			if attack_data.weapon_unit:base():got_silencer() then
				armor_pierce_value = armor_pierce_value + managers.player:upgrade_value("weapon", "armor_piercing_chance_silencer", 0)
			end

			if attack_data.weapon_unit:base():is_category("saw") then
				armor_pierce_value = armor_pierce_value + managers.player:upgrade_value("saw", "armor_piercing_chance", 0)
			end
		elseif attack_data.attacker_unit:base() and attack_data.attacker_unit:base().sentry_gun then
			local owner = attack_data.attacker_unit:base():get_owner()

			if alive(owner) then
				if owner == managers.player:player_unit() then
					armor_pierce_value = armor_pierce_value + managers.player:upgrade_value("sentry_gun", "armor_piercing_chance", 0)
					armor_pierce_value = armor_pierce_value + managers.player:upgrade_value("sentry_gun", "armor_piercing_chance_2", 0)
				else
					armor_pierce_value = armor_pierce_value + (owner:base():upgrade_value("sentry_gun", "armor_piercing_chance") or 0)
					armor_pierce_value = armor_pierce_value + (owner:base():upgrade_value("sentry_gun", "armor_piercing_chance_2") or 0)
				end
			end
		end
		
		if armor_pierce_roll <= armor_pierce_value then
			allow_pen_from_rng = true
		end
	end
	
	-- if sentry shot body armor, without AP, or AP RNG success, dmg is ignored
	if attack_data.attacker_unit:base() and attack_data.attacker_unit:base().sentry_gun and self._has_plate and attack_data.col_ray.body and attack_data.col_ray.body:name() == self._ids_plate_name and not attack_data.armor_piercing and not allow_pen_from_rng then
		return
	end
	
	-- new "advnaced" backup AP: if enemy is hit in the body plate, reduce damage in half if we have new AP either only basic or aced; dont reduce dmg if we have AP aced + basic. only do this if standard AP rng failed
	if not attack_data.armor_piercing and attackerIsPlayer and self._has_plate and attack_data.col_ray.body and attack_data.col_ray.body:name() == self._ids_plate_name and not allow_pen_from_rng then
		local has_basic = managers.player:has_category_upgrade("player", "ap_bullets_basic")
		local has_aced = managers.player:has_category_upgrade("player", "ap_bullets_aced")
		if has_basic or has_aced then
			if (has_basic and not has_aced) or (has_aced and not has_basic) then
				-- allow armor piercing but reduce damage after pen in half
				attack_data.damage = attack_data.damage * 0.5
				allow_pen = true
			else
				-- if we have AP bullets normal + aced, dont reduce damage
				allow_pen = true
			end
		else
			allow_pen = false
		end
	end
	
	-- allow throwable knives and such to pen body armor
	if attack_data.weapon_unit:base().thrower_unit then
		allow_pen = true
	end
	
	-- allow saws to pen body armor, withou ap chance shenanigans
	if attack_data.weapon_unit:base().name_id == "saw" or attack_data.weapon_unit:base().name_id == "saw_secondary" then
		allow_pen = true
	end
	
	if not allow_pen then
		return
	end
	
	local shotgun_min_mul = 1
	local min_shot_dmg = 1
	-- new shotgun damage
	if attack_data and attack_data.weapon_unit and attack_data.weapon_unit:base() and attack_data.weapon_unit:base().is_category and (attack_data.weapon_unit:base():is_category("shotgun") or attack_data.weapon_unit:base():is_category("grenade_launcher")) and attack_data.weapon_unit:base()._rays and attack_data.weapon_unit:base()._rays >= 2 then
		
		-- as of 05.08.2025 weapon lib makes each shotgun pellet deal full shotgun damage instead of dealing a % of the total damage per pellet
		-- this actually helps with the new shotgun damage mechanic, but if it ever gets fixed, we need to increase it's damage back to full
		if not Gilza.isWeaponLibBroken then
			attack_data.damage = attack_data.damage * attack_data.weapon_unit:base()._rays
		end
		
		-- how new shotgun damage works:
		-- every shotgun can now have a minimal damage multiplier per shot
		-- if a shotgun has a minimal multiplier of 0.35, it would always deal at least 35% of it's max damage per hit target
		-- this damage can get multiplied by headshot damage, if at least 1 pellet from the same shotgun shot (trigger pull) hit a headshot
		-- other additional pellets deal additional damage calculated as 'leftover damage/amount of pellets'
		-- so, based on example above, all additional pellets will deal '65% of the shotgun max damage / how many pellets shotgun currently has (depends on the shotgun itself and used ammo)'
		-- this code is a bit of a mess, but the beauty of it is that its fully adaptable to shotgun pellet amount, and every shotgun can be tweaked with it's own base multiplier
		-- and it can also handle multiple enemy units per shotgun trigger pull, so if you hit 5 enemies with 1 shot, they will all take at least 35% of damage, or whatever that shotgun's value is
		-- it can also work as a prehook since attackdata's type is a list, but we still need the buckshot headshot override, and other stuff, so this is a full func override
		
		shotgun_min_mul = Gilza.shotgun_minimal_damage_multipliers[attack_data.weapon_unit:base()._name_id] or (1 / attack_data.weapon_unit:base()._rays)
		min_shot_dmg = attack_data.damage * shotgun_min_mul
		local is_headshot = self._head_body_name and attack_data.col_ray.body and attack_data.col_ray.body:name() == self._ids_head_body_name
		
		-- 'Gilza.current_shotgun_shot_id' value gets updated when we pull the trigger of our shotgun in fire_raycast function,
		-- so if this value is newer then the local one, the col_ray we are handling right now came from a new shotgun shot, so we reset all the temp values and update the local shot_id value
		if Gilza.current_shotgun_shot_id > local_shotgun_shot_id then
			local_shotgun_shot_id = Gilza.current_shotgun_shot_id
			Gilza.was_first_pellet_proccessed = {}
			Gilza.first_pellet_headshot_bonus = {}
			Gilza.rolled_shotgun_crit_already = {}
			Gilza.is_current_shotgun_critical = {}
		end
		
		-- if first pellet from the shot was not proccessed yet, we make this pellet deal the minimal weapon damage
		if not Gilza.was_first_pellet_proccessed[tostring(self._unit:id())] then
			attack_data.damage = min_shot_dmg
			Gilza.was_first_pellet_proccessed[tostring(self._unit:id())] = true
			Gilza.first_pellet_headshot_bonus[tostring(self._unit:id())] = is_headshot
		else
			-- this value checks if our current shotgun shot managed to deal a headshot with at least 1 pellet yet, if we allready did, then pellet damage is calculated normally
			if Gilza.first_pellet_headshot_bonus[tostring(self._unit:id())] then
				attack_data.damage = (attack_data.damage * (1 - shotgun_min_mul)) / (attack_data.weapon_unit:base()._rays - 1)
			else
				-- if we still did not land a headshot with any of our pellets, check if the currently proccessed pellet would hit a headshot
				if is_headshot then
					-- if it would, this pellet's damage is set to the same as the first pellet, but it's damage is multiplied by the (headshot multiplier of the enemy - 1)
					-- -1 because we allready dealt bodyshot damage to this enemy with the first pellet. then dmg is divided by original hs mul, 
					-- because later in this function damage will be increased by the hs_mul again, regardless of if it's a shotgun or not
					local hs_mul = 1
					if not self._char_tweak.ignore_headshot and not self._damage_reduction_multiplier then
						if self._char_tweak.headshot_dmg_mul then
							hs_mul = self._char_tweak.headshot_dmg_mul
						else
							hs_mul = 10
						end
					end
					-- compensation + pellet
					attack_data.damage = (min_shot_dmg * (hs_mul-1)) / hs_mul + ((attack_data.damage * (1 - shotgun_min_mul)) / (attack_data.weapon_unit:base()._rays - 1))
					Gilza.first_pellet_headshot_bonus[tostring(self._unit:id())] = true
				else
					-- if not, same normal calculation
					attack_data.damage = (attack_data.damage * (1 - shotgun_min_mul)) / (attack_data.weapon_unit:base()._rays - 1)
				end
			end
		end
	end
	
	local result = nil
	local body_index = self._unit:get_body_index(attack_data.col_ray.body:name())
	local head = self._head_body_name and attack_data.col_ray.body and attack_data.col_ray.body:name() == self._ids_head_body_name
	-- if using a weapon with buckshot tag (which only comes from said ammo), we remove all headshot damage properties,
	-- but still allow for player manager to grant us bonus armor from headshot hits, if we have them
	if attack_data.weapon_unit:base()._is_buckshot then
		if head then
			managers.player:on_headshot_dealt()
		end
		head = false
	end
	local damage = attack_data.damage

	if self._unit:base():char_tweak().DAMAGE_CLAMP_BULLET then
		damage = math.min(damage, self._unit:base():char_tweak().DAMAGE_CLAMP_BULLET)
	end
	
	if managers.player:has_category_upgrade("temporary", "new_berserk_weapon_damage_multiplier") then
		damage = damage * managers.player:temporary_upgrade_value("temporary", "new_berserk_weapon_damage_multiplier", 1)
	end

	damage = damage * (self._marked_dmg_mul or 1)

	if self._marked_dmg_dist_mul then
		local spott_dst = tweak_data.upgrades.values.player.marked_inc_dmg_distance[self._marked_dmg_dist_mul]

		if spott_dst then
			local dst = mvector3.distance(attack_data.origin, self._unit:position())

			if spott_dst[1] < dst then
				damage = damage * spott_dst[2]
			end
		end
	end

	if self._unit:movement():cool() then
		damage = self._HEALTH_INIT
	end

	local headshot = false
	local headshot_multiplier = 1

	if attack_data.attacker_unit == managers.player:player_unit() then
		local damage_scale = nil

		if alive(attack_data.weapon_unit) and attack_data.weapon_unit:base() and attack_data.weapon_unit:base().is_weak_hit then
			damage_scale = attack_data.weapon_unit:base():is_weak_hit(attack_data.col_ray and attack_data.col_ray.distance, attack_data.attacker_unit) or 1
		end

		local critical_hit, crit_damage = self:roll_critical_hit(attack_data, damage)
		
		if critical_hit then
			managers.hud:on_crit_confirmed(damage_scale)
			
			damage = crit_damage
			attack_data.critical_hit = true
		else
			managers.hud:on_hit_confirmed(damage_scale)
		end

		headshot_multiplier = managers.player:upgrade_value("weapon", "passive_headshot_damage_multiplier", 1)

		if managers.groupai:state():is_enemy_special(self._unit) then
			damage = damage * managers.player:upgrade_value("weapon", "special_damage_taken_multiplier", 1)

			if attack_data.weapon_unit:base().weapon_tweak_data then
				damage = damage * (attack_data.weapon_unit:base():weapon_tweak_data().special_damage_multiplier or 1)
			end
		end

		if head then
			managers.player:on_headshot_dealt()

			headshot = true
		end
	end

	if not self._char_tweak.ignore_headshot and not self._damage_reduction_multiplier and head then
		if self._char_tweak.headshot_dmg_mul then
			damage = damage * self._char_tweak.headshot_dmg_mul * headshot_multiplier
		else
			damage = self._health * 10
		end
	end

	if not head and not self._char_tweak.no_headshot_add_mul and attack_data.weapon_unit:base().get_add_head_shot_mul then
		local add_head_shot_mul = attack_data.weapon_unit:base():get_add_head_shot_mul()

		if add_head_shot_mul then
			if self._char_tweak.headshot_dmg_mul then
				local tweak_headshot_mul = math.max(0, self._char_tweak.headshot_dmg_mul - 1)
				local mul = tweak_headshot_mul * add_head_shot_mul + 1
				damage = damage * mul
			else
				damage = self._health * 10
			end
		end
	end
	
	damage = self:_apply_damage_reduction(damage)
	attack_data.raw_damage = damage
	attack_data.headshot = head
	-- after calculating % dmg dealt, game ceils it. this causes dmg inaccuracy within 1 chunk of health, and since HEALTH_GRANULARITY is 512, it's 1/512 of enemy's health.
	-- i am yet to find a reason for this ceil, as it doesnt seem to break any aspect of the game, it just causes your damage to always have damage inacuracy
	-- always being slightly higher, with an error range of 1/512 of enemy health. this is why dozers recieve so much extra dmg from low-dmg weapons.
	-- using non-ceiled values works fine, but overriding all functions that do this is a pointless risk for a minor fix, so i wont do it.
	-- p.s. this is the value you report to other players btw, which allows for you to tell others that you dealt 76/512 of unit's health per shot
	-- and this is why we can rebalance the game's health and damage so much, since sync is % based.
	local damage_percent = math.ceil(math.clamp(damage / self._HEALTH_INIT_PRECENT, 1, self._HEALTH_GRANULARITY))
	damage = damage_percent * self._HEALTH_INIT_PRECENT
	damage, damage_percent = self:_apply_min_health_limit(damage, damage_percent)

	if self._immortal then
		damage = math.min(damage, self._health - 1)
	end

	if self._health <= damage then
		if self:check_medic_heal() then
			result = {
				type = "healed",
				variant = attack_data.variant
			}
		else
			if head then
				managers.player:on_lethal_headshot_dealt(attack_data.attacker_unit, attack_data)
				self:_spawn_head_gadget({
					position = attack_data.col_ray.body:position(),
					rotation = attack_data.col_ray.body:rotation(),
					dir = attack_data.col_ray.ray
				})
			else
				managers.player:_Gilza_activate_bodyshot_kill_ammo_refill(attack_data)
			end
			managers.player:_Gilza_activate_bodyshot_kill_aggressive_reload(attack_data, head)

			attack_data.damage = self._health
			result = {
				type = "death",
				variant = attack_data.variant
			}

			self:die(attack_data)
			self:chk_killshot(attack_data.attacker_unit, "bullet", headshot, attack_data.weapon_unit:base():get_name_id())
		end
	else
		attack_data.damage = damage
		local result_type = not self._char_tweak.immune_to_knock_down and (attack_data.knock_down and "knock_down" or attack_data.stagger and not self._has_been_staggered and "stagger") or self:get_damage_type(damage_percent, "bullet")
		result = {
			type = result_type,
			variant = attack_data.variant
		}

		self:_apply_damage_to_health(damage)
	end

	attack_data.result = result
	attack_data.pos = attack_data.col_ray.position

	if result.type == "death" then
		local data = {
			name = self._unit:base()._tweak_table,
			stats_name = self._unit:base()._stats_name,
			head_shot = head,
			weapon_unit = attack_data.weapon_unit,
			variant = attack_data.variant
		}

		if managers.groupai:state():all_criminals()[attack_data.attacker_unit:key()] then
			managers.statistics:killed_by_anyone(data)
		end

		if attack_data.attacker_unit == managers.player:player_unit() then
			local special_comment = self:_check_special_death_conditions(attack_data.variant, attack_data.col_ray.body, attack_data.attacker_unit, attack_data.weapon_unit)

			self:_comment_death(attack_data.attacker_unit, self._unit, special_comment)
			self:_show_death_hint(self._unit:base()._tweak_table)

			local attacker_state = managers.player:current_state()
			data.attacker_state = attacker_state

			managers.statistics:killed(data)
			self:_check_damage_achievements(attack_data, head)

			if not is_civilian and managers.player:has_category_upgrade("temporary", "overkill_damage_multiplier") and not attack_data.weapon_unit:base().thrower_unit and attack_data.weapon_unit:base():is_category("shotgun", "saw") then
				managers.player:activate_temporary_upgrade("temporary", "overkill_damage_multiplier")
			end

			if is_civilian then
				managers.money:civilian_killed()
			end
		elseif managers.groupai:state():is_unit_team_AI(attack_data.attacker_unit) then
			local special_comment = self:_check_special_death_conditions(attack_data.variant, attack_data.col_ray.body, attack_data.attacker_unit, attack_data.weapon_unit)

			self:_comment_death(attack_data.attacker_unit, self._unit, special_comment)
		elseif attack_data.attacker_unit:base().sentry_gun then
			if Network:is_server() then
				local server_info = attack_data.weapon_unit:base():server_information()

				if server_info and server_info.owner_peer_id ~= managers.network:session():local_peer():id() then
					local owner_peer = managers.network:session():peer(server_info.owner_peer_id)

					if owner_peer then
						owner_peer:send_queued_sync("sync_player_kill_statistic", data.name, data.head_shot and true or false, data.weapon_unit, data.variant, data.stats_name)
					end
				else
					data.attacker_state = managers.player:current_state()

					managers.statistics:killed(data)
				end
			end

			local sentry_attack_data = deep_clone(attack_data)
			sentry_attack_data.attacker_unit = attack_data.attacker_unit:base():get_owner()

			if sentry_attack_data.attacker_unit == managers.player:player_unit() then
				self:_check_damage_achievements(sentry_attack_data, head)
			else
				self._unit:network():send("sync_damage_achievements", sentry_attack_data.weapon_unit, sentry_attack_data.attacker_unit, sentry_attack_data.damage, sentry_attack_data.col_ray and sentry_attack_data.col_ray.distance, head)
			end
		end
	end

	local hit_offset_height = math.clamp(attack_data.col_ray.position.z - self._unit:movement():m_pos().z, 0, 300)
	local attacker = attack_data.attacker_unit

	if attacker:id() == -1 then
		attacker = self._unit
	end

	local weapon_unit = attack_data.weapon_unit

	if alive(weapon_unit) and weapon_unit:base() and weapon_unit:base().add_damage_result then
		weapon_unit:base():add_damage_result(self._unit, result.type == "death", attacker, damage_percent)
	end

	local variant = nil

	if result.type == "knock_down" then
		variant = 1
	elseif result.type == "stagger" then
		variant = 2
		self._has_been_staggered = true
	elseif result.type == "healed" then
		variant = 3
	else
		variant = 0
	end

	self:_send_bullet_attack_result(attack_data, attacker, damage_percent, body_index, hit_offset_height, variant)
	self:_on_damage_received(attack_data)

	if not is_civilian then
		managers.player:send_message(Message.OnEnemyShot, nil, self._unit, attack_data)
	end

	result.attack_data = attack_data

	return result
end)

-- same as the bullet function, but for fire damage. this is only used by the dragon's breath rounds, and it is a complete copy of the new shotgun damage mechanic
Hooks:PreHook(CopDamage, "damage_fire", "Gilza_CopDamage_damage_fire_pre", function(self, attack_data)
	
	-- reduce fire damage for headless dozers, since they ignore headshot damage, and Gilza's bodyshot damage is higher with lower HS muls
	-- cant change their health because of explosive weapon's breakpoints
	if self._char_tweak.Gilza_headless_tag then
		attack_data.damage = attack_data.damage * 0.55
	end
	
	-- add new weapon dmg zerk
	if managers.player:has_category_upgrade("temporary", "new_berserk_weapon_damage_multiplier") then
		attack_data.damage = attack_data.damage * managers.player:temporary_upgrade_value("temporary", "new_berserk_weapon_damage_multiplier", 1)
	end
	if attack_data and attack_data.weapon_unit and attack_data.weapon_unit:base() and attack_data.weapon_unit:base().is_category and (attack_data.weapon_unit:base():is_category("shotgun") or attack_data.weapon_unit:base():is_category("grenade_launcher")) and attack_data.weapon_unit:base()._rays and attack_data.weapon_unit:base()._rays >= 2 then
		if not Gilza.isWeaponLibBroken then
			attack_data.damage = attack_data.damage * attack_data.weapon_unit:base()._rays
		end
		local shotgun_mul = Gilza.shotgun_minimal_damage_multipliers[attack_data.weapon_unit:base()._name_id] or (1 / attack_data.weapon_unit:base()._rays)
		local is_headshot = self._head_body_name and attack_data.col_ray.body and attack_data.col_ray.body:name() == self._ids_head_body_name
		if Gilza.current_shotgun_shot_id ~= local_shotgun_shot_id then
			local_shotgun_shot_id = Gilza.current_shotgun_shot_id
			Gilza.was_first_pellet_proccessed = {}
			Gilza.first_pellet_headshot_bonus = {}
			Gilza.rolled_shotgun_crit_already = {}
			Gilza.is_current_shotgun_critical = {}
		end
		if not Gilza.was_first_pellet_proccessed[tostring(self._unit:id())] then
			attack_data.damage = attack_data.damage * shotgun_mul
			Gilza.was_first_pellet_proccessed[tostring(self._unit:id())] = true
			Gilza.first_pellet_headshot_bonus[tostring(self._unit:id())] = is_headshot
		else
			if Gilza.first_pellet_headshot_bonus[tostring(self._unit:id())] then
				attack_data.damage = (attack_data.damage * (1 - shotgun_mul)) / (attack_data.weapon_unit:base()._rays - 1)
			else
				if is_headshot then
					local hs_mul = 1
					if not self._char_tweak.ignore_headshot and not self._damage_reduction_multiplier then
						if self._char_tweak.headshot_dmg_mul then
							hs_mul = self._char_tweak.headshot_dmg_mul
						else
							hs_mul = 10
						end
					end
					attack_data.damage = ((attack_data.damage * shotgun_mul * (hs_mul - 1)) / hs_mul) + (attack_data.damage * (1 - shotgun_mul)) / (attack_data.weapon_unit:base()._rays - 1)
					Gilza.first_pellet_headshot_bonus[tostring(self._unit:id())] = true
				else
					attack_data.damage = (attack_data.damage * (1 - shotgun_mul)) / (attack_data.weapon_unit:base()._rays - 1)
				end
			end
		end
	end
end)

-- make crits always deal 2.25x damage. this change makes cloakers, dozers and Winters harder to kill, since everyone else has a 2x headshot multiplier
-- also make crits only evaluate chances once per shotgun shot, instead of per pellet (if it's per pellet, literally every shot would have a crit hitmarker)
local gilza_orig_roll_critical_hit = CopDamage.roll_critical_hit
Hooks:OverrideFunction(CopDamage, "roll_critical_hit", function (self, attack_data, damage)
	
	local res1, res2 = gilza_orig_roll_critical_hit(self, attack_data, damage)
	
	local shotgun_check = attack_data.weapon_unit and attack_data.weapon_unit:base() and attack_data.weapon_unit:base().is_category and (attack_data.weapon_unit:base():is_category("shotgun") or attack_data.weapon_unit:base():is_category("grenade_launcher")) and attack_data.weapon_unit:base()._rays and attack_data.weapon_unit:base()._rays >= 2
	if shotgun_check then
		if Gilza.rolled_shotgun_crit_already[tostring(self._unit:id())] then
			if Gilza.is_current_shotgun_critical[tostring(self._unit:id())] then
				res1 = true
			else
				res1 = false
			end
		else
			if res1 then
				Gilza.is_current_shotgun_critical[tostring(self._unit:id())] = true
			end
			Gilza.rolled_shotgun_crit_already[tostring(self._unit:id())] = true
		end
	end
	
	if res1 then
		res2 = damage * 2.25 -- new crit mul
	end
	
	return res1, res2
end)

-- sentry kill tracking for new technician skill and guardian deck
local gilza_chk_killshot_orig = CopDamage.chk_killshot
Hooks:OverrideFunction(CopDamage, "chk_killshot", function (self, attacker_unit, variant, headshot, weapon_id)
	
	-- if sentry. copied from... somewhere idk
	if alive(attacker_unit) and attacker_unit:in_slot(25) then
		
		local owned_sentry_killshot = false
		-- this func has different input parameters depending on if we are server/client
		if Network:is_server() then
			if attacker_unit:base()._owner == managers.player:player_unit() then
				owned_sentry_killshot = true
			end
		elseif attacker_unit:base()._owner_id then
			local owner_id = attacker_unit:base()._owner_id
			if managers and managers.network and managers.network:session() and managers.network:session():peer(owner_id) then
				local peer = managers.network:session():peer(owner_id)
				local unit = peer and peer:unit() or nil
				if unit and alive(unit) then
					if unit == managers.player:player_unit() then
						owned_sentry_killshot = true
					end
				end
			end
		end
		
		-- sentry killed something
		if owned_sentry_killshot then
			
			local player_unit = managers.player:player_unit()
			-- guardian health on kill
			if managers.player:has_category_upgrade("player", "guardian_health_on_kill") and alive(player_unit) and managers.player:Gilza_is_player_in_guardian_zone() then
				local diff_mul = 1
				if Global.game_settings and Global.game_settings.difficulty and Global.game_settings.difficulty == "sm_wish" then
					diff_mul = 2
				end
				local heal = managers.player:upgrade_value("player", "guardian_health_on_kill", 0) * diff_mul
				player_unit:character_damage():restore_health(heal, true)
			end
			
			-- guardian ammo pickup
			if managers.player:has_category_upgrade("player", "guardian_auto_ammo_pickup_on_kill") and alive(player_unit) and managers.player:Gilza_is_player_in_guardian_zone() then
				local function find_pickups_at_death_location(death_spot, desync_compensation)
					local desync_compensation = desync_compensation or 0
					local skill_range_increase = managers.player:upgrade_value("player", "increased_pickup_area", 1)
					local pickups = World:find_units_quick("sphere", death_spot, (20 * skill_range_increase) + desync_compensation, managers.slot:get_mask("pickups"))
					local grenade_tweak = tweak_data.blackmarket.projectiles[managers.blackmarket:equipped_grenade()]
					local may_find_grenade = not grenade_tweak.base_cooldown and managers.player:has_category_upgrade("player", "regain_throwable_from_ammo")
					
					if pickups and #pickups >= 1 then
						for _, pickup in ipairs(pickups) do
							if pickup:pickup() and pickup:pickup():pickup(player_unit) then
								if may_find_grenade then
									local data = managers.player:upgrade_value("player", "regain_throwable_from_ammo", nil)

									if data and not managers.player:got_max_grenades() then
										managers.player:add_coroutine("regain_throwable_from_ammo", PlayerAction.FullyLoaded, managers.player, data.chance, data.chance_inc)
									end
								end

								for id, weapon in pairs(player_unit:inventory():available_selections()) do
									managers.hud:set_ammo_amount(id, weapon.unit:base():ammo_info())
								end
								return true
							end
						end
					end
					return false
				end
				local death_spot = Vector3(0,0,0)
				mvector3.set(death_spot,self._unit:movement():m_pos())
				if Network and Network:is_client() then
					local max_attempts = 0 -- 3 seconds tops
					local function ammo_loop(death_spot)
						-- whenever we kill more then 1 enemy unit in one shot, this func will trigger for each dead enemy. if delayedcall name was the same, it would override
						-- first kill's delayed call with the second kill's delayed call, giving less ammo, so we are adding shot id to the name. on top of that, we add randomised number,
						-- because grenade launcher's shots fired tracker is more complex. for that case a RNG should help in cases where we get <10-20 kills per explosion. otherwise there would be higher chance for RNG to repeat itself
						DelayedCalls:Add("Gilza_try_finding_ammo_pickups_with_client_ping_compensation_for_shot_"..tostring(Gilza.weapon_shot_id).."_rng_"..tostring( math.random( math.random(0,55555), math.random(55555,99999) ) ), 0.05, function()
							if player_unit and alive(player_unit) then
								max_attempts = max_attempts + 1
								local ammo_found = find_pickups_at_death_location(death_spot,max_attempts*1.5)
								if max_attempts < 60 and not ammo_found then
									ammo_loop(death_spot)
								end
							end
						end)
					end
					ammo_loop(death_spot)
				else
					find_pickups_at_death_location(death_spot)
				end
			end
			
			-- sentry new ammo on kill skill
			if managers.player:has_category_upgrade("player", "sentry_kills_refill_ammo") then
				-- for an unknon reason to me, chk_killshot triggeres twice on kill, so we only refil once per killed unit id
				if not managers.player.sentry_kill_ammo_refill_units then
					managers.player.sentry_kill_ammo_refill_units = {}
				end
				if not managers.player.sentry_kill_ammo_refill_units[tostring(self._unit:id())] then
					managers.player.sentry_kill_ammo_refill_units[tostring(self._unit:id())] = true
					-- refil ammo
					local player_manager = managers.player
					local player_unit = player_manager:player_unit()
					local inventory = player_unit:inventory()
					if not player_unit:character_damage():dead() and inventory then
						local picked_up = false
						local available_selections = {}

						for i, weapon in pairs(inventory:available_selections()) do
							if inventory:is_equipped(i) then
								table.insert(available_selections, 1, weapon)
							else
								table.insert(available_selections, weapon)
							end
						end

						for _, weapon in ipairs(available_selections) do
							local success, add_amount = nil
							local pick_up_mul = managers.player:upgrade_value("player", "sentry_kills_refill_ammo", 0.01)
							success, add_amount = weapon.unit:base():add_ammo(pick_up_mul)
							picked_up = success or picked_up
						end
						
						if picked_up then
							player_unit:sound():play(self._pickup_event or "pickup_ammo", nil, true)
							for id, weapon in pairs(inventory:available_selections()) do
								managers.hud:set_ammo_amount(id, weapon.unit:base():ammo_info())
							end
						end
					end
				end
			end
			
		end
		
	end
	
	return gilza_chk_killshot_orig(self, attacker_unit, variant, headshot, weapon_id)
end)

-- stockholm menace and hitman checks
Hooks:PreHook(CopDamage, "die", "Gilza_CopDamage_die_pre", function(self, attack_data)
	local is_intimidated_cop = Gilza.intimidated_enemies[self._unit:id()] or false
	
	if is_intimidated_cop and attack_data.attacker_unit == managers.player:player_unit() then
		local orig_amount = managers.player._Gilza_menace_kill_tracker
		managers.player._Gilza_menace_kill_tracker = managers.player._Gilza_menace_kill_tracker + 0.5
		if orig_amount < 4 and managers.player._Gilza_menace_kill_tracker > 4 then
			Gilza.New_Skills_Informer:adjusted_stockholm_stacks(4-managers.player._Gilza_menace_kill_tracker)
			managers.player._Gilza_menace_kill_tracker = 4
		elseif managers.player._Gilza_menace_kill_tracker > 4 then
			managers.player._Gilza_menace_kill_tracker = 4
		else
			Gilza.New_Skills_Informer:adjusted_stockholm_stacks(0.5)
		end
	end
	
	if managers.player:has_category_upgrade("temporary", "player_bounty_hunter") then
		if self._unit == managers.player._gilza_hitman_bounty_target and attack_data.attacker_unit ~= managers.player:player_unit() then
			managers.player._gilza_hitman_bounty_cooldown_end = Application:time() + 40
			managers.player._gilza_hitman_has_active_bounty = false
		end
		if self._unit == managers.player._gilza_hitman_bounty_target then
			self._unit:contour():remove("generic_interactable_selected" , false)
		end
	end
end)

-- allow new "agressive reload" (body economy) to get credit from graze kills
local gilza_orig_copdamage_damage_simple = Hooks:GetFunction(CopDamage,"damage_simple")
Hooks:OverrideFunction(CopDamage, "damage_simple", function (self, attack_data)
	local res = gilza_orig_copdamage_damage_simple(self, attack_data)
	
	if res and res.type == "death" then
		if attack_data.variant == "graze" then
			managers.player:_Gilza_activate_bodyshot_kill_aggressive_reload(attack_data)
			managers.player:_Gilza_activate_bodyshot_kill_ammo_refill(attack_data)
		end
	end
	
	return res
end)