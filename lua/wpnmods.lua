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
		ammo_pickup_max_mul = 1.1, -- what kind of weird logic does this function use? for some reason it adjusts pick up based on default pick up instead of what comes after skills get applied, resulting in pick up beeing way too low. it will actually give you better pick up now if you dont have a perk deck, but lower if you have one. wtf
		ammo_pickup_min_mul = 1.1,
	}
end)

Hooks:PostHook(WeaponFactoryTweakData, "_init_mp5", "newwpnstats_mp5", function(self, ...)
	self.parts.wpn_fps_smg_mp5_m_straight.stats = {
		extra_ammo = -2.5,
		damage = 65,
		spread = -8,
		spread_moving = -8,
		recoil = -14,
		total_ammo_mod = -8,
		reload = 2,
		concealment = -6,
	}
	self.parts.wpn_fps_smg_mp5_m_straight.name_id = "bm_wpn_fps_smg_mp5_m_straight_R"
end)

Hooks:PostHook(WeaponFactoryTweakData, "_init_x_mp5", "newwpnstats_x_mp5", function(self, ...)
	self.wpn_fps_smg_x_mp5.override.wpn_fps_smg_mp5_m_straight.stats = {
		extra_ammo = -5,
		damage = 65,
		spread = -8,
		spread_moving = -8,
		recoil = -14,
		total_ammo_mod = -6,
		reload = 2,
		concealment = -6,
	}
end)

Hooks:PostHook(WeaponFactoryTweakData, "_init_shak12", "newwpnstats_ash12", function(self, ...)
	self.parts.wpn_fps_ass_shak12_body_vks.stats = {
			total_ammo_mod = -4,
			concealment = -2,
			value = 6,
			fire_rate = 2,
	}
	self.parts.wpn_fps_ass_shak12_body_vks.type = "ammo"
	self.parts.wpn_fps_ass_shak12_body_vks.custom_stats = {
		ammo_pickup_max_mul = 0.7,
		ammo_pickup_min_mul = 0.7,
		fire_rate_multiplier = 0.8,
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
		damage = -2,
		total_ammo_mod = -6
	}
	self.parts.wpn_fps_bow_long_m_poison.custom_stats = {
		armor_piercing_add = 1,
	}
	self.parts.wpn_fps_bow_long_m_explosive.stats = {
		damage = 16,
		total_ammo_mod = -6
	}
	self.parts.wpn_fps_bow_long_m_explosive.desc_id = "bm_wpn_fps_bow_long_m_explosive_desc"
end)

Hooks:PostHook(WeaponFactoryTweakData, "_init_elastic", "newwpnstats_longbow_free", function(self, ...)
	self.parts.wpn_fps_bow_elastic_m_standard.custom_stats = {
		armor_piercing_add = 1,
	}
	self.parts.wpn_fps_bow_elastic_m_poison.stats = {
		damage = -2,
		total_ammo_mod = -6
	}
	self.parts.wpn_fps_bow_elastic_m_poison.custom_stats = {
		armor_piercing_add = 1,
	}
	self.parts.wpn_fps_bow_elastic_m_explosive.stats = {
		damage = 16,
		total_ammo_mod = -6
	}
end)

