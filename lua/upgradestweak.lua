Hooks:PostHook(UpgradesTweakData, "init", "newskills1", function(self, params)
	-- Sprint with any bag
	self.values.player.sprint_any_bag = {true}
end)

Hooks:PostHook(UpgradesTweakData, "_init_pd2_values", "newskills2", function(self, params)
	-- overkill
	self.values.temporary.overkill_damage_multiplier = {{1.40,30}}
	self.values.shotgun.consume_no_ammo_chance = {
		0.075,
		0.20
	}
	-- new shotgun pro recoil
	self.values.shotgun.recoil_multiplier = {
		0.85,
		0.60
	}
	-- nerfed aced close by
	self.values.shotgun.hip_rate_of_fire = {
		1.25
	}
	-- nerfed and tweaked steady grip to only give stability bonuses
	self.values.player.stability_increase_bonus_2 = {
		4,
		1,
		3
	}
	-- nerfed and tweaked stable shot to only give accuarcy bonuses
	self.values.player.weapon_accuracy_increase = {
		1,
		2
	}
	-- marksman replacment that gives you dmg resistance if not moving or bipoded
	self.values.player.not_moving_damage_reduction_bonus = {
		0.95
	}
	-- marksman replacment pro that gives you extra dmg resistance if bipoded
	self.values.player.not_moving_damage_reduction_bonus_bipoded = {
		0.631 -- this value is a bit dumb, because we apply both the base 5% bonus and the pro bipod bonus one after another, this is close enough to 40%, cuz idk right now how to make those values additive
	}
	-- fire control hip fire 20->15
	self.values.player.weapon_movement_stability = {
		0.85
	}
	-- new agile marksman skill, nullifies weapon inaccuarcy while moving and ADS'ing
	self.values.player.weapon_movement_accuracy_nullifier = {
		0.7
	}
	-- gun nut ROF changed from 50 to 25, bcuz all pistols have higher base ROF now
	self.values.pistol.fire_rate_multiplier = {
		1.20
	}
	-- make fully loaded aced nade pick up base kit (from perks) and buff it's aced values. nerf grenade amount to compensate
	self.values.player.regain_throwable_from_ammo = {
		{
			chance = 0.025,
			chance_inc = 1.0075
		},
		{
			chance = 0.10,
			chance_inc = 1.02
		}
	}
	-- faster bipod deploy time
	self.values.player.bipod_deploy_speed = {
		2
	}
	-- consume even less ammo with saw skills
	self.values.saw.enemy_slicer = {
		5
	}
	-- faster melee charge skill
	self.values.player.melee_faster_charge = {
		2
	}
	-- melee sprint skill
	self.values.player.melee_sprint = {
		true
	}
	-- blotdthirst basic adjustment to new melee system
	self.values.player.melee_damage_stacking = {
		{
			max_multiplier = 7,
			melee_multiplier = 0.25
		}
	}
	-- berserker adjustment to new melee system
	self.values.player.melee_damage_health_ratio_multiplier = {
		1.25
	}
	-- sociopath/infiltrator melee dmg boosts adjustments
	self.values.melee.stacking_hit_damage_multiplier = {
		0.5,
		0.5
	}
	-- adjusted hidden infiltrator duration buff to be present on both decks but shorter
	self.values.melee.stacking_hit_expire_t = {
		4
	}
	-- adjust normal selfheal from up you go just in case
	self.values.player.revived_health_regain = {
		1
	}
	-- new version for self heal with up you go
	self.values.player.health_regain_V2 = {
		0.35
	}
	-- Brawler deck stuff
	self.values.player.extra_ammo_cut = {
		0.2
	}
	self.values.player.passive_armor_movement_penalty_multiplier = {
		0.75,
		0.5,
		0.25
	}
	self.values.player.damage_resist_brawler = {
		0.82,
		0.64,
		0.46
	}
	self.values.player.armor_regen_brawler = {
		true
	}
	self.values.player.damage_resist_faraway_brawler = {
		0.25
	}
end)

Hooks:PostHook(UpgradesTweakData, "_player_definitions", "newskills3", function(self, params)	

	-- add new skills
	self.definitions.player_sprint_any_bag = {
		category = "feature",
		name_id = "menu_player_sprint_any_bag",
		upgrade = {
			category = "player",
			upgrade = "sprint_any_bag",
			value = 1
		}
	}
	self.definitions.player_stability_increase_bonus_3 = {
		name_id = "menu_player_stability_increase_bonus",
		category = "feature",
		upgrade = {
			value = 2,
			upgrade = "stability_increase_bonus_2",
			category = "player"
		}
	}
	self.definitions.player_stability_increase_bonus_4 = {
		name_id = "menu_player_stability_increase_bonus",
		category = "feature",
		upgrade = {
			value = 3,
			upgrade = "stability_increase_bonus_2",
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
	self.definitions.player_weapon_movement_accuracy_nullifier = {
		name_id = "player_weapon_movement_accuracy_nullifier",
		category = "feature",
		upgrade = {
			value = 1,
			upgrade = "weapon_movement_accuracy_nullifier",
			category = "player"
		}
	}
	self.definitions.player_regain_throwable_from_ammo_1 = {
		name_id = "menu_player_regain_throwable_from_ammo",
		category = "feature",
		upgrade = {
			value = 2,
			upgrade = "regain_throwable_from_ammo",
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
	self.definitions.player_melee_faster_charge = {
		name_id = "menu_player_melee_faster_charge",
		category = "feature",
		upgrade = {
			value = 1,
			upgrade = "melee_faster_charge",
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
	self.definitions.player_revived_health_regain_V2 = {
		name_id = "revived_health_regain_V2",
		category = "feature",
		upgrade = {
			value = 1,
			upgrade = "health_regain_V2",
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

Hooks:PostHook(UpgradesTweakData, "_shotgun_definitions", "newskills4", function(self, params)	

	-- add new shotgun skills
	self.definitions.shotgun_recoil_multiplier_1 = {
		name_id = "menu_shotgun_recoil_multiplier_1",
		category = "feature",
		upgrade = {
			value = 1,
			upgrade = "recoil_multiplier",
			category = "shotgun"
		}
	}
	self.definitions.shotgun_recoil_multiplier_2 = {
		name_id = "menu_shotgun_recoil_multiplier_2",
		category = "feature",
		upgrade = {
			value = 2,
			upgrade = "recoil_multiplier",
			category = "shotgun"
		}
	}
end)