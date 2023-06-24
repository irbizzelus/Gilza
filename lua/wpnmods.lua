-- changes to all weapon mods and addition of some new ones

Hooks:PostHook(WeaponFactoryTweakData, "init", "newwpnparts_breachround_andAP", function(self, params, ...)
	self.parts.wpn_fps_upg_br_shtgn.name_id = "bm_wpn_fps_upg_br_shtgn"
	self.parts.wpn_fps_upg_br_shtgn.desc_id = "bm_wpn_fps_upg_br_shtgn_desc"
	self.parts.wpn_fps_upg_br_shtgn.forbids = {"wpn_fps_sho_m590_b_suppressor", "wpn_fps_upg_ns_shot_thick", "wpn_fps_upg_ns_sho_salvo_large"}
	self.parts.wpn_fps_upg_br_shtgn.stats = {
		value = 0,
		damage = -145,
		spread = -23,
		spread_moving = -23,
	}
	self.parts.wpn_fps_upg_br_shtgn.custom_stats = {
		damage_near_mul = 0,
		damage_far_mul = 0,
		armor_piercing_add = 1,
		can_shoot_through_shield = true,
		can_shoot_through_wall = true,
		can_breach = true,
	}
	
	self.parts.wpn_fps_upg_ar_ap_rounds.name_id = "bm_wpn_fps_upg_ar_ap_rounds"
	self.parts.wpn_fps_upg_ar_ap_rounds.desc_id = "bm_wpn_fps_upg_ar_ap_rounds_desc"
	self.parts.wpn_fps_upg_ar_ap_rounds.stats = {
		value = 0,
		spread = -5,
		spread_moving = -5,
		recoil = -4
	}
	self.parts.wpn_fps_upg_ar_ap_rounds.custom_stats = {
		armor_piercing_add = 1,
		can_shoot_through_shield = true,
		can_shoot_through_wall = true,
		ammo_pickup_max_mul = 0.75,
		ammo_pickup_min_mul = 0.75,
	}
	
	-- p90 AP rounds
	self.parts.wpn_fps_upg_smg_ap_rounds.name_id = "bm_wpn_fps_upg_smg_ap_rounds"
	self.parts.wpn_fps_upg_smg_ap_rounds.desc_id = "bm_wpn_fps_upg_smg_ap_rounds_desc"
	self.parts.wpn_fps_upg_smg_ap_rounds.stats = {
		value = 0,
		total_ammo_mod = -5,
		spread = -6,
		damage = 15,
		spread_moving = -6,
		recoil = -2
	}
	self.parts.wpn_fps_upg_smg_ap_rounds.custom_stats = {
		can_shoot_through_shield = true,
		armor_piercing_add = 1,
		ammo_pickup_max_mul = 0.5,
		ammo_pickup_min_mul = 0.5,
	}
	
	-- mateba 357 ap
	self.parts.wpn_fps_upg_pist_ap_rounds.name_id = "bm_wpn_fps_upg_pist_ap_rounds"
	self.parts.wpn_fps_upg_pist_ap_rounds.desc_id = "bm_wpn_fps_upg_pist_ap_rounds_desc"
	self.parts.wpn_fps_upg_pist_ap_rounds.stats = {
		value = 0,
		total_ammo_mod = -8,
		spread = -3,
		spread_moving = -3,
		recoil = -3
	}
	self.parts.wpn_fps_upg_pist_ap_rounds.custom_stats = {
		can_shoot_through_shield = true,
		armor_piercing_add = 1,
		ammo_pickup_max_mul = 0.5,
		ammo_pickup_min_mul = 0.5,
	}
	
	-- little friend 762's 556 conversion kit
	self.parts.wpn_fps_upg_762_to_556_kit.name_id = "bm_wpn_fps_upg_762_to_556_kit"
	self.parts.wpn_fps_upg_762_to_556_kit.desc_id = "bm_wpn_fps_upg_762_to_556_kit_desc"
	self.parts.wpn_fps_upg_762_to_556_kit.stats = {
		value = 0,
		total_ammo_mod = 8,
		extra_ammo = 5,
		damage = -243,
		spread = -2,
		recoil = -4
	}
	self.parts.wpn_fps_upg_762_to_556_kit.custom_stats = {
		ammo_pickup_min_mul = 4.52,
		ammo_pickup_max_mul = 3.05
	}
	-- m4 210 damage profile kit
	self.parts.wpn_fps_upg_m4_hp_rounds.name_id = "wpn_fps_upg_m4_hp_rounds"
	self.parts.wpn_fps_upg_m4_hp_rounds.desc_id = "wpn_fps_upg_m4_hp_rounds_desc"
	self.parts.wpn_fps_upg_m4_hp_rounds.stats = {
		value = 0,
		damage = 33,
		spread = -3,
		recoil = -3
	}
	self.parts.wpn_fps_upg_m4_hp_rounds.custom_stats = {
		ammo_pickup_min_mul = 0.756,
		ammo_pickup_max_mul = 0.836
	}
	
	-- FrenchyAU's tacticool packs
	local function FrenchyAU_packs_stat_adjustments()
		-- Supressors
		
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
				self.parts[frenchyAU_supressors_BIG_acc[i]].stats.recoil = 1
				self.parts[frenchyAU_supressors_BIG_acc[i]].stats.spread = 3
				self.parts[frenchyAU_supressors_BIG_acc[i]].stats.damage = -6
				self.parts[frenchyAU_supressors_BIG_acc[i]].stats.concealment = -5
			end
		end
		for i=1, #frenchyAU_supressors_BIG_stab do
			if self.parts[frenchyAU_supressors_BIG_stab[i]] then
				self.parts[frenchyAU_supressors_BIG_stab[i]].stats.recoil = 3
				self.parts[frenchyAU_supressors_BIG_stab[i]].stats.spread = 1
				self.parts[frenchyAU_supressors_BIG_stab[i]].stats.damage = -1
				self.parts[frenchyAU_supressors_BIG_stab[i]].stats.concealment = -5
			end
		end
		for i=1, #frenchyAU_supressors_BIG_avg do
			if self.parts[frenchyAU_supressors_BIG_avg[i]] then
				self.parts[frenchyAU_supressors_BIG_avg[i]].stats.recoil = 2
				self.parts[frenchyAU_supressors_BIG_avg[i]].stats.spread = 2
				self.parts[frenchyAU_supressors_BIG_avg[i]].stats.damage = -4
				self.parts[frenchyAU_supressors_BIG_avg[i]].stats.concealment = -5
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
				self.parts[frenchyAU_supressors_AVERAGE_acc[i]].stats.recoil = 1
				self.parts[frenchyAU_supressors_AVERAGE_acc[i]].stats.spread = 2
				self.parts[frenchyAU_supressors_AVERAGE_acc[i]].stats.damage = -5
				self.parts[frenchyAU_supressors_AVERAGE_acc[i]].stats.concealment = -3
			end
		end
		for i=1, #frenchyAU_supressors_AVERAGE_stab do
			if self.parts[frenchyAU_supressors_AVERAGE_stab[i]] then
				self.parts[frenchyAU_supressors_AVERAGE_stab[i]].stats.recoil = 3
				self.parts[frenchyAU_supressors_AVERAGE_stab[i]].stats.spread = 0
				self.parts[frenchyAU_supressors_AVERAGE_stab[i]].stats.damage = -1
				self.parts[frenchyAU_supressors_AVERAGE_stab[i]].stats.concealment = -3
			end
		end
		for i=1, #frenchyAU_supressors_AVERAGE_avg do
			if self.parts[frenchyAU_supressors_AVERAGE_avg[i]] then
				self.parts[frenchyAU_supressors_AVERAGE_avg[i]].stats.recoil = 2
				self.parts[frenchyAU_supressors_AVERAGE_avg[i]].stats.spread = 1
				self.parts[frenchyAU_supressors_AVERAGE_avg[i]].stats.damage = -3
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
				self.parts[frenchyAU_supressors_COMAPCT_acc[i]].stats.damage = -6
				self.parts[frenchyAU_supressors_COMAPCT_acc[i]].stats.concealment = -1
			end
		end
		for i=1, #frenchyAU_supressors_COMAPCT_stab do
			if self.parts[frenchyAU_supressors_COMAPCT_stab[i]] then
				self.parts[frenchyAU_supressors_COMAPCT_stab[i]].stats.recoil = 2
				self.parts[frenchyAU_supressors_COMAPCT_stab[i]].stats.spread = -2
				self.parts[frenchyAU_supressors_COMAPCT_stab[i]].stats.damage = -2
				self.parts[frenchyAU_supressors_COMAPCT_stab[i]].stats.concealment = -1
			end
		end
		for i=1, #frenchyAU_supressors_COMAPCT_avg do
			if self.parts[frenchyAU_supressors_COMAPCT_avg[i]] then
				self.parts[frenchyAU_supressors_COMAPCT_avg[i]].stats.recoil = 1
				self.parts[frenchyAU_supressors_COMAPCT_avg[i]].stats.spread = 1
				self.parts[frenchyAU_supressors_COMAPCT_avg[i]].stats.damage = -4
				self.parts[frenchyAU_supressors_COMAPCT_avg[i]].stats.concealment = -1
			end
		end
		-- why the fuck is this even a thing
		if self.parts.wpn_fps_ass_ns_g_bacon then
			self.parts.wpn_fps_ass_ns_g_bacon.stats.recoil = 9
			self.parts.wpn_fps_ass_ns_g_bacon.stats.spread = 2
			self.parts.wpn_fps_ass_ns_g_bacon.stats.damage = -42
			self.parts.wpn_fps_ass_ns_g_bacon.stats.concealment = -29
		end
		
		-- Muzzle devices
		if self.parts.wpn_fps_ass_ns_g_pws then
			self.parts.wpn_fps_ass_ns_g_pws.stats.recoil = 3
			self.parts.wpn_fps_ass_ns_g_pws.stats.spread = 0
			self.parts.wpn_fps_ass_ns_g_pws.stats.damage = 0
			self.parts.wpn_fps_ass_ns_g_pws.stats.concealment = 0
			self.parts.wpn_fps_ass_ns_g_pws.stats.suppression = -10
		end
		if self.parts.wpn_fps_ass_ns_g_bulletec then
			self.parts.wpn_fps_ass_ns_g_bulletec.stats.recoil = -1
			self.parts.wpn_fps_ass_ns_g_bulletec.stats.spread = 3
			self.parts.wpn_fps_ass_ns_g_bulletec.stats.damage = 0
			self.parts.wpn_fps_ass_ns_g_bulletec.stats.concealment = -2
			self.parts.wpn_fps_ass_ns_g_bulletec.stats.suppression = 0
		end
		if self.parts.wpn_fps_ass_ns_g_heart then
			self.parts.wpn_fps_ass_ns_g_heart.stats.recoil = 2
			self.parts.wpn_fps_ass_ns_g_heart.stats.spread = 2
			self.parts.wpn_fps_ass_ns_g_heart.stats.damage = -1
			self.parts.wpn_fps_ass_ns_g_heart.stats.concealment = 0
			self.parts.wpn_fps_ass_ns_g_heart.stats.suppression = 0
		end
		if self.parts.wpn_fps_ass_ns_g_traptor then
			self.parts.wpn_fps_ass_ns_g_traptor.stats.recoil = 3
			self.parts.wpn_fps_ass_ns_g_traptor.stats.spread = 3
			self.parts.wpn_fps_ass_ns_g_traptor.stats.damage = -10
			self.parts.wpn_fps_ass_ns_g_traptor.stats.concealment = -4
			self.parts.wpn_fps_ass_ns_g_traptor.stats.suppression = 0
		end
		if self.parts.wpn_fps_ass_ns_g_bmd then
			self.parts.wpn_fps_ass_ns_g_bmd.stats.recoil = 5
			self.parts.wpn_fps_ass_ns_g_bmd.stats.spread = -2
			self.parts.wpn_fps_ass_ns_g_bmd.stats.damage = 0
			self.parts.wpn_fps_ass_ns_g_bmd.stats.concealment = -4
			self.parts.wpn_fps_ass_ns_g_bmd.stats.suppression = -10
		end
		if self.parts.wpn_fps_ass_ns_g_sf3p then
			self.parts.wpn_fps_ass_ns_g_sf3p.stats.recoil = -2
			self.parts.wpn_fps_ass_ns_g_sf3p.stats.spread = 4
			self.parts.wpn_fps_ass_ns_g_sf3p.stats.damage = 0
			self.parts.wpn_fps_ass_ns_g_sf3p.stats.concealment = -1
			self.parts.wpn_fps_ass_ns_g_sf3p.stats.suppression = 0
		end
		if self.parts.wpn_fps_ass_ns_g_slr then
			self.parts.wpn_fps_ass_ns_g_slr.stats.recoil = 4
			self.parts.wpn_fps_ass_ns_g_slr.stats.spread = -1
			self.parts.wpn_fps_ass_ns_g_slr.stats.damage = 2
			self.parts.wpn_fps_ass_ns_g_slr.stats.concealment = -1
			self.parts.wpn_fps_ass_ns_g_slr.stats.suppression = 0
		end
		if self.parts.wpn_fps_ass_ns_g_dmnoz then
			self.parts.wpn_fps_ass_ns_g_dmnoz.stats.recoil = 2
			self.parts.wpn_fps_ass_ns_g_dmnoz.stats.spread = 1
			self.parts.wpn_fps_ass_ns_g_dmnoz.stats.damage = 0
			self.parts.wpn_fps_ass_ns_g_dmnoz.stats.concealment = 1
			self.parts.wpn_fps_ass_ns_g_dmnoz.stats.suppression = 0
		end
		
		-- Gadgets
		if self.parts.wpn_fps_upg_fl_peq2 then
			self.parts.wpn_fps_upg_fl_peq2.stats.recoil = 0
			self.parts.wpn_fps_upg_fl_peq2.stats.spread = 1
			self.parts.wpn_fps_upg_fl_peq2.stats.concealment = -1
		end
		if self.parts.wpn_fps_upg_fl_dbal then
			self.parts.wpn_fps_upg_fl_dbal.stats.recoil = 1
			self.parts.wpn_fps_upg_fl_dbal.stats.spread = 0
			self.parts.wpn_fps_upg_fl_dbal.stats.concealment = -1
		end
		if self.parts.wpn_fps_upg_fl_holo then
			self.parts.wpn_fps_upg_fl_holo.stats.recoil = 0
			self.parts.wpn_fps_upg_fl_holo.stats.spread = 1
			self.parts.wpn_fps_upg_fl_holo.stats.concealment = -1
		end
		if self.parts.wpn_fps_upg_fl_ncs then
			self.parts.wpn_fps_upg_fl_ncs.stats.recoil = -1
			self.parts.wpn_fps_upg_fl_ncs.stats.spread = 1
			self.parts.wpn_fps_upg_fl_ncs.stats.concealment = 0
		end
		if self.parts.wpn_fps_upg_fl_peq15 then
			self.parts.wpn_fps_upg_fl_peq15.stats.recoil = 0
			self.parts.wpn_fps_upg_fl_peq15.stats.spread = 2
			self.parts.wpn_fps_upg_fl_peq15.stats.concealment = -5
		end
		if self.parts.wpn_fps_upg_fl_2irs then
			self.parts.wpn_fps_upg_fl_2irs.stats.recoil = 1
			self.parts.wpn_fps_upg_fl_2irs.stats.spread = 0
			self.parts.wpn_fps_upg_fl_2irs.stats.concealment = -1
		end
		if self.parts.wpn_fps_upg_fl_mawl then
			self.parts.wpn_fps_upg_fl_mawl.stats.recoil = 1
			self.parts.wpn_fps_upg_fl_mawl.stats.spread = 1
			self.parts.wpn_fps_upg_fl_mawl.stats.concealment = -3
		end
		if self.parts.wpn_fps_upg_fl_pers then
			self.parts.wpn_fps_upg_fl_pers.stats.recoil = 2
			self.parts.wpn_fps_upg_fl_pers.stats.spread = 1
			self.parts.wpn_fps_upg_fl_pers.stats.concealment = -5
		end
		if self.parts.wpn_fps_upg_fl_x400 then
			self.parts.wpn_fps_upg_fl_x400.stats.recoil = 0
			self.parts.wpn_fps_upg_fl_x400.stats.spread = 0
			self.parts.wpn_fps_upg_fl_x400.stats.concealment = 0
		end
		if self.parts.wpn_fps_upg_fl_la5 then
			self.parts.wpn_fps_upg_fl_la5.stats.recoil = 1
			self.parts.wpn_fps_upg_fl_la5.stats.spread = 1
			self.parts.wpn_fps_upg_fl_la5.stats.concealment = -3
		end
		if self.parts.wpn_fps_upg_fl_kleh then
			self.parts.wpn_fps_upg_fl_kleh.stats.recoil = 3
			self.parts.wpn_fps_upg_fl_kleh.stats.spread = 0
			self.parts.wpn_fps_upg_fl_kleh.stats.concealment = -4
		end
		if self.parts.wpn_fps_upg_fl_las then
			self.parts.wpn_fps_upg_fl_las.stats.recoil = 1
			self.parts.wpn_fps_upg_fl_las.stats.spread = 0
			self.parts.wpn_fps_upg_fl_las.stats.concealment = 0
		end
		-- Pistol gadgets
		if self.parts.wpn_fps_upg_fl_pis_ncs then
			self.parts.wpn_fps_upg_fl_pis_ncs.stats.recoil = 0
			self.parts.wpn_fps_upg_fl_pis_ncs.stats.spread = 1
			self.parts.wpn_fps_upg_fl_pis_ncs.stats.concealment = -1
		end
		if self.parts.wpn_fps_upg_fl_pis_dbal then
			self.parts.wpn_fps_upg_fl_pis_dbal.stats.recoil = 0
			self.parts.wpn_fps_upg_fl_pis_dbal.stats.spread = 1
			self.parts.wpn_fps_upg_fl_pis_dbal.stats.concealment = -2
		end
		if self.parts.wpn_fps_upg_fl_pis_gl21 then
			self.parts.wpn_fps_upg_fl_pis_gl21.stats.recoil = 1
			self.parts.wpn_fps_upg_fl_pis_gl21.stats.spread = 0
			self.parts.wpn_fps_upg_fl_pis_gl21.stats.concealment = -2
		end
		if self.parts.wpn_fps_upg_fl_pis_xc1 then
			self.parts.wpn_fps_upg_fl_pis_xc1.stats.recoil = 0
			self.parts.wpn_fps_upg_fl_pis_xc1.stats.spread = 0
			self.parts.wpn_fps_upg_fl_pis_xc1.stats.concealment = -1
		end
		if self.parts.wpn_fps_upg_fl_pis_2irs then
			self.parts.wpn_fps_upg_fl_pis_2irs.stats.recoil = 0
			self.parts.wpn_fps_upg_fl_pis_2irs.stats.spread = 1
			self.parts.wpn_fps_upg_fl_pis_2irs.stats.concealment = -2
		end
		if self.parts.wpn_fps_upg_fl_pis_las then
			self.parts.wpn_fps_upg_fl_pis_las.stats.recoil = 0
			self.parts.wpn_fps_upg_fl_pis_las.stats.spread = 0
			self.parts.wpn_fps_upg_fl_pis_las.stats.concealment = 0
		end
		
		-- Foregrips
		if self.parts.wpn_fps_upg_m4_fg_urx3 then
			self.parts.wpn_fps_upg_m4_fg_urx3.stats.spread = 1
			self.parts.wpn_fps_upg_m4_fg_urx3.stats.recoil = 0
			self.parts.wpn_fps_upg_m4_fg_urx3.stats.concealment = 0
		end
		if self.parts.wpn_fps_upg_m4_fg_kacris then
			self.parts.wpn_fps_upg_m4_fg_kacris.stats.spread = 0
			self.parts.wpn_fps_upg_m4_fg_kacris.stats.recoil = 1
			self.parts.wpn_fps_upg_m4_fg_kacris.stats.concealment = 3
		end
		if self.parts.wpn_fps_upg_saiga_fg_custom then
			self.parts.wpn_fps_upg_saiga_fg_custom.stats.spread = 2
			self.parts.wpn_fps_upg_saiga_fg_custom.stats.recoil = 3
			self.parts.wpn_fps_upg_saiga_fg_custom.stats.concealment = -3
		end
		if self.parts.wpn_fps_upg_m4_fg_ris9 then
			self.parts.wpn_fps_upg_m4_fg_ris9.stats.damage = 1
			self.parts.wpn_fps_upg_m4_fg_ris9.stats.spread = 1
			self.parts.wpn_fps_upg_m4_fg_ris9.stats.recoil = 2
			self.parts.wpn_fps_upg_m4_fg_ris9.stats.concealment = -2
		end
		if self.parts.wpn_fps_upg_m4_fg_gis9 then
			self.parts.wpn_fps_upg_m4_fg_gis9.stats.damage = 1
			self.parts.wpn_fps_upg_m4_fg_gis9.stats.spread = 0
			self.parts.wpn_fps_upg_m4_fg_gis9.stats.recoil = 2
			self.parts.wpn_fps_upg_m4_fg_gis9.stats.concealment = -1
		end
		if self.parts.wpn_fps_upg_m4_fg_lwrc7 then
			self.parts.wpn_fps_upg_m4_fg_lwrc7.stats.damage = 3
			self.parts.wpn_fps_upg_m4_fg_lwrc7.stats.spread = 0
			self.parts.wpn_fps_upg_m4_fg_lwrc7.stats.recoil = 1
			self.parts.wpn_fps_upg_m4_fg_lwrc7.stats.concealment = 2
		end
		if self.parts.wpn_fps_ak_upg_fg_ak100 then
			self.parts.wpn_fps_ak_upg_fg_ak100.stats.spread = 1
			self.parts.wpn_fps_ak_upg_fg_ak100.stats.recoil = 1
			self.parts.wpn_fps_ak_upg_fg_ak100.stats.concealment = 2
		end
		if self.parts.wpn_fps_ak_upg_fg_b30 then
			self.parts.wpn_fps_ak_upg_fg_b30.stats.damage = 3
			self.parts.wpn_fps_ak_upg_fg_b30.stats.spread = 0
			self.parts.wpn_fps_ak_upg_fg_b30.stats.recoil = 3
			self.parts.wpn_fps_ak_upg_fg_b30.stats.concealment = -3
		end
		if self.parts.wpn_fps_upg_416_fg_quad then
			self.parts.wpn_fps_upg_416_fg_quad.stats.spread = 2
			self.parts.wpn_fps_upg_416_fg_quad.stats.recoil = 0
			self.parts.wpn_fps_upg_416_fg_quad.stats.concealment = -1
		end
		if self.parts.wpn_fps_upg_m4_fg_lvoas then
			self.parts.wpn_fps_upg_m4_fg_lvoas.stats.spread = 1
			self.parts.wpn_fps_upg_m4_fg_lvoas.stats.recoil = 3
			self.parts.wpn_fps_upg_m4_fg_lvoas.stats.concealment = -2
		end
		if self.parts.wpn_fps_ak_upg_fg_hexa then
			self.parts.wpn_fps_ak_upg_fg_hexa.stats.spread = 2
			self.parts.wpn_fps_ak_upg_fg_hexa.stats.recoil = -1
			self.parts.wpn_fps_ak_upg_fg_hexa.stats.concealment = 4
		end
		if self.parts.wpn_fps_upg_m4_fg_strike then
			self.parts.wpn_fps_upg_m4_fg_strike.stats.spread = -1
			self.parts.wpn_fps_upg_m4_fg_strike.stats.recoil = -2
			self.parts.wpn_fps_upg_m4_fg_strike.stats.concealment = 4
		end
		if self.parts.wpn_fps_upg_m4_fg_lvoac then
			self.parts.wpn_fps_upg_m4_fg_lvoac.stats.damage = -3
			self.parts.wpn_fps_upg_m4_fg_lvoac.stats.spread = 1
			self.parts.wpn_fps_upg_m4_fg_lvoac.stats.recoil = 4
			self.parts.wpn_fps_upg_m4_fg_lvoac.stats.concealment = -5
		end
		if self.parts.wpn_fps_upg_scar_fg_mrex then
			self.parts.wpn_fps_upg_scar_fg_mrex.stats.spread = 2
			self.parts.wpn_fps_upg_scar_fg_mrex.stats.recoil = 2
			self.parts.wpn_fps_upg_scar_fg_mrex.stats.concealment = -3
		end
		if self.parts.wpn_fps_upg_m4_fg_urx10 then
			self.parts.wpn_fps_upg_m4_fg_urx10.stats.spread = 2
			self.parts.wpn_fps_upg_m4_fg_urx10.stats.recoil = 1
			self.parts.wpn_fps_upg_m4_fg_urx10.stats.concealment = -2
		end
		if self.parts.wpn_fps_ak_upg_fg_zhuk then
			self.parts.wpn_fps_ak_upg_fg_zhuk.stats.spread = 1
			self.parts.wpn_fps_ak_upg_fg_zhuk.stats.recoil = 3
			self.parts.wpn_fps_ak_upg_fg_zhuk.stats.concealment = -2
		end
		if self.parts.wpn_fps_upg_417_fg_patrol then
			self.parts.wpn_fps_upg_417_fg_patrol.stats.spread = -1
			self.parts.wpn_fps_upg_417_fg_patrol.stats.recoil = -2
			self.parts.wpn_fps_upg_417_fg_patrol.stats.concealment = 2
		end
		if self.parts.wpn_fps_upg_m4_fg_mk10 then
			self.parts.wpn_fps_upg_m4_fg_mk10.stats.spread = 2
			self.parts.wpn_fps_upg_m4_fg_mk10.stats.recoil = 2
			self.parts.wpn_fps_upg_m4_fg_mk10.stats.concealment = -3
		end
		if self.parts.wpn_fps_ak_upg_fg_krebsl then
			self.parts.wpn_fps_ak_upg_fg_krebsl.stats.damage = 2
			self.parts.wpn_fps_ak_upg_fg_krebsl.stats.spread = 3
			self.parts.wpn_fps_ak_upg_fg_krebsl.stats.recoil = 0
			self.parts.wpn_fps_ak_upg_fg_krebsl.stats.concealment = -3
		end
		if self.parts.wpn_fps_upg_m4_fg_stm9 then
			self.parts.wpn_fps_upg_m4_fg_stm9.stats.spread = 4
			self.parts.wpn_fps_upg_m4_fg_stm9.stats.recoil = -4
			self.parts.wpn_fps_upg_m4_fg_stm9.stats.concealment = 0
		end
		if self.parts.wpn_fps_ak_upg_fg_b11 then
			self.parts.wpn_fps_ak_upg_fg_b11.stats.spread = 1
			self.parts.wpn_fps_ak_upg_fg_b11.stats.recoil = 2
			self.parts.wpn_fps_ak_upg_fg_b11.stats.concealment = -2
		end
		if self.parts.wpn_fps_upg_m4_fg_risfsp then
			self.parts.wpn_fps_upg_m4_fg_risfsp.stats.damage = 2
			self.parts.wpn_fps_upg_m4_fg_risfsp.stats.spread = 1
			self.parts.wpn_fps_upg_m4_fg_risfsp.stats.recoil = 2
			self.parts.wpn_fps_upg_m4_fg_risfsp.stats.concealment = -3
		end
		if self.parts.wpn_fps_upg_m4_fg_aero then
			self.parts.wpn_fps_upg_m4_fg_aero.stats.damage = 1
			self.parts.wpn_fps_upg_m4_fg_aero.stats.spread = 2
			self.parts.wpn_fps_upg_m4_fg_aero.stats.recoil = 2
			self.parts.wpn_fps_upg_m4_fg_aero.stats.concealment = -2
		end
		if self.parts.wpn_fps_upg_m4_fg_lmt then
			self.parts.wpn_fps_upg_m4_fg_lmt.stats.spread = 1
			self.parts.wpn_fps_upg_m4_fg_lmt.stats.recoil = 1
			self.parts.wpn_fps_upg_m4_fg_lmt.stats.concealment = 1
		end
		if self.parts.wpn_fps_ak_upg_fg_tdi then
			self.parts.wpn_fps_ak_upg_fg_tdi.stats.spread = 1
			self.parts.wpn_fps_ak_upg_fg_tdi.stats.recoil = 1
			self.parts.wpn_fps_ak_upg_fg_tdi.stats.concealment = 2
		end
		if self.parts.wpn_fps_ak_upg_fg_caa then
			self.parts.wpn_fps_ak_upg_fg_caa.stats.spread = 1
			self.parts.wpn_fps_ak_upg_fg_caa.stats.recoil = 2
			self.parts.wpn_fps_ak_upg_fg_caa.stats.concealment = 0
		end
		if self.parts.wpn_fps_upg_m4_fg_lancer then
			self.parts.wpn_fps_upg_m4_fg_lancer.stats.spread = 1
			self.parts.wpn_fps_upg_m4_fg_lancer.stats.recoil = 0
			self.parts.wpn_fps_upg_m4_fg_lancer.stats.concealment = 1
		end
		if self.parts.wpn_fps_upg_m4_fg_gis13 then
			self.parts.wpn_fps_upg_m4_fg_gis13.stats.damage = 1
			self.parts.wpn_fps_upg_m4_fg_gis13.stats.spread = 1
			self.parts.wpn_fps_upg_m4_fg_gis13.stats.recoil = 3
			self.parts.wpn_fps_upg_m4_fg_gis13.stats.concealment = -3
		end
		if self.parts.wpn_fps_upg_m4_fg_noves then
			self.parts.wpn_fps_upg_m4_fg_noves.stats.spread = 1
			self.parts.wpn_fps_upg_m4_fg_noves.stats.recoil = 2
			self.parts.wpn_fps_upg_m4_fg_noves.stats.concealment = -2
		end
		if self.parts.wpn_fps_upg_416_fg_quade then
			self.parts.wpn_fps_upg_416_fg_quade.stats.spread = 3
			self.parts.wpn_fps_upg_416_fg_quade.stats.recoil = -1
			self.parts.wpn_fps_upg_416_fg_quade.stats.concealment = -3
		end
		if self.parts.wpn_fps_upg_m4_fg_cmmg9 then
			self.parts.wpn_fps_upg_m4_fg_cmmg9.stats.spread = 1
			self.parts.wpn_fps_upg_m4_fg_cmmg9.stats.recoil = 2
			self.parts.wpn_fps_upg_m4_fg_cmmg9.stats.concealment = 2
		end
		if self.parts.wpn_fps_upg_m4_fg_lone then
			self.parts.wpn_fps_upg_m4_fg_lone.stats.spread = 4
			self.parts.wpn_fps_upg_m4_fg_lone.stats.recoil = 1
			self.parts.wpn_fps_upg_m4_fg_lone.stats.concealment = -5
		end
		if self.parts.wpn_fps_upg_m4_fg_stm15 then
			self.parts.wpn_fps_upg_m4_fg_stm15.stats.spread = 6
			self.parts.wpn_fps_upg_m4_fg_stm15.stats.recoil = -4
			self.parts.wpn_fps_upg_m4_fg_stm15.stats.concealment = -2
		end
		if self.parts.wpn_fps_upg_417_fg_free then
			self.parts.wpn_fps_upg_417_fg_free.stats.spread = 3
			self.parts.wpn_fps_upg_417_fg_free.stats.recoil = -1
			self.parts.wpn_fps_upg_417_fg_free.stats.concealment = -3
		end
		if self.parts.wpn_fps_upg_m4_fg_dm7 then
			self.parts.wpn_fps_upg_m4_fg_dm7.stats.damage = 2
			self.parts.wpn_fps_upg_m4_fg_dm7.stats.spread = 2
			self.parts.wpn_fps_upg_m4_fg_dm7.stats.recoil = 2
			self.parts.wpn_fps_upg_m4_fg_dm7.stats.concealment = -3
		end
		if self.parts.wpn_fps_upg_m4_fg_moec then
			self.parts.wpn_fps_upg_m4_fg_moec.stats.spread = 0
			self.parts.wpn_fps_upg_m4_fg_moec.stats.recoil = 1
			self.parts.wpn_fps_upg_m4_fg_moec.stats.concealment = 1
		end
		if self.parts.wpn_fps_upg_m4_fg_nove then
			self.parts.wpn_fps_upg_m4_fg_nove.stats.spread = 0
			self.parts.wpn_fps_upg_m4_fg_nove.stats.recoil = 1
			self.parts.wpn_fps_upg_m4_fg_nove.stats.concealment = -1
		end
		if self.parts.wpn_fps_upg_m4_fg_lwrc9 then
			self.parts.wpn_fps_upg_m4_fg_lwrc9.stats.spread = 1
			self.parts.wpn_fps_upg_m4_fg_lwrc9.stats.recoil = 1
			self.parts.wpn_fps_upg_m4_fg_lwrc9.stats.concealment = 1
		end
		if self.parts.wpn_fps_upg_scar_fg_srx then
			self.parts.wpn_fps_upg_scar_fg_srx.stats.spread = 1
			self.parts.wpn_fps_upg_scar_fg_srx.stats.recoil = 1
			self.parts.wpn_fps_upg_scar_fg_srx.stats.concealment = -1
		end
		if self.parts.wpn_fps_upg_m4_fg_rismini then
			self.parts.wpn_fps_upg_m4_fg_rismini.stats.damage = 1
			self.parts.wpn_fps_upg_m4_fg_rismini.stats.spread = 1
			self.parts.wpn_fps_upg_m4_fg_rismini.stats.recoil = 2
			self.parts.wpn_fps_upg_m4_fg_rismini.stats.concealment = -2
		end
		if self.parts.wpn_fps_upg_hk_fg_caa then
			self.parts.wpn_fps_upg_hk_fg_caa.stats.spread = 2
			self.parts.wpn_fps_upg_hk_fg_caa.stats.recoil = 3
			self.parts.wpn_fps_upg_hk_fg_caa.stats.concealment = -3
		end
		if self.parts.wpn_fps_upg_m4_fg_moem then
			self.parts.wpn_fps_upg_m4_fg_moem.stats.spread = 0
			self.parts.wpn_fps_upg_m4_fg_moem.stats.recoil = 2
			self.parts.wpn_fps_upg_m4_fg_moem.stats.concealment = 0
		end
		if self.parts.wpn_fps_ak_upg_fg_plum then
			self.parts.wpn_fps_ak_upg_fg_plum.stats.spread = 1
			self.parts.wpn_fps_ak_upg_fg_plum.stats.recoil = 1
			self.parts.wpn_fps_ak_upg_fg_plum.stats.concealment = 2
		end
		if self.parts.wpn_fps_upg_416_fg_mlok13 then
			self.parts.wpn_fps_upg_416_fg_mlok13.stats.spread = 4
			self.parts.wpn_fps_upg_416_fg_mlok13.stats.recoil = -2
			self.parts.wpn_fps_upg_416_fg_mlok13.stats.concealment = -4
		end
		if self.parts.wpn_fps_upg_m4_fg_kac then
			self.parts.wpn_fps_upg_m4_fg_kac.stats.spread = 1
			self.parts.wpn_fps_upg_m4_fg_kac.stats.recoil = 1
			self.parts.wpn_fps_upg_m4_fg_kac.stats.concealment = -1
		end
		if self.parts.wpn_fps_upg_m4_fg_wing then
			self.parts.wpn_fps_upg_m4_fg_wing.stats.spread = 3
			self.parts.wpn_fps_upg_m4_fg_wing.stats.recoil = -1
			self.parts.wpn_fps_upg_m4_fg_wing.stats.concealment = -1
		end
		if self.parts.wpn_fps_upg_m4_fg_adar then
			self.parts.wpn_fps_upg_m4_fg_adar.stats.spread = -2
			self.parts.wpn_fps_upg_m4_fg_adar.stats.recoil = 3
			self.parts.wpn_fps_upg_m4_fg_adar.stats.concealment = -1
		end
		if self.parts.wpn_fps_upg_m4_fg_516 then
			self.parts.wpn_fps_upg_m4_fg_516.stats.spread = 2
			self.parts.wpn_fps_upg_m4_fg_516.stats.recoil = 1
			self.parts.wpn_fps_upg_m4_fg_516.stats.concealment = -2
		end
		if self.parts.wpn_fps_upg_m4_fg_vypr then
			self.parts.wpn_fps_upg_m4_fg_vypr.stats.spread = 1
			self.parts.wpn_fps_upg_m4_fg_vypr.stats.recoil = 0
			self.parts.wpn_fps_upg_m4_fg_vypr.stats.concealment = 0
		end
		if self.parts.wpn_fps_upg_m4_fg_skele then
			self.parts.wpn_fps_upg_m4_fg_skele.stats.spread = -2
			self.parts.wpn_fps_upg_m4_fg_skele.stats.recoil = -1
			self.parts.wpn_fps_upg_m4_fg_skele.stats.concealment = 4
		end
		if self.parts.wpn_fps_upg_m4_fg_sail then
			self.parts.wpn_fps_upg_m4_fg_sail.stats.damage = -1
			self.parts.wpn_fps_upg_m4_fg_sail.stats.spread = 0
			self.parts.wpn_fps_upg_m4_fg_sail.stats.recoil = 4
			self.parts.wpn_fps_upg_m4_fg_sail.stats.concealment = -5
		end
		if self.parts.wpn_fps_upg_m4_fg_cmmg15 then
			self.parts.wpn_fps_upg_m4_fg_cmmg15.stats.spread = 2
			self.parts.wpn_fps_upg_m4_fg_cmmg15.stats.recoil = 1
			self.parts.wpn_fps_upg_m4_fg_cmmg15.stats.concealment = -2
		end
		if self.parts.wpn_fps_ak_upg_fg_aggr then
			self.parts.wpn_fps_ak_upg_fg_aggr.stats.damage = 1
			self.parts.wpn_fps_ak_upg_fg_aggr.stats.spread = -2
			self.parts.wpn_fps_ak_upg_fg_aggr.stats.recoil = 5
			self.parts.wpn_fps_ak_upg_fg_aggr.stats.concealment = -3
		end
		if self.parts.wpn_fps_upg_416_fg_key then
			self.parts.wpn_fps_upg_416_fg_key.stats.spread = 2
			self.parts.wpn_fps_upg_416_fg_key.stats.recoil = 2
			self.parts.wpn_fps_upg_416_fg_key.stats.concealment = -3
		end
		if self.parts.wpn_fps_ak_upg_fg_goliaf then
			self.parts.wpn_fps_ak_upg_fg_goliaf.stats.spread = 2
			self.parts.wpn_fps_ak_upg_fg_goliaf.stats.recoil = 3
			self.parts.wpn_fps_ak_upg_fg_goliaf.stats.concealment = -3
		end
		if self.parts.wpn_fps_upg_m4_fg_sais then
			self.parts.wpn_fps_upg_m4_fg_sais.stats.spread = -1
			self.parts.wpn_fps_upg_m4_fg_sais.stats.recoil = 3
			self.parts.wpn_fps_upg_m4_fg_sais.stats.concealment = -3
		end
		if self.parts.wpn_fps_ak_upg_fg_cmdr then
			self.parts.wpn_fps_ak_upg_fg_cmdr.stats.spread = 3
			self.parts.wpn_fps_ak_upg_fg_cmdr.stats.recoil = 3
			self.parts.wpn_fps_ak_upg_fg_cmdr.stats.concealment = -5
		end
		if self.parts.wpn_fps_upg_m4_fg_stm12 then
			self.parts.wpn_fps_upg_m4_fg_stm12.stats.spread = 5
			self.parts.wpn_fps_upg_m4_fg_stm12.stats.recoil = -4
			self.parts.wpn_fps_upg_m4_fg_stm12.stats.concealment = -1
		end
		if self.parts.wpn_fps_upg_m4_fg_rsass then
			self.parts.wpn_fps_upg_m4_fg_rsass.stats.spread = 1
			self.parts.wpn_fps_upg_m4_fg_rsass.stats.recoil = 2
			self.parts.wpn_fps_upg_m4_fg_rsass.stats.concealment = -2
		end
		if self.parts.wpn_fps_upg_416_fg_carbon then
			self.parts.wpn_fps_upg_416_fg_carbon.stats.damage = 2
			self.parts.wpn_fps_upg_416_fg_carbon.stats.spread = 2
			self.parts.wpn_fps_upg_416_fg_carbon.stats.recoil = 1
			self.parts.wpn_fps_upg_416_fg_carbon.stats.concealment = -3
		end
		if self.parts.wpn_fps_upg_416_fg_mlok9 then
			self.parts.wpn_fps_upg_416_fg_mlok9.stats.spread = 1
			self.parts.wpn_fps_upg_416_fg_mlok9.stats.recoil = 1
			self.parts.wpn_fps_upg_416_fg_mlok9.stats.concealment = 0
		end
		if self.parts.wpn_fps_upg_m4_fg_ris12 then
			self.parts.wpn_fps_upg_m4_fg_ris12.stats.damage = 3
			self.parts.wpn_fps_upg_m4_fg_ris12.stats.spread = 2
			self.parts.wpn_fps_upg_m4_fg_ris12.stats.recoil = 2
			self.parts.wpn_fps_upg_m4_fg_ris12.stats.concealment = -4
		end
		if self.parts.wpn_fps_ak_upg_fg_moe then
			self.parts.wpn_fps_ak_upg_fg_moe.stats.spread = 1
			self.parts.wpn_fps_ak_upg_fg_moe.stats.recoil = 2
			self.parts.wpn_fps_ak_upg_fg_moe.stats.concealment = 1
		end
		if self.parts.wpn_fps_upg_416_fg_crux then
			self.parts.wpn_fps_upg_416_fg_crux.stats.spread = 7
			self.parts.wpn_fps_upg_416_fg_crux.stats.recoil = -5
			self.parts.wpn_fps_upg_416_fg_crux.stats.concealment = -5
		end
		if self.parts.wpn_fps_upg_hk_fg_tri then
			self.parts.wpn_fps_upg_hk_fg_tri.stats.spread = 1
			self.parts.wpn_fps_upg_hk_fg_tri.stats.recoil = 2
			self.parts.wpn_fps_upg_hk_fg_tri.stats.concealment = -2
		end
		if self.parts.wpn_fps_upg_fal_fg_belg then
			self.parts.wpn_fps_upg_fal_fg_belg.stats.spread = 2
			self.parts.wpn_fps_upg_fal_fg_belg.stats.recoil = 1
			self.parts.wpn_fps_upg_fal_fg_belg.stats.concealment = -2
		end
		-- This one doesnt appear in game fore me bcuz of a typo in main.xml of frenchy's mod, maybe he fixed it in the latest version idk
		if self.parts.wpn_fps_upg_fal_fg_stamp then
			self.parts.wpn_fps_upg_fal_fg_stamp.stats.spread = 2
			self.parts.wpn_fps_upg_fal_fg_stamp.stats.recoil = 2
			self.parts.wpn_fps_upg_fal_fg_stamp.stats.concealment = -3
		end
		if self.parts.wpn_fps_upg_fal_fg_casvl then
			self.parts.wpn_fps_upg_fal_fg_casvl.stats.spread = -1
			self.parts.wpn_fps_upg_fal_fg_casvl.stats.recoil = 5
			self.parts.wpn_fps_upg_fal_fg_casvl.stats.concealment = -2
		end
		if self.parts.wpn_fps_upg_fal_fg_casvs then
			self.parts.wpn_fps_upg_fal_fg_casvs.stats.spread = 0
			self.parts.wpn_fps_upg_fal_fg_casvs.stats.recoil = -1
			self.parts.wpn_fps_upg_fal_fg_casvs.stats.concealment = 6
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
		
		-- BARRELS
		if self.parts.wpn_fps_smg_polymer_barrel_barlong then
			self.parts.wpn_fps_smg_polymer_barrel_barlong.stats.spread = 3
			self.parts.wpn_fps_smg_polymer_barrel_barlong.stats.recoil = -4
			self.parts.wpn_fps_smg_polymer_barrel_barlong.stats.concealment = -3
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
			self.parts.wpn_fps_smg_polymer_barrel_barsil.stats.damage = -4
			self.parts.wpn_fps_smg_polymer_barrel_barsil.stats.spread = 3
			self.parts.wpn_fps_smg_polymer_barrel_barsil.stats.recoil = -2
			self.parts.wpn_fps_smg_polymer_barrel_barsil.stats.concealment = -4
		end
		if self.parts.wpn_fps_smg_polymer_barrel_mk5 then
			self.parts.wpn_fps_smg_polymer_barrel_mk5.stats.spread = 1
			self.parts.wpn_fps_smg_polymer_barrel_mk5.stats.recoil = 1
			self.parts.wpn_fps_smg_polymer_barrel_mk5.stats.concealment = -1
		end
		if self.parts.wpn_fps_upg_m4_b_406 then
			self.parts.wpn_fps_upg_m4_b_406.stats.damage = -2
			self.parts.wpn_fps_upg_m4_b_406.stats.spread = 0
			self.parts.wpn_fps_upg_m4_b_406.stats.recoil = 2
			self.parts.wpn_fps_upg_m4_b_406.stats.concealment = 0
		end
		if self.parts.wpn_fps_upg_m4_b_508 then
			self.parts.wpn_fps_upg_m4_b_508.stats.spread = -2
			self.parts.wpn_fps_upg_m4_b_508.stats.recoil = 4
			self.parts.wpn_fps_upg_m4_b_508.stats.concealment = -3
		end
		if self.parts.wpn_fps_upg_416_b_505 then
			self.parts.wpn_fps_upg_416_b_505.stats.damage = -4
			self.parts.wpn_fps_upg_416_b_505.stats.spread = 2
			self.parts.wpn_fps_upg_416_b_505.stats.recoil = 3
			self.parts.wpn_fps_upg_416_b_505.stats.concealment = -4
		end
		if self.parts.wpn_fps_upg_m4_b_370 then
			self.parts.wpn_fps_upg_m4_b_370.stats.damage = -3
			self.parts.wpn_fps_upg_m4_b_370.stats.spread = 0
			self.parts.wpn_fps_upg_m4_b_370.stats.recoil = 0
			self.parts.wpn_fps_upg_m4_b_370.stats.concealment = 2
		end
		if self.parts.wpn_fps_upg_416_b_279 then
			self.parts.wpn_fps_upg_416_b_279.stats.spread = 1
			self.parts.wpn_fps_upg_416_b_279.stats.recoil = 0
			self.parts.wpn_fps_upg_416_b_279.stats.concealment = -1
		end
		if self.parts.wpn_fps_upg_416_b_419 then
			self.parts.wpn_fps_upg_416_b_419.stats.spread = 1
			self.parts.wpn_fps_upg_416_b_419.stats.recoil = 2
			self.parts.wpn_fps_upg_416_b_419.stats.concealment = -3
		end
		if self.parts.wpn_fps_upg_m4_b_457 then
			self.parts.wpn_fps_upg_m4_b_457.stats.spread = -1
			self.parts.wpn_fps_upg_m4_b_457.stats.recoil = 3
			self.parts.wpn_fps_upg_m4_b_457.stats.concealment = -2
		end
		if self.parts.wpn_fps_upg_416_b_264 then
			self.parts.wpn_fps_upg_416_b_264.stats.spread = 0
			self.parts.wpn_fps_upg_416_b_264.stats.recoil = -2
			self.parts.wpn_fps_upg_416_b_264.stats.concealment = 1
		end
		if self.parts.wpn_fps_upg_scar_b_cqb then
			self.parts.wpn_fps_upg_scar_b_cqb.stats.spread = -2
			self.parts.wpn_fps_upg_scar_b_cqb.stats.recoil = -1
			self.parts.wpn_fps_upg_scar_b_cqb.stats.concealment = 4
		end
		if self.parts.wpn_fps_upg_m4_b_508post then
			self.parts.wpn_fps_upg_m4_b_508post.stats.spread = 4
			self.parts.wpn_fps_upg_m4_b_508post.stats.recoil = -3
			self.parts.wpn_fps_upg_m4_b_508post.stats.concealment = -3
		end
		if self.parts.wpn_fps_upg_m4_b_370rail then
			self.parts.wpn_fps_upg_m4_b_370rail.stats.damage = -3
			self.parts.wpn_fps_upg_m4_b_370rail.stats.spread = 0
			self.parts.wpn_fps_upg_m4_b_370rail.stats.recoil = 1
			self.parts.wpn_fps_upg_m4_b_370rail.stats.concealment = 1
		end
		if self.parts.wpn_fps_upg_m4_b_260post then
			self.parts.wpn_fps_upg_m4_b_260post.stats.damage = -5
			self.parts.wpn_fps_upg_m4_b_260post.stats.spread = -1
			self.parts.wpn_fps_upg_m4_b_260post.stats.recoil = -2
			self.parts.wpn_fps_upg_m4_b_260post.stats.concealment = 2
		end
		if self.parts.wpn_fps_upg_m4_b_260rail then
			self.parts.wpn_fps_upg_m4_b_260rail.stats.damage = -5
			self.parts.wpn_fps_upg_m4_b_260rail.stats.spread = -2
			self.parts.wpn_fps_upg_m4_b_260rail.stats.recoil = -1
			self.parts.wpn_fps_upg_m4_b_260rail.stats.concealment = 2
		end
		if self.parts.wpn_fps_upg_akmsu_b then
			self.parts.wpn_fps_upg_akmsu_b.stats.spread = -1
			self.parts.wpn_fps_upg_akmsu_b.stats.recoil = 1
			self.parts.wpn_fps_upg_akmsu_b.stats.concealment = 1
		end
		if self.parts.wpn_fps_upg_m4_b_406post then
			self.parts.wpn_fps_upg_m4_b_406post.stats.damage = -2
			self.parts.wpn_fps_upg_m4_b_406post.stats.spread = 2
			self.parts.wpn_fps_upg_m4_b_406post.stats.recoil = 0
			self.parts.wpn_fps_upg_m4_b_406post.stats.concealment = 0
		end
		if self.parts.wpn_fps_upg_416_b_368 then
			self.parts.wpn_fps_upg_416_b_368.stats.spread = 1
			self.parts.wpn_fps_upg_416_b_368.stats.recoil = 1
			self.parts.wpn_fps_upg_416_b_368.stats.concealment = -2
		end
		if self.parts.wpn_fps_upg_m4_b_370post then
			self.parts.wpn_fps_upg_m4_b_370post.stats.damage = -3
			self.parts.wpn_fps_upg_m4_b_370post.stats.spread = 1
			self.parts.wpn_fps_upg_m4_b_370post.stats.recoil = 0
			self.parts.wpn_fps_upg_m4_b_370post.stats.concealment = 1
		end
		if self.parts.wpn_fps_upg_m4_b_457post then
			self.parts.wpn_fps_upg_m4_b_457post.stats.spread = 3
			self.parts.wpn_fps_upg_m4_b_457post.stats.recoil = -2
			self.parts.wpn_fps_upg_m4_b_457post.stats.concealment = -2
		end
		if self.parts.wpn_fps_upg_m4_b_260 then
			self.parts.wpn_fps_upg_m4_b_260.stats.damage = -5
			self.parts.wpn_fps_upg_m4_b_260.stats.spread = -2
			self.parts.wpn_fps_upg_m4_b_260.stats.recoil = -2
			self.parts.wpn_fps_upg_m4_b_260.stats.concealment = 3
		end
		
		-- STOCKS
		if self.parts.wpn_fps_upg_m4_s_a2 then
			self.parts.wpn_fps_upg_m4_s_a2.stats.spread = -2
			self.parts.wpn_fps_upg_m4_s_a2.stats.recoil = 2
			self.parts.wpn_fps_upg_m4_s_a2.stats.concealment = -3
		end
		if self.parts.wpn_fps_upg_m4_s_hera then
			table.insert(self.parts.wpn_fps_upg_m4_s_hera.forbids, "wpn_fps_upg_g_m4_surgeon")
			table.insert(self.parts.wpn_fps_upg_m4_s_hera.forbids, "wpn_fps_m4_uupg_g_billet")
			table.insert(self.parts.wpn_fps_upg_m4_s_hera.forbids, "wpn_fps_sho_sko12_body_grip")
			table.insert(self.parts.wpn_fps_upg_m4_s_hera.forbids, "wpn_fps_snp_victor_g_mod3")
			self.parts.wpn_fps_upg_m4_s_hera.stats.spread = 1
			self.parts.wpn_fps_upg_m4_s_hera.stats.recoil = 3
			self.parts.wpn_fps_upg_m4_s_hera.stats.concealment = -3
		end
		if self.parts.wpn_fps_upg_m4_s_prs3 then
			self.parts.wpn_fps_upg_m4_s_prs3.stats.spread = -1
			self.parts.wpn_fps_upg_m4_s_prs3.stats.recoil = 4
			self.parts.wpn_fps_upg_m4_s_prs3.stats.concealment = -3
		end
		if self.parts.wpn_fps_upg_m4_s_ddun then
			self.parts.wpn_fps_upg_m4_s_ddun.stats.spread = 1
			self.parts.wpn_fps_upg_m4_s_ddun.stats.recoil = 1
			self.parts.wpn_fps_upg_m4_s_ddun.stats.concealment = 0
		end
		if self.parts.wpn_fps_upg_mpx_s_tele then
			self.parts.wpn_fps_upg_mpx_s_tele.stats.spread = 1
			self.parts.wpn_fps_upg_mpx_s_tele.stats.recoil = 2
			self.parts.wpn_fps_upg_mpx_s_tele.stats.concealment = -2
		end
		if self.parts.wpn_fps_upg_m4_s_prs2 then
			self.parts.wpn_fps_upg_m4_s_prs2.stats.spread = 0
			self.parts.wpn_fps_upg_m4_s_prs2.stats.recoil = 3
			self.parts.wpn_fps_upg_m4_s_prs2.stats.concealment = -3
		end
		if self.parts.wpn_fps_upg_mpx_s_maxim then
			self.parts.wpn_fps_upg_mpx_s_maxim.stats.spread = 1
			self.parts.wpn_fps_upg_mpx_s_maxim.stats.recoil = 0
			self.parts.wpn_fps_upg_mpx_s_maxim.stats.concealment = 0
		end
		if self.parts.wpn_fps_upg_ak_s_arch then
			self.parts.wpn_fps_upg_ak_s_arch.stats.spread = 2
			self.parts.wpn_fps_upg_ak_s_arch.stats.recoil = 1
			self.parts.wpn_fps_upg_ak_s_arch.stats.concealment = -2
		end
		if self.parts.wpn_fps_upg_mpx_s_thin then
			self.parts.wpn_fps_upg_mpx_s_thin.stats.spread = 1
			self.parts.wpn_fps_upg_mpx_s_thin.stats.recoil = 1
			self.parts.wpn_fps_upg_mpx_s_thin.stats.concealment = 0
		end
		if self.parts.wpn_fps_upg_m4_s_core then
			self.parts.wpn_fps_upg_m4_s_core.stats.spread = 0
			self.parts.wpn_fps_upg_m4_s_core.stats.recoil = 2
			self.parts.wpn_fps_upg_m4_s_core.stats.concealment = 0
		end
		if self.parts.wpn_fps_upg_fal_s_prs then
			self.parts.wpn_fps_upg_fal_s_prs.stats.spread = 1
			self.parts.wpn_fps_upg_fal_s_prs.stats.recoil = 3
			self.parts.wpn_fps_upg_fal_s_prs.stats.concealment = -4
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
			self.parts.wpn_fps_upg_m4_s_cmmg.stats.spread = -1
			self.parts.wpn_fps_upg_m4_s_cmmg.stats.recoil = -1
			self.parts.wpn_fps_upg_m4_s_cmmg.stats.concealment = 3
		end
		if self.parts.wpn_fps_upg_mpx_s_collap then
			self.parts.wpn_fps_upg_mpx_s_collap.stats.spread = 0
			self.parts.wpn_fps_upg_mpx_s_collap.stats.recoil = -1
			self.parts.wpn_fps_upg_mpx_s_collap.stats.concealment = 1
		end
		if self.parts.wpn_fps_upg_m4_s_gen2 then
			self.parts.wpn_fps_upg_m4_s_gen2.stats.spread = 2
			self.parts.wpn_fps_upg_m4_s_gen2.stats.recoil = 1
			self.parts.wpn_fps_upg_m4_s_gen2.stats.concealment = -3
		end
		if self.parts.wpn_fps_upg_mpx_s_ulss then
			self.parts.wpn_fps_upg_mpx_s_ulss.stats.spread = -1
			self.parts.wpn_fps_upg_mpx_s_ulss.stats.recoil = 0
			self.parts.wpn_fps_upg_mpx_s_ulss.stats.concealment = 1
		end
		if self.parts.wpn_fps_upg_fal_s_brs then
			self.parts.wpn_fps_upg_fal_s_brs.stats.spread = 2
			self.parts.wpn_fps_upg_fal_s_brs.stats.recoil = 2
			self.parts.wpn_fps_upg_fal_s_brs.stats.concealment = -3
		end
		if self.parts.wpn_fps_upg_m4_s_ds150 then
			self.parts.wpn_fps_upg_m4_s_ds150.stats.spread = 2
			self.parts.wpn_fps_upg_m4_s_ds150.stats.recoil = -2
			self.parts.wpn_fps_upg_m4_s_ds150.stats.concealment = 1
		end
		if self.parts.wpn_fps_sho_ultima_s_ults then
			self.parts.wpn_fps_sho_ultima_s_ults.stats.spread = 0
			self.parts.wpn_fps_sho_ultima_s_ults.stats.recoil = 2
			self.parts.wpn_fps_sho_ultima_s_ults.stats.concealment = -1
		end
		if self.parts.wpn_fps_upg_ak_s_plstc then
			self.parts.wpn_fps_upg_ak_s_plstc.stats.spread = 1
			self.parts.wpn_fps_upg_ak_s_plstc.stats.recoil = 2
			self.parts.wpn_fps_upg_ak_s_plstc.stats.concealment = -2
		end
		if self.parts.wpn_fps_upg_m4_s_adar then
			table.insert(self.parts.wpn_fps_upg_m4_s_adar.forbids, "wpn_fps_upg_g_m4_surgeon")
			table.insert(self.parts.wpn_fps_upg_m4_s_adar.forbids, "wpn_fps_m4_uupg_g_billet")
			table.insert(self.parts.wpn_fps_upg_m4_s_adar.forbids, "wpn_fps_sho_sko12_body_grip")
			table.insert(self.parts.wpn_fps_upg_m4_s_adar.forbids, "wpn_fps_snp_victor_g_mod3")
			self.parts.wpn_fps_upg_m4_s_adar.stats.spread = 1
			self.parts.wpn_fps_upg_m4_s_adar.stats.recoil = 3
			self.parts.wpn_fps_upg_m4_s_adar.stats.concealment = -4
		end
		if self.parts.wpn_fps_upg_fal_s_spr then
			self.parts.wpn_fps_upg_fal_s_spr.stats.spread = 3
			self.parts.wpn_fps_upg_fal_s_spr.stats.recoil = -1
			self.parts.wpn_fps_upg_fal_s_spr.stats.concealment = -1
		end
		if self.parts.wpn_fps_sho_ultima_s_ultm then
			self.parts.wpn_fps_sho_ultima_s_ultm.stats.spread = 0
			self.parts.wpn_fps_sho_ultima_s_ultm.stats.recoil = 3
			self.parts.wpn_fps_sho_ultima_s_ultm.stats.concealment = -2
		end
		if self.parts.wpn_fps_upg_ak_s_hex then
			self.parts.wpn_fps_upg_ak_s_hex.stats.spread = -1
			self.parts.wpn_fps_upg_ak_s_hex.stats.recoil = 1
			self.parts.wpn_fps_upg_ak_s_hex.stats.concealment = 3
		end
		if self.parts.wpn_fps_upg_m4_s_bus then
			self.parts.wpn_fps_upg_m4_s_bus.stats.spread = -2
			self.parts.wpn_fps_upg_m4_s_bus.stats.recoil = 2
			self.parts.wpn_fps_upg_m4_s_bus.stats.concealment = 1
		end
		if self.parts.wpn_fps_upg_m4_s_viper then
			self.parts.wpn_fps_upg_m4_s_viper.stats.spread = -2
			self.parts.wpn_fps_upg_m4_s_viper.stats.recoil = 1
			self.parts.wpn_fps_upg_m4_s_viper.stats.concealment = 2
		end
		if self.parts.wpn_fps_upg_m4_s_hke1 then
			self.parts.wpn_fps_upg_m4_s_hke1.stats.spread = -1
			self.parts.wpn_fps_upg_m4_s_hke1.stats.recoil = 4
			self.parts.wpn_fps_upg_m4_s_hke1.stats.concealment = -3
		end
		if self.parts.wpn_fps_sho_ultima_s_ultl then
			self.parts.wpn_fps_sho_ultima_s_ultl.stats.spread = 1
			self.parts.wpn_fps_sho_ultima_s_ultl.stats.recoil = 3
			self.parts.wpn_fps_sho_ultima_s_ultl.stats.concealment = -3
		end
		if self.parts.wpn_fps_upg_m4_s_hkslim then
			self.parts.wpn_fps_upg_m4_s_hkslim.stats.spread = 1
			self.parts.wpn_fps_upg_m4_s_hkslim.stats.recoil = 0
			self.parts.wpn_fps_upg_m4_s_hkslim.stats.concealment = 1
		end
		if self.parts.wpn_fps_upg_m4_s_troy then
			self.parts.wpn_fps_upg_m4_s_troy.stats.spread = -1
			self.parts.wpn_fps_upg_m4_s_troy.stats.recoil = -2
			self.parts.wpn_fps_upg_m4_s_troy.stats.concealment = 3
		end
		if self.parts.wpn_fps_upg_ak_s_akhera then
			table.insert(self.parts.wpn_fps_upg_ak_s_akhera.forbids, "wpn_fps_upg_ak_g_hgrip")
			table.insert(self.parts.wpn_fps_upg_ak_s_akhera.forbids, "wpn_fps_upg_ak_g_wgrip")
			self.parts.wpn_fps_upg_ak_s_akhera.stats.spread = 3
			self.parts.wpn_fps_upg_ak_s_akhera.stats.recoil = 4
			self.parts.wpn_fps_upg_ak_s_akhera.stats.concealment = -6
		end
		-- adapter
		if self.parts.wpn_fps_upg_m4_buff_adap then
			self.parts.wpn_fps_upg_m4_buff_adap.stats.spread = 1
			self.parts.wpn_fps_upg_m4_buff_adap.stats.recoil = -1
			self.parts.wpn_fps_upg_m4_buff_adap.stats.concealment = 0
		end
		
		-- pistol grips
		if self.parts.wpn_fps_upg_m4_g_psg then
			self.parts.wpn_fps_upg_m4_g_psg.stats.spread = 1
			self.parts.wpn_fps_upg_m4_g_psg.stats.recoil = 2
			self.parts.wpn_fps_upg_m4_g_psg.stats.concealment = -3
		end
		if self.parts.wpn_fps_upg_m4_g_dlg123 then
			self.parts.wpn_fps_upg_m4_g_dlg123.stats.spread = 2
			self.parts.wpn_fps_upg_m4_g_dlg123.stats.recoil = -1
			self.parts.wpn_fps_upg_m4_g_dlg123.stats.concealment = -1
		end

		-- MAGAZINES
		if self.parts.wpn_fps_upg_m_dura then
			self.parts.wpn_fps_upg_m_dura.stats.spread = 0
			self.parts.wpn_fps_upg_m_dura.stats.recoil = 0
			self.parts.wpn_fps_upg_m_dura.stats.concealment = 1
			self.parts.wpn_fps_upg_m_dura.stats.reload = 0
		end
		if self.parts.wpn_fps_upg_m_d60 then
			self.parts.wpn_fps_upg_m_d60.stats.spread = -1
			self.parts.wpn_fps_upg_m_d60.stats.recoil = 1
			self.parts.wpn_fps_upg_m_d60.stats.concealment = -3
			self.parts.wpn_fps_upg_m_d60.stats.reload = -5
		end
		if self.parts.wpn_fps_upg_m_p10 then
			self.parts.wpn_fps_upg_m_p10.stats.spread = 1
			self.parts.wpn_fps_upg_m_p10.stats.recoil = -3
			self.parts.wpn_fps_upg_m_p10.stats.concealment = 4
			self.parts.wpn_fps_upg_m_p10.stats.reload = 9
		end
		if self.parts.wpn_fps_upg_m_p20 then
			self.parts.wpn_fps_upg_m_p20.stats.spread = 0
			self.parts.wpn_fps_upg_m_p20.stats.recoil = -2
			self.parts.wpn_fps_upg_m_p20.stats.concealment = 2
			self.parts.wpn_fps_upg_m_p20.stats.reload = 8
		end
		if self.parts.wpn_fps_upg_m_p30 then
			self.parts.wpn_fps_upg_m_p30.stats.spread = 1
			self.parts.wpn_fps_upg_m_p30.stats.recoil = 1
			self.parts.wpn_fps_upg_m_p30.stats.concealment = -2
			self.parts.wpn_fps_upg_m_p30.stats.reload = 2
		end
		if self.parts.wpn_fps_upg_m_p30w then
			self.parts.wpn_fps_upg_m_p30w.stats.spread = 0
			self.parts.wpn_fps_upg_m_p30w.stats.recoil = 2
			self.parts.wpn_fps_upg_m_p30w.stats.concealment = -1
			self.parts.wpn_fps_upg_m_p30w.stats.reload = 1
		end
		if self.parts.wpn_fps_upg_m_p40 then
			self.parts.wpn_fps_upg_m_p40.stats.spread = -1
			self.parts.wpn_fps_upg_m_p40.stats.recoil = 0
			self.parts.wpn_fps_upg_m_p40.stats.concealment = -2
			self.parts.wpn_fps_upg_m_p40.stats.reload = -3
		end
		if self.parts.wpn_fps_upg_m_battle then
			self.parts.wpn_fps_upg_m_battle.stats.spread = 0
			self.parts.wpn_fps_upg_m_battle.stats.recoil = 1
			self.parts.wpn_fps_upg_m_battle.stats.concealment = 1
			self.parts.wpn_fps_upg_m_battle.stats.reload = 0
		end
		if self.parts.wpn_fps_upg_m_poly then
			self.parts.wpn_fps_upg_m_poly.stats.spread = 3
			self.parts.wpn_fps_upg_m_poly.stats.recoil = -1
			self.parts.wpn_fps_upg_m_poly.stats.concealment = -1
			self.parts.wpn_fps_upg_m_poly.stats.reload = 0
		end
		if self.parts.wpn_fps_upg_m_hksteel then
			self.parts.wpn_fps_upg_m_hksteel.stats.spread = 0
			self.parts.wpn_fps_upg_m_hksteel.stats.recoil = 1
			self.parts.wpn_fps_upg_m_hksteel.stats.concealment = 0
			self.parts.wpn_fps_upg_m_hksteel.stats.reload = 0
		end
		if self.parts.wpn_fps_upg_m_gen2 then
			self.parts.wpn_fps_upg_m_gen2.stats.spread = 1
			self.parts.wpn_fps_upg_m_gen2.stats.recoil = 1
			self.parts.wpn_fps_upg_m_gen2.stats.concealment = 1
			self.parts.wpn_fps_upg_m_gen2.stats.reload = 0
		end
		if self.parts.wpn_fps_upg_m_plum then
			self.parts.wpn_fps_upg_m_plum.stats.spread = 0
			self.parts.wpn_fps_upg_m_plum.stats.recoil = 1
			self.parts.wpn_fps_upg_m_plum.stats.concealment = 0
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
			self.parts.wpn_fps_upg_m_rpk45.stats.spread = -2
			self.parts.wpn_fps_upg_m_rpk45.stats.recoil = 1
			self.parts.wpn_fps_upg_m_rpk45.stats.concealment = -2
			self.parts.wpn_fps_upg_m_rpk45.stats.reload = -3
		end
		if self.parts.wpn_fps_upg_m_545pmag then
			self.parts.wpn_fps_upg_m_545pmag.stats.spread = 0
			self.parts.wpn_fps_upg_m_545pmag.stats.recoil = 1
			self.parts.wpn_fps_upg_m_545pmag.stats.concealment = 0
			self.parts.wpn_fps_upg_m_545pmag.stats.reload = 2
		end
		if self.parts.wpn_fps_upg_m_rpkd then
			self.parts.wpn_fps_upg_m_rpkd.stats.spread = -3
			self.parts.wpn_fps_upg_m_rpkd.stats.recoil = 4
			self.parts.wpn_fps_upg_m_rpkd.stats.concealment = -6
			self.parts.wpn_fps_upg_m_rpkd.stats.reload = -8
		end
		if self.parts.wpn_fps_upg_m_6l10 then
			self.parts.wpn_fps_upg_m_6l10.stats.spread = 0
			self.parts.wpn_fps_upg_m_6l10.stats.recoil = 2
			self.parts.wpn_fps_upg_m_6l10.stats.concealment = -1
			self.parts.wpn_fps_upg_m_6l10.stats.reload = 0
		end
		if self.parts.wpn_fps_upg_m_103 then
			self.parts.wpn_fps_upg_m_103.stats.spread = 0
			self.parts.wpn_fps_upg_m_103.stats.recoil = 1
			self.parts.wpn_fps_upg_m_103.stats.concealment = 1
			self.parts.wpn_fps_upg_m_103.stats.reload = 0
		end
		if self.parts.wpn_fps_upg_m_762pmag then
			self.parts.wpn_fps_upg_m_762pmag.stats.spread = 1
			self.parts.wpn_fps_upg_m_762pmag.stats.recoil = -1
			self.parts.wpn_fps_upg_m_762pmag.stats.concealment = 0
			self.parts.wpn_fps_upg_m_762pmag.stats.reload = 2
		end
		if self.parts.wpn_fps_upg_m_762rpk75 then
			self.parts.wpn_fps_upg_m_762rpk75.stats.spread = -3
			self.parts.wpn_fps_upg_m_762rpk75.stats.recoil = 4
			self.parts.wpn_fps_upg_m_762rpk75.stats.concealment = -5
			self.parts.wpn_fps_upg_m_762rpk75.stats.reload = -9
		end
		if self.parts.wpn_fps_upg_m_palm then
			self.parts.wpn_fps_upg_m_palm.stats.spread = 0
			self.parts.wpn_fps_upg_m_palm.stats.recoil = -1
			self.parts.wpn_fps_upg_m_palm.stats.concealment = 0
			self.parts.wpn_fps_upg_m_palm.stats.reload = 3
		end
		if self.parts.wpn_fps_upg_m_promagd then
			self.parts.wpn_fps_upg_m_promagd.stats.spread = -2
			self.parts.wpn_fps_upg_m_promagd.stats.recoil = 3
			self.parts.wpn_fps_upg_m_promagd.stats.concealment = -6
			self.parts.wpn_fps_upg_m_promagd.stats.reload = -8
		end
		if self.parts.wpn_fps_upg_m_rpk40 then
			self.parts.wpn_fps_upg_m_rpk40.stats.spread = -2
			self.parts.wpn_fps_upg_m_rpk40.stats.recoil = 2
			self.parts.wpn_fps_upg_m_rpk40.stats.concealment = -2
			self.parts.wpn_fps_upg_m_rpk40.stats.reload = -2
		end
		if self.parts.wpn_fps_upg_m_rpkbake then
			self.parts.wpn_fps_upg_m_rpkbake.stats.spread = -1
			self.parts.wpn_fps_upg_m_rpkbake.stats.recoil = 0
			self.parts.wpn_fps_upg_m_rpkbake.stats.concealment = -2
			self.parts.wpn_fps_upg_m_rpkbake.stats.reload = -2
		end
		if self.parts.wpn_fps_upg_m_x47 then
			self.parts.wpn_fps_upg_m_x47.stats.spread = -1
			self.parts.wpn_fps_upg_m_x47.stats.recoil = 2
			self.parts.wpn_fps_upg_m_x47.stats.concealment = -1
			self.parts.wpn_fps_upg_m_x47.stats.reload = -4
		end
		if self.parts.wpn_fps_upg_m_308pmag then
			self.parts.wpn_fps_upg_m_308pmag.stats.spread = 0
			self.parts.wpn_fps_upg_m_308pmag.stats.recoil = 0
			self.parts.wpn_fps_upg_m_308pmag.stats.concealment = 1
			self.parts.wpn_fps_upg_m_308pmag.stats.reload = 0
		end
		if self.parts.wpn_fps_upg_m_kac10 then
			self.parts.wpn_fps_upg_m_kac10.stats.spread = 0
			self.parts.wpn_fps_upg_m_kac10.stats.recoil = -2
			self.parts.wpn_fps_upg_m_kac10.stats.concealment = 2
			self.parts.wpn_fps_upg_m_kac10.stats.reload = 3
		end
		if self.parts.wpn_fps_upg_m_308dmmag then
			self.parts.wpn_fps_upg_m_308dmmag.override_weapon.AMMO_MAX = 60
			self.parts.wpn_fps_upg_m_308dmmag.override_weapon.CLIP_AMMO_MAX = 30
			self.parts.wpn_fps_upg_m_308dmmag.stats.damage = -140
			self.parts.wpn_fps_upg_m_308dmmag.stats.spread = -3
			self.parts.wpn_fps_upg_m_308dmmag.stats.recoil = 3
			self.parts.wpn_fps_upg_m_308dmmag.stats.concealment = -3
			self.parts.wpn_fps_upg_m_308dmmag.stats.reload = -3
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
			self.parts.wpn_fps_upg_m_celerity.stats.spread = -1
			self.parts.wpn_fps_upg_m_celerity.stats.recoil = 1
			self.parts.wpn_fps_upg_m_celerity.stats.concealment = -1
			self.parts.wpn_fps_upg_m_celerity.stats.reload = -3
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
			self.parts.wpn_fps_upg_m_d60boot.stats.reload = 4
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
			self.parts.wpn_fps_upg_m_mpx30.stats.concealment = -2
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
			self.parts.wpn_fps_upg_m_cap10.stats.spread = -3
			self.parts.wpn_fps_upg_m_cap10.stats.recoil = 4
			self.parts.wpn_fps_upg_m_cap10.stats.concealment = 1
			self.parts.wpn_fps_upg_m_cap10.stats.reload = 5
		end
		if self.parts.wpn_fps_upg_m_puf20 then
			self.parts.wpn_fps_upg_m_puf20.stats.spread = 2
			self.parts.wpn_fps_upg_m_puf20.stats.recoil = -2
			self.parts.wpn_fps_upg_m_puf20.stats.concealment = 0
			self.parts.wpn_fps_upg_m_puf20.stats.reload = 3
		end
		if self.parts.wpn_fps_upg_m_puf30 then
			self.parts.wpn_fps_upg_m_puf30.stats.spread = 1
			self.parts.wpn_fps_upg_m_puf30.stats.recoil = 0
			self.parts.wpn_fps_upg_m_puf30.stats.concealment = -1
			self.parts.wpn_fps_upg_m_puf30.stats.reload = 0
		end
		if self.parts.wpn_fps_upg_m_vityazpmag then
			self.parts.wpn_fps_upg_m_vityazpmag.stats.spread = 0
			self.parts.wpn_fps_upg_m_vityazpmag.stats.recoil = 1
			self.parts.wpn_fps_upg_m_vityazpmag.stats.concealment = 0
			self.parts.wpn_fps_upg_m_vityazpmag.stats.reload = 0
		end
		if self.parts.wpn_fps_upg_m_7drum then
			self.parts.wpn_fps_upg_m_7drum.stats.spread = -3
			self.parts.wpn_fps_upg_m_7drum.stats.recoil = 3
			self.parts.wpn_fps_upg_m_7drum.stats.concealment = -4
			self.parts.wpn_fps_upg_m_7drum.stats.reload = -7
		end
		if self.parts.wpn_fps_upg_m_max then
			self.parts.wpn_fps_upg_m_max.stats.spread = -3
			self.parts.wpn_fps_upg_m_max.stats.recoil = 3
			self.parts.wpn_fps_upg_m_max.stats.concealment = -4
			self.parts.wpn_fps_upg_m_max.stats.reload = -9
		end
		if self.parts.wpn_fps_upg_m_pro then
			self.parts.wpn_fps_upg_m_pro.stats.spread = -2
			self.parts.wpn_fps_upg_m_pro.stats.recoil = 1
			self.parts.wpn_fps_upg_m_pro.stats.concealment = -2
			self.parts.wpn_fps_upg_m_pro.stats.reload = -6
		end
		if self.parts.wpn_fps_upg_m_mk17 then
			self.parts.wpn_fps_upg_m_mk17.stats.spread = 1
			self.parts.wpn_fps_upg_m_mk17.stats.recoil = -1
			self.parts.wpn_fps_upg_m_mk17.stats.concealment = 1
			self.parts.wpn_fps_upg_m_mk17.stats.reload = 3
		end
		if self.parts.wpn_fps_upg_m_lanc then
			self.parts.wpn_fps_upg_m_lanc.stats.spread = 1
			self.parts.wpn_fps_upg_m_lanc.stats.recoil = 1
			self.parts.wpn_fps_upg_m_lanc.stats.concealment = 1
			self.parts.wpn_fps_upg_m_lanc.stats.reload = 0
		end
		if self.parts.wpn_fps_upg_m_dmmag then
			self.parts.wpn_fps_upg_m_dmmag.stats.spread = -1
			self.parts.wpn_fps_upg_m_dmmag.stats.recoil = 0
			self.parts.wpn_fps_upg_m_dmmag.stats.concealment = 0
			self.parts.wpn_fps_upg_m_dmmag.stats.reload = 2
		end
		if self.parts.wpn_fps_upg_m_54510s then
			self.parts.wpn_fps_upg_m_54510s.stats.spread = 0
			self.parts.wpn_fps_upg_m_54510s.stats.recoil = -3
			self.parts.wpn_fps_upg_m_54510s.stats.concealment = 2
			self.parts.wpn_fps_upg_m_54510s.stats.reload = 11
		end
		if self.parts.wpn_fps_upg_m_54520 then
			self.parts.wpn_fps_upg_m_54520.stats.spread = 2
			self.parts.wpn_fps_upg_m_54520.stats.recoil = -2
			self.parts.wpn_fps_upg_m_54520.stats.concealment = 1
			self.parts.wpn_fps_upg_m_54520.stats.reload = 5
		end
		if self.parts.wpn_fps_upg_m_54520d then
			self.parts.wpn_fps_upg_m_54520d.stats.spread = 1
			self.parts.wpn_fps_upg_m_54520d.stats.recoil = 0
			self.parts.wpn_fps_upg_m_54520d.stats.concealment = -2
			self.parts.wpn_fps_upg_m_54520d.stats.reload = 2
		end
		if self.parts.wpn_fps_upg_m_54520s then
			self.parts.wpn_fps_upg_m_54520s.stats.spread = 1
			self.parts.wpn_fps_upg_m_54520s.stats.recoil = -2
			self.parts.wpn_fps_upg_m_54520s.stats.concealment = 0
			self.parts.wpn_fps_upg_m_54520s.stats.reload = 8
		end
		if self.parts.wpn_fps_upg_m_54530d then
			self.parts.wpn_fps_upg_m_54530d.stats.spread = -2
			self.parts.wpn_fps_upg_m_54530d.stats.recoil = 1
			self.parts.wpn_fps_upg_m_54530d.stats.concealment = -3
			self.parts.wpn_fps_upg_m_54530d.stats.reload = 1
		end
		if self.parts.wpn_fps_upg_m_54530s then
			self.parts.wpn_fps_upg_m_54530s.stats.spread = -1
			self.parts.wpn_fps_upg_m_54530s.stats.recoil = 0
			self.parts.wpn_fps_upg_m_54530s.stats.concealment = -2
			self.parts.wpn_fps_upg_m_54530s.stats.reload = 4
		end
		if self.parts.wpn_fps_upg_m_fmgdrum then
			self.parts.wpn_fps_upg_m_fmgdrum.stats.spread = -2
			self.parts.wpn_fps_upg_m_fmgdrum.stats.recoil = 2
			self.parts.wpn_fps_upg_m_fmgdrum.stats.concealment = -3
			self.parts.wpn_fps_upg_m_fmgdrum.stats.reload = -4
		end
		if self.parts.wpn_fps_upg_m_g36_dura then
			self.parts.wpn_fps_upg_m_g36_dura.stats.spread = 0
			self.parts.wpn_fps_upg_m_g36_dura.stats.recoil = 0
			self.parts.wpn_fps_upg_m_g36_dura.stats.concealment = 1
			self.parts.wpn_fps_upg_m_g36_dura.stats.reload = 0
		end
		if self.parts.wpn_fps_upg_m_g36_d60 then
			self.parts.wpn_fps_upg_m_g36_d60.stats.spread = -1
			self.parts.wpn_fps_upg_m_g36_d60.stats.recoil = 1
			self.parts.wpn_fps_upg_m_g36_d60.stats.concealment = -3
			self.parts.wpn_fps_upg_m_g36_d60.stats.reload = -5
		end
		if self.parts.wpn_fps_upg_m_g36_p30 then
			self.parts.wpn_fps_upg_m_g36_p30.stats.spread = 1
			self.parts.wpn_fps_upg_m_g36_p30.stats.recoil = 1
			self.parts.wpn_fps_upg_m_g36_p30.stats.concealment = -2
			self.parts.wpn_fps_upg_m_g36_p30.stats.reload = 2
		end
		if self.parts.wpn_fps_upg_m_g36_p30w then
			self.parts.wpn_fps_upg_m_g36_p30w.stats.spread = 0
			self.parts.wpn_fps_upg_m_g36_p30w.stats.recoil = 2
			self.parts.wpn_fps_upg_m_g36_p30w.stats.concealment = -1
			self.parts.wpn_fps_upg_m_g36_p30w.stats.reload = 1
		end
		if self.parts.wpn_fps_upg_m_g36_p40 then
			self.parts.wpn_fps_upg_m_g36_p40.stats.spread = -1
			self.parts.wpn_fps_upg_m_g36_p40.stats.recoil = 0
			self.parts.wpn_fps_upg_m_g36_p40.stats.concealment = -2
			self.parts.wpn_fps_upg_m_g36_p40.stats.reload = -3
		end
		if self.parts.wpn_fps_upg_m_g36_battle then
			self.parts.wpn_fps_upg_m_g36_battle.stats.spread = 0
			self.parts.wpn_fps_upg_m_g36_battle.stats.recoil = 1
			self.parts.wpn_fps_upg_m_g36_battle.stats.concealment = 1
			self.parts.wpn_fps_upg_m_g36_battle.stats.reload = 0
		end
		if self.parts.wpn_fps_upg_m_g36_poly then
			self.parts.wpn_fps_upg_m_g36_poly.stats.spread = 3
			self.parts.wpn_fps_upg_m_g36_poly.stats.recoil = -1
			self.parts.wpn_fps_upg_m_g36_poly.stats.concealment = -1
			self.parts.wpn_fps_upg_m_g36_poly.stats.reload = 0
		end
		if self.parts.wpn_fps_upg_m_g36_hksteel then
			self.parts.wpn_fps_upg_m_g36_hksteel.stats.spread = 0
			self.parts.wpn_fps_upg_m_g36_hksteel.stats.recoil = 1
			self.parts.wpn_fps_upg_m_g36_hksteel.stats.concealment = 0
			self.parts.wpn_fps_upg_m_g36_hksteel.stats.reload = 0
		end
		if self.parts.wpn_fps_upg_m_g36_gen2 then
			self.parts.wpn_fps_upg_m_g36_gen2.stats.spread = 1
			self.parts.wpn_fps_upg_m_g36_gen2.stats.recoil = 1
			self.parts.wpn_fps_upg_m_g36_gen2.stats.concealment = 1
			self.parts.wpn_fps_upg_m_g36_gen2.stats.reload = 0
		end
		if self.parts.wpn_fps_upg_m_g36_lanc then
			self.parts.wpn_fps_upg_m_g36_lanc.stats.spread = 1
			self.parts.wpn_fps_upg_m_g36_lanc.stats.recoil = 1
			self.parts.wpn_fps_upg_m_g36_lanc.stats.concealment = 1
			self.parts.wpn_fps_upg_m_g36_lanc.stats.reload = 0
		end
		if self.parts.wpn_fps_upg_m_g36_dmmag then
			self.parts.wpn_fps_upg_m_g36_dmmag.stats.spread = -1
			self.parts.wpn_fps_upg_m_g36_dmmag.stats.recoil = 0
			self.parts.wpn_fps_upg_m_g36_dmmag.stats.concealment = 0
			self.parts.wpn_fps_upg_m_g36_dmmag.stats.reload = 2
		end
	end
	FrenchyAU_packs_stat_adjustments()
	
	-- barret m107cq
	if self.parts.wpn_fps_upg_m107cq_ammo_416 then
		self.parts.wpn_fps_upg_m107cq_ammo_416.stats.damage = -4025
	end
	
	-- VANILLA GAME WEAPON MODS
	
	-- vanilla non dlc muzzle devices
	self.parts.wpn_fps_upg_ns_ass_smg_tank.stats.recoil = 0
	self.parts.wpn_fps_upg_ns_ass_smg_tank.stats.spread = 2
	self.parts.wpn_fps_upg_ns_ass_smg_tank.stats.damage = 1
	self.parts.wpn_fps_upg_ns_ass_smg_tank.stats.concealment = -1
	self.parts.wpn_fps_upg_ns_ass_smg_tank.stats.suppression = -3
	
	self.parts.wpn_fps_upg_ns_ass_smg_firepig.stats.recoil = 1
	self.parts.wpn_fps_upg_ns_ass_smg_firepig.stats.spread = 1
	self.parts.wpn_fps_upg_ns_ass_smg_firepig.stats.damage = 4
	self.parts.wpn_fps_upg_ns_ass_smg_firepig.stats.suppression = 0
	
	-- AUG: black body that gives less concealment and better stats? no ty, base weapon stats were buffed a bit instead
	self.parts.wpn_fps_aug_body_f90.stats = {
		value = 1,
		concealment = 3,
		damage = -2,
		recoil = 1
	}
	-- mp5 stock that made no sense
	self.parts.wpn_fps_smg_mp5_s_folding.stats = {
		value = 1,
		concealment = 1,
		recoil = -1
	}
	-- mg42 barrel that is lighter but better in every way?
	self.parts.wpn_fps_lmg_mg42_b_mg34.stats = {
		value = 1,
		recoil = -1,
		damage = -1,
		spread = 3
	}
	-- so, this "taktika" AK foregrip is visually bigger then the 'keymod rail' yet has better concealment and worse stability? wtf
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
		concealment = -1
	}
	-- select fire mods
	self.parts.wpn_fps_upg_i_singlefire.stats = {
		spread = 2,
		recoil = -3,
		value = 5
	}
	self.parts.wpn_fps_upg_i_autofire.stats = {
		value = 8,
		damage = 4,
		spread = -3,
		recoil = 3
	}
	
	-- straight magazine
	self.parts.wpn_fps_upg_m4_m_straight.stats = {
		value = 2,
		concealment = 1,
		reload = 3,
		extra_ammo = -4
	}
	
	-- all sight's stats are now 0 cuz they should be chosen based on personal preference and not stats
	for id, _table_ in pairs(self.parts) do
		if self.parts[id].type then
			if self.parts[id].type == "sight" then
				if self.parts[id].stats then
					if self.parts[id].stats.recoil or self.parts[id].stats.spread then
						if self.parts[id].stats.recoil ~= 0 or self.parts[id].stats.spread ~= 0 then
							self.parts[id].stats.recoil = 0
							self.parts[id].stats.spread = 0
						end
					end
				end
			end
		end
	end
	
	-- no no, + 2 conceal for free is bad overkill, no
	self.parts.wpn_fps_upg_o_mbus_rear.stats.spread = -2
	self.parts.wpn_fps_upg_o_mbus_rear.stats.recoil = -1
	
	-- secondary sights
	self.parts.wpn_fps_upg_o_45rds_v2.stats.spread = 0
	self.parts.wpn_fps_upg_o_45rds_v2.stats.recoil = 1
	self.parts.wpn_fps_upg_o_45rds_v2.stats.concealment = -1
	
	self.parts.wpn_fps_upg_o_xpsg33_magnifier.stats.spread = 1
	self.parts.wpn_fps_upg_o_xpsg33_magnifier.stats.recoil = 0
	self.parts.wpn_fps_upg_o_xpsg33_magnifier.stats.concealment = -1
	
	self.parts.wpn_fps_upg_o_45rds.stats.spread = 0
	self.parts.wpn_fps_upg_o_45rds.stats.recoil = 1
	self.parts.wpn_fps_upg_o_45rds.stats.concealment = -1
	
	self.parts.wpn_fps_upg_o_45steel.stats.spread = 0
	self.parts.wpn_fps_upg_o_45steel.stats.recoil = -1
	self.parts.wpn_fps_upg_o_45steel.stats.concealment = 0
	
	self.parts.wpn_fps_upg_o_sig.stats.spread = 1
	self.parts.wpn_fps_upg_o_sig.stats.recoil = 0
	self.parts.wpn_fps_upg_o_sig.stats.concealment = -1