Hooks:PostHook(WeaponFactoryTweakData, "_init_arblast", "newwpnstats_heavycrossbow", function(self, ...)
	self.parts.wpn_fps_bow_arblast_m_standard.custom_stats = {
		armor_piercing_add = 1,
	}
	self.parts.wpn_fps_bow_arblast_m_poison.stats = {
		damage = -2,
		total_ammo_mod = -6
	}
	self.parts.wpn_fps_bow_arblast_m_poison.custom_stats = {
		armor_piercing_add = 1,
	}
	self.parts.wpn_fps_bow_arblast_m_explosive.stats = {
		damage = 16,
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
		damage = 50,
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
	
	self.parts.wpn_fps_upg_a_custom.stats.damage = 36
	self.parts.wpn_fps_upg_a_custom_free.stats.damage = 36
	self.parts.wpn_fps_upg_a_slug.stats = {
		value = 5,
		total_ammo_mod = -6
	}
	self.parts.wpn_fps_upg_a_explosive.stats = {
		value = 5,
		total_ammo_mod = -9,
		damage = 45,
		recoil = -11
	}
	self.parts.wpn_fps_upg_a_piercing.stats = {
		value = 5
	}
	self.parts.wpn_fps_upg_a_dragons_breath.stats = {
		value = 5,
		total_ammo_mod = -9,
		moving_spread = -7,
		spread = -5
	}
	self.parts.wpn_fps_upg_a_dragons_breath.custom_stats.fire_dot_data = {
		dot_trigger_chance = "90",
		dot_damage = "12",
		dot_length = "3.1",
		dot_trigger_max_distance = "1000",
		dot_tick_period = "0.5"
	}
	self.parts.wpn_fps_upg_a_rip.stats = {
		value = 5,
		total_ammo_mod = -7,
		spread = -4,
		moving_spread = -6
	}
	self.parts.wpn_fps_upg_a_rip.custom_stats.dot_data.custom_data = {
		hurt_animation_chance = 1,
		dot_damage = 10,
		dot_length = 2.1,
		use_weapon_damage_falloff = true,
		dot_tick_period = 0.5
	}
	self.parts.wpn_fps_upg_a_rip.desc_id = "bm_wpn_fps_upg_a_rip_desc_G"
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
		spread = 2,
		total_ammo_mod = -5,
		concealment = -5,
		value = 1,
		recoil = -7
	}
	self.parts.wpn_fps_upg_ass_m4_b_beowulf.custom_stats = {
		armor_piercing_add = 1,
		can_shoot_through_shield = true,
		can_shoot_through_wall = true,
		ammo_pickup_max_mul = 0.5,
		ammo_pickup_min_mul = 0.5,
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
		"wpn_fps_ass_shak12_ns_muzzle"
	}
	
	--ak dmr kit
	self.parts.wpn_fps_upg_ass_ak_b_zastava.stats = {
		spread = 2,
		total_ammo_mod = -5,
		concealment = -5,
		value = 1,
		recoil = -7
	}
	self.parts.wpn_fps_upg_ass_ak_b_zastava.custom_stats = {
		armor_piercing_add = 1,
		can_shoot_through_shield = true,
		can_shoot_through_wall = true,
		ammo_pickup_max_mul = 0.5,
		ammo_pickup_min_mul = 0.5,
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
		"wpn_fps_ass_shak12_ns_muzzle"
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
		damage = 190,
		value = 2,
		concealment = -3,
		recoil = -4,
		spread = 3
	}
	self.parts.wpn_fps_ass_g3_b_sniper.custom_stats = {
		armor_piercing_add = 1,
		fire_rate_multiplier = 0.4,
		can_shoot_through_shield = true,
		can_shoot_through_wall = true,
		ammo_pickup_max_mul = 0.3,
		ammo_pickup_min_mul = 0.3
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
		"wpn_fps_ass_shak12_ns_muzzle"
	}
	
	--assault kit
	self.parts.wpn_fps_ass_g3_b_short.stats = {
		spread = -9,
		total_ammo_mod = 15,
		damage = -45,
		value = 2,
		concealment = 2,
		recoil = 5
	}
	self.parts.wpn_fps_ass_g3_b_short.custom_stats = {
		fire_rate_multiplier = 0.6,
		ammo_pickup_max_mul = 2.6,
		ammo_pickup_min_mul = 2.6
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
		"wpn_fps_ass_shak12_ns_muzzle"
	}
end)

Hooks:PostHook(WeaponFactoryTweakData, "_init_c96", "newwpnstats_c96barrel", function(self, ...)
	self.parts.wpn_fps_pis_c96_b_long.stats = {
		value = 2,
		total_ammo_mod = -10,
		concealment = -5,
		damage = 70,
		recoil = -6
	}
	self.parts.wpn_fps_pis_c96_b_long.custom_stats = {
		armor_piercing_add = 1,
		can_shoot_through_shield = true,
		can_shoot_through_wall = true,
		ammo_pickup_max_mul = 0.37,
		ammo_pickup_min_mul = 0.37
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
	self.parts.wpn_fps_pis_g18c_m_mag_33rnd.stats.reload = -9
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