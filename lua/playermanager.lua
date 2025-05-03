-- fix lock and load aced target kill propety being static, instead of being taked from the skill value
Hooks:PostHook(PlayerManager, "_setup", "Gilza_post_setup", function(self)
	local skill = self:upgrade_value("player", "automatic_faster_reload")
	local val
	if skill and type(skill) ~= "number" then
		val = skill.target_enemies
	end
	self._SHOCK_AND_AWE_TARGET_KILLS = val or 2
	self._Gilza_menace_kill_tracker = 0
end)

-- made dmg resistance stackable by making them additive instead of multiplicative. to avoid god mode, max dmg resist is capped at 90%
function PlayerManager:damage_reduction_skill_multiplier(damage_type)
	local multiplier = 1
	multiplier = multiplier - (1 - self:temporary_upgrade_value("temporary", "dmg_dampener_outnumbered", 1))
	multiplier = multiplier - (1 - self:temporary_upgrade_value("temporary", "dmg_dampener_outnumbered_strong", 1))
	multiplier = multiplier - (1 - self:temporary_upgrade_value("temporary", "dmg_dampener_close_contact", 1))
	multiplier = multiplier - (1 - self:temporary_upgrade_value("temporary", "revived_damage_resist", 1))
	multiplier = multiplier - (1 - self:upgrade_value("player", "damage_dampener", 1))
	multiplier = multiplier - (1 - self:upgrade_value("player", "health_damage_reduction", 1))
	multiplier = multiplier - (1 - self:temporary_upgrade_value("temporary", "first_aid_damage_reduction", 1))
	multiplier = multiplier - (1 - self:temporary_upgrade_value("temporary", "revive_damage_reduction", 1))
	multiplier = multiplier - (1 - self:get_hostage_bonus_multiplier("damage_dampener"))
	multiplier = multiplier - (1 - self._properties:get_property("revive_damage_reduction", 1))
	multiplier = multiplier - (1 - self._temporary_properties:get_property("revived_damage_reduction", 1))
	local dmg_red_mul = self:team_upgrade_value("damage_dampener", "team_damage_reduction", 1)

	if managers.network:session():local_peer():unit():movement()._current_state._moving == false or managers.player:current_state() == "bipod" then
		multiplier = multiplier - (1 - managers.player:upgrade_value("player", "not_moving_damage_reduction_bonus", 1))
	end
	
	if managers.player:current_state() == "bipod" then
		multiplier = multiplier - (1 - managers.player:upgrade_value("player", "not_moving_damage_reduction_bonus_bipoded", 1))
	end
	
	if self:is_close_to_sentry_gun() then
		multiplier = multiplier - (1 - managers.player:upgrade_value("player", "sentry_proximity_damage_resist", 1))
	end
	
	if damage_type == "bullet" then
	
		if managers.player:player_unit():character_damage():get_real_armor() > 0 then
			if managers.player:has_category_upgrade("player", "damage_resist_brawler") then
				multiplier = multiplier - (1 - managers.player:upgrade_value("player", "damage_resist_brawler", 1))
			end
		end
	
		local att_unit = alive(Gilza.latest_bullet_attacker_unit) and Gilza.latest_bullet_attacker_unit
		if managers.player:has_category_upgrade("player", "damage_resist_faraway_brawler") then
			if ( managers.player:player_unit():character_damage():_max_health() / managers.player:player_unit():character_damage():get_real_health() ) >= 2 and managers.player:player_unit():character_damage():get_real_armor() > 0 then
				if managers.player:player_unit():camera() and managers.player:player_unit():camera():position() and att_unit and att_unit:position() then
					local dist = mvector3.distance(managers.player:player_unit():camera():position(), att_unit:position())
					local diff_mul = 1
					if Global.game_settings and Global.game_settings.difficulty and Global.game_settings.difficulty ~= "sm_wish" then
						diff_mul = 0.5
					end
					if dist and dist <= 1800 then
						multiplier = multiplier - 0.08 * diff_mul
					end
					if dist and dist <= 1000 then
						multiplier = multiplier - 0.1 * diff_mul
					end
					if dist and dist <= 500 then
						multiplier = multiplier - 0.14 * diff_mul
					end
				end
			end
		end
	end

	if self:has_category_upgrade("player", "passive_damage_reduction") then
		local health_ratio = self:player_unit():character_damage():health_ratio()
		local min_ratio = self:upgrade_value("player", "passive_damage_reduction")

		if health_ratio < min_ratio then
			dmg_red_mul = dmg_red_mul - (1 - dmg_red_mul)
		end
	end
	
	multiplier = multiplier - (1 - dmg_red_mul)

	if damage_type == "melee" then
		multiplier = multiplier - (1 - managers.player:upgrade_value("player", "melee_damage_dampener", 1))
	end

	local current_state = self:get_current_state()

	if current_state and current_state:_interacting() then
		multiplier = multiplier - (1 - managers.player:upgrade_value("player", "interacting_damage_multiplier", 1))
	end
	
	return math.clamp(multiplier, 0.1, 1)
