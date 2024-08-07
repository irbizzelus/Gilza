Hooks:PreHook(PlayerTased, "enter", "Gilza_tazer_bullets_trigger", function(self, state_data, enter_data)
	if managers.player:has_category_upgrade("temporary", "tased_electric_bullets") then
		managers.player:activate_temporary_upgrade("temporary", "tased_electric_bullets")
	end
end)