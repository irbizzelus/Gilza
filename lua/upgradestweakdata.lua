if not Gilza then
	dofile("mods/Gilza/lua/1_GilzaBase.lua")
end

-- actual values for all skills
Hooks:PostHook(UpgradesTweakData, "_init_pd2_values", "Gilza_UpgradesTweakData_init_pd2_values_post", function(self)
	
	-- Shotgun HE round. Why it would be here is beyond my understanding
	self.explosive_bullet = {
		curve_pow = 0,
		player_dmg_mul = 0.01,
		range = 120
	}
	self.explosive_bullet.feedback_range = self.explosive_bullet.range
	
	local function New_Skills()
	
		local function New_Mastermind_Skills()
			---- MEDIC
			-- combat medic basic
			self.values.temporary.revive_damage_reduction = {
				{
					0.75,
					5
				}
			}
			self.values.player.revive_damage_reduction = {
				0.75
			}
			-- new on revive bonus
			self.values.player.revive_action_self_heal = {
				0.35
			}
			---- CONTROLLER
			-- new murder hobo skill
			self.values.player.menace_panic_spread = {
				{
					chance = 0.1,
					area = 1000,
					amount = 75
				}
			}
			---- SHARPSHOOTER
			-- tweaked stable shot to only give accuracy bonuses
			self.values.player.weapon_accuracy_increase = {
				1,
				4
			}
			-- new designated marksman skill - better recoil with first 5/10 shots
			self.values.player.less_start_recoil = {
				0.85,
				0.5
			}
			self.values.player.less_start_recoil_for_longer = {
				true
			}
			self.values.smg.zoom_increase = {
				(Gilza.settings.designated_marksman_zoom - 1) or 2
			}
			self.values.assault_rifle.zoom_increase = {
				(Gilza.settings.designated_marksman_zoom - 1) or 2
			}
			self.values.lmg.zoom_increase = {
				(Gilza.settings.designated_marksman_zoom - 1) or 2
			}
			self.values.snp.zoom_increase = {
				(Gilza.settings.designated_marksman_zoom - 1) or 2
			}
			self.values.pistol.zoom_increase = {
				(Gilza.settings.designated_marksman_zoom - 1) or 2
			}
			-- new slow and steady skill - dmg resist if not moving
			self.values.player.not_moving_damage_reduction_bonus = {
				0.925
			}
			-- slow and steady pro - extra dmg resist if bipoded
			self.values.player.not_moving_damage_reduction_bonus_bipoded = {
				0.7
			}
			-- slow and steady pro - faster bipod deploy time
			self.values.player.bipod_deploy_speed = {
				2
			}
			-- agressive reload for AR's; due to game's reload speed caluclations, this value is now 25% so that actuall reloads gain a 20% buff
			self.values.assault_rifle.reload_speed_multiplier = {
				1.2
			}
			-- agressive reload for SMG's
			self.values.smg.reload_speed_multiplier = {
				1.2
			}
			-- agressive reload for sniper's
			self.values.snp.reload_speed_multiplier = {
				1.2
			}
			-- agressive reload based on bodyshots that lasts "forever" and grants 10% bonus per 1 stack. stacks counted in PM
			self.values.temporary.single_body_shot_kill_reload = {
				{
					0.1,
					9999
				}
			}
			-- agressive reload basic/aced ammo refills
			self.values.player.single_body_shot_kill_refill_ammo = {
				0.1,
				0.4
			}
			-- new graze values, they should be 1/3 and 2/3 but i dont trust damage calculation's rounding up values correctly
			self.values.snp.graze_damage = {
				{
					radius = 80,
					damage_factor = 0.34,
					damage_factor_headshot = 0
				},
				{
					radius = 160,
					damage_factor = 0.67,
					damage_factor_headshot = 0
				}
			}
		end
		New_Mastermind_Skills()
		
		local function New_Enforcer_Skills()
			---- SHOTGUNNER
			-- underdog duration reduced to compensate new activation mechanics
			self.values.temporary.dmg_multiplier_outnumbered = {
				{
					1.1,
					5
				}
			}
			self.values.temporary.dmg_dampener_outnumbered = {
				{
					0.9,
					5
				}
			}
			-- new shotgun expert skill
			self.values.shotgun.recoil_multiplier = {
				0.8,
				0.50
			}
			self.values.shotgun.steelsight_accuracy_inc = {
				0.7
			}
			-- new blast away skill - suprisingly still has native support, and does not require any code on my part
			self.values.shotgun.consume_no_ammo_chance = {
				0.065,
				0.2
			}
			-- fearmonger's shotgun panic spread
			self.values.shotgun.panic_when_kill = {
				{
					chance = 0.75,
					area = 1500,
					amount = 750
				}
			}
			-- shotgun panic - speed boost
			self.values.temporary.speed_boost_on_panic_kill = {
				{
					0.25,
					20
				}
			}
			-- overkill
			self.values.temporary.overkill_damage_multiplier = {{1.40,30}}
			
			---- TANK
			-- interaction dmg resist reduced for new dmg resist properties
			self.values.player.interacting_damage_multiplier = {
				0.6
			}
			-- Sprint with any bag
			self.values.player.sprint_any_bag = {true}
			-- bullseye aced
			self.values.player.headshot_regen_armor_shorter_cooldown = {true}
			
			---- AMMO SPECIALIST
			-- we consume less total ammo with saw, so skill is also reduced
			self.values.saw.enemy_slicer = {
				5
			}
			-- new saw massacre aced bonus
			self.values.player.saw_ammo_pick_up = {
				true
			}
			-- fully loaded aced pickup. basic version is noramlly under perks, but no more - its fucking annoying
			self.values.player.pick_up_ammo_multiplier = {
				1.25,
				1
			}
			-- make old fully loaded aced grenade pick up base kit with perks, buff the skill values. nerf grenade pick ups depending on the grenade
			self.values.player.regain_throwable_from_ammo = {
				{
					chance = 0,
					chance_inc = 0.01
				},
				{
					chance = 0.03,
					chance_inc = 0.03
				}
			}	
		end
		New_Enforcer_Skills()
		
		local function New_Technician_Skills()
			---- ENGINEER
			-- new gun oil skill
			self.values.player.ar_smg_lmg_rof_increase = {
				0.95,
				0.75
			}
			-- sentry guns tower defense - less sentries
			self.values.sentry_gun.quantity = {
				3,
				2
			}
			-- sentry guns tower defense - 10% dmg resist
			self.values.player.sentry_proximity_damage_resist = {
				0.9,
			}
			-- sentry guns tower defense - refil ammo for every sentry gun kill. ratio is for a standard ammo pick up
			self.values.player.sentry_kills_refill_ammo = {
				0.25,
			}
			---- BREACHER
			-- new drill repairs
			self.values.player.drill_fix_interaction_speed_multiplier = {
				0.85,
				0.5
			}
			-- buff firetraps a bit
			self.values.trip_mine.fire_trap = {
				{
					0,
					1
				},
				{
					20,
					1.75
				}
			}
			---- OPPRESSOR
			-- base steady grip sometimes can be gained for no reason, idk why, just make sure that it gives nothing
			self.values.player.stability_increase_bonus_1 = {
				0,
			}
			-- tweaked steady grip to only give stability bonuses
			self.values.player.stability_increase_bonus_2 = {
				1,
				4
			}
			-- heavy impact
			self.values.weapon.knock_down = {
				0.05,
				0.2
			}
			-- new fire control basic - removed 40% recoil penalty while hipfiring
			self.values.player.hipfire_less_recoil = {
				0
			}
			-- new fire control aced - removes acc penalty while hipfiring
			self.values.player.hipfire_no_accuracy_penalty = {
				0
			}
			-- ap chance for surefire aced, in addition to it's reduced guarnteed pen, for better build variety
			self.values.weapon.armor_piercing_chance_2 = {
				0.25
			}
			-- lock n load aced, new version
			self.values.player.automatic_faster_reload = {
				{
					min_reload_increase = 1.35,
					penalty = 1.01,
					target_enemies = 3,
					min_bullets = 15,
					max_reload_increase = 2.25
				}
			}
			-- Body expertise muls
			self.values.weapon.automatic_head_shot_add = {
				1,
				1.25
			}
			-- new ap bullets for surefire
			self.values.player.ap_bullets_basic = {
				true
			}
			-- new ap bullets for BE aced
			self.values.player.ap_bullets_aced = {
				true
			}
			-- ammo pick up reduction for BE - legacy
			self.values.player.pick_up_ammo_reduction = {
				1,
				1
			}
		end
		New_Technician_Skills()
		
		local function New_Ghost_Skills()
			---- ARTFUL DODGER
			-- new jump skill
			self.values.player.extra_jump_height = {
				1.2
			}
			-- new no fall damage skill
			self.values.player.limited_fall_damage_immunity = {
				1
			}
			-- new tazer boolets
			self.values.temporary.tased_electric_bullets = {
				{
					1,
					20
				}
			}
			-- moved to the anti-tazer skill, with reduced duration
			self.values.player.armor_depleted_stagger_shot = {
				0,
				2
			}
			-- new dodge armor regen skill
			self.values.temporary.player_dodge_armor_regen = {
				{
					1,
					20
				},
				{
					5,
					10
				}
			}
			-- ap chance for silencers - incremental
			self.values.weapon.armor_piercing_chance_silencer = {
				0.15,
				0.35
			}
			-- unseen strike velue nerfs to compensate much more forgiving activation trigger
			self.values.player.unseen_increased_crit_chance = {
				{
					min_time = 6,
					max_duration = 6,
					crit_chance = 1.35
				},
				{
					min_time = 6,
					max_duration = 18,
					crit_chance = 1.35
				}
			}
			self.values.temporary.unseen_strike = {
				{
					1.35,
					6
				},
				{
					1.35,
					18
				}
			}
		end
		New_Ghost_Skills()
		
		local function New_Fugitive_Skills()
			---- GUNSLINGER
			-- equilibrium aced buffs
			self.values.pistol.swap_speed_multiplier = {
				1.5,
				2
			}
			self.values.pistol.spread_index_addend = {
				3
			}
			-- pistol passive ROF
			self.values.pistol.fire_rate_multiplier = {
				1.20
			}
			-- nerfed main trigger happy
			self.values.pistol.stacking_hit_damage_multiplier = {
				{
					max_stacks = 1,
					max_time = 5,
					damage_bonus = 1.3
				},
				{
					max_stacks = 1,
					max_time = 5,
					damage_bonus = 1.3
				}
			}
			-- rof buff during trigger happy
			self.values.pistol.trigger_happpy_rof_increase = {
				1.3
			}
			-- new desperado
			self.values.pistol.stacked_accuracy_bonus = {
				{
					max_stacks = 1,
					accuracy_bonus = 0.68,
					max_time = 5
				}
			}	
			-- new akimbo skill
			self.values.akimbo.pistol_improved_handling = {
				{
				recoil = 4,
				accuracy = 3,
				reload = 1.35,
				swap_speed = 2
				},
			}
			self.values.akimbo.allow_smg_improved_handling = {
				true
			}
			-- new bottomless pockets skill
			self.values.pistol.extra_ammo_multiplier = {
				1.5,
				2.5
			}
			-- new bottomless pockets skill - ammo total
			self.values.smg.extra_ammo_multiplier = {
				1.4,
				2
			}
			-- bottomless pockets basic
			self.values.player.secondary_weapons_pickup_bonus = {
				1 / 0.7 -- secondary mul nulifier
			}
			-- bottomless pockets aced
			self.values.player.pistols_and_smgs_pick_up_increase = {
				1.25
			}
			
			---- REVENANT
			-- new version for self heal with up you go
			self.values.player.health_regain_V2 = {
				0.3
			}
			-- adjust normal selfheal from up you go just in case
			self.values.player.revived_health_regain = {
				1
			}
			-- running from death buffs
			self.values.temporary.swap_weapon_faster = {
				{
					2,
					30
				}
			}
			self.values.temporary.reload_weapon_faster = {
				{
					2,
					30
				}
			}
			self.values.temporary.increased_movement_speed = {
				{
					1.3,
					30
				}
			}
			-- messiah inf bleedout health
			self.values.player.bleed_out_health_multiplier = {
				1.5,
				999
			}
			-- swan song change
			self.values.temporary.berserker_damage_multiplier = { {1,4}, {1.5,8} }
			
			---- BRAWLER
			self.values.player.melee_shake_reduction = {
				0.7,
				0.1
			}
			-- blotdthirst basic adjustment to new melee system
			self.values.player.melee_damage_stacking = {
				{
					max_multiplier = 3,
					melee_multiplier = 0.2
				}
			}
			-- melee sprint skill
			self.values.player.melee_sprint = {
				true
			}
			-- faster melee charge skill
			self.values.player.melee_faster_charge = {
				0.5
			}
			-- base berserk melee damage buff
			self.values.player.melee_damage_newzerk_addin = {
				0.5
			}
			-- new berserk melee
			self.values.temporary.new_berserk_melee_damage_multiplier_1 = {
				{
					1.5,
					40
				}
			}
			-- new berserk weapon
			self.values.temporary.new_berserk_weapon_damage_multiplier = {
				{
					2,
					30
				}
			}
			-- new berserk weapon cooldown
			self.values.temporary.new_berserk_weapon_damage_multiplier_cooldown = {
				{
					1,
					40
				}
			}
		end
		New_Fugitive_Skills()
	
	end
	New_Skills()
	
	-- PERKS
	local function New_Perks()
		
		-- skills that are used by multiple perks at once
		local function Shared_updates()
			-- 4th value added for ROGUE, mostly just the first value is used sometimes to add dodge. 5th value deprecated, was used by COPYCAT
			self.values.player.passive_dodge_chance = {
				0.15,
				0.3,
				0.45,
				0.5,
				0
			}
			-- armour piercing buffs for ROGUE and CROOK
			self.values.weapon.armor_piercing_chance = {
				0.4, -- rogue
				0.75 -- crook
			}
			-- CROOK skill adjustments to buff LBV for burglar
			self.values.player.level_2_dodge_addend = {
				0.05,
				0.1,
				0.25
			}
			self.values.player.level_3_dodge_addend = {
				0.05,
				0.1,
				0.25
			}
			self.values.player.level_4_dodge_addend = {
				0.05,
				0.1,
				0.25
			}
			-- GAMBLER's ammo pick up range. this skill is copied from enforcer's skill tree. both were made incremental so they can stack
			self.values.player.increased_pickup_area = {
				1.5,
				2
			}
			-- COPYCAT's additions to this skill
			self.values.temporary.armor_break_invulnerable = {
				{
					2,
					15
				},
				{
					2,
					30
				},
				{
					2,
					40
				}
			}
			-- BRAWLER add 4x slower armor recovery multiplier to this vanilla skill
			self.values.player.perk_armor_regen_timer_multiplier = {
				0.95,
				0.85,
				0.75,
				0.65,
				0.55,
				3.5
			}
			-- BRAWLER's ap damage resist. now also used for Yakuza, and can be used for more things theoretically
			self.values.player.AP_damage_resist_brawler = {
				true
			}
			-- SPEED JUNKIE - anarchist's vanilla armor increase skill, extended for our new perk
			self.values.player.armor_increase = {
				1,
				1.1,
				1.2,
				0.42,
				0.46,
				0.52
			}
			-- SPEED JUNKIE - anarchist's health decrease, extended for our new perk
			self.values.player.health_decrease = {
				0.5,
				0.9
			}
		end
		Shared_updates()
		
		local function New_Vanilla_Perks()
			
			local function Crew_chief_updates()
				-- new inspire buff
				self.values.player.passive_inspire_range_mul = {
					1.25
				}
			end
			Crew_chief_updates()
			
			local function Rogue_updates()
				-- extra 15% move speed. basic variant is given by parkour skill in vanilla, but now it's at perk card #8. this skill is added at #9, so no conflicts
				self.values.player.movement_speed_multiplier = {
					1.1,
					1.25
				}
				-- extra 25% stamina
				self.values.player.stamina_multiplier = {
					1.25
				}
			end
			Rogue_updates()
			
			local function Hitman_updates()
				-- legacy upgrade that paused armor regen. not the worst idea, but just boring.
				self.values.temporary.player_new_hitman_regen = {
					{
						0.25, -- % of the base recovery timer that is used for the actual duration
						0.5, -- default duration
					}
				}
				-- new "death dance" combo skill
				self.values.temporary.death_dance_combo_invulnerability = {
					{
						10, -- base duration
						30 -- CD. begins at the same time as the effect
					}
				}
				-- new akimbo recovery proc from akimbos/pistols/smgs. yes it didnt have secondary smg's initialy, thus the name
				self.values.temporary.akimbo_pistol_armor_regen_timer_multiplier = {
					{
						0.75, -- 25% armor recovery
						10 -- for 10 secs
					}
				}
				-- new bounty hunter system. duration is for the bonus you get after you secure the kill.
				self.values.temporary.player_bounty_hunter = {
					{
						true,
						30 -- do not update without touching up playermanager file, since values there are hard coded to this value right now. should fix this later
					}
				}
				-- new melee/non-explosive throwable kill armor regen. amount is determined in playermanager, cooldown here
				self.values.temporary.badass_hitman_kill_armor_regen = {
					{
						true,
						0.01 -- no longer has a cooldown, since having 1 sec cooldown is pointless, because most weapons that trigger this skill already have ~1sec delay in-between uses, and having longer then 1 sec CD feels like shit
					}
				}
			end
			Hitman_updates()
			
			local function Burglar_updates()
				---- BURGLAR
				-- stelf buffs
				self.values.player.corpse_dispose_speed_multiplier = {
					0.75
				}
				self.values.player.pick_lock_speed_multiplier = {
					0.75
				}
				self.values.player.alarm_pager_speed_multiplier = {
					0.75
				}
				-- new supressor buff, firs value is used by silencer skill. this upgrade is now incremental, so they add up if combined
				self.values.player.silencer_concealment_increase = {
					1,
					3
				}
			end
			Burglar_updates()
			
			local function Infil_Socio_updates()
				-- dmg boosts adjusted for new melee stats. now a 2x bonus instead of 10x
				self.values.melee.stacking_hit_damage_multiplier = {
					1,
					1
				}
				-- adjusted hidden (more like forgotten to be added to descriptions) infiltrator duration buff to be present on both decks, but made it shorter
				self.values.melee.stacking_hit_expire_t = {
					4
				}
				-- overdog - 1st card dmg reduction duration and amount compensation for new activation rules and dmg resist
				self.values.temporary.dmg_dampener_outnumbered_strong = {
					{
						0.9,
						5
					}
				}
				-- INFILTRATOR's dmg reduction duration nerf to compensate for new activation rules and new dmg resist stacking math
				self.values.temporary.dmg_dampener_close_contact = {
					{
						0.92,
						5
					},
					{
						0.85,
						5
					},
					{
						0.78,
						5
					}
				}
			end
			Infil_Socio_updates()
			
			local function Gambler_updates()
				-- Almost complete rework.
				-- health regen. re-wrote values because basic multiplier system is just confusing for no reason (other then 1 that i removed) on the backend
				self.loose_ammo_restore_health_values = {
					{
						0,
						8
					},
					{
						8,
						16
					},
					{
						16,
						24
					},
					multiplier = 0.1,
					cd = 4,
					base = 16
				}
				-- add values from above into a proper upgrade table and make new skills out of them. copy of vanilla set up
				self.values.temporary.loose_ammo_restore_health = {}
				for i, data in ipairs(self.loose_ammo_restore_health_values) do
					local base = self.loose_ammo_restore_health_values.base

					table.insert(self.values.temporary.loose_ammo_restore_health, {
						{
							base + data[1],
							base + data[2]
						},
						self.loose_ammo_restore_health_values.cd
					})
				end
				-- adjusted cooldown to be in sync with ammo pick up, both are at 4 secs now
				self.values.temporary.loose_ammo_give_team = {
					{
						true,
						4
					}
				}
				-- new gambling (cause, you know, GAMBLER perk) system, hells ye. neutral chance is calculated as 1-(addition)-(removal)
				self.values.player.loose_ammo_restore_health_chances = {
					{
						addition_chance = 0.7,
						removal_chance = 0.15,
						addition_jackpot_chance = 0.2,
						removal_jackpot_chance = 0.1
					}
				}
				-- dodge values for new galmbling system
				self.values.player.loose_ammo_add_dodge_amount = {
					{
						addition_min = 0.02,
						addition_max = 0.08,
						removal_min = -0.04,
						removal_max = -0.16,
						addition_jackpot = 0.35,
						removal_jackpot = -0.35
					}
				}
			end
			Gambler_updates()
			
			local function Grinder_updates()
				-- buffed ap chances a bit to make them more viable with new silencer skills
				self.values.player.armor_piercing_chance = {
					0.1,
					0.35
				}
			end
			Grinder_updates()
			
			local function Yakuza_updates()
				-- this upgrade adds both suppression and AP resistance cause im lazy.
				self.values.player.yakuza_suppression_resist = {
					true
				}
				self.values.player.yakuza_behind_player_resist = {
					0.75,
				}
			end
			Yakuza_updates()
			
			local function Ex_President_updates()
				-- new 9th card - store armor recovery, similar to health
				self.values.player.store_armor_recovery_bonus_timer = {
					1
				}
				-- new 9th card - armor type based amount of recovery
				self.values.player.body_armor.skill_store_armor_recovery_bonus_timer = {
					0.25,
					0.2,
					0.18,
					0.16,
					0.12,
					0.08,
					0.04
				}
				-- armor health storage values. completely new to get new breakpoints accounting for new "shield" system
				self.values.player.body_armor.skill_max_health_store = {
					14.5,
					9.5,
					8.67,
					6,
					6,
					5.5,
					3.5
				}
				-- new 5th card static dodge bonus replacing old 15% dodge. this only effectively hurts 2 piece suit, while all other armors are buffed.
				-- yes, ICTV is favoured heavily for DS, but this is not the perk balance issue, but a difficulty balance issue
				self.values.player.static_dodge_chance = {
					0.2
				}
				-- new health "shield" system from stored health. originaly stored health took this much more dmg before damage was applies to health
				-- but this was both confusing, and unnecessarily harsh, so now it no longer gets multiplied.
				self.values.player.armor_health_store_shield = {
					1.5
				}
			end
			Ex_President_updates()
			
			local function Maniac_updates()
				-- new values that deplete faster from max possible to keep player on edge. we are a cocaine addict afterall
				-- max dmg per tick we can add
				self.max_cocaine_stacks_per_tick = 120
				-- tick length
				self.cocaine_stacks_tick_t = 1.5
				-- passive decay. correction: no longer passive. now will only deplete if no damage was dealt for this duration
				self.cocaine_stacks_decay_t = 3
				-- yes
				self.cocaine_stacks_decay_amount_per_tick = 80
				self.cocaine_stacks_decay_percentage_per_tick = 0.2
			end
			Maniac_updates()
			
			local function Anarchist_updates()
				-- new passive regeneration. revered values for ICTV and suit, to give ICTV best gating.
				-- this was done to make anarchist more expensive (skills wise) to run if you want best gating on DS
				-- or you can run the suit and gain more armor per minute then ICTV, which is more viable for lower difficulties
				self.values.player.armor_grinding = {
					{
						{
							5,
							6
						},
						{
							2.35,
							4
						},
						{
							2.05,
							3.5
						},
						{
							1.75,
							3
						},
						{
							1.125,
							2.25
						},
						{
							1,
							2
						},
						{
							0.875,
							1.75
						}
					}
				}
				-- 9th card armor gain from damage. overkill originaly meant to have different values based on armor, but later this was simplified.
				-- i brought this back, but also had to add UI to the armor panel to make this make sense.
				-- overall idea is same as with skill above - more armor, more often you can regen, but gain is lower both per instance and per minute
				self.values.player.damage_to_armor = {
					{
						{
							7.5,
							3
						},
						{
							4.5,
							2
						},
						{
							4.5,
							2
						},
						{
							4.5,
							2
						},
						{
							3,
							1.5
						},
						{
							3,
							1.5
						},
						{
							1.875,
							1.25
						}
					}
				}
			end
			Anarchist_updates()
			
			local function Biker_updates()
				-- biker new regen stacking pause
				-- used as reference for default delay
				self.values.player.wild_temporary_regen_pause_default = {
					1
				}
				-- actual delay. this was set up in such way because this skill can sometimes have lower duration based on health/armor. logic is setup in playermanager
				self.values.temporary.player_wild_temporary_regen_pause = {
					{
						true,
						1
					}
				}
			end
			Biker_updates()
			
			local function Stoic_updates()
				-- 1st card
				self.values.player.damage_control_passive = {
					{
						70,
						10
					}
				}
				-- 7th card
				self.values.player.damage_control_cooldown_drain = {
					{
						0,
						1
					},
					{
						45,
						1.5
					}
				}
				-- 9th card
				self.values.player.damage_control_healing = {
					60
				}
			end
			Stoic_updates()
			
			local function Tag_team_updates()
				-- range biff
				self.values.player.tag_team_base.distance = 24
				-- 1.3 -> 1.7
				self.values.player.tag_team_base.kill_extension = 1.7
				-- make it maxed faster
				self.values.player.tag_team_damage_absorption = {
					{
						kill_gain = 0.4,
						max = 3.2
					}
				}
			end
			Tag_team_updates()
			
			local function Hacker_updates()
				-- PECM jammer longer feedback
				-- BEWARE: duration lasts for 12/6 seconds based on game state (loud/stealth), code for that is in playermanager.lua
				self.values.player.pocket_ecm_jammer_base[1].duration = 12
				-- PECM jammer less cooldown on kill;
				self.values.player.pocket_ecm_jammer_base[1].cooldown_drain = 4
				-- heal from self during PECM - 1.5x the amount to compensate lower activation frequency
				self.values.player.pocket_ecm_heal_on_kill = {
					3
				}
				-- temp dodge - now requires 3 kills to trigger and lasts for 50 secs instead of 20, to compensate lower activation frequency
				self.values.temporary.pocket_ecm_kill_dodge = {
					{
						0.2,
						50,
						3
					}
				}
			end
			Hacker_updates()
			
			local function Leech_updates()
				-- № of segments
				self.values.player.copr_static_damage_ratio = {
					0.25, -- 4
					0.2 -- 5
				}
				-- heal on ampule activation. slight buff to compensate longer CD
				self.values.player.copr_activate_bonus_health_ratio = {
					0.5
				}
				-- new invulnerability skill. gained upon loosing any amount of segments
				self.values.temporary.copr_invuln_on_segment_loss = {
					{
						true,
						1
					}
				}
				-- increased amount of self heal during invuln period per kill
				self.values.player.copr_heal_during_invuln_increase = {
					2
				}
				-- gain x seconds when either self is revived by any means other than ampule, on when revived another player
				self.values.player.copr_regain_cooldown_on_revives = {
					10
				}
				-- longer basic CD
				self.copr_ability_cooldown = 60
				-- increased CD return on kill
				self.values.player.copr_speed_up_on_kill = {
					1
				}
				-- reduced damage threshold to loose 2 segments at once, to avoid allowing player to run dmg resistance skills to get to this amount
				self.copr_high_damage_multiplier = {
					15,
					2
				}
			end
			Leech_updates()
			
			local function Copycat_updates()
				-- 7th card CD nerf from 15 to 20, because this card was fixed to only activate invlun if armor is <0
				self.values.temporary.mrwi_health_invulnerable = {
					{
						0.5,
						2,
						20
					}
				}
				-- first 4 choise cards health boost 20%->15% to make certain 9th card choises more impactfull
				local health_boost = 0.15
				self.values.player.mrwi_health_multiplier = {
					1 + health_boost * 1,
					1 + health_boost * 2,
					1 + health_boost * 3,
					1 + health_boost * 4
				}
				local ammo_multiplier = 0.075
				self.values.player.mrwi_ammo_supply_multiplier = {
					1 + ammo_multiplier * 1,
					1 + ammo_multiplier * 2,
					1 + ammo_multiplier * 3,
					1 + ammo_multiplier * 4
				}
				-- used in some perks to identify the fact of usage of 9th Copy card to reduce certain effects
				self.values.player.copycat_9th_card_identifier = {
					true
				}
			end
			Copycat_updates()
			
		end
		New_Vanilla_Perks()
		
		local function New_Custom_Perks()
			
			local function Brawler_updates()
				self.values.player.extra_ammo_cut = {
					0.2
				}
				self.values.player.passive_armor_movement_penalty_multiplier = {
					0.75,
					0.5,
					0.25
				}
				self.values.player.damage_resist_brawler = {
					0.95,
					0.9,
					0.8
				}
				self.values.player.stamina_on_melee_kill_brawler = {
					0.05
				}
				self.values.player.armor_regen_brawler = {
					true
				}
				self.values.player.damage_resist_faraway_brawler = { -- legacy
					true
				}
				self.values.player.damage_resist_teammates_brawler = {
					{
						absorption = 0,
						resist = 0.96
					}
				}
			end
			Brawler_updates()
			
			local function Speed_Junkie_updates()
				self.values.player.speed_junkie_meter = {
					true
				}
				self.values.player.pause_armor_recovery_when_moving = {
					true
				}
				self.values.player.speed_junkie_stamina_on_kill = {
					0.05
				}
				self.values.player.speed_junkie_meter_on_kill = {
					10
				}
				self.values.temporary.player_speed_junkie_armor_on_dodge = {
					{
						1.5, -- amount
						1, -- cooldown
					}
				}
				self.values.player.speed_junkie_armor_berserk = {
					0.25
				}
				self.values.player.speed_junkie_meter_boost_agility = {
					{
						reload = 1.4,
						swap_speed = 2,
						interaction = 1.4
					}
				}
			end
			Speed_Junkie_updates()
			
			local function Guardian_updates()
				---- Guardian deck stuff
				self.values.player.guardian_movement_penalty = {
					0.8
				}
				self.values.player.guardian_interaction_speed_penalty = {
					1.5
				}
				self.values.player.guardian_armor_remover = {
					true
				}
				self.values.player.guardian_area_passive = {
					true
				}
				self.values.player.guardian_area_range = {
					300,
					500
				}
				self.values.player.guardian_area_passive_activation_timer = {
					5,
					3
				}
				self.values.player.guardian_area_passive_health_regen = {
					1,
					2,
					3
				}
				self.values.player.guardian_damage_clamp_inside_1 = {
					{
						minimum = 8,
						maximum = 16,
					}
				}
				self.values.player.guardian_damage_clamp_outside_1 = {
					{
						minimum = 10,
						maximum = 20,
					}
				}
				self.values.player.guardian_damage_clamp_inside_2 = {
					{
						minimum = 6,
						maximum = 12,
					}
				}
				self.values.player.guardian_damage_clamp_outside_2 = {
					{
						minimum = 8,
						maximum = 16,
					}
				}
				self.values.player.passive_health_multiplier = {
					1.1,
					1.2,
					1.4,
					1.8,
					2,
					2.5
				}
				-- for 10 points of armor you get a chance multiplier for ricochet. so for 216 armor with current mul you get 21 x 3 = 63%
				self.values.player.guardian_heavy_armor_ricochet = {
					3
				}
				self.values.player.guardian_activate_area_on_kill = {
					true
				}
				self.values.player.guardian_auto_ammo_pickup_on_kill = {
					true
				}
				self.values.player.guardian_health_on_kill = {
					2
				}
				self.values.player.guardian_reduce_equipment_heal = {
					0.5
				}
			end
			Guardian_updates()
			
		end
		New_Custom_Perks()
		
	end
	New_Perks()
	
end)

