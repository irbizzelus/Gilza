Hooks:PostHook(SkillTreeTweakData, "init", "swap_base_decks_and_skills", function(self, params)
	-- Change headshot multiplier to 8th card lame doc bag bonus
	local deck2 = {
		cost = 300,
		desc_id = "menu_deckall_2_desc",
		name_id = "menu_deckall_2",
		upgrades = {
			"passive_doctor_bag_interaction_speed_multiplier",
		},
		icon_xy = {
			1,
			0
		}
	}
	
	-- Add fully loaded nade pick up as base kit, but make it really weak
		local deck6 = {
			cost = 1600,
			desc_id = "menu_deckall_6_desc",
			name_id = "menu_deckall_6",
			upgrades = {
				"armor_kit",
				"player_pick_up_ammo_multiplier",
				"player_regain_throwable_from_ammo_1"
			},
			icon_xy = {
				5,
				0
			}
		}
	
	-- Remove pathetic extra 5% damage and replace with base transporter+parkour
	local deck8 = {
		cost = 3200,
		desc_id = "menu_deckall_8_desc",
		name_id = "menu_deckall_8",
		upgrades = {
			"carry_throw_distance_multiplier",
			"player_movement_speed_multiplier",
		},
		icon_xy = {
			7,
			0
		}
	}
	
	local deck_0_socio = {
		cost = 200,
		desc_id = "menu_sociopathinfil_1_desc",
		name_id = "menu_deck9_1",
		upgrades = {
			"player_damage_dampener_outnumbered_strong",
			"melee_stacking_hit_damage_multiplier_1",
			"melee_stacking_hit_expire_t",
		},
		icon_xy = {
			6,
			4
		}
	}
	self.specializations[9][1] = deck_0_socio
	
	local deck_0_infil = {
		cost = 200,
		desc_id = "menu_sociopathinfil_1_desc",
		name_id = "menu_deck8_7",
		upgrades = {
			"player_damage_dampener_outnumbered_strong",
			"melee_stacking_hit_damage_multiplier_1",
			"melee_stacking_hit_expire_t",
		},
		icon_xy = {
			6,
			4
		}
	}
	self.specializations[8][1] = deck_0_infil
	
	local deck_4_infil = {
		cost = 1000,
		desc_id = "menu_deck8_3_desc",
		name_id = "menu_deck8_3",
		upgrades = {
			"player_damage_dampener_close_contact_2",
			"melee_stacking_hit_damage_multiplier_1"
		},
		icon_xy = {
			4,
			4
		}
	}
	self.specializations[8][5] = deck_4_infil

	-- Change common perks in each deck
	for i = 1, #self.specializations, 1 do
		self.specializations[i][2] = deck2
		self.specializations[i][6] = deck6
		self.specializations[i][8] = deck8
	end
	
	-- Add new Brawler perk deck
	local brawler_deck = {
		{
			cost = 200,
			desc_id = "menu_deck_brawler1_desc",
			name_id = "menu_deck_brawler1",
			upgrades = {
				"player_extra_ammo_cut",
				"player_passive_armor_movement_penalty_multiplier2",
				"player_damage_resist_brawler1"
			},
			icon_xy = {
				2,
				4
			}
		},
		deck2,
		{
			cost = 400,
			desc_id = "menu_deck_brawler3_desc",
			name_id = "menu_deck_brawler3",
			upgrades = {
				"player_damage_resist_brawler2",
			},
			icon_xy = {
				0,
				5
			}
		},
		{-- neutral card 4
			cost = 600,
			desc_id = "menu_deckall_4_desc",
			name_id = "menu_deckall_4",
			upgrades = {
				"passive_player_xp_multiplier",
				"player_passive_suspicion_bonus",
				"player_passive_armor_movement_penalty_multiplier"
			},
			icon_xy = {
				3,
				0
			}
		},
		{
			cost = 1000,
			desc_id = "menu_deck_brawler5_desc",
			name_id = "menu_deck_brawler5",
			texture_bundle_folder = "max",
			upgrades = {
				"player_passive_armor_movement_penalty_multiplier3",
			},
			icon_xy = {
				1,
				0
			}
		},
		deck6,
		{
			cost = 2400,
			desc_id = "menu_deck_brawler7_desc",
			name_id = "menu_deck_brawler7",
			upgrades = {
				"player_damage_resist_brawler3",
			},
			icon_xy = {
				0,
				5
			}
		},
		deck8,
		{
			cost = 4000,
			desc_id = "menu_deck_brawler9_desc",
			name_id = "menu_deck_brawler9",
			upgrades = {
				"player_armor_regen_brawler",
				"player_damage_resist_faraway_brawler",
				"player_uncover_multiplier",
				"player_passive_loot_drop_multiplier"
			},
			icon_xy = {
				6,
				4
			}
		},
		desc_id = "menu_deck_brawler_desc",
		name_id = "menu_deck_brawler",
		custom = true,
		custom_id = "Gilza_brawler_perkdeck",
	}

	local j = #self.specializations + 1
	self.specializations[j] = brawler_deck
	Gilza.brawler_deck_index = j
	
	-- rogue
	self.specializations[4][9].upgrades = {
		"player_passive_loot_drop_multiplier",
		"weapon_passive_armor_piercing_chance",
		"weapon_passive_swap_speed_multiplier_1",
		"player_movement_speed_multiplier_2",
		"player_stamina_multiplier",
		"player_passive_dodge_chance_4"
	}
	
	-- new skills and reworks
	
	self.skills.pack_mule[1].upgrades = { "player_armor_carry_bonus_1" }
	self.skills.pack_mule[2].upgrades = { "player_sprint_any_bag" }
	self.skills.pack_mule.icon_xy = { 6, 0 }
	
	self.skills.awareness[1].upgrades = { "player_climb_speed_multiplier_1", "player_can_free_run", }
	self.skills.awareness[2].upgrades = { "player_run_and_reload" }
	
	self.skills.far_away[1].upgrades = { "shotgun_consume_no_ammo_chance_1" }
	self.skills.far_away[2].upgrades = { "shotgun_consume_no_ammo_chance_2" }
	self.skills.far_away.icon_xy = { 4, 1 }
	
	self.skills.close_by[2].upgrades = { "shotgun_hip_rate_of_fire_1" }

	self.skills.shotgun_cqb[1].upgrades = { "shotgun_reload_speed_multiplier_1" }
	self.skills.shotgun_cqb[2].upgrades = { "shotgun_reload_speed_multiplier_2" }
	
	self.skills.shotgun_impact[1].upgrades = { "shotgun_recoil_multiplier_1", "shotgun_enter_steelsight_speed_multiplier" }
	self.skills.shotgun_impact[2].upgrades = { "shotgun_recoil_multiplier_2" }
	self.skills.shotgun_impact.icon_xy = { 8, 5 }
	
	self.skills.steady_grip[1].upgrades = { "player_stability_increase_bonus_3" }
	self.skills.steady_grip[2].upgrades = { "player_stability_increase_bonus_4" }
	
	self.skills.stable_shot[1].upgrades = { "player_weapon_accuracy_increase_1" }
	self.skills.stable_shot[2].upgrades = { "player_weapon_accuracy_increase_2" }
	
	self.skills.sharpshooter[1].upgrades = { "player_not_moving_damage_reduction_bonus_1" }
	self.skills.sharpshooter[2].upgrades = { "player_not_moving_damage_reduction_bonus_bipoded", "player_bipod_deploy_speed" }
	
	self.skills.rifleman[1].upgrades = {
		"weapon_enter_steelsight_speed_multiplier",
		"assault_rifle_zoom_increase",
		"snp_zoom_increase",
		"smg_zoom_increase",
		"lmg_zoom_increase",
		"pistol_zoom_increase",
	}
	self.skills.rifleman[2].upgrades = { "player_steelsight_normal_movement_speed", "player_weapon_movement_accuracy_nullifier" }
	
	self.skills.bandoliers[2].upgrades = { "player_regain_throwable_from_ammo_2"}
	
	self.skills.steroids[1].upgrades = { "player_melee_faster_charge" }
	self.skills.steroids[2].upgrades = { "player_melee_sprint" }
	self.skills.steroids.icon_xy = { 11, 7 }
	self.skills.martial_arts.icon_xy = { 1, 1 }
	
	self.skills.up_you_go[2].upgrades = {"player_revived_health_regain_V2"}
	
	self.skills.gun_fighter[1].upgrades = {"pistol_extra_ammo_multiplier_1"}
	self.skills.gun_fighter[2].upgrades = {"pistol_extra_ammo_multiplier_2"}
	self.skills.gun_fighter.icon_xy = {11,0}
	
	self.skills.dance_instructor[1].upgrades = {"pistol_fire_rate_multiplier"}
	self.skills.dance_instructor[2].upgrades = {"pistol_magazine_capacity_inc_1"}
	self.skills.dance_instructor.icon_xy = {7,11}
	
	self.skills.carbon_blade[2].upgrades = {"saw_ignore_shields_1","saw_panic_when_kill_1","player_saw_ammo_pick_up"}
end)