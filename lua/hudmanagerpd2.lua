-- removes "you are hurt, take cover" popup msg whenever the "fake armor" bug happens, whenever you join in as client
Hooks:OverrideFunction(HUDManager, "set_player_armor", function (self, data)
	self:set_teammate_armor(HUDManager.PLAYER_PANEL, data)
end)