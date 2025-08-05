-- new berserker - when armor breaks under half health gain damage bonuses and activate HUD flash
Hooks:PreHook(PlayerDamage, "_calc_armor_damage", "Gilza_PlayerDamage_calc_armor_damage_pre", function(self, attack_data)
	-- on armor break
	if self:get_real_armor() > 0 and attack_data.damage >= self:get_real_armor() then
		-- and under half health
		if ( self:_max_health() / self:get_real_health() ) >= 2 then
			
			-- activate new berserk ui/skills
			local melee_duration = false
			local weapon_duration = false
			if managers.player:has_category_upgrade("temporary", "new_berserk_melee_damage_multiplier_1") then
				managers.player:activate_temporary_upgrade("temporary", "new_berserk_melee_damage_multiplier_1")
				Gilza.NSI:activated_new_zerk_melee()
				local skill = managers.player:upgrade_value("temporary", "new_berserk_melee_damage_multiplier_1")
				if skill and type(skill) ~= "number" then
					melee_duration = skill[2]
				end
			end

			if managers.player:has_category_upgrade("temporary", "new_berserk_weapon_damage_multiplier") and managers.player:has_category_upgrade("temporary", "new_berserk_weapon_damage_multiplier_cooldown") then
				if not managers.player:has_activate_temporary_upgrade("temporary", "new_berserk_weapon_damage_multiplier_cooldown") then
					managers.player:activate_temporary_upgrade("temporary", "new_berserk_weapon_damage_multiplier")
					managers.player:activate_temporary_upgrade("temporary", "new_berserk_weapon_damage_multiplier_cooldown")
					Gilza.NSI:activated_new_zerk_firearms()
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

-- new damage reduction skills/perks
Hooks:PreHook(PlayerDamage, "damage_bullet", "Gilza_pre_player_damage_bullet", function(self, attack_data)
	
	local att_unit = attack_data.attacker_unit
	Gilza.latest_bullet_attacker_unit = att_unit
	
	-- check enemy unit position relative to camera direction
	if managers.player:has_category_upgrade("player", "yakuza_behind_player_resist") then
		local player_unit = managers.player:player_unit()
		local camera = player_unit:camera()
		local looking_at = Vector3(camera:forward().x,camera:forward().y,0)
		local attacking_pos = Vector3(att_unit:position().x,att_unit:position().y,0)
		local taking_pos = Vector3(camera:position().x,camera:position().y,0)
		local normalized_in_space_difference = (attacking_pos - taking_pos):normalized()
		local target_dir = mvector3.dot(looking_at, normalized_in_space_difference)
		managers.player._last_damage_taken_direction = target_dir -- reports negative values for 180 degrees behind player. verticality is ignored.
	end
	
	-- guardian's damage clamp is applied before any other damage resist
	if managers.player:has_category_upgrade("player", "guardian_area_passive") then
		attack_data.damage = self:Gilza_calculate_guardian_damage_clamp(attack_data.damage)
	end
	
	-- porcupine "reflect", for the most part code copied from copycat richochet
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
	
	-- AP sniper shot resist. initially was made for brawler as a passive, but later added to yakuza while under half health, so yakuza's version has an additional check
	if self:get_real_armor() > 0 then
		if managers.player:has_category_upgrade("player", "AP_damage_resist_brawler") and attack_data.armor_piercing == true then
			-- if we have yakuza, check under half health requirement
			if managers.player:has_category_upgrade("player", "armor_regen_damage_health_ratio_multiplier") then
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

-- allow counterstrike skill to deal damage
PlayerDamage._Gilza_WasCounterAttacking = false -- if we counterattacked, we reset chainsaw damage effect in a posthook for damage_melee func
Hooks:PreHook(PlayerDamage, "damage_melee", "Gilza_pre_player_damage_melee", function(self, attack_data)
	
	if attack_data.damage and managers.player:has_category_upgrade("player", "guardian_area_passive") then
		attack_data.damage = self:Gilza_calculate_guardian_damage_clamp(attack_data.damage)
	end
	
	-- mostly based on default melee attack code
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

-- interupt melee hold after a counterattack, to specifically stop chainsaw damage
-- this also causes all melees to almost instantly get unequiped. i deem this a feature and not a bug, since it's actually sometimes helpful. lazyness lead development.
Hooks:PostHook(PlayerDamage, "damage_melee", "Gilza_post_player_damage_melee", function(self, attack_data)
	if self._Gilza_WasCounterAttacking then
		self._unit:movement():current_state():_interupt_action_melee(managers.player:player_timer():time())
	end
end)

-- apply swan song speed boost if a human player is downed at moment of swang song activation. TODO: add checks for friendly AI as well
Hooks:PostHook(PlayerDamage, "_on_enter_swansong_event", "Gilza_post_PlayerDamage_on_enter_swansong_event", function(self)
	
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

-- add armor on dodge from new skill and a bunch of UI stuff
Hooks:PostHook(PlayerDamage, "init", "Gilza_post_PlayerDamage_init", function(self)
	
	if Gilza.VHP_enabled then
		if managers.player:has_category_upgrade("player", "menace_panic_spread") then
			managers.gameinfo:event("buff", "activate", "stockholm_basic_stacks")
			managers.gameinfo:event("buff", "set_value", "stockholm_basic_stacks", { value = math.random() })
		end
		if managers.player:has_category_upgrade("temporary", "single_body_shot_kill_reload") then
			managers.gameinfo:event("buff", "activate", "body_economy_stacks")
			managers.gameinfo:event("buff", "set_value", "body_economy_stacks", { value = -69 })
			managers.gameinfo:event("buff", "deactivate", "body_economy_stacks")
		end
	end
	
	-- the so called "gilza perk UI". somewhat flexible if we decide to add this element to more perks
	local function CreatePerkGUI()
		
		-- icon itself
		local function AddDefaultPerkGUI(panel_name, default_visibility, icon_loc_string)
			if not managers.hud or not managers.hud:script(PlayerBase.PLAYER_INFO_HUD_PD2) then
				return
			end
			local hud = managers.hud:script(PlayerBase.PLAYER_INFO_HUD_PD2)
			if not hud.panel:child(panel_name) then
				local image_scale = Gilza.settings.junkie_icon_scale -- can you tell that this was not a planned from the start feature yet?
				local x_position = Gilza.settings.junkie_icon_x_pos
				local y_position = Gilza.settings.junkie_icon_y_pos
				hud.panel:bitmap({
					name = panel_name,
					visible = default_visibility,
					texture = icon_loc_string,
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
		
		-- text under icon
		local function AddDefaultPerkGUITextAddon(pm_var_name, panel_name, default_string)
			if not managers.hud or not managers.hud:script(PlayerBase.PLAYER_INFO_HUD_PD2) then
				return
			end
			local hud = managers.hud:script(PlayerBase.PLAYER_INFO_HUD_PD2)
			local image_scale = Gilza.settings.junkie_icon_scale
			local x_position = Gilza.settings.junkie_icon_x_pos
			local y_position = Gilza.settings.junkie_icon_y_pos
			
			if not managers.player[pm_var_name] then
				managers.player[pm_var_name] = OutlinedText:new(hud.panel, {
					name = panel_name,
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
				local str = default_string or "0"
				managers.player[pm_var_name]:set_text(str)
				managers.player[pm_var_name]:set_outlines_visible(true)
				managers.player[pm_var_name]:set_alpha(1)
				managers.player[pm_var_name]:show()
				managers.player[pm_var_name]:set_visible(false)
			end
		end
		
		-- speed junkie
		if managers.player:has_category_upgrade("player", "speed_junkie_meter") then
			AddDefaultPerkGUI("Gilza_speed_junkie_GUI_icon", true, "guis/dlcs/Gilza/textures/pd2/specialization/junkie_icon")
			AddDefaultPerkGUITextAddon("_Gilza_junkie_counter_GUI", "Gilza_speed_junkie_GUI_counter")
			managers.player:Gilza_update_junkie_loop()
		end
		
		-- guardian
		if managers.player:has_category_upgrade("player", "guardian_area_passive") then
			AddDefaultPerkGUI("Gilza_guardian_GUI_icon", false, "guis/dlcs/Gilza/textures/pd2/specialization/guardian_icon")
			managers.player:Gilza_start_guardian_tracking()
		end
		
		-- gambler
		if managers.player:has_category_upgrade("temporary", "loose_ammo_restore_health") then
			AddDefaultPerkGUI("Gilza_new_gambler_GUI_icon", true, "guis/dlcs/Gilza/textures/pd2/specialization/new_gambler_icon")
			AddDefaultPerkGUITextAddon("_Gilza_new_gambler_dodge_counter_GUI", "Gilza_new_gambler_dodge_counter_GUI")
			managers.player:Gilza_new_gambler_recursive_updater()
		end
		
		-- hitman
		if managers.player:has_category_upgrade("temporary", "death_dance_combo_invulnerability") then
			AddDefaultPerkGUI("Gilza_new_hitman_GUI_icon", true, "guis/dlcs/Gilza/textures/pd2/specialization/new_hitman_icon")
			AddDefaultPerkGUITextAddon("_Gilza_new_hitman_combo_counter_GUI", "Gilza_new_hitman_combo_counter_GUI", "0x")
			managers.player:Gilza_new_hitman_recursive_updater()
		end
		
		-- brawler
		if managers.player:has_category_upgrade("player", "damage_resist_teammates_brawler") or (managers.player:has_category_upgrade("player", "copycat_9th_card_identifier") and managers.player:has_category_upgrade("player", "armor_regen_brawler")) then
			AddDefaultPerkGUI("Gilza_brawler_GUI_icon", true, "guis/dlcs/Gilza/textures/pd2/specialization/brawler_icon")
			if managers.player:has_category_upgrade("player", "armor_regen_brawler") then
				AddDefaultPerkGUITextAddon("_Gilza_new_brawler_regen_counter_GUI", "Gilza_new_brawler_regen_counter_GUI", "0x")
			end
			managers.player:Gilza_brawler_recursive_updater()
		end
	
	end
	CreatePerkGUI()
	
	-- revitalized + speed junkie
	managers.player:unregister_message(Message.OnPlayerDodge, "Gilza_armor_on_dodge_skill")
	
	managers.player:register_message(Message.OnPlayerDodge, "Gilza_armor_on_dodge_skill", function()
		
		local excluded_state = {
			["bleed_out"] = true,
			["fatal"] = true,
			["incapacitated"] = true,
			["arrested"] = true,
			["jerry1"] = true
		}
		if managers.player:has_category_upgrade("temporary", "player_speed_junkie_armor_on_dodge") and not excluded_state[managers.player:current_state()] then
			if not managers.player:has_activate_temporary_upgrade("temporary", "player_speed_junkie_armor_on_dodge") then
				if self._unit and alive(self._unit) and self._unit.character_damage then
					managers.player:activate_temporary_upgrade("temporary", "player_speed_junkie_armor_on_dodge")
					if self:get_real_armor() > 0 then
						self._unit:character_damage():restore_armor(managers.player:temporary_upgrade_value("temporary", "player_speed_junkie_armor_on_dodge", 0))
					else
						self._unit:character_damage():restore_armor(managers.player:temporary_upgrade_value("temporary", "player_speed_junkie_armor_on_dodge", 0) * 3)
					end
				end
			end
		end
		if managers.player:has_category_upgrade("temporary", "player_dodge_armor_regen") and not excluded_state[managers.player:current_state()] and self:get_real_armor() <= 0 then -- can it even be less?
			if not managers.player:has_activate_temporary_upgrade("temporary", "player_dodge_armor_regen") then
				if self._unit and alive(self._unit) and self._unit.character_damage then
					managers.player:activate_temporary_upgrade("temporary", "player_dodge_armor_regen")
					Gilza.NSI:activated_revitalized_cd()
					self._unit:character_damage():restore_armor(managers.player:temporary_upgrade_value("temporary", "player_dodge_armor_regen", 0))
				end
			end
		end
	end)
end)

Hooks:PreHook(PlayerDamage, "pre_destroy", "Gilza_pre_PlayerDamage_pre_destroy", function(self)
	managers.player:unregister_message(Message.OnPlayerDodge, "Gilza_armor_on_dodge_skill")
end)

-- armor recovery related skills. this func triggers, after getting shot or supressed
local orig_timer_to_max = PlayerDamage.set_regenerate_timer_to_max
Hooks:OverrideFunction(PlayerDamage, "set_regenerate_timer_to_max", function (self)
	local is_regenrating_armor = self._current_state and self._update_regenerate_timer and self._current_state == self._update_regenerate_timer
	-- deprecated hitman rework
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
		-- if we have the new supression resist skill from yakuza, make supression delay 0. this completely removes the supression armor delay effect
		if tweak_data.player.suppression.decay_start_delay ~= 0 then
			tweak_data.player.suppression.decay_start_delay = 0
		end
		local mul = managers.player:body_armor_regen_multiplier(alive(self._unit) and self._unit:movement():current_state()._moving, self:health_ratio())
		-- however, this 1 sec delay timer is usually added to the regen timer as a flat value.
		-- because of that vanilla yakuza has best possible armor regen at ~1.765 secs with 2 additional recovery skills from tank subtree in enforcer
		-- if we dont compensate armor recovery delay, new best possible recovery timer becomes ~0.765 seconds which is a bit too good imo
		-- so we compensate lack of suppression by adding a lower flat timer. new best recovery becomes ~1.265 secs, but only ~1.34 secs at 10% health, which is the main balance target
		self._regenerate_timer = tweak_data.player.damage.REGENERATE_TIME * mul * managers.player:upgrade_value("player", "armor_regen_time_mul", 1)
		local regen_compensation = 0.5
		self._regenerate_timer = self._regenerate_timer + regen_compensation
		self._regenerate_speed = self._regenerate_speed or 1
		self._current_state = self._update_regenerate_timer
	elseif managers.player:has_category_upgrade("player", "store_armor_recovery_bonus_timer") then
		-- if we have new 9th card from ex-president, on taking damage, reduce armor regen timer, based on amount of kills
		-- but never reduce it beyond a specified timer
		-- this specifically applies before armor recovery boosting skills, to the flat 3 (in online) sec armor recovery timer 
		if tweak_data.player.damage.REGENERATE_TIME + managers.player:Gilza_new_expres_armor_regen_bonus_timer_on_kill() >= 0.8 then
			self._regenerate_timer = tweak_data.player.damage.REGENERATE_TIME + managers.player:Gilza_new_expres_armor_regen_bonus_timer_on_kill()
		else
			self._regenerate_timer = 0.8
		end
		
		-- mostly vanilla
		local mul = managers.player:body_armor_regen_multiplier(alive(self._unit) and self._unit:movement():current_state()._moving, self:health_ratio())
		self._regenerate_timer = self._regenerate_timer * mul
		self._regenerate_timer = self._regenerate_timer * managers.player:upgrade_value("player", "armor_regen_time_mul", 1)
		self._regenerate_speed = self._regenerate_speed or 1
		self._current_state = self._update_regenerate_timer
	elseif managers.player:has_category_upgrade("temporary", "akimbo_pistol_armor_regen_timer_multiplier") then
		-- new hitman
		local mul = managers.player:body_armor_regen_multiplier(alive(self._unit) and self._unit:movement():current_state()._moving, self:health_ratio())
		self._regenerate_timer = tweak_data.player.damage.REGENERATE_TIME * mul
		local recovery_bonus = managers.player:temporary_upgrade_value("temporary", "akimbo_pistol_armor_regen_timer_multiplier", 1)
		if managers.player:has_activate_temporary_upgrade("temporary", "player_bounty_hunter") then
			recovery_bonus = 1 - ((1 - recovery_bonus) * 2)
		end
		self._regenerate_timer = self._regenerate_timer * recovery_bonus
		self._regenerate_timer = self._regenerate_timer * managers.player:upgrade_value("player", "armor_regen_time_mul", 1)
		self._regenerate_speed = self._regenerate_speed or 1
		self._current_state = self._update_regenerate_timer
	else
		orig_timer_to_max(self)
	end
end)

-- armor recovery progress
local orig_update_regenerate_timer = PlayerDamage._update_regenerate_timer
Hooks:OverrideFunction(PlayerDamage, "_update_regenerate_timer", function (self, t, dt)
	-- DEPRECATED: while new skill upgrade is active regen timer updates it's value to itself instead of reducing it, effectively freezing the timer
	if managers.player:has_activate_temporary_upgrade("temporary", "player_new_hitman_regen") and self:get_real_armor() > 0 then
		self._regenerate_timer = self._regenerate_timer
	-- junkie
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
	
	-- new ex-pres card #7 bonus. if we have any amount of stacks and we take health damage, stacks will "shield" incoming damage by absorbing damage first, and then damaging health
	if managers.player:has_category_upgrade("player", "armor_health_store_shield") and not (self:get_real_armor() > 0) and attack_data.damage > 0 then
		if self._armor_stored_health > 0 then
			-- reduce incoming dmg with stored stacks
			if self._armor_stored_health - attack_data.damage <= 0 then
				self._armor_stored_health = 0
				attack_data.damage = attack_data.damage - self._armor_stored_health
				self:update_armor_stored_health()
			else -- if stored health can tank dmg, stored health gets reduced and incoming dmg is reduced to 0
				self._armor_stored_health = self._armor_stored_health - attack_data.damage
				self:update_armor_stored_health()
				return 0
			end
		end
	end
	
	-- copycat
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
			if new_health <= 0 then -- preven health from going bellow 0 if invlun was proced
				attack_data.damage = attack_data.damage + new_health - 0.1 -- leave at 1
			end
		end
	end

	local health_subtracted = 0
	health_subtracted = self:get_real_health()

	self:change_health(-attack_data.damage)

	health_subtracted = health_subtracted - self:get_real_health()
	
	-- removed vanilla leech teammate regen

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

-- guardian armor cut
local gilza_orig_max_armor = PlayerDamage._max_armor
Hooks:OverrideFunction(PlayerDamage, "_max_armor", function(self)
	if managers.player:has_category_upgrade("player", "guardian_armor_remover") then
		return 0
	else
		return gilza_orig_max_armor(self)
	end
end)

-- applies before DR skills
function PlayerDamage:Gilza_calculate_guardian_damage_clamp(incoming_dmg)
	
	-- using funny calculations to (maybe?) avoid float point errors from math.clamp
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
	
	-- skill level and zone proximity check. todo: maybe rework upgrades on the backend to be a singular upgrade with 2 different levels like grenade ammo pick up, instead of this shit?
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

-- faks heal guardian less since he gets a fuck ton of healing allready with a stupid high health pool, sitting on top of FAK's with it would be even more stupid
local gilza_orig_band_aid_health = PlayerDamage.band_aid_health
Hooks:OverrideFunction(PlayerDamage, "band_aid_health", function (self)
	if managers.platform:presence() == "Playing" and (self:arrested() or self:need_revive()) then
		return
	end
	
	if managers.player:has_category_upgrade("player", "guardian_reduce_equipment_heal") then
		self:change_health(self:_max_health() * self._healing_reduction * managers.player:upgrade_value("player", "guardian_reduce_equipment_heal", 1))
		self._said_hurt = false
	else
		gilza_orig_band_aid_health(self)
	end
end)

-- adjust doc bags healing for guardian. pre/post hooks always better than func overrides
local gilza_pre_medbag_health = 0
Hooks:PreHook(PlayerDamage, "recover_health", "Gilza_PlayerDamage_pre_medbag_heal", function(self)
	if managers.player:has_category_upgrade("player", "guardian_reduce_equipment_heal") then
		gilza_pre_medbag_health = self:get_real_health()
	end
end)

-- after doc bag heal reduce HP to wanted level, if we aren't there yet
Hooks:PostHook(PlayerDamage, "recover_health", "Gilza_PlayerDamage_post_medbag_heal", function(self)
	if managers.player:has_category_upgrade("player", "guardian_reduce_equipment_heal") then
		local new_heal = self:_max_health() * self._healing_reduction * managers.player:upgrade_value("player", "guardian_reduce_equipment_heal", 1)
		local wanted_health = gilza_pre_medbag_health + new_heal
		if wanted_health < self:get_real_health() then
			self:change_health((self:get_real_health() - wanted_health) * -1)
		end
	end
end)

-- stoic/guardian hud fix when playing as client (aka fake phantom armor). tis a vanilla bug btw
Hooks:OverrideFunction(PlayerDamage, "_update_armor_hud", function (self, t, dt)
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
end)

-- when armor fully regens by any means, reset ex-president's 9th card bonus timer to 0
Hooks:PostHook(PlayerDamage, "_regenerate_armor", "Gilza_post_PlayerDamage_regenerate_armor", function(self, no_sound)
	managers.player:Gilza_new_expres_armor_regen_bonus_timer_on_kill_reset()
end)

-- hitman's combo
function PlayerDamage:Gilza_add_damage_invuln_timer(duration)
	self._can_take_dmg_timer = self._can_take_dmg_timer + duration
end

-- revive assosiated stuff like yakuza, up u go, leech and junkie
Hooks:OverrideFunction(PlayerDamage, "revive", function (self, silent)
	
	if Application:digest_value(self._revives, false) == 0 then
		self._revive_health_multiplier = nil

		return
	end

	local arrested = self:arrested()

	managers.player:set_player_state("standard")
	managers.player:remove_copr_risen_cooldown()

	if not silent then
		PlayerStandard.say_line(self, "s05x_sin")
	end

	self._bleed_out = false
	self._incapacitated = nil
	self._downed_timer = nil
	self._downed_start_time = nil

	-- always revive yakuza at 10% health
	if managers.player:has_category_upgrade("player", "armor_regen_damage_health_ratio_multiplier") then
		tweak_data.player.damage.REVIVE_HEALTH_STEPS = {0.1}
	end

	if not arrested then
		-- new up u go
		if managers.player:has_category_upgrade("player", "health_regain_V2") then
			self:set_health(self:_max_health() * tweak_data.player.damage.REVIVE_HEALTH_STEPS[self._revive_health_i] * (self._revive_health_multiplier or 1) + (self:_max_health() * managers.player:upgrade_value("player", "health_regain_V2", 0)))
		else
			self:set_health(self:_max_health() * tweak_data.player.damage.REVIVE_HEALTH_STEPS[self._revive_health_i] * (self._revive_health_multiplier or 1) * managers.player:upgrade_value("player", "revived_health_regain", 1))
		end
		self:set_armor(self:_max_armor())

		self._revive_health_i = math.min(#tweak_data.player.damage.REVIVE_HEALTH_STEPS, self._revive_health_i + 1)
		self._revive_miss = 2
	end

	self:_regenerate_armor()
	managers.hud:set_player_health({
		current = self:get_real_health(),
		total = self:_max_health(),
		revives = Application:digest_value(self._revives, false)
	})
	self:_send_set_health()
	self:_set_health_effect()
	managers.hud:pd_stop_progress()

	self._revive_health_multiplier = nil

	self._listener_holder:call("on_revive")

	if managers.player:has_inactivate_temporary_upgrade("temporary", "revived_damage_resist") then
		managers.player:activate_temporary_upgrade("temporary", "revived_damage_resist")
	end

	if managers.player:has_inactivate_temporary_upgrade("temporary", "increased_movement_speed") then
		managers.player:activate_temporary_upgrade("temporary", "increased_movement_speed")
	end

	if managers.player:has_inactivate_temporary_upgrade("temporary", "swap_weapon_faster") then
		managers.player:activate_temporary_upgrade("temporary", "swap_weapon_faster")
	end

	if managers.player:has_inactivate_temporary_upgrade("temporary", "reload_weapon_faster") then
		managers.player:activate_temporary_upgrade("temporary", "reload_weapon_faster")
	end
	
	-- add some junkie adrenaline after revival to avoid being instantly dead again
	if managers.player:has_category_upgrade("player", "speed_junkie_meter") then
		managers.player._Gilza_junkie_counter = (managers.player._Gilza_junkie_counter or 0) + math.random(18,42)
	end
	
	-- leech CD speed up on reivival of local player
	if managers.player:has_category_upgrade("temporary", "copr_ability") and not managers.player:has_activate_temporary_upgrade("temporary", "copr_ability") then
		local secs = managers.player:upgrade_value("player", "copr_regain_cooldown_on_revives", 0)
		if secs > 0 then
			managers.player:speed_up_grenade_cooldown(secs)
		end
	end
	
end)

-- yakuza heal protection
local gilza_orig_PlayerDamage_set_revive_boost = PlayerDamage.set_revive_boost
Hooks:OverrideFunction(PlayerDamage, "set_revive_boost", function (self, revive_health_level)
	if managers.player:has_category_upgrade("player", "armor_regen_damage_health_ratio_multiplier") then
		-- ignore healing
	else
		gilza_orig_PlayerDamage_set_revive_boost(self, revive_health_level)
	end
end)

-- yakuza heal protection #2 + leech dire state
local gilza_orig_PlayerDamage_restore_health = PlayerDamage.restore_health
Hooks:OverrideFunction(PlayerDamage, "restore_health", function (self, health_restored, is_static, chk_health_ratio)
	if managers.player:has_category_upgrade("player", "armor_regen_damage_health_ratio_multiplier") then
		local has_health = managers.player:player_unit() and managers.player:player_unit():character_damage() and managers.player:player_unit():character_damage():get_real_health() > 0.01
		if has_health and health_restored > 0 then
			return false
		else -- idk when and how this can happen, but why not
			gilza_orig_PlayerDamage_restore_health(self, health_restored, is_static, chk_health_ratio)
		end
	elseif managers.player:has_category_upgrade("temporary", "copr_ability") then
		if self._gilza_leech_dire_state then
			return false
		else
			gilza_orig_PlayerDamage_restore_health(self, health_restored, is_static, chk_health_ratio)
		end
	else
		gilza_orig_PlayerDamage_restore_health(self, health_restored, is_static, chk_health_ratio)
	end
end)

-- leech - after taking damage to a segment, activate (1) sec invuln. this is proccessed before damage_melee and such
Hooks:OverrideFunction(PlayerDamage, "copr_update_attack_data", function (self, attack_data)
	if managers.player:has_activate_temporary_upgrade("temporary", "copr_ability") then
		local static_damage_ratio = managers.player:upgrade_value_nil("player", "copr_static_damage_ratio")
		
		if static_damage_ratio and attack_data.damage > 0 then
			local high_damage_tweak = tweak_data.upgrades.copr_high_damage_multiplier
			local damage_multiplier = high_damage_tweak[1] <= attack_data.damage and high_damage_tweak[2] or 1
			attack_data.damage = self:_max_health() * static_damage_ratio * damage_multiplier
			
			-- dont activate again if invuln is already active
			if not self:_chk_dmg_too_soon(attack_data.damage) then
				self._Gilza_new_leech_invuln_activator = true
			end
		end
	end
end)

-- following few posthooks activate the leech invuln upgrade itself. need to be done this way to allow for these funcs to deal damage to player first, and only afterwards we get invuln
Hooks:PostHook(PlayerDamage, "damage_melee", "Gilza_post_PlayerDamage_damage_melee_leech_invuln_activator", function(self, attack_data)
	if self._Gilza_new_leech_invuln_activator and managers.player:has_inactivate_temporary_upgrade("temporary", "copr_invuln_on_segment_loss") then
		self._Gilza_new_leech_invuln_activator = false
		managers.player:activate_temporary_upgrade("temporary", "copr_invuln_on_segment_loss")
		local invuln_timer_dur = tweak_data.upgrades.values.temporary.copr_invuln_on_segment_loss[1][2]
		self._next_allowed_dmg_t = Application:digest_value(managers.player:player_timer():time() + invuln_timer_dur, true)
		self._last_received_dmg = self:_max_health() * 5
	end
end)

Hooks:PostHook(PlayerDamage, "damage_bullet", "Gilza_post_PlayerDamage_damage_bullet_leech_invuln_activator", function(self, attack_data)
	if self._Gilza_new_leech_invuln_activator and managers.player:has_inactivate_temporary_upgrade("temporary", "copr_invuln_on_segment_loss") then
		self._Gilza_new_leech_invuln_activator = false
		managers.player:activate_temporary_upgrade("temporary", "copr_invuln_on_segment_loss")
		local invuln_timer_dur = tweak_data.upgrades.values.temporary.copr_invuln_on_segment_loss[1][2]
		self._next_allowed_dmg_t = Application:digest_value(managers.player:player_timer():time() + invuln_timer_dur, true)
		self._last_received_dmg = self:_max_health() * 5
	end
end)

Hooks:PostHook(PlayerDamage, "damage_explosion", "Gilza_post_PlayerDamage_damage_explosion_leech_invuln_activator", function(self, attack_data)
	if self._Gilza_new_leech_invuln_activator and managers.player:has_inactivate_temporary_upgrade("temporary", "copr_invuln_on_segment_loss") then
		self._Gilza_new_leech_invuln_activator = false
		managers.player:activate_temporary_upgrade("temporary", "copr_invuln_on_segment_loss")
		local invuln_timer_dur = tweak_data.upgrades.values.temporary.copr_invuln_on_segment_loss[1][2]
		self._next_allowed_dmg_t = Application:digest_value(managers.player:player_timer():time() + invuln_timer_dur, true)
		self._last_received_dmg = self:_max_health() * 5
	end
end)

Hooks:PostHook(PlayerDamage, "damage_fire_hit", "Gilza_post_PlayerDamage_damage_fire_hit_leech_invuln_activator", function(self, attack_data)
	if self._Gilza_new_leech_invuln_activator and managers.player:has_inactivate_temporary_upgrade("temporary", "copr_invuln_on_segment_loss") then
		self._Gilza_new_leech_invuln_activator = false
		managers.player:activate_temporary_upgrade("temporary", "copr_invuln_on_segment_loss")
		local invuln_timer_dur = tweak_data.upgrades.values.temporary.copr_invuln_on_segment_loss[1][2]
		self._next_allowed_dmg_t = Application:digest_value(managers.player:player_timer():time() + invuln_timer_dur, true)
		self._last_received_dmg = self:_max_health() * 5
	end
end)

-- force leech cooldown after going down
Hooks:PostHook(PlayerDamage, "on_downed", "Gilza_post_PlayerDamage_on_downed", function(self, attack_data)
	if managers.player:has_category_upgrade("temporary", "copr_ability") then
		self._gilza_leech_dire_state = false
		local remaining_cooldown = managers.player:get_timer_remaining("replenish_grenades") or 0
		if remaining_cooldown < 20 then -- todo: maybe make this into a proper upgradestweak?
			if remaining_cooldown == 0 then
				managers.player:replenish_grenades(20) -- cd
				managers.player:add_grenade_amount(-1) -- remove ability
				local speed_up_on_kill_time = managers.player:upgrade_value("player", "copr_speed_up_on_kill", 0)
				local function speed_up_on_kill_func()
					managers.player:speed_up_grenade_cooldown(speed_up_on_kill_time)
				end
				managers.player:register_message(Message.OnEnemyKilled, "speed_up_copr_ability", speed_up_on_kill_func) -- add 1 sec on kill if we have skill
			else
				managers.player:speed_up_grenade_cooldown(-1 * (20 - remaining_cooldown))
			end
		end
	end
end)

-- leech ampule end cleanup and heal
Hooks:PostHook(PlayerDamage, "on_copr_ability_deactivated", "Gilza_post_PlayerDamage_on_copr_ability_deactivated", function(self)
	if managers.player._Gilza_leech_did_revive_during_effect then -- this var is disabled in playermanager
		self:restore_health(self:_max_health(), true, false)
		self:restore_armor(self:_max_armor())
		local secs = managers.player:upgrade_value("player", "copr_regain_cooldown_on_revives", 0)
		if secs > 0 then
			managers.player:speed_up_grenade_cooldown(secs)
		end
	end
	self._gilza_leech_dire_state = false
end)

-- leech dire state tracker
Hooks:PostHook(PlayerDamage, "update", "Gilza_post_player_dmg_update", function(self, unit, t, dt)
	if managers.player:has_activate_temporary_upgrade("temporary", "copr_ability") then
		local out_of_health = self:health_ratio() + 0.01 < managers.player:upgrade_value("player", "copr_static_damage_ratio", 0)
		if out_of_health and not managers.player:has_activate_temporary_upgrade("temporary", "copr_invuln_on_segment_loss") then
			self._block_medkit_auto_revive = true
			self._gilza_leech_dire_state = true
		elseif not out_of_health then
			self._block_medkit_auto_revive = false
			self._gilza_leech_dire_state = false
		end
	end
end)

-- new fall damage immunity skill
local gilza_orig_playerDamage_damage_fall = PlayerDamage.damage_fall
Hooks:OverrideFunction(PlayerDamage, "damage_fall", function (self, data)
	if managers.player:has_category_upgrade("player", "limited_fall_damage_immunity") then
		local will_block_fall = false
		local is_free_falling = self._unit:movement():current_state_name() == "jerry1"
		if self._god_mode and not is_free_falling or self._invulnerable or self._mission_damage_blockers.invulnerable then
			will_block_fall = true
		elseif self:incapacitated() then
			will_block_fall = true
		elseif self._unit:movement():current_state().immortal then
			will_block_fall = true
		elseif self._mission_damage_blockers.damage_fall_disabled then
			will_block_fall = true
		end
		local height_limit = 300
		local death_limit = 631 -- vanilla btw
		if data.height < height_limit then
			will_block_fall = true
		end
		local die = death_limit < data.height
		
		-- if we can, use a charge and pretend that our fall distance wasn't lethal
		if not will_block_fall and not is_free_falling and die and managers.player:limited_fall_damage_charges() >= 1 then
			managers.player:use_limited_fall_damage_charge()
			managers.hud:show_hint({text = managers.localization:text("Gilza_used_limited_fall_damage_immunity_charge")..tostring(managers.player:limited_fall_damage_charges())})
			data.height = 630
			gilza_orig_playerDamage_damage_fall(self, data)
		else
			gilza_orig_playerDamage_damage_fall(self, data)
		end
	else
		gilza_orig_playerDamage_damage_fall(self, data)
	end
end)