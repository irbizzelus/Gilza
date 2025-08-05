-- this file is handling all new skills that gilza adds (or at least most of them), that are not just vanilla skill value overrides
-- functions bellow are called by related skills every time they are activated or such
-- every skill may be activated differently, and if so it is specified

-- use this file's functions to add Gilza's new skills to any infoHUD you use/develop
-- by default only vanillaHUD+ is supported

-- you can use semi overrides of these functions or posthooks to track when skills are activated
-- in order to properly work, your HUD/info mod needs to have lower priority than gilza's (current Gilza priority: 19)
-- use Hooks:GetFunction(Gilza.New_Skills_Informer,"activated_new_zerk_melee") to grab the function itself for either a semi override or a hook

Gilza.New_Skills_Informer = {}
-- for ease of use, u can run Gilza.NSI
Gilza.NSI = Gilza.New_Skills_Informer

-- add new skills for VHUD+. fold this part to go bellow it, where relevant functions are.
if Gilza.VHP_enabled then
	local function add_vhud_vars()
		local buffs_loaded = false
		local map_loaded = false
		-- add our skills to vanila hud's buff list so that it stops screaming about unknown effects in the logs
		if GameInfoManager and GameInfoManager._BUFFS and GameInfoManager._BUFFS.temporary then
			GameInfoManager._BUFFS.temporary.player_new_hitman_regen = "player_new_hitman_regen" -- deprecated
			GameInfoManager._BUFFS.temporary.player_dodge_armor_regen = "player_dodge_armor_regen"
			GameInfoManager._BUFFS.temporary.player_speed_junkie_armor_on_dodge = "player_speed_junkie_armor_on_dodge"
			GameInfoManager._BUFFS.temporary.speed_boost_on_panic_kill = "speed_boost_on_panic_kill"
			GameInfoManager._BUFFS.temporary.tased_electric_bullets = "tased_electric_bullets"
			GameInfoManager._BUFFS.temporary.new_berserk_melee_damage_multiplier_1 = "new_berserk_melee_damage_multiplier_1"
			GameInfoManager._BUFFS.temporary.new_berserk_melee_damage_multiplier_2 = "new_berserk_melee_damage_multiplier_2"
			GameInfoManager._BUFFS.temporary.new_berserk_weapon_damage_multiplier = "new_berserk_weapon_damage_multiplier"
			GameInfoManager._BUFFS.temporary.new_berserk_weapon_damage_multiplier_cooldown = "new_berserk_weapon_damage_multiplier_cooldown"
			GameInfoManager._BUFFS.temporary.badass_hitman_kill_armor_regen = "badass_hitman_kill_armor_regen"
			GameInfoManager._BUFFS.temporary.akimbo_pistol_armor_regen_timer_multiplier = "akimbo_pistol_armor_regen_timer_multiplier"
			GameInfoManager._BUFFS.temporary.death_dance_combo_invulnerability = "death_dance_combo_invulnerability"
			GameInfoManager._BUFFS.temporary.player_bounty_hunter = "player_bounty_hunter"
			GameInfoManager._BUFFS.temporary.player_wild_temporary_regen_pause = "player_wild_temporary_regen_pause"
			GameInfoManager._BUFFS.temporary.copr_invuln_on_segment_loss = "copr_invuln_on_segment_loss"
			GameInfoManager._BUFFS.temporary.single_body_shot_kill_reload = "single_body_shot_kill_reload"
			
			GameInfoManager._BUFFS.on_activate.new_berserk_weapon_damage_multiplier = function(id, data)
				local upgrade_value = managers.player:upgrade_value("temporary", "new_berserk_weapon_damage_multiplier")
				managers.gameinfo:event("timed_buff", "activate", "new_berserk_weapon_damage_multiplier", { t = data.t, duration = upgrade_value and upgrade_value[2] or 0 })
			end
			
			buffs_loaded = true
		end
		if HUDListManager and HUDListManager.BUFFS and HUDList and HUDList.BuffItemBase and HUDList.BuffItemBase.MAP and HUDList.BuffItemBase.MAP ~= {} then
			HUDListManager.BUFFS.composite_debuffs.new_berserk_weapon_damage_multiplier_cooldown = "new_berserk_weapon_damage_multiplier"
			HUDListManager.BUFFS.composite_debuffs.new_unseen_strike_debuff = "new_unseen_strike"
			-- add weapon buff to global dmg increase
			HUDListManager.BUFFS.new_berserk_weapon_damage_multiplier = { "new_berserk_weapon_damage_multiplier", "damage_increase" }
			
			-- new zerk in 3 parts
			HUDList.BuffItemBase.MAP.new_berserk_weapon_damage_multiplier = {
				skills_new = tweak_data.skilltree.skills.wolverine.icon_xy,
				class = "TimedBuffItem",
				priority = 4,
				title = "Gilza_new_skill_zerk_weapons",
				localized = true,
				color = HUDListManager.ListOptions.buff_icon_color_standard,
				ignore = not Gilza.settings.vhud_compat_new_weapon_zerk,
			}
			HUDList.BuffItemBase.MAP.new_berserk_weapon_damage_multiplier_cooldown = {
				skills_new = tweak_data.skilltree.skills.wolverine.icon_xy,
				class = "TimedBuffItem",
				priority = 8,
				color = HUDListManager.ListOptions.buff_icon_color_debuff_fix,
				ignore = true,
			}
			HUDList.BuffItemBase.MAP.new_berserk_melee_damage_multiplier_1 = {
				skills_new = tweak_data.skilltree.skills.wolverine.icon_xy,
				class = "TimedBuffItem",
				priority = 4,
				title = "Gilza_new_skill_zerk_melee",
				localized = true,
				color = HUDListManager.ListOptions.buff_icon_color_standard,
				ignore = not Gilza.settings.vhud_compat_new_melee_zerk,
			}
			-- new stockholm - made as a class because the value needs to be calculated differently from default trackers and it needs % at the end
			-- add trigger to our stockholm class
			HUDListManager.BUFFS.stockholm_basic_stacks = { "stockholm_basic_stacks", "Gilza_stockholm_basic" }
			-- create class
			HUDList.Gilza_stockholm_basic = HUDList.Gilza_stockholm_basic or class(HUDList.CompositeBuff)
			function HUDList.Gilza_stockholm_basic:init(...)
				HUDList.Gilza_stockholm_basic.super.init(self, ...)
			end
			-- this is called by our skill informer. updates values based on stack count and based value
			function HUDList.Gilza_stockholm_basic:_update_value()
				if managers.player:has_category_upgrade("player", "menace_panic_spread") then
					local value = 0
					local upg_values = managers.player:upgrade_value("player", "menace_panic_spread")
					if upg_values then
						value = value + upg_values.chance
					end
					managers.player._Gilza_menace_kill_tracker = managers.player._Gilza_menace_kill_tracker or 0
					value = value + managers.player._Gilza_menace_kill_tracker / 10
					
					self:_set_text(string.format("%.1f%%", value * 100))
				end
			end
			-- buff that is activated on kill
			HUDList.BuffItemBase.MAP.stockholm_basic_stacks = {
				skills_new = tweak_data.skilltree.skills.stockholm_syndrome.icon_xy,
				class = "Gilza_stockholm_basic",
				priority = 2,
				color = HUDListManager.ListOptions.buff_icon_color_standard,
				title = "Gilza_new_skill_stockholm_basic",
				localized = true,
				ignore = not Gilza.settings.vhud_compat_stockholm_menace,
			}
			-- body economy stacks, similar to stockholm
			HUDListManager.BUFFS.body_economy_stacks = { "body_economy_stacks", "Gilza_body_economy" }
			HUDList.Gilza_body_economy = HUDList.Gilza_body_economy or class(HUDList.CompositeBuff)
			function HUDList.Gilza_body_economy:init(...)
				HUDList.Gilza_body_economy.super.init(self, ...)
			end
			function HUDList.Gilza_body_economy:_update_value()
				if managers.player:has_category_upgrade("temporary", "single_body_shot_kill_reload") then
					managers.player._aggressive_reload_stacks = managers.player._aggressive_reload_stacks or 0
					local value = managers.player._aggressive_reload_stacks
					self:_set_text(string.format("%.1f%%", value * 10))
				end
			end
			HUDList.BuffItemBase.MAP.body_economy_stacks = {
				skills_new = tweak_data.skilltree.skills.speedy_reload.icon_xy,
				class = "Gilza_body_economy",
				priority = 4,
				color = HUDListManager.ListOptions.buff_icon_color_standard,
				title = "Gilza_new_skill_body_economy",
				localized = true,
				ignore = not Gilza.settings.vhud_compat_body_economy,
			}
			-- fearmonger
			HUDList.BuffItemBase.MAP.speed_boost_on_panic_kill = {
				skills_new = tweak_data.skilltree.skills.close_by.icon_xy,
				class = "TimedBuffItem",
				priority = 4,
				title = "wolfhud_hudlist_buff_aced",
				localized = true,
				color = HUDListManager.ListOptions.buff_icon_color_standard,
				ignore = not Gilza.settings.vhud_compat_fearmonger_speed,
			}
			-- electric boolets
			HUDList.BuffItemBase.MAP.tased_electric_bullets = {
				skills_new = tweak_data.skilltree.skills.insulation.icon_xy,
				class = "TimedBuffItem",
				priority = 4,
				title = "wolfhud_hudlist_buff_aced",
				localized = true,
				color = HUDListManager.ListOptions.buff_icon_color_standard,
				ignore = not Gilza.settings.vhud_compat_electric_bullets,
			}
			HUDList.BuffItemBase.MAP.dire_need = {
				skills_new = tweak_data.skilltree.skills.insulation.icon_xy,
				class = "TimedBuffItem",
				title = "wolfhud_hudlist_buff_basic",
				localized = true,
				priority = 4,
				color = HUDListManager.ListOptions.buff_icon_color_standard,
				ignore = not Gilza.settings.vhud_compat_dire_need_override,
			}
			-- revitalized
			HUDList.BuffItemBase.MAP.player_dodge_armor_regen = {
				skills_new = tweak_data.skilltree.skills.jail_diet.icon_xy,
				class = "TimedBuffItem",
				priority = 8,
				color = HUDListManager.ListOptions.buff_icon_color_debuff_fix,
				ignore = not Gilza.settings.vhud_compat_revitalized,
			}
			-- unseen strike composite buff #1
			HUDList.BuffItemBase.MAP.new_unseen_strike = {
				skills_new = tweak_data.skilltree.skills.unseen_strike.icon_xy,
				class = "TimedBuffItem",
				title = "Gilza_new_skill_unseen_strike_crits",
				localized = true,
				priority = 4,
				color = HUDListManager.ListOptions.buff_icon_color_standard,
				ignore = not Gilza.settings.vhud_compat_unseen_strike_override,
			}
			-- unseen strike composite buff #2
			HUDList.BuffItemBase.MAP.new_unseen_strike_debuff = {
				skills_new = tweak_data.skilltree.skills.unseen_strike.icon_xy,
				class = "TimedBuffItem",
				priority = 8,
				color = HUDListManager.ListOptions.buff_icon_color_debuff_fix,
				ignore = true,
			}
			-- unseen strike eligibility
			HUDList.BuffItemBase.MAP.new_unseen_strike_eligibility = {
				skills_new = tweak_data.skilltree.skills.unseen_strike.icon_xy,
				class = "TimedBuffItem",
				title = "Gilza_new_skill_unseen_strike_eligibility",
				localized = true,
				priority = 8,
				color = HUDListManager.ListOptions.buff_icon_color_standard,
				ignore = not Gilza.settings.vhud_compat_unseen_strike_override,
			}
			-- force disable vanilla unseen strike
			HUDList.BuffItemBase.MAP.unseen_strike.ignore = true
			-- new aced lock and load reloads
			HUDListManager.BUFFS.new_lock_n_load_bonus = { "new_lock_n_load_bonus", "Gilza_new_lock_n_load_bonus" }
			HUDList.Gilza_new_lock_n_load_bonus = HUDList.Gilza_new_lock_n_load_bonus or class(HUDList.CompositeBuff)
			function HUDList.Gilza_new_lock_n_load_bonus:init(...)
				HUDList.Gilza_new_lock_n_load_bonus.super.init(self, ...)
			end
			function HUDList.Gilza_new_lock_n_load_bonus:_update_value(input)
				-- this function doesnt do anything cause it doesnt need to do anything. however if it doesnt exist vhud will crash so enjoy this piece of trivia
			end
			function HUDList.Gilza_new_lock_n_load_bonus:set_value(source, data)
				if managers.player:has_category_upgrade("player", "automatic_faster_reload") then
					if source == "new_lock_n_load_bonus" and data then
						self:_set_text(string.format("%.0f%%", data.value * 100 - 100))
					end
				end
			end
			HUDList.BuffItemBase.MAP.new_lock_n_load_bonus = {
				skills_new = tweak_data.skilltree.skills.shock_and_awe.icon_xy,
				class = "Gilza_new_lock_n_load_bonus",
				title = "wolfhud_hudlist_buff_aced",
				localized = true,
				priority = 4,
				color = HUDListManager.ListOptions.buff_icon_color_standard,
				ignore = not Gilza.settings.vhud_compat_new_lock_n_load,
			}
			-- force disable vanilla lock n load
			HUDList.BuffItemBase.MAP.lock_n_load.ignore = true
			
			-- fixes for desperado/trigger happy
			HUDList.BuffItemBase.MAP.desperado.skills_new = {11,1}
			HUDList.BuffItemBase.MAP.desperado.ignore = not Gilza.settings.vhud_compat_new_trigger_happy
			-- since we have it under one skill, no point in tracking them seperately
			HUDList.BuffItemBase.MAP.trigger_happy.ignore = true
			
			-- composite damage reduction
			HUDListManager.BUFFS.gilza_total_dmg_resist = { "gilza_total_dmg_resist", "GilzaDamageReductionBuff" }
			-- all upgrades that should affect the total dmg resist. used mostly for timed buffs to show their duration
			HUDListManager.BUFFS.close_contact_1 = { "close_contact", "gilza_total_dmg_resist" }
			HUDListManager.BUFFS.close_contact_2 = { "close_contact", "gilza_total_dmg_resist" }
			HUDListManager.BUFFS.close_contact_3 = { "close_contact", "gilza_total_dmg_resist" }
			HUDListManager.BUFFS.combat_medic = { "combat_medic", "gilza_total_dmg_resist" }
			HUDListManager.BUFFS.combat_medic_passive = { "combat_medic_passive", "gilza_total_dmg_resist" }
			HUDListManager.BUFFS.die_hard = { "die_hard", "gilza_total_dmg_resist" }
			HUDListManager.BUFFS.hostage_situation = { "hostage_situation", "gilza_total_dmg_resist" }
			HUDListManager.BUFFS.overdog = { "overdog", "gilza_total_dmg_resist" }
			HUDListManager.BUFFS.pain_killer = { "painkiller", "gilza_total_dmg_resist" }
			HUDListManager.BUFFS.pain_killer_aced = { "painkiller", "gilza_total_dmg_resist" }
			HUDListManager.BUFFS.quick_fix = { "quick_fix", "gilza_total_dmg_resist" }
			HUDListManager.BUFFS.underdog_aced = { "underdog", "gilza_total_dmg_resist" }
			HUDListManager.BUFFS.up_you_go = { "up_you_go", "gilza_total_dmg_resist" }
			HUDListManager.BUFFS.crew_chief_1 = { "crew_chief", "gilza_total_dmg_resist" }
			
			HUDList.GilzaDamageReductionBuff = HUDList.GilzaDamageReductionBuff or class(HUDList.CompositeBuff)
			function HUDList.GilzaDamageReductionBuff:init(...)
				HUDList.GilzaDamageReductionBuff.super.init(self, ...)
			end
			function HUDList.GilzaDamageReductionBuff:_update_value(input)
				-- bliss
			end
			function HUDList.GilzaDamageReductionBuff:set_value(source, data)
				if source == "gilza_total_dmg_resist" and data then
					self._current_resist = self._current_resist or 0
					if self._current_resist ~= data.value then
						self._current_resist = data.value
						self:_set_text(string.format("%.1f%%", 100 - data.value * 100))
					end
					if self._current_resist >= 1 then
						managers.gameinfo:event("buff", "deactivate", "gilza_total_dmg_resist")
					else
						managers.gameinfo:event("buff", "activate", "gilza_total_dmg_resist")
					end
				end
			end
			HUDList.BuffItemBase.MAP.gilza_total_dmg_resist = {
				skills_new = tweak_data.skilltree.skills.disguise.icon_xy,
				class = "GilzaDamageReductionBuff",
				title = "wolfhud_hudlist_buff_dmg_dec",
				localized = true,
				priority = 2,
				color = Color(0, 1, 1),
				ignore = not Gilza.settings.vhud_compat_total_dmg_resist
			}
			-- force disable vanilla dmg resist
			HUDList.BuffItemBase.MAP.damage_reduction.ignore = true
			
			-- composite dodge
			HUDListManager.BUFFS.gilza_total_dodge = { "gilza_total_dodge", "GilzaTotalDodgeChanceBuff" }
			-- add hacker's temporary dodge
			HUDListManager.BUFFS.pocket_ecm_kill_dodge = { "pocket_ecm_kill_dodge", "gilza_total_dodge" }
			HUDList.GilzaTotalDodgeChanceBuff = HUDList.GilzaTotalDodgeChanceBuff or class(HUDList.CompositeBuff)
			function HUDList.GilzaTotalDodgeChanceBuff:init(...)
				HUDList.GilzaTotalDodgeChanceBuff.super.init(self, ...)
			end
			function HUDList.GilzaTotalDodgeChanceBuff:_update_value(input)
				-- bliss
			end
			function HUDList.GilzaTotalDodgeChanceBuff:set_value(source, data)
				if source == "gilza_total_dodge" and data then
					self._current_dodge = self._current_dodge or 0
					if self._current_dodge ~= data.value then
						self._current_dodge = data.value
						self:_set_text(string.format("%.1f%%", data.value * 100))
					end
					if self._current_dodge <= 0 then
						managers.gameinfo:event("buff", "deactivate", "gilza_total_dodge")
					else
						managers.gameinfo:event("buff", "activate", "gilza_total_dodge")
					end
				end
			end
			HUDList.BuffItemBase.MAP.gilza_total_dodge = {
				skills_new = {1, 12},
				texture_bundle_folder = "max",
				class = "GilzaTotalDodgeChanceBuff",
				title = "wolfhud_hudlist_buff_tot_dodge",
				localized = true,
				priority = 2,
				color = Color(1, 0.5, 0),
				ignore = not Gilza.settings.vhud_compat_total_dodge
			}
			-- force disable vanilla dodge
			HUDList.BuffItemBase.MAP.total_dodge_chance.ignore = true
			
			-- passive heal adjust
			function HUDList.PassiveHealthRegenBuff:_update_value()
				local value = 0

				for id, data in pairs(self._member_buffs) do
					local clbk = self._buff_effects[id]
					value = value + (data.value and (clbk and clbk(data.value) or data.value) or 0)
				end
				
				-- ova here
				if managers.player:has_category_upgrade("player", "passive_health_regen") and self._latest_adjustment then
					value = value + self._latest_adjustment
				end

				self:_set_text(string.format("%.1f%%", value * 100))
			end
			
			-- add swan song aced buff to total dmg increase
			HUDListManager.BUFFS.swan_song_aced = { "swan_song", "damage_increase" }
			function HUDList.DamageIncreaseBuff:init(...)
				HUDList.DamageIncreaseBuff.super.init(self, ...)

				self._buff_weapon_requirements = {
					overkill = {
						shotgun = true,
						saw = true,
					},
					berserker = {
						saw = true,
					},
				}

				self._buff_weapon_exclusions = {
					overkill_aced = {
						shotgun = true,
						saw = true,
					},
					berserker_aced = {
						saw = true,
					},
				}

				self._buff_effects = {
					berserker = function(value)
						return 1 + (value or 0) * managers.player:upgrade_value("player", "melee_damage_health_ratio_multiplier", 0)
					end,
					berserker_aced = function(value)
						return 1 + (value or 0) * managers.player:upgrade_value("player", "damage_health_ratio_multiplier", 0)
					end,
					new_berserk_weapon_damage_multiplier = function(value)
						return (value or 1)
					end,
					swan_song_aced = function(value)
						return (value or 1)
					end,
				}
			end
			
			-- composite damage abosrption
			HUDListManager.BUFFS.gilza_total_damage_absorb = { "gilza_total_damage_absorb", "GilzaTotalDamageAbsorptionBuff" }
			HUDList.GilzaTotalDamageAbsorptionBuff = HUDList.GilzaTotalDamageAbsorptionBuff or class(HUDList.CompositeBuff)
			function HUDList.GilzaTotalDamageAbsorptionBuff:init(...)
				HUDList.GilzaTotalDamageAbsorptionBuff.super.init(self, ...)
			end
			function HUDList.GilzaTotalDamageAbsorptionBuff:_update_value(input)
				-- bliss
			end
			function HUDList.GilzaTotalDamageAbsorptionBuff:set_value(source, data)
				if source == "gilza_total_damage_absorb" and data then
					self._current_absorb = self._current_absorb or 0
					if self._current_absorb ~= data.value then
						self._current_absorb = data.value
						self:_set_text(string.format("-%.1f", data.value * 10))
					end
					if self._current_absorb <= 0 then
						managers.gameinfo:event("buff", "deactivate", "gilza_total_damage_absorb")
					else
						managers.gameinfo:event("buff", "activate", "gilza_total_damage_absorb")
					end
				end
			end
			HUDList.BuffItemBase.MAP.gilza_total_damage_absorb = {
				skills_new = tweak_data.skilltree.skills.disguise.icon_xy,
				class = "GilzaTotalDamageAbsorptionBuff",
				title = "Gilza_new_vhud_dmg_aborb_total",
				localized = true,
				priority = 2,
				color = Color(0, 1, 1),
				ignore = not Gilza.settings.vhud_compat_total_dmg_absorb
			}
			-- hitman akimbo kill recovery
			HUDList.BuffItemBase.MAP.new_hitman_recovery_bonus = {
				perks = {7, 2},
				--texture_bundle_folder = "max",
				class = "TimedBuffItem",
				title = "Gilza_new_hitman_recovery_bonus_tag",
				localized = true,
				priority = 8,
				color = HUDListManager.ListOptions.buff_icon_color_standard,
				ignore = not Gilza.settings.vhud_compat_new_hitman_recovery,
			}
			
			map_loaded = true
		end
		if buffs_loaded and map_loaded then
			Gilza.vhud_compatibility_loaded = true
			log("[Gilza] VHUD+ compatibility loaded.")
		end
		if not Gilza.vhud_compatibility_loaded then
			DelayedCalls:Add("Gilza_wait_for_vhp_to_load", 0.25, function()
				add_vhud_vars()
			end)
		end
	end
	add_vhud_vars()
