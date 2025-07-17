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
				local ammo = weapon_unit:base():get_ammo_max_per_clip()

				if player_manager:has_category_upgrade("player", "automatic_mag_increase") and weapon_unit:base():is_category("smg", "assault_rifle", "lmg") then
					ammo = ammo - player_manager:upgrade_value("player", "automatic_mag_increase", 0)
				end
				
				local ammo_fired = ammo - weapon_unit:base():get_ammo_remaining_in_clip()

				if min_bullets < ammo_fired then
					local num_bullets = ammo_fired - min_bullets

					for i = 1, num_bullets do
						reload_multiplier = reload_multiplier + (penalty-1)
					end
				end
				reload_multiplier = math.clamp(reload_multiplier,min_reload_increase,max_reload_increase)
				
				player_manager:set_property("shock_and_awe_reload_multiplier", reload_multiplier)
				Gilza.NSI:new_lock_n_load_status(false)
			end
		end

		local function on_switch_weapon_quit()
			running = false
		end

		player_manager:register_message(Message.OnSwitchWeapon, co, on_switch_weapon_quit)
		player_manager:register_message(Message.OnPlayerReload, co, on_player_reload)

		while running and alive(weapon_unit) and weapon_unit == player_manager:equipped_weapon_unit() do
			coroutine.yield(co)
		end

		player_manager:unregister_message(Message.OnSwitchWeapon, co)
		player_manager:unregister_message(Message.OnPlayerReload, co)
		Gilza.NSI:new_lock_n_load_status(false)
	end
}