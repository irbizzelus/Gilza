-- this func updates blackmarket GUI numbers
Hooks:OverrideFunction(BlackMarketManager, "accuracy_addend", function (self, name, categories, spread_index, silencer, current_state, fire_mode, blueprint, is_moving, is_single_shot)
	local addend = 0

	if spread_index then
		local index = spread_index
		index = index + managers.player:upgrade_value("player", "weapon_accuracy_increase", 0)

		local simplified_categories = {}
		for _, category in ipairs(categories) do
			index = index + managers.player:upgrade_value(category, "spread_index_addend", 0)

			if current_state and current_state._moving then
				index = index + managers.player:upgrade_value(category, "move_spread_index_addend", 0)
			end
			
			if category == "akimbo" then
				for __, category2 in ipairs(categories) do
					simplified_categories[category2] = true
				end
			end
		end
		
		-- new akimbo handling skill
		if simplified_categories.akimbo and managers.player:has_category_upgrade("akimbo", "pistol_improved_handling") then
			if simplified_categories.pistol or (simplified_categories.smg and managers.player:has_category_upgrade("akimbo", "allow_smg_improved_handling")) then
				local skill = managers.player:upgrade_value("akimbo", "pistol_improved_handling")
				if skill and type(skill) ~= "number" then
					index = index + skill.accuracy
				end	
			end
		end

		if silencer then
			index = index + managers.player:upgrade_value("weapon", "silencer_spread_index_addend", 0)

			for _, category in ipairs(categories) do
				index = index + managers.player:upgrade_value(category, "silencer_spread_index_addend", 0)
			end
		end

		if fire_mode == "single" and table.contains_any(tweak_data.upgrades.sharpshooter_categories, categories) then
			index = index + managers.player:upgrade_value("weapon", "single_spread_index_addend", 0)
		elseif fire_mode == "auto" or fire_mode == "burst" then
			index = index + managers.player:upgrade_value("weapon", "auto_spread_index_addend", 0)
		end

		local spread_tweak = tweak_data.weapon.stats.spread
		index = math.clamp(index, 1, #spread_tweak)
		spread_index = math.clamp(spread_index, 1, #spread_tweak)

		if index ~= spread_index then
			local diff = spread_tweak[index] - spread_tweak[spread_index]
			addend = addend + diff
		end
	end

	return addend
end)

-- this func actually adds the stat to the gun
Hooks:OverrideFunction(BlackMarketManager, "accuracy_index_addend", function (self, name, categories, silencer, current_state, fire_mode, blueprint)
	local index = 0
	index = index + managers.player:upgrade_value("player", "weapon_accuracy_increase", 0)

	local simplified_categories = {}
	for _, category in ipairs(categories) do
		index = index + managers.player:upgrade_value(category, "spread_index_addend", 0)

		if current_state and current_state._moving then
			index = index + managers.player:upgrade_value(category, "move_spread_index_addend", 0)
		end
		
		if category == "akimbo" then
			for __, category2 in ipairs(categories) do
				simplified_categories[category2] = true
			end
		end
	end
	
	if simplified_categories.akimbo and managers.player:has_category_upgrade("akimbo", "pistol_improved_handling") then
		if simplified_categories.pistol or (simplified_categories.smg and managers.player:has_category_upgrade("akimbo", "allow_smg_improved_handling")) then
			local skill = managers.player:upgrade_value("akimbo", "pistol_improved_handling")
			if skill and type(skill) ~= "number" then
				index = index + skill.accuracy
			end	
		end
	end
	
	-- ignore fire mode penalties if we r using pistols with new auto rapid fire skill
	local active_trig_hap = false
	for _, category in ipairs(categories) do
		if category == "pistol" and managers.player:has_category_upgrade("pistol", "stacking_hit_damage_multiplier") then
			active_trig_hap = true
		end
	end
	
	-- weapon inaccuracy for any weapon, based on fire mode. this was removed from "accuracy_addend" func above, since you should get your max single fire acuracy in menus
	if fire_mode and fire_mode ~= "single" then
		if active_trig_hap then
			-- ignored
		elseif managers.player:current_state() == "bipod" then
			-- +40 acc for bipods, they also have a multiplier which depends on bipod deploy process
			index = index + 10
		elseif fire_mode == "volley" then
			-- buff volley mode, because this firemode is used by mostly inaccurate guns in this mod
			index = index + 5
		elseif fire_mode == "burst" then
			-- burst fire mode has slighlty better accuracy. only 1 vanilla weapon has this feature - ms3gl, other weapons gain this mode from gilza's weapon_tweaks
			index = index - 2
		else
			index = index - 4
		end
	end
	
	-- 20 points of inaccuracy for hipfire, unless we have new version of fire control skill
	if current_state and not current_state:in_steelsight() then
		if managers.player:current_state() == "bipod" then
			-- ignored
		else
			index = index - managers.player:upgrade_value("player", "hipfire_no_accuracy_penalty", 5)
		end
	end

	if silencer then
		index = index + managers.player:upgrade_value("weapon", "silencer_spread_index_addend", 0)

		for _, category in ipairs(categories) do
			index = index + managers.player:upgrade_value(category, "silencer_spread_index_addend", 0)
		end
	end

	if fire_mode == "single" and table.contains_any(tweak_data.upgrades.sharpshooter_categories, categories) then
		index = index + managers.player:upgrade_value("weapon", "single_spread_index_addend", 0)
	elseif fire_mode == "auto" or fire_mode == "burst" then
		index = index + managers.player:upgrade_value("weapon", "auto_spread_index_addend", 0)
	end

	return index
end)

-- same as 2 funcs above but for recoil - updates both GUI and the stats
Hooks:OverrideFunction(BlackMarketManager, "recoil_addend", function (self, name, categories, recoil_index, silencer, blueprint, current_state, is_single_shot)
	local addend = 0

	if recoil_index then
		local index = recoil_index
		index = index + managers.player:upgrade_value("weapon", "recoil_index_addend", 0)
		index = index + managers.player:upgrade_value("player", "stability_increase_bonus_1", 0)
		index = index + managers.player:upgrade_value("player", "stability_increase_bonus_2", 0)
		index = index + managers.player:upgrade_value(name, "recoil_index_addend", 0)
		
		local simplified_categories = {}
		for _, category in ipairs(categories) do
			index = index + managers.player:upgrade_value(category, "recoil_index_addend", 0)
			if category == "akimbo" then
				for __, category2 in ipairs(categories) do
					simplified_categories[category2] = true
				end
			end
		end
		
		-- new skimbo skill
		if simplified_categories.akimbo and managers.player:has_category_upgrade("akimbo", "pistol_improved_handling") then
			if simplified_categories.pistol or (simplified_categories.smg and managers.player:has_category_upgrade("akimbo", "allow_smg_improved_handling")) then
				local skill = managers.player:upgrade_value("akimbo", "pistol_improved_handling")
				if skill and type(skill) ~= "number" then
					index = index + skill.recoil
				end	
			end	
		end

		if managers.player:player_unit() and managers.player:player_unit():character_damage():is_suppressed() then
			for _, category in ipairs(categories) do
				if managers.player:has_team_category_upgrade(category, "suppression_recoil_index_addend") then
					index = index + managers.player:team_upgrade_value(category, "suppression_recoil_index_addend", 0)
				end
			end

			if managers.player:has_team_category_upgrade("weapon", "suppression_recoil_index_addend") then
				index = index + managers.player:team_upgrade_value("weapon", "suppression_recoil_index_addend", 0)
			end
		else
			for _, category in ipairs(categories) do
				if managers.player:has_team_category_upgrade(category, "recoil_index_addend") then
					index = index + managers.player:team_upgrade_value(category, "recoil_index_addend", 0)
				end
			end
			
			if managers.player:has_team_category_upgrade("weapon", "recoil_index_addend") then
				index = index + managers.player:team_upgrade_value("weapon", "recoil_index_addend", 0)
			end
		end
		
		-- 36 points of recoil penalty if hipfiring without new skill
		if current_state and not current_state:in_steelsight() then
			index = index - managers.player:upgrade_value("player", "hipfire_less_recoil", 9)
		end

		if silencer then
			index = index + managers.player:upgrade_value("weapon", "silencer_recoil_index_addend", 0)

			for _, category in ipairs(categories) do
				index = index + managers.player:upgrade_value(category, "silencer_recoil_index_addend", 0)
			end
		end

		if blueprint and self:is_weapon_modified(managers.weapon_factory:get_factory_id_by_weapon_id(name), blueprint) then
			index = index + managers.player:upgrade_value("weapon", "modded_recoil_index_addend", 0)
		end

		local recoil_tweak = tweak_data.weapon.stats.recoil
		index = math.clamp(index, 1, #recoil_tweak)
		recoil_index = math.clamp(recoil_index, 1, #recoil_tweak)

		if index ~= recoil_index then
			local diff = recoil_tweak[index] - recoil_tweak[recoil_index]
			addend = addend + diff
		end
	end

	return addend
end)

-- updates both GUI and in game stats for ROF
Hooks:OverrideFunction(BlackMarketManager, "fire_rate_multiplier", function (self, name, categories, silencer, detection_risk, current_state, blueprint)
	
	local multiplier = 1
	multiplier = multiplier + 1 - managers.player:upgrade_value(name, "fire_rate_multiplier", 1)
	multiplier = multiplier + 1 - managers.player:upgrade_value("weapon", "fire_rate_multiplier", 1)

	for _, category in ipairs(categories) do
		multiplier = multiplier + 1 - managers.player:upgrade_value(category, "fire_rate_multiplier", 1)
		
		-- new trigger happy buff
		if category == "pistol" and managers.player:has_category_upgrade("pistol", "stacking_hit_damage_multiplier") and managers.player._coroutine_mgr:is_running("trigger_happy") then
			multiplier = multiplier + 1 - managers.player:upgrade_value("pistol", "trigger_happpy_rof_increase", 1)
		end
	end
	
	-- new gun oil skill - due to the fact that this is a multiplier, we do some funny fuckery to make the bonus always the same
	-- and we do it as a mul since making flat number increases would be annoying. this func allready supports skills UI, so might as well just make it work
	local has_skill_value = managers.player:upgrade_value("player", "ar_smg_lmg_rof_increase", 0)
	if has_skill_value ~= 0 then
		for _, category in ipairs(categories) do
			if category == "assault_rifle" or category == "smg" or category == "lmg" then
				-- get weapon rof bonus based on it's default rof
				-- this effectively makes all weapons have identical ROF bouns, favouring lower ROF weapons as a result
				local wpn_rof = 60 / tweak_data.weapon[name].fire_mode_data.fire_rate
				local rof_bonus = 1 - has_skill_value
				if wpn_rof ~= 600 then
					local rof_dif_ratio = (600 / wpn_rof)
					rof_bonus = rof_bonus * rof_dif_ratio
				end
				
				multiplier = multiplier * (1 - rof_bonus)
				break
			end
		end
	end
	
	return self:_convert_add_to_mul(multiplier)
end)

-- new melee sort
Hooks:OverrideFunction(BlackMarketManager, "get_sorted_melee_weapons", function (self, hide_locked, id_list_only)
	local items = {}
	local global_value, td, category = nil

	for id, item in pairs(Global.blackmarket_manager.melee_weapons) do
		td = tweak_data.blackmarket.melee_weapons[id]
		global_value = td.dlc or td.global_value or "normal"
		category = td.type or "unknown"
		local add_item = item.unlocked or item.equipped or not hide_locked and not managers.dlc:should_hide_unavailable(global_value, true)

		if add_item then
			table.insert(items, {
				id,
				item
			})
		end
	end

	local xd, yd, x_td, y_td, x_sn, y_sn, x_gv, y_gv = nil
	local m_tweak_data = tweak_data.blackmarket.melee_weapons
	local l_tweak_data = tweak_data.lootdrop.global_values
	local locked_sort_numbers = {}

	for _, item in ipairs(items) do
		local id = item[1]
		local data = item[2]
		local dlc = m_tweak_data[id] and m_tweak_data[id].dlc or managers.dlc:global_value_to_dlc(m_tweak_data[id].global_value)
		local func = data.func_based or false
		local skill = data.skill_based or false
		locked_sort_numbers[id] = tweak_data.gui:get_locked_sort_number(dlc, func, skill)
	end

	local function sort_func(x, y)
		xd = x[2]
		yd = y[2]
		x_td = m_tweak_data[x[1]]
		y_td = m_tweak_data[y[1]]
		
		if not x_td.sort_order or not y_td.sort_order then
			return x_td.sort_order and true
		end
		
		if x_td.sort_order ~= y_td.sort_order then
			return x_td.sort_order < y_td.sort_order
		end
		
		-- vanilla stuff bellow, mostly ignored
		if _G.IS_VR and xd.vr_locked ~= yd.vr_locked then
			return not xd.vr_locked
		end

		if xd.unlocked ~= yd.unlocked then
			return xd.unlocked
		end

		if not xd.unlocked then
			x_sn = locked_sort_numbers[x[1]]
			y_sn = locked_sort_numbers[y[1]]

			if x_sn ~= y_sn then
				return x_sn < y_sn
			end
		end

		if xd.level ~= yd.level then
			return xd.level < yd.level
		end

		if x_td.instant ~= y_td.instant then
			return x_td.instant
		end

		if xd.skill_based ~= yd.skill_based then
			return xd.skill_based
		end

		if x_td.free ~= y_td.free then
			return x_td.free
		end

		x_gv = x_td.global_value or x_td.dlc or "normal"
		y_gv = y_td.global_value or y_td.dlc or "normal"
		x_sn = l_tweak_data[x_gv]
		y_sn = l_tweak_data[y_gv]
		x_sn = x_sn and x_sn.sort_number or 1
		y_sn = y_sn and y_sn.sort_number or 1

		if x_sn ~= y_sn then
			return x_sn < y_sn
		end

		if xd.level ~= yd.level then
			return xd.level < yd.level
		end

		return x[1] < y[1]
	end

	table.sort(items, sort_func)

	if id_list_only then
		local id_list = {}

		for _, data in ipairs(items) do
			table.insert(id_list, data[1])
		end

		return id_list
	end

	local override_slots = {
		5,
		5
	}
	local num_slots_per_category = override_slots[1] * override_slots[2]
	local sorted_categories = {}
	local item_categories = {}
	local category = nil
	local items_per_category = {}
	local next_category_start = 1
	local current_sort_order = -3
	
	for index, item in ipairs(items) do
		if m_tweak_data[item[1]].sort_order then
			items_per_category[next_category_start] = items_per_category[next_category_start] or 1
			
			if m_tweak_data[item[1]].sort_order <= 1 then
				if items_per_category[next_category_start] > num_slots_per_category then
					next_category_start = next_category_start + 1
				end
			elseif items_per_category[next_category_start] > num_slots_per_category or m_tweak_data[item[1]].sort_order > current_sort_order then
				next_category_start = next_category_start + 1
			end
			
			category = next_category_start
			current_sort_order = m_tweak_data[item[1]].sort_order
	
			item_categories[category] = item_categories[category] or {}
			table.insert(item_categories[category], item)
			items_per_category[next_category_start] = (items_per_category[next_category_start] or 1) + 1
		else
			log("[Gilza] Melee without assigned sort order: "..item[1].." - it wont show up in the inventory! Someone pls fix.")
		end
	end

	for i = 1, #item_categories do
		table.insert(sorted_categories, i)
	end

	return sorted_categories, item_categories, override_slots
end)