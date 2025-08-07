-- made dmg resistance additive instead of multiplicative. to avoid god mode, max dmg resist is capped
Hooks:OverrideFunction(PlayerManager, "damage_reduction_skill_multiplier", function (self, damage_type)
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

	-- 2 slow and steady buffs
	if managers.network:session():local_peer():unit():movement()._current_state._moving == false or managers.player:current_state() == "bipod" then
		multiplier = multiplier - (1 - managers.player:upgrade_value("player", "not_moving_damage_reduction_bonus", 1))
	end
	if managers.player:current_state() == "bipod" then
		multiplier = multiplier - (1 - managers.player:upgrade_value("player", "not_moving_damage_reduction_bonus_bipoded", 1))
	end
	
	-- new technician skill
	if self:Gilza_is_close_to_sentry_gun() then
		multiplier = multiplier - (1 - managers.player:upgrade_value("player", "sentry_proximity_damage_resist", 1))
	end
	
	if damage_type == "bullet" then
		
		-- yakuza behind
		if managers.player:has_category_upgrade("player", "yakuza_behind_player_resist") and self._last_damage_taken_direction and self._last_damage_taken_direction ~= 69 then
			if self._last_damage_taken_direction < 0 then
				local yakuza_bhind_resist = 1
				if Global.game_settings and Global.game_settings.difficulty and Global.game_settings.difficulty == "sm_wish" then
					yakuza_bhind_resist = yakuza_bhind_resist * 2
				end
				multiplier = multiplier - (1 - self:upgrade_value("player", "yakuza_behind_player_resist", 1)) * yakuza_bhind_resist
			end
			self._last_damage_taken_direction = 69
		end
		
		-- brawler's passive
		if managers.player:player_unit():character_damage():get_real_armor() > 0 then
			if managers.player:has_category_upgrade("player", "damage_resist_brawler") then
				multiplier = multiplier - (1 - managers.player:upgrade_value("player", "damage_resist_brawler", 1))
			end
		end
		
		-- brawler teammate based
		if managers.player:has_category_upgrade("player", "damage_resist_teammates_brawler") then
			if ( managers.player:player_unit():character_damage():_max_health() / managers.player:player_unit():character_damage():get_real_health() ) >= 2 and managers.player:player_unit():character_damage():get_real_armor() > 0 then
				if self._gilza_brawler_teammates_nearby and self._gilza_brawler_teammates_nearby >= 1 then
					local skill = managers.player:upgrade_value("player", "damage_resist_teammates_brawler")
					local brawler_resist = 1
					if skill and type(skill) ~= "number" then
						brawler_resist = skill.resist
					end
					brawler_resist = 1 - brawler_resist
					
					if Global.game_settings and Global.game_settings.difficulty and Global.game_settings.difficulty == "sm_wish" then
						brawler_resist = brawler_resist * 2
					end
					
					brawler_resist = brawler_resist * self._gilza_brawler_teammates_nearby
					
					if brawler_resist > 0 then
						multiplier = multiplier - brawler_resist
					end
				end
			end
		end
		
		-- brawler legacy, distance based
		if managers.player:has_category_upgrade("player", "damage_resist_faraway_brawler") then
			local att_unit = alive(Gilza.latest_bullet_attacker_unit) and Gilza.latest_bullet_attacker_unit
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
	
	return math.round(math.clamp(multiplier, 0.2, 1) * 1000) / 1000 -- no idea why math.clamp has floating point errors, but it does.
end)

-- new speed bonuses
local gilza_orig_pm_movement_speed_multiplier = PlayerManager.movement_speed_multiplier
Hooks:OverrideFunction(PlayerManager, "movement_speed_multiplier", function (self, speed_state, bonus_multiplier, upgrade_level, health_ratio)
	
	local multiplier = gilza_orig_pm_movement_speed_multiplier(self, speed_state, bonus_multiplier, upgrade_level, health_ratio)
	
	-- fearmonger
	local panic_speed_multiplier = managers.player:temporary_upgrade_value("temporary", "speed_boost_on_panic_kill", 0)
	multiplier = multiplier + panic_speed_multiplier
	
	-- armor percentage based junkie bonus
	if self:has_category_upgrade("player", "speed_junkie_armor_berserk") then
		local skill_max_value = managers.player:upgrade_value("player", "speed_junkie_armor_berserk", 0)
		local max_armor = managers.player.local_player and alive(managers.player:local_player()) and managers.player:local_player().character_damage and managers.player:local_player():character_damage():_max_armor()
		local cur_armor = managers.player.local_player and alive(managers.player:local_player()) and managers.player:local_player().character_damage and managers.player:local_player():character_damage():get_real_armor()
		if max_armor and cur_armor then
			local addin = skill_max_value - (skill_max_value * (cur_armor / max_armor))
			multiplier = multiplier + addin
		end
	end
	
	-- yeap
	if self:has_category_upgrade("player", "guardian_movement_penalty") then
		multiplier = multiplier + self:upgrade_value("player", "guardian_movement_penalty", 1) - 1
	end
	
	return multiplier
	
end)

-- new dodge bonuses
local gilza_orig_pm_skill_dodge_chance = PlayerManager.skill_dodge_chance
Hooks:OverrideFunction(PlayerManager, "skill_dodge_chance", function (self, running, crouching, on_zipline, override_armor, detection_risk)
	local result = gilza_orig_pm_skill_dodge_chance(self, running, crouching, on_zipline, override_armor, detection_risk)
	if managers.player:has_category_upgrade("player", "speed_junkie_meter") then
		self._Gilza_junkie_counter = self._Gilza_junkie_counter or 0
		local junkie_adds_dodge = self._Gilza_junkie_counter / 100 * 0.4 -- up to 40% dodge max. probably should make this tweakable from upgradestweaks, but lazyness
		result = result + junkie_adds_dodge
	end
	-- new gambler 9th card
	if managers.player:has_category_upgrade("player", "loose_ammo_add_dodge_amount") then
		result = result + (self._gilza_gambler_new_dodge or 0) 
	end
	-- ex-president
	if managers.player:has_category_upgrade("player", "static_dodge_chance") then
		result = managers.player:upgrade_value("player", "static_dodge_chance", 0)
	end
	return result
end)