end)

Hooks:PostHook(WeaponFactoryTweakData, "_init_mp5", "newwpnstats_mp5", function(self, ...)
	self.parts.wpn_fps_smg_mp5_m_straight.stats = {
		extra_ammo = -2.5,
		damage = 64,
		spread = -8,
		spread_moving = -8,
		recoil = -14,
		total_ammo_mod = -6,
		reload = 2,
		concealment = -6,
	}
	self.parts.wpn_fps_smg_mp5_m_straight.custom_stats = {
		ammo_pickup_min_mul = 0.8,
		ammo_pickup_max_mul = 0.8
	}
	self.parts.wpn_fps_smg_mp5_m_straight.name_id = "bm_wpn_fps_smg_mp5_m_straight_R"
end)

Hooks:PostHook(WeaponFactoryTweakData, "_init_x_mp5", "newwpnstats_x_mp5", function(self, ...)
	self.wpn_fps_smg_x_mp5.override.wpn_fps_smg_mp5_m_straight.stats = {
		extra_ammo = -5,
		damage = 64,
		spread = -8,
		spread_moving = -8,
		recoil = -14,
		total_ammo_mod = -5,
		reload = 2,
		concealment = -6,
	}
end)

Hooks:PostHook(WeaponFactoryTweakData, "_init_shak12", "newwpnstats_ash12", function(self, ...)
	self.parts.wpn_fps_ass_shak12_body_vks.stats = {
			total_ammo_mod = -5,
			concealment = -2,
			recoil = -6,
			value = 6,
			fire_rate = 0.6,
	}
	self.parts.wpn_fps_ass_shak12_body_vks.type = "ammo"
	self.parts.wpn_fps_ass_shak12_body_vks.custom_stats = {
		ammo_pickup_max_mul = 0.73,
		ammo_pickup_min_mul = 0.73,
		fire_rate_multiplier = 0.6,
		armor_piercing_add = 1,
		can_shoot_through_shield = true,
		can_shoot_through_wall = true,
	}
	self.parts.wpn_fps_ass_shak12_body_vks.name_id = "wpn_fps_ass_shak12_body_vks_R"
	self.parts.wpn_fps_ass_shak12_body_vks.desc_id = "bm_wpn_fps_anynewassaultkit_desc"
end)

