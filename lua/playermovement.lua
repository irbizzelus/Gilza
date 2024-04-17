-- if we recieve inspire morale boost from ourselves, half it's bonuses
PlayerMovement._Gilza_allreadyInspiredByTeammate = false

-- making sure that we wouldnt override other player's 20% bonus by granting ourselves our 10% bonus
Hooks:PreHook(PlayerMovement, "on_morale_boost", "Gilza_PlayerMovement_inspire_1", function(self, benefactor_unit, recieved_from_self)
	if self._morale_boost and self._morale_boost.move_speed_bonus == 1.2 then
		self._Gilza_allreadyInspiredByTeammate = true
	else
		self._Gilza_allreadyInspiredByTeammate = false
	end
end)

Hooks:PostHook(PlayerMovement, "on_morale_boost", "Gilza_PlayerMovement_inspire_2", function(self, benefactor_unit, recieved_from_self)
	if not recieved_from_self or (recieved_from_self and self._Gilza_allreadyInspiredByTeammate) then
		self._morale_boost.move_speed_bonus = 1.2
		self._morale_boost.reload_speed_bonus = 1.2
	else
		self._morale_boost.move_speed_bonus = 1.1
		self._morale_boost.reload_speed_bonus = 1.1
	end
end)
-- P.S. this whole shabang has a bug, where after recieving a buff from someone else, you could theoretically keep the 20% bonus by just shouting at other players almost non-stop.
-- Even though this is not truly intentional, it's not that game breaking of a difference, plus it's way too easy to loose.
-- Fixing this would require a function override and dealing with callback id's, which wouldnt take that much effort, but lesser function overrides we have in the mod, the better.

-- allow counterstrike skill to deal damage, cloaker's aced version
Hooks:PreHook(PlayerMovement, "on_SPOOCed", "Gilza_PlayerMovement_on_SPOOCed", function(self, enemy_unit)
	if managers.player:has_category_upgrade("player", "counter_strike_spooc") and self._current_state.in_melee and self._current_state:in_melee() then
		managers.player:player_unit():movement():current_state():_do_melee_damage(managers.player:player_timer():time(), nil)
	end
end)