-- "on kill" buffs from new skills and perks
Hooks:PostHook(PlayerManager, "on_killshot", "Gilza_PlayerManager_post_on_killshot", function(self, killed_unit, variant, headshot, weapon_id)
	local player_unit = self:player_unit()

	if not player_unit then
		return
	end

	if CopDamage.is_civilian(killed_unit:base()._tweak_table) then
		return
	end
	
	local function skill_triggers()
		
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
		
		-- shotgun suppression on kill from fearmonger
		local shotgun_panic_on_kill = self:has_category_upgrade("shotgun", "panic_when_kill")
		if shotgun_panic_on_kill and variant ~= "melee" then
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
		
		-- temp speed boost on kill from fearmonger
		if killed_unit:movement() and killed_unit:movement()._action_common_data and killed_unit:movement()._action_common_data.is_suppressed then
			if Gilza.panicking_enemies and Gilza.panicking_enemies[killed_unit:id()] and Gilza.panicking_enemies[killed_unit:id()] ~= "removed" then
				if Gilza.settings.shotgun_skill_notification then
					managers.hud:show_hint({text = managers.localization:text("Gilza_fearmonger_trigger_notification")})
				end
				self:get_current_state()._unit:movement():_change_stamina(self:get_current_state()._unit:movement():_max_stamina()+1)
				if managers.player:has_category_upgrade("temporary", "speed_boost_on_panic_kill") then
					managers.player:activate_temporary_upgrade("temporary", "speed_boost_on_panic_kill")
					Gilza.NSI:activated_fearmonger_speed_boost()
				end
			end
		end
		
	end
	skill_triggers()
	
	local function perk_triggers()
		
		local function HITMAN()
			
			-- akimbo/pistol/smg armor recovery temp buff
			if managers.player:has_category_upgrade("temporary", "akimbo_pistol_armor_regen_timer_multiplier") and alive(player_unit) then
				if tweak_data.weapon[weapon_id] then
					for i=1, #tweak_data.weapon[weapon_id].categories do
						if tweak_data.weapon[weapon_id].categories[i] == "akimbo" or tweak_data.weapon[weapon_id].categories[i] == "pistol" or tweak_data.weapon[weapon_id].categories[i] == "smg" then
							managers.player:activate_temporary_upgrade("temporary", "akimbo_pistol_armor_regen_timer_multiplier")
							Gilza.NSI:activated_new_hitman_akimbo_recovery()
						end
					end
				end
			end
			
			-- "death dance" combo
			if managers.player:has_category_upgrade("temporary", "death_dance_combo_invulnerability") then
				
				local player_unit = self:player_unit()
				if not player_unit and not alive(player_unit) then
					return
				end
				
				if not managers.player:has_inactivate_temporary_upgrade("temporary", "death_dance_combo_invulnerability") then
					return
				end
				
				self._gilza_death_dance = self._gilza_death_dance or 0
				self._gilza_death_dance_next_kill_expected_at = self._gilza_death_dance_next_kill_expected_at or 0
				self._gilza_death_dance_invuln_end = self._gilza_death_dance_invuln_end or 0
				
				local throwables_list = {
					wpn_prj_ace = true,
					wpn_prj_four = true,
					wpn_prj_jav = true,
					wpn_prj_target = true,
					wpn_prj_hur = true
				}
				local badass_kill = (variant == "bullet" and throwables_list[weapon_id]) or variant == "melee"
				
				local function reset_combo()
					self._gilza_death_dance = 0
					self._gilza_death_dance_next_kill_expected_at = -1
					self._gilza_death_dance_invuln_end = 0
				end
				
				if badass_kill then
					if managers.player:has_inactivate_temporary_upgrade("temporary", "badass_hitman_kill_armor_regen") then
						managers.player:activate_temporary_upgrade("temporary", "badass_hitman_kill_armor_regen")
						local armor_percent = 0.2
						if managers.player:has_activate_temporary_upgrade("temporary", "player_bounty_hunter") then
							armor_percent = 0.4
						end
						player_unit:character_damage():restore_armor(player_unit:character_damage():_max_armor() * armor_percent)
					end
				end
				
				if badass_kill and self._gilza_death_dance == 0 then
					self._gilza_death_dance = 1
					self._gilza_death_dance_next_kill_expected_at = Application:time() + 1
				elseif self._gilza_death_dance >= 1 and math.abs(self._gilza_death_dance_next_kill_expected_at - Application:time()) <= 0.5 then
					if badass_kill then
						self._gilza_death_dance = self._gilza_death_dance + 2
					else
						self._gilza_death_dance = self._gilza_death_dance + 1
					end
					self._gilza_death_dance_next_kill_expected_at = Application:time() + 1
				elseif self._gilza_death_dance >= 1 and self._gilza_death_dance_next_kill_expected_at - Application:time() > 0.5 then
					-- if we got a kill before the expected time forgiveness interval, igonre the kill
				else
					reset_combo()
				end
				
				if self._gilza_death_dance == 4 or (self._gilza_death_dance == 5 and badass_kill) then
					if managers.player:has_inactivate_temporary_upgrade("temporary", "death_dance_combo_invulnerability") then
						managers.player:activate_temporary_upgrade("temporary", "death_dance_combo_invulnerability")
						duration_mul = 1
						if managers.player:has_activate_temporary_upgrade("temporary", "player_bounty_hunter") then
							duration_mul = 2
						end
						local duration = managers.player:temporary_upgrade_value("temporary", "death_dance_combo_invulnerability", 0) * duration_mul
						player_unit:sound():play("perkdeck_activate", nil, false)
						player_unit:character_damage():Gilza_add_damage_invuln_timer(duration)
						self._gilza_death_dance_invuln_end = Application:time() + duration
					end
				elseif self._gilza_death_dance >= 5 then
					reset_combo()
				end
				
			end
			
			-- bounty
			if managers.player:has_category_upgrade("temporary", "player_bounty_hunter") and alive(player_unit) then
				if self._gilza_hitman_has_active_bounty then
					if killed_unit == self._gilza_hitman_bounty_target then
						managers.player:activate_temporary_upgrade("temporary", "player_bounty_hunter")
						self._gilza_hitman_bounty_cooldown_end = Application:time() + 40
						self._gilza_hitman_has_active_bounty = false
					end
				end
			end
			
		end
		HITMAN()
		
		local function LEECH()
			
			-- heal during invuln window
			if self:has_activate_temporary_upgrade("temporary", "copr_ability") and self:has_activate_temporary_upgrade("temporary", "copr_invuln_on_segment_loss") then
				local damage_ext = player_unit:character_damage()
				local static_damage_ratio = self:upgrade_value_nil("player", "copr_static_damage_ratio")
				
				if static_damage_ratio and damage_ext then
					local health_regen = static_damage_ratio

					if health_regen > 0 then
						damage_ext:restore_health(health_regen * managers.player:upgrade_value("player", "copr_heal_during_invuln_increase", 1))
						local teammate_heal_level = managers.player:upgrade_level_nil("player", "copr_teammate_heal")
						if teammate_heal_level and damage_ext:get_real_health() > 0 then
							player_unit:network():send("copr_teammate_heal", teammate_heal_level)
							-- doubled heal for teammates from a kill during invuln. techically would still most likely be less heals per minute than vanilla leech
							if self:has_category_upgrade("player", "copr_heal_during_invuln_increase") then
								player_unit:network():send("copr_teammate_heal", teammate_heal_level)
							end
						end
						-- deactivate temp upgrade to only allow to heal ourselves once per invuln period. invuln effect itself is not attached to this upgrade
						managers.player:deactivate_temporary_upgrade("temporary", "copr_invuln_on_segment_loss")
					end
				end
			end
			
		end
		LEECH()
	
		local function BRAWLER()
			
			-- stamina on kill
			if self:get_current_state()._unit and alive(self:get_current_state()._unit) and managers.player:has_category_upgrade("player", "stamina_on_melee_kill_brawler") and variant == "melee" then
				self:get_current_state()._unit:movement():_change_stamina(self:get_current_state()._unit:movement():_max_stamina() * managers.player:upgrade_value("player", "stamina_on_melee_kill_brawler", 0))
			end
			
			-- armor regen on melee kill
			self._gilza_brawler_melee_kill_count = self._gilza_brawler_melee_kill_count or 0 -- used for delayed call naming to avoid interupting previous delayedcalls
			self._gilza_brawler_regen_count = self._gilza_brawler_regen_count or 0
			local function is_brawler_regen_allowed()
				local res = false
				if variant == "melee" then
					res = true
				elseif weapon_id == "saw" or weapon_id == "saw_secondary" then
					res = true
				elseif self._gilza_brawler_regen_count == 0 then
					res = true
				end
				return res
			end
			if managers.player:has_category_upgrade("player", "armor_regen_brawler") and player_unit:character_damage() and is_brawler_regen_allowed() then
				self._gilza_brawler_melee_kill_count = self._gilza_brawler_melee_kill_count + 1
				-- if we recieved a 4th stack, we reset very first regen effect, then next kill resets second, and so on. allows for better upkeep
				if self._gilza_brawler_melee_kill_count >= 4 then
					self._gilza_brawler_melee_kill_count = 1
				end
				-- i am too lazy to set up an proper overtime regeneration effect for armor, so here is a braindead solution
				-- add 7 delayed calls with a 0.75 interval in between each call, as a result we get 8 "ticks" every 0.75s
				local total_regen = 0
				if Global.game_settings and Global.game_settings.difficulty and Global.game_settings.difficulty == "sm_wish" then
					if managers.player:has_category_upgrade("player", "copycat_9th_card_identifier") then
						total_regen = 5.0 -- 50 hp points
					else
						total_regen = 10.0
					end
				else
					-- <= DW
					if managers.player:has_category_upgrade("player", "copycat_9th_card_identifier") then
						total_regen = 2.0
					else
						total_regen = 4.0
					end
				end
				local regen_per_tick = total_regen / 8
				if self._gilza_brawler_regen_count < 3 then
					self._gilza_brawler_regen_count = self._gilza_brawler_regen_count + 1
				end
				player_unit:character_damage():restore_armor(regen_per_tick)
				for i=1,7 do
					DelayedCalls:Add("Gilza_brawler_armor_regen_"..tostring(i).."_for_hit_number_"..tostring(self._gilza_brawler_melee_kill_count), 0.75 * i, function()
						if player_unit and alive(player_unit) and player_unit:character_damage() then
							player_unit:character_damage():restore_armor(regen_per_tick)
						end
						if i == 7 then
							self._gilza_brawler_regen_count = self._gilza_brawler_regen_count - 1
						end
					end)
				end
			end
			
		end
		BRAWLER()
		
		local function SPEED_JUNKIE()
			
			-- GUI and counter (stacks) updates
			if managers.player:has_category_upgrade("player", "speed_junkie_meter_on_kill") then
				if managers.hud and managers.hud:script(PlayerBase.PLAYER_INFO_HUD_PD2) then
					local hud = managers.hud:script(PlayerBase.PLAYER_INFO_HUD_PD2)
					if hud.panel:child("Gilza_speed_junkie_GUI_icon") then
						self._Gilza_junkie_counter = self._Gilza_junkie_counter or 0
						local amount_to_add = managers.player:upgrade_value("player", "speed_junkie_meter_on_kill", 0)
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
							player_unit:sound():play("perkdeck_activate", nil, false)
						end
					end
				end
			end
			
			-- stamina on kill
			if self:get_current_state()._unit and alive(self:get_current_state()._unit) and managers.player:has_category_upgrade("player", "speed_junkie_stamina_on_kill") then
				self:get_current_state()._unit:movement():_change_stamina(self:get_current_state()._unit:movement():_max_stamina() * managers.player:upgrade_value("player", "speed_junkie_stamina_on_kill", 0))
			end
			
		end
		SPEED_JUNKIE()
		
		local function GUARDIAN()
			
			-- area activation on kill
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
			
			-- health on kill
			if managers.player:has_category_upgrade("player", "guardian_health_on_kill") and alive(player_unit) and self:Gilza_is_player_in_guardian_zone() then
				local diff_mul = 1
				if Global.game_settings and Global.game_settings.difficulty and Global.game_settings.difficulty == "sm_wish" then
					diff_mul = 2
				end
				local heal = managers.player:upgrade_value("player", "guardian_health_on_kill", 0) * diff_mul
				player_unit:character_damage():restore_health(heal, true)
			end
			
			-- auto ammo pickup
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
			
		end
		GUARDIAN()
		
	end
	perk_triggers()
	
end)

