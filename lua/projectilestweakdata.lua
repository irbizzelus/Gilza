-- spoof high velocity grenades so we dont send incorrect indexes to the host and start throwing hand grenades from our launchers
Hooks:OverrideFunction(BlackMarketTweakData, "get_index_from_projectile_id", function (self, projectile_id)
	local Gilza_projectiles = {
		launcher_velocity = "launcher_frag",
		launcher_velocity_china = "launcher_frag_china",
		launcher_velocity_m32 = "launcher_frag_m32",
		launcher_velocity_slap = "launcher_frag_slap",
		underbarrel_velocity_frag = "launcher_m203",
		underbarrel_velocity_frag_groza = "underbarrel_m203_groza"
	}
	
	if Gilza_projectiles[projectile_id] then
		projectile_id = Gilza_projectiles[projectile_id]
	end
	
	-- base game code
	for index, entry_name in ipairs(self._projectiles_index) do
		if entry_name == projectile_id then
			return index
		end
	end

	return 0
end)

Hooks:PostHook(BlackMarketTweakData, "_init_projectiles", "Gilza_init_projectiles", function(self, params)
	-- Change Sicario smoke grenade cooldown from 60 to 40
	self.projectiles.smoke_screen_grenade.base_cooldown = 45
	-- Change Hacker ECM cooldown from 100 to 140
	self.projectiles.pocket_ecm_jammer.base_cooldown = 140
	
	-- init new launcher velocity nades
	self.projectiles.launcher_velocity = deep_clone(self.projectiles.launcher_frag)
	self.projectiles.launcher_velocity_china = deep_clone(self.projectiles.launcher_frag)
	self.projectiles.launcher_velocity_china.weapon_id = "china"
	self.projectiles.launcher_velocity_china.unit = "units/pd2_dlc_lupus/weapons/wpn_launcher_frag_grenade_china/wpn_launcher_frag_grenade_china"
	self.projectiles.launcher_velocity_m32 = deep_clone(self.projectiles.launcher_frag)
	self.projectiles.launcher_velocity_m32.weapon_id = "m32"
	self.projectiles.launcher_velocity_slap = deep_clone(self.projectiles.launcher_frag)
	self.projectiles.launcher_velocity_slap.weapon_id = "slap"
	
	self.projectiles.underbarrel_velocity_frag = deep_clone(self.projectiles.launcher_m203)
	self.projectiles.underbarrel_velocity_frag_groza = deep_clone(self.projectiles.underbarrel_velocity_frag)
	self.projectiles.underbarrel_velocity_frag_groza.unit = "units/pd2_dlc_sawp/weapons/wpn_launcher_electric/wpn_underbarrel_m203_groza"
	self.projectiles.underbarrel_velocity_frag_groza.weapon_id = "groza"
end)