Hooks:PostHook(WeaponFactoryTweakData, "_init_flamethrower_mk2", "newwpnstats_flamenprimary", function(self, ...)
	--we will make different mags have different afterburn damage on top of other stuff
	--so we have to make base flamethrower have no afterburn, and add those stats to it's deafault mag
	
	-- rare mag
	self.parts.wpn_fps_fla_mk2_mag_rare.type = "ammo"
	self.parts.wpn_fps_fla_mk2_mag_rare.desc_id = "bm_wpn_fps_fla_mk2_mag_rare_desc"
	self.parts.wpn_fps_fla_mk2_mag_rare.custom_stats = {
		bullet_class = "FlameBulletBase",
		fire_dot_data = {
				dot_trigger_chance = "75",
				dot_damage = "14",
				dot_length = "3.1",
				dot_trigger_max_distance = "3000",
				dot_tick_period = "0.25"
			}
	}
	self.parts.wpn_fps_fla_mk2_mag_rare.stats = {
		value = 1,
		total_ammo_mod = 10,
		damage = -34
	}
	
	-- base mag
	self.parts.wpn_fps_fla_mk2_mag.type = "ammo"
	self.parts.wpn_fps_fla_mk2_mag.custom_stats = {
		bullet_class = "FlameBulletBase",
		fire_dot_data = {
				dot_trigger_chance = "25",
				dot_damage = "6",
				dot_length = "2.1",
				dot_trigger_max_distance = "3000",
				dot_tick_period = "0.25"
			}
	}
	
	--well done mag
	self.parts.wpn_fps_fla_mk2_mag_welldone.type = "ammo"
	self.parts.wpn_fps_fla_mk2_mag_welldone.desc_id = "bm_wpn_fps_fla_mk2_mag_welldone_desc"
	self.parts.wpn_fps_fla_mk2_mag_welldone.custom_stats = {
		bullet_class = "FlameBulletBase",
		fire_dot_data = {
				dot_trigger_chance = "5",
				dot_damage = "3",
				dot_length = "1.1",
				dot_trigger_max_distance = "3000",
				dot_tick_period = "0.25"
			}
	}
	self.parts.wpn_fps_fla_mk2_mag_welldone.stats = {
		value = 1,
		total_ammo_mod = -5,
		damage = 35
	}
end)

