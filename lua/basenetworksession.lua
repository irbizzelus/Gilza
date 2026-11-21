local gilza_orig_send_to_peers_synced = Hooks:GetFunction(BaseNetworkSession, "send_to_peers_synched")
Hooks:OverrideFunction(BaseNetworkSession, "send_to_peers_synched", function (self, ...)
	local param_1, param_2, param_3, param_4, param_5 = select(1, ...)
	
	-- reduce dmg report from explosive shotgun rounds (and a-like) to other peers. does not affect dmg dealt to cops
	if param_1 == "sync_explode_bullet" and type(param_4) == "number" and param_4 > 0 then
		param_4 = param_4 * 0.1
	end
	
	-- disallow brawler deck to have camouflage bonuses for enemy attention.
	-- sadly this is the best way to get max enemy attention on local player, since i cant make "15% uncover" skill sync properly to modless clients if it's value is increased
	if managers.player and managers.player:has_category_upgrade("player", "damage_resist_brawler") and managers.player:has_category_upgrade("player", "uncover_multiplier") then
		if param_1 == "sync_upgrade" and param_2 == "player" and (param_3 == "camouflage_bonus" or param_3 == "camouflage_multiplier") then
			-- dont report
		else
			gilza_orig_send_to_peers_synced(self, ...)
		end
	else
		gilza_orig_send_to_peers_synced(self, ...)
	end
end)

-- peer sync
Hooks:Add("BaseNetworkSessionOnLoadComplete", "Gilza_send_hello", function(local_peer, id)
	LuaNetworking:SendToPeers("Gilza_peer_sync", "Hello!")
end)

Hooks:Add("BaseNetworkSessionOnPeerEnteredLobby", "Gilza_send_hello_to_new_joiner", function(peer, peer_id)
	LuaNetworking:SendToPeer(peer_id, "Gilza_peer_sync", "Hello!")
end)

-- proccessing
local host_notif_only_once = false
Hooks:Add("NetworkReceivedData", "Gilza_NetworkReceivedData", function(sender, messageType, data)
	if messageType == "Gilza_peer_sync" and string.sub(data, 1, 6) == "Hello!" then
		Gilza.peers_with_mod[sender] = true
		if sender == 1 and not host_notif_only_once and Network:is_client() then
			host_notif_only_once = true
			DelayedCalls:Add("Gilza_notify_self_of_host_running_Gilza_delayed", 2, function()
				if managers and managers.chat then
					local loc_msg = managers.network:session():peer(sender):name()..managers.localization:text("Gilza_nofify_host_has_gilza")
					managers.chat:_receive_message(1, "[Gilza]", loc_msg, Color(0,0.8,0.76))
				end
			end)
		end
	end
	if Gilza.peers_with_mod[sender] and messageType == "Gilza_peer_sync" and string.sub(data, 1, 21) == "Equipped_custom_deck_" then
		local deck_str = string.sub(data, 22, -1)
		local allowed_decks = {
			brawler = Gilza.custom_specialization_indexes.brawler,
			junkie = Gilza.custom_specialization_indexes.junkie,
			guardian = Gilza.custom_specialization_indexes.guardian
		}
		if allowed_decks[deck_str] and not (Gilza.peers_with_Gilza_perks[sender] == allowed_decks[deck_str]) then
			Gilza.peers_with_Gilza_perks[sender] = allowed_decks[deck_str]
			if managers and managers.chat then
				local loc_msg = managers.network:session():peer(sender):name()..managers.localization:text("Gilza_nofify_peer_equipped_gilza_deck_"..tostring(deck_str))
				managers.chat:_receive_message(1, "[Gilza]", loc_msg, Color(0,0.8,0.76))
			end
		end
	end
end)

-- clear data on peer leave
Hooks:Add("BaseNetworkSessionOnPeerRemoved", "Gilza_BaseNetworkSessionOnPeerRemoved", function(peer, peer_id, reason)
	if peer_id == 1 then
		host_notif_only_once = false
	end
	Gilza.peers_with_mod[peer_id] = false
	Gilza.peers_with_Gilza_perks[peer_id] = false
end)