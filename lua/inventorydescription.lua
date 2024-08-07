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

-- update total ammo amount if we have brawler deck equipeed in blackmarket UI @50 and 92;
-- added ability to use float values with total_ammo_mod @90-91
-- fixed dumbass weapon max ammo overrides from weaponlib @83-88 and @94 and @98
Hooks:OverrideFunction(WeaponDescription, "get_weapon_ammo_info", function (weapon_id, extra_ammo, total_ammo_mod, is_override)
	local weapon_tweak_data = tweak_data.weapon[weapon_id]
	local ammo_max_multiplier = managers.player:upgrade_value("player", "extra_ammo_multiplier", 1)
	local primary_category = weapon_tweak_data.categories[1]
	local category_skill_in_effect = false
	local category_multiplier = 1

	for _, category in ipairs(weapon_tweak_data.categories) do
		if managers.player:has_category_upgrade(category, "extra_ammo_multiplier") then
			category_multiplier = category_multiplier + managers.player:upgrade_value(category, "extra_ammo_multiplier", 1) - 1
			category_skill_in_effect = true
		end
	end

	ammo_max_multiplier = (ammo_max_multiplier - 1) + category_multiplier

	if managers.player:has_category_upgrade("player", "add_armor_stat_skill_ammo_mul") then
		ammo_max_multiplier = ammo_max_multiplier * managers.player:body_armor_value("skill_ammo_mul", nil, 1)
	end
	
	ammo_max_multiplier = ammo_max_multiplier * managers.player:upgrade_value("player", "extra_ammo_cut", 1)

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
	local override_total_ammo = 0
	if is_override then
		local overriden_max_ammo = tweak_data.weapon[weapon_id].AMMO_MAX
		restore_tweak_data(weapon_id)
		override_total_ammo = overriden_max_ammo - tweak_data.weapon[weapon_id].AMMO_MAX
	end
	local ammo_max_per_clip = get_ammo_max_per_clip(weapon_id)
	local ammo_max = tweak_data.weapon[weapon_id].AMMO_MAX
	local new_total_ammo_mod = math.floor(total_ammo_mod * 1000 + 0.5)
	new_total_ammo_mod = new_total_ammo_mod / 1000
	local ammo_from_mods = ammo_max * (total_ammo_mod and tweak_data.weapon.stats.total_ammo_mod[new_total_ammo_mod] or 0)
	ammo_max = (ammo_max + ammo_from_mods + override_total_ammo + managers.player:upgrade_value(weapon_id, "clip_amount_increase") * ammo_max_per_clip) * ammo_max_multiplier
	ammo_max_per_clip = math.min(ammo_max_per_clip, ammo_max)
	local ammo_data = {
		base = tweak_data.weapon[weapon_id].AMMO_MAX,
		mod = ammo_from_mods + override_total_ammo + managers.player:upgrade_value(weapon_id, "clip_amount_increase") * ammo_max_per_clip
	}
	ammo_data.skill = (ammo_data.base + ammo_data.mod) * ammo_max_multiplier - ammo_data.base - ammo_data.mod
	ammo_data.skill_in_effect = managers.player:has_category_upgrade("player", "extra_ammo_multiplier") or category_skill_in_effect or managers.player:has_category_upgrade("player", "add_armor_stat_skill_ammo_mul") or managers.player:has_category_upgrade("player", "extra_ammo_cut")
	
	return ammo_max_per_clip, ammo_max, ammo_data
end)

-- blackmarket GUI yet again. this one is changed so that faster reload with new akimbo skill would work/show up in stats. also the overkill reload buff is here; @182-206
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
					
					if managers.player:has_category_upgrade("player", "speed_junkie_meter_boost_agility") then
						local counter = managers.player._Gilza_junkie_counter or 0
						local skill = managers.player:upgrade_value("player", "speed_junkie_meter_boost_agility")
						if skill and type(skill) ~= "number" then
							local mul = (skill.reload - 1) * (counter / 100) + 1
							mult = mult + 1 - mul
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

