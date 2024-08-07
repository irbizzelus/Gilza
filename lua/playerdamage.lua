-- new berserker - when armor breaks under half health gain damage bonuses and activate HUD flash
Hooks:PreHook(PlayerDamage, "_calc_armor_damage", "Gilza_new_berserk_trigger", function(self, attack_data)
	-- on armor break
	if self:get_real_armor() > 0 and attack_data.damage >= self:get_real_armor() then
		-- and under half health
		if ( self:_max_health() / self:get_real_health() ) >= 2 then
			
			-- activate new berserk damage
			local melee_active = false
			local melee_duration = 0
			local weapon_active = false
			local berserk_active = false
			if managers.player:has_category_upgrade("temporary", "new_berserk_melee_damage_multiplier_2") then
				managers.player:activate_temporary_upgrade("temporary", "new_berserk_melee_damage_multiplier_2")
				melee_active = 2
				melee_duration = 40
				berserk_active = true
			elseif managers.player:has_category_upgrade("temporary", "new_berserk_melee_damage_multiplier_1") then
				managers.player:activate_temporary_upgrade("temporary", "new_berserk_melee_damage_multiplier_1")
				melee_active = 1
				melee_duration = 20
				berserk_active = true
			end
			if managers.player:has_category_upgrade("temporary", "new_berserk_weapon_damage_multiplier") then
				managers.player:activate_temporary_upgrade("temporary", "new_berserk_weapon_damage_multiplier")
				weapon_active = true
				berserk_active = true
			end
			
			if melee_active or weapon_active then
				
				-- hud stuff
				if not managers.hud or not managers.hud:script(PlayerBase.PLAYER_INFO_HUD_FULLSCREEN_PD2) then
					return
				end
				
				local hud = managers.hud:script(PlayerBase.PLAYER_INFO_HUD_FULLSCREEN_PD2)
				if not hud.panel:child("Gilza_new_berserk") then
				
					local textureSize = "guis/textures/berserk_flash"
					if Gilza.settings.flash_size == 2 then
						textureSize = "guis/textures/berserk_flash_bigger"
					elseif Gilza.settings.flash_size == 3 then
						textureSize = "guis/textures/berserk_flash_biggest"
					end
					
					local Gilza_new_berserk = hud.panel:bitmap({
						name = "Gilza_new_berserk",
						visible = false,
						texture = textureSize,
						layer = 0,
						color = Color((Gilza.settings.flash_color_R / 255), (Gilza.settings.flash_color_G / 255), (Gilza.settings.flash_color_B / 255)),
						blend_mode = "add",
						w = hud.panel:w(),
						h = hud.panel:h(),
						x = 0,
						y = 0 
					})
				end
				local Gilza_new_berserk = hud.panel:child("Gilza_new_berserk")
				local hudinfo = managers.hud:script(PlayerBase.PLAYER_INFO_HUD_PD2)
				
				-- 1 - flash then 3s of calm, 2 - calm then 3s of flash, 3 - calm, 4 - flash
				local flash_type = Gilza.settings.flash_type
				-- 1 - disabled, 2- weapons only, 3-melee only, 4-everything
				local flash_trigger = Gilza.settings.flash_trigger
				
				local function activate_berserk_type_1 (duration)
					Gilza_new_berserk:set_visible(true)
					Gilza_new_berserk:animate(hudinfo.flash_icon, duration-3)
					DelayedCalls:Add("disable_berserk_flash", duration, function()
						Gilza_new_berserk:stop()
						Gilza_new_berserk:set_visible(false)
					end)
				end
				
				local function activate_berserk_type_2 (duration)
					Gilza_new_berserk:set_visible(true)
					DelayedCalls:Add("disable_berserk_flash", duration-3, function()
						Gilza_new_berserk:animate(hudinfo.flash_icon, 3)
						DelayedCalls:Add("disable_berserk_flash_2", 3, function()
							Gilza_new_berserk:stop()
							Gilza_new_berserk:set_visible(false)
						end)
					end)
				end
				
				local function activate_berserk_type_3 (duration)
					Gilza_new_berserk:set_visible(true)
					DelayedCalls:Add("disable_berserk_flash", duration, function()
						Gilza_new_berserk:stop()
						Gilza_new_berserk:set_visible(false)
					end)
				end
				
				local function activate_berserk_type_4 (duration)
					Gilza_new_berserk:set_visible(true)
					Gilza_new_berserk:animate(hudinfo.flash_icon, duration+1)
					DelayedCalls:Add("disable_berserk_flash", duration, function()
						Gilza_new_berserk:stop()
						Gilza_new_berserk:set_visible(false)
					end)
				end
				
				if flash_trigger ~= 1 and berserk_active then
					if flash_trigger == 2 then
						if weapon_active then
							if flash_type == 1 then
								activate_berserk_type_1(20)
							elseif flash_type == 2 then
								activate_berserk_type_2(20)
							elseif flash_type == 3 then
								activate_berserk_type_3(20)
							elseif flash_type == 4 then
								activate_berserk_type_4(20)
							end
						end
					elseif flash_trigger == 3 then
						if melee_active then
							local duration
							if melee_active == 2 then
								duration = 40
							elseif melee_active == 1 then
								duration = 20
							end
							
							if flash_type == 1 then
								activate_berserk_type_1(duration)
							elseif flash_type == 2 then
								activate_berserk_type_2(duration)
							elseif flash_type == 3 then
								activate_berserk_type_3(duration)
							elseif flash_type == 4 then
								activate_berserk_type_4(duration)
							end
						end
					elseif flash_trigger == 4 then
						local melee_dur = 0
						local wpn_dur = 0
						if melee_active then
							if melee_active == 2 then
								melee_dur = 40
							elseif melee_active == 1 then
								melee_dur = 20
							end
						end
						if weapon_active then
							wpn_dur = 20
						end
						Gilza_new_berserk:set_visible(true)
						Gilza_new_berserk:animate(hudinfo.flash_icon, wpn_dur)
						DelayedCalls:Add("disable_berserk_flash", melee_dur, function()
							Gilza_new_berserk:stop()
							Gilza_new_berserk:set_visible(false)
						end)
					end
				end

			end
		end
		
	end
end)