-- copycat skill asignments
function UpgradesTweakData.mrwi_deck9_options_gilza_update()
	local deck9_options = {
		{ -- CC
			tree = 1,
			tier = 1,
			desc_id = "menu_deck23_9_crew_chief_desc",
			upgrades = {
				"team_passive_stamina_multiplier_1",
				"player_passive_intimidate_range_mul",
				"player_damage_dampener_close_contact_1",
				"player_passive_inspire_range_mul"
			},
			icon_xy = {
				0,
				1
			}
		},
		{ -- MUSCLE
			tree = 2,
			tier = 1,
			desc_id = "menu_deck23_9_muscle_desc",
			upgrades = {
				"player_passive_health_multiplier_2",
				"player_passive_health_regen"
			},
			icon_xy = {
				4,
				1
			}
		},
		{ -- ARMORER
			desc_id = "menu_deck23_9_armorer_desc",
			tier = 1,
			tree = 3,
			upgrades = {
				"temporary_armor_break_invulnerable_1",
				"temporary_armor_break_invulnerable_2"
			},
			icon_xy = {
				0,
				2
			}
		},
		{ -- ROGUE
			tree = 4,
			tier = 1,
			desc_id = "menu_deck23_9_rogue_desc",
			upgrades = {
				"player_crouch_dodge_chance_1",
			},
			icon_xy = {
				5,
				2
			}
		},
		{ -- HITMAN
			tree = 5,
			tier = 1,
			desc_id = "menu_deck23_9_hitman_desc",
			upgrades = {
				"akimbo_recoil_index_addend_4",
				"akimbo_extra_ammo_multiplier_2",
				"temporary_akimbo_pistol_armor_regen_timer_multiplier"
			},
			icon_xy = {
				3,
				3
			}
		},
		{ -- CROOK
			tree = 6,
			tier = 3,
			desc_id = "menu_deck23_9_crook_desc",
			upgrades = {
				"weapon_passive_armor_piercing_chance_maxed",
			},
			icon_xy = {
				6,
				2
			}
		},
		{ -- BURGLAR
			desc_id = "menu_deck23_9_burglar_desc",
			name_id = "menu_st_spec_7",
			upgrades = {
				"player_level_2_dodge_addend_1",
				"player_level_2_dodge_addend_2",
				"player_silencer_concealment_increase_2",
				"player_alarm_pager_speed_multiplier",
				"player_stand_still_crouch_camouflage_bonus_1",
			},
			icon_xy = {
				2,
				4
			}
		},
		{ -- INFIL
			tier = 9,
			tree = 8,
			desc_id = "menu_deck23_9_infil_desc",
			upgrades = {
				"melee_stacking_hit_damage_multiplier_1",
				"melee_stacking_hit_expire_t"
			}
		},
		{ -- SOCIO
			tree = 9,
			tier = 3,
			icon_xy = {
				3,
				5
			}
		},
		{ -- GAMBLER
			tree = 10,
			desc_id = "menu_deck23_9_gambler_desc",
			tier = 1,
			icon_xy = {
				0,
				6
			},
			upgrades = {
				"temporary_loose_ammo_give_team"
			}
		},
		{ -- GRINDER
			desc_id = "menu_deck23_9_grinder_desc",
			tier = 1,
			tree = 11,
			upgrades = {
				"player_damage_to_hot_2"
			},
			icon_xy = {
				5,
				6
			}
		},
		{ -- YAKUZA
			tree = 12,
			tier = 3,
			desc_id = "menu_deck23_9_yakuza_desc",
			upgrades = {
				"player_yakuza_suppression_resist",
				"player_movement_speed_damage_health_ratio_threshold_multiplier"
			},
			icon_xy = {
				2,
				7
			}
		},
		{ -- EX-PRES
			desc_id = "menu_deck23_9_expres_desc",
			tier = 3,
			tree = 13,
			upgrades = {
				"player_armor_health_store_amount_1"
			},
			icon_xy = {
				7,
				7
			}
		},
		{ -- MANIAC
			desc_id = "menu_deck23_9_maniac_desc",
			tier = 3,
			tree = 14,
			upgrades = {
				"player_cocaine_stacking_1"
			},
			icon_xy = {
				0,
				1
			}
		},
		{ -- ANARCHIST
			tree = 15,
			tier = 1,
			upgrades = {
				"temporary_armor_break_invulnerable_2",
				"temporary_armor_break_invulnerable_3"
			},
			desc_id = "menu_deck23_9_anarchist_desc",
			icon_xy = {
				0,
				1
			}
		},
		{ -- BIKER
			texture_bundle_folder = "wild",
			name_id = "menu_st_spec_16",
			upgrades = {
				"player_wild_health_amount_1",
				"player_wild_armor_amount_1",
				"player_wild_temporary_regen_pause"
			},
			icon_xy = {
				0,
				1
			},
			desc_id = "menu_deck23_9_biker_desc",
		},
		{ -- KINGPIN
			tree = 17,
			tier = 1,
			icon_xy = {
				0,
				1
			}
		},
		{ -- SICARIO
			tree = 18,
			tier = 1,
			icon_xy = {
				0,
				1
			}
		},
		{ -- STOIC
			tree = 19,
			tier = 1,
			desc_id = "menu_deck23_9_stoic_desc",
			icon_xy = {
				0,
				1
			}
		},
		{ -- TAG TEAM
			tree = 20,
			tier = 1,
			icon_xy = {
				0,
				1
			}
		},
		{ -- HACKER
			tree = 21,
			tier = 1,
			icon_xy = {
				0,
				1
			}
		},
		{ -- LEECH
			tree = 22,
			tier = 1,
			desc_id = "menu_deck23_9_leech_desc",
			upgrades = {
				"player_copr_regain_cooldown_on_revives",
			},
			icon_xy = {
				1,
				1
			}
		},
		{ -- BRAWLER
			tree = 24,
			tier = 9,
			desc_id = "menu_deck23_9_brawler_desc",
		},
		{ -- JUNKIE
			texture_bundle_folder = "Gilza",
			icon_xy = {
				1,
				1
			},
			name_id = "menu_deck23_9_junkie",
			desc_id = "menu_deck23_9_junkie_desc",
			upgrades = {
				"player_speed_junkie_meter",
				"player_pause_armor_recovery_when_moving",
			},
		},
		{ -- GUARDIAN
			texture_bundle_folder = "Gilza_guardian",
			name_id = "menu_deck23_9_guardian",
			desc_id = "menu_deck23_9_guardian_desc",
			icon_xy = {
				0,
				1
			},
			upgrades = {
				"player_guardian_interaction_speed_penalty",
				"player_guardian_movement_penalty",
				"player_guardian_area_passive",
				"player_guardian_area_range_1",
				"player_guardian_area_passive_activation_timer_1",
				"player_guardian_area_passive_health_regen_1",
				"player_guardian_area_passive_health_regen_2",
			},
		}
	}
	
	return deck9_options
