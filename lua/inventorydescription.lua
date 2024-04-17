local function is_weapon_category(weapon_tweak, ...)
	local arg = {
		...
	}
	local categories = weapon_tweak.categories

	for i = 1, #arg do
		if table.contains(categories, arg[i]) then
			return true
		end
	end

	return false
end
local color_ranges = {}
local func_hex_color = InventoryDescription._create_hex_color
local func_color_text = InventoryDescription._add_color_to_text
local func_add_lb = InventoryDescription._add_line_break
local func_create_list = InventoryDescription._create_list
local backup_tweak_data = {}
local function override_tweak_data(weapon_id, blueprint)
	backup_tweak_data[weapon_id] = backup_tweak_data[weapon_id] or tweak_data.weapon[weapon_id]
	tweak_data.weapon[weapon_id] = managers.weapon_factory:get_weapon_tweak_data_override(weapon_id, managers.weapon_factory:get_factory_id_by_weapon_id(weapon_id), blueprint)
end
local function restore_tweak_data(weapon_id)
	tweak_data.weapon[weapon_id] = backup_tweak_data[weapon_id] or tweak_data.weapon[weapon_id]
end

-- update total ammo amount if we have brawler deck equipeed in blackmarket UI; @32 and 90
Hooks:OverrideFunction(WeaponDescription, "get_weapon_ammo_info", function (weapon_id, extra_ammo, total_ammo_mod)
	local weapon_tweak_data = tweak_data.weapon[weapon_id]
	local ammo_max_multiplier = managers.player:upgrade_value("player", "extra_ammo_multiplier", 1) * managers.player:upgrade_value("player", "extra_ammo_cut", 1)
	local primary_category = weapon_tweak_data.categories[1]
	local category_skill_in_effect = false
	local category_multiplier = 1

	for _, category in ipairs(weapon_tweak_data.categories) do
		if managers.player:has_category_upgrade(category, "extra_ammo_multiplier") then
			category_multiplier = category_multiplier + managers.player:upgrade_value(category, "extra_ammo_multiplier", 1) - 1
			category_skill_in_effect = true
		end
	end

	ammo_max_multiplier = ammo_max_multiplier * category_multiplier

	if managers.player:has_category_upgrade("player", "add_armor_stat_skill_ammo_mul") then
		ammo_max_multiplier = ammo_max_multiplier * managers.player:body_armor_value("skill_ammo_mul", nil, 1)
	end

	local function get_ammo_max_per_clip(weapon_id)
		local function upgrade_blocked(category, upgrade)
			if not weapon_tweak_data.upgrade_blocks then
				return false
			end

			if not weapon_tweak_data.upgrade_blocks[category] then
				return false
			end

			return table.contains(weapon_tweak_data.upgrade_blocks[category], upgrade)
		end

		local clip_base = weapon_tweak_data.CLIP_AMMO_MAX
		local clip_mod = extra_ammo and tweak_data.weapon.stats.extra_ammo[extra_ammo] or 0
		local clip_skill = managers.player:upgrade_value(weapon_id, "clip_ammo_increase")

		if not upgrade_blocked("weapon", "clip_ammo_increase") then
			clip_skill = clip_skill + managers.player:upgrade_value("weapon", "clip_ammo_increase", 0)
		end

		for _, category in ipairs(weapon_tweak_data.categories) do
			if not upgrade_blocked(category, "clip_ammo_increase") then
				clip_skill = clip_skill + managers.player:upgrade_value(category, "clip_ammo_increase", 0)
			end
		end

		return clip_base + clip_mod + clip_skill
	end

	local ammo_max_per_clip = get_ammo_max_per_clip(weapon_id)
	local ammo_max = tweak_data.weapon[weapon_id].AMMO_MAX
	local ammo_from_mods = ammo_max * (total_ammo_mod and tweak_data.weapon.stats.total_ammo_mod[total_ammo_mod] or 0)
	ammo_max = (ammo_max + ammo_from_mods + managers.player:upgrade_value(weapon_id, "clip_amount_increase") * ammo_max_per_clip) * ammo_max_multiplier
	ammo_max_per_clip = math.min(ammo_max_per_clip, ammo_max)
	local ammo_data = {
		base = tweak_data.weapon[weapon_id].AMMO_MAX,
		mod = ammo_from_mods + managers.player:upgrade_value(weapon_id, "clip_amount_increase") * ammo_max_per_clip
	}
	ammo_data.skill = (ammo_data.base + ammo_data.mod) * ammo_max_multiplier - ammo_data.base - ammo_data.mod
	ammo_data.skill_in_effect = managers.player:has_category_upgrade("player", "extra_ammo_multiplier") or category_skill_in_effect or managers.player:has_category_upgrade("player", "add_armor_stat_skill_ammo_mul") or managers.player:has_category_upgrade("player", "extra_ammo_cut")
	
	return ammo_max_per_clip, ammo_max, ammo_data
end)

