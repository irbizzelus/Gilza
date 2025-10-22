-- a horrible solution to a weird problem - custom ammo that overrides weapon sounds makes that gun sounds horribly loud if used by other clients or npcs
-- because it uses override sounds, instead of using npc sounds that are normaly quiet. since this has never been an issue untill this blast rifle thing
-- we are using a shitty solution to a problem most likely caused by weaponlib
Hooks:PreHook(NewNPCRaycastWeaponBase, "_sound_autofire_start", "Gilza_NewNPCRaycastWeaponBase_sound_autofire_start_pre", function(self, nr_shots)
	if self._name_id == "blast_crew" or self._name_id == "blast_npc" then
		if table.contains(self._blueprint, "wpn_fps_upg_blast_ammo_ap") then
			table.delete(self._blueprint, "wpn_fps_upg_blast_ammo_ap")
		end
		if table.contains(self._blueprint, "wpn_fps_upg_blast_ammo_fire") then
			table.delete(self._blueprint, "wpn_fps_upg_blast_ammo_fire")
		end
		if table.contains(self._blueprint, "wpn_fps_upg_blast_ammo_poison") then
			table.delete(self._blueprint, "wpn_fps_upg_blast_ammo_poison")
		end
		if table.contains(self._blueprint, "wpn_fps_upg_blast_ammo_stun") then
			table.delete(self._blueprint, "wpn_fps_upg_blast_ammo_stun")
		end
		if table.contains(self._blueprint, "wpn_fps_upg_blast_ammo_syphon") then
			table.delete(self._blueprint, "wpn_fps_upg_blast_ammo_syphon")
		end
	end
end)

Hooks:PreHook(NewNPCRaycastWeaponBase, "_sound_singleshot", "Gilza_NewNPCRaycastWeaponBase_sound_singleshot_pre", function(self)
	if self._name_id == "blast_crew" or self._name_id == "blast_npc" then
		if table.contains(self._blueprint, "wpn_fps_upg_blast_ammo_ap") then
			table.delete(self._blueprint, "wpn_fps_upg_blast_ammo_ap")
		end
		if table.contains(self._blueprint, "wpn_fps_upg_blast_ammo_fire") then
			table.delete(self._blueprint, "wpn_fps_upg_blast_ammo_fire")
		end
		if table.contains(self._blueprint, "wpn_fps_upg_blast_ammo_poison") then
			table.delete(self._blueprint, "wpn_fps_upg_blast_ammo_poison")
		end
		if table.contains(self._blueprint, "wpn_fps_upg_blast_ammo_stun") then
			table.delete(self._blueprint, "wpn_fps_upg_blast_ammo_stun")
		end
		if table.contains(self._blueprint, "wpn_fps_upg_blast_ammo_syphon") then
			table.delete(self._blueprint, "wpn_fps_upg_blast_ammo_syphon")
		end
	end
end)