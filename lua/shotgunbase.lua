-- add ammo breaching property to the weapon
Hooks:PostHook(ShotgunBase, "_update_stats_values", "Gilza_addBreachRoundToShotgun", function(self, params)
	self._can_breach = self._can_breach or false
	self._is_buckshot = self._is_buckshot or false
	if self._ammo_data then
		if self._ammo_data.can_breach then
			self._can_breach = self._ammo_data.can_breach
		end
		if self._ammo_data.is_buckshot then
			self._is_buckshot = self._ammo_data.is_buckshot
		end
	end
end)

-- if weapon can breach, open locks. Also keep track of our shotgun's shot number, we need it for new shotgun damage calculations, because copDamage doesnt know if shotgun collision rays belong to the same trigger pull
Hooks:PreHook(ShotgunBase, "_fire_raycast", "Gilza_shotgunShotCountAndLockerCheck", function(self, user_unit, from_pos, direction, dmg_mul, shoot_player, spread_mul, autohit_mul, suppr_mul, shoot_through_data)
	
	if self:is_category("shotgun") or self:is_category("grenade_launcher") then
		
		Gilza.current_shotgun_shot_id = Gilza.current_shotgun_shot_id + 1
		
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
		
	end
	
end)