-- reworked agressive reload, aka body economy
function PlayerManager:_Gilza_activate_bodyshot_kill_aggressive_reload(attack_data, head)
	if self:has_category_upgrade("temporary", "single_body_shot_kill_reload") then
		self._aggressive_reload_stacks = self._aggressive_reload_stacks or 0
		if attack_data and attack_data.variant ~= "projectile" then
			local weapon_unit = self:equipped_weapon_unit()

			if weapon_unit then
				local weapon = weapon_unit:base()
				
				if managers.player._gilza_new_AR_should_cancel_on_kill then
					self._aggressive_reload_stacks = 0
					managers.player._gilza_new_AR_should_cancel_on_kill = false
					self:deactivate_temporary_upgrade("temporary", "single_body_shot_kill_reload")
					Gilza.NSI:adjusted_body_economy_stacks(0, true)
				else
					if not head and weapon and weapon:fire_mode() == "single" and weapon:is_category("smg", "assault_rifle", "snp") then
						if not managers.player:has_activate_temporary_upgrade("temporary", "single_body_shot_kill_reload") then
							self:activate_temporary_upgrade("temporary", "single_body_shot_kill_reload")
						end
						
						self._aggressive_reload_stacks = self._aggressive_reload_stacks + 0.75
						if self._aggressive_reload_stacks >= 7.5 then
							self._aggressive_reload_stacks = 7.5
						end
						Gilza.NSI:adjusted_body_economy_stacks(self._aggressive_reload_stacks / 0.75)
					end
				end
			end
		end
	end
end

-- body economy ammo
function PlayerManager:_Gilza_activate_bodyshot_kill_ammo_refill(attack_data)
	if self:has_category_upgrade("player", "single_body_shot_kill_refill_ammo") then
		if attack_data and attack_data.variant ~= "projectile" then
			local weapon_unit = self:equipped_weapon_unit()

			if weapon_unit then
				local weapon = weapon_unit:base()

				if weapon and weapon:fire_mode() == "single" and weapon:is_category("smg", "assault_rifle", "snp") then
					local player_unit = self:player_unit()
					local inventory = player_unit:inventory()
					
					if not player_unit:character_damage():dead() and inventory then
						local picked_up = false
						local available_selections = {}

						for i, weapon in pairs(inventory:available_selections()) do
							if inventory:is_equipped(i) then
								table.insert(available_selections, 1, weapon)
							else
								table.insert(available_selections, weapon)
							end
						end

						for _, weapon in ipairs(available_selections) do
							local success, add_amount = nil
							local pick_up_mul = managers.player:upgrade_value("player", "single_body_shot_kill_refill_ammo", 0)
							success, add_amount = weapon.unit:base():add_ammo(pick_up_mul)
							picked_up = success or picked_up
						end
						
						if picked_up then
							player_unit:sound():play(self._pickup_event or "pickup_ammo", nil, true)
							for id, weapon in pairs(inventory:available_selections()) do
								managers.hud:set_ammo_amount(id, weapon.unit:base():ammo_info())
							end
						end
					end
					
				end
				
			end
			
		end
	end
end

-- lock n load's skill. a few adjustments to make infohud's track new reload bonus better
Hooks:OverrideFunction(PlayerManager, "_on_enter_shock_and_awe_event", function (self)
	if not self._coroutine_mgr:is_running("automatic_faster_reload") then
		local equipped_unit = self:get_current_state()._equipped_unit
		local data = self:upgrade_value("player", "automatic_faster_reload", nil)
		local is_grenade_launcher = equipped_unit:base():is_category("grenade_launcher")

		if data and equipped_unit and not is_grenade_launcher and (equipped_unit:base():fire_mode() == "auto" or equipped_unit:base():is_category("minigun", "flamethrower")) then
			self._coroutine_mgr:add_and_run_coroutine("automatic_faster_reload", PlayerAction.ShockAndAwe, self, data.target_enemies, data.max_reload_increase, data.min_reload_increase, data.penalty, data.min_bullets, equipped_unit)
			
			-- INFOHUD UI
			-- current value calculations
			local reload_multiplier = data.min_reload_increase
			local ammo = equipped_unit:base():get_ammo_max_per_clip()
			if self:has_category_upgrade("player", "automatic_mag_increase") and equipped_unit:base():is_category("smg", "assault_rifle", "lmg") then
				ammo = ammo - self:upgrade_value("player", "automatic_mag_increase", 0)
			end
			local ammo_fired = ammo - equipped_unit:base():get_ammo_remaining_in_clip()
			if data.min_bullets < ammo_fired then
				local num_bullets = ammo_fired - data.min_bullets

				for i = 1, num_bullets do
					reload_multiplier = reload_multiplier + (data.penalty-1)
				end
			end
			reload_multiplier = math.clamp(reload_multiplier,data.min_reload_increase,data.max_reload_increase)
			-- enable and set value
			Gilza.NSI:new_lock_n_load_status(true)
			Gilza.NSI:new_lock_n_load_buff_update(reload_multiplier)
		end
	end
end)

-- fix lock and load aced target kill propety being static, instead of being taken from the skill value
Hooks:PostHook(PlayerManager, "_setup", "Gilza_PlayerManager_post_setup", function(self)
	local skill = self:upgrade_value("player", "automatic_faster_reload")
	local val
	if skill and type(skill) ~= "number" then
		val = skill.target_enemies
	end
	self._SHOCK_AND_AWE_TARGET_KILLS = val or 3 -- but still default to our new value
	self._Gilza_menace_kill_tracker = 0 -- murderhobo from stockholm syndrome
end)

-- clear stockholm stacks
Hooks:PreHook(PlayerManager, "on_enter_custody", "Gilza_pm_pre_on_enter_custody", function(self, _player, already_dead)
	local player = _player or self:player_unit()
	if not player then
		return
	end

	if player == self:player_unit() then
		self._Gilza_menace_kill_tracker = 0
		Gilza.New_Skills_Informer:adjusted_stockholm_stacks(0, true)
	end
end)

