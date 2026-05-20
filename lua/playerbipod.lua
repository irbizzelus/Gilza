Hooks:OverrideFunction(PlayerBipod, "_enter", function (self, enter_data)
	
	self._exiting_bipod_state = false
	local player = managers.player:player_unit()

	if player and self._unit:base().is_local_player then
		self._bipod = true
		local tweak_data = self._equipped_unit:base():weapon_tweak_data()
		local speed_multiplier = self._equipped_unit:base():get_property("bipod_deploy_multiplier") or 1
		local reload_name_id = tweak_data.animations.reload_name_id or self._equipped_unit:base().name_id
		local equipped_unit_id = self._equipped_unit:base().name_id
		
		-- use new swag angles if gun is ready for it, otherwise use vanilla anims
		if not tweak_data.has_new_gilza_bipod_camera then
			self._camera_pos = self._unit:camera():position()
			self._shoulder_pos = Vector3(0, 0, 0)
			if tweak_data.bipod_weapon_translation then
				mvector3.set(self._shoulder_pos, tweak_data.bipod_weapon_translation)
			end
			mvector3.rotate_with(self._shoulder_pos, self._unit:camera():rotation())
			mvector3.add(self._shoulder_pos, self._camera_pos)
		else
			self._shoulder_pos = nil
		end

		self._unit_deploy_position = player:position()
		
		local weapon = self._equipped_unit:base()
		local bipod_part = managers.weapon_factory:get_parts_from_weapon_by_perk("bipod", weapon._parts)
		local bipod_unit = false
		if bipod_part and bipod_part[1] then
			bipod_unit = bipod_part[1].unit:base()
			self._bipod_flag_entry_type = bipod_unit._bipod_entry_type
			self._bipod_flag_lean_type = bipod_unit._bipod_lean_type
		end
		
		-- cam limits only in manual while auto is fluid
		if bipod_unit and self._bipod_flag_entry_type == "entry_standard" and self._bipod_flag_lean_type then
			self._unit:camera():camera_unit():base():set_standard_bipod_limits(40, 15, self._bipod_flag_lean_type) -- for consistency sake
		elseif bipod_unit and self._bipod_flag_entry_type == "entry_automatic" and self._bipod_flag_lean_type then
			local centre_adjustment = 0
			if self._bipod_flag_lean_type == "right_lean" then
				centre_adjustment = 12
			elseif self._bipod_flag_lean_type == "left_lean" then
				centre_adjustment = -12
			end
			bipod_unit._entry_camera_centre_spin = (managers.player:player_unit():camera():camera_unit():base()._camera_properties.spin or 0) + centre_adjustment
			bipod_unit._entry_camera_centre_pitch = (managers.player:player_unit():camera():camera_unit():base()._camera_properties.pitch or 0)
		end
		
		-- auto deploy has inaccuracy penalty for some time while manual is slower
		if bipod_unit and self._bipod_flag_entry_type == "entry_automatic" then
			speed_multiplier = speed_multiplier * managers.player:upgrade_value("player", "bipod_deploy_speed", 1)
			self._deploy_bipod_start = Application:time()
			self._deploy_bipod_end = Application:time() + (tweak_data.timers.deploy_bipod or 1) / speed_multiplier * 3.333 -- increase the bipod deploy speed to make accuracy multiplier gain max acc longer, without affecting the animation speed
		else
			speed_multiplier = speed_multiplier * managers.player:upgrade_value("player", "bipod_deploy_speed", 1) * 0.6667 -- slower manual deploy to make choice between man and auto a thing
			PlayerBipod.super:start_deploying_bipod((tweak_data.timers.deploy_bipod or 1)/speed_multiplier)
		end
		
		self._equipped_unit:base():tweak_data_anim_stop("undeploy")
		
		-- only play bipod entry anim for manual, cause otherwise its extremely distracting
		if not (bipod_unit and self._bipod_flag_entry_type == "entry_automatic") then
			self._ext_camera:play_redirect(Idstring(tweak_data.animations.bipod_enter .. "_" .. equipped_unit_id), speed_multiplier)
			self._equipped_unit:base():tweak_data_anim_play("deploy", speed_multiplier)
		end
		
		self._headbob = 0
		self._target_headbob = 0

		self._ext_camera:set_shaker_parameter("headbob", "amplitude", 0)

		PlayerStandard.ANIM_STATES.bipod = {
			recoil = Idstring(tweak_data.animations.bipod_recoil .. "_" .. equipped_unit_id),
			recoil_enter = Idstring(tweak_data.animations.bipod_recoil_enter .. "_" .. equipped_unit_id),
			recoil_loop = Idstring(tweak_data.animations.bipod_recoil_loop .. "_" .. equipped_unit_id),
			recoil_exit = Idstring(tweak_data.animations.bipod_recoil_exit .. "_" .. equipped_unit_id)
		}

		self:set_animation_state("bipod")
		self._unit:sound_source():post_event("wp_steady_in")
		
		managers.player.bipod_entry_started = self._bipod_flag_lean_type
		self:_stance_entered()
		
		self:_husk_bipod_data()
		
		-- dont forget to transfer to bipod animations after entering this state to prevent weird arm snapping when shooting
		if bipod_unit and self._bipod_flag_entry_type == "entry_automatic" then
			self._ext_camera:play_redirect(self:get_animation("recoil_exit"))
		end
		
		-- bipod is always ADS'd
		self:_check_action_steelsight(Application:time(), input)
	end
end)

