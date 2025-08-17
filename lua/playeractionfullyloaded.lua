-- update increase chance for grenade pick ups based on our adjustments @6-15
local function on_ammo_pickup(unit, pickup_chance, increase)
	local gained_throwable = false
	local chance = pickup_chance
	
	-- if currently equipped grenade has a multiplier in our list, we use it as a modifier for the 'increase' value. Allows to tweak grenade pick up chances for each nade
	if Gilza and Gilza.grenade_multipliers then
		local eqipped_nade = managers.blackmarket:equipped_grenade()
		local grenade_tweak = tweak_data.blackmarket.projectiles[eqipped_nade]
		local may_find_grenade = not grenade_tweak.base_cooldown
		
		if may_find_grenade and Gilza.grenade_multipliers[eqipped_nade] then
			increase = increase * Gilza.grenade_multipliers[eqipped_nade]
		end
	end

	if unit == managers.player:player_unit() then
		local random = math.random()
		if random < chance then
			gained_throwable = true
			
			managers.player:add_grenade_amount(1, true)
			-- on nade pickup, reset current pick up chance. most likely becuase this is a coroutine, getting multiple pickups in one tick is not handled well, allowing players to gain 2 or more pickups on the same tick
			-- without resetting the % to the starting value. normally starting value is reset on coroutine restart, but it doesnt happen in the "multiple packs in one tick" case, so we manualy reset it
			if managers.player:upgrade_value("player", "regain_throwable_from_ammo") and managers.player:upgrade_value("player", "regain_throwable_from_ammo").chance then
				chance = managers.player:upgrade_value("player", "regain_throwable_from_ammo").chance or 0
			end
		else
			chance = chance + increase
		end
	end

	return gained_throwable, chance
end

-- base game code. setting up a proper override for a coroutine would probably(?) not be easy
-- and either way, nothing should hook to this function unless an infoHUD mod allows for exact % tracking for nade pick ups, in which case - too bad
PlayerAction.FullyLoaded = {
	Priority = 1,
	Function = function (player_manager, pickup_chance, increase)
		local co = coroutine.running()
		local gained_throwable = false
		local chance = pickup_chance

		local function on_ammo_pickup_message(unit)
			gained_throwable, chance = on_ammo_pickup(unit, chance, increase)
		end

		player_manager:register_message(Message.OnAmmoPickup, co, on_ammo_pickup_message)
		player_manager:register_message(Message.OnAmmoPickup, co, on_ammo_pickup)

		while not gained_throwable do
			coroutine.yield(co)
		end

		player_manager:unregister_message(Message.OnAmmoPickup, co)
	end,
	Function_Force_Remove = function (co)
		managers.player:unregister_message(Message.OnAmmoPickup, co)
	end
}