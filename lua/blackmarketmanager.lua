-- add new akimbo skill

-- this func updates blackmarket GUI numbers; @11-33 for the new akimbo skill
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
		elseif fire_mode == "auto" then
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

-- this func actually adds the stat to the gun; @67-89 for the new akimbo skill
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

	if silencer then
		index = index + managers.player:upgrade_value("weapon", "silencer_spread_index_addend", 0)

		for _, category in ipairs(categories) do
			index = index + managers.player:upgrade_value(category, "silencer_spread_index_addend", 0)
		end
	end

	if fire_mode == "single" and table.contains_any(tweak_data.upgrades.sharpshooter_categories, categories) then
		index = index + managers.player:upgrade_value("weapon", "single_spread_index_addend", 0)
	elseif fire_mode == "auto" then
		index = index + managers.player:upgrade_value("weapon", "auto_spread_index_addend", 0)
	end

	return index
end)

-- same as 2 funcs above but for recoil - updates both GUI and the stats; @119-136, yeap the akimbo skill again
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