if tweak_data and tweak_data.projectiles then
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
end

-- overrides total ammo mod table to enable support for float values for total_ammo_mod, while keeping older values the same.
-- goes up to 20000 entries aka 200 total_ammo_mod max. base game has 20k entries at 20k total_ammo_mod max, thus the limit
-- techincally can be increased to include the base game limit of 1000x times the max ammo, but screw that
-- i dont think anyone should be able to use total_ammo_mod with values over 2x max ammo anyway, with only exceptions being some weird custom guns
-- so, this func here provides a limit of 10x, to avoid using more memory then this table would in the base game.
local function Override_total_ammo_mod_values()
	tweak_data.weapon.stats.total_ammo_mod = {}
	local mod_value = -1
	for i=1,200, 0.01 do
		i = math.floor(i * 1000 + 0.5)
		i = i / 1000
		mod_value = math.floor(mod_value * 100000 + 0.5)
		mod_value = mod_value / 100000
		tweak_data.weapon.stats.total_ammo_mod[i] = mod_value
		mod_value = mod_value + 0.0005
	end
end
Override_total_ammo_mod_values()