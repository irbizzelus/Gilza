if not Gilza then
	dofile("mods/Gilza/lua/1_GilzaBase.lua")
end

-- brawler max ammo cut @9
Hooks:OverrideFunction(RaycastWeaponBase, "replenish", function (self)
	local ammo_max_multiplier = managers.player:upgrade_value("player", "extra_ammo_multiplier", 1)
	
	for _, category in ipairs(self:weapon_tweak_data().categories) do
		ammo_max_multiplier = ammo_max_multiplier + managers.player:upgrade_value(category, "extra_ammo_multiplier", 1) - 1
	end
	
	ammo_max_multiplier = ammo_max_multiplier * managers.player:upgrade_value("player", "extra_ammo_cut", 1)

	ammo_max_multiplier = ammo_max_multiplier + ammo_max_multiplier * (self._total_ammo_mod or 0)
	ammo_max_multiplier = managers.modifiers:modify_value("WeaponBase:GetMaxAmmoMultiplier", ammo_max_multiplier)
	local ammo_max_per_clip = self:calculate_ammo_max_per_clip()
	local ammo_max = math.round((tweak_data.weapon[self._name_id].AMMO_MAX + managers.player:upgrade_value(self._name_id, "clip_amount_increase") * ammo_max_per_clip) * ammo_max_multiplier)
	ammo_max_per_clip = math.min(ammo_max_per_clip, ammo_max)

	self:set_ammo_max_per_clip(ammo_max_per_clip)
	self:set_ammo_max(ammo_max)
	self:set_ammo_total(ammo_max)
	self:set_ammo_remaining_in_clip(ammo_max_per_clip)

	self._ammo_pickup = tweak_data.weapon[self._name_id].AMMO_PICKUP

	self:update_damage()
end)

-- body expertise ammo penalty @31&33; all HV GL rounds will use standard ammo pick up if user is a network client @48; saw ammo pick up skill @81; brawler pick up @79
Hooks:OverrideFunction(RaycastWeaponBase, "add_ammo", function (self, ratio, add_amount_override)
	local mul_1 = managers.player:upgrade_value("player", "pick_up_ammo_multiplier", 1) - 1
	local mul_2 = managers.player:upgrade_value("player", "pick_up_ammo_multiplier_2", 1) - 1
	local mul_3 = managers.player:upgrade_value("player", "pick_up_ammo_reduction", 1) - 1
	local crew_mul = managers.player:crew_ability_upgrade_value("crew_scavenge", 0)
	local pickup_mul = 1 + mul_1 + mul_2 + mul_3 + crew_mul

	local function _add_ammo(ammo_base, ratio, add_amount_override)
		if ammo_base:get_ammo_max() == ammo_base:get_ammo_total() then
			return false, 0
		end

		local picked_up = true
		local stored_pickup_ammo = nil
		local add_amount = add_amount_override

		if not add_amount then
			local min_pickup = ammo_base._ammo_pickup[1]
			local max_pickup = ammo_base._ammo_pickup[2]
			
			-- if we have custom ammo pick up
			if ammo_base._ammo_data and (ammo_base._ammo_data.ammo_pickup_min_mul or ammo_base._ammo_data.ammo_pickup_max_mul) then
				local HV_launchers = {
					contraband_m203 = true,
					groza_underbarrel = true,
					gre_m79 = true,
					m32 = true,
					china = true,
					slap = true
				}
				-- and used weapon is one of the launchers that has high velocity rounds
				if ammo_base._name_id and HV_launchers[ammo_base._name_id] then
					-- and we are a client, remove ammo pick up penalty because grenade velocity change would not work
					if Network and Network:is_client() then
						-- underbarrels
						if ammo_base._ammo_data.ammo_pickup_min_mul == tweak_data.weapon.factory.parts.wpn_fps_upg_a_underbarrel_velocity_frag.custom_stats.ammo_pickup_min_mul then
							ammo_base._ammo_data.ammo_pickup_min_mul = 1
							ammo_base._ammo_data.ammo_pickup_max_mul = 1
						-- other GL's
						elseif ammo_base._ammo_data.ammo_pickup_min_mul == tweak_data.weapon.factory.parts.wpn_fps_upg_a_grenade_launcher_velocity.custom_stats.ammo_pickup_min_mul then
							ammo_base._ammo_data.ammo_pickup_min_mul = 1
							ammo_base._ammo_data.ammo_pickup_max_mul = 1
						end
					end
				end
				-- P.S. techincally could break if another ammo has identical ammo pick up stat, but we can just make sure that never happens by tweaking attachment's data :)
				min_pickup = min_pickup * (ammo_base._ammo_data.ammo_pickup_min_mul or 1)
				max_pickup = max_pickup * (ammo_base._ammo_data.ammo_pickup_max_mul or 1)
			end
			
			pickup_mul = pickup_mul * managers.player:upgrade_value("player", "extra_ammo_cut", 1)
			add_amount = math.lerp(min_pickup * pickup_mul, max_pickup * pickup_mul, math.random())
			
			-- saw pick up skill
			if (ammo_base._factory_id == "wpn_fps_saw" or ammo_base._factory_id == "wpn_fps_saw_secondary") and managers.player:has_category_upgrade("player", "saw_ammo_pick_up") then
				add_amount = 5
			end
			
			picked_up = add_amount > 0
			add_amount = add_amount * (ratio or 1)
			stored_pickup_ammo = ammo_base:get_stored_pickup_ammo()

			if stored_pickup_ammo then
				add_amount = add_amount + stored_pickup_ammo

				ammo_base:remove_pickup_ammo()
			end
		end

		local rounded_amount = math.floor(add_amount)
		local new_ammo = ammo_base:get_ammo_total() + rounded_amount
		local max_allowed_ammo = ammo_base:get_ammo_max()

		if not add_amount_override and new_ammo < max_allowed_ammo then
			local leftover_ammo = add_amount - rounded_amount

			if leftover_ammo > 0 then
				ammo_base:store_pickup_ammo(leftover_ammo)
			end
		end

		ammo_base:set_ammo_total(math.clamp(new_ammo, 0, max_allowed_ammo))

		if stored_pickup_ammo then
			add_amount = math.floor(add_amount - stored_pickup_ammo)
		else
			add_amount = rounded_amount
		end
		
		return picked_up, add_amount
	end

	local picked_up, add_amount = nil
	picked_up, add_amount = _add_ammo(self, ratio, add_amount_override)

	if self.AKIMBO then
		local akimbo_rounding = self:get_ammo_total() % 2 + #self._fire_callbacks

		if akimbo_rounding > 0 then
			_add_ammo(self, nil, akimbo_rounding)
		end
	end

	for _, gadget in ipairs(self:get_all_override_weapon_gadgets()) do
		if gadget and gadget.ammo_base then
			local p, a = _add_ammo(gadget:ammo_base(), ratio, add_amount_override)
			picked_up = p or picked_up
			add_amount = add_amount + a

			if self.AKIMBO then
				local akimbo_rounding = gadget:ammo_base():get_ammo_total() % 2 + #self._fire_callbacks

				if akimbo_rounding > 0 then
					_add_ammo(gadget:ammo_base(), nil, akimbo_rounding)
				end
			end
		end
	end

	return picked_up, add_amount
end)

