if not Gilza then
	dofile("mods/Gilza/lua/1_GilzaBase.lua")
end

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
	
	tweak_data.projectiles.crossbow_arrow.damage = 41
	tweak_data.projectiles.crossbow_poison_arrow.damage = 20
	tweak_data.projectiles.crossbow_arrow_exp.damage = 82
	
	tweak_data.projectiles.frankish_arrow.damage = 41
	tweak_data.projectiles.frankish_poison_arrow.damage = 20
	tweak_data.projectiles.frankish_arrow_exp.damage = 82
	
	tweak_data.projectiles.arblast_arrow.damage = 90
	tweak_data.projectiles.arblast_poison_arrow.damage = 60
	tweak_data.projectiles.arblast_arrow_exp.damage = 180
	
	tweak_data.projectiles.ecp_arrow.damage = 20
	tweak_data.projectiles.ecp_arrow_poison.damage = 5
	tweak_data.projectiles.ecp_arrow_exp.damage = 50
	
	tweak_data.projectiles.west_arrow.damage = 50
	tweak_data.projectiles.west_arrow_exp.damage = 100
	tweak_data.projectiles.bow_poison_arrow.damage = 40
	
	tweak_data.projectiles.long_arrow.damage = 130
	tweak_data.projectiles.long_poison_arrow.damage = 60
	tweak_data.projectiles.long_arrow_exp.damage = 250
	
	tweak_data.projectiles.elastic_arrow.damage = 130
	tweak_data.projectiles.elastic_arrow_poison.damage = 60
	tweak_data.projectiles.elastic_arrow_exp.damage = 250
	
	-- throwables that we can adjust for better breakpoints, since they are client authorative. thank fuck.
	tweak_data.projectiles.wpn_prj_ace.damage = 30
	tweak_data.projectiles.wpn_prj_four.damage = 15
	tweak_data.projectiles.wpn_prj_target.damage = 100
	tweak_data.projectiles.wpn_prj_hur.damage = 130
	
end

