-- vehicle fov adjustment based on user settings
-- vehicle fov redcued for passengers with weapons, to allow vehicle fov to be the same across all states
Hooks:OverrideFunction(PlayerDriving, "get_zoom_fov", function (self, stance_data)
	if self._vehicle == nil then
		return PlayerStandard.get_zoom_fov(self, stance_data)
	end

	local fov = self._vehicle_ext._tweak_data.fov or stance_data and stance_data.FOV or 75

	if self._seat.allow_shooting or self._stance == PlayerDriving.STANCE_SHOOTING then
		local shooterFOV = PlayerStandard.get_zoom_fov(self, {
			FOV = fov
		})

		-- only reduce fov if not ads
		if not stance_data.zoom_fov then
			shooterFOV = shooterFOV / managers.user:get_setting("fov_multiplier")
		end

		return shooterFOV
	end

	return fov
end)