-- new knock down chances changes, affects the stagger skill from the body expertise tree
Hooks:OverrideFunction(RaycastWeaponBase, "is_knock_down", function (self)
	if not self._knock_down then
		return false
	end
	
	-- for damage bellow 100 stagger chance is 15%
	-- for damage above 300 stagger chance is 25%
	-- for everything in between we scale it based on damage
	local new_knock_down_chance = 0
	if self._damage >= 10 and self._damage <= 30 then
		new_knock_down_chance = 0.1 + ((self._damage - 10) / 20 * 0.1)
	elseif self._damage < 10 then
		new_knock_down_chance = 0.1
	elseif self._damage > 30 then
		new_knock_down_chance = 0.2
	end
	
	local max_threat_bonus = 2 -- 1 + 2x = 3x
	local max_req_threat = 4 -- 40
	local wpn_threat = self._suppression - 0.2
	local threat_percent = wpn_threat / max_req_threat
	local total_threat_bonus = 1 + max_threat_bonus * threat_percent
	
	if total_threat_bonus and total_threat_bonus > 1 then
		new_knock_down_chance = new_knock_down_chance * total_threat_bonus
	end
	
	-- if we only have the basic skill, use 1/5 the chance, according to skill power
	if self._knock_down == 0.05 then
		new_knock_down_chance = new_knock_down_chance / 5
	end
	
	return self._knock_down > 0 and math.random() < new_knock_down_chance
end)

