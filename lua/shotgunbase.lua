Hooks:PostHook(ShotgunBase, "_update_stats_values", "breachroundaddition", function(self, params)
	self._can_breach = self._can_breach or false
	if self._ammo_data then
		if self._ammo_data.can_breach then
			self._can_breach = self._ammo_data.can_breach
		end
	end
end)

Hooks:PreHook(ShotgunBase, "_fire_raycast", "breakzelock", function(self, user_unit, from_pos, direction, dmg_mul, shoot_player, spread_mul, autohit_mul, suppr_mul, shoot_through_data)
	local lockbreak = nil
	local mvec_to = Vector3()
	local mvec_direction = Vector3()
	local mvec_spread_direction = Vector3()
	local spread_x, spread_y = self:_get_spread(user_unit)
	local right = direction:cross(Vector3(0, 0, 1)):normalized()
	local up = direction:cross(right):normalized()
	local damage = self:_get_current_damage(dmg_mul)

	mvector3.set(mvec_direction, direction)
	
	for i = 1, shoot_through_data and 1 or self._rays, 1 do

		local theta = math.random() * 360
		local ax = math.sin(theta) * math.random() * spread_x * (spread_mul or 1)
		local ay = math.cos(theta) * math.random() * spread_y * (spread_mul or 1)

		mvector3.set(mvec_spread_direction, mvec_direction)
		mvector3.add(mvec_spread_direction, right * math.rad(ax))
		mvector3.add(mvec_spread_direction, up * math.rad(ay))
		mvector3.set(mvec_to, mvec_spread_direction)
		mvector3.multiply(mvec_to, 20000)
		mvector3.add(mvec_to, from_pos)
	end
	
	if self._can_breach == true then
		lockbreak = World:raycast("ray", from_pos, mvec_to, "slot_mask", self._bullet_slotmask, "ignore_unit", self._setup.ignore_units, "ray_type", "body bullet lock")
		if lockbreak and lockbreak.unit and lockbreak.unit:damage() and lockbreak.body:extension() and lockbreak.body:extension().damage then
			damage = math.clamp(damage * 2, 0, 200)

			lockbreak.body:extension().damage:damage_lock(user_unit, lockbreak.normal, lockbreak.position, lockbreak.direction, damage)

			if lockbreak.unit:id() ~= -1 then
				managers.network:session():send_to_peers_synched("sync_body_damage_lock", lockbreak.body, damage)
			end
		end
	end
end)