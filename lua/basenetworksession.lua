if not Gilza then
	dofile("mods/Gilza/lua/1_GilzaBase.lua")
end

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
Hooks:Add("NetworkReceivedData", "Gilza_NetworkReceivedData", function(sender, messageType, data)
	if messageType == "Gilza_peer_sync" and string.sub(data, 1, 6) == "Hello!" then
		Gilza.peers_with_mod[sender].has_Gilza = true
		if sender == 1 and Network:is_client() then
			DelayedCalls:Add("Gilza_notify_self_of_host_running_Gilza__delayed", 2, function()
				if managers and managers.chat and not Gilza.peers_with_mod[sender].seen_host_notif then
					local loc_msg = managers.network:session():peer(sender):name()..managers.localization:text("Gilza_nofify_host_has_gilza")
					managers.chat:_receive_message(1, "[Gilza]", loc_msg, Color(0,0.8,0.76))
					Gilza.peers_with_mod[sender].seen_host_notif = true
				end
			end)
		end
	end
	if Gilza.peers_with_mod[sender].has_Gilza and messageType == "Gilza_peer_sync" and string.sub(data, 1, 19) == "Equipped_perk_deck_" then
		local deck_str = string.sub(data, 20, -1)
		local allowed_decks = {
			vanilla = true,
			brawler = true,
			junkie = true,
			guardian = true
		}
		if allowed_decks[deck_str] and not (Gilza.peers_with_mod[sender].used_deck == deck_str) then
			
			-- anti notification spam
			local function notify_self(peer_id,deck)
				Gilza.peers_with_mod[peer_id].deck_sync_timer = Application:time() + 5
				if managers and managers.chat and managers.network and managers.network:session() and managers.network:session():peer(peer_id) and not (Gilza.peers_with_mod[peer_id].used_deck == deck) then
					Gilza.peers_with_mod[peer_id].used_deck = deck
					local loc_msg = managers.network:session():peer(peer_id):name()..managers.localization:text("Gilza_nofify_peer_equipped_gilza_deck_"..tostring(deck))
					managers.chat:_receive_message(1, "[Gilza]", loc_msg, Color(0,0.8,0.76))
				end
			end
			
			-- if someone swaps to a new deck but they recently already said they did so, only notify self 5 seconds after previous self-notif
			if Application:time() > Gilza.peers_with_mod[sender].deck_sync_timer then
				notify_self(sender,deck_str)
			else
				-- if currently on CD, after CD ends try to self-notif again. if it's a new deck we print a new notif, otherwise do fuck all
				DelayedCalls:Add("Gilza_delayed_notif_of_deck_swap_for_peer_"..tostring(sender), Gilza.peers_with_mod[sender].deck_sync_timer - Application:time(), function(self)
					notify_self(sender,deck_str)
				end)
			end
		end
	end
end)

-- clear data on peer leave
Hooks:Add("BaseNetworkSessionOnPeerRemoved", "Gilza_BaseNetworkSessionOnPeerRemoved", function(peer, peer_id, reason)
	Gilza.peers_with_mod[peer_id] = {
		has_Gilza = false,
		used_deck = "vanilla",
		deck_sync_timer = 0
	}
end)

-- clear data on lobby disconnect
Hooks:PreHook(BaseNetworkSession, "destroy", "Gilza_BaseNetworkSession_pre_destroy", function(self)
	if Gilza and Gilza.peers_with_mod then
		Gilza.peers_with_mod = {}
		for i=1,4 do
			Gilza.peers_with_mod[i] = {
				has_Gilza = false,
				used_deck = "vanilla",
				deck_sync_timer = 0
			}
		end
	end
end)

-- keep the peer data between loading screens
Hooks:PreHook(BaseNetworkSession, "load", "Gilza_BaseNetworkSession_post_load", function(self, data)
	if Gilza and data.Gilza_peers_table then
		Gilza.peers_with_mod = deep_clone(data.Gilza_peers_table)
	end
end)
Hooks:PostHook(BaseNetworkSession, "save", "Gilza_BaseNetworkSession_post_save", function(self, data)
	if Gilza and Gilza.peers_with_mod then
		data.Gilza_peers_table = deep_clone(Gilza.peers_with_mod)
	end
end)