-- new reload speed from the akimbo skill @182-195 and also buffed overkill @197-203
Hooks:OverrideFunction(RaycastWeaponBase, "reload_speed_multiplier", function (self)
	local multiplier = 1

	local simplified_categories = {}
	for _, category in ipairs(self:weapon_tweak_data().categories) do
		multiplier = multiplier * managers.player:upgrade_value(category, "reload_speed_multiplier", 1)
		simplified_categories[category] = true
	end
	
	if simplified_categories.akimbo and managers.player:has_category_upgrade("akimbo", "pistol_improved_handling") then
		if simplified_categories.pistol or (simplified_categories.smg and managers.player:has_category_upgrade("akimbo", "allow_smg_improved_handling")) then
			local skill = managers.player:upgrade_value("akimbo", "pistol_improved_handling")
			if skill and type(skill) ~= "number" then
				multiplier = multiplier * skill.reload
			end	
		end
	end
	
	if managers.player:has_category_upgrade("player", "speed_junkie_meter_boost_agility") then
		local counter = managers.player._Gilza_junkie_counter or 0
		local skill = managers.player:upgrade_value("player", "speed_junkie_meter_boost_agility")
		if skill and type(skill) ~= "number" then
			local mul = (skill.reload - 1) * (counter / 100) + 1
			multiplier = multiplier * mul
		end	
	end
	
	if managers.player:has_category_upgrade("temporary", "overkill_damage_multiplier") and managers.player:temporary_upgrade_value("temporary", "overkill_damage_multiplier", 1) > 1 then
		if managers.player:has_category_upgrade("player", "overkill_all_weapons") then
			multiplier = multiplier * 1.5
		elseif simplified_categories.shotgun or simplified_categories.saw then
			multiplier = multiplier * 1.5
		end
	end

	multiplier = multiplier * managers.player:upgrade_value("weapon", "passive_reload_speed_multiplier", 1)
	multiplier = multiplier * managers.player:upgrade_value(self._name_id, "reload_speed_multiplier", 1)
	multiplier = managers.modifiers:modify_value("WeaponBase:GetReloadSpeedMultiplier", multiplier)

	return multiplier
end)

-- if we are in swan song, consume reserve ammo, but dont consume ammo in the clip
Hooks:PostHook(RaycastWeaponBase, "fire", "Gilza_swan_song_ammo", function(self, from_pos, direction, dmg_mul, shoot_player, spread_mul, autohit_mul, suppr_mul, target_unit)
	local is_player = self._setup.user_unit == managers.player:player_unit()
	local consume_ammo = not managers.player:has_active_temporary_property("bullet_storm") and (not managers.player:has_activate_temporary_upgrade("temporary", "berserker_damage_multiplier") or not managers.player:has_category_upgrade("player", "berserker_no_ammo_cost")) or not is_player
	local ammo_usage = self:ammo_usage()

	if not consume_ammo and (is_player or Network:is_server()) and managers.player:has_category_upgrade("player", "berserker_no_ammo_cost") then
		local base = self:ammo_base()

		if base:get_ammo_remaining_in_clip() == 0 then
			return
		end

		if is_player then
			for _, category in ipairs(self:weapon_tweak_data().categories) do
				if managers.player:has_category_upgrade(category, "consume_no_ammo_chance") then
					local roll = math.rand(1)
					local chance = managers.player:upgrade_value(category, "consume_no_ammo_chance", 0)

					if roll < chance then
						ammo_usage = 0

						print("NO AMMO COST")
					end
				end
			end
		end

		local mutator = nil

		if managers.mutators:is_mutator_active(MutatorPiggyRevenge) then
			mutator = managers.mutators:get_mutator(MutatorPiggyRevenge)
		end

		if mutator and mutator.get_free_ammo_chance and mutator:get_free_ammo_chance() then
			ammo_usage = 0
		end

		local ammo_in_clip = base:get_ammo_remaining_in_clip()
		local remaining_ammo = ammo_in_clip - ammo_usage

		if remaining_ammo < 0 then
			ammo_usage = ammo_usage + remaining_ammo
			remaining_ammo = 0
		end

		if ammo_in_clip > 0 and remaining_ammo <= (self.AKIMBO and 1 or 0) then
			local w_td = self:weapon_tweak_data()

			if w_td.animations and w_td.animations.magazine_empty then
				self:tweak_data_anim_play("magazine_empty")
			end

			if w_td.sounds and w_td.sounds.magazine_empty then
				self:play_tweak_data_sound("magazine_empty")
			end

			if w_td.effects and w_td.effects.magazine_empty then
				self:_spawn_tweak_data_effect("magazine_empty")
			end

			self:set_magazine_empty(true)
		end
		
		if not managers.player:has_active_temporary_property("bullet_storm") then
			if base:get_ammo_total() == base:get_ammo_remaining_in_clip() then
				base:set_ammo_remaining_in_clip(ammo_in_clip - ammo_usage)
			end
			self:use_ammo(base, ammo_usage)
		end
		
	end
end)