end

-- activated on new melee zerk. can be activated even while its allready active, like overkill. grab duration from tweakdata like vhud func bellow
function Gilza.New_Skills_Informer:activated_new_zerk_melee()
	if Gilza.VHP_enabled and Gilza.vhud_compatibility_loaded then
		managers.gameinfo:event("timed_buff", "activate", "new_berserk_melee_damage_multiplier_1", { duration = tweak_data.upgrades.values.temporary.new_berserk_weapon_damage_multiplier_cooldown[1][2] or 0 })
	end
end

-- new weapon berserk. activates 2 temporary buffs, one for duration, another for cooldown, because main buff has a dmg mul.
-- grab duration info on both from tweakdata
function Gilza.New_Skills_Informer:activated_new_zerk_firearms()
	if Gilza.VHP_enabled and Gilza.vhud_compatibility_loaded then
		managers.gameinfo:event("timed_buff", "activate", "new_berserk_weapon_damage_multiplier_cooldown", { duration = tweak_data.upgrades.values.temporary.new_berserk_weapon_damage_multiplier_cooldown[1][2] or 0 })
	end
end

-- called whenever new basic stockholm stacks are added/removed. amount of total stacks scales from 0 to 4. amount var this func gets represents amount of added stacks, not total.
-- "cleared" is true only when going to custody, in such case amount is 0.
-- for infohuds: new func needs to be made that adds up (stack amount / 100) and basic value of the skill via managers.player:upgrade_value("player", "menace_panic_spread").chance
-- because we always start at 0 stacks, but always have our basic 10% chance (at least thats current value)
-- for an example scroll up to HUDList.Gilza_stockholm_basic:_update_value()
function Gilza.New_Skills_Informer:adjusted_stockholm_stacks(amount, cleared)
	if Gilza.settings.menace_points_notification and not cleared then
		managers.hud:show_hint({text = managers.localization:text("Gilza_menace_panic_spread_notification")..tostring(managers.player._Gilza_menace_kill_tracker)})
	end
	if amount and Gilza.VHP_enabled and Gilza.vhud_compatibility_loaded then
		managers.gameinfo:event("buff", "set_value", "stockholm_basic_stacks", { value = math.random() }) -- value is irrelevant bcuz updater func calculates current amount by itself
	end