-- update blackmarket UI, based on WeaponLib's function override, fixes the total ammo count @313-314 and @324
Hooks:OverrideFunction(WeaponDescription, "_get_stats", function (name, category, slot, blueprint)
	local base_stats, mods_stats, skill_stats = WeaponDescription._weaponlib_pre_get_stats(name, category, slot, blueprint)
	local factory_id = managers.weapon_factory:get_factory_id_by_weapon_id(name)
	local blueprint = blueprint or slot and managers.blackmarket:get_weapon_blueprint(category, slot) or managers.weapon_factory:get_default_blueprint_by_factory_id(factory_id)

	if blueprint then
		local cosmetics = managers.blackmarket:get_weapon_cosmetics(category, slot)
		local bonus_stats = {}
		if cosmetics and cosmetics.id and cosmetics.bonus and not managers.job:is_current_job_competitive() and not managers.weapon_factory:has_perk("bonus", factory_id, blueprint) then
			bonus_stats = tweak_data:get_raw_value("economy", "bonuses", tweak_data.blackmarket.weapon_skins[cosmetics.id].bonus, "stats") or {}
		end

		local original_base_stats = WeaponDescription._get_base_stats(name)
		local original_mods_stats = WeaponDescription._get_mods_stats(name, original_base_stats, deep_clone(blueprint), bonus_stats) 

		local weapon_override_stats = WeaponDescription._get_weapon_override_stats(name, blueprint)
		local clip_ammo, max_ammo, ammo_data = WeaponDescription.get_weapon_ammo_info(name, tweak_data.weapon[name].stats.extra_ammo, base_stats.totalammo.index + mods_stats.totalammo.index)

		override_tweak_data(name, blueprint)
		local overriden_clip_ammo, overriden_max_ammo, overriden_ammo_data = WeaponDescription.get_weapon_ammo_info(name, tweak_data.weapon[name].stats.extra_ammo, base_stats.totalammo.index + mods_stats.totalammo.index, true)
		--restore_tweak_data(name)

		mods_stats.totalammo.value = weapon_override_stats.totalammo.value + ammo_data.mod
		mods_stats.magazine.value = original_mods_stats.magazine.value

		local my_clip = base_stats.magazine.value + mods_stats.magazine.value + skill_stats.magazine.value
		if overriden_max_ammo < my_clip then
			mods_stats.magazine.value = mods_stats.magazine.value + overriden_max_ammo - my_clip
		end
		
		skill_stats.totalammo.value = overriden_ammo_data.skill
	end
	
	return base_stats, mods_stats, skill_stats
end)

