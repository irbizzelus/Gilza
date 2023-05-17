local function has_value (tab, val)
    for index, value in ipairs(tab) do
        if value == val then
            return true
        end
    end
    return false
end

local exceptions = {
	"npc_melee",
	"ceiling_turret_module_longer_range",
	"sentry_gun",
	"ceiling_turret_module_no_idle",
	"elastic",
	"x_type54_underbarrel",
	"crate_turret_module",
	"ceiling_turret_module",
	"type54_underbarrel",
	"swat_van_turret_module",
	"ranc_heavy_machine_gun",
	"crosshair",
	"aa_turret_module",
	"factory",
	"stats",
	"groza_underbarrel",
	"trip_mines",
	"contraband_m203",
}

local customWeaponsList = {}
function Gilza.initCutsomGuns()
	if Gilza.defaultWeapons then
		for gun, stats in pairs(tweak_data.weapon) do
			if not (string.sub(gun,-5,-1) == "_crew" or string.sub(gun,-3,-1) == "npc") and not (has_value(Gilza.defaultWeapons,gun)) and not (has_value(exceptions,gun)) then
				table.insert(customWeaponsList,gun)
			end
		end
		Gilza.tryAddingNewGuns()
	else
		log("[Gilza] Could not load default weapon list, custom weapon stats can not be applied.")
	end
end

function Gilza.tryAddingNewGuns()
	if #customWeaponsList >= 1 then
		for j=1, #customWeaponsList do
			if tweak_data.weapon[customWeaponsList[j]] then
				-- AR check
				for i=1, #tweak_data.weapon[customWeaponsList[j]].categories do
					if tweak_data.weapon[customWeaponsList[j]].categories[i] == "assault_rifle" then
						tweak_data.weapon[customWeaponsList[j]].stats.damage = math.floor(tweak_data.weapon[customWeaponsList[j]].stats.damage * 1.75)
						Gilza.applyCustomAR_stats(customWeaponsList[j])
					end
				end
				for i=1, #tweak_data.weapon[customWeaponsList[j]].categories do
					if tweak_data.weapon[customWeaponsList[j]].categories[i] == "smg" then
						tweak_data.weapon[customWeaponsList[j]].stats.damage = math.floor(tweak_data.weapon[customWeaponsList[j]].stats.damage * 1.75)
						Gilza.applyCustomSMG_stats(customWeaponsList[j])
					end
				end
				for i=1, #tweak_data.weapon[customWeaponsList[j]].categories do
					if tweak_data.weapon[customWeaponsList[j]].categories[i] == "pistol" then
						tweak_data.weapon[customWeaponsList[j]].stats.damage = math.floor(tweak_data.weapon[customWeaponsList[j]].stats.damage * 1.75)
						-- im 80% positive that custom revolvers dont have this tag, but oh well
						if tweak_data.weapon[customWeaponsList[j]].categories[i] == "revolver" then
							Gilza.applyCustomPISTOL_stats(customWeaponsList[j],true)
						else
							Gilza.applyCustomPISTOL_stats(customWeaponsList[j],false)
						end
					end
				end
				-- add more categories checks to apply stats to more weapon types later
				-- popular weapon categories on MWS that i'll have to add: melee,sniper,shotgun,lmg
			end
		end
	end
end

function Gilza.applyCustomAR_stats(id)

	log("[Gilza] Applying custom weapon stats to AR with id: "..tostring(id))
	
	-- adjust damage profiles and ammo pick up based on weapons damage (after dmg increase in the init function above)
	-- if AR has lower then 100 dmg, dont apply any changes to dmg or pick up, considering that the range of breakpoints down there is way to big, let normal stats work
	
	-- light AR's
	if tweak_data.weapon[id].stats.damage >= 100 and tweak_data.weapon[id].stats.damage <= 125 then
		tweak_data.weapon[id].stats.damage = 117
		tweak_data.weapon[id].AMMO_PICKUP = {3.64,6.15}
		
	-- low mid AR's
	elseif tweak_data.weapon[id].stats.damage >= 126 and tweak_data.weapon[id].stats.damage <= 152 then
		tweak_data.weapon[id].stats.damage = 146
		tweak_data.weapon[id].AMMO_PICKUP = {3.111,4.35}
		
	-- high mid AR's
	elseif tweak_data.weapon[id].stats.damage >= 153 and tweak_data.weapon[id].stats.damage <= 200 then
		tweak_data.weapon[id].stats.damage = 177
		tweak_data.weapon[id].AMMO_PICKUP = {2.8,3.73}
		
	-- heavy AR's
	elseif tweak_data.weapon[id].stats.damage >= 201 and tweak_data.weapon[id].stats.damage <= 350 then
		tweak_data.weapon[id].stats.damage = 210
		tweak_data.weapon[id].AMMO_PICKUP = {2.12,3.12}
		
	-- super heavy AR's
	elseif tweak_data.weapon[id].stats.damage >= 351 then
		tweak_data.weapon[id].stats.damage = 420
		tweak_data.weapon[id].AMMO_PICKUP = {0.6937,1.294}
	end
