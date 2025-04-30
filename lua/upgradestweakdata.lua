Hooks:PostHook(UpgradesTweakData, "_init_pd2_values", "Gilza_skill_values", function(self)
	
	-- Shotgun HE round. Why it would be here is beyond my understanding
	self.explosive_bullet = {
		curve_pow = 0,
		player_dmg_mul = 0.01,
		range = 120
	}
	self.explosive_bullet.feedback_range = self.explosive_bullet.range
	
	local function New_Mastermind_Skills()
		---- MEDIC
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
		-- new designated marksman skill aced - 50% better recoil with first 5 shots
		self.values.player.less_start_recoil = {
			0.5
		}
		-- new slow and steady skill - dmg resist if not moving
		self.values.player.not_moving_damage_reduction_bonus = {
			0.9
		}
		-- slow and steady pro - extra dmg resist if bipoded
		self.values.player.not_moving_damage_reduction_bonus_bipoded = {
			0.75
		}
		-- slow and steady pro - faster bipod deploy time
		self.values.player.bipod_deploy_speed = {
			2
		}
		-- agressive reload for AR's; due to game's reload speed caluclations, this value is now 25% so that actuall reloads gain a 20% buff
		self.values.assault_rifle.reload_speed_multiplier = {
			1.25
		}
		-- agressive reload for SMG's
		self.values.smg.reload_speed_multiplier = {
			1.25
		}
		-- agressive reload for sniper's
		self.values.snp.reload_speed_multiplier = {
			1.25
		}
		-- agressive reload aced buff from 100% to 200% reload
		self.values.temporary.single_shot_fast_reload = {
			{
				2.5,
				4
			}
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
			0.06,
			0.18
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
		-- Sprint with any bag
		self.values.player.sprint_any_bag = {true}
		
		---- AMMO SPECIALIST
		-- we consume less total ammo with saw, so skill is also reduced
		self.values.saw.enemy_slicer = {
			5
		}
		-- new saw massacre aced bonus
		self.values.player.saw_ammo_pick_up = {
			true
		}
		-- fully loaded aced pickup buff 75->85
		self.values.player.pick_up_ammo_multiplier = {
			1.35,
			1.85
		}
		-- make old fully loaded aced grenade pick up base kit with perks, buff the skill values. nerf grenade pick ups depending on the grenade
		self.values.player.regain_throwable_from_ammo = {
			{
				chance = 0,
				chance_inc = 0.01
			},
			{
				chance = 0.10,
				chance_inc = 0.03
			}
		}	
	end
	New_Enforcer_Skills()
	
	local function New_Technician_Skills()
		---- ENGINEER
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
			0.25
		}
		-- new fire control basic - removed 40% recoil penalty while hipfiring
		self.values.player.hipfire_less_recoil = {
			0
		}
		-- new fire control aced - removes acc penalty while hipfiring
		self.values.player.hipfire_no_accuracy_penalty = {
			0
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
		-- new ap bullets from BE basic
		self.values.player.ap_bullets_aced = {
			true
		}
		-- ammo pick up reduction for BE
		self.values.player.pick_up_ammo_reduction = {
			0.8,
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
				25
			},
			{
				4,
				10
			}
		}
	end
	New_Ghost_Skills()
	
	-- Fugitive
	local function New_Fugitive_Skills()
		---- GUNSLINGER
		-- gun nut ROF changed to 20%
		self.values.pistol.fire_rate_multiplier = {
			1.20
		}
		-- new nerfed trigger happy
		self.values.pistol.stacking_hit_damage_multiplier = {
			{
				max_stacks = 2,
				max_time = 10,
				damage_bonus = 1.4
			},
			{
				max_stacks = 2,
				max_time = 10,
				damage_bonus = 1.4
			}
		}
		-- new desperado
		self.values.pistol.stacked_accuracy_bonus = {
			{
				max_stacks = 2,
				accuracy_bonus = 0.84,
				max_time = 10
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
		-- new bottomless pockets skill
		self.values.smg.extra_ammo_multiplier = {
			1.4,
			2
		}
		
		---- REVENANT
		-- new version for self heal with up you go
		self.values.player.health_regain_V2 = {
			0.25
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
				45
			}
		}
	end
	New_Fugitive_Skills()
	
	-- PERKS
	local function New_Perks()
		-- adding 4th dodge chance for rogue buff
		self.values.player.passive_dodge_chance = {
			0.15,
			0.3,
			0.45,
			0.5
		}
		-- roruge armour piercing buff
		self.values.weapon.armor_piercing_chance = {
			0.5
		}
		-- rogue extra 15% move speed
		self.values.player.movement_speed_multiplier = {
			1.1,
			1.25
		}
		-- rogue extra 25% stamina
		self.values.player.stamina_multiplier = {
			1.25
		}
		-- infiltrator/sociopath melee dmg boosts adjustments
		self.values.melee.stacking_hit_damage_multiplier = {
			0.75,
			0.75
		}
		-- adjusted hidden infiltrator duration buff to be present on both decks but shorter
		self.values.melee.stacking_hit_expire_t = {
			4
		}
		-- gambler
		self.values.player.gain_life_per_players = {
			0.4
		}
		self.values.player.increased_pickup_area = {
			1.5,
			2
		}
		-- hacker jammer - longer feedback, but less cooldown on kill; WARN: duration lasts for 12/6 seconds based on game state, code for that is in playermanager.lua
		self.values.player.pocket_ecm_jammer_base[1].duration = 12
		self.values.player.pocket_ecm_jammer_base[1].cooldown_drain = 4
		-- hacker heal from self - 2x the amount
		self.values.player.pocket_ecm_heal_on_kill = {
			4
		}
		-- hacker temp dodge - now requires 3 kills to trigger and lasts for 50 secs instead of 20
		self.values.temporary.pocket_ecm_kill_dodge = {
			{
				0.2,
				50,
				3
			}
		}
		-- hitman
		self.values.temporary.player_new_hitman_regen = {
			{
				0.4, -- % of the base recovery timer that is used for the actual duration
				0.5, -- default duration
			}
		}
		-- yakuza
		self.values.player.yakuza_suppression_resist = {
			true
		}
		-- tag team
		self.values.player.tag_team_base.distance = 24
		self.values.player.tag_team_base.kill_extension = 1.7
		self.values.player.tag_team_damage_absorption = {
			{
				kill_gain = 0.4,
				max = 3.2
			}
		}
		-- copycat nerf from 15 to 20, because this card was fixed to only activate invlun if armor is <0
		self.values.temporary.mrwi_health_invulnerable = {
			{
				0.5,
				2,
				30
			}
		}
		---- Brawler deck stuff
		-- why make new code that makes more sense, when old code will do?
		self.values.player.perk_armor_regen_timer_multiplier = {
			0.95,
			0.85,
			0.75,
			0.65,
			0.55,
			3
		}
		self.values.player.extra_ammo_cut = {
			0.2
		}
		self.values.player.passive_armor_movement_penalty_multiplier = {
			0.75,
			0.5,
			0.25
		}
		self.values.player.damage_resist_brawler = {
			0.9,
			0.8,
			0.7
		}
		self.values.player.stamina_on_melee_kill_brawler = {
			0.1
		}
		self.values.player.AP_damage_resist_brawler = {
			true
		}
		self.values.player.armor_regen_brawler = {
			true
		}
		self.values.player.damage_resist_faraway_brawler = {
			true
		}
		---- Speed Junkie deck stuff
		-- anarchist armor increase, extended for new junkie perk
		self.values.player.armor_increase = {
			1,
			1.1,
			1.2,
			0.42,
			0.46,
			0.52
		}
		-- anarchist health decrease, extended for new junkie perk
		self.values.player.health_decrease = {
			0.5,
			0.9
		}
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
			3
		}
		self.values.temporary.player_speed_junkie_armor_on_dodge = {
			{
				0.6, -- amount
				1.5, -- cooldown
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
		-- for 10 points of armor you get a chance multiplier for ricochet. so for 216 armor with current mul you get 21 x 2 = 42%
		self.values.player.guardian_heavy_armor_ricochet = {
			2
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
	New_Perks()
	
end)

Hooks:PostHook(UpgradesTweakData, "_player_definitions", "Gilza_skill_definitions_1", function(self)	
	
	---- MASTERMIND
	self.definitions.player_revive_action_self_heal = {
		name_id = "menu_player_revive_action_self_heal",
		category = "feature",
		upgrade = {
			value = 1,
			upgrade = "revive_action_self_heal",
			category = "player"
		}
	}
	self.definitions.player_weapon_accuracy_increase_2 = {
		name_id = "menu_player_weapon_accuracy_increase",
		category = "feature",
		upgrade = {
			value = 2,
			upgrade = "weapon_accuracy_increase",
			category = "player"
		}
	}
	self.definitions.player_less_start_recoil = {
		name_id = "player_less_start_recoil",
		category = "feature",
		upgrade = {
			value = 1,
			upgrade = "less_start_recoil",
			category = "player"
		}
	}
	self.definitions.player_not_moving_damage_reduction_bonus_1 = {
		name_id = "player_not_moving_damage_reduction_bonus",
		category = "feature",
		upgrade = {
			value = 1,
			upgrade = "not_moving_damage_reduction_bonus",
			category = "player"
		}
	}
	self.definitions.player_not_moving_damage_reduction_bonus_bipoded = {
		name_id = "player_not_moving_damage_reduction_bonus_bipoded",
		category = "feature",
		upgrade = {
			value = 1,
			upgrade = "not_moving_damage_reduction_bonus_bipoded",
			category = "player"
		}
	}
	self.definitions.player_bipod_deploy_speed = {
		name_id = "menu_player_bipod_deploy_speed",
		category = "feature",
		upgrade = {
			value = 1,
			upgrade = "bipod_deploy_speed",
			category = "player"
		}
	}
	
	---- ENFORCER
	self.definitions.player_speed_boost_on_panic_kill = {
		name_id = "menu_player_speed_boost_on_panic_kill",
		category = "temporary",
		upgrade = {
			value = 1,
			upgrade = "speed_boost_on_panic_kill",
			category = "temporary"
		}
	}
	self.definitions.player_sprint_any_bag = {
		category = "feature",
		name_id = "menu_player_sprint_any_bag",
		upgrade = {
			category = "player",
			upgrade = "sprint_any_bag",
			value = 1
		}
	}
	self.definitions.player_saw_ammo_pick_up = {
		name_id = "saw_ammo_pick_up",
		category = "feature",
		upgrade = {
			value = 1,
			upgrade = "saw_ammo_pick_up",
			category = "player"
		}
	}
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
	
	---- TECHNICIAN
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
	self.definitions.player_hipfire_less_recoil = {
		name_id = "player_hipfire_less_recoil",
		category = "feature",
		upgrade = {
			value = 1,
			upgrade = "hipfire_less_recoil",
			category = "player"
		}
	}
	self.definitions.player_hipfire_no_accuracy_penalty = {
		name_id = "player_hipfire_no_accuracy_penalty",
		category = "feature",
		upgrade = {
			value = 1,
			upgrade = "hipfire_no_accuracy_penalty",
			category = "player"
		}
	}
	self.definitions.player_ap_bullets_aced = {
		name_id = "player_ap_bullets_aced",
		category = "feature",
		upgrade = {
			value = 1,
			upgrade = "ap_bullets_aced",
			category = "player"
		}
	}
	self.definitions.player_pick_up_ammo_reduction_1 = {
		name_id = "menu_player_pick_up_ammo_reduction_1",
		category = "feature",
		upgrade = {
			value = 1,
			upgrade = "pick_up_ammo_reduction",
			category = "player"
		}
	}
	self.definitions.player_pick_up_ammo_reduction_2 = {
		name_id = "menu_player_pick_up_ammo_reduction_2",
		category = "feature",
		upgrade = {
			value = 2,
			upgrade = "pick_up_ammo_reduction",
			category = "player"
		}
	}
	self.definitions.player_sentry_proximity_damage_resist = {
		name_id = "menu_player_sentry_proximity_damage_resist",
		category = "feature",
		upgrade = {
			value = 1,
			upgrade = "sentry_proximity_damage_resist",
			category = "player"
		}
	}
	self.definitions.player_sentry_kills_refill_ammo = {
		name_id = "menu_player_sentry_kills_refill_ammo",
		category = "feature",
		upgrade = {
			value = 1,
			upgrade = "sentry_kills_refill_ammo",
			category = "player"
		}
	}
	
	---- GHOST
	self.definitions.player_extra_jump_height = {
		name_id = "extra_jump_height",
		category = "feature",
		upgrade = {
			value = 1,
			upgrade = "extra_jump_height",
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
	self.definitions.player_dodge_armor_regen_1 = {
		name_id = "menu_player_dodge_armor_regen_1",
		category = "temporary",
		upgrade = {
			value = 1,
			upgrade = "player_dodge_armor_regen",
			category = "temporary"
		}
	}
	self.definitions.player_dodge_armor_regen_2 = {
		name_id = "menu_player_dodge_armor_regen_2",
		category = "temporary",
		upgrade = {
			value = 2,
			upgrade = "player_dodge_armor_regen",
			category = "temporary"
		}
	}
	
	---- FUGITIVE
	self.definitions.player_revived_health_regain_V2 = {
		name_id = "revived_health_regain_V2",
		category = "feature",
		upgrade = {
			value = 1,
			upgrade = "health_regain_V2",
			category = "player"
		}
	}
	self.definitions.player_bleed_out_health_multiplier_2 = {
		name_id = "menu_player_bleed_out_health_multiplier_2",
		category = "feature",
		upgrade = {
			value = 2,
			upgrade = "bleed_out_health_multiplier",
			category = "player"
		}
	}
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
	self.definitions.player_melee_damage_newzerk_addin = {
		name_id = "melee_damage_newzerk_addin",
		category = "feature",
		upgrade = {
			value = 1,
			upgrade = "melee_damage_newzerk_addin",
			category = "player"
		}
	}
	self.definitions.player_new_berserk_melee_damage_multiplier_1 = {
		name_id = "menu_player_new_berserk_melee_damage_multiplier_1",
		category = "temporary",
		upgrade = {
			value = 1,
			upgrade = "new_berserk_melee_damage_multiplier_1",
			category = "temporary"
		}
	}
	self.definitions.player_new_berserk_weapon_damage_multiplier = {
		name_id = "menu_player_new_berserk_weapon_damage_multiplier",
		category = "temporary",
		upgrade = {
			value = 1,
			upgrade = "new_berserk_weapon_damage_multiplier",
			category = "temporary"
		}
	}
	self.definitions.player_new_berserk_weapon_damage_multiplier_cooldown = {
		name_id = "menu_player_new_berserk_weapon_damage_multiplier_cooldown",
		category = "temporary",
		upgrade = {
			value = 1,
			upgrade = "new_berserk_weapon_damage_multiplier_cooldown",
			category = "temporary"
		}
	}
	
	---- PERKS
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
	-- rogue
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
	-- hitman
	self.definitions.player_new_hitman_regen = {
		name_id = "menu_player_new_hitman_regen",
		category = "temporary",
		upgrade = {
			value = 1,
			upgrade = "player_new_hitman_regen",
			category = "temporary"
		}
	}
	-- yakuza
	self.definitions.player_yakuza_suppression_resist = {
		name_id = "menu_player_yakuza_suppression_resist",
		category = "feature",
		upgrade = {
			value = 1,
			upgrade = "yakuza_suppression_resist",
			category = "player"
		}
	}
	-- gambler
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
	-- brawler
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
	-- speed junkie
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
	-- Guardian
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
	
end)

Hooks:PostHook(UpgradesTweakData, "_shotgun_definitions", "Gilza_skill_definitions_2", function(self)	
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
end)

Hooks:PostHook(UpgradesTweakData, "_smg_definitions", "Gilza_skill_definitions_4", function(self)	
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