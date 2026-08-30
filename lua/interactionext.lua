-- adjust interaction timer(s) if we have speed junkie or guardian perk
Hooks:OverrideFunction(BaseInteractionExt, "_get_timer", function (self)
	local modified_timer = self:_get_modified_timer()

	if modified_timer then
		return modified_timer
	end

	local multiplier = 1

	if self.tweak_data ~= "corpse_alarm_pager" then
		multiplier = multiplier * managers.player:crew_ability_upgrade_value("crew_interact", 1)
	end
	
	if self.tweak_data ~= "corpse_alarm_pager" and self.tweak_data ~= "revive" then
		-- junkie perk
		if managers.player:has_category_upgrade("player", "speed_junkie_meter_boost_agility") then
			local counter = managers.player._Gilza_junkie_counter or 0
			local skill = managers.player:upgrade_value("player", "speed_junkie_meter_boost_agility")
			if skill and type(skill) ~= "number" then
				local mul = 1 - (skill.interaction - 1) * (counter / 100)
				multiplier = multiplier * mul
			end	
		end
		-- guardian perk
		if managers.player:has_category_upgrade("player", "guardian_interaction_speed_penalty") then
			multiplier = multiplier * managers.player:upgrade_value("player", "guardian_interaction_speed_penalty", 1)
		end
	end

	if self._tweak_data.upgrade_timer_multiplier then
		multiplier = multiplier * managers.player:upgrade_value(self._tweak_data.upgrade_timer_multiplier.category, self._tweak_data.upgrade_timer_multiplier.upgrade, 1)
	end

	if self._tweak_data.upgrade_timer_multipliers then
		for _, upgrade_timer_multiplier in pairs(self._tweak_data.upgrade_timer_multipliers) do
			multiplier = multiplier * managers.player:upgrade_value(upgrade_timer_multiplier.category, upgrade_timer_multiplier.upgrade, 1)
		end
	end

	if managers.player:has_category_upgrade("player", "level_interaction_timer_multiplier") then
		local data = managers.player:upgrade_value("player", "level_interaction_timer_multiplier") or {}
		local player_level = managers.experience:current_level() or 0
		multiplier = multiplier * (1 - (data[1] or 0) * math.ceil(player_level / (data[2] or 1)))
	end

	return self:_timer_value() * multiplier * managers.player:toolset_value()
end)

-- new tower defense aced
Hooks:PostHook(SentryGunInteractionExt, "_on_death_event", "Gilza_SentryGunInteractionExt_on_death_event_post", function (self)
	if self:is_owner() and managers.player:has_category_upgrade("sentry_gun", "can_revive") then
		self:set_active(true)
		self:set_tweak_data("sentry_gun_revive")
		
		if not managers.player.owned_broken_sentries then
			managers.player.owned_broken_sentries = {}
		end
		managers.player.owned_broken_sentries[self._unit:id()] = true
	end
end)

-- player revive skills
Hooks:PostHook(ReviveInteractionExt, "interact", "Gilza_ReviveInteractionExt_interact_post", function (self,reviving_unit)
	-- new combat medic aced
	if reviving_unit and reviving_unit == managers.player:player_unit() and managers.player:has_category_upgrade("player", "revive_action_self_heal") then
		local stoic = managers.player:has_category_upgrade("player", "armor_to_health_conversion")
		local guardian = managers.player:has_category_upgrade("player", "guardian_armor_remover")
		local player_dmg = managers.player:player_unit():character_damage()
		if stoic or guardian then -- health
			local heal = managers.player:upgrade_value("player", "revive_action_self_heal", 0) * player_dmg:_max_health()
			player_dmg:restore_health(heal, true)
		else -- armor
			local armor = managers.player:upgrade_value("player", "revive_action_self_heal", 0) * player_dmg:_max_armor()
			player_dmg:restore_armor(armor)
		end
	end
	
	-- new leech heal bonus
	if reviving_unit and reviving_unit == managers.player:player_unit() and managers.player:has_category_upgrade("temporary", "copr_ability") then
		local secs = managers.player:upgrade_value("player", "copr_regain_cooldown_on_revives", 0)
		if secs > 0 then
			managers.player:speed_up_grenade_cooldown(secs)
		end
		if managers.player:has_activate_temporary_upgrade("temporary", "copr_ability") then
			managers.player._Gilza_leech_did_revive_during_effect = true
		end
		
		if managers.player:has_category_upgrade("player", "copr_heal_on_teammate_revive")  then
			-- heal self on teammate revive
			local heal_level = managers.player:upgrade_level_nil("player", "copr_teammate_heal")
			if not managers.player:player_unit():character_damage()._gilza_leech_dire_state then
				managers.player:player_unit():character_damage():on_copr_heal_received(managers.player:player_unit(), heal_level)
			end
			-- heal teammate on revive. if we send heal immediately on revive, husk doesnt heal because they get said info while they are still down, thus missing out on heals
			if self._unit:base().is_husk_player then
				local limit = 300 -- 3 secs of ping delay
				local function try_to_heal()
					local prevented_states = {
						"bleed_out",
						"incapacitated",
						"fatal",
					}
					if self._unit and alive(self._unit) and self._unit:movement() and self._unit:movement():current_state_name() and not prevented_states[self._unit:movement():current_state_name()] then
						local peer = managers.network:session():peer_by_unit(self._unit)
						if peer then
							peer:send("copr_teammate_heal", managers.player:player_unit(), heal_level)
							peer:send("copr_teammate_heal", managers.player:player_unit(), heal_level) -- 2 sends for 20% health at max
							limit = 0
						end
					else
						if limit > 0 then
							limit = limit - 1
							DelayedCalls:Add("Gilza_leech_heal_teammate_after_revival_ping_compensation", 0.1, function()
								try_to_heal()
							end)
						end
					end
				end
				-- first we delay peer heal by 1 second, and then wait until they report to us that they arent dead, afterwards send heal
				DelayedCalls:Add("Gilza_leech_heal_teammate_after_revival_delayed", 1, function()
					try_to_heal()
				end)
			end
		end
	end
end)

-- leech doc bag/fak heal block in dire state
local gilza_orig_doc_bag_interaction_blocked = Hooks:GetFunction(DoctorBagBaseInteractionExt, "_interact_blocked")
Hooks:OverrideFunction(DoctorBagBaseInteractionExt, "_interact_blocked", function (self, player)
	if player:character_damage()._gilza_leech_dire_state then
		return true, false, "hint_health_berserking"
	else
		return gilza_orig_doc_bag_interaction_blocked(self, player)
	end
end)