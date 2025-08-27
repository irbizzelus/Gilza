-- this here is a fix that uses BLT's persist_scripts feature. this feature constantly runs this file while an assosiated global var is nil or false
-- this was done in such way because weaponLib keeps overriding functions regardless of what it's priority is set to
-- i honestly dont know why, but my suspicion lies with the way it's hooks are added in the supermod.xml file
-- regardless, this will add anything that weaponlib is preventing me from adding through normal means
if not Gilzas_weaponlib_overrides_and_fixes then
	-- keep track of when a user clicks their primary fire button. if they do while reloading,
	-- and having run and reload skill, they can cancel the reload manualy
	PlayerStandard = PlayerStandard or class(PlayerMovementState)
	if PlayerStandard then
		Hooks:PreHook(PlayerStandard, "_check_action_primary_attack", "Gilza_prehook_check_action_primary_attack", function(self, t, input, params)
			local action_wanted = (not params or params.action_wanted == nil or params.action_wanted) and (input.btn_primary_attack_state or input.btn_primary_attack_release or self:is_shooting_count() or self:_is_charging_weapon())
			local weapon = self._equipped_unit:base() -- dont cancel reload if weapon is empty
			if weapon and weapon:can_reload() and weapon:clip_not_empty() and self.RUN_AND_RELOAD and self._running and action_wanted then
				self:_interupt_action_reload(t)
			end
		end)
		
		-- based on weaponlib's version. adds a check for new pistol full auto simulation skill. basically makes them fire in full auto even tho fire mode itself is single
		Hooks:OverrideFunction(PlayerStandard, "_check_action_primary_attack", function (self, t, input)
			if not self._equipped_unit then return false end

			local new_action = nil
			local action_wanted = input.btn_primary_attack_state or input.btn_primary_attack_release
			action_wanted = action_wanted or self:is_shooting_count()
			action_wanted = action_wanted or self:_is_charging_weapon()
			
			-- allow to potentially fire a shot even if we are not pressing mouse keys, if we requested a shot before
			self._requested_fire_between_single_shots = self._requested_fire_between_single_shots or {nil, self._equipped_unit:base()._name_id}
			if action_wanted or (Gilza.settings.single_fire_input_buffering and self._requested_fire_between_single_shots[1]) then
				
				local weap_base = self._equipped_unit:base()
				local weapon_tweak_data = weap_base:weapon_tweak_data()
				
				-- new automatic single fire skill. currently based purely off the trigger happy skill, cause this is a laziness driven development enviroment
				local _has_automatic_pistol_trigger_pull = false
				if managers.player:has_category_upgrade("pistol", "stacking_hit_damage_multiplier") and weap_base:is_category("pistol") then
					_has_automatic_pistol_trigger_pull = true
				end

				local action_forbidden =
					self:_is_reloading() or
					self:_changing_weapon() or
					self:_is_meleeing() or
					self._use_item_expire_t or
					self:_interacting() or
					self:_is_throwing_projectile() or
					self:_is_deploying_bipod() or
					self._menu_closed_fire_cooldown > 0 or
					self:is_switching_stances() or
					weapon_tweak_data.bipod_fire_only and not self:_is_using_bipod()

				if not action_forbidden then
					self._queue_reload_interupt = nil
					local start_shooting = false

					self._ext_inventory:equip_selected_primary(false)

					local fire_mode = weap_base:fire_mode()
					local animation_firemode = fire_mode == "auto" and "auto" or "single"
					if fire_mode ~= "auto" and weapon_tweak_data.fake_singlefire_anim then
						animation_firemode = "auto"
					elseif fire_mode == "auto" and weapon_tweak_data.fake_autofire_anim then
						animation_firemode = "single"
					end
					
					-- if we request a mouse press action with single fire weapons, while we cant shoot (either cause we already are or gun's ROF delay is not done)
					-- remember our mouse press request time. dont do this for weapons with too low ROF (<150 per min rn)
					if Gilza.settings.single_fire_input_buffering then
						if action_wanted and fire_mode == "single" and input.btn_primary_attack_press and (self._shooting or not weap_base:start_shooting_allowed()) and (weap_base:weapon_fire_rate() / weap_base:fire_rate_multiplier() < 0.4) then
							self._requested_fire_between_single_shots[1] = Application:time()
							self._requested_fire_between_single_shots[2] = weap_base._name_id
						elseif fire_mode == "single" and self._requested_fire_between_single_shots[1] and self._requested_fire_between_single_shots[2] == weap_base._name_id and weap_base:start_shooting_allowed() and not self._shooting and (weap_base:weapon_fire_rate() / weap_base:fire_rate_multiplier() < 0.4) then
							-- if we can shoot and we requested a shot when we couldnt shoot, try to fire a shot automatically. dont do this for weapons with too low ROF (<150 per min rn)
							local rof_based_delay_window = weap_base:weapon_fire_rate() / weap_base:fire_rate_multiplier() * 0.5
							-- also dont do this if we requested a shot too long ago, or if firing a shot would be too late after the ROF delay has run out
							if (weap_base._next_fire_allowed - self._requested_fire_between_single_shots[1] <= rof_based_delay_window) and (Application:time() - weap_base._next_fire_allowed <= rof_based_delay_window * 0.25) then
								self._requested_fire_between_single_shots[1] = nil
								-- to allow a shot, simulate a mouse press
								input.btn_primary_attack_press = true
							else
								-- if timing was unfortunate, ignore our shot request
								self._requested_fire_between_single_shots[1] = nil
							end
						elseif action_wanted and fire_mode == "burst" and input.btn_primary_attack_press and (self._shooting or not weap_base:start_shooting_allowed()) and (((weap_base:weapon_tweak_data().fire_mode_data.burst_cooldown or weap_base:weapon_fire_rate()) / weap_base:fire_rate_multiplier()) < 0.4) then
							self._requested_fire_between_single_shots[1] = Application:time()
							self._requested_fire_between_single_shots[2] = weap_base._name_id
						elseif fire_mode == "burst" and self._requested_fire_between_single_shots[1] and self._requested_fire_between_single_shots[2] == weap_base._name_id and weap_base:start_shooting_allowed() and not self._shooting and (((weap_base:weapon_tweak_data().fire_mode_data.burst_cooldown or weap_base:weapon_fire_rate()) / weap_base:fire_rate_multiplier()) < 0.4) and weap_base:shooting_count() == 0 then
							local rof_based_delay_window = (weap_base:weapon_tweak_data().fire_mode_data.burst_cooldown or weap_base:weapon_fire_rate()) / weap_base:fire_rate_multiplier() * 0.5
							if (weap_base._next_fire_allowed - self._requested_fire_between_single_shots[1] <= rof_based_delay_window) and (Application:time() - weap_base._next_fire_allowed <= rof_based_delay_window * 0.25) then
								self._requested_fire_between_single_shots[1] = nil
								input.btn_primary_attack_press = true
							else
								self._requested_fire_between_single_shots[1] = nil
							end
						else
							-- clear var on weapon/fire mode change
							if (fire_mode ~= "single" and fire_mode ~= "burst") or self._requested_fire_between_single_shots[2] ~= weap_base._name_id then
								self._requested_fire_between_single_shots[1] = nil
							elseif self._requested_fire_between_single_shots[1] then
								-- if its been too long since last shot - clear
								if Application:time() - self._requested_fire_between_single_shots[1] >= (weap_base:weapon_fire_rate() / weap_base:fire_rate_multiplier()) * 1.1 then
									self._requested_fire_between_single_shots[1] = nil
								end
							end
						end
					end

					local fire_on_release = weap_base:fire_on_release()

					if weap_base:out_of_ammo() then
						if input.btn_primary_attack_press then
							weap_base:dryfire()
						end
					elseif weap_base.clip_empty and weap_base:clip_empty() then
						if self:_is_using_bipod() then
							if input.btn_primary_attack_press then
								weap_base:dryfire()
							end

							self._equipped_unit:base():tweak_data_anim_stop("fire")
						elseif fire_mode == "single" then
							if input.btn_primary_attack_press or self._equipped_unit:base().should_reload_immediately and self._equipped_unit:base():should_reload_immediately() then
								self:_start_action_reload_enter(t)
							end
						else
							new_action = true

							self:_start_action_reload_enter(t)
						end
					elseif self._running and not self._equipped_unit:base():run_and_shoot_allowed() then
						self:_interupt_action_running(t)
					else
						local firing_animation_state = nil
						
						if not self._shooting then
							if weap_base:start_shooting_allowed() then
								local start = (fire_mode == "single" and input.btn_primary_attack_press) or (fire_mode == "single" and _has_automatic_pistol_trigger_pull and input.btn_primary_attack_state)
								start = start or fire_mode == "auto" and input.btn_primary_attack_state
								start = start or fire_mode == "burst" and input.btn_primary_attack_press
								start = start or fire_mode == "volley" and input.btn_primary_attack_press
								start = start and not fire_on_release
								start = start or fire_on_release and input.btn_primary_attack_release
								
								if start then
									weap_base:start_shooting()
									self._camera_unit:base():start_shooting()

									self._shooting = true
									self._shooting_t = t
									start_shooting = true

									if animation_firemode == "auto" then
										self._recoil_enter = true
										self._recoil_end_t = self._shooting_t + (weapon_tweak_data.timers and weapon_tweak_data.timers.fake_singlefire or 0.1)

										firing_animation_state = self._unit:camera():play_redirect(self:get_animation("recoil_enter"))
									end

									if fire_mode == "auto" then
										if (not weap_base.akimbo or weapon_tweak_data.allow_akimbo_autofire) and (not weap_base.third_person_important or weap_base.third_person_important and not weap_base:third_person_important()) then
											self._ext_network:send("sync_start_auto_fire_sound", 0)
										end
									end
								end
							else
								self:_check_stop_shooting()

								return false
							end
						end

						local suppression_ratio = self._unit:character_damage():effective_suppression_ratio()
						local spread_mul = math.lerp(1, tweak_data.player.suppression.spread_mul, suppression_ratio)
						local autohit_mul = math.lerp(1, tweak_data.player.suppression.autohit_chance_mul, suppression_ratio)
						local suppression_mul = managers.blackmarket:threat_multiplier()
						local dmg_mul = 1
						local primary_category = weapon_tweak_data.categories[1]

						if not weapon_tweak_data.ignore_damage_multipliers then
							dmg_mul = dmg_mul * managers.player:temporary_upgrade_value("temporary", "dmg_multiplier_outnumbered", 1)

							if managers.player:has_category_upgrade("player", "overkill_all_weapons") or weap_base:is_category("shotgun", "saw") then
								dmg_mul = dmg_mul * managers.player:temporary_upgrade_value("temporary", "overkill_damage_multiplier", 1)
							end

							local health_ratio = self._ext_damage:health_ratio()
							local damage_health_ratio = managers.player:get_damage_health_ratio(health_ratio, primary_category)

							if damage_health_ratio > 0 then
								local upgrade_name = weap_base:is_category("saw") and "melee_damage_health_ratio_multiplier" or "damage_health_ratio_multiplier"
								local damage_ratio = damage_health_ratio
								dmg_mul = dmg_mul * (1 + managers.player:upgrade_value("player", upgrade_name, 0) * damage_ratio)
							end

							dmg_mul = dmg_mul * managers.player:temporary_upgrade_value("temporary", "berserker_damage_multiplier", 1)
							dmg_mul = dmg_mul * managers.player:get_property("trigger_happy", 1)
						end

						local fired = nil

						if fire_mode == "single" then
							if input.btn_primary_attack_press and start_shooting then
								fired = weap_base:trigger_pressed(self:get_fire_weapon_position(), self:get_fire_weapon_direction(), dmg_mul, nil, spread_mul, autohit_mul, suppression_mul)
							elseif _has_automatic_pistol_trigger_pull and input.btn_primary_attack_state then
								fired = weap_base:trigger_held(self:get_fire_weapon_position(), self:get_fire_weapon_direction(), dmg_mul, nil, spread_mul, autohit_mul, suppression_mul)
							elseif fire_on_release then
								if input.btn_primary_attack_release then
									fired = weap_base:trigger_released(self:get_fire_weapon_position(), self:get_fire_weapon_direction(), dmg_mul, nil, spread_mul, autohit_mul, suppression_mul)
								elseif input.btn_primary_attack_state then
									weap_base:trigger_held(self:get_fire_weapon_position(), self:get_fire_weapon_direction(), dmg_mul, nil, spread_mul, autohit_mul, suppression_mul)
								end
							end
						elseif fire_mode == "burst" then
							fired = weap_base:trigger_held(self:get_fire_weapon_position(), self:get_fire_weapon_direction(), dmg_mul, nil, spread_mul, autohit_mul, suppression_mul)
						elseif fire_mode == "volley" then
							if self._shooting then
								fired = weap_base:trigger_held(self:get_fire_weapon_position(), self:get_fire_weapon_direction(), dmg_mul, nil, spread_mul, autohit_mul, suppression_mul)
							end
						elseif input.btn_primary_attack_state then
							fired = weap_base:trigger_held(self:get_fire_weapon_position(), self:get_fire_weapon_direction(), dmg_mul, nil, spread_mul, autohit_mul, suppression_mul)
						end

						if weap_base.manages_steelsight and weap_base:manages_steelsight() then
							if weap_base:wants_steelsight() and not self._state_data.in_steelsight then
								self:_start_action_steelsight(t)
							elseif not weap_base:wants_steelsight() and self._state_data.in_steelsight then
								self:_end_action_steelsight(t)
							end
						end

						local charging_weapon = weap_base:charging()

						if not self._state_data.charging_weapon and charging_weapon then
							self:_start_action_charging_weapon(t)
						elseif self._state_data.charging_weapon and not charging_weapon then
							self:_end_action_charging_weapon(t)
						end

						new_action = true

						if fired then
							managers.rumble:play("weapon_fire")

							local clip_empty = weap_base:ammo_base():get_ammo_remaining_in_clip() <= (weap_base.AKIMBO and 1 or 0)
							self._camera_unit:anim_state_machine():set_global("is_empty", clip_empty and 1 or 0)

							local weap_tweak_data = weap_base:weapon_tweak_data()
							local shake_tweak_data = weap_tweak_data.shake[fire_mode] or weap_tweak_data.shake
							local shake_multiplier = shake_tweak_data[self._state_data.in_steelsight and "fire_steelsight_multiplier" or "fire_multiplier"]

							self._ext_camera:play_shaker("fire_weapon_rot", 1 * shake_multiplier)
							self._ext_camera:play_shaker("fire_weapon_kick", 1 * shake_multiplier, 1, 0.15)

							if animation_firemode == "single" and weap_base:get_name_id() ~= "saw" then
								local redirect = self:get_animation("recoil")
								if self._state_data.in_steelsight and weap_tweak_data.animations.recoil_steelsight and not weap_base:is_second_sight_on() then
									redirect = self:get_animation("recoil_steelsight")
								end

								firing_animation_state = self._ext_camera:play_redirect(redirect, weap_base:fire_rate_multiplier())
							end

							local recoil_multiplier = (weap_base:recoil() + weap_base:recoil_addend()) * weap_base:recoil_multiplier()

							local kick_tweak_data = weap_tweak_data.kick[fire_mode] or weap_tweak_data.kick
							local up, down, left, right = unpack(kick_tweak_data[self._state_data.in_steelsight and "steelsight" or self._state_data.ducking and "crouching" or "standing"])

							self._camera_unit:base():recoil_kick(up * recoil_multiplier, down * recoil_multiplier, left * recoil_multiplier, right * recoil_multiplier)

							if self._shooting_t then
								local time_shooting = t - self._shooting_t
								local achievement_data = tweak_data.achievement.never_let_you_go

								if achievement_data and weap_base:get_name_id() == achievement_data.weapon_id and achievement_data.timer <= time_shooting then
									managers.achievment:award(achievement_data.award)

									self._shooting_t = nil
								end
							end

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

							if weap_base.set_recharge_clbk then
								weap_base:set_recharge_clbk(callback(self, self, "weapon_recharge_clbk_listener"))
							end

							managers.hud:set_ammo_amount(weap_base:selection_index(), weap_base:ammo_info())

							local impact = not fired.hit_enemy

							if weap_base.third_person_important and weap_base:third_person_important() then
								self._ext_network:send("shot_blank_reliable", impact, 0)
							elseif fire_mode ~= "auto" or weap_base.akimbo and not weapon_tweak_data.allow_akimbo_autofire then
								self._ext_network:send("shot_blank", impact, 0)
							end

							if fire_mode == "volley" then
								self:_check_stop_shooting()
							end
						elseif fire_mode == "single" and not _has_automatic_pistol_trigger_pull then
							new_action = false
						elseif fire_mode == "burst" then
							if weap_base:shooting_count() == 0 then
								new_action = false
							end
						elseif fire_mode == "volley" then
							new_action = self:_is_charging_weapon()
						end

						if firing_animation_state then
							self._camera_unit:anim_state_machine():set_parameter(firing_animation_state, "alt_weight", self._equipped_unit:base():alt_fire_active() and 1 or 0)
						end
					end
				elseif self:_is_reloading() and self._equipped_unit:base():reload_interuptable() and input.btn_primary_attack_press then
					self._queue_reload_interupt = true
					self._requested_fire_between_single_shots[1] = nil -- clear single fire shot buffering
				else
					self._requested_fire_between_single_shots[1] = nil
				end
			end

			if not new_action then
				self:_check_stop_shooting()
			end

			return new_action
		end)
	end
	
	-- fix an issue with weaponlib where all bipoded weapons are allowed to reload while bipoded by default, instead of
	-- exiting bipod state and then begining to reload. theoretically a good feature for custom weapons that might have
	-- reload animations while reloading, but why it's defauled to true for vanilla LMG's is beyond me.
	PlayerBipod = PlayerBipod or class(PlayerStandard)
	if PlayerBipod then
		Hooks:OverrideFunction(PlayerBipod, "_check_action_reload", function (self, t, input)
			local new_action = nil
			local action_wanted = input.btn_reload_press

			if action_wanted and self._equipped_unit and not self._equipped_unit:base():clip_full() then
				local weapon = self._equipped_unit:base()
				local weapon_tweak_data = weapon:weapon_tweak_data()
				if not (weapon_tweak_data.bipod_reload_allowed or false) then
					self:exit(nil, "standard")
					managers.player:set_player_state("standard")
				end

				self:_start_action_reload_enter(t)

				new_action = true
			end

			return new_action
		end)
	end
	
	_G.Gilzas_weaponlib_overrides_and_fixes = {} -- the needed global var
end