end

-- new aced agressive reload/body economy. reports total amount of stacks from 1 to 10. each stacks provides 7.5% reload speed. you can make a func that shows either total buff or stack count
-- "cleared" triggers whenever stacks are reset to 0
function Gilza.New_Skills_Informer:adjusted_body_economy_stacks(total_amount, cleared)
	if total_amount and Gilza.VHP_enabled and Gilza.vhud_compatibility_loaded then
		managers.gameinfo:event("buff", "activate", "body_economy_stacks")
		managers.gameinfo:event("buff", "set_value", "body_economy_stacks", { value = total_amount })
		if cleared then
			managers.gameinfo:event("buff", "deactivate", "body_economy_stacks")
			managers.gameinfo:event("buff", "set_value", "body_economy_stacks", { value = -69 })
		end
	end
end

-- practically identical to melee zerk as a simple timed buff. activates even while already active like overkill
function Gilza.New_Skills_Informer:activated_fearmonger_speed_boost()
	if Gilza.VHP_enabled and Gilza.vhud_compatibility_loaded then
		managers.gameinfo:event("timed_buff", "activate", "speed_boost_on_panic_kill", { duration = tweak_data.upgrades.values.temporary.speed_boost_on_panic_kill[1][2] or 0 })
	end
end

-- same as fearmonger above but for electric boolets (skill named "backfire")
function Gilza.New_Skills_Informer:activated_electric_bullets()
	if Gilza.VHP_enabled and Gilza.vhud_compatibility_loaded then
		managers.gameinfo:event("timed_buff", "activate", "tased_electric_bullets", { duration = tweak_data.upgrades.values.temporary.tased_electric_bullets[1][2] or 0 })
	end