-- adding ability to use float values with total_ammo_mod @392-393
-- this is an override of base game function "WeaponDescription._get_weapon_mod_stats". WeaponLib has it's own override for it,
-- but still uses the original game function at the start, to update stats basaed of of it. So we simply override what would've been a copy of the original function.
Hooks:OverrideFunction(WeaponDescription, "_weaponlib_pre_get_weapon_mod_stats", function (mod_name, weapon_name, base_stats, mods_stats, equipped_mods)
	local tweak_stats = tweak_data.weapon.stats
	local tweak_factory = tweak_data.weapon.factory.parts
	local weapon_tweak = tweak_data.weapon[weapon_name]
	local modifier_stats = weapon_tweak.stats_modifiers
	local factory_id = managers.weapon_factory:get_factory_id_by_weapon_id(weapon_name)
	local default_blueprint = managers.weapon_factory:get_default_blueprint_by_factory_id(factory_id)
	local part_data = nil
	local mod_stats = {
		chosen = {},
		equip = {}
	}

	for _, stat in pairs(WeaponDescription._stats_shown) do
		mod_stats.chosen[stat.name] = 0
		mod_stats.equip[stat.name] = 0
	end

	mod_stats.chosen.name = mod_name

	if equipped_mods then
		for _, mod in ipairs(equipped_mods) do
			if tweak_factory[mod] and tweak_factory[mod_name].type == tweak_factory[mod].type then
				mod_stats.equip.name = mod

				break
			end
		end
	end

	local curr_stats = base_stats
	local index, wanted_index = nil

	for _, mod in pairs(mod_stats) do
		part_data = nil

		if mod.name then
			if tweak_data.blackmarket.weapon_skins[mod.name] and tweak_data.blackmarket.weapon_skins[mod.name].bonus and tweak_data.economy.bonuses[tweak_data.blackmarket.weapon_skins[mod.name].bonus] then
				part_data = {
					stats = tweak_data.economy.bonuses[tweak_data.blackmarket.weapon_skins[mod.name].bonus].stats
				}
			else
				part_data = managers.weapon_factory:get_part_data_by_part_id_from_weapon(mod.name, factory_id, default_blueprint)
			end
		end

		for _, stat in pairs(WeaponDescription._stats_shown) do
			if part_data and part_data.stats then
				if stat.name == "magazine" then
					local ammo = part_data.stats.extra_ammo
					ammo = ammo and ammo + (tweak_data.weapon[weapon_name].stats.extra_ammo or 0)
					mod[stat.name] = ammo and tweak_data.weapon.stats.extra_ammo[ammo] or 0

					if part_data.custom_stats and part_data.custom_stats.ammo_offset then
						mod[stat.name] = mod[stat.name] + part_data.custom_stats.ammo_offset
					end
				elseif stat.name == "totalammo" then
					local chosen_index = part_data.stats.total_ammo_mod or 0
					chosen_index = math.clamp(base_stats[stat.name].index + chosen_index, 1, #tweak_stats.total_ammo_mod)
					chosen_index = math.floor(chosen_index * 1000 + 0.5)
					chosen_index = chosen_index / 1000
					mod[stat.name] = base_stats[stat.name].value * tweak_stats.total_ammo_mod[chosen_index]
				elseif stat.name == "reload" then
					local chosen_index = part_data.stats.reload or 0
					chosen_index = math.clamp(base_stats[stat.name].index + chosen_index, 1, #tweak_stats[stat.name])
					local reload_time = managers.blackmarket:get_reload_time(weapon_name)
					local mult = 1 / tweak_data.weapon.stats[stat.name][chosen_index]
					local mod_value = reload_time * mult
					mod[stat.name] = mod_value - base_stats[stat.name].value
				elseif stat.name == "fire_rate" then
					if part_data.custom_stats and part_data.custom_stats.fire_rate_multiplier then
						mod[stat.name] = base_stats[stat.name].value * (part_data.custom_stats.fire_rate_multiplier - 1)
					end
				elseif stat.name == "damage" and part_data.custom_stats and part_data.custom_stats.launcher_grenade then
					local projectile_type = weapon_tweak.projectile_types and weapon_tweak.projectile_types[part_data.custom_stats.launcher_grenade] or part_data.custom_stats.launcher_grenade
					local modifier = modifier_stats and modifier_stats[stat.name] or 1
					local projectile_tweak = tweak_data.projectiles[projectile_type]
					mod[stat.name] = projectile_tweak.damage * modifier - base_stats[stat.name].value
				else
					local chosen_index = part_data.stats[stat.name] or 0

					if tweak_stats[stat.name] then
						wanted_index = curr_stats[stat.name].index + chosen_index
						index = math.clamp(wanted_index, 1, #tweak_stats[stat.name])
						mod[stat.name] = stat.index and index or tweak_stats[stat.name][index] * tweak_data.gui.stats_present_multiplier

						if wanted_index ~= index then
							print("[WeaponDescription._get_weapon_mod_stats] index went out of bound, estimating value", "mod_name", mod_name, "stat.name", stat.name, "wanted_index", wanted_index, "index", index)

							if stat.index then
								index = wanted_index
								mod[stat.name] = index
							elseif index ~= curr_stats[stat.name].index then
								local diff_value = tweak_stats[stat.name][index] - tweak_stats[stat.name][curr_stats[stat.name].index]
								local diff_index = index - curr_stats[stat.name].index
								local diff_ratio = diff_value / diff_index
								diff_index = wanted_index - index
								diff_value = diff_index * diff_ratio
								mod[stat.name] = mod[stat.name] + diff_value * tweak_data.gui.stats_present_multiplier
							end
						end

						local offset = math.min(tweak_stats[stat.name][1], tweak_stats[stat.name][#tweak_stats[stat.name]]) * tweak_data.gui.stats_present_multiplier

						if stat.offset then
							mod[stat.name] = mod[stat.name] - offset
						end

						if stat.revert then
							local max_stat = math.max(tweak_stats[stat.name][1], tweak_stats[stat.name][#tweak_stats[stat.name]]) * tweak_data.gui.stats_present_multiplier

							if stat.revert then
								max_stat = max_stat - offset
							end

							mod[stat.name] = max_stat - mod[stat.name]
						end

						if modifier_stats and modifier_stats[stat.name] then
							local mod_stat = modifier_stats[stat.name]

							if stat.revert and not stat.index then
								local real_base_value = tweak_stats[stat.name][index]
								local modded_value = real_base_value * mod_stat
								local offset = math.min(tweak_stats[stat.name][1], tweak_stats[stat.name][#tweak_stats[stat.name]])

								if stat.offset then
									modded_value = modded_value - offset
								end

								local max_stat = math.max(tweak_stats[stat.name][1], tweak_stats[stat.name][#tweak_stats[stat.name]])

								if stat.offset then
									max_stat = max_stat - offset
								end

								local new_value = (max_stat - modded_value) * tweak_data.gui.stats_present_multiplier

								if mod_stat ~= 0 and (tweak_stats[stat.name][1] < modded_value or modded_value < tweak_stats[stat.name][#tweak_stats[stat.name]]) then
									new_value = (new_value + mod[stat.name] / mod_stat) / 2
								end

								mod[stat.name] = new_value
							else
								mod[stat.name] = mod[stat.name] * mod_stat
							end
						end

						if stat.percent then
							local max_stat = stat.index and #tweak_stats[stat.name] or math.max(tweak_stats[stat.name][1], tweak_stats[stat.name][#tweak_stats[stat.name]]) * tweak_data.gui.stats_present_multiplier

							if stat.offset then
								max_stat = max_stat - offset
							end

							local ratio = mod[stat.name] / max_stat
							mod[stat.name] = ratio * 100
						end

						mod[stat.name] = mod[stat.name] - curr_stats[stat.name].value
					end
				end
			end
		end
	end

	return mod_stats
end)