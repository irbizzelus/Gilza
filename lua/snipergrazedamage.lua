-- newnewnew graze rework
Hooks:OverrideFunction(SniperGrazeDamage, "on_weapon_fired", function (self, weapon_unit, result)
	
	if not alive(weapon_unit) then
		return
	end
	
	local weap_base = weapon_unit:base()
	
	-- allow semi AR's and smg
	if not weap_base:is_category("snp") then
		if weap_base:is_category("assault_rifle") or weap_base:is_category("smg") then
			local semi_auto = weap_base._fire_mode == Idstring("single")
			if not semi_auto then
				return
			end
		else
			return
		end
	end

	if weapon_unit ~= managers.player:equipped_weapon_unit() then
		return
	end

	if not result.rays then
		return
	end
	
	local enemies_to_hit = {}
	local sentry_mask = managers.slot:get_mask("sentry_gun")
	local ally_mask = managers.slot:get_mask("all_criminals")
	local pl_state = managers.player:player_unit():movement():current_state()
	local from = pl_state:get_fire_weapon_position()
	local direction = pl_state:get_fire_weapon_direction()
	local ray_distance = weap_base:weapon_range()
	local mvec_to = Vector3()
	mvector3.set(mvec_to, direction)
	mvector3.multiply(mvec_to, ray_distance)
	mvector3.add(mvec_to, from)
	
	local upgrade_value = managers.player:upgrade_value("snp", "graze_damage")
	local radius_base = upgrade_value.base_radius
	local max_exp_range = upgrade_value.max_expansion_range
	local radius_per_expansion = upgrade_value.radius_gain_per_expansion
	local level_dmg_decrease = upgrade_value.damage_loss_per_expansion
	local dmg_floor_mul = upgrade_value.damage_loss_floor
	local expansion_level = 0
	
	-- deal with the intital shot targets and the damage graze is going to start with
	local initialy_hit_targets = {}
	local crit_indicator = false
	local base_graze_dmg = 1
	if result.hit_enemy then
		for i, hit in ipairs(result.rays) do
			if alive(hit.unit) then
				local is_turret = hit.unit:in_slot(sentry_mask)
				local is_ally = hit.unit:in_slot(ally_mask)
				local is_valid_hit = hit.damage_result and hit.damage_result.attack_data and true or false
				if not is_turret and not is_ally and is_valid_hit then
					-- prevent graze damage to unit(s) shot by the weapon during initial raycast
					table.insert(initialy_hit_targets, hit.unit)
					-- get highest damage from initial raycast to account for dmg skills and falloff
					local result = hit.damage_result
					local attack_data = result.attack_data
					if attack_data.raw_damage then
						if attack_data.headshot then -- but not headshots
							attack_data.raw_damage = attack_data.raw_damage / hit.unit:base():char_tweak().headshot_dmg_mul
						end
						if attack_data.raw_damage > base_graze_dmg then
							base_graze_dmg = attack_data.raw_damage
						end
					end
				end
			end
		end
	else
		-- get weapon dmg if no enemies were hit by initial raycast
		local dmg_mul = 1
		if not weap_base:weapon_tweak_data().ignore_damage_multipliers then
			dmg_mul = dmg_mul * managers.player:temporary_upgrade_value("temporary", "dmg_multiplier_outnumbered", 1)
			if managers.player:has_category_upgrade("player", "overkill_all_weapons") or weap_base:is_category("shotgun", "saw") then
				dmg_mul = dmg_mul * managers.player:temporary_upgrade_value("temporary", "overkill_damage_multiplier", 1)
			end
			local health_ratio = pl_state._ext_damage:health_ratio()
			local damage_health_ratio = managers.player:get_damage_health_ratio(health_ratio, weap_base:categories()[1])
			if damage_health_ratio > 0 then
				local upgrade_name = weap_base:is_category("saw") and "melee_damage_health_ratio_multiplier" or "damage_health_ratio_multiplier"
				local damage_ratio = damage_health_ratio
				dmg_mul = dmg_mul * (1 + managers.player:upgrade_value("player", upgrade_name, 0) * damage_ratio)
			end
			if managers.player:has_category_upgrade("temporary", "new_berserk_weapon_damage_multiplier") then
				dmg_mul = dmg_mul * managers.player:temporary_upgrade_value("temporary", "new_berserk_weapon_damage_multiplier", 1)
			end
			dmg_mul = dmg_mul * managers.player:temporary_upgrade_value("temporary", "berserker_damage_multiplier", 1)
			-- simulate crit
			local critical_hit = false
			local rolled_crit = managers.player:critical_hit_chance()
			if rolled_crit > 0 then
				local critical_roll = math.rand(1)
				critical_hit = critical_roll < rolled_crit
			end
			if critical_hit then
				crit_indicator = true
				dmg_mul = dmg_mul * 2.25
			end
		end
		base_graze_dmg = weap_base:_get_current_damage(dmg_mul)
	end
	
	-- local function debugdraw(from,to,radius)
		-- local brush = Draw:brush(Color.red:with_alpha(0.5),8)
		-- brush:cylinder(from, to, radius, 24)
	-- end
	
	-- check if target should take graze damage
	local ignored_targets = {}
	local function is_target_dmg_allowed(unit, char_dmg)
		if ignored_targets[unit] then
			return false
		end
		if not char_dmg then
			ignored_targets[unit] = true
			return false
		end
		if char_dmg.is_civilian(unit:base()._tweak_table) then
			ignored_targets[unit] = true
			return false
		end
		if char_dmg._immortal or char_dmg._invulnerable then
			ignored_targets[unit] = true
			return false
		end
		if table.contains(initialy_hit_targets, unit) then
			ignored_targets[unit] = true
			return false
		end
		if not weap_base:can_shoot_through_wall() then -- cursed weapon wall pen check
			local vec_to = Vector3(unit:position().x, unit:position().y, unit:position().z + 100)
			local hits = World:raycast_all("ray", pl_state:get_fire_weapon_position(), vec_to, "sphere_cast_radius", 1, "disable_inner_ray", "slot_mask", managers.slot:get_mask("enemies","world_geometry"))
			local dist_to_target, dist_to_wall = 9999999999, 9999999999
			for i, hit in ipairs(hits) do
				if hit.unit and alive(hit.unit) then
					if hit.unit == unit then
						dist_to_target = hit.distance
					elseif hit.unit:in_slot(managers.slot:get_mask("world_geometry")) then
						dist_to_wall = hit.distance
					end
				end
			end
			if dist_to_wall < dist_to_target then
				ignored_targets[unit] = true
				return false
			end
		else -- prevent pen through thick walls
			local hits = World:raycast_wall("ray", pl_state:get_fire_weapon_position(), Vector3(unit:position().x, unit:position().y, unit:position().z + 100), "slot_mask", managers.slot:get_mask("bullet_impact_targets"), "ignore_unit", initialy_hit_targets, "thickness", 40, "thickness_mask", managers.slot:get_mask("world_geometry"))
			local should_hit = false
			for i, hit in ipairs(hits) do
				if hit.unit and alive(hit.unit) and hit.unit == unit then
					should_hit = true
				end
			end
			if not should_hit then
				return false
			end
		end
		if (unit:base()._tweak_table == "shield" or unit:base()._tweak_table == "marshal_shield" or unit:base()._tweak_table == "phalanx_minion" or unit:base()._tweak_table == "phalanx_vip") and not weap_base:can_shoot_through_shield() then
			ignored_targets[unit] = true
			return false
		end
		return true
	end
	
	-- initial thickened raycast
	local hits = World:raycast_all("ray", from, mvec_to, "sphere_cast_radius", radius_base, "disable_inner_ray", "slot_mask", managers.slot:get_mask("enemies"))
	local last_hit_unit_data
	
	-- start expansions at first hit target's position
	local closest_target = 999999999999
	for i, hit in ipairs(hits) do
		if hit.unit and alive(hit.unit) and hit.unit.character_damage and not enemies_to_hit[hit.unit] and is_target_dmg_allowed(hit.unit, hit.unit:character_damage()) then
			if hit.distance < closest_target then
				closest_target = hit.distance
				last_hit_unit_data = hit
			end
		end
	end
	
	-- no hits no graze
	if closest_target == 999999999999 then
		return
	end
	
	enemies_to_hit[last_hit_unit_data.unit] = {data = last_hit_unit_data, level = expansion_level}
	
	local should_stop_expansions = false
	while not should_stop_expansions do
		
		expansion_level = expansion_level + 1
		closest_target = 999999999999
		from = last_hit_unit_data.unit:position()
		from = Vector3(from.x, from.y, from.z + 100) -- not at feet/head level please
		local late_hits = World:raycast_all("ray", from, mvec_to, "sphere_cast_radius", radius_base + expansion_level * radius_per_expansion, "disable_inner_ray", "slot_mask", managers.slot:get_mask("enemies"))
		
		for i, hit in ipairs(late_hits) do
			if hit.unit and alive(hit.unit) and hit.unit.character_damage and not enemies_to_hit[hit.unit] and is_target_dmg_allowed(hit.unit, hit.unit:character_damage()) then
				if hit.distance < closest_target and not (hit.distance > max_exp_range) then
					closest_target = hit.distance
					last_hit_unit_data = hit
				end
			end
		end
		
		if closest_target == 999999999999 then
			should_stop_expansions = true
		else
			enemies_to_hit[last_hit_unit_data.unit] = {data = last_hit_unit_data, level = expansion_level}
		end
		
	end
	
	if next(enemies_to_hit) ~= nil then
		for enemy, data in pairs(enemies_to_hit) do
			local dist_from_player = mvector3.distance(pl_state:get_fire_weapon_position(), enemy:position())
			local actual_dmg = weap_base:get_damage_falloff(base_graze_dmg, {distance = dist_from_player}, managers.player:player_unit())
			local char_dmg = enemy:character_damage()
			
			actual_dmg = char_dmg:_apply_damage_reduction(actual_dmg)
			local dmg_mul = 1 - (data.level * level_dmg_decrease)
			if dmg_mul < dmg_floor_mul then
				dmg_mul = dmg_floor_mul
			end
			char_dmg:damage_simple({
				variant = "graze",
				damage = dmg_mul * actual_dmg,
				attacker_unit = managers.player:player_unit(),
				weapon_unit = weapon_unit,
				pos = data.data.position,
				attack_dir = -data.data.normal
			})
		end
		
		if not result.hit_enemy then
			if crit_indicator then
				managers.hud:on_crit_confirmed(1)
			else
				managers.hud:on_hit_confirmed(1)
			end
		end
	end
	
end)