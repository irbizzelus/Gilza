-- new "lock n' load" skill reload adjusments
PlayerAction.ShockAndAwe = {
	Priority = 1,
	Function = function (player_manager, target_enemies, max_reload_increase, min_reload_increase, penalty, min_bullets, weapon_unit)
		local co = coroutine.running()
		local running = true

		local function are_bonuses_empty()
			local tbl1 = player_manager._num_SHOCK_AND_AWE_kills
			local tbl2 = player_manager._num_SHOCK_AND_AWE_bullets_fired
			if tbl1[1] == 0 and tbl2[1] == 0 and tbl1[2] == 0 and tbl2[2] == 0 then
				return true
			end
			return false
		end
		
		local function on_player_reload(weapon_unit)
			if alive(weapon_unit) and running then
				local index = player_manager:equipped_weapon_unit():base():selection_index()
				if player_manager._num_SHOCK_AND_AWE_kills[index] >= player_manager._SHOCK_AND_AWE_TARGET_KILLS then
					local reload_multiplier = min_reload_increase
					reload_multiplier = reload_multiplier + player_manager._num_SHOCK_AND_AWE_bullets_fired[index] * penalty -- "penalty" is a bonus reload % gained per bullet missing in clip
					reload_multiplier = math.clamp(reload_multiplier,min_reload_increase,max_reload_increase)
					player_manager:set_property("shock_and_awe_reload_multiplier", reload_multiplier)
					
					player_manager._num_SHOCK_AND_AWE_kills[index] = 0
					player_manager._num_SHOCK_AND_AWE_bullets_fired[index] = 0
					Gilza.NSI:new_lock_n_load_status(false)
					if are_bonuses_empty() then
						running = false
					end
				end
			end
		end
		
		player_manager:register_message(Message.OnPlayerReload, co, on_player_reload)
		
		while running and alive(weapon_unit) and not are_bonuses_empty() do
			coroutine.yield(co)
		end
	
		player_manager:unregister_message(Message.OnSwitchWeapon, co)
		player_manager:unregister_message(Message.OnPlayerReload, co)
		player_manager._num_SHOCK_AND_AWE_bullets_fired = {[1] = 0,[2] = 0}
		player_manager._num_SHOCK_AND_AWE_kills = {[1] = 0,[2] = 0}
		Gilza.NSI:new_lock_n_load_status(false)
	end
}