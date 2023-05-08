function BlackMarketTweakData:get_index_from_projectile_id(projectile_id)
	-- treat high velocity nades like normal grenades, so we dont send incorrect indexes to host and start throwing wrong grenades
	if projectile_id == "launcher_velocity" then
		projectile_id = "launcher_frag"
	elseif projectile_id == "launcher_velocity_china" then
		projectile_id = "launcher_frag_china"
	elseif projectile_id == "launcher_velocity_m32" then
		projectile_id = "launcher_frag_m32"	
	elseif projectile_id == "launcher_velocity_slap" then
		projectile_id = "launcher_frag_slap"	
	end
	for index, entry_name in ipairs(self._projectiles_index) do
		if entry_name == projectile_id then
			return index
		end
	end

	return 0
end

Hooks:PostHook(BlackMarketTweakData, "_init_projectiles", "throwablecounters", function(self, params)
	-- new nade amounts
	self.projectiles.frag.max_amount = 2
	self.projectiles.wpn_prj_four.max_amount = 6
	self.projectiles.wpn_prj_ace.max_amount = 10
	self.projectiles.wpn_prj_hur.max_amount = 3
	self.projectiles.wpn_prj_jav.max_amount = 2
	self.projectiles.wpn_prj_target.max_amount = 5
	self.projectiles.concussion.max_amount = 4
	self.projectiles.dynamite.max_amount = 2
	self.projectiles.frag_com.max_amount = 2
	self.projectiles.fir_com.max_amount = 3
	self.projectiles.dada_com.max_amount = 2
	self.projectiles.molotov.max_amount = 2
	self.projectiles.wpn_gre_electric.max_amount = 3
	
	-- Change Sicario smoke grenade cooldown from 60 to 40
	self.projectiles.smoke_screen_grenade.base_cooldown = 40
	
	-- new launcher nade
	self.projectiles.launcher_velocity = {
		name_id = "bm_launcher_frag",
		unit = "units/pd2_dlc_gage_assault/weapons/wpn_launcher_frag_grenade/wpn_launcher_frag_grenade",
		weapon_id = "gre_m79",
		no_cheat_count = true,
		impact_detonation = true,
		time_cheat = 1
	}
	self.projectiles.launcher_velocity_china = deep_clone(self.projectiles.launcher_velocity)
	self.projectiles.launcher_velocity_china.weapon_id = "china"
	self.projectiles.launcher_velocity_china.unit = "units/pd2_dlc_lupus/weapons/wpn_launcher_frag_grenade_china/wpn_launcher_frag_grenade_china"
	self.projectiles.launcher_velocity_m32 = deep_clone(self.projectiles.launcher_velocity)
	self.projectiles.launcher_velocity_m32.weapon_id = "m32"
	self.projectiles.launcher_velocity_slap = deep_clone(self.projectiles.launcher_velocity)
	self.projectiles.launcher_velocity_slap.weapon_id = "slap"
end)