end

-- tier 4 dodge tree skill. get cooldown duration on your own similar to how its done bellow for vhud.
function Gilza.New_Skills_Informer:activated_revitalized_cd()
	if Gilza.VHP_enabled and Gilza.vhud_compatibility_loaded then
		local upg_values = managers.player:upgrade_value("temporary", "player_dodge_armor_regen")
		local dur = upg_values[2] or 0
		if dur > 0 then
			managers.gameinfo:event("timed_buff", "activate", "player_dodge_armor_regen", { duration = dur })
		end
	end
end

-- due to the way unseen strike triggeres were redone, adjust your unseen strike effects.
-- this one triggers when crits become active. this effect always has a (6) second cooldown, that is equal to "no taking dmg" duration.
-- calculate stuff similarly to whats done bellow.
function Gilza.New_Skills_Informer:activated_new_unseen_strike_crits()
	if Gilza.VHP_enabled and Gilza.vhud_compatibility_loaded then
		local upg_values = managers.player:upgrade_value("temporary", "unseen_strike")
		local US_CD = managers.player:upgrade_value("player", "unseen_increased_crit_chance")
		if US_CD and US_CD.min_time and US_CD.min_time > 0 then US_CD = US_CD.min_time end
		local dur = upg_values[2] or 0
		if dur > 0 then
			managers.gameinfo:event("timed_buff", "deactivate", "new_unseen_strike_debuff")
			managers.gameinfo:event("timed_buff", "activate", "new_unseen_strike_debuff", { duration = dur + US_CD }) -- delay is equal to the "not getting shot" requirement
			managers.gameinfo:event("timed_buff", "activate", "new_unseen_strike", { duration = dur })
		end
	end
