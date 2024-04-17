-- changes to all weapon attachments and addition of some new ones
Hooks:PostHook(WeaponFactoryTweakData, "init", "Gilza_weapon_attachments_data", function(self, ...)
	
	local function init_new_mods()
		-- shotgun breach round
		self.parts.wpn_fps_upg_br_shtgn.name_id = "bm_wpn_fps_upg_br_shtgn"
		self.parts.wpn_fps_upg_br_shtgn.desc_id = "bm_wpn_fps_upg_br_shtgn_desc"
		self.parts.wpn_fps_upg_br_shtgn.forbids = {"wpn_fps_sho_m590_b_suppressor", "wpn_fps_upg_ns_shot_thick", "wpn_fps_upg_ns_sho_salvo_large"}
		self.parts.wpn_fps_upg_br_shtgn.stats = {value = 0,damage = -125,spread = -10}
		self.parts.wpn_fps_upg_br_shtgn.custom_stats = {
			rays = 1,
			damage_near_mul = 0.5,
			damage_far_mul = 0.5,
			armor_piercing_add = 1,
			can_shoot_through_shield = true,
			can_breach = true
		}
		-- AP rounds for galant and m14 - ammo cut is under individual wpn tweaks
		self.parts.wpn_fps_upg_ar_dmr_ap_rounds.name_id = "bm_wpn_fps_upg_ar_dmr_ap_rounds"
		self.parts.wpn_fps_upg_ar_dmr_ap_rounds.desc_id = "bm_wpn_fps_upg_ar_dmr_ap_rounds_desc"
		self.parts.wpn_fps_upg_ar_dmr_ap_rounds.stats = {value = 0,spread = -4,recoil = -3}
		self.parts.wpn_fps_upg_ar_dmr_ap_rounds.custom_stats = {armor_piercing_add = 1,can_shoot_through_shield = true,can_shoot_through_wall = true,ammo_pickup_max_mul = 0.5,ammo_pickup_min_mul = 0.5}
		-- ammo that ap kits add to the gun, invisible in the blackmarket menus
		self.parts.wpn_fps_upg_ap_kit_ap_rounds.name_id = "bm_wpn_fps_upg_ap_kit_ap_rounds"
		self.parts.wpn_fps_upg_ap_kit_ap_rounds.stats = {}
		self.parts.wpn_fps_upg_ap_kit_ap_rounds.custom_stats = {armor_piercing_add = 1,can_shoot_through_shield = true,can_shoot_through_wall = true,ammo_pickup_max_mul = 0.5,ammo_pickup_min_mul = 0.5}
		-- ammo that C96 ap kit adds to the gun, invisible in the blackmarket menus
		self.parts.wpn_fps_upg_c96_ap_kit_ap_rounds.name_id = "bm_wpn_fps_upg_ap_kit_ap_rounds"
		self.parts.wpn_fps_upg_c96_ap_kit_ap_rounds.stats = {}
		self.parts.wpn_fps_upg_c96_ap_kit_ap_rounds.custom_stats = {armor_piercing_add = 1,can_shoot_through_shield = true,can_shoot_through_wall = true,ammo_pickup_max_mul = 0.3,ammo_pickup_min_mul = 0.3}
		-- p90 AP rounds
		self.parts.wpn_fps_upg_smg_p90_ap_rounds.name_id = "bm_wpn_fps_upg_smg_p90_ap_rounds"
		self.parts.wpn_fps_upg_smg_p90_ap_rounds.desc_id = "bm_wpn_fps_upg_smg_p90_ap_rounds_desc"
		self.parts.wpn_fps_upg_smg_p90_ap_rounds.stats = {value = 0,total_ammo_mod = -5,spread = -5,recoil = -3}
		self.parts.wpn_fps_upg_smg_p90_ap_rounds.custom_stats = {can_shoot_through_shield = true,armor_piercing_add = 1,ammo_pickup_max_mul = 0.5,ammo_pickup_min_mul = 0.5}
		-- mateba 357 ap
		self.parts.wpn_fps_upg_pist_mateba_ap_rounds.name_id = "bm_wpn_fps_upg_pist_mateba_ap_rounds"
		self.parts.wpn_fps_upg_pist_mateba_ap_rounds.desc_id = "bm_wpn_fps_upg_pist_mateba_ap_rounds_desc"
		self.parts.wpn_fps_upg_pist_mateba_ap_rounds.stats = {value = 0,total_ammo_mod = -5,spread = -4,recoil = -3}
		self.parts.wpn_fps_upg_pist_mateba_ap_rounds.custom_stats = {can_shoot_through_shield = true,armor_piercing_add = 1,ammo_pickup_max_mul = 0.5,ammo_pickup_min_mul = 0.5}
		-- little friend's 762 to 556 conversion kit
		self.parts.wpn_fps_upg_contraband_762_to_556_kit.name_id = "bm_wpn_fps_upg_contraband_762_to_556_kit"
		self.parts.wpn_fps_upg_contraband_762_to_556_kit.desc_id = "bm_wpn_fps_upg_contraband_762_to_556_kit_desc"
		self.parts.wpn_fps_upg_contraband_762_to_556_kit.stats = {value = 0,total_ammo_mod = 8,extra_ammo = 5,damage = -250,spread = -1,recoil = 3}
		self.parts.wpn_fps_upg_contraband_762_to_556_kit.custom_stats = {ammo_pickup_min_mul = 2.65,ammo_pickup_max_mul = 2.64}
		-- m4 250 damage profile kit
		self.parts.wpn_fps_upg_ak_hp_rounds.name_id = "wpn_fps_upg_ak_hp_rounds"
		self.parts.wpn_fps_upg_ak_hp_rounds.desc_id = "wpn_fps_upg_ak_hp_rounds_desc"
		self.parts.wpn_fps_upg_ak_hp_rounds.stats = {value = 0,damage = 200,spread = -2,recoil = -3}
		self.parts.wpn_fps_upg_ak_hp_rounds.custom_stats = {ammo_pickup_min_mul = 0.613,ammo_pickup_max_mul = 0.618}
		-- akm's 450 damage profile kit
		self.parts.wpn_fps_upg_m4_hp_rounds.name_id = "wpn_fps_upg_m4_hp_rounds"
		self.parts.wpn_fps_upg_m4_hp_rounds.desc_id = "wpn_fps_upg_m4_hp_rounds_desc"
		self.parts.wpn_fps_upg_m4_hp_rounds.stats = {value = 0,damage = 95,spread = -4,recoil = -3}
		self.parts.wpn_fps_upg_m4_hp_rounds.custom_stats = {ammo_pickup_min_mul = 0.551,ammo_pickup_max_mul = 0.55}
		-- groza's 762 to 5.45 conversion kit
		self.parts.wpn_fps_upg_groza_762_to_545_kit.name_id = "bm_wpn_fps_upg_groza_762_to_545_kit"
		self.parts.wpn_fps_upg_groza_762_to_545_kit.desc_id = "bm_wpn_fps_upg_groza_762_to_545_kit_desc"
		self.parts.wpn_fps_upg_groza_762_to_545_kit.stats = {value = 0,total_ammo_mod = 4,damage = -95,spread = -2,recoil = 4}
		self.parts.wpn_fps_upg_groza_762_to_545_kit.custom_stats = {ammo_pickup_min_mul = 1.81,ammo_pickup_max_mul = 1.81}
		-- new velocity nade for standard launchers
		self.parts.wpn_fps_upg_a_grenade_launcher_velocity = deep_clone(self.parts.wpn_fps_upg_a_grenade_launcher_incendiary)
		self.parts.wpn_fps_upg_a_grenade_launcher_velocity.dlc = nil
		self.parts.wpn_fps_upg_a_grenade_launcher_velocity.texture_bundle_folder = "Gilza"
		self.parts.wpn_fps_upg_a_grenade_launcher_velocity.is_a_unlockable = false
		self.parts.wpn_fps_upg_a_grenade_launcher_velocity.drop = false
		self.parts.wpn_fps_upg_a_grenade_launcher_velocity.global_value = "Gilza"
		self.parts.wpn_fps_upg_a_grenade_launcher_velocity.name_id = "bm_wp_upg_a_grenade_launcher_velocity"
		self.parts.wpn_fps_upg_a_grenade_launcher_velocity.desc_id = "bm_wp_upg_a_grenade_launcher_velocity_desc"
		self.parts.wpn_fps_upg_a_grenade_launcher_velocity.stats = {}
		-- to avoid issues with ammo pick up check for whenever you are a client, numbers will be a bit fucky
		self.parts.wpn_fps_upg_a_grenade_launcher_velocity.custom_stats = {launcher_grenade = "launcher_velocity", ammo_pickup_min_mul = 0.799986, ammo_pickup_max_mul = 0.799986}
		self.parts.wpn_fps_upg_a_grenade_launcher_velocity.sub_type = "ammo_explosive"
		self.parts.wpn_fps_upg_a_grenade_launcher_velocity.override = {}
		local weapons = {
			"wpn_fps_gre_m79",
			"wpn_fps_gre_m32",
			"wpn_fps_gre_china",
			"wpn_fps_gre_slap"
		}
		for _, factory_id in ipairs(weapons) do
			if self[factory_id] and self[factory_id].uses_parts then
				table.insert(self[factory_id].uses_parts, "wpn_fps_upg_a_grenade_launcher_velocity")
			end
		end
		-- new velocity nade for underbarrel launchers
		self.parts.wpn_fps_upg_a_underbarrel_velocity_frag = deep_clone(self.parts.wpn_fps_upg_a_underbarrel_frag_groza)
		self.parts.wpn_fps_upg_a_underbarrel_velocity_frag.dlc = nil
		self.parts.wpn_fps_upg_a_underbarrel_velocity_frag.texture_bundle_folder = "Gilza"
		self.parts.wpn_fps_upg_a_underbarrel_velocity_frag.is_a_unlockable = false
		self.parts.wpn_fps_upg_a_underbarrel_velocity_frag.drop = false
		self.parts.wpn_fps_upg_a_underbarrel_velocity_frag.global_value = "Gilza"
		self.parts.wpn_fps_upg_a_underbarrel_velocity_frag.name_id = "bm_wp_upg_a_grenade_launcher_velocity"
		self.parts.wpn_fps_upg_a_underbarrel_velocity_frag.sub_type = "ammo_explosive"
		self.parts.wpn_fps_upg_a_underbarrel_velocity_frag.desc_id = "bm_wp_upg_a_underbarrel_velocity_frag_desc"
		self.parts.wpn_fps_upg_a_underbarrel_velocity_frag.custom_stats = {launcher_grenade = "underbarrel_velocity_frag", ammo_pickup_min_mul = 0.799986, ammo_pickup_max_mul = 0.799986}
		local weapons_withGL = {
			"wpn_fps_ass_groza",
			"wpn_fps_ass_contraband"
		}
		for _, factory_id in ipairs(weapons_withGL) do
			if self[factory_id] and self[factory_id].uses_parts then
				table.insert(self[factory_id].uses_parts, "wpn_fps_upg_a_underbarrel_velocity_frag")
			end
		end
		
	end
	init_new_mods()
	
	-- every mod that is not single gun exclusive
	local function init_general_mods()
	
		-- remove spread_moving stat from ALL weapon parts, because this mechanic is not used in this mod anymore
		for id, tbl in pairs(self.parts) do
			if self.parts[id].stats and self.parts[id].stats.spread_moving then
				self.parts[id].stats.spread_moving = nil
			end
		end
		
		-- Scopes
		local function general_sights()
			
			-- list for sniper stat overrides
			local sights_list = {}
			-- all sight's stats are now 0 cuz they should be chosen based on personal preference, not stats
			for id, _table_ in pairs(self.parts) do
				if self.parts[id].type then
					if self.parts[id].type == "sight" or self.parts[id].type == "second_sight" then
						if self.parts[id].stats then
							if self.parts[id].stats.recoil or self.parts[id].stats.spread then
								self.parts[id].stats.recoil = 0
								self.parts[id].stats.spread = 0
							end
							if self.parts[id].type == "sight" then
								table.insert(sights_list, tostring(id))
							end
						end
					end
				end
			end
			
			-- since overkill added a pay to win 0 concealment scope in a dlc, we might as well allow some other scopes to have 0 concealment for variety
			self.parts.wpn_fps_upg_o_eotech_xps.stats.concealment = 0
			self.parts.wpn_fps_upg_o_docter.stats.concealment = 0
			
			-- removing the default sniper scope so it doesnt have -3 by default, and also removing the winchester's scope, since it starts without a scope by default, so getting -3 makes sense
			table.delete(sights_list,"wpn_fps_upg_o_shortdot")
			table.delete(sights_list,"wpn_fps_upg_o_shortdot_vanilla")
			table.delete(sights_list,"wpn_fps_upg_winchester_o_classic")
			
			local snipers = {
				"wpn_fps_snp_msr",
				"wpn_fps_snp_r700",
				"wpn_fps_snp_sbl",
				"wpn_fps_snp_qbu88",
				"wpn_fps_snp_awp",
				"wpn_fps_snp_model70",
				"wpn_fps_snp_wa2000",
				"wpn_fps_snp_desertfox",
				"wpn_fps_snp_tti",
				"wpn_fps_snp_r93",
				"wpn_fps_snp_winchester",
				"wpn_fps_snp_siltstone",
				"wpn_fps_snp_mosin",
				"wpn_fps_snp_m95",
				"wpn_fps_snp_scout",
				"wpn_fps_snp_contender",
				"wpn_fps_snp_victor"
			}
			-- override all scopes on snipers to have postitive concealment since we remove the default big scope. amount depends on scope's concealment stat
			for i=1, #snipers do
				if self[snipers[i]] then
					if not self[snipers[i]].override then
						self[snipers[i]].override = {}
					end
					for j=1, #sights_list do
						self[snipers[i]].override[sights_list[j]] = {stats = deep_clone(self.parts[sights_list[j]].stats)}
						if not self.parts[sights_list[j]].stats.concealment or self.parts[sights_list[j]].stats.concealment >= 0 then
							self[snipers[i]].override[sights_list[j]].stats.concealment = 3
						elseif self.parts[sights_list[j]].stats.concealment == -1 then
							self[snipers[i]].override[sights_list[j]].stats.concealment = 2
						elseif self.parts[sights_list[j]].stats.concealment == -2 then
							self[snipers[i]].override[sights_list[j]].stats.concealment = 1
						elseif self.parts[sights_list[j]].stats.concealment == -3 then
							self[snipers[i]].override[sights_list[j]].stats.concealment = 0
						else
							self[snipers[i]].override[sights_list[j]].stats.concealment = -1
						end
					end
				end
			end
			
			-- secondary sights' concealment 'logic-based tweaks', because a canted sight can not give you a higher concealment stat overkilll
			self.parts.wpn_fps_upg_o_45rds_v2.stats.concealment = -1
			self.parts.wpn_fps_upg_o_xpsg33_magnifier.stats.concealment = -1
			self.parts.wpn_fps_upg_o_45rds.stats.concealment = -1
			self.parts.wpn_fps_upg_o_45steel.stats.concealment = 0
			self.parts.wpn_fps_upg_o_sig.stats.concealment = -1
		end
		general_sights()
		
		-- muzzle devices
		local function general_MD()
			self.parts.wpn_fps_upg_ns_ass_smg_tank.stats.recoil = 3
			self.parts.wpn_fps_upg_ns_ass_smg_tank.stats.spread = 1
			self.parts.wpn_fps_upg_ns_ass_smg_tank.stats.damage = 0
			self.parts.wpn_fps_upg_ns_ass_smg_tank.stats.concealment = -2
			self.parts.wpn_fps_upg_ns_ass_smg_tank.stats.suppression = -8
			
			self.parts.wpn_fps_upg_ns_ass_smg_stubby.stats.recoil = 4
			self.parts.wpn_fps_upg_ns_ass_smg_stubby.stats.spread = 0
			self.parts.wpn_fps_upg_ns_ass_smg_stubby.stats.damage = 0
			self.parts.wpn_fps_upg_ns_ass_smg_stubby.stats.concealment = -1
			self.parts.wpn_fps_upg_ns_ass_smg_stubby.stats.suppression = -10
			
			self.parts.wpn_fps_upg_ns_ass_smg_firepig.stats.recoil = 1
			self.parts.wpn_fps_upg_ns_ass_smg_firepig.stats.spread = 1
			self.parts.wpn_fps_upg_ns_ass_smg_firepig.stats.damage = 4
			self.parts.wpn_fps_upg_ns_ass_smg_firepig.stats.suppression = 0
			
			self.parts.wpn_fps_upg_ass_ns_linear.stats.recoil = 3
			self.parts.wpn_fps_upg_ass_ns_linear.stats.spread = 2
			self.parts.wpn_fps_upg_ass_ns_linear.stats.damage = -2
			self.parts.wpn_fps_upg_ass_ns_linear.stats.concealment = -5
			self.parts.wpn_fps_upg_ass_ns_linear.stats.suppression = 0
			
			self.parts.wpn_fps_upg_ass_ns_battle.stats.recoil = 6
			self.parts.wpn_fps_upg_ass_ns_battle.stats.spread = -3
			self.parts.wpn_fps_upg_ass_ns_battle.stats.damage = 0
			self.parts.wpn_fps_upg_ass_ns_battle.stats.concealment = -3
			self.parts.wpn_fps_upg_ass_ns_battle.stats.suppression = 3
			
			self.parts.wpn_fps_upg_ns_ass_pbs1.stats.spread = 2
			self.parts.wpn_fps_upg_ns_ass_pbs1.stats.recoil = 2
			self.parts.wpn_fps_upg_ns_ass_pbs1.stats.damage = -1
			self.parts.wpn_fps_upg_ns_ass_pbs1.stats.concealment = -6
			
			self.parts.wpn_fps_lmg_hk51b_ns_jcomp.stats.recoil = -2
			self.parts.wpn_fps_lmg_hk51b_ns_jcomp.stats.spread = 4
			self.parts.wpn_fps_lmg_hk51b_ns_jcomp.stats.damage = 0
			self.parts.wpn_fps_lmg_hk51b_ns_jcomp.stats.concealment = -2
			self.parts.wpn_fps_lmg_hk51b_ns_jcomp.stats.suppression = 0
			
			self.parts.wpn_fps_upg_ak_ns_jmac.stats.recoil = 0
			
			self.parts.wpn_fps_lmg_kacchainsaw_ns_muzzle.stats.recoil = 3
			
			self.parts.wpn_fps_upg_ak_ns_tgp.stats.recoil = 1
			self.parts.wpn_fps_upg_ak_ns_tgp.stats.spread = 2
			
			-- shotgun devices
			self.parts.wpn_fps_upg_ns_shot_shark.stats = {
				spread = 3,
				concealment = -2,
				damage = 1,
				suppression = -3,
				value = 5,
				recoil = -2
			}
			self.parts.wpn_fps_upg_ns_shot_thick.stats = {
				alert_size = 12,
				damage = -3,
				spread = -3,
				suppression = 12,
				value = 7,
				recoil = 4,
				concealment = -3
			}
			self.parts.wpn_fps_upg_shot_ns_king.stats = {
				value = 5,
				concealment = -2,
				damage = 2,
				suppression = -4,
				spread = -2,
				recoil = 4
			}
			self.parts.wpn_fps_upg_ns_sho_salvo_large.stats = {
				alert_size = 12,
				spread = 4,
				damage = -4,
				suppression = 12,
				value = 7,
				recoil = -3,
				concealment = -3
			}
			self.parts.wpn_fps_upg_ns_duck.stats = {
				value = 1,
				recoil = 4,
				damage = 3,
				concealment = -2,
				spread = -6,
				spread_multi = {
					2.25,
					0.5
				}
			}
			self.parts.wpn_fps_upg_ns_duck.has_description = true
			self.parts.wpn_fps_upg_ns_duck.desc_id = "wpn_fps_upg_ns_duck_desc"
			
			-- pistol devices
			self.parts.wpn_fps_upg_ns_pis_ipsccomp.stats.recoil = -2
			self.parts.wpn_fps_upg_ns_pis_ipsccomp.stats.concealment = -2
			self.parts.wpn_fps_upg_ns_pis_meatgrinder.stats.damage = 1
			self.parts.wpn_fps_upg_ns_pis_meatgrinder.stats.spread = -2
			self.parts.wpn_fps_upg_ns_pis_meatgrinder.stats.recoil = 3
			self.parts.wpn_fps_upg_pis_ns_flash.stats.damage = nil
			self.parts.wpn_fps_upg_pis_ns_flash.stats.recoil = 1
			self.parts.wpn_fps_upg_pis_ns_flash.stats.spread = 1
			self.parts.wpn_fps_upg_ns_pis_typhoon.stats.damage = -11
			self.parts.wpn_fps_upg_ns_pis_typhoon.stats.spread = 2
			self.parts.wpn_fps_upg_ns_pis_typhoon.stats.recoil = 2
			self.parts.wpn_fps_upg_ns_pis_typhoon.stats.concealment = -2
			self.parts.wpn_fps_upg_ns_pis_large_kac.stats.recoil = nil
			self.parts.wpn_fps_upg_ns_pis_medium.stats.recoil = 2
			self.parts.wpn_fps_upg_ns_pis_large.stats.recoil = 3
			self.parts.wpn_fps_upg_ns_pis_medium_slim.stats.spread = -1
		end
		general_MD()
		
		-- Barrels
		local function general_barrels()
			-- AK barrels
			self.parts.wpn_fps_upg_ak_b_ak105.stats.value = 1
			self.parts.wpn_fps_upg_ak_b_ak105.stats.concealment = 1
			self.parts.wpn_fps_upg_ak_b_ak105.stats.recoil = 2
			self.parts.wpn_fps_upg_ak_b_ak105.stats.spread = -2
			self.parts.wpn_fps_upg_ak_b_ak105.stats.damage = 1
			self.parts.wpn_fps_upg_ak_b_draco.stats.value = 2
			self.parts.wpn_fps_upg_ak_b_draco.stats.concealment = 1
			self.parts.wpn_fps_upg_ak_b_draco.stats.recoil = 3
			self.parts.wpn_fps_upg_ak_b_draco.stats.spread = -3
			self.parts.wpn_fps_upg_ak_b_draco.stats.damage = 3
			self.parts.wpn_fps_upg_ak_b_draco.stats.reload = 2
			-- AK dmr kit, this stuff is used by akm's, ak74 has an override
			self.parts.wpn_fps_upg_ass_ak_b_zastava.stats = {
				value = 1,
				concealment = -4,
				spread = 3,
				recoil = -5
			}
			self.parts.wpn_fps_upg_ass_ak_b_zastava.override_weapon = {_meta = "override_weapon", AMMO_MAX = 120}
			self.parts.wpn_fps_upg_ass_ak_b_zastava.custom_stats = {}
			self.parts.wpn_fps_upg_ass_ak_b_zastava.adds = {"wpn_fps_upg_ap_kit_ap_rounds"}
			self.parts.wpn_fps_upg_ass_ak_b_zastava.name_id = "bm_wpn_fps_upg_ass_ak_b_zastava_newname"
			self.parts.wpn_fps_upg_ass_ak_b_zastava.has_description = true
			self.parts.wpn_fps_upg_ass_ak_b_zastava.desc_id = "bm_wpn_fps_upg_ar_ap_kit_desc"
			self.parts.wpn_fps_upg_ass_ak_b_zastava.forbids = {"wpn_fps_upg_ak_hp_rounds"}
			-- M4 barrels
			self.parts.wpn_fps_m4_uupg_b_long.stats = {
				value = 4,
				concealment = -3,
				spread = 2,
				recoil = -1
			}
			-- M4 dmr kit
			self.parts.wpn_fps_upg_ass_m4_b_beowulf.stats = {
				concealment = -4,
				value = 1,
				spread = 3,
				recoil = -4
			}
			self.parts.wpn_fps_upg_ass_m4_b_beowulf.override_weapon = {_meta = "override_weapon", AMMO_MAX = 150}
			self.parts.wpn_fps_upg_ass_m4_b_beowulf.custom_stats = {}
			self.parts.wpn_fps_upg_ass_m4_b_beowulf.adds = {"wpn_fps_upg_ap_kit_ap_rounds"}
			self.parts.wpn_fps_upg_ass_m4_b_beowulf.name_id = "bm_wpn_fps_upg_ass_m4_b_beowulf_newname"
			self.parts.wpn_fps_upg_ass_m4_b_beowulf.has_description = true
			self.parts.wpn_fps_upg_ass_m4_b_beowulf.desc_id = "bm_wpn_fps_upg_ar_ap_kit_desc"
			table.insert(self.parts.wpn_fps_upg_ass_m4_b_beowulf.forbids, "wpn_fps_upg_m4_hp_rounds")
		end
		general_barrels()
		
		-- Gadgets, mostly for descriptions
		local function general_gadgets()
			self.parts.wpn_fps_upg_fl_ass_smg_sho_surefire.has_description = true
			self.parts.wpn_fps_upg_fl_ass_smg_sho_surefire.desc_id = "bm_flashlight_gadget_module"
			
			self.parts.wpn_fps_upg_fl_ass_smg_sho_peqbox.stats.recoil = 1
			self.parts.wpn_fps_upg_fl_ass_smg_sho_peqbox.has_description = true
			self.parts.wpn_fps_upg_fl_ass_smg_sho_peqbox.desc_id = "bm_laser_gadget_module"
			
			self.parts.wpn_fps_upg_fl_ass_laser.has_description = true
			self.parts.wpn_fps_upg_fl_ass_laser.desc_id = "bm_laser_gadget_module"
			
			self.parts.wpn_fps_upg_fl_ass_peq15.stats.spread = 2
			self.parts.wpn_fps_upg_fl_ass_peq15.stats.recoil = 0
			self.parts.wpn_fps_upg_fl_ass_peq15.has_description = true
			self.parts.wpn_fps_upg_fl_ass_peq15.stats.concealment = -4
			self.parts.wpn_fps_upg_fl_ass_peq15.desc_id = "bm_combined_gadget_module"
			
			self.parts.wpn_fps_upg_fl_ass_utg.stats.recoil = 2
			self.parts.wpn_fps_upg_fl_ass_utg.stats.spread = 1
			self.parts.wpn_fps_upg_fl_ass_utg.stats.concealment = -5
			self.parts.wpn_fps_upg_fl_ass_utg.has_description = true
			self.parts.wpn_fps_upg_fl_ass_utg.desc_id = "bm_combined_gadget_module"
			
			self.parts.wpn_fps_upg_fl_dbal_laser.has_description = true
			self.parts.wpn_fps_upg_fl_dbal_laser.desc_id = "bm_laser_gadget_module"
			
			self.parts.wpn_fps_upg_fl_pis_crimson.has_description = true
			self.parts.wpn_fps_upg_fl_pis_crimson.desc_id = "bm_laser_gadget_module"
			
			self.parts.wpn_fps_upg_fl_pis_x400v.has_description = true
			self.parts.wpn_fps_upg_fl_pis_x400v.desc_id = "bm_combined_gadget_module"
			
			self.parts.wpn_fps_upg_fl_pis_tlr1.stats.concealment = 0
			self.parts.wpn_fps_upg_fl_pis_tlr1.has_description = true
			self.parts.wpn_fps_upg_fl_pis_tlr1.desc_id = "bm_flashlight_gadget_module"
			
			self.parts.wpn_fps_upg_fl_pis_laser.stats.recoil = 1
			self.parts.wpn_fps_upg_fl_pis_laser.stats.spread = -1
			self.parts.wpn_fps_upg_fl_pis_laser.stats.concealment = 0
			self.parts.wpn_fps_upg_fl_pis_laser.has_description = true
			self.parts.wpn_fps_upg_fl_pis_laser.desc_id = "bm_laser_gadget_module"
			
			self.parts.wpn_fps_upg_fl_pis_perst.has_description = true
			self.parts.wpn_fps_upg_fl_pis_perst.desc_id = "bm_laser_gadget_module"
			
			self.parts.wpn_fps_upg_fl_pis_m3x.has_description = true
			self.parts.wpn_fps_upg_fl_pis_m3x.desc_id = "bm_flashlight_gadget_module"
		end
		general_gadgets()
		
		-- Grips
		local function general_grips()
			self.parts.wpn_fps_m4_uupg_g_billet.stats.recoil = 1
			self.parts.wpn_fps_m4_uupg_g_billet.stats.spread = 0
			self.parts.wpn_fps_upg_g_m4_surgeon.stats.concealment = 3
			self.parts.wpn_fps_upg_ak_g_rk9.stats.concealment = -2
			self.parts.wpn_fps_upg_ak_g_edg.stats.concealment = -4
			self.parts.wpn_fps_upg_ak_g_gradus.stats.concealment = 0
			self.parts.wpn_fps_upg_ak_g_gradus.stats.recoil = 1
			self.parts.wpn_fps_upg_ak_g_gradus.stats.spread = 0
			self.parts.wpn_fps_upg_ak_g_rk3.stats.concealment = 0
			self.parts.wpn_fps_upg_ak_g_wgrip.stats.concealment = -3
			self.parts.wpn_fps_upg_ak_g_hgrip.stats.concealment = -1
			self.parts.wpn_fps_upg_ak_g_pgrip.stats.recoil = -1
			self.parts.wpn_fps_upg_ak_g_pgrip.stats.spread = 2
		end
		general_grips()
		
		-- Mags
		local function general_mags()
			self.parts.wpn_fps_m4_uupg_m_std.override_weapon = {_meta = "override_weapon", CLIP_AMMO_MAX = 30}
			self.parts.wpn_fps_m4_uupg_m_std.stats.extra_ammo = nil
			self.parts.wpn_fps_m4_uupg_m_std.stats.spread = -1
			self.parts.wpn_fps_m4_uupg_m_std.stats.concealment = nil
			self.parts.wpn_fps_m4_uupg_m_strike.stats.recoil = 1
			self.parts.wpn_fps_m4_uupg_m_strike.stats.spread = -2
			self.parts.wpn_fps_m4_uupg_m_strike.stats.reload = 1
			self.parts.wpn_fps_m4_uupg_m_strike.stats.extra_ammo = 2.5
			self.parts.wpn_fps_m4_upg_m_quick.stats.spread = -2
			self.parts.wpn_fps_upg_m4_m_l5.stats.extra_ammo = -1
			self.parts.wpn_fps_upg_m4_m_l5.stats.reload = 4
			self.parts.wpn_fps_ass_l85a2_m_emag.stats.extra_ammo = 0
			self.parts.wpn_fps_upg_m4_m_pmag.stats.extra_ammo = 0
			self.parts.wpn_fps_upg_m4_m_pmag.stats.spread = 1
			self.parts.wpn_fps_upg_m4_m_straight.stats.extra_ammo = -5
			self.parts.wpn_fps_upg_m4_m_straight.stats.reload = 6
			self.parts.wpn_fps_upg_m4_m_straight.stats.concealment = 3
			self.parts.wpn_fps_upg_m4_m_quad.stats.recoil = 4
			self.parts.wpn_fps_upg_m4_m_quad.stats.spread = -3
			self.parts.wpn_fps_upg_m4_m_quad.stats.concealment = -4
			self.parts.wpn_fps_upg_m4_m_quad.stats.reload = -6
			self.parts.wpn_fps_upg_ak_m_uspalm.stats.extra_ammo = 0
			self.parts.wpn_fps_upg_ak_m_quad.stats.recoil = 4
			self.parts.wpn_fps_upg_ak_m_quad.stats.spread = -3
			self.parts.wpn_fps_upg_ak_m_quad.stats.concealment = -4
			self.parts.wpn_fps_upg_ak_m_quad.stats.reload = -6
			self.parts.wpn_fps_upg_ak_m_quick.stats.spread = -2
			-- glock mag
			self.parts.wpn_fps_pis_g18c_m_mag_33rnd.stats.reload = -4
			self.wpn_fps_pis_x_g17.override.wpn_fps_pis_g18c_m_mag_33rnd.stats.reload = -8
		end
		general_mags()
		
		-- Stocks
		local function general_stocks()
			self.parts.wpn_fps_snp_tti_s_vltor.stats.spread = 3
			self.parts.wpn_fps_snp_tti_s_vltor.stats.concealment = -4
			self.parts.wpn_fps_snp_victor_s_mod0.stats.spread = 1
			self.parts.wpn_fps_snp_victor_s_mod0.stats.recoil = 1
			self.parts.wpn_fps_snp_victor_s_mod0.stats.concealment = 0
			self.parts.wpn_fps_sho_sko12_stock.stats.recoil = 1
			self.parts.wpn_fps_sho_sko12_stock.stats.spread = 0
			self.parts.wpn_fps_sho_sko12_stock.stats.reload = 2
			self.parts.wpn_fps_m4_uupg_s_zulu.stats.reload = 2
			self.parts.wpn_fps_upg_m4_s_mk46.stats.recoil = 1
			self.parts.wpn_fps_upg_m4_s_mk46.stats.spread = 0
			self.parts.wpn_fps_upg_m4_s_mk46.stats.reload = 2
			self.parts.wpn_fps_upg_m4_s_pts.stats.reload = 4
			self.parts.wpn_upg_ak_s_psl.stats.recoil = 6
			self.parts.wpn_upg_ak_s_psl.stats.spread = 3
			self.parts.wpn_upg_ak_s_psl.stats.concealment = -10
			self.parts.wpn_upg_ak_s_psl.stats.reload = -2
			self.parts.wpn_fps_ass_fal_s_03.stats.recoil = 2
			self.parts.wpn_fps_ass_fal_s_03.stats.spread = 2
			self.parts.wpn_fps_ass_fal_s_03.stats.concealment = -3
			self.parts.wpn_fps_ass_fal_s_wood.stats.recoil = 3
			self.parts.wpn_fps_ass_fal_s_wood.stats.spread = 1
			self.parts.wpn_fps_ass_fal_s_wood.stats.concealment = -3
		end
		general_stocks()
		
		-- Foregrips
		local function general_foregrips()
			self.parts.wpn_fps_uupg_fg_radian.stats.reload = -3
			self.parts.wpn_fps_uupg_fg_radian.stats.concealment = -3
			self.parts.wpn_fps_upg_ass_m4_fg_moe.stats.damage = 0
			self.parts.wpn_fps_upg_ass_m4_fg_moe.stats.spread = 0
			self.parts.wpn_fps_upg_ass_m4_fg_lvoa.stats.damage = 3
			self.parts.wpn_fps_upg_ass_m4_fg_lvoa.stats.recoil = 5
			self.parts.wpn_fps_upg_ass_m4_fg_lvoa.stats.concealment = -3
			self.parts.wpn_fps_upg_fg_smr.stats.spread = 1
			self.parts.wpn_fps_upg_fg_smr.stats.recoil = 2
			self.parts.wpn_fps_upg_fg_smr.stats.reload = 3
			self.parts.wpn_fps_upg_fg_jp.stats.damage = 0
			self.parts.wpn_fps_upg_fg_jp.stats.recoil = 1
			self.parts.wpn_fps_upg_fg_jp.stats.spread = -1
			self.parts.wpn_fps_upg_fg_jp.stats.concealment = 3
			self.parts.wpn_fps_upg_fg_jp.stats.reload = 2
			self.parts.wpn_fps_m4_uupg_fg_lr300.stats.spread = 1
			self.parts.wpn_upg_ak_fg_combo2.stats.recoil = 2
			self.parts.wpn_upg_ak_fg_combo2.stats.reload = 2
			self.parts.wpn_upg_ak_fg_combo3.stats.spread = 0
			self.parts.wpn_upg_ak_fg_combo3.stats.recoil = 3
			self.parts.wpn_upg_ak_fg_combo3.stats.reload = 4
			self.parts.wpn_fps_upg_ak_fg_tapco.stats.spread = 2
			self.parts.wpn_fps_upg_ak_fg_tapco.stats.concealment = 2
			self.parts.wpn_fps_upg_ak_fg_krebs.stats.spread = 1
			-- so, the "taktika" AK foregrip is visually bigger then the 'keymod rail' yet has better concealment and worse stability? wtf
			-- moved their stats around because this is dumb
			self.parts.wpn_fps_upg_ak_fg_zenitco.stats = {
				spread = 2,
				recoil = 2,
				value = 1,
				concealment = -2
			}
			self.parts.wpn_fps_upg_ak_fg_trax.stats = {
				spread = 2,
				recoil = 1,
				value = 1,
				concealment = 1,
				reload = 4
			}
		end
		general_foregrips()
		
		-- Miscellaneous
		local function general_MISC()
			-- select fire mods
			self.parts.wpn_fps_upg_i_singlefire.stats = {
				spread = 2,
				recoil = -3,
				damage = 2,
				value = 5
			}
			self.parts.wpn_fps_upg_i_autofire.stats = {
				value = 8,
				damage = 4,
				spread = -3,
				recoil = 3
			}
			-- ak charging handle
			self.parts.wpn_fps_upg_ak_dh_zenitco.stats.spread = nil
		end
		general_MISC()
		
		-- Recievers, both upper and lower
		local function general_recievers()
			-- 'orthogon' m4 upper
			self.parts.wpn_fps_m4_uupg_upper_radian.stats = {
				concealment = 1,
				recoil = -1,
				damage = 1,
				value = 3
			}
			-- 'thrust' m4 upper
			self.parts.wpn_fps_upg_ass_m4_upper_reciever_core.stats.recoil = 2
			self.parts.wpn_fps_upg_ass_m4_upper_reciever_core.stats.spread = 0
			self.parts.wpn_fps_upg_ass_m4_upper_reciever_core.stats.damage = 0
			-- 'LW' m4 upper
			self.parts.wpn_fps_upg_ass_m4_upper_reciever_ballos.stats.recoil = 1
			self.parts.wpn_fps_upg_ass_m4_upper_reciever_ballos.stats.spread = 1
			self.parts.wpn_fps_upg_ass_m4_upper_reciever_ballos.stats.damage = -1
			-- 'exotique' m4 upper
			self.parts.wpn_fps_m4_upper_reciever_edge.stats.recoil = 0
			self.parts.wpn_fps_m4_upper_reciever_edge.stats.spread = 2
			self.parts.wpn_fps_m4_upper_reciever_edge.stats.damage = -1
			-- 'orthogon' m4 lower
			self.parts.wpn_fps_m4_uupg_lower_radian.stats = {
				spread = 1,
				recoil = -1,
				value = 1,
				concealment = 1
			}
			-- 'thrust' m4 lower
			self.parts.wpn_fps_upg_ass_m4_lower_reciever_core.stats.recoil = -1
			-- 'taktika railed' ak upper -- крышка ствольной коробки
			self.parts.wpn_fps_upg_ak_body_upperreceiver_zenitco.stats.damage = nil
		end
		general_recievers()
		
	end
	init_general_mods()
	
	-- AR individual weapon attachments, based on weapon appearance order in game
	local function init_AR_mods()
		
		---- AMCAR ----
		local function Gilza_init_amcar()
			-- magazine overrides so that same magazine doesnt have different capacities depending on the gun
			self.wpn_fps_ass_amcar.override.wpn_fps_m4_uupg_m_strike = {
				override_weapon = {
					_meta = "override_weapon",
					CLIP_AMMO_MAX = 35
				},
				stats = {
					recoil = 1,
					spread = -2,
					reload = 1,
					concealment = -2
				}
			}
			self.wpn_fps_ass_amcar.override.wpn_fps_m4_upg_m_quick = {
				override_weapon = {
					_meta = "override_weapon",
					CLIP_AMMO_MAX = 30
				},
				stats = {
					reload = 10,
					value = 2,
					spread = -2,
					concealment = -2,
					recoil = -2	
				}
			}
			self.wpn_fps_ass_amcar.override.wpn_fps_upg_m4_m_l5 = {
				override_weapon = {
					_meta = "override_weapon",
					CLIP_AMMO_MAX = 28
				},
				stats = {
					recoil = 1,
					value = 1,
					reload = 4
				}
			}
			self.wpn_fps_ass_amcar.override.wpn_fps_ass_l85a2_m_emag = {
				override_weapon = {
					_meta = "override_weapon",
					CLIP_AMMO_MAX = 30
				},
				stats = {
					value = 1,
					recoil = 1,
					concealment = -1,
				}
			}
			self.wpn_fps_ass_amcar.override.wpn_fps_upg_m4_m_quad = {
				override_weapon = {
					_meta = "override_weapon",
					CLIP_AMMO_MAX = 60
				},
				stats = {
					value = 3,
					recoil = 4,
					spread = -3,
					concealment = -5,
					spread_moving = -2,
					reload = -6
				}
			}
			self.wpn_fps_ass_amcar.override.wpn_fps_upg_m4_m_pmag = {
				override_weapon = {
					_meta = "override_weapon",
					CLIP_AMMO_MAX = 30
				},
				stats = {
					value = 3,
					concealment = -1,
					spread = 1
				}
			}
		end
		Gilza_init_amcar()
		
		---- CORGI ----
		local function Gilza_init_corgi()
			self.parts.wpn_fps_ass_corgi_b_short.stats.spread = -3
		end
		Gilza_init_corgi()
		
		---- S552 ----
		local function Gilza_init_s552()
			self.parts.wpn_fps_ass_s552_body_standard_black.stats.recoil = -2
			self.parts.wpn_fps_ass_s552_g_standard_green.stats.recoil = 3
			self.parts.wpn_fps_ass_s552_fg_railed.stats.recoil = -1
			self.parts.wpn_fps_ass_s552_fg_railed.stats.spread = 3
			self.parts.wpn_fps_ass_s552_fg_standard_green.stats.recoil = 3
		end
		Gilza_init_s552()
		
		---- SCAR ----
		local function Gilza_init_scar()
			self.parts.wpn_fps_ass_scar_b_short.stats.recoil = 2
			self.parts.wpn_fps_ass_scar_b_short.stats.spread = -1
			self.parts.wpn_fps_ass_scar_b_short.stats.concealment = 3
			self.parts.wpn_fps_ass_scar_b_long.stats.recoil = -1
			self.parts.wpn_fps_ass_scar_b_long.stats.spread = 2
			self.parts.wpn_fps_ass_scar_b_long.stats.concealment = -3
		end
		Gilza_init_scar()
		
		---- AK74 ----
		local function Gilza_init_ak74()
			-- dmr kit stats override
			self.wpn_fps_ass_74.override.wpn_fps_upg_ass_ak_b_zastava = {
				override_weapon = {
					_meta = "override_weapon",
					AMMO_MAX = 150
				},
				stats = {
					value = 1,
					concealment = -4,
					spread = 3,
					recoil = -5
				}
			}
		end
		Gilza_init_ak74()
		
		---- M4 ----
		local function Gilza_init_m4()
			-- exclusive set
			self.parts.wpn_fps_m4_upg_fg_mk12.stats = {
				value = 4,
				spread = 2,
				damage = 4,
				suppression = 12,
				concealment = -8,
				recoil = 8,
				reload = 2,
				alert_size = 12
			}
			self.parts.wpn_fps_m4_upg_fg_mk12.has_description = true
			self.parts.wpn_fps_m4_upg_fg_mk12.desc_id = "bm_m4_upg_fg_mk12_desc"
			-- FrenchyAU's barrels
			table.insert(self.parts.wpn_fps_m4_upg_fg_mk12.forbids, "wpn_fps_upg_m4_b_260")
			table.insert(self.parts.wpn_fps_m4_upg_fg_mk12.forbids, "wpn_fps_upg_m4_b_260post")
			table.insert(self.parts.wpn_fps_m4_upg_fg_mk12.forbids, "wpn_fps_upg_m4_b_260rail")
			table.insert(self.parts.wpn_fps_m4_upg_fg_mk12.forbids, "wpn_fps_upg_m4_b_370")
			table.insert(self.parts.wpn_fps_m4_upg_fg_mk12.forbids, "wpn_fps_upg_m4_b_370post")
			table.insert(self.parts.wpn_fps_m4_upg_fg_mk12.forbids, "wpn_fps_upg_m4_b_370rail")
			table.insert(self.parts.wpn_fps_m4_upg_fg_mk12.forbids, "wpn_fps_upg_m4_b_406")
			table.insert(self.parts.wpn_fps_m4_upg_fg_mk12.forbids, "wpn_fps_upg_m4_b_406post")
			table.insert(self.parts.wpn_fps_m4_upg_fg_mk12.forbids, "wpn_fps_upg_m4_b_457")
			table.insert(self.parts.wpn_fps_m4_upg_fg_mk12.forbids, "wpn_fps_upg_m4_b_457post")
			table.insert(self.parts.wpn_fps_m4_upg_fg_mk12.forbids, "wpn_fps_upg_m4_b_508")
			table.insert(self.parts.wpn_fps_m4_upg_fg_mk12.forbids, "wpn_fps_upg_m4_b_508post")
			-- FrenchyAU's foregrips
			table.insert(self.parts.wpn_fps_m4_upg_fg_mk12.forbids, "wpn_fps_upg_m4_fg_516")
			table.insert(self.parts.wpn_fps_m4_upg_fg_mk12.forbids, "wpn_fps_upg_m4_fg_adar")
			table.insert(self.parts.wpn_fps_m4_upg_fg_mk12.forbids, "wpn_fps_upg_m4_fg_aero")
			table.insert(self.parts.wpn_fps_m4_upg_fg_mk12.forbids, "wpn_fps_upg_m4_fg_cmmg9")
			table.insert(self.parts.wpn_fps_m4_upg_fg_mk12.forbids, "wpn_fps_upg_m4_fg_dm7")
			table.insert(self.parts.wpn_fps_m4_upg_fg_mk12.forbids, "wpn_fps_upg_m4_fg_gis13")
			table.insert(self.parts.wpn_fps_m4_upg_fg_mk12.forbids, "wpn_fps_upg_m4_fg_gis9")
			table.insert(self.parts.wpn_fps_m4_upg_fg_mk12.forbids, "wpn_fps_upg_m4_fg_kacris")
			table.insert(self.parts.wpn_fps_m4_upg_fg_mk12.forbids, "wpn_fps_upg_m4_fg_lmt")
			table.insert(self.parts.wpn_fps_m4_upg_fg_mk12.forbids, "wpn_fps_upg_m4_fg_lone")
			table.insert(self.parts.wpn_fps_m4_upg_fg_mk12.forbids, "wpn_fps_upg_m4_fg_lvoac")
			table.insert(self.parts.wpn_fps_m4_upg_fg_mk12.forbids, "wpn_fps_upg_m4_fg_lvoas")
			table.insert(self.parts.wpn_fps_m4_upg_fg_mk12.forbids, "wpn_fps_upg_m4_fg_lwrc7")
			table.insert(self.parts.wpn_fps_m4_upg_fg_mk12.forbids, "wpn_fps_upg_m4_fg_lwrc9")
			table.insert(self.parts.wpn_fps_m4_upg_fg_mk12.forbids, "wpn_fps_upg_m4_fg_mk10")
			table.insert(self.parts.wpn_fps_m4_upg_fg_mk12.forbids, "wpn_fps_upg_m4_fg_moec")
			table.insert(self.parts.wpn_fps_m4_upg_fg_mk12.forbids, "wpn_fps_upg_m4_fg_moem")
			table.insert(self.parts.wpn_fps_m4_upg_fg_mk12.forbids, "wpn_fps_upg_m4_fg_ris12")
			table.insert(self.parts.wpn_fps_m4_upg_fg_mk12.forbids, "wpn_fps_upg_m4_fg_ris9")
			table.insert(self.parts.wpn_fps_m4_upg_fg_mk12.forbids, "wpn_fps_upg_m4_fg_risfsp")
			table.insert(self.parts.wpn_fps_m4_upg_fg_mk12.forbids, "wpn_fps_upg_m4_fg_rsass")
			table.insert(self.parts.wpn_fps_m4_upg_fg_mk12.forbids, "wpn_fps_upg_m4_fg_sail")
			table.insert(self.parts.wpn_fps_m4_upg_fg_mk12.forbids, "wpn_fps_upg_m4_fg_sais")
			table.insert(self.parts.wpn_fps_m4_upg_fg_mk12.forbids, "wpn_fps_upg_m4_fg_skele")
			table.insert(self.parts.wpn_fps_m4_upg_fg_mk12.forbids, "wpn_fps_upg_m4_fg_stm12")
			table.insert(self.parts.wpn_fps_m4_upg_fg_mk12.forbids, "wpn_fps_upg_m4_fg_stm15")
			table.insert(self.parts.wpn_fps_m4_upg_fg_mk12.forbids, "wpn_fps_upg_m4_fg_stm9")
			table.insert(self.parts.wpn_fps_m4_upg_fg_mk12.forbids, "wpn_fps_upg_m4_fg_strike")
			table.insert(self.parts.wpn_fps_m4_upg_fg_mk12.forbids, "wpn_fps_upg_m4_fg_urx10")
			table.insert(self.parts.wpn_fps_m4_upg_fg_mk12.forbids, "wpn_fps_upg_m4_fg_urx3")
			table.insert(self.parts.wpn_fps_m4_upg_fg_mk12.forbids, "wpn_fps_upg_m4_fg_vypr")
			table.insert(self.parts.wpn_fps_m4_upg_fg_mk12.forbids, "wpn_fps_upg_m4_fg_wing")
			-- silenced barrel
			self.parts.wpn_fps_m4_uupg_b_sd.stats = {
				alert_size = 12,
				value = 6,
				damage = -3,
				suppression = 12,
				spread = 1,
				recoil = 3,
				concealment = -2
			}
			-- FrenchyAU's foregrips
			table.insert(self.parts.wpn_fps_m4_uupg_b_sd.forbids, "wpn_fps_upg_m4_fg_adar")
			table.insert(self.parts.wpn_fps_m4_uupg_b_sd.forbids, "wpn_fps_upg_m4_fg_aero")
			table.insert(self.parts.wpn_fps_m4_uupg_b_sd.forbids, "wpn_fps_upg_m4_fg_dm7")
			table.insert(self.parts.wpn_fps_m4_uupg_b_sd.forbids, "wpn_fps_upg_m4_fg_gis13")
			table.insert(self.parts.wpn_fps_m4_uupg_b_sd.forbids, "wpn_fps_upg_m4_fg_gis9")
			table.insert(self.parts.wpn_fps_m4_uupg_b_sd.forbids, "wpn_fps_upg_m4_fg_lone")
			table.insert(self.parts.wpn_fps_m4_uupg_b_sd.forbids, "wpn_fps_upg_m4_fg_lvoac")
			table.insert(self.parts.wpn_fps_m4_uupg_b_sd.forbids, "wpn_fps_upg_m4_fg_lvoas")
			table.insert(self.parts.wpn_fps_m4_uupg_b_sd.forbids, "wpn_fps_upg_m4_fg_ris12")
			table.insert(self.parts.wpn_fps_m4_uupg_b_sd.forbids, "wpn_fps_upg_m4_fg_ris9")
			table.insert(self.parts.wpn_fps_m4_uupg_b_sd.forbids, "wpn_fps_upg_m4_fg_stm12")
			table.insert(self.parts.wpn_fps_m4_uupg_b_sd.forbids, "wpn_fps_upg_m4_fg_stm15")
			table.insert(self.parts.wpn_fps_m4_uupg_b_sd.forbids, "wpn_fps_upg_m4_fg_stm9")
			table.insert(self.parts.wpn_fps_m4_uupg_b_sd.forbids, "wpn_fps_upg_m4_fg_vypr")
			-- short barrel
			self.parts.wpn_fps_m4_uupg_b_short.stats = {
				damage = -1,
				value = 5,
				concealment = 1
			}
		end
		Gilza_init_m4()
		
		---- AUG ----
		local function Gilza_init_aug()
			self.parts.wpn_fps_ass_aug_m_quick.spread = -2
			-- black coloured reciever that gives less concealment and better stats? no.
			self.parts.wpn_fps_aug_body_f90.stats = {
				value = 1,
				concealment = 3,
				damage = -1,
				spread = -1,
				recoil = -1
			}
			self.parts.wpn_fps_aug_fg_a3.stats.recoil = 1
			self.parts.wpn_fps_aug_fg_a3.stats.spread = -1
			self.parts.wpn_fps_aug_b_short.damage = 2
			self.parts.wpn_fps_aug_b_short.concealment = 1
			self.parts.wpn_fps_aug_b_long.spread = 2
			self.parts.wpn_fps_aug_b_long.recoil = -1
			self.parts.wpn_fps_aug_b_long.damage = nil
			self.parts.wpn_fps_aug_b_long.concealment = -2
		end
		Gilza_init_aug()
		
		---- GROZA ----
		local function Gilza_init_groza()
			self.parts.wpn_fps_ass_groza_m_speed.stats = {
				value = 2,
				spread = -1,
				concealment = -2,
				reload = 9
			}
			self.parts.wpn_fps_ass_groza_b_supressor.stats = {
				alert_size = 12,
				value = 1,
				suppression = 8,
				spread = 1,
				recoil = 3
			}
		end
		Gilza_init_groza()
		
		---- SUB2000 ----
		local function Gilza_init_sub2000()
			self.parts.wpn_fps_ass_sub2000_fg_suppressed.stats = {
				alert_size = 12,
				value = 5,
				damage = -2,
				suppression = 12,
				spread = 1,
				recoil = 4,
				spread_moving = 1,
				concealment = -4
			}
			self.parts.wpn_fps_ass_sub2000_fg_gen2.stats = {
				value = 1,
				recoil = -1,
				spread = 1,
				reload = 2,
				concealment = 1
			}
			self.parts.wpn_fps_ass_sub2000_fg_railed.stats = {
				value = 1,
				recoil = -1,
				spread = 2,
				concealment = 1
			}
		end
		Gilza_init_sub2000()
		
		---- AKM + AKM GOLD ----
		local function Gilza_init_akm()
			-- only use universal mods
		end
		Gilza_init_akm()
		
		---- G36 ----
		local function Gilza_init_g36()
			self.parts.wpn_fps_ass_g36_s_kv.stats.concealment = -1
			self.parts.wpn_fps_ass_g36_s_kv.stats.spread = 2
			self.parts.wpn_fps_ass_g36_s_kv.stats.recoil = 1
			self.parts.wpn_fps_ass_g36_s_sl8.stats.spread = 0
			self.parts.wpn_fps_ass_g36_s_sl8.stats.recoil = 3
			self.parts.wpn_fps_ass_g36_m_quick.stats.spread = -2
			self.parts.wpn_fps_ass_g36_fg_c.stats.spread = -1
			self.parts.wpn_fps_ass_g36_fg_c.stats.recoil = 2
			self.parts.wpn_fps_ass_g36_fg_c.stats.reload = 3
			self.parts.wpn_fps_ass_g36_fg_ksk.stats.spread = 2
			self.parts.wpn_fps_upg_g36_fg_long.stats.spread = 3
			self.parts.wpn_fps_upg_g36_fg_long.stats.recoil = -1
		end
		Gilza_init_g36()
		
		---- AK12 ----
		local function Gilza_init_flint()
			-- only uses universal mods
		end
		Gilza_init_flint()
		
		---- TECCI ----
		local function Gilza_init_tecci()
			-- 2 individual attachments left unchanged
		end
		Gilza_init_tecci()
		
		---- L85A2 ----
		local function Gilza_init_l85a2()
			self.parts.wpn_fps_ass_l85a2_fg_short.stats.spread = -1
		end
		Gilza_init_l85a2()
		
		---- CHING ----
		local function Gilza_init_ching()
			self.parts.wpn_fps_ass_ching_s_pouch.stats.total_ammo_mod = nil
			self.parts.wpn_fps_ass_ching_s_pouch.stats.concealment = -1
			if not self.wpn_fps_ass_ching.override then self.wpn_fps_ass_ching.override = {} end
			self.wpn_fps_ass_ching.override.wpn_fps_ass_ching_s_pouch = {override_weapon = {_meta = "override_weapon", AMMO_MAX = 96}}
			self.wpn_fps_ass_ching.override.wpn_fps_upg_ar_dmr_ap_rounds = {stats = {value = 0,spread = -4,recoil = -3, total_ammo_mod = -6}}
		end
		Gilza_init_ching()
		
		---- M14 ----
		local function Gilza_init_m14()
			self.parts.wpn_fps_ass_m14_body_ruger.stats.spread = -3
			self.parts.wpn_fps_ass_m14_body_ruger.stats.total_ammo_mod = nil
			self.parts.wpn_fps_ass_m14_body_ruger.stats.recoil = -4
			self.parts.wpn_fps_ass_m14_body_ruger.stats.reload = 4
			self.parts.wpn_fps_ass_m14_body_ebr.stats.recoil = -1
			self.parts.wpn_fps_ass_m14_body_ebr.stats.spread = 2
			self.parts.wpn_fps_ass_m14_body_ebr.stats.reload = 2
			self.parts.wpn_fps_ass_m14_body_jae.stats.reload = -1
			self.parts.wpn_fps_ass_m14_body_jae.stats.recoil = 2
			if not self.wpn_fps_ass_m14.override then self.wpn_fps_ass_m14.override = {} end
			self.wpn_fps_ass_m14.override.wpn_fps_upg_ar_dmr_ap_rounds = {override_weapon = {_meta = "override_weapon",AMMO_MAX = 60}}
		end
		Gilza_init_m14()
		
		---- FAMAS ----
		local function Gilza_init_famas()
			-- AK dmr kit, this stuff is used by akm's, ak74 has an override
			self.parts.wpn_fps_ass_famas_b_sniper.stats = {
				value = 2,
				concealment = -4,
				spread = 3,
				recoil = -4
			}
			self.parts.wpn_fps_ass_famas_b_sniper.override_weapon = {_meta = "override_weapon", AMMO_MAX = 210}
			self.parts.wpn_fps_ass_famas_b_sniper.adds = {"wpn_fps_upg_ap_kit_ap_rounds"}
			self.parts.wpn_fps_ass_famas_b_sniper.name_id = "bm_wp_famas_b_sniper_newname"
			self.parts.wpn_fps_ass_famas_b_sniper.has_description = true
			self.parts.wpn_fps_ass_famas_b_sniper.desc_id = "bm_wpn_fps_upg_ar_ap_kit_desc"
			self.parts.wpn_fps_ass_famas_b_long.stats.spread = 2
			self.parts.wpn_fps_ass_famas_b_long.stats.recoil = nil
			self.parts.wpn_fps_ass_famas_b_suppressed.stats.recoil = 2
			self.parts.wpn_fps_ass_famas_b_suppressed.stats.concealment = -2
		end
		Gilza_init_famas()	
		
		---- VHS ----
		local function Gilza_init_vhs()
			self.parts.wpn_fps_ass_vhs_b_silenced.stats.recoil = nil
			self.parts.wpn_fps_ass_vhs_b_silenced.stats.spread = 4
			self.parts.wpn_fps_ass_vhs_b_sniper.stats.recoil = 1
			self.parts.wpn_fps_ass_vhs_b_sniper.stats.spread = 3
			self.parts.wpn_fps_ass_vhs_b_sniper.stats.concealment = -3
		end
		Gilza_init_vhs()
		
		---- ASVAL ----
		local function Gilza_init_asval()
			self.parts.wpn_fps_ass_asval_s_solid.stats.recoil = 4
			self.parts.wpn_fps_ass_asval_b_proto.stats.spread = -2
			self.parts.wpn_fps_ass_asval_b_proto.stats.recoil = 1
			self.parts.wpn_fps_ass_asval_b_proto.stats.reload = 2
		end
		Gilza_init_asval()
		
		---- AK5 ----
		local function Gilza_init_ak5()
			self.parts.wpn_fps_ass_ak5_s_ak5b.stats.spread = 2
			self.parts.wpn_fps_ass_ak5_b_short.stats.spread = nil
			self.parts.wpn_fps_ass_ak5_b_short.stats.recoil = 1
		end
		Gilza_init_ak5()
		
		---- GALIL ----
		local function Gilza_init_galil()
			self.parts.wpn_fps_ass_galil_s_sniper.stats.recoil = -2
			self.parts.wpn_fps_ass_galil_s_plastic.stats.recoil = -1
			self.parts.wpn_fps_ass_galil_fg_sar.stats.reload = 3
		end
		Gilza_init_galil()
		
		---- KOMODO ----
		local function Gilza_init_komodo()
			-- only uses universal mods
		end
		Gilza_init_komodo()
		
		---- M16 ----
		local function Gilza_init_m16()
			self.parts.wpn_fps_m16_fg_railed.stats.damage = -1
			self.parts.wpn_fps_m16_fg_railed.stats.spread = 1
			self.parts.wpn_fps_m16_fg_railed.stats.recoil = 4
			self.parts.wpn_fps_m16_fg_vietnam.stats.damage = -1
			self.parts.wpn_fps_m16_fg_vietnam.stats.spread = -1
			self.parts.wpn_fps_m16_fg_vietnam.stats.recoil = 2
			self.parts.wpn_fps_m16_fg_vietnam.stats.reload = 4
			self.parts.wpn_fps_upg_ass_m16_fg_stag.stats.damage = 2
			self.parts.wpn_fps_upg_ass_m16_fg_stag.stats.spread = 2
			self.parts.wpn_fps_upg_ass_m16_fg_stag.stats.recoil = 3
			self.wpn_fps_ass_m16.override.wpn_fps_upg_ass_m4_b_beowulf = {
				override_weapon = {
					_meta = "override_weapon",
					AMMO_MAX = 120
				},
				stats = {
					value = 1,
					concealment = -4,
					spread = 1,
					recoil = 1
				}
			}
		end
		Gilza_init_m16()
		
		---- SHAK12 ----
		local function Gilza_init_shak12()
			self.parts.wpn_fps_ass_shak12_body_vks.stats = {
				concealment = -3,
				damage = 5,
				value = 4,
				spread = 3,
				recoil = -4
			}
			self.parts.wpn_fps_ass_shak12_body_vks.override_weapon = {_meta = "override_weapon", AMMO_MAX = 100}
			self.parts.wpn_fps_ass_shak12_body_vks.custom_stats = {}
			self.parts.wpn_fps_ass_shak12_body_vks.adds = {"wpn_fps_upg_ap_kit_ap_rounds"}
			self.parts.wpn_fps_ass_shak12_body_vks.name_id = "wpn_fps_ass_shak12_body_vks_R"
			self.parts.wpn_fps_ass_shak12_body_vks.has_description = true
			self.parts.wpn_fps_ass_shak12_body_vks.desc_id = "bm_wpn_fps_shak12_upg_ap_kit_desc"
		end
		Gilza_init_shak12()
		
		---- CONTRABAND ----
		local function Gilza_init_contraband()
			
		end
		Gilza_init_contraband()
		
		---- FAL ----
		local function Gilza_init_fal()
			self.parts.wpn_fps_ass_fal_m_01.stats = {
				extra_ammo = 5,
				value = 2,
				spread = -1,
				recoil = 2,
				concealment = -2,
				reload = -3
			}
			self.parts.wpn_fps_ass_fal_g_01.stats.spread = -2
			self.parts.wpn_fps_ass_fal_fg_01.stats.concealment = 5
			self.parts.wpn_fps_ass_fal_fg_03.stats.recoil = 3
			self.parts.wpn_fps_ass_fal_fg_03.stats.reload = 1
			self.parts.wpn_fps_ass_fal_fg_04.stats.spread = -1
			self.parts.wpn_fps_ass_fal_fg_04.stats.recoil = 3
			self.parts.wpn_fps_ass_fal_fg_04.stats.reload = 3
		end
		Gilza_init_fal()
		
		---- TKB ----
		local function Gilza_init_tkb()
			self.parts.wpn_fps_ass_tkb_m_bakelite.stats.spread = -1
			self.parts.wpn_fps_ass_tkb_body_pouch.stats.total_ammo_mod = nil
			self.parts.wpn_fps_ass_tkb_body_pouch.override_weapon = {_meta = "override_weapon", AMMO_MAX = 300}
			self.parts.wpn_fps_ass_tkb_conversion.stats = {
				value = 1,
				spread = 3,
				damage = 2,
				recoil = 8,
				concealment = -3,
				reload = 2
			}
			self.parts.wpn_fps_ass_tkb_conversion.custom_stats = {
				fire_rate_multiplier = 0.8125
			}
		end
		Gilza_init_tkb()
		
		---- G3 ----
		local function Gilza_init_g3()
			-- ap kit
			self.parts.wpn_fps_ass_g3_b_long.name_id = "bm_wpn_fps_ass_g3_b_long_newname"
			self.parts.wpn_fps_ass_g3_b_sniper.stats = {
				extra_ammo = -5,
				value = 2,
				concealment = -2,
				recoil = -5,
				spread = 4
			}
			self.parts.wpn_fps_ass_g3_b_sniper.override_weapon = {_meta = "override_weapon", AMMO_MAX = 90}
			self.parts.wpn_fps_ass_g3_b_sniper.custom_stats = {
				fire_rate_multiplier = 0.6923
			}
			self.parts.wpn_fps_ass_g3_b_sniper.adds = {"wpn_fps_upg_ap_kit_ap_rounds"}
			self.parts.wpn_fps_ass_g3_b_sniper.name_id = "bm_wpn_fps_ass_g3_b_sniper_newname"
			self.parts.wpn_fps_ass_g3_b_sniper.has_description = true
			self.parts.wpn_fps_ass_g3_b_sniper.desc_id = "bm_wpn_fps_upg_ar_ap_kit_desc"
			-- assault kit
			self.parts.wpn_fps_ass_g3_b_short.stats = {
				spread = -8,
				damage = -50,
				value = 2,
				concealment = 3,
				recoil = 5
			}
			self.parts.wpn_fps_ass_g3_b_short.override_weapon = {_meta = "override_weapon", AMMO_MAX = 180}
			self.parts.wpn_fps_ass_g3_b_short.custom_stats = {
				fire_rate_multiplier = 1.3077,
				ammo_pickup_max_mul = 1.6289,
				ammo_pickup_min_mul = 1.6346
			}
			self.parts.wpn_fps_ass_g3_b_short.has_description = true
			self.parts.wpn_fps_ass_g3_b_short.desc_id = "bm_wpn_fps_ass_g3_b_short_desc"
			
			self.parts.wpn_fps_ass_g3_s_wood.stats.spread = -1
			self.parts.wpn_fps_ass_g3_s_wood.stats.recoil = 2
			self.parts.wpn_fps_ass_g3_g_retro.stats.recoil = 1
			self.parts.wpn_fps_ass_g3_fg_psg.stats.concealment = 1
			self.parts.wpn_fps_ass_g3_fg_railed.stats.concealment = 1
			self.parts.wpn_fps_ass_g3_fg_retro.stats.concealment = -2
			self.parts.wpn_fps_ass_g3_fg_retro.stats.spread = 1
			self.parts.wpn_fps_ass_g3_fg_retro.stats.recoil = 2
			self.parts.wpn_fps_ass_g3_fg_retro_plastic.stats.concealment = nil
			self.parts.wpn_fps_ass_g3_fg_retro_plastic.stats.spread = nil
			self.parts.wpn_fps_ass_g3_fg_retro_plastic.stats.recoil = 2
			self.parts.wpn_fps_ass_g3_fg_retro_plastic.stats.reload = 2
		end
		Gilza_init_g3()	
		
	end
	init_AR_mods()
	
	-- Shotgun individual
	local function init_Shotgun_mods()
		
		local function init_shotgun_ammo()
		
			-- SLUG
			self.parts.wpn_fps_upg_a_slug.stats = {value = 5,spread = 3,recoil = -2,total_ammo_mod = -5}
			self.parts.wpn_fps_upg_a_slug.custom_stats.damage_far_mul = 1.15
			self.parts.wpn_fps_upg_a_slug.custom_stats.damage_near_mul = 1.15
			self.parts.wpn_fps_upg_a_slug.custom_stats.ammo_pickup_min_mul = 0.75
			self.parts.wpn_fps_upg_a_slug.custom_stats.ammo_pickup_max_mul = 0.75
			self.parts.wpn_fps_upg_a_slug.desc_id = "bm_wpn_fps_upg_a_slug_desc_new"
			
			-- FLECHETTE
			self.parts.wpn_fps_upg_a_piercing.stats = {value = 5}
			self.parts.wpn_fps_upg_a_piercing.custom_stats = {rays = 6, armor_piercing_add = 1,damage_near_mul = 1.4,damage_far_mul = 1.4,ammo_pickup_max_mul = 0.9,ammo_pickup_min_mul = 0.9}
			self.parts.wpn_fps_upg_a_piercing.desc_id = "bm_wpn_fps_upg_a_piercing_desc_new"
			
			-- FIRE
			self.parts.wpn_fps_upg_a_dragons_breath.stats = {value = 5,total_ammo_mod = -10,recoil = -6}
			self.parts.wpn_fps_upg_a_dragons_breath.custom_stats.damage_near_mul = 0.8
			self.parts.wpn_fps_upg_a_dragons_breath.custom_stats.damage_far_mul = 0.8
			self.parts.wpn_fps_upg_a_dragons_breath.custom_stats.rays = 9
			self.parts.wpn_fps_upg_a_dragons_breath.custom_stats.ammo_pickup_max_mul = 0.7
			self.parts.wpn_fps_upg_a_dragons_breath.custom_stats.ammo_pickup_min_mul = 0.7
			self.parts.wpn_fps_upg_a_dragons_breath.desc_id = "bm_wpn_fps_upg_a_dragons_breath_desc_new"
			
			-- TOXIC SLUG
			self.parts.wpn_fps_upg_a_rip.stats = {value = 5,spread = 2,total_ammo_mod = -5}
			self.parts.wpn_fps_upg_a_rip.custom_stats.ammo_pickup_max_mul = 0.8
			self.parts.wpn_fps_upg_a_rip.custom_stats.ammo_pickup_min_mul = 0.8
			self.parts.wpn_fps_upg_a_rip.desc_id = "bm_wpn_fps_upg_a_rip_desc_new"
			
			-- HE SLUG
			local HE_custom_stats = {
				ignore_statistic = true,
				damage_far_mul = 1,
				damage_near_mul = 1,
				bullet_class = "InstantExplosiveBulletBase",
				rays = 1,
				ammo_pickup_max_mul = 0.35,
				ammo_pickup_min_mul = 0.35
			}
			self.parts.wpn_fps_upg_a_explosive.desc_id = "bm_wpn_fps_upg_a_explosive_desc_new"
			
			-- BUCKSHOT
			local BS_custom_stats = {
				damage_far_mul = 0.8,
				damage_near_mul = 0.8,
				ammo_pickup_max_mul = 0.5,
				ammo_pickup_min_mul = 0.5,
				is_buckshot = true,
				rays = 8
			}
			self.parts.wpn_fps_upg_a_custom.desc_id = "bm_wpn_fps_upg_a_custom_desc_new"
			self.parts.wpn_fps_upg_a_custom_free.desc_id = "bm_wpn_fps_upg_a_custom_desc_new"
			
			-- buckshot and explosive rounds have overrides per shotgun damage class
			local function init_DB()
				local double_barrels = {
					"wpn_fps_shot_b682",
					"wpn_fps_shot_huntsman",
					"wpn_fps_sho_coach"
				}
				for i=1, #double_barrels do
					if not self[double_barrels[i]].override then
						self[double_barrels[i]].override = {}
					end
					if not self[double_barrels[i]].override.wpn_fps_upg_a_custom then
						self[double_barrels[i]].override.wpn_fps_upg_a_custom = {}
					end
					if not self[double_barrels[i]].override.wpn_fps_upg_a_custom_free then
						self[double_barrels[i]].override.wpn_fps_upg_a_custom_free = {}
					end
					if not self[double_barrels[i]].override.wpn_fps_upg_a_explosive then
						self[double_barrels[i]].override.wpn_fps_upg_a_explosive = {}
					end
					self[double_barrels[i]].override.wpn_fps_upg_a_custom.stats = {total_ammo_mod = -5,damage = 1000}
					self[double_barrels[i]].override.wpn_fps_upg_a_custom.custom_stats = BS_custom_stats
					self[double_barrels[i]].override.wpn_fps_upg_a_custom_free.stats = {total_ammo_mod = -5,damage = 1000}
					self[double_barrels[i]].override.wpn_fps_upg_a_custom_free.custom_stats = BS_custom_stats
					self[double_barrels[i]].override.wpn_fps_upg_a_explosive.stats = {value = 5,total_ammo_mod = -10,damage = 1100,recoil = -8}
					self[double_barrels[i]].override.wpn_fps_upg_a_explosive.custom_stats = HE_custom_stats
				end
			end
			init_DB()
			
			local function init_PA()
				local pump_action = {
					"wpn_fps_sho_boot",
					"wpn_fps_shot_r870",
					"wpn_fps_sho_m590",
					"wpn_fps_sho_ksg",
					"wpn_fps_shot_m1897",
					"wpn_fps_shot_serbu",
					"wpn_fps_shot_m37",
					"wpn_fps_sho_supernova"
				}
				for i=1, #pump_action do
					if not self[pump_action[i]].override then
						self[pump_action[i]].override = {}
					end
					if not self[pump_action[i]].override.wpn_fps_upg_a_custom then
						self[pump_action[i]].override.wpn_fps_upg_a_custom = {}
					end
					if not self[pump_action[i]].override.wpn_fps_upg_a_custom_free then
						self[pump_action[i]].override.wpn_fps_upg_a_custom_free = {}
					end
					if not self[pump_action[i]].override.wpn_fps_upg_a_explosive then
						self[pump_action[i]].override.wpn_fps_upg_a_explosive = {}
					end
					self[pump_action[i]].override.wpn_fps_upg_a_custom.stats = {total_ammo_mod = -5,damage = 450}
					self[pump_action[i]].override.wpn_fps_upg_a_custom.custom_stats = BS_custom_stats
					self[pump_action[i]].override.wpn_fps_upg_a_custom_free.stats = {total_ammo_mod = -5,damage = 450}
					self[pump_action[i]].override.wpn_fps_upg_a_custom_free.custom_stats = BS_custom_stats
					self[pump_action[i]].override.wpn_fps_upg_a_explosive.stats = {value = 5,total_ammo_mod = -10,damage = 550,recoil = -8}
					self[pump_action[i]].override.wpn_fps_upg_a_explosive.custom_stats = HE_custom_stats
				end
			end
			init_PA()

			local function init_SA()
				local semi_auto = {
					"wpn_fps_sho_spas12",
					"wpn_fps_sho_ben",
					"wpn_fps_sho_striker",
					"wpn_fps_sho_ultima",
					"wpn_fps_pis_judge",
					"wpn_fps_pis_x_judge"
				}
				for i=1, #semi_auto do
					if not self[semi_auto[i]].override then
						self[semi_auto[i]].override = {}
					end
					if not self[semi_auto[i]].override.wpn_fps_upg_a_custom then
						self[semi_auto[i]].override.wpn_fps_upg_a_custom = {}
					end
					if not self[semi_auto[i]].override.wpn_fps_upg_a_custom_free then
						self[semi_auto[i]].override.wpn_fps_upg_a_custom_free = {}
					end
					if not self[semi_auto[i]].override.wpn_fps_upg_a_explosive then
						self[semi_auto[i]].override.wpn_fps_upg_a_explosive = {}
					end
					self[semi_auto[i]].override.wpn_fps_upg_a_custom.stats = {total_ammo_mod = -5,damage = 325}
					self[semi_auto[i]].override.wpn_fps_upg_a_custom.custom_stats = BS_custom_stats
					self[semi_auto[i]].override.wpn_fps_upg_a_custom_free.stats = {total_ammo_mod = -5,damage = 325}
					self[semi_auto[i]].override.wpn_fps_upg_a_custom_free.custom_stats = BS_custom_stats
					self[semi_auto[i]].override.wpn_fps_upg_a_explosive.stats = {value = 5,total_ammo_mod = -10,damage = 400,recoil = -8}
					self[semi_auto[i]].override.wpn_fps_upg_a_explosive.custom_stats = HE_custom_stats
				end
				self.wpn_fps_pis_x_judge.override.wpn_fps_upg_a_custom.stats = {total_ammo_mod = -5,damage = 163}
				self.wpn_fps_pis_x_judge.override.wpn_fps_upg_a_custom_free.stats = {total_ammo_mod = -5,damage = 163}
				self.wpn_fps_pis_x_judge.override.wpn_fps_upg_a_explosive.stats = {value = 5,total_ammo_mod = -10,damage = 200,recoil = -8}
			end
			init_SA()
			
			local function init_FA()
				local full_auto = {
					"wpn_fps_sho_sko12",
					"wpn_fps_shot_saiga",
					"wpn_fps_sho_aa12",
					"wpn_fps_sho_rota",
					"wpn_fps_sho_basset",
					"wpn_fps_sho_x_sko12",
					"wpn_fps_sho_x_rota",
					"wpn_fps_sho_x_basset"
				}
				for i=1, #full_auto do
					if not self[full_auto[i]].override then
						self[full_auto[i]].override = {}
					end
					if not self[full_auto[i]].override.wpn_fps_upg_a_custom then
						self[full_auto[i]].override.wpn_fps_upg_a_custom = {}
					end
					if not self[full_auto[i]].override.wpn_fps_upg_a_custom_free then
						self[full_auto[i]].override.wpn_fps_upg_a_custom_free = {}
					end
					if not self[full_auto[i]].override.wpn_fps_upg_a_explosive then
						self[full_auto[i]].override.wpn_fps_upg_a_explosive = {}
					end
					self[full_auto[i]].override.wpn_fps_upg_a_custom.stats = {total_ammo_mod = -5,damage = 100}
					self[full_auto[i]].override.wpn_fps_upg_a_custom.custom_stats = BS_custom_stats
					self[full_auto[i]].override.wpn_fps_upg_a_custom_free.stats = {total_ammo_mod = -5,damage = 100}
					self[full_auto[i]].override.wpn_fps_upg_a_custom_free.custom_stats = BS_custom_stats
					self[full_auto[i]].override.wpn_fps_upg_a_explosive.stats = {value = 5,total_ammo_mod = -10,damage = 120,recoil = -8}
					self[full_auto[i]].override.wpn_fps_upg_a_explosive.custom_stats = HE_custom_stats
				end
				self.wpn_fps_sho_x_sko12.override.wpn_fps_upg_a_custom.stats = {total_ammo_mod = -5,damage = 50}
				self.wpn_fps_sho_x_sko12.override.wpn_fps_upg_a_custom_free.stats = {total_ammo_mod = -5,damage = 50}
				self.wpn_fps_sho_x_sko12.override.wpn_fps_upg_a_explosive.stats = {value = 5,total_ammo_mod = -10,damage = 60,recoil = -8}
				self.wpn_fps_sho_x_rota.override.wpn_fps_upg_a_custom.stats = {total_ammo_mod = -5,damage = 50}
				self.wpn_fps_sho_x_rota.override.wpn_fps_upg_a_custom_free.stats = {total_ammo_mod = -5,damage = 50}
				self.wpn_fps_sho_x_rota.override.wpn_fps_upg_a_explosive.stats = {value = 5,total_ammo_mod = -10,damage = 60,recoil = -8}
				self.wpn_fps_sho_x_basset.override.wpn_fps_upg_a_custom.stats = {total_ammo_mod = -5,damage = 50}
				self.wpn_fps_sho_x_basset.override.wpn_fps_upg_a_custom_free.stats = {total_ammo_mod = -5,damage = 50}
				self.wpn_fps_sho_x_basset.override.wpn_fps_upg_a_explosive.stats = {value = 5,total_ammo_mod = -10,damage = 60,recoil = -8}
			end
			init_FA()
			
		end
		init_shotgun_ammo()
		
		---- SPAS12 ----
		local function Gilza_init_spas12()
			self.parts.wpn_fps_sho_s_spas12_folded.stats.spread = 1
			self.parts.wpn_fps_sho_s_spas12_solid.stats.spread = -1
			self.parts.wpn_fps_sho_s_spas12_solid.stats.recoil = 2
		end
		Gilza_init_spas12()
		
		---- BOOT ----
		local function Gilza_init_boot()
			self.parts.wpn_fps_sho_boot_body_exotic.stats.recoil = -1
		end
		Gilza_init_boot()
		
		---- R870 ----
		local function Gilza_init_r870()
			self.wpn_fps_shot_r870.override.wpn_fps_shot_r870_body_rack = {override_weapon = {_meta = "override_weapon", AMMO_MAX = 53}}
			self.parts.wpn_fps_shot_r870_body_rack.stats.reload = 1
			self.parts.wpn_fps_shot_r870_body_rack.stats.total_ammo_mod = nil
			self.parts.wpn_fps_shot_r870_body_rack.stats.concealment = -3
			self.parts.wpn_fps_shot_r870_s_nostock_big.stats.reload = 1
			self.parts.wpn_fps_shot_r870_s_folding.stats.reload = 3
			self.parts.wpn_fps_shot_r870_s_folding.stats.recoil = -3
			self.parts.wpn_fps_shot_r870_s_folding.stats.concealment = nil
			self.parts.wpn_fps_shot_r870_fg_wood.stats.spread = -4
			self.parts.wpn_fps_shot_r870_fg_wood.custom_stats = {fire_rate_multiplier = 1.09}
		end
		Gilza_init_r870()
		
		---- M590 ----
		local function Gilza_init_m590()
			self.parts.wpn_fps_sho_m590_body_rail.stats.recoil = 2
			self.parts.wpn_fps_sho_m590_body_rail.stats.spread = -1
			self.parts.wpn_fps_sho_m590_body_rail.stats.concealment = -1
			self.parts.wpn_fps_sho_m590_b_suppressor.stats.extra_ammo = 1
			self.parts.wpn_fps_sho_m590_b_suppressor.stats.recoil = -3
			self.parts.wpn_fps_sho_m590_b_suppressor.stats.spread = 4
			self.parts.wpn_fps_sho_m590_b_suppressor.stats.concealment = -2
		end
		Gilza_init_m590()
		
		---- SKO12 ----
		local function Gilza_init_sko12()
			self.parts.wpn_fps_sho_sko12_b_long.stats.spread = 1
			self.parts.wpn_fps_sho_sko12_conversion.stats.spread = 3
			self.parts.wpn_fps_sho_sko12_conversion.stats.recoil = 4
			self.parts.wpn_fps_sho_sko12_conversion.stats.concealment = -3
			table.insert(self.parts.wpn_fps_sho_sko12_conversion.forbids, "wpn_fps_upg_m4_s_a2")
			table.insert(self.parts.wpn_fps_sho_sko12_conversion.forbids, "wpn_fps_upg_m4_s_bus")
			table.insert(self.parts.wpn_fps_sho_sko12_conversion.forbids, "wpn_fps_upg_m4_s_cmmg")
			table.insert(self.parts.wpn_fps_sho_sko12_conversion.forbids, "wpn_fps_upg_m4_s_core")
			table.insert(self.parts.wpn_fps_sho_sko12_conversion.forbids, "wpn_fps_upg_m4_s_ddun")
			table.insert(self.parts.wpn_fps_sho_sko12_conversion.forbids, "wpn_fps_upg_m4_s_ds150")
			table.insert(self.parts.wpn_fps_sho_sko12_conversion.forbids, "wpn_fps_upg_m4_s_hke1")
			table.insert(self.parts.wpn_fps_sho_sko12_conversion.forbids, "wpn_fps_upg_m4_s_hkslim")
			table.insert(self.parts.wpn_fps_sho_sko12_conversion.forbids, "wpn_fps_upg_m4_s_moe")
			table.insert(self.parts.wpn_fps_sho_sko12_conversion.forbids, "wpn_fps_upg_m4_s_prs2")
			table.insert(self.parts.wpn_fps_sho_sko12_conversion.forbids, "wpn_fps_upg_m4_s_prs3")
			table.insert(self.parts.wpn_fps_sho_sko12_conversion.forbids, "wpn_fps_upg_m4_s_viper")
		end
		Gilza_init_sko12()
		
		---- BENELLI ----
		local function Gilza_init_benelli()
			self.parts.wpn_fps_sho_ben_s_solid.stats.spread = nil
			self.parts.wpn_fps_sho_ben_b_long.stats.spread = 1
		end
		Gilza_init_benelli()
		
		---- KSG ----
		local function Gilza_init_ksg()
			self.parts.wpn_fps_upg_o_mbus_rear.stats.spread = -2
			self.parts.wpn_fps_upg_o_mbus_rear.stats.recoil = -1
		end
		Gilza_init_ksg()
		
		---- SAIGA ----
		local function Gilza_init_saiga()
			self.parts.wpn_fps_sho_basset_m_extended.stats.reload = -5
			self.parts.wpn_upg_saiga_fg_lowerrail.stats.reload = 2
			self.wpn_fps_shot_saiga.override.wpn_fps_upg_ak_ns_zenitco = {stats = {damage = 5,recoil = 1,spread = 1}}
		end
		Gilza_init_saiga()
		
		---- M1897 ----
		local function Gilza_init_m1897()
			self.parts.wpn_fps_shot_m1897_b_short.stats.recoil = 2
			self.parts.wpn_fps_shot_m1897_b_short.stats.reload = 2
			self.parts.wpn_fps_shot_m1897_b_long.stats.recoil = -2
			self.parts.wpn_fps_shot_m1897_b_long.stats.spread = 3
		end
		Gilza_init_m1897()
		
		---- SUPERNOVA ----
		local function Gilza_init_supernova()
			self.parts.wpn_fps_sho_supernova_shell_rack.stats.total_ammo_mod = nil
			self.wpn_fps_sho_supernova.override.wpn_fps_sho_supernova_shell_rack = {override_weapon = {_meta = "override_weapon", AMMO_MAX = 47}}
			self.parts.wpn_fps_sho_supernova_s_raven.stats.concealment = nil
			table.insert(self.parts.wpn_fps_sho_supernova_g_standard.forbids, "wpn_fps_upg_m4_s_a2")
			table.insert(self.parts.wpn_fps_sho_supernova_g_standard.forbids, "wpn_fps_upg_m4_s_bus")
			table.insert(self.parts.wpn_fps_sho_supernova_g_standard.forbids, "wpn_fps_upg_m4_s_cmmg")
			table.insert(self.parts.wpn_fps_sho_supernova_g_standard.forbids, "wpn_fps_upg_m4_s_core")
			table.insert(self.parts.wpn_fps_sho_supernova_g_standard.forbids, "wpn_fps_upg_m4_s_ddun")
			table.insert(self.parts.wpn_fps_sho_supernova_g_standard.forbids, "wpn_fps_upg_m4_s_ds150")
			table.insert(self.parts.wpn_fps_sho_supernova_g_standard.forbids, "wpn_fps_upg_m4_s_hke1")
			table.insert(self.parts.wpn_fps_sho_supernova_g_standard.forbids, "wpn_fps_upg_m4_s_hkslim")
			table.insert(self.parts.wpn_fps_sho_supernova_g_standard.forbids, "wpn_fps_upg_m4_s_moe")
			table.insert(self.parts.wpn_fps_sho_supernova_g_standard.forbids, "wpn_fps_upg_m4_s_prs2")
			table.insert(self.parts.wpn_fps_sho_supernova_g_standard.forbids, "wpn_fps_upg_m4_s_prs3")
			table.insert(self.parts.wpn_fps_sho_supernova_g_standard.forbids, "wpn_fps_upg_m4_s_viper")
			table.insert(self.parts.wpn_fps_sho_supernova_g_raven.forbids, "wpn_fps_upg_m4_s_a2")
			table.insert(self.parts.wpn_fps_sho_supernova_g_raven.forbids, "wpn_fps_upg_m4_s_bus")
			table.insert(self.parts.wpn_fps_sho_supernova_g_raven.forbids, "wpn_fps_upg_m4_s_cmmg")
			table.insert(self.parts.wpn_fps_sho_supernova_g_raven.forbids, "wpn_fps_upg_m4_s_core")
			table.insert(self.parts.wpn_fps_sho_supernova_g_raven.forbids, "wpn_fps_upg_m4_s_ddun")
			table.insert(self.parts.wpn_fps_sho_supernova_g_raven.forbids, "wpn_fps_upg_m4_s_ds150")
			table.insert(self.parts.wpn_fps_sho_supernova_g_raven.forbids, "wpn_fps_upg_m4_s_hke1")
			table.insert(self.parts.wpn_fps_sho_supernova_g_raven.forbids, "wpn_fps_upg_m4_s_hkslim")
			table.insert(self.parts.wpn_fps_sho_supernova_g_raven.forbids, "wpn_fps_upg_m4_s_moe")
			table.insert(self.parts.wpn_fps_sho_supernova_g_raven.forbids, "wpn_fps_upg_m4_s_prs2")
			table.insert(self.parts.wpn_fps_sho_supernova_g_raven.forbids, "wpn_fps_upg_m4_s_prs3")
			table.insert(self.parts.wpn_fps_sho_supernova_g_raven.forbids, "wpn_fps_upg_m4_s_viper")
			table.insert(self.parts.wpn_fps_sho_supernova_g_stakeout.forbids, "wpn_fps_upg_m4_s_a2")
			table.insert(self.parts.wpn_fps_sho_supernova_g_stakeout.forbids, "wpn_fps_upg_m4_s_bus")
			table.insert(self.parts.wpn_fps_sho_supernova_g_stakeout.forbids, "wpn_fps_upg_m4_s_cmmg")
			table.insert(self.parts.wpn_fps_sho_supernova_g_stakeout.forbids, "wpn_fps_upg_m4_s_core")
			table.insert(self.parts.wpn_fps_sho_supernova_g_stakeout.forbids, "wpn_fps_upg_m4_s_ddun")
			table.insert(self.parts.wpn_fps_sho_supernova_g_stakeout.forbids, "wpn_fps_upg_m4_s_ds150")
			table.insert(self.parts.wpn_fps_sho_supernova_g_stakeout.forbids, "wpn_fps_upg_m4_s_hke1")
			table.insert(self.parts.wpn_fps_sho_supernova_g_stakeout.forbids, "wpn_fps_upg_m4_s_hkslim")
			table.insert(self.parts.wpn_fps_sho_supernova_g_stakeout.forbids, "wpn_fps_upg_m4_s_moe")
			table.insert(self.parts.wpn_fps_sho_supernova_g_stakeout.forbids, "wpn_fps_upg_m4_s_prs2")
			table.insert(self.parts.wpn_fps_sho_supernova_g_stakeout.forbids, "wpn_fps_upg_m4_s_prs3")
			table.insert(self.parts.wpn_fps_sho_supernova_g_stakeout.forbids, "wpn_fps_upg_m4_s_viper")
			self.parts.wpn_fps_sho_supernova_conversion.stats = {value = 1,total_ammo_mod = 3,concealment = 3,recoil = 2,extra_ammo = 1}
		end
		Gilza_init_supernova()
		
		---- HUMTSMAN ----
		local function Gilza_init_humtsman()
			-- all good
		end
		Gilza_init_humtsman()
		
		---- B682 ----
		local function Gilza_init_b682()
			self.parts.wpn_fps_shot_b682_s_ammopouch.stats.total_ammo_mod = nil
			self.wpn_fps_shot_b682.override.wpn_fps_shot_b682_s_ammopouch = {override_weapon = {_meta = "override_weapon", AMMO_MAX = 32}}
		end
		Gilza_init_b682()
		
		---- AA12 ----
		local function Gilza_init_aa12()
			self.parts.wpn_fps_sho_aa12_mag_drum.stats.reload = -6
			self.parts.wpn_fps_sho_aa12_barrel_long.stats.spread = 1
			self.parts.wpn_fps_sho_aa12_barrel_silenced.stats.damage = nil
			self.parts.wpn_fps_sho_aa12_barrel_silenced.stats.spread = -2
			self.parts.wpn_fps_sho_aa12_barrel_silenced.stats.recoil = 4
			self.parts.wpn_fps_sho_aa12_barrel_silenced.stats.concealment = -3
		end
		Gilza_init_aa12()
		
		---- SERBU ----
		local function Gilza_init_serbu()
			-- all good
		end
		Gilza_init_serbu()
		
		---- M37 ----
		local function Gilza_init_m37()
			self.parts.wpn_fps_shot_m37_b_short.stats.recoil = 2
		end
		Gilza_init_m37()
		
		---- ROTA ----
		local function Gilza_init_rota()
			self.parts.wpn_fps_sho_rota_b_silencer.stats.damage = nil
			self.parts.wpn_fps_sho_rota_b_silencer.stats.spread = -2
			self.parts.wpn_fps_sho_rota_b_silencer.stats.recoil = 4
			self.parts.wpn_fps_sho_rota_b_silencer.stats.concealment = -3
		end
		Gilza_init_rota()
		
		---- BASSET ----
		local function Gilza_init_basset()
			-- magazine override for akimbo version
			self.wpn_fps_sho_x_basset.override.wpn_fps_sho_basset_m_extended = {
				stats = {
					extra_ammo = 4,
					value = 1,
					concealment = -2,
					reload = -5
				}
			}
		end
		Gilza_init_basset()
		
		---- STRIKER ----
		local function Gilza_init_striker()
			self.parts.wpn_fps_sho_striker_b_suppressed.stats.damage = nil
			self.parts.wpn_fps_sho_striker_b_suppressed.stats.spread = -2
			self.parts.wpn_fps_sho_striker_b_suppressed.stats.recoil = 4
			self.parts.wpn_fps_sho_striker_b_suppressed.stats.concealment = -3
		end
		Gilza_init_striker()
		
		---- ULTIMA ----
		local function Gilza_init_ultima()
			self.wpn_fps_sho_ultima.override.wpn_fps_sho_ultima_body_rack = {override_weapon = {_meta = "override_weapon", AMMO_MAX = 54}}
			self.parts.wpn_fps_sho_ultima_body_rack.stats.total_ammo_mod = nil
		end
		Gilza_init_ultima()
		
	end
	init_Shotgun_mods()
	
	-- LMG individual
	local function init_LMG_mods()
		
		-- RPK
		self.parts.wpn_fps_lmg_rpk_fg_standard.stats.recoil = 1
		
		-- PAR
		self.parts.wpn_fps_lmg_par_s_plastic.stats.recoil = -1
		self.parts.wpn_fps_lmg_par_s_plastic.stats.concealment = 2
		self.parts.wpn_fps_lmg_par_b_short.stats.spread = -1
		
		-- M60
		self.parts.wpn_fps_lmg_m60_fg_tropical.stats.spread = -2
		self.parts.wpn_fps_lmg_m60_fg_tropical.stats.recoil = 3
		self.parts.wpn_fps_lmg_m60_fg_keymod.stats.spread = 2
		
		-- HK51
		self.parts.wpn_fps_lmg_hk51b_b_fluted.stats.recoil = -2
		
		-- KACCHAINSAW
		self.parts.wpn_fps_lmg_kacchainsaw_sling.stats.recoil = 4
		self.parts.wpn_fps_lmg_kacchainsaw_sling.stats.spread = 1
		self.parts.wpn_fps_lmg_kacchainsaw_b_long.stats.spread = 2
		self.parts.wpn_fps_lmg_kacchainsaw_b_long.stats.spread = nil
		self.parts.wpn_fps_lmg_kacchainsaw_mag_b.stats.spread = -2
		self.parts.wpn_fps_lmg_kacchainsaw_mag_b.stats.recoil = 2
		self.parts.wpn_fps_lmg_kacchainsaw_flamethrower.stats = {concealment = -9,spread = -5,value = 1,recoil = 3}
		self.parts.wpn_fps_lmg_kacchainsaw_flamethrower.custom_stats = {ammo_pickup_min_mul = 0.65,ammo_pickup_max_mul = 0.65}
		self.parts.wpn_fps_lmg_kacchainsaw_flamethrower.has_description = true
		self.parts.wpn_fps_lmg_kacchainsaw_flamethrower.desc_id = "bm_wpn_fps_upg_lmg_kacchainsaw_underbarrel_flamethrower_desc"
		self.parts.wpn_fps_lmg_kacchainsaw_conversionkit.stats = {extra_ammo = 50,damage = -20,value = 1,spread = 1,recoil = 4}
		self.parts.wpn_fps_lmg_kacchainsaw_conversionkit.override_weapon = {_meta = "override_weapon",AMMO_MAX = 500}
		self.parts.wpn_fps_lmg_kacchainsaw_conversionkit.custom_stats = {ammo_pickup_min_mul = 1.25,ammo_pickup_max_mul = 1.25,fire_rate_multiplier = 1.25}
		self.parts.wpn_fps_lmg_kacchainsaw_conversionkit.has_description = true
		self.parts.wpn_fps_lmg_kacchainsaw_conversionkit.desc_id = "bm_wpn_fps_upg_lmg_kacchainsaw_conversionkit_desc"
		
		-- M249
		self.parts.wpn_fps_lmg_m249_fg_mk46.stats.spread = 1
		self.parts.wpn_fps_lmg_m249_fg_mk46.stats.recoil = -1
		self.parts.wpn_fps_lmg_m249_b_long.stats.reload = -1
		
		-- HCAR
		self.parts.wpn_fps_lmg_hcar_m_drum.stats.concealment = -6
		self.parts.wpn_fps_lmg_hcar_m_drum.stats.reload = -8
		self.parts.wpn_fps_lmg_hcar_m_drum.stats.recoil = 7
		self.parts.wpn_fps_lmg_hcar_m_drum.stats.spread = -6
		self.parts.wpn_fps_lmg_hcar_m_stick.stats.reload = -3
		self.parts.wpn_fps_lmg_hcar_m_stick.stats.recoil = 3
		self.parts.wpn_fps_lmg_hcar_m_stick.stats.spread = -2
		self.parts.wpn_fps_lmg_hcar_barrel_dmr.stats = {concealment = -2,spread = 3,recoil = -3,value = 3}
		self.parts.wpn_fps_lmg_hcar_barrel_dmr.override_weapon = {_meta = "override_weapon", AMMO_MAX = 120}
		self.parts.wpn_fps_lmg_hcar_barrel_dmr.adds = {"wpn_fps_upg_ap_kit_ap_rounds"}
		self.parts.wpn_fps_lmg_hcar_barrel_dmr.custom_stats = {fire_rate_multiplier = 0.6667}
		self.parts.wpn_fps_lmg_hcar_barrel_dmr.perks = {"fire_mode_single"}
		self.parts.wpn_fps_lmg_hcar_barrel_dmr.name_id = "wpn_fps_lmg_hcar_barrel_dmr_PEN"
		self.parts.wpn_fps_lmg_hcar_barrel_dmr.has_description = true
		self.parts.wpn_fps_lmg_hcar_barrel_dmr.desc_id = "bm_wpn_fps_lmg_hcar_barrel_dmr_PEN_desc"
		self.parts.wpn_fps_lmg_hcar_barrel_dmr.forbids = {"wpn_fps_lmg_hcar_m_drum"}
		self.parts.wpn_fps_lmg_hcar_body_conversionkit.stats = {extra_ammo = 40,total_ammo_mod = 20,damage = -50,value = 1,spread = -8,recoil = 7,fire_rate = 1.5,reload = -6}
		self.parts.wpn_fps_lmg_hcar_body_conversionkit.custom_stats.fire_rate_multiplier = 1.5
		self.parts.wpn_fps_lmg_hcar_body_conversionkit.custom_stats.ammo_pickup_min_mul = 1.664
		self.parts.wpn_fps_lmg_hcar_body_conversionkit.custom_stats.ammo_pickup_max_mul = 1.664
		self.parts.wpn_fps_lmg_hcar_body_conversionkit.has_description = true
		self.parts.wpn_fps_lmg_hcar_body_conversionkit.desc_id = "bm_wpn_fps_lmg_hcar_body_conversionkit_desc"
		
		-- MG42
		self.parts.wpn_fps_lmg_mg42_b_vg38.stats.spread = 3
		self.parts.wpn_fps_lmg_mg42_b_vg38.stats.recoil = 2
		self.parts.wpn_fps_lmg_mg42_b_vg38.stats.concealment = -1
		self.parts.wpn_fps_lmg_mg42_b_mg34.stats.recoil = -2
		self.parts.wpn_fps_lmg_mg42_b_mg34.stats.spread = 3
		
		-- HK21
		self.parts.wpn_fps_lmg_hk21_b_long.stats.damage = nil
		self.parts.wpn_fps_lmg_hk21_b_long.stats.spread = 2
		self.parts.wpn_fps_lmg_hk21_b_long.stats.recoil = -1
		
	end
	init_LMG_mods()
	
	-- SMG individual, akimbo versions included with non-akimbo version
	local function init_SMG_mods()
		
		---- M45 ----
		local function Gilza_init_m45()
			self.parts.wpn_fps_smg_m45_m_extended.stats.reload = -2
			self.parts.wpn_fps_smg_m45_m_extended.stats.extra_ammo = 3
			self.wpn_fps_smg_x_m45.override.wpn_fps_smg_m45_m_extended.stats.reload = -2
			self.wpn_fps_smg_x_m45.override.wpn_fps_smg_m45_m_extended.stats.extra_ammo = 6
			self.parts.wpn_fps_smg_m45_b_green.stats.recoil = nil
			self.parts.wpn_fps_smg_m45_b_small.stats.reload = 2
		end
		Gilza_init_m45()
		
		---- MP7 ----
		local function Gilza_init_mp7()
			self.parts.wpn_fps_smg_mp7_m_extended.stats.reload = -3
			self.wpn_fps_smg_x_mp7.override.wpn_fps_smg_mp7_m_extended.stats.reload = -3
		end
		Gilza_init_mp7()
		
		---- MAC10 ----
		local function Gilza_init_mac10()
			self.parts.wpn_fps_smg_mac10_s_skel.stats.recoil = 2
			self.parts.wpn_fps_smg_mac10_m_quick.stats.reload = 6
			self.parts.wpn_fps_smg_mac10_m_quick.stats.spread = -2
			self.parts.wpn_fps_smg_mac10_m_quick.stats.concealment = -2
			self.wpn_fps_smg_x_mac10.override.wpn_fps_smg_mac10_m_quick.stats.reload = 6
			self.wpn_fps_smg_x_mac10.override.wpn_fps_smg_mac10_m_quick.stats.spread = -2
			self.wpn_fps_smg_x_mac10.override.wpn_fps_smg_mac10_m_quick.stats.recoil = -2
			self.wpn_fps_smg_x_mac10.override.wpn_fps_smg_mac10_m_quick.stats.concealment = -2
			self.parts.wpn_fps_smg_mac10_m_extended.stats.recoil = 2
			self.wpn_fps_smg_x_mac10.override.wpn_fps_smg_mac10_m_extended.stats.recoil = 2
		end
		Gilza_init_mac10()
		
		---- HAJK ----
		local function Gilza_init_hajk()
			self.wpn_fps_smg_x_hajk.override.wpn_fps_ass_l85a2_m_emag = {override_weapon = {_meta = "override_weapon",CLIP_AMMO_MAX = 60},stats = {value = 1,recoil = 1,concealment = -1,}}
			self.wpn_fps_smg_x_hajk.override.wpn_fps_upg_m4_m_pmag = {override_weapon = {_meta = "override_weapon",CLIP_AMMO_MAX = 60},stats = {value = 3,concealment = -1,spread = 1}}
			self.wpn_fps_smg_x_hajk.override.wpn_fps_upg_m4_m_l5 = {override_weapon = {_meta = "override_weapon",CLIP_AMMO_MAX = 56},stats = {recoil = 1,value = 1,reload = 4}}
			self.wpn_fps_smg_x_hajk.override.wpn_fps_upg_m4_m_quad = {override_weapon = {_meta = "override_weapon",CLIP_AMMO_MAX = 60},stats = {recoil = 1,value = 1,reload = 3}}
			self.wpn_fps_smg_x_hajk.override.wpn_fps_upg_m4_m_straight = {override_weapon = {_meta = "override_weapon",CLIP_AMMO_MAX = 40},stats = {reload = 6,concealment = 3}}
		end
		Gilza_init_hajk()
		
		---- VITYAZ ----
		local function Gilza_init_vityaz()
			self.parts.wpn_fps_smg_vityaz_b_supressed.stats.spread = 1
			self.parts.wpn_fps_smg_vityaz_b_supressed.stats.recoil = 1
			self.wpn_fps_smg_x_vityaz.override.wpn_fps_upg_m_vityazpmag = {override_weapon = {_meta = "override_weapon", CLIP_AMMO_MAX = 66}}
			self.wpn_fps_smg_x_vityaz.override.wpn_fps_upg_m_puf30 = {override_weapon = {_meta = "override_weapon", CLIP_AMMO_MAX = 60}}
			self.wpn_fps_smg_x_vityaz.override.wpn_fps_upg_m_puf20 = {override_weapon = {_meta = "override_weapon", CLIP_AMMO_MAX = 40}}
			self.wpn_fps_smg_x_vityaz.override.wpn_fps_upg_m_cap10 = {override_weapon = {_meta = "override_weapon", CLIP_AMMO_MAX = 20}}
		end
		Gilza_init_vityaz()
		
		---- COBRAY ----
		local function Gilza_init_cobray()
			self.parts.wpn_fps_smg_cobray_body_upper_jacket.stats.damage = nil
			self.parts.wpn_fps_smg_cobray_body_upper_jacket.stats.recoil = 1
			self.parts.wpn_fps_smg_cobray_body_upper_jacket.stats.concealment = -1
			self.parts.wpn_fps_smg_cobray_ns_barrelextension.stats.spread = 2
			self.parts.wpn_fps_smg_cobray_ns_barrelextension.stats.recoil = 1
			self.parts.wpn_fps_smg_cobray_ns_barrelextension.stats.concealment = -3
			self.parts.wpn_fps_smg_cobray_ns_silencer.stats.spread = 2
			self.parts.wpn_fps_smg_cobray_ns_silencer.stats.recoil = 2
			self.parts.wpn_fps_smg_cobray_ns_silencer.stats.concealment = -2
		end
		Gilza_init_cobray()
		
		---- MP5 ----
		local function Gilza_init_mp5()
			self.parts.wpn_fps_smg_mp5_s_folding.stats.concealment = 2
			self.parts.wpn_fps_smg_mp5_s_folding.stats.recoil = -1
			self.parts.wpn_fps_smg_mp5_s_adjust.stats.recoil = -2
			self.parts.wpn_fps_smg_mp5_m_straight.stats.extra_ammo = -2.5
			self.parts.wpn_fps_smg_mp5_m_straight.stats.damage = 95
			self.parts.wpn_fps_smg_mp5_m_straight.stats.spread = -3
			self.parts.wpn_fps_smg_mp5_m_straight.stats.recoil = -6
			self.parts.wpn_fps_smg_mp5_m_straight.stats.reload = 2
			self.parts.wpn_fps_smg_mp5_m_straight.stats.concealment = -4
			self.wpn_fps_smg_mp5.override.wpn_fps_smg_mp5_m_straight = {override_weapon = {_meta = "override_weapon", AMMO_MAX = 125}}
			self.parts.wpn_fps_smg_mp5_m_straight.custom_stats = {ammo_pickup_min_mul = 0.55,ammo_pickup_max_mul = 0.55}
			self.parts.wpn_fps_smg_mp5_m_straight.name_id = "bm_wpn_fps_smg_mp5_m_straight_R"
			self.parts.wpn_fps_smg_mp5_m_straight.has_description = true
			self.parts.wpn_fps_smg_mp5_m_straight.desc_id = "bm_wpn_fps_smg_mp5_m_straight_R_desc"
			self.wpn_fps_smg_x_mp5.override.wpn_fps_smg_mp5_m_straight.stats = {extra_ammo = -5,damage = 48,spread = -3,recoil = -6,reload = 2,concealment = -4}
			self.wpn_fps_smg_x_mp5.override.wpn_fps_smg_mp5_m_straight.override_weapon = {_meta = "override_weapon", AMMO_MAX = 100}
			self.parts.wpn_fps_smg_mp5_fg_flash.stats.spread = nil
			self.parts.wpn_fps_smg_mp5_fg_flash.has_description = true
			self.parts.wpn_fps_smg_mp5_fg_flash.desc_id = "bm_flashlight_gadget_module"
			self.parts.wpn_fps_smg_mp5_fg_flash.forbids = {
				"wpn_fps_upg_fl_ass_utg",
				"wpn_fps_upg_fl_ass_peq15",
				"wpn_fps_upg_fl_ass_smg_sho_surefire"	
			}
			self.parts.wpn_fps_smg_mp5_fg_mp5a5.stats.spread = 1
			self.parts.wpn_fps_smg_mp5_fg_mp5a5.stats.recoil = nil
			self.parts.wpn_fps_smg_mp5_fg_mp5a5.stats.concealment = -2
			self.parts.wpn_fps_smg_mp5_fg_mp5sd.stats.spread = 2
			self.parts.wpn_fps_smg_mp5_fg_mp5sd.stats.recoil = 2
			self.parts.wpn_fps_smg_mp5_fg_m5k.stats.recoil = -2
		end
		Gilza_init_mp5()
		
		---- M1928 ----
		local function Gilza_init_m1928()
			self.parts.wpn_fps_smg_thompson_barrel_long.stats.damage = nil
			self.parts.wpn_fps_smg_thompson_barrel_long.stats.reload = -2
			self.parts.wpn_fps_smg_thompson_barrel_short.stats.spread = -2
			self.parts.wpn_fps_smg_thompson_barrel_short.stats.reload = 2
		end
		Gilza_init_m1928()
		
		---- FMG9 ----
		local function Gilza_init_fmg9()
			self.parts.wpn_fps_smg_fmg9_stock_padded.stats.spread = 1
			self.parts.wpn_fps_smg_fmg9_stock_padded.stats.recoil = 1
			self.parts.wpn_fps_smg_fmg9_conversion.stats.damage = nil
			self.parts.wpn_fps_smg_fmg9_conversion.stats.recoil = 3
		end
		Gilza_init_fmg9()
		
		---- PM9 ----
		local function Gilza_init_pm9()
			self.parts.wpn_fps_smg_pm9_s_tactical.stats.recoil = 2
		end
		Gilza_init_pm9()
		
		---- SCORPION ----
		local function Gilza_init_scorpion()
			self.parts.wpn_fps_smg_scorpion_s_unfolded.stats.recoil = 2
			self.parts.wpn_fps_smg_scorpion_b_suppressed.stats.spread = 1
		end
		Gilza_init_scorpion()
		
		---- MP9 ----
		local function Gilza_init_mp9()
			self.parts.wpn_fps_smg_mp9_s_skel.stats.recoil = 2
		end
		Gilza_init_mp9()
		
		---- OLYMPIC ----
		local function Gilza_init_olympic()
			self.parts.wpn_fps_smg_olympic_fg_railed.stats.concealment = 2
			self.parts.wpn_fps_upg_smg_olympic_fg_lr300.stats.concealment = 1
			self.wpn_fps_smg_olympic.override.wpn_fps_m4_uupg_m_strike = {
				override_weapon = {
					_meta = "override_weapon",
					CLIP_AMMO_MAX = 35
				},
				stats = {
					recoil = 1,
					spread = -2,
					reload = 1,
					concealment = -2
				}
			}
			self.wpn_fps_smg_olympic.override.wpn_fps_m4_upg_m_quick = {
				override_weapon = {
					_meta = "override_weapon",
					CLIP_AMMO_MAX = 30
				},
				stats = {
					reload = 10,
					value = 2,
					spread = -2,
					concealment = -2,
					recoil = -2	
				}
			}
			self.wpn_fps_smg_olympic.override.wpn_fps_upg_m4_m_l5 = {
				override_weapon = {
					_meta = "override_weapon",
					CLIP_AMMO_MAX = 28
				},
				stats = {
					recoil = 1,
					value = 1,
					reload = 4
				}
			}
			self.wpn_fps_smg_olympic.override.wpn_fps_ass_l85a2_m_emag = {
				override_weapon = {
					_meta = "override_weapon",
					CLIP_AMMO_MAX = 30
				},
				stats = {
					value = 1,
					recoil = 1,
					concealment = -1,
				}
			}
			self.wpn_fps_smg_olympic.override.wpn_fps_upg_m4_m_quad = {
				override_weapon = {
					_meta = "override_weapon",
					CLIP_AMMO_MAX = 60
				},
				stats = {
					value = 3,
					recoil = 4,
					spread = -3,
					concealment = -5,
					spread_moving = -2,
					reload = -6
				}
			}
			self.wpn_fps_smg_olympic.override.wpn_fps_upg_m4_m_pmag = {
				override_weapon = {
					_meta = "override_weapon",
					CLIP_AMMO_MAX = 30
				},
				stats = {
					value = 3,
					concealment = -1,
					spread = 1
				}
			}
			self.wpn_fps_smg_x_olympic.override.wpn_fps_m4_upg_m_quick = {override_weapon = {_meta = "override_weapon",CLIP_AMMO_MAX = 60},stats = {reload = 10,value = 2,spread = -2,concealment = -2,recoil = -2}}
			self.wpn_fps_smg_x_olympic.override.wpn_fps_m4_uupg_m_strike = {override_weapon = {_meta = "override_weapon",CLIP_AMMO_MAX = 70},stats = {recoil = 1,spread = -2,reload = 1,concealment = -2}}
			self.wpn_fps_smg_x_olympic.override.wpn_fps_ass_l85a2_m_emag = {override_weapon = {_meta = "override_weapon",CLIP_AMMO_MAX = 60},stats = {value = 1,recoil = 1,concealment = -1,}}
			self.wpn_fps_smg_x_olympic.override.wpn_fps_upg_m4_m_pmag = {override_weapon = {_meta = "override_weapon",CLIP_AMMO_MAX = 60},stats = {value = 3,concealment = -1,spread = 1}}
			self.wpn_fps_smg_x_olympic.override.wpn_fps_upg_m4_m_l5 = {override_weapon = {_meta = "override_weapon",CLIP_AMMO_MAX = 56},stats = {recoil = 1,value = 1,reload = 4}}
			self.wpn_fps_smg_x_olympic.override.wpn_fps_upg_m4_m_quad = {override_weapon = {_meta = "override_weapon",CLIP_AMMO_MAX = 120},stats = {recoil = 1,value = 1,reload = 3}}
			self.wpn_fps_smg_x_olympic.override.wpn_fps_m4_uupg_m_std = {override_weapon = {_meta = "override_weapon",CLIP_AMMO_MAX = 60},stats = {spread = -1}}
		end
		Gilza_init_olympic()
		
		---- BAKA ----
		local function Gilza_init_baka()
			-- all good
		end
		Gilza_init_baka()
		
		---- SHEPHEARD ----
		local function Gilza_init_shepheard()
			self.parts.wpn_fps_smg_shepheard_mag_extended.stats.extra_ammo = 7
			self.parts.wpn_fps_smg_shepheard_mag_extended.stats.reload = -3
			self.wpn_fps_smg_x_shepheard.override.wpn_fps_smg_shepheard_mag_extended.stats.extra_ammo = 14
			self.wpn_fps_smg_x_shepheard.override.wpn_fps_smg_shepheard_mag_extended.stats.reload = -3
		end
		Gilza_init_shepheard()

		---- SCHAKAL ----
		local function Gilza_init_schakal()
			self.parts.wpn_fps_smg_schakal_m_short.stats.reload = 2
			self.parts.wpn_fps_smg_schakal_m_long.stats.reload = -5
			self.parts.wpn_fps_smg_schakal_ns_silencer.stats.spread = 1
			self.parts.wpn_fps_smg_schakal_b_civil.stats.damage = nil
			self.parts.wpn_fps_smg_schakal_b_civil.stats.recoil = -1
			self.parts.wpn_fps_smg_schakal_vg_surefire.stats.recoil = 2
			self.parts.wpn_fps_smg_schakal_vg_surefire.stats.spread = 1
			self.parts.wpn_fps_smg_schakal_vg_surefire.stats.concealment = -3
			self.parts.wpn_fps_smg_schakal_vg_surefire.forbids = {
				"wpn_fps_upg_fl_ass_utg",
				"wpn_fps_upg_fl_ass_peq15",
				"wpn_fps_upg_fl_ass_smg_sho_surefire",
				"wpn_fps_upg_fl_dbal_laser",
				"wpn_fps_upg_fl_ass_laser",
				"wpn_fps_upg_fl_ass_smg_sho_peqbox"
			}
			self.parts.wpn_fps_smg_schakal_vg_surefire.has_description = true
			self.parts.wpn_fps_smg_schakal_vg_surefire.desc_id = "bm_combined_gadget_module"
			self.wpn_fps_smg_x_schakal.override.wpn_fps_smg_schakal_m_short.stats.reload = 2
			self.wpn_fps_smg_x_schakal.override.wpn_fps_smg_schakal_m_long.stats.reload = -5
		end
		Gilza_init_schakal()
		
		---- ERMA ----
		local function Gilza_init_erma()
			-- all good
		end
		Gilza_init_erma()
		
		---- SR2 ----
		local function Gilza_init_sr2()
			self.parts.wpn_fps_smg_sr2_s_unfolded.stats.concealment = -1
			self.parts.wpn_fps_smg_sr2_m_quick.stats.spread = -2
			self.parts.wpn_fps_smg_sr2_m_quick.stats.reload = 8
		end
		Gilza_init_sr2()
		
		---- AKMSU ----
		local function Gilza_init_akmsu()
			-- all good
		end
		Gilza_init_akmsu()
		
		---- TEC9 ----
		local function Gilza_init_tec9()
			self.parts.wpn_fps_smg_tec9_s_unfolded.stats.recoil = 2
			self.parts.wpn_fps_smg_tec9_b_standard.stats.reload = 2
			self.parts.wpn_fps_smg_tec9_ns_ext.stats.damage = nil
			self.parts.wpn_fps_smg_tec9_ns_ext.stats.spread = 1
			self.parts.wpn_fps_smg_tec9_ns_ext.stats.recoil = 1
			self.parts.wpn_fps_smg_tec9_m_extended.stats.reload = -4
			self.wpn_fps_smg_x_tec9.override.wpn_fps_smg_tec9_m_extended.stats.reload = -4
		end
		Gilza_init_tec9()
		
		---- P90 ----
		local function Gilza_init_p90()
			self.parts.wpn_fps_smg_p90_m_strap.stats.spread = -2
			self.parts.wpn_fps_smg_p90_m_strap.stats.reload = 8
			self.parts.wpn_fps_smg_p90_b_ninja.stats.spread = 3
			self.parts.wpn_fps_smg_p90_b_ninja.stats.concealment = -4
			self.parts.wpn_fps_smg_p90_b_civilian.stats.concealment = -3
			self.parts.wpn_fps_smg_p90_b_long.stats.spread = 1
			self.parts.wpn_fps_smg_p90_b_long.stats.recoil = 1
		end
		Gilza_init_p90()
		
		---- POLYMER ----
		local function Gilza_init_polymer()
			-- all good
		end
		Gilza_init_polymer()
		
		---- COAL ----
		local function Gilza_init_coal()
			-- all good
		end
		Gilza_init_coal()
		
		---- STERLING ----
		local function Gilza_init_sterling()
			self.parts.wpn_fps_smg_sterling_b_long.stats.damage = nil
			self.parts.wpn_fps_smg_sterling_b_short.stats.reload = 3
			self.parts.wpn_fps_smg_sterling_b_suppressed.stats.recoil = 3
			self.parts.wpn_fps_smg_sterling_b_e11.stats.reload = 1
			self.parts.wpn_fps_smg_sterling_b_e11.stats.recoil = 2
		end
		Gilza_init_sterling()
		
		---- UZI ----
		local function Gilza_init_uzi()
			self.parts.wpn_fps_smg_uzi_b_suppressed.stats.spread = 2
			self.parts.wpn_fps_smg_uzi_fg_rail.stats.spread = -1
			self.parts.wpn_fps_smg_uzi_fg_rail.stats.recoil = 2
		end
		Gilza_init_uzi()
		
	end
	init_SMG_mods()
	
	-- Special individual
	local function init_Special_mods()
		
		-- MICROGUN
		self.parts.wpn_fps_lmg_shuno_b_heat_short.stats.recoil = 3
		self.parts.wpn_fps_lmg_shuno_b_heat_long.stats.spread = 3
		self.parts.wpn_fps_lmg_shuno_b_heat_long.stats.recoil = -2
		
		-- MINIGUN
		self.parts.wpn_fps_lmg_m134_barrel_extreme.stats.spread = 2
		self.parts.wpn_fps_lmg_m134_barrel_extreme.stats.recoil = -2
		self.parts.wpn_fps_lmg_m134_body_upper_light.stats.spread = 2
		self.parts.wpn_fps_lmg_m134_body_upper_light.stats.recoil = 1
		self.parts.wpn_fps_lmg_m134_body_upper_light.stats.reload = 7
		self.parts.wpn_fps_lmg_m134_body_upper_light.stats.total_ammo_mod = nil
		self.parts.wpn_fps_lmg_m134_body_upper_light.override_weapon = {_meta = "override_weapon",AMMO_MAX = 600,CLIP_AMMO_MAX = 300}
		
		-- HAILSTORM
		self.parts.wpn_fps_hailstorm_conversion.stats.spread = 1
		self.parts.wpn_fps_hailstorm_conversion.stats.recoil = 3
		self.parts.wpn_fps_hailstorm_conversion.stats.total_ammo_mod = nil
		self.parts.wpn_fps_hailstorm_conversion.stats.reload = 2
		
		-- PISTOL CROSSBOW
		self.parts.wpn_fps_bow_hunter_m_standard.custom_stats = {armor_piercing_add = 1}
		self.parts.wpn_fps_upg_a_crossbow_poison.stats = {total_ammo_mod = -10}
		self.parts.wpn_fps_upg_a_crossbow_poison.custom_stats.armor_piercing_add = 1
		self.parts.wpn_fps_upg_a_crossbow_poison.desc_id = "bm_wpn_fps_upg_a_pistol_crossbow_poison_desc"

		-- LIGHT CROSSBOW
		self.parts.wpn_fps_bow_frankish_m_standard.custom_stats = {armor_piercing_add = 1}
		self.parts.wpn_fps_bow_frankish_m_poison.stats = {total_ammo_mod = -10}
		self.parts.wpn_fps_bow_frankish_m_poison.custom_stats.armor_piercing_add = 1
		self.parts.wpn_fps_bow_frankish_m_poison.desc_id = "bm_wpn_fps_upg_a_light_crossbow_poison_desc"

		-- PLAINSRIDER
		self.parts.wpn_fps_bow_plainsrider_m_standard.custom_stats = {armor_piercing_add = 1}
		self.parts.wpn_fps_upg_a_bow_poison.stats = {total_ammo_mod = -10}
		self.parts.wpn_fps_upg_a_bow_poison.custom_stats.armor_piercing_add = 1
		self.parts.wpn_fps_upg_a_bow_poison.desc_id = "bm_wpn_fps_upg_a_crossbow_poison_desc_new"

		-- BRITISH LONGBOW
		self.parts.wpn_fps_bow_long_m_standard.custom_stats = {armor_piercing_add = 1}
		self.parts.wpn_fps_bow_long_m_poison.stats = {total_ammo_mod = -10}
		self.parts.wpn_fps_bow_long_m_poison.custom_stats.armor_piercing_add = 1
		self.parts.wpn_fps_bow_long_m_poison.desc_id = "bm_wpn_fps_upg_a_crossbow_poison_desc_new"

		-- DECA COMPOUND
		self.parts.wpn_fps_bow_elastic_m_standard.custom_stats = {armor_piercing_add = 1}
		self.parts.wpn_fps_bow_elastic_m_poison.stats = {total_ammo_mod = -10}
		self.parts.wpn_fps_bow_elastic_m_poison.custom_stats.armor_piercing_add = 1
		self.parts.wpn_fps_bow_elastic_m_poison.desc_id = "bm_wpn_fps_upg_a_crossbow_poison_desc_new"

		-- HEAVY CROSSBOW
		self.parts.wpn_fps_bow_arblast_m_standard.custom_stats = {armor_piercing_add = 1}
		self.parts.wpn_fps_bow_arblast_m_poison.stats = {total_ammo_mod = -10}
		self.parts.wpn_fps_bow_arblast_m_poison.custom_stats.armor_piercing_add = 1
		self.parts.wpn_fps_bow_arblast_m_poison.desc_id = "bm_wpn_fps_upg_a_crossbow_poison_desc_new"

		-- H3H3
		self.parts.wpn_fps_bow_ecp_m_arrows_standard.custom_stats = {armor_piercing_add = 1}
		self.parts.wpn_fps_bow_ecp_m_arrows_poison.stats = {total_ammo_mod = -10}
		self.parts.wpn_fps_bow_ecp_m_arrows_poison.custom_stats.armor_piercing_add = 1
		self.parts.wpn_fps_bow_ecp_m_arrows_poison.desc_id = "bm_wpn_fps_upg_a_h3h3_poison_desc"
		
		---- FLAMMENWERFERS
		-- primary
		-- rare mag
		self.parts.wpn_fps_fla_mk2_mag_rare.has_description = true
		self.parts.wpn_fps_fla_mk2_mag_rare.desc_id = "bm_wpn_fps_fla_mk2_mag_rare_desc"
		self.parts.wpn_fps_fla_mk2_mag_rare.stats = {
			value = 1,
			total_ammo_mod = 10,
			damage = -14
		}
		-- well done mag
		self.parts.wpn_fps_fla_mk2_mag_welldone.has_description = true
		self.parts.wpn_fps_fla_mk2_mag_welldone.desc_id = "bm_wpn_fps_fla_mk2_mag_welldone_desc"
		self.parts.wpn_fps_fla_mk2_mag_welldone.stats = {
			value = 1,
			total_ammo_mod = -5,
			damage = 15
		}
		-- secondary
		-- high temp mix
		self.parts.wpn_fps_fla_system_m_high.has_description = true
		self.parts.wpn_fps_fla_system_m_high.type = "ammo"
		self.parts.wpn_fps_fla_system_m_high.desc_id = "bm_wpn_fps_fla_mk2_mag_welldone_desc" -- has same stats so use same description
		self.parts.wpn_fps_fla_system_m_high.stats = {
			value = 1,
			total_ammo_mod = -5,
			damage = 10
		}
		-- low temp mix
		self.parts.wpn_fps_fla_system_m_low.type = "ammo"
		self.parts.wpn_fps_fla_system_m_low.desc_id = "bm_wpn_fps_fla_mk2_mag_rare_desc"
		self.parts.wpn_fps_fla_system_m_low.stats = {
			value = 1,
			total_ammo_mod = 10,
			damage = -9
		}
		
		-- GL's INCLUDES UNDERBARRELS
		-- poison
		self.parts.wpn_fps_upg_a_grenade_launcher_poison.stats = {}
		self.parts.wpn_fps_upg_a_grenade_launcher_poison.desc_id = "bm_wpn_fps_upg_a_grenade_launcher_poison_default_desc"
		self.parts.wpn_fps_upg_a_grenade_launcher_poison_ms3gl.stats = {}
		self.parts.wpn_fps_upg_a_grenade_launcher_poison_ms3gl.desc_id = "bm_wpn_fps_upg_a_grenade_launcher_poison_ms3gl_desc"
		self.parts.wpn_fps_gre_ms3gl_conversion.desc_id = "bm_wpn_fps_upg_a_grenade_launcher_poison_ms3gl_CK_desc"
		self.parts.wpn_fps_gre_ms3gl_conversion.stats.damage = 12
		self.parts.wpn_fps_upg_a_grenade_launcher_poison_arbiter.stats = {}
		self.parts.wpn_fps_upg_a_grenade_launcher_poison_arbiter.desc_id = "bm_wpn_fps_upg_a_grenade_launcher_poison_arbiter_desc"
		self.parts.wpn_fps_upg_a_underbarrel_poison.desc_id = "bm_wpn_fps_upg_a_grenade_launcher_poison_underbarrel_desc"
		-- fire
		self.parts.wpn_fps_upg_a_grenade_launcher_incendiary.desc_id = "bm_wpn_fps_upg_a_grenade_launcher_incendiary_desc"
		self.parts.wpn_fps_upg_a_grenade_launcher_incendiary.custom_stats.ammo_pickup_max_mul = 0.5
		self.parts.wpn_fps_upg_a_grenade_launcher_incendiary.custom_stats.ammo_pickup_min_mul = 0.5
		self.parts.wpn_fps_upg_a_grenade_launcher_incendiary_ms3gl.desc_id = "bm_wpn_fps_upg_a_grenade_launcher_incendiary_ms3gl_desc"
		self.parts.wpn_fps_upg_a_grenade_launcher_incendiary_ms3gl.custom_stats.ammo_pickup_min_mul = 0.25
		self.parts.wpn_fps_upg_a_grenade_launcher_incendiary_ms3gl.custom_stats.ammo_pickup_max_mul = 0.25
		self.parts.wpn_fps_upg_a_grenade_launcher_incendiary_arbiter.desc_id = "bm_wpn_fps_upg_a_grenade_launcher_incendiary_arbiter_desc"
		self.parts.wpn_fps_upg_a_grenade_launcher_incendiary_arbiter.custom_stats.ammo_pickup_max_mul = 0.5
		self.parts.wpn_fps_upg_a_grenade_launcher_incendiary_arbiter.custom_stats.ammo_pickup_min_mul = 0.5
		-- electric
		self.parts.wpn_fps_upg_a_grenade_launcher_electric.custom_stats.ammo_pickup_min_mul = 0.9
		self.parts.wpn_fps_upg_a_grenade_launcher_electric.custom_stats.ammo_pickup_max_mul = 0.9
		self.parts.wpn_fps_upg_a_grenade_launcher_electric.desc_id = "bm_wpn_fps_upg_a_grenade_launcher_electric_desc"
		self.parts.wpn_fps_upg_a_grenade_launcher_electric_arbiter.custom_stats.ammo_pickup_min_mul = 0.9
		self.parts.wpn_fps_upg_a_grenade_launcher_electric_arbiter.custom_stats.ammo_pickup_max_mul = 0.9
		self.parts.wpn_fps_upg_a_grenade_launcher_electric_arbiter.desc_id = "bm_wpn_fps_upg_a_grenade_launcher_electric_desc"
		self.parts.wpn_fps_upg_a_grenade_launcher_electric_ms3gl.custom_stats.ammo_pickup_min_mul = 0.9
		self.parts.wpn_fps_upg_a_grenade_launcher_electric_ms3gl.custom_stats.ammo_pickup_max_mul = 0.9
		self.parts.wpn_fps_upg_a_grenade_launcher_electric_ms3gl.desc_id = "bm_wpn_fps_upg_a_grenade_launcher_electric_desc"
		-- shotgun round
		self.parts.wpn_fps_upg_a_grenade_launcher_hornet.custom_stats.ammo_pickup_min_mul = 2.5
		self.parts.wpn_fps_upg_a_grenade_launcher_hornet.custom_stats.ammo_pickup_max_mul = 2.5
		self.parts.wpn_fps_upg_a_grenade_launcher_hornet.desc_id = "bm_wpn_fps_upg_a_grenade_launcher_hornet_desc"
		self.parts.wpn_fps_upg_a_underbarrel_hornet.desc_id = "bm_wpn_fps_upg_a_grenade_launcher_hornet_underbarrel_desc"
		self.wpn_fps_ass_groza.override = self.wpn_fps_ass_groza.override or {}
		self.wpn_fps_ass_groza.override.wpn_fps_upg_a_underbarrel_hornet = {
			custom_stats = {
					rays = 20,
					ammo_pickup_max_mul = 3.5,
					base_stats_modifiers = {spread = -10,damage = -145},
					falloff_override = {near_falloff = 0,optimal_range = 100,optimal_distance = 100,near_multiplier = 1,far_multiplier = 1,far_falloff = 100},
					can_shoot_through_shield = true,
					sounds = {fire_single = "hornet_fire"},
					muzzleflash = "effects/payday2/particles/weapons/shotgun/sho_muzzleflash_hornet",
					ignore_damage_upgrades = false,
					ammo_pickup_min_mul = 3.5
			},
			muzzleflash = "effects/payday2/particles/weapons/shotgun/sho_muzzleflash_hornet"
		}
		self.wpn_fps_ass_contraband.override = self.wpn_fps_ass_contraband.override or {}
		self.wpn_fps_ass_contraband.override.wpn_fps_upg_a_underbarrel_hornet = {
			custom_stats = {
					rays = 20,
					ammo_pickup_max_mul = 3.5,
					base_stats_modifiers = {spread = -10,damage = -41},
					falloff_override = {near_falloff = 0,optimal_range = 100,optimal_distance = 100,near_multiplier = 1,far_multiplier = 1,far_falloff = 100},
					can_shoot_through_shield = true,
					sounds = {fire_single = "hornet_fire"},
					muzzleflash = "effects/payday2/particles/weapons/shotgun/sho_muzzleflash_hornet",
					ignore_damage_upgrades = false,
					ammo_pickup_min_mul = 3.5
			},
			muzzleflash = "effects/payday2/particles/weapons/shotgun/sho_muzzleflash_hornet"
		}
		-- prevents the game from updating base weapon damage value based on the underbarrel projectile damage, applies to groza as well
		self.parts.wpn_fps_upg_a_underbarrel_electric.stats = nil
		self.parts.wpn_fps_upg_a_underbarrel_electric.desc_id = "bm_wpn_fps_upg_a_underbarrel_launcher_electric_desc"
	end
	init_Special_mods()
	
	-- Pistol individual, akimbo versions included with non-akimbo version
	local function init_Pistol_mods()
		
		---- USP ----
		local function Gilza_init_usp()
			self.parts.wpn_fps_pis_usp_b_expert.stats.concealment = nil
			self.parts.wpn_fps_pis_usp_b_expert.stats.spread = 2
			self.parts.wpn_fps_pis_usp_b_expert.stats.recoil = -1
			self.parts.wpn_fps_pis_usp_b_expert.stats.reload = 1
			self.parts.wpn_fps_pis_usp_b_match.stats.concealment = -3
			self.parts.wpn_fps_pis_usp_m_big.stats.reload = -6
			self.parts.wpn_fps_pis_usp_m_extended.stats.reload = -4
			self.wpn_fps_pis_x_usp.override.wpn_fps_pis_usp_m_extended.stats.reload = -4
			self.wpn_fps_pis_x_usp.override.wpn_fps_pis_usp_m_big.stats.reload = -6
			self.parts.wpn_fps_pis_usp_co_comp_1.stats.damage = 1
			self.parts.wpn_fps_pis_usp_co_comp_1.stats.spread = -2
			self.parts.wpn_fps_pis_usp_co_comp_1.stats.recoil = 3
			self.parts.wpn_fps_pis_usp_co_comp_2.stats.spread = 3
			self.parts.wpn_fps_pis_usp_co_comp_2.stats.recoil = -2
			self.parts.wpn_fps_pis_usp_co_comp_2.stats.concealment = -2
		end
		Gilza_init_usp()
		
		---- GLOCK_17 ----
		local function Gilza_init_glock_17()
			self.parts.wpn_fps_pis_g26_g_laser.forbids = {
				"wpn_fps_upg_fl_pis_crimson",
				"wpn_fps_upg_fl_pis_x400v",
				"wpn_fps_upg_fl_pis_laser",
				"wpn_fps_upg_fl_pis_perst"
			}
			self.parts.wpn_fps_pis_g26_g_laser.desc_id = "bm_laser_gadget_module"
			self.parts.wpn_fps_pis_g26_g_gripforce.stats.concealment = nil
			self.parts.wpn_fps_pis_g17_ck.stats.spread = 2
			self.parts.wpn_fps_pis_g17_ck.stats.recoil = -2
			self.parts.wpn_fps_pis_g17_ck.stats.concealment = -1
		end
		Gilza_init_glock_17()
		
		---- PPK ----
		local function Gilza_init_ppk()
			self.parts.wpn_fps_pis_ppk_g_laser.forbids = {
				"wpn_fps_upg_fl_pis_crimson",
				"wpn_fps_upg_fl_pis_x400v",
				"wpn_fps_upg_fl_pis_laser",
				"wpn_fps_upg_fl_pis_perst"
			}
			self.parts.wpn_fps_pis_ppk_g_laser.desc_id = "bm_laser_gadget_module"
		end
		Gilza_init_ppk()
		
		---- P226 ----
		local function Gilza_init_p226()
			self.parts.wpn_fps_pis_p226_b_equinox.stats.damage = nil
			self.parts.wpn_fps_pis_p226_b_equinox.stats.spread = 1
			self.parts.wpn_fps_pis_p226_b_equinox.stats.reload = 1
			self.parts.wpn_fps_pis_p226_co_comp_1.stats.damage = 1
			self.parts.wpn_fps_pis_p226_co_comp_1.stats.spread = -2
			self.parts.wpn_fps_pis_p226_co_comp_1.stats.recoil = 3
			self.parts.wpn_fps_pis_p226_co_comp_2.stats.spread = 3
			self.parts.wpn_fps_pis_p226_co_comp_2.stats.recoil = -2
			self.parts.wpn_fps_pis_p226_co_comp_2.stats.concealment = -2
			self.parts.wpn_fps_pis_p226_m_extended.stats.reload = -4
			self.wpn_fps_pis_x_p226.override.wpn_fps_pis_p226_m_extended.stats.reload = -5
		end
		Gilza_init_p226()
		
		---- COLT_1911 ----
		local function Gilza_init_colt_1911()
			self.parts.wpn_fps_pis_1911_b_vented.stats.suppression = nil
			self.parts.wpn_fps_pis_1911_b_vented.stats.damage = nil
			self.parts.wpn_fps_pis_1911_b_vented.stats.spread = 1
			self.parts.wpn_fps_pis_1911_b_vented.stats.recoil = 1
			self.parts.wpn_fps_pis_1911_b_vented.stats.reload = 2
			self.parts.wpn_fps_pis_1911_b_long.stats.recoil = nil
			self.parts.wpn_fps_pis_1911_co_1.stats.damage = nil
			self.parts.wpn_fps_pis_1911_co_1.stats.spread = -2
			self.parts.wpn_fps_pis_1911_co_1.stats.recoil = 3
			self.parts.wpn_fps_pis_1911_co_1.stats.concealment = nil
			self.parts.wpn_fps_pis_1911_co_1.stats.suppression = -7
			self.parts.wpn_fps_pis_1911_co_2.stats.damage = nil
			self.parts.wpn_fps_pis_1911_co_2.stats.spread = 3
			self.parts.wpn_fps_pis_1911_co_2.stats.recoil = -2
			self.parts.wpn_fps_pis_1911_co_2.stats.concealment = nil
			self.parts.wpn_fps_pis_1911_co_2.stats.suppression = -12
			self.parts.wpn_fps_pis_1911_m_big.stats.reload = -6
			self.parts.wpn_fps_pis_1911_m_extended.stats.reload = -3
			self.wpn_fps_x_1911.override.wpn_fps_pis_1911_m_big.stats.reload = -6
			self.wpn_fps_x_1911.override.wpn_fps_pis_1911_m_extended.stats.reload = -3
		end
		Gilza_init_colt_1911()
		
		---- B92FS ----
		local function Gilza_init_b92fs()
			self.parts.wpn_fps_pis_beretta_sl_brigadier.stats.recoil = nil
			self.parts.wpn_fps_pis_beretta_g_engraved.stats.spread = -1
			self.parts.wpn_fps_pis_beretta_g_ergo.stats.recoil = -1
			self.parts.wpn_fps_pis_beretta_g_ergo.stats.spread = 1
			self.parts.wpn_fps_pis_beretta_co_co1.stats.damage = 5
			self.parts.wpn_fps_pis_beretta_co_co1.stats.spread = -2
			self.parts.wpn_fps_pis_beretta_co_co1.stats.recoil = 3
			self.parts.wpn_fps_pis_beretta_co_co1.stats.concealment = -1
			self.parts.wpn_fps_pis_beretta_co_co1.stats.suppression = -4
			self.parts.wpn_fps_pis_beretta_co_co2.stats.damage = -1
			self.parts.wpn_fps_pis_beretta_co_co2.stats.spread = 3
			self.parts.wpn_fps_pis_beretta_co_co2.stats.recoil = -2
			self.parts.wpn_fps_pis_beretta_co_co2.stats.concealment = nil
			self.parts.wpn_fps_pis_beretta_co_co2.stats.suppression = -6
			self.parts.wpn_fps_pis_beretta_m_extended.stats.reload = -8
			self.wpn_fps_x_b92fs.override.wpn_fps_pis_beretta_m_extended.stats.reload = -7
		end
		Gilza_init_b92fs()
		
		---- NEW_RAGING_BULL ----
		local function Gilza_init_new_raging_bull()
			self.parts.wpn_fps_pis_rage_body_smooth.stats.recoil = -1
			self.parts.wpn_fps_pis_rage_b_comp1.stats.spread = 1
			self.parts.wpn_fps_pis_rage_b_comp1.stats.recoil = 2
			self.parts.wpn_fps_pis_rage_b_comp1.stats.concealment = -2
			self.parts.wpn_fps_pis_rage_b_short.stats.recoil = -2
			self.parts.wpn_fps_pis_rage_b_short.stats.reload = 2
			self.parts.wpn_fps_pis_rage_b_comp2.stats.damage = 5
			self.parts.wpn_fps_pis_rage_b_comp2.stats.spread = 1
			self.parts.wpn_fps_pis_rage_b_comp2.stats.recoil = 1
			self.parts.wpn_fps_pis_rage_b_comp2.stats.concealment = -2
			self.parts.wpn_fps_pis_rage_b_comp2.stats.suppression = nil
			self.parts.wpn_fps_pis_rage_b_long.stats.spread = 2
			self.parts.wpn_fps_pis_rage_b_long.stats.recoil = 2
			self.parts.wpn_fps_pis_rage_b_long.stats.concealment = -3
			self.parts.wpn_fps_pis_rage_b_long.stats.reload = -2
			self.parts.wpn_fps_pis_rage_g_ergo.stats.spread = 1
			self.parts.wpn_fps_pis_rage_g_ergo.stats.recoil = -1
		end
		Gilza_init_new_raging_bull()
		
		---- M1911 ----
		local function Gilza_init_m1911()
			-- all good
		end
		Gilza_init_m1911()
		
		---- MAXIM9 ----
		local function Gilza_init_maxim9()
			-- all good
		end
		Gilza_init_maxim9()
		
		---- PL14 ----
		local function Gilza_init_pl14()
			self.parts.wpn_fps_pis_sparrow_body_941.stats.recoil = -1
			self.parts.wpn_fps_pis_sparrow_g_cowboy.stats.recoil = 1
		end
		Gilza_init_pl14()
		
		---- SPARROW ----
		local function Gilza_init_sparrow()
			-- all good
		end
		Gilza_init_sparrow()
		
		---- LEGACY ----
		local function Gilza_init_legacy()
			self.parts.wpn_fps_pis_legacy_g_wood.stats.concealment = -1
		end
		Gilza_init_legacy()
		
		---- KORTH ----
		local function Gilza_init_korth()
			self.parts.wpn_fps_pis_korth_m_6.stats = {extra_ammo = -1,damage = 4,value = 1,spread = 8,recoil = 3}
			self.wpn_fps_pis_x_korth.override.wpn_fps_pis_korth_m_6 = {stats={extra_ammo = -2,damage = 4,value = 1,spread = 8,recoil = 5}}
			self.parts.wpn_fps_pis_korth_g_houge.stats.recoil = -1
			self.parts.wpn_fps_pis_korth_g_houge.stats.concealment = 1
			self.parts.wpn_fps_pis_korth_b_railed.stats.damage = 7
			self.parts.wpn_fps_pis_korth_b_railed.stats.recoil = 1
			self.parts.wpn_fps_pis_korth_b_railed.stats.concealment = -3
			self.parts.wpn_fps_pis_korth_b_railed.stats.reload = -2
		end
		Gilza_init_korth()
		
		---- G22C ----
		local function Gilza_init_g22c()
			self.parts.wpn_fps_pis_g22c_b_long.stats.spread = 1
			self.parts.wpn_fps_pis_g22c_b_long.stats.recoil = -1
			self.parts.wpn_fps_pis_g18c_co_1.stats.damage = nil
			self.parts.wpn_fps_pis_g18c_co_1.stats.spread = 3
			self.parts.wpn_fps_pis_g18c_co_1.stats.recoil = -2
			self.parts.wpn_fps_pis_g18c_co_1.stats.concealment = -1
			self.parts.wpn_fps_pis_g18c_co_1.stats.suppression = -8
		end
		Gilza_init_g22c()
		
		---- C96 ----
		local function Gilza_init_c96()
			self.parts.wpn_fps_pis_c96_s_solid.stats.recoil = 3
			self.parts.wpn_fps_pis_c96_b_long.stats = {value = 1,concealment = -3,damage = 95,spread = 5,recoil = -4}
			self.parts.wpn_fps_pis_c96_b_long.override_weapon = {_meta = "override_weapon", AMMO_MAX = 40}
			self.parts.wpn_fps_pis_c96_b_long.adds = {"wpn_fps_upg_c96_ap_kit_ap_rounds"}
			self.parts.wpn_fps_pis_c96_b_long.name_id = "bm_wpn_fps_pis_c96_b_long_newname"
			self.parts.wpn_fps_pis_c96_b_long.has_description = true
			self.parts.wpn_fps_pis_c96_b_long.desc_id = "bm_wpn_fps_pis_c96_b_long_newdesc"
			self.parts.wpn_fps_pis_c96_m_extended.stats.reload = -5
		end
		Gilza_init_c96()
		
		---- TYPE54 ----
		local function Gilza_init_type54()
			-- underbarrel ammo itself
			self.parts.wpn_fps_upg_a_slug_underbarrel.stats = {value = 5,spread = 3,recoil = -2,total_ammo_mod = -5}
			self.parts.wpn_fps_upg_a_slug_underbarrel.custom_stats.damage_far_mul = 1.15
			self.parts.wpn_fps_upg_a_slug_underbarrel.custom_stats.damage_near_mul = 1.15
			self.parts.wpn_fps_upg_a_slug_underbarrel.custom_stats.ammo_pickup_min_mul = 0.75
			self.parts.wpn_fps_upg_a_slug_underbarrel.custom_stats.ammo_pickup_max_mul = 0.75
			self.parts.wpn_fps_upg_a_piercing_underbarrel.custom_stats = {rays = 6, armor_piercing_add = 1,damage_near_mul = 1.4,damage_far_mul = 1.4,ammo_pickup_max_mul = 0.9,ammo_pickup_min_mul = 0.9}
			-- underbarrel mods
			self.parts.wpn_fps_pis_type54_underbarrel.desc_id = "bm_wpn_fps_pis_type54_underbarrel_desc"
			self.parts.wpn_fps_pis_type54_underbarrel.has_description = true
			self.parts.wpn_fps_pis_type54_underbarrel_slug.desc_id = "bm_wpn_fps_pis_type54_underbarrel_slug_desc"
			self.parts.wpn_fps_pis_type54_underbarrel_slug.has_description = true
			self.parts.wpn_fps_pis_type54_underbarrel_piercing.desc_id = "bm_wpn_fps_pis_type54_underbarrel_ap_desc"
			self.parts.wpn_fps_pis_type54_underbarrel_piercing.has_description = true
			self.parts.wpn_fps_pis_x_type54_underbarrel.desc_id = "bm_wpn_fps_pis_x_type54_underbarrel_desc"
			self.parts.wpn_fps_pis_x_type54_underbarrel.has_description = true
			self.parts.wpn_fps_pis_x_type54_underbarrel_slug.desc_id = "bm_wpn_fps_pis_x_type54_underbarrel_slug_desc"
			self.parts.wpn_fps_pis_x_type54_underbarrel_slug.has_description = true
			self.parts.wpn_fps_pis_x_type54_underbarrel_piercing.desc_id = "bm_wpn_fps_pis_x_type54_underbarrel_ap_desc"
			self.parts.wpn_fps_pis_x_type54_underbarrel_piercing.has_description = true

			self.parts.wpn_fps_pis_type54_m_ext.stats.reload = -3
			self.wpn_fps_pis_x_type54.override.wpn_fps_pis_type54_m_ext.stats.reload = -3
		end
		Gilza_init_type54()
		
		---- BREECH ----
		local function Gilza_init_breech()
			self.parts.wpn_fps_pis_breech_b_reinforced.stats.spread = 1
			self.parts.wpn_fps_pis_breech_b_reinforced.stats.recoil = -1
		end
		Gilza_init_breech()
		
		---- LEMMING ----
		local function Gilza_init_lemming()
			self.parts.wpn_fps_pis_lemming_m_ext.stats.reload = -3
			self.parts.wpn_fps_pis_lemming_m_ext.stats.extra_ammo = 3
			self.parts.wpn_fps_pis_lemming_m_ext.stats.concealment = -2
		end
		Gilza_init_lemming()
		
		---- CHINCHILLA ----
		local function Gilza_init_chinchilla()
			self.parts.wpn_fps_pis_chinchilla_b_satan.stats.spread = 1
			self.parts.wpn_fps_pis_chinchilla_b_satan.stats.recoil = -2
		end
		Gilza_init_chinchilla()
		
		---- PACKRAT ----
		local function Gilza_init_packrat()
			self.parts.wpn_fps_pis_packrat_m_extended.stats.reload = -5
			self.wpn_fps_x_packrat.override.wpn_fps_pis_packrat_m_extended.stats.reload = -5
			self.parts.wpn_fps_pis_packrat_ns_wick.stats.damage = 1
			self.parts.wpn_fps_pis_packrat_ns_wick.stats.spread = -2
			self.parts.wpn_fps_pis_packrat_ns_wick.stats.recoil = 3
			self.parts.wpn_fps_pis_packrat_ns_wick.stats.concealment = nil
		end
		Gilza_init_packrat()
		
		---- MODEL3 ----
		local function Gilza_init_model3()
			self.parts.wpn_fps_pis_model3_g_bling.stats.spread = -1
			self.parts.wpn_fps_pis_model3_b_long.stats.spread = 1
			self.parts.wpn_fps_pis_model3_b_long.stats.recoil = -1
		end
		Gilza_init_model3()
		
		---- RSH12 ----
		local function Gilza_init_rsh12()
			self.parts.wpn_fps_pis_rsh12_b_comp.stats.damage = nil
		end
		Gilza_init_rsh12()
		
		---- SHREW ----
		local function Gilza_init_shrew()
			self.parts.wpn_fps_pis_shrew_m_extended.stats.extra_ammo = 1
		end
		Gilza_init_shrew()
		
		---- G26 ----
		local function Gilza_init_g26()
			-- all good
		end
		Gilza_init_g26()
		
		---- HS2000 ----
		local function Gilza_init_hs2000()
			self.parts.wpn_fps_pis_hs2000_sl_long.stats.spread = 1
			self.parts.wpn_fps_pis_hs2000_sl_long.stats.recoil = -1
			self.parts.wpn_fps_pis_hs2000_sl_custom.stats.damage = nil
			self.parts.wpn_fps_pis_hs2000_sl_custom.stats.suppression = nil
			self.parts.wpn_fps_pis_hs2000_sl_custom.stats.reload = 2
			self.parts.wpn_fps_pis_hs2000_m_extended.stats.reload = -4
			self.wpn_fps_pis_x_hs2000.override.wpn_fps_pis_hs2000_m_extended.stats.reload = -4
		end
		Gilza_init_hs2000()
		
		---- GLOCK_18C ----
		local function Gilza_init_glock_18c()
			-- all good
		end
		Gilza_init_glock_18c()
		
		---- BEER ----
		local function Gilza_init_beer()
			self.parts.wpn_fps_pis_beer_m_extended.stats.extra_ammo = 4
			self.parts.wpn_fps_pis_beer_m_extended.stats.reload = -2
		end
		Gilza_init_beer()
		
		---- CZECH ----
		local function Gilza_init_czech()
			self.parts.wpn_fps_pis_czech_m_extended.stats.reload = -3
			self.wpn_fps_pis_x_czech.override.wpn_fps_pis_czech_m_extended.stats.reload = -3
		end
		Gilza_init_czech()
		
		---- STECH ----
		local function Gilza_init_stech()
			self.parts.wpn_fps_pis_stech_m_extended.stats.reload = -6
			self.wpn_fps_pis_x_stech.override.wpn_fps_pis_stech_m_extended.stats.reload = -6
			self.parts.wpn_fps_pis_czech_b_long.stats.recoil = -1
		end
		Gilza_init_stech()
		
		---- HOLT ----
		local function Gilza_init_holt()
			self.parts.wpn_fps_pis_holt_m_extended.stats.reload = -4
			self.wpn_fps_pis_x_holt.override.wpn_fps_pis_holt_m_extended.stats.reload = -4
		end
		Gilza_init_holt()
		
		---- PEACEMAKER ----
		local function Gilza_init_peacemaker()
			self.parts.wpn_fps_pis_peacemaker_s_skeletal.stats.spread = -1
			self.parts.wpn_fps_pis_peacemaker_s_skeletal.stats.reload = -1
			self.parts.wpn_fps_pis_peacemaker_b_long.stats.reload = -1
		end
		Gilza_init_peacemaker()
		
		---- MATEBA ----
		local function Gilza_init_mateba()
			-- all good
		end
		Gilza_init_mateba()
		
		---- DEAGLE ----
		local function Gilza_init_deagle()
			self.parts.wpn_fps_pis_deagle_m_extended.stats.reload = -4
			self.wpn_fps_x_deagle.override.wpn_fps_pis_deagle_m_extended.stats.reload = -4
			self.parts.wpn_fps_pis_deagle_co_short.stats.recoil = 3
			self.parts.wpn_fps_pis_deagle_co_long.stats.spread = 2
		end
		Gilza_init_deagle()
		
	end
	init_Pistol_mods()
	
	-- Sniper individual
	local function init_Sniper_mods()
		
		-- MSR
		self.parts.wpn_fps_snp_msr_body_msr.stats.reload = 2
		
		-- R700
		self.parts.wpn_fps_snp_r700_s_military.stats.reload = 2
		self.parts.wpn_fps_snp_r700_s_military.stats.spread = 1
		self.parts.wpn_fps_snp_r700_s_military.stats.concealment = -1
		self.parts.wpn_fps_snp_r700_s_tactical.stats.spread = 2
		self.parts.wpn_fps_snp_r700_s_tactical.stats.recoil = 2
		self.parts.wpn_fps_snp_r700_s_tactical.stats.concealment = -2
		self.parts.wpn_fps_snp_r700_b_short.stats.reload = 1
		self.parts.wpn_fps_snp_r700_b_medium.stats.spread = 2
		self.parts.wpn_fps_snp_r700_b_medium.stats.concealment = -2
		-- i am getting tired of your bullshit frenchy
		self.parts.wpn_fps_snp_r700_b_medium.forbids = {
			"wpn_fps_ass_ns_g_bmd",
			"wpn_fps_ass_ns_g_bulletec",
			"wpn_fps_ass_ns_g_dmnoz",
			"wpn_fps_ass_ns_g_heart",
			"wpn_fps_ass_ns_g_pws",
			"wpn_fps_ass_ns_g_sf3p",
			"wpn_fps_ass_ns_g_slr",
			"wpn_fps_ass_ns_g_traptor",
		}
		
		-- SBL
		self.parts.wpn_fps_snp_sbl_b_short.stats.spread = 2
		self.parts.wpn_fps_snp_sbl_b_short.forbids = {
			"wpn_fps_ass_ns_g_bmd",
			"wpn_fps_ass_ns_g_bulletec",
			"wpn_fps_ass_ns_g_dmnoz",
			"wpn_fps_ass_ns_g_heart",
			"wpn_fps_ass_ns_g_pws",
			"wpn_fps_ass_ns_g_sf3p",
			"wpn_fps_ass_ns_g_slr",
			"wpn_fps_ass_ns_g_traptor",
		}
		
		-- QBU88
		self.parts.wpn_fps_snp_qbu88_m_extended.stats.reload = -5
		
		-- AWP
		self.parts.wpn_fps_snp_awp_conversion_dragonlore.stats.total_ammo_mod = -6
		self.parts.wpn_fps_snp_awp_conversion_dragonlore.stats.damage = 300
		self.parts.wpn_fps_snp_awp_conversion_dragonlore.custom_stats = {ammo_pickup_max_mul = 0.898,ammo_pickup_min_mul = 0.898}
		self.parts.wpn_fps_snp_awp_conversion_dragonlore.has_description = true
		self.parts.wpn_fps_snp_awp_conversion_dragonlore.desc_id = "bm_wpn_fps_upg_snp_awp_conversionkit_new_desc"
		self.parts.wpn_fps_snp_awp_conversion_wildlands.stats.total_ammo_mod = 12
		self.parts.wpn_fps_snp_awp_conversion_wildlands.stats.damage = -350
		self.parts.wpn_fps_snp_awp_conversion_wildlands.stats.reload = -3
		self.parts.wpn_fps_snp_awp_conversion_wildlands.custom_stats = {ammo_pickup_max_mul = 1.152,ammo_pickup_min_mul = 1.152,fire_rate_multiplier = 1.8}
		self.parts.wpn_fps_snp_awp_conversion_wildlands.has_description = true
		self.parts.wpn_fps_snp_awp_conversion_wildlands.desc_id = "bm_wpn_fps_upg_snp_awp_conversionkit_new_desc"
		self.parts.wpn_fps_snp_awp_ext_shellrack.stats.total_ammo_mod = 5
		self.parts.wpn_fps_snp_awp_ns_suppressor.stats.spread = nil

		-- WA2000
		self.parts.wpn_fps_snp_wa2000_g_light.stats.spread = 2
		self.parts.wpn_fps_snp_wa2000_g_light.stats.recoil = -1
		self.parts.wpn_fps_snp_wa2000_b_suppressed.stats.spread = 2
		self.parts.wpn_fps_snp_wa2000_b_suppressed.forbids = {
			"wpn_fps_ass_ns_g_bmd",
			"wpn_fps_ass_ns_g_bulletec",
			"wpn_fps_ass_ns_g_dmnoz",
			"wpn_fps_ass_ns_g_heart",
			"wpn_fps_ass_ns_g_pws",
			"wpn_fps_ass_ns_g_sf3p",
			"wpn_fps_ass_ns_g_slr",
			"wpn_fps_ass_ns_g_traptor",
		}
		
		-- DESERTFOX
		self.parts.wpn_fps_snp_desertfox_b_silencer.stats.spread = 2
		self.parts.wpn_fps_snp_desertfox_b_silencer.forbids = {
			"wpn_fps_ass_ns_g_bmd",
			"wpn_fps_ass_ns_g_bulletec",
			"wpn_fps_ass_ns_g_dmnoz",
			"wpn_fps_ass_ns_g_heart",
			"wpn_fps_ass_ns_g_pws",
			"wpn_fps_ass_ns_g_sf3p",
			"wpn_fps_ass_ns_g_slr",
			"wpn_fps_ass_ns_g_traptor",
		}
		
		-- TTI
		self.parts.wpn_fps_snp_tti_ns_hex.stats.spread = 2
		
		-- R93
		self.parts.wpn_fps_snp_r93_b_suppressed.stats.damage = -3
		self.parts.wpn_fps_snp_r93_b_suppressed.stats.spread = 2
		self.parts.wpn_fps_snp_r93_b_suppressed.forbids = {
			"wpn_fps_ass_ns_g_bmd",
			"wpn_fps_ass_ns_g_bulletec",
			"wpn_fps_ass_ns_g_dmnoz",
			"wpn_fps_ass_ns_g_heart",
			"wpn_fps_ass_ns_g_pws",
			"wpn_fps_ass_ns_g_sf3p",
			"wpn_fps_ass_ns_g_slr",
			"wpn_fps_ass_ns_g_traptor",
		}
		
		-- WINCHESTER1874
		self.parts.wpn_fps_snp_winchester_b_suppressed.stats.spread = 2
		self.parts.wpn_fps_snp_winchester_b_suppressed.forbids = {
			"wpn_fps_ass_ns_g_bmd",
			"wpn_fps_ass_ns_g_bulletec",
			"wpn_fps_ass_ns_g_dmnoz",
			"wpn_fps_ass_ns_g_heart",
			"wpn_fps_ass_ns_g_pws",
			"wpn_fps_ass_ns_g_sf3p",
			"wpn_fps_ass_ns_g_slr",
			"wpn_fps_ass_ns_g_traptor",
		}
		
		-- SILTSTONE
		self.parts.wpn_fps_snp_siltstone_ns_variation_b.forbids = {
			"wpn_fps_ass_ns_g_bmd",
			"wpn_fps_ass_ns_g_bulletec",
			"wpn_fps_ass_ns_g_dmnoz",
			"wpn_fps_ass_ns_g_heart",
			"wpn_fps_ass_ns_g_pws",
			"wpn_fps_ass_ns_g_sf3p",
			"wpn_fps_ass_ns_g_slr",
			"wpn_fps_ass_ns_g_traptor",
		}
		self.parts.wpn_fps_snp_siltstone_b_silenced.stats.spread = 2
		self.parts.wpn_fps_snp_siltstone_b_silenced.forbids = {
			"wpn_fps_ass_ns_g_bmd",
			"wpn_fps_ass_ns_g_bulletec",
			"wpn_fps_ass_ns_g_dmnoz",
			"wpn_fps_ass_ns_g_heart",
			"wpn_fps_ass_ns_g_pws",
			"wpn_fps_ass_ns_g_sf3p",
			"wpn_fps_ass_ns_g_slr",
			"wpn_fps_ass_ns_g_traptor",
		}
		
		-- MOSIN
		self.parts.wpn_fps_snp_mosin_b_sniper.stats.damage = -3
		self.parts.wpn_fps_snp_mosin_b_sniper.stats.spread = 2
		self.parts.wpn_fps_snp_mosin_b_sniper.forbids = {
			"wpn_fps_ass_ns_g_bmd",
			"wpn_fps_ass_ns_g_bulletec",
			"wpn_fps_ass_ns_g_dmnoz",
			"wpn_fps_ass_ns_g_heart",
			"wpn_fps_ass_ns_g_pws",
			"wpn_fps_ass_ns_g_sf3p",
			"wpn_fps_ass_ns_g_slr",
			"wpn_fps_ass_ns_g_traptor",
		}
		self.parts.wpn_fps_snp_mosin_ns_bayonet.stats = {
			min_damage = 5,
			max_damage = 5,
			min_damage_effect = 8,
			max_damage_effect = 8,
			concealment = -2,
			value = 1
		}
		
		-- SECONDARIES
		-- CONTENDER
		table.insert(self.parts.wpn_fps_snp_contender_grip_standard.forbids, "wpn_fps_upg_m4_s_a2")
		table.insert(self.parts.wpn_fps_snp_contender_grip_standard.forbids, "wpn_fps_upg_m4_s_bus")
		table.insert(self.parts.wpn_fps_snp_contender_grip_standard.forbids, "wpn_fps_upg_m4_s_cmmg")
		table.insert(self.parts.wpn_fps_snp_contender_grip_standard.forbids, "wpn_fps_upg_m4_s_core")
		table.insert(self.parts.wpn_fps_snp_contender_grip_standard.forbids, "wpn_fps_upg_m4_s_ddun")
		table.insert(self.parts.wpn_fps_snp_contender_grip_standard.forbids, "wpn_fps_upg_m4_s_ds150")
		table.insert(self.parts.wpn_fps_snp_contender_grip_standard.forbids, "wpn_fps_upg_m4_s_hke1")
		table.insert(self.parts.wpn_fps_snp_contender_grip_standard.forbids, "wpn_fps_upg_m4_s_hkslim")
		table.insert(self.parts.wpn_fps_snp_contender_grip_standard.forbids, "wpn_fps_upg_m4_s_moe")
		table.insert(self.parts.wpn_fps_snp_contender_grip_standard.forbids, "wpn_fps_upg_m4_s_prs2")
		table.insert(self.parts.wpn_fps_snp_contender_grip_standard.forbids, "wpn_fps_upg_m4_s_prs3")
		table.insert(self.parts.wpn_fps_snp_contender_grip_standard.forbids, "wpn_fps_upg_m4_s_viper")
		self.parts.wpn_fps_upg_m4_g_contender.stats.spread = nil
		self.parts.wpn_fps_upg_m4_g_contender.stats.recoil = 1
		self.parts.wpn_fps_snp_contender_frontgrip_long.stats.spread = 1
		self.parts.wpn_fps_snp_contender_frontgrip_long.stats.recoil = 2
		self.parts.wpn_fps_snp_contender_conversion.stats.reload = -3
		self.parts.wpn_fps_snp_contender_conversion.stats.total_ammo_mod = -8
		self.parts.wpn_fps_snp_contender_conversion.stats.damage = 300
		self.parts.wpn_fps_snp_contender_conversion.custom_stats = {ammo_pickup_max_mul = 0.898,ammo_pickup_min_mul = 0.898}
		
		-- SCOUT
		self.parts.wpn_fps_snp_scout_conversion.stats.spread = -2
		self.parts.wpn_fps_snp_scout_conversion.stats.recoil = 2
		self.parts.wpn_fps_snp_scout_conversion.stats.reload = nil
		self.parts.wpn_fps_snp_scout_ns_suppressor.stats.spread = nil
		self.parts.wpn_fps_snp_scout_m_extended.stats.reload = -4
		
		-- VICTOR
		table.insert(self.parts.wpn_fps_snp_victor_sbr_kit.forbids, "wpn_fps_upg_m4_s_gen2")
		table.insert(self.parts.wpn_fps_snp_victor_sbr_kit.forbids, "wpn_fps_upg_m4_s_troy")
		self.parts.wpn_fps_snp_victor_sbr_kit.stats.spread = 1
		self.parts.wpn_fps_snp_victor_sbr_kit.stats.recoil = 4
		
	end
	init_Sniper_mods()
	
	local function customWeaponMods()
	
		-- FrenchyAU's tacticool packs
		local function FrenchyAU_packs_stat_adjustments()
			
			-- Supressors
			local function FrenchyAU_supressors()
				
				local frenchyAU_supressors_BIG_acc = {
					"wpn_fps_ass_ns_ak_dtkp",
					"wpn_fps_ass_ns_ak_waffle",
					"wpn_fps_ass_ns_ash12"
				}
				local frenchyAU_supressors_BIG_stab = {
					"wpn_fps_ass_ns_ak_dtk4m",
					"wpn_fps_ass_ns_ak_hex",
					"wpn_fps_ass_ns_ak_pbs4",
					"wpn_fps_ass_ns_g_ultraw"
				}
				local frenchyAU_supressors_BIG_avg = {
					"wpn_fps_ass_ns_ak_pbs1",
					"wpn_fps_ass_ns_g_rfl",
					"wpn_fps_ass_ns_g_prs"
				}
				for i=1, #frenchyAU_supressors_BIG_acc do
					if self.parts[frenchyAU_supressors_BIG_acc[i]] then
						self.parts[frenchyAU_supressors_BIG_acc[i]].stats.recoil = -1
						self.parts[frenchyAU_supressors_BIG_acc[i]].stats.spread = 4
						self.parts[frenchyAU_supressors_BIG_acc[i]].stats.damage = -1
						self.parts[frenchyAU_supressors_BIG_acc[i]].stats.concealment = -6
					end
				end
				for i=1, #frenchyAU_supressors_BIG_stab do
					if self.parts[frenchyAU_supressors_BIG_stab[i]] then
						self.parts[frenchyAU_supressors_BIG_stab[i]].stats.recoil = 4
						self.parts[frenchyAU_supressors_BIG_stab[i]].stats.spread = 0
						self.parts[frenchyAU_supressors_BIG_stab[i]].stats.damage = -1
						self.parts[frenchyAU_supressors_BIG_stab[i]].stats.concealment = -6
					end
				end
				for i=1, #frenchyAU_supressors_BIG_avg do
					if self.parts[frenchyAU_supressors_BIG_avg[i]] then
						self.parts[frenchyAU_supressors_BIG_avg[i]].stats.recoil = 2
						self.parts[frenchyAU_supressors_BIG_avg[i]].stats.spread = 2
						self.parts[frenchyAU_supressors_BIG_avg[i]].stats.damage = -1
						self.parts[frenchyAU_supressors_BIG_avg[i]].stats.concealment = -6
					end
				end
				
				local frenchyAU_supressors_AVERAGE_acc = {
					"wpn_fps_ass_ns_g_saker",
					"wpn_fps_ass_ns_g_sdn",
					"wpn_fps_ass_ns_g_ultra",
					"wpn_fps_ass_ns_g_victor",
					"wpn_fps_pis_ns_alpha"
				}
				local frenchyAU_supressors_AVERAGE_stab = {
					"wpn_fps_ass_ns_g_gem1",
					"wpn_fps_ass_ns_g_nt4",
					"wpn_fps_ass_ns_g_rc2",
					"wpn_fps_pis_ns_osprey",
					"wpn_fps_pis_ns_alpha"
				}
				local frenchyAU_supressors_AVERAGE_avg = {
					"wpn_fps_ass_ns_ak_tgpa",
					"wpn_fps_ass_ns_g_hybrid",
					"wpn_fps_ass_ns_g_wave",
					"wpn_fps_ass_ns_g_ump",
					"wpn_fps_pis_ns_alpha"
				}
				for i=1, #frenchyAU_supressors_AVERAGE_acc do
					if self.parts[frenchyAU_supressors_AVERAGE_acc[i]] then
						self.parts[frenchyAU_supressors_AVERAGE_acc[i]].stats.recoil = 0
						self.parts[frenchyAU_supressors_AVERAGE_acc[i]].stats.spread = 2
						self.parts[frenchyAU_supressors_AVERAGE_acc[i]].stats.damage = -2
						self.parts[frenchyAU_supressors_AVERAGE_acc[i]].stats.concealment = -3
					end
				end
				for i=1, #frenchyAU_supressors_AVERAGE_stab do
					if self.parts[frenchyAU_supressors_AVERAGE_stab[i]] then
						self.parts[frenchyAU_supressors_AVERAGE_stab[i]].stats.recoil = 4
						self.parts[frenchyAU_supressors_AVERAGE_stab[i]].stats.spread = -1
						self.parts[frenchyAU_supressors_AVERAGE_stab[i]].stats.damage = -2
						self.parts[frenchyAU_supressors_AVERAGE_stab[i]].stats.concealment = -3
					end
				end
				for i=1, #frenchyAU_supressors_AVERAGE_avg do
					if self.parts[frenchyAU_supressors_AVERAGE_avg[i]] then
						self.parts[frenchyAU_supressors_AVERAGE_avg[i]].stats.recoil = 1
						self.parts[frenchyAU_supressors_AVERAGE_avg[i]].stats.spread = 1
						self.parts[frenchyAU_supressors_AVERAGE_avg[i]].stats.damage = -2
						self.parts[frenchyAU_supressors_AVERAGE_avg[i]].stats.concealment = -3
					end
				end
				
				local frenchyAU_supressors_COMAPCT_acc = {
					"wpn_fps_ass_ns_g_mnstr",
					"wpn_fps_ass_ns_g_srd",
					"wpn_fps_ass_ns_g_aac"
				}
				local frenchyAU_supressors_COMAPCT_stab = {
					"wpn_fps_ass_ns_g_mini",
					"wpn_fps_ass_ns_g_srdqd",
					"wpn_fps_pis_ns_omega",
					"wpn_fps_ass_ns_g_sfn"
				}
				local frenchyAU_supressors_COMAPCT_avg = {
					"wpn_fps_ass_ns_g_beast",
					"wpn_fps_ass_ns_g_srdbig",
					"wpn_fps_pis_ns_pl15"
				}
				for i=1, #frenchyAU_supressors_COMAPCT_acc do
					if self.parts[frenchyAU_supressors_COMAPCT_acc[i]] then
						self.parts[frenchyAU_supressors_COMAPCT_acc[i]].stats.recoil = -2
						self.parts[frenchyAU_supressors_COMAPCT_acc[i]].stats.spread = 2
						self.parts[frenchyAU_supressors_COMAPCT_acc[i]].stats.damage = -3
						self.parts[frenchyAU_supressors_COMAPCT_acc[i]].stats.concealment = -1
					end
				end
				for i=1, #frenchyAU_supressors_COMAPCT_stab do
					if self.parts[frenchyAU_supressors_COMAPCT_stab[i]] then
						self.parts[frenchyAU_supressors_COMAPCT_stab[i]].stats.recoil = 3
						self.parts[frenchyAU_supressors_COMAPCT_stab[i]].stats.spread = -2
						self.parts[frenchyAU_supressors_COMAPCT_stab[i]].stats.damage = -3
						self.parts[frenchyAU_supressors_COMAPCT_stab[i]].stats.concealment = -1
					end
				end
				for i=1, #frenchyAU_supressors_COMAPCT_avg do
					if self.parts[frenchyAU_supressors_COMAPCT_avg[i]] then
						self.parts[frenchyAU_supressors_COMAPCT_avg[i]].stats.recoil = 1
						self.parts[frenchyAU_supressors_COMAPCT_avg[i]].stats.spread = 1
						self.parts[frenchyAU_supressors_COMAPCT_avg[i]].stats.damage = -3
						self.parts[frenchyAU_supressors_COMAPCT_avg[i]].stats.concealment = -1
					end
				end
				-- why the fuck is this even a thing Frenchy?
				if self.parts.wpn_fps_ass_ns_g_bacon then
					self.parts.wpn_fps_ass_ns_g_bacon.stats.recoil = 10
					self.parts.wpn_fps_ass_ns_g_bacon.stats.spread = 6
					self.parts.wpn_fps_ass_ns_g_bacon.stats.damage = -60
					self.parts.wpn_fps_ass_ns_g_bacon.stats.concealment = -29
				end
			end
			
			-- Muzzle devices
			local function FrenchyAU_muzzle_devices()
				if self.parts.wpn_fps_ass_ns_g_pws then
					table.delete(self.parts.wpn_fps_ass_ns_g_pws.weapons, "wpn_fps_snp_m95")
					self.parts.wpn_fps_ass_ns_g_pws.stats.recoil = 3
					self.parts.wpn_fps_ass_ns_g_pws.stats.spread = 0
					self.parts.wpn_fps_ass_ns_g_pws.stats.damage = 0
					self.parts.wpn_fps_ass_ns_g_pws.stats.concealment = 0
					self.parts.wpn_fps_ass_ns_g_pws.stats.suppression = -10
				end
				if self.parts.wpn_fps_ass_ns_g_bulletec then
					table.delete(self.parts.wpn_fps_ass_ns_g_bulletec.weapons, "wpn_fps_snp_m95")
					self.parts.wpn_fps_ass_ns_g_bulletec.stats.recoil = 1
					self.parts.wpn_fps_ass_ns_g_bulletec.stats.spread = 3
					self.parts.wpn_fps_ass_ns_g_bulletec.stats.damage = -1
					self.parts.wpn_fps_ass_ns_g_bulletec.stats.concealment = -3
					self.parts.wpn_fps_ass_ns_g_bulletec.stats.suppression = 3
				end
				if self.parts.wpn_fps_ass_ns_g_heart then
					table.delete(self.parts.wpn_fps_ass_ns_g_heart.weapons, "wpn_fps_snp_m95")
					self.parts.wpn_fps_ass_ns_g_heart.stats.recoil = 2
					self.parts.wpn_fps_ass_ns_g_heart.stats.spread = 2
					self.parts.wpn_fps_ass_ns_g_heart.stats.damage = -1
					self.parts.wpn_fps_ass_ns_g_heart.stats.concealment = -1
					self.parts.wpn_fps_ass_ns_g_heart.stats.suppression = 2
				end
				if self.parts.wpn_fps_ass_ns_g_traptor then
					table.delete(self.parts.wpn_fps_ass_ns_g_traptor.weapons, "wpn_fps_snp_m95")
					self.parts.wpn_fps_ass_ns_g_traptor.stats.recoil = 3
					self.parts.wpn_fps_ass_ns_g_traptor.stats.spread = 3
					self.parts.wpn_fps_ass_ns_g_traptor.stats.damage = -10
					self.parts.wpn_fps_ass_ns_g_traptor.stats.concealment = -6
					self.parts.wpn_fps_ass_ns_g_traptor.stats.suppression = -8
				end
				if self.parts.wpn_fps_ass_ns_g_bmd then
					table.delete(self.parts.wpn_fps_ass_ns_g_bmd.weapons, "wpn_fps_snp_m95")
					self.parts.wpn_fps_ass_ns_g_bmd.stats.recoil = 5
					self.parts.wpn_fps_ass_ns_g_bmd.stats.spread = -2
					self.parts.wpn_fps_ass_ns_g_bmd.stats.damage = 0
					self.parts.wpn_fps_ass_ns_g_bmd.stats.concealment = -4
					self.parts.wpn_fps_ass_ns_g_bmd.stats.suppression = -10
				end
				if self.parts.wpn_fps_ass_ns_g_sf3p then
					table.delete(self.parts.wpn_fps_ass_ns_g_sf3p.weapons, "wpn_fps_snp_m95")
					self.parts.wpn_fps_ass_ns_g_sf3p.stats.recoil = -3
					self.parts.wpn_fps_ass_ns_g_sf3p.stats.spread = 5
					self.parts.wpn_fps_ass_ns_g_sf3p.stats.damage = -2
					self.parts.wpn_fps_ass_ns_g_sf3p.stats.concealment = -1
					self.parts.wpn_fps_ass_ns_g_sf3p.stats.suppression = 0
				end
				if self.parts.wpn_fps_ass_ns_g_slr then
					table.delete(self.parts.wpn_fps_ass_ns_g_slr.weapons, "wpn_fps_snp_m95")
					self.parts.wpn_fps_ass_ns_g_slr.stats.recoil = 4
					self.parts.wpn_fps_ass_ns_g_slr.stats.spread = -1
					self.parts.wpn_fps_ass_ns_g_slr.stats.damage = 2
					self.parts.wpn_fps_ass_ns_g_slr.stats.concealment = -1
					self.parts.wpn_fps_ass_ns_g_slr.stats.suppression = -10
				end
				if self.parts.wpn_fps_ass_ns_g_dmnoz then
					table.delete(self.parts.wpn_fps_ass_ns_g_dmnoz.weapons, "wpn_fps_snp_m95")
					self.parts.wpn_fps_ass_ns_g_dmnoz.stats.recoil = 2
					self.parts.wpn_fps_ass_ns_g_dmnoz.stats.spread = 2
					self.parts.wpn_fps_ass_ns_g_dmnoz.stats.damage = -1
					self.parts.wpn_fps_ass_ns_g_dmnoz.stats.concealment = -1
					self.parts.wpn_fps_ass_ns_g_dmnoz.stats.suppression = 2
				end
			end
			
			-- Gadgets
			local function FrenchyAU_gadgets()
				if self.parts.wpn_fps_upg_fl_peq2 then
					self.parts.wpn_fps_upg_fl_peq2.stats.recoil = 0
					self.parts.wpn_fps_upg_fl_peq2.stats.spread = 1
					self.parts.wpn_fps_upg_fl_peq2.stats.concealment = -1
					self.parts.wpn_fps_upg_fl_peq2.has_description = true
					self.parts.wpn_fps_upg_fl_peq2.desc_id = "bm_laser_gadget_module"
				end
				if self.parts.wpn_fps_upg_fl_dbal then
					self.parts.wpn_fps_upg_fl_dbal.stats.recoil = 1
					self.parts.wpn_fps_upg_fl_dbal.stats.spread = 0
					self.parts.wpn_fps_upg_fl_dbal.stats.concealment = -1
					self.parts.wpn_fps_upg_fl_dbal.has_description = true
					self.parts.wpn_fps_upg_fl_dbal.desc_id = "bm_laser_gadget_module"
				end
				if self.parts.wpn_fps_upg_fl_dbal_a2 then
					self.parts.wpn_fps_upg_fl_dbal_a2.stats.recoil = 1
					self.parts.wpn_fps_upg_fl_dbal_a2.stats.spread = -1
					self.parts.wpn_fps_upg_fl_dbal_a2.stats.concealment = 0
					self.parts.wpn_fps_upg_fl_dbal_a2.has_description = true
					self.parts.wpn_fps_upg_fl_dbal_a2.desc_id = "bm_laser_gadget_module"
				end
				if self.parts.wpn_fps_upg_fl_eotech_ngal then
					self.parts.wpn_fps_upg_fl_eotech_ngal.stats.recoil = 1
					self.parts.wpn_fps_upg_fl_eotech_ngal.stats.spread = 0
					self.parts.wpn_fps_upg_fl_eotech_ngal.stats.concealment = -1
					self.parts.wpn_fps_upg_fl_eotech_ngal.has_description = true
					self.parts.wpn_fps_upg_fl_eotech_ngal.desc_id = "bm_laser_gadget_module"
				end
				if self.parts.wpn_fps_upg_fl_eotech_ogl then
					self.parts.wpn_fps_upg_fl_eotech_ogl.stats.recoil = 0
					self.parts.wpn_fps_upg_fl_eotech_ogl.stats.spread = 1
					self.parts.wpn_fps_upg_fl_eotech_ogl.stats.concealment = -1
					self.parts.wpn_fps_upg_fl_eotech_ogl.has_description = true
					self.parts.wpn_fps_upg_fl_eotech_ogl.desc_id = "bm_laser_gadget_module"
				end
				if self.parts.wpn_fps_upg_fl_holo then
					self.parts.wpn_fps_upg_fl_holo.stats.recoil = 0
					self.parts.wpn_fps_upg_fl_holo.stats.spread = 1
					self.parts.wpn_fps_upg_fl_holo.stats.concealment = -1
					self.parts.wpn_fps_upg_fl_holo.has_description = true
					self.parts.wpn_fps_upg_fl_holo.desc_id = "bm_laser_gadget_module"
				end
				if self.parts.wpn_fps_upg_fl_ncs then
					self.parts.wpn_fps_upg_fl_ncs.stats.recoil = -1
					self.parts.wpn_fps_upg_fl_ncs.stats.spread = 1
					self.parts.wpn_fps_upg_fl_ncs.stats.concealment = 0
					self.parts.wpn_fps_upg_fl_ncs.has_description = true
					self.parts.wpn_fps_upg_fl_ncs.desc_id = "bm_laser_gadget_module"
				end
				if self.parts.wpn_fps_upg_fl_peq15 then
					self.parts.wpn_fps_upg_fl_peq15.stats.recoil = 0
					self.parts.wpn_fps_upg_fl_peq15.stats.spread = 2
					self.parts.wpn_fps_upg_fl_peq15.stats.concealment = -5
					self.parts.wpn_fps_upg_fl_peq15.has_description = true
					self.parts.wpn_fps_upg_fl_peq15.desc_id = "bm_combined_gadget_module"
				end
				if self.parts.wpn_fps_upg_fl_2irs then
					self.parts.wpn_fps_upg_fl_2irs.stats.recoil = 2
					self.parts.wpn_fps_upg_fl_2irs.stats.spread = 1
					self.parts.wpn_fps_upg_fl_2irs.stats.concealment = -5
					self.parts.wpn_fps_upg_fl_2irs.has_description = true
					self.parts.wpn_fps_upg_fl_2irs.desc_id = "bm_combined_gadget_module"
				end
				if self.parts.wpn_fps_upg_fl_mawl then
					self.parts.wpn_fps_upg_fl_mawl.stats.recoil = 1
					self.parts.wpn_fps_upg_fl_mawl.stats.spread = 1
					self.parts.wpn_fps_upg_fl_mawl.stats.concealment = -3
					self.parts.wpn_fps_upg_fl_mawl.has_description = true
					self.parts.wpn_fps_upg_fl_mawl.desc_id = "bm_combined_gadget_module"
				end
				if self.parts.wpn_fps_upg_fl_pers then
					self.parts.wpn_fps_upg_fl_pers.stats.recoil = 2
					self.parts.wpn_fps_upg_fl_pers.stats.spread = 1
					self.parts.wpn_fps_upg_fl_pers.stats.concealment = -5
					self.parts.wpn_fps_upg_fl_pers.has_description = true
					self.parts.wpn_fps_upg_fl_pers.desc_id = "bm_combined_gadget_module"
				end
				if self.parts.wpn_fps_upg_fl_x400 then
					self.parts.wpn_fps_upg_fl_x400.stats.recoil = 0
					self.parts.wpn_fps_upg_fl_x400.stats.spread = 0
					self.parts.wpn_fps_upg_fl_x400.stats.concealment = 0
					self.parts.wpn_fps_upg_fl_x400.has_description = true
					self.parts.wpn_fps_upg_fl_x400.desc_id = "bm_combined_gadget_module"
				end
				if self.parts.wpn_fps_upg_fl_la5 then
					self.parts.wpn_fps_upg_fl_la5.stats.recoil = 1
					self.parts.wpn_fps_upg_fl_la5.stats.spread = 1
					self.parts.wpn_fps_upg_fl_la5.stats.concealment = -3
					self.parts.wpn_fps_upg_fl_la5.has_description = true
					self.parts.wpn_fps_upg_fl_la5.desc_id = "bm_combined_gadget_module"
				end
				if self.parts.wpn_fps_upg_fl_kleh then
					self.parts.wpn_fps_upg_fl_kleh.stats.recoil = 3
					self.parts.wpn_fps_upg_fl_kleh.stats.spread = 0
					self.parts.wpn_fps_upg_fl_kleh.stats.concealment = -4
					self.parts.wpn_fps_upg_fl_kleh.has_description = true
					self.parts.wpn_fps_upg_fl_kleh.desc_id = "bm_flashlight_gadget_module"
				end
				if self.parts.wpn_fps_upg_fl_las then
					self.parts.wpn_fps_upg_fl_las.stats.recoil = 1
					self.parts.wpn_fps_upg_fl_las.stats.spread = 0
					self.parts.wpn_fps_upg_fl_las.stats.concealment = 0
					self.parts.wpn_fps_upg_fl_las.has_description = true
					self.parts.wpn_fps_upg_fl_las.desc_id = "bm_flashlight_gadget_module"
				end
			end
			
			-- Pistol gadgets
			local function FrenchyAU_pistol_gadgets()
				if self.parts.wpn_fps_upg_fl_pis_ncs then
					self.parts.wpn_fps_upg_fl_pis_ncs.stats.recoil = 0
					self.parts.wpn_fps_upg_fl_pis_ncs.stats.spread = 1
					self.parts.wpn_fps_upg_fl_pis_ncs.stats.concealment = -1
					self.parts.wpn_fps_upg_fl_pis_ncs.has_description = true
					self.parts.wpn_fps_upg_fl_pis_ncs.desc_id = "bm_laser_gadget_module"
				end
				if self.parts.wpn_fps_upg_fl_pis_dbal then
					self.parts.wpn_fps_upg_fl_pis_dbal.stats.recoil = 0
					self.parts.wpn_fps_upg_fl_pis_dbal.stats.spread = 1
					self.parts.wpn_fps_upg_fl_pis_dbal.stats.concealment = -2
					self.parts.wpn_fps_upg_fl_pis_dbal.has_description = true
					self.parts.wpn_fps_upg_fl_pis_dbal.desc_id = "bm_combined_gadget_module"
				end
				if self.parts.wpn_fps_upg_fl_pis_gl21 then
					self.parts.wpn_fps_upg_fl_pis_gl21.stats.recoil = 1
					self.parts.wpn_fps_upg_fl_pis_gl21.stats.spread = 0
					self.parts.wpn_fps_upg_fl_pis_gl21.stats.concealment = -2
					self.parts.wpn_fps_upg_fl_pis_gl21.has_description = true
					self.parts.wpn_fps_upg_fl_pis_gl21.desc_id = "bm_combined_gadget_module"
				end
				if self.parts.wpn_fps_upg_fl_pis_xc1 then
					self.parts.wpn_fps_upg_fl_pis_xc1.stats.recoil = 0
					self.parts.wpn_fps_upg_fl_pis_xc1.stats.spread = 0
					self.parts.wpn_fps_upg_fl_pis_xc1.stats.concealment = -1
					self.parts.wpn_fps_upg_fl_pis_xc1.has_description = true
					self.parts.wpn_fps_upg_fl_pis_xc1.desc_id = "bm_combined_gadget_module"
				end
				if self.parts.wpn_fps_upg_fl_pis_2irs then
					self.parts.wpn_fps_upg_fl_pis_2irs.stats.recoil = 0
					self.parts.wpn_fps_upg_fl_pis_2irs.stats.spread = 1
					self.parts.wpn_fps_upg_fl_pis_2irs.stats.concealment = -2
					self.parts.wpn_fps_upg_fl_pis_2irs.has_description = true
					self.parts.wpn_fps_upg_fl_pis_2irs.desc_id = "bm_combined_gadget_module"
				end
				if self.parts.wpn_fps_upg_fl_pis_las then
					self.parts.wpn_fps_upg_fl_pis_las.stats.recoil = 0
					self.parts.wpn_fps_upg_fl_pis_las.stats.spread = 0
					self.parts.wpn_fps_upg_fl_pis_las.stats.concealment = 0
					self.parts.wpn_fps_upg_fl_pis_las.has_description = true
					self.parts.wpn_fps_upg_fl_pis_las.desc_id = "bm_flashlight_gadget_module"
				end
			end
			
			-- Grips
			local function FrenchyAU_hand_grips()
				if self.parts.wpn_fps_upg_m4_g_psg then
					self.parts.wpn_fps_upg_m4_g_psg.stats.spread = 2
					self.parts.wpn_fps_upg_m4_g_psg.stats.recoil = 2
					self.parts.wpn_fps_upg_m4_g_psg.stats.concealment = -5
				end
				if self.parts.wpn_fps_upg_m4_g_dlg123 then
					self.parts.wpn_fps_upg_m4_g_dlg123.stats.spread = -1
					self.parts.wpn_fps_upg_m4_g_dlg123.stats.recoil = 3
					self.parts.wpn_fps_upg_m4_g_dlg123.stats.concealment = -3
				end
				if self.parts.wpn_fps_upg_m4_g_st2 then
					self.parts.wpn_fps_upg_m4_g_st2.stats.spread = 1
					self.parts.wpn_fps_upg_m4_g_st2.stats.recoil = 0
					self.parts.wpn_fps_upg_m4_g_st2.stats.concealment = 2
				end
				if self.parts.wpn_fps_upg_m4_g_mcx then
					self.parts.wpn_fps_upg_m4_g_mcx.stats.spread = 2
					self.parts.wpn_fps_upg_m4_g_mcx.stats.recoil = -1
					self.parts.wpn_fps_upg_m4_g_mcx.stats.concealment = -1
				end
				if self.parts.wpn_fps_upg_m4_g_st1 then
					self.parts.wpn_fps_upg_m4_g_st1.stats.spread = 2
					self.parts.wpn_fps_upg_m4_g_st1.stats.recoil = -2
					self.parts.wpn_fps_upg_m4_g_st1.stats.concealment = 3
				end
				if self.parts.wpn_fps_upg_m4_g_hg15 then
					self.parts.wpn_fps_upg_m4_g_hg15.stats.spread = 3
					self.parts.wpn_fps_upg_m4_g_hg15.stats.recoil = -1
					self.parts.wpn_fps_upg_m4_g_hg15.stats.concealment = -3
				end
				if self.parts.wpn_fps_upg_ak_g_ags then
					self.parts.wpn_fps_upg_ak_g_ags.stats.spread = 2
					self.parts.wpn_fps_upg_ak_g_ags.stats.recoil = 3
					self.parts.wpn_fps_upg_ak_g_ags.stats.concealment = -6
				end
				if self.parts.wpn_fps_upg_ak_g_si then
					self.parts.wpn_fps_upg_ak_g_si.stats.spread = -1
					self.parts.wpn_fps_upg_ak_g_si.stats.recoil = 2
					self.parts.wpn_fps_upg_ak_g_si.stats.concealment = 0
				end
				if self.parts.wpn_fps_upg_ak_g_kgb then
					self.parts.wpn_fps_upg_ak_g_kgb.stats.spread = -1
					self.parts.wpn_fps_upg_ak_g_kgb.stats.recoil = 1
					self.parts.wpn_fps_upg_ak_g_kgb.stats.concealment = 2
				end
				if self.parts.wpn_fps_upg_ak_g_saw then
					self.parts.wpn_fps_upg_ak_g_saw.stats.spread = 2
					self.parts.wpn_fps_upg_ak_g_saw.stats.recoil = 0
					self.parts.wpn_fps_upg_ak_g_saw.stats.concealment = -2
				end
				if self.parts.wpn_fps_upg_ak_g_scorp then
					self.parts.wpn_fps_upg_ak_g_scorp.stats.spread = 2
					self.parts.wpn_fps_upg_ak_g_scorp.stats.recoil = -1
					self.parts.wpn_fps_upg_ak_g_scorp.stats.concealment = -1
				end
				if self.parts.wpn_fps_upg_m4_g_hex then
					self.parts.wpn_fps_upg_m4_g_hex.stats.spread = 0
					self.parts.wpn_fps_upg_m4_g_hex.stats.recoil = 1
					self.parts.wpn_fps_upg_m4_g_hex.stats.concealment = 1
				end
				if self.parts.wpn_fps_upg_ak_g_palm then
					self.parts.wpn_fps_upg_ak_g_palm.stats.spread = 0
					self.parts.wpn_fps_upg_ak_g_palm.stats.recoil = 2
					self.parts.wpn_fps_upg_ak_g_palm.stats.concealment = -1
				end
				if self.parts.wpn_fps_upg_ak_g_moe then
					self.parts.wpn_fps_upg_ak_g_moe.stats.spread = 2
					self.parts.wpn_fps_upg_ak_g_moe.stats.recoil = 2
					self.parts.wpn_fps_upg_ak_g_moe.stats.concealment = -4
				end
				if self.parts.wpn_fps_upg_m4_g_grals then
					self.parts.wpn_fps_upg_m4_g_grals.stats.spread = 2
					self.parts.wpn_fps_upg_m4_g_grals.stats.recoil = -1
					self.parts.wpn_fps_upg_m4_g_grals.stats.concealment = 0
				end
				if self.parts.wpn_fps_upg_m4_g_houge then
					self.parts.wpn_fps_upg_m4_g_houge.stats.spread = 1
					self.parts.wpn_fps_upg_m4_g_houge.stats.recoil = 2
					self.parts.wpn_fps_upg_m4_g_houge.stats.concealment = -2
				end
				if self.parts.wpn_fps_upg_m4_g_st2pc then
					self.parts.wpn_fps_upg_m4_g_st2pc.stats.spread = -2
					self.parts.wpn_fps_upg_m4_g_st2pc.stats.recoil = 3
					self.parts.wpn_fps_upg_m4_g_st2pc.stats.concealment = 1
				end
				if self.parts.wpn_fps_upg_m4_g_miad then
					self.parts.wpn_fps_upg_m4_g_miad.stats.spread = 1
					self.parts.wpn_fps_upg_m4_g_miad.stats.recoil = 2
					self.parts.wpn_fps_upg_m4_g_miad.stats.concealment = -2
				end
				if self.parts.wpn_fps_upg_m4_g_moe then
					self.parts.wpn_fps_upg_m4_g_moe.stats.spread = 0
					self.parts.wpn_fps_upg_m4_g_moe.stats.recoil = 2
					self.parts.wpn_fps_upg_m4_g_moe.stats.concealment = -1
				end
				if self.parts.wpn_fps_upg_m4_g_stark then
					self.parts.wpn_fps_upg_m4_g_stark.stats.spread = 3
					self.parts.wpn_fps_upg_m4_g_stark.stats.recoil = -1
					self.parts.wpn_fps_upg_m4_g_stark.stats.concealment = -3
				end
			end
			
			-- Foregrips
			local function FrenchyAU_foregrips()
				-- m4
				if self.parts.wpn_fps_upg_m4_fg_516 then
					self.parts.wpn_fps_upg_m4_fg_516.stats.spread = 2
					self.parts.wpn_fps_upg_m4_fg_516.stats.recoil = 2
					self.parts.wpn_fps_upg_m4_fg_516.stats.concealment = -3
					self.parts.wpn_fps_upg_m4_fg_516.stats.reload = 2
				end
				if self.parts.wpn_fps_upg_m4_fg_adar then
					self.parts.wpn_fps_upg_m4_fg_adar.stats.damage = 1
					self.parts.wpn_fps_upg_m4_fg_adar.stats.spread = 4
					self.parts.wpn_fps_upg_m4_fg_adar.stats.recoil = 0
					self.parts.wpn_fps_upg_m4_fg_adar.stats.concealment = -4
				end
				if self.parts.wpn_fps_upg_m4_fg_aero then
					self.parts.wpn_fps_upg_m4_fg_aero.stats.damage = 2
					self.parts.wpn_fps_upg_m4_fg_aero.stats.spread = 2
					self.parts.wpn_fps_upg_m4_fg_aero.stats.recoil = 2
					self.parts.wpn_fps_upg_m4_fg_aero.stats.concealment = -3
				end
				if self.parts.wpn_fps_upg_m4_fg_cmmg9 then
					self.parts.wpn_fps_upg_m4_fg_cmmg9.stats.damage = 3
					self.parts.wpn_fps_upg_m4_fg_cmmg9.stats.spread = 3
					self.parts.wpn_fps_upg_m4_fg_cmmg9.stats.recoil = 2
					self.parts.wpn_fps_upg_m4_fg_cmmg9.stats.concealment = -3
					self.parts.wpn_fps_upg_m4_fg_cmmg9.stats.reload = -3
				end
				if self.parts.wpn_fps_upg_m4_fg_dm7 then
					self.parts.wpn_fps_upg_m4_fg_dm7.stats.damage = 3
					self.parts.wpn_fps_upg_m4_fg_dm7.stats.spread = 2
					self.parts.wpn_fps_upg_m4_fg_dm7.stats.recoil = 3
					self.parts.wpn_fps_upg_m4_fg_dm7.stats.concealment = -5
					self.parts.wpn_fps_upg_m4_fg_dm7.stats.reload = -2
				end
				if self.parts.wpn_fps_upg_m4_fg_gis13 then
					self.parts.wpn_fps_upg_m4_fg_gis13.stats.spread = 1
					self.parts.wpn_fps_upg_m4_fg_gis13.stats.recoil = 3
					self.parts.wpn_fps_upg_m4_fg_gis13.stats.concealment = -3
					self.parts.wpn_fps_upg_m4_fg_gis13.stats.reload = 2
				end
				if self.parts.wpn_fps_upg_m4_fg_gis9 then
					self.parts.wpn_fps_upg_m4_fg_gis9.stats.spread = 1
					self.parts.wpn_fps_upg_m4_fg_gis9.stats.recoil = 2
					self.parts.wpn_fps_upg_m4_fg_gis9.stats.concealment = -1
					self.parts.wpn_fps_upg_m4_fg_gis9.stats.reload = 4
				end
				if self.parts.wpn_fps_upg_m4_fg_kacris then
					self.parts.wpn_fps_upg_m4_fg_kacris.stats.damage = -1
					self.parts.wpn_fps_upg_m4_fg_kacris.stats.spread = -1
					self.parts.wpn_fps_upg_m4_fg_kacris.stats.recoil = 2
					self.parts.wpn_fps_upg_m4_fg_kacris.stats.concealment = 3
					self.parts.wpn_fps_upg_m4_fg_kacris.stats.reload = 3
				end
				if self.parts.wpn_fps_upg_m4_fg_lmt then
					self.parts.wpn_fps_upg_m4_fg_lmt.stats.damage = -1
					self.parts.wpn_fps_upg_m4_fg_lmt.stats.spread = 2
					self.parts.wpn_fps_upg_m4_fg_lmt.stats.recoil = 3
					self.parts.wpn_fps_upg_m4_fg_lmt.stats.concealment = -3
					self.parts.wpn_fps_upg_m4_fg_lmt.stats.reload = -3
				end
				if self.parts.wpn_fps_upg_m4_fg_lone then
					self.parts.wpn_fps_upg_m4_fg_lone.stats.spread = 3
					self.parts.wpn_fps_upg_m4_fg_lone.stats.recoil = 3
					self.parts.wpn_fps_upg_m4_fg_lone.stats.concealment = -6
					self.parts.wpn_fps_upg_m4_fg_lone.stats.reload = -5
				end
				if self.parts.wpn_fps_upg_m4_fg_lvoac then
					self.parts.wpn_fps_upg_m4_fg_lvoac.stats.damage = 3
					self.parts.wpn_fps_upg_m4_fg_lvoac.stats.spread = 3
					self.parts.wpn_fps_upg_m4_fg_lvoac.stats.recoil = 2
					self.parts.wpn_fps_upg_m4_fg_lvoac.stats.concealment = -4
					self.parts.wpn_fps_upg_m4_fg_lvoac.stats.reload = -2
				end
				if self.parts.wpn_fps_upg_m4_fg_lvoas then
					self.parts.wpn_fps_upg_m4_fg_lvoas.stats.spread = 2
					self.parts.wpn_fps_upg_m4_fg_lvoas.stats.recoil = 2
					self.parts.wpn_fps_upg_m4_fg_lvoas.stats.concealment = -2
					self.parts.wpn_fps_upg_m4_fg_lvoas.stats.reload = 2
				end
				if self.parts.wpn_fps_upg_m4_fg_lwrc7 then
					self.parts.wpn_fps_upg_m4_fg_lwrc7.stats.damage = -1
					self.parts.wpn_fps_upg_m4_fg_lwrc7.stats.spread = 2
					self.parts.wpn_fps_upg_m4_fg_lwrc7.stats.recoil = -2
					self.parts.wpn_fps_upg_m4_fg_lwrc7.stats.concealment = 3
					self.parts.wpn_fps_upg_m4_fg_lwrc7.stats.reload = 3
					self.wpn_fps_smg_olympic.override.wpn_fps_upg_m4_fg_lwrc7 = {stats = {
						damage = 1,
						spread = 2,
						recoil = 2,
						reload = -2,
						concealment = -4
					}}
				end
				if self.parts.wpn_fps_upg_m4_fg_lwrc9 then
					self.parts.wpn_fps_upg_m4_fg_lwrc9.stats.spread = 1
					self.parts.wpn_fps_upg_m4_fg_lwrc9.stats.recoil = 1
					self.parts.wpn_fps_upg_m4_fg_lwrc9.stats.concealment = 1
				end
				if self.parts.wpn_fps_upg_m4_fg_mk10 then
					self.parts.wpn_fps_upg_m4_fg_mk10.stats.damage = 1
					self.parts.wpn_fps_upg_m4_fg_mk10.stats.spread = 2
					self.parts.wpn_fps_upg_m4_fg_mk10.stats.recoil = 3
					self.parts.wpn_fps_upg_m4_fg_mk10.stats.concealment = -4
					self.parts.wpn_fps_upg_m4_fg_mk10.stats.reload = 1
				end
				if self.parts.wpn_fps_upg_m4_fg_moec then
					self.parts.wpn_fps_upg_m4_fg_moec.stats.spread = 0
					self.parts.wpn_fps_upg_m4_fg_moec.stats.recoil = 2
					self.parts.wpn_fps_upg_m4_fg_moec.stats.concealment = 1
					self.parts.wpn_fps_upg_m4_fg_moec.stats.reload = 2
				end
				if self.parts.wpn_fps_upg_m4_fg_moem then
					self.parts.wpn_fps_upg_m4_fg_moem.stats.damage = 3
					self.parts.wpn_fps_upg_m4_fg_moem.stats.spread = -1
					self.parts.wpn_fps_upg_m4_fg_moem.stats.recoil = 3
					self.parts.wpn_fps_upg_m4_fg_moem.stats.concealment = 0
					self.parts.wpn_fps_upg_m4_fg_moem.stats.reload = 2
				end
				if self.parts.wpn_fps_upg_m4_fg_ris12 then
					self.parts.wpn_fps_upg_m4_fg_ris12.stats.damage = 2
					self.parts.wpn_fps_upg_m4_fg_ris12.stats.spread = 0
					self.parts.wpn_fps_upg_m4_fg_ris12.stats.recoil = 6
					self.parts.wpn_fps_upg_m4_fg_ris12.stats.concealment = -5
					self.parts.wpn_fps_upg_m4_fg_ris12.stats.reload = -4
				end
				if self.parts.wpn_fps_upg_m4_fg_ris9 then
					self.parts.wpn_fps_upg_m4_fg_ris9.stats.damage = 1
					self.parts.wpn_fps_upg_m4_fg_ris9.stats.spread = 0
					self.parts.wpn_fps_upg_m4_fg_ris9.stats.recoil = 4
					self.parts.wpn_fps_upg_m4_fg_ris9.stats.concealment = -3
					self.parts.wpn_fps_upg_m4_fg_ris9.stats.reload = -2
				end
				if self.parts.wpn_fps_upg_m4_fg_risfsp then
					self.parts.wpn_fps_upg_m4_fg_risfsp.stats.damage = 1
					self.parts.wpn_fps_upg_m4_fg_risfsp.stats.spread = 1
					self.parts.wpn_fps_upg_m4_fg_risfsp.stats.recoil = 3
					self.parts.wpn_fps_upg_m4_fg_risfsp.stats.concealment = -3
					self.parts.wpn_fps_upg_m4_fg_risfsp.stats.reload = -1
				end
				if self.parts.wpn_fps_upg_m4_fg_rsass then
					self.parts.wpn_fps_upg_m4_fg_rsass.stats.damage = 1
					self.parts.wpn_fps_upg_m4_fg_rsass.stats.spread = 4
					self.parts.wpn_fps_upg_m4_fg_rsass.stats.recoil = 1
					self.parts.wpn_fps_upg_m4_fg_rsass.stats.concealment = -3
				end
				if self.parts.wpn_fps_upg_m4_fg_sail then
					self.parts.wpn_fps_upg_m4_fg_sail.stats.damage = -1
					self.parts.wpn_fps_upg_m4_fg_sail.stats.spread = 6
					self.parts.wpn_fps_upg_m4_fg_sail.stats.recoil = -2
					self.parts.wpn_fps_upg_m4_fg_sail.stats.concealment = -5
					self.parts.wpn_fps_upg_m4_fg_sail.stats.reload = -3
				end
				if self.parts.wpn_fps_upg_m4_fg_sais then
					self.parts.wpn_fps_upg_m4_fg_sais.stats.spread = 4
					self.parts.wpn_fps_upg_m4_fg_sais.stats.recoil = 0
					self.parts.wpn_fps_upg_m4_fg_sais.stats.concealment = -3
				end
				if self.parts.wpn_fps_upg_m4_fg_skele then
					self.parts.wpn_fps_upg_m4_fg_skele.stats.damage = -2
					self.parts.wpn_fps_upg_m4_fg_skele.stats.spread = 1
					self.parts.wpn_fps_upg_m4_fg_skele.stats.recoil = 1
					self.parts.wpn_fps_upg_m4_fg_skele.stats.concealment = -4
					self.parts.wpn_fps_upg_m4_fg_skele.stats.reload = 6
				end
				if self.parts.wpn_fps_upg_m4_fg_stm12 then
					self.parts.wpn_fps_upg_m4_fg_stm12.stats.damage = -1
					self.parts.wpn_fps_upg_m4_fg_stm12.stats.spread = 1
					self.parts.wpn_fps_upg_m4_fg_stm12.stats.recoil = 4
					self.parts.wpn_fps_upg_m4_fg_stm12.stats.concealment = -2
				end
				if self.parts.wpn_fps_upg_m4_fg_stm15 then
					self.parts.wpn_fps_upg_m4_fg_stm15.stats.spread = 0
					self.parts.wpn_fps_upg_m4_fg_stm15.stats.recoil = 5
					self.parts.wpn_fps_upg_m4_fg_stm15.stats.concealment = -3
					self.parts.wpn_fps_upg_m4_fg_stm15.stats.reload = -2
				end
				if self.parts.wpn_fps_upg_m4_fg_stm9 then
					self.parts.wpn_fps_upg_m4_fg_stm9.stats.spread = -1
					self.parts.wpn_fps_upg_m4_fg_stm9.stats.recoil = 6
					self.parts.wpn_fps_upg_m4_fg_stm9.stats.concealment = -1
					self.parts.wpn_fps_upg_m4_fg_stm9.stats.reload = 1
				end
				if self.parts.wpn_fps_upg_m4_fg_strike then
					self.parts.wpn_fps_upg_m4_fg_strike.stats.spread = -2
					self.parts.wpn_fps_upg_m4_fg_strike.stats.recoil = -1
					self.parts.wpn_fps_upg_m4_fg_strike.stats.concealment = 4
				end
				if self.parts.wpn_fps_upg_m4_fg_urx10 then
					self.parts.wpn_fps_upg_m4_fg_urx10.stats.damage = 2
					self.parts.wpn_fps_upg_m4_fg_urx10.stats.spread = 2
					self.parts.wpn_fps_upg_m4_fg_urx10.stats.recoil = 2
					self.parts.wpn_fps_upg_m4_fg_urx10.stats.concealment = -4
					self.parts.wpn_fps_upg_m4_fg_urx10.stats.reload = 3
				end
				if self.parts.wpn_fps_upg_m4_fg_urx3 then
					self.parts.wpn_fps_upg_m4_fg_urx3.stats.spread = 2
					self.parts.wpn_fps_upg_m4_fg_urx3.stats.recoil = 2
					self.parts.wpn_fps_upg_m4_fg_urx3.stats.concealment = -1
				end
				if self.parts.wpn_fps_upg_m4_fg_vypr then
					self.parts.wpn_fps_upg_m4_fg_vypr.stats.damage = -2
					self.parts.wpn_fps_upg_m4_fg_vypr.stats.spread = 3
					self.parts.wpn_fps_upg_m4_fg_vypr.stats.recoil = 0
					self.parts.wpn_fps_upg_m4_fg_vypr.stats.concealment = 0
				end
				if self.parts.wpn_fps_upg_m4_fg_wing then
					self.parts.wpn_fps_upg_m4_fg_wing.stats.damage = 2
					self.parts.wpn_fps_upg_m4_fg_wing.stats.spread = 2
					self.parts.wpn_fps_upg_m4_fg_wing.stats.recoil = 3
					self.parts.wpn_fps_upg_m4_fg_wing.stats.concealment = -3
				end
				-- scar
				if self.parts.wpn_fps_upg_scar_fg_mrex then
					self.parts.wpn_fps_upg_scar_fg_mrex.stats.spread = 2
					self.parts.wpn_fps_upg_scar_fg_mrex.stats.recoil = 0
					self.parts.wpn_fps_upg_scar_fg_mrex.stats.concealment = -3
				end
				if self.parts.wpn_fps_upg_scar_fg_srx then
					self.parts.wpn_fps_upg_scar_fg_srx.stats.spread = -1
					self.parts.wpn_fps_upg_scar_fg_srx.stats.recoil = 1
					self.parts.wpn_fps_upg_scar_fg_srx.stats.concealment = 1
				end
				-- AK
				if self.parts.wpn_fps_ak_upg_fg_aggr then
					self.parts.wpn_fps_ak_upg_fg_aggr.stats.damage = 1
					self.parts.wpn_fps_ak_upg_fg_aggr.stats.spread = -2
					self.parts.wpn_fps_ak_upg_fg_aggr.stats.recoil = 5
					self.parts.wpn_fps_ak_upg_fg_aggr.stats.concealment = -3
				end
				if self.parts.wpn_fps_ak_upg_fg_ak100 then
					self.parts.wpn_fps_ak_upg_fg_ak100.stats.spread = 1
					self.parts.wpn_fps_ak_upg_fg_ak100.stats.recoil = 2
					self.parts.wpn_fps_ak_upg_fg_ak100.stats.concealment = 0
					self.parts.wpn_fps_ak_upg_fg_ak100.stats.reload = 2
				end
				if self.parts.wpn_fps_ak_upg_fg_b30 then
					self.parts.wpn_fps_ak_upg_fg_b30.stats.damage = 3
					self.parts.wpn_fps_ak_upg_fg_b30.stats.spread = 0
					self.parts.wpn_fps_ak_upg_fg_b30.stats.recoil = 3
					self.parts.wpn_fps_ak_upg_fg_b30.stats.concealment = -3
				end
				if self.parts.wpn_fps_ak_upg_fg_caa then
					self.parts.wpn_fps_ak_upg_fg_caa.stats.spread = 1
					self.parts.wpn_fps_ak_upg_fg_caa.stats.recoil = 2
					self.parts.wpn_fps_ak_upg_fg_caa.stats.concealment = 0
					self.parts.wpn_fps_ak_upg_fg_caa.stats.reload = 2
				end
				if self.parts.wpn_fps_ak_upg_fg_cmdr then
					self.parts.wpn_fps_ak_upg_fg_cmdr.stats.damage = -1
					self.parts.wpn_fps_ak_upg_fg_cmdr.stats.spread = 3
					self.parts.wpn_fps_ak_upg_fg_cmdr.stats.recoil = 1
					self.parts.wpn_fps_ak_upg_fg_cmdr.stats.concealment = -5
				end
				if self.parts.wpn_fps_ak_upg_fg_hexa then
					self.parts.wpn_fps_ak_upg_fg_hexa.stats.spread = 2
					self.parts.wpn_fps_ak_upg_fg_hexa.stats.recoil = 1
					self.parts.wpn_fps_ak_upg_fg_hexa.stats.concealment = 1
					self.parts.wpn_fps_ak_upg_fg_hexa.stats.reload = 4
				end
				if self.parts.wpn_fps_ak_upg_fg_krebsl then
					self.parts.wpn_fps_ak_upg_fg_krebsl.stats.damage = -1
					self.parts.wpn_fps_ak_upg_fg_krebsl.stats.spread = 2
					self.parts.wpn_fps_ak_upg_fg_krebsl.stats.recoil = 2
					self.parts.wpn_fps_ak_upg_fg_krebsl.stats.concealment = -2
					self.parts.wpn_fps_ak_upg_fg_krebsl.stats.reload = 2
				end
				if self.parts.wpn_fps_ak_upg_fg_moe then
					self.parts.wpn_fps_ak_upg_fg_moe.stats.spread = 0
					self.parts.wpn_fps_ak_upg_fg_moe.stats.recoil = 2
					self.parts.wpn_fps_ak_upg_fg_moe.stats.concealment = 2
					self.parts.wpn_fps_ak_upg_fg_moe.stats.reload = 1
				end
				if self.parts.wpn_fps_ak_upg_fg_plum then
					self.parts.wpn_fps_ak_upg_fg_plum.stats.spread = 1
					self.parts.wpn_fps_ak_upg_fg_plum.stats.recoil = 2
					self.parts.wpn_fps_ak_upg_fg_plum.stats.concealment = 0
					self.parts.wpn_fps_ak_upg_fg_plum.stats.reload = 2
				end
				if self.parts.wpn_fps_ak_upg_fg_tdi then
					self.parts.wpn_fps_ak_upg_fg_tdi.stats.spread = 0
					self.parts.wpn_fps_ak_upg_fg_tdi.stats.recoil = 2
					self.parts.wpn_fps_ak_upg_fg_tdi.stats.concealment = 1
					self.parts.wpn_fps_ak_upg_fg_tdi.stats.reload = 4
				end
				if self.parts.wpn_fps_ak_upg_fg_zhuk then
					self.parts.wpn_fps_ak_upg_fg_zhuk.stats.spread = 0
					self.parts.wpn_fps_ak_upg_fg_zhuk.stats.recoil = 4
					self.parts.wpn_fps_ak_upg_fg_zhuk.stats.concealment = -4
					self.parts.wpn_fps_ak_upg_fg_zhuk.stats.reload = 3
				end
				-- sydney's bootleg
				if self.parts.wpn_fps_upg_416_fg_carbon then
					self.parts.wpn_fps_upg_416_fg_carbon.stats.damage = 2
					self.parts.wpn_fps_upg_416_fg_carbon.stats.spread = 1
					self.parts.wpn_fps_upg_416_fg_carbon.stats.recoil = 1
					self.parts.wpn_fps_upg_416_fg_carbon.stats.concealment = -2
				end
				if self.parts.wpn_fps_upg_416_fg_crux then
					self.parts.wpn_fps_upg_416_fg_crux.stats.spread = 2
					self.parts.wpn_fps_upg_416_fg_crux.stats.recoil = 1
					self.parts.wpn_fps_upg_416_fg_crux.stats.concealment = -3
				end
				if self.parts.wpn_fps_upg_416_fg_key then
					self.parts.wpn_fps_upg_416_fg_key.stats.spread = 2
					self.parts.wpn_fps_upg_416_fg_key.stats.recoil = 2
					self.parts.wpn_fps_upg_416_fg_key.stats.concealment = -5
					self.parts.wpn_fps_upg_416_fg_key.stats.reload = -1
				end
				if self.parts.wpn_fps_upg_416_fg_mlok13 then
					self.parts.wpn_fps_upg_416_fg_mlok13.stats.spread = 1
					self.parts.wpn_fps_upg_416_fg_mlok13.stats.recoil = 1
					self.parts.wpn_fps_upg_416_fg_mlok13.stats.reload = 2
					self.parts.wpn_fps_upg_416_fg_mlok13.stats.concealment = -3
				end
				if self.parts.wpn_fps_upg_416_fg_mlok9 then
					self.parts.wpn_fps_upg_416_fg_mlok9.stats.spread = 0
					self.parts.wpn_fps_upg_416_fg_mlok9.stats.recoil = 1
					self.parts.wpn_fps_upg_416_fg_mlok9.stats.concealment = -1
					self.parts.wpn_fps_upg_416_fg_mlok9.stats.reload = 1
				end
				if self.parts.wpn_fps_upg_416_fg_quad then
					self.parts.wpn_fps_upg_416_fg_quad.stats.spread = 1
					self.parts.wpn_fps_upg_416_fg_quad.stats.recoil = 0
					self.parts.wpn_fps_upg_416_fg_quad.stats.concealment = -2
					self.parts.wpn_fps_upg_416_fg_quad.stats.reload = 2
				end
				if self.parts.wpn_fps_upg_416_fg_quade then
					self.parts.wpn_fps_upg_416_fg_quade.stats.spread = 0
					self.parts.wpn_fps_upg_416_fg_quade.stats.recoil = 3
					self.parts.wpn_fps_upg_416_fg_quade.stats.concealment = -4
					self.parts.wpn_fps_upg_416_fg_quade.stats.reload = 2
				end
				-- contraband aka little friend
				if self.parts.wpn_fps_upg_417_fg_free then
					self.parts.wpn_fps_upg_417_fg_free.stats.spread = 1
					self.parts.wpn_fps_upg_417_fg_free.stats.recoil = 2
					self.parts.wpn_fps_upg_417_fg_free.stats.concealment = -2
				end
				if self.parts.wpn_fps_upg_417_fg_patrol then
					self.parts.wpn_fps_upg_417_fg_patrol.stats.spread = -1
					self.parts.wpn_fps_upg_417_fg_patrol.stats.recoil = -2
					self.parts.wpn_fps_upg_417_fg_patrol.stats.concealment = 2
				end
				-- FAL
				if self.parts.wpn_fps_upg_fal_fg_belg then
					self.parts.wpn_fps_upg_fal_fg_belg.stats.spread = 2
					self.parts.wpn_fps_upg_fal_fg_belg.stats.recoil = 1
					self.parts.wpn_fps_upg_fal_fg_belg.stats.concealment = -2
				end
				if self.parts.wpn_fps_upg_fal_fg_casvl then
					self.parts.wpn_fps_upg_fal_fg_casvl.stats.damage = -1
					self.parts.wpn_fps_upg_fal_fg_casvl.stats.spread = -1
					self.parts.wpn_fps_upg_fal_fg_casvl.stats.recoil = 5
					self.parts.wpn_fps_upg_fal_fg_casvl.stats.concealment = -2
					self.parts.wpn_fps_upg_fal_fg_casvl.stats.reload = -2
				end
				if self.parts.wpn_fps_upg_fal_fg_casvs then
					self.parts.wpn_fps_upg_fal_fg_casvs.stats.spread = 0
					self.parts.wpn_fps_upg_fal_fg_casvs.stats.recoil = -1
					self.parts.wpn_fps_upg_fal_fg_casvs.stats.concealment = 5
				end
				if self.parts.wpn_fps_upg_fal_fg_flok then
					self.parts.wpn_fps_upg_fal_fg_flok.stats.spread = 4
					self.parts.wpn_fps_upg_fal_fg_flok.stats.recoil = -2
					self.parts.wpn_fps_upg_fal_fg_flok.stats.concealment = -2
				end
				if self.parts.wpn_fps_upg_fal_fg_keym then
					self.parts.wpn_fps_upg_fal_fg_keym.stats.spread = 1
					self.parts.wpn_fps_upg_fal_fg_keym.stats.recoil = 0
					self.parts.wpn_fps_upg_fal_fg_keym.stats.concealment = 2
				end
				-- This one doesnt appear in game because of a typo in main.xml of frenchy's mod
				if self.parts.wpn_fps_upg_fal_fg_stamp then
					self.parts.wpn_fps_upg_fal_fg_stamp.stats.spread = 2
					self.parts.wpn_fps_upg_fal_fg_stamp.stats.recoil = 2
					self.parts.wpn_fps_upg_fal_fg_stamp.stats.concealment = -4
				end
				-- saiga, duh
				if self.parts.wpn_fps_upg_saiga_fg_custom then
					self.parts.wpn_fps_upg_saiga_fg_custom.stats.spread = 2
					self.parts.wpn_fps_upg_saiga_fg_custom.stats.recoil = 3
					self.parts.wpn_fps_upg_saiga_fg_custom.stats.concealment = -4
				end
				-- hk51 lmg
				if self.parts.wpn_fps_upg_hk_fg_caa then
					self.parts.wpn_fps_upg_hk_fg_caa.stats.spread = 2
					self.parts.wpn_fps_upg_hk_fg_caa.stats.recoil = 3
					self.parts.wpn_fps_upg_hk_fg_caa.stats.concealment = -4
				end		
				if self.parts.wpn_fps_upg_hk_fg_tri then
					self.parts.wpn_fps_upg_hk_fg_tri.stats.spread = 1
					self.parts.wpn_fps_upg_hk_fg_tri.stats.recoil = 2
					self.parts.wpn_fps_upg_hk_fg_tri.stats.concealment = -2
				end
				-- 308 contractor sniper
				if self.parts.wpn_fps_upg_m4_fg_cmmg15 then
					self.parts.wpn_fps_upg_m4_fg_cmmg15.stats.spread = 2
					self.parts.wpn_fps_upg_m4_fg_cmmg15.stats.recoil = 1
					self.parts.wpn_fps_upg_m4_fg_cmmg15.stats.concealment = -2
				end
				if self.parts.wpn_fps_upg_m4_fg_kac then
					self.parts.wpn_fps_upg_m4_fg_kac.stats.spread = 1
					self.parts.wpn_fps_upg_m4_fg_kac.stats.recoil = 1
					self.parts.wpn_fps_upg_m4_fg_kac.stats.concealment = -1
					self.parts.wpn_fps_upg_m4_fg_kac.stats.reload = -3
				end
				if self.parts.wpn_fps_upg_m4_fg_lancer then
					self.parts.wpn_fps_upg_m4_fg_lancer.stats.spread = 1
					self.parts.wpn_fps_upg_m4_fg_lancer.stats.recoil = 0
					self.parts.wpn_fps_upg_m4_fg_lancer.stats.concealment = 1
				end
				if self.parts.wpn_fps_upg_m4_fg_nove then
					self.parts.wpn_fps_upg_m4_fg_nove.stats.spread = 0
					self.parts.wpn_fps_upg_m4_fg_nove.stats.recoil = 1
					self.parts.wpn_fps_upg_m4_fg_nove.stats.concealment = 1
				end
				if self.parts.wpn_fps_upg_m4_fg_noves then
					self.parts.wpn_fps_upg_m4_fg_noves.stats.spread = 1
					self.parts.wpn_fps_upg_m4_fg_noves.stats.recoil = 2
					self.parts.wpn_fps_upg_m4_fg_noves.stats.concealment = -1
				end
				-- secondary m4
				if self.parts.wpn_fps_upg_m4_fg_rismini then
					self.parts.wpn_fps_upg_m4_fg_rismini.stats.damage = 0
					self.parts.wpn_fps_upg_m4_fg_rismini.stats.spread = 1
					self.parts.wpn_fps_upg_m4_fg_rismini.stats.recoil = 1
					self.parts.wpn_fps_upg_m4_fg_rismini.stats.concealment = -2
					self.parts.wpn_fps_upg_m4_fg_rismini.stats.reload = 4
				end
				-- akmsu 'krinkov'
				if self.parts.wpn_fps_ak_upg_fg_b11 then
					self.parts.wpn_fps_ak_upg_fg_b11.stats.spread = 0
					self.parts.wpn_fps_ak_upg_fg_b11.stats.recoil = 2
					self.parts.wpn_fps_ak_upg_fg_b11.stats.concealment = -2
				end
				if self.parts.wpn_fps_ak_upg_fg_goliaf then
					self.parts.wpn_fps_ak_upg_fg_goliaf.stats.spread = 1
					self.parts.wpn_fps_ak_upg_fg_goliaf.stats.recoil = 3
					self.parts.wpn_fps_ak_upg_fg_goliaf.stats.concealment = -4
					self.parts.wpn_fps_ak_upg_fg_goliaf.stats.reload = -3
				end
			end
			
			-- BARRELS
			local function FrenchyAU_barrels()
				if self.parts.wpn_fps_upg_m4_b_260 then
					self.parts.wpn_fps_upg_m4_b_260.stats.damage = 3
					self.parts.wpn_fps_upg_m4_b_260.stats.spread = -3
					self.parts.wpn_fps_upg_m4_b_260.stats.recoil = 1
					self.parts.wpn_fps_upg_m4_b_260.stats.concealment = 2
				end
				if self.parts.wpn_fps_upg_m4_b_260post then
					self.parts.wpn_fps_upg_m4_b_260post.stats.damage = 3
					self.parts.wpn_fps_upg_m4_b_260post.stats.spread = -2
					self.parts.wpn_fps_upg_m4_b_260post.stats.recoil = 0
					self.parts.wpn_fps_upg_m4_b_260post.stats.concealment = 2
				end
				if self.parts.wpn_fps_upg_m4_b_260rail then
					self.parts.wpn_fps_upg_m4_b_260rail.stats.damage = 3
					self.parts.wpn_fps_upg_m4_b_260rail.stats.spread = -4
					self.parts.wpn_fps_upg_m4_b_260rail.stats.recoil = 2
					self.parts.wpn_fps_upg_m4_b_260rail.stats.concealment = 2
				end
				if self.parts.wpn_fps_upg_m4_b_370 then
					self.parts.wpn_fps_upg_m4_b_370.stats.damage = -1
					self.parts.wpn_fps_upg_m4_b_370.stats.spread = 0
					self.parts.wpn_fps_upg_m4_b_370.stats.recoil = 0
					self.parts.wpn_fps_upg_m4_b_370.stats.concealment = 1
				end
				if self.parts.wpn_fps_upg_m4_b_370post then
					self.parts.wpn_fps_upg_m4_b_370post.stats.damage = -1
					self.parts.wpn_fps_upg_m4_b_370post.stats.spread = 1
					self.parts.wpn_fps_upg_m4_b_370post.stats.recoil = -1
					self.parts.wpn_fps_upg_m4_b_370post.stats.concealment = 1
				end	
				if self.parts.wpn_fps_upg_m4_b_370rail then
					self.parts.wpn_fps_upg_m4_b_370rail.stats.damage = -1
					self.parts.wpn_fps_upg_m4_b_370rail.stats.spread = -1
					self.parts.wpn_fps_upg_m4_b_370rail.stats.recoil = 1
					self.parts.wpn_fps_upg_m4_b_370rail.stats.concealment = 1
				end
				if self.parts.wpn_fps_upg_m4_b_406 then
					self.parts.wpn_fps_upg_m4_b_406.stats.damage = 1
					self.parts.wpn_fps_upg_m4_b_406.stats.spread = 0
					self.parts.wpn_fps_upg_m4_b_406.stats.recoil = 1
					self.parts.wpn_fps_upg_m4_b_406.stats.concealment = 0
				end
				if self.parts.wpn_fps_upg_m4_b_406post then
					self.parts.wpn_fps_upg_m4_b_406post.stats.damage = 1
					self.parts.wpn_fps_upg_m4_b_406post.stats.spread = 1
					self.parts.wpn_fps_upg_m4_b_406post.stats.recoil = -1
					self.parts.wpn_fps_upg_m4_b_406post.stats.concealment = 0
				end
				if self.parts.wpn_fps_upg_m4_b_457 then
					self.parts.wpn_fps_upg_m4_b_457.stats.damage = 2
					self.parts.wpn_fps_upg_m4_b_457.stats.spread = 1
					self.parts.wpn_fps_upg_m4_b_457.stats.recoil = 0
					self.parts.wpn_fps_upg_m4_b_457.stats.concealment = -2
				end
				if self.parts.wpn_fps_upg_m4_b_457post then
					self.parts.wpn_fps_upg_m4_b_457post.stats.spread = 3
					self.parts.wpn_fps_upg_m4_b_457post.stats.recoil = -2
					self.parts.wpn_fps_upg_m4_b_457post.stats.concealment = -2
				end
				if self.parts.wpn_fps_upg_m4_b_508 then
					self.parts.wpn_fps_upg_m4_b_508.stats.spread = 2
					self.parts.wpn_fps_upg_m4_b_508.stats.recoil = -1
					self.parts.wpn_fps_upg_m4_b_508.stats.concealment = -3
				end
				if self.parts.wpn_fps_upg_m4_b_508post then
					self.parts.wpn_fps_upg_m4_b_508post.stats.damage = 2
					self.parts.wpn_fps_upg_m4_b_508post.stats.spread = 3
					self.parts.wpn_fps_upg_m4_b_508post.stats.recoil = -2
					self.parts.wpn_fps_upg_m4_b_508post.stats.concealment = -3
				end
				-- sydney's bootleg gun has 5 barrels exclusive to it. thats a bit too much effort for 1 gun frenchy, but ok
				if self.parts.wpn_fps_upg_416_b_264 then
					self.parts.wpn_fps_upg_416_b_264.stats.damage = 3
					self.parts.wpn_fps_upg_416_b_264.stats.spread = -2
					self.parts.wpn_fps_upg_416_b_264.stats.recoil = 1
					self.parts.wpn_fps_upg_416_b_264.stats.concealment = 2
				end
				if self.parts.wpn_fps_upg_416_b_279 then
					self.parts.wpn_fps_upg_416_b_279.stats.damage = 2
					self.parts.wpn_fps_upg_416_b_279.stats.spread = -1
					self.parts.wpn_fps_upg_416_b_279.stats.recoil = 0
					self.parts.wpn_fps_upg_416_b_279.stats.concealment = 1
				end
				if self.parts.wpn_fps_upg_416_b_368 then
					self.parts.wpn_fps_upg_416_b_368.stats.damage = 1
					self.parts.wpn_fps_upg_416_b_368.stats.spread = 0
					self.parts.wpn_fps_upg_416_b_368.stats.recoil = 1
					self.parts.wpn_fps_upg_416_b_368.stats.concealment = -1
				end
				if self.parts.wpn_fps_upg_416_b_419 then
					self.parts.wpn_fps_upg_416_b_419.stats.spread = 1
					self.parts.wpn_fps_upg_416_b_419.stats.recoil = 1
					self.parts.wpn_fps_upg_416_b_419.stats.concealment = -2
				end
				if self.parts.wpn_fps_upg_416_b_505 then
					self.parts.wpn_fps_upg_416_b_505.stats.damage = -1
					self.parts.wpn_fps_upg_416_b_505.stats.spread = 2
					self.parts.wpn_fps_upg_416_b_505.stats.recoil = 0
					self.parts.wpn_fps_upg_416_b_505.stats.concealment = -3
				end
				if self.parts.wpn_fps_upg_scar_b_cqb then
					self.parts.wpn_fps_upg_scar_b_cqb.stats.spread = -2
					self.parts.wpn_fps_upg_scar_b_cqb.stats.recoil = 3
					self.parts.wpn_fps_upg_scar_b_cqb.stats.concealment = 4
				end		
				if self.parts.wpn_fps_upg_akmsu_b then
					self.parts.wpn_fps_upg_akmsu_b.stats.spread = -1
					self.parts.wpn_fps_upg_akmsu_b.stats.recoil = 1
					self.parts.wpn_fps_upg_akmsu_b.stats.concealment = 1
				end
				if self.parts.wpn_fps_smg_polymer_barrel_mk5 then
					self.parts.wpn_fps_smg_polymer_barrel_mk5.stats.spread = 1
					self.parts.wpn_fps_smg_polymer_barrel_mk5.stats.recoil = 1
					self.parts.wpn_fps_smg_polymer_barrel_mk5.stats.concealment = 0
				end
				if self.parts.wpn_fps_smg_polymer_barrel_barlong then
					self.parts.wpn_fps_smg_polymer_barrel_barlong.stats.spread = 3
					self.parts.wpn_fps_smg_polymer_barrel_barlong.stats.recoil = -4
					self.parts.wpn_fps_smg_polymer_barrel_barlong.stats.concealment = -4
				end
				if self.parts.wpn_fps_smg_polymer_barrel_barsil then
					-- WE CANT PUT A SUPRESSOR INSIDE OF ANOTHER SUPRESSOR FRENCHY
					table.insert(self.parts.wpn_fps_smg_polymer_barrel_barsil.forbids, "wpn_fps_ass_ns_g_aac")
					table.insert(self.parts.wpn_fps_smg_polymer_barrel_barsil.forbids, "wpn_fps_ass_ns_g_sfn")
					table.insert(self.parts.wpn_fps_smg_polymer_barrel_barsil.forbids, "wpn_fps_ass_ns_g_srd")
					table.insert(self.parts.wpn_fps_smg_polymer_barrel_barsil.forbids, "wpn_fps_pis_ns_alpha")
					table.insert(self.parts.wpn_fps_smg_polymer_barrel_barsil.forbids, "wpn_fps_pis_ns_omega")
					table.insert(self.parts.wpn_fps_smg_polymer_barrel_barsil.forbids, "wpn_fps_pis_ns_osprey")
					table.insert(self.parts.wpn_fps_smg_polymer_barrel_barsil.forbids, "wpn_fps_pis_ns_pl15")
					table.insert(self.parts.wpn_fps_smg_polymer_barrel_barsil.forbids, "wpn_fps_upg_ns_pis_putnik")
					table.insert(self.parts.wpn_fps_smg_polymer_barrel_barsil.forbids, "wpn_fps_smg_polymer_barrel_precision")
					table.insert(self.parts.wpn_fps_smg_polymer_barrel_barsil.forbids, "wpn_fps_smg_polymer_ns_silencer")
					self.parts.wpn_fps_smg_polymer_barrel_barsil.stats.damage = -2
					self.parts.wpn_fps_smg_polymer_barrel_barsil.stats.spread = 3
					self.parts.wpn_fps_smg_polymer_barrel_barsil.stats.recoil = -2
					self.parts.wpn_fps_smg_polymer_barrel_barsil.stats.concealment = -3
				end
			end
			
			-- STOCKS
			local function FrenchyAU_stocks()
				if self.parts.wpn_fps_upg_m4_s_a2 then
					self.parts.wpn_fps_upg_m4_s_a2.stats.spread = -1
					self.parts.wpn_fps_upg_m4_s_a2.stats.recoil = 3
					self.parts.wpn_fps_upg_m4_s_a2.stats.concealment = -3
				end
				if self.parts.wpn_fps_upg_m4_s_hera then				
					table.insert(self.parts.wpn_fps_upg_m4_s_hera.forbids, "wpn_fps_upg_g_m4_surgeon")
					table.insert(self.parts.wpn_fps_upg_m4_s_hera.forbids, "wpn_fps_m4_uupg_g_billet")
					table.insert(self.parts.wpn_fps_upg_m4_s_hera.forbids, "wpn_fps_sho_sko12_body_grip")
					table.insert(self.parts.wpn_fps_upg_m4_s_hera.forbids, "wpn_fps_snp_victor_g_mod3")
					table.insert(self.parts.wpn_fps_upg_m4_s_hera.forbids, "wpn_fps_upg_m4_g_standard")
					self.parts.wpn_fps_upg_m4_s_hera.stats.spread = 4
					self.parts.wpn_fps_upg_m4_s_hera.stats.recoil = 4
					self.parts.wpn_fps_upg_m4_s_hera.stats.concealment = -10
					self.parts.wpn_fps_upg_m4_s_hera.stats.reload = -1
				end
				if self.parts.wpn_fps_upg_m4_s_prs3 then
					self.parts.wpn_fps_upg_m4_s_prs3.stats.spread = -1
					self.parts.wpn_fps_upg_m4_s_prs3.stats.recoil = 4
					self.parts.wpn_fps_upg_m4_s_prs3.stats.concealment = -5
					self.parts.wpn_fps_upg_m4_s_prs3.stats.reload = -2
				end
				if self.parts.wpn_fps_upg_m4_s_ddun then
					self.parts.wpn_fps_upg_m4_s_ddun.stats.spread = 1
					self.parts.wpn_fps_upg_m4_s_ddun.stats.recoil = 1
					self.parts.wpn_fps_upg_m4_s_ddun.stats.concealment = -1
					-- i am not 100% sure why and how, but this stock crashes the game if equipped on the 'little friend' AR
					-- it doesnt even really matter why it happens, since this is the only stock that was added to this gun by frenchy,
					-- so even if it would work for other people, having a choice of either using a default or 1 custom stock would be kinda lame
					table.delete(self.parts.wpn_fps_upg_m4_s_ddun.weapons,"wpn_fps_ass_contraband")
				end
				if self.parts.wpn_fps_upg_mpx_s_tele then
					self.parts.wpn_fps_upg_mpx_s_tele.stats.spread = 1
					self.parts.wpn_fps_upg_mpx_s_tele.stats.recoil = 2
					self.parts.wpn_fps_upg_mpx_s_tele.stats.concealment = -3
					self.parts.wpn_fps_upg_mpx_s_tele.stats.reload = -2
				end
				if self.parts.wpn_fps_upg_m4_s_prs2 then
					self.parts.wpn_fps_upg_m4_s_prs2.stats.spread = 0
					self.parts.wpn_fps_upg_m4_s_prs2.stats.recoil = 3
					self.parts.wpn_fps_upg_m4_s_prs2.stats.concealment = -4
					self.parts.wpn_fps_upg_m4_s_prs2.stats.reload = -1
				end
				if self.parts.wpn_fps_upg_mpx_s_maxim then
					self.parts.wpn_fps_upg_mpx_s_maxim.stats.spread = 0
					self.parts.wpn_fps_upg_mpx_s_maxim.stats.recoil = 1
					self.parts.wpn_fps_upg_mpx_s_maxim.stats.concealment = 0
					self.parts.wpn_fps_upg_mpx_s_maxim.stats.reload = 2
				end
				if self.parts.wpn_fps_upg_ak_s_arch then
					self.parts.wpn_fps_upg_ak_s_arch.stats.spread = 2
					self.parts.wpn_fps_upg_ak_s_arch.stats.recoil = 1
					self.parts.wpn_fps_upg_ak_s_arch.stats.concealment = -2
				end
				if self.parts.wpn_fps_upg_mpx_s_thin then
					self.parts.wpn_fps_upg_mpx_s_thin.stats.spread = 1
					self.parts.wpn_fps_upg_mpx_s_thin.stats.recoil = 1
					self.parts.wpn_fps_upg_mpx_s_thin.stats.concealment = -1
				end
				if self.parts.wpn_fps_upg_m4_s_core then
					self.parts.wpn_fps_upg_m4_s_core.stats.spread = 3
					self.parts.wpn_fps_upg_m4_s_core.stats.recoil = -1
					self.parts.wpn_fps_upg_m4_s_core.stats.concealment = -3
				end
				if self.parts.wpn_fps_upg_fal_s_prs then
					self.parts.wpn_fps_upg_fal_s_prs.stats.spread = 3
					self.parts.wpn_fps_upg_fal_s_prs.stats.recoil = 0
					self.parts.wpn_fps_upg_fal_s_prs.stats.concealment = -4
					self.parts.wpn_fps_upg_fal_s_prs.stats.reload = 2
				end
				if self.parts.wpn_fps_upg_m4_s_moe then
					self.parts.wpn_fps_upg_m4_s_moe.stats.spread = -1
					self.parts.wpn_fps_upg_m4_s_moe.stats.recoil = 0
					self.parts.wpn_fps_upg_m4_s_moe.stats.concealment = 2
				end
				if self.parts.wpn_fps_upg_ak_s_zhu then
					self.parts.wpn_fps_upg_ak_s_zhu.stats.spread = 2
					self.parts.wpn_fps_upg_ak_s_zhu.stats.recoil = 1
					self.parts.wpn_fps_upg_ak_s_zhu.stats.concealment = -2
				end
				if self.parts.wpn_fps_upg_m4_s_cmmg then
					self.parts.wpn_fps_upg_m4_s_cmmg.stats.spread = 0
					self.parts.wpn_fps_upg_m4_s_cmmg.stats.recoil = -1
					self.parts.wpn_fps_upg_m4_s_cmmg.stats.concealment = 2
				end
				if self.parts.wpn_fps_upg_mpx_s_collap then
					self.parts.wpn_fps_upg_mpx_s_collap.stats.spread = 0
					self.parts.wpn_fps_upg_mpx_s_collap.stats.recoil = -1
					self.parts.wpn_fps_upg_mpx_s_collap.stats.concealment = 1
					self.parts.wpn_fps_upg_mpx_s_collap.stats.reload = 2
				end
				if self.parts.wpn_fps_upg_m4_s_gen2 then
					self.parts.wpn_fps_upg_m4_s_gen2.stats.spread = 2
					self.parts.wpn_fps_upg_m4_s_gen2.stats.recoil = 2
					self.parts.wpn_fps_upg_m4_s_gen2.stats.concealment = -5
					self.parts.wpn_fps_upg_m4_s_gen2.stats.reload = -2
				end
				if self.parts.wpn_fps_upg_mpx_s_ulss then
					self.parts.wpn_fps_upg_mpx_s_ulss.stats.spread = 1
					self.parts.wpn_fps_upg_mpx_s_ulss.stats.recoil = 0
					self.parts.wpn_fps_upg_mpx_s_ulss.stats.concealment = 0
				end
				if self.parts.wpn_fps_upg_fal_s_brs then
					self.parts.wpn_fps_upg_fal_s_brs.stats.spread = -1
					self.parts.wpn_fps_upg_fal_s_brs.stats.recoil = 4
					self.parts.wpn_fps_upg_fal_s_brs.stats.concealment = -4
					self.parts.wpn_fps_upg_fal_s_brs.stats.reload = 3
				end
				if self.parts.wpn_fps_upg_m4_s_ds150 then
					self.parts.wpn_fps_upg_m4_s_ds150.stats.spread = 2
					self.parts.wpn_fps_upg_m4_s_ds150.stats.recoil = 0
					self.parts.wpn_fps_upg_m4_s_ds150.stats.concealment = -2
				end
				if self.parts.wpn_fps_sho_ultima_s_ults then
					self.parts.wpn_fps_sho_ultima_s_ults.stats.spread = 0
					self.parts.wpn_fps_sho_ultima_s_ults.stats.recoil = 2
					self.parts.wpn_fps_sho_ultima_s_ults.stats.concealment = -1
				end
				if self.parts.wpn_fps_upg_ak_s_plstc then
					self.parts.wpn_fps_upg_ak_s_plstc.stats.spread = 1
					self.parts.wpn_fps_upg_ak_s_plstc.stats.recoil = 3
					self.parts.wpn_fps_upg_ak_s_plstc.stats.concealment = -3
					self.parts.wpn_fps_upg_ak_s_plstc.stats.reload = -1
				end
				if self.parts.wpn_fps_upg_m4_s_adar then
					table.insert(self.parts.wpn_fps_upg_m4_s_adar.forbids, "wpn_fps_upg_g_m4_surgeon")
					table.insert(self.parts.wpn_fps_upg_m4_s_adar.forbids, "wpn_fps_m4_uupg_g_billet")
					table.insert(self.parts.wpn_fps_upg_m4_s_adar.forbids, "wpn_fps_sho_sko12_body_grip")
					table.insert(self.parts.wpn_fps_upg_m4_s_adar.forbids, "wpn_fps_snp_victor_g_mod3")
					table.insert(self.parts.wpn_fps_upg_m4_s_adar.forbids, "wpn_fps_upg_m4_g_standard")
					self.parts.wpn_fps_upg_m4_s_adar.stats.spread = 4
					self.parts.wpn_fps_upg_m4_s_adar.stats.recoil = 4
					self.parts.wpn_fps_upg_m4_s_adar.stats.concealment = -10
					self.parts.wpn_fps_upg_m4_s_adar.stats.reload = -1
				end
				if self.parts.wpn_fps_upg_fal_s_spr then
					self.parts.wpn_fps_upg_fal_s_spr.stats.spread = 0
					self.parts.wpn_fps_upg_fal_s_spr.stats.recoil = 2
					self.parts.wpn_fps_upg_fal_s_spr.stats.concealment = 2
				end
				if self.parts.wpn_fps_sho_ultima_s_ultm then
					self.parts.wpn_fps_sho_ultima_s_ultm.stats.spread = 0
					self.parts.wpn_fps_sho_ultima_s_ultm.stats.recoil = 3
					self.parts.wpn_fps_sho_ultima_s_ultm.stats.concealment = -2
				end
				if self.parts.wpn_fps_upg_ak_s_hex then
					self.parts.wpn_fps_upg_ak_s_hex.stats.spread = 2
					self.parts.wpn_fps_upg_ak_s_hex.stats.recoil = 1
					self.parts.wpn_fps_upg_ak_s_hex.stats.concealment = -1
					self.parts.wpn_fps_upg_ak_s_hex.stats.reload = -1
				end
				if self.parts.wpn_fps_upg_m4_s_bus then
					self.parts.wpn_fps_upg_m4_s_bus.stats.spread = 4
					self.parts.wpn_fps_upg_m4_s_bus.stats.recoil = -1
					self.parts.wpn_fps_upg_m4_s_bus.stats.concealment = -5
					self.parts.wpn_fps_upg_m4_s_bus.stats.reload = -2
				end
				if self.parts.wpn_fps_upg_m4_s_viper then
					self.parts.wpn_fps_upg_m4_s_viper.stats.spread = 0
					self.parts.wpn_fps_upg_m4_s_viper.stats.recoil = 0
					self.parts.wpn_fps_upg_m4_s_viper.stats.concealment = 1
					self.parts.wpn_fps_upg_m4_s_viper.stats.reload = 5
				end
				if self.parts.wpn_fps_upg_m4_s_hke1 then
					self.parts.wpn_fps_upg_m4_s_hke1.stats.spread = -1
					self.parts.wpn_fps_upg_m4_s_hke1.stats.recoil = 4
					self.parts.wpn_fps_upg_m4_s_hke1.stats.concealment = -5
					self.parts.wpn_fps_upg_m4_s_hke1.stats.reload = -2
				end
				if self.parts.wpn_fps_sho_ultima_s_ultl then
					self.parts.wpn_fps_sho_ultima_s_ultl.stats.spread = 1
					self.parts.wpn_fps_sho_ultima_s_ultl.stats.recoil = 3
					self.parts.wpn_fps_sho_ultima_s_ultl.stats.concealment = -3
				end
				if self.parts.wpn_fps_upg_m4_s_hkslim then
					self.parts.wpn_fps_upg_m4_s_hkslim.stats.spread = 0
					self.parts.wpn_fps_upg_m4_s_hkslim.stats.recoil = 2
					self.parts.wpn_fps_upg_m4_s_hkslim.stats.concealment = -2
				end
				if self.parts.wpn_fps_upg_m4_s_troy then
					self.parts.wpn_fps_upg_m4_s_troy.stats.spread = -1
					self.parts.wpn_fps_upg_m4_s_troy.stats.recoil = -1
					self.parts.wpn_fps_upg_m4_s_troy.stats.concealment = 3
					self.parts.wpn_fps_upg_m4_s_troy.stats.reload = 3
				end
				if self.parts.wpn_fps_upg_ak_s_akhera then
					table.insert(self.parts.wpn_fps_upg_ak_s_akhera.forbids, "wpn_fps_upg_ak_g_hgrip")
					table.insert(self.parts.wpn_fps_upg_ak_s_akhera.forbids, "wpn_fps_upg_ak_g_wgrip")
					self.parts.wpn_fps_upg_ak_s_akhera.stats.spread = 3
					self.parts.wpn_fps_upg_ak_s_akhera.stats.recoil = 6
					self.parts.wpn_fps_upg_ak_s_akhera.stats.reload = -2
					self.parts.wpn_fps_upg_ak_s_akhera.stats.concealment = -10
				end
				-- adapter
				if self.parts.wpn_fps_upg_m4_buff_adap then
					self.parts.wpn_fps_upg_m4_buff_adap.stats.spread = 0
					self.parts.wpn_fps_upg_m4_buff_adap.stats.recoil = 0
					self.parts.wpn_fps_upg_m4_buff_adap.stats.concealment = 0
				end
			end
			
			-- MAGAZINES
			local function FrenchyAU_mags()
				if self.parts.wpn_fps_upg_m_dura then
					self.parts.wpn_fps_upg_m_dura.stats.extra_ammo = 2
					self.parts.wpn_fps_upg_m_dura.stats.spread = 0
					self.parts.wpn_fps_upg_m_dura.stats.recoil = 1
					self.parts.wpn_fps_upg_m_dura.stats.concealment = -1
					self.parts.wpn_fps_upg_m_dura.stats.reload = -1
					self.wpn_fps_smg_x_olympic.override.wpn_fps_upg_m_dura = {override_weapon = {_meta = "override_weapon",CLIP_AMMO_MAX = 68},stats = {spread = nil,recoil = 1,concealment = -1,reload = -1}}
				end
				if self.parts.wpn_fps_upg_m_d60 then
					self.parts.wpn_fps_upg_m_d60.stats.spread = -2
					self.parts.wpn_fps_upg_m_d60.stats.recoil = 3
					self.parts.wpn_fps_upg_m_d60.stats.concealment = -4
					self.parts.wpn_fps_upg_m_d60.stats.reload = -6
					self.wpn_fps_smg_x_olympic.override.wpn_fps_upg_m_d60 = {override_weapon = {_meta = "override_weapon",CLIP_AMMO_MAX = 120},stats = {spread = -2,recoil = 3,concealment = -4,reload = -6}}
				end
				if self.parts.wpn_fps_upg_m_p10 then
					self.parts.wpn_fps_upg_m_p10.stats.spread = 3
					self.parts.wpn_fps_upg_m_p10.stats.recoil = -2
					self.parts.wpn_fps_upg_m_p10.stats.concealment = 4
					self.parts.wpn_fps_upg_m_p10.stats.reload = 10
					self.wpn_fps_smg_x_olympic.override.wpn_fps_upg_m_p10 = {override_weapon = {_meta = "override_weapon",CLIP_AMMO_MAX = 20},stats = {spread = 3,recoil = -2,concealment = 4,reload = 10}}
				end
				if self.parts.wpn_fps_upg_m_p20 then
					self.parts.wpn_fps_upg_m_p20.stats.spread = 2
					self.parts.wpn_fps_upg_m_p20.stats.recoil = -1
					self.parts.wpn_fps_upg_m_p20.stats.concealment = 2
					self.parts.wpn_fps_upg_m_p20.stats.reload = 8
					self.wpn_fps_smg_x_olympic.override.wpn_fps_upg_m_p20 = {override_weapon = {_meta = "override_weapon",CLIP_AMMO_MAX = 40},stats = {spread = 2,recoil = -1,concealment = 2,reload = 8}}
				end
				if self.parts.wpn_fps_upg_m_p30 then
					self.parts.wpn_fps_upg_m_p30.stats.spread = 1
					self.parts.wpn_fps_upg_m_p30.stats.recoil = 1
					self.parts.wpn_fps_upg_m_p30.stats.concealment = -3
					self.parts.wpn_fps_upg_m_p30.stats.reload = 0
					self.wpn_fps_smg_x_olympic.override.wpn_fps_upg_m_p30 = {override_weapon = {_meta = "override_weapon",CLIP_AMMO_MAX = 60},stats = {spread = 1,recoil = 1,concealment = -3,reload = nil}}
				end
				if self.parts.wpn_fps_upg_m_p30w then
					self.parts.wpn_fps_upg_m_p30w.stats.spread = 2
					self.parts.wpn_fps_upg_m_p30w.stats.recoil = -1
					self.parts.wpn_fps_upg_m_p30w.stats.concealment = -2
					self.parts.wpn_fps_upg_m_p30w.stats.reload = 0
					self.wpn_fps_smg_x_olympic.override.wpn_fps_upg_m_p30w = {override_weapon = {_meta = "override_weapon",CLIP_AMMO_MAX = 60},stats = {spread = 2,recoil = -1,concealment = -2,reload = nil}}
				end
				if self.parts.wpn_fps_upg_m_p40 then
					self.parts.wpn_fps_upg_m_p40.stats.spread = -1
					self.parts.wpn_fps_upg_m_p40.stats.recoil = 1
					self.parts.wpn_fps_upg_m_p40.stats.concealment = -3
					self.parts.wpn_fps_upg_m_p40.stats.reload = -4
					self.wpn_fps_smg_x_olympic.override.wpn_fps_upg_m_p40 = {override_weapon = {_meta = "override_weapon",CLIP_AMMO_MAX = 60},stats = {spread = -1,recoil = 1,concealment = -3,reload = -4}}
				end
				if self.parts.wpn_fps_upg_m_battle then
					self.parts.wpn_fps_upg_m_battle.stats.spread = 0
					self.parts.wpn_fps_upg_m_battle.stats.recoil = 0
					self.parts.wpn_fps_upg_m_battle.stats.concealment = 2
					self.parts.wpn_fps_upg_m_battle.stats.reload = 0
					self.wpn_fps_smg_x_olympic.override.wpn_fps_upg_m_battle = {override_weapon = {_meta = "override_weapon",CLIP_AMMO_MAX = 60},stats = {spread = nil,recoil = nil,concealment = 2,reload = nil}}
				end
				if self.parts.wpn_fps_upg_m_poly then
					self.parts.wpn_fps_upg_m_poly.stats.spread = 3
					self.parts.wpn_fps_upg_m_poly.stats.recoil = -2
					self.parts.wpn_fps_upg_m_poly.stats.concealment = -3
					self.parts.wpn_fps_upg_m_poly.stats.reload = 0
					self.wpn_fps_smg_x_olympic.override.wpn_fps_upg_m_poly = {override_weapon = {_meta = "override_weapon",CLIP_AMMO_MAX = 60},stats = {spread = 3,recoil = -2,concealment = -3,reload = nil}}
				end
				if self.parts.wpn_fps_upg_m_hksteel then
					self.parts.wpn_fps_upg_m_hksteel.stats.extra_ammo = 1
					self.parts.wpn_fps_upg_m_hksteel.stats.spread = 1
					self.parts.wpn_fps_upg_m_hksteel.stats.recoil = 0
					self.parts.wpn_fps_upg_m_hksteel.stats.concealment = -2
					self.parts.wpn_fps_upg_m_hksteel.stats.reload = 0
					self.wpn_fps_ass_amcar.override.wpn_fps_upg_m_hksteel = {override_weapon = {_meta = "override_weapon",CLIP_AMMO_MAX = 32},stats = {spread = 1,recoil = nil,concealment = -2,reload = nil}}
					self.wpn_fps_smg_olympic.override.wpn_fps_upg_m_hksteel = {override_weapon = {_meta = "override_weapon",CLIP_AMMO_MAX = 32},stats = {spread = 1,recoil = nil,concealment = -2,reload = nil}}
					self.wpn_fps_smg_x_olympic.override.wpn_fps_upg_m_hksteel = {override_weapon = {_meta = "override_weapon",CLIP_AMMO_MAX = 64},stats = {spread = 1,recoil = nil,concealment = -2,reload = nil}}
				end
				if self.parts.wpn_fps_upg_m_lanc then
					self.parts.wpn_fps_upg_m_lanc.stats.spread = 1
					self.parts.wpn_fps_upg_m_lanc.stats.recoil = 0
					self.parts.wpn_fps_upg_m_lanc.stats.concealment = 1
					self.parts.wpn_fps_upg_m_lanc.stats.reload = 0
					self.wpn_fps_smg_x_olympic.override.wpn_fps_upg_m_lanc = {override_weapon = {_meta = "override_weapon",CLIP_AMMO_MAX = 60},stats = {spread = 1,recoil = nil,concealment = 1,reload = nil}}
				end
				if self.parts.wpn_fps_upg_m_dmmag then
					self.parts.wpn_fps_upg_m_dmmag.stats.spread = -1
					self.parts.wpn_fps_upg_m_dmmag.stats.recoil = 0
					self.parts.wpn_fps_upg_m_dmmag.stats.concealment = -1
					self.parts.wpn_fps_upg_m_dmmag.stats.reload = 2
					self.wpn_fps_smg_x_olympic.override.wpn_fps_upg_m_dmmag = {override_weapon = {_meta = "override_weapon",CLIP_AMMO_MAX = 64},stats = {spread = -1,recoil = nil,concealment = -1,reload = 2}}
				end
				if self.parts.wpn_fps_upg_m_gen2 then
					self.parts.wpn_fps_upg_m_gen2.stats.spread = 1
					self.parts.wpn_fps_upg_m_gen2.stats.recoil = 1
					self.parts.wpn_fps_upg_m_gen2.stats.concealment = -3
					self.parts.wpn_fps_upg_m_gen2.stats.reload = 0
					self.wpn_fps_smg_x_olympic.override.wpn_fps_upg_m_gen2 = {override_weapon = {_meta = "override_weapon",CLIP_AMMO_MAX = 60},stats = {spread = 1,recoil = 1,concealment = -3,reload = nil}}
				end
				if self.parts.wpn_fps_upg_m_plum then
					self.parts.wpn_fps_upg_m_plum.stats.spread = 1
					self.parts.wpn_fps_upg_m_plum.stats.recoil = 1
					self.parts.wpn_fps_upg_m_plum.stats.concealment = -1
					self.parts.wpn_fps_upg_m_plum.stats.reload = 0
				end
				if self.parts.wpn_fps_upg_m_10rs then
					self.parts.wpn_fps_upg_m_10rs.stats.spread = 2
					self.parts.wpn_fps_upg_m_10rs.stats.recoil = -3
					self.parts.wpn_fps_upg_m_10rs.stats.concealment = 3
					self.parts.wpn_fps_upg_m_10rs.stats.reload = 9
				end
				if self.parts.wpn_fps_upg_m_45r then
					self.parts.wpn_fps_upg_m_45r.stats.spread = -2
					self.parts.wpn_fps_upg_m_45r.stats.recoil = 2
					self.parts.wpn_fps_upg_m_45r.stats.concealment = -3
					self.parts.wpn_fps_upg_m_45r.stats.reload = -3
				end
				if self.parts.wpn_fps_upg_m_rpk45 then
					self.parts.wpn_fps_upg_m_rpk45.stats.spread = -1
					self.parts.wpn_fps_upg_m_rpk45.stats.recoil = 1
					self.parts.wpn_fps_upg_m_rpk45.stats.concealment = -3
					self.parts.wpn_fps_upg_m_rpk45.stats.reload = -3
				end
				if self.parts.wpn_fps_upg_m_545pmag then
					self.parts.wpn_fps_upg_m_545pmag.stats.spread = 0
					self.parts.wpn_fps_upg_m_545pmag.stats.recoil = 1
					self.parts.wpn_fps_upg_m_545pmag.stats.concealment = -1
					self.parts.wpn_fps_upg_m_545pmag.stats.reload = 1
				end
				if self.parts.wpn_fps_upg_m_rpkd then
					self.parts.wpn_fps_upg_m_rpkd.stats.spread = -4
					self.parts.wpn_fps_upg_m_rpkd.stats.recoil = 5
					self.parts.wpn_fps_upg_m_rpkd.stats.concealment = -7
					self.parts.wpn_fps_upg_m_rpkd.stats.reload = -8
				end
				if self.parts.wpn_fps_upg_m_6l10 then
					self.parts.wpn_fps_upg_m_6l10.stats.spread = 1
					self.parts.wpn_fps_upg_m_6l10.stats.recoil = 0
					self.parts.wpn_fps_upg_m_6l10.stats.concealment = -1
					self.parts.wpn_fps_upg_m_6l10.stats.reload = 1
					table.insert(self.parts.wpn_fps_upg_m_6l10.weapons, "wpn_fps_ass_akm_gold")
				end
				if self.parts.wpn_fps_upg_m_103 then
					self.parts.wpn_fps_upg_m_103.stats.spread = 0
					self.parts.wpn_fps_upg_m_103.stats.recoil = 1
					self.parts.wpn_fps_upg_m_103.stats.concealment = 0
					self.parts.wpn_fps_upg_m_103.stats.reload = 1
					table.insert(self.parts.wpn_fps_upg_m_103.weapons, "wpn_fps_ass_akm_gold")
				end
				if self.parts.wpn_fps_upg_m_762pmag then
					self.parts.wpn_fps_upg_m_762pmag.stats.spread = 0
					self.parts.wpn_fps_upg_m_762pmag.stats.recoil = 1
					self.parts.wpn_fps_upg_m_762pmag.stats.concealment = -1
					self.parts.wpn_fps_upg_m_762pmag.stats.reload = 2
					table.insert(self.parts.wpn_fps_upg_m_762pmag.weapons, "wpn_fps_ass_akm_gold")
				end
				if self.parts.wpn_fps_upg_m_palm then
					self.parts.wpn_fps_upg_m_palm.stats.spread = 0
					self.parts.wpn_fps_upg_m_palm.stats.recoil = -1
					self.parts.wpn_fps_upg_m_palm.stats.concealment = 0
					self.parts.wpn_fps_upg_m_palm.stats.reload = 3
					table.insert(self.parts.wpn_fps_upg_m_palm.weapons, "wpn_fps_ass_akm_gold")
				end
				if self.parts.wpn_fps_upg_m_promagd then
					self.parts.wpn_fps_upg_m_promagd.stats.spread = -3
					self.parts.wpn_fps_upg_m_promagd.stats.recoil = 4
					self.parts.wpn_fps_upg_m_promagd.stats.concealment = -6
					self.parts.wpn_fps_upg_m_promagd.stats.reload = -6
					table.insert(self.parts.wpn_fps_upg_m_promagd.weapons, "wpn_fps_ass_akm_gold")
				end
				if self.parts.wpn_fps_upg_m_762rpk75 then
					self.parts.wpn_fps_upg_m_762rpk75.stats.spread = -3
					self.parts.wpn_fps_upg_m_762rpk75.stats.recoil = 4
					self.parts.wpn_fps_upg_m_762rpk75.stats.concealment = -6
					self.parts.wpn_fps_upg_m_762rpk75.stats.reload = -6
					table.insert(self.parts.wpn_fps_upg_m_762rpk75.weapons, "wpn_fps_ass_akm_gold")
				end
				if self.parts.wpn_fps_upg_m_rpk40 then
					self.parts.wpn_fps_upg_m_rpk40.stats.spread = -1
					self.parts.wpn_fps_upg_m_rpk40.stats.recoil = 1
					self.parts.wpn_fps_upg_m_rpk40.stats.concealment = -3
					self.parts.wpn_fps_upg_m_rpk40.stats.reload = -3
					table.insert(self.parts.wpn_fps_upg_m_rpk40.weapons, "wpn_fps_ass_akm_gold")
				end
				if self.parts.wpn_fps_upg_m_rpkbake then
					self.parts.wpn_fps_upg_m_rpkbake.stats.spread = -2
					self.parts.wpn_fps_upg_m_rpkbake.stats.recoil = 2
					self.parts.wpn_fps_upg_m_rpkbake.stats.concealment = -3
					self.parts.wpn_fps_upg_m_rpkbake.stats.reload = -3
					table.insert(self.parts.wpn_fps_upg_m_rpkbake.weapons, "wpn_fps_ass_akm_gold")
				end
				if self.parts.wpn_fps_upg_m_x47 then
					self.parts.wpn_fps_upg_m_x47.stats.spread = -2
					self.parts.wpn_fps_upg_m_x47.stats.recoil = 3
					self.parts.wpn_fps_upg_m_x47.stats.concealment = -3
					self.parts.wpn_fps_upg_m_x47.stats.reload = -5
					table.insert(self.parts.wpn_fps_upg_m_x47.weapons, "wpn_fps_ass_akm_gold")
				end
				if self.parts.wpn_fps_upg_m_308pmag then
					self.parts.wpn_fps_upg_m_308pmag.stats.spread = 0
					self.parts.wpn_fps_upg_m_308pmag.stats.recoil = 0
					self.parts.wpn_fps_upg_m_308pmag.stats.concealment = 1
					self.parts.wpn_fps_upg_m_308pmag.stats.reload = 0
				end
				if self.parts.wpn_fps_upg_m_kac10 then
					self.parts.wpn_fps_upg_m_kac10.stats.spread = 2
					self.parts.wpn_fps_upg_m_kac10.stats.recoil = -1
					self.parts.wpn_fps_upg_m_kac10.stats.concealment = 2
					self.parts.wpn_fps_upg_m_kac10.stats.reload = 8
				end
				if self.parts.wpn_fps_upg_m_308dmmag then
					self.parts.wpn_fps_upg_m_308dmmag.override_weapon.AMMO_MAX = 60
					self.parts.wpn_fps_upg_m_308dmmag.override_weapon.CLIP_AMMO_MAX = 30
					self.parts.wpn_fps_upg_m_308dmmag.stats.damage = -200
					self.parts.wpn_fps_upg_m_308dmmag.stats.spread = -3
					self.parts.wpn_fps_upg_m_308dmmag.stats.recoil = 3
					self.parts.wpn_fps_upg_m_308dmmag.stats.concealment = -5
					self.parts.wpn_fps_upg_m_308dmmag.stats.reload = -2
				end
				if self.parts.wpn_fps_upg_m_kac20 then
					self.parts.wpn_fps_upg_m_kac20.stats.spread = 1
					self.parts.wpn_fps_upg_m_kac20.stats.recoil = -1
					self.parts.wpn_fps_upg_m_kac20.stats.concealment = 1
					self.parts.wpn_fps_upg_m_kac20.stats.reload = 0
				end
				if self.parts.wpn_fps_upg_m_sgmt then
					self.parts.wpn_fps_upg_m_sgmt.stats.spread = -3
					self.parts.wpn_fps_upg_m_sgmt.stats.recoil = 3
					self.parts.wpn_fps_upg_m_sgmt.stats.concealment = -4
					self.parts.wpn_fps_upg_m_sgmt.stats.reload = -9
				end
				if self.parts.wpn_fps_upg_m_celerity then
					self.parts.wpn_fps_upg_m_celerity.stats.spread = 0
					self.parts.wpn_fps_upg_m_celerity.stats.recoil = 0
					self.parts.wpn_fps_upg_m_celerity.stats.concealment = -1
					self.parts.wpn_fps_upg_m_celerity.stats.reload = -2
				end
				if self.parts.wpn_fps_upg_m_vecsgmt then
					self.parts.wpn_fps_upg_m_vecsgmt.stats.spread = -4
					self.parts.wpn_fps_upg_m_vecsgmt.stats.recoil = 2
					self.parts.wpn_fps_upg_m_vecsgmt.stats.concealment = -3
					self.parts.wpn_fps_upg_m_vecsgmt.stats.reload = -5
				end
				if self.parts.wpn_fps_upg_m_d60boot then
					self.parts.wpn_fps_upg_m_d60boot.stats.spread = 2
					self.parts.wpn_fps_upg_m_d60boot.stats.recoil = -4
					self.parts.wpn_fps_upg_m_d60boot.stats.concealment = 2
					self.parts.wpn_fps_upg_m_d60boot.stats.reload = 5
				end
				if self.parts.wpn_fps_upg_m_mpx20 then
					self.parts.wpn_fps_upg_m_mpx20.stats.spread = 0
					self.parts.wpn_fps_upg_m_mpx20.stats.recoil = 0
					self.parts.wpn_fps_upg_m_mpx20.stats.concealment = 1
					self.parts.wpn_fps_upg_m_mpx20.stats.reload = 0
				end
				if self.parts.wpn_fps_upg_m_mpx30 then
					self.parts.wpn_fps_upg_m_mpx30.stats.spread = -1
					self.parts.wpn_fps_upg_m_mpx30.stats.recoil = 0
					self.parts.wpn_fps_upg_m_mpx30.stats.concealment = 0
					self.parts.wpn_fps_upg_m_mpx30.stats.reload = -2
				end
				if self.parts.wpn_fps_upg_m_mpxdrum then
					self.parts.wpn_fps_upg_m_mpxdrum.stats.spread = -2
					self.parts.wpn_fps_upg_m_mpxdrum.stats.recoil = 3
					self.parts.wpn_fps_upg_m_mpxdrum.stats.concealment = -4
					self.parts.wpn_fps_upg_m_mpxdrum.stats.reload = -6
				end
				if self.parts.wpn_fps_upg_m_mpxtti then
					self.parts.wpn_fps_upg_m_mpxtti.stats.spread = -1
					self.parts.wpn_fps_upg_m_mpxtti.stats.recoil = 2
					self.parts.wpn_fps_upg_m_mpxtti.stats.concealment = -3
					self.parts.wpn_fps_upg_m_mpxtti.stats.reload = -4
				end
				if self.parts.wpn_fps_upg_m_cap10 then
					self.parts.wpn_fps_upg_m_cap10.stats.spread = 4
					self.parts.wpn_fps_upg_m_cap10.stats.recoil = 2
					self.parts.wpn_fps_upg_m_cap10.stats.concealment = 1
					self.parts.wpn_fps_upg_m_cap10.stats.reload = 5
				end
				if self.parts.wpn_fps_upg_m_puf20 then
					self.parts.wpn_fps_upg_m_puf20.stats.spread = 2
					self.parts.wpn_fps_upg_m_puf20.stats.recoil = -1
					self.parts.wpn_fps_upg_m_puf20.stats.concealment = 0
					self.parts.wpn_fps_upg_m_puf20.stats.reload = 3
				end
				if self.parts.wpn_fps_upg_m_puf30 then
					self.parts.wpn_fps_upg_m_puf30.stats.spread = 1
					self.parts.wpn_fps_upg_m_puf30.stats.recoil = 0
					self.parts.wpn_fps_upg_m_puf30.stats.concealment = -2
					self.parts.wpn_fps_upg_m_puf30.stats.reload = 0
				end
				if self.parts.wpn_fps_upg_m_vityazpmag then
					self.parts.wpn_fps_upg_m_vityazpmag.stats.spread = 0
					self.parts.wpn_fps_upg_m_vityazpmag.stats.recoil = 1
					self.parts.wpn_fps_upg_m_vityazpmag.stats.concealment = 0
					self.parts.wpn_fps_upg_m_vityazpmag.stats.reload = -1
				end
				if self.parts.wpn_fps_upg_m_7drum then
					self.parts.wpn_fps_upg_m_7drum.stats.spread = -3
					self.parts.wpn_fps_upg_m_7drum.stats.recoil = 3
					self.parts.wpn_fps_upg_m_7drum.stats.concealment = -5
					self.parts.wpn_fps_upg_m_7drum.stats.reload = -7
					self.wpn_fps_smg_x_mp7.override.wpn_fps_upg_m_7drum = {stats = {spread = -3,recoil = 3,concealment = -5,reload = -7}}
					self.wpn_fps_smg_x_mp7.override.wpn_fps_upg_m_7drum.override_weapon = {_meta = "override_weapon", CLIP_AMMO_MAX = 120}
				end
				if self.parts.wpn_fps_upg_m_max then
					self.parts.wpn_fps_upg_m_max.stats.spread = -3
					self.parts.wpn_fps_upg_m_max.stats.recoil = 3
					self.parts.wpn_fps_upg_m_max.stats.concealment = -4
					self.parts.wpn_fps_upg_m_max.stats.reload = -9
					self.wpn_fps_sho_x_basset.override.wpn_fps_upg_m_max = {
						override_weapon = {
							_meta = "override_weapon",
							CLIP_AMMO_MAX = 40
						},
						stats = {
							value = 1,
							spread = -3,
							recoil = 3,
							concealment = -4,
							reload = -9
						}
						
					}
				end
				if self.parts.wpn_fps_upg_m_pro then
					self.parts.wpn_fps_upg_m_pro.stats.spread = -2
					self.parts.wpn_fps_upg_m_pro.stats.recoil = 1
					self.parts.wpn_fps_upg_m_pro.stats.concealment = -2
					self.parts.wpn_fps_upg_m_pro.stats.reload = -6
					self.wpn_fps_sho_x_basset.override.wpn_fps_upg_m_pro = {
						override_weapon = {
							_meta = "override_weapon",
							CLIP_AMMO_MAX = 26
						},
						stats = {
							spread = -2,
							recoil = 1,
							value = 1,
							concealment = -2,
							reload = -6
						}
					}
				end
				if self.parts.wpn_fps_upg_m_mk17 then
					self.parts.wpn_fps_upg_m_mk17.stats.spread = 1
					self.parts.wpn_fps_upg_m_mk17.stats.recoil = -1
					self.parts.wpn_fps_upg_m_mk17.stats.concealment = 1
					self.parts.wpn_fps_upg_m_mk17.stats.reload = 3
				end
				if self.parts.wpn_fps_upg_m_54510s then
					self.parts.wpn_fps_upg_m_54510s.stats.spread = 2
					self.parts.wpn_fps_upg_m_54510s.stats.recoil = -3
					self.parts.wpn_fps_upg_m_54510s.stats.concealment = 1
					self.parts.wpn_fps_upg_m_54510s.stats.reload = 14
				end
				if self.parts.wpn_fps_upg_m_54520 then
					self.parts.wpn_fps_upg_m_54520.stats.spread = 2
					self.parts.wpn_fps_upg_m_54520.stats.recoil = -1
					self.parts.wpn_fps_upg_m_54520.stats.concealment = 1
					self.parts.wpn_fps_upg_m_54520.stats.reload = 6
				end
				if self.parts.wpn_fps_upg_m_54520d then
					self.parts.wpn_fps_upg_m_54520d.stats.spread = 2
					self.parts.wpn_fps_upg_m_54520d.stats.recoil = -1
					self.parts.wpn_fps_upg_m_54520d.stats.concealment = -1
					self.parts.wpn_fps_upg_m_54520d.stats.reload = 4
					self.parts.wpn_fps_upg_m_54520d.override_weapon_add = nil
					self.parts.wpn_fps_upg_m_54520d.override_weapon_add = {AMMO_MAX = 20}
				end		
				if self.parts.wpn_fps_upg_m_54520s then
					self.parts.wpn_fps_upg_m_54520s.stats.spread = 2
					self.parts.wpn_fps_upg_m_54520s.stats.recoil = -1
					self.parts.wpn_fps_upg_m_54520s.stats.concealment = 0
					self.parts.wpn_fps_upg_m_54520s.stats.reload = 8
				end
				if self.parts.wpn_fps_upg_m_54530d then
					self.parts.wpn_fps_upg_m_54530d.stats.spread = -2
					self.parts.wpn_fps_upg_m_54530d.stats.recoil = 3
					self.parts.wpn_fps_upg_m_54530d.stats.concealment = -4
					self.parts.wpn_fps_upg_m_54530d.stats.reload = 0
					self.parts.wpn_fps_upg_m_54530d.override_weapon_add = nil
					self.parts.wpn_fps_upg_m_54530d.override_weapon_add = {AMMO_MAX = 30}
				end
				if self.parts.wpn_fps_upg_m_54530s then
					self.parts.wpn_fps_upg_m_54530s.stats.spread = -1
					self.parts.wpn_fps_upg_m_54530s.stats.recoil = -1
					self.parts.wpn_fps_upg_m_54530s.stats.concealment = 0
					self.parts.wpn_fps_upg_m_54530s.stats.reload = 6
				end
				if self.parts.wpn_fps_upg_m_fmgdrum then
					self.parts.wpn_fps_upg_m_fmgdrum.stats.spread = -2
					self.parts.wpn_fps_upg_m_fmgdrum.stats.recoil = 2
					self.parts.wpn_fps_upg_m_fmgdrum.stats.concealment = -3
					self.parts.wpn_fps_upg_m_fmgdrum.stats.reload = -4
				end
				if self.parts.wpn_fps_upg_m_g36_dura then
					self.parts.wpn_fps_upg_m_g36_dura.stats.extra_ammo = 2
					self.parts.wpn_fps_upg_m_g36_dura.stats.spread = 0
					self.parts.wpn_fps_upg_m_g36_dura.stats.recoil = 1
					self.parts.wpn_fps_upg_m_g36_dura.stats.concealment = -1
					self.parts.wpn_fps_upg_m_g36_dura.stats.reload = -1
				end
				if self.parts.wpn_fps_upg_m_g36_d60 then
					self.parts.wpn_fps_upg_m_g36_d60.stats.spread = -2
					self.parts.wpn_fps_upg_m_g36_d60.stats.recoil = 3
					self.parts.wpn_fps_upg_m_g36_d60.stats.concealment = -4
					self.parts.wpn_fps_upg_m_g36_d60.stats.reload = -6
				end
				if self.parts.wpn_fps_upg_m_g36_p30 then
					self.parts.wpn_fps_upg_m_g36_p30.stats.spread = 1
					self.parts.wpn_fps_upg_m_g36_p30.stats.recoil = 1
					self.parts.wpn_fps_upg_m_g36_p30.stats.concealment = -3
					self.parts.wpn_fps_upg_m_g36_p30.stats.reload = 0
				end
				if self.parts.wpn_fps_upg_m_g36_p30w then
					self.parts.wpn_fps_upg_m_g36_p30w.stats.spread = 2
					self.parts.wpn_fps_upg_m_g36_p30w.stats.recoil = -1
					self.parts.wpn_fps_upg_m_g36_p30w.stats.concealment = -2
					self.parts.wpn_fps_upg_m_g36_p30w.stats.reload = 0
				end
				if self.parts.wpn_fps_upg_m_g36_p40 then
					self.parts.wpn_fps_upg_m_g36_p40.stats.spread = -1
					self.parts.wpn_fps_upg_m_g36_p40.stats.recoil = 1
					self.parts.wpn_fps_upg_m_g36_p40.stats.concealment = -3
					self.parts.wpn_fps_upg_m_g36_p40.stats.reload = -4
				end
				if self.parts.wpn_fps_upg_m_g36_battle then
					self.parts.wpn_fps_upg_m_g36_battle.stats.spread = 0
					self.parts.wpn_fps_upg_m_g36_battle.stats.recoil = 0
					self.parts.wpn_fps_upg_m_g36_battle.stats.concealment = 2
					self.parts.wpn_fps_upg_m_g36_battle.stats.reload = 0
				end
				if self.parts.wpn_fps_upg_m_g36_poly then
					self.parts.wpn_fps_upg_m_g36_poly.stats.spread = 3
					self.parts.wpn_fps_upg_m_g36_poly.stats.recoil = -2
					self.parts.wpn_fps_upg_m_g36_poly.stats.concealment = -3
					self.parts.wpn_fps_upg_m_g36_poly.stats.reload = 0
				end
				if self.parts.wpn_fps_upg_m_g36_hksteel then
					self.parts.wpn_fps_upg_m_g36_hksteel.stats.extra_ammo = 1
					self.parts.wpn_fps_upg_m_g36_hksteel.stats.spread = 1
					self.parts.wpn_fps_upg_m_g36_hksteel.stats.recoil = 0
					self.parts.wpn_fps_upg_m_g36_hksteel.stats.concealment = -2
					self.parts.wpn_fps_upg_m_g36_hksteel.stats.reload = 0
				end
				if self.parts.wpn_fps_upg_m_g36_gen2 then
					self.parts.wpn_fps_upg_m_g36_gen2.stats.spread = 1
					self.parts.wpn_fps_upg_m_g36_gen2.stats.recoil = 1
					self.parts.wpn_fps_upg_m_g36_gen2.stats.concealment = -3
					self.parts.wpn_fps_upg_m_g36_gen2.stats.reload = 0
				end
				if self.parts.wpn_fps_upg_m_g36_lanc then
					self.parts.wpn_fps_upg_m_g36_lanc.stats.spread = 1
					self.parts.wpn_fps_upg_m_g36_lanc.stats.recoil = 0
					self.parts.wpn_fps_upg_m_g36_lanc.stats.concealment = 1
					self.parts.wpn_fps_upg_m_g36_lanc.stats.reload = 0
				end
				if self.parts.wpn_fps_upg_m_g36_dmmag then
					self.parts.wpn_fps_upg_m_g36_dmmag.stats.spread = -1
					self.parts.wpn_fps_upg_m_g36_dmmag.stats.recoil = 0
					self.parts.wpn_fps_upg_m_g36_dmmag.stats.concealment = -1
					self.parts.wpn_fps_upg_m_g36_dmmag.stats.reload = 2
				end
			end
			
			FrenchyAU_supressors()
			FrenchyAU_muzzle_devices()
			FrenchyAU_gadgets()
			FrenchyAU_pistol_gadgets()
			FrenchyAU_foregrips()
			FrenchyAU_hand_grips()
			FrenchyAU_barrels()
			FrenchyAU_stocks()
			FrenchyAU_mags()
			
		end
		FrenchyAU_packs_stat_adjustments()
		
	end
	customWeaponMods()
	
	-- all accuracy adjusting mods adjust moving acc in the same way to make shooting while moving feel the same
	for part, tbl in pairs(self.parts) do
		if tbl and tbl.stats and (tbl.stats.spread or tbl.stats.spread_moving) then
			if tbl.stats.spread then
				self.parts[part].stats.spread_moving = self.parts[part].stats.spread
			else
				self.parts[part].stats.spread_moving = nil
			end
		end
	end
	
end)