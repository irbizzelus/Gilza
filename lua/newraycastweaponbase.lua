-- accuracy adjustments @11-26
Hooks:OverrideFunction(NewRaycastWeaponBase, "conditional_accuracy_multiplier", function (self, current_state)
	local mul = 1

	if not current_state then
		return mul
	end

	local pm = managers.player
	
	-- GILZA START
	-- 25% inaccuracy for all weapon types if firing in full auto
	if not self:is_single_shot() then
		mul = mul - 0.25
	end
	
	-- 70% bonus while bipoded, it also sompensates the full auto penalty, since lmgs cant be in single fire without mods anyway
	if managers.player:current_state() == "bipod" then
		mul = mul + 0.95
	end
	
	-- 25% inaccuracy for hipfire, unless we have new skill
	if not current_state:in_steelsight() then
		mul = mul - managers.player:upgrade_value("player", "hipfire_no_accuracy_penalty", 0.25)
	end
	-- GILZA END

	if current_state:in_steelsight() and self:is_single_shot() then
		mul = mul + 1 - pm:upgrade_value("player", "single_shot_accuracy_inc", 1)
	end

	if current_state:in_steelsight() then
		for _, category in ipairs(self:categories()) do
			mul = mul + 1 - pm:upgrade_value("player", "steelsight_accuracy_inc", 1)
		end
	end

	mul = mul + 1 - pm:get_property("desperado", 1)
	
	return self:_convert_add_to_mul(mul)
end)

-- recoil adjustments @67-70
Hooks:OverrideFunction(NewRaycastWeaponBase, "recoil_multiplier", function (self)
	local is_moving = false
	local user_unit = self._setup and self._setup.user_unit

	if user_unit then
		is_moving = alive(user_unit) and user_unit:movement() and user_unit:movement()._current_state and user_unit:movement()._current_state._moving
	end

	local multiplier = managers.blackmarket:recoil_multiplier(self._name_id, self:weapon_tweak_data().categories, self._silencer, self._blueprint, is_moving)

	if self._alt_fire_active and self._alt_fire_data then
		multiplier = multiplier * (self._alt_fire_data.recoil_mul or 1)
	end
	
	local current_state
	if user_unit then
		current_state = alive(user_unit) and user_unit:movement() and user_unit:movement()._current_state
	end
	
	if not current_state then
		return multiplier
	end
	
	-- 40% worse recoil if hipfiring without new skill
	if not current_state:in_steelsight() then
		multiplier = multiplier * managers.player:upgrade_value("player", "hipfire_less_recoil", 1.4)
	end
	
	return multiplier

end)

-- code is based on WeaponLib's newraycast hook. ammo cut for brawler deck @93. ammo override/total_ammo_mod compatibility with total ammo skills fixed @87 and @99
Hooks:PostHook(NewRaycastWeaponBase, "replenish", "Gilza_replenish", function(self)
	local original_tweak_data = tweak_data.weapon[self._name_id]
	local weapon_tweak_data = self:weapon_tweak_data()

	local ammo_max_multiplier = managers.player:upgrade_value("player", "extra_ammo_multiplier", 1)

	for _, category in ipairs(weapon_tweak_data.categories) do
		ammo_max_multiplier = ammo_max_multiplier + managers.player:upgrade_value(category, "extra_ammo_multiplier", 1) - 1
	end

	--ammo_max_multiplier = ammo_max_multiplier + ammo_max_multiplier * (self._total_ammo_mod or 0)

	if managers.player:has_category_upgrade("player", "add_armor_stat_skill_ammo_mul") then
		ammo_max_multiplier = ammo_max_multiplier * managers.player:body_armor_value("skill_ammo_mul", nil, 1)
	end
	
	ammo_max_multiplier = ammo_max_multiplier * managers.player:upgrade_value("player", "extra_ammo_cut", 1)

	ammo_max_multiplier = managers.modifiers:modify_value("WeaponBase:GetMaxAmmoMultiplier", ammo_max_multiplier)
	local ammo_max_per_clip = self:calculate_ammo_max_per_clip()

	local ammo_max_override_delta = weapon_tweak_data.AMMO_MAX - original_tweak_data.AMMO_MAX
	local ammo_max = math.round(((original_tweak_data.AMMO_MAX + (managers.player:upgrade_value(self._name_id, "clip_amount_increase") * ammo_max_per_clip) + ammo_max_override_delta + math.round(original_tweak_data.AMMO_MAX * (self._total_ammo_mod or 0))) * ammo_max_multiplier))
	ammo_max_per_clip = math.min(ammo_max_per_clip, ammo_max)

	self:set_ammo_max_per_clip(ammo_max_per_clip + self:get_chamber_size())
	self:set_ammo_max(ammo_max)
	self:set_ammo_total(ammo_max)
	self:set_ammo_remaining_in_clip(ammo_max_per_clip)

	self._ammo_pickup = weapon_tweak_data.AMMO_PICKUP
end)

