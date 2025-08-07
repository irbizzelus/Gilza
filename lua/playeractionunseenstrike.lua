-- allowed to gain effect eligibility while crit bonus is active, but added a forced cooldown between re-activations.
PlayerAction.UnseenStrike = {
	Priority = 1,
	Function = function (player_manager, min_time, max_duration, crit_chance)
		local co = coroutine.running()
		local current_time = Application:time()
		local target_time = Application:time() + min_time
		local can_activate = true

		local function on_damage_taken()
			Gilza.NSI:updated_new_unseen_strike_eligibility(false)
			-- this is practically removal of previous instances of this delayed call, because removing it outright doesnt work like i want for it to
			DelayedCalls:Add("Gilza_update_skill_info_on_unseen_strike_eligibility", 0, function(self) end)
			DelayedCalls:Add("Gilza_clear_outdated_US_eligibility", 0, function(self) end)
			
			can_activate = true
			if player_manager:has_activate_temporary_upgrade("temporary", "unseen_strike") then
				target_time = player_manager:get_activate_temporary_expire_time("temporary", "unseen_strike") + min_time
				DelayedCalls:Add("Gilza_update_skill_info_on_unseen_strike_eligibility", min_time, function(self)
					Gilza.NSI:updated_new_unseen_strike_eligibility(true)
					-- retarded failsafe in case player switches profile from a build that has unseen strike to a profile that doesnt have unseen strike,
					-- while somehow having eligibility, even tho you cant become eligible without taking damage? regardless, should never happen
					DelayedCalls:Add("Gilza_clear_outdated_US_eligibility", 24, function(self)
						Gilza.NSI:updated_new_unseen_strike_eligibility(false)
					end)
				end)
			else
				target_time = Application:time() + min_time
				DelayedCalls:Add("Gilza_update_skill_info_on_unseen_strike_eligibility", min_time, function(self)
					Gilza.NSI:updated_new_unseen_strike_eligibility(true)
					DelayedCalls:Add("Gilza_clear_outdated_US_eligibility", 24, function(self)
						Gilza.NSI:updated_new_unseen_strike_eligibility(false)
					end)
				end)
			end
		end

		player_manager:register_message(Message.OnPlayerDamage, co, on_damage_taken)

		while true do
			current_time = Application:time()

			if target_time <= current_time and can_activate then
				if not player_manager:has_activate_temporary_upgrade("temporary", "unseen_strike") then
					managers.player:activate_temporary_upgrade("temporary", "unseen_strike")
					Gilza.NSI:activated_new_unseen_strike_crits()
					DelayedCalls:Add("Gilza_update_skill_info_on_unseen_strike_eligibility", 0, function(self) end) -- clear delayedcalls
					DelayedCalls:Add("Gilza_clear_outdated_US_eligibility", 0, function(self) end)
					Gilza.NSI:updated_new_unseen_strike_eligibility(false)
				end
				can_activate = false
			end

			coroutine.yield(co)
		end

		player_manager:unregister_message(Message.OnPlayerDamage, co)
	end
}