Hooks:PostHook(WeaponFactoryTweakData, "_init_system", "newwpnstats_flamensecondary", function(self, ...)
	--high temp mix
	self.parts.wpn_fps_fla_system_m_high.type = "ammo"
	self.parts.wpn_fps_fla_system_m_high.desc_id = "bm_wpn_fps_fla_mk2_mag_welldone_desc" -- has same stats so use same description
	self.parts.wpn_fps_fla_system_m_high.custom_stats = {
		bullet_class = "FlameBulletBase",
		fire_dot_data = {
				dot_trigger_chance = "5",
				dot_damage = "3",
				dot_length = "1.1",
				dot_trigger_max_distance = "3000",
				dot_tick_period = "0.25"
			}
	}
	self.parts.wpn_fps_fla_system_m_high.stats = {
		value = 1,
		total_ammo_mod = -5,
		damage = 25
	}
	--low temp mix
	self.parts.wpn_fps_fla_system_m_low.type = "ammo"
	self.parts.wpn_fps_fla_system_m_low.desc_id = "bm_wpn_fps_fla_mk2_mag_rare_desc"
	self.parts.wpn_fps_fla_system_m_low.custom_stats = {
		bullet_class = "FlameBulletBase",
		fire_dot_data = {
				dot_trigger_chance = "75",
				dot_damage = "14",
				dot_length = "3.1",
				dot_trigger_max_distance = "3000",
				dot_tick_period = "0.25"
			}
	}
	self.parts.wpn_fps_fla_system_m_low.stats = {
		value = 1,
		total_ammo_mod = 10,
		damage = -24
	}
	-- base mag
	self.parts.wpn_fps_fla_system_m_standard.type = "ammo"
	self.parts.wpn_fps_fla_system_m_standard.custom_stats = {
		bullet_class = "FlameBulletBase",
		fire_dot_data = {
				dot_trigger_chance = "25",
				dot_damage = "6",
				dot_length = "2.1",
				dot_trigger_max_distance = "3000",
				dot_tick_period = "0.25"
			}
	}
end)

