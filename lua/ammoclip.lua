-- this file is here for the gambler rework, and brawler's arrow pick up nerf

local CABLE_TIE_GET_CHANCE = 0.2
local CABLE_TIE_GET_AMOUNT = 1

Hooks:OverrideFunction(AmmoClip, "_pickup", function(self, unit)
	if self._picked_up then
		return
	end

	local player_manager = managers.player
	local inventory = unit:inventory()

	if not unit:character_damage():dead() and inventory then
		local picked_up = false

		if self._projectile_id then
			if managers.blackmarket:equipped_projectile() == self._projectile_id and not player_manager:got_max_grenades() then
				player_manager:add_grenade_amount(self._ammo_count or 1)

				picked_up = true
			end
		else
			local available_selections = {}

			for i, weapon in pairs(inventory:available_selections()) do
				if inventory:is_equipped(i) then
					table.insert(available_selections, 1, weapon)
				else
					table.insert(available_selections, weapon)
				end
			end

			local success, add_amount = nil

			for _, weapon in ipairs(available_selections) do
				if not self._weapon_category or self._weapon_category == weapon.unit:base():weapon_tweak_data().categories[1] then
					
					-- if we pickup bow/crossbow bolt from enviroment with brawler deck, we only have a chance to get it back. chance is equal to total ammo multiplier
					if self._pickup_event and (self._pickup_event == "wp_arrow_pick_up" or self._pickup_event == "wp_hunterarrow_pick_up") then
						if managers.player:has_category_upgrade("player", "extra_ammo_cut") then
							local rng_win = math.random() <= managers.player:upgrade_value("player", "extra_ammo_cut", 0)
							if not rng_win then
								-- no bueno
								picked_up = true
								break
							end
						end
					end
					
					success, add_amount = weapon.unit:base():add_ammo(1, self._ammo_count)
					picked_up = success or picked_up

					if self._ammo_count then
						self._ammo_count = math.max(math.floor(self._ammo_count - add_amount), 0)
					end

					if picked_up and tweak_data.achievement.pickup_sticks and self._weapon_category == tweak_data.achievement.pickup_sticks.weapon_category then
						managers.achievment:award_progress(tweak_data.achievement.pickup_sticks.stat)
					end
				end
			end
		end

		if picked_up then
			self._picked_up = true
			local rand = math.random()

			if rand <= CABLE_TIE_GET_CHANCE and self._ammo_box then
				managers.player:add_cable_ties(CABLE_TIE_GET_AMOUNT)
			end

			if not self._projectile_id and not self._weapon_category then
				local restored_health = nil

				if not unit:character_damage():is_downed() and player_manager:has_category_upgrade("temporary", "loose_ammo_restore_health") and not player_manager:has_activate_temporary_upgrade("temporary", "loose_ammo_restore_health") then
					
					local heal_gamble = {effect = "nothing", jackpot = false}
					if player_manager:has_category_upgrade("player", "loose_ammo_restore_health_chances") then
						local skill = player_manager:upgrade_value("player", "loose_ammo_restore_health_chances")
						if skill and type(skill) ~= "number" then
							local gamble_initial = math.random()
							if gamble_initial <= skill.addition_chance then
								heal_gamble.effect = "add"
								if math.random() <= skill.addition_jackpot_chance then
									heal_gamble.jackpot = true
								end
							else
								if (1 - gamble_initial) <= skill.removal_chance then
									heal_gamble.effect = "remove"
									if math.random() <= skill.removal_jackpot_chance then
										heal_gamble.jackpot = true
									end
								end
							end
						end	
					end
					
					player_manager:activate_temporary_upgrade("temporary", "loose_ammo_restore_health")
					player_manager:Gilza_new_gambler_triggered(heal_gamble)
					
					if heal_gamble.effect ~= "nothing" then
						
						local values = player_manager:temporary_upgrade_value("temporary", "loose_ammo_restore_health", 0)

						if values ~= 0 then
							local restore_value = math.random(values[1], values[2])
							
							if heal_gamble.effect == "remove" then
								restore_value = restore_value * -2
							end
							
							if heal_gamble.jackpot then
								restore_value = restore_value * 3
							end
							
							restore_value = restore_value * (tweak_data.upgrades.loose_ammo_restore_health_values.multiplier or 0.1)
							
							local damage_ext = unit:character_damage()

							if not damage_ext:need_revive() and not damage_ext:dead() and not damage_ext:is_berserker() then
								if heal_gamble.effect == "remove" and damage_ext:get_real_health() + restore_value <= 0 then
									-- prevent player health from going bellow 0 from this substraction
									damage_ext:restore_health((damage_ext:get_real_health() - 0.1) * -1, true)
								else
									damage_ext:restore_health(restore_value, true)
								end
								unit:sound():play("pickup_ammo_health_boost", nil, true)
							end
							
							if player_manager:has_category_upgrade("player", "loose_ammo_add_dodge_amount") then
								local dodge_skill = player_manager:upgrade_value("player", "loose_ammo_add_dodge_amount")
								if dodge_skill and type(dodge_skill) ~= "number" then
									if heal_gamble.effect == "add" then
										if heal_gamble.jackpot then
											player_manager:Gilza_add_gambler_new_dodge(dodge_skill.addition_jackpot)
										else
											player_manager:Gilza_add_gambler_new_dodge(math.random(dodge_skill.addition_min * 100,dodge_skill.addition_max * 100) / 100)
										end
									elseif heal_gamble.effect == "remove" then
										if heal_gamble.jackpot then
											player_manager:Gilza_add_gambler_new_dodge(dodge_skill.removal_jackpot)
										else
											player_manager:Gilza_add_gambler_new_dodge(math.random(dodge_skill.removal_min * 100,dodge_skill.removal_max * 100) / 100)
										end
									end
								end	
							end
						end
					end
					
					-- other players have an intended cap to how much health they can get from this effect. if they would recieve more health than 15, they get no healing at all
					-- since we cant give other players more health, we will just always give them the max possible amount instead of 12-15 that we would get otherwise
					-- this is both a buff and compensation for longer cooldown of 4 secs
					if player_manager:has_category_upgrade("player", "loose_ammo_restore_health_give_team") then
						managers.network:session():send_to_peers_synched("sync_unit_event_id_16", self._unit, "pickup", 15)
					end

					if player_manager:has_category_upgrade("temporary", "loose_ammo_give_team") and not player_manager:has_activate_temporary_upgrade("temporary", "loose_ammo_give_team") then
						player_manager:activate_temporary_upgrade("temporary", "loose_ammo_give_team")
						managers.network:session():send_to_peers_synched("sync_unit_event_id_16", self._unit, "pickup", AmmoClip.EVENT_IDS.bonnie_share_ammo)
					end
				
				end
			elseif self._projectile_id then
				player_manager:register_grenade(managers.network:session():local_peer():id())
				managers.network:session():send_to_peers_synched("sync_unit_event_id_16", self._unit, "pickup", AmmoClip.EVENT_IDS.register_grenade)
			end

			if Network:is_client() then
				managers.network:session():send_to_host("sync_pickup", self._unit)
			end

			unit:sound():play(self._pickup_event or "pickup_ammo", nil, true)
			self:consume()

			if self._ammo_box then
				player_manager:send_message(Message.OnAmmoPickup, nil, unit)
			end

			return true
		end
	end

	return false
	
end)