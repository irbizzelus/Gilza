-- new berserker - when armor breaks under half health gain damage bonuses and activate HUD flash
Hooks:PreHook(PlayerDamage, "_calc_armor_damage", "Gilza_new_berserk_trigger", function(self, attack_data)
	-- on armor break
	if self:get_real_armor() > 0 and attack_data.damage >= self:get_real_armor() then
		-- and under half health
		if ( self:_max_health() / self:get_real_health() ) >= 2 then
			
			-- activate new berserk ui/skills
			local melee_duration = false
			local weapon_duration = false
			if managers.player:has_category_upgrade("temporary", "new_berserk_melee_damage_multiplier_1") then
				managers.player:activate_temporary_upgrade("temporary", "new_berserk_melee_damage_multiplier_1")
				local skill = managers.player:upgrade_value("temporary", "new_berserk_melee_damage_multiplier_1")
				if skill and type(skill) ~= "number" then
					melee_duration = skill[2]
				end
			end

			if managers.player:has_category_upgrade("temporary", "new_berserk_weapon_damage_multiplier") and managers.player:has_category_upgrade("temporary", "new_berserk_weapon_damage_multiplier_cooldown") then
				if not managers.player:has_activate_temporary_upgrade("temporary", "new_berserk_weapon_damage_multiplier_cooldown") then
					managers.player:activate_temporary_upgrade("temporary", "new_berserk_weapon_damage_multiplier")
					managers.player:activate_temporary_upgrade("temporary", "new_berserk_weapon_damage_multiplier_cooldown")
					local skill = managers.player:upgrade_value("temporary", "new_berserk_weapon_damage_multiplier")
					if skill and type(skill) ~= "number" then
						weapon_duration = skill[2]
					end
				end
			end
			
			-- UI
			if melee_duration or weapon_duration then
				
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
				
				local function activate_singular_berserk_ui(duration)
					-- 1 - flash then 3s of calm, 2 - calm then 3s of flash, 3 - calm, 4 - flash
					local flash_type = Gilza.settings.flash_type
					
					Gilza_new_berserk:set_visible(true)
					if flash_type == 1 then
						Gilza_new_berserk:animate(hudinfo.flash_icon, duration-3)
					elseif flash_type == 4 then
						Gilza_new_berserk:animate(hudinfo.flash_icon, duration+1)
					end
					
					DelayedCalls:Add("Gilza_berserk_flash_last_3s", duration-3, function()
						if flash_type == 2 then
							Gilza_new_berserk:animate(hudinfo.flash_icon, 4)
						end
					end)
					
					DelayedCalls:Add("Gilza_berserk_flash_end", duration, function()
						Gilza_new_berserk:stop()
						Gilza_new_berserk:set_visible(false)
					end)
				end
				
				local function activate_combined_berserk_ui(melee_dur,wpn_dur)
					Gilza_new_berserk:set_visible(true)
					if wpn_dur then -- in case melee triggers while weapons are on cooldown
						Gilza_new_berserk:animate(hudinfo.flash_icon, wpn_dur)
					end
					DelayedCalls:Add("Gilza_berserk_flash_end", melee_dur, function()
						Gilza_new_berserk:stop()
						Gilza_new_berserk:set_visible(false)
					end)
				end
				
				-- 1 - disabled, 2- weapons only, 3-melee only, 4-combined
				local flash_trigger = Gilza.settings.flash_trigger
				if flash_trigger > 1 then
					if flash_trigger == 2 then
						if weapon_duration then
							activate_singular_berserk_ui(weapon_duration)
						end
					elseif flash_trigger == 3 then
						if melee_duration then
							activate_singular_berserk_ui(melee_duration)
						end
					elseif flash_trigger == 4 then
						activate_combined_berserk_ui(melee_duration,weapon_duration)
					end
				end

			end
		end
		
	end
end)

