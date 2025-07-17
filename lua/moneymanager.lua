Hooks:PreHook(MoneyManager, "civilian_killed", "Gilza_civ_kill_tracker_stockholm", function(self)
	-- track civ kills for new stockholm basic. for some reason copdamage:die does not trigger for civs, even though it should.
	if managers.player:has_category_upgrade("player", "menace_panic_spread") then
		local orig_amount = managers.player._Gilza_menace_kill_tracker
		managers.player._Gilza_menace_kill_tracker = managers.player._Gilza_menace_kill_tracker + 1.5
		if orig_amount < 4 and managers.player._Gilza_menace_kill_tracker > 4 then
			Gilza.New_Skills_Informer:adjusted_stockholm_stacks(4-managers.player._Gilza_menace_kill_tracker)
			managers.player._Gilza_menace_kill_tracker = 4
		elseif managers.player._Gilza_menace_kill_tracker > 4 then
			managers.player._Gilza_menace_kill_tracker = 4
		else
			Gilza.New_Skills_Informer:adjusted_stockholm_stacks(1.5)
		end
	end
end)