-- aced bullseye
Hooks:OverrideFunction(PlayerManager, "on_headshot_dealt", function (self)
	local player_unit = self:player_unit()

	if not player_unit then
		return
	end
	
	if self:has_category_upgrade("player", "headshot_regen_armor_shorter_cooldown") then
		tweak_data.upgrades.on_headshot_dealt_cooldown = 1.5
	end

	self._message_system:notify(Message.OnHeadShot, nil, nil)

	local t = Application:time()

	if self._on_headshot_dealt_t and t < self._on_headshot_dealt_t then
		return
	end

	self._on_headshot_dealt_t = t + (tweak_data.upgrades.on_headshot_dealt_cooldown or 0)
	local damage_ext = player_unit:character_damage()
	local regen_armor_bonus = managers.player:upgrade_value("player", "headshot_regen_armor_bonus", 0)

	if damage_ext and regen_armor_bonus > 0 then
		damage_ext:restore_armor(regen_armor_bonus)
	end

	local regen_health_bonus = managers.player:upgrade_value("player", "headshot_regen_health_bonus", 0)
	
	-- reduce heal for copycat's headshot heal amount. this keeps the heal per minute amount the same without breaking infohuds, but does make it slighlty harder to use.
	if self:has_category_upgrade("player", "headshot_regen_armor_shorter_cooldown") and regen_health_bonus > 0 then
		regen_health_bonus = regen_health_bonus * 0.75
	end
	
	if damage_ext and regen_health_bonus > 0 then
		damage_ext:restore_health(regen_health_bonus, true)
	end
end)

-- lethal fall damage resist, code based on messiah skill implementaion
Hooks:PostHook(PlayerManager, "check_skills", "Gilza_posthook_pm_check_skills", function(self)
	-- charge based fall_damage_immunity
	if self:has_category_upgrade("player", "limited_fall_damage_immunity") then
		self._limited_fall_damage_charges = self:upgrade_value("player", "limited_fall_damage_immunity", 0)
		self._max_limited_fall_damage_charges = self._limited_fall_damage_charges
		
		self._message_system:register(Message.OnDoctorBagUsed, "recharge_limited_fall_damage", callback(self, self, "_on_limited_fall_damage_recharge_event"))
	else
		self._limited_fall_damage_charges = 0
		self._max_limited_fall_damage_charges = self._limited_fall_damage_charges
		self._message_system:unregister(Message.OnDoctorBagUsed, "recharge_limited_fall_damage")
	end
end)

function PlayerManager:limited_fall_damage_charges()
	return self._limited_fall_damage_charges
end

function PlayerManager:use_limited_fall_damage_charge()
	if self._limited_fall_damage_charges then
		self._limited_fall_damage_charges = math.max(self._limited_fall_damage_charges - 1, 0)
	end
end

function PlayerManager:_on_limited_fall_damage_recharge_event()
	if self._limited_fall_damage_charges and self._max_limited_fall_damage_charges then
		self._limited_fall_damage_charges = math.min(self._limited_fall_damage_charges + 1, self._max_limited_fall_damage_charges)
	end
end

-- needed for new tower defense skill. area is manualy set to 8m here
-- todo: sentry gun slot mask is a friendly sentry gun, which means that purchasable sentries on golden grin count for it. at least i think, so maybe add some checks for it?
function PlayerManager:Gilza_is_close_to_sentry_gun()
	local player_unit = self:player_unit()
	local sentries = World:find_units_quick(player_unit, "sphere", player_unit:position(), 800, managers.slot:get_mask("sentry_gun"))
	if sentries and #sentries >=1 then
		return true
	end
	
	return false
end

-- muscle 9th card buff for DS
local gilza_orig_PlayerManager_health_regen = PlayerManager.health_regen
Hooks:OverrideFunction(PlayerManager, "health_regen", function (self)
	local res = gilza_orig_PlayerManager_health_regen(self)
	local adjustments_wanted = 0
	if managers.player:has_category_upgrade("player", "passive_health_regen") then
		-- copycat's reduced heal
		if managers.player:has_category_upgrade("player", "copycat_9th_card_identifier") then
			adjustments_wanted = adjustments_wanted - 0.015
		end
		-- DS increased heal
		if Global.game_settings and Global.game_settings.difficulty and Global.game_settings.difficulty == "sm_wish" then
			if managers.player:has_category_upgrade("player", "copycat_9th_card_identifier") then
				-- but not so much for kitty
				adjustments_wanted = adjustments_wanted + 0.01
			else
				adjustments_wanted = adjustments_wanted + 0.02
			end
		end
	end
	Gilza.NSI:new_passive_health_regen_adjustment(adjustments_wanted)
	return res + adjustments_wanted
end)

-- new biker preventions
Hooks:OverrideFunction(PlayerManager, "chk_wild_kill_counter", function (self, killed_unit, variant)
	local player_unit = self:player_unit()

	if not player_unit then
		return
	end

	if CopDamage.is_civilian(killed_unit:base()._tweak_table) then
		return
	end

	local damage_ext = player_unit:character_damage()

	if damage_ext and (managers.player:has_category_upgrade("player", "wild_health_amount") or managers.player:has_category_upgrade("player", "wild_armor_amount")) then
		self._wild_kill_triggers = self._wild_kill_triggers or {}
		self._wild_kills_stored = self._wild_kills_stored or {}
		local t = Application:time()

		while self._wild_kill_triggers[1] and self._wild_kill_triggers[1] <= t do
			table.remove(self._wild_kill_triggers, 1)
		end

		if tweak_data.upgrades.wild_max_triggers_per_time <= #self._wild_kill_triggers then
			return
		end

		local trigger_cooldown = tweak_data.upgrades.wild_trigger_time or 30
		local wild_health_amount = managers.player:upgrade_value("player", "wild_health_amount", 0)
		local wild_armor_amount = managers.player:upgrade_value("player", "wild_armor_amount", 0)
		local less_health_wild_armor = managers.player:upgrade_value("player", "less_health_wild_armor", 0)
		local less_armor_wild_health = managers.player:upgrade_value("player", "less_armor_wild_health", 0)
		local less_health_wild_cooldown = managers.player:upgrade_value("player", "less_health_wild_cooldown", 0)
		local less_armor_wild_cooldown = managers.player:upgrade_value("player", "less_armor_wild_cooldown", 0)
		local missing_health_ratio = math.clamp(1 - damage_ext:health_ratio(), 0, 1)
		local missing_armor_ratio = math.clamp(1 - damage_ext:armor_ratio(), 0, 1)

		if less_health_wild_armor ~= 0 and less_health_wild_armor[1] ~= 0 then
			local missing_health_stacks = math.floor(missing_health_ratio / less_health_wild_armor[1])
			wild_armor_amount = wild_armor_amount + less_health_wild_armor[2] * missing_health_stacks
		end

		if less_armor_wild_health ~= 0 and less_armor_wild_health[1] ~= 0 then
			local missing_armor_stacks = math.floor(missing_armor_ratio / less_armor_wild_health[1])
			wild_health_amount = wild_health_amount + less_armor_wild_health[2] * missing_armor_stacks
		end
		
		-- new prevention var
		local regen_pause_duration = tweak_data.upgrades.values.player.wild_temporary_regen_pause_default[1]
		
		if less_health_wild_cooldown ~= 0 and less_health_wild_cooldown[1] ~= 0 then
			local missing_health_stacks = math.floor(missing_health_ratio / less_health_wild_cooldown[1])
			trigger_cooldown = trigger_cooldown - less_health_wild_cooldown[2] * missing_health_stacks
			regen_pause_duration = regen_pause_duration - 0.025 * missing_health_stacks
		end

		if less_armor_wild_cooldown ~= 0 and less_armor_wild_cooldown[1] ~= 0 then
			local missing_armor_stacks = math.floor(missing_armor_ratio / less_armor_wild_cooldown[1])
			trigger_cooldown = trigger_cooldown - less_armor_wild_cooldown[2] * missing_armor_stacks
			regen_pause_duration = regen_pause_duration - 0.025 * missing_armor_stacks
		end
		
		-- only heal if armor or health is damaged
		local did_restore = false
		-- for some very reasonable reasons these 2 damage extension functions can return the same number but not be equal
		-- if i log these numbers they will both show up as 23 and 23, yet not be equal. and when i substract one from the other result turns up to be -7
		-- im definetly too stupid to understand why it works this way software logic wise, but why this was never an issue for OVK devs is also confusing.
		-- rounding them like this seems to fix it somehow as well. idek why, but it works, so here it is.
		local curr_armor = math.round(damage_ext:get_real_armor() * 100) / 100
		local max_armor = math.round(damage_ext:_max_armor() * 100) / 100
		if not (damage_ext:get_real_health() == damage_ext:_max_health()) or not (curr_armor == max_armor) then
			if curr_armor > 0 then
				-- dont allow wasting stacks while armor is >0
				if managers.player:has_category_upgrade("temporary", "player_wild_temporary_regen_pause") and not managers.player:has_activate_temporary_upgrade("temporary", "player_wild_temporary_regen_pause") then
					tweak_data.upgrades.values.temporary.player_wild_temporary_regen_pause[1][2] = regen_pause_duration -- reduce cooldown duration if armor/health is damaged
					managers.player:activate_temporary_upgrade("temporary", "player_wild_temporary_regen_pause")
					damage_ext:restore_health(wild_health_amount, true, false)
					damage_ext:restore_armor(wild_armor_amount)
					did_restore = true
				end
			else
				damage_ext:restore_health(wild_health_amount, true, false)
				damage_ext:restore_armor(wild_armor_amount)
				did_restore = true
			end
		end

		local trigger_time = t + math.max(trigger_cooldown, 0)
		local insert_index = #self._wild_kill_triggers

		while insert_index > 0 and trigger_time < self._wild_kill_triggers[insert_index] do
			insert_index = insert_index - 1
		end
		
		-- only add a kill based stack that actualy healed
		if did_restore then
			table.insert(self._wild_kill_triggers, insert_index + 1, trigger_time)
		end
	end
end)

