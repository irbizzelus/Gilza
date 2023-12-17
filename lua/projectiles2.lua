if not tweak_data then return end

-- normal grenade
tweak_data.projectiles.frag.damage = 500
tweak_data.projectiles.frag.curve_pow = 0.1
tweak_data.projectiles.frag.range = 350

-- 'adhesive' nade
tweak_data.projectiles.sticky_grenade.damage = 200
tweak_data.projectiles.sticky_grenade.range = 350

-- molotov
tweak_data.projectiles.molotov.damage = 1
tweak_data.projectiles.molotov.range = 75
tweak_data.projectiles.molotov.burn_duration = 15

-- incendiary grenade
tweak_data.projectiles.fir_com.damage = 50
tweak_data.projectiles.fir_com.range = 375

-- xmas
if tweak_data.projectiles.xmas_snowball then
	tweak_data.projectiles.xmas_snowball.damage = 45
end

-- shurikens: a bit more impact dmg
tweak_data.projectiles.wpn_prj_four.damage = 25
tweak_data.projectiles.wpn_prj_fouradjust_z = 0

-- throw cards
tweak_data.projectiles.wpn_prj_ace = {
	damage = 56,
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

-- throw axe
tweak_data.projectiles.wpn_prj_hur = {
	damage = 130,
	launch_speed = 1000,
	adjust_z = 0,
	mass_look_up_modifier = 1,
	name_id = "bm_prj_hur",
	push_at_body_index = "dynamic_body_spinn",
	sounds = {deep_clone(tweak_data.projectiles.wpn_prj_hur.sounds)}
}

-- javelin
tweak_data.projectiles.wpn_prj_jav = {
	damage = 800,
	launch_speed = 1500,
	adjust_z = 30,
	mass_look_up_modifier = 1,
	name_id = "bm_prj_jav",
	push_at_body_index = 0,
	sounds = {deep_clone(tweak_data.projectiles.wpn_prj_jav.sounds)}
}

-- dynamyte
tweak_data.projectiles.dynamite = {
	damage = 250,
	curve_pow = 0.1,
	player_damage = 10,
	range = 700,
	name_id = "bm_grenade_frag",
	effect_name = "effects/payday2/particles/explosions/dynamite_explosion"
}

-- electric nade
tweak_data.projectiles.wpn_gre_electric = {
	damage = 120,
	curve_pow = 3.5,
	range = 1200,
	name_id = "bm_electric_grenade",
	sound_event = "grenade_electric_explode"
}

-- gas nade
tweak_data.projectiles.poison_gas_grenade.damage = 10
tweak_data.projectiles.poison_gas_grenade.range = 900
tweak_data.projectiles.poison_gas_grenade.poison_gas_range = 900
tweak_data.projectiles.poison_gas_grenade.poison_gas_duration = 15
tweak_data.projectiles.poison_gas_grenade.poison_gas_fade_time = 2
tweak_data.projectiles.poison_gas_grenade.poison_gas_tick_time = 0.25

-- matryoshka
tweak_data.projectiles.dada_com = {
	damage = 250,
	curve_pow = 0.1,
	range = 700,
	name_id = "bm_grenade_dada_com",
	sound_event = "mtl_explosion"
}

-- community nade
tweak_data.projectiles.frag_com = {
	damage = 500,
	curve_pow = 0.1,
	range = 350,
	name_id = "bm_grenade_frag_com"
}

-- LAUNCHERS
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
tweak_data.projectiles.launcher_incendiary.range = 75
tweak_data.projectiles.launcher_incendiary.burn_duration = 10

tweak_data.projectiles.launcher_incendiary_m32 = deep_clone(tweak_data.projectiles.launcher_incendiary)
tweak_data.projectiles.launcher_incendiary_china = deep_clone(tweak_data.projectiles.launcher_incendiary)
tweak_data.projectiles.launcher_incendiary_slap = deep_clone(tweak_data.projectiles.launcher_incendiary)
tweak_data.projectiles.launcher_incendiary_ms3gl = deep_clone(tweak_data.projectiles.launcher_incendiary)

tweak_data.projectiles.launcher_incendiary_arbiter.range = 90
tweak_data.projectiles.launcher_incendiary_arbiter.burn_duration = 5

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
tweak_data.projectiles.launcher_poison.damage = 10
tweak_data.projectiles.launcher_poison.range = 600
tweak_data.projectiles.launcher_poison.poison_gas_range = 600
tweak_data.projectiles.launcher_poison.poison_gas_duration = 10
tweak_data.projectiles.launcher_poison.poison_gas_fade_time = 2
tweak_data.projectiles.launcher_poison.poison_gas_tick_time = 0.25

tweak_data.projectiles.launcher_poison_ms3gl_conversion = deep_clone(tweak_data.projectiles.launcher_poison)
tweak_data.projectiles.launcher_poison_gre_m79 = deep_clone(tweak_data.projectiles.launcher_poison)
tweak_data.projectiles.launcher_poison_m32 = deep_clone(tweak_data.projectiles.launcher_poison)
tweak_data.projectiles.launcher_poison_groza = deep_clone(tweak_data.projectiles.launcher_poison)
tweak_data.projectiles.launcher_poison_china = deep_clone(tweak_data.projectiles.launcher_poison)
tweak_data.projectiles.launcher_poison_slap = deep_clone(tweak_data.projectiles.launcher_poison)
tweak_data.projectiles.launcher_poison_contraband = deep_clone(tweak_data.projectiles.launcher_poison)
tweak_data.projectiles.launcher_poison_arbiter = deep_clone(tweak_data.projectiles.launcher_poison)
tweak_data.projectiles.launcher_poison_arbiter.range = 350
tweak_data.projectiles.launcher_poison_arbiter.launch_speed = 7000
tweak_data.projectiles.launcher_poison_arbiter.curve_pow = 0.1
tweak_data.projectiles.launcher_poison_arbiter.poison_gas_range = 350
tweak_data.projectiles.launcher_poison_arbiter.poison_gas_duration = 5

tweak_data.projectiles.launcher_electric.damage = 100
tweak_data.projectiles.launcher_electric_slap.damage = 100
tweak_data.projectiles.launcher_electric_m32.damage = 100
tweak_data.projectiles.launcher_electric_china.damage = 100
tweak_data.projectiles.launcher_electric_arbiter.damage = 50
tweak_data.projectiles.launcher_electric_ms3gl.damage = 100

-- plainsrider
tweak_data.projectiles.west_arrow.damage = 72.0
tweak_data.projectiles.bow_poison_arrow.damage = 72.0
tweak_data.projectiles.west_arrow_exp.damage = 144.0

-- longbow
tweak_data.projectiles.long_arrow.damage = 160.0
tweak_data.projectiles.long_poison_arrow.damage = 140.0
tweak_data.projectiles.long_arrow_exp.damage = 320.0

-- compound bow
tweak_data.projectiles.elastic_arrow.damage = 160.0
tweak_data.projectiles.elastic_arrow_poison.damage = 140.0
tweak_data.projectiles.elastic_arrow_exp.damage = 320.0

-- pistol crossbow
tweak_data.projectiles.crossbow_arrow.damage = 72.0
tweak_data.projectiles.crossbow_poison_arrow.damage = 72.0
tweak_data.projectiles.crossbow_arrow_exp.damage = 144.0

-- light crossbow
tweak_data.projectiles.frankish_arrow.damage = 72.0
tweak_data.projectiles.frankish_poison_arrow.damage = 72.0
tweak_data.projectiles.frankish_arrow_exp.damage = 144.0

-- heavy crossbow
tweak_data.projectiles.arblast_arrow.damage = 160.0
tweak_data.projectiles.arblast_poison_arrow.damage = 140.0
tweak_data.projectiles.arblast_arrow_exp.damage = 320.0

-- airbow
tweak_data.projectiles.ecp_arrow.damage = 56.0
tweak_data.projectiles.ecp_arrow_poison.damage = 56.0
tweak_data.projectiles.ecp_arrow_exp.damage = 112.0