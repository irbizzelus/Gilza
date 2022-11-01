if not tweak_data then return end

-- normal grenade
tweak_data.projectiles.frag.damage = 500
tweak_data.projectiles.frag.curve_pow = 0.1
tweak_data.projectiles.frag.player_damage = 10
tweak_data.projectiles.frag.range = 300
-- molotov: buff 
tweak_data.projectiles.molotov = {
	damage = 1,
	player_damage = 2,
	fire_dot_data = {
		dot_trigger_chance = 95,
		dot_damage = 2,
		dot_length = 5,
		dot_trigger_max_distance = 3000,
		dot_tick_period = 0.25
	},
	range = 75,
	burn_duration = 10,
	burn_tick_period = 0.25,
	sound_event = "molotov_impact",
	sound_event_impact_duration = 4,
	name_id = "bm_grenade_molotov",
	alert_radius = 1500,
	fire_alert_radius = 1500
}
-- incendiary grenade
tweak_data.projectiles.fir_com = {
	damage = 100,
	curve_pow = 0.1,
	player_damage = 3,
	fire_dot_data = {
		dot_trigger_chance = 100,
		dot_damage = 14.5,
		dot_length = 2.01,
		dot_trigger_max_distance = 3000,
		dot_tick_period = 0.25
	},
	range = 375,
	name_id = "bm_grenade_fir_com",
	sound_event = "white_explosion",
	effect_name = "effects/payday2/particles/explosions/grenade_incendiary_explosion"
}
-- shurikens: a bit more impact dmg
tweak_data.projectiles.wpn_prj_four = {
	damage = 20,
	launch_speed = 1500,
	adjust_z = 0,
	mass_look_up_modifier = 1,
	name_id = "bm_prj_four",
	push_at_body_index = 0,
	dot_data = {
		type = "poison"
	},
	bullet_class = "ProjectilesPoisonBulletBase",
	sounds = {deep_clone(tweak_data.projectiles.wpn_prj_four.sounds)}
}
-- throw cards
tweak_data.projectiles.wpn_prj_ace = {
	damage = 55,
	launch_speed = 1500,
	adjust_z = 0,
	mass_look_up_modifier = 1,
	name_id = "bm_prj_ace",
	push_at_body_index = 0,
	sounds = {deep_clone(tweak_data.projectiles.wpn_prj_ace.sounds)}
}
-- throw knife
tweak_data.projectiles.wpn_prj_target = {
	damage = 70,
	launch_speed = 1000,
	adjust_z = 0,
	mass_look_up_modifier = 1,
	name_id = "bm_prj_target",
	push_at_body_index = "dynamic_body_spinn",
	sounds = {deep_clone(tweak_data.projectiles.wpn_prj_target.sounds)}
}
--throw axe
tweak_data.projectiles.wpn_prj_hur = {
	damage = 130,
	launch_speed = 1000,
	adjust_z = 0,
	mass_look_up_modifier = 1,
	name_id = "bm_prj_hur",
	push_at_body_index = "dynamic_body_spinn",
	sounds = {deep_clone(tweak_data.projectiles.wpn_prj_hur.sounds)}
}
--javelin
tweak_data.projectiles.wpn_prj_jav = {
	damage = 800,
	launch_speed = 1500,
	adjust_z = 30,
	mass_look_up_modifier = 1,
	name_id = "bm_prj_jav",
	push_at_body_index = 0,
	sounds = {deep_clone(tweak_data.projectiles.wpn_prj_jav.sounds)}
}
--dynamyte
tweak_data.projectiles.dynamite = {
	damage = 250,
	curve_pow = 0.1,
	player_damage = 10,
	range = 600,
	name_id = "bm_grenade_frag",
	effect_name = "effects/payday2/particles/explosions/dynamite_explosion"
}
--electric nade
tweak_data.projectiles.wpn_gre_electric = {
	damage = 20,
	curve_pow = 3.5,
	range = 1200,
	name_id = "bm_electric_grenade",
	sound_event = "grenade_electric_explode"
}
--gas 200 direct + ~300
tweak_data.projectiles.poison_gas_grenade = {
	damage = 20,
	player_damage = 0,
	curve_pow = 0.1,
	range = 200,
	name_id = "bm_poison_gas_grenade",
	poison_gas_range = 900,
	poison_gas_duration = 20,
	poison_gas_fade_time = 2,
	poison_gas_tick_time = 0.25,
	poison_gas_dot_data = {
		hurt_animation_chance = 1,
		dot_damage = 0.3,
		dot_length = 30,
		dot_tick_period = 0.25
	}
}
--matryoshka
tweak_data.projectiles.dada_com = {
	damage = 500,
	curve_pow = 0.1,
	range = 300,
	name_id = "bm_grenade_dada_com",
	sound_event = "mtl_explosion"
}
-- community nade
tweak_data.projectiles.frag_com = {
	damage = 500,
	curve_pow = 0.1,
	range = 300,
	name_id = "bm_grenade_frag_com"
}
	
