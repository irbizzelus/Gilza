-- allow faster melee charge aa
local old_meleecharge = PlayerStandard._get_melee_charge_lerp_value
function PlayerStandard:_get_melee_charge_lerp_value(...)
	local value = old_meleecharge(self, ...)
	return math.clamp(value * managers.player:upgrade_value("player", "melee_faster_charge", 1), 0, 1)
end


-- sprint while meleeing
function PlayerStandard:_start_action_running(t)
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
end

-- fixes sprint beeing reset when starting melee charge with sprint skill
function PlayerStandard:_start_action_melee(t, input, instant)
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
end

local old_cam = PlayerStandard._check_action_melee
function PlayerStandard:_check_action_melee(t, input)
	local cam = old_cam(self, t, input)
	if input.btn_melee_release then
		self._state_data.chainsaw_t = nil
	end
	local melee_entry = managers.blackmarket:equipped_melee_weapon()
	if cam == true and tweak_data.blackmarket.melee_weapons[melee_entry].chainsaw == true and not self._state_data.chainsaw_t then -- don't override the other chainsaw timer on first swing
		self._state_data.chainsaw_t = t + (tweak_data.blackmarket.melee_weapons[melee_entry].repeat_chainsaw_delay or 0.2)
	end
end

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

local old_meleetimers = PlayerStandard._update_melee_timers
function PlayerStandard:_update_melee_timers(t, input)
	-- CHAINSAW
	if tweak_data.blackmarket.melee_weapons[managers.blackmarket:equipped_melee_weapon()].chainsaw == true and self._state_data.chainsaw_t and self._state_data.chainsaw_t < t then
		self:_do_chainsaw_damage(t)
		self._state_data.chainsaw_t = t + 0.2
	end
	old_meleetimers(self, t, input)
end

-- disable chainsaw when interrupting
local old_interrupt = PlayerStandard._interupt_action_melee
function PlayerStandard:_interupt_action_melee(t)
	old_interrupt(self, t)
	self._state_data.chainsaw_t = nil

	local speed_multiplier = self:_get_swap_speed_multiplier()
	local tweak_data = self._equipped_unit:base():weapon_tweak_data()
	speed_multiplier = speed_multiplier * (tweak_data.equip_speed_mult or 1)

	self._ext_camera:play_redirect(self:get_animation("equip"), speed_multiplier)
	self._equipped_unit:base():tweak_data_anim_stop("unequip")
	self._equipped_unit:base():tweak_data_anim_play("equip", speed_multiplier)
end

-- fixes sprint stop animations while melee'ing
function PlayerStandard:_end_action_running(t)
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
end

-- fixes melee sprint jump animations
function PlayerStandard:_start_action_jump(t, action_start_data)
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
end

-- adjusts ammo pick up for grenades to use new amounts, otherwise other players can get marked as cheaters
function PlayerStandard:_find_pickups(t)
	local pickups = World:find_units_quick("sphere", self._unit:movement():m_pos(), self._pickup_area, self._slotmask_pickups)
	local grenade_tweak = tweak_data.blackmarket.projectiles[managers.blackmarket:equipped_grenade()]
	local may_find_grenade = not grenade_tweak.base_cooldown and managers.player:has_category_upgrade("player", "regain_throwable_from_ammo")

	for _, pickup in ipairs(pickups) do
		if pickup:pickup() and pickup:pickup():pickup(self._unit) then
			if may_find_grenade then
				local data = managers.player:upgrade_value("player", "regain_throwable_from_ammo", nil)
				
				local nades = {
					frag_com = 2,
					dada_com = 2,
					frag = 2,
					dynamite = 2,
					fir_com = 3,
					molotov = 2,
					wpn_gre_electric = 3,
					wpn_prj_four = 6,
					wpn_prj_ace = 10,
					wpn_prj_hur = 3,
					wpn_prj_jav = 2,
					wpn_prj_target = 5,
					concussion = 4,
					sticky_grenade = 3,
					poison_gas_grenade = 2
				}
				function Gilza_nadepickuptweaks()
					if not grenade_tweak.base_cooldown then
						tweak_data.blackmarket.projectiles[managers.blackmarket:equipped_grenade()].max_amount = nades[managers.blackmarket:equipped_grenade()]
					end
				end
				Gilza_nadepickuptweaks()
				if data then
					managers.player:add_coroutine("regain_throwable_from_ammo", PlayerAction.FullyLoaded, managers.player, data.chance, data.chance_inc)
				end
			end

			for id, weapon in pairs(self._unit:inventory():available_selections()) do
				managers.hud:set_ammo_amount(id, weapon.unit:base():ammo_info())
			end
		end
	end
end

