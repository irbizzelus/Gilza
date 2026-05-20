WeaponLionGadget1.biopd_z_offset = -18 -- initial vertical bipod offset, from player camera to the bipod itself, to check against bipod level instead of camera level
WeaponLionGadget1.forward_distance = 45 -- from player camera to bipod itself. same as var above but forwards
WeaponLionGadget1.vertical_distance = 75 -- downward distance from the "bipod" position, used to establish core points in space where the raychecks are ending
WeaponLionGadget1.ray_distance = 75 -- used for similar purpose as the var above, but for x,y axis
WeaponLionGadget1.max_angled_distance = 60 -- max length of a 45 degree angled ray
WeaponLionGadget1.max_flat_distance = 40 -- max length of a 90 degree rays going straight to the right
 -- default vars
WeaponLionGadget1._bipod_entry_type = "empty"
WeaponLionGadget1._bipod_lean_type = "empty"
WeaponLionGadget1._entry_camera_centre_spin = 0
WeaponLionGadget1._entry_camera_centre_pitch = 0

Hooks:OverrideFunction(WeaponLionGadget1, "check_state", function (self, request)
	if self._is_npc then
		return false
	end

	local bipod_deployable = self:_is_deployable()
	
	if request and request == "entry_automatic" then
		self._bipod_entry_type = "entry_automatic"
	else
		self._bipod_entry_type = "entry_standard"
	end

	if not bipod_deployable and not self:is_deployed() and (not request or request == "entry_standard") then
		managers.hud:show_hint({
			time = 2,
			text = managers.localization:text("hud_hint_bipod_nomount")
		})
	end

	self._deployed = false

	if not self._is_npc then
		if managers.player:current_state() ~= "bipod" and bipod_deployable then
			
			local curr_state = managers.player:player_unit():movement():current_state()
			if curr_state:in_steelsight() then
				curr_state:_end_action_steelsight(t)
			end
			
			self._previous_state = managers.player:current_state()

			managers.player:set_player_state("bipod")

			self._deployed = true
		elseif managers.player:current_state() == "bipod" then
			self:_unmount()
		end
	end

	self._unit:set_extension_update_enabled(Idstring("base"), self._deployed)
end)