-- normal nades
tweak_data.projectiles.launcher_frag = {
	damage = 400,
	launch_speed = 1250,
	curve_pow = 0.1,
	player_damage = 8,
	range = 175,
	init_timer = 2.5,
	mass_look_up_modifier = 1,
	sound_event = "gl_explode",
	name_id = "bm_launcher_frag"
}
tweak_data.projectiles.launcher_frag_m32 = deep_clone(tweak_data.projectiles.launcher_frag)
tweak_data.projectiles.launcher_frag_china = deep_clone(tweak_data.projectiles.launcher_frag)
tweak_data.projectiles.launcher_frag_slap = deep_clone(tweak_data.projectiles.launcher_frag)
tweak_data.projectiles.launcher_m203 = deep_clone(tweak_data.projectiles.launcher_frag)
tweak_data.projectiles.launcher_m203.projectile_trail = true
tweak_data.projectiles.launcher_frag_ms3gl = deep_clone(tweak_data.projectiles.launcher_frag)
tweak_data.projectiles.launcher_frag_ms3gl.damage = 32
tweak_data.projectiles.launcher_frag_arbiter = {
	damage = 200,
	launch_speed = 7000,
	curve_pow = 0.1,
	player_damage = 8,
	range = 120,
	init_timer = 2.5,
	mass_look_up_modifier = 1,
	sound_event = "gl_explode",
	name_id = "bm_launcher_frag"
}

-- fire nades
tweak_data.projectiles.launcher_incendiary = {
	damage = 1,
	launch_speed = 1250,
	curve_pow = 0.1,
	player_damage = 2,
	fire_dot_data = {
		dot_trigger_chance = 99,
		dot_damage = 10,
		dot_length = 3.1,
		dot_trigger_max_distance = 3000,
		dot_tick_period = 0.5
	},
	range = 75,
	init_timer = 2.5,
	mass_look_up_modifier = 1,
	sound_event = "gl_explode",
	sound_event_impact_duration = 1,
	name_id = "bm_launcher_incendiary",
	burn_duration = 10,
	burn_tick_period = 0.5
}
tweak_data.projectiles.launcher_incendiary_m32 = deep_clone(tweak_data.projectiles.launcher_incendiary)
tweak_data.projectiles.launcher_incendiary_china = deep_clone(tweak_data.projectiles.launcher_incendiary)
tweak_data.projectiles.launcher_incendiary_slap = deep_clone(tweak_data.projectiles.launcher_incendiary)
tweak_data.projectiles.launcher_incendiary_ms3gl = deep_clone(tweak_data.projectiles.launcher_incendiary)
tweak_data.projectiles.launcher_incendiary_arbiter = {
	damage = 1,
	launch_speed = 7000,
	curve_pow = 0.1,
	player_damage = 2,
	fire_dot_data = {
		dot_trigger_chance = 99,
		dot_damage = 8,
		dot_length = 3.1,
		dot_trigger_max_distance = 3000,
		dot_tick_period = 0.5
	},
	range = 90,
	init_timer = 2.5,
	mass_look_up_modifier = 1,
	sound_event = "gl_explode",
	sound_event_impact_duration = 0.25,
	name_id = "bm_launcher_incendiary",
	burn_duration = 5,
	burn_tick_period = 0.5
}

-- high velocity nades
tweak_data.projectiles.launcher_velocity = {
	damage = 400,
	launch_speed = 3500,
	curve_pow = 0.1,
	player_damage = 8,
	range = 70,
	init_timer = 2.5,
	mass_look_up_modifier = 1,
	sound_event = "gl_explode",
	name_id = "bm_launcher_frag_velocity"
}
tweak_data.projectiles.launcher_velocity_m32 = deep_clone(tweak_data.projectiles.launcher_velocity)
tweak_data.projectiles.launcher_velocity_china = deep_clone(tweak_data.projectiles.launcher_velocity)
tweak_data.projectiles.launcher_velocity_slap = deep_clone(tweak_data.projectiles.launcher_velocity)

-- СУКА РПГ
tweak_data.projectiles.launcher_rocket = {
	damage = 1630,
	launch_speed = 2500,
	curve_pow = 0.1,
	player_damage = 40,
	range = 400,
	init_timer = 2.5,
	mass_look_up_modifier = 1,
	sound_event = "rpg_explode",
	name_id = "bm_launcher_rocket"
}