end

-- whenever player is eligible for US this gets triggered with true, and vise versa. (you become eligible if you didnt take dmg for 6 seconds, even during unseen strike crits)
function Gilza.New_Skills_Informer:updated_new_unseen_strike_eligibility(status)
	if Gilza.VHP_enabled and Gilza.vhud_compatibility_loaded then
		if status then
			managers.gameinfo:event("buff", "activate", "new_unseen_strike_eligibility")
		else
			managers.gameinfo:event("buff", "deactivate", "new_unseen_strike_eligibility")
		end
	end
end

-- reports true or false when new lock and load bonus becomes active/inactive
-- bonus can be deactivated because of weapon swap/reload, but the bonus amount itself does not get reset, because weapon still has missing rounds in it's mag
function Gilza.New_Skills_Informer:new_lock_n_load_status(enabled)
	if Gilza.VHP_enabled and Gilza.vhud_compatibility_loaded then
		if enabled then
			local upg_values = managers.player:upgrade_value("player", "automatic_faster_reload")
			local min_bonus = upg_values.min_reload_increase
			managers.gameinfo:event("buff", "activate", "new_lock_n_load_bonus")
			managers.gameinfo:event("buff", "set_value", "new_lock_n_load_bonus", { value = min_bonus })
		else
			managers.gameinfo:event("buff", "set_value", "new_lock_n_load_bonus", { value = 0 })
			managers.gameinfo:event("buff", "deactivate", "new_lock_n_load_bonus")
		end
	end