Hooks:PostHook(WeaponFactoryTweakData, "_init_ms3gl", "newwpnstats_3rburstGL", function(self, ...)
	self.parts.wpn_fps_gre_ms3gl_conversion.stats.damage = -366
end)

Hooks:PostHook(WeaponFactoryTweakData, "_init_hunter", "newwpnstats_pistolcrossbow", function(self, ...)
	self.parts.wpn_fps_bow_hunter_m_standard.custom_stats = {
		armor_piercing_add = 1,
	}
	self.parts.wpn_fps_upg_a_crossbow_poison.stats = {
		total_ammo_mod = -6
	}
	self.parts.wpn_fps_upg_a_crossbow_poison.custom_stats = {
		armor_piercing_add = 1,
	}
	self.parts.wpn_fps_upg_a_crossbow_explosion.stats = {
		damage = 72,
		total_ammo_mod = -6
	}
end)

Hooks:PostHook(WeaponFactoryTweakData, "_init_frankish", "newwpnstats_lightcrossbow", function(self, ...)
	self.parts.wpn_fps_bow_frankish_m_standard.custom_stats = {
		armor_piercing_add = 1,
	}
	self.parts.wpn_fps_bow_frankish_m_poison.stats = {
		total_ammo_mod = -6
	}
	self.parts.wpn_fps_bow_frankish_m_poison.custom_stats = {
		armor_piercing_add = 1,
	}
	self.parts.wpn_fps_bow_frankish_m_explosive.stats = {
		damage = 72,
		total_ammo_mod = -6
	}
end)

