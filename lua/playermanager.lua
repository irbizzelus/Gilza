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
	
	-- junkie GUI and counter updates
	if managers.player:has_category_upgrade("player", "speed_junkie_meter_on_kill") then
		if managers.hud and managers.hud:script(PlayerBase.PLAYER_INFO_HUD_PD2) then
			local hud = managers.hud:script(PlayerBase.PLAYER_INFO_HUD_PD2)
			if hud.panel:child("Gilza_speed_junkie_GUI_icon") then
				self._Gilza_junkie_counter = self._Gilza_junkie_counter or 0
				if not headshot then -- x3
					self._Gilza_junkie_counter = self._Gilza_junkie_counter + (managers.player:upgrade_value("player", "speed_junkie_meter_on_kill", 0) * 3)
				else
					self._Gilza_junkie_counter = self._Gilza_junkie_counter + managers.player:upgrade_value("player", "speed_junkie_meter_on_kill", 0)
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
local junkie_exhausted = false
local function Gilza_update_junkie_loop(self)
	DelayedCalls:Add("Gilza_update_junkie_loop", 0.05, function()
		
		-- speed related updates
		if managers.player:current_state() == "standard" or managers.player:current_state() == "carry" then
			if self and self.local_player and alive(self:local_player()) and self:local_player().movement and self:local_player():movement().current_state and self:local_player():movement():current_state()._get_max_walk_speed then
				if self:local_player():movement():current_state()._moving and not self:local_player():movement():current_state()._state_data.in_air then
					-- if moving, update junkie stacks based on movement speed, higher speed = higher gain; low speed = lose stacks
					local player_speed = self:local_player():movement():current_state():_get_max_walk_speed(managers.player:player_timer():time(),false)
					local junkie_power_adust_mul = player_speed / 590 -- 590 speed is the 'you dont loose meter' point
					local junkie_adjustment = -0.54 + (0.54 * junkie_power_adust_mul)
					self._Gilza_junkie_counter = self._Gilza_junkie_counter + junkie_adjustment
					-- tracks how many 'tics' have passed since we stopped moving, a tick for this loop is 1/20 of a second
					ticks_since_stopped_moving = 0
					ticks_moving_in_air = 0
				elseif self:local_player():movement():current_state()._state_data.in_air then
					-- if we are in air, mostly from jumping, deplete really slowly
					ticks_moving_in_air = ticks_moving_in_air + 1
					if self._Gilza_junkie_counter > 0 then
						if ticks_moving_in_air >= 30 then
							-- if a jump takes longer then 1.5 secs freeze the depletion
						else
							self._Gilza_junkie_counter = self._Gilza_junkie_counter - 0.1
						end
					end
				else
					-- if we dont't move start actively depleting junkie stacks
					ticks_since_stopped_moving = ticks_since_stopped_moving + 1
					if self._Gilza_junkie_counter > 0 then
						-- first 1 second of not moving counter depletes at a stable rate, later it speeds up
						if ticks_since_stopped_moving <= 30 then
							self._Gilza_junkie_counter = self._Gilza_junkie_counter - 0.3
						else
							self._Gilza_junkie_counter = self._Gilza_junkie_counter - (ticks_since_stopped_moving * 0.01)
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
		
		-- flash the player figure icon if we are at 96 or above stacks and apply penalties if we maintain it for long enough
		local info_hud = managers.hud:script(PlayerBase.PLAYER_INFO_HUD_PD2)
		local icon = info_hud.panel:child("Gilza_speed_junkie_GUI_icon")
		if self._Gilza_junkie_counter > 96 then
			icon:animate(info_hud.flash_icon, 999999)
			ticks_since_reached_high_stacks = ticks_since_reached_high_stacks + 1
			-- if we reach high stacks and maintain them for over 2 seconds, stamina gets drained to 0, for at least 4 seconds
			if ticks_since_reached_high_stacks >= 40 then
				self._Gilza_junkie_counter = self._Gilza_junkie_counter * math.random(450,650)/1000 -- rand value between 0.45 and 0.65
				if self:get_current_state()._unit and alive(self:get_current_state()._unit) then
					junkie_exhausted = true
					self:get_current_state()._unit:movement():_change_stamina(self:get_current_state()._unit:movement():_max_stamina() * 0.96 * -1)
				end
				DelayedCalls:Add("Gilza_remove_junkie_penalty", 6, function()
					junkie_exhausted = false
				end)
			end
		else
			if junkie_exhausted and self:get_current_state()._unit and alive(self:get_current_state()._unit) then
				-- this would've been easier if player movement had a func that allowed to set stamina to a set value instead of only allowing to 'add' values to curr stamina
				if self:get_current_state()._unit:movement() then
					local cur_stamina = self:get_current_state()._unit:movement():stamina()
					local max_stamina = self:get_current_state()._unit:movement():_max_stamina()
					if cur_stamina > max_stamina * 0.04 then
						self:get_current_state()._unit:movement():_change_stamina( (cur_stamina - max_stamina * 0.04) * -1 )
					end
				end
			end
			icon:stop()
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
		
		-- color adjustments, goes from white to yelow to green to red
		if junkie_exhausted then -- dark purple if we have the high meter debuff
			self._Gilza_junkie_counter_GUI:set_color(Color(1, 0.6, 0, 0.6))
			icon:set_color(Color(1, 0.6, 0, 0.6))
		elseif self._Gilza_junkie_counter < 42 then -- white to yellow
			local color = math.lerp(Color(1, 1, 1, 1), Color(1, 1, 1, 0.4), self._Gilza_junkie_counter / 42)
			self._Gilza_junkie_counter_GUI:set_color(color)
			icon:set_color(color)
		elseif self._Gilza_junkie_counter < 96 then -- yellow to green
			local color = math.lerp(Color(1, 1, 1, 0.4), Color(1, 0, 1, 0), (self._Gilza_junkie_counter - 42) / 54)
			self._Gilza_junkie_counter_GUI:set_color(color)
			icon:set_color(color)
		else -- red
			self._Gilza_junkie_counter_GUI:set_color(Color(1, 1, 0, 0))
			icon:set_color(Color(1, 1, 0, 0))
		end
		
		-- 2 numbers after decimal at most for GUI
		local text = tostring(math.floor(self._Gilza_junkie_counter * 100) / 100)
		self._Gilza_junkie_counter_GUI:set_text(text)
		self._Gilza_junkie_counter_GUI:set_outlines_visible(true)
		self._Gilza_junkie_counter_GUI:show()
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