-- new reload speeds from tweaked 'overkill' and new akimbo skill; @116-137
Hooks:OverrideFunction(NewRaycastWeaponBase, "reload_speed_multiplier", function (self)
	if self._current_reload_speed_multiplier then
		return self._current_reload_speed_multiplier
	end

	local multiplier = 1

	local simplified_categories = {}
	for _, category in ipairs(self:weapon_tweak_data().categories) do
		multiplier = multiplier + 1 - managers.player:upgrade_value(category, "reload_speed_multiplier", 1)
		simplified_categories[category] = true
	end
	
	if simplified_categories.akimbo and managers.player:has_category_upgrade("akimbo", "pistol_improved_handling") then
		if simplified_categories.pistol or (simplified_categories.smg and managers.player:has_category_upgrade("akimbo", "allow_smg_improved_handling")) then
			local skill = managers.player:upgrade_value("akimbo", "pistol_improved_handling")
			if skill and type(skill) ~= "number" then
				multiplier = multiplier + 1 - skill.reload
			end	
		end
	end
	
	if managers.player:has_category_upgrade("player", "speed_junkie_meter_boost_agility") then
		local counter = managers.player._Gilza_junkie_counter or 0
		local skill = managers.player:upgrade_value("player", "speed_junkie_meter_boost_agility")
		if skill and type(skill) ~= "number" then
			local mul = (skill.reload - 1) * (counter / 100) + 1
			multiplier = multiplier + 1 - mul
		end	
	end
	
	if managers.player:has_category_upgrade("temporary", "overkill_damage_multiplier") and managers.player:temporary_upgrade_value("temporary", "overkill_damage_multiplier", 1) > 1 then
		if managers.player:has_category_upgrade("player", "overkill_all_weapons") then
			multiplier = multiplier - 0.5
		elseif simplified_categories.shotgun or simplified_categories.saw then
			multiplier = multiplier - 0.5
		end
	end

	multiplier = multiplier + 1 - managers.player:upgrade_value("weapon", "passive_reload_speed_multiplier", 1)
	multiplier = multiplier + 1 - managers.player:upgrade_value(self._name_id, "reload_speed_multiplier", 1)

	if self._setup and alive(self._setup.user_unit) and self._setup.user_unit:movement() then
		local morale_boost_bonus = self._setup.user_unit:movement():morale_boost()

		if morale_boost_bonus then
			multiplier = multiplier + 1 - morale_boost_bonus.reload_speed_bonus
		end

		if self._setup.user_unit:movement():next_reload_speed_multiplier() then
			multiplier = multiplier + 1 - self._setup.user_unit:movement():next_reload_speed_multiplier()
		end
	end

	if managers.player:has_activate_temporary_upgrade("temporary", "reload_weapon_faster") then
		multiplier = multiplier + 1 - managers.player:temporary_upgrade_value("temporary", "reload_weapon_faster", 1)
	end

	if managers.player:has_activate_temporary_upgrade("temporary", "single_shot_fast_reload") then
		multiplier = multiplier + 1 - managers.player:temporary_upgrade_value("temporary", "single_shot_fast_reload", 1)
	end

	multiplier = multiplier + 1 - managers.player:get_property("shock_and_awe_reload_multiplier", 1)
	multiplier = multiplier + 1 - managers.player:get_temporary_property("bloodthirst_reload_speed", 1)
	multiplier = multiplier + 1 - managers.player:upgrade_value("team", "crew_faster_reload", 1)
	multiplier = self:_convert_add_to_mul(multiplier)
	multiplier = multiplier * self:reload_speed_stat()
	multiplier = managers.modifiers:modify_value("WeaponBase:GetReloadSpeedMultiplier", multiplier)

	return multiplier
end)