end

Hooks:PostHook(UpgradesTweakData, "_player_definitions", "Gilza_skill_definitions_1", function(self)	
	
	---- MASTERMIND
	local function New_Mastermind_definitions()
		-- new self heal on ally revive interaction
		self.definitions.player_revive_action_self_heal = {
			name_id = "menu_player_revive_action_self_heal",
			category = "feature",
			upgrade = {
				value = 1,
				upgrade = "revive_action_self_heal",
				category = "player"
			}
		}
		-- 1st tier acc bonus
		self.definitions.player_weapon_accuracy_increase_2 = {
			name_id = "menu_player_weapon_accuracy_increase",
			category = "feature",
			upgrade = {
				value = 2,
				upgrade = "weapon_accuracy_increase",
				category = "player"
			}
		}
		-- new stuff
		self.definitions.player_less_start_recoil = {
			name_id = "menu_player_less_start_recoil",
			category = "feature",
			upgrade = {
				value = 1,
				upgrade = "less_start_recoil",
				category = "player"
			}
		}
		self.definitions.player_less_start_recoil_2 = {
			name_id = "menu_player_less_start_recoil_2",
			category = "feature",
			upgrade = {
				value = 2,
				upgrade = "less_start_recoil",
				category = "player"
			}
		}
		self.definitions.player_less_start_recoil_for_longer = {
			name_id = "menu_player_less_start_recoil_for_longer",
			category = "feature",
			upgrade = {
				value = 1,
				upgrade = "less_start_recoil_for_longer",
				category = "player"
			}
		}
		-- bipod skill pt1
		self.definitions.player_not_moving_damage_reduction_bonus_1 = {
			name_id = "player_not_moving_damage_reduction_bonus",
			category = "feature",
			upgrade = {
				value = 1,
				upgrade = "not_moving_damage_reduction_bonus",
				category = "player"
			}
		}
		-- bipod skill pt2
		self.definitions.player_not_moving_damage_reduction_bonus_bipoded = {
			name_id = "player_not_moving_damage_reduction_bonus_bipoded",
			category = "feature",
			upgrade = {
				value = 1,
				upgrade = "not_moving_damage_reduction_bonus_bipoded",
				category = "player"
			}
		}
		-- 3
		self.definitions.player_bipod_deploy_speed = {
			name_id = "menu_player_bipod_deploy_speed",
			category = "feature",
			upgrade = {
				value = 1,
				upgrade = "bipod_deploy_speed",
				category = "player"
			}
		}
		-- new bodyshot kill reload
		self.definitions.player_single_body_shot_kill_reload = {
			name_id = "menu_player_single_body_shot_kill_reload",
			category = "temporary",
			upgrade = {
				value = 1,
				upgrade = "single_body_shot_kill_reload",
				category = "temporary"
			}
		}
		-- new bodyshot kill refill
		self.definitions.player_single_body_shot_kill_refill_ammo_1 = {
			name_id = "menu_player_single_body_shot_kill_refill_ammo_1",
			category = "feature",
			upgrade = {
				value = 1,
				upgrade = "single_body_shot_kill_refill_ammo",
				category = "player"
			}
		}
		self.definitions.player_single_body_shot_kill_refill_ammo_2 = {
			name_id = "menu_player_single_body_shot_kill_refill_ammo_2",
			category = "feature",
			upgrade = {
				value = 2,
				upgrade = "single_body_shot_kill_refill_ammo",
				category = "player"
			}
		}
	end
	New_Mastermind_definitions()
	
	---- ENFORCER
	local function New_Enforcer_definitions()
		-- fearmonger
		self.definitions.player_speed_boost_on_panic_kill = {
			name_id = "menu_player_speed_boost_on_panic_kill",
			category = "temporary",
			upgrade = {
				value = 1,
				upgrade = "speed_boost_on_panic_kill",
				category = "temporary"
			}
		}
		-- yea
		self.definitions.player_sprint_any_bag = {
			category = "feature",
			name_id = "menu_player_sprint_any_bag",
			upgrade = {
				category = "player",
				upgrade = "sprint_any_bag",
				value = 1
			}
		}
		self.definitions.player_headshot_regen_armor_shorter_cooldown = {
			category = "feature",
			name_id = "menu_player_headshot_regen_armor_shorter_cooldown",
			upgrade = {
				category = "player",
				upgrade = "headshot_regen_armor_shorter_cooldown",
				value = 1
			}
		}
		-- ye
		self.definitions.player_saw_ammo_pick_up = {
			name_id = "saw_ammo_pick_up",
			category = "feature",
			upgrade = {
				value = 1,
				upgrade = "saw_ammo_pick_up",
				category = "player"
			}
		}
		-- new fully loaded aced, #1 used for perk deck card #8 (or 6?)
		self.definitions.player_regain_throwable_from_ammo_2 = {
			incremental = true,
			name_id = "menu_player_regain_throwable_from_ammo",
			category = "feature",
			upgrade = {
				value = 2,
				upgrade = "regain_throwable_from_ammo",
				category = "player"
			}
		}
	end
	New_Enforcer_definitions()
	
	---- TECHNICIAN
	local function New_Technician_definitions()
		-- new gun oil skill
		self.definitions.player_ar_smg_lmg_rof_increase_1 = {
			name_id = "menu_player_ar_smg_lmg_rof_increase_1",
			category = "feature",
			upgrade = {
				value = 1,
				upgrade = "ar_smg_lmg_rof_increase",
				category = "player"
			}
		}
		self.definitions.player_ar_smg_lmg_rof_increase_2 = {
			name_id = "menu_player_ar_smg_lmg_rof_increase_2",
			category = "feature",
			upgrade = {
				value = 2,
				upgrade = "ar_smg_lmg_rof_increase",
				category = "player"
			}
		}
		-- more drill repair speed for kickstarter aced
		self.definitions.player_drill_fix_interaction_speed_multiplier_2 = {
			name_id = "menu_player_drill_fix_interaction_speed_multiplier_2",
			category = "feature",
			upgrade = {
				value = 2,
				upgrade = "drill_fix_interaction_speed_multiplier",
				category = "player"
			}
		}
		-- tier 1 recoil
		self.definitions.player_stability_increase_bonus_3 = {
			incremental = true,
			name_id = "menu_player_stability_increase_bonus",
			category = "feature",
			upgrade = {
				value = 1,
				upgrade = "stability_increase_bonus_2",
				category = "player"
			}
		}
		-- twice
		self.definitions.player_stability_increase_bonus_4 = {
			incremental = true,
			name_id = "menu_player_stability_increase_bonus",
			category = "feature",
			upgrade = {
				value = 2,
				upgrade = "stability_increase_bonus_2",
				category = "player"
			}
		}
		-- new recoil negation
		self.definitions.player_hipfire_less_recoil = {
			name_id = "player_hipfire_less_recoil",
			category = "feature",
			upgrade = {
				value = 1,
				upgrade = "hipfire_less_recoil",
				category = "player"
			}
		}
		-- new acc negation
		self.definitions.player_hipfire_no_accuracy_penalty = {
			name_id = "player_hipfire_no_accuracy_penalty",
			category = "feature",
			upgrade = {
				value = 1,
				upgrade = "hipfire_no_accuracy_penalty",
				category = "player"
			}
		}
		-- new AP, used in surefire
		self.definitions.player_ap_bullets_basic = {
			name_id = "player_ap_bullets_basic",
			category = "feature",
			upgrade = {
				value = 1,
				upgrade = "ap_bullets_basic",
				category = "player"
			}
		}
		-- new AP, used in BE
		self.definitions.player_ap_bullets_aced = {
			name_id = "player_ap_bullets_aced",
			category = "feature",
			upgrade = {
				value = 1,
				upgrade = "ap_bullets_aced",
				category = "player"
			}
		}
		-- BE ammo pick up penalty - legacy
		self.definitions.player_pick_up_ammo_reduction_1 = {
			name_id = "menu_player_pick_up_ammo_reduction_1",
			category = "feature",
			upgrade = {
				value = 1,
				upgrade = "pick_up_ammo_reduction",
				category = "player"
			}
		}
		-- 2
		self.definitions.player_pick_up_ammo_reduction_2 = {
			name_id = "menu_player_pick_up_ammo_reduction_2",
			category = "feature",
			upgrade = {
				value = 2,
				upgrade = "pick_up_ammo_reduction",
				category = "player"
			}
		}
		-- yea
		self.definitions.player_sentry_proximity_damage_resist = {
			name_id = "menu_player_sentry_proximity_damage_resist",
			category = "feature",
			upgrade = {
				value = 1,
				upgrade = "sentry_proximity_damage_resist",
				category = "player"
			}
		}
		-- ye
		self.definitions.player_sentry_kills_refill_ammo = {
			name_id = "menu_player_sentry_kills_refill_ammo",
			category = "feature",
			upgrade = {
				value = 1,
				upgrade = "sentry_kills_refill_ammo",
				category = "player"
			}
		}
	end
	New_Technician_definitions()
	
	---- GHOST
	local function New_Ghost_definitions()
		self.definitions.player_extra_jump_height = {
			name_id = "extra_jump_height",
			category = "feature",
			upgrade = {
				value = 1,
				upgrade = "extra_jump_height",
				category = "player"
			}
		}
		self.definitions.player_limited_fall_damage_immunity = {
			name_id = "menu_player_limited_fall_damage_immunity",
			category = "feature",
			upgrade = {
				value = 1,
				upgrade = "limited_fall_damage_immunity",
				category = "player"
			}
		}
		self.definitions.player_tased_electric_bullets = {
			name_id = "menu_player_tased_electric_bullets",
			category = "temporary",
			upgrade = {
				value = 1,
				upgrade = "tased_electric_bullets",
				category = "temporary"
			}
		}
		-- new tier 4
		self.definitions.player_dodge_armor_regen_1 = {
			name_id = "menu_player_dodge_armor_regen_1",
			category = "temporary",
			upgrade = {
				value = 1,
				upgrade = "player_dodge_armor_regen",
				category = "temporary"
			}
		}
		-- 2ice
		self.definitions.player_dodge_armor_regen_2 = {
			name_id = "menu_player_dodge_armor_regen_2",
			category = "temporary",
			upgrade = {
				value = 2,
				upgrade = "player_dodge_armor_regen",
				category = "temporary"
			}
		}
	end
	New_Ghost_definitions()
	
	---- FUGITIVE
	local function New_Fugitive_definitions()
		-- botomless pockets basic
		self.definitions.player_secondary_weapons_pickup_bonus = {
			name_id = "menu_player_secondary_weapons_pickup_bonus",
			category = "feature",
			upgrade = {
				value = 1,
				upgrade = "secondary_weapons_pickup_bonus",
				category = "player"
			}
		}
		-- aced
		self.definitions.player_pistols_and_smgs_pick_up_increase = {
			name_id = "menu_player_pistols_and_smgs_pick_up_increase",
			category = "feature",
			upgrade = {
				value = 1,
				upgrade = "pistols_and_smgs_pick_up_increase",
				category = "player"
			}
		}
		-- up you go
		self.definitions.player_revived_health_regain_V2 = {
			name_id = "revived_health_regain_V2",
			category = "feature",
			upgrade = {
				value = 1,
				upgrade = "health_regain_V2",
				category = "player"
			}
		}
		-- messiah basic buff
		self.definitions.player_bleed_out_health_multiplier_2 = {
			name_id = "menu_player_bleed_out_health_multiplier_2",
			category = "feature",
			upgrade = {
				value = 2,
				upgrade = "bleed_out_health_multiplier",
				category = "player"
			}
		}
		-- camera shake on melee hits
		self.definitions.player_melee_shake_reduction_1 = {
			name_id = "menu_player_melee_shake_reduction_1",
			category = "feature",
			upgrade = {
				value = 1,
				upgrade = "melee_shake_reduction",
				category = "player"
			}
		}
		self.definitions.player_melee_shake_reduction_2 = {
			name_id = "menu_player_melee_shake_reduction_2",
			category = "feature",
			upgrade = {
				value = 2,
				upgrade = "melee_shake_reduction",
				category = "player"
			}
		}
		-- hell yeaaaa
		self.definitions.player_melee_sprint = {
			name_id = "menu_player_melee_sprint",
			category = "feature",
			upgrade = {
				value = 1,
				upgrade = "melee_sprint",
				category = "player"
			}
		}
		self.definitions.player_melee_faster_charge = {
			name_id = "menu_player_melee_faster_charge",
			category = "feature",
			upgrade = {
				value = 1,
				upgrade = "melee_faster_charge",
				category = "player"
			}
		}
		-- passive melee dmg increase from berserk
		self.definitions.player_melee_damage_newzerk_addin = {
			name_id = "melee_damage_newzerk_addin",
			category = "feature",
			upgrade = {
				value = 1,
				upgrade = "melee_damage_newzerk_addin",
				category = "player"
			}
		}
		-- new zerk - melee
		self.definitions.player_new_berserk_melee_damage_multiplier_1 = {
			name_id = "menu_player_new_berserk_melee_damage_multiplier_1",
			category = "temporary",
			upgrade = {
				value = 1,
				upgrade = "new_berserk_melee_damage_multiplier_1",
				category = "temporary"
			}
		}
		-- new zerk - firearms
		self.definitions.player_new_berserk_weapon_damage_multiplier = {
			name_id = "menu_player_new_berserk_weapon_damage_multiplier",
			category = "temporary",
			upgrade = {
				value = 1,
				upgrade = "new_berserk_weapon_damage_multiplier",
				category = "temporary"
			}
		}
		-- CD is seperate to track both temp effects
		self.definitions.player_new_berserk_weapon_damage_multiplier_cooldown = {
			name_id = "menu_player_new_berserk_weapon_damage_multiplier_cooldown",
			category = "temporary",
			upgrade = {
				value = 1,
				upgrade = "new_berserk_weapon_damage_multiplier_cooldown",
				category = "temporary"
			}
		}
	end
	New_Fugitive_definitions()
	
	---- PERKS
	local function New_Perk_definitions()
		
		-- neutral card #6(or 8?) throwble pickup
		self.definitions.player_regain_throwable_from_ammo_1 = {
			incremental = true,
			name_id = "menu_player_regain_throwable_from_ammo",
			category = "feature",
			upgrade = {
				value = 1,
				upgrade = "regain_throwable_from_ammo",
				category = "player"
			}
		}
		
		local function New_Vanilla_Perk_definitions()
			
			local function CrewChief_definitions()
				self.definitions.player_passive_inspire_range_mul = {
					name_id = "menu_player_passive_inspire_range_mul",
					category = "feature",
					upgrade = {
						value = 1,
						upgrade = "passive_inspire_range_mul",
						category = "player"
					}
				}
			end
			CrewChief_definitions()
			
			local function Rogue_definitions()
				self.definitions.player_movement_speed_multiplier_2 = {
					incremental = true,
					name_id = "menu_player_movement_speed_multiplier",
					category = "feature",
					upgrade = {
						value = 2,
						upgrade = "movement_speed_multiplier",
						category = "player"
					}
				}
			end
			Rogue_definitions()
			
			local function Hitman_definitions()
				-- legacy
				self.definitions.player_new_hitman_regen = {
					name_id = "menu_player_new_hitman_regen",
					category = "temporary",
					upgrade = {
						value = 1,
						upgrade = "player_new_hitman_regen",
						category = "temporary"
					}
				}
				self.definitions.temporary_death_dance_combo_invulnerability = {
					name_id = "menu_temporary_death_dance_combo_invulnerability",
					category = "temporary",
					upgrade = {
						value = 1,
						upgrade = "death_dance_combo_invulnerability",
						category = "temporary"
					}
				}
				self.definitions.temporary_akimbo_pistol_armor_regen_timer_multiplier = {
					name_id = "menu_temporary_akimbo_pistol_armor_regen_timer_multiplier",
					category = "temporary",
					upgrade = {
						value = 1,
						upgrade = "akimbo_pistol_armor_regen_timer_multiplier",
						category = "temporary"
					}
				}
				self.definitions.temporary_player_bounty_hunter = {
					name_id = "menu_temporary_player_bounty_hunter",
					category = "temporary",
					upgrade = {
						value = 1,
						upgrade = "player_bounty_hunter",
						category = "temporary"
					}
				}
				self.definitions.temporary_badass_hitman_kill_armor_regen = {
					name_id = "menu_temporary_badass_hitman_kill_armor_regen",
					category = "temporary",
					upgrade = {
						value = 1,
						upgrade = "badass_hitman_kill_armor_regen",
						category = "temporary"
					}
				}
			end
			Hitman_definitions()
			
			local function Crook_definitions()
				-- by "maxed" i mean 75% evidently. initialy was 100%
				self.definitions.weapon_passive_armor_piercing_chance_maxed = {
					name_id = "menu_weapon_passive_armor_piercing_chance_maxed",
					category = "feature",
					upgrade = {
						value = 2,
						upgrade = "armor_piercing_chance",
						category = "weapon"
					}
				}
			end
			Crook_definitions()
			
			local function Burglar_definitions()
				self.definitions.player_silencer_concealment_increase_1 = {
					incremental = true,
					name_id = "menu_player_silencer_concealment_increase",
					category = "feature",
					upgrade = {
						value = 1,
						upgrade = "silencer_concealment_increase",
						category = "player"
					}
				}
				self.definitions.player_silencer_concealment_increase_2 = {
					incremental = true,
					name_id = "menu_player_silencer_concealment_increase",
					category = "feature",
					upgrade = {
						value = 2,
						upgrade = "silencer_concealment_increase",
						category = "player"
					}
				}
			end
			Burglar_definitions()
			
			local function Yakuza_definitions()
				self.definitions.player_yakuza_suppression_resist = {
					name_id = "menu_player_yakuza_suppression_resist",
					category = "feature",
					upgrade = {
						value = 1,
						upgrade = "yakuza_suppression_resist",
						category = "player"
					}
				}
				self.definitions.player_yakuza_behind_player_resist = {
					name_id = "menu_player_yakuza_behind_player_resist",
					category = "feature",
					upgrade = {
						value = 1,
						upgrade = "yakuza_behind_player_resist",
						category = "player"
					}
				}
			end
			Yakuza_definitions()
			
			local function Ex_president_definitions()
				-- new 9th card
				self.definitions.player_store_armor_recovery_bonus_timer = {
					name_id = "menu_player_store_armor_recovery_bonus_timer",
					category = "feature",
					upgrade = {
						value = 1,
						upgrade = "store_armor_recovery_bonus_timer",
						category = "player"
					}
				}
				-- ICTV dodge lol
				self.definitions.player_static_dodge_chance = {
					name_id = "menu_player_static_dodge_chance",
					category = "feature",
					upgrade = {
						value = 1,
						upgrade = "static_dodge_chance",
						category = "player"
					}
				}
				-- new mechanic
				self.definitions.player_armor_health_store_shield = {
					name_id = "menu_player_armor_health_store_shield",
					category = "feature",
					upgrade = {
						value = 1,
						upgrade = "armor_health_store_shield",
						category = "player"
					}
				}
			end
			Ex_president_definitions()
			
			local function Gambler_definitions()
				-- range
				self.definitions.player_increased_pickup_area_1.incremental = true
				self.definitions.player_increased_pickup_area_2 = {
					name_id = "menu_player_increased_pickup_area",
					category = "feature",
					incremental = true,
					upgrade = {
						value = 2,
						upgrade = "increased_pickup_area",
						category = "player"
					}
				}
				self.definitions.temporary_loose_ammo_add_dodge = {
					name_id = "menu_temporary_loose_ammo_add_dodge",
					category = "temporary",
					upgrade = {
						value = 1,
						upgrade = "loose_ammo_add_dodge",
						category = "temporary"
					}
				}
				self.definitions.player_loose_ammo_restore_health_chances = {
					name_id = "menu_player_loose_ammo_restore_health_chances",
					category = "feature",
					upgrade = {
						value = 1,
						upgrade = "loose_ammo_restore_health_chances",
						category = "player"
					}
				}
				self.definitions.player_loose_ammo_add_dodge_amount = {
					name_id = "menu_player_loose_ammo_add_dodge_amount",
					category = "feature",
					upgrade = {
						value = 1,
						upgrade = "loose_ammo_add_dodge_amount",
						category = "player"
					}
				}
			end
			Gambler_definitions()
			
			local function Biker_definitions()
				self.definitions.player_wild_temporary_regen_pause = {
					name_id = "menu_player_wild_temporary_regen_pause",
					category = "temporary",
					upgrade = {
						value = 1,
						upgrade = "player_wild_temporary_regen_pause",
						category = "temporary"
					}
				}
			end
			Biker_definitions()
			
			local function Leech_definitions()
				self.definitions.temporary_copr_invuln_on_segment_loss = {
					name_id = "menu_temporary_copr_invuln_on_segment_loss",
					category = "temporary",
					upgrade = {
						value = 1,
						upgrade = "copr_invuln_on_segment_loss",
						category = "temporary"
					}
				}
				self.definitions.player_copr_heal_during_invuln_increase = {
					name_id = "menu_player_copr_heal_during_invuln_increase",
					category = "feature",
					upgrade = {
						value = 1,
						upgrade = "copr_heal_during_invuln_increase",
						category = "player"
					}
				}
				self.definitions.player_copr_regain_cooldown_on_revives = {
					name_id = "menu_player_copr_regain_cooldown_on_revives",
					category = "feature",
					upgrade = {
						value = 1,
						upgrade = "copr_regain_cooldown_on_revives",
						category = "player"
					}
				}
			end
			Leech_definitions()
			
			local function Copycat_definitions()
				-- new ammo buffs
				for i = 1, 4 do
					self.definitions["mrwi_ammo_supply_multiplier_" .. tostring(i)] = {
						incremental = true,
						name_id = "menu_mrwi_ammo_supply_multiplier",
						category = "feature",
						upgrade = {
							value = 1,
							upgrade = "mrwi_ammo_supply_multiplier",
							category = "player"
						}
					}
				end
				-- used to nerf some effects if detected
				self.definitions.player_copycat_9th_card_identifier = {
					name_id = "menu_player_copycat_9th_card_identifier",
					category = "feature",
					upgrade = {
						value = 1,
						upgrade = "copycat_9th_card_identifier",
						category = "player"
					}
				}
				-- new armorer/anarchist bonuses
				self.definitions.temporary_armor_break_invulnerable_3 = {
					name_id = "menu_temporary_armor_break_invulnerable",
					category = "temporary",
					upgrade = {
						value = 3,
						upgrade = "armor_break_invulnerable",
						category = "temporary"
					}
				}
				-- rogue new dodge chance
				self.definitions.player_passive_dodge_chance_5 = {
					name_id = "menu_player_run_dodge_chance",
					category = "feature",
					upgrade = {
						value = 5,
						upgrade = "passive_dodge_chance",
						category = "player"
					}
				}
			end
			Copycat_definitions()
			
		end
		New_Vanilla_Perk_definitions()
		
		local function New_Custom_Perk_definitions()
			
			local function Brawler_definitions()
				self.definitions.player_extra_ammo_cut = {
					name_id = "extra_ammo_cut",
					category = "feature",
					upgrade = {
						value = 1,
						upgrade = "extra_ammo_cut",
						category = "player"
					}
				}
				self.definitions.player_perk_armor_regen_timer_multiplier_6 = {
					name_id = "menu_player_perk_armor_regen_timer_multiplier",
					category = "feature",
					upgrade = {
						upgrade = "perk_armor_regen_timer_multiplier",
						category = "player",
						value = 6
					}
				}
				self.definitions.player_stamina_on_melee_kill_brawler = {
					name_id = "menu_player_stamina_on_melee_kill_brawler",
					category = "feature",
					upgrade = {
						upgrade = "stamina_on_melee_kill_brawler",
						category = "player",
						value = 1
					}
				}
				self.definitions.player_passive_armor_movement_penalty_multiplier2 = {
					name_id = "menu_passive_armor_movement_penalty_multiplier2",
					category = "feature",
					upgrade = {
						value = 2,
						upgrade = "passive_armor_movement_penalty_multiplier",
						category = "player"
					}
				}
				self.definitions.player_passive_armor_movement_penalty_multiplier3 = {
					name_id = "menu_passive_armor_movement_penalty_multiplier3",
					category = "feature",
					upgrade = {
						value = 3,
						upgrade = "passive_armor_movement_penalty_multiplier",
						category = "player"
					}
				}
				self.definitions.player_damage_resist_brawler1 = {
					name_id = "menu_damage_resist_brawler1",
					category = "feature",
					upgrade = {
						value = 1,
						upgrade = "damage_resist_brawler",
						category = "player"
					}
				}
				self.definitions.player_damage_resist_brawler2 = {
					name_id = "menu_damage_resist_brawler2",
					category = "feature",
					upgrade = {
						value = 2,
						upgrade = "damage_resist_brawler",
						category = "player"
					}
				}
				self.definitions.player_damage_resist_brawler3 = {
					name_id = "menu_damage_resist_brawler3",
					category = "feature",
					upgrade = {
						value = 3,
						upgrade = "damage_resist_brawler",
						category = "player"
					}
				}
				self.definitions.player_AP_damage_resist_brawler = {
					name_id = "menu_AP_damage_resist_brawler",
					category = "feature",
					upgrade = {
						value = 1,
						upgrade = "AP_damage_resist_brawler",
						category = "player"
					}
				}
				self.definitions.player_armor_regen_brawler = {
					name_id = "menu_armor_regen_brawler",
					category = "feature",
					upgrade = {
						value = 1,
						upgrade = "armor_regen_brawler",
						category = "player"
					}
				}
				self.definitions.player_damage_resist_faraway_brawler = {
					name_id = "damage_resist_faraway_brawler",
					category = "feature",
					upgrade = {
						value = 1,
						upgrade = "damage_resist_faraway_brawler",
						category = "player"
					}
				}
				self.definitions.player_damage_resist_teammates_brawler = {
					name_id = "menu_player_damage_resist_teammates_brawler",
					category = "feature",
					upgrade = {
						upgrade = "damage_resist_teammates_brawler",
						category = "player",
						value = 1
					}
				}
			end
			Brawler_definitions()
			
			local function Junkie_definitions()
				self.definitions.player_speed_junkie_meter = {
					name_id = "menu_player_speed_junkie_meter",
					category = "feature",
					upgrade = {
						value = 1,
						upgrade = "speed_junkie_meter",
						category = "player"
					}
				}
				self.definitions.player_pause_armor_recovery_when_moving = {
					name_id = "menu_player_pause_armor_recovery_when_moving",
					category = "feature",
					upgrade = {
						value = 1,
						upgrade = "pause_armor_recovery_when_moving",
						category = "player"
					}
				}
				self.definitions.player_health_decrease_2 = {
					name_id = "menu_player_health_decrease",
					category = "feature",
					upgrade = {
						value = 2,
						upgrade = "health_decrease",
						category = "player"
					}
				}
				self.definitions.player_armor_increase_4 = {
					name_id = "menu_player_health_to_armor_conversion",
					category = "feature",
					upgrade = {
						value = 4,
						upgrade = "armor_increase",
						category = "player"
					}
				}
				self.definitions.player_armor_increase_5 = {
					name_id = "menu_player_health_to_armor_conversion",
					category = "feature",
					upgrade = {
						value = 5,
						upgrade = "armor_increase",
						category = "player"
					}
				}
				self.definitions.player_speed_junkie_stamina_on_kill = {
					name_id = "menu_player_speed_junkie_stamina_on_kill",
					category = "feature",
					upgrade = {
						value = 1,
						upgrade = "speed_junkie_stamina_on_kill",
						category = "player"
					}
				}
				self.definitions.player_speed_junkie_meter_on_kill = {
					name_id = "menu_player_speed_junkie_meter_on_kill",
					category = "feature",
					upgrade = {
						value = 1,
						upgrade = "speed_junkie_meter_on_kill",
						category = "player"
					}
				}
				self.definitions.player_armor_increase_6 = {
					name_id = "menu_player_health_to_armor_conversion",
					category = "feature",
					upgrade = {
						value = 6,
						upgrade = "armor_increase",
						category = "player"
					}
				}
				self.definitions.player_speed_junkie_armor_on_dodge = {
					name_id = "menu_player_speed_junkie_armor_on_dodge",
					category = "temporary",
					upgrade = {
						value = 1,
						upgrade = "player_speed_junkie_armor_on_dodge",
						category = "temporary"
					}
				}
				self.definitions.player_speed_junkie_armor_berserk = {
					name_id = "menu_player_speed_junkie_armor_berserk",
					category = "feature",
					upgrade = {
						value = 1,
						upgrade = "speed_junkie_armor_berserk",
						category = "player"
					}
				}
				self.definitions.player_speed_junkie_meter_boost_agility = {
					name_id = "menu_player_speed_junkie_meter_boost_agility",
					category = "feature",
					upgrade = {
						value = 1,
						upgrade = "speed_junkie_meter_boost_agility",
						category = "player"
					}
				}
			end
			Junkie_definitions()
			
			local function Guardian_definitions()
				self.definitions.player_guardian_interaction_speed_penalty = {
					name_id = "menu_player_guardian_interaction_speed_penalty",
					category = "feature",
					upgrade = {
						value = 1,
						upgrade = "guardian_interaction_speed_penalty",
						category = "player"
					}
				}
				self.definitions.player_guardian_movement_penalty = {
					name_id = "menu_player_guardian_movement_penalty",
					category = "feature",
					upgrade = {
						value = 1,
						upgrade = "guardian_movement_penalty",
						category = "player"
					}
				}
				self.definitions.player_guardian_armor_remover = {
					name_id = "menu_player_guardian_armor_remover",
					category = "feature",
					upgrade = {
						value = 1,
						upgrade = "guardian_armor_remover",
						category = "player"
					}
				}
				self.definitions.player_guardian_area_passive = {
					name_id = "menu_player_guardian_area_passive",
					category = "feature",
					upgrade = {
						value = 1,
						upgrade = "guardian_area_passive",
						category = "player"
					}
				}
				self.definitions.player_guardian_area_range_1 = {
					name_id = "menu_player_guardian_area_range_1",
					category = "feature",
					upgrade = {
						value = 1,
						upgrade = "guardian_area_range",
						category = "player"
					}
				}
				self.definitions.player_guardian_area_range_2 = {
					name_id = "menu_player_guardian_area_range_2",
					category = "feature",
					upgrade = {
						value = 2,
						upgrade = "guardian_area_range",
						category = "player"
					}
				}
				self.definitions.player_guardian_area_passive_activation_timer_1 = {
					name_id = "menu_player_guardian_area_passive_activation_timer_1",
					category = "feature",
					upgrade = {
						value = 1,
						upgrade = "guardian_area_passive_activation_timer",
						category = "player"
					}
				}
				self.definitions.player_guardian_area_passive_activation_timer_2 = {
					name_id = "menu_player_guardian_area_passive_activation_timer_2",
					category = "feature",
					upgrade = {
						value = 2,
						upgrade = "guardian_area_passive_activation_timer",
						category = "player"
					}
				}
				self.definitions.player_guardian_area_passive_health_regen_1 = {
					name_id = "menu_player_guardian_area_passive_health_regen_1",
					category = "feature",
					upgrade = {
						value = 1,
						upgrade = "guardian_area_passive_health_regen",
						category = "player"
					}
				}
				self.definitions.player_guardian_area_passive_health_regen_2 = {
					name_id = "menu_player_guardian_area_passive_health_regen_2",
					category = "feature",
					upgrade = {
						value = 2,
						upgrade = "guardian_area_passive_health_regen",
						category = "player"
					}
				}
				self.definitions.player_guardian_area_passive_health_regen_3 = {
					name_id = "menu_player_guardian_area_passive_health_regen_3",
					category = "feature",
					upgrade = {
						value = 3,
						upgrade = "guardian_area_passive_health_regen",
						category = "player"
					}
				}
				self.definitions.player_guardian_damage_clamp_inside_1 = {
					name_id = "menu_player_guardian_damage_clamp_inside_1",
					category = "feature",
					upgrade = {
						value = 1,
						upgrade = "guardian_damage_clamp_inside_1",
						category = "player"
					}
				}
				self.definitions.player_guardian_damage_clamp_inside_2 = {
					name_id = "menu_player_guardian_damage_clamp_inside_2",
					category = "feature",
					upgrade = {
						value = 1,
						upgrade = "guardian_damage_clamp_inside_2",
						category = "player"
					}
				}
				self.definitions.player_guardian_damage_clamp_outside_1 = {
					name_id = "menu_player_guardian_damage_clamp_outside_1",
					category = "feature",
					upgrade = {
						value = 1,
						upgrade = "guardian_damage_clamp_outside_1",
						category = "player"
					}
				}
				self.definitions.player_guardian_damage_clamp_outside_2 = {
					name_id = "menu_player_guardian_damage_clamp_outside_2",
					category = "feature",
					upgrade = {
						value = 1,
						upgrade = "guardian_damage_clamp_outside_2",
						category = "player"
					}
				}
				self.definitions.player_passive_health_multiplier_6 = {
					name_id = "menu_player_health_multiplier",
					category = "feature",
					upgrade = {
						value = 6,
						upgrade = "passive_health_multiplier",
						category = "player"
					}
				}
				self.definitions.player_guardian_heavy_armor_ricochet = {
					name_id = "menu_player_guardian_heavy_armor_ricochet",
					category = "feature",
					upgrade = {
						value = 1,
						upgrade = "guardian_heavy_armor_ricochet",
						category = "player"
					}
				}
				self.definitions.player_guardian_activate_area_on_kill = {
					name_id = "menu_player_guardian_activate_area_on_kill",
					category = "feature",
					upgrade = {
						value = 1,
						upgrade = "guardian_activate_area_on_kill",
						category = "player"
					}
				}
				self.definitions.player_guardian_auto_ammo_pickup_on_kill = {
					name_id = "menu_player_guardian_auto_ammo_pickup_on_kill",
					category = "feature",
					upgrade = {
						value = 1,
						upgrade = "guardian_auto_ammo_pickup_on_kill",
						category = "player"
					}
				}
				self.definitions.player_guardian_health_on_kill = {
					name_id = "menu_player_guardian_health_on_kill",
					category = "feature",
					upgrade = {
						value = 1,
						upgrade = "guardian_health_on_kill",
						category = "player"
					}
				}
				self.definitions.player_guardian_reduce_equipment_heal = {
					name_id = "menu_player_guardian_reduce_equipment_heal",
					category = "feature",
					upgrade = {
						value = 1,
						upgrade = "guardian_reduce_equipment_heal",
						category = "player"
					}
				}
				self.definitions.player_menace_panic_spread = {
					name_id = "menu_player_menace_panic_spread",
					category = "feature",
					upgrade = {
						value = 1,
						upgrade = "menace_panic_spread",
						category = "player"
					}
				}
			end
			Guardian_definitions()
			
		end
		New_Custom_Perk_definitions()
		
	end
	New_Perk_definitions()
	
end)

