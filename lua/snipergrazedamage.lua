-- newnew graze rework
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
	
	local expansion_level = 1
	local graze_expansions_start = 0
	local upgrade_value = managers.player:upgrade_value("snp", "graze_damage")
	local expansionl_range_per_lvl = upgrade_value.range_per_lvl
	local radius_base = upgrade_value.base_radius
	local radius_per_expansion = upgrade_value.radius_per_expansion
	local max_expansions = upgrade_value.max_expansions
	local level_dmg_decrease = upgrade_value.lvl_dmg_decrease
	
	-- initial thickened raycast
	local hits = World:raycast_all("ray", from, mvec_to, "sphere_cast_radius", radius_base, "disable_inner_ray", "slot_mask", managers.slot:get_mask("enemies"))
	
	-- start expansions after first target hit
	local closest_target = 99999999
	for i, hit in ipairs(hits) do
		if hit.unit and alive(hit.unit) and hit.unit:character_damage() then
			if hit.distance < closest_target then
				closest_target = hit.distance
			end
		end
	end
	if closest_target ~= 99999999 then
		graze_expansions_start = closest_target
	end
	
	-- lvl 1
	local should_increase_expansion = false
	for i, hit in ipairs(hits) do
		if hit.unit and alive(hit.unit) and hit.unit:character_damage() then
			if hit.distance < (expansionl_range_per_lvl + graze_expansions_start) and hit.distance > graze_expansions_start and not enemies_to_hit[hit.unit] then
				enemies_to_hit[hit.unit] = {data = hit, level = expansion_level}
				should_increase_expansion = true
			end
		end
	end
	
	-- lvl 2+
	while max_expansions ~= 0 do
		max_expansions = max_expansions - 1
		if should_increase_expansion then
			should_increase_expansion = false
			expansion_level = expansion_level + 1
			
			hits = World:raycast_all("ray", from, mvec_to, "sphere_cast_radius", radius_base + expansion_level * radius_per_expansion, "disable_inner_ray", "slot_mask", managers.slot:get_mask("enemies"))
			for i, hit in ipairs(hits) do
				if hit.unit and alive(hit.unit) and hit.unit:character_damage() then
					if hit.distance < (expansionl_range_per_lvl * expansion_level + graze_expansions_start) and hit.distance > graze_expansions_start and not enemies_to_hit[hit.unit] then
						enemies_to_hit[hit.unit] = {data = hit, level = expansion_level}
						should_increase_expansion = true
					end
				end
			end
		end
	end
	
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
					enemies_to_hit[hit.unit] = nil
					-- get damage from initial raycast to account for dmg skills
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
			local damage_health_ratio = managers.player:get_damage_health_ratio(health_ratio, weap_base:weapon_tweak_data().categories[1])
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
				for enemy, data in pairs(enemies_to_hit) do
					if enemy then
						crit_indicator = true
						break
					end
				end
				dmg_mul = dmg_mul * 2.25
			end
		end
		base_graze_dmg = weap_base:_get_current_damage(dmg_mul)
	end
	
	local shown_hitmarker = false
	for enemy, data in pairs(enemies_to_hit) do
		local actual_dmg = weap_base:get_damage_falloff(base_graze_dmg, {distance = data.data.distance}, managers.player:player_unit())
		local char_dmg = enemy:character_damage()
		local function is_dmg_allowed()
			if not char_dmg then
				return false
			end
			if char_dmg.is_civilian(enemy:base()._tweak_table) then
				return false
			end
			if (enemy:base()._tweak_table == "shield" or enemy:base()._tweak_table == "marshal_shield" or enemy:base()._tweak_table == "phalanx_minion" or enemy:base()._tweak_table == "phalanx_vip") and not weap_base:can_shoot_through_shield() then
				return false
			end
			return true
		end
		if is_dmg_allowed() then
			if not shown_hitmarker then
				shown_hitmarker = true
				if crit_indicator then
					managers.hud:on_crit_confirmed(1)
				else
					managers.hud:on_hit_confirmed(1)
				end
			end
			actual_dmg = char_dmg:_apply_damage_reduction(actual_dmg)
			char_dmg:damage_simple({
				variant = "graze",
				damage = (1 - data.level * level_dmg_decrease) * actual_dmg,
				attacker_unit = managers.player:player_unit(),
				weapon_unit = weapon_unit,
				pos = data.data.position,
				attack_dir = -data.data.normal
			})
		end
	end
	
end)