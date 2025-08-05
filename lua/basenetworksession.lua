-- disallow brawler deck to have camouflage bonuses for enemy attention.
-- sadly this is the best way to get max enemy attention on local player, since i cant make "15% uncover" skill sync properly to modless clients if it's value is increased
local gilza_orig_send_to_peers_synced = BaseNetworkSession.send_to_peers_synched
Hooks:OverrideFunction(BaseNetworkSession, "send_to_peers_synched", function (self, ...)
	if managers.player and managers.player:has_category_upgrade("player", "damage_resist_brawler") and managers.player:has_category_upgrade("player", "uncover_multiplier") then
		local param_1, param_2, param_3, param_4 = select(1, ...)
		if param_1 == "sync_upgrade" and param_2 == "player" and (param_3 == "camouflage_bonus" or param_3 == "camouflage_multiplier") then
			-- dont report
		else
			gilza_orig_send_to_peers_synced(self, ...)
		end
	else
		gilza_orig_send_to_peers_synced(self, ...)
	end
end)