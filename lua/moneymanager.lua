Hooks:PreHook(MoneyManager, "civilian_killed", "Gilza_civ_kill_tracker", function(self)
	-- track civ kills for new stockholm basic. for some reason copdamage:die does not trigger for civs, even though it should.
	if managers.player:has_category_upgrade("player", "menace_panic_spread") then
		managers.player._Gilza_menace_kill_tracker = managers.player._Gilza_menace_kill_tracker + 1.5
		if managers.player._Gilza_menace_kill_tracker > 4 then
			managers.player._Gilza_menace_kill_tracker = 4
		else
			managers.hud:show_hint({text = managers.localization:text("Gilza_menace_panic_spread_notification")..tostring(managers.player._Gilza_menace_kill_tracker)})
		end
	end
end)