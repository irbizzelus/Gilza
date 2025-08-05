-- if the fake armor bug happens with stoic/guardian, whenever you join in as client the "you are hurt, take cover" popup msg is removed
Hooks:OverrideFunction(HUDManager, "set_player_armor", function (self, data)
	self:set_teammate_armor(HUDManager.PLAYER_PANEL, data)
end)