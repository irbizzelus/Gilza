Hooks:Add('LocalizationManagerPostInit', 'newdescriptionsandstuff_eng', function(loc)
	LocalizationManager:add_localized_strings({
		-- skills/perks
		menu_deckall_8 = "Improved Physique",
		menu_deckall_8_desc = "You gain ##10%## additional movement speed.\n\nYou can throw bags ##50%## further.",
		menu_deckall_6_desc = "Unlocks an armor bag equipment for you to use. The armor bag can be used to change your armor during a heist.\n\nIncreases your ammo pickup to ##135%## of the normal rate.\n\nYou also gain a base ##0%## chance to get a throwable from an ammo box. The base chance is increased by ##1.5%## for each ammo box you pick up that does not contain a throwable. When a throwable has been found, the chance is reset to its base value.",
		menu_deckall_2 = "Fast and Furious",
		menu_deckall_2_desc = "Increases your doctor bag interaction speed by ##20%##",
		menu_deck18_1_desc = "Unlocks and equips the throwable Smoke Bomb.\n\nChanging to another perk deck will make the Smoke Bomb unavailable again. The Smoke Bomb replaces your current throwable, is equipped in your throwable slot and can be switched out if desired.\n\nWhile in game you can use throwable key to deploy the Smoke Bomb.\n\nWhen deployed, the smoke bomb creates a smoke screen that lasts for ##10## seconds. While standing inside the smoke screen, you and any of your allies automatically avoid ##50%## of all bullets. Any enemies that stand in the smoke will see their accuracy reduced by ##50%##.\n\nAfter the smoke screen dissipates, the Smoke Bomb is on a cooldown for ##40## seconds, but killing enemies will reduce this cooldown by ##1## second.",
		
		menu_pack_mule_beta_desc = "BASIC: ##$basic##\nFor each ##10## armor points, the bag movement penalty is reduced by ##1%##.\n\nACE: ##$pro##\nYou can sprint with any bag.",
		menu_awareness_beta_desc = "BASIC: ##$basic##\nYou gain ##20%## increased speed when climbing ladders.\n\nYou gain the ability to sprint in any direction.\n\nACE: ##$pro##\nRun and reload - you can reload your weapons while sprinting.",
		menu_overkill_beta_desc = "BASIC: ##$basic##\nWhen you kill an enemy with a Shotgun or the OVE9000 portable saw, you receive a ##40%## damage increase for ##30## seconds.\n\nACE: ##$pro##\nThe damage bonus now applies to all weapons. Skill must be activated using a Shotgun or the OVE9000 portable saw. Your weapon swap speed is increased by ##80%##\n\nNote: Does not apply to melee damage, throwables, grenade launchers or rocket launchers.",
		menu_far_away_beta = "BLAST AWAY",
		menu_far_away_beta_desc = "BASIC: ##$basic##\nEvery time you fire any Shotgun you get ##7.5%## chance to not consume any ammo.\n\nACE: ##$pro##\nYour chances to not consume any ammo increase to ##20%##",
		menu_close_by_beta_desc = "BASIC: ##$basic##\nYou can now hip-fire with your Shotguns while sprinting.\n\nACE: ##$pro##\nYour rate of fire is increased by ##25%## while firing from the hip with single shot Shotguns.",
		menu_shotgun_cqb_beta_desc = "BASIC: ##$basic##\nYou reload Shotguns ##15%## faster.\n\nACE: ##$pro##\nYou reload Shotguns ##35%## faster.",
		menu_shotgun_impact_beta = "Shotgun expert",
		menu_shotgun_impact_beta_desc = "BASIC: ##$basic##\nYou gain ##125%## increased steel sight zoom speed when using shotguns.\nYou gain ##15%## better stability with all shotguns.\n\nACE: ##$pro##\nYou gain ##40%## better stability with all shotguns.",
		menu_steady_grip_beta_desc = "BASIC: ##$basic##\nYou gain ##4## weapon Stability.\n\nACE: ##$pro##\nYou gain ##8## more weapon Stability, for a total of ##12##.",
		menu_stable_shot_beta_desc = "BASIC: ##$basic##\nYou gain ##4## weapon Accuracy.\n\nACE: ##$pro##\nYou gain ##4## more weapon Accuracy, for a total of ##8##.",
		menu_sharpshooter_beta = "Slow and Steady",
		menu_sharpshooter_beta_desc = "BASIC: ##$basic##\nYou gain ##5%## damage resistance while standing still or bipoded.\n\nACE: ##$pro##\nYou gain extra ##35%## damage resistance while bipoded.\nYour bipod deploy speed is increased by ##100%##.",
		menu_rifleman_beta = "Agile Marksman",
		menu_rifleman_beta_desc = "BASIC: ##$basic##\nYour snap to zoom is ##100%## faster with all weapons.\n\nYour weapon zoom level is increased by ##25%## with all weapons.\n\nACE: ##$pro##\nWhile aiming down sights your movement speed is unhindered.\n\nYour ##25%## accuracy penalty while ##moving and aiming## is removed.",
		menu_fire_control_beta_desc = "BASIC: ##$basic##\nYou gain ##12## weapon accuracy while firing from the hip.\n\nACE: ##$pro##\nYour ##25%## accuracy penalty while ##moving and hip-firing## is removed.",
		menu_dance_instructor_desc = "BASIC: ##$basic##\nYour pistol magazine sizes are increased by ##5## bullets.\n\nACE: ##$pro##\nYou gain ##20%## increased rate of fire with pistols.",
		menu_bandoliers_beta_desc = "BASIC: ##$basic##\nYour total ammo capacity is increased by ##25%##.\n\nACE: ##$pro##\nIncreases the amount of ammo you gain from ammo boxes by ##75%##.You also gain a base ##10%## chance to get a throwable from an ammo box. The base chance is increased by ##2%## for each ammo box you pick up that does not contain a throwable. When a throwable has been found, the chance is reset to its base value.\n\nNote: Does not stack with the perk skill 'Walk-in Closet'.",
		menu_martial_arts_beta = "Tough Guy",
		menu_steroids_beta = "Martial Arts",
		menu_steroids_beta_desc = "BASIC: ##$basic##\nYou charge your melee weapons ##100%## faster.\n\nACE: ##$pro##\nYou can now sprint while using melee weapons.",
		menu_bloodthirst_desc = "BASIC: ##$basic##\nEvery kill you get will increase your next melee attack damage by ##25%##, up to a maximum of ##700%##. This effect gets reset when you kill an enemy with a melee attack.\n\nACE: ##$pro##\nWhenever you kill an enemy with a melee attack, you will gain a ##50%## increase in reload speed for ##10## seconds.",
		menu_wolverine_beta_desc = "BASIC: ##$basic##\nThe lower your health, the more damage you do. When your health is below ##50%##, you will do up to ##125%## more melee and saw damage.\n\nACE: ##$pro##\nThe lower your health, the more damage you do. When your health is below ##50%##, you will do up to ##100%## more damage with ranged weapons as well.\n\nNote: Does not apply to throwables, grenade launchers or rocket launchers.\n\nEntering berserker state negates third party regeneration effects.",
		menu_sociopathinfil_1_desc = "When you are surrounded by three enemies or more, you receive ##12%## less damage from enemies.\n\nYour second and each consecutive melee hit within ##4## seconds of the last one will deal ##75%## more damage.\n",
		menu_up_you_go_beta_desc = "BASIC: ##$basic##\nYou take ##30%## less damage for ##10## seconds after being revived.\n\nACE: ##$pro##\nYou receive additonal ##35%## of your maximum health when revived.\n\nNote: This adds up to about ##75%## health on difficulties lower then Mayhem, and ##45%## health on all difficulties above and including Mayhem.",
		menu_body_expertise_beta_desc = "BASIC: ##$basic##\n##25%## from the bonus headshot damage is permanently applied to hitting enemies on the body. This skill is only activated by SMGs, LMGs, Assault Rifles or Special Weapons fired in automatic mode.\n\nACE: ##$pro##\n##50%## from the bonus headshot damage is permanently applied to hitting enemies on the body. This skill is only activated by SMGs, LMGs, Assault Rifles or Special Weapons fired in automatic mode.\n\nGilza note: due to how this skill calculates additional bodyshot damage, you can think of basic version of the skill giving you ##1.5x## times the damage on bodyshots, and aced version giving you ##2x## times the damage, since normally, headshots in Gilza deal ##3x## damage to every enemy, except for cloakers and bulldozers.",
		menu_dance_instructor_desc = "BASIC: ##$basic##\nYou gain ##20%## increased rate of fire with pistols.\n\nACE: ##$pro##\nYour pistol magazine sizes are increased by ##8## bullets.",
		menu_gun_fighter_beta = "Bottomless pockets",
		menu_gun_fighter_beta_desc = "BASIC: ##$basic##\nYou gain ##15%## more reserve ammunition with all pistols.\n\nACE: ##$pro##\nYou gain ##50%## more reserve ammunition with all pistols.\n\nGilza note: both versions stack with akimbo ammo reserve increasing skills.",
		
		menu_deck_brawler = "Brawler",
		menu_deck_brawler_desc = "Gage tipped Bain off about a new shipment of experimental lightweight high power armor suits being transported by Murkywater to one of their facitilies. And who are you, if not THE fucking payday gang? Of course you had to steal it! But after properly inspecting them in your safe house, you found out that they are extremely bulky, yet still somehow comfortable to run around in.\n\nThis, is how you became... THE BRAWLER!",
		menu_deck_brawler1 = "Armor suit upgrade",
		menu_deck_brawler1_desc = "Using this high profile armor suit with any kind of a chest rig is pretty much imposible due to it's form and size. But who needs them, right?\n\nYour total ammo capacity is reduced by ##85%##.\n\nArmor movement penalty is reduced by ##20%##.\n\nYou gain ##18%## bullet damage resistance.",
		menu_deck_brawler3 = "High level armor plates",
		menu_deck_brawler3_desc = "You gain ##18%## more bullet damage resistance.",
		menu_deck_brawler5 = "Lightweight armor plates",
		menu_deck_brawler5_desc = "Armor movement penalty is reduced by additional ##20%##.",
		menu_deck_brawler7 = "Max level armor plates",
		menu_deck_brawler7_desc = "You gain ##18%## more bullet damage resistance.",
		menu_deck_brawler9 = "Meat shield",
		menu_deck_brawler9_desc = "You are ##15%## more likely to be targeted when you are close to your crew members.\n\nSecuring a kill with a melee weapon grants you ##75## points of armor.\n\nWhen you are under ##50%## health you recieve following bonuses:\n- Every enemy further then ##9## meters away from you deals ##18%## less damage\n- Every enemy further then ##16## meters away from you deals ##16%## less damage\n\nAll perk resistance bonuses stack, so enemies beyond ##16## meters will only deal ##12%## damage.\n\nDeck Completion Bonus: Your chance of getting a higher quality item during a Payday is increased by ##10%##.",
		
		-- weaponary
		-- shotgun ammo 
		bm_wpn_fps_upg_a_rip_desc_new = "Poisoned bullet that deals damage over time and can interrupt enemies if they are close enough.\n\nDeals 400 damage over 2 seconds, with a damage tick every 0.5 seconds.\n\nAmmo pick up reduced by 20%",
		bm_wpn_fps_upg_a_custom_desc_new = "Bigger pellets with more impact.\nAmmo pick up reduced by 20%",
		bm_wpn_fps_upg_a_explosive_desc_new = "Fires one explosive charge that kills or stuns targets.\nNo extra headshot damage.\nAmmo pick up reduced by 60%",
		bm_wpn_fps_upg_a_piercing_desc_new = "Peirces enemy body armor. Damage range increased.\nAmount of darts per shell - 5",
		bm_wpn_fps_upg_a_slug_desc_new = "Fires a single lead slug that penetrates body armor, enemies, shields and walls.\nAmmo pick up reduced by 25%",
		bm_wpn_fps_upg_a_dragons_breath_desc_new = "Fires pellets that go up in sparks and flames. Burns through shields and body armor.\nNo extra headshot damage.\nDeals 1180 in fire damage.\nAmmo pick up reduced by 80%",
		
		bm_wpn_fps_ass_g3_b_sniper_desc = "ACTUAL RATE OF FIRE: 450\nPierce enemy body armor, shields and walls. Ammo pick up decreased.",
		bm_wpn_fps_ass_g3_b_short_desc = "ACTUAL RATE OF FIRE: 850\nClose quaters assault kit. Ammo pick up increased.",
		bm_wpn_fps_upg_ar_ap_rounds = "AP rounds",
		bm_wpn_fps_upg_ar_ap_rounds_desc = "Pierce enemy body armor, shields and walls.\n\nAmmo pick up is reduced, but not as much as full on AP kits.",
		bm_wpn_fps_upg_smg_ap_rounds = "AP rounds",
		bm_wpn_fps_upg_smg_ap_rounds_desc = "Pierce enemy shields and body armor.\nAmmo pick up reduced.",
		bm_wpn_fps_upg_pist_ap_rounds = "AP rounds",
		bm_wpn_fps_upg_pist_ap_rounds_desc = "Pierce enemy shields and body armor.\nAmmo pick up reduced.",
		bm_wpn_fps_upg_762_to_556_kit = "5.56 Conversion kit",
		bm_wpn_fps_upg_762_to_556_kit_desc = "Convers current weapon's reciever to support 5.56 caliber ammunition.\nAmmo pick up increased.\n\n(Pretend that it actually changes the reciever and the mag visually, so its even cooler)",
		bm_wpn_fps_upg_br_shtgn = "Breaching round",
		bm_wpn_fps_upg_br_shtgn_desc = "Allows you to breach everything that saw OVE9000 usually can. Can also penetrate shield and body armor.\nDamage drop off is significantly worse.\n", 
		bm_wpn_fps_smg_mp5_m_straight_R = "RIP rounds",
		wpn_fps_ass_shak12_body_vks_R = "KS12 Armor Piercing Kit",
		bm_wpn_fps_fla_mk2_mag_rare_desc = "Less direct firepower but more afterburn damage.\n75% chance to start afterburn damage that deals 700 damage over 3 seconds.\nBase flamethrower values: 25% chance for 300dmg over 2 seconds.",
		bm_wpn_fps_fla_mk2_mag_welldone_desc = "More direct firepower but less afterburn damage.\n5% chance to start afterburn damage that deals 150 damage over 1 second.\nBase flamethrower values: 25% chance for 300dmg over 2 seconds.",
		bm_wpn_fps_upg_a_grenade_launcher_incendiary_desc = "Upon impact creates a fire field that lasts for 10 seconds.\nEnemies that come in contact with fire, recieve 1000dmg over 3 seconds, or even more if they stay inside the ring of fire.\nAmmo pick-up is drastically reduced.",
		bm_wpn_fps_upg_a_grenade_launcher_poison_desc = "Upon impact deals 100dmg and creates a gas field that lasts for 10 seconds.\nEnemies that come in contact with gas, recieve at max 500dmg over 30 seconds.\nLow kill potential, but is really effective at weakening enemies who haven't come close to you yet.\n\nNote: deals ticks of damage every 0.25s.",
		bm_wpn_fps_upg_a_grenade_launcher_incendiary_arbiter_desc = "Upon impact creates a fire field that lasts for 5 seconds.\nEnemies that come in contact with fire, recieve 800dmg over 3 seconds, or even more if they stay inside the ring of fire.\nAmmo pick-up is drastically reduced.",
		bm_wpn_fps_upg_a_grenade_launcher_poison_arbiter_desc = "Upon impact deals 100dmg and creates a (smaller compared to other launchers) gas field that lasts for 10 seconds.\nEnemies that come in contact with gas, recieve at max 500dmg over 11 seconds.\nLow kill potential, but is really effective at weakening enemies who haven't come close to you yet.",
		bm_wpn_fps_upg_ass_m4_b_beowulf_newname = "M4 Armor Piercing Kit",
		bm_wpn_fps_upg_ass_ak_b_zastava_newname = "AK Armor Piercing Kit",
		bm_wp_akm_b_standard_gold = "Standard AKM Gold Barrel",
		bm_wpn_fps_ass_g3_b_sniper_newname = "Gewehr3 Armor Piercing Kit",
		bm_wpn_fps_ass_g3_b_long_newname = "Standard Gewehr3 Long Barrel",
		bm_wpn_fps_pis_c96_b_long_newname = "C96 Armor Piercing Kit",
		bm_wp_c96_b_standard = "Standard C96 Barrel",
		bm_wpn_fps_anynewassaultkit_desc = "Allows you to penetrate shields, walls and enemy body armor.\nAmmo pick up is reduced.",
		bm_wpn_prj_ace_desc = "Damage: 550\nCan one-shot anyone other then dozers in the head on DW difficulty.\n",
		bm_grenade_frag_desc = "Damage: 5000\nRange: 350\n\nVanilla PD2 grenade range: 500\n",
		bm_wpn_prj_four_desc = "Damage: 200\nDeals enough poison damage to finish off every enemy except for cloaker/dozer.\nClarification: can actually finish off cloakers if you land shuriken in the head.\n",
		bm_wpn_prj_hur_desc = "Damage: 1300\nCan one-shot heavy swat in the body on DW difficulty.\n",
		bm_wpn_prj_jav_desc = "Damage: 8000\nCan two-shot non-minigun dozers on DW difficulty.\n",
		bm_wpn_prj_target_desc = "Damage: 700\nCan one-shot normal swat in the body on DW difficulty.\n",
		bm_concussion_desc = "No changes compared to base game other then the max amount.\n",
		bm_dynamite_desc = "Damage: 2500\nRange: 700\n\nVanilla PD2 grenade range: 500\n",
		bm_grenade_frag_com_desc = "Damage: 5000\nRange: 350\n\nVanilla PD2 grenade range: 500\n",
		bm_grenade_sticky_grenade_desc = "Damage: 2000\nRange: 350\n\nBase game sticky damage and range: 1200 and 500\nShould be a bit more of a skill shot nade. Amounts are kept the same to compensate.",
		bm_grenade_xmas_snowball_desc = "Damage: 400\nRange: 100\n\nBase game snowball damage: 280\nShould feel roughly the same considering Gilza's health pool changes.",
		bm_grenade_fir_com_desc = "Damage: 1000 direct + 1500 with afterburn over 2 seconds.\n",
		bm_grenade_dada_com_desc = "Damage: 5000\nRange: 350\n\nVanilla PD2 grenade range: 500\n",
		bm_grenade_molotov_desc = "No direct damage, creates a fire ring for 15 seconds. Any enemy that comes in contact with fire recieves 700 damage over 3 seconds.\nIf enemy doesn't get out of the circle they will recieve roughly 8000 damage overall.\n",
		bm_grenade_electric_desc = "Zap-zap.\nNo changes compared to base game other then the max amount.\n",
		bm_grenade_poison_gas_grenade_desc = "Damage: 100 direct + 300 over 30 seconds. Cloud lasts for 20 seconds.\n",
		bm_wp_upg_a_grenade_launcher_velocity = "High Velocity Round",
		bm_wp_upg_a_grenade_launcher_velocity_desc = "Increases grenade velocity to 300%, but decreases blast radius to 50%.",
		wpn_fps_ass_hcar_barrel_dmr_PEN = "Akron HC AP Kit",
		bm_wpn_fps_ass_hcar_barrel_dmr_PEN_desc = "Allows you to penetrate enemy body armor and walls.\nLimits weapon to single-fire mode.\nAmmo pick up reduced.",
		bm_wp_hcar_barrel_standard = "Standard Akron HC Barrel"
	})
end)