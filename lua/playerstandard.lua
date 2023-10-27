-- allow faster melee charge aa
local old_meleecharge = PlayerStandard._get_melee_charge_lerp_value
function PlayerStandard:_get_melee_charge_lerp_value(...)
	local value = old_meleecharge(self, ...)
	return math.clamp(value * managers.player:upgrade_value("player", "melee_faster_charge", 1), 0, 1)
end


-- sprint while meleeing
function PlayerStandard:_start_action_running(t)
	if not self._move_dir then
		self._running_wanted = true

		return
	end

	if self:on_ladder() or self:_on_zipline() then
		return
	end

	if self._shooting and not self._equipped_unit:base():run_and_shoot_allowed() or self._use_item_expire_t or self._state_data.in_air or self:_is_throwing_projectile() or self:_is_charging_weapon() or self:_changing_weapon() then
		self._running_wanted = true

		return
	end
	
	
	if self:_is_meleeing() then -- moved melee check from block above for ease of access
		if not managers.player:has_category_upgrade("player", "melee_sprint") then -- just like base game
			self._running_wanted = true
			return
		else
			-- if we have skill dont reset sprint
		end
	end

	if self._state_data.ducking and not self:_can_stand() then
		self._running_wanted = true

		return
	end

	if not self:_can_run_directional() then
		return
	end

	self._running_wanted = false

	if managers.player:get_player_rule("no_run") then
		return
	end

	if not self._unit:movement():is_above_stamina_threshold() then
		return
	end

	if (not self._state_data.shake_player_start_running or not self._ext_camera:shaker():is_playing(self._state_data.shake_player_start_running)) and self._setting_use_headbob then
		self._state_data.shake_player_start_running = self._ext_camera:play_shaker("player_start_running", 0.75)
	end

	self:set_running(true)

	self._end_running_expire_t = nil
	self._start_running_t = t
	self._play_stop_running_anim = nil
	
	if managers.player:has_category_upgrade("player", "melee_sprint") then
		if (not self:_is_reloading() or not self.RUN_AND_RELOAD) and not self:_is_meleeing() then
			if not self._equipped_unit:base():run_and_shoot_allowed() then
				self._ext_camera:play_redirect(self:get_animation("start_running"))
			else
				self._ext_camera:play_redirect(self:get_animation("idle"))
			end
		end
	else
		if not self:_is_reloading() or not self.RUN_AND_RELOAD then
			if not self._equipped_unit:base():run_and_shoot_allowed() then
				self._ext_camera:play_redirect(self:get_animation("start_running"))
			else
				self._ext_camera:play_redirect(self:get_animation("idle"))
			end
		end
	end

	if not self.RUN_AND_RELOAD then
		self:_interupt_action_reload(t)
	end

	self:_interupt_action_steelsight(t)
	self:_interupt_action_ducking(t)

	--self:_stance_entered()
end

-- fixes sprint beeing reset when starting melee charge with sprint skill
function PlayerStandard:_start_action_melee(t, input, instant)
	self._equipped_unit:base():tweak_data_anim_stop("fire")
	self:_interupt_action_reload(t)
	self:_interupt_action_steelsight(t)
	if not managers.player:has_category_upgrade("player", "melee_sprint") then -- over here
		self:_interupt_action_running(t)
	end
	self:_interupt_action_charging_weapon(t)

	self._state_data.melee_charge_wanted = nil
	self._state_data.meleeing = true
	self._state_data.melee_start_t = nil
	local melee_entry = managers.blackmarket:equipped_melee_weapon()
	local primary = managers.blackmarket:equipped_primary()
	local primary_id = primary.weapon_id
	local bayonet_id = managers.blackmarket:equipped_bayonet(primary_id)
	local bayonet_melee = false

	if bayonet_id and melee_entry == "weapon" and self._equipped_unit:base():selection_index() == 2 then
		bayonet_melee = true
	end

	if instant then
		self:_do_action_melee(t, input)

		return
	end

	self:_stance_entered()

	if self._state_data.melee_global_value then
		self._camera_unit:anim_state_machine():set_global(self._state_data.melee_global_value, 0)
	end

	local melee_entry = managers.blackmarket:equipped_melee_weapon()
	self._state_data.melee_global_value = tweak_data.blackmarket.melee_weapons[melee_entry].anim_global_param

	self._camera_unit:anim_state_machine():set_global(self._state_data.melee_global_value, 1)

	local current_state_name = self._camera_unit:anim_state_machine():segment_state(self:get_animation("base"))
	local attack_allowed_expire_t = tweak_data.blackmarket.melee_weapons[melee_entry].attack_allowed_expire_t or 0.15
	self._state_data.melee_attack_allowed_t = t + (current_state_name ~= self:get_animation("melee_attack_state") and attack_allowed_expire_t or 0)
	local instant_hit = tweak_data.blackmarket.melee_weapons[melee_entry].instant

	if not instant_hit then
		self._ext_network:send("sync_melee_start", 0)
	end

	if current_state_name == self:get_animation("melee_attack_state") then
		self._ext_camera:play_redirect(self:get_animation("melee_charge"))

		return
	end

	local offset = nil

	if current_state_name == self:get_animation("melee_exit_state") then
		local segment_relative_time = self._camera_unit:anim_state_machine():segment_relative_time(self:get_animation("base"))
		offset = (1 - segment_relative_time) * 0.9
	end

	offset = math.max(offset or 0, attack_allowed_expire_t)

	self._ext_camera:play_redirect(self:get_animation("melee_enter"), nil, offset)
