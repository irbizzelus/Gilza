-- convert melee damage to % based on the weapon's stat
Hooks:PreHook(CopDamage, "damage_melee", "Gilza_new_melee_damage", function(self,attack_data)
	if not attack_data.Gilza_melee_damage_tweak_applied then
	
		local dmg_multiplier = 1
		
		-- new zerk melee skills
		if managers.player:has_category_upgrade("temporary", "new_berserk_melee_damage_multiplier_2") then
			dmg_multiplier = dmg_multiplier * managers.player:temporary_upgrade_value("temporary", "new_berserk_melee_damage_multiplier_2", 1)
		elseif managers.player:has_category_upgrade("temporary", "new_berserk_melee_damage_multiplier_1") then
			dmg_multiplier = dmg_multiplier * managers.player:temporary_upgrade_value("temporary", "new_berserk_melee_damage_multiplier_1", 1)
		end
		
		dmg_multiplier = dmg_multiplier + managers.player:upgrade_value("player", "melee_damage_newzerk_addin", 0)
		
		attack_data.damage = attack_data.damage * dmg_multiplier
	
		if self._char_tweak.Gilza_boss_tag then
			attack_data.damage = (self._HEALTH_INIT * (attack_data.damage / 50)) -- bosses take 5x the amount of hits
		elseif self._char_tweak.Gilza_boss_tag_deep then
			attack_data.damage = (self._HEALTH_INIT * (attack_data.damage / 100)) -- crude awakening boss takes 10x the amount of hits, because this fucker is tanky and techically last boss of the game
		elseif self._char_tweak.Gilza_winters_tag then
			attack_data.damage = (self._HEALTH_INIT * (attack_data.damage / 15)) -- winters takes 1.5x the amount of hits
		elseif self._char_tweak.access == "tank" then
			attack_data.damage = (self._HEALTH_INIT * (attack_data.damage / 30)) -- dozers take thrice the amount of hits
		else
			attack_data.damage = self._HEALTH_INIT * (attack_data.damage / 10) + 0.1 -- +1 dmg is needed due to rounding calculations with low hp targets, like street cops, that leave them with 0.1 hp instead of killing them
		end
		-- failsafe to prevent from overwriting damage twice, which should never happen anyway
		attack_data.Gilza_melee_damage_tweak_applied = true
	end
end)

local mvec_1 = Vector3()
local mvec_2 = Vector3()
local local_shotgun_shot_id = -1
local was_first_pellet_proccessed = {}
local first_pellet_headshot_bonus = {}

