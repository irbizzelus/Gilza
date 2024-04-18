if not Gilza then
	dofile("mods/Gilza/lua/1_GilzaBase.lua")
end

-- new faster melee charge skill
Hooks:OverrideFunction(PlayerStandard, "_get_melee_charge_lerp_value", function (self, t, offset)
	offset = offset or 0
	local melee_entry = managers.blackmarket:equipped_melee_weapon()
	local max_charge_time = tweak_data.blackmarket.melee_weapons[melee_entry].stats.charge_time

	if not self._state_data.melee_start_t then
		return 0
	end

	local original_result = math.clamp(t - self._state_data.melee_start_t - offset, 0, max_charge_time) / max_charge_time
	return math.clamp(original_result * managers.player:upgrade_value("player", "melee_faster_charge", 1), 0, 1)
end)

-- sprint while melee'ing @38-51, @77-93
Hooks:OverrideFunction(PlayerStandard, "_start_action_running", function (self, t)
	if not self._move_dir then
		self._running_wanted = true

		return
	end

	if self:on_ladder() or self:_on_zipline() then
		return
	end

	if self._shooting and not self._equipped_unit:base():run_and_shoot_allowed() or self._use_item_expire_t or self._state_data.in_air or self:_is_throwing_projectile() or self:_is_charging_weapon() or self:_changing_weapon() then
		self._running_wanted = true

		return
	end
	
	
	if self:_is_meleeing() then -- moved melee check from block above for ease of access
		if not managers.player:has_category_upgrade("player", "melee_sprint") then -- just like base game
			self._running_wanted = true
			return
		else
			-- if we have skill dont reset sprint
		end
	end

	if self._state_data.ducking and not self:_can_stand() then
		self._running_wanted = true

		return
	end

	if not self:_can_run_directional() then
		return
	end

	self._running_wanted = false

	if managers.player:get_player_rule("no_run") then
		return
	end

	if not self._unit:movement():is_above_stamina_threshold() then
		return
	end

	if (not self._state_data.shake_player_start_running or not self._ext_camera:shaker():is_playing(self._state_data.shake_player_start_running)) and self._setting_use_headbob then
		self._state_data.shake_player_start_running = self._ext_camera:play_shaker("player_start_running", 0.75)
	end

	self:set_running(true)

	self._end_running_expire_t = nil
	self._start_running_t = t
	self._play_stop_running_anim = nil
	
	if managers.player:has_category_upgrade("player", "melee_sprint") then
		if (not self:_is_reloading() or not self.RUN_AND_RELOAD) and not self:_is_meleeing() then
			if not self._equipped_unit:base():run_and_shoot_allowed() then
				self._ext_camera:play_redirect(self:get_animation("start_running"))
			else
				self._ext_camera:play_redirect(self:get_animation("idle"))
			end
		end
	else
		if not self:_is_reloading() or not self.RUN_AND_RELOAD then
			if not self._equipped_unit:base():run_and_shoot_allowed() then
				self._ext_camera:play_redirect(self:get_animation("start_running"))
			else
				self._ext_camera:play_redirect(self:get_animation("idle"))
			end
		end
	end

	if not self.RUN_AND_RELOAD then
		self:_interupt_action_reload(t)
	end

	self:_interupt_action_steelsight(t)
	self:_interupt_action_ducking(t)

	--self:_stance_entered()
end)