end

-- fixes sprint stop animations while melee'ing
function PlayerStandard:_end_action_running(t)
	if not self._end_running_expire_t then
		local speed_multiplier = self._equipped_unit:base():exit_run_speed_multiplier()
		self._end_running_expire_t = t + 0.4 / speed_multiplier
		local stop_running = not self._equipped_unit:base():run_and_shoot_allowed() and (not self.RUN_AND_RELOAD or not self:_is_reloading())

		if not managers.player:has_category_upgrade("player", "melee_sprint") then 
			if stop_running then
				self._ext_camera:play_redirect(self:get_animation("stop_running"), speed_multiplier)
			end
		elseif self:_is_meleeing() then
			if stop_running then
				--charging weapon: doing melee anims
				self._ext_camera:play_redirect(self:get_animation("melee_exit_state"), speed_multiplier)
			end
		else
			if stop_running then
				--not charging weapon: doing standard stuff
				self._ext_camera:play_redirect(self:get_animation("stop_running"), speed_multiplier)
			end
		end
	end
end

-- fixes melee sprint jump animations
function PlayerStandard:_start_action_jump(t, action_start_data)
	if self._running and self:_is_reloading() and not self.RUN_AND_RELOAD and not self._equipped_unit:base():run_and_shoot_allowed() then
		self:_interupt_action_reload(t)
		if not managers.player:has_category_upgrade("player", "melee_sprint") then 
			self._ext_camera:play_redirect(self:get_animation("stop_running"), self._equipped_unit:base():exit_run_speed_multiplier())
		else
			if self:_is_meleeing() then
				--charging melee: no anim reset
				self._ext_camera:play_redirect(self:get_animation("melee_exit_state"), speed_multiplier)
			else
				--standard stuff
				self._ext_camera:play_redirect(self:get_animation("stop_running"), self._equipped_unit:base():exit_run_speed_multiplier())
			end
		end
	end

	self:_interupt_action_running(t)

	self._jump_t = t
	local jump_vec = action_start_data.jump_vel_z * math.UP

	self._unit:mover():jump()

	if self._move_dir then
		local move_dir_clamp = self._move_dir:normalized() * math.min(1, self._move_dir:length())
		self._last_velocity_xy = move_dir_clamp * action_start_data.jump_vel_xy
		self._jump_vel_xy = mvector3.copy(self._last_velocity_xy)
	else
		self._last_velocity_xy = Vector3()
	end

	self:_perform_jump(jump_vec)
end

-- adjusts ammo pick up for grenades to use new amounts, otherwise can get marked as cheater
function PlayerStandard:_find_pickups(t)
	local pickups = World:find_units_quick("sphere", self._unit:movement():m_pos(), self._pickup_area, self._slotmask_pickups)
	local grenade_tweak = tweak_data.blackmarket.projectiles[managers.blackmarket:equipped_grenade()]
	local may_find_grenade = not grenade_tweak.base_cooldown and managers.player:has_category_upgrade("player", "regain_throwable_from_ammo")

	for _, pickup in ipairs(pickups) do
		if pickup:pickup() and pickup:pickup():pickup(self._unit) then
			if may_find_grenade then
				local data = managers.player:upgrade_value("player", "regain_throwable_from_ammo", nil)
				
				local nades = {
					frag_com = 2,
					dada_com = 2,
					frag = 2,
					dynamite = 2,
					fir_com = 3,
					molotov = 2,
					wpn_gre_electric = 3,
					wpn_prj_four = 6,
					wpn_prj_ace = 10,
					wpn_prj_hur = 3,
					wpn_prj_jav = 2,
					wpn_prj_target = 5,
					concussion = 4,
					sticky_grenade = 3,
					poison_gas_grenade = 2
				}
				function Gilza_nadepickuptweaks()
					if not grenade_tweak.base_cooldown then
						tweak_data.blackmarket.projectiles[managers.blackmarket:equipped_grenade()].max_amount = nades[managers.blackmarket:equipped_grenade()]
					end
				end
				Gilza_nadepickuptweaks()
				if data then
					managers.player:add_coroutine("regain_throwable_from_ammo", PlayerAction.FullyLoaded, managers.player, data.chance, data.chance_inc)
				end
			end

			for id, weapon in pairs(self._unit:inventory():available_selections()) do
				managers.hud:set_ammo_amount(id, weapon.unit:base():ammo_info())
			end
		end
	end