end

-- on kill add brawler's armor regen and fearmonger's speed boost if we have those skills
local brawler_melee_kill_count = 0
local brawler_regen_count = 0
Hooks:PostHook(PlayerManager, "on_killshot", "Gilza_on_killshot", function(self, killed_unit, variant, headshot, weapon_id)
	local player_unit = self:player_unit()

	if not player_unit then
		return
	end

	if CopDamage.is_civilian(killed_unit:base()._tweak_table) then
		return
	end
	
	-- guardian area activation on kill
	if managers.player:has_category_upgrade("player", "guardian_activate_area_on_kill") and alive(player_unit) then
		if not self:Gilza_is_guardian_zone_active() and (Application:time() - self.Gilza_guardian_area.last_attended_time) >= 16 then
			local area = self.Gilza_guardian_area
			area.position = player_unit:position()
			area.is_active = true
			area.is_player_inside = true
			area.last_attended_time = Application:time()
			
			local info_hud = managers.hud:script(PlayerBase.PLAYER_INFO_HUD_PD2)
			local icon = info_hud.panel:child("Gilza_guardian_GUI_icon")
			if icon then
				icon:set_visible(true)
				icon:set_color(Color(1, 1, 1, 1))
			end
			player_unit:sound():play("perkdeck_activate", nil, false)
		end
	end
	
	-- guardian health on kill
	if managers.player:has_category_upgrade("player", "guardian_health_on_kill") and alive(player_unit) and self:Gilza_is_player_in_guardian_zone() then
		local diff_mul = 1
		if Global.game_settings and Global.game_settings.difficulty and Global.game_settings.difficulty == "sm_wish" then
			diff_mul = 2
		end
		local heal = managers.player:upgrade_value("player", "guardian_health_on_kill", 0) * diff_mul
		player_unit:character_damage():restore_health(heal, true)
	end
	
	-- guardian ammo pickup
	if managers.player:has_category_upgrade("player", "guardian_auto_ammo_pickup_on_kill") and alive(player_unit) and self:Gilza_is_player_in_guardian_zone() then
		
		local function find_pickups_at_death_location(death_spot, desync_compensation)
			local desync_compensation = desync_compensation or 0
			local skill_range_increase = managers.player:upgrade_value("player", "increased_pickup_area", 1)
			local pickups = World:find_units_quick("sphere", death_spot, (20 * skill_range_increase) + desync_compensation, managers.slot:get_mask("pickups"))
			local grenade_tweak = tweak_data.blackmarket.projectiles[managers.blackmarket:equipped_grenade()]
			local may_find_grenade = not grenade_tweak.base_cooldown and managers.player:has_category_upgrade("player", "regain_throwable_from_ammo")
			
			if pickups and #pickups >= 1 then
				for _, pickup in ipairs(pickups) do
					if pickup:pickup() and pickup:pickup():pickup(player_unit) then
						if may_find_grenade then
							local data = managers.player:upgrade_value("player", "regain_throwable_from_ammo", nil)

							if data and not managers.player:got_max_grenades() then
								managers.player:add_coroutine("regain_throwable_from_ammo", PlayerAction.FullyLoaded, managers.player, data.chance, data.chance_inc)
							end
						end

						for id, weapon in pairs(player_unit:inventory():available_selections()) do
							managers.hud:set_ammo_amount(id, weapon.unit:base():ammo_info())
						end
						return true
					end
				end
			end
			return false
		end
		local death_spot = Vector3(0,0,0)
		mvector3.set(death_spot,killed_unit:movement():m_pos())
		if Network and Network:is_client() then
			local max_attempts = 0 -- 3 seconds tops
			local function ammo_loop(death_spot)
				-- whenever we kill more then 1 enemy unit in one shot, this func will trigger for each dead enemy. if delayedcall name was the same, it would override
				-- first kill's delayed call with the second kill's delayed call, giving less ammo, so we are adding shot id to the name. on top of that, we add randomised number,
				-- because grenade launcher's shots fired tracker is more complex. for that case a RNG should help in cases where we get <10-20 kills per explosion. otherwise there would be higher chance for RNG to repeat itself
				DelayedCalls:Add("Gilza_try_finding_ammo_pickups_with_client_ping_compensation_for_shot_"..tostring(Gilza.weapon_shot_id).."_rng_"..tostring( math.random( math.random(0,55555), math.random(55555,99999) ) ), 0.05, function()
					if player_unit and alive(player_unit) then
						max_attempts = max_attempts + 1
						local ammo_found = find_pickups_at_death_location(death_spot,max_attempts*1.5)
						if max_attempts < 60 and not ammo_found then
							ammo_loop(death_spot)
						end
					end
				end)
			end
			ammo_loop(death_spot)
		else
			find_pickups_at_death_location(death_spot)
		end
		
	end
	
	-- junkie GUI and counter updates
	if managers.player:has_category_upgrade("player", "speed_junkie_meter_on_kill") then
		if managers.hud and managers.hud:script(PlayerBase.PLAYER_INFO_HUD_PD2) then
			local hud = managers.hud:script(PlayerBase.PLAYER_INFO_HUD_PD2)
			if hud.panel:child("Gilza_speed_junkie_GUI_icon") then
				self._Gilza_junkie_counter = self._Gilza_junkie_counter or 0
				local amount_to_add = managers.player:upgrade_value("player", "speed_junkie_meter_on_kill", 0)
				if not headshot then -- x3
					amount_to_add = amount_to_add * 3
				end
				if self._Gilza_junkie_counter < 90 and amount_to_add + self._Gilza_junkie_counter >= 90 then
					amount_to_add = 90 - self._Gilza_junkie_counter
				elseif self._Gilza_junkie_counter > 90 then
					amount_to_add = amount_to_add * -1
					if self._Gilza_junkie_counter + amount_to_add < 90 then
						amount_to_add = (self._Gilza_junkie_counter - 90) * -1
					end
				end
				self._Gilza_junkie_counter = self._Gilza_junkie_counter + amount_to_add
				-- 10% chance to enter adrenaline mode on kill if eligible
				if self._Gilza_junkie_eligible_for_spike and math.random() <= 0.1 then
					self._Gilza_junkie_adrenaline_spike = true
				end
			end
		end
	end
	-- junkie stamina on kill
	if self:get_current_state()._unit and alive(self:get_current_state()._unit) and managers.player:has_category_upgrade("player", "speed_junkie_stamina_on_kill") then
		self:get_current_state()._unit:movement():_change_stamina(self:get_current_state()._unit:movement():_max_stamina() * managers.player:upgrade_value("player", "speed_junkie_stamina_on_kill", 0))
	end
	
	if self:get_current_state()._unit and alive(self:get_current_state()._unit) and managers.player:has_category_upgrade("player", "stamina_on_melee_kill_brawler") and variant == "melee" then
		self:get_current_state()._unit:movement():_change_stamina(self:get_current_state()._unit:movement():_max_stamina() * managers.player:upgrade_value("player", "stamina_on_melee_kill_brawler", 0))
	end
	
	-- brawler armor melee regen
	if player_unit:character_damage() and managers.player:has_category_upgrade("player", "armor_regen_brawler") and variant == "melee" then
		brawler_melee_kill_count = brawler_melee_kill_count + 1
		-- i am too lazy to set up an actual overtime regeneration effect for armor, so here is a braindead method
		-- it adds 7 delayed calls with a 0.75 interval in between each call
		-- as a result we get 8 "ticks" every 0.75s with 12.5 points of armor per regen tick, total'ing at 100
		if brawler_regen_count < 3 then
			brawler_regen_count = brawler_regen_count + 1
			player_unit:character_damage():restore_armor(1.25)
			for i=1,7 do
				DelayedCalls:Add("Gilza_brawler_armor_regen_"..tostring(i).."_for_hit_number_"..tostring(brawler_melee_kill_count), 0.75 * i, function()
					if player_unit and alive(player_unit) and player_unit:character_damage() then
						player_unit:character_damage():restore_armor(1.25)
					end
					if i == 7 then
						brawler_regen_count = brawler_regen_count - 1
					end
				end)
			end
		end
	end
	
	-- menace suppression from new stockholm basic
	if self:has_category_upgrade("player", "menace_panic_spread") then
		local pos = player_unit:position()
		local skill = self:upgrade_value("player", "menace_panic_spread")

		if skill and type(skill) ~= "number" then
			local area = skill.area
			local chance = skill.chance * (1 + (self._Gilza_menace_kill_tracker or 0))
			local amount = skill.amount * (1 + (self._Gilza_menace_kill_tracker or 0))
			local enemies = World:find_units_quick("sphere", pos, area, 12, 21)

			for i, unit in ipairs(enemies) do
				if unit:character_damage() then
					unit:character_damage():build_suppression(amount, chance)
				end
			end
		end
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
				managers.hud:show_hint({text = managers.localization:text("Gilza_fearmonger_trigger_notification")})
			end
			self:get_current_state()._unit:movement():_change_stamina(self:get_current_state()._unit:movement():_max_stamina()+1)
			if managers.player:has_category_upgrade("temporary", "speed_boost_on_panic_kill") then
				managers.player:activate_temporary_upgrade("temporary", "speed_boost_on_panic_kill")
			end
		end
	end
end)