-- fixes sprint reseting when starting melee charge with sprint skill @110 and adds chainsaw stuff @172
Hooks:OverrideFunction(PlayerStandard, "_start_action_melee", function (self, t, input, instant)
	self._equipped_unit:base():tweak_data_anim_stop("fire")
	self:_interupt_action_reload(t)
	self:_interupt_action_steelsight(t)
	if not managers.player:has_category_upgrade("player", "melee_sprint") then -- over here
		self:_interupt_action_running(t)
	end
	self:_interupt_action_charging_weapon(t)

	self._state_data.melee_charge_wanted = nil
	self._state_data.meleeing = true
	self._state_data.melee_start_t = nil
	local melee_entry = managers.blackmarket:equipped_melee_weapon()
	local primary = managers.blackmarket:equipped_primary()
	local primary_id = primary.weapon_id
	local bayonet_id = managers.blackmarket:equipped_bayonet(primary_id)
	local bayonet_melee = false

	if bayonet_id and melee_entry == "weapon" and self._equipped_unit:base():selection_index() == 2 then
		bayonet_melee = true
	end

	if instant then
		self:_do_action_melee(t, input)

		return
	end

	self:_stance_entered()

	if self._state_data.melee_global_value then
		self._camera_unit:anim_state_machine():set_global(self._state_data.melee_global_value, 0)
	end

	local melee_entry = managers.blackmarket:equipped_melee_weapon()
	self._state_data.melee_global_value = tweak_data.blackmarket.melee_weapons[melee_entry].anim_global_param

	self._camera_unit:anim_state_machine():set_global(self._state_data.melee_global_value, 1)

	local current_state_name = self._camera_unit:anim_state_machine():segment_state(self:get_animation("base"))
	local attack_allowed_expire_t = tweak_data.blackmarket.melee_weapons[melee_entry].attack_allowed_expire_t or 0.15
	self._state_data.melee_attack_allowed_t = t + (current_state_name ~= self:get_animation("melee_attack_state") and attack_allowed_expire_t or 0)
	local instant_hit = tweak_data.blackmarket.melee_weapons[melee_entry].instant

	if not instant_hit then
		self._ext_network:send("sync_melee_start", 0)
	end

	if current_state_name == self:get_animation("melee_attack_state") then
		self._ext_camera:play_redirect(self:get_animation("melee_charge"))

		return
	end

	local offset = nil

	if current_state_name == self:get_animation("melee_exit_state") then
		local segment_relative_time = self._camera_unit:anim_state_machine():segment_relative_time(self:get_animation("base"))
		offset = (1 - segment_relative_time) * 0.9
	end

	offset = math.max(offset or 0, attack_allowed_expire_t)

	self._ext_camera:play_redirect(self:get_animation("melee_enter"), nil, offset)
	
	-- set chainsaw mode active
	if tweak_data.blackmarket.melee_weapons[melee_entry].chainsaw == true then
		self._state_data.chainsaw_t = t + (tweak_data.blackmarket.melee_weapons[melee_entry].chainsaw_delay or 0.8)
	end
end)

-- fixes sprint stop animations while melee'ing @184-198
Hooks:OverrideFunction(PlayerStandard, "_end_action_running", function (self, t)
	if not self._end_running_expire_t then
		local speed_multiplier = self._equipped_unit:base():exit_run_speed_multiplier()
		self._end_running_expire_t = t + 0.4 / speed_multiplier
		local stop_running = not self._equipped_unit:base():run_and_shoot_allowed() and (not self.RUN_AND_RELOAD or not self:_is_reloading())

		if not managers.player:has_category_upgrade("player", "melee_sprint") then 
			if stop_running then
				self._ext_camera:play_redirect(self:get_animation("stop_running"), speed_multiplier)
			end
		elseif self:_is_meleeing() then
			if stop_running then
				--charging weapon: doing melee anims
				self._ext_camera:play_redirect(self:get_animation("melee_exit_state"), speed_multiplier)
			end
		else
			if stop_running then
				--not charging weapon: doing standard stuff
				self._ext_camera:play_redirect(self:get_animation("stop_running"), speed_multiplier)
			end
		end
	end
end)

-- fixes melee sprint jump animations @206-216
Hooks:OverrideFunction(PlayerStandard, "_start_action_jump", function (self, t, action_start_data)
	if self._running and self:_is_reloading() and not self.RUN_AND_RELOAD and not self._equipped_unit:base():run_and_shoot_allowed() then
		self:_interupt_action_reload(t)
		if not managers.player:has_category_upgrade("player", "melee_sprint") then 
			self._ext_camera:play_redirect(self:get_animation("stop_running"), self._equipped_unit:base():exit_run_speed_multiplier())
		else
			if self:_is_meleeing() then
				--charging melee: no anim reset
				self._ext_camera:play_redirect(self:get_animation("melee_exit_state"), speed_multiplier)
			else
				--standard stuff
				self._ext_camera:play_redirect(self:get_animation("stop_running"), self._equipped_unit:base():exit_run_speed_multiplier())
			end
		end
	end

	self:_interupt_action_running(t)

	self._jump_t = t
	local jump_vec = action_start_data.jump_vel_z * math.UP

	self._unit:mover():jump()

	if self._move_dir then
		local move_dir_clamp = self._move_dir:normalized() * math.min(1, self._move_dir:length())
		self._last_velocity_xy = move_dir_clamp * action_start_data.jump_vel_xy
		self._jump_vel_xy = mvector3.copy(self._last_velocity_xy)
	else
		self._last_velocity_xy = Vector3()
	end

	self:_perform_jump(jump_vec)
end)

