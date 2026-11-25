-- swap high velocity grenade indexes so that we dont send incorrect ones to a vanilla host, making us throw hand grenades from the launcher
-- while hosting index is only used to tell clients what projectile was fired while the actual id is used for velocity calculations, and explosion is also host sided
-- the only desync with vanilla players is that the projectile itself from client's POV would have standard velocity and would land before the explosion, but its not that eye catchy
-- the way vanilla proj sync is setup is unironically perfect for this HV implementation ngl
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
		if Network:is_server() or (Network:is_client() and not Gilza.peers_with_mod[1]) then
			projectile_id = Gilza_projectiles[projectile_id]
		else
			local Gilza_projectile_indexes = {
				launcher_velocity = 127,
				launcher_velocity_china = 126,
				launcher_velocity_m32 = 125,
				launcher_velocity_slap = 124,
				underbarrel_velocity_frag = 123,
				underbarrel_velocity_frag_groza = 122
			}
			if Gilza_projectile_indexes[projectile_id] then
				return Gilza_projectile_indexes[projectile_id]
			end
		end
	end
	
	-- base game code
	for index, entry_name in ipairs(self._projectiles_index) do
		if entry_name == projectile_id then
			return index
		end
	end

	return 0
end)

Hooks:PostHook(BlackMarketTweakData, "_init_projectiles", "Gilza_post_BlackMarketTweakData_init_projectiles", function(self, params)
	-- Change Hacker ECM cooldown
	self.projectiles.pocket_ecm_jammer.base_cooldown = 150
	
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
	
	-- custom projectile indexes used by Gilza clients to send throw requests to host if they got Gilza installed
	self._projectiles_index[127] = "launcher_velocity"
	self._projectiles_index[126] = "launcher_velocity_china"
	self._projectiles_index[125] = "launcher_velocity_m32"
	self._projectiles_index[124] = "launcher_velocity_slap"
	self._projectiles_index[123] = "underbarrel_velocity_frag"
	self._projectiles_index[122] = "underbarrel_velocity_frag_groza"
end)