end

function Gilza.applyCustomSMG_stats(id)

	log("[Gilza] Applying custom weapon stats to SMG with id: "..tostring(id))
	
	-- same as with AR's - dont touch guns with REALLY low damage
	if tweak_data.weapon[id].stats.damage >= 77 and tweak_data.weapon[id].stats.damage <= 92 then
		tweak_data.weapon[id].stats.damage = 77
		tweak_data.weapon[id].AMMO_PICKUP = {4.26,7.1}
	elseif tweak_data.weapon[id].stats.damage >= 93 and tweak_data.weapon[id].stats.damage <= 110 then
		tweak_data.weapon[id].stats.damage = 95
		tweak_data.weapon[id].AMMO_PICKUP = {3.98,6.83}
	elseif tweak_data.weapon[id].stats.damage >= 111 and tweak_data.weapon[id].stats.damage <= 129 then
		tweak_data.weapon[id].stats.damage = 117
		tweak_data.weapon[id].AMMO_PICKUP = {2.79,4.72}
	elseif tweak_data.weapon[id].stats.damage >= 130 and tweak_data.weapon[id].stats.damage <= 147 then
		tweak_data.weapon[id].stats.damage = 146
		tweak_data.weapon[id].AMMO_PICKUP = {2.39,3.34}
	elseif tweak_data.weapon[id].stats.damage >= 148 and tweak_data.weapon[id].stats.damage <= 200 then
		tweak_data.weapon[id].stats.damage = 183
		tweak_data.weapon[id].AMMO_PICKUP = {2.15,2.99}
	elseif tweak_data.weapon[id].stats.damage >= 201 then
		tweak_data.weapon[id].stats.damage = 210
		tweak_data.weapon[id].AMMO_PICKUP = {1.62,2.39}
	end
end

function Gilza.applyCustomPISTOL_stats(id, isRevolver)

	log("[Gilza] Applying custom weapon stats to pistol with id: "..tostring(id))
	
	-- same as with others - dont touch guns with REALLY low damage
	if tweak_data.weapon[id].stats.damage >= 77 and tweak_data.weapon[id].stats.damage <= 92 then
		tweak_data.weapon[id].stats.damage = 77
		tweak_data.weapon[id].AMMO_PICKUP = {4.26,7.1}
	elseif tweak_data.weapon[id].stats.damage >= 93 and tweak_data.weapon[id].stats.damage <= 110 then
		tweak_data.weapon[id].stats.damage = 95
		tweak_data.weapon[id].AMMO_PICKUP = {3.98,6.83}
	elseif tweak_data.weapon[id].stats.damage >= 111 and tweak_data.weapon[id].stats.damage <= 129 then
		tweak_data.weapon[id].stats.damage = 117
		tweak_data.weapon[id].AMMO_PICKUP = {2.79,4.72}
	elseif tweak_data.weapon[id].stats.damage >= 130 and tweak_data.weapon[id].stats.damage <= 147 then
		tweak_data.weapon[id].stats.damage = 146
		tweak_data.weapon[id].AMMO_PICKUP = {2.39,3.34}
	elseif tweak_data.weapon[id].stats.damage >= 148 and tweak_data.weapon[id].stats.damage <= 200 then
		tweak_data.weapon[id].stats.damage = 183
		tweak_data.weapon[id].AMMO_PICKUP = {2.15,2.99}
	elseif tweak_data.weapon[id].stats.damage >= 201 and isRevolver then
		tweak_data.weapon[id].stats.damage = 420
		tweak_data.weapon[id].AMMO_PICKUP = {0.53,0.99}
	elseif tweak_data.weapon[id].stats.damage >= 201 then
		tweak_data.weapon[id].stats.damage = 210
		tweak_data.weapon[id].AMMO_PICKUP = {1.62,2.39}
	end
	
	if tweak_data.weapon[id].fire_mode_data then
		tweak_data.weapon[id].fire_mode_data.fire_rate = tweak_data.weapon[id].fire_mode_data.fire_rate * 1.5
	end
	if tweak_data.weapon[id].single then
		tweak_data.weapon[id].single.fire_rate = tweak_data.weapon[id].single.fire_rate * 1.5
	end
	if tweak_data.weapon[id].auto then
		tweak_data.weapon[id].auto.fire_rate = tweak_data.weapon[id].auto.fire_rate * 1.5
	end
	
end

function Gilza.checkforweapontweaks()
	if tweak_data and tweak_data.weapon then
		Gilza.initCutsomGuns()
	else
		-- if we dont have stats yet, wait for them
		DelayedCalls:Add("Gilza_wpntweaks", 0.15, function()
			Gilza.checkforweapontweaks()
		end)
	end
end
Gilza.checkforweapontweaks()