-- leech deactivation cleanup
Hooks:OverrideFunction(PlayerManager, "clbk_copr_ability_ended", function (self)
	self:deactivate_temporary_upgrade("temporary", "copr_ability")

	local player_unit = self:local_player()
	local character_damage = alive(player_unit) and player_unit:character_damage()

	if character_damage then
		local health_ratio = character_damage:health_ratio()
		local static_damage_ratio = self:upgrade_value("player", "copr_static_damage_ratio", 0) - 1e-08
		local out_of_health = health_ratio < static_damage_ratio
		local risen_from_dead = self:get_property("copr_risen", false) == true

		character_damage:on_copr_ability_deactivated()

		if self._Gilza_leech_did_revive_during_effect then
			managers.player._block_medkit_auto_revive = false
			character_damage:restore_health(character_damage:_max_health() * 0.5, true, false)
			character_damage:restore_armor(character_damage:_max_armor())
			self._Gilza_leech_did_revive_during_effect = false
		elseif out_of_health or risen_from_dead then
			character_damage:force_into_bleedout(false, risen_from_dead)
		end
	end

	self:set_property("copr_risen", nil)
	managers.hud:set_copr_indicator(false)
end)

-- leech activate
Hooks:OverrideFunction(PlayerManager, "_attempt_copr_ability", function (self)
	if self:has_activate_temporary_upgrade("temporary", "copr_ability") then
		return false
	end

	local character_damage = self:local_player():character_damage()
	local duration = self:upgrade_value("temporary", "copr_ability")[2]
	local now = managers.game_play_central:get_heist_timer()

	managers.network:session():send_to_peers("sync_ability_hud", now + duration, duration)

	local is_downed = game_state_machine:verify_game_state(GameStateFilters.downed)

	self:set_property("copr_risen", is_downed)

	if is_downed then
		character_damage:revive(true)
	end

	self:activate_temporary_upgrade("temporary", "copr_ability")
	
	-- use our own BLT delayed call. i honestly have no idea why, but sometimes clbk_copr_ability_ended is not called after the 6-10 sec time window of the ampule effect expires
	-- leading to player having no armor, segmented health UI (but not actualy segmented health) and no invulnerability/heal procing
	-- todo: WHY IS IT HAPPENING?!?!
	DelayedCalls:Add("Gilza_force_deactivate_leech_at_"..tostring(now), duration - 0.0001, function()
		managers.player:clbk_copr_ability_ended()
	end)
	--local expire_time = self:get_activate_temporary_expire_time("temporary", "copr_ability")
	--managers.enemy:add_delayed_clbk("copr_ability_active", callback(self, self, "clbk_copr_ability_ended"), expire_time)
	
	managers.hud:activate_teammate_ability_radial(HUDManager.PLAYER_PANEL, duration)

	local bonus_health = self:upgrade_value("player", "copr_activate_bonus_health_ratio", tweak_data.upgrades.values.player.copr_activate_bonus_health_ratio[1])

	character_damage:restore_health(bonus_health)
	character_damage:set_armor(0)
	character_damage:send_set_status()

	local speed_up_on_kill_time = self:upgrade_value("player", "copr_speed_up_on_kill", 0)

	if speed_up_on_kill_time > 0 then
		local function speed_up_on_kill_func()
			managers.player:speed_up_grenade_cooldown(speed_up_on_kill_time)
		end

		self:register_message(Message.OnEnemyKilled, "speed_up_copr_ability", speed_up_on_kill_func)
	end

	character_damage:on_copr_ability_activated()

	self._copr_kill_life_leech_num = 0
	local static_damage_ratio = self:upgrade_value("player", "copr_static_damage_ratio", 0)

	managers.hud:set_copr_indicator(true, static_damage_ratio)

	if is_downed then
		self:register_message("ability_activated", "copr_risen_cooldown_key", callback(self, self, "add_copr_risen_cooldown"))
	end

	return true
end)

-- if we deal damage, delay maniac's decay by it's decay interval
Hooks:PreHook(PlayerManager, "_update_damage_dealt", "Gilza_pre_update_damage_dealt", function(self, t, dt)
	if self._damage_dealt_to_cops_recently and self._damage_dealt_to_cops_recently > 0 then
		self._damage_dealt_to_cops_decay_t = t + (tweak_data.upgrades.cocaine_stacks_decay_t or 5)
		self._damage_dealt_to_cops_recently = 0
	end
end)

-- grab latest damage for maniac changes
Hooks:PostHook(PlayerManager, "_check_damage_to_cops", "Gilza_post_check_damage_to_cops", function(self, t, unit, damage_info)
	local player_unit = self:player_unit()

	if alive(player_unit) and not player_unit:character_damage():need_revive() and player_unit:character_damage():dead() then
		-- Nothing
	end

	if not alive(unit) or not unit:base() or not damage_info then
		return
	end

	if CopDamage.is_civilian(unit:base()._tweak_table) then
		return
	end
	
	self._damage_dealt_to_cops_recently = 0 + (damage_info.damage or 0)
end)

-- adds absorption for 9th maniac card on DS
Hooks:OverrideFunction(PlayerManager, "damage_absorption", function (self)
	local total = 0

	for _, absorption in pairs(self._damage_absorption) do
		total = total + Application:digest_value(absorption, false)
	end
	
	-- new dmg absorb bonuses for brawler
	if managers.player:has_category_upgrade("player", "damage_resist_teammates_brawler") then
		if self._gilza_brawler_teammates_nearby and self._gilza_brawler_teammates_nearby >= 1 and (managers.player:player_unit():character_damage():_max_health() / managers.player:player_unit():character_damage():get_real_health()) >= 2 then
			local skill = managers.player:upgrade_value("player", "damage_resist_teammates_brawler")
			local brawler_absorb = 0
			if skill and type(skill) ~= "number" then
				brawler_absorb = skill.absorption
			end
			
			if Global.game_settings and Global.game_settings.difficulty and Global.game_settings.difficulty == "sm_wish" then
				brawler_absorb = brawler_absorb * 2
			end
			
			brawler_absorb = brawler_absorb * self._gilza_brawler_teammates_nearby
			
			total = total + brawler_absorb
		end
	end
	
	-- add more absorption for maniac on DS
	local diff_mul = 1
	if managers.player:has_category_upgrade("player", "cocaine_stack_absorption_multiplier") and Global.game_settings and Global.game_settings.difficulty and Global.game_settings.difficulty == "sm_wish" then
		diff_mul = 1.5
	end

	total = total + (self:get_best_cocaine_damage_absorption(managers.network:session():local_peer():id()) * diff_mul)
	total = managers.modifiers:modify_value("PlayerManager:GetDamageAbsorption", total)

	return total
end)