end

-- new berserk dmg increase @line 359
function PlayerStandard:_check_action_primary_attack(t, input)
	local new_action = nil
	local action_wanted = input.btn_primary_attack_state or input.btn_primary_attack_release
	action_wanted = action_wanted or self:is_shooting_count()
	action_wanted = action_wanted or self:_is_charging_weapon()

	if action_wanted then
		local action_forbidden = self:_is_reloading() or self:_changing_weapon() or self:_is_meleeing() or self._use_item_expire_t or self:_interacting() or self:_is_throwing_projectile() or self:_is_deploying_bipod() or self._menu_closed_fire_cooldown > 0 or self:is_switching_stances()

		if not action_forbidden then
			self._queue_reload_interupt = nil
			local start_shooting = false

			self._ext_inventory:equip_selected_primary(false)

			if self._equipped_unit then
				local weap_base = self._equipped_unit:base()
				local fire_mode = weap_base:fire_mode()
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
					if not self._shooting then
						if weap_base:start_shooting_allowed() then
							local start = fire_mode == "single" and input.btn_primary_attack_press
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

								if fire_mode == "auto" then
									self._unit:camera():play_redirect(self:get_animation("recoil_enter"))

									if (not weap_base.akimbo or weap_base:weapon_tweak_data().allow_akimbo_autofire) and (not weap_base.third_person_important or weap_base.third_person_important and not weap_base:third_person_important()) then
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
					local weapon_tweak_data = weap_base:weapon_tweak_data()
					local primary_category = weapon_tweak_data.categories[1]

					if not weapon_tweak_data.ignore_damage_multipliers then
						dmg_mul = dmg_mul * managers.player:temporary_upgrade_value("temporary", "dmg_multiplier_outnumbered", 1)

						if managers.player:has_category_upgrade("player", "overkill_all_weapons") or weap_base:is_category("shotgun", "saw") then
							dmg_mul = dmg_mul * managers.player:temporary_upgrade_value("temporary", "overkill_damage_multiplier", 1)
						end
						
						if managers.player:has_category_upgrade("temporary", "new_berserk_weapon_damage_multiplier") then
							dmg_mul = dmg_mul * managers.player:temporary_upgrade_value("temporary", "new_berserk_weapon_damage_multiplier", 1)
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

						local weap_tweak_data = tweak_data.weapon[weap_base:get_name_id()]
						local shake_tweak_data = weap_tweak_data.shake[fire_mode] or weap_tweak_data.shake
						local shake_multiplier = shake_tweak_data[self._state_data.in_steelsight and "fire_steelsight_multiplier" or "fire_multiplier"]

						self._ext_camera:play_shaker("fire_weapon_rot", 1 * shake_multiplier)
						self._ext_camera:play_shaker("fire_weapon_kick", 1 * shake_multiplier, 1, 0.15)
						self._equipped_unit:base():tweak_data_anim_stop("unequip")
						self._equipped_unit:base():tweak_data_anim_stop("equip")

						if not self._state_data.in_steelsight or not weap_base:tweak_data_anim_play("fire_steelsight", weap_base:fire_rate_multiplier()) then
							weap_base:tweak_data_anim_play("fire", weap_base:fire_rate_multiplier())
						end

						if fire_mode ~= "auto" and weap_base:get_name_id() ~= "saw" then
							local state = nil

							if not self._state_data.in_steelsight then
								state = self._ext_camera:play_redirect(self:get_animation("recoil"), weap_base:fire_rate_multiplier())
							elseif weap_tweak_data.animations.recoil_steelsight then
								state = self._ext_camera:play_redirect(weap_base:is_second_sight_on() and self:get_animation("recoil") or self:get_animation("recoil_steelsight"), 1)
							end

							if state then
								self._camera_unit:anim_state_machine():set_parameter(state, "alt_weight", self._equipped_unit:base():alt_fire_active() and 1 or 0)
							end
						end

						local recoil_multiplier = (weap_base:recoil() + weap_base:recoil_addend()) * weap_base:recoil_multiplier()

						cat_print("jansve", "[PlayerStandard] Weapon Recoil Multiplier: " .. tostring(recoil_multiplier))

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
						elseif fire_mode ~= "auto" or weap_base.akimbo and not weap_base:weapon_tweak_data().allow_akimbo_autofire then
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
			end
		elseif self:_is_reloading() and self._equipped_unit:base():reload_interuptable() and input.btn_primary_attack_press then
			self._queue_reload_interupt = true
		end
	end

	if not new_action then
		self:_check_stop_shooting()
	end

	return new_action
end