Hooks:PostHook(CopMovement, "action_request", "Gilza_CopMovement_action_request_post" , function(self,action_desc)
	
	-- still have 0 clue what this prevents, yet im using it :)
	if self._unit:base().mic_is_being_moved then
		return
	end
	
	if managers.enemy:is_civilian(self._unit) then
		return
	end
	
	if self._unit:base():char_tweak().access == "teamAI4" then
		return
	end
	
	-- clear hitman's bounty target if it's been alive for 40 secs after it was assigned
	if managers.player:has_category_upgrade("temporary", "player_bounty_hunter") and managers.player._gilza_hitman_has_active_bounty then
		if self._unit == managers.player._gilza_hitman_bounty_target then
			local is_alive = alive(self._unit) and not self._unit:character_damage():dead()
			local is_enemy = is_alive and self._unit:brain():is_hostile()
			if not is_alive or not_enemy then
				managers.player._gilza_hitman_bounty_cooldown_end = Application:time() + 40
				managers.player._gilza_hitman_has_active_bounty = false
				self._unit:contour():remove("generic_interactable_selected" , false)
			end
		end
	end
	
	-- enemy hostage tracker for murderhobo stockholm skill
	if managers.player:has_category_upgrade("player", "menace_panic_spread") then
		if action_desc.variant == "tied" or action_desc.variant == "tied_all_in_one" then
			if not Gilza.intimidated_enemies[self._unit:id()] then
				Gilza.intimidated_enemies[self._unit:id()] = true
			end
		else
			if Gilza.intimidated_enemies[self._unit:id()] then
				Gilza.intimidated_enemies[self._unit:id()] = nil
			end
		end
	end
	
	if not managers.player:has_category_upgrade("shotgun", "panic_when_kill") then
		return
	end
	-- tracker for the new shotgun panic skill
	-- basically any time cop enters the 'im shiting my pants right now' animation state we add him to our list, to give player bonuses if that cop is killed by the player
	-- enemy is cleared from the list after 4.25 seconds (animation duration + ~1 extra second) and the list is constantly cleared to avoid duplications and other issues
	
	-- loops itself every 5 seconds to clear the list off of dead units/cops and cops who no longer are panicking
	function Gilza.panickedEnemiesCleanUp()
		for id,npc in pairs(Gilza.panicking_enemies) do
			if Gilza.panicking_enemies[id] == "removed" or not Gilza.panicking_enemies[id] or not alive(Gilza.panicking_enemies[id]._unit) or not npc:can_request_actions() then
				Gilza.panicking_enemies[id] = nil
			end
		end
		DelayedCalls:Add("Gilza_endless_cleanup_loop", 5, function()
			Gilza.panickedEnemiesCleanUp()
		end)
	end
	
	if action_desc.variant == "suppressed_fumble_still" then
		-- runs only once
		if not Gilza.panicking_enemies then
			Gilza.panicking_enemies = {}
			Gilza.panickedEnemiesCleanUp()
		end
		-- 'removed' is used for cops that have stopped panicking, but they are not removed from the list yet
		-- why not remove them straight away and rely on the cleanup func? 1 - it crashed me with access violation for some reason lmao
		-- 2 - they might start panicking again; 3 - clearing function allready has all the sanity checks for units and their states,
		-- might as well let it do all the work and not overcomplicate other parts of the code
		if not Gilza.panicking_enemies[self._unit:id()] or Gilza.panicking_enemies[self._unit:id()] == "removed" then
			Gilza.panicking_enemies[self._unit:id()] = self
		end
		DelayedCalls:Add("Gilza_remove_panicking_unit_"..tostring(self._unit:id()), 4.25, function()
			if self and alive(self._unit) then
				Gilza.panicking_enemies[self._unit:id()] = "removed"
			end
		end)
	end
end)