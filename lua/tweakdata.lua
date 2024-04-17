if not tweak_data then
	return
end

-- high velocity nades
tweak_data.projectiles.launcher_velocity = deep_clone(tweak_data.projectiles.launcher_frag)
tweak_data.projectiles.launcher_velocity.launch_speed = 3750
tweak_data.projectiles.launcher_velocity.name_id = "bm_launcher_frag_velocity"
tweak_data.weapon_disable_crit_for_damage.launcher_velocity = {explosion = false,fire = false}
tweak_data.projectiles.launcher_velocity_m32 = deep_clone(tweak_data.projectiles.launcher_velocity)
tweak_data.weapon_disable_crit_for_damage.launcher_velocity_m32 = {explosion = false,fire = false}
tweak_data.projectiles.launcher_velocity_china = deep_clone(tweak_data.projectiles.launcher_velocity)
tweak_data.projectiles.launcher_velocity_china.damage = 96
tweak_data.weapon_disable_crit_for_damage.launcher_velocity_china = {explosion = false,fire = false}
tweak_data.projectiles.launcher_velocity_slap = deep_clone(tweak_data.projectiles.launcher_velocity)
tweak_data.weapon_disable_crit_for_damage.launcher_velocity_slap = {explosion = false,fire = false}

tweak_data.projectiles.underbarrel_velocity_frag = deep_clone(tweak_data.projectiles.launcher_frag)
tweak_data.projectiles.underbarrel_velocity_frag.launch_speed = 3750
tweak_data.projectiles.underbarrel_velocity_frag.name_id = "bm_launcher_underbarrel_velocity_frag"
tweak_data.weapon_disable_crit_for_damage.underbarrel_velocity_frag = {explosion = false,fire = false}
tweak_data.projectiles.underbarrel_velocity_frag_groza = deep_clone(tweak_data.projectiles.underbarrel_velocity_frag)
tweak_data.weapon_disable_crit_for_damage.underbarrel_velocity_frag_groza = {explosion = false,fire = false}