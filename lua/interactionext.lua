-- reduced interaction timer if we have speed junkie perk, depends on stacks amount
Hooks:OverrideFunction(BaseInteractionExt, "_get_timer", function (self)
	local modified_timer = self:_get_modified_timer()

	if modified_timer then
		return modified_timer
	end

	local multiplier = 1

	if self.tweak_data ~= "corpse_alarm_pager" then
		multiplier = multiplier * managers.player:crew_ability_upgrade_value("crew_interact", 1)
	end
	
	-- junkie perk
	if self.tweak_data ~= "corpse_alarm_pager" and self.tweak_data ~= "revive" then
		if managers.player:has_category_upgrade("player", "speed_junkie_meter_boost_agility") then
			local counter = managers.player._Gilza_junkie_counter or 0
			local skill = managers.player:upgrade_value("player", "speed_junkie_meter_boost_agility")
			if skill and type(skill) ~= "number" then
				local mul = 1 - (skill.interaction - 1) * (counter / 100)
				multiplier = multiplier * mul
			end	
		end
	end

	if self._tweak_data.upgrade_timer_multiplier then
		multiplier = multiplier * managers.player:upgrade_value(self._tweak_data.upgrade_timer_multiplier.category, self._tweak_data.upgrade_timer_multiplier.upgrade, 1)
	end

	if self._tweak_data.upgrade_timer_multipliers then
		for _, upgrade_timer_multiplier in pairs(self._tweak_data.upgrade_timer_multipliers) do
			multiplier = multiplier * managers.player:upgrade_value(upgrade_timer_multiplier.category, upgrade_timer_multiplier.upgrade, 1)
		end
	end

	if managers.player:has_category_upgrade("player", "level_interaction_timer_multiplier") then
		local data = managers.player:upgrade_value("player", "level_interaction_timer_multiplier") or {}
		local player_level = managers.experience:current_level() or 0
		multiplier = multiplier * (1 - (data[1] or 0) * math.ceil(player_level / (data[2] or 1)))
	end

	return self:_timer_value() * multiplier * managers.player:toolset_value()
end)