Hooks:PostHook(WeaponFactoryTweakData, "_init_plainsrider", "newwpnstats_lightbow", function(self, ...)
	self.parts.wpn_fps_bow_plainsrider_m_standard.custom_stats = {
		armor_piercing_add = 1,
	}
	self.parts.wpn_fps_upg_a_bow_poison.stats = {
		total_ammo_mod = -6,
	}
	self.parts.wpn_fps_upg_a_bow_poison.custom_stats = {
		armor_piercing_add = 1
	}
	self.parts.wpn_fps_upg_a_bow_explosion.stats = {
		damage = 72,
		total_ammo_mod = -6
	}
end)

Hooks:PostHook(WeaponFactoryTweakData, "_init_long", "newwpnstats_longbow", function(self, ...)
	self.parts.wpn_fps_bow_long_m_standard.custom_stats = {
		armor_piercing_add = 1,
	}
	self.parts.wpn_fps_bow_long_m_poison.stats = {
		damage = -20,
		total_ammo_mod = -6
	}
	self.parts.wpn_fps_bow_long_m_poison.custom_stats = {
		armor_piercing_add = 1,
	}
	self.parts.wpn_fps_bow_long_m_explosive.stats = {
		damage = 100,
		total_ammo_mod = -6
	}
end)

Hooks:PostHook(WeaponFactoryTweakData, "_init_elastic", "newwpnstats_longbow_free", function(self, ...)
	self.parts.wpn_fps_bow_elastic_m_standard.custom_stats = {
		armor_piercing_add = 1,
	}
	self.parts.wpn_fps_bow_elastic_m_poison.stats = {
		damage = -20,
		total_ammo_mod = -6
	}
	self.parts.wpn_fps_bow_elastic_m_poison.custom_stats = {
		armor_piercing_add = 1,
	}
	self.parts.wpn_fps_bow_elastic_m_explosive.stats = {
		damage = 100,
		total_ammo_mod = -6
	}
end)

Hooks:PostHook(WeaponFactoryTweakData, "_init_arblast", "newwpnstats_heavycrossbow", function(self, ...)
	self.parts.wpn_fps_bow_arblast_m_standard.custom_stats = {
		armor_piercing_add = 1,
	}
	self.parts.wpn_fps_bow_arblast_m_poison.stats = {
		damage = -20,
		total_ammo_mod = -6
	}
	self.parts.wpn_fps_bow_arblast_m_poison.custom_stats = {
		armor_piercing_add = 1,
	}
	self.parts.wpn_fps_bow_arblast_m_explosive.stats = {
		damage = 100,
		total_ammo_mod = -6
	}
end)

Hooks:PostHook(WeaponFactoryTweakData, "_init_ecp", "newwpnstats_h3h3garbage", function(self, ...)
	self.parts.wpn_fps_bow_ecp_m_arrows_standard.custom_stats = {
		armor_piercing_add = 1,
	}
	self.parts.wpn_fps_bow_ecp_m_arrows_poison.stats = {
		total_ammo_mod = -6
	}
	self.parts.wpn_fps_bow_ecp_m_arrows_poison.custom_stats = {
		armor_piercing_add = 1,
	}
	self.parts.wpn_fps_bow_ecp_m_arrows_explosive.stats = {
		damage = 56,
		total_ammo_mod = -6
	}
end)

Hooks:PostHook(WeaponFactoryTweakData, "create_ammunition", "newwpnstats_updategrenadebmgui", function(self, ...)
	self.parts.wpn_fps_upg_a_grenade_launcher_incendiary.stats.damage = -399
	self.parts.wpn_fps_upg_a_grenade_launcher_incendiary_ms3gl.stats.damage = -399
	self.parts.wpn_fps_upg_a_grenade_launcher_incendiary_arbiter.stats.damage = -199
	self.parts.wpn_fps_upg_a_grenade_launcher_incendiary_ms3gl.desc_id = "bm_wpn_fps_upg_a_grenade_launcher_incendiary_desc"
	self.parts.wpn_fps_upg_a_grenade_launcher_incendiary_arbiter.desc_id = "bm_wpn_fps_upg_a_grenade_launcher_incendiary_arbiter_desc"
	self.parts.wpn_fps_upg_a_grenade_launcher_incendiary.desc_id = "bm_wpn_fps_upg_a_grenade_launcher_incendiary_desc"
	self.parts.wpn_fps_upg_a_grenade_launcher_incendiary_arbiter.custom_stats = {
		launcher_grenade = "launcher_incendiary_arbiter",
		ammo_pickup_max_mul = 0.35,
		ammo_pickup_min_mul = 0.35,
		}
	self.parts.wpn_fps_upg_a_grenade_launcher_incendiary.custom_stats = {
		launcher_grenade = "launcher_incendiary",
		ammo_pickup_max_mul = 0.35,
		ammo_pickup_min_mul = 0.35,
	}
	self.parts.wpn_fps_upg_a_grenade_launcher_incendiary_ms3gl.custom_stats = {
		launcher_grenade = "launcher_incendiary",
		ammo_pickup_min_mul = 0.15, -- why the fuck is base 'low' pick up higher then average on this gun anyway? base max is the same. can't you just make good looking guns instead of pimping up stats for new dlc's overkill?
		ammo_pickup_max_mul = 0.35,
	}
	
	self.parts.wpn_fps_upg_a_grenade_launcher_poison.stats.damage = -380
	self.parts.wpn_fps_upg_a_grenade_launcher_poison_ms3gl.stats.damage = -380
	
	self.parts.wpn_fps_upg_a_grenade_launcher_poison_arbiter.stats.damage = -180
	
	self.parts.wpn_fps_gre_ms3gl_conversion_grenade_poison.stats.damage = -366
	self.parts.wpn_fps_upg_a_grenade_launcher_poison.desc_id = "bm_wpn_fps_upg_a_grenade_launcher_poison_desc"
	self.parts.wpn_fps_upg_a_grenade_launcher_poison_ms3gl.desc_id = "bm_wpn_fps_upg_a_grenade_launcher_poison_desc"
	self.parts.wpn_fps_upg_a_grenade_launcher_poison_arbiter.desc_id = "bm_wpn_fps_upg_a_grenade_launcher_poison_arbiter_desc"
	self.parts.wpn_fps_upg_a_underbarrel_poison.desc_id = "bm_wpn_fps_upg_a_grenade_launcher_poison_desc"
	
	self.parts.wpn_fps_upg_a_grenade_launcher_electric.stats.damage = -320
	self.parts.wpn_fps_upg_a_grenade_launcher_electric_ms3gl.stats.damage = -320
	self.parts.wpn_fps_upg_a_grenade_launcher_electric_arbiter.stats.damage = -170
	
	-- new nade
	self.parts.wpn_fps_upg_a_grenade_launcher_velocity = deep_clone(self.parts.wpn_fps_upg_a_grenade_launcher_incendiary)
	self.parts.wpn_fps_upg_a_grenade_launcher_velocity.dlc = nil
	self.parts.wpn_fps_upg_a_grenade_launcher_velocity.texture_bundle_folder = "Gilza"
	self.parts.wpn_fps_upg_a_grenade_launcher_velocity.is_a_unlockable = false
	self.parts.wpn_fps_upg_a_grenade_launcher_velocity.drop = false
	self.parts.wpn_fps_upg_a_grenade_launcher_velocity.name_id = "bm_wp_upg_a_grenade_launcher_velocity"
	self.parts.wpn_fps_upg_a_grenade_launcher_velocity.desc_id = "bm_wp_upg_a_grenade_launcher_velocity_desc"
	self.parts.wpn_fps_upg_a_grenade_launcher_velocity.stats = {}
	self.parts.wpn_fps_upg_a_grenade_launcher_velocity.custom_stats = {launcher_grenade = "launcher_velocity"}
	self.parts.wpn_fps_upg_a_grenade_launcher_velocity.sub_type = "ammo_explosive"
	self.parts.wpn_fps_upg_a_grenade_launcher_velocity.override = {
		wpn_fps_gre_m32_mag = {
			unit = "units/pd2_dlc_bbq/weapons/wpn_fps_gre_m32_pts/wpn_fps_gre_m32_mag"
		},
		wpn_fps_gre_m79_grenade = {
			unit = "units/pd2_dlc_gage_assault/weapons/wpn_fps_gre_m79_pts/wpn_fps_gre_m79_grenade"
		},
		wpn_fps_gre_m79_grenade_whole = {
			unit = "units/pd2_dlc_lupus/weapons/wpn_fps_gre_china_pts/wpn_fps_gre_m79_grenade_whole"
		}
	}
	
	local weapons = {
		"wpn_fps_gre_m79",
		"wpn_fps_gre_m32",
		"wpn_fps_gre_china",
		"wpn_fps_gre_slap"
	}

	for _, factory_id in ipairs(weapons) do
		if self[factory_id] and self[factory_id].uses_parts then
			table.insert(self[factory_id].uses_parts, "wpn_fps_upg_a_grenade_launcher_velocity")
			--table.insert(self[factory_id .. "_npc"].uses_parts, "wpn_fps_upg_a_grenade_launcher_velocity")
		end
	end

	--###############################################################################################################################################################--
	--####################################################################### SHOTGUN ROUNDS ########################################################################--
	--###############################################################################################################################################################--
	--###############################################################################################################################################################--
	
	local double_barrels = {
		"wpn_fps_shot_b682",
		"wpn_fps_shot_huntsman",
		"wpn_fps_sho_coach"
	}
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
	local semi_auto = {
		"wpn_fps_sho_spas12",
		"wpn_fps_sho_ben",
		"wpn_fps_sho_striker",
		"wpn_fps_sho_ultima",
		"wpn_fps_pis_judge",
		"wpn_fps_pis_x_judge"
	}
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

	-- HE slug
	local HE_custom_stats = {
		ignore_statistic = true,
		damage_far_mul = 1,
		damage_near_mul = 1,
		bullet_class = "InstantExplosiveBulletBase",
		rays = 1,
		ammo_pickup_max_mul = 0.4,
		ammo_pickup_min_mul = 0.4
	}
	
	-- Double barrel HE convert
	for i=1, #double_barrels do
		self[double_barrels[i]].override.wpn_fps_upg_a_explosive.stats = {
			value = 5,
			total_ammo_mod = -10,
			damage = 1350,
			recoil = -25
		}
		self[double_barrels[i]].override.wpn_fps_upg_a_explosive.custom_stats = HE_custom_stats
	end
	
	-- PA HE convert
	local PAHEstats = {
		value = 5,
		total_ammo_mod = -10,
		damage = 450,
		recoil = -25
	}
	for i=1, #pump_action do
		if self[pump_action[i]].override then
			if self[pump_action[i]].override.wpn_fps_upg_a_explosive then
				self[pump_action[i]].override.wpn_fps_upg_a_explosive.stats = PAHEstats
				self[pump_action[i]].override.wpn_fps_upg_a_explosive.custom_stats = HE_custom_stats
			else
				self[pump_action[i]].override["wpn_fps_upg_a_explosive"] = {stats = PAHEstats,custom_stats = HE_custom_stats}
			end
		else
			self[pump_action[i]].override = {wpn_fps_upg_a_explosive = {stats = PAHEstats,custom_stats = HE_custom_stats}}
		end
	end
	
	-- SA HE convert
	local SAHEstats = {
		value = 5,
		total_ammo_mod = -10,
		damage = 395,
		recoil = -25
	}
	for i=1, #semi_auto do
		if self[semi_auto[i]].override then
			if self[semi_auto[i]].override.wpn_fps_upg_a_explosive then
				self[semi_auto[i]].override.wpn_fps_upg_a_explosive.stats = SAHEstats
				self[semi_auto[i]].override.wpn_fps_upg_a_explosive.custom_stats = HE_custom_stats
			else
				self[semi_auto[i]].override["wpn_fps_upg_a_explosive"] = {stats = SAHEstats,custom_stats = HE_custom_stats}
			end
		else
			self[semi_auto[i]].override = {wpn_fps_upg_a_explosive = {stats = SAHEstats,custom_stats = HE_custom_stats}}
		end
	end
	
	-- FA HE convert
	local FAHEstats = {
		value = 5,
		total_ammo_mod = -10,
		damage = 130,
		recoil = -25
	}
	for i=1, #full_auto do
		if self[full_auto[i]].override then
			if self[full_auto[i]].override.wpn_fps_upg_a_explosive then
				self[full_auto[i]].override.wpn_fps_upg_a_explosive.stats = FAHEstats
				self[full_auto[i]].override.wpn_fps_upg_a_explosive.custom_stats = HE_custom_stats
			else
				self[full_auto[i]].override["wpn_fps_upg_a_explosive"] = {stats = FAHEstats,custom_stats = HE_custom_stats}
			end
		else
			self[full_auto[i]].override = {wpn_fps_upg_a_explosive = {stats = FAHEstats,custom_stats = HE_custom_stats}}
		end
	end
	self.parts.wpn_fps_upg_a_explosive.desc_id = "bm_wpn_fps_upg_a_explosive_desc_new"
	
	-- BUCKSHOT
	local BS_custom_stats = {
		damage_far_mul = 1,
		damage_near_mul = 1,
		ammo_pickup_max_mul = 0.8,
		ammo_pickup_min_mul = 0.8
	}
	self.parts.wpn_fps_upg_a_custom.desc_id = "bm_wpn_fps_upg_a_custom_desc_new"
	self.parts.wpn_fps_upg_a_custom_free.desc_id = "bm_wpn_fps_upg_a_custom_desc_new"
	
	-- what a fucking shit show
	-- Double barrel BUCKSHOT convert
	for i=1, #double_barrels do
		if self[double_barrels[i]].override then
			if self[double_barrels[i]].override.wpn_fps_upg_a_custom and self[double_barrels[i]].override.wpn_fps_upg_a_custom_free then
				self[double_barrels[i]].override.wpn_fps_upg_a_custom.stats = {damage = 350}
				self[double_barrels[i]].override.wpn_fps_upg_a_custom.custom_stats = BS_custom_stats
				self[double_barrels[i]].override.wpn_fps_upg_a_custom_free.stats = {damage = 350}
				self[double_barrels[i]].override.wpn_fps_upg_a_custom_free.custom_stats = BS_custom_stats
			else
				self[double_barrels[i]].override["wpn_fps_upg_a_custom"] = {stats = {damage = 350},custom_stats = BS_custom_stats}
				self[double_barrels[i]].override["wpn_fps_upg_a_custom_free"] = {stats = {damage = 350},custom_stats = BS_custom_stats}
			end
		else
			self[double_barrels[i]].override = {wpn_fps_upg_a_custom = {stats = {damage = 350},custom_stats = BS_custom_stats}}
			self[double_barrels[i]].override = {wpn_fps_upg_a_custom_free = {stats = {damage = 350},custom_stats = BS_custom_stats}}
		end
	end
	
	-- PA BUCKSHOT convert
	for i=1, #pump_action do
		if self[pump_action[i]].override then
			if self[pump_action[i]].override.wpn_fps_upg_a_custom and self[pump_action[i]].override.wpn_fps_upg_a_custom_free then
				self[pump_action[i]].override.wpn_fps_upg_a_custom.stats = {damage = 140}
				self[pump_action[i]].override.wpn_fps_upg_a_custom.custom_stats = BS_custom_stats
				self[pump_action[i]].override.wpn_fps_upg_a_custom_free.stats = {damage = 140}
				self[pump_action[i]].override.wpn_fps_upg_a_custom_free.custom_stats = BS_custom_stats
			else
				self[pump_action[i]].override["wpn_fps_upg_a_custom"] = {stats = {damage = 140},custom_stats = BS_custom_stats}
				self[pump_action[i]].override["wpn_fps_upg_a_custom_free"] = {stats = {damage = 140},custom_stats = BS_custom_stats}
			end
		else
			self[pump_action[i]].override = {wpn_fps_upg_a_custom = {stats = {damage = 140},custom_stats = BS_custom_stats}}
			self[pump_action[i]].override = {wpn_fps_upg_a_custom_free = {stats = {damage = 140},custom_stats = BS_custom_stats}}
		end
	end
	
	-- SA BUCKSHOT convert
	for i=1, #semi_auto do
		if self[semi_auto[i]].override then
			if self[semi_auto[i]].override.wpn_fps_upg_a_custom and self[semi_auto[i]].override.wpn_fps_upg_a_custom_free then
				self[semi_auto[i]].override.wpn_fps_upg_a_custom.stats = {damage = 90}
				self[semi_auto[i]].override.wpn_fps_upg_a_custom.custom_stats = BS_custom_stats
				self[semi_auto[i]].override.wpn_fps_upg_a_custom_free.stats = {damage = 90}
				self[semi_auto[i]].override.wpn_fps_upg_a_custom_free.custom_stats = BS_custom_stats
			else
				self[semi_auto[i]].override["wpn_fps_upg_a_custom"] = {stats = {damage = 90},custom_stats = BS_custom_stats}
				self[semi_auto[i]].override["wpn_fps_upg_a_custom_free"] = {stats = {damage = 90},custom_stats = BS_custom_stats}
			end
		else
			self[semi_auto[i]].override = {wpn_fps_upg_a_custom = {stats = {damage = 90},custom_stats = BS_custom_stats}}
			self[semi_auto[i]].override = {wpn_fps_upg_a_custom_free = {stats = {damage = 90},custom_stats = BS_custom_stats}}
		end
	end
	
	-- FA BUCKSHOT convert
	for i=1, #full_auto do
		if self[full_auto[i]].override then
			if self[full_auto[i]].override.wpn_fps_upg_a_custom and self[full_auto[i]].override.wpn_fps_upg_a_custom_free then
				self[full_auto[i]].override.wpn_fps_upg_a_custom.stats = {damage = 40}
				self[full_auto[i]].override.wpn_fps_upg_a_custom.custom_stats = BS_custom_stats
				self[full_auto[i]].override.wpn_fps_upg_a_custom_free.stats = {damage = 40}
				self[full_auto[i]].override.wpn_fps_upg_a_custom_free.custom_stats = BS_custom_stats
			else
				self[full_auto[i]].override["wpn_fps_upg_a_custom"] = {stats = {damage = 40},custom_stats = BS_custom_stats}
				self[full_auto[i]].override["wpn_fps_upg_a_custom_free"] = {stats = {damage = 40},custom_stats = BS_custom_stats}
			end
		else
			self[full_auto[i]].override = {wpn_fps_upg_a_custom = {stats = {damage = 40},custom_stats = BS_custom_stats}}
			self[full_auto[i]].override = {wpn_fps_upg_a_custom_free = {stats = {damage = 40},custom_stats = BS_custom_stats}}
		end
	end
	
	-- SLUG
	self.parts.wpn_fps_upg_a_slug.stats = {
		value = 5,
		total_ammo_mod = -6
	}
	self.parts.wpn_fps_upg_a_slug.custom_stats.ammo_pickup_max_mul = 0.75
	self.parts.wpn_fps_upg_a_slug.custom_stats.ammo_pickup_min_mul = 0.75
	self.parts.wpn_fps_upg_a_slug.desc_id = "bm_wpn_fps_upg_a_slug_desc_new"
	
	-- FLECHETTE
	self.parts.wpn_fps_upg_a_piercing.stats = {
		value = 5
	}
	self.parts.wpn_fps_upg_a_piercing.custom_stats.rays = 5
	self.parts.wpn_fps_upg_a_piercing.desc_id = "bm_wpn_fps_upg_a_piercing_desc_new"
	
	-- FIRE
	self.parts.wpn_fps_upg_a_dragons_breath.stats = {
		value = 5,
		total_ammo_mod = -10,
		damage = 7,
		moving_spread = -7,
		spread = -5
	}
	self.parts.wpn_fps_upg_a_dragons_breath.custom_stats.rays = 6
	self.parts.wpn_fps_upg_a_dragons_breath.custom_stats.ammo_pickup_max_mul = 0.2
	self.parts.wpn_fps_upg_a_dragons_breath.custom_stats.ammo_pickup_min_mul = 0.2
	self.parts.wpn_fps_upg_a_dragons_breath.custom_stats.fire_dot_data = {
		dot_trigger_chance = "100",
		dot_damage = "23",
		dot_length = "3.1",
		dot_trigger_max_distance = "900",
		dot_tick_period = "0.5"
	}
	self.parts.wpn_fps_upg_a_dragons_breath.desc_id = "bm_wpn_fps_upg_a_dragons_breath_desc_new"
	
	-- TOXIC SLUG
	self.parts.wpn_fps_upg_a_rip.stats = {
		value = 5,
		total_ammo_mod = -7,
	}
	self.parts.wpn_fps_upg_a_rip.custom_stats.ammo_pickup_max_mul = 0.8
	self.parts.wpn_fps_upg_a_rip.custom_stats.ammo_pickup_min_mul = 0.8
	self.parts.wpn_fps_upg_a_rip.custom_stats.dot_data.custom_data = {
		hurt_animation_chance = 1,
		dot_damage = 10,
		dot_length = 2.1,
		use_weapon_damage_falloff = true,
		dot_tick_period = 0.5
	}
	self.parts.wpn_fps_upg_a_rip.desc_id = "bm_wpn_fps_upg_a_rip_desc_new"
	
	--###############################################################################################################################################################--
	--###############################################################################################################################################################--
	--###############################################################################################################################################################--
	--###############################################################################################################################################################--
end)

