-- adds weapon stat adjustments from new melee skills to blackmarket GUI.
Hooks:OverrideFunction(BlackMarketGui, "_get_melee_weapon_stats", function (self, name)
	local base_stats = {}
	local mods_stats = {}
	local skill_stats = {}
	local stats_data = managers.blackmarket:get_melee_weapon_stats(name)
	local multiple_of = {}
	local has_non_special = managers.player:has_category_upgrade("player", "non_special_melee_multiplier")
	local has_special = managers.player:has_category_upgrade("player", "melee_damage_multiplier")
	local non_special = managers.player:upgrade_value("player", "non_special_melee_multiplier", 1) - 1
	local special = managers.player:upgrade_value("player", "melee_damage_multiplier", 1) - 1

	for i, stat in ipairs(self._mweapon_stats_shown) do
		local skip_rounding = stat.num_decimals
		base_stats[stat.name] = {
			value = 0,
			max_value = 0,
			min_value = 0
		}
		mods_stats[stat.name] = {
			value = 0,
			max_value = 0,
			min_value = 0
		}
		skill_stats[stat.name] = {
			value = 0,
			max_value = 0,
			min_value = 0
		}

		if stat.name == "damage" then
			local base_min = stats_data.min_damage * tweak_data.gui.stats_present_multiplier
			local base_max = stats_data.max_damage * tweak_data.gui.stats_present_multiplier
			local dmg_mul = managers.player:upgrade_value("player", "melee_" .. tostring(tweak_data.blackmarket.melee_weapons[name].stats.weapon_type) .. "_damage_multiplier", 1)
			local newzerkmul = 1 + managers.player:upgrade_value("player", "melee_damage_newzerk_addin", 0)
			local skill_mul = newzerkmul * dmg_mul * ((has_non_special and has_special and math.max(non_special, special) or 0) + 1) - 1
			local skill_min = skill_mul
			local skill_max = skill_mul
			base_stats[stat.name] = {
				min_value = base_min,
				max_value = base_max,
				value = (base_min + base_max) / 2
			}
			skill_stats[stat.name] = {
				min_value = skill_min,
				max_value = skill_max,
				value = (skill_min + skill_max) / 2,
				skill_in_effect = skill_min > 0 or skill_max > 0
			}
		elseif stat.name == "damage_effect" then
			local base_min = stats_data.min_damage_effect
			local base_max = stats_data.max_damage_effect
			base_stats[stat.name] = {
				min_value = base_min,
				max_value = base_max,
				value = (base_min + base_max) / 2
			}
			local dmg_mul = managers.player:upgrade_value("player", "melee_" .. tostring(tweak_data.blackmarket.melee_weapons[name].stats.weapon_type) .. "_damage_multiplier", 1) - 1
			local gst_skill = managers.player:upgrade_value("player", "melee_knockdown_mul", 1) - 1
			local skill_mul = (1 + dmg_mul) * (1 + gst_skill) - 1
			local skill_min = skill_mul
			local skill_max = skill_mul
			skill_stats[stat.name] = {
				skill_min = skill_min,
				skill_max = skill_max,
				min_value = skill_min,
				max_value = skill_max,
				value = (skill_min + skill_max) / 2,
				skill_in_effect = skill_min > 0 or skill_max > 0
			}
		elseif stat.name == "charge_time" then
			local base = stats_data.charge_time
			local chargespeedmul = managers.player:upgrade_value("player", "melee_faster_charge", 0)
			base_stats[stat.name] = {
				value = base,
				min_value = base,
				max_value = base
			}
			skill_stats[stat.name] = {
				value = chargespeedmul * -1,
				min_value = chargespeedmul * -1,
				max_value = chargespeedmul * -1,
				skill_in_effect = chargespeedmul > 0
			}
		elseif stat.name == "range" then
			local base_min = stats_data.range
			local base_max = stats_data.range
			base_stats[stat.name] = {
				min_value = base_min,
				max_value = base_max,
				value = (base_min + base_max) / 2
			}
		elseif stat.name == "concealment" then
			local base = managers.blackmarket:_calculate_melee_weapon_concealment(name)
			local skill = managers.blackmarket:concealment_modifier("melee_weapons")
			base_stats[stat.name] = {
				min_value = base,
				max_value = base,
				value = base
			}
			skill_stats[stat.name] = {
				min_value = skill,
				max_value = skill,
				value = skill,
				skill_in_effect = skill > 0
			}
		end

		if stat.multiple_of then
			table.insert(multiple_of, {
				stat.name,
				stat.multiple_of
			})
		end

		base_stats[stat.name].real_value = base_stats[stat.name].value
		mods_stats[stat.name].real_value = mods_stats[stat.name].value
		skill_stats[stat.name].real_value = skill_stats[stat.name].value
		base_stats[stat.name].real_min_value = base_stats[stat.name].min_value
		mods_stats[stat.name].real_min_value = mods_stats[stat.name].min_value
		skill_stats[stat.name].real_min_value = skill_stats[stat.name].min_value
		base_stats[stat.name].real_max_value = base_stats[stat.name].max_value
		mods_stats[stat.name].real_max_value = mods_stats[stat.name].max_value
		skill_stats[stat.name].real_max_value = skill_stats[stat.name].max_value
	end

	for i, data in ipairs(multiple_of) do
		local multiplier = data[1]
		local stat = data[2]
		base_stats[multiplier].min_value = base_stats[stat].real_min_value * base_stats[multiplier].real_min_value
		base_stats[multiplier].max_value = base_stats[stat].real_max_value * base_stats[multiplier].real_max_value
		base_stats[multiplier].value = (base_stats[multiplier].min_value + base_stats[multiplier].max_value) / 2
	end

	for i, stat in ipairs(self._mweapon_stats_shown) do
		if not stat.index then
			if skill_stats[stat.name].value and base_stats[stat.name].value then
				skill_stats[stat.name].value = base_stats[stat.name].value * skill_stats[stat.name].value
				base_stats[stat.name].value = base_stats[stat.name].value
			end

			if skill_stats[stat.name].min_value and base_stats[stat.name].min_value then
				skill_stats[stat.name].min_value = base_stats[stat.name].min_value * skill_stats[stat.name].min_value
				base_stats[stat.name].min_value = base_stats[stat.name].min_value
			end

			if skill_stats[stat.name].max_value and base_stats[stat.name].max_value then
				skill_stats[stat.name].max_value = base_stats[stat.name].max_value * skill_stats[stat.name].max_value
				base_stats[stat.name].max_value = base_stats[stat.name].max_value
			end
		end
	end

	return base_stats, mods_stats, skill_stats
end)