-- add new speed bonus from shotgun panic skill @114
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
	
	if self:has_category_upgrade("player", "speed_junkie_armor_berserk") then
		local skill_max_value = managers.player:upgrade_value("player", "speed_junkie_armor_berserk", 0)
		local max_armor = managers.player.local_player and alive(managers.player:local_player()) and managers.player:local_player().character_damage and managers.player:local_player():character_damage():_max_armor()
		local cur_armor = managers.player.local_player and alive(managers.player:local_player()) and managers.player:local_player().character_damage and managers.player:local_player():character_damage():get_real_armor()
		if max_armor and cur_armor then
			local addin = skill_max_value - (skill_max_value * (cur_armor / max_armor))
			multiplier = multiplier + addin
		end
	end
	
	if self:has_category_upgrade("player", "guardian_movement_penalty") then
		multiplier = multiplier + self:upgrade_value("player", "guardian_movement_penalty", 1) - 1
	end
	
	return multiplier
end)

-- manages pocket ecm duration for stealth/loud
Hooks:PreHook(PlayerManager, "_attempt_pocket_ecm_jammer", "Gilza_attempt_pocket_ecm_jammer", function(self)
	if managers.groupai and not managers.groupai:state():whisper_mode() then
		tweak_data.upgrades.values.player.pocket_ecm_jammer_base[1].duration = 12
	else
		tweak_data.upgrades.values.player.pocket_ecm_jammer_base[1].duration = 6
	end
end)

