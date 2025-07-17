-- Reduced melee camera shake skill
Hooks:OverrideFunction(PlayerCamera, "play_shaker", function (self, effect, amplitude, frequency, offset)
	if _G.IS_VR then
		return
	end
	
	if effect == "melee_hit" or effect == "melee_hit_var2" then
		amplitude = managers.player:upgrade_value("player", "melee_shake_reduction", 1)
	end
	
	return self._shaker:play(effect, amplitude or 1, frequency or 1, offset or 0)
end)