-- commando
tweak_data.projectiles.rocket_ray_frag.damage = 820
tweak_data.projectiles.rocket_ray_frag.range = 400

-- poison nades
tweak_data.projectiles.launcher_poison = deep_clone(tweak_data.projectiles.launcher_frag)
tweak_data.projectiles.launcher_poison.damage = 10
tweak_data.projectiles.launcher_poison.range = 200
tweak_data.projectiles.launcher_poison.poison_gas_range = 600
tweak_data.projectiles.launcher_poison.poison_gas_duration = 10
tweak_data.projectiles.launcher_poison.poison_gas_fade_time = 2
tweak_data.projectiles.launcher_poison.poison_gas_tick_time = 0.25
tweak_data.projectiles.launcher_poison.poison_gas_dot_data = {
	hurt_animation_chance = 1,
	dot_damage = 0.9,
	dot_length = 30,
	dot_tick_period = 0.25
}

tweak_data.projectiles.launcher_poison_ms3gl_conversion = deep_clone(tweak_data.projectiles.launcher_poison)
tweak_data.projectiles.launcher_poison_ms3gl_conversion.damage = 34
tweak_data.projectiles.launcher_poison_ms3gl_conversion.poison_gas_range = 800
tweak_data.projectiles.launcher_poison_gre_m79 = deep_clone(tweak_data.projectiles.launcher_poison)
tweak_data.projectiles.launcher_poison_m32 = deep_clone(tweak_data.projectiles.launcher_poison)
tweak_data.projectiles.launcher_poison_groza = deep_clone(tweak_data.projectiles.launcher_poison)
tweak_data.projectiles.launcher_poison_china = deep_clone(tweak_data.projectiles.launcher_poison)
tweak_data.projectiles.launcher_poison_slap = deep_clone(tweak_data.projectiles.launcher_poison)
tweak_data.projectiles.launcher_poison_contraband = deep_clone(tweak_data.projectiles.launcher_poison)
tweak_data.projectiles.launcher_poison_arbiter = deep_clone(tweak_data.projectiles.launcher_poison)
tweak_data.projectiles.launcher_poison_arbiter.range = 150
tweak_data.projectiles.launcher_poison_arbiter.launch_speed = 7000
tweak_data.projectiles.launcher_poison_arbiter.curve_pow = 0.1
tweak_data.projectiles.launcher_poison_arbiter.poison_gas_range = 400
tweak_data.projectiles.launcher_poison_arbiter.poison_gas_dot_data = {
	hurt_animation_chance = 1,
	dot_damage = 0.9,
	dot_length = 11,
	dot_tick_period = 0.25
}
-- electric nades for 3 round birst gl
tweak_data.projectiles.launcher_electric_ms3gl.damage = 100

-- plainsrider
tweak_data.projectiles.west_arrow.damage = 72.0
tweak_data.projectiles.bow_poison_arrow.damage = 72.0
tweak_data.projectiles.west_arrow_exp.damage = 144.0

--[[ handling buffs, may be used later
tweak_data.projectiles.west_arrow.launch_speed = 3500
tweak_data.projectiles.west_arrow.adjust_z = -100
tweak_data.projectiles.bow_poison_arrow.launch_speed = tweak_data.projectiles.west_arrow.launch_speed
tweak_data.projectiles.bow_poison_arrow.adjust_z = tweak_data.projectiles.west_arrow.adjust_z
tweak_data.projectiles.west_arrow_exp.launch_speed = tweak_data.projectiles.west_arrow.launch_speed
tweak_data.projectiles.west_arrow_exp.adjust_z = tweak_data.projectiles.west_arrow.adjust_z
]]