-- update text for armor descriptions for ex-pres and anarchist perk decks
Hooks:PostHook(BlackMarketGui, "update_info_text", "Gilza_BlackMarketGui_update_info_text_post", function(self)
	local slot_data = self._slot_data
	local tab_data = self._tabs[self._selected]._data
	local identifier = tab_data.identifier
	
	if identifier == self.identifiers.armor then
		-- new ex-pres
		if managers.player:has_category_upgrade("player", "armor_health_store_amount") then
			local bm_armor_tweak = tweak_data.blackmarket.armors[slot_data.name]
			local upgrade_level = bm_armor_tweak.upgrade_level
			local amount = managers.player:body_armor_value("skill_max_health_store", upgrade_level, 1)
			local multiplier = managers.player:upgrade_value("player", "armor_max_health_store_multiplier", 1)
			local recovery_bonus = managers.player:body_armor_value("skill_store_armor_recovery_bonus_timer", upgrade_level, 1)
			local new_info_str = managers.localization:text("bm_menu_armor_max_health_store", {
				amount = (amount * multiplier * tweak_data.gui.stats_present_multiplier),
				amount_2 = recovery_bonus
			})
			
			self._info_texts[2]:set_text(tostring(new_info_str))
		end
		
		-- new anarchist
		if managers.player:has_category_upgrade("player", "armor_grinding") then
			local bm_armor_tweak = tweak_data.blackmarket.armors[slot_data.name]
			local upgrade_level = bm_armor_tweak.upgrade_level
			local new_info_str = managers.localization:text("bm_menu_anarchist_armor_desc", {
				amount_1 = tweak_data.upgrades.values.player.armor_grinding[1][upgrade_level][1] * 10,
				amount_2 = tweak_data.upgrades.values.player.armor_grinding[1][upgrade_level][2],
				amount_3 = tweak_data.upgrades.values.player.damage_to_armor[1][upgrade_level][1] * 10,
				amount_4 = tweak_data.upgrades.values.player.damage_to_armor[1][upgrade_level][2],
			})
			if slot_data.unlocked then -- prevent ICTV's skill requirement text from overlapping with new description if we dont have it unlocked
				self._info_texts[2]:set_text(tostring(new_info_str))
			end
			
			-- ui activation and positioning
			local info_text = self._info_texts[2]
			local _, _, _, th = info_text:text_rect()
			info_text:set_h(th)
			info_text:set_w(self._info_texts_panel:w())
			info_text:set_font_size(tweak_data.menu.pd2_small_font_size)
			if slot_data.comparision_data and alive(self._stats_text_modslist) then
				info_text:set_world_y(self._stats_text_modslist:world_top())
			end
		end
	end
end)

