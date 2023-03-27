Hooks:OverrideFunction(WeaponAmmo, "replenish", function(self)
	local ammo_max_multiplier = managers.player:upgrade_value("player", "extra_ammo_multiplier", 1) * managers.player:upgrade_value("player", "extra_ammo_cut", 1)

	for _, category in ipairs(self:weapon_tweak_data().categories) do
		ammo_max_multiplier = ammo_max_multiplier * managers.player:upgrade_value(category, "extra_ammo_multiplier", 1)
	end

	ammo_max_multiplier = managers.modifiers:modify_value("WeaponBase:GetMaxAmmoMultiplier", ammo_max_multiplier)
	local ammo_max_per_clip = self:calculate_ammo_max_per_clip()
	local ammo_max = math.round((self:weapon_tweak_data().AMMO_MAX + managers.player:upgrade_value(self._name_id, "clip_amount_increase") * ammo_max_per_clip) * ammo_max_multiplier)
	ammo_max_per_clip = math.min(ammo_max_per_clip, ammo_max)

	self:set_ammo_max(ammo_max)
	self:set_ammo_max_per_clip(ammo_max_per_clip)
	self:set_ammo_total(ammo_max)
	self:set_ammo_remaining_in_clip(ammo_max_per_clip)

	self._ammo_pickup = self:weapon_tweak_data().AMMO_PICKUP
end)