-- new damage reduction skills + brawler deck
Hooks:PreHook(PlayerDamage, "damage_bullet", "Gilza_player_damage_bullet", function(self, attack_data)
	local damage_resistance_mul = 1
	
	if managers.network:session():local_peer():unit():movement()._current_state._moving == false or managers.player:current_state() == "bipod" then
		damage_resistance_mul = damage_resistance_mul - managers.player:upgrade_value("player", "not_moving_damage_reduction_bonus", 0)
	end
	
	if managers.player:current_state() == "bipod" then
		damage_resistance_mul = damage_resistance_mul - managers.player:upgrade_value("player", "not_moving_damage_reduction_bonus_bipoded", 0)
	end
	
	if self:get_real_armor() > 0 then
		if managers.player:has_category_upgrade("player", "damage_resist_brawler") then
			damage_resistance_mul = damage_resistance_mul - managers.player:upgrade_value("player", "damage_resist_brawler", 0)
		end
		
		if managers.player:has_category_upgrade("player", "AP_damage_resist_brawler") and attack_data.armor_piercing == true then
			-- if we have yakuza deck card #9, check that we are under half health before giving AP resist
			if managers.player:has_category_upgrade("player", "yakuza_suppression_resist") then
				if ( self:_max_health() / self:get_real_health() ) >= 2 then
					attack_data.armor_piercing = nil
				end
			else
				attack_data.armor_piercing = nil
			end
		end
	end
	
	if managers.player:has_category_upgrade("player", "damage_resist_faraway_brawler") then
		if ( self:_max_health() / self:get_real_health() ) >= 2 and self:get_real_armor() > 0 then
			if managers.player:player_unit():camera() and managers.player:player_unit():camera():position() and attack_data.attacker_unit:position() then
				local dist = mvector3.distance(managers.player:player_unit():camera():position(), attack_data.attacker_unit:position())
				local diff_mul = 1
				if Global.game_settings and Global.game_settings.difficulty and Global.game_settings.difficulty ~= "sm_wish" then
					diff_mul = 0.5
				end
				if dist and dist <= 1800 then
					damage_resistance_mul = damage_resistance_mul - 0.14 * diff_mul
				end
				if dist and dist <= 1000 then
					damage_resistance_mul = damage_resistance_mul - 0.18 * diff_mul
				end
				if dist and dist <= 500 then
					damage_resistance_mul = damage_resistance_mul - 0.22 * diff_mul
				end
			end
		end
	end
	
	attack_data.damage = attack_data.damage * damage_resistance_mul
end)