-- chainsaw check
local old_cam = PlayerStandard._check_action_melee
Hooks:OverrideFunction(PlayerStandard, "_check_action_melee", function (self, t, input)
	local cam = old_cam(self, t, input)
	if input.btn_melee_release then
		self._state_data.chainsaw_t = nil
	end
	local melee_entry = managers.blackmarket:equipped_melee_weapon()
	if cam == true and tweak_data.blackmarket.melee_weapons[melee_entry].chainsaw == true and not self._state_data.chainsaw_t then -- don't override the other chainsaw timer on first swing
		self._state_data.chainsaw_t = t + (tweak_data.blackmarket.melee_weapons[melee_entry].repeat_chainsaw_delay or 0.2)
	end
end)

-- new function, mostly from irenfist, my beloved
function PlayerStandard:_do_chainsaw_damage(t)
	melee_entry = melee_entry or managers.blackmarket:equipped_melee_weapon()
	local charge_lerp_value = 0
	local sphere_cast_radius = 20
	local col_ray = nil

	if melee_hit_ray then
		col_ray = melee_hit_ray ~= true and melee_hit_ray or nil
	else
		col_ray = self:_calc_melee_hit_ray(t, sphere_cast_radius)
	end

	if col_ray and alive(col_ray.unit) then
		local damage, damage_effect = managers.blackmarket:equipped_melee_weapon_damage_info(charge_lerp_value)
		if tweak_data.blackmarket.melee_weapons[melee_entry].stats.tick_damage then
			damage = tweak_data.blackmarket.melee_weapons[melee_entry].stats.tick_damage
		end
		col_ray.sphere_cast_radius = sphere_cast_radius
		local hit_unit = col_ray.unit

		if hit_unit:character_damage() then

			local hit_sfx = "hit_body"
			if hit_unit:character_damage() and hit_unit:character_damage().melee_hit_sfx then
				hit_sfx = hit_unit:character_damage():melee_hit_sfx()
			end

			self:_play_melee_sound(melee_entry, hit_sfx, self._melee_attack_var)
			self:_play_melee_sound(melee_entry, "charge", self._melee_attack_var) -- continue playing charge sound after hit instead of silence

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

		elseif self._on_melee_restart_drill and hit_unit:base() and (hit_unit:base().is_drill or hit_unit:base().is_saw) then
			hit_unit:base():on_melee_hit(managers.network:session():local_peer():id())
		else
			self:_play_melee_sound(melee_entry, "hit_gen", self._melee_attack_var)
			self:_play_melee_sound(melee_entry, "charge", self._melee_attack_var) -- continue playing charge sound after hit instead of silence

			managers.game_play_central:play_impact_sound_and_effects({
				no_decal = true,
				no_sound = true,
				col_ray = col_ray,
				effect = Idstring("effects/payday2/particles/impacts/fallback_impact_pd2")
			})
		end

		local custom_data = nil

		if _G.IS_VR and hand_id then
			custom_data = {
				engine = hand_id == 1 and "right" or "left"
			}
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

			if target_dead and target_hostile and life_leach_available then
				managers.player:activate_temporary_upgrade("temporary", "melee_life_leech")
				self._unit:character_damage():restore_health(managers.player:temporary_upgrade_value("temporary", "melee_life_leech", 1))
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
			action_data.damage_effect = damage_effect
			action_data.attacker_unit = self._unit
			action_data.col_ray = col_ray

			if shield_knock then
				action_data.shield_knock = can_shield_knock
			end

			action_data.name_id = melee_entry
			action_data.charge_lerp_value = charge_lerp_value

			local defense_data = character_unit:character_damage():damage_melee(action_data)

			self:_check_melee_special_damage(col_ray, character_unit, defense_data, melee_entry)
			self:_perform_sync_melee_damage(hit_unit, col_ray, action_data.damage)

			return defense_data
		else
			self:_perform_sync_melee_damage(hit_unit, col_ray, damage)
		end
	end

	return col_ray
end

