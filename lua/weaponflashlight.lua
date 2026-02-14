Hooks:PostHook(WeaponFlashLight, "update", "Gilza_WeaponFlashLight_update_post", function(self, unit, t, dt)
	if not self._is_npc and not self:is_haunted() then
		self._light:set_spot_angle_end(58)
		self._light:set_far_range(900)
	end
end)

Hooks:PostHook(WeaponFlashLight, "init", "Gilza_WeaponFlashLight_init_post", function(self, unit)
	if not self._is_npc and not self:is_haunted() then
		WeaponFlashLight.EFFECT_OPACITY_MAX = 4
		self._light:set_spot_angle_end(58)
		self._light:set_far_range(900)
		self._light:set_multiplier(1.25)
		self._light_drop_off_2 = World:create_light("spot|specular|plane_projection", "units/lights/spot_light_projection_textures/spotprojection_11_flashlight_df")
		self._light_drop_off_2:set_spot_angle_end(58)
		self._light_drop_off_2:set_far_range(1600)
		self._light_drop_off_2:set_multiplier(0.75)
		self._light_drop_off_2:link(self._a_flashlight_obj)
		self._light_drop_off_2:set_rotation(Rotation(self._a_flashlight_obj:rotation():z(), -self._a_flashlight_obj:rotation():x(), -self._a_flashlight_obj:rotation():y()))
		self._light_drop_off_2:set_enable(false)
		self._light_drop_off_3 = World:create_light("spot|specular|plane_projection", "units/lights/spot_light_projection_textures/spotprojection_11_flashlight_df")
		self._light_drop_off_3:set_spot_angle_end(58)
		self._light_drop_off_3:set_far_range(2800)
		self._light_drop_off_3:set_multiplier(0.4)
		self._light_drop_off_3:link(self._a_flashlight_obj)
		self._light_drop_off_3:set_rotation(Rotation(self._a_flashlight_obj:rotation():z(), -self._a_flashlight_obj:rotation():x(), -self._a_flashlight_obj:rotation():y()))
		self._light_drop_off_3:set_enable(false)
		self._light_drop_off_4 = World:create_light("spot|specular|plane_projection", "units/lights/spot_light_projection_textures/spotprojection_11_flashlight_df")
		self._light_drop_off_4:set_spot_angle_end(58)
		self._light_drop_off_4:set_far_range(4000)
		self._light_drop_off_4:set_multiplier(0.2)
		self._light_drop_off_4:link(self._a_flashlight_obj)
		self._light_drop_off_4:set_rotation(Rotation(self._a_flashlight_obj:rotation():z(), -self._a_flashlight_obj:rotation():x(), -self._a_flashlight_obj:rotation():y()))
		self._light_drop_off_4:set_enable(false)
	end
end)

Hooks:PostHook(WeaponFlashLight, "_check_state", "Gilza_WeaponFlashLight_check_state_post", function(self, current_state)
	if not self._is_npc and not self:is_haunted() then
		if self._light_drop_off_2 then
			self._light_drop_off_2:set_enable(self._on)
		end
		if self._light_drop_off_3 then
			self._light_drop_off_3:set_enable(self._on)
		end
		if self._light_drop_off_4 then
			self._light_drop_off_4:set_enable(self._on)
		end
	end
end)

Hooks:PostHook(WeaponFlashLight, "destroy", "Gilza_WeaponFlashLight_destroy_post", function(self, unit)
	if alive(self._light_drop_off_2) then
		World:delete_light(self._light_drop_off_2)
	end
	if alive(self._light_drop_off_3) then
		World:delete_light(self._light_drop_off_3)
	end
	if alive(self._light_drop_off_4) then
		World:delete_light(self._light_drop_off_4)
	end
end)

Hooks:PostHook(WeaponFlashLight, "set_color", "Gilza_WeaponFlashLight_set_color_post", function(self, color)
	if self._is_npc then
		return
	end
	if self:is_haunted() then
		return
	end
	if not color then
		return
	end
	if self._light_drop_off_2 then
		self._light_drop_off_2:set_color(Vector3(color.r, color.g, color.b))
	end
	if self._light_drop_off_3 then
		self._light_drop_off_3:set_color(Vector3(color.r, color.g, color.b))
	end
	if self._light_drop_off_4 then
		self._light_drop_off_4:set_color(Vector3(color.r, color.g, color.b))
	end
end)