-- adds bipod skill and adjusts new values
Hooks:OverrideFunction(PlayerBipod, "exit", function (self, state_data, new_state_name)
	
	if self._state_data.in_steelsight then
		self:_end_action_steelsight(t)
	end
	self._exiting_bipod_state = true
	managers.player.bipod_entry_started = false
	
	PlayerBipod.super.exit(self, state_data or self._state_data, new_state_name)

	self._bipod = nil
	local tweak_data = self._equipped_unit:base():weapon_tweak_data()
	local speed_multiplier = self._equipped_unit:base():get_property("bipod_deploy_multiplier") or 1
	local equipped_unit_id = self._equipped_unit:base().name_id
	
	self._equipped_unit:base():tweak_data_anim_stop("deploy")
	
	if self._bipod_flag_entry_type == "entry_automatic" then
		speed_multiplier = speed_multiplier * managers.player:upgrade_value("player", "bipod_deploy_speed", 1) * 1.35
	else
		speed_multiplier = speed_multiplier * managers.player:upgrade_value("player", "bipod_deploy_speed", 1)
	end
	
	local result = self._ext_camera:play_redirect(Idstring(tweak_data.animations.bipod_exit .. "_" .. equipped_unit_id), speed_multiplier)
	local result_deploy = self._equipped_unit:base():tweak_data_anim_play("undeploy", speed_multiplier)

	self._unit:camera():camera_unit():base():remove_limits()

	self._unit:camera():camera_unit():base().bipod_location = nil
	local exit_data = {
		skip_equip = true
	}
	self._dye_risk = nil

	self:set_animation_state("standard")
	self._unit:sound_source():post_event("wp_steady_out")

	local peer_id = managers.network:session():peer_by_unit(self._unit):id()

	Application:trace("PlayerBipod:exit: ", peer_id)
	managers.player:set_bipod_data_for_peer({
		peer_id = peer_id
	})

	self._state_data.previous_state = "bipod"
	
	managers.player._gilza_flag_bipod_redeploy_delay = Application:time() + (1.2 * (1 / managers.player:upgrade_value("player", "bipod_deploy_speed", 1)))
	return exit_data
end)

Hooks:OverrideFunction(PlayerBipod, "get_zoom_fov", function (self, stance_data)
	local fov = stance_data and stance_data.FOV or 50
	local fov_multiplier = self._setting_fov_multiplier

	-- by default you are forced to ads when entering bipod state. all scopes have a zoom level, but iron sights do not. to make irons a competitive option, it will get a zoom bonus
	local extra_zoom = 0.6
	local scope_parts = managers.weapon_factory:get_parts_from_weapon_by_perk("scope", self._equipped_unit:base()._parts)
	if scope_parts and scope_parts[1] then
		extra_zoom = 1 -- while scopes get default increases
	end

	if self._state_data.in_steelsight then
		fov = self._equipped_unit:base():zoom()
		fov_multiplier = (1 + (fov_multiplier - 1) / 2) * extra_zoom
	end

	return fov * fov_multiplier
end)

Hooks:OverrideFunction(PlayerBipod, "_check_action_steelsight", function (self, t, input)
	-- crouch check is normaly executed before steelsights, so we do start it here. we need to check for uncrouch input if we are in auto, so we add this check
	local cur_state = self._ext_movement:current_state_name()
	self:_check_action_duck(t, input)
	if cur_state ~= self._ext_movement:current_state_name() then
		return
	end
	
	-- same for interacting
	if input then
		self:_check_action_interact(t, input)
		if cur_state ~= self._ext_movement:current_state_name() then
			return
		end
	end
	
	if cur_state == "bipod" and not self._state_data.in_steelsight and not self._exiting_bipod_state then
		self:_start_action_steelsight(t)
	end
end)