-- chainsaw check #2
local old_meleetimers = PlayerStandard._update_melee_timers
Hooks:OverrideFunction(PlayerStandard, "_update_melee_timers", function (self, t, input)
	-- CHAINSAW
	if tweak_data.blackmarket.melee_weapons[managers.blackmarket:equipped_melee_weapon()].chainsaw == true and self._state_data.chainsaw_t and self._state_data.chainsaw_t < t then
		self:_do_chainsaw_damage(t)
		self._state_data.chainsaw_t = t + 0.2
	end
	old_meleetimers(self, t, input)
end)

-- disable chainsaw when interrupted
local old_interrupt = PlayerStandard._interupt_action_melee
Hooks:OverrideFunction(PlayerStandard, "_interupt_action_melee", function (self, t)
	old_interrupt(self, t)
	self._state_data.chainsaw_t = nil

	local speed_multiplier = self:_get_swap_speed_multiplier()
	local tweak_data = self._equipped_unit:base():weapon_tweak_data()
	speed_multiplier = speed_multiplier * (tweak_data.equip_speed_mult or 1)

	self._ext_camera:play_redirect(self:get_animation("equip"), speed_multiplier)
	self._equipped_unit:base():tweak_data_anim_stop("unequip")
	self._equipped_unit:base():tweak_data_anim_play("equip", speed_multiplier)
end)