-- ex-president's new 9th card - team kill tracking. used for new armor regen time bonuses. 
Hooks:PostHook(PlayerManager, "chk_store_armor_health_kill_counter", "Gilza_post_chk_store_armor_health_kill_counter", function(self, killed_unit, variant)
	local player_unit = self:player_unit()

	if not player_unit then
		return
	end

	if CopDamage.is_civilian(killed_unit:base()._tweak_table) then
		return
	end
	
	if self:has_category_upgrade("player", "store_armor_recovery_bonus_timer") then
		self._gilza_armor_regen_bonus_timer_on_kill = (self._gilza_armor_regen_bonus_timer_on_kill or 0) - managers.player:body_armor_value("skill_store_armor_recovery_bonus_timer", nil, 0)
	end
end)

-- returns all armor stats. if we have static dodge, set armor's dodge stat to 0. static dodge itself is set in the dodge func
local gilza_orig_pm_body_armor_value = PlayerManager.body_armor_value
Hooks:OverrideFunction(PlayerManager, "body_armor_value", function (self, category, override_value, default)
	if category == "dodge" then
		if managers.player:has_category_upgrade("player", "static_dodge_chance") then
			return 0
		else
			return gilza_orig_pm_body_armor_value(self, category, override_value, default)
		end
	else
		return gilza_orig_pm_body_armor_value(self, category, override_value, default)
	end
end)

-- report current bonus as a negative timer reduction
function PlayerManager:Gilza_new_expres_armor_regen_bonus_timer_on_kill()
	return self._gilza_armor_regen_bonus_timer_on_kill or 0
end

function PlayerManager:Gilza_new_expres_armor_regen_bonus_timer_on_kill_reset()
	self._gilza_armor_regen_bonus_timer_on_kill = 0
end

-- override tag team LOS check
local orig_attempt_tag_team = PlayerManager._attempt_tag_team
Hooks:OverrideFunction(PlayerManager, "_attempt_tag_team", function (self, ...)
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
end)

-- before activating PECM, set it's duration based on game state (stealth/loud)
Hooks:PreHook(PlayerManager, "_attempt_pocket_ecm_jammer", "Gilza_attempt_pocket_ecm_jammer", function(self)
	if managers.groupai and not managers.groupai:state():whisper_mode() then
		tweak_data.upgrades.values.player.pocket_ecm_jammer_base[1].duration = 12
	else
		tweak_data.upgrades.values.player.pocket_ecm_jammer_base[1].duration = 6
	end
end)

function PlayerManager:Gilza_add_gambler_new_dodge(amount)
	self._gilza_gambler_new_dodge = (self._gilza_gambler_new_dodge or 0) + amount
	if self._gilza_gambler_new_dodge < 0 then
		self._gilza_gambler_new_dodge = 0
	end
	if self._gilza_gambler_new_dodge > 0.35 then
		self._gilza_gambler_new_dodge = 0.35
	end
end

function PlayerManager:Gilza_new_gambler_triggered(heal_gamble)
	self._gilza_new_gambler_activated_recently = true
	DelayedCalls:Add("Gilza_new_gambler_trigger_deactivate", 2, function(self) -- detemines for how long icon will have effect color and flash if its a jackpot
		managers.player._gilza_new_gambler_activated_recently = false
	end)
	
	self._gilza_new_gambler_recent_effect = heal_gamble.effect
	self._gilza_new_gambler_recent_is_jackpot = heal_gamble.jackpot
end

-- ui and sound updates
local new_gambler_jackpoint_flash_cycle = 0
local jackpot_announced = false
function PlayerManager:Gilza_new_gambler_recursive_updater()
	
	local player_unit = self:player_unit()
	
	local info_hud = managers.hud:script(PlayerBase.PLAYER_INFO_HUD_PD2)
	local icon = info_hud.panel:child("Gilza_new_gambler_GUI_icon")

	if alive(player_unit) then
		
		if self._gilza_new_gambler_activated_recently then -- first 1 second manager
			-- color
			if self._gilza_new_gambler_recent_effect == "add" then
				icon:set_color(Color(1, 0.06, 0.65, 0.27)) -- prettier green
			elseif self._gilza_new_gambler_recent_effect == "remove" then
				icon:set_color(Color(1, 0.73, 0.24, 0)) -- prettier red
			else
				icon:set_color(Color(0.9, 1, 1, 1)) -- full white
			end
			
			-- jackpot flash
			if self._gilza_new_gambler_recent_is_jackpot then
				if not jackpot_announced then
					player_unit:sound():play("perkdeck_activate", nil, false)
					jackpot_announced = true
				end
				
				new_gambler_jackpoint_flash_cycle = new_gambler_jackpoint_flash_cycle + 1
				
				if new_gambler_jackpoint_flash_cycle < 4 then
					icon:set_visible(false)
				else
					icon:set_visible(true)
				end
				
				if new_gambler_jackpoint_flash_cycle == 7 then
					new_gambler_jackpoint_flash_cycle = 0
				end
			else
				icon:set_visible(true)
			end
			
			if self:has_category_upgrade("player", "loose_ammo_add_dodge_amount") then
				self._Gilza_new_gambler_dodge_counter_GUI:set_visible(true)
				local text = (self._gilza_gambler_new_dodge or 0) * 100
				self._Gilza_new_gambler_dodge_counter_GUI:set_text(tostring(text).." %")
				self._Gilza_new_gambler_dodge_counter_GUI:set_outlines_visible(true)
				self._Gilza_new_gambler_dodge_counter_GUI:show()
			end
			
		else -- other time
			icon:set_visible(true)
			if self:has_activate_temporary_upgrade("temporary", "loose_ammo_restore_health") then
				jackpot_announced = false
				icon:set_color(Color(1, 1, 1, 1)) -- low transperancy while on cooldown
			else
				icon:set_color(Color(0.2, 1, 1, 1)) -- active white icon indicating cooldown
			end
		end
	else
		if icon then
			icon:set_visible(false)
		end
	end
	
	DelayedCalls:Add("Gilza_new_gambler_recursive_updater", 0.05, function(self)
		managers.player:Gilza_new_gambler_recursive_updater()
	end)
end

