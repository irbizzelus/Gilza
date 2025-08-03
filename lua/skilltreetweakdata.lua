-- skill assignments
Hooks:PostHook(SkillTreeTweakData, "init", "Gilza_SkillTreeTweakData_init_post", function(self, params)
	
	local function updatePERKS()
		
		-- Changed headshot multiplier to the lame doc bag bonus from 8th card
		local deck2 = {
			cost = 300,
			desc_id = "menu_deckall_2_desc",
			name_id = "menu_deckall_2",
			upgrades = {
				"passive_doctor_bag_interaction_speed_multiplier",
				"player_passive_armor_movement_penalty_multiplier"
			},
			icon_xy = {
				1,
				0
			}
		}
		
		-- unchanged, used for new decks
		local deck4 = {
			cost = 600,
			desc_id = "menu_deckall_4_desc",
			name_id = "menu_deckall_4",
			upgrades = {
				"passive_player_xp_multiplier",
				"player_passive_suspicion_bonus"
			},
			icon_xy = {
				3,
				0
			}
		}
		
		-- Added fully loaded nade pick up as base kit, but made it kinda weak
		local deck6 = {
			cost = 1600,
			desc_id = "menu_deckall_6_desc",
			name_id = "menu_deckall_6",
			upgrades = {
				"armor_kit",
				"player_regain_throwable_from_ammo_1"
			},
			icon_xy = {
				5,
				0
			}
		}
		
		-- Removed pathetic extra 5% damage and replace with basic transporter and basic parkour
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
		
		-- Change common perk cards in each deck
		for i = 1, #self.specializations, 1 do
			self.specializations[i][2] = deck2
			self.specializations[i][4] = deck4
			self.specializations[i][6] = deck6
			self.specializations[i][8] = deck8
		end
		
		-- load custom perks first so that copycat can successfully copy them
		local function CUSTOM_PERKS()
			-- Brawler perk deck
			local brawler_deck = {
				{
					cost = 200,
					desc_id = "menu_deck_brawler1_desc",
					short_id = "menu_deck_brawler1_desc_short",
					name_id = "menu_deck_brawler1",
					upgrades = {
						"player_extra_ammo_cut",
						"player_damage_resist_brawler1",
						"player_perk_armor_regen_timer_multiplier_1", -- when perk is unequipped, it resets to a weaker version of the same skills, instead of removing upgrades completely
						"player_perk_armor_regen_timer_multiplier_2", -- so now this perk adds lower upgrades as well to avoid this issue
						"player_perk_armor_regen_timer_multiplier_3",
						"player_perk_armor_regen_timer_multiplier_4",
						"player_perk_armor_regen_timer_multiplier_5",
						"player_perk_armor_regen_timer_multiplier_6", -- important one
						"melee_stacking_hit_damage_multiplier_1",
						"melee_stacking_hit_expire_t",
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
					short_id = "menu_deck_brawler3_desc_short",
					name_id = "menu_deck_brawler3",
					upgrades = {
						"player_damage_resist_brawler2",
						"player_passive_armor_movement_penalty_multiplier2",
					},
					icon_xy = {
						0,
						5
					}
				},
				
				deck4,
				
				{
					cost = 1000,
					desc_id = "menu_deck_brawler5_desc",
					short_id = "menu_deck_brawler5_desc_short",
					name_id = "menu_deck_brawler5",
					texture_bundle_folder = "max",
					upgrades = {
						"player_damage_resist_brawler3",
						"player_passive_armor_movement_penalty_multiplier3",
						"player_AP_damage_resist_brawler",
						"player_stamina_on_melee_kill_brawler"
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
					short_id = "menu_deck_brawler7_desc_short",
					name_id = "menu_deck_brawler7",
					upgrades = {
						"player_uncover_multiplier",
						"player_damage_resist_teammates_brawler"
					},
					icon_xy = {
						0,
						5
					}
				},
				
				deck8,
				
				{
					cost = 4000,
					texture_bundle_folder = "Gilza",
					desc_id = "menu_deck_brawler9_desc",
					short_id = "menu_deck_brawler9_desc_short",
					name_id = "menu_deck_brawler9",
					upgrades = {
						"player_armor_regen_brawler",
						"player_passive_loot_drop_multiplier"
					},
					icon_xy = {
						2,
						1
					}
				},
				desc_id = "menu_deck_brawler_desc",
				name_id = "menu_deck_brawler",
				custom = true,
				custom_id = "Gilza_brawler_perkdeck",
			}
			
			-- Add Brawler
			local j = #self.specializations + 1
			self.specializations[j] = brawler_deck
			Gilza.custom_specialization_indexes = {brawler = j}
			
			-- Speed junkie perk deck
			local speed_junkie_deck = {
				{
					cost = 200,
					texture_bundle_folder = "Gilza",
					desc_id = "menu_deck_SJ_1_desc",
					short_id = "menu_deck_SJ_1_desc_short",
					name_id = "menu_deck_SJ_1",
					upgrades = {
						"player_speed_junkie_meter",
						"player_pause_armor_recovery_when_moving",
						"player_health_decrease_1", -- when perk is unequipped, it resets to a weaker version of the same skills, instead of removing upgrades completely
						"player_health_decrease_2", -- this is the important one
						"player_armor_increase_1", -- so now this perk adds lower upgrades as well to avoid this issue
						"player_armor_increase_2",
						"player_armor_increase_3",
						"player_armor_increase_4" -- this is the important one
					},
					icon_xy = {
						1,
						0
					}
				},
				deck2,
				{
					cost = 400,
					texture_bundle_folder = "Gilza",
					desc_id = "menu_deck_SJ_3_desc",
					short_id = "menu_deck_SJ_3_desc_short",
					name_id = "menu_deck_SJ_3",
					upgrades = {
						"player_passive_dodge_chance_1",
						"player_armor_increase_5",
						"player_speed_junkie_stamina_on_kill"
					},
					icon_xy = {
						2,
						0
					}
				},
				deck4,
				{
					cost = 1000,
					texture_bundle_folder = "Gilza",
					desc_id = "menu_deck_SJ_5_desc",
					short_id = "menu_deck_SJ_5_desc_short",
					name_id = "menu_deck_SJ_5",
					upgrades = {
						"player_speed_junkie_meter_on_kill",
						"player_armor_increase_6"
					},
					icon_xy = {
						3,
						0
					}
				},
				deck6,
				{
					cost = 2400,
					texture_bundle_folder = "max",
					desc_id = "menu_deck_SJ_7_desc",
					short_id = "menu_deck_SJ_7_desc_short",
					name_id = "menu_deck_SJ_7",
					upgrades = {
						"player_speed_junkie_armor_on_dodge"
					},
					icon_xy = {
						3,
						0
					}
				},
				deck8,
				{
					cost = 4000,
					texture_bundle_folder = "Gilza",
					desc_id = "menu_deck_SJ_9_desc",
					short_id = "menu_deck_SJ_9_desc_short",
					name_id = "menu_deck_SJ_9",
					upgrades = {
						"player_speed_junkie_armor_berserk",
						"player_speed_junkie_meter_boost_agility",
						"player_passive_loot_drop_multiplier"
					},
					icon_xy = {
						1,
						1
					}
				},
				desc_id = "menu_deck_SJ_desc",
				name_id = "menu_deck_SJ",
				custom = true,
				custom_id = "Gilza_SJ_perkdeck",
			}

			-- Speed junkie
			j = #self.specializations + 1
			self.specializations[j] = speed_junkie_deck
			Gilza.custom_specialization_indexes.junkie = j
			
			-- Guardian perk deck
			local guardian_deck = {
				{
					cost = 200,
					texture_bundle_folder = "Gilza_guardian",
					desc_id = "menu_deck_Gilza_guardian_1_desc",
					short_id = "menu_deck_Gilza_guardian_1_desc_short",
					name_id = "menu_deck_Gilza_guardian_1",
					upgrades = {
						"player_guardian_interaction_speed_penalty",
						"player_guardian_movement_penalty",
						"player_guardian_armor_remover",
						"player_guardian_area_passive",
						"player_guardian_area_range_1",
						"player_guardian_area_passive_activation_timer_1",
						"player_guardian_area_passive_health_regen_1",
					},
					icon_xy = {
						0,
						0
					}
				},
				deck2,
				{
					cost = 400,
					texture_bundle_folder = "Gilza_guardian",
					desc_id = "menu_deck_Gilza_guardian_3_desc",
					short_id = "menu_deck_Gilza_guardian_3_desc_short",
					name_id = "menu_deck_Gilza_guardian_3",
					upgrades = {
						"player_guardian_damage_clamp_inside_1",
						"player_guardian_damage_clamp_outside_1",
						"player_passive_health_multiplier_1",
						"player_passive_health_multiplier_2",
						"player_passive_health_multiplier_3",
						"player_passive_health_multiplier_4",
						"player_passive_health_multiplier_5",
						"player_guardian_area_passive_health_regen_2",
					},
					icon_xy = {
						1,
						0
					}
				},
				deck4,
				{
					cost = 1000,
					texture_bundle_folder = "Gilza_guardian",
					desc_id = "menu_deck_Gilza_guardian_5_desc",
					short_id = "menu_deck_Gilza_guardian_5_desc_short",
					name_id = "menu_deck_Gilza_guardian_5",
					upgrades = {
						"player_guardian_health_on_kill",
						"player_passive_health_multiplier_6",
						"player_guardian_area_passive_health_regen_3",
						"player_guardian_area_range_2",
						"player_guardian_reduce_equipment_heal",
					},
					icon_xy = {
						2,
						0
					}
				},
				deck6,
				{
					cost = 2400,
					texture_bundle_folder = "Gilza_guardian",
					desc_id = "menu_deck_Gilza_guardian_7_desc",
					short_id = "menu_deck_Gilza_guardian_7_desc_short",
					name_id = "menu_deck_Gilza_guardian_7",
					upgrades = {
						"player_guardian_heavy_armor_ricochet",
						"player_guardian_area_passive_activation_timer_2",
					},
					icon_xy = {
						3,
						0
					}
				},
				deck8,
				{
					cost = 4000,
					texture_bundle_folder = "Gilza_guardian",
					desc_id = "menu_deck_Gilza_guardian_9_desc",
					short_id = "menu_deck_Gilza_guardian_9_desc_short",
					name_id = "menu_deck_Gilza_guardian_9",
					upgrades = {
						"player_guardian_auto_ammo_pickup_on_kill",
						"player_guardian_activate_area_on_kill",
						"player_guardian_damage_clamp_inside_2",
						"player_guardian_damage_clamp_outside_2",
						"player_passive_loot_drop_multiplier"
					},
					icon_xy = {
						0,
						1
					}
				},
				desc_id = "menu_deck_Gilza_guardian_desc",
				name_id = "menu_deck_Gilza_guardian",
				custom = true,
				custom_id = "Gilza_guardian_perkdeck",
			}

			-- Guardian
			j = #self.specializations + 1
			self.specializations[j] = guardian_deck
			Gilza.custom_specialization_indexes.guardian = j
		end
		CUSTOM_PERKS()
		
		local function VANILLA_PERKS()
			
			local function Crew_chief_updates()
				-- update melee related card
				self.specializations[1][3].upgrades = {
					"team_passive_stamina_multiplier_1",
					"player_passive_intimidate_range_mul",
					"player_damage_dampener_close_contact_1",
					"player_passive_inspire_range_mul"
				}
			end
			Crew_chief_updates()
			
			local function Rogue_updates()
				self.specializations[4][9].upgrades = {
					"player_passive_loot_drop_multiplier",
					"weapon_passive_armor_piercing_chance",
					"weapon_passive_swap_speed_multiplier_1",
					"player_movement_speed_multiplier_2",
					"player_stamina_multiplier",
					"player_passive_dodge_chance_4",
					"player_crouch_dodge_chance_1"
				}
			end
			Rogue_updates()
			
			local function Hitman_updates()
				self.specializations[5][1].upgrades = {
					"temporary_badass_hitman_kill_armor_regen"
				}
				self.specializations[5][3].upgrades = {
					"akimbo_recoil_index_addend_4",
					"akimbo_extra_ammo_multiplier_2",
					"temporary_akimbo_pistol_armor_regen_timer_multiplier"
				}
				self.specializations[5][5].upgrades = {
					"temporary_death_dance_combo_invulnerability",
				}
				self.specializations[5][7].upgrades = {
					"temporary_player_bounty_hunter"
				}
				self.specializations[5][9].upgrades = {
					"player_passive_loot_drop_multiplier",
					"player_passive_always_regen_armor_1"
				}
			end
			Hitman_updates()
			
			local function Crook_updates()
				self.specializations[6][9].upgrades = {
					"player_passive_loot_drop_multiplier",
					"player_armor_regen_timer_multiplier_tier",
					"weapon_passive_armor_piercing_chance_maxed"
				}
			end
			Crook_updates()
			
			local function Burglar_updates()
				self.specializations[7][5].upgrades = {
					"player_tier_dodge_chance_2",
					"player_stand_still_crouch_camouflage_bonus_2",
					"player_pick_lock_speed_multiplier",
					"player_level_2_dodge_addend_1",
					"player_level_2_dodge_addend_2",
					"player_silencer_concealment_increase_2"
				}
			end
			Burglar_updates()
			
			local function Infiltrator_updates()
				-- update melee related cards
				self.specializations[8][1] = {
					cost = 200,
					desc_id = "menu_sociopathinfil_1_desc",
					short_id = "menu_sociopathinfil_1_short",
					name_id = "menu_sociopathinfil_1",
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
				self.specializations[8][5] = {
					cost = 1000,
					desc_id = "menu_deck8_5_desc",
					short_id = "menu_deck8_5_short",
					name_id = "menu_deck8_5",
					upgrades = {
						"player_damage_dampener_close_contact_2",
						"melee_stacking_hit_damage_multiplier_1"
					},
					icon_xy = {
						4,
						4
					}
				}
				-- fixes vanilla mixed around card names for ease of use in loc files
				self.specializations[8][3].desc_id = "menu_deck8_3_desc"
				self.specializations[8][3].short_id = "menu_deck8_3_short"
				self.specializations[8][3].name_id = "menu_deck8_3"
				self.specializations[8][7].desc_id = "menu_deck8_7_desc"
				self.specializations[8][7].short_id = "menu_deck8_7_short"
				self.specializations[8][7].name_id = "menu_deck8_7"
			end
			Infiltrator_updates()
			
			local function Sociopath_updates()
				-- update melee related card
				self.specializations[9][1] = {
					cost = 200,
					desc_id = "menu_sociopathinfil_1_desc",
					short_id = "menu_sociopathinfil_1_short",
					name_id = "menu_sociopathinfil_1",
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
			end
			Sociopath_updates()
			
			local function Gambler_updates()
				self.specializations[10][1].upgrades = {
					"player_loose_ammo_restore_health_chances",
					"temporary_loose_ammo_restore_health_1",
					"player_increased_pickup_area_2"
				}
				self.specializations[10][7].upgrades = {
					"temporary_loose_ammo_restore_health_2",
					"temporary_loose_ammo_restore_health_3"
				}
				self.specializations[10][9].upgrades = {
					"player_passive_loot_drop_multiplier",
					"player_loose_ammo_add_dodge_amount",
				}
			end
			Gambler_updates()
			
			local function Yakuza_updates()
				self.specializations[12][7].upgrades = {
					"player_armor_regen_damage_health_ratio_multiplier_3",
					"player_AP_damage_resist_brawler"
				}
				self.specializations[12][9].upgrades = {
					"player_passive_loot_drop_multiplier",
					"player_armor_regen_damage_health_ratio_threshold_multiplier",
					"player_movement_speed_damage_health_ratio_threshold_multiplier",
					"player_yakuza_suppression_resist",
					"player_yakuza_behind_player_resist",
				}
			end
			Yakuza_updates()
			
			local function Ex_pres_updates()
				self.specializations[13][5].upgrades = {
					"player_armor_max_health_store_multiplier",
					"player_passive_health_multiplier_2",
					"player_static_dodge_chance",
				}
				self.specializations[13][7].upgrades = {
					"player_armor_health_store_amount_3",
					"player_passive_health_multiplier_3",
					"player_armor_health_store_shield",
				}
				self.specializations[13][9].upgrades = {
					"player_passive_loot_drop_multiplier",
					"player_store_armor_recovery_bonus_timer"
				}
			end
			Ex_pres_updates()

			local function Biker_updates()
				self.specializations[16][1].upgrades = {
					"player_wild_health_amount_1",
					"player_wild_armor_amount_1",
					"player_wild_temporary_regen_pause",
					"player_tier_armor_multiplier_1",
					"player_passive_health_multiplier_1"
				}
			end
			Biker_updates()
			
			local function Leech_updates()
				self.specializations[22][1].upgrades = {
					"temporary_copr_ability_1",
					"copr_ability",
					"player_copr_static_damage_ratio_1",
					"player_copr_activate_bonus_health_ratio_1",
					"player_copr_teammate_heal_1",
					"temporary_copr_invuln_on_segment_loss"
				}
				self.specializations[22][7].upgrades = {
					"player_passive_health_multiplier_3",
					"player_passive_health_multiplier_4",
					"player_copr_regain_cooldown_on_revives"
				}
				self.specializations[22][9].upgrades = {
					"player_activate_ability_downed",
					"player_copr_static_damage_ratio_2",
					"player_copr_heal_during_invuln_increase",
					"player_passive_loot_drop_multiplier"
				}
				self.specializations[22].category = "supportive"
			end
			Leech_updates()
			
			local function Copycat_updates()
				self.specializations[23][1].multi_choice[4].upgrades = {
					"mrwi_crouch_speed_multiplier_1",
					"mrwi_carry_speed_multiplier_1",
					"mrwi_ammo_supply_multiplier_1"
				}
				self.specializations[23][3].multi_choice[4].upgrades = {
					"mrwi_crouch_speed_multiplier_2",
					"mrwi_carry_speed_multiplier_2",
					"mrwi_ammo_supply_multiplier_2"
				}
				self.specializations[23][5].multi_choice[4].upgrades = {
					"mrwi_crouch_speed_multiplier_3",
					"mrwi_carry_speed_multiplier_3",
					"mrwi_ammo_supply_multiplier_3"
				}
				self.specializations[23][7].multi_choice[4].upgrades = {
					"mrwi_crouch_speed_multiplier_4",
					"mrwi_carry_speed_multiplier_4",
					"mrwi_ammo_supply_multiplier_4"
				}
				local deck9_multi_choice = {}
				local deck9_options = UpgradesTweakData.mrwi_deck9_options_gilza_update()
				for _, options in pairs(deck9_options) do
					local data = nil
					local perk_name = nil

					if options.tree and options.tier then
						data = clone(self.specializations[options.tree][options.tier])
						perk_name = self.specializations[options.tree].name_id
					else
						data = {}
					end

					data.upgrades = table.list_add(options.upgrades or {}, data.upgrades or {})
					data.cost = options.cost or data.cost or 4000
					data.icon_atlas = options.icon_atlas or data.icon_atlas or "icons_atlas"
					data.icon_xy = options.icon_xy or data.icon_xy
					data.texture_bundle_folder = options.texture_bundle_folder or data.texture_bundle_folder
					data.name_id = perk_name or options.name_id or data.name_id
					data.desc_id = options.desc_id or data.desc_id
					data.short_id = "menu_deck23_9_short"
					data.skip_tier_desc = options.skip_tier_desc or data.skip_tier_desc
					data.skip_tier_name = true
					data.shorten_desc = options.shorten_desc or data.shorten_desc
					
					table.insert(deck9_multi_choice, data)
				end
				self.specializations[23][9].upgrades = {
					"player_passive_loot_drop_multiplier",
					"player_copycat_9th_card_identifier" -- does not do anything, only used to idenfy usage of 9th card to reduce some bonuses
				}
				self.specializations[23][9].multi_choice = deck9_multi_choice
			end
			Copycat_updates()
			
		end
		VANILLA_PERKS()
	
	end
	updatePERKS()
	
	local function updateSKILLS()
		
		---- MASTERMIND
		self.skills.combat_medic[2].upgrades = { "player_revive_action_self_heal" }
		
		self.skills.triathlete[1].upgrades = { "cable_tie_quantity", "cable_tie_interact_speed_multiplier", "team_damage_hostage_absorption" }
		self.skills.triathlete[2].upgrades = { "player_convert_enemies_damage_multiplier_1", "player_convert_enemies", "player_convert_enemies_max_minions_1" }
		
		self.skills.joker[1].upgrades = { "player_convert_enemies_interaction_speed_multiplier", "player_convert_enemies_damage_multiplier_2" }
		self.skills.joker[2].upgrades = { "player_convert_enemies_max_minions_2" }
		
		self.skills.cable_guy[2].upgrades = { "player_civ_calming_alerts" }
		
		self.skills.stockholm_syndrome[1].upgrades = { "player_menace_panic_spread" }
		
		self.skills.stable_shot[1].upgrades = { "player_weapon_accuracy_increase_1" }
		self.skills.stable_shot[2].upgrades = { "player_weapon_accuracy_increase_2" }
		
		self.skills.rifleman[1].upgrades = { "weapon_enter_steelsight_speed_multiplier", "assault_rifle_zoom_increase", "snp_zoom_increase", "smg_zoom_increase", "lmg_zoom_increase", "pistol_zoom_increase", "player_less_start_recoil" }
		self.skills.rifleman[2].upgrades = { "player_steelsight_normal_movement_speed", "player_less_start_recoil_2", "player_less_start_recoil_for_longer" }
		
		self.skills.sharpshooter[1].upgrades = { "player_not_moving_damage_reduction_bonus_1" }
		self.skills.sharpshooter[2].upgrades = { "player_not_moving_damage_reduction_bonus_bipoded", "player_bipod_deploy_speed" }
		
		self.skills.speedy_reload[1].upgrades = { "assault_rifle_reload_speed_multiplier", "smg_reload_speed_multiplier", "snp_reload_speed_multiplier", "player_single_body_shot_kill_refill_ammo_1" }
		self.skills.speedy_reload[2].upgrades = { "player_single_body_shot_kill_reload", "player_single_body_shot_kill_refill_ammo_2" }
		
		---- ENFORCER
		self.skills.shotgun_cqb[1].upgrades = { "shotgun_reload_speed_multiplier_1" }
		self.skills.shotgun_cqb[2].upgrades = { "shotgun_reload_speed_multiplier_2" }
		
		self.skills.shotgun_impact[1].upgrades = { "shotgun_recoil_multiplier_1", "shotgun_enter_steelsight_speed_multiplier" }
		self.skills.shotgun_impact[2].upgrades = { "shotgun_recoil_multiplier_2", "shotgun_steelsight_accuracy_inc_1" }
		self.skills.shotgun_impact.icon_xy = { 8, 5 }
		
		self.skills.far_away[1].upgrades = { "shotgun_consume_no_ammo_chance_1" }
		self.skills.far_away[2].upgrades = { "shotgun_consume_no_ammo_chance_2" }
		self.skills.far_away.icon_xy = { 4, 1 }
		
		self.skills.close_by[2].upgrades = { "shotgun_panic_when_kill", "player_speed_boost_on_panic_kill" }
		
		self.skills.pack_mule[1].upgrades = { "player_armor_carry_bonus_1" }
		self.skills.pack_mule[2].upgrades = { "player_sprint_any_bag" }
		self.skills.pack_mule.icon_xy = { 6, 0 }
		
		self.skills.prison_wife[2].upgrades = {"player_headshot_regen_armor_bonus_2", "player_headshot_regen_armor_shorter_cooldown"}
		
		self.skills.ammo_2x[1].upgrades = { "ammo_bag_ammo_increase1" }
		self.skills.ammo_2x[2].upgrades = { "ammo_bag_quantity" }
		
		self.skills.carbon_blade[2].upgrades = {"saw_ignore_shields_1","saw_panic_when_kill_1","player_saw_ammo_pick_up"}
		
		self.skills.bandoliers[2].upgrades = {"player_regain_throwable_from_ammo_2", "player_pick_up_ammo_multiplier"}
		
		---- TECHICIAN
		self.skills.defense_up[1].upgrades = {"sentry_gun_cost_reduction_1", "sentry_gun_cost_reduction_2"}
		self.skills.defense_up[2].upgrades = {"sentry_gun_armor_multiplier", "sentry_gun_extra_ammo_multiplier_1"}
		
		self.skills.sentry_targeting_package[1].upgrades = {"sentry_gun_spread_multiplier","sentry_gun_rot_speed_multiplier"}
		self.skills.sentry_targeting_package[2].upgrades = {"sentry_gun_shield"}
		
		self.skills.eco_sentry[1].upgrades = {"player_ar_smg_lmg_rof_increase_1"}
		self.skills.eco_sentry[2].upgrades = {"player_ar_smg_lmg_rof_increase_2"}
		self.skills.eco_sentry.icon_xy = {1,7}
		
		self.skills.tower_defense[2].upgrades = { "sentry_gun_quantity_2", "sentry_gun_can_revive", "player_sentry_proximity_damage_resist", "player_sentry_kills_refill_ammo" }
		
		self.skills.kick_starter[2].upgrades = {"player_drill_melee_hit_restart_chance_1", "player_drill_fix_interaction_speed_multiplier_2"}
		
		self.skills.steady_grip[1].upgrades = { "player_stability_increase_bonus_3" }
		self.skills.steady_grip[2].upgrades = { "player_stability_increase_bonus_4" }
		
		self.skills.fire_control[1].upgrades = { "player_hipfire_less_recoil" }
		self.skills.fire_control[2].upgrades = { "player_hipfire_no_accuracy_penalty" }
		
		self.skills.fast_fire[2].upgrades = {"player_ap_bullets_basic", "weapon_armor_piercing_chance_2"}
		
		self.skills.body_expertise[1].upgrades = { "weapon_automatic_head_shot_add_1"}
		self.skills.body_expertise[2].upgrades = { "weapon_automatic_head_shot_add_2", "player_ap_bullets_aced"}
		
		---- GHOST
		self.skills.jail_workout[1].upgrades = { "player_additional_assets" }
		self.skills.jail_workout[2].upgrades = { "player_small_loot_multiplier_1", "player_mask_off_pickup" }
		self.skills.jail_workout.icon_xy = {0,8}
		
		self.skills.cleaner[1].upgrades = { "player_corpse_dispose_amount_2", "player_extra_corpse_dispose_amount", "player_cleaner_cost_multiplier" }
		self.skills.cleaner[2].upgrades = { "bodybags_bag_quantity", "player_buy_bodybags_asset" }
		
		self.skills.chameleon[1].upgrades = { "player_buy_spotter_asset", "player_suspicion_bonus", "player_sec_camera_highlight_mask_off", "player_special_enemy_highlight_mask_off" }
		self.skills.chameleon[2].upgrades = { "player_standstill_omniscience" }
		
		self.skills.awareness[1].upgrades = { "player_climb_speed_multiplier_1", "player_extra_jump_height", "player_can_free_run" }
		self.skills.awareness[2].upgrades = {  "player_run_and_reload", "player_limited_fall_damage_immunity" }
		
		self.skills.dire_need[1].upgrades = {"player_detection_risk_add_dodge_chance_1"}
		self.skills.dire_need[2].upgrades = {"player_detection_risk_add_dodge_chance_2"}
		self.skills.dire_need.icon_xy = {1,12}
		
		self.skills.insulation[1].upgrades = {"player_armor_depleted_stagger_shot_1", "player_armor_depleted_stagger_shot_2"}
		self.skills.insulation[2].upgrades = {"player_taser_self_shock","player_escape_taser_1","player_tased_electric_bullets"}
		
		self.skills.jail_diet[1].upgrades = {"player_dodge_armor_regen_1"}
		self.skills.jail_diet[2].upgrades = {"player_dodge_armor_regen_2"}
		self.skills.jail_diet.icon_xy = {10,8}
		
		self.skills.silence_expert[1].upgrades = {"weapon_silencer_recoil_index_addend", "weapon_silencer_enter_steelsight_speed_multiplier", "weapon_silencer_armor_piercing_chance_1"}
		self.skills.silence_expert[2].upgrades = {"weapon_silencer_spread_index_addend", "weapon_silencer_armor_piercing_chance_2"}
		
		---- FUGITIVE
		self.skills.equilibrium[2].upgrades = {"pistol_swap_speed_multiplier_2", "pistol_spread_index_addend"}
		
		self.skills.dance_instructor[1].upgrades = {"pistol_fire_rate_multiplier"}
		self.skills.dance_instructor[2].upgrades = {"pistol_reload_speed_multiplier"}
		self.skills.dance_instructor.icon_xy = {0,9}
		
		self.skills.gun_fighter[1].upgrades = {"pistol_stacked_accuracy_bonus_1"}
		self.skills.gun_fighter[2].upgrades = {"pistol_stacking_hit_damage_multiplier_1", "pistol_trigger_happpy_rof_increase"}
		self.skills.gun_fighter.icon_xy = {11,2}
		
		self.skills.expert_handling[1].upgrades = {"akimbo_pistol_improved_handling"}
		self.skills.expert_handling[2].upgrades = {"akimbo_allow_smg_improved_handling"}
		self.skills.expert_handling.icon_xy = {3,3}

		self.skills.trigger_happy[1].upgrades = {"pistol_extra_ammo_multiplier_1", "smg_extra_ammo_multiplier_1", "player_secondary_weapons_pickup_bonus"}
		self.skills.trigger_happy[2].upgrades = {"pistol_extra_ammo_multiplier_2", "smg_extra_ammo_multiplier_2", "player_pistols_and_smgs_pick_up_increase"}
		self.skills.trigger_happy.icon_xy = {11,0}
		
		self.skills.up_you_go[2].upgrades = {"player_revived_health_regain_V2"}
		
		self.skills.messiah[1].upgrades = {"player_messiah_revive_from_bleed_out_1","player_bleed_out_health_multiplier_2"}
		
		self.skills.martial_arts[1].upgrades = {"player_melee_knockdown_mul", "player_melee_shake_reduction_1"}
		self.skills.martial_arts[2].upgrades = {"player_melee_damage_dampener", "player_melee_shake_reduction_2"}
		self.skills.martial_arts.icon_xy = { 1, 1 }
		
		self.skills.steroids[1].upgrades = { "player_melee_sprint" }
		self.skills.steroids[2].upgrades = { "player_melee_faster_charge" }
		self.skills.steroids.icon_xy = { 11, 7 }
		
		self.skills.wolverine[1].upgrades = {"player_new_berserk_melee_damage_multiplier_1","player_melee_damage_newzerk_addin"}
		self.skills.wolverine[2].upgrades = {"player_new_berserk_weapon_damage_multiplier","player_new_berserk_weapon_damage_multiplier_cooldown"}
		
	end
	updateSKILLS()
	
end)