-- swaping camera location when using bipods when BTAW mod is found. makes them all closer to the fronal iron sight for both ease of use and better compatibility with various scopes
if Gilza.BTAW_enabled and tweak_data and tweak_data.player and tweak_data.player.stances then
	
	-- rpk
	if tweak_data.player.stances.rpk and tweak_data.player.stances.rpk.bipod then
		local pivot_shoulder_translation = Vector3(10.6138, 41.7178, -3.97323)
		local pivot_shoulder_rotation = Rotation(0.106543, -0.0842801, 0.628575)
		local pivot_head_translation = Vector3(0, 0, 0)
		local pivot_head_rotation = Rotation(0, 0, 0)
		tweak_data.player.stances.rpk.bipod.shoulders.translation = pivot_head_translation - pivot_shoulder_translation:rotate_with(pivot_shoulder_rotation:inverse()):rotate_with(pivot_head_rotation)
		tweak_data.player.stances.rpk.bipod.shoulders.rotation = pivot_head_rotation * pivot_shoulder_rotation:inverse()
		tweak_data.player.stances.rpk.bipod.vel_overshot.pivot = pivot_shoulder_translation + Vector3(0, -0, 0)
		tweak_data.player.stances.rpk.bipod.shakers = {breathing = {}}	
		tweak_data.player.stances.rpk.bipod.shakers.breathing.amplitude = 0
	end
	
	-- par/ksp58
	if tweak_data.player.stances.par and tweak_data.player.stances.par.bipod then
		local pivot_shoulder_translation = Vector3(10.0, 18.38842, -1.747177)
		local pivot_shoulder_rotation = Rotation(0.106618, -0.084954, 0.62858)
		local pivot_head_translation = Vector3(0, 0, 0)
		local pivot_head_rotation = Rotation(0, 0, 0)
		tweak_data.player.stances.par.bipod.shoulders.translation = pivot_head_translation - pivot_shoulder_translation:rotate_with(pivot_shoulder_rotation:inverse()):rotate_with(pivot_head_rotation)
		tweak_data.player.stances.par.bipod.shoulders.rotation = pivot_head_rotation * pivot_shoulder_rotation:inverse()
		tweak_data.player.stances.par.bipod.vel_overshot.pivot = pivot_shoulder_translation + Vector3(0, -0, 0)
		tweak_data.player.stances.par.bipod.shakers = {breathing = {}}	
		tweak_data.player.stances.par.bipod.shakers.breathing.amplitude = 0
	end
	
	-- m60
	if tweak_data.player.stances.m60 and tweak_data.player.stances.m60.bipod then
		local pivot_shoulder_translation = Vector3(10.6356, 24.5, 0.095)
		local pivot_shoulder_rotation = Rotation(0.106618, -0.084954, 0.62858)
		local pivot_head_translation = Vector3(0, 0, 0)
		local pivot_head_rotation = Rotation(0, 0, 0)
		tweak_data.player.stances.m60.bipod.shoulders.translation = pivot_head_translation - pivot_shoulder_translation:rotate_with(pivot_shoulder_rotation:inverse()):rotate_with(pivot_head_rotation)
		tweak_data.player.stances.m60.bipod.shoulders.rotation = pivot_head_rotation * pivot_shoulder_rotation:inverse()
		tweak_data.player.stances.m60.bipod.vel_overshot.pivot = pivot_shoulder_translation + Vector3(0, -0, 0)
		tweak_data.player.stances.m60.bipod.shakers = {breathing = {}}	
		tweak_data.player.stances.m60.bipod.shakers.breathing.amplitude = 0
	end
	
	-- m249
	if tweak_data.player.stances.m249 and tweak_data.player.stances.m249.bipod then
		local pivot_shoulder_translation = Vector3(10.7056, 16.38842, 0.547177)
		local pivot_shoulder_rotation = Rotation(0.106618, -0.084954, 0.62858)
		local pivot_head_translation = Vector3(0, 0, 0)
		local pivot_head_rotation = Rotation(0, 0, 0)
		tweak_data.player.stances.m249.bipod.shoulders.translation = pivot_head_translation - pivot_shoulder_translation:rotate_with(pivot_shoulder_rotation:inverse()):rotate_with(pivot_head_rotation)
		tweak_data.player.stances.m249.bipod.shoulders.rotation = pivot_head_rotation * pivot_shoulder_rotation:inverse()
		tweak_data.player.stances.m249.bipod.vel_overshot.pivot = pivot_shoulder_translation + Vector3(0, -0, 0)
		tweak_data.player.stances.m249.bipod.shakers = {breathing = {}}	
		tweak_data.player.stances.m249.bipod.shakers.breathing.amplitude = 0
	end
	
	-- mg42
	if tweak_data.player.stances.mg42 and tweak_data.player.stances.mg42.bipod then
		local pivot_shoulder_translation = Vector3(10.6884, 27.1711, 0.871937)
		local pivot_shoulder_rotation = Rotation(0.106614, -0.0857193, 0.628153)
		local pivot_head_translation = Vector3(0, 0, 0)
		local pivot_head_rotation = Rotation(0, 0, 0)
		tweak_data.player.stances.mg42.bipod.shoulders.translation = pivot_head_translation - pivot_shoulder_translation:rotate_with(pivot_shoulder_rotation:inverse()):rotate_with(pivot_head_rotation)
		tweak_data.player.stances.mg42.bipod.shoulders.rotation = pivot_head_rotation * pivot_shoulder_rotation:inverse()
		tweak_data.player.stances.mg42.bipod.vel_overshot.pivot = pivot_shoulder_translation + Vector3(0, -0, 0)
		tweak_data.player.stances.mg42.bipod.shakers = {breathing = {}}	
		tweak_data.player.stances.mg42.bipod.shakers.breathing.amplitude = 0
	end
	
	-- hk21
	if tweak_data.player.stances.hk21 and tweak_data.player.stances.hk21.bipod then
		local pivot_shoulder_translation = Vector3(8.545, 16.3934, -2.53201)
		local pivot_shoulder_rotation = Rotation(4.78916e-05, 0.00548037, -0.00110991)
		local pivot_head_translation = Vector3(0, 0, 0)
		local pivot_head_rotation = Rotation(0, 0, 0)
		tweak_data.player.stances.hk21.bipod.shoulders.translation = pivot_head_translation - pivot_shoulder_translation:rotate_with(pivot_shoulder_rotation:inverse()):rotate_with(pivot_head_rotation)
		tweak_data.player.stances.hk21.bipod.shoulders.rotation = pivot_head_rotation * pivot_shoulder_rotation:inverse()
		tweak_data.player.stances.hk21.bipod.vel_overshot.pivot = pivot_shoulder_translation + Vector3(0, -0, 0)
		tweak_data.player.stances.hk21.bipod.shakers = {breathing = {}}	
		tweak_data.player.stances.hk21.bipod.shakers.breathing.amplitude = 0
	end
	
	-- galil
	if tweak_data.player.stances.galil and tweak_data.player.stances.galil.bipod then
		local pivot_shoulder_translation = Vector3(10.6632, 48.0834, -3.26603)
		local pivot_shoulder_rotation = Rotation(0.106684, -0.084986, 0.628584)
		local pivot_head_translation = Vector3(0, 0, 0)	
		local pivot_head_rotation = Rotation(0, 0, 0)
		tweak_data.player.stances.galil.bipod.shoulders.translation = pivot_head_translation - pivot_shoulder_translation:rotate_with(pivot_shoulder_rotation:inverse()):rotate_with(pivot_head_rotation)
		tweak_data.player.stances.galil.bipod.shoulders.rotation = pivot_head_rotation * pivot_shoulder_rotation:inverse()
		tweak_data.player.stances.galil.bipod.vel_overshot.pivot = pivot_shoulder_translation + Vector3(0, -30, 0)
		tweak_data.player.stances.galil.bipod.shakers = {breathing = {}}	
		tweak_data.player.stances.galil.bipod.shakers.breathing.amplitude = 0
	end
	
	-- g3
	if tweak_data.player.stances.g3 and tweak_data.player.stances.g3.bipod then
		local pivot_shoulder_translation = Vector3(10.6681, 44.5458, -1.53827)
		local pivot_shoulder_rotation = Rotation(0.106686, -0.0859334, 0.627737)
		local pivot_head_translation = Vector3(0, 0, 0)	
		local pivot_head_rotation = Rotation(0, 0, 0)
		tweak_data.player.stances.g3.bipod.shoulders.translation = pivot_head_translation - pivot_shoulder_translation:rotate_with(pivot_shoulder_rotation:inverse()):rotate_with(pivot_head_rotation)
		tweak_data.player.stances.g3.bipod.shoulders.rotation = pivot_head_rotation * pivot_shoulder_rotation:inverse()
		tweak_data.player.stances.g3.bipod.vel_overshot.pivot = pivot_shoulder_translation + Vector3(0, -30, 0)
		tweak_data.player.stances.g3.bipod.shakers = {breathing = {}}	
		tweak_data.player.stances.g3.bipod.shakers.breathing.amplitude = 0
	end
	
	-- wa2000
	if tweak_data.player.stances.wa2000 and tweak_data.player.stances.wa2000.bipod then
		tweak_data.player.stances.wa2000.bipod.FOV = 20
	end
	
	-- m95 -- pretty bad still
	if tweak_data.player.stances.m95 and tweak_data.player.stances.m95.bipod then
		local pivot_shoulder_translation = Vector3(12.9634, 33.463, 1.1494)
		local pivot_shoulder_rotation = Rotation(0.113234, 0.518279, 0.627416)
		local pivot_head_translation = Vector3(0, 0, 0)	
		local pivot_head_rotation = Rotation(0, 0, 0)
		tweak_data.player.stances.m95.bipod.shoulders.translation = pivot_head_translation - pivot_shoulder_translation:rotate_with(pivot_shoulder_rotation:inverse()):rotate_with(pivot_head_rotation)
		tweak_data.player.stances.m95.bipod.shoulders.rotation = pivot_head_rotation * pivot_shoulder_rotation:inverse()
		tweak_data.player.stances.m95.bipod.vel_overshot.pivot = pivot_shoulder_translation + Vector3(0, -30, 0)
		tweak_data.player.stances.m95.bipod.shakers = {breathing = {}}	
		tweak_data.player.stances.m95.bipod.shakers.breathing.amplitude = 0
		tweak_data.player.stances.m95.bipod.FOV = 35
	end
	
	-- g36
	if tweak_data.player.stances.g36 then
		local pivot_shoulder_translation = Vector3(10.4664, 41.6875, -1.1479)
		local pivot_shoulder_rotation = Rotation(0.157971, -0.000391207, -0.00105803)
		local pivot_head_translation = Vector3(0, 0, 0)	
		local pivot_head_rotation = Rotation(0, 0, 0)
		tweak_data.player.stances.g36.bipod = {
			shoulders = {},
			vel_overshot = {}
		}
		tweak_data.player.stances.g36.bipod.shoulders.translation = pivot_head_translation - pivot_shoulder_translation:rotate_with(pivot_shoulder_rotation:inverse()):rotate_with(pivot_head_rotation)
		tweak_data.player.stances.g36.bipod.shoulders.rotation = pivot_head_rotation * pivot_shoulder_rotation:inverse()
		tweak_data.player.stances.g36.bipod.vel_overshot.pivot = pivot_shoulder_translation + Vector3(0, -30, 0)
		tweak_data.player.stances.g36.bipod.vel_overshot.yaw_neg = 0
		tweak_data.player.stances.g36.bipod.vel_overshot.yaw_pos = 0
		tweak_data.player.stances.g36.bipod.vel_overshot.pitch_neg = 0
		tweak_data.player.stances.g36.bipod.vel_overshot.pitch_pos = 0

		tweak_data.player.stances.g36.bipod.FOV = 50
		tweak_data.player.stances.g36.bipod.shakers = {breathing = {}}
		tweak_data.player.stances.g36.bipod.shakers.breathing.amplitude = 0
	end
	
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