local ticks_since_stopped_moving = 0
local ticks_moving_in_air = 0
local ticks_since_reached_high_stacks = 0
local ticks_since_entered_adrenaline_spike_range = 0
local spike_flash_timer = 0
local junkie_exhausted = false
local function Gilza_update_junkie_loop(self)
	DelayedCalls:Add("Gilza_update_junkie_loop", 0.05, function()
		
		-- speed and movement state related value updates
		if managers.player:current_state() == "standard" or managers.player:current_state() == "carry" then
			if self and self.local_player and alive(self:local_player()) and self:local_player().movement and self:local_player():movement().current_state and self:local_player():movement():current_state()._get_max_walk_speed then
				if self:local_player():movement():current_state()._moving and not self:local_player():movement():current_state()._state_data.in_air then
					-- if moving, update junkie stacks based on movement speed, higher speed = higher gain; low speed = lose stacks
					local player_speed = self:local_player():movement():current_state():_get_max_walk_speed(managers.player:player_timer():time(),false)
					local junkie_power_adust_mul = player_speed / 580 -- speed value where you dont loose the meter
					local junkie_adjustment = -0.75 + (0.75 * junkie_power_adust_mul)
					self._Gilza_junkie_counter = self._Gilza_junkie_counter + junkie_adjustment
					-- tracks how many 'ticks' have passed since we stopped moving, a tick for this loop is 1/20 of a second
					ticks_since_stopped_moving = 0
					ticks_moving_in_air = 0
				elseif self:local_player():movement():current_state()._state_data.in_air then
					-- if we are in air, mostly from jumping, deplete really slowly
					ticks_moving_in_air = ticks_moving_in_air + 1
					if self._Gilza_junkie_counter > 0 then
						if ticks_moving_in_air >= 20 then
							-- if a jump takes longer then 1 sec freeze the depletion
						else
							self._Gilza_junkie_counter = self._Gilza_junkie_counter - 0.1
						end
					end
				else
					-- if we dont't move start actively depleting junkie stacks
					ticks_since_stopped_moving = ticks_since_stopped_moving + 1
					if self._Gilza_junkie_counter > 0 then
						-- first 1 second of not moving counter depletes at a stable rate, later it speeds up
						if ticks_since_stopped_moving <= 20 then
							self._Gilza_junkie_counter = self._Gilza_junkie_counter - 0.4
						else
							self._Gilza_junkie_counter = self._Gilza_junkie_counter - (ticks_since_stopped_moving * 0.02)
						end
					end
				end
			end
		elseif managers.player:current_state() == "arrested" or managers.player:current_state() == "tased" or managers.player:current_state() == "player_turret" or managers.player:current_state() == "driving" or managers.player:current_state() == "bipod" then
			-- player states where we loose stucks, but not that quickly
			if self._Gilza_junkie_counter > 0 then
				self._Gilza_junkie_counter = self._Gilza_junkie_counter - 0.08
			end
		elseif managers.player:current_state() == "jerry1" or managers.player:current_state() == "jerry2" then -- parachuting
			if self._Gilza_junkie_counter < 90 then
				self._Gilza_junkie_counter = self._Gilza_junkie_counter + 0.4
			end
		else
			self._Gilza_junkie_counter = 0
		end
		
		-- this chunk applies exhaust if stacks are high and updates the icon flash animation based on current status
		local info_hud = managers.hud:script(PlayerBase.PLAYER_INFO_HUD_PD2)
		local icon = info_hud.panel:child("Gilza_speed_junkie_GUI_icon")
		if self._Gilza_junkie_counter > 90 and not self._Gilza_junkie_adrenaline_spike then
			icon:animate(info_hud.flash_icon, 999999)
			ticks_since_reached_high_stacks = ticks_since_reached_high_stacks + 1
			-- if we reach high stacks and maintain them for over 4 seconds, stamina gets drained to 0
			if ticks_since_reached_high_stacks >= 80 then
				self._Gilza_junkie_counter = self._Gilza_junkie_counter * math.random(550,700)/1000 -- rand value between 0.55 and 0.7
				if self:get_current_state()._unit and alive(self:get_current_state()._unit) and self:get_current_state()._unit:movement() then
					junkie_exhausted = true
					self:get_current_state()._unit:movement():_change_stamina(-999999)
				end
				DelayedCalls:Add("Gilza_remove_junkie_status", 4, function()
					junkie_exhausted = false
				end)
			end
		else
			if self._Gilza_junkie_counter > 70 and not self._Gilza_junkie_eligible_for_spike and not self._Gilza_junkie_adrenaline_spike then
				self._Gilza_junkie_eligible_for_spike = self._Gilza_junkie_eligible_for_spike or false
				ticks_since_entered_adrenaline_spike_range = ticks_since_entered_adrenaline_spike_range + 1
				if ticks_since_entered_adrenaline_spike_range >= 400 then -- 20 seconds total
					self._Gilza_junkie_eligible_for_spike = true
				end
			end
			if self._Gilza_junkie_adrenaline_spike then
				icon:animate(info_hud.flash_icon, 999999)
			else
				icon:stop()
			end
			ticks_since_reached_high_stacks = 0
		end
		
		-- avoid going below 0
		if self._Gilza_junkie_counter < 0 then
			self._Gilza_junkie_counter = 0
		end
		-- avoid going over 100
		if self._Gilza_junkie_counter > 100 then
			self._Gilza_junkie_counter = 100
		end
		-- avoid going away from 999 during a spike
		if self._Gilza_junkie_adrenaline_spike then
			self._Gilza_junkie_counter = 999
		end
		
		-- adrenaline spike stuff
		-- if eligible and it was activated, maintain 999 stacks during the spike
		if self._Gilza_junkie_eligible_for_spike and self._Gilza_junkie_adrenaline_spike then
			self._Gilza_junkie_counter = 999
			junkie_exhausted = false
			-- restore max stamina for the spike
			if self:get_current_state()._unit and alive(self:get_current_state()._unit) and self:get_current_state()._unit:movement() then
				self:get_current_state()._unit:movement():_change_stamina(999999)
			end
			-- prevent this chunk from looping indefinetely
			self._Gilza_junkie_eligible_for_spike = false
			ticks_since_entered_adrenaline_spike_range = 0
			DelayedCalls:Add("Gilza_remove_junkie_spike", 8, function()
				-- after spike is complete remove eligibility, reset values, and apply harsher version of exhaustion
				ticks_since_entered_adrenaline_spike_range = 0
				self._Gilza_junkie_adrenaline_spike = false
				self._Gilza_junkie_counter = math.random(1500,2500)/100
				junkie_exhausted = true
				if self:get_current_state()._unit and alive(self:get_current_state()._unit) and self:get_current_state()._unit:movement() then
					self:get_current_state()._unit:movement():_change_stamina(-999999)
				end
				DelayedCalls:Add("Gilza_remove_junkie_spike_pt2", 4, function()
					junkie_exhausted = false
				end)
			end)
		end
		
		-- color adjustments, UI element goes from white to yelow then to green then to red; blue for the spike
		if self._Gilza_junkie_adrenaline_spike then -- adrenaline spike
			-- spike will flash from blue to white color to indicate the "FUCKING RUN" feeling
			spike_flash_timer = spike_flash_timer + 1
			if spike_flash_timer >= 4 then
				self._Gilza_junkie_counter_GUI:set_color(Color(1, 1, 1, 1))
				icon:set_color(Color(1, 1, 1, 1))
				if spike_flash_timer >= 5 then
					spike_flash_timer = 0
				end
			else
				self._Gilza_junkie_counter_GUI:set_color(Color(1, 0.1, 0.4, 0.84))
				icon:set_color(Color(1, 0.1, 0.4, 0.84))
			end
		elseif junkie_exhausted then -- dark purple if we have the high meter debuff
			self._Gilza_junkie_counter_GUI:set_color(Color(1, 0.6, 0, 0.6))
			icon:set_color(Color(1, 0.6, 0, 0.6))
		elseif self._Gilza_junkie_counter < 38 then -- white to yellow
			local color = math.lerp(Color(1, 1, 1, 1), Color(1, 1, 1, 0.4), self._Gilza_junkie_counter / 42)
			self._Gilza_junkie_counter_GUI:set_color(color)
			icon:set_color(color)
		elseif self._Gilza_junkie_counter < 90 then -- yellow to green
			local color = math.lerp(Color(1, 1, 1, 0.4), Color(1, 0, 1, 0), (self._Gilza_junkie_counter - 42) / 54)
			self._Gilza_junkie_counter_GUI:set_color(color)
			icon:set_color(color)
		else -- red
			self._Gilza_junkie_counter_GUI:set_color(Color(1, 1, 0, 0))
			icon:set_color(Color(1, 1, 0, 0))
		end
		
		if not self._Gilza_junkie_adrenaline_spike then
			spike_flash_timer = 0
		end
		
		-- 2 numbers after decimal at most for GUI
		local text = tostring(math.floor(self._Gilza_junkie_counter * 100) / 100)
		self._Gilza_junkie_counter_GUI:set_text(text)
		self._Gilza_junkie_counter_GUI:set_outlines_visible(true)
		self._Gilza_junkie_counter_GUI:show()
		
		-- loop
		Gilza_update_junkie_loop(self)
		
	end)