Hooks:PostHook(UpgradesTweakData, "_shotgun_definitions", "Gilza_skill_definitions_2", function(self)	
	-- new shotgun recoil skill
	self.definitions.shotgun_recoil_multiplier_1 = {
		incremental = true,
		name_id = "menu_shotgun_recoil_multiplier_1",
		category = "feature",
		upgrade = {
			value = 1,
			upgrade = "recoil_multiplier",
			category = "shotgun"
		}
	}
	self.definitions.shotgun_recoil_multiplier_2 = {
		incremental = true,
		name_id = "menu_shotgun_recoil_multiplier_2",
		category = "feature",
		upgrade = {
			value = 2,
			upgrade = "recoil_multiplier",
			category = "shotgun"
		}
	}
	-- fearmonger
	self.definitions.shotgun_panic_when_kill = {
		name_id = "menu_shotgun_panic_when_kill",
		category = "feature",
		upgrade = {
			value = 1,
			upgrade = "panic_when_kill",
			category = "shotgun"
		}
	}
end)

Hooks:PostHook(UpgradesTweakData, "_pistol_definitions", "Gilza_skill_definitions_3", function(self)	
	-- botomless pockets pistol part
	self.definitions.pistol_extra_ammo_multiplier_1 = {
		incremental = true,
		name_id = "menu_pistol_extra_ammo_multiplier",
		category = "feature",
		upgrade = {
			value = 1,
			upgrade = "extra_ammo_multiplier",
			category = "pistol"
		}
	}
	self.definitions.pistol_extra_ammo_multiplier_2 = {
		incremental = true,
		name_id = "menu_pistol_extra_ammo_multiplier2",
		category = "feature",
		upgrade = {
			value = 2,
			upgrade = "extra_ammo_multiplier",
			category = "pistol"
		}
	}
	-- new ACED tier 1 upgrade
	self.definitions.pistol_swap_speed_multiplier_2 = {
		name_id = "menu_pistol_swap_speed_multiplier_2",
		category = "feature",
		upgrade = {
			value = 2,
			upgrade = "swap_speed_multiplier",
			category = "pistol"
		}
	}
	-- new trigger happy buff
	self.definitions.pistol_trigger_happpy_rof_increase = {
		name_id = "menu_pistol_trigger_happpy_rof_increase",
		category = "feature",
		upgrade = {
			value = 1,
			upgrade = "trigger_happpy_rof_increase",
			category = "pistol"
		}
	}
end)

