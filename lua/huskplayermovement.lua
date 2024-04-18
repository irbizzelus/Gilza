Hooks:PostHook(HuskPlayerMovement, "set_need_revive", "Gilza_swan_song_speed_on_husk_downed", function(self, need_revive, down_time)
	if need_revive and managers.player:has_activate_temporary_upgrade("temporary", "berserker_damage_multiplier") then
		tweak_data.upgrades.berserker_movement_speed_multiplier = 1
		DelayedCalls:Add("Gilza_reset_swan_song_speed", 3, function()
			tweak_data.upgrades.berserker_movement_speed_multiplier = 0.4
		end)
	end
end)