Hooks:OverrideFunction(WeaponLionGadget1, "_is_deployable", function (self)
	if self._is_npc then
		return false
	end

	if self:_is_in_blocked_deployable_state() then
		return false
	end

	local player = managers.player:local_player():movement()
	
	-- always bipod if crouched
	if player:current_state():ducking() then
		self._bipod_lean_type = "crouched"
		return true, "crouched"
	end
	
	local debug_draw = false
	local brush_valid = Draw:brush(Color.green:with_alpha(0.5),5)
	local brush_invalid = Draw:brush(Color.red:with_alpha(0.5),5)
	local function debugdraw(from,to,valid)
		if not debug_draw then
			return 
		end
		local brush = valid and brush_valid or brush_invalid
		brush:line(from,to)
		brush:sphere(to,10)
	end
	
	-- replaced placement checks from the location of the bipod itself to player's camera position.
	-- as cool as vanilla's concept is, it could potentialy make bipod experience (especially with custom weapons) not as predictable/reliable as it should be
	local yaw = player:m_head_rot():yaw()
	
	local x = math.sin(-yaw % 360) * self.forward_distance
	local y = math.cos(-yaw % 360) * self.forward_distance
	local from = player:m_head_pos() + Vector3(x,y,self.biopd_z_offset)
	
	-- ray to the left, roughly at 45 degree angle
	to = from + Vector3(self.ray_distance * math.sin((270 + yaw) % 360),-self.ray_distance * math.cos((270 + yaw) % 360),-self.vertical_distance)
	local ray_left = self._unit:raycast(from,to) or {}
	local left_valid = ray_left.distance and ray_left.distance > 5 and ray_left.distance < self.max_angled_distance
	debugdraw(from,to,left_valid)
	
	-- ray directly to the left at 90 degree angle
	to = from + Vector3(self.ray_distance * math.sin((270 + yaw) % 360),-self.ray_distance * math.cos((270 + yaw) % 360),0)
	local ray_left_flat = self._unit:raycast(from,to) or {}
	local left_flat_valid = ray_left_flat.distance and ray_left_flat.distance > 1 and ray_left_flat.distance < self.max_flat_distance
	debugdraw(from,to,left_flat_valid)
	
	if left_valid and left_flat_valid then 
		if debug_draw then
			brush_valid:sphere(from,5)
		end
		self._bipod_lean_type = "left_lean"
		return true, "left_lean"
	end
	
	-- ray to the right, roughly at 45 degree angle
	to = from + Vector3(self.ray_distance * math.sin((90 + yaw) % 360),-self.ray_distance * math.cos((90 + yaw) % 360),-self.vertical_distance)
	local ray_right = self._unit:raycast(from,to) or {}
	local right_valid = ray_right.distance and ray_right.distance > 5 and ray_right.distance < self.max_angled_distance
	debugdraw(from,to,right_valid)
	
	-- ray directly to the right at 90 degree angle
	to = from + Vector3(self.ray_distance * math.sin((90 + yaw) % 360),-self.ray_distance * math.cos((90 + yaw) % 360),0)
	local ray_right_flat = self._unit:raycast(from,to) or {}
	local right_flat_valid = ray_right_flat.distance and ray_right_flat.distance > 1 and ray_right_flat.distance < self.max_flat_distance
	debugdraw(from,to,right_flat_valid)
	
	if right_valid and right_flat_valid then 
		if debug_draw then
			brush_valid:sphere(from,5)
		end
		self._bipod_lean_type = "right_lean"
		return true, "right_lean"
	end
	
	-- 2 45 degree rays, similar to vanilla but does not require centre
	if left_valid and right_valid then 
		if debug_draw then
			brush_valid:sphere(from,5)
		end
		self._bipod_lean_type = "angled"
		return true, "angled"
	end
	
	-- vertical ray
	local to = from + Vector3(0,0,-self.vertical_distance)
	local ray_down = self._unit:raycast(from,to) or {}
	local down_valid = ray_down.distance and ray_down.distance > 5
	debugdraw(from,to,down_valid)
	
	if down_valid then 
		if debug_draw then
			brush_valid:sphere(from,5)
		end
		self._bipod_lean_type = "centred"
		return true, "centred"
	end
	
	if debug_draw then 
		brush_invalid:sphere(from,5)
	end
	return false
	
end)

