local gilza_orig_send_to_peers_synced = BaseNetworkSession.send_to_peers_synched
Hooks:OverrideFunction(BaseNetworkSession, "send_to_peers_synched", function (self, ...)
	local param_1, param_2, param_3, param_4, param_5 = select(1, ...)
	-- disallow brawler deck to have camouflage bonuses for enemy attention.
	-- sadly this is the best way to get max enemy attention on local player, since i cant make "15% uncover" skill sync properly to modless clients if it's value is increased
	if managers.player and managers.player:has_category_upgrade("player", "damage_resist_brawler") and managers.player:has_category_upgrade("player", "uncover_multiplier") then
		if param_1 == "sync_upgrade" and param_2 == "player" and (param_3 == "camouflage_bonus" or param_3 == "camouflage_multiplier") then
			-- dont report
		else
			gilza_orig_send_to_peers_synced(self, ...)
		end
	elseif param_1 == "sync_explode_bullet" and type(param_4) == "number" and param_4 > 0 then -- reduce dmg report from explosive shotgun rounds (and a-like) to other peers. does not affect dmg dealt to cops
		param_4 = param_4 * 0.1
		gilza_orig_send_to_peers_synced(self, param_1, param_2, param_3, param_4, param_5)
	else
		gilza_orig_send_to_peers_synced(self, ...)
	end
end)