-- override based on weaponlib's override. adds new berserk damage increase @519-521
Hooks:OverrideFunction(PlayerStandard, "_check_action_primary_attack", function (self, t, input, params)
	if not self._equipped_unit then return false end

	local new_action = nil
	local action_wanted = input.btn_primary_attack_state or input.btn_primary_attack_release
	action_wanted = action_wanted or self:is_shooting_count()
	action_wanted = action_wanted or self:_is_charging_weapon()

	if action_wanted then
		local weap_base = self._equipped_unit:base()
		local weapon_tweak_data = weap_base:weapon_tweak_data()

		local action_forbidden =
			self:_is_reloading() or
			self:_changing_weapon() or
			self:_is_meleeing() or
			self._use_item_expire_t or
			self:_interacting() or
			self:_is_throwing_projectile() or
			self:_is_deploying_bipod() or
			self._menu_closed_fire_cooldown > 0 or
			self:is_switching_stances() or
			weapon_tweak_data.bipod_fire_only and not self:_is_using_bipod()

		if not action_forbidden then
			self._queue_reload_interupt = nil
			local start_shooting = false

			self._ext_inventory:equip_selected_primary(false)

			local fire_mode = weap_base:fire_mode()
			local animation_firemode = fire_mode == "auto" and "auto" or "single"
			if fire_mode ~= "auto" and weapon_tweak_data.fake_singlefire_anim then
				animation_firemode = "auto"
			elseif fire_mode == "auto" and weapon_tweak_data.fake_autofire_anim then
				animation_firemode = "single"
			end

			local fire_on_release = weap_base:fire_on_release()

			if weap_base:out_of_ammo() then
				if input.btn_primary_attack_press then
					weap_base:dryfire()
				end
			elseif weap_base.clip_empty and weap_base:clip_empty() then
				if self:_is_using_bipod() then
					if input.btn_primary_attack_press then
						weap_base:dryfire()
					end

					self._equipped_unit:base():tweak_data_anim_stop("fire")
				elseif fire_mode == "single" then
					if input.btn_primary_attack_press or self._equipped_unit:base().should_reload_immediately and self._equipped_unit:base():should_reload_immediately() then
						self:_start_action_reload_enter(t)
					end
				else
					new_action = true

					self:_start_action_reload_enter(t)
				end
			elseif self._running and not self._equipped_unit:base():run_and_shoot_allowed() then
				self:_interupt_action_running(t)
			else
				local firing_animation_state = nil

				if not self._shooting then
					if weap_base:start_shooting_allowed() then
						local start = fire_mode == "single" and input.btn_primary_attack_press
						start = start or fire_mode == "auto" and input.btn_primary_attack_state
						start = start or fire_mode == "burst" and input.btn_primary_attack_press
						start = start or fire_mode == "volley" and input.btn_primary_attack_press
						start = start and not fire_on_release
						start = start or fire_on_release and input.btn_primary_attack_release

						if start then
							weap_base:start_shooting()
							self._camera_unit:base():start_shooting()

							self._shooting = true
							self._shooting_t = t
							start_shooting = true

							if animation_firemode == "auto" then
								self._recoil_enter = true
								self._recoil_end_t = self._shooting_t + (weapon_tweak_data.timers and weapon_tweak_data.timers.fake_singlefire or 0.1)

								firing_animation_state = self._unit:camera():play_redirect(self:get_animation("recoil_enter"))
							end

							if fire_mode == "auto" then
								if (not weap_base.akimbo or weapon_tweak_data.allow_akimbo_autofire) and (not weap_base.third_person_important or weap_base.third_person_important and not weap_base:third_person_important()) then
									self._ext_network:send("sync_start_auto_fire_sound", 0)
								end
							end
						end
					else
						self:_check_stop_shooting()

						return false
					end
				end

				local suppression_ratio = self._unit:character_damage():effective_suppression_ratio()
				local spread_mul = math.lerp(1, tweak_data.player.suppression.spread_mul, suppression_ratio)
				local autohit_mul = math.lerp(1, tweak_data.player.suppression.autohit_chance_mul, suppression_ratio)
				local suppression_mul = managers.blackmarket:threat_multiplier()
				local dmg_mul = 1
				local primary_category = weapon_tweak_data.categories[1]

				if not weapon_tweak_data.ignore_damage_multipliers then
					dmg_mul = dmg_mul * managers.player:temporary_upgrade_value("temporary", "dmg_multiplier_outnumbered", 1)

					if managers.player:has_category_upgrade("player", "overkill_all_weapons") or weap_base:is_category("shotgun", "saw") then
						dmg_mul = dmg_mul * managers.player:temporary_upgrade_value("temporary", "overkill_damage_multiplier", 1)
					end
					
					if managers.player:has_category_upgrade("temporary", "new_berserk_weapon_damage_multiplier") then
						dmg_mul = dmg_mul * managers.player:temporary_upgrade_value("temporary", "new_berserk_weapon_damage_multiplier", 1)
					end

					local health_ratio = self._ext_damage:health_ratio()
					local damage_health_ratio = managers.player:get_damage_health_ratio(health_ratio, primary_category)

					if damage_health_ratio > 0 then
						local upgrade_name = weap_base:is_category("saw") and "melee_damage_health_ratio_multiplier" or "damage_health_ratio_multiplier"
						local damage_ratio = damage_health_ratio
						dmg_mul = dmg_mul * (1 + managers.player:upgrade_value("player", upgrade_name, 0) * damage_ratio)
					end

					dmg_mul = dmg_mul * managers.player:temporary_upgrade_value("temporary", "berserker_damage_multiplier", 1)
					dmg_mul = dmg_mul * managers.player:get_property("trigger_happy", 1)
				end

				local fired = nil

				if fire_mode == "single" then
					if input.btn_primary_attack_press and start_shooting then
						fired = weap_base:trigger_pressed(self:get_fire_weapon_position(), self:get_fire_weapon_direction(), dmg_mul, nil, spread_mul, autohit_mul, suppression_mul)
					elseif fire_on_release then
						if input.btn_primary_attack_release then
							fired = weap_base:trigger_released(self:get_fire_weapon_position(), self:get_fire_weapon_direction(), dmg_mul, nil, spread_mul, autohit_mul, suppression_mul)
						elseif input.btn_primary_attack_state then
							weap_base:trigger_held(self:get_fire_weapon_position(), self:get_fire_weapon_direction(), dmg_mul, nil, spread_mul, autohit_mul, suppression_mul)
						end
					end
				elseif fire_mode == "burst" then
					fired = weap_base:trigger_held(self:get_fire_weapon_position(), self:get_fire_weapon_direction(), dmg_mul, nil, spread_mul, autohit_mul, suppression_mul)
				elseif fire_mode == "volley" then
					if self._shooting then
						fired = weap_base:trigger_held(self:get_fire_weapon_position(), self:get_fire_weapon_direction(), dmg_mul, nil, spread_mul, autohit_mul, suppression_mul)
					end
				elseif input.btn_primary_attack_state then
					fired = weap_base:trigger_held(self:get_fire_weapon_position(), self:get_fire_weapon_direction(), dmg_mul, nil, spread_mul, autohit_mul, suppression_mul)
				end

				if weap_base.manages_steelsight and weap_base:manages_steelsight() then
					if weap_base:wants_steelsight() and not self._state_data.in_steelsight then
						self:_start_action_steelsight(t)
					elseif not weap_base:wants_steelsight() and self._state_data.in_steelsight then
						self:_end_action_steelsight(t)
					end
				end

				local charging_weapon = weap_base:charging()

				if not self._state_data.charging_weapon and charging_weapon then
					self:_start_action_charging_weapon(t)
				elseif self._state_data.charging_weapon and not charging_weapon then
					self:_end_action_charging_weapon(t)
				end

				new_action = true

				if fired then
					managers.rumble:play("weapon_fire")

					local clip_empty = weap_base:ammo_base():get_ammo_remaining_in_clip() <= (weap_base.AKIMBO and 1 or 0)
					self._camera_unit:anim_state_machine():set_global("is_empty", clip_empty and 1 or 0)

					local weap_tweak_data = weap_base:weapon_tweak_data()
					local shake_tweak_data = weap_tweak_data.shake[fire_mode] or weap_tweak_data.shake
					local shake_multiplier = shake_tweak_data[self._state_data.in_steelsight and "fire_steelsight_multiplier" or "fire_multiplier"]

					self._ext_camera:play_shaker("fire_weapon_rot", 1 * shake_multiplier)
					self._ext_camera:play_shaker("fire_weapon_kick", 1 * shake_multiplier, 1, 0.15)

					if animation_firemode == "single" and weap_base:get_name_id() ~= "saw" then
						local redirect = self:get_animation("recoil")
						if self._state_data.in_steelsight and weap_tweak_data.animations.recoil_steelsight and not weap_base:is_second_sight_on() then
							redirect = self:get_animation("recoil_steelsight")
						end

						firing_animation_state = self._ext_camera:play_redirect(redirect, weap_base:fire_rate_multiplier())
					end

					local recoil_multiplier = (weap_base:recoil() + weap_base:recoil_addend()) * weap_base:recoil_multiplier()

					local kick_tweak_data = weap_tweak_data.kick[fire_mode] or weap_tweak_data.kick
					local up, down, left, right = unpack(kick_tweak_data[self._state_data.in_steelsight and "steelsight" or self._state_data.ducking and "crouching" or "standing"])

					self._camera_unit:base():recoil_kick(up * recoil_multiplier, down * recoil_multiplier, left * recoil_multiplier, right * recoil_multiplier)

					if self._shooting_t then
						local time_shooting = t - self._shooting_t
						local achievement_data = tweak_data.achievement.never_let_you_go

						if achievement_data and weap_base:get_name_id() == achievement_data.weapon_id and achievement_data.timer <= time_shooting then
							managers.achievment:award(achievement_data.award)

							self._shooting_t = nil
						end
					end

					if managers.player:has_category_upgrade(primary_category, "stacking_hit_damage_multiplier") then
						self._state_data.stacking_dmg_mul = self._state_data.stacking_dmg_mul or {}
						self._state_data.stacking_dmg_mul[primary_category] = self._state_data.stacking_dmg_mul[primary_category] or {
							nil,
							0
						}
						local stack = self._state_data.stacking_dmg_mul[primary_category]

						if fired.hit_enemy then
							stack[1] = t + managers.player:upgrade_value(primary_category, "stacking_hit_expire_t", 1)
							stack[2] = math.min(stack[2] + 1, tweak_data.upgrades.max_weapon_dmg_mul_stacks or 5)
						else
							stack[1] = nil
							stack[2] = 0
						end
					end

					if weap_base.set_recharge_clbk then
						weap_base:set_recharge_clbk(callback(self, self, "weapon_recharge_clbk_listener"))
					end

					managers.hud:set_ammo_amount(weap_base:selection_index(), weap_base:ammo_info())

					local impact = not fired.hit_enemy

					if weap_base.third_person_important and weap_base:third_person_important() then
						self._ext_network:send("shot_blank_reliable", impact, 0)
					elseif fire_mode ~= "auto" or weap_base.akimbo and not weapon_tweak_data.allow_akimbo_autofire then
						self._ext_network:send("shot_blank", impact, 0)
					end

					if fire_mode == "volley" then
						self:_check_stop_shooting()
					end
				elseif fire_mode == "single" then
					new_action = false
				elseif fire_mode == "burst" then
					if weap_base:shooting_count() == 0 then
						new_action = false
					end
				elseif fire_mode == "volley" then
					new_action = self:_is_charging_weapon()
				end

				if firing_animation_state then
					self._camera_unit:anim_state_machine():set_parameter(firing_animation_state, "alt_weight", self._equipped_unit:base():alt_fire_active() and 1 or 0)
				end
			end
		elseif self:_is_reloading() and self._equipped_unit:base():reload_interuptable() and input.btn_primary_attack_press then
			self._queue_reload_interupt = true
		end
	end

	if not new_action then
		self:_check_stop_shooting()
	end

	return new_action
end)

