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
PlayerMovement._Gilza_WasCounterAttacking = false -- if we counterattacked, we reset chainsaw damage effect in a posthook for on_SPOOCed func
Hooks:PreHook(PlayerMovement, "on_SPOOCed", "Gilza_PlayerMovement_on_SPOOCed", function(self, enemy_unit)
	if managers.player:has_category_upgrade("player", "counter_strike_spooc") and self._current_state.in_melee and self._current_state:in_melee() then
		self._Gilza_WasCounterAttacking = true
		local t = managers.player:player_timer():time()
		local melee_entry = melee_entry or managers.blackmarket:equipped_melee_weapon()
		local anim_attack_vars = tweak_data.blackmarket.melee_weapons[melee_entry].anim_attack_vars
		local melee_attack_var = anim_attack_vars and math.random(#anim_attack_vars)
		local player_state = self._unit:movement():current_state()
		local charge_lerp_value = player_state:_get_melee_charge_lerp_value(managers.player:player_timer():time()) or 0
		local from = player_state._unit:movement():m_head_pos()
		local attacker_pos = enemy_unit:position()
		local toRot = Rotation:look_at(from, attacker_pos, Vector3(0, 0, 1))
		local to = Rotation(toRot:x(), toRot:y(), toRot:z())
		local col_ray = player_state._unit:raycast("ray", from, to, "slot_mask", player_state._slotmask_bullet_impact_targets, "sphere_cast_radius", 20, "ray_type", "body melee")
		
		if col_ray and alive(col_ray.unit) then
			local damage, damage_effect = managers.blackmarket:equipped_melee_weapon_damage_info(charge_lerp_value)
			if tweak_data.blackmarket.melee_weapons[melee_entry].stats.tick_damage then
				damage = tweak_data.blackmarket.melee_weapons[melee_entry].stats.tick_damage
				charge_lerp_value = 0
			end
			
			local hit_unit = enemy_unit

			if hit_unit:character_damage() then

				local hit_sfx = "hit_body"
				if hit_unit:character_damage() and hit_unit:character_damage().melee_hit_sfx then
					hit_sfx = hit_unit:character_damage():melee_hit_sfx()
				end

				player_state:_play_melee_sound(melee_entry, hit_sfx, melee_attack_var)

				if not hit_unit:character_damage()._no_blood then
					managers.game_play_central:play_impact_flesh({
						col_ray = col_ray
					})
					managers.game_play_central:play_impact_sound_and_effects({
						no_decal = true,
						no_sound = true,
						col_ray = col_ray
					})
				end
			end

			managers.game_play_central:physics_push(col_ray)

			local character_unit, shield_knock = nil
			local can_shield_knock = managers.player:has_category_upgrade("player", "shield_knock")

			if can_shield_knock and hit_unit:in_slot(8) and alive(hit_unit:parent()) and not hit_unit:parent():character_damage():is_immune_to_shield_knockback() then
				shield_knock = true
				character_unit = hit_unit:parent()
			end

			character_unit = character_unit or hit_unit

			if character_unit:character_damage() and character_unit:character_damage().damage_melee then
				local dmg_multiplier = 1
				local target_dead = character_unit:character_damage().dead and not character_unit:character_damage():dead()
				local target_hostile = managers.enemy:is_enemy(character_unit) and not tweak_data.character[character_unit:base()._tweak_table].is_escort and character_unit:brain():is_hostile()
				local life_leach_available = managers.player:has_category_upgrade("temporary", "melee_life_leech") and not managers.player:has_activate_temporary_upgrade("temporary", "melee_life_leech")
				
				-- bloodthirst base
				dmg_multiplier = dmg_multiplier * managers.player:get_melee_dmg_multiplier()
				
				-- sociopath/infil damage
				if managers.player:has_category_upgrade("melee", "stacking_hit_damage_multiplier") then
					player_state._state_data.stacking_dmg_mul = player_state._state_data.stacking_dmg_mul or {}
					player_state._state_data.stacking_dmg_mul.melee = player_state._state_data.stacking_dmg_mul.melee or {
						nil,
						0
					}
					local stack = player_state._state_data.stacking_dmg_mul.melee

					if stack[1] and t < stack[1] then
						dmg_multiplier = dmg_multiplier * (1 + managers.player:upgrade_value("melee", "stacking_hit_damage_multiplier", 0) * stack[2])
					else
						stack[2] = 0
					end
				end
				
				if target_dead and target_hostile and life_leach_available then
					managers.player:activate_temporary_upgrade("temporary", "melee_life_leech")
					player_state._unit:character_damage():restore_health(managers.player:temporary_upgrade_value("temporary", "melee_life_leech", 1))
				end

				local special_weapon = tweak_data.blackmarket.melee_weapons[melee_entry].special_weapon
				local action_data = {
					variant = "melee"
				}

				if special_weapon == "taser" then
					action_data.variant = "taser_tased"
				end

				if _G.IS_VR and melee_entry == "weapon" and not bayonet_melee then
					dmg_multiplier = 0.5
				end

				action_data.damage = shield_knock and 0 or damage * dmg_multiplier * 2
				action_data.damage_effect = damage_effect
				action_data.attacker_unit = player_state._unit
				action_data.col_ray = col_ray

				if shield_knock then
					action_data.shield_knock = can_shield_knock
				end

				action_data.name_id = melee_entry
				action_data.charge_lerp_value = charge_lerp_value

				local defense_data = character_unit:character_damage():damage_melee(action_data)

				player_state:_check_melee_special_damage(col_ray, character_unit, defense_data, melee_entry)
				player_state:_perform_sync_melee_damage(hit_unit, col_ray, action_data.damage)
				
				-- sociopath/infil timer
				if managers.player:has_category_upgrade("melee", "stacking_hit_damage_multiplier") then
					player_state._state_data.stacking_dmg_mul = player_state._state_data.stacking_dmg_mul or {}
					player_state._state_data.stacking_dmg_mul.melee = player_state._state_data.stacking_dmg_mul.melee or {
						nil,
						0
					}
					local stack = player_state._state_data.stacking_dmg_mul.melee

					if character_unit:character_damage().dead and not character_unit:character_damage():dead() then
						stack[1] = t + managers.player:upgrade_value("melee", "stacking_hit_expire_t", 1)
						stack[2] = math.min(stack[2] + 1, tweak_data.upgrades.max_melee_weapon_dmg_mul_stacks or 5)
					else
						stack[1] = nil
						stack[2] = 0
					end
				end
				
				return defense_data
			end
		end

		return col_ray
	else
		self._Gilza_WasCounterAttacking = false
	end
end)

-- interupt melee hold after a counterattack, to stop chainsaw damage
-- this also causes a small bug where melee is almost instantly unequiped, but i deem it a feature and not a bug.
Hooks:PostHook(PlayerMovement, "on_SPOOCed", "Gilza_PlayerMovement_on_SPOOCed_2", function(self, enemy_unit)
	if self._Gilza_WasCounterAttacking then
		self._unit:movement():current_state():_interupt_action_melee(managers.player:player_timer():time())
	end
end)