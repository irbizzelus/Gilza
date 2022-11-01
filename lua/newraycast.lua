-- adjust acc in single fire
function NewRaycastWeaponBase:conditional_accuracy_multiplier(current_state)
	local mul = 1

	if not current_state then
		return mul
	end

	local pm = managers.player
	
	if self:is_single_shot() then
		mul = mul + 1 - 0.7
	end
	
	if managers.player:current_state() == "bipod" then
		mul = mul + 1 - 0.8
	end
	
	if current_state:in_steelsight() and current_state._moving then
		mul = mul + 1 - pm:upgrade_value("player", "weapon_movement_accuracy_nullifier", 1)
	end

	if current_state:in_steelsight() and self:is_single_shot() then
		mul = mul + 1 - pm:upgrade_value("player", "single_shot_accuracy_inc", 1)
	end

	if current_state:in_steelsight() then
		for _, category in ipairs(self:categories()) do
			mul = mul + 1 - managers.player:upgrade_value(category, "steelsight_accuracy_inc", 1)
		end
	end

	if current_state._moving then
		mul = mul + 1 - pm:upgrade_value("player", "weapon_movement_stability", 1)
	end

	mul = mul + 1 - pm:get_property("desperado", 1)

	return self:_convert_add_to_mul(mul)
end
-- adjust recoil in single fire
function NewRaycastWeaponBase:recoil_multiplier()
	local is_moving = false
	local user_unit = self._setup and self._setup.user_unit

	if user_unit then
		is_moving = alive(user_unit) and user_unit:movement() and user_unit:movement()._current_state and user_unit:movement()._current_state._moving
	end
	
	if self:is_single_shot() then
		return managers.blackmarket:recoil_multiplier(self._name_id, self:weapon_tweak_data().categories, self._silencer, self._blueprint, is_moving) * 0.7
	else
		return managers.blackmarket:recoil_multiplier(self._name_id, self:weapon_tweak_data().categories, self._silencer, self._blueprint, is_moving) 
	end
end