-- new akimbo swap speed bonus @683-700
Hooks:OverrideFunction(PlayerStandard, "_get_swap_speed_multiplier", function (self)
	local multiplier = 1
	local weapon_tweak_data = self._equipped_unit:base():weapon_tweak_data()
	multiplier = multiplier * managers.player:upgrade_value("weapon", "swap_speed_multiplier", 1)
	multiplier = multiplier * managers.player:upgrade_value("weapon", "passive_swap_speed_multiplier", 1)

	local simplified_categories = {}
	for _, category in ipairs(weapon_tweak_data.categories) do
		multiplier = multiplier * managers.player:upgrade_value(category, "swap_speed_multiplier", 1)
		if category == "akimbo" then
			for __, category2 in ipairs(weapon_tweak_data.categories) do
				simplified_categories[category2] = true
			end
		end
	end
	
	if simplified_categories.akimbo and managers.player:has_category_upgrade("akimbo", "pistol_improved_handling") then
		if simplified_categories.pistol or (simplified_categories.smg and managers.player:has_category_upgrade("akimbo", "allow_smg_improved_handling")) then
			local skill = managers.player:upgrade_value("akimbo", "pistol_improved_handling")
			if skill and type(skill) ~= "number" then
				multiplier = multiplier * skill.swap_speed
			end	
		end
	end

	multiplier = multiplier * managers.player:upgrade_value("team", "crew_faster_swap", 1)

	if managers.player:has_activate_temporary_upgrade("temporary", "swap_weapon_faster") then
		multiplier = multiplier * managers.player:temporary_upgrade_value("temporary", "swap_weapon_faster", 1)
	end

	multiplier = managers.modifiers:modify_value("PlayerStandard:GetSwapSpeedMultiplier", multiplier)
	multiplier = multiplier * managers.player:upgrade_value("weapon", "mrwi_swap_speed_multiplier", 1)

	return multiplier
end)