-- check if local player is arrested when beeing revived
local Gilza_arrested = "CBT"
Hooks:PreHook(PlayerDamage, "revive", "Gilza_newUpYouGoPart1", function(self)
	Gilza_arrested = self:arrested()
end)

-- if not arrested and we have new Up you go skill, get more health + sync
Hooks:PostHook(PlayerDamage, "revive", "Gilza_newUpYouGoPart2", function(self)
	if not Gilza_arrested and managers.player:has_category_upgrade("player", "health_regain_V2") then
		self:set_health(self:get_real_health() + (self:_max_health() * managers.player:upgrade_value("player", "health_regain_V2", 0)))
		managers.hud:set_player_health({
			current = self:get_real_health(),
			total = self:_max_health(),
			revives = Application:digest_value(self._revives, false)
		})
		self:_send_set_health()
	end
end)

-- allow counterstrike skill to deal damage
PlayerDamage._Gilza_WasCounterAttacking = false -- if we counterattacked, we reset chainsaw damage effect in a posthook for damage_melee func
Hooks:PreHook(PlayerDamage, "damage_melee", "Gilza_player_damage_melee", function(self, attack_data)
	local can_counter_strike = managers.player:has_category_upgrade("player", "counter_strike_melee")
	if can_counter_strike and self._unit:movement():current_state().in_melee and self._unit:movement():current_state():in_melee() then
		self._Gilza_WasCounterAttacking = true
		local t = managers.player:player_timer():time()
		local melee_entry = melee_entry or managers.blackmarket:equipped_melee_weapon()
		local anim_attack_vars = tweak_data.blackmarket.melee_weapons[melee_entry].anim_attack_vars
		local melee_attack_var = anim_attack_vars and math.random(#anim_attack_vars)
		local player_state = self._unit:movement():current_state()
		local charge_lerp_value = player_state:_get_melee_charge_lerp_value(managers.player:player_timer():time()) or 0
		local from = player_state._unit:movement():m_head_pos()
		local attacker_pos = attack_data.attacker_unit:position()
		local toRot = Rotation:look_at(from, attacker_pos, Vector3(0, 0, 1))
		local to = Rotation(toRot:x(), toRot:y(), toRot:z())
		local col_ray = player_state._unit:raycast("ray", from, to, "slot_mask", player_state._slotmask_bullet_impact_targets, "sphere_cast_radius", 20, "ray_type", "body melee")
		
		if col_ray and alive(col_ray.unit) then
			local damage, damage_effect = managers.blackmarket:equipped_melee_weapon_damage_info(charge_lerp_value)
			if tweak_data.blackmarket.melee_weapons[melee_entry].stats.tick_damage then
				damage = tweak_data.blackmarket.melee_weapons[melee_entry].stats.tick_damage
				charge_lerp_value = 0
			end
			
			local hit_unit = attack_data.attacker_unit

			if hit_unit:character_damage() then

				local hit_sfx = "hit_body"
				if hit_unit:character_damage() and hit_unit:character_damage().melee_hit_sfx then
					hit_sfx = hit_unit:character_damage():melee_hit_sfx()
				end

				player_state:_play_melee_sound(melee_entry, hit_sfx, melee_attack_var)

				if not hit_unit:character_damage()._no_blood then
					managers.game_play_central:play_impact_flesh({
						col_ray = col_ray
					})
					managers.game_play_central:play_impact_sound_and_effects({
						no_decal = true,
						no_sound = true,
						col_ray = col_ray
					})
				end
			end

			managers.game_play_central:physics_push(col_ray)

			local character_unit, shield_knock = nil
			local can_shield_knock = managers.player:has_category_upgrade("player", "shield_knock")

			if can_shield_knock and hit_unit:in_slot(8) and alive(hit_unit:parent()) and not hit_unit:parent():character_damage():is_immune_to_shield_knockback() then
				shield_knock = true
				character_unit = hit_unit:parent()
			end

			character_unit = character_unit or hit_unit

			if character_unit:character_damage() and character_unit:character_damage().damage_melee then
				local dmg_multiplier = 1
				local target_dead = character_unit:character_damage().dead and not character_unit:character_damage():dead()
				local target_hostile = managers.enemy:is_enemy(character_unit) and not tweak_data.character[character_unit:base()._tweak_table].is_escort and character_unit:brain():is_hostile()
				local life_leach_available = managers.player:has_category_upgrade("temporary", "melee_life_leech") and not managers.player:has_activate_temporary_upgrade("temporary", "melee_life_leech")
				
				-- bloodthirst base
				dmg_multiplier = dmg_multiplier * managers.player:get_melee_dmg_multiplier()
				
				-- sociopath/infil damage
				if managers.player:has_category_upgrade("melee", "stacking_hit_damage_multiplier") then
					player_state._state_data.stacking_dmg_mul = player_state._state_data.stacking_dmg_mul or {}
					player_state._state_data.stacking_dmg_mul.melee = player_state._state_data.stacking_dmg_mul.melee or {
						nil,
						0
					}
					local stack = player_state._state_data.stacking_dmg_mul.melee

					if stack[1] and t < stack[1] then
						dmg_multiplier = dmg_multiplier * (1 + managers.player:upgrade_value("melee", "stacking_hit_damage_multiplier", 0) * stack[2])
					else
						stack[2] = 0
					end
				end
				
				if target_dead and target_hostile and life_leach_available then
					managers.player:activate_temporary_upgrade("temporary", "melee_life_leech")
					player_state._unit:character_damage():restore_health(managers.player:temporary_upgrade_value("temporary", "melee_life_leech", 1))
				end

				local special_weapon = tweak_data.blackmarket.melee_weapons[melee_entry].special_weapon
				local action_data = {
					variant = "melee"
				}

				if special_weapon == "taser" then
					action_data.variant = "taser_tased"
				end

				if _G.IS_VR and melee_entry == "weapon" and not bayonet_melee then
					dmg_multiplier = 0.5
				end

				action_data.damage = shield_knock and 0 or damage * dmg_multiplier
				if managers.player:has_category_upgrade("player", "counter_strike_spooc") then
					action_data.damage = action_data.damage * 2
				end
				action_data.damage_effect = damage_effect
				action_data.attacker_unit = player_state._unit
				action_data.col_ray = col_ray

				if shield_knock then
					action_data.shield_knock = can_shield_knock
				end

				action_data.name_id = melee_entry
				action_data.charge_lerp_value = charge_lerp_value

				local defense_data = character_unit:character_damage():damage_melee(action_data)

				player_state:_check_melee_special_damage(col_ray, character_unit, defense_data, melee_entry)
				player_state:_perform_sync_melee_damage(hit_unit, col_ray, action_data.damage)
				
				-- sociopath/infil timer
				if managers.player:has_category_upgrade("melee", "stacking_hit_damage_multiplier") then
					player_state._state_data.stacking_dmg_mul = player_state._state_data.stacking_dmg_mul or {}
					player_state._state_data.stacking_dmg_mul.melee = player_state._state_data.stacking_dmg_mul.melee or {
						nil,
						0
					}
					local stack = player_state._state_data.stacking_dmg_mul.melee

					if character_unit:character_damage().dead and not character_unit:character_damage():dead() then
						stack[1] = t + managers.player:upgrade_value("melee", "stacking_hit_expire_t", 1)
						stack[2] = math.min(stack[2] + 1, tweak_data.upgrades.max_melee_weapon_dmg_mul_stacks or 5)
					else
						stack[1] = nil
						stack[2] = 0
					end
				end
				
				return defense_data
			end
		end

		return col_ray
	else
		self._Gilza_WasCounterAttacking = false
	end
end)

-- interupt melee hold after a counterattack, to stop chainsaw damage
-- this also causes a small bug where melee is almost instantly unequiped, but i deem it a feature and not a bug.
Hooks:PostHook(PlayerDamage, "damage_melee", "Gilza_player_damage_melee_2", function(self, attack_data)
	if self._Gilza_WasCounterAttacking then
		self._unit:movement():current_state():_interupt_action_melee(managers.player:player_timer():time())
	end
end)

Hooks:PostHook(PlayerDamage, "_on_enter_swansong_event", "Gilza_on_enter_SwanSong", function(self)
	
	if not managers.network or not managers.network:session() or not managers.network:session().peers then
		return
	end
	
	for _, peer in pairs(managers.network:session():peers()) do
		if peer then
			local player_unit = peer and peer:unit() or nil
			if player_unit and alive(player_unit) then
				if player_unit:interaction():active() and player_unit:movement():need_revive() then
					tweak_data.upgrades.berserker_movement_speed_multiplier = 1
					DelayedCalls:Add("Gilza_reset_swan_song_speed", 3, function()
						tweak_data.upgrades.berserker_movement_speed_multiplier = 0.4
					end)
					break
				end
			end
		end
	end
	
end)

-- add armor on dodge with new skill
Hooks:PostHook(PlayerDamage, "init", "Gilza_dodge_gib_armor_1", function(self)
	
	-- create junkie hud
	if managers.player:has_category_upgrade("player", "speed_junkie_meter") then
		if not managers.hud or not managers.hud:script(PlayerBase.PLAYER_INFO_HUD_PD2) then
			return
		end
		local hud = managers.hud:script(PlayerBase.PLAYER_INFO_HUD_PD2)
		if not hud.panel:child("Gilza_speed_junkie_GUI_icon") then
			local image_scale = Gilza.settings.junkie_icon_scale
			local x_position = Gilza.settings.junkie_icon_x_pos
			local y_position = Gilza.settings.junkie_icon_y_pos
			hud.panel:bitmap({
				name = "Gilza_speed_junkie_GUI_icon",
				visible = true,
				texture = "guis/dlcs/Gilza/textures/pd2/specialization/junkie_icon",
				layer = 5,
				color = Color(1, 1, 1, 1),
				blend_mode = "add",
				w = 60 * image_scale,
				h = 60 * image_scale,
				x = x_position,
				y = y_position
			})
			managers.player:Gilza_create_junkie_gui(image_scale,x_position,y_position)
		end
	end
	
	managers.player:unregister_message(Message.OnPlayerDodge, "Gilza_armor_on_dodge_skill")
	managers.player:register_message(Message.OnPlayerDodge, "Gilza_armor_on_dodge_skill", function()
		
		local excluded_state = {
			["bleed_out"] = true,
			["fatal"] = true,
			["incapacitated"] = true,
			["arrested"] = true,
			["jerry1"] = true
		}
		if managers.player:has_category_upgrade("temporary", "player_dodge_armor_regen") and not excluded_state[managers.player:current_state()] and self:get_real_armor() <= 0 then -- can it even be less?
			if not managers.player:has_activate_temporary_upgrade("temporary", "player_dodge_armor_regen") then
				if self._unit and alive(self._unit) and self._unit.character_damage then
					managers.player:activate_temporary_upgrade("temporary", "player_dodge_armor_regen")
					self._unit:character_damage():restore_armor(managers.player:temporary_upgrade_value("temporary", "player_dodge_armor_regen", 0))
				end
			end
		end
		if managers.player:has_category_upgrade("temporary", "player_speed_junkie_armor_on_dodge") and not excluded_state[managers.player:current_state()] then
			if not managers.player:has_activate_temporary_upgrade("temporary", "player_speed_junkie_armor_on_dodge") then
				if self._unit and alive(self._unit) and self._unit.character_damage then
					managers.player:activate_temporary_upgrade("temporary", "player_speed_junkie_armor_on_dodge")
					if self:get_real_armor() > 0 then
						if self:_max_armor() ~= self:get_real_armor() then
							self._unit:character_damage():restore_armor(managers.player:temporary_upgrade_value("temporary", "player_speed_junkie_armor_on_dodge", 0))
						end
					else
						self._unit:character_damage():restore_armor(managers.player:temporary_upgrade_value("temporary", "player_speed_junkie_armor_on_dodge", 0) * 4)
					end
				end
			end
		end
			
	end)
end)

Hooks:PreHook(PlayerDamage, "pre_destroy", "Gilza_dodge_gib_armor_2", function(self)
	managers.player:unregister_message(Message.OnPlayerDodge, "Gilza_armor_on_dodge_skill")
end)

local orig_timer_to_max = PlayerDamage.set_regenerate_timer_to_max
Hooks:OverrideFunction(PlayerDamage, "set_regenerate_timer_to_max", function (self)
	local is_regenrating_armor = self._current_state and self._update_regenerate_timer and self._current_state == self._update_regenerate_timer
	if managers.player:has_category_upgrade("temporary", "player_new_hitman_regen") and is_regenrating_armor then
		local mul = managers.player:body_armor_regen_multiplier(alive(self._unit) and self._unit:movement():current_state()._moving, self:health_ratio())
		local default_regen_timer = tweak_data.player.damage.REGENERATE_TIME * mul * managers.player:upgrade_value("player", "armor_regen_time_mul", 1)
		-- first value of this skill is a % value of the default regen timer. this makes all armors have unique freeze time for their recovery
		local skill_freeze_time = default_regen_timer * tweak_data.upgrades.values.temporary.player_new_hitman_regen[1][1]
		-- if freeze timer would make total armor regen timer longer, ignore it
		if default_regen_timer < self._regenerate_timer + skill_freeze_time then
			orig_timer_to_max(self)
			return
		end
		-- adjust skill's duration value before enabling it. while buff is active armor regen is frozen
		tweak_data.upgrades.values.temporary.player_new_hitman_regen[1][2] = skill_freeze_time
		managers.player:activate_temporary_upgrade("temporary", "player_new_hitman_regen")
	elseif managers.player:has_category_upgrade("player", "yakuza_suppression_resist") then
		-- if we have the new supression resist skill from yakuza, make supression delay 0. that removes the effect
		-- however we need to compensate regen duration for the armor because supression always adds 1 second of regen time. to be nice, it will be 0.95s instead :) @461
		if tweak_data.player.suppression.decay_start_delay ~= 0 then
			tweak_data.player.suppression.decay_start_delay = 0
		end
		local mul = managers.player:body_armor_regen_multiplier(alive(self._unit) and self._unit:movement():current_state()._moving, self:health_ratio())
		self._regenerate_timer = tweak_data.player.damage.REGENERATE_TIME * mul * managers.player:upgrade_value("player", "armor_regen_time_mul", 1) + 0.95
		self._regenerate_speed = self._regenerate_speed or 1
		self._current_state = self._update_regenerate_timer
	else
		orig_timer_to_max(self)
	end
end)

local orig_update_regenerate_timer = PlayerDamage._update_regenerate_timer
Hooks:OverrideFunction(PlayerDamage, "_update_regenerate_timer", function (self, t, dt)
	-- while new skill upgrade is active regen timer updates it's value to itself instead of reducing it, effectively freezing the timer
	if managers.player:has_activate_temporary_upgrade("temporary", "player_new_hitman_regen") and self:get_real_armor() > 0 then
		self._regenerate_timer = self._regenerate_timer
	elseif managers.player:has_category_upgrade("player", "pause_armor_recovery_when_moving") and managers.player.local_player and alive(managers.player:local_player()) and managers.player:local_player().movement and managers.player:local_player():movement().current_state and managers.player:local_player():movement():current_state()._moving then
		self:set_regenerate_timer_to_max()
	else
		orig_update_regenerate_timer(self, t, dt)
	end
end)