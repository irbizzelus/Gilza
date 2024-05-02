Hooks:PostHook(UpgradesTweakData, "_init_pd2_values", "Gilza_skill_values", function(self)
	
	-- Shotgun HE round. Why it would be here is beyond my understanding
	self.explosive_bullet = {
		curve_pow = 0,
		player_dmg_mul = 0.01,
		range = 120
	}
	self.explosive_bullet.feedback_range = self.explosive_bullet.range
	
	local function New_Mastermind_Skills()
		---- SHARPSHOOTER
		-- tweaked stable shot to only give accuracy bonuses
		self.values.player.weapon_accuracy_increase = {
			1,
			3
		}
		-- new designated marksman skill aced - 35% better recoil with first 5 shots
		self.values.player.less_start_recoil = {
			0.65
		}
		-- new slow and steady skill - dmg resist if not moving or bipoded
		self.values.player.not_moving_damage_reduction_bonus = {
			0.075
		}
		-- slow and steady pro - extra dmg resist if bipoded
		self.values.player.not_moving_damage_reduction_bonus_bipoded = {
			0.35
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
		-- new graze values, they should be 1/3 and 2/3 but i dont trust damage calculation's rounding up values correctly
		self.values.snp.graze_damage = {
			{
				radius = 75,
				damage_factor = 0.34,
				damage_factor_headshot = 0
			},
			{
				radius = 150,
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
			0.85,
			0.60
		}
		-- new blast away skill - suprisingly still has native support, and does not require any code on my part
		self.values.shotgun.consume_no_ammo_chance = {
			0.075,
			0.20
		}
		-- fearmonger's shotgun panic spread
		self.values.shotgun.panic_when_kill = {
			{
				chance = 0.75,
				area = 1500,
				amount = 500
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
		-- make old fully loaded aced grenade pick up base kit with perks, buff the skill values. nerf grenade pick ups depending on the grenade
		self.values.player.regain_throwable_from_ammo = {
			{
				chance = 0,
				chance_inc = 0.01
			},
			{
				chance = 0.10,
				chance_inc = 0.02
			}
		}	
	end
	New_Enforcer_Skills()
	
	local function New_Technician_Skills()
		---- OPPRESSOR
		-- base steady grip sometimes can be gained for no reason, idk why, just make sure that it gives nothing
		self.values.player.stability_increase_bonus_1 = {
			0,
		}
		-- tweaked steady grip to only give stability bonuses
		self.values.player.stability_increase_bonus_2 = {
			1,
			3
		}
		-- heavy impact
		self.values.weapon.knock_down = {
			0.05,
			0.25
		}
		-- new fire control basic - removed 40% recoil penalty while hipfiring
		self.values.player.hipfire_less_recoil = {
			1
		}
		-- new fire control aced - removes 25% acc penalty while hipfiring
		self.values.player.hipfire_no_accuracy_penalty = {
			0
		}
		-- Body expertise muls
		self.values.weapon.automatic_head_shot_add = {
			0.5,
			1
		}
		-- new ap bullets from BE basic
		self.values.player.ap_bullets_aced = {
			true
		}
		-- ammo pick up reduction for BE; numbers are fucky, because i wanted to make it so it reduced pick up by 20% and 40% after the 35% buff from a perk deck skill
		self.values.player.pick_up_ammo_reduction = {
			0.73,
			0.46
		}
	end
	New_Technician_Skills()
	
	local function New_Ghost_Skills()
		-- no value adjustments here yet, just moved skills around a bit
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
				max_stacks = 1,
				max_time = 1.5,
				damage_bonus = 1.8
			},
			{
				max_stacks = 1,
				max_time = 1.5,
				damage_bonus = 1.8
			}
		}
		-- new desperado
		self.values.pistol.stacked_accuracy_bonus = {
			{
				max_stacks = 3,
				accuracy_bonus = 0.9,
				max_time = 15
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
			1.4,
			2
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
		-- swan song change
		self.values.temporary.berserker_damage_multiplier = { {1,3}, {1.5,9} }
		
		---- BRAWLER
		-- blotdthirst basic adjustment to new melee system
		self.values.player.melee_damage_stacking = {
			{
				max_multiplier = 5,
				melee_multiplier = 0.25
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
				20
			}
		}
		-- new berserk melee aced
		self.values.temporary.new_berserk_melee_damage_multiplier_2 = {
			{
				1.5,
				40
			}
		}
		-- new berserk weapon
		self.values.temporary.new_berserk_weapon_damage_multiplier = {
			{
				2,
				15
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
		-- gambler change
		self.values.player.gain_life_per_players = {
			0.4
		}	
		-- Brawler deck stuff
		self.values.player.extra_ammo_cut = {
			0.1
		}
		self.values.player.passive_armor_movement_penalty_multiplier = {
			0.75,
			0.5,
			0.25
		}
		self.values.player.damage_resist_brawler = {
			0.18,
			0.36,
			0.54
		}
		self.values.player.armor_regen_brawler = {
			true
		}
		self.values.player.damage_resist_faraway_brawler = {
			true
		}
	end
	New_Perks()
	
end)

Hooks:PostHook(UpgradesTweakData, "_player_definitions", "Gilza_skill_definitions_1", function(self)	
	
	---- MASTERMIND
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
	self.definitions.player_new_berserk_melee_damage_multiplier_2 = {
		name_id = "menu_player_new_berserk_melee_damage_multiplier_2",
		category = "temporary",
		upgrade = {
			value = 1,
			upgrade = "new_berserk_melee_damage_multiplier_2",
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
	self.definitions.player_extra_ammo_cut = {
		name_id = "extra_ammo_cut",
		category = "feature",
		upgrade = {
			value = 1,
			upgrade = "extra_ammo_cut",
			category = "player"
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