local ids_single = Idstring("single")
local ids_auto = Idstring("auto")
local ids_burst = Idstring("burst")
local ids_volley = Idstring("volley")
-- allow total_ammo_mod stat to have float values @397-400
Hooks:OverrideFunction(NewRaycastWeaponBase, "_update_stats_values", function (self, disallow_replenish, ammo_data)
	self:_default_damage_falloff()
	self:_check_sound_switch()

	self._silencer = managers.weapon_factory:has_perk("silencer", self._factory_id, self._blueprint)
	local weapon_perks = managers.weapon_factory:get_perks(self._factory_id, self._blueprint) or {}

	if weapon_perks.fire_mode_auto then
		self._locked_fire_mode = ids_auto
	elseif weapon_perks.fire_mode_single then
		self._locked_fire_mode = ids_single
	elseif weapon_perks.fire_mode_burst then
		self._locked_fire_mode = ids_burst
	elseif weapon_perks.fire_mode_volley then
		self._locked_fire_mode = ids_volley
	else
		self._locked_fire_mode = nil
	end

	self._fire_mode = self._locked_fire_mode or self:get_recorded_fire_mode(self:_weapon_tweak_data_id()) or Idstring(self:weapon_tweak_data().FIRE_MODE or "single")
	self._ammo_data = ammo_data or managers.weapon_factory:get_ammo_data_from_weapon(self._factory_id, self._blueprint) or {}
	self._can_shoot_through_shield = tweak_data.weapon[self._name_id].can_shoot_through_shield
	self._can_shoot_through_enemy = tweak_data.weapon[self._name_id].can_shoot_through_enemy
	self._can_shoot_through_wall = tweak_data.weapon[self._name_id].can_shoot_through_wall
	self._armor_piercing_chance = self:weapon_tweak_data().armor_piercing_chance or 0
	local primary_category = self:weapon_tweak_data().categories and self:weapon_tweak_data().categories[1]
	self._movement_penalty = tweak_data.upgrades.weapon_movement_penalty[primary_category] or 1
	self._burst_count = self:weapon_tweak_data().BURST_COUNT or 3
	local fire_mode_data = self:weapon_tweak_data().fire_mode_data or {}
	local volley_fire_mode = fire_mode_data.volley

	if volley_fire_mode then
		self._volley_spread_mul = volley_fire_mode.spread_mul or 1
		self._volley_damage_mul = volley_fire_mode.damage_mul or 1
		self._volley_ammo_usage = volley_fire_mode.ammo_usage or 1
		self._volley_rays = volley_fire_mode.rays or 1
	end

	local custom_stats = managers.weapon_factory:get_custom_stats_from_weapon(self._factory_id, self._blueprint)
	local part_data = nil
	local is_underbarrel = self.is_underbarrel and self:is_underbarrel()
	local weap_factory_parts = tweak_data.weapon.factory.parts

	for part_id, stats in pairs(custom_stats) do
		part_data = weap_factory_parts[part_id]
		local can_apply = true

		if part_data.type == "underbarrel_ammo" then
			can_apply = is_underbarrel
		elseif part_data.type == "ammo" then
			can_apply = not is_underbarrel
		end

		if can_apply then
			if stats.movement_speed then
				self._movement_penalty = self._movement_penalty * stats.movement_speed
			end

			if part_data.type ~= "ammo" and part_data.type ~= "underbarrel_ammo" then
				if stats.ammo_pickup_min_mul then
					self._ammo_data.ammo_pickup_min_mul = self._ammo_data.ammo_pickup_min_mul and self._ammo_data.ammo_pickup_min_mul * stats.ammo_pickup_min_mul or stats.ammo_pickup_min_mul
				end

				if stats.ammo_pickup_max_mul then
					self._ammo_data.ammo_pickup_max_mul = self._ammo_data.ammo_pickup_max_mul and self._ammo_data.ammo_pickup_max_mul * stats.ammo_pickup_max_mul or stats.ammo_pickup_max_mul
				end

				if stats.ammo_offset then
					self._ammo_data.ammo_offset = (self._ammo_data.ammo_offset or 0) + stats.ammo_offset
				end

				if stats.fire_rate_multiplier then
					self._ammo_data.fire_rate_multiplier = (self._ammo_data.fire_rate_multiplier or 0) + stats.fire_rate_multiplier - 1
				end
			end

			if stats.burst_count then
				self._burst_count = stats.burst_count
			end

			if stats.volley_spread_mul then
				self._volley_spread_mul = stats.volley_spread_mul
			end

			if stats.volley_damage_mul then
				self._volley_damage_mul = stats.volley_damage_mul
			end

			if stats.volley_ammo_usage then
				self._volley_ammo_usage = stats.volley_ammo_usage
			end

			if stats.volley_rays then
				self._volley_rays = stats.volley_rays
			end
		end
	end

	local damage_falloff = {
		optimal_distance = self._optimal_distance,
		optimal_range = self._optimal_range,
		near_falloff = self._near_falloff,
		far_falloff = self._far_falloff,
		near_multiplier = self._near_multiplier,
		far_multiplier = self._far_multiplier
	}

	managers.blackmarket:modify_damage_falloff(damage_falloff, custom_stats)

	self._optimal_distance = damage_falloff.optimal_distance
	self._optimal_range = damage_falloff.optimal_range
	self._near_falloff = damage_falloff.near_falloff
	self._far_falloff = damage_falloff.far_falloff
	self._near_multiplier = damage_falloff.near_multiplier
	self._far_multiplier = damage_falloff.far_multiplier

	if self._ammo_data then
		if self._ammo_data.can_shoot_through_shield ~= nil then
			self._can_shoot_through_shield = self._ammo_data.can_shoot_through_shield
		end

		if self._ammo_data.can_shoot_through_enemy ~= nil then
			self._can_shoot_through_enemy = self._ammo_data.can_shoot_through_enemy
		end

		if self._ammo_data.can_shoot_through_wall ~= nil then
			self._can_shoot_through_wall = self._ammo_data.can_shoot_through_wall
		end

		if self._ammo_data.bullet_class ~= nil then
			self._bullet_class = CoreSerialize.string_to_classtable(self._ammo_data.bullet_class)
			self._bullet_slotmask = self._bullet_class:bullet_slotmask()

			if self._setup and self._setup.user_unit == managers.player:player_unit() then
				self._bullet_slotmask = managers.mutators:modify_value("RaycastWeaponBase:modify_slot_mask", self._bullet_slotmask)
			end

			self._blank_slotmask = self._bullet_class:blank_slotmask()
		end

		if self._ammo_data.armor_piercing_add ~= nil then
			self._armor_piercing_chance = math.clamp(self._armor_piercing_chance + self._ammo_data.armor_piercing_add, 0, 1)
		end

		if self._ammo_data.armor_piercing_mul ~= nil then
			self._armor_piercing_chance = math.clamp(self._armor_piercing_chance * self._ammo_data.armor_piercing_mul, 0, 1)
		end
	end

	if self._silencer then
		self._muzzle_effect = Idstring(self:weapon_tweak_data().muzzleflash_silenced or "effects/payday2/particles/weapons/9mm_auto_silence_fps")
	elseif self._ammo_data and self._ammo_data.muzzleflash ~= nil then
		self._muzzle_effect = Idstring(self._ammo_data.muzzleflash)
	else
		self._muzzle_effect = Idstring(self:weapon_tweak_data().muzzleflash or "effects/particles/test/muzzleflash_maingun")
	end

	self._muzzle_effect_table = {
		effect = self._muzzle_effect,
		parent = self._obj_fire,
		force_synch = self._muzzle_effect_table.force_synch or false
	}

	if self._ammo_data and self._ammo_data.trail_effect ~= nil then
		self._trail_effect = Idstring(self._ammo_data.trail_effect)
	else
		self._trail_effect = self:weapon_tweak_data().trail_effect and Idstring(self:weapon_tweak_data().trail_effect) or self.TRAIL_EFFECT
	end

	self._trail_effect_table = {
		effect = self._trail_effect,
		position = Vector3(),
		normal = Vector3()
	}
	local base_stats = self:weapon_tweak_data().stats

	if not base_stats then
		return
	end

	local parts_stats = managers.weapon_factory:get_stats(self._factory_id, self._blueprint)
	local stats = deep_clone(base_stats)
	local stats_tweak_data = tweak_data.weapon.stats
	local modifier_stats = self:weapon_tweak_data().stats_modifiers
	local bonus_stats = self._cosmetics_bonus and self._cosmetics_data and self._cosmetics_data.bonus and tweak_data.economy.bonuses[self._cosmetics_data.bonus] and tweak_data.economy.bonuses[self._cosmetics_data.bonus].stats or {}

	if managers.job:is_current_job_competitive() or managers.weapon_factory:has_perk("bonus", self._factory_id, self._blueprint) then
		bonus_stats = {}
	end

	if self.modify_base_stats then
		self:modify_base_stats(stats)
	end

	if stats.zoom then
		stats.zoom = math.min(stats.zoom + managers.player:upgrade_value(primary_category, "zoom_increase", 0), #stats_tweak_data.zoom)
	end

	for stat, _ in pairs(stats) do
		if stats[stat] < 1 or stats[stat] > #stats_tweak_data[stat] then
			Application:error("[NewRaycastWeaponBase] Base weapon stat is out of bound!", "stat: " .. stat, "index: " .. stats[stat], "max_index: " .. #stats_tweak_data[stat], "This stat will be clamped!")
		end

		if parts_stats[stat] then
			stats[stat] = stats[stat] + parts_stats[stat]
		end

		if bonus_stats[stat] then
			stats[stat] = stats[stat] + bonus_stats[stat]
		end

		stats[stat] = math.clamp(stats[stat], 1, #stats_tweak_data[stat])
	end

	self._current_stats_indices = stats
	self._current_stats = {}

	for stat, i in pairs(stats) do
		if stat == "total_ammo_mod" then
			local index = math.floor(i * 1000 + 0.5)
			index = index / 1000
			self._current_stats[stat] = stats_tweak_data[stat] and stats_tweak_data[stat][index] or 1
		else
			self._current_stats[stat] = stats_tweak_data[stat] and stats_tweak_data[stat][i] or 1
		end

		if modifier_stats and modifier_stats[stat] then
			self._current_stats[stat] = self._current_stats[stat] * modifier_stats[stat]
		end
	end

	self._current_stats.alert_size = stats_tweak_data.alert_size[math.clamp(stats.alert_size, 1, #stats_tweak_data.alert_size)]

	if modifier_stats and modifier_stats.alert_size then
		self._current_stats.alert_size = self._current_stats.alert_size * modifier_stats.alert_size
	end

	if stats.concealment then
		stats.suspicion = math.clamp(#stats_tweak_data.concealment - base_stats.concealment - (parts_stats.concealment or 0), 1, #stats_tweak_data.concealment)
		self._current_stats.suspicion = stats_tweak_data.concealment[stats.suspicion]
	end

	if parts_stats and parts_stats.spread_multi then
		self._current_stats.spread_multi = parts_stats.spread_multi
	end

	self._alert_size = self._current_stats.alert_size or self._alert_size
	self._suppression = self._current_stats.suppression or self._suppression
	self._zoom = self._current_stats.zoom or self._zoom
	self._spread = self._current_stats.spread or self._spread
	self._recoil = self._current_stats.recoil or self._recoil
	self._spread_moving = self._current_stats.spread_moving or self._spread_moving
	self._extra_ammo = self._current_stats.extra_ammo or self._extra_ammo
	self._total_ammo_mod = self._current_stats.total_ammo_mod or self._total_ammo_mod

	if self._ammo_data.ammo_offset then
		self._extra_ammo = self._extra_ammo + self._ammo_data.ammo_offset
	end

	self._reload = self._current_stats.reload or self._reload
	self._spread_multiplier = self._current_stats.spread_multi or self._spread_multiplier
	self._scopes = managers.weapon_factory:get_parts_from_weapon_by_type_or_perk("scope", self._factory_id, self._blueprint)
	self._has_range_distance_scope = self:_chk_has_range_distance_scope()
	self._unit_health_displays = managers.weapon_factory:get_parts_from_weapon_by_type_or_perk("display_unit_health", self._factory_id, self._blueprint)
	self._has_unit_health_display = self:_chk_has_unit_health_display()
	self._can_highlight_with_perk = managers.weapon_factory:has_perk("highlight", self._factory_id, self._blueprint)
	self._can_highlight_with_skill = managers.player:has_category_upgrade("weapon", "steelsight_highlight_specials")
	self._can_highlight = self._can_highlight_with_perk or self._can_highlight_with_skill

	self:_check_reticle_obj()

	if not disallow_replenish then
		self:replenish()
	end

	local user_unit = self._setup and self._setup.user_unit
	local current_state = alive(user_unit) and user_unit:movement() and user_unit:movement()._current_state
	self._fire_rate_multiplier = managers.blackmarket:fire_rate_multiplier(self._name_id, self:weapon_tweak_data().categories, self._silencer, nil, current_state, self._blueprint)

	if self._ammo_data.fire_rate_multiplier then
		self._fire_rate_multiplier = self._fire_rate_multiplier + self._ammo_data.fire_rate_multiplier
	end
end)