-- new damage reduction skills + brawler deck
Hooks:PreHook(PlayerDamage, "damage_bullet", "Gilza_player_damage_bullet", function(self, attack_data)
	
	local att_unit = attack_data.attacker_unit
	Gilza.latest_bullet_attacker_unit = att_unit
	
	if managers.player:has_category_upgrade("player", "guardian_area_passive") then
		attack_data.damage = self:Gilza_calculate_guardian_damage_clamp(attack_data.damage)
	end
	
	if managers.player:has_category_upgrade("player", "guardian_heavy_armor_ricochet") then
		local chance_mul = managers.player:upgrade_value("player", "guardian_heavy_armor_ricochet", 0)
		local required_roll = math.floor(self:_raw_max_armor()) * chance_mul * 0.01
		if math.random() <= required_roll then
			local from = Vector3()
			local to = Vector3()
			local dir = Vector3()

			if attack_data.variant == "bullet" then
				local player_unit = managers.player:player_unit()

				if not alive(att_unit) or not att_unit:character_damage() or att_unit:character_damage():dead() or not att_unit:character_damage().damage_simple then
					return
				end

				mvector3.set(dir, attack_data.col_ray.ray)
				mvector3.negate(dir)
				mvector3.set(to, attack_data.col_ray.position)
				mvector3.set(from, dir)
				mvector3.multiply(from, attack_data.col_ray.distance or 20000)
				mvector3.add(from, to)
				math.point_on_line(from, to, player_unit:movement():m_head_pos(), to)
				mvector3.direction(dir, to, from)
				mvector3.set(from, to)
				mvector3.set(to, dir)
				mvector3.spread(to, 3)
				mvector3.multiply(to, 20000)
				mvector3.add(to, from)

				local ray_hits = RaycastWeaponBase.collect_hits(from, to, {
					ignore_unit = {
						player_unit
					}
				})
				local hit_dmg_ext = nil

				for _, col_ray in ipairs(ray_hits) do
					hit_dmg_ext = col_ray.unit:character_damage()

					if hit_dmg_ext and hit_dmg_ext.damage_simple then
						hit_dmg_ext:damage_simple({
							variant = "bullet",
							damage = attack_data.damage,
							attacker_unit = player_unit,
							pos = col_ray.position,
							attack_dir = dir
						})
						managers.game_play_central:play_impact_flesh({
							col_ray = col_ray
						})
					end

					managers.game_play_central:play_impact_sound_and_effects({
						col_ray = col_ray
					})
				end

				local furthest_hit = ray_hits[#ray_hits]

				if furthest_hit and furthest_hit.distance > 600 or not furthest_hit then
					local trail_effect_table = {
						effect = RaycastWeaponBase.TRAIL_EFFECT,
						normal = dir,
						position = from
					}
					local trail = World:effect_manager():spawn(trail_effect_table)

					if furthest_hit then
						World:effect_manager():set_remaining_lifetime(trail, math.clamp((furthest_hit.distance - 600) / 10000, 0, furthest_hit.distance))
					end
				end
			end
		end
	end
	
	if self:get_real_armor() > 0 then
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
end)

Hooks:PreHook(PlayerDamage, "damage_explosion", "Gilza_pre_player_damage_explosion", function(self, attack_data)
	if managers.player:has_category_upgrade("player", "guardian_area_passive") then
		attack_data.damage = self:Gilza_calculate_guardian_damage_clamp(attack_data.damage)
	end
end)

Hooks:PreHook(PlayerDamage, "damage_fire", "Gilza_pre_player_damage_fire", function(self, attack_data)
	if managers.player:has_category_upgrade("player", "guardian_area_passive") then
		attack_data.damage = self:Gilza_calculate_guardian_damage_clamp(attack_data.damage)
	end
end)

Hooks:PreHook(PlayerDamage, "damage_fire_hit", "Gilza_pre_player_damage_fire_hit", function(self, attack_data)
	if managers.player:has_category_upgrade("player", "guardian_area_passive") then
		attack_data.damage = self:Gilza_calculate_guardian_damage_clamp(attack_data.damage)
	end
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
	
	if attack_data.damage and managers.player:has_category_upgrade("player", "guardian_area_passive") then
		attack_data.damage = self:Gilza_calculate_guardian_damage_clamp(attack_data.damage)
	end
	
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
	
	-- start guardian logic and GUI
	if managers.player:has_category_upgrade("player", "guardian_area_passive") then
		
		managers.player:Gilza_start_guardian_tracking()
		
		if not managers.hud or not managers.hud:script(PlayerBase.PLAYER_INFO_HUD_PD2) then
			return
		end
		local hud = managers.hud:script(PlayerBase.PLAYER_INFO_HUD_PD2)
		if not hud.panel:child("Gilza_guardian_GUI_icon") then
			local image_scale = Gilza.settings.junkie_icon_scale
			local x_position = Gilza.settings.junkie_icon_x_pos
			local y_position = Gilza.settings.junkie_icon_y_pos
			hud.panel:bitmap({
				name = "Gilza_guardian_GUI_icon",
				visible = false,
				texture = "guis/dlcs/Gilza/textures/pd2/specialization/guardian_icon",
				layer = 5,
				color = Color(1, 1, 1, 1),
				blend_mode = "add",
				w = 60 * image_scale,
				h = 60 * image_scale,
				x = x_position,
				y = y_position
			})
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

-- 'fix' copycat health invulnerability perk card to work as described - when taking health damage, if new health after damage is <50%, and we had >=50% health, activate invuln
Hooks:OverrideFunction(PlayerDamage, "_calc_health_damage", function (self, attack_data)
	if attack_data.weapon_unit then
		local weap_base = alive(attack_data.weapon_unit) and attack_data.weapon_unit:base()
		local weap_tweak_data = weap_base and weap_base.weapon_tweak_data and weap_base:weapon_tweak_data()

		if weap_tweak_data and weap_tweak_data.slowdown_data then
			self:apply_slowdown(weap_tweak_data.slowdown_data)
		end
	end

	if managers.player:has_activate_temporary_upgrade("temporary", "mrwi_health_invulnerable") then
		return 0
	end
	
	if self._has_mrwi_health_invulnerable then
		local health_threshold = self._mrwi_health_invulnerable_threshold or 0.5
		local is_cooling_down = managers.player:get_temporary_property("mrwi_health_invulnerable", false)
		
		local reduced_to_threshold = false
		local old_health = self:get_real_health()
		local new_health = self:get_real_health() - attack_data.damage
		if (1 / (self:_max_health() / new_health)) < health_threshold and (1 / (self:_max_health() / old_health)) >= health_threshold then
			reduced_to_threshold = true
		end
		
		if reduced_to_threshold and not is_cooling_down and not (self:get_real_armor() > 0) and attack_data.damage > 0 then
			local cooldown_time = self._mrwi_health_invulnerable_cooldown or 10

			managers.player:activate_temporary_upgrade("temporary", "mrwi_health_invulnerable")
			managers.player:activate_temporary_property("mrwi_health_invulnerable", cooldown_time, true)
		end
	end

	local health_subtracted = 0
	health_subtracted = self:get_real_health()

	self:change_health(-attack_data.damage)

	health_subtracted = health_subtracted - self:get_real_health()

	if managers.player:has_activate_temporary_upgrade("temporary", "copr_ability") and health_subtracted > 0 then
		local teammate_heal_level = managers.player:upgrade_level_nil("player", "copr_teammate_heal")

		if teammate_heal_level and self:get_real_health() > 0 then
			self._unit:network():send("copr_teammate_heal", teammate_heal_level)
		end
	end

	local trigger_skills = table.contains({
		"bullet",
		"explosion",
		"melee",
		"delayed_tick"
	}, attack_data.variant)
	local ignore_reduce_revive = self:check_ignore_reduce_revive()

	if self:get_real_health() == 0 and trigger_skills then
		self:_chk_cheat_death(ignore_reduce_revive)
	end

	self:_damage_screen()
	self:_check_bleed_out(trigger_skills, nil, ignore_reduce_revive)
	managers.hud:set_player_health({
		current = self:get_real_health(),
		total = self:_max_health(),
		revives = Application:digest_value(self._revives, false)
	})
	self:_send_set_health()
	self:_set_health_effect()
	managers.statistics:health_subtracted(health_subtracted)

	return health_subtracted
end)

local gilza_orig_max_armor = PlayerDamage._max_armor
Hooks:OverrideFunction(PlayerDamage, "_max_armor", function(self)
	local max_armor = gilza_orig_max_armor(self)
	
	if managers.player:has_category_upgrade("player", "guardian_armor_remover") then
		max_armor = 0
	end
	
	return max_armor
end)

function PlayerDamage:Gilza_calculate_guardian_damage_clamp(incoming_dmg)
	
	local function clamp_guardian_perk_damage(skill, dmg)
		local min_clamp = 0
		local max_clamp = 999999
		local end_dmg = dmg
		if skill and type(skill) ~= "number" then
			min_clamp = skill.minimum
			max_clamp = skill.maximum
		end
		if dmg >= max_clamp then
			end_dmg = max_clamp
		elseif dmg <= min_clamp then
			end_dmg = min_clamp
		end
		return end_dmg
	end
	
	local resulting_dmg = incoming_dmg or 0
	
	if managers.player:has_category_upgrade("player", "guardian_damage_clamp_inside_2") and managers.player:has_category_upgrade("player", "guardian_damage_clamp_outside_2") then
		if managers.player:Gilza_is_player_in_guardian_zone() then
			resulting_dmg = clamp_guardian_perk_damage(managers.player:upgrade_value("player", "guardian_damage_clamp_inside_2"), resulting_dmg)
		else
			resulting_dmg = clamp_guardian_perk_damage(managers.player:upgrade_value("player", "guardian_damage_clamp_outside_2"), resulting_dmg)
		end
	elseif managers.player:has_category_upgrade("player", "guardian_damage_clamp_inside_1") and managers.player:has_category_upgrade("player", "guardian_damage_clamp_outside_1") then
		if managers.player:Gilza_is_player_in_guardian_zone() then
			resulting_dmg = clamp_guardian_perk_damage(managers.player:upgrade_value("player", "guardian_damage_clamp_inside_1"), resulting_dmg)
		else
			resulting_dmg = clamp_guardian_perk_damage(managers.player:upgrade_value("player", "guardian_damage_clamp_outside_1"), resulting_dmg)
		end
	end
	
	return resulting_dmg
	
end

local gilza_orig_band_aid_health = PlayerDamage.band_aid_health
function PlayerDamage:band_aid_health()
	if managers.platform:presence() == "Playing" and (self:arrested() or self:need_revive()) then
		return
	end
	
	if managers.player:has_category_upgrade("player", "guardian_reduce_equipment_heal") then
		self:change_health(self:_max_health() * self._healing_reduction * managers.player:upgrade_value("player", "guardian_reduce_equipment_heal", 1))
		self._said_hurt = false
	else
		gilza_orig_band_aid_health(self)
	end
end

local gilza_pre_medbag_health = 0
Hooks:PreHook(PlayerDamage, "recover_health", "Gilza_pre_medbag_heal", function(self)
	if managers.player:has_category_upgrade("player", "guardian_reduce_equipment_heal") then
		gilza_pre_medbag_health = self:get_real_health()
	end
end)

Hooks:PostHook(PlayerDamage, "recover_health", "Gilza_post_medbag_heal", function(self)
	if managers.player:has_category_upgrade("player", "guardian_reduce_equipment_heal") then
		local new_heal = self:_max_health() * self._healing_reduction * managers.player:upgrade_value("player", "guardian_reduce_equipment_heal", 1)
		local wanted_health = gilza_pre_medbag_health + new_heal
		if wanted_health < self:get_real_health() then
			self:change_health((self:get_real_health() - wanted_health) * -1)
		end
	end
end)

-- stoic/guardian hud fixes when playing as client
function PlayerDamage:_update_armor_hud(t, dt)
	local real_armor = self:get_real_armor()
	self._current_armor_fill = math.lerp(self._current_armor_fill, real_armor, 10 * dt)
	
	if managers.player:has_category_upgrade("player", "armor_to_health_conversion") or managers.player:has_category_upgrade("player", "guardian_armor_remover") then --overrides your would-be fake armor from showing on the hud
		managers.hud:set_player_armor({
			current = 0,
			total = 0
		})
	elseif math.abs(self._current_armor_fill - real_armor) > 0.01 then
		managers.hud:set_player_armor({
			current = self._current_armor_fill,
			total = self:_max_armor()
		})
	end

	if self._hurt_value then
		self._hurt_value = math.min(1, self._hurt_value + dt)
	end
end