-- adds bipod deploy speed multiplier if user has 'bipods that (actually) work'. for some reason playerbipod:_entry never triggers with this mod...
if Gilza.BTAW_enabled then
	local original_start_deploying_bipod = PlayerStandard.start_deploying_bipod
	Hooks:OverrideFunction(PlayerStandard, "start_deploying_bipod", function (self, bipod_deploy_duration, ...)
		local speed_multiplier = 1 * managers.player:upgrade_value("player", "bipod_deploy_speed", 1)
		bipod_deploy_duration = (bipod_deploy_duration or 1) / speed_multiplier
		return original_start_deploying_bipod(self,bipod_deploy_duration,...)
	end)
end

-- if we are boosting another player with basic inspire, we get it ourselves as well
Hooks:PreHook(PlayerStandard, "_get_intimidation_action", "Gilza_PlayerStandard_new_inspire", function(self, prime_target, char_table, amount, primary_only, detect_only, secondary)
	local mvec3_dis_sq = mvector3.distance_sq
	if prime_target and prime_target.unit_type == 2 then
		
		local is_human_player, record = nil

		if not detect_only then
			record = managers.groupai:state():all_criminals()[prime_target.unit:key()]
			if not record.ai then
				is_human_player = true
			end
		end
		
		local current_state_name = self._unit:movement():current_state_name()

		if not secondary and current_state_name ~= "arrested" and current_state_name ~= "bleed_out" and current_state_name ~= "fatal" and current_state_name ~= "incapacitated" then
			local rally_skill_data = self._ext_movement:rally_skill_data()

			if rally_skill_data and mvec3_dis_sq(self._pos, record.m_pos) < rally_skill_data.range_sq then
				local needs_revive, is_arrested = nil

				if prime_target.unit:base().is_husk_player then
					is_arrested = prime_target.unit:movement():current_state_name() == "arrested"
					needs_revive = prime_target.unit:interaction():active() and prime_target.unit:movement():need_revive() and not is_arrested
				else
					is_arrested = prime_target.unit:character_damage():arrested()
					needs_revive = prime_target.unit:character_damage():need_revive()
				end

				if is_human_player and not is_arrested and not needs_revive and rally_skill_data.morale_boost_delay_t and rally_skill_data.morale_boost_delay_t < managers.player:player_timer():time() then
					self._unit:movement():on_morale_boost(aggressor_unit, true)
				end
			end
		end
	end
end)