-- new berserk
Hooks:PreHook(PlayerDamage, "_calc_armor_damage", "new_berserk_trigger", function(self, attack_data)
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
					local Gilza_new_berserk = hud.panel:bitmap({
						name = "Gilza_new_berserk",
						visible = false,
						texture = "guis/textures/berserk_flash",
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
								activate_berserk_type_1(15)
							elseif flash_type == 2 then
								activate_berserk_type_2(15)
							elseif flash_type == 3 then
								activate_berserk_type_3(15)
							elseif flash_type == 4 then
								activate_berserk_type_4(15)
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
							wpn_dur = 15
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

-- Slow and steady skill damage multipliers
Hooks:PreHook(PlayerDamage, "damage_bullet", "SaS_skillresist", function(self, attack_data)
	if managers.network:session():local_peer():unit():movement()._current_state._moving == false then
		attack_data.damage = attack_data.damage * managers.player:upgrade_value("player", "not_moving_damage_reduction_bonus", 1)
	end
	if managers.player:current_state() == "bipod" then
		attack_data.damage = attack_data.damage * managers.player:upgrade_value("player", "not_moving_damage_reduction_bonus", 1) -- apply basic skill version reduction if bipoded
		attack_data.damage = attack_data.damage * managers.player:upgrade_value("player", "not_moving_damage_reduction_bonus_bipoded", 1)
	end
	if managers.player:has_category_upgrade("player", "damage_resist_brawler") then
		attack_data.damage = attack_data.damage * managers.player:upgrade_value("player", "damage_resist_brawler", 1)
	end
	if managers.player:has_category_upgrade("player", "damage_resist_faraway_brawler") then
		if ( self:_max_health() / self:get_real_health() ) >= 2 then
			if managers.player:player_unit():position() and attack_data.attacker_unit:position() then
				local ray = World:raycast( "ray", managers.player:player_unit():position(), attack_data.attacker_unit:position(), "slot_mask", managers.slot:get_mask( "bullet_impact_targets" ) )
				if ray and ray.distance >= 900 and ray.distance < 1600 then
					attack_data.damage = attack_data.damage * 0.61
				elseif ray and ray.distance >= 1600 then
					attack_data.damage = attack_data.damage * 0.26
				end
			end
		end
	end
end)

local Gilz_arrested = "CBT"
-- check for arrest when beeing revived
Hooks:PreHook(PlayerDamage, "revive", "Gilza_UYGBuffpt1", function(self)
	Gilz_arrested = self:arrested()
end)
-- if not arrested and we have Up you go, get more health + sync
Hooks:PostHook(PlayerDamage, "revive", "Gilza_UYGBuffpt2", function(self)
	if not Gilz_arrested and managers.player:has_category_upgrade("player", "health_regain_V2") then
		self:set_health(self:get_real_health() + (self:_max_health() * managers.player:upgrade_value("player", "health_regain_V2", 0)))
		managers.hud:set_player_health({
			current = self:get_real_health(),
			total = self:_max_health(),
			revives = Application:digest_value(self._revives, false)
		})
		self:_send_set_health()
	end
end)