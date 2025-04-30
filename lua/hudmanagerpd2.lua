function HUDManager:set_player_armor(data) --removes "you are hurt, take cover" popup msg whenever the fake armor bug happens
	self:set_teammate_armor(HUDManager.PLAYER_PANEL, data)
end