-- override damage_bullet function to add new armor pen skills and allow throawble weapons like axes to perice body armour @168-192
-- shotgun changes @46-106
-- add buckshot tweak @199
Hooks:OverrideFunction(CopDamage, "damage_bullet", function (self, attack_data)
	
	-- new shotgun damage
	if attack_data and attack_data.weapon_unit and attack_data.weapon_unit:base() and attack_data.weapon_unit:base().is_category and (attack_data.weapon_unit:base():is_category("shotgun") or attack_data.weapon_unit:base():is_category("grenade_launcher")) and attack_data.weapon_unit:base()._rays and attack_data.weapon_unit:base()._rays >= 2 then
		
		-- as of 18.04.2024 weapon lib makes each shotgun pellet deal full shotgun damage instead of dealing a % of the total damage per pellet
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
		-- it can also work as a prehook since attackdata's type is a list, but we still need the buckshot headshot override, so keep it like this for now.
		
		local shotgun_mul = Gilza.shotgun_minimal_damage_multipliers[attack_data.weapon_unit:base()._name_id] or (1 / attack_data.weapon_unit:base()._rays)
		local is_headshot = self._head_body_name and attack_data.col_ray.body and attack_data.col_ray.body:name() == self._ids_head_body_name
		
		-- 'Gilza.current_shotgun_shot_id' value gets updated when we pull the trigger of our shotgun in fire_raycast function,
		-- so if this value is newer then the local one, the col_ray we are handling right now came from a new shotgun shot, so we reset all the temp values and update the local shot_id value
		if Gilza.current_shotgun_shot_id > local_shotgun_shot_id then
			local_shotgun_shot_id = Gilza.current_shotgun_shot_id
			was_first_pellet_proccessed = {}
			first_pellet_headshot_bonus = {}
		end
		
		-- if first pellet from the shot was not proccessed yet, we make this pellet deal the minimal weapon damage
		if not was_first_pellet_proccessed[self._unit:id()] then
			attack_data.damage = attack_data.damage * shotgun_mul
			was_first_pellet_proccessed[self._unit:id()] = true
			first_pellet_headshot_bonus[self._unit:id()] = is_headshot
		else
			-- this value checks if our current shotgun shot managed to deal a headshot with at least 1 pellet yet, if we allready did, then pellet damage is calculated normally
			if first_pellet_headshot_bonus[self._unit:id()] then
				attack_data.damage = (attack_data.damage * (1 - shotgun_mul)) / (attack_data.weapon_unit:base()._rays - 1)
			-- if we still did not land a headshot with any of our pellets, check if the currently proccessed pellet would hit a headshot
			else
				-- if we would, this pellet's damage is set to the same as the first pellet, but it's damage is multiplied by the headshot multiplier of the enemy that we will hit - 1 (-1 because we allready dealt bodyshot damage to them on our first pellet)
				-- hs_mul calculations are based on headshot calulation bellow, aka vanilla pd2 fucntion
				if is_headshot then
					local hs_mul = 1
					if not self._char_tweak.ignore_headshot and not self._damage_reduction_multiplier then
						if self._char_tweak.headshot_dmg_mul then
							hs_mul = self._char_tweak.headshot_dmg_mul
						else
							hs_mul = 10
						end
					end
					-- since this is an additional pellet that comes after the first, it should deal it's personal damage as well as the compensation for the first pellet
					attack_data.damage = (attack_data.damage * shotgun_mul * (hs_mul - 1)) + (attack_data.damage * (1 - shotgun_mul)) / (attack_data.weapon_unit:base()._rays - 1)
					first_pellet_headshot_bonus[self._unit:id()] = true
				else
					-- if not, same normal calculation
					attack_data.damage = (attack_data.damage * (1 - shotgun_mul)) / (attack_data.weapon_unit:base()._rays - 1)
				end
			end
		end
	end
	
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

	local is_civilian = CopDamage.is_civilian(self._unit:base()._tweak_table)
	local allow_pen = true
	
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
		
		if armor_pierce_roll >= armor_pierce_value then
			allow_pen = false
		end
	end
	
	local attackerIsPlayer = attack_data.attacker_unit == managers.player:player_unit()
	-- new AP: if enemy is hit in the plate, reduce damage in half if we have armor peirce basic; dont reduce dmg if we have AP aced + basic
	if (attack_data.armor_piercing or managers.player:has_category_upgrade("player", "ap_bullets_aced")) and attackerIsPlayer and self._has_plate and attack_data.col_ray.body and attack_data.col_ray.body:name() == self._ids_plate_name then
		if managers.player:has_category_upgrade("player", "ap_bullets") and not managers.player:has_category_upgrade("player", "ap_bullets_aced") or not managers.player:has_category_upgrade("player", "ap_bullets") and managers.player:has_category_upgrade("player", "ap_bullets_aced") then
			-- allow armor piercing but reduce damage after pen in half
			attack_data.damage = attack_data.damage * 0.5
			allow_pen = true
		else
			-- if we have AP bullets normal + aced, dont reduce damage
			allow_pen = true
		end
	end
	
	-- allow throwable knives and such to pen body armor
	if attack_data.weapon_unit:base().thrower_unit then
		allow_pen = true
	end
	
	-- allow saws to pen body armor
	if attack_data.weapon_unit:base().name_id == "saw" or attack_data.weapon_unit:base().name_id == "saw_secondary" then
		allow_pen = true
	end
	
	if not allow_pen then
		return
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
			end

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
Hooks:PreHook(CopDamage, "damage_fire", "Gilza_fire_shotgun_fix", function(self, attack_data)
	if attack_data and attack_data.weapon_unit and attack_data.weapon_unit:base() and attack_data.weapon_unit:base().is_category and (attack_data.weapon_unit:base():is_category("shotgun") or attack_data.weapon_unit:base():is_category("grenade_launcher")) and attack_data.weapon_unit:base()._rays and attack_data.weapon_unit:base()._rays >= 2 then
		if not Gilza.isWeaponLibBroken then
			attack_data.damage = attack_data.damage * attack_data.weapon_unit:base()._rays
		end
		local shotgun_mul = Gilza.shotgun_minimal_damage_multipliers[attack_data.weapon_unit:base()._name_id] or (1 / attack_data.weapon_unit:base()._rays)
		local is_headshot = self._head_body_name and attack_data.col_ray.body and attack_data.col_ray.body:name() == self._ids_head_body_name
		if Gilza.current_shotgun_shot_id ~= local_shotgun_shot_id then
			local_shotgun_shot_id = Gilza.current_shotgun_shot_id
			was_first_pellet_proccessed = {}
			first_pellet_headshot_bonus = {}
		end
		if not was_first_pellet_proccessed[self._unit:id()] then
			attack_data.damage = attack_data.damage * shotgun_mul
			was_first_pellet_proccessed[self._unit:id()] = true
			first_pellet_headshot_bonus[self._unit:id()] = is_headshot
		else
			if first_pellet_headshot_bonus[self._unit:id()] then
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
					attack_data.damage = (attack_data.damage * shotgun_mul * (hs_mul - 1)) + (attack_data.damage * (1 - shotgun_mul)) / (attack_data.weapon_unit:base()._rays - 1)
					first_pellet_headshot_bonus[self._unit:id()] = true
				else
					attack_data.damage = (attack_data.damage * (1 - shotgun_mul)) / (attack_data.weapon_unit:base()._rays - 1)
				end
			end
		end
	end
end)