end

function PlayerManager:Gilza_create_junkie_gui(image_scale,x_position,y_position)
	local hud = managers.hud:script(PlayerBase.PLAYER_INFO_HUD_PD2)
	self._Gilza_junkie_counter_GUI = OutlinedText:new(hud.panel, {
		name = "Gilza_speed_junkie_GUI_counter",
		visible = true,
		text = "default",
		valign = "center",
		align = "center",
		layer = 5,
		color = Color(1, 1, 1, 1),
		font = tweak_data.menu.pd2_large_font,
		font_size = math.floor(24 * image_scale),
		w = 60 * image_scale,
		h = 60 * image_scale,
		x = x_position,
		y = 60 * image_scale + y_position
	})
	self._Gilza_junkie_counter_GUI:set_text("0")
	self._Gilza_junkie_counter_GUI:set_outlines_visible(true)
	self._Gilza_junkie_counter_GUI:set_alpha(1)
	self._Gilza_junkie_counter_GUI:show()
	self._Gilza_junkie_counter_GUI:set_visible(true)
	
	self._Gilza_junkie_counter = 0
	Gilza_update_junkie_loop(self)
end

local orig_skill_dodge_chance = PlayerManager.skill_dodge_chance
Hooks:OverrideFunction(PlayerManager, "skill_dodge_chance", function (self, running, crouching, on_zipline, override_armor, detection_risk)
	local result = orig_skill_dodge_chance(self, running, crouching, on_zipline, override_armor, detection_risk)
	if managers.player:has_category_upgrade("player", "speed_junkie_meter") then
		self._Gilza_junkie_counter = self._Gilza_junkie_counter or 0
		local junkie_adds_dodge = self._Gilza_junkie_counter / 100 * 0.4 -- up to 40% dodge max
		result = result + junkie_adds_dodge
	end
	return result
end)