Hooks:OverrideFunction(PlayerBipod, "_update_movement", function (self, t, dt)
	if self._move_dir then
		
		if self._bipod_flag_entry_type == "entry_automatic" then
			self:_unmount_bipod()
			
			-- if we quit auto-bipod by moving, reduce redeploy delay in half
			managers.player._gilza_flag_bipod_redeploy_delay = Application:time() + (0.6 * (1 / managers.player:upgrade_value("player", "bipod_deploy_speed", 1)))
			local current_state = managers.player:get_current_state()

			if current_state then
				current_state:_update_movement(t, dt)
			end
		end
	end
end)

Hooks:OverrideFunction(PlayerBipod, "_check_action_unmount_bipod", function (self, t, input)
	if not input.btn_deploy_bipod then
		return false
	end
	
	-- if we press bipod button while bipod is already auto-deploying, ignore the input to prevent accidental undeploy
	if Application:time() <= ((self._deploy_bipod_start or -1) + 0.2) then
		return false
	end

	self:_unmount_bipod()

	return true
end)

-- if we auto deployed while crouched, uncrouch input unmounts
Hooks:OverrideFunction(PlayerBipod, "_check_action_duck", function (self, t, input)
	if input and input.btn_duck_press and not self._unit:base():stats_screen_visible() then
		
		if self._bipod_flag_lean_type == "crouched" and self._bipod_flag_entry_type == "entry_automatic" then
			self:_unmount_bipod()
			
			local current_state = managers.player:get_current_state()

			if current_state then
				current_state:_end_action_ducking(t)
			end
			
			return true
		end
	end
end)

-- add ability to interact while auto-deployed, but unmount player first
Hooks:OverrideFunction(PlayerBipod, "_check_action_interact", function (self, t, input)
	local keyboard = self._controller.TYPE == "pc" or managers.controller:get_default_wrapper_type() == "pc"
	local pressed, released, holding = nil

	if self._interact_expire_t and not self._use_item_expire_t then
		pressed, released, holding = self:_check_tap_to_interact_inputs(t, input.btn_interact_press, input.btn_interact_release, input.btn_interact_state)
	else
		holding = input.btn_interact_state
		released = input.btn_interact_release
		pressed = input.btn_interact_press
	end

	local new_action, timer, interact_object = nil

	if pressed then
		if _G.IS_VR then
			self._interact_hand = input.btn_interact_left_press and PlayerHand.LEFT or PlayerHand.RIGHT
		end
		
		if not self:_action_interact_forbidden() then
			new_action, timer, interact_object = self._interaction:interact(self._unit, input.data, self._interact_hand)

			if new_action then
				self:_play_interact_redirect(t, input)
			end

			if timer then
				new_action = true
				self:_unmount_bipod()
				local current_state = managers.player:get_current_state()
				if current_state then
					current_state._ext_camera:camera_unit():base():set_limits(80, 50)
					current_state:_start_action_interact(t, input, timer, interact_object)
					current_state:_chk_tap_to_interact_enable(t, timer, interact_object)
				end
				return true
			end

			if not new_action then
				self._start_intimidate = true
				self._start_intimidate_t = t
			end
		end
	end

	local secondary_delay = tweak_data.team_ai.stop_action.delay
	local force_secondary_intimidate = false

	if not new_action and keyboard and input.btn_interact_secondary_press then
		force_secondary_intimidate = true
	end

	if released then
		if _G.IS_VR then
			local release_hand = input.btn_interact_left_release and PlayerHand.LEFT or PlayerHand.RIGHT
			released = release_hand == self._interact_hand
		end

		if released then
			if self._start_intimidate and not self:_action_interact_forbidden() then
				if t < self._start_intimidate_t + secondary_delay then
					self:_start_action_intimidate(t)

					self._start_intimidate = false
				end
			else
				self:_interupt_action_interact()
			end
		end
	end

	if (self._start_intimidate or force_secondary_intimidate) and not self:_action_interact_forbidden() and (not keyboard and t > self._start_intimidate_t + secondary_delay or force_secondary_intimidate) then
		self:_start_action_intimidate(t, true)

		self._start_intimidate = false
	end

	return new_action
end)

Hooks:OverrideFunction(PlayerBipod, "interaction_blocked", function (self)
	if self._bipod_flag_entry_type and self._bipod_flag_entry_type == "entry_automatic" then
		return false
	else
		return true
	end
end)