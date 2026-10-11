-- rewrote parts of this func to have identical mechanics to trigger happy, mostly for infinite re-activation on hit
function PlayerAction.ExpertHandling.Function(player_manager, accuracy_bonus, max_stacks, max_time)
	max_time = max_time - Application:time() -- whenever entering this coroutine the "max_time" is setup in the player manager because reasons
	local property_name = "desperado"
	local co = coroutine.running()
	local current_time = Application:time()
	local end_time = Application:time() + max_time
	local current_stacks = 1

	local function on_hit(unit, attack_data)
		local attacker_unit = attack_data.attacker_unit
		local variant = attack_data.variant

		if attacker_unit == player_manager:player_unit() and variant == "bullet" then
			end_time = current_time + max_time
			Gilza.NSI:activated_trigger_happy(end_time)

			if current_stacks < max_stacks then
				current_stacks = current_stacks + 1

				player_manager:mul_to_property(property_name, accuracy_bonus)
			end
		end
	end
	
	Gilza.NSI:activated_trigger_happy(end_time)
	player_manager:mul_to_property(property_name, accuracy_bonus)
	player_manager:register_message(Message.OnEnemyShot, co, on_hit)

	while current_time < end_time do
		current_time = Application:time()

		if not player_manager:is_current_weapon_of_category("pistol") then
			break
		end

		coroutine.yield(co)
	end
	
	Gilza.NSI:stopped_trigger_happy()
	player_manager:remove_property(property_name)
	player_manager:unregister_message(Message.OnEnemyShot, co)
end
