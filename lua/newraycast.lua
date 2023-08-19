-- adjust acc in single fire
function NewRaycastWeaponBase:conditional_accuracy_multiplier(current_state)
	local mul = 1

	if not current_state then
		return mul
	end

	local pm = managers.player
	
	-- Gilza start
	-- 30% inaccuracy for some weapon types in full auto
	if not self:is_single_shot() then
		for _, category in ipairs(self:categories()) do
			-- assuming there are no weird weapon hybrids that have both smg and ar category
			if category == "smg" or category == "assault_rifle" or category == "lmg" then
				mul = mul - 0.3
			end
		end
	end
	
	if managers.player:current_state() == "bipod" then
		mul = mul + 0.8
	end
	
	if current_state._moving then
		if current_state:in_steelsight() then 
			mul = mul - (1 - pm:upgrade_value("player", "weapon_movement_accuracy_nullifier", 0.75))
		else
			mul = mul - (1 - pm:upgrade_value("player", "weapon_movement_stability", 0.75))
		end
	end
	
	-- bellow is base game code

	if current_state:in_steelsight() and self:is_single_shot() then
		mul = mul + 1 - pm:upgrade_value("player", "single_shot_accuracy_inc", 1)
	end

	if current_state:in_steelsight() then
		for _, category in ipairs(self:categories()) do
			mul = mul + 1 - managers.player:upgrade_value(category, "steelsight_accuracy_inc", 1)
		end
	end

	--[[ fire control skill, moved above
	if current_state._moving then
		mul = mul + 1 - pm:upgrade_value("player", "weapon_movement_stability", 1)
	end
	]]
	mul = mul + 1 - pm:get_property("desperado", 1)
	
	return self:_convert_add_to_mul(mul)
end

function NewRaycastWeaponBase:recoil_multiplier()
	local is_moving = false
	local user_unit = self._setup and self._setup.user_unit

	if user_unit then
		is_moving = alive(user_unit) and user_unit:movement() and user_unit:movement()._current_state and user_unit:movement()._current_state._moving
	end
	
	local multiplier = managers.blackmarket:recoil_multiplier(self._name_id, self:weapon_tweak_data().categories, self._silencer, self._blueprint, is_moving)

	if self._alt_fire_active and self._alt_fire_data then
		multiplier = multiplier * (self._alt_fire_data.recoil_mul or 1)
	end
	
	-- 50% extra recoil for some weapon types in single fire
	if self:is_single_shot() then
		for _, category in ipairs(self:categories()) do
			if category == "smg" or category == "assault_rifle" or category == "lmg" then
				multiplier = multiplier * 0.5
			end
		end
	end
	
	return multiplier
	
end

function NewRaycastWeaponBase:replenish()
	local ammo_max_multiplier = managers.player:upgrade_value("player", "extra_ammo_multiplier", 1) * managers.player:upgrade_value("player", "extra_ammo_cut", 1)
	for _, category in ipairs(self:weapon_tweak_data().categories) do
		ammo_max_multiplier = ammo_max_multiplier * managers.player:upgrade_value(category, "extra_ammo_multiplier", 1)
	end

	ammo_max_multiplier = ammo_max_multiplier + ammo_max_multiplier * (self._total_ammo_mod or 0)

	if managers.player:has_category_upgrade("player", "add_armor_stat_skill_ammo_mul") then
		ammo_max_multiplier = ammo_max_multiplier * managers.player:body_armor_value("skill_ammo_mul", nil, 1)
	end

	ammo_max_multiplier = managers.modifiers:modify_value("WeaponBase:GetMaxAmmoMultiplier", ammo_max_multiplier)
	local ammo_max_per_clip = self:calculate_ammo_max_per_clip()
	local ammo_max = math.round((tweak_data.weapon[self._name_id].AMMO_MAX + managers.player:upgrade_value(self._name_id, "clip_amount_increase") * ammo_max_per_clip) * ammo_max_multiplier)
	ammo_max_per_clip = math.min(ammo_max_per_clip, ammo_max)

	self:set_ammo_max_per_clip(ammo_max_per_clip)
	self:set_ammo_max(ammo_max)
	self:set_ammo_total(ammo_max)
	self:set_ammo_remaining_in_clip(ammo_max_per_clip)

	self._ammo_pickup = tweak_data.weapon[self._name_id].AMMO_PICKUP

	if self._assembly_complete then
		for _, gadget in ipairs(self:get_all_override_weapon_gadgets()) do
			if gadget and gadget.replenish then
				gadget:replenish()
			end
		end
	end

	self:update_damage()
end