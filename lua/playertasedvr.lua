-- new berserk dmg increase @line 60
function PlayerTasedVR:_check_fire_per_weapon(t, pressed, held, released, weap_base, akimbo)
	local action_wanted = held
	action_wanted = action_wanted or self:is_shooting_count()
	action_wanted = action_wanted or self:_is_charging_weapon()

	if not action_wanted then
		return false
	end

	local new_action = false
	local fire_mode = weap_base:fire_mode()

	if weap_base:out_of_ammo() then
		if pressed then
			weap_base:dryfire()
		end
	elseif weap_base.clip_empty and weap_base:clip_empty() then
		if fire_mode == "single" and pressed then
			weap_base:dryfire()
		end
	elseif self._num_shocks > 1 and weap_base.can_refire_while_tased and not weap_base:can_refire_while_tased() then
		-- Nothing
	elseif self._running then
		self:_interupt_action_running(t)
	else
		if not self._shooting and weap_base:start_shooting_allowed() then
			local start = fire_mode == "single" and pressed
			start = start or fire_mode == "auto" and held
			start = start or fire_mode == "burst" and pressed
			start = start or fire_mode == "volley" and pressed

			if start then
				weap_base:start_shooting()

				if not self._state_data.in_steelsight or not weap_base:tweak_data_anim_play("fire_steelsight", weap_base:fire_rate_multiplier()) then
					weap_base:tweak_data_anim_play("fire", weap_base:fire_rate_multiplier())
				end

				self._shooting_weapons = self._shooting_weapons or {}
				self._shooting_weapons[akimbo and 2 or 1] = weap_base
				self._shooting = true
			end
		end

		if not self._shooting_weapons or not self._shooting_weapons[akimbo and 2 or 1] then
			return
		end

		local suppression_ratio = self._unit:character_damage():effective_suppression_ratio()
		local spread_mul = math.lerp(1, tweak_data.player.suppression.spread_mul, suppression_ratio)
		local autohit_mul = math.lerp(1, tweak_data.player.suppression.autohit_chance_mul, suppression_ratio)
		local suppression_mul = managers.blackmarket:threat_multiplier()
		local dmg_mul = managers.player:temporary_upgrade_value("temporary", "dmg_multiplier_outnumbered", 1)

		if managers.player:has_category_upgrade("player", "overkill_all_weapons") or weap_base:is_category("shotgun", "saw") then
			dmg_mul = dmg_mul * managers.player:temporary_upgrade_value("temporary", "overkill_damage_multiplier", 1)
		end
		
		if managers.player:has_category_upgrade("temporary", "new_berserk_weapon_damage_multiplier") then
			dmg_mul = dmg_mul * managers.player:temporary_upgrade_value("temporary", "new_berserk_weapon_damage_multiplier", 1)
		end

		local health_ratio = self._ext_damage:health_ratio()
		local primary_category = weap_base:weapon_tweak_data().categories[1]
		local damage_health_ratio = managers.player:get_damage_health_ratio(health_ratio, primary_category)

		if damage_health_ratio > 0 then
			local upgrade_name = primary_category == "saw" and "melee_damage_health_ratio_multiplier" or "damage_health_ratio_multiplier"
			local damage_ratio = damage_health_ratio
			dmg_mul = dmg_mul * (1 + managers.player:upgrade_value("player", upgrade_name, 0) * damage_ratio)
		end

		dmg_mul = dmg_mul * managers.player:temporary_upgrade_value("temporary", "berserker_damage_multiplier", 1)
		dmg_mul = dmg_mul * managers.player:get_property("trigger_happy", 1)
		local fired = nil

		if fire_mode == "single" then
			if pressed then
				fired = weap_base:trigger_pressed(self:get_fire_weapon_position(), self:get_fire_weapon_direction(), dmg_mul, nil, spread_mul, autohit_mul, suppression_mul)

				if weap_base:fire_on_release() then
					if weap_base.set_tased_shot then
						weap_base:set_tased_shot(true)
					end

					fired = weap_base:trigger_released(self:get_fire_weapon_position(), self:get_fire_weapon_direction(), dmg_mul, nil, spread_mul, autohit_mul, suppression_mul)

					if weap_base.set_tased_shot then
						weap_base:set_tased_shot(false)
					end
				end
			end
		elseif fire_mode == "burst" then
			fired = weap_base:trigger_held(self:get_fire_weapon_position(), self:get_fire_weapon_direction(), dmg_mul, nil, spread_mul, autohit_mul, suppression_mul)
		elseif fire_mode == "volley" then
			if self._shooting then
				fired = weap_base:trigger_held(self:get_fire_weapon_position(), self:get_fire_weapon_direction(), dmg_mul, nil, spread_mul, autohit_mul, suppression_mul)
			end
		elseif held then
			fired = weap_base:trigger_held(self:get_fire_weapon_position(), self:get_fire_weapon_direction(), dmg_mul, nil, spread_mul, autohit_mul, suppression_mul)
		end

		local charging_weapon = weap_base:charging() and not table.contains(weap_base:weapon_tweak_data().categories, "bow")

		if not self._state_data.charging_weapon and charging_weapon then
			self:_start_action_charging_weapon(t)
		elseif self._state_data.charging_weapon and not charging_weapon then
			self:_end_action_charging_weapon(t)
		end

		new_action = true

		if fired then
			local weap_tweak_data = tweak_data.weapon[weap_base:get_name_id()]
			local recoil_multiplier = weap_base:recoil() * weap_base:recoil_multiplier() + weap_base:recoil_addend()
			local kick_tweak_data = weap_tweak_data.kick[fire_mode] or weap_tweak_data.kick
			local up, down, left, right = unpack(kick_tweak_data[self._state_data.in_steelsight and "steelsight" or self._state_data.ducking and "crouching" or "standing"])

			self._camera_unit:base():recoil_kick(up * recoil_multiplier, down * recoil_multiplier, left * recoil_multiplier, right * recoil_multiplier)

			local spread_multiplier = weap_base:spread_multiplier()

			self._equipped_unit:base():tweak_data_anim_stop("unequip")
			self._equipped_unit:base():tweak_data_anim_stop("equip")

			if managers.player:has_category_upgrade(primary_category, "stacking_hit_damage_multiplier") then
				self._state_data.stacking_dmg_mul = self._state_data.stacking_dmg_mul or {}
				self._state_data.stacking_dmg_mul[primary_category] = self._state_data.stacking_dmg_mul[primary_category] or {
					nil,
					0
				}
				local stack = self._state_data.stacking_dmg_mul[primary_category]

				if fired.hit_enemy then
					stack[1] = t + managers.player:upgrade_value(primary_category, "stacking_hit_expire_t", 1)
					stack[2] = math.min(stack[2] + 1, tweak_data.upgrades.max_weapon_dmg_mul_stacks or 5)
				else
					stack[1] = nil
					stack[2] = 0
				end
			end

			managers.hud:set_ammo_amount(weap_base:selection_index(), weap_base:ammo_info())

			if self._ext_network then
				local impact = not fired.hit_enemy

				self._ext_network:send("shot_blank", impact, 0)
			end

			if fire_mode == "volley" then
				self:_check_stop_shooting()
			end
		elseif fire_mode == "single" then
			new_action = false
		elseif fire_mode == "burst" then
			if weap_base:shooting_count() == 0 then
				new_action = false
			end
		elseif fire_mode == "volley" then
			new_action = self:_is_charging_weapon()
		end
	end

	return new_action
end