Hooks:PostHook(UpgradesTweakData, "_smg_definitions", "Gilza_skill_definitions_4", function(self)	
	-- botomless pockets smg part
	self.definitions.smg_extra_ammo_multiplier_1 = {
		incremental = true,
		name_id = "menu_smg_extra_ammo_multiplier_1",
		category = "feature",
		upgrade = {
			value = 1,
			upgrade = "extra_ammo_multiplier",
			category = "smg"
		}
	}
	self.definitions.smg_extra_ammo_multiplier_2 = {
		incremental = true,
		name_id = "menu_smg_extra_ammo_multiplier_2",
		category = "feature",
		upgrade = {
			value = 2,
			upgrade = "extra_ammo_multiplier",
			category = "smg"
		}
	}
end)

Hooks:PostHook(UpgradesTweakData, "_weapon_definitions", "Gilza_skill_definitions_5", function(self)	
	-- double trouble skill
	self.definitions.akimbo_pistol_improved_handling = {
		name_id = "menu_akimbo_pistol_improved_handling",
		category = "feature",
		upgrade = {
			value = 1,
			upgrade = "pistol_improved_handling",
			category = "akimbo"
		}
	}
	self.definitions.akimbo_allow_smg_improved_handling = {
		name_id = "menu_akimbo_allow_smg_improved_handling",
		category = "feature",
		upgrade = {
			value = 1,
			upgrade = "allow_smg_improved_handling",
			category = "akimbo"
		}
	}
end)