-- new berserk dmg increase @line 359
function PlayerStandard:_check_action_primary_attack(t, input, params)
	local new_action, action_wanted = nil
	action_wanted = (not params or params.action_wanted == nil or params.action_wanted) and (input.btn_primary_attack_state or input.btn_primary_attack_release or self:is_shooting_count() or self:_is_charging_weapon())

	if action_wanted then
		local action_forbidden = nil

		if params and params.action_forbidden ~= nil then
			action_forbidden = params.action_forbidden
		elseif self:_is_reloading() or self:_changing_weapon() or self:_is_meleeing() or self._use_item_expire_t or self:_interacting() or self:_is_throwing_projectile() or self:_is_deploying_bipod() or self._menu_closed_fire_cooldown > 0 or self:is_switching_stances() then
			action_forbidden = true
		else
			action_forbidden = false
		end

		if not action_forbidden then
			self._queue_reload_interupt = nil
			local start_shooting = false

			self._ext_inventory:equip_selected_primary(false)

			local weap_unit = self._equipped_unit

			if weap_unit then
				local weap_base = weap_unit:base()
				local fire_mode = weap_base:fire_mode()
				local fire_on_release = weap_base:fire_on_release()

				if weap_base:out_of_ammo() then
					if input.btn_primary_attack_press then
						weap_base:dryfire()
					end
				elseif weap_base.clip_empty and weap_base:clip_empty() then
					if params and params.no_reload or self:_is_using_bipod() then
						if input.btn_primary_attack_press then
							weap_base:dryfire()
						end

						weap_base:tweak_data_anim_stop("fire")
					else
						local fire_mode_func = self._primary_action_funcs.clip_empty[fire_mode]

						if not fire_mode_func or not fire_mode_func(self, t, input, params, weap_unit, weap_base) then
							fire_mode_func = self._primary_action_funcs.clip_empty.default

							if fire_mode_func then
								fire_mode_func(self, t, input, params, weap_unit, weap_base)
							end
						end

						new_action = self:_is_reloading()
					end
				elseif params and params.block_fire then
					-- Nothing
				elseif self._running and (params and params.no_running or weap_base.run_and_shoot_allowed and not weap_base:run_and_shoot_allowed()) then
					self:_interupt_action_running(t)
				else
					if not self._shooting then
						if weap_base:start_shooting_allowed() then
							local start = nil
							local start_fire_func = self._primary_action_get_value.chk_start_fire[fire_mode]

							if start_fire_func then
								start = start_fire_func(self, t, input, params, weap_unit, weap_base)
							else
								start_fire_func = self._primary_action_get_value.chk_start_fire.default

								if start_fire_func then
									start = start_fire_func(self, t, input, params, weap_unit, weap_base)
								end
							end

							if not params or not params.no_start_fire_on_release then
								start = start and not fire_on_release
								start = start or fire_on_release and input.btn_primary_attack_release
							end

							if start then
								weap_base:start_shooting()
								self._camera_unit:base():start_shooting()

								self._shooting = true
								self._shooting_t = t
								start_shooting = true
								local fire_mode_func = self._primary_action_funcs.start_fire[fire_mode]

								if not fire_mode_func or not fire_mode_func(self, t, input, params, weap_unit, weap_base) then
									fire_mode_func = self._primary_action_funcs.start_fire.default

									if fire_mode_func then
										fire_mode_func(self, t, input, params, weap_unit, weap_base)
									end
								end
							end
						elseif not params or not params.no_check_stop_shooting_early then
							self:_check_stop_shooting()

							return false
						end
					end

					local suppression_ratio = self._unit:character_damage():effective_suppression_ratio()
					local spread_mul = math.lerp(1, tweak_data.player.suppression.spread_mul, suppression_ratio)
					local autohit_mul = math.lerp(1, tweak_data.player.suppression.autohit_chance_mul, suppression_ratio)
					local suppression_mul = managers.blackmarket:threat_multiplier()
					local dmg_mul = 1
					local weapon_tweak_data = weap_base:weapon_tweak_data()
					local primary_category = weapon_tweak_data.categories[1]

					if not weapon_tweak_data.ignore_damage_multipliers then
						dmg_mul = dmg_mul * managers.player:temporary_upgrade_value("temporary", "dmg_multiplier_outnumbered", 1)

						if self._overkill_all_weapons or weap_base:is_category("shotgun", "saw") then
							dmg_mul = dmg_mul * managers.player:temporary_upgrade_value("temporary", "overkill_damage_multiplier", 1)
						end
						
						if managers.player:has_category_upgrade("temporary", "new_berserk_weapon_damage_multiplier") then
							dmg_mul = dmg_mul * managers.player:temporary_upgrade_value("temporary", "new_berserk_weapon_damage_multiplier", 1)
						end
						
						if managers.player:has_category_upgrade("temporary", "new_berserk_weapon_damage_multiplier") then
							dmg_mul = dmg_mul * managers.player:temporary_upgrade_value("temporary", "new_berserk_weapon_damage_multiplier", 1)
						end

						local health_ratio = self._ext_damage:health_ratio()
						local damage_health_ratio = managers.player:get_damage_health_ratio(health_ratio, primary_category)

						if damage_health_ratio > 0 then
							local upgrade = weap_base:is_category("saw") and self._damage_health_ratio_mul_melee or self._damage_health_ratio_mul
							dmg_mul = dmg_mul * (1 + upgrade * damage_health_ratio)
						end

						dmg_mul = dmg_mul * managers.player:temporary_upgrade_value("temporary", "berserker_damage_multiplier", 1)
						dmg_mul = dmg_mul * managers.player:get_property("trigger_happy", 1)
					end

					local fired = nil
					local fired_func = self._primary_action_get_value.fired[fire_mode]

					if fired_func then
						fired = fired_func(self, t, input, params, weap_unit, weap_base, start_shooting, fire_on_release, dmg_mul, nil, spread_mul, autohit_mul, suppression_mul)
					else
						fired_func = self._primary_action_get_value.fired.default

						if fired_func then
							fired = fired_func(self, t, input, params, weap_unit, weap_base, start_shooting, fire_on_release, dmg_mul, nil, spread_mul, autohit_mul, suppression_mul)
						end
					end

					if (not params or not params.no_steelsight) and weap_base.manages_steelsight and weap_base:manages_steelsight() then
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
						if not params or not params.no_rumble then
							managers.rumble:play("weapon_fire")
						end

						local weap_tweak_data = weap_base.weapon_tweak_data and weap_base:weapon_tweak_data() or tweak_data.weapon[weap_base:get_name_id()]

						if not params or not params.no_shake then
							local shake_tweak_data = weap_tweak_data.shake[fire_mode] or weap_tweak_data.shake
							local shake_multiplier = shake_tweak_data[self._state_data.in_steelsight and "fire_steelsight_multiplier" or "fire_multiplier"]

							self._ext_camera:play_shaker("fire_weapon_rot", 1 * shake_multiplier)
							self._ext_camera:play_shaker("fire_weapon_kick", 1 * shake_multiplier, 1, 0.15)
						end

						weap_base:tweak_data_anim_stop("unequip")
						weap_base:tweak_data_anim_stop("equip")

						if (not params or not params.no_steelsight) and (not self._state_data.in_steelsight or not weap_base:tweak_data_anim_play("fire_steelsight", weap_base:fire_rate_multiplier())) then
							weap_base:tweak_data_anim_play("fire", weap_base:fire_rate_multiplier())
						end

						if (not params or not params.no_recoil_anim_redirect) and not weap_tweak_data.no_recoil_anim_redirect then
							local fire_mode_func = self._primary_action_funcs.recoil_anim_redirect[fire_mode]

							if not fire_mode_func or not fire_mode_func(self, t, input, params, weap_unit, weap_base) then
								fire_mode_func = self._primary_action_funcs.recoil_anim_redirect.default

								if fire_mode_func then
									fire_mode_func(self, t, input, params, weap_unit, weap_base)
								end
							end
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

						if (not params or not params.no_recharge_clbk) and weap_base.set_recharge_clbk then
							weap_base:set_recharge_clbk(callback(self, self, "weapon_recharge_clbk_listener"))
						end

						managers.hud:set_ammo_amount(weap_base:selection_index(), weap_base:ammo_info())

						if self._ext_network then
							local impact = not fired.hit_enemy
							local sync_blank_func = self._primary_action_funcs.sync_blank[fire_mode]

							if not sync_blank_func or not sync_blank_func(self, t, input, params, weap_unit, weap_base, impact) then
								sync_blank_func = self._primary_action_funcs.sync_blank.default

								if sync_blank_func then
									sync_blank_func(self, t, input, params, weap_unit, weap_base, impact)
								end
							end
						end

						local stop_volley_func = self._primary_action_get_value.check_stop_shooting_volley[fire_mode]

						if stop_volley_func then
							new_action = stop_volley_func(self, t, input, params, weap_unit, weap_base)
						else
							stop_volley_func = self._primary_action_get_value.check_stop_shooting_volley.default

							if stop_volley_func then
								new_action = stop_volley_func(self, t, input, params, weap_unit, weap_base)
							end
						end
					else
						local not_fired_func = self._primary_action_get_value.not_fired[fire_mode]

						if not_fired_func then
							new_action = not_fired_func(self, t, input, params, weap_unit, weap_base)
						else
							not_fired_func = self._primary_action_get_value.not_fired.default

							if not_fired_func then
								new_action = not_fired_func(self, t, input, params, weap_unit, weap_base)
							end
						end
					end
				end
			end
		elseif self:_is_reloading() and self._equipped_unit and self._equipped_unit:base():reload_interuptable() and input.btn_primary_attack_press then
			self._queue_reload_interupt = true
		end
	end

	self:_chk_action_stop_shooting(new_action)

	return new_action
end