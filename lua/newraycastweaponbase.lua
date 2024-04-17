-- accuracy adjustments
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

-- recoil adjustments @67-73
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

-- ammo cut for brawler deck @84. code is based on WeaponLib's newraycast hook
Hooks:PostHook(NewRaycastWeaponBase, "replenish", "Gilza_replenish", function(self)
	local original_tweak_data = tweak_data.weapon[self._name_id]
	local weapon_tweak_data = self:weapon_tweak_data()

	local ammo_max_multiplier = managers.player:upgrade_value("player", "extra_ammo_multiplier", 1) * managers.player:upgrade_value("player", "extra_ammo_cut", 1)

	for _, category in ipairs(weapon_tweak_data.categories) do
		ammo_max_multiplier = ammo_max_multiplier * managers.player:upgrade_value(category, "extra_ammo_multiplier", 1)
	end

	ammo_max_multiplier = ammo_max_multiplier + ammo_max_multiplier * (self._total_ammo_mod or 0)

	if managers.player:has_category_upgrade("player", "add_armor_stat_skill_ammo_mul") then
		ammo_max_multiplier = ammo_max_multiplier * managers.player:body_armor_value("skill_ammo_mul", nil, 1)
	end

	ammo_max_multiplier = managers.modifiers:modify_value("WeaponBase:GetMaxAmmoMultiplier", ammo_max_multiplier)
	local ammo_max_per_clip = self:calculate_ammo_max_per_clip()

	local ammo_max_override_delta = weapon_tweak_data.AMMO_MAX - original_tweak_data.AMMO_MAX
	local ammo_max = math.round(((original_tweak_data.AMMO_MAX + (managers.player:upgrade_value(self._name_id, "clip_amount_increase") * ammo_max_per_clip)) * ammo_max_multiplier) + ammo_max_override_delta)
	ammo_max_per_clip = math.min(ammo_max_per_clip, ammo_max)

	self:set_ammo_max_per_clip(ammo_max_per_clip + self:get_chamber_size())
	self:set_ammo_max(ammo_max)
	self:set_ammo_total(ammo_max)
	self:set_ammo_remaining_in_clip(ammo_max_per_clip)

	self._ammo_pickup = weapon_tweak_data.AMMO_PICKUP
end)

-- new reload speeds from tweaked 'overkill' and new akimbo skill; @119-140
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