-- ui/sound updates + bounty target finder/activator
local new_hitman_bounty_notifier_flash_cycle = 0
function PlayerManager:Gilza_new_hitman_recursive_updater()
	
	self._gilza_hitman_has_active_bounty = self._gilza_hitman_has_active_bounty or false
	self._gilza_hitman_bounty_target = self._gilza_hitman_bounty_target or false
	self._gilza_hitman_bounty_cooldown_end = self._gilza_hitman_bounty_cooldown_end or 0
	self._gilza_death_dance = self._gilza_death_dance or 0
	self._gilza_death_dance_next_kill_expected_at = self._gilza_death_dance_next_kill_expected_at or 0
	self._gilza_hitman_bounty_received_at = self._gilza_hitman_bounty_received_at or 0
	
	local player_unit = managers.player:player_unit()
	
	if player_unit and alive(player_unit) and not self._gilza_hitman_has_active_bounty and Application:time() >= self._gilza_hitman_bounty_cooldown_end then
		
		local enemies = World:find_units_quick(player_unit, "sphere", player_unit:position(), 2500, managers.slot:get_mask("enemies"))
		if enemies and #enemies > 0 then
			
			local best_dist = 999999
			local prefered_bounty = false
			for i, enemy in pairs(enemies) do
				local function is_enemy_enemy()
					if not enemy or not player_unit or not player_unit:movement() or not enemy:movement() or not player_unit:movement():team() or not enemy:movement():team() then
						return false
					end
					if enemy:brain()._current_logic_name == "trade" then
						return false
					end
					return player_unit:movement():team().foes[enemy:movement():team().id] and true or false
				end
				
				if alive(enemy) and is_enemy_enemy() then
					
					local dist = mvector3.distance(enemy:position(), player_unit:position())

					if dist < best_dist then
						best_dist = dist
						if best_dist <= 1500 then -- prioritise first found enemy within 15m
							if prefered_bounty then
								break
							else
								prefered_bounty = enemy
								break
							end
						end
						prefered_bounty = enemy
					end
					
				end
			end
			
			if prefered_bounty then
				self._gilza_hitman_bounty_target = prefered_bounty
				prefered_bounty:contour():add("generic_interactable_selected", false)
				self._gilza_hitman_has_active_bounty = true
				self._gilza_hitman_bounty_received_at = Application:time()
			end
		
		end
		
	end
	
	if managers.player:has_category_upgrade("temporary", "death_dance_combo_invulnerability") then
		if self._gilza_death_dance >= 1 and self._gilza_death_dance_next_kill_expected_at - Application:time() <= -0.3 then
			self._gilza_death_dance = 0
			self._gilza_death_dance_next_kill_expected_at = -1
		end
		
		if managers.player._Gilza_new_hitman_combo_counter_GUI then
			if managers.player:has_activate_temporary_upgrade("temporary", "death_dance_combo_invulnerability") then
				if Application:time() > self._gilza_death_dance_invuln_end then
					managers.player._Gilza_new_hitman_combo_counter_GUI:set_text("") -- invuln end CD
					managers.player._Gilza_new_hitman_combo_counter_GUI:set_color(Color(1, 1, 0, 0))
				else
					managers.player._Gilza_new_hitman_combo_counter_GUI:set_text("") -- active invuln skull
					managers.player._Gilza_new_hitman_combo_counter_GUI:set_color(Color(1, 0, 0.5, 0.9))
				end
			else
				managers.player._Gilza_new_hitman_combo_counter_GUI:set_text(tostring(self._gilza_death_dance).."x")
				if self._gilza_death_dance > 0 then
					managers.player._Gilza_new_hitman_combo_counter_GUI:set_color(Color(1, 1, 1, 0))
				else
					managers.player._Gilza_new_hitman_combo_counter_GUI:set_color(Color(1, 1, 1, 1))
				end
			end
			managers.player._Gilza_new_hitman_combo_counter_GUI:set_visible(true)
		end
	end
	
	if managers.player:has_category_upgrade("temporary", "player_bounty_hunter") then
		local info_hud = managers.hud:script(PlayerBase.PLAYER_INFO_HUD_PD2)
		local icon = info_hud.panel:child("Gilza_new_hitman_GUI_icon")
		
		if icon then
			if managers.player:has_activate_temporary_upgrade("temporary", "player_bounty_hunter") then
				icon:set_visible(true)
				icon:set_color(Color(1, 0.06, 0.65, 0.27))
			else
				if self._gilza_hitman_has_active_bounty then
					if (self._gilza_hitman_bounty_received_at + 3) > Application:time() then
						new_hitman_bounty_notifier_flash_cycle = new_hitman_bounty_notifier_flash_cycle + 1
						icon:set_color(Color(0.9, 1, 1, 1))
						if new_hitman_bounty_notifier_flash_cycle < 4 then
							icon:set_visible(false)
						else
							icon:set_visible(true)
						end
						if new_hitman_bounty_notifier_flash_cycle == 7 then
							new_hitman_bounty_notifier_flash_cycle = 0
						end
					else
						new_hitman_bounty_notifier_flash_cycle = 0
						icon:set_visible(true)
						icon:set_color(Color(0.9, 1, 1, 1))
					end
				else
					icon:set_visible(true)
					icon:set_color(Color(0.2, 1, 1, 1))
				end
			end
		end
		
		if self._gilza_hitman_has_active_bounty then
			local is_alive = alive(self._gilza_hitman_bounty_target) and not self._gilza_hitman_bounty_target:character_damage():dead()
			local is_enemy = is_alive and self._gilza_hitman_bounty_target:brain():is_hostile()
			local too_long_since_bounty_received = ((self._gilza_hitman_bounty_received_at + 40) < Application:time())
			if too_long_since_bounty_received or not is_alive or not is_enemy then
				local extension = 40
				if too_long_since_bounty_received then
					extension = 10
					if is_alive then
						managers.player._gilza_hitman_bounty_target:contour():remove("generic_interactable_selected" , false)
					end
				end
				managers.player._gilza_hitman_bounty_cooldown_end = Application:time() + extension
				managers.player._gilza_hitman_has_active_bounty = false
			end
		end
		
	end

	DelayedCalls:Add("Gilza_new_hitman_recursive_updater", 0.05, function(self)
		managers.player:Gilza_new_hitman_recursive_updater()
	end)
end

-- updated the way health to armor conversion is calculated with anarchist/speed junkie deck to make it work properly
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