end

-- reports total reload bonus that player has from the skill. reports the bonus itself as "2.25" if bonus is maxed at "125%" bonus reload speed, so make adjustments.
function Gilza.New_Skills_Informer:new_lock_n_load_buff_update(total_percent)
	if Gilza.VHP_enabled and Gilza.vhud_compatibility_loaded then
		if total_percent then
			managers.gameinfo:event("buff", "set_value", "new_lock_n_load_bonus", { value = total_percent })
		end
	end
end

-- new dmg resist reporter - provides damage multiplier that you currently have from passive dmg resistances, every time playerstandard:update is executed
-- so 0.3 means 70% total dmg resist. also, this does not take into account specific damage type resistances like bullet/melee, so perks like yakuza and brawler will show lower resist than what they probably have
function Gilza.New_Skills_Informer:update_current_passive_dmg_resist(total_resist)
	if Gilza.VHP_enabled and Gilza.vhud_compatibility_loaded then
		managers.gameinfo:event("buff", "deactivate", "damage_reduction") -- idk why vanilla's DR hud element rarely pops up, but it does, so always force disable it
		managers.gameinfo:event("buff", "activate", "gilza_total_dmg_resist")
		if total_resist then
			managers.gameinfo:event("buff", "set_value", "gilza_total_dmg_resist", { value = total_resist })
		end
	end