Hooks:OverrideFunction(WeaponLionGadget1, "is_usable", function (self)
	if not self._bipod_lean_type then
		log("[Gilza] WeaponLionGadget1:is_usable - no _bipod_type!")
		return nil
	end
	
	local yaw = managers.player:local_player():movement():m_head_rot():yaw()
	local x = math.sin(-yaw % 360) * self.forward_distance
	local y = math.cos(-yaw % 360) * self.forward_distance
	local from = managers.player:local_player():movement():m_head_pos() + Vector3(x,y,self.biopd_z_offset)
	
	if self._bipod_lean_type == "crouched" then
		if self._bipod_entry_type == "entry_automatic" then
			if managers.player:local_player():movement():current_state():ducking() and (math.abs((managers.player:player_unit():camera():camera_unit():base()._camera_properties.spin + 180 - self._entry_camera_centre_spin) % 360 - 180) < 50) and (math.abs(managers.player:player_unit():camera():camera_unit():base()._camera_properties.pitch - self._entry_camera_centre_pitch) < 25) then
				return true
			else
				self._bipod_lean_type = nil
				return nil
			end
		else
			if managers.player:local_player():movement():current_state():ducking() then
				return true
			else
				self._bipod_lean_type = nil
				return nil
			end
		end
	end
	
	if self._bipod_entry_type == "entry_automatic" then
	
		if self._bipod_lean_type == "right_lean" then
			
			local within_angle_limit = math.abs((managers.player:player_unit():camera():camera_unit():base()._camera_properties.spin + 180 - self._entry_camera_centre_spin) % 360 - 180) < 20 and (math.abs(managers.player:player_unit():camera():camera_unit():base()._camera_properties.pitch - self._entry_camera_centre_pitch) < 10)
			if within_angle_limit then
				return true
			end
			
			local to = from + Vector3(self.ray_distance * math.sin((90 + yaw) % 360),-self.ray_distance * math.cos((90 + yaw) % 360),-self.vertical_distance)
			local ray_right = self._unit:raycast(from,to) or {}
			local right_valid = ray_right.distance and ray_right.distance > 5 and ray_right.distance < self.max_angled_distance
			
			to = from + Vector3(self.ray_distance * math.sin((90 + yaw) % 360),-self.ray_distance * math.cos((90 + yaw) % 360),0)
			local ray_right_flat = self._unit:raycast(from,to) or {}
			local right_flat_valid = ray_right_flat.distance and ray_right_flat.distance > 1 and ray_right_flat.distance < self.max_flat_distance
			
			if right_valid and right_flat_valid then
				return true
			else
				self._bipod_lean_type = nil
				return nil
			end
			
		elseif self._bipod_lean_type == "left_lean" then
			
			local within_angle_limit = math.abs((managers.player:player_unit():camera():camera_unit():base()._camera_properties.spin + 180 - self._entry_camera_centre_spin) % 360 - 180) < 20 and (math.abs(managers.player:player_unit():camera():camera_unit():base()._camera_properties.pitch - self._entry_camera_centre_pitch) < 10)
			if within_angle_limit then
				return true
			end
			
			local to = from + Vector3(self.ray_distance * math.sin((270 + yaw) % 360),-self.ray_distance * math.cos((270 + yaw) % 360),-self.vertical_distance)
			local ray_left = self._unit:raycast(from,to) or {}
			local left_valid = ray_left.distance and ray_left.distance > 5 and ray_left.distance < self.max_angled_distance
			
			to = from + Vector3(self.ray_distance * math.sin((270 + yaw) % 360),-self.ray_distance * math.cos((270 + yaw) % 360),0)
			local ray_left_flat = self._unit:raycast(from,to) or {}
			local left_flat_valid = ray_left_flat.distance and ray_left_flat.distance > 1 and ray_left_flat.distance < self.max_flat_distance
			
			if left_valid and left_flat_valid then
				return true
			else
				self._bipod_lean_type = nil
				return nil
			end
			
		elseif self._bipod_lean_type == "angled" or self._bipod_lean_type == "centred" then
			
			local to = from + Vector3(0,0,-self.vertical_distance)
			local ray_down = self._unit:raycast(from,to) or {}
			local down_valid = ray_down.distance and ray_down.distance > 5
			local within_angle_limit = math.abs((managers.player:player_unit():camera():camera_unit():base()._camera_properties.spin + 180 - self._entry_camera_centre_spin) % 360 - 180) < 45 and (math.abs(managers.player:player_unit():camera():camera_unit():base()._camera_properties.pitch - self._entry_camera_centre_pitch) < 20)
			
			if down_valid and within_angle_limit then
				return true
			end

			to = from + Vector3(self.ray_distance * math.sin((270 + yaw) % 360),-self.ray_distance * math.cos((270 + yaw) % 360),-self.vertical_distance)
			local ray_left = self._unit:raycast(from,to) or {}
			local left_valid = ray_left.distance and ray_left.distance > 5 and ray_left.distance < self.max_angled_distance
			
			to = from + Vector3(self.ray_distance * math.sin((90 + yaw) % 360),-self.ray_distance * math.cos((90 + yaw) % 360),-self.vertical_distance)
			local ray_right = self._unit:raycast(from,to) or {}
			local right_valid = ray_right.distance and ray_right.distance > 5 and ray_right.distance < self.max_angled_distance
			
			if left_valid and right_valid and within_angle_limit then 
				return true
			else
				self._bipod_lean_type = nil
				return nil
			end
		else
			log("[Gilza] Exited automatically placed bipod because _bipod_lean_type was not recognized: "..tostring(self._bipod_lean_type))
			self._bipod_lean_type = nil
			return nil
		end
	
	else
		-- in case of allowed manual entry, bipod should always stay, unless player starts to move or something, and such cases are handled by different funcs
		return true
	end
	
end)