-- weapon sorting based on damage value
Hooks:PreHook(BlackMarketGui, "populate_buy_weapon", "Gilza_BlackMarketGui_populate_buy_weapon_pre", function(self, data)
	
	-- 1 disable, 2 descend, 3 ascend
	local order_preference = Gilza.settings.blackmarket_weapon_sorting or 1
	
	if order_preference > 1 and data.name ~= "wpn_special" then
		local default_data_clone = deep_clone(data.on_create_data)
		local new_data = {}
		for i=1, #data.on_create_data do
			local wpn_id = data.on_create_data[i].weapon_id
			local dmg = 0
			if tweak_data.weapon[wpn_id] then
				dmg = tweak_data.weapon[wpn_id].stats.damage
			end
			new_data[dmg] = new_data[dmg] or {}
			table.insert(new_data[dmg], wpn_id)
		end
		
		local new_new_data = {}
		local import_order = 1
		local function sort_weapon_order()
			local positions = 0
			for ___, ____ in pairs(new_data) do
				positions = positions + 1
			end
			
			if order_preference == 2 then
				for i = 1, positions do
					local highest_dmg = 0
					for dmg_type, weapons in pairs(new_data) do
						if highest_dmg < dmg_type then
							highest_dmg = dmg_type
						end
					end
					new_new_data[import_order] = deep_clone(new_data[highest_dmg])
					import_order = import_order + 1
					new_data[highest_dmg] = nil
				end
			elseif order_preference == 3 then
				for i = 1, positions do
					local lowest_dmg = 999999
					for dmg_type, weapons in pairs(new_data) do
						if lowest_dmg > dmg_type then
							lowest_dmg = dmg_type
						end
					end
					new_new_data[import_order] = deep_clone(new_data[lowest_dmg])
					import_order = import_order + 1
					new_data[lowest_dmg] = nil
				end
			end
		end
		sort_weapon_order()
		
		local table_fill_id = 1
		for order, weapons in ipairs(new_new_data) do
			for _, weapon in pairs(weapons) do
				local orig_item_spot = 0
				for i=1, #default_data_clone do
					if default_data_clone[i].weapon_id == weapon then
						orig_item_spot = i
					end
				end
				if orig_item_spot ~= 0 then
					data.on_create_data[table_fill_id] = deep_clone(default_data_clone[orig_item_spot])
					table_fill_id = table_fill_id + 1
				end
			end
		end
	end
	
end)