local orig_attempt_tag_team = PlayerManager._attempt_tag_team
function PlayerManager:_attempt_tag_team(...)
	local success = orig_attempt_tag_team(self, ...)
	
	if not success and not self._coroutine_mgr:is_running("tag_team") then
		local player = managers.player:player_unit()
		local criminals = managers.groupai:state():all_criminals()
		if player and not table.empty(criminals) then
			local player_eye = player:camera():position()
			local player_fwd = player:camera():rotation():y()
			local tagged = nil
			local tag_distance = managers.player:upgrade_value("player", "tag_team_base").distance * 100			
			for u_key, u_data in pairs(criminals) do
				local unit = u_data.unit
				if alive(unit) and unit:movement() then
					if mvector3.distance_sq(player_eye, unit:movement():m_pos()) < tag_distance * tag_distance then
						local cam_fwd = player_fwd
						local vec = unit:movement():m_pos() - player_eye
						local dis = mvector3.normalize(vec)
						local max_angle = math.max(8, math.lerp(10, 30, dis / 1200))
						local angle = vec:angle(cam_fwd)
						if angle < max_angle or math.abs(max_angle - angle) < 10 then
							tagged = unit
							break
						end				
					end
				end
			end
			if tagged and not self._coroutine_mgr:is_running("tag_team") then
				self:add_coroutine("tag_team", PlayerAction.TagTeam, tagged, player)
				return true
			end			
		end
	end
	
	return success
