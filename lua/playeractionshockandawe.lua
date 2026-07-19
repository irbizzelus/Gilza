-- new "lock n' load" skill reload adjusments
PlayerAction.ShockAndAwe = {
	Priority = 1,
	Function = function (player_manager, target_enemies, max_reload_increase, min_reload_increase, penalty, min_bullets, weapon_unit)
		local co = coroutine.running()
		local running = true

		local function on_player_reload(weapon_unit)
			if alive(weapon_unit) and running then
				running = false
				local reload_multiplier = min_reload_increase
				reload_multiplier = reload_multiplier + player_manager._num_SHOCK_AND_AWE_bullets_fired * penalty -- "penalty" is a bonus reload % gained per bullet missing in clip
				reload_multiplier = math.clamp(reload_multiplier,min_reload_increase,max_reload_increase)
				player_manager:set_property("shock_and_awe_reload_multiplier", reload_multiplier)
				
				player_manager._num_SHOCK_AND_AWE_kills = 0
				player_manager._num_SHOCK_AND_AWE_bullets_fired = 0
				Gilza.NSI:new_lock_n_load_status(false)
			end
		end

		local function on_switch_weapon_quit()
			player_manager._num_SHOCK_AND_AWE_kills = 0
			player_manager._num_SHOCK_AND_AWE_bullets_fired = 0
			running = false
		end
		
		player_manager:register_message(Message.OnSwitchWeapon, co, on_switch_weapon_quit)
		player_manager:register_message(Message.OnPlayerReload, co, on_player_reload)

		while running and alive(weapon_unit) and weapon_unit == player_manager:equipped_weapon_unit() do
			coroutine.yield(co)
		end
	
		player_manager:unregister_message(Message.OnSwitchWeapon, co)
		player_manager:unregister_message(Message.OnPlayerReload, co)
		player_manager._num_SHOCK_AND_AWE_bullets_fired = 0
		player_manager._num_SHOCK_AND_AWE_kills = 0
		Gilza.NSI:new_lock_n_load_status(false)
	end
}