Hooks:PostHook(WeaponFactoryTweakData, "_init_content_jobs", "newwpnstats_bigmagz", function(self, ...)
	self.parts.wpn_fps_upg_m4_m_quad.stats = {
		extra_ammo = 15,
		value = 3,
		recoil = 1,
		spread = -1,
		concealment = -3,
		spread_moving = -2,
		reload = -5
	}
	self.parts.wpn_fps_upg_ak_m_quad.stats = {
		extra_ammo = 15,
		value = 3,
		recoil = 1,
		spread = -1,
		concealment = -3,
		spread_moving = -2,
		reload = -5
	}
end)

Hooks:PostHook(WeaponFactoryTweakData, "_init_fal", "newwpnstats_bigmagforfal", function(self, ...)
	self.parts.wpn_fps_ass_fal_m_01.stats = {
		extra_ammo = 10,
		value = 2,
		spread = -1,
		recoil = 1,
		concealment = -2,
		spread_moving = -2,
		reload = -5
	}
end)

Hooks:PostHook(WeaponFactoryTweakData, "_init_aa12", "newwpnstats_bigmagforaa12", function(self, ...)
	self.parts.wpn_fps_sho_aa12_mag_drum.stats = {
		extra_ammo = 6,
		value = 1,
		concealment = -4,
		reload = -3
	}
end)

Hooks:PostHook(WeaponFactoryTweakData, "_init_shepheard", "newwpnstats_mcxmag", function(self, ...)
	self.parts.wpn_fps_smg_shepheard_mag_extended.stats = {
		value = 1,
		extra_ammo = 7,
		reload = -3
	}
end)

Hooks:PostHook(WeaponFactoryTweakData, "_init_modpack_m4_ak", "newwpnstats_m4akdmrkits", function(self, ...)
	--m4 dmr kit
	self.parts.wpn_fps_upg_ass_m4_b_beowulf.stats = {
		spread = 3,
		total_ammo_mod = -6,
		concealment = -5,
		value = 1,
		recoil = -7
	}
	self.parts.wpn_fps_upg_ass_m4_b_beowulf.custom_stats = {
		armor_piercing_add = 1,
		can_shoot_through_shield = true,
		can_shoot_through_wall = true,
		ammo_pickup_max_mul = 0.56,
		ammo_pickup_min_mul = 0.56,
	}
	
	self.parts.wpn_fps_upg_ass_m4_b_beowulf.name_id = "bm_wpn_fps_upg_ass_m4_b_beowulf_newname"
	self.parts.wpn_fps_upg_ass_m4_b_beowulf.type = "ammo"
	self.parts.wpn_fps_upg_ass_m4_b_beowulf.desc_id = "bm_wpn_fps_anynewassaultkit_desc"
	self.parts.wpn_fps_upg_ass_m4_b_beowulf.forbids = {
		"wpn_fps_m4_uupg_b_short",
		"wpn_fps_m4_uupg_b_sd",
		"wpn_fps_m4_uupg_b_long",
		"wpn_fps_m4_uupg_b_sd",
		
		"wpn_fps_upg_ns_ass_smg_large",
		"wpn_fps_upg_ns_ass_smg_medium",
		"wpn_fps_upg_ns_ass_smg_small",
		"wpn_fps_upg_ns_ass_smg_firepig",
		"wpn_fps_upg_ns_ass_smg_stubby",
		"wpn_fps_upg_ns_ass_smg_tank",
		"wpn_fps_upg_ass_ns_jprifles",
		"wpn_fps_upg_ass_ns_linear",
		"wpn_fps_upg_ass_ns_surefire",
		"wpn_fps_upg_ass_ns_battle",
		"wpn_fps_upg_ns_ass_smg_v6",
		"wpn_fps_lmg_hk51b_ns_jcomp",
		"wpn_fps_ass_shak12_ns_suppressor",
		"wpn_fps_ass_shak12_ns_muzzle",
		"wpn_fps_lmg_kacchainsaw_ns_muzzle",
		"wpn_fps_lmg_kacchainsaw_ns_suppressor"
	}
	
	--ak dmr kit
	self.parts.wpn_fps_upg_ass_ak_b_zastava.stats = {
		spread = 3,
		total_ammo_mod = -4,
		concealment = -5,
		value = 1,
		recoil = -7
	}
	self.parts.wpn_fps_upg_ass_ak_b_zastava.custom_stats = {
		armor_piercing_add = 1,
		can_shoot_through_shield = true,
		can_shoot_through_wall = true,
		ammo_pickup_max_mul = 0.56,
		ammo_pickup_min_mul = 0.56,
	}
	self.parts.wpn_fps_upg_ass_ak_b_zastava.name_id = "bm_wpn_fps_upg_ass_ak_b_zastava_newname"
	self.parts.wpn_fps_upg_ass_ak_b_zastava.type = "ammo"
	self.parts.wpn_fps_upg_ass_ak_b_zastava.desc_id = "bm_wpn_fps_anynewassaultkit_desc"
	self.parts.wpn_fps_upg_ass_ak_b_zastava.forbids = {
		"wpn_fps_upg_ak_b_ak105",
		--"wpn_fps_upg_ak_ns_ak105",
		"wpn_fps_upg_ak_b_draco",
		"wpn_fps_ass_74_b_standard",
		"wpn_fps_ass_akm_b_standard",
		"wpn_fps_ass_akm_b_standard_gold",
		
		"wpn_fps_upg_ns_ass_pbs1",
		"wpn_fps_upg_ns_ass_smg_large",
		"wpn_fps_upg_ns_ass_smg_medium",
		"wpn_fps_upg_ns_ass_smg_small",
		"wpn_fps_upg_ns_ass_smg_firepig",
		"wpn_fps_upg_ns_ass_smg_stubby",
		"wpn_fps_upg_ns_ass_smg_tank",
		"wpn_fps_upg_ass_ns_jprifles",
		"wpn_fps_upg_ass_ns_linear",
		"wpn_fps_upg_ass_ns_surefire",
		"wpn_fps_upg_ass_ns_battle",
		"wpn_fps_upg_ns_ass_smg_v6",
		"wpn_fps_lmg_hk51b_ns_jcomp",
		"wpn_fps_ass_shak12_ns_suppressor",
		"wpn_fps_ass_shak12_ns_muzzle",
		"wpn_fps_upg_ak_ns_jmac",
		"wpn_fps_upg_ak_ns_tgp",
		"wpn_fps_lmg_kacchainsaw_ns_muzzle",
		"wpn_fps_lmg_kacchainsaw_ns_suppressor"
	}
end)

Hooks:PostHook(WeaponFactoryTweakData, "_init_ak74", "newwpnstats_ak74dmrkitoverride", function(self, ...)
	self.wpn_fps_ass_74.override.wpn_fps_upg_ass_ak_b_zastava.stats = {
		spread = 3,
		total_ammo_mod = -9,
		concealment = -5,
		value = 1,
		recoil = -7
	}
	
	self.wpn_fps_ass_74.override.wpn_fps_upg_ass_ak_b_zastava.custom_stats = {
		armor_piercing_add = 1,
		can_shoot_through_shield = true,
		can_shoot_through_wall = true,
		ammo_pickup_max_mul = 0.56,
		ammo_pickup_min_mul = 0.56,
	}
end)

Hooks:PostHook(WeaponFactoryTweakData, "_init_m16", "newwpnstats_m16dmrkitnooverride", function(self, ...)
	self.wpn_fps_ass_m16.override = {
		wpn_fps_upg_ass_m4_b_beowulf = {
			stats = {
				spread = 2,
				total_ammo_mod = -5,
				concealment = -5,
				value = 1,
				recoil = -7
			},
			custom_stats = {
				armor_piercing_add = 1,
				can_shoot_through_shield = true,
				can_shoot_through_wall = true,
				ammo_pickup_max_mul = 0.5,
				ammo_pickup_min_mul = 0.5,
			}
		}
	}
end)

Hooks:PostHook(WeaponFactoryTweakData, "_init_g3", "newwpnstats_g3kits", function(self, ...)
	--dmr kit
	self.parts.wpn_fps_ass_g3_b_long.name_id = "bm_wpn_fps_ass_g3_b_long_newname"
	self.parts.wpn_fps_ass_g3_b_sniper.stats = {
		extra_ammo = -5,
		total_ammo_mod = -8,
		damage = 210,
		value = 2,
		concealment = -3,
		recoil = -4,
		spread = 4,
		fire_rate = 0.35
	}
	self.parts.wpn_fps_ass_g3_b_sniper.custom_stats = {
		armor_piercing_add = 1,
		fire_rate_multiplier = 0.35,
		can_shoot_through_shield = true,
		can_shoot_through_wall = true,
		ammo_pickup_max_mul = 0.43,
		ammo_pickup_min_mul = 0.34
	}
	self.parts.wpn_fps_ass_g3_b_sniper.name_id = "bm_wpn_fps_ass_g3_b_sniper_newname"
	self.parts.wpn_fps_ass_g3_b_sniper.type = "ammo"
	self.parts.wpn_fps_ass_g3_b_sniper.desc_id = "bm_wpn_fps_ass_g3_b_sniper_desc"
	self.parts.wpn_fps_ass_g3_b_sniper.forbids = {
		"wpn_fps_ass_g3_b_long",
		
		"wpn_fps_upg_ns_ass_pbs1",
		"wpn_fps_upg_ns_ass_smg_large",
		"wpn_fps_upg_ns_ass_smg_medium",
		"wpn_fps_upg_ns_ass_smg_small",
		"wpn_fps_upg_ns_ass_smg_firepig",
		"wpn_fps_upg_ns_ass_smg_stubby",
		"wpn_fps_upg_ns_ass_smg_tank",
		"wpn_fps_upg_ass_ns_jprifles",
		"wpn_fps_upg_ass_ns_linear",
		"wpn_fps_upg_ass_ns_surefire",
		"wpn_fps_upg_ass_ns_battle",
		"wpn_fps_upg_ns_ass_smg_v6",
		"wpn_fps_lmg_hk51b_ns_jcomp",
		"wpn_fps_ass_shak12_ns_suppressor",
		"wpn_fps_ass_shak12_ns_muzzle",
		"wpn_fps_lmg_kacchainsaw_ns_muzzle",
		"wpn_fps_lmg_kacchainsaw_ns_suppressor",
	}
	
	--assault kit
	self.parts.wpn_fps_ass_g3_b_short.stats = {
		spread = -9,
		total_ammo_mod = 15,
		damage = -33,
		value = 2,
		concealment = 2,
		recoil = 5,
		fire_rate = 0.65
	}
	self.parts.wpn_fps_ass_g3_b_short.custom_stats = {
		fire_rate_multiplier = 0.65,
		ammo_pickup_max_mul = 1.29,
		ammo_pickup_min_mul = 1.29
	}
	self.parts.wpn_fps_ass_g3_b_short.type = "ammo"
	self.parts.wpn_fps_ass_g3_b_short.desc_id = "bm_wpn_fps_ass_g3_b_short_desc"
	self.parts.wpn_fps_ass_g3_b_short.forbids = {
		"wpn_fps_ass_g3_b_long",
		
		"wpn_fps_upg_ns_ass_pbs1",
		"wpn_fps_upg_ns_ass_smg_large",
		"wpn_fps_upg_ns_ass_smg_medium",
		"wpn_fps_upg_ns_ass_smg_small",
		"wpn_fps_upg_ns_ass_smg_firepig",
		"wpn_fps_upg_ns_ass_smg_stubby",
		"wpn_fps_upg_ns_ass_smg_tank",
		"wpn_fps_upg_ass_ns_jprifles",
		"wpn_fps_upg_ass_ns_linear",
		"wpn_fps_upg_ass_ns_surefire",
		"wpn_fps_upg_ass_ns_battle",
		"wpn_fps_upg_ns_ass_smg_v6",
		"wpn_fps_lmg_hk51b_ns_jcomp",
		"wpn_fps_ass_shak12_ns_suppressor",
		"wpn_fps_ass_shak12_ns_muzzle",
		"wpn_fps_lmg_kacchainsaw_ns_muzzle",
		"wpn_fps_lmg_kacchainsaw_ns_suppressor",
	}
end)

Hooks:PostHook(WeaponFactoryTweakData, "_init_c96", "newwpnstats_c96barrel", function(self, ...)
	self.parts.wpn_fps_pis_c96_b_long.stats = {
		value = 2,
		total_ammo_mod = -10,
		concealment = -5,
		damage = 64,
		recoil = -6
	}
	self.parts.wpn_fps_pis_c96_b_long.custom_stats = {
		armor_piercing_add = 1,
		can_shoot_through_shield = true,
		can_shoot_through_wall = true,
		ammo_pickup_max_mul = 0.25,
		ammo_pickup_min_mul = 0.25
	}
	self.parts.wpn_fps_pis_c96_b_long.name_id = "bm_wpn_fps_pis_c96_b_long_newname"
	self.parts.wpn_fps_pis_c96_b_long.type = "ammo"
	self.parts.wpn_fps_pis_c96_b_long.desc_id = "bm_wpn_fps_anynewassaultkit_desc"
	self.parts.wpn_fps_pis_c96_b_long.forbids = {
		"wpn_fps_pis_c96_nozzle",
		"wpn_fps_upg_ns_pis_large",
		"wpn_fps_upg_ns_pis_medium",
		"wpn_fps_upg_ns_pis_small",
		"wpn_fps_upg_ns_pis_large_kac",
		"wpn_fps_upg_ns_pis_medium_gem",
		"wpn_fps_upg_ns_pis_medium_slim",
		"wpn_fps_upg_ns_ass_filter",
		"wpn_fps_upg_ns_pis_jungle",
		"wpn_fps_upg_ns_pis_typhoon",
		"wpn_fps_upg_ns_pis_putnik",
		"wpn_fps_upg_pis_ns_flash",
		"wpn_fps_pis_c96_b_standard",
		"wpn_fps_upg_o_rmr",
		"wpn_fps_upg_o_rms",
		"wpn_fps_upg_o_rikt",
	}
end)