-- speed junkie updater. affects current stack count and UI/sounds.
local spike_flash_timer = 0
local junkie_exhausted = false
function PlayerManager:Gilza_update_junkie_loop()
	self._Gilza_junkie_counter = self._Gilza_junkie_counter or 0
	
	self._Gilza_junkie_ticks_since_stopped_moving = self._Gilza_junkie_ticks_since_stopped_moving or 0
	self._Gilza_junkie_ticks_moving_in_air = self._Gilza_junkie_ticks_moving_in_air or 0
	self._Gilza_junkie_ticks_since_reached_high_stacks = self._Gilza_junkie_ticks_since_reached_high_stacks or 0
	self._Gilza_junkie_ticks_since_entered_adrenaline_spike_range = self._Gilza_junkie_ticks_since_entered_adrenaline_spike_range or 0
	self._Gilza_junkie_exhausted = self._Gilza_junkie_exhausted or false
	
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
				self._Gilza_junkie_ticks_since_stopped_moving = 0
				self._Gilza_junkie_ticks_moving_in_air = 0
			elseif self:local_player():movement():current_state()._state_data.in_air then
				-- if we are in air, mostly from jumping, deplete really slowly
				self._Gilza_junkie_ticks_moving_in_air = self._Gilza_junkie_ticks_moving_in_air + 1
				if self._Gilza_junkie_counter > 0 then
					if self._Gilza_junkie_ticks_moving_in_air >= 20 then
						-- if a jump takes longer then 1 sec freeze the depletion
					else
						self._Gilza_junkie_counter = self._Gilza_junkie_counter - 0.1
					end
				end
			else
				-- if we dont't move start actively depleting junkie stacks
				self._Gilza_junkie_ticks_since_stopped_moving = self._Gilza_junkie_ticks_since_stopped_moving + 1
				if self._Gilza_junkie_counter > 0 then
					-- first 1 second of not moving counter depletes at a stable rate, later it speeds up
					if self._Gilza_junkie_ticks_since_stopped_moving <= 20 then
						self._Gilza_junkie_counter = self._Gilza_junkie_counter - 0.4
					else
						self._Gilza_junkie_counter = self._Gilza_junkie_counter - (self._Gilza_junkie_ticks_since_stopped_moving * 0.02)
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
		else
			self._Gilza_junkie_counter = 90
		end
	else -- loose stacks, mostly on downs
		self._Gilza_junkie_counter = 0
	end
	
	-- this chunk applies exhaust if stacks are high and updates the icon flash animation based on current status
	local info_hud = managers.hud:script(PlayerBase.PLAYER_INFO_HUD_PD2)
	local icon = info_hud.panel:child("Gilza_speed_junkie_GUI_icon")
	if self._Gilza_junkie_counter > 90 and not self._Gilza_junkie_adrenaline_spike then
		icon:animate(info_hud.flash_icon, 999999)
		self._Gilza_junkie_ticks_since_reached_high_stacks = self._Gilza_junkie_ticks_since_reached_high_stacks + 1
		-- if we reach high stacks and maintain them for over 4 seconds, stamina gets drained to 0
		if self._Gilza_junkie_ticks_since_reached_high_stacks >= 80 then
			self._Gilza_junkie_counter = self._Gilza_junkie_counter * math.random(550,700)/1000 -- rand value between 0.55 and 0.7
			if self:get_current_state()._unit and alive(self:get_current_state()._unit) and self:get_current_state()._unit:movement() then
				self._Gilza_junkie_exhausted = true
				self:get_current_state()._unit:movement():_change_stamina(-999999)
			end
			DelayedCalls:Add("Gilza_remove_junkie_status", 4, function()
				self._Gilza_junkie_exhausted = false
			end)
		end
	else
		if self._Gilza_junkie_counter > 70 and not self._Gilza_junkie_eligible_for_spike and not self._Gilza_junkie_adrenaline_spike then
			self._Gilza_junkie_eligible_for_spike = self._Gilza_junkie_eligible_for_spike or false
			self._Gilza_junkie_ticks_since_entered_adrenaline_spike_range = self._Gilza_junkie_ticks_since_entered_adrenaline_spike_range + 1
			if self._Gilza_junkie_ticks_since_entered_adrenaline_spike_range >= 400 then -- 20 seconds total
				self._Gilza_junkie_eligible_for_spike = true
			end
		end
		if self._Gilza_junkie_adrenaline_spike then
			icon:animate(info_hud.flash_icon, 999999)
		else
			icon:stop()
		end
		self._Gilza_junkie_ticks_since_reached_high_stacks = 0
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
		self._Gilza_junkie_exhausted = false
		-- restore max stamina for the spike
		if self:get_current_state()._unit and alive(self:get_current_state()._unit) and self:get_current_state()._unit:movement() then
			self:get_current_state()._unit:movement():_change_stamina(999999)
		end
		-- prevent this chunk from looping indefinetely
		self._Gilza_junkie_eligible_for_spike = false
		self._Gilza_junkie_ticks_since_entered_adrenaline_spike_range = 0
		DelayedCalls:Add("Gilza_remove_junkie_spike", 8, function()
			-- after spike is complete remove eligibility, reset values, and apply harsher version of exhaustion
			self._Gilza_junkie_ticks_since_entered_adrenaline_spike_range = 0
			self._Gilza_junkie_adrenaline_spike = false
			self._Gilza_junkie_counter = math.random(1500,2500)/100
			self._Gilza_junkie_exhausted = true
			if self:get_current_state()._unit and alive(self:get_current_state()._unit) and self:get_current_state()._unit:movement() then
				self:get_current_state()._unit:movement():_change_stamina(-999999)
			end
			DelayedCalls:Add("Gilza_remove_junkie_spike_pt2", 4, function()
				self._Gilza_junkie_exhausted = false
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
	elseif self._Gilza_junkie_exhausted then -- dark purple if we have the high meter debuff
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
	
	-- set text for UI. remove decimal for 0, 100 and 999, cause it looks prettier this way. otherwise only use 1 decimal number
	local text = "0"
	if self._Gilza_junkie_counter ~= 100 and self._Gilza_junkie_counter ~= 0 and self._Gilza_junkie_counter ~= 999 then
		text = string.format("%.1f", self._Gilza_junkie_counter)
	else
		text = tostring(self._Gilza_junkie_counter)
	end
	self._Gilza_junkie_counter_GUI:set_text(text)
	self._Gilza_junkie_counter_GUI:set_outlines_visible(true)
	self._Gilza_junkie_counter_GUI:show()
	
	-- loop
	DelayedCalls:Add("Gilza_update_junkie_loop", 0.05, function()
		managers.player:Gilza_update_junkie_loop()
	end)
end

-- guardian init
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

-- constant checks related to the guardian deck. various guardian timers are hard coded here instead of upgradestweaks cause lazynesssssss
function PlayerManager:Gilza_guardian_recursive_updater()
	
	local player_unit = self:player_unit()
	local area = self.Gilza_guardian_area
	
	local info_hud = managers.hud:script(PlayerBase.PLAYER_INFO_HUD_PD2)
	local icon = info_hud.panel:child("Gilza_guardian_GUI_icon")

	if alive(player_unit) then
		
		-- passive are activation vars
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
				
				icon:set_color(Color(0.2, 1, 1, 1)) -- low ui transperancy while ouside the area, which is still active
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
	
	--log("Area info: Location: "..tostring(area.position).."; Active: "..tostring(area.is_active).."; Radius: "..tostring(area.radius).."; Player inside: "..tostring(area.is_player_inside).."; Last inside at: "..tostring(area.last_attended_time))
	
	DelayedCalls:Add("Gilza_guardian_recursive_updater", 0.1, function(self)
		managers.player:Gilza_guardian_recursive_updater()
	end)
end

-- passive healing while inside of the guardian zone
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

-- ui/sound updates + nearby teammates scanner
function PlayerManager:Gilza_brawler_recursive_updater()
	
	if managers.player:has_category_upgrade("player", "damage_resist_teammates_brawler") then
		self._gilza_brawler_teammates_nearby = self._gilza_brawler_teammates_nearby or 0
		local player_unit = managers.player:player_unit()
		local scan_range = 2100
		
		if player_unit and alive(player_unit) then
			local criminals = World:find_units_quick("sphere", player_unit:position(), scan_range, managers.slot:get_mask("criminals"))
			if criminals and #criminals > 0 then
				local total_teammates = 0
				for i=1, #criminals do
					if criminals[i] ~= player_unit then
						if criminals[i] and criminals[i].character_damage and criminals[i]:character_damage() then
							-- if criminal in range is converted, check if it's our minion before adding resists
							if criminals[i]:character_damage()._converted then
								for u_key, u_data in pairs(managers.groupai:state():all_player_criminals()) do
									if player_unit:key() == u_key and u_data.minions then
										for bot_key, bot_data in pairs(u_data.minions) do
											if criminals[i] == bot_data.unit then
												total_teammates = total_teammates + 1
											end
										end
									end
								end
							else
								-- if criminal in range is not converted, make sure it's not a sentry gun :D
								if not criminals[i]:base().sentry_gun then
									total_teammates = total_teammates + 1
								end
							end
						end
					end
				end
				self._gilza_brawler_teammates_nearby = total_teammates
				
				if self._gilza_brawler_teammates_nearby > 3 then -- dont think this can happen, but better safe then sorry
					self._gilza_brawler_teammates_nearby = 3
				end
			end
		end
		
		local info_hud = managers.hud:script(PlayerBase.PLAYER_INFO_HUD_PD2)
		local icon = info_hud.panel:child("Gilza_brawler_GUI_icon")
		if self._gilza_brawler_teammates_nearby == 0 then
			icon:set_color(Color(0.2, 1, 1, 1))
		elseif self._gilza_brawler_teammates_nearby == 1 then
			icon:set_color(Color(1, 1, 1, 1))
		elseif self._gilza_brawler_teammates_nearby == 2 then
			icon:set_color(Color(1, 1, 1, 0))
		elseif self._gilza_brawler_teammates_nearby == 3 then
			icon:set_color(Color(1, 0, 1, 0))
		end
	else
		-- copycat 9th
		if managers.player:has_category_upgrade("player", "armor_regen_brawler") then
			local info_hud = managers.hud:script(PlayerBase.PLAYER_INFO_HUD_PD2)
			local icon = info_hud.panel:child("Gilza_brawler_GUI_icon")
			if icon then
				icon:set_color(Color(0.2, 1, 1, 1))
			end
		end
	end
	
	if managers.player:has_category_upgrade("player", "armor_regen_brawler") then
		self._gilza_brawler_regen_count = self._gilza_brawler_regen_count or 0
		if self._Gilza_new_brawler_regen_counter_GUI and self._gilza_brawler_regen_count and self._gilza_brawler_regen_count >= 0 then
			self._Gilza_new_brawler_regen_counter_GUI:set_text(tostring(self._gilza_brawler_regen_count).."x")
			self._Gilza_new_brawler_regen_counter_GUI:set_visible(true)
			if self._gilza_brawler_regen_count == 0 then
				self._Gilza_new_brawler_regen_counter_GUI:set_color(Color(1, 1, 0.25, 0.25))
			else
				self._Gilza_new_brawler_regen_counter_GUI:set_color(Color(1, 1, 1, 1))
			end
		end
	end

	DelayedCalls:Add("Gilza_brawler_recursive_updater", 0.05, function(self)
		managers.player:Gilza_brawler_recursive_updater()
	end)
end