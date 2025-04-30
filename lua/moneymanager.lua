Hooks:PreHook(MoneyManager, "civilian_killed", "Gilza_civ_kill_tracker", function(self)
	-- track civ kills for new stockholm basic. for some reason copdamage:die does not trigger for civs, even though it should.
	managers.player._Gilza_menace_kill_tracker = managers.player._Gilza_menace_kill_tracker + 1
	if managers.player._Gilza_menace_kill_tracker >= 4 then
		managers.player._Gilza_menace_kill_tracker = 4
	end
end)