-- electric bullets + saw no headshot
local instantbullet_give_impact_dmg_orig = InstantBulletBase.give_impact_damage
Hooks:OverrideFunction(InstantBulletBase, "give_impact_damage", function (self, col_ray, weapon_unit, user_unit, damage, armor_piercing, shield_knock, knock_down, stagger, variant)
	
	-- don't do anything on bows and crossbows due to crashes. also they are not boolets
	if weapon_unit:base():is_category("bow") or weapon_unit:base():is_category("crossbow") then
		return instantbullet_give_impact_dmg_orig(self, col_ray, weapon_unit, user_unit, damage, armor_piercing, shield_knock, knock_down, stagger, variant)
	end
	
	local hit_unit = col_ray.unit
	local is_valid_target = hit_unit and hit_unit:character_damage() and hit_unit:character_damage()._char_tweak and hit_unit:character_damage()._char_tweak.access
	local is_target_tank = is_valid_target and hit_unit:character_damage()._char_tweak.access == "tank"
	local is_target_winters = is_valid_target and hit_unit:base():char_tweak().Gilza_winters_tag
	
	-- remove saw's headshot damage for non-dozer enemies
	if weapon_unit:base():is_category("saw") then
		if is_valid_target and not is_target_tank then
			local head = hit_unit:character_damage()._head_body_name and col_ray.body and col_ray.body:name() == hit_unit:character_damage()._ids_head_body_name
			if not hit_unit:character_damage()._char_tweak.ignore_headshot and not hit_unit:character_damage()._damage_reduction_multiplier and head and hit_unit:character_damage()._char_tweak.headshot_dmg_mul then
				damage = damage / hit_unit:character_damage()._char_tweak.headshot_dmg_mul
			end
		end
	end
	
	-- adds new electric bullets skill, for x seconds after getting tazed
	if user_unit == managers.player:player_unit() and managers.player:has_activate_temporary_upgrade("temporary", "tased_electric_bullets") and not is_target_tank and not is_target_winters then
		local action_data = {}
		action_data.weapon_unit = weapon_unit
		action_data.attacker_unit = user_unit
		action_data.col_ray = col_ray
		action_data.armor_piercing = armor_piercing
		action_data.attack_dir = col_ray.ray
		action_data.variant = "taser_tased"
		action_data.damage = damage
		action_data.damage_effect = 1
		action_data.name_id = "taser"
		action_data.charge_lerp_value = 0
		action_data.bullet_taze = true
		
		defense_data = hit_unit and hit_unit:character_damage().damage_tase and hit_unit:character_damage().damage_melee and hit_unit:character_damage():damage_melee(action_data)
		if defense_data and hit_unit and hit_unit:character_damage().damage_tase then
			action_data.damage = 0
			action_data.damage_effect = nil
			hit_unit:character_damage():damage_tase(action_data)
			return defense_data
		else
			return instantbullet_give_impact_dmg_orig(self, col_ray, weapon_unit, user_unit, damage, armor_piercing, shield_knock, knock_down, stagger, variant)
		end
	else
		return instantbullet_give_impact_dmg_orig(self, col_ray, weapon_unit, user_unit, damage, armor_piercing, shield_knock, knock_down, stagger, variant)
	end
end)

Hooks:PreHook(RaycastWeaponBase, "_fire_raycast", "Gilza_bullet_fired_tracker", function(user_unit, from_pos, direction, dmg_mul, shoot_player, spread_mul, autohit_mul, suppr_mul)
	Gilza.weapon_shot_id = Gilza.weapon_shot_id + 1
end)

-- fix flamethrower magazines not adjusting dot type that is applied to the enemy
Hooks:OverrideFunction(DOTBulletBase, "_dot_data_by_weapon", function (self, weapon_unit)
	local weap_base = alive(weapon_unit) and weapon_unit:base()
	local ammo_data = weap_base.ammo_data and weap_base:ammo_data()
	local dot_data_name = ammo_data and ammo_data.dot_data_name

	if not dot_data_name then
		local weapon_tweak_data = weap_base and weap_base.weapon_tweak_data and weap_base:weapon_tweak_data()
		dot_data_name = weapon_tweak_data and weapon_tweak_data.dot_data_name
	end
	
	-- if dot requesting weapon has a mag, check if that mag has a custom_stats dot property and if so, return it
	local mag_mods = managers.weapon_factory:get_parts_from_weapon_by_type_or_perk("magazine", weap_base._factory_id, weap_base._blueprint)
	if #mag_mods >=1 then
		for _, mag in ipairs(mag_mods) do
			local factory_part = tweak_data.weapon.factory.parts[mag]
			if factory_part then
				if factory_part.custom_stats and factory_part.custom_stats.dot_data_name then
					dot_data_name = factory_part.custom_stats.dot_data_name
					break
				end
			end
		end
	end

	if dot_data_name then
		return tweak_data.dot:get_dot_data(dot_data_name)
	end

	return nil
end)