end

-- updated the way armor is updated with anarchist/speed junkie deck to make it work properly, since skill health multipliers are additive instead of multiplicative for some fucking reason
Hooks:OverrideFunction(PlayerManager, "body_armor_skill_addend", function (self, override_armor)
	local addend = 0
	addend = addend + self:upgrade_value("player", tostring(override_armor or managers.blackmarket:equipped_armor(true, true)) .. "_armor_addend", 0)

	if self:has_category_upgrade("player", "armor_increase") then
		local default_health = (PlayerDamage._HEALTH_INIT + self:health_skill_addend())
		local health_multiplier = self:health_skill_multiplier()
		local anarch_health_decrease = self:upgrade_value("player", "health_decrease", 0)
		
		local perk_health_update = default_health - default_health * (1 - anarch_health_decrease)
		local skills_health_update = (health_multiplier + anarch_health_decrease) * default_health - default_health
		
		addend = addend + (perk_health_update + skills_health_update) * self:upgrade_value("player", "armor_increase", 1)
	end

	addend = addend + self:upgrade_value("team", "crew_add_armor", 0)

	return addend
end)

function PlayerManager:Gilza_start_guardian_tracking()
	if not self.Gilza_guardian_area then
		self.Gilza_guardian_area = {
			position = Vector3(0,0,0),
			is_active = false,
			radius = managers.player:upgrade_value("player", "guardian_area_range", 100),
			is_player_inside = false,
			last_attended_time = 0
		}
	end
	self:Gilza_guardian_recursive_updater()
	self:Gilza_guardian_recursive_healing()
end