-- longbow
tweak_data.projectiles.long_arrow.damage = 160.0
tweak_data.projectiles.long_poison_arrow.damage = 140.0
tweak_data.projectiles.long_arrow_exp.damage = 320.0
--[[
tweak_data.projectiles.long_arrow.launch_speed = tweak_data.projectiles.west_arrow.launch_speed
tweak_data.projectiles.long_arrow.adjust_z = tweak_data.projectiles.west_arrow.adjust_z
tweak_data.projectiles.long_poison_arrow.launch_speed = tweak_data.projectiles.west_arrow.launch_speed
tweak_data.projectiles.long_poison_arrow.adjust_z = tweak_data.projectiles.west_arrow.adjust_z
tweak_data.projectiles.long_arrow_exp.launch_speed = tweak_data.projectiles.west_arrow.launch_speed
tweak_data.projectiles.long_arrow_exp.adjust_z = tweak_data.projectiles.west_arrow.adjust_z
]]
-- compound bow
tweak_data.projectiles.elastic_arrow.damage = 160.0
tweak_data.projectiles.elastic_arrow_poison.damage = 140.0
tweak_data.projectiles.elastic_arrow_exp.damage = 320.0
--[[
tweak_data.projectiles.elastic_arrow.launch_speed = tweak_data.projectiles.west_arrow.launch_speed
tweak_data.projectiles.elastic_arrow.adjust_z = -130
tweak_data.projectiles.elastic_arrow_poison.launch_speed = tweak_data.projectiles.west_arrow.launch_speed
tweak_data.projectiles.elastic_arrow_poison.adjust_z = -130
tweak_data.projectiles.elastic_arrow_exp.launch_speed = tweak_data.projectiles.west_arrow.launch_speed
tweak_data.projectiles.elastic_arrow_exp.adjust_z = -130
]]
-- pistol crossbow
tweak_data.projectiles.crossbow_arrow.damage = 72.0
tweak_data.projectiles.crossbow_poison_arrow.damage = 72.0
tweak_data.projectiles.crossbow_arrow_exp.damage = 144.0
--[[
tweak_data.projectiles.crossbow_arrow.launch_speed = 2000
tweak_data.projectiles.crossbow_arrow.adjust_z = 50
tweak_data.projectiles.crossbow_poison_arrow.launch_speed = 2000
tweak_data.projectiles.crossbow_poison_arrow.adjust_z = 50
tweak_data.projectiles.crossbow_arrow_exp.launch_speed = 2000
tweak_data.projectiles.crossbow_arrow_exp.adjust_z = 50
]]
-- light crossbow
tweak_data.projectiles.frankish_arrow.damage = 72.0
tweak_data.projectiles.frankish_poison_arrow.damage = 72.0
tweak_data.projectiles.frankish_arrow_exp.damage = 144.0
--[[
tweak_data.projectiles.frankish_arrow.launch_speed = 3000
tweak_data.projectiles.frankish_arrow.adjust_z = 0
tweak_data.projectiles.frankish_poison_arrow.launch_speed = tweak_data.projectiles.frankish_arrow.launch_speed
tweak_data.projectiles.frankish_poison_arrow.adjust_z = tweak_data.projectiles.frankish_arrow.adjust_z
tweak_data.projectiles.frankish_arrow_exp.launch_speed = tweak_data.projectiles.frankish_arrow.launch_speed
tweak_data.projectiles.frankish_arrow_exp.adjust_z = tweak_data.projectiles.frankish_arrow.adjust_z
]]
-- heavy crossbow
tweak_data.projectiles.arblast_arrow.damage = 160.0
tweak_data.projectiles.arblast_poison_arrow.damage = 140.0
tweak_data.projectiles.arblast_arrow_exp.damage = 320.0
--[[
tweak_data.projectiles.arblast_arrow.launch_speed = tweak_data.projectiles.frankish_arrow.launch_speed
tweak_data.projectiles.arblast_arrow.adjust_z = tweak_data.projectiles.frankish_arrow.adjust_z
tweak_data.projectiles.arblast_poison_arrow.launch_speed = tweak_data.projectiles.frankish_arrow.launch_speed
tweak_data.projectiles.arblast_poison_arrow.adjust_z = tweak_data.projectiles.frankish_arrow.adjust_z
tweak_data.projectiles.arblast_arrow_exp.launch_speed = tweak_data.projectiles.frankish_arrow.launch_speed
tweak_data.projectiles.arblast_arrow_exp.adjust_z = tweak_data.projectiles.frankish_arrow.adjust_z
]]
-- airbow
tweak_data.projectiles.ecp_arrow.damage = 50.0
tweak_data.projectiles.ecp_arrow_poison.damage = 50.0
tweak_data.projectiles.ecp_arrow_exp.damage = 100.0
--[[
tweak_data.projectiles.arblast_arrow.launch_speed = tweak_data.projectiles.frankish_arrow.launch_speed
tweak_data.projectiles.arblast_arrow.adjust_z = tweak_data.projectiles.frankish_arrow.adjust_z
tweak_data.projectiles.arblast_poison_arrow.launch_speed = tweak_data.projectiles.frankish_arrow.launch_speed
tweak_data.projectiles.arblast_poison_arrow.adjust_z = tweak_data.projectiles.frankish_arrow.adjust_z
tweak_data.projectiles.arblast_arrow_exp.launch_speed = tweak_data.projectiles.frankish_arrow.launch_speed
tweak_data.projectiles.arblast_arrow_exp.adjust_z = tweak_data.projectiles.frankish_arrow.adjust_z
]]