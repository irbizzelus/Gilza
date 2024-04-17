-- new version of graze
Hooks:OverrideFunction(SniperGrazeDamage, "on_weapon_fired", function (self, weapon_unit, result)
	if not alive(weapon_unit) then
		return
	end

	if not weapon_unit:base():is_category("snp") then
		return
	end

	if weapon_unit ~= managers.player:equipped_weapon_unit() then
		return
	end

	if not result.hit_enemy then
		return
	end

	if not result.rays then
		return
	end
	
	local furthest_hit = result.rays[#result.rays]
	local upgrade_value = managers.player:upgrade_value("snp", "graze_damage")
	local enemies_hit = {}
	local best_damage = 0
	local sentry_mask = managers.slot:get_mask("sentry_gun")
	local ally_mask = managers.slot:get_mask("all_criminals")
	-- new requirment
	local max_distance = 0

	for i, hit in ipairs(result.rays) do
		if alive(hit.unit) then
			local is_turret = hit.unit:in_slot(sentry_mask)
			local is_ally = hit.unit:in_slot(ally_mask)
			local is_valid_hit = hit.damage_result and hit.damage_result.attack_data and true or false
			
			if not is_turret and not is_ally and is_valid_hit then
				local result = hit.damage_result
				local attack_data = result.attack_data
				-- if hit a headshot, reduce raw damage to it's pre-headshot value
				if attack_data.headshot then
					attack_data.raw_damage = attack_data.raw_damage / hit.unit:base():char_tweak().headshot_dmg_mul
				end
				local damage_mul = upgrade_value.damage_factor
				-- use raw_damage instead of whatever damage we dealt to the enemy, so that hitting low hp targets is not worse then hitting dozers
				local damage = attack_data.raw_damage * damage_mul
				
				if best_damage < damage then
					best_damage = damage
				end
				
				-- check for max distance of the longest enemy collision ray so that graze doesnt activate if hitting targets too close to player
				if max_distance < hit.distance then
					max_distance = hit.distance
				end

				enemies_hit[hit.unit:key()] = true
			end
		end
	end

	if best_damage == 0 then
		return
	end
	
	-- maximum distance check ~7.5 meters
	if max_distance < 750 then
		return
	end

	local radius = upgrade_value.radius
	local from = mvector3.copy(furthest_hit.position)
	local stopped_by_geometry = furthest_hit.unit:in_slot(managers.slot:get_mask("world_geometry"))
	local distance = stopped_by_geometry and furthest_hit.distance - radius * 2 or weapon_unit:base():weapon_range() - radius

	mvector3.add_scaled(from, furthest_hit.ray, -furthest_hit.distance)
	mvector3.add_scaled(from, furthest_hit.ray, radius)

	local to = mvector3.copy(from)

	mvector3.add_scaled(to, furthest_hit.ray, distance)

	local hits = World:raycast_all("ray", from, to, "sphere_cast_radius", radius, "disable_inner_ray", "slot_mask", managers.slot:get_mask("enemies"))

	for i, hit in ipairs(hits) do
		local key = hit.unit:key()

		if not enemies_hit[key] then
			hits[key] = hits[key] or hit
		end

		hits[i] = nil
	end

	for _, hit in pairs(hits) do
		hit.unit:character_damage():damage_simple({
			variant = "graze",
			damage = best_damage,
			attacker_unit = managers.player:player_unit(),
			weapon_unit = weapon_unit,
			pos = hit.position,
			attack_dir = -hit.normal
		})
	end
end)