end

-- updates current dodge chance every time playerstandard:update is executed (afaik thats about 100 times a second)
-- current dodge value is reported as 0.3 for 30% dodge
function Gilza.New_Skills_Informer:dodge_value_tracker(current_dodge)
	if Gilza.VHP_enabled and Gilza.vhud_compatibility_loaded then
		managers.gameinfo:event("buff", "activate", "gilza_total_dodge")
		if current_dodge then
			managers.gameinfo:event("buff", "set_value", "gilza_total_dodge", { value = current_dodge })
		end
	end
end

-- any time PlayerManager:health_regen() caclulates amount of passive health regen, this function also gets triggered.
-- it will report by how much health regen was adjusted. value can be both positive and negative. example: -0.015 to reduce 5 second heal by 1.5%
-- this skill adjustment happens with copycat perk, and muscle perk on DS
function Gilza.New_Skills_Informer:new_passive_health_regen_adjustment(amount)
	if Gilza.VHP_enabled and Gilza.vhud_compatibility_loaded then
		if amount then
			HUDList.PassiveHealthRegenBuff._latest_adjustment = amount
		end
	end
end

-- reports current damage abosrption amount as total value
-- current absorb value is reported as 1.5 for 15 abosrption
function Gilza.New_Skills_Informer:update_current_dmg_absorb(current_DA)
	if Gilza.VHP_enabled and Gilza.vhud_compatibility_loaded then
		managers.gameinfo:event("buff", "activate", "gilza_total_damage_absorb")
		if current_DA then
			managers.gameinfo:event("buff", "set_value", "gilza_total_damage_absorb", { value = current_DA })
		end
	end
end

-- 2nd card for hitman. reports activation of the skill, which like overkill, always resets self to maximum on re-activation
function Gilza.New_Skills_Informer:activated_new_hitman_akimbo_recovery()
	if Gilza.VHP_enabled and Gilza.vhud_compatibility_loaded then
		local upg_values = managers.player:upgrade_value("temporary", "akimbo_pistol_armor_regen_timer_multiplier")
		local dur = upg_values[2] or 0
		if dur > 0 then
			managers.gameinfo:event("timed_buff", "deactivate", "new_hitman_recovery_bonus")
			managers.gameinfo:event("timed_buff", "activate", "new_hitman_recovery_bonus", { duration = dur })
		end
	end
end