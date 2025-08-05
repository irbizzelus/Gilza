-- updates UI for weapon's burst fire mode, based on VHUD's implementation, since it should work with it.
Hooks:OverrideFunction(HUDTeammate,"set_weapon_firemode",function(self,id, firemode, ...)
	
	local is_secondary = id == 1
	local secondary_weapon_panel = self._player_panel:child("weapons_panel"):child("secondary_weapon_panel")
	local primary_weapon_panel = self._player_panel:child("weapons_panel"):child("primary_weapon_panel")
	local weapon_selection = is_secondary and secondary_weapon_panel:child("weapon_selection") or primary_weapon_panel:child("weapon_selection")

	if alive(weapon_selection) then
		local firemode_single = weapon_selection:child("firemode_single")
		local firemode_auto = weapon_selection:child("firemode_auto")
		local firemode_mapping = is_secondary and self._firemode_secondary_mapping or self._firemode_primary_mapping

		if firemode_mapping then
			firemode = firemode_mapping[firemode] or firemode
		end

		local is_alt = select(1, ...)

		if is_alt then
			if firemode == "single" then
				firemode = "auto"
			else
				firemode = "single"
			end
		end

		if alive(firemode_single) and alive(firemode_auto) then
			if firemode == "single" then
				firemode_single:show()
				firemode_auto:hide()
			elseif firemode == "burst" then -- this fella
				firemode_single:show()
				firemode_auto:show()
			else
				firemode_single:hide()
				firemode_auto:show()
			end
		end
	end
end)