Hooks:PostHook(WeaponFactoryTweakData, "_init_x_basset", "newwpnstats_bigmagforakimbogrim", function(self, ...)
	self.wpn_fps_sho_x_basset.override = {
		wpn_fps_sho_basset_m_extended = {
			stats = {
				extra_ammo = 4,
				value = 1,
				concealment = -2,
				reload = -5
			}
		}
	}
end)

Hooks:PostHook(WeaponFactoryTweakData, "_init_hcar", "newwpnstats_hcar", function(self, ...)
	self.parts.wpn_fps_lmg_hcar_barrel_dmr.stats = {
			total_ammo_mod = -10,
			concealment = -2,
			damage = 210,
			spread = 2,
			value = 6,
			fire_rate = 0.6667,
	}
	self.parts.wpn_fps_lmg_hcar_barrel_dmr.type = "ammo"
	self.parts.wpn_fps_lmg_hcar_barrel_dmr.custom_stats = {
		ammo_pickup_max_mul = 0.45,
		ammo_pickup_min_mul = 0.45,
		fire_rate_multiplier = 0.6667,
		armor_piercing_add = 1,
		can_shoot_through_wall = true,
	}
	self.parts.wpn_fps_lmg_hcar_barrel_dmr.perks = {
		"fire_mode_single"
	}
	self.parts.wpn_fps_lmg_hcar_barrel_dmr.name_id = "wpn_fps_ass_hcar_barrel_dmr_PEN"
	self.parts.wpn_fps_lmg_hcar_barrel_dmr.desc_id = "bm_wpn_fps_ass_hcar_barrel_dmr_PEN_desc"
	self.parts.wpn_fps_lmg_hcar_barrel_dmr.forbids = {
		"wpn_fps_lmg_hcar_body_conversionkit",
		"wpn_fps_lmg_hcar_barrel_standard",
		"wpn_fps_lmg_hcar_barrel_short",
		
		"wpn_fps_lmg_hcar_m_drum",
		
		"wpn_fps_upg_ns_ass_smg_large",
		"wpn_fps_upg_ns_ass_smg_medium",
		"wpn_fps_upg_ns_ass_smg_small",
		"wpn_fps_upg_ns_ass_smg_firepig",
		"wpn_fps_upg_ns_ass_smg_stubby",
		"wpn_fps_upg_ns_ass_smg_tank",
		"wpn_fps_upg_ass_ns_jprifles",
		"wpn_fps_upg_ass_ns_linear",
		"wpn_fps_upg_ass_ns_surefire",
		"wpn_fps_upg_ass_ns_battle",
		"wpn_fps_upg_ns_ass_smg_v6",
		"wpn_fps_lmg_hk51b_ns_jcomp",
		"wpn_fps_ass_shak12_ns_suppressor",
		"wpn_fps_ass_shak12_ns_muzzle",
		"wpn_fps_lmg_hcar_suppressor",
		"wpn_fps_lmg_kacchainsaw_ns_muzzle",
		"wpn_fps_lmg_kacchainsaw_ns_suppressor",
	}
	
	self.parts.wpn_fps_lmg_hcar_m_drum.stats = {
		extra_ammo = 25,
		value = 3,
		concealment = -6,
		reload = -8,
		recoil = 7,
		spread = -6,
	}
	
	self.parts.wpn_fps_lmg_hcar_m_stick.stats = {
		extra_ammo = 10,
		value = 3,
		concealment = -2,
		reload = -3,
		recoil = 3,
		spread = -2,
	}
	
	self.parts.wpn_fps_lmg_hcar_body_conversionkit.stats = {
		extra_ammo = 40,
		total_ammo_mod = 20,
		damage = -33,
		value = 1,
		spread = -8,
		spread_moving = -8,
		recoil = 6,
		fire_rate = 1.667,
		reload = -6,
	}
	self.parts.wpn_fps_lmg_hcar_body_conversionkit.custom_stats.ammo_pickup_min_mul = 1.45
	self.parts.wpn_fps_lmg_hcar_body_conversionkit.custom_stats.ammo_pickup_max_mul = 1.35
end)

Hooks:PostHook(WeaponFactoryTweakData, "_init_tkb", "newwpnstats_tkb", function(self, ...)
	self.parts.wpn_fps_ass_tkb_conversion.stats = {
		value = 1,
		spread = 4,
		recoil = 3,
		concealment = -3,
		fire_rate = 0.875,
		reload = 2,
	}
	self.parts.wpn_fps_ass_tkb_conversion.custom_stats = {
		fire_rate_multiplier = 0.875
	}
	
	self.parts.wpn_fps_ass_tkb_body_pouch.stats = {
		value = 1,
		total_ammo_mod = 5,
		concealment = -2,
		spread = -2,
		recoil = 2
	}
end)

Hooks:PostHook(WeaponFactoryTweakData, "_init_contender", "newwpnstats_contender", function(self, ...)
	self.parts.wpn_fps_snp_contender_conversion.stats = {
		reload = -3,
		value = 1,
		total_ammo_mod = -8,
		damage = 625,
		concealment = -9,
		spread = 2
	}
end)

Hooks:PostHook(WeaponFactoryTweakData, "_init_basset", "newwpnstats_bigmagforsaigaandgrimm", function(self, ...)
	self.parts.wpn_fps_sho_basset_m_extended.stats.reload = -5
end)

Hooks:PostHook(WeaponFactoryTweakData, "_init_qbu88", "newwpnstats_bigmagforqbu88", function(self, ...)
	self.parts.wpn_fps_snp_qbu88_m_extended.stats.reload = -5
end)

Hooks:PostHook(WeaponFactoryTweakData, "_init_r93", "newwpnstats_silencerforr93", function(self, ...)
	self.parts.wpn_fps_snp_r93_b_suppressed.stats.damage = -3
end)

Hooks:PostHook(WeaponFactoryTweakData, "_init_mosin", "newwpnstats_silencerformosin", function(self, ...)
	self.parts.wpn_fps_snp_mosin_b_sniper.stats.damage = -3
end)

Hooks:PostHook(WeaponFactoryTweakData, "_init_scout", "newwpnstats_bigmagforscout", function(self, ...)
	self.parts.wpn_fps_snp_scout_m_extended.stats.reload = -4
end)

-- tango dlc aka gage spec ops pack
Hooks:PostHook(WeaponFactoryTweakData, "_init_tng", "newwpnstats_SpecOpsPack", function(self, ...)
	self.parts.wpn_fps_pis_usp_m_big.stats.reload = -7
	self.parts.wpn_fps_pis_1911_m_big.stats.reload = -7
end)

Hooks:PostHook(WeaponFactoryTweakData, "_init_usp", "newwpnstats_bigmagforusp", function(self, ...)
	self.parts.wpn_fps_pis_usp_m_extended.stats.reload = -4
end)

Hooks:PostHook(WeaponFactoryTweakData, "_init_x_usp", "newwpnstats_bigmagforakimbousp", function(self, ...)
	self.wpn_fps_pis_x_usp.override.wpn_fps_pis_usp_m_extended.stats.reload = -4
	self.wpn_fps_pis_x_usp.override.wpn_fps_pis_usp_m_big.stats.reload = -7
end)

Hooks:PostHook(WeaponFactoryTweakData, "_init_g18c", "newwpnstats_bigmagforglocks", function(self, ...)
	self.parts.wpn_fps_pis_g18c_m_mag_33rnd.stats.reload = -4
end)

Hooks:PostHook(WeaponFactoryTweakData, "_init_x_g17", "newwpnstats_bigmagforakimbog17", function(self, ...)
	self.wpn_fps_pis_x_g17.override.wpn_fps_pis_g18c_m_mag_33rnd.stats.reload = -8
end)

Hooks:PostHook(WeaponFactoryTweakData, "_init_p226", "newwpnstats_bigmagforp226", function(self, ...)
	self.parts.wpn_fps_pis_p226_m_extended.stats.reload = -4
end)

Hooks:PostHook(WeaponFactoryTweakData, "_init_x_p226", "newwpnstats_bigmagforakimbop226", function(self, ...)
	self.wpn_fps_pis_x_p226.override.wpn_fps_pis_p226_m_extended.stats.reload = -5
end)

Hooks:PostHook(WeaponFactoryTweakData, "_init_colt_1911", "newwpnstats_bigmagform1911", function(self, ...)
	self.parts.wpn_fps_pis_1911_m_extended.stats.reload = -3
end)

Hooks:PostHook(WeaponFactoryTweakData, "_init_x_1911", "newwpnstats_bigmagforakimbom1911", function(self, ...)
	self.wpn_fps_x_1911.override.wpn_fps_pis_1911_m_extended.stats.reload = -3
	self.wpn_fps_x_1911.override.wpn_fps_pis_1911_m_big.stats.reload = -7
end)

Hooks:PostHook(WeaponFactoryTweakData, "_init_b92fs", "newwpnstats_bigmagforb9", function(self, ...)
	self.parts.wpn_fps_pis_beretta_m_extended.stats.reload = -8
end)

Hooks:PostHook(WeaponFactoryTweakData, "_init_x_b92fs", "newwpnstats_bigmagforakimbob9", function(self, ...)
	self.wpn_fps_x_b92fs.override.wpn_fps_pis_beretta_m_extended.stats.reload = -7
end)

Hooks:PostHook(WeaponFactoryTweakData, "_init_korth", "newwpnstats_smallmagforkahn357", function(self, ...)
	self.parts.wpn_fps_pis_korth_m_6.stats.damage = 210
	self.parts.wpn_fps_pis_korth_m_6.stats.spread = -9
end)

Hooks:PostHook(WeaponFactoryTweakData, "_init_x_korth", "newwpnstats_smallmagforakimbokahn357", function(self, ...)
	self.wpn_fps_pis_x_korth.override.wpn_fps_pis_korth_m_6 = {stats={
		extra_ammo = -2,
		concealment = -2,
		damage = 210,
		value = 1,
		spread = -9,
		recoil = -3
	}}
end)

Hooks:PostHook(WeaponFactoryTweakData, "_init_type54", "newwpnstats_bigmagfortokarev", function(self, ...)
	self.parts.wpn_fps_pis_type54_m_ext.stats.reload = -3
end)

Hooks:PostHook(WeaponFactoryTweakData, "_init_x_type54", "newwpnstats_bigmagforakimbotokarev", function(self, ...)
	self.wpn_fps_pis_x_type54.override.wpn_fps_pis_type54_m_ext.stats.reload = -3
end)

Hooks:PostHook(WeaponFactoryTweakData, "_init_packrat", "newwpnstats_bigmagforp30l", function(self, ...)
	self.parts.wpn_fps_pis_packrat_m_extended.stats.reload = -5
end)

Hooks:PostHook(WeaponFactoryTweakData, "_init_x_packrat", "newwpnstats_bigmagforakimbop30l", function(self, ...)
	self.wpn_fps_x_packrat.override.wpn_fps_pis_packrat_m_extended.stats.reload = -5
end)

Hooks:PostHook(WeaponFactoryTweakData, "_init_hs2000", "newwpnstats_bigmagforhk2000", function(self, ...)
	self.parts.wpn_fps_pis_hs2000_m_extended.stats.reload = -4
end)

Hooks:PostHook(WeaponFactoryTweakData, "_init_x_hs2000", "newwpnstats_bigmagforakimbohk2000", function(self, ...)
	self.wpn_fps_pis_x_hs2000.override.wpn_fps_pis_hs2000_m_extended.stats.reload = -4
end)

Hooks:PostHook(WeaponFactoryTweakData, "_init_czech", "newwpnstats_bigmagforcz75", function(self, ...)
	self.parts.wpn_fps_pis_czech_m_extended.stats.reload = -2
end)

Hooks:PostHook(WeaponFactoryTweakData, "_init_x_czech", "newwpnstats_bigmagforakimbocz75", function(self, ...)
	self.wpn_fps_pis_x_czech.override.wpn_fps_pis_czech_m_extended.stats.reload = -2
end)

Hooks:PostHook(WeaponFactoryTweakData, "_init_stech", "newwpnstats_bigmagforaps", function(self, ...)
	self.parts.wpn_fps_pis_stech_m_extended.stats.reload = -6
end)

Hooks:PostHook(WeaponFactoryTweakData, "_init_x_stech", "newwpnstats_bigmagforakimboaps", function(self, ...)
	self.wpn_fps_pis_x_stech.override.wpn_fps_pis_stech_m_extended.stats.reload = -6
end)

Hooks:PostHook(WeaponFactoryTweakData, "_init_holt", "newwpnstats_bigmagforH9", function(self, ...)
	self.parts.wpn_fps_pis_holt_m_extended.stats.reload = -3
end)

Hooks:PostHook(WeaponFactoryTweakData, "_init_x_holt", "newwpnstats_bigmagforakimboH9", function(self, ...)
	self.wpn_fps_pis_x_holt.override.wpn_fps_pis_holt_m_extended.stats.reload = -3
end)

Hooks:PostHook(WeaponFactoryTweakData, "_init_deagle", "newwpnstats_bigmagfordeagle", function(self, ...)
	self.parts.wpn_fps_pis_deagle_m_extended.stats.reload = -5
end)

Hooks:PostHook(WeaponFactoryTweakData, "_init_x_deagle", "newwpnstats_bigmagforakimbodeagle", function(self, ...)
	self.wpn_fps_x_deagle.override.wpn_fps_pis_deagle_m_extended.stats.reload = -5
end)

Hooks:PostHook(WeaponFactoryTweakData, "_init_m45", "newwpnstats_bigmagform45", function(self, ...)
	self.parts.wpn_fps_smg_m45_m_extended.stats.reload = -4
end)

Hooks:PostHook(WeaponFactoryTweakData, "_init_x_m45", "newwpnstats_bigmagforakimbom45", function(self, ...)
	self.wpn_fps_smg_x_m45.override.wpn_fps_smg_m45_m_extended.stats.reload = -4
end)

Hooks:PostHook(WeaponFactoryTweakData, "_init_mp7", "newwpnstats_bigmagformp7", function(self, ...)
	self.parts.wpn_fps_smg_mp7_m_extended.stats.reload = -3
end)

Hooks:PostHook(WeaponFactoryTweakData, "_init_x_mp7", "newwpnstats_bigmagforakimbomp7", function(self, ...)
	self.wpn_fps_smg_x_mp7.override.wpn_fps_smg_mp7_m_extended.stats.reload = -4
end)

Hooks:PostHook(WeaponFactoryTweakData, "_init_schakal", "newwpnstats_bigmagforump", function(self, ...)
	self.parts.wpn_fps_smg_schakal_m_short.stats.reload = 2
	self.parts.wpn_fps_smg_schakal_m_long.stats.reload = -5
end)

Hooks:PostHook(WeaponFactoryTweakData, "_init_x_schakal", "newwpnstats_bigmagforakimboump", function(self, ...)
	self.wpn_fps_smg_x_schakal.override.wpn_fps_smg_schakal_m_short.stats.reload = 2
	self.wpn_fps_smg_x_schakal.override.wpn_fps_smg_schakal_m_long.stats.reload = -5
end)

Hooks:PostHook(WeaponFactoryTweakData, "_init_tec9", "newwpnstats_bigmagfortec9", function(self, ...)
	self.parts.wpn_fps_smg_tec9_m_extended.stats.reload = -4
end)

Hooks:PostHook(WeaponFactoryTweakData, "_init_x_tec9", "newwpnstats_bigmagforakimbotec9", function(self, ...)
	self.wpn_fps_smg_x_tec9.override.wpn_fps_smg_tec9_m_extended.stats.reload = -4
end)

Hooks:PostHook(WeaponFactoryTweakData, "_init_c96", "newwpnstats_bigmagforc96", function(self, ...)
	self.parts.wpn_fps_pis_c96_m_extended.stats.reload = -3
end)

Hooks:PostHook(WeaponFactoryTweakData, "_init_lemming", "newwpnstats_bigmagforfiveseven", function(self, ...)
	self.parts.wpn_fps_pis_lemming_m_ext.stats.reload = -3
	self.parts.wpn_fps_pis_lemming_m_ext.stats.extra_ammo = 3
	self.parts.wpn_fps_pis_lemming_m_ext.stats.concealment = -2
end)

Hooks:PostHook(WeaponFactoryTweakData, "_init_kacchainsaw", "newwpnstats_mcshay4lmg", function(self, ...)
	self.parts.wpn_fps_lmg_kacchainsaw_flamethrower.stats = {
		concealment = -9,
		spread = -5,
		value = 1,
		recoil = 2
	}
	self.parts.wpn_fps_lmg_kacchainsaw_flamethrower.custom_stats = {
		ammo_pickup_min_mul = 0.637,
		ammo_pickup_max_mul = 0.602,
	}
	self.parts.wpn_fps_lmg_kacchainsaw_conversionkit.stats = {
		extra_ammo = 50,
		total_ammo_mod = 20,
		damage = -22,
		value = 1,
		spread = 1,
		recoil = 4,
		fire_rate = 1.334
	}
	self.parts.wpn_fps_lmg_kacchainsaw_conversionkit.custom_stats = {
		ammo_pickup_min_mul = 1.2,
		ammo_pickup_max_mul = 1.24,
		fire_rate_multiplier = 1.334
	}
end)

Hooks:PostHook(WeaponFactoryTweakData, "_init_awp", "newwpnstats_mcshay4awp", function(self, ...)
	self.parts.wpn_fps_snp_awp_conversion_dragonlore.stats = {
		extra_ammo = -1,
		total_ammo_mod = -6,
		damage = 68,
		spread = 2,
		value = 8,
		concealment = -6
	}
	self.parts.wpn_fps_snp_awp_conversion_dragonlore.custom_stats = {
		ammo_pickup_max_mul = 0.9,
		ammo_pickup_min_mul = 0.9
	}
	self.parts.wpn_fps_snp_awp_conversion_wildlands.stats = {
		concealment = 2,
		total_ammo_mod = 13,
		damage = -120,
		spread = -2,
		value = 8,
		recoil = 4
	}
	self.parts.wpn_fps_snp_awp_conversion_wildlands.custom_stats = {
		fire_rate_multiplier = 1.7
	}
	self.parts.wpn_fps_snp_awp_ext_shellrack.stats.total_ammo_mod = 7
end)

Hooks:PostHook(WeaponFactoryTweakData, "_init_supernova", "newwpnstats_mcshay4shotty", function(self, ...)
	self.parts.wpn_fps_sho_supernova_conversion.stats = {
		value = 1,
		total_ammo_mod = 3,
		concealment = 2,
		spread = -3,
		recoil = 2,
		extra_ammo = 1
	}
	self.parts.wpn_fps_sho_supernova_shell_rack.stats.total_ammo_mod = 3
end)