-- blackmarket GUI yet again. this one is changed so that faster reload with new akimbo skill would work/show up in stats. also the overkill reload buff is here; @171-195
Hooks:OverrideFunction(WeaponDescription, "_get_skill_stats", function (name, category, slot, base_stats, mods_stats, silencer, single_mod, auto_mod, blueprint)
	-- due to weapon lib changes, and our need to keep hooks for this function by using hooksoverride, we will have to add weaponlib's code in here,
	-- local function 'original_skill_stats' is pretty much the function itself, everything around it is weaponlib's stuff
	override_tweak_data(name, blueprint)
	local function original_skill_stats()
		local skill_stats = {}
		local tweak_stats = tweak_data.weapon.stats

		for _, stat in pairs(WeaponDescription._stats_shown) do
			skill_stats[stat.name] = {
				value = 0
			}
		end

		local detection_risk = 0

		if category then
			local custom_data = {
				[category] = managers.blackmarket:get_crafted_category_slot(category, slot)
			}
			detection_risk = managers.blackmarket:get_suspicion_offset_from_custom_data(custom_data, tweak_data.player.SUSPICION_OFFSET_LERP or 0.75)
			detection_risk = detection_risk * 100
		end

		local base_value, base_index, modifier, multiplier = nil
		local factory_id = managers.weapon_factory:get_factory_id_by_weapon_id(name)
		local weapon_tweak = tweak_data.weapon[name]
		local primary_category = weapon_tweak.categories[1]

		for _, stat in ipairs(WeaponDescription._stats_shown) do
			if weapon_tweak.stats[stat.stat_name or stat.name] or stat.name == "totalammo" or stat.name == "fire_rate" then
				if stat.name == "magazine" then
					skill_stats[stat.name].value = managers.player:upgrade_value(name, "clip_ammo_increase", 0)
					local has_magazine = weapon_tweak.has_magazine
					local add_modifier = false

					if is_weapon_category(weapon_tweak, "shotgun") and has_magazine then
						skill_stats[stat.name].value = skill_stats[stat.name].value + managers.player:upgrade_value("shotgun", "magazine_capacity_inc", 0)
						add_modifier = managers.player:has_category_upgrade("shotgun", "magazine_capacity_inc")

						if primary_category == "akimbo" then
							skill_stats[stat.name].value = skill_stats[stat.name].value * 2
						end
					elseif is_weapon_category(weapon_tweak, "pistol") and not is_weapon_category(weapon_tweak, "revolver") and managers.player:has_category_upgrade("pistol", "magazine_capacity_inc") then
						skill_stats[stat.name].value = skill_stats[stat.name].value + managers.player:upgrade_value("pistol", "magazine_capacity_inc", 0)

						if primary_category == "akimbo" then
							skill_stats[stat.name].value = skill_stats[stat.name].value * 2
						end

						add_modifier = true
					elseif is_weapon_category(weapon_tweak, "smg", "assault_rifle", "lmg") then
						skill_stats[stat.name].value = skill_stats[stat.name].value + managers.player:upgrade_value("player", "automatic_mag_increase", 0)
						add_modifier = managers.player:has_category_upgrade("player", "automatic_mag_increase")

						if primary_category == "akimbo" then
							skill_stats[stat.name].value = skill_stats[stat.name].value * 2
						end
					end

					if not weapon_tweak.upgrade_blocks or not weapon_tweak.upgrade_blocks.weapon or not table.contains(weapon_tweak.upgrade_blocks.weapon, "clip_ammo_increase") then
						skill_stats[stat.name].value = skill_stats[stat.name].value + managers.player:upgrade_value("weapon", "clip_ammo_increase", 0)
					end

					if not weapon_tweak.upgrade_blocks or not weapon_tweak.upgrade_blocks[primary_category] or not table.contains(weapon_tweak.upgrade_blocks[primary_category], "clip_ammo_increase") then
						skill_stats[stat.name].value = skill_stats[stat.name].value + managers.player:upgrade_value(primary_category, "clip_ammo_increase", 0)
					end

					skill_stats[stat.name].skill_in_effect = managers.player:has_category_upgrade(name, "clip_ammo_increase") or managers.player:has_category_upgrade("weapon", "clip_ammo_increase") or add_modifier
				elseif stat.name == "totalammo" then
					-- Nothing
				elseif stat.name == "reload" then
					local skill_in_effect = false
					local mult = 1
					
					local simplified_categories = {}
					for _, category in ipairs(weapon_tweak.categories) do
						if managers.player:has_category_upgrade(category, "reload_speed_multiplier") then
							mult = mult + 1 - managers.player:upgrade_value(category, "reload_speed_multiplier", 1)
							skill_in_effect = true
						end
						simplified_categories[category] = true
					end
					
					if simplified_categories.akimbo and managers.player:has_category_upgrade("akimbo", "pistol_improved_handling") then
						if simplified_categories.pistol or (simplified_categories.smg and managers.player:has_category_upgrade("akimbo", "allow_smg_improved_handling")) then
							local skill = managers.player:upgrade_value("akimbo", "pistol_improved_handling")
							if skill and type(skill) ~= "number" then
								mult = mult + 1 - skill.reload
							end	
						end
					end
					
					if managers.player:has_category_upgrade("temporary", "overkill_damage_multiplier") and managers.player:temporary_upgrade_value("temporary", "overkill_damage_multiplier", 1) > 1 then
						if managers.player:has_category_upgrade("player", "overkill_all_weapons") then
							mult = mult - 0.5
						elseif simplified_categories.shotgun or simplified_categories.saw then
							mult = mult - 0.5
						end
					end

					mult = 1 / managers.blackmarket:_convert_add_to_mul(mult)
					local diff = base_stats[stat.name].value * mult - base_stats[stat.name].value
					skill_stats[stat.name].value = skill_stats[stat.name].value + diff
					skill_stats[stat.name].skill_in_effect = skill_in_effect
				else
					base_value = math.max(base_stats[stat.name].value + mods_stats[stat.name].value, 0)

					if base_stats[stat.name].index and mods_stats[stat.name].index then
						base_index = base_stats[stat.name].index + mods_stats[stat.name].index
					end

					multiplier = 1
					modifier = 0
					local is_single_shot = managers.weapon_factory:has_perk("fire_mode_single", factory_id, blueprint)

					if stat.name == "damage" then
						multiplier = managers.blackmarket:damage_multiplier(name, weapon_tweak.categories, silencer, detection_risk, nil, blueprint)
						modifier = math.floor(managers.blackmarket:damage_addend(name, weapon_tweak.categories, silencer, detection_risk, nil, blueprint) * tweak_data.gui.stats_present_multiplier * multiplier)
					elseif stat.name == "spread" then
						local fire_mode = single_mod and "single" or auto_mod and "auto" or weapon_tweak.FIRE_MODE or "single"
						multiplier = managers.blackmarket:accuracy_multiplier(name, weapon_tweak.categories, silencer, nil, nil, fire_mode, blueprint, nil, is_single_shot)
						modifier = managers.blackmarket:accuracy_addend(name, weapon_tweak.categories, base_index, silencer, nil, fire_mode, blueprint, nil, is_single_shot) * tweak_data.gui.stats_present_multiplier
					elseif stat.name == "recoil" then
						multiplier = managers.blackmarket:recoil_multiplier(name, weapon_tweak.categories, silencer, blueprint)
						modifier = managers.blackmarket:recoil_addend(name, weapon_tweak.categories, base_index, silencer, blueprint, nil, is_single_shot) * tweak_data.gui.stats_present_multiplier
					elseif stat.name == "suppression" then
						multiplier = managers.blackmarket:threat_multiplier(name, weapon_tweak.categories, silencer)
					elseif stat.name == "concealment" then
						if silencer and managers.player:has_category_upgrade("player", "silencer_concealment_increase") then
							modifier = managers.player:upgrade_value("player", "silencer_concealment_increase", 0)
						end

						if silencer and managers.player:has_category_upgrade("player", "silencer_concealment_penalty_decrease") then
							local stats = managers.weapon_factory:get_perk_stats("silencer", factory_id, blueprint)

							if stats and stats.concealment then
								modifier = modifier + math.min(managers.player:upgrade_value("player", "silencer_concealment_penalty_decrease", 0), math.abs(stats.concealment))
							end
						end
					elseif stat.name == "fire_rate" then
						base_value = math.max(base_stats[stat.name].value, 0)

						if base_stats[stat.name].index then
							base_index = base_stats[stat.name].index
						end

						multiplier = managers.blackmarket:fire_rate_multiplier(name, weapon_tweak.categories, silencer, detection_risk, nil, blueprint)
					end

					if modifier ~= 0 then
						local offset = math.min(tweak_stats[stat.name][1], tweak_stats[stat.name][#tweak_stats[stat.name]]) * tweak_data.gui.stats_present_multiplier

						if stat.revert then
							modifier = -modifier
						end

						if stat.percent then
							local max_stat = stat.index and #tweak_stats[stat.name] or math.max(tweak_stats[stat.name][1], tweak_stats[stat.name][#tweak_stats[stat.name]]) * tweak_data.gui.stats_present_multiplier

							if stat.offset then
								max_stat = max_stat - offset
							end

							local ratio = modifier / max_stat
							modifier = ratio * 100
						end
					end

					if stat.revert then
						multiplier = 1 / math.max(multiplier, 0.01)
					end

					skill_stats[stat.name].skill_in_effect = multiplier ~= 1 or modifier ~= 0
					skill_stats[stat.name].value = modifier + base_value * multiplier - base_value
				end
			end
		end

		return skill_stats
	end
	local return_data = original_skill_stats()
	restore_tweak_data(name)
	return return_data
end)