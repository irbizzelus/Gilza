-- on kill add brawler's armor regen and fearmonger's speed boost if we have those skills
Hooks:PostHook(PlayerManager, "on_killshot", "Gilza_on_killshot", function(self, killed_unit, variant, headshot, weapon_id)
	local player_unit = self:player_unit()

	if not player_unit then
		return
	end

	if CopDamage.is_civilian(killed_unit:base()._tweak_table) then
		return
	end
	
	-- brawler armor melee regen
	if player_unit:character_damage() and managers.player:has_category_upgrade("player", "armor_regen_brawler") and variant == "melee" then
		player_unit:character_damage():restore_armor(7.5)
	end
	
	-- shotgun suppression aka fearmonger
	local shotgun_panic_when_kill = self:has_category_upgrade("shotgun", "panic_when_kill")
	
	if shotgun_panic_when_kill and variant ~= "melee" then
		local equipped_unit = self:get_current_state()._equipped_unit:base()
		-- only for shotguns with threat of 35 and above (idk where the extra 0.2 comes from yet)
		if equipped_unit:is_category("shotgun") and equipped_unit._suppression >= 3.7 then
			local pos = player_unit:position()
			local skill = self:upgrade_value("shotgun", "panic_when_kill")

			if skill and type(skill) ~= "number" then
				local area = skill.area
				local chance = skill.chance
				local amount = skill.amount
				local enemies = World:find_units_quick("sphere", pos, area, 12, 21)

				for i, unit in ipairs(enemies) do
					if unit:character_damage() then
						unit:character_damage():build_suppression(amount, chance)
					end
				end
			end
		end
	end

	if killed_unit:movement() and killed_unit:movement()._action_common_data and killed_unit:movement()._action_common_data.is_suppressed then
		if Gilza.panicking_enemies and Gilza.panicking_enemies[killed_unit:id()] and Gilza.panicking_enemies[killed_unit:id()] ~= "removed" then
			if Gilza.settings.shotgun_skill_notification then
				managers.hud:show_hint({text = "Temporary speed boost activated."})
			end
			self:get_current_state()._unit:movement():_change_stamina(self:get_current_state()._unit:movement():_max_stamina()+1)
			if managers.player:has_category_upgrade("temporary", "speed_boost_on_panic_kill") then
				managers.player:activate_temporary_upgrade("temporary", "speed_boost_on_panic_kill")
			end
		end
	end
end)

-- add new speed bonus from shotgun panic skill @97
Hooks:OverrideFunction(PlayerManager, "movement_speed_multiplier", function (self, speed_state, bonus_multiplier, upgrade_level, health_ratio)
	local multiplier = 1
	local armor_penalty = self:mod_movement_penalty(self:body_armor_value("movement", upgrade_level, 1))
	multiplier = multiplier + armor_penalty - 1

	if bonus_multiplier then
		multiplier = multiplier + bonus_multiplier - 1
	end

	if speed_state then
		multiplier = multiplier + self:upgrade_value("player", speed_state .. "_speed_multiplier", 1) - 1
		multiplier = multiplier + self:upgrade_value("player", "mrwi_" .. speed_state .. "_speed_multiplier", 1) - 1
	end

	multiplier = multiplier + self:get_hostage_bonus_multiplier("speed") - 1
	multiplier = multiplier + self:upgrade_value("player", "movement_speed_multiplier", 1) - 1

	if self:num_local_minions() > 0 then
		multiplier = multiplier + self:upgrade_value("player", "minion_master_speed_multiplier", 1) - 1
	end

	if self:has_category_upgrade("player", "secured_bags_speed_multiplier") then
		local bags = 0
		bags = bags + (managers.loot:get_secured_mandatory_bags_amount() or 0)
		bags = bags + (managers.loot:get_secured_bonus_bags_amount() or 0)
		multiplier = multiplier + bags * (self:upgrade_value("player", "secured_bags_speed_multiplier", 1) - 1)
	end

	if managers.player:has_activate_temporary_upgrade("temporary", "berserker_damage_multiplier") then
		multiplier = multiplier * (tweak_data.upgrades.berserker_movement_speed_multiplier or 1)
	end

	if health_ratio then
		local damage_health_ratio = self:get_damage_health_ratio(health_ratio, "movement_speed")
		multiplier = multiplier * (1 + managers.player:upgrade_value("player", "movement_speed_damage_health_ratio_multiplier", 0) * damage_health_ratio)
	end

	local damage_speed_multiplier = managers.player:temporary_upgrade_value("temporary", "damage_speed_multiplier", managers.player:temporary_upgrade_value("temporary", "team_damage_speed_multiplier_received", 1))
	multiplier = multiplier * damage_speed_multiplier
	
	local panic_speed_multiplier = managers.player:temporary_upgrade_value("temporary", "speed_boost_on_panic_kill", 0)
	multiplier = multiplier + panic_speed_multiplier

	return multiplier
end)