function PlayerManager:Gilza_guardian_recursive_updater()
	
	local player_unit = self:player_unit()
	local area = self.Gilza_guardian_area
	
	local info_hud = managers.hud:script(PlayerBase.PLAYER_INFO_HUD_PD2)
	local icon = info_hud.panel:child("Gilza_guardian_GUI_icon")

	if alive(player_unit) then
		
		self._gilza_is_moving = player_unit:movement() and player_unit:movement()._current_state and player_unit:movement()._current_state._moving
		if not self._gilza_is_moving and not self._gilza_stopped_moving then
			self._gilza_stopped_moving = true
			self._gilza_stopped_moving_at = Application:time()
		elseif self._gilza_is_moving then
			self._gilza_stopped_moving = false
		end
		
		-- if area is active, check how far away player is, and update that info. remove zone is far away for long
		if area.is_active then
			-- set vertical axis for both positions to 0 to make this area effectively an endless vertical cylinder instead of a sphere
			local player_pos = mvector3.copy(player_unit:position())
			player_pos = Vector3(player_pos.x,player_pos.y,0)
			local area_pos = Vector3(area.position.x,area.position.y,0)
			if mvector3.distance(player_pos, area_pos) <= area.radius then
				area.is_player_inside = true
				area.last_attended_time = Application:time()
				
				icon:set_visible(true)
				icon:set_color(Color(1, 1, 1, 1))
			else
				area.is_player_inside = false
				
				icon:set_color(Color(0.2, 1, 1, 1)) -- low transperancy while ouside but active
			end
			if not area.is_player_inside and (Application:time() - area.last_attended_time) >= 8 then
				area.is_active = false
				
				icon:set_visible(false)
			end
		end
		
		-- if inactive and away for long enough, create area passively
		if not area.is_active and (Application:time() - area.last_attended_time) >= 16 then
			if self._gilza_stopped_moving and (Application:time() - self._gilza_stopped_moving_at) >= managers.player:upgrade_value("player", "guardian_area_passive_activation_timer", 10) then
				area.position = player_unit:position()
				area.is_active = true
				area.is_player_inside = true
				area.last_attended_time = Application:time()
				
				icon:set_visible(true)
				icon:set_color(Color(1, 1, 1, 1))
				player_unit:sound():play("perkdeck_activate", nil, false)
			end
		end
	else
		-- clear area info if player is dead or unit is somehow else unavailable
		area.position = Vector3(0,0,0)
		area.is_active = false
		area.radius = managers.player:upgrade_value("player", "guardian_area_range", 100)
		area.is_player_inside = false
		area.last_attended_time = 0
		
		if icon then
			icon:set_visible(false)
		end
	end
	
	--log("Area info. Location: "..tostring(area.position).."; Active: "..tostring(area.is_active).."; Radius: "..tostring(area.radius).."; Player inside: "..tostring(area.is_player_inside).."; Last inside at: "..tostring(area.last_attended_time))
	
	DelayedCalls:Add("Gilza_guardian_recursive_updater", 0.1, function(self)
		managers.player:Gilza_guardian_recursive_updater()
	end)
end

function PlayerManager:Gilza_guardian_recursive_healing()
	
	local heal_delay = 2 -- in seconds
	local player_unit = self:player_unit()
	
	if self:Gilza_is_player_in_guardian_zone() then
		if alive(player_unit) then
			local heal = managers.player:upgrade_value("player", "guardian_area_passive_health_regen", 0)
			player_unit:character_damage():restore_health(heal, true)
		end
	else
		-- if player is not inside of the zone, update loop more often, to avoid a few secs of delay before heal begins if we enter a zone again
		heal_delay = 0.05
	end
	
	DelayedCalls:Add("Gilza_guardian_recursive_heal_loop", heal_delay, function(self)
		managers.player:Gilza_guardian_recursive_healing()
	end)
end

function PlayerManager:Gilza_is_player_in_guardian_zone()
	return self.Gilza_guardian_area.is_player_inside
end

function PlayerManager:Gilza_is_guardian_zone_active()
	return self.Gilza_guardian_area.is_active
end

-- needed for new tower defense skill. area is manualy set to 8m here
function PlayerManager:is_close_to_sentry_gun()
	local player_unit = self:player_unit()
	local sentries = World:find_units_quick(player_unit, "sphere", player_unit:position(), 800, managers.slot:get_mask("sentry_gun"))
	if sentries and #sentries >=1 then
		return true
	end
	
	return false
end

Hooks:PostHook(PlayerManager, "on_enter_custody", "Gilza_on_enter_custody", function(self, _player, already_dead)
	local player = _player or self:player_unit()
	if not player then
		return
	end

	if player == self:player_unit() then
		self._Gilza_menace_kill_tracker = 0
	end
end)