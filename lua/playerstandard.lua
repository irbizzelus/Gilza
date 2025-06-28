if not Gilza then
	dofile("mods/Gilza/lua/1_GilzaBase.lua")
end

-- new faster melee charge skill
local gilza_orig_get_melee_charge_lerp_value = PlayerStandard._get_melee_charge_lerp_value
Hooks:OverrideFunction(PlayerStandard, "_get_melee_charge_lerp_value", function (self, t, offset)
	local res = gilza_orig_get_melee_charge_lerp_value(self, t, offset)
	return math.clamp(res / managers.player:upgrade_value("player", "melee_faster_charge", 1), 0, 1)
end)

-- if sprint button is pressed while melee'ing, allow for sprint if skill is equipped.
local gilza_orig_start_action_running = PlayerStandard._start_action_running
Hooks:OverrideFunction(PlayerStandard, "_start_action_running", function (self, t)
	gilza_orig_start_action_running(self, t)
	if managers.player:has_category_upgrade("player", "melee_sprint") then
		if self:_is_meleeing() then
			if self._running then
				self._running_wanted = false -- on another button press stop sprinting
			end
			self:set_running(true)
			self._end_running_expire_t = nil
			self._start_running_t = t
			self._play_stop_running_anim = nil
			self:_interupt_action_ducking(t)
		end
	end
end)

-- fix sprinting animation with new melee sprint skill. these checks are a fucking mess, but this is the only way i can fucking read them
Hooks:PostHook(PlayerStandard, "update", "Gilza_posthook_PlayerStandard_update", function(self, t, dt)
	if managers.player:has_category_upgrade("player", "melee_sprint") then
		if self._running then
			if not self:_is_meleeing() and not self._in_melee_skill_sprint_animation then
				if not self._equipped_unit:base():run_and_shoot_allowed() and not self._end_running_expire_t then
					self._ext_camera:play_redirect(self:get_animation("start_running"))
				end
				self._in_melee_skill_sprint_animation = true
			end
		else
			self._in_melee_skill_sprint_animation = false
		end
	end
	
	-- infohud ui
	local pl_unit = self._unit
	if pl_unit and alive(pl_unit) and pl_unit:movement() then
		-- dodge
		local dodge_value = tweak_data.player.damage.DODGE_INIT or 0
		local armor_dodge_chance = managers.player:body_armor_value("dodge")
		local skill_dodge_chance = managers.player:skill_dodge_chance(pl_unit:movement():running(), pl_unit:movement():crouching(), pl_unit:movement():zipline_unit())
		dodge_value = dodge_value + armor_dodge_chance + skill_dodge_chance
		local pl_dmg = pl_unit:character_damage()
		if pl_dmg._temporary_dodge_t and TimerManager:game():time() < pl_dmg._temporary_dodge_t then
			dodge_value = dodge_value + pl_dmg._temporary_dodge
		end
		local smoke_dodge = 0
		for _, smoke_screen in ipairs(managers.player._smoke_screen_effects or {}) do
			if smoke_screen:is_in_smoke(pl_unit) then
				smoke_dodge = tweak_data.projectiles.smoke_screen_grenade.dodge_chance
				break
			end
		end
		dodge_value = 1 - (1 - dodge_value) * (1 - smoke_dodge)
		Gilza.NSI:dodge_value_tracker(dodge_value)
		
		-- dmg resist
		Gilza.NSI:update_current_passive_dmg_resist(managers.player:damage_reduction_skill_multiplier())
		
		-- dmg absorb
		Gilza.NSI:update_current_dmg_absorb(managers.player:damage_absorption())
	else
		log("[Gilza] playerstandard:update cant report on current dodge/dmg resist/etc for infohuds")
	end
end)

-- prevent sprint interupt when starting a melee charge with sprint skill. also adds chainsaw stuff
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
	self._in_melee_skill_sprint_animation = false -- needed for sprint animation handling
end)

-- fixes sprint stop animations while melee'ing
local gilza_orig_end_action_running = PlayerStandard._end_action_running
Hooks:OverrideFunction(PlayerStandard, "_end_action_running", function (self, t)
	if managers.player:has_category_upgrade("player", "melee_sprint") and self:_is_meleeing() then
		if not self._end_running_expire_t then
			local speed_multiplier = self._equipped_unit:base():exit_run_speed_multiplier()
			self._end_running_expire_t = t + 0.4 / speed_multiplier
			local stop_running = not self._equipped_unit:base():run_and_shoot_allowed() and (not self.RUN_AND_RELOAD or not self:_is_reloading())

			if stop_running then
				--charging weapon: doing melee anims
				self._ext_camera:play_redirect(self:get_animation("melee_exit_state"), speed_multiplier)
			end
		end
	else
		gilza_orig_end_action_running(self, t)
	end
end)

-- fixes melee sprint jump animations. i think
local gilza_orig_start_action_jump = PlayerStandard._start_action_jump
Hooks:OverrideFunction(PlayerStandard, "_start_action_jump", function (self, t, action_start_data)
	if managers.player:has_category_upgrade("player", "melee_sprint") and self:_is_meleeing() then
		self._ext_camera:play_redirect(self:get_animation("melee_exit_state"), speed_multiplier)
		gilza_orig_start_action_jump(self, t, action_start_data)
	else
		gilza_orig_start_action_jump(self, t, action_start_data)
	end
end)

-- chainsaw check
local gilza_orig_check_action_melee = PlayerStandard._check_action_melee
Hooks:OverrideFunction(PlayerStandard, "_check_action_melee", function (self, t, input)
	local cam = gilza_orig_check_action_melee(self, t, input)
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
			
			-- bloodthirst base
			dmg_multiplier = dmg_multiplier * managers.player:get_melee_dmg_multiplier()
			
			-- sociopath/infil damage
			if managers.player:has_category_upgrade("melee", "stacking_hit_damage_multiplier") then
				self._state_data.stacking_dmg_mul = self._state_data.stacking_dmg_mul or {}
				self._state_data.stacking_dmg_mul.melee = self._state_data.stacking_dmg_mul.melee or {
					nil,
					0
				}
				local stack = self._state_data.stacking_dmg_mul.melee

				if stack[1] and t < stack[1] then
					dmg_multiplier = dmg_multiplier * (1 + managers.player:upgrade_value("melee", "stacking_hit_damage_multiplier", 0) * stack[2])
				else
					stack[2] = 0
				end
			end
			
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
			
			-- sociopath/infil timer
			if managers.player:has_category_upgrade("melee", "stacking_hit_damage_multiplier") then
				self._state_data.stacking_dmg_mul = self._state_data.stacking_dmg_mul or {}
				self._state_data.stacking_dmg_mul.melee = self._state_data.stacking_dmg_mul.melee or {
					nil,
					0
				}
				local stack = self._state_data.stacking_dmg_mul.melee

				if character_unit:character_damage().dead and not character_unit:character_damage():dead() then
					stack[1] = t + managers.player:upgrade_value("melee", "stacking_hit_expire_t", 1)
					stack[2] = math.min(stack[2] + 1, tweak_data.upgrades.max_melee_weapon_dmg_mul_stacks or 5)
				else
					stack[1] = nil
					stack[2] = 0
				end
			end

			return defense_data
		else
			self:_perform_sync_melee_damage(hit_unit, col_ray, damage)
		end
	end

	return col_ray
end

-- chainsaw check #2
local gilza_orig_update_melee_timers = PlayerStandard._update_melee_timers
Hooks:OverrideFunction(PlayerStandard, "_update_melee_timers", function (self, t, input)
	-- CHAINSAW
	if tweak_data.blackmarket.melee_weapons[managers.blackmarket:equipped_melee_weapon()].chainsaw == true and self._state_data.chainsaw_t and self._state_data.chainsaw_t < t then
		self:_do_chainsaw_damage(t)
		self._state_data.chainsaw_t = t + 0.2
	end
	gilza_orig_update_melee_timers(self, t, input)
end)

-- disable chainsaw when interrupted
local gilza_orig_interupt_action_melee = PlayerStandard._interupt_action_melee
Hooks:OverrideFunction(PlayerStandard, "_interupt_action_melee", function (self, t)
	gilza_orig_interupt_action_melee(self, t)
	self._state_data.chainsaw_t = nil

	local speed_multiplier = self:_get_swap_speed_multiplier()
	local tweak_data = self._equipped_unit:base():weapon_tweak_data()
	speed_multiplier = speed_multiplier * (tweak_data.equip_speed_mult or 1)

	self._ext_camera:play_redirect(self:get_animation("equip"), speed_multiplier)
	self._equipped_unit:base():tweak_data_anim_stop("unequip")
	self._equipped_unit:base():tweak_data_anim_play("equip", speed_multiplier)
end)

-- new akimbo swap speed bonus
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

	if managers.player:has_category_upgrade("player", "speed_junkie_meter_boost_agility") then
		local counter = managers.player._Gilza_junkie_counter or 0
		local skill = managers.player:upgrade_value("player", "speed_junkie_meter_boost_agility")
		if skill and type(skill) ~= "number" then
			local mul = (skill.swap_speed - 1) * (counter / 100) + 1
			multiplier = multiplier * mul
		end	
	end

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
Hooks:PreHook(PlayerStandard, "_get_intimidation_action", "Gilza_PlayerStandard_get_intimidation_action", function(self, prime_target, char_table, amount, primary_only, detect_only, secondary)
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

-- new jump skill from basic parkour
Hooks:PreHook(PlayerStandard, "_start_action_jump", "Gilza_PlayerStandard_start_action_jump", function(self, t, action_start_data)
	if action_start_data and managers.player:has_category_upgrade("player", "extra_jump_height") then
		if action_start_data.jump_vel_z then
			action_start_data.jump_vel_z = action_start_data.jump_vel_z * managers.player:upgrade_value("player", "extra_jump_height", 1)
		end
		if action_start_data.jump_vel_xy then
			action_start_data.jump_vel_xy = action_start_data.jump_vel_xy * managers.player:upgrade_value("player", "extra_jump_height", 1)
		end
	end
end)

local hide_int_state = {
	["bleed_out"] = true,
	["fatal"] = true,
	["incapacitated"] = true,
	["arrested"] = true,
	["jerry1"] = true
}
-- melee gui 1
Hooks:PostHook(PlayerStandard, "_start_action_melee", "Gilza_PlayerStandard_start_action_melee_GUI", function(self, t, input, instant)
	if not instant then
		if true and self._state_data.meleeing and not hide_int_state[managers.player:current_state()] then
			self._state_data._Gilza_showing_melee = true
			self._state_data._Gilza_melee_charge_duration = tweak_data.blackmarket.melee_weapons[managers.blackmarket:equipped_melee_weapon()].stats.charge_time or 1
			managers.hud:show_interaction_bar(0, self._state_data._Gilza_melee_charge_duration)
		end
	end
end)

-- melee gui 2
Hooks:PostHook(PlayerStandard, "enter", "Gilza_PlayerStandard_enter_GUI", function(self, ...)
	if hide_int_state[managers.player:current_state()] and self._state_data._Gilza_showing_melee then
		managers.hud:hide_interaction_bar(false)
		self._state_data._Gilza_showing_melee = false
	end
end)

-- melee gui 3
Hooks:PostHook(PlayerStandard, "_update_melee_timers", "Gilza_PlayerStandard_update_melee_timers_GUI", function(self, t, input)
	if self._state_data.meleeing and self._state_data._Gilza_showing_melee then
		local melee_lerp = self:_get_melee_charge_lerp_value(t)
		if hide_int_state[managers.player:current_state()] then
			managers.hud:hide_interaction_bar()
			self._state_data._Gilza_showing_melee = false
		elseif self._state_data._Gilza_showing_melee or self._state_data.chainsaw_t then
			managers.hud:set_interaction_bar_width(self._state_data._Gilza_melee_charge_duration * melee_lerp, self._state_data._Gilza_melee_charge_duration)
		end
	end
end)

-- melee gui 4
Hooks:PostHook(PlayerStandard, "_do_melee_damage", "Gilza_PlayerStandard_do_melee_damage_GUI", function(self, ...)
	if self._state_data._Gilza_showing_melee then
		managers.hud:hide_interaction_bar()
		self._state_data._Gilza_showing_melee = false
	end
end)

-- melee gui 5
Hooks:PostHook(PlayerStandard, "_interupt_action_melee", "Gilza_PlayerStandard_interupt_action_melee_GUI", function(self, t)
	if self._state_data._Gilza_showing_melee then
		managers.hud:hide_interaction_bar()
		self._state_data._Gilza_showing_melee = false
	end
end)