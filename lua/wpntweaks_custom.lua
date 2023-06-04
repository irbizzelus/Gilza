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
				for i=1, #tweak_data.weapon[customWeaponsList[j]].categories do
					if tweak_data.weapon[customWeaponsList[j]].categories[i] == "assault_rifle" then
						tweak_data.weapon[customWeaponsList[j]].stats.damage = math.floor(tweak_data.weapon[customWeaponsList[j]].stats.damage * 1.75)
						Gilza.applyCustomAR_stats(customWeaponsList[j])
					elseif tweak_data.weapon[customWeaponsList[j]].categories[i] == "smg" then
						tweak_data.weapon[customWeaponsList[j]].stats.damage = math.floor(tweak_data.weapon[customWeaponsList[j]].stats.damage * 1.75)
						Gilza.applyCustomSMG_stats(customWeaponsList[j])
					elseif tweak_data.weapon[customWeaponsList[j]].categories[i] == "pistol" then
						local isRevolver = false
						for k=1, #tweak_data.weapon[customWeaponsList[j]].categories do
							if tweak_data.weapon[customWeaponsList[j]].categories[i] == "revolver" then
								isRevolver = true
							end							
						end
						tweak_data.weapon[customWeaponsList[j]].stats.damage = math.floor(tweak_data.weapon[customWeaponsList[j]].stats.damage * 1.75)
						Gilza.applyCustomPISTOL_stats(customWeaponsList[j],isRevolver)
					elseif tweak_data.weapon[customWeaponsList[j]].categories[i] == "lmg" then
						tweak_data.weapon[customWeaponsList[j]].stats.damage = math.floor(tweak_data.weapon[customWeaponsList[j]].stats.damage * 1.75)
						Gilza.applyCustomLMG_stats(customWeaponsList[j])
					elseif tweak_data.weapon[customWeaponsList[j]].categories[i] == "snp" then
						Gilza.applyCustomSNIPER_stats(customWeaponsList[j])
					elseif tweak_data.weapon[customWeaponsList[j]].categories[i] == "shotgun" then
						Gilza.applyCustomSHOTGUN_stats(customWeaponsList[j])
					end
				end
				-- add more categories checks to apply stats to more weapon types later
				-- popular weapon categories on MWS that i'll have to add: minigun special maaaaaaaybe
			end
		end
	end
	Gilza.applyCustomMELEE_stats()
end

function Gilza.applyCustomAR_stats(id)

	log("[Gilza] Applying custom weapon stats to AR with id: "..tostring(id))
	
	-- adjust damage profiles and ammo pick up based on weapons damage (after dmg increase in the init function above)
	-- if AR has lower then 100 dmg(so, lower then ~57 in vanilla values), only apply changes to pick up, considering that the range of breakpoints down there is way to big, let whatever stats work
	
	local custom_ARs_with_GL = {
		"g3hk79",
		"mdr_308",
		"yayo",
		"m14e2",
		"soppo",
		"kurisumasu",
		"xeno"
	}
	local has_gl = has_value(custom_ARs_with_GL,id)
	local dmg_type = "nil"
	
	-- light AR's
	if tweak_data.weapon[id].stats.damage >= 100 and tweak_data.weapon[id].stats.damage <= 125 then
		tweak_data.weapon[id].stats.damage = 117
		tweak_data.weapon[id].AMMO_PICKUP = {3.64,6.15}
		dmg_type = "117"
	-- low mid AR's
	elseif tweak_data.weapon[id].stats.damage >= 126 and tweak_data.weapon[id].stats.damage <= 152 then
		tweak_data.weapon[id].stats.damage = 146
		tweak_data.weapon[id].AMMO_PICKUP = {3.111,4.35}
		dmg_type = "146"
	-- high mid AR's
	elseif tweak_data.weapon[id].stats.damage >= 153 and tweak_data.weapon[id].stats.damage <= 200 then
		tweak_data.weapon[id].stats.damage = 177
		tweak_data.weapon[id].AMMO_PICKUP = {2.8,3.73}
		dmg_type = "177"
	-- heavy AR's
	elseif tweak_data.weapon[id].stats.damage >= 201 and tweak_data.weapon[id].stats.damage <= 350 then
		tweak_data.weapon[id].stats.damage = 210
		tweak_data.weapon[id].AMMO_PICKUP = {2.12,3.12}
		dmg_type = "210"
	-- super heavy AR's
	elseif tweak_data.weapon[id].stats.damage >= 351 then
		tweak_data.weapon[id].stats.damage = 420
		tweak_data.weapon[id].AMMO_PICKUP = {0.6937,1.294}
		dmg_type = "420"
	end
	
	if dmg_type == "nil" then
		dmg_type = "super_light"
		tweak_data.weapon[id].AMMO_PICKUP[1] = tweak_data.weapon[id].AMMO_PICKUP[1] * 0.6
		tweak_data.weapon[id].AMMO_PICKUP[2] = tweak_data.weapon[id].AMMO_PICKUP[2] * 0.75
	end
	
	if has_gl then
		log("[Gilza] "..tostring(id).." has an underbarrel GL")
		tweak_data.weapon[id].AMMO_PICKUP[1] = tweak_data.weapon[id].AMMO_PICKUP[1] * 0.69
		tweak_data.weapon[id].AMMO_PICKUP[2] = tweak_data.weapon[id].AMMO_PICKUP[2] * 0.69
	end
	
	-- set new AR recoil, copied from wpntweaks.lua
	local recoil = tweak_data.weapon[id].stats.recoil * 4 - 4
	local tenth = math.floor(recoil / 10)
	local recoil_weight = 1 - (recoil/100)
	local UPrecoil = 0.4 + (recoil_weight * 1.2)
	local DOWNrecoil
	local LEFTrecoil
	local RIGHTrecoil
	if UPrecoil >= 1 then
		DOWNrecoil = UPrecoil * 0.75
	else
		DOWNrecoil = UPrecoil
	end
	if math.fmod(tenth,2) == 0 or tenth < 1 then
		LEFTrecoil = 0.5 + (recoil_weight * 0.75)
		RIGHTrecoil = LEFTrecoil * 0.66
	else
		RIGHTrecoil = 0.5 + (recoil_weight * 0.75)
		LEFTrecoil = RIGHTrecoil * 0.66
	end
	LEFTrecoil = LEFTrecoil * -1
	tweak_data.weapon[id].kick = {
		standing = {
			UPrecoil,
			DOWNrecoil,
			LEFTrecoil,
			RIGHTrecoil
		}
	}
	tweak_data.weapon[id].kick.steelsight = tweak_data.weapon[id].kick.standing
	tweak_data.weapon[id].kick.crouching = tweak_data.weapon[id].kick.standing
	
	-- stat adjustments based on class - higher dmg means lower total stats
	local wpn_ACC = tweak_data.weapon[id].stats.spread
	local wpn_STAB = tweak_data.weapon[id].stats.recoil
	local wpn_ROF =  60 / tweak_data.weapon[id].fire_mode_data.fire_rate
	local wpn_AMMO = tweak_data.weapon[id].AMMO_MAX
	local max_stat_points = 150
	
	-- allocation of max amount of stab+accuracy stats based on ammo/rof
	if dmg_type == "117" then
		if wpn_AMMO <= 90 then
			max_stat_points = max_stat_points + 10
		end
		if wpn_AMMO <= 120 then
			max_stat_points = max_stat_points + 10
		end
		if wpn_AMMO >= 180 then
			max_stat_points = max_stat_points - 10
		end
		if wpn_AMMO >= 210 then
			max_stat_points = max_stat_points - 10
		end
		if wpn_AMMO >= 240 then
			max_stat_points = max_stat_points - 10
		end
		-- rof
		if wpn_ROF <= 400 then
			max_stat_points = max_stat_points + 5
		end
		if wpn_ROF <= 500 then
			max_stat_points = max_stat_points + 5
		end
		if wpn_ROF >= 700 then
			max_stat_points = max_stat_points - 5
		end
		if wpn_ROF >= 800 then
			max_stat_points = max_stat_points - 5
		end
		if wpn_ROF >= 900 then
			max_stat_points = max_stat_points - 5
		end
		if wpn_ROF >= 1000 then
			max_stat_points = max_stat_points - 5
		end
	elseif dmg_type == "146" then
		if wpn_AMMO <= 120 then
			max_stat_points = max_stat_points + 10
		end
		if wpn_AMMO < 150 then
			max_stat_points = max_stat_points + 10
		end
		if wpn_AMMO >= 180 then
			max_stat_points = max_stat_points - 5
		end
		if wpn_AMMO >= 210 then
			max_stat_points = max_stat_points - 10
		end
		if wpn_AMMO >= 240 then
			max_stat_points = max_stat_points - 15
		end
		-- rof
		if wpn_ROF <= 500 then
			max_stat_points = max_stat_points + 10
		end
		if wpn_ROF <= 600 then
			max_stat_points = max_stat_points + 5
		end
		if wpn_ROF >= 800 then
			max_stat_points = max_stat_points - 5
		end
		if wpn_ROF >= 900 then
			max_stat_points = max_stat_points - 5
		end
		if wpn_ROF >= 1000 then
			max_stat_points = max_stat_points - 10
		end
	elseif dmg_type == "177" then
		if wpn_AMMO <= 90 then
			max_stat_points = max_stat_points + 10
		end
		if wpn_AMMO > 150 then
			max_stat_points = max_stat_points - 5
		end
		if wpn_AMMO >= 180 then
			max_stat_points = max_stat_points - 10
		end
		if wpn_AMMO >= 210 then
			max_stat_points = max_stat_points - 15
		end
		-- rof
		if wpn_ROF <= 500 then
			max_stat_points = max_stat_points + 5
		end
		if wpn_ROF >= 700 then
			max_stat_points = max_stat_points - 6
		end
		if wpn_ROF >= 800 then
			max_stat_points = max_stat_points - 8
		end
		if wpn_ROF >= 900 then
			max_stat_points = max_stat_points - 10
		end
		if wpn_ROF >= 1000 then
			max_stat_points = max_stat_points - 10
		end
	elseif dmg_type == "210" then
		if wpn_AMMO <= 90 then
			max_stat_points = max_stat_points + 5
		end
		if wpn_AMMO > 120 then
			max_stat_points = max_stat_points - 5
		end
		if wpn_AMMO >= 150 then
			max_stat_points = max_stat_points - 5
		end
		if wpn_AMMO >= 180 then
			max_stat_points = max_stat_points - 10
		end
		if wpn_AMMO >= 210 then
			max_stat_points = max_stat_points - 15
		end
		-- rof
		if wpn_ROF <= 500 then
			max_stat_points = max_stat_points + 12
		end
		if wpn_ROF >= 700 then
			max_stat_points = max_stat_points - 5
		end
		if wpn_ROF >= 800 then
			max_stat_points = max_stat_points - 10
		end
		if wpn_ROF >= 900 then
			max_stat_points = max_stat_points - 15
		end
		if wpn_ROF >= 1000 then
			max_stat_points = max_stat_points - 15
		end
	elseif dmg_type == "420" then
		if wpn_AMMO <= 75 then
			max_stat_points = max_stat_points + 5
		end
		if wpn_AMMO > 100 then
			max_stat_points = max_stat_points - 10
		end
		if wpn_AMMO >= 120 then
			max_stat_points = max_stat_points - 20
		end
		if wpn_AMMO >= 150 then
			max_stat_points = max_stat_points - 40
		end
		-- rof
		if wpn_ROF <= 500 then
			max_stat_points = max_stat_points + 10
		end
		if wpn_ROF <= 600 then
			max_stat_points = max_stat_points + 5
		end
		if wpn_ROF >= 700 then
			max_stat_points = max_stat_points - 5
		end
		if wpn_ROF >= 800 then
			max_stat_points = max_stat_points - 10
		end
		if wpn_ROF >= 900 then
			max_stat_points = max_stat_points - 15
		end
		if wpn_ROF >= 1000 then
			max_stat_points = max_stat_points - 20
		end
	elseif dmg_type == "super_light" then
		if wpn_AMMO <= 90 then
			max_stat_points = max_stat_points + 15
		end
		if wpn_AMMO <= 120 then
			max_stat_points = max_stat_points + 10
		end
		if wpn_AMMO > 180 then
			max_stat_points = max_stat_points - 5
		end
		if wpn_AMMO >= 210 then
			max_stat_points = max_stat_points - 5
		end
		if wpn_AMMO >= 240 then
			max_stat_points = max_stat_points - 10
		end
		-- rof
		-- who would ever make a gun with 40 damage and 420 rate of fire xD
		if wpn_ROF <= 450 then
			max_stat_points = max_stat_points + 15
		end
		if wpn_ROF <= 550 then
			max_stat_points = max_stat_points + 10
		end
		if wpn_ROF <= 650 then
			max_stat_points = max_stat_points + 5
		end
		if wpn_ROF >= 750 then
			max_stat_points = max_stat_points - 5
		end
		if wpn_ROF >= 850 then
			max_stat_points = max_stat_points - 5
		end
		if wpn_ROF >= 925 then
			max_stat_points = max_stat_points - 5
		end
		if wpn_ROF >= 1100 then
			max_stat_points = max_stat_points - 5
		end
	end
	
	-- convert max points from in-game values to coded weapon values
	if math.fmod(max_stat_points,2) == 1 then
		max_stat_points = max_stat_points + 1
	end
	max_stat_points = math.modf(max_stat_points / 4)

	local stat_difference = math.abs(wpn_ACC-wpn_STAB)
	local allowed_acc
	local allowed_stab
	local previous_stat = "acc"
	
	-- actuall stats
	-- in case allowed amount is lower then then the difference between stab/acc in the stats for the custom gun, we just use however much we can based on which stat is higher
	if wpn_ACC > wpn_STAB then
		if (max_stat_points - stat_difference) >= 0 then
			allowed_acc = stat_difference
			allowed_stab = 0
			max_stat_points = max_stat_points - stat_difference
		else
			allowed_acc = max_stat_points
			allowed_stab = 0
			max_stat_points = 0
		end
		previous_stat = "acc"
	elseif wpn_STAB > wpn_ACC then
		if (max_stat_points - stat_difference) >= 0 then
			allowed_acc = 0
			allowed_stab = stat_difference
			max_stat_points = max_stat_points - stat_difference
		else
			allowed_acc = 0
			allowed_stab = max_stat_points
			max_stat_points = 0
		end
		previous_stat = "stab"
	else
		allowed_acc = 0
		allowed_stab = 0
	end
	
	-- loop that adds +4 to stability, then accuracy etc. untill we run out of points
	while max_stat_points > 0 do
		
		-- this should be impossible to reach, but add this just in case
		if allowed_acc >= 25 and allowed_stab >= 25 then
			break
		end
	
		if previous_stat == "acc" then
			if allowed_stab <=24 then
				allowed_stab = allowed_stab + 1
			else
				allowed_acc = allowed_acc + 1
			end
			previous_stat = "stab"
		elseif previous_stat == "stab" then
			if allowed_acc <=24 then
				allowed_acc = allowed_acc + 1
			else
				allowed_stab = allowed_stab + 1
			end
			previous_stat = "acc"
		end
		
		max_stat_points = max_stat_points - 1
	end
	
	-- never go above accuracy that the custom gun itself was shipped with, stability is fine due to recoil rework
	if allowed_acc > wpn_ACC then
		allowed_acc = wpn_ACC
	end
	
	-- apply
	tweak_data.weapon[id].stats.spread = allowed_acc
	tweak_data.weapon[id].stats.recoil = allowed_stab
end

function Gilza.applyCustomSMG_stats(id)

	log("[Gilza] Applying custom weapon stats to SMG with id: "..tostring(id))
	
	-- same as with AR's
	local dmg_type = "nil"
	
	if tweak_data.weapon[id].stats.damage >= 77 and tweak_data.weapon[id].stats.damage <= 92 then
		tweak_data.weapon[id].stats.damage = 77
		tweak_data.weapon[id].AMMO_PICKUP = {4.26,7.1}
		dmg_type = "77"
	elseif tweak_data.weapon[id].stats.damage >= 93 and tweak_data.weapon[id].stats.damage <= 110 then
		tweak_data.weapon[id].stats.damage = 95
		tweak_data.weapon[id].AMMO_PICKUP = {3.98,6.83}
		dmg_type = "95"
	elseif tweak_data.weapon[id].stats.damage >= 111 and tweak_data.weapon[id].stats.damage <= 129 then
		tweak_data.weapon[id].stats.damage = 117
		tweak_data.weapon[id].AMMO_PICKUP = {2.79,4.72}
		dmg_type = "117"
	elseif tweak_data.weapon[id].stats.damage >= 130 and tweak_data.weapon[id].stats.damage <= 147 then
		tweak_data.weapon[id].stats.damage = 146
		tweak_data.weapon[id].AMMO_PICKUP = {2.39,3.34}
		dmg_type = "146"
	elseif tweak_data.weapon[id].stats.damage >= 148 and tweak_data.weapon[id].stats.damage <= 200 then
		tweak_data.weapon[id].stats.damage = 177
		tweak_data.weapon[id].AMMO_PICKUP = {2.15,2.99}
		dmg_type = "177"
	elseif tweak_data.weapon[id].stats.damage >= 201 then
		tweak_data.weapon[id].stats.damage = 210
		tweak_data.weapon[id].AMMO_PICKUP = {1.62,2.39}
		dmg_type = "210"
	end
	
	if dmg_type == "nil" then
		dmg_type = "super_light"
		tweak_data.weapon[id].AMMO_PICKUP[1] = tweak_data.weapon[id].AMMO_PICKUP[1] * 0.6
		tweak_data.weapon[id].AMMO_PICKUP[2] = tweak_data.weapon[id].AMMO_PICKUP[2] * 0.75
	end
	
	-- new SMG recoil
	local recoil = tweak_data.weapon[id].stats.recoil * 4 - 4
	local tenth = math.floor(recoil / 10)
	local recoil_weight = 1 - (recoil/100)
	local UPrecoil = 0.3 + (recoil_weight * 0.8)
	local DOWNrecoil
	local LEFTrecoil
	local RIGHTrecoil
	if UPrecoil >= 0.7 then
		DOWNrecoil = UPrecoil * 0.8
	else
		DOWNrecoil = UPrecoil
	end
	if math.fmod(tenth,2) == 0 or tenth < 1 then
		LEFTrecoil = 0.4 + (recoil_weight * 0.75)
		RIGHTrecoil = LEFTrecoil * 0.73
	else
		RIGHTrecoil = 0.4 + (recoil_weight * 0.75)
		LEFTrecoil = RIGHTrecoil * 0.73
	end
	LEFTrecoil = LEFTrecoil * -1
	tweak_data.weapon[id].kick = {
		standing = {
			UPrecoil,
			DOWNrecoil,
			LEFTrecoil,
			RIGHTrecoil
		}
	}
	tweak_data.weapon[id].kick.steelsight = tweak_data.weapon[id].kick.standing
	tweak_data.weapon[id].kick.crouching = tweak_data.weapon[id].kick.standing
	
	-- stat adjustments based on class - higher dmg means lower total stats
	local wpn_ACC = tweak_data.weapon[id].stats.spread
	local wpn_STAB = tweak_data.weapon[id].stats.recoil
	local wpn_ROF =  60 / tweak_data.weapon[id].fire_mode_data.fire_rate
	local wpn_AMMO = tweak_data.weapon[id].AMMO_MAX
	local max_stat_points = 175
	
	-- allocation of max amount of stab+accuracy stats based on ammo/rof
	if dmg_type == "77" then
		if wpn_AMMO <= 90 then
			max_stat_points = max_stat_points + 20
		end
		if wpn_AMMO <= 120 then
			max_stat_points = max_stat_points + 10
		end
		if wpn_AMMO < 150 then
			max_stat_points = max_stat_points + 10
		end
		if wpn_AMMO >= 180 then
			max_stat_points = max_stat_points - 5
		end
		if wpn_AMMO >= 210 then
			max_stat_points = max_stat_points - 10
		end
		if wpn_AMMO >= 240 then
			max_stat_points = max_stat_points - 15
		end
		-- rof
		if wpn_ROF <= 400 then
			max_stat_points = max_stat_points + 15
		end
		if wpn_ROF <= 500 then
			max_stat_points = max_stat_points + 10
		end
		if wpn_ROF <= 700 then
			max_stat_points = max_stat_points + 5
		end
		if wpn_ROF >= 900 then
			max_stat_points = max_stat_points - 5
		end
		if wpn_ROF >= 1000 then
			max_stat_points = max_stat_points - 10
		end
		if wpn_ROF >= 1200 then
			max_stat_points = max_stat_points - 20
		end
	elseif dmg_type == "95" then
		if wpn_AMMO <= 90 then
			max_stat_points = max_stat_points + 15
		end
		if wpn_AMMO <= 120 then
			max_stat_points = max_stat_points + 10
		end
		if wpn_AMMO <= 150 then
			max_stat_points = max_stat_points + 5
		end
		if wpn_AMMO >= 180 then
			max_stat_points = max_stat_points - 5
		end
		if wpn_AMMO >= 210 then
			max_stat_points = max_stat_points - 15
		end
		if wpn_AMMO >= 240 then
			max_stat_points = max_stat_points - 25
		end
		-- rof
		if wpn_ROF <= 500 then
			max_stat_points = max_stat_points + 15
		end
		if wpn_ROF <= 600 then
			max_stat_points = max_stat_points + 10
		end
		if wpn_ROF >= 800 then
			max_stat_points = max_stat_points - 5
		end
		if wpn_ROF >= 900 then
			max_stat_points = max_stat_points - 10
		end
		if wpn_ROF >= 1000 then
			max_stat_points = max_stat_points - 15
		end
		if wpn_ROF >= 1200 then
			max_stat_points = max_stat_points - 25
		end
	elseif dmg_type == "117" then
		if wpn_AMMO <= 90 then
			max_stat_points = max_stat_points + 10
		end
		if wpn_AMMO <= 120 then
			max_stat_points = max_stat_points + 5
		end
		if wpn_AMMO > 150 then
			max_stat_points = max_stat_points - 5
		end
		if wpn_AMMO >= 180 then
			max_stat_points = max_stat_points - 10
		end
		if wpn_AMMO >= 210 then
			max_stat_points = max_stat_points - 25
		end
		if wpn_AMMO >= 240 then
			max_stat_points = max_stat_points - 35
		end
		-- rof
		if wpn_ROF <= 500 then
			max_stat_points = max_stat_points + 5
		end
		if wpn_ROF >= 800 then
			max_stat_points = max_stat_points - 10
		end
		if wpn_ROF >= 900 then
			max_stat_points = max_stat_points - 10
		end
		if wpn_ROF >= 1000 then
			max_stat_points = max_stat_points - 10
		end
		if wpn_ROF >= 1100 then
			max_stat_points = max_stat_points - 15
		end
		if wpn_ROF >= 1200 then
			max_stat_points = max_stat_points - 25
		end
	elseif dmg_type == "146" then
		if wpn_AMMO < 120 then
			max_stat_points = max_stat_points + 10
		end
		if wpn_AMMO >= 180 then
			max_stat_points = max_stat_points - 15
		end
		if wpn_AMMO >= 210 then
			max_stat_points = max_stat_points - 20
		end
		if wpn_AMMO >= 240 then
			max_stat_points = max_stat_points - 35
		end
		-- rof
		if wpn_ROF <= 500 then
			max_stat_points = max_stat_points + 15
		end
		if wpn_ROF >= 700 then
			max_stat_points = max_stat_points - 5
		end
		if wpn_ROF >= 800 then
			max_stat_points = max_stat_points - 10
		end
		if wpn_ROF >= 900 then
			max_stat_points = max_stat_points - 15
		end
		if wpn_ROF >= 1000 then
			max_stat_points = max_stat_points - 25
		end
		if wpn_ROF >= 1200 then
			max_stat_points = max_stat_points - 25
		end
	elseif dmg_type == "177" then
		if wpn_AMMO < 120 then
			max_stat_points = max_stat_points + 5
		end
		if wpn_AMMO >= 180 then
			max_stat_points = max_stat_points - 15
		end
		if wpn_AMMO >= 210 then
			max_stat_points = max_stat_points - 20
		end
		if wpn_AMMO >= 240 then
			max_stat_points = max_stat_points - 35
		end
		-- rof
		if wpn_ROF <= 500 then
			max_stat_points = max_stat_points + 10
		end
		if wpn_ROF >= 700 then
			max_stat_points = max_stat_points - 10
		end
		if wpn_ROF >= 800 then
			max_stat_points = max_stat_points - 10
		end
		if wpn_ROF >= 900 then
			max_stat_points = max_stat_points - 15
		end
		if wpn_ROF >= 1000 then
			max_stat_points = max_stat_points - 25
		end
		if wpn_ROF >= 1200 then
			max_stat_points = max_stat_points - 30
		end
	elseif dmg_type == "210" then
		if wpn_AMMO > 120 then
			max_stat_points = max_stat_points - 10
		end
		if wpn_AMMO >= 150 then
			max_stat_points = max_stat_points - 20
		end
		if wpn_AMMO >= 180 then
			max_stat_points = max_stat_points - 25
		end
		if wpn_AMMO >= 210 then
			max_stat_points = max_stat_points - 35
		end
		-- rof
		if wpn_ROF <= 500 then
			max_stat_points = max_stat_points + 10
		end
		if wpn_ROF <= 600 then
			max_stat_points = max_stat_points + 5
		end
		if wpn_ROF >= 700 then
			max_stat_points = max_stat_points - 5
		end
		if wpn_ROF >= 800 then
			max_stat_points = max_stat_points - 10
		end
		if wpn_ROF >= 900 then
			max_stat_points = max_stat_points - 15
		end
		if wpn_ROF >= 1000 then
			max_stat_points = max_stat_points - 25
		end
		if wpn_ROF >= 1200 then
			max_stat_points = max_stat_points - 35
		end
	elseif dmg_type == "super_light" then
		if wpn_AMMO <= 90 then
			max_stat_points = max_stat_points + 15
		end
		if wpn_AMMO <= 120 then
			max_stat_points = max_stat_points + 10
		end
		if wpn_AMMO > 180 then
			max_stat_points = max_stat_points - 5
		end
		if wpn_AMMO >= 210 then
			max_stat_points = max_stat_points - 10
		end
		if wpn_AMMO >= 240 then
			max_stat_points = max_stat_points - 15
		end
		-- rof
		if wpn_ROF <= 450 then
			max_stat_points = max_stat_points + 15
		end
		if wpn_ROF <= 550 then
			max_stat_points = max_stat_points + 10
		end
		if wpn_ROF <= 650 then
			max_stat_points = max_stat_points + 5
		end
		if wpn_ROF >= 750 then
			max_stat_points = max_stat_points - 5
		end
		if wpn_ROF >= 850 then
			max_stat_points = max_stat_points - 10
		end
		if wpn_ROF >= 925 then
			max_stat_points = max_stat_points - 15
		end
		if wpn_ROF >= 1100 then
			max_stat_points = max_stat_points - 20
		end
	end
	
	if math.fmod(max_stat_points,2) == 1 then
		max_stat_points = max_stat_points + 1
	end
	max_stat_points = math.modf(max_stat_points / 4)

	local stat_difference = math.abs(wpn_ACC-wpn_STAB)
	local allowed_acc
	local allowed_stab
	local previous_stat = "acc"
	
	if wpn_ACC > wpn_STAB then
		if (max_stat_points - stat_difference) >= 0 then
			allowed_acc = stat_difference
			allowed_stab = 0
			max_stat_points = max_stat_points - stat_difference
		else
			allowed_acc = max_stat_points
			allowed_stab = 0
			max_stat_points = 0
		end
		previous_stat = "acc"
	elseif wpn_STAB > wpn_ACC then
		if (max_stat_points - stat_difference) >= 0 then
			allowed_acc = 0
			allowed_stab = stat_difference
			max_stat_points = max_stat_points - stat_difference
		else
			allowed_acc = 0
			allowed_stab = max_stat_points
			max_stat_points = 0
		end
		previous_stat = "stab"
	else
		allowed_acc = 0
		allowed_stab = 0
	end
	
	while max_stat_points > 0 do
	
		if allowed_acc >= 25 and allowed_stab >= 25 then
			break
		end
	
		if previous_stat == "acc" then
			if allowed_stab <=24 then
				allowed_stab = allowed_stab + 1
			else
				allowed_acc = allowed_acc + 1
			end
			previous_stat = "stab"
		elseif previous_stat == "stab" then
			if allowed_acc <=24 then
				allowed_acc = allowed_acc + 1
			else
				allowed_stab = allowed_stab + 1
			end
			previous_stat = "acc"
		end
		
		max_stat_points = max_stat_points - 1
	end
	
	if allowed_acc > wpn_ACC then
		allowed_acc = wpn_ACC
	end
	
	-- apply
	tweak_data.weapon[id].stats.spread = allowed_acc
	tweak_data.weapon[id].stats.recoil = allowed_stab
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
	
	local ROF = "decrease"
	if (tweak_data.weapon[id].FIRE_MODE and tweak_data.weapon[id].FIRE_MODE == "auto") or tweak_data.weapon[id].CAN_TOGGLE_FIREMODE then
		ROF = "increase"
	end
	
	if ROF == "decrease" then
		if tweak_data.weapon[id].fire_mode_data then
			tweak_data.weapon[id].fire_mode_data.fire_rate = tweak_data.weapon[id].fire_mode_data.fire_rate * 1.5
		end
		if tweak_data.weapon[id].single then
			tweak_data.weapon[id].single.fire_rate = tweak_data.weapon[id].single.fire_rate * 1.5
		end
		if tweak_data.weapon[id].auto then
			tweak_data.weapon[id].auto.fire_rate = tweak_data.weapon[id].auto.fire_rate * 1.5
		end
	else
		if tweak_data.weapon[id].fire_mode_data then
			tweak_data.weapon[id].fire_mode_data.fire_rate = tweak_data.weapon[id].fire_mode_data.fire_rate * 0.8
		end
		if tweak_data.weapon[id].single then
			tweak_data.weapon[id].single.fire_rate = tweak_data.weapon[id].single.fire_rate * 0.8
		end
		if tweak_data.weapon[id].auto then
			tweak_data.weapon[id].auto.fire_rate = tweak_data.weapon[id].auto.fire_rate * 0.8
		end
	end
	
end

function Gilza.applyCustomLMG_stats(id)

	log("[Gilza] Applying custom weapon stats to LMG with id: "..tostring(id))
	
	local dmg_type = "nil"
	
	if tweak_data.weapon[id].stats.damage >= 114 and tweak_data.weapon[id].stats.damage < 130 then
		tweak_data.weapon[id].stats.damage = 117
		tweak_data.weapon[id].AMMO_PICKUP = {6.19,10.2}
		dmg_type = "117"
	-- avg
	elseif tweak_data.weapon[id].stats.damage >= 130 and tweak_data.weapon[id].stats.damage < 180 then
		tweak_data.weapon[id].stats.damage = 140
		tweak_data.weapon[id].AMMO_PICKUP = {4.97,8.2}
		dmg_type = "140"
	-- heavy
	elseif tweak_data.weapon[id].stats.damage >= 180 then
		tweak_data.weapon[id].stats.damage = 210
		tweak_data.weapon[id].AMMO_PICKUP = {3.18,5.92}
		dmg_type = "210"
	end
	
	if dmg_type == "nil" then
		dmg_type = "super_light"
		tweak_data.weapon[id].AMMO_PICKUP[1] = tweak_data.weapon[id].AMMO_PICKUP[1] * 0.55
		tweak_data.weapon[id].AMMO_PICKUP[2] = tweak_data.weapon[id].AMMO_PICKUP[2] * 0.55
	end

	local recoil = tweak_data.weapon[id].stats.recoil * 4 - 4
	local tenth = math.floor(recoil / 10)
	local recoil_weight = 1 - (recoil/100)
	local UPrecoil = 1.25 + (recoil_weight * 0.5)
	local DOWNrecoil
	local LEFTrecoil
	local RIGHTrecoil
	if UPrecoil >= 1.5 then
		DOWNrecoil = UPrecoil * 0.75
	else
		DOWNrecoil = UPrecoil
	end
	if math.fmod(tenth,2) == 0 or tenth < 1 then
		LEFTrecoil = 0.6 + (recoil_weight * 0.5)
		RIGHTrecoil = LEFTrecoil * 0.45
	else
		RIGHTrecoil = 0.6 + (recoil_weight * 0.5)
		LEFTrecoil = RIGHTrecoil * 0.45
	end
	LEFTrecoil = LEFTrecoil * -1
	tweak_data.weapon[id].kick = {
		standing = {
			UPrecoil,
			DOWNrecoil,
			LEFTrecoil,
			RIGHTrecoil
		}
	}
	tweak_data.weapon[id].kick.steelsight = tweak_data.weapon[id].kick.standing
	tweak_data.weapon[id].kick.crouching = tweak_data.weapon[id].kick.standing
	
	-- lmg recoil is so bad that i wont even nerf custom ones in any way, just give em a few extra stability points if needed
	if tweak_data.weapon[id].stats.recoil <= 13 then
		tweak_data.weapon[id].stats.recoil = tweak_data.weapon[id].stats.recoil + 3
	end
end

function Gilza.applyCustomSNIPER_stats(id)

	log("[Gilza] Applying custom weapon stats to SNIPER with id: "..tostring(id))
	
	if tweak_data.weapon[id].stats_modifiers then
		if tweak_data.weapon[id].stats_modifiers.damage then
			tweak_data.weapon[id].stats.damage = tweak_data.weapon[id].stats.damage * tweak_data.weapon[id].stats_modifiers.damage
			tweak_data.weapon[id].stats_modifiers.damage = 1
		end
	end
	
	local rof = 0
	local force_semi_auto = false
	if tweak_data.weapon[id].single then
		rof = tweak_data.weapon[id].single.fire_rate
	end
	if tweak_data.weapon[id].fire_mode_data then
		rof = tweak_data.weapon[id].fire_mode_data.fire_rate
	end
	rof = 60 / rof
	if rof > 120 then
		force_semi_auto = true
	end
	
	local force_lever_action = false
	if tweak_data.weapon[id].use_shotgun_reload == true then
		force_lever_action = true
	end
	
	if tweak_data.weapon[id].stats.damage <= 240 then
		tweak_data.weapon[id].fire_mode_data = {fire_rate = 60/260}
		tweak_data.weapon[id].single = {fire_rate = 60/260}
		tweak_data.weapon[id].stats.damage = 560
		tweak_data.weapon[id].AMMO_PICKUP = {0.444,0.814}
	elseif tweak_data.weapon[id].stats.damage >= 241 and tweak_data.weapon[id].stats.damage <= 450 then
		tweak_data.weapon[id].stats.damage = 630
		tweak_data.weapon[id].AMMO_PICKUP = {0.444,0.814}
	elseif tweak_data.weapon[id].stats.damage >= 451 and tweak_data.weapon[id].stats.damage <= 1250 then
		tweak_data.weapon[id].stats.damage = 1260
		tweak_data.weapon[id].AMMO_PICKUP = {0.444,0.814}
	elseif tweak_data.weapon[id].stats.damage > 1250 then
		tweak_data.weapon[id].stats.damage = 8050
		tweak_data.weapon[id].AMMO_PICKUP = {0.03,0.68}
	elseif force_semi_auto then
		tweak_data.weapon[id].fire_mode_data = {fire_rate = 60/260}
		tweak_data.weapon[id].single = {fire_rate = 60/260}
		tweak_data.weapon[id].stats.damage = 560
		tweak_data.weapon[id].AMMO_PICKUP = {0.444,0.814}
	elseif force_lever_action then
		tweak_data.weapon[id].stats.damage = 630
		tweak_data.weapon[id].AMMO_PICKUP = {0.444,0.814}
	end
	
end

function Gilza.applyCustomSHOTGUN_stats(id)

	log("[Gilza] Applying custom weapon stats to SHOTGUN with id: "..tostring(id))
	
	if tweak_data.weapon[id].stats_modifiers then
		if tweak_data.weapon[id].stats_modifiers.damage then
			tweak_data.weapon[id].stats.damage = tweak_data.weapon[id].stats.damage * tweak_data.weapon[id].stats_modifiers.damage
			tweak_data.weapon[id].stats_modifiers.damage = 1
		end
	end
	
	local secondary = false
	if tweak_data.weapon[id].use_data and tweak_data.weapon[id].use_data.selection_index then
		if tweak_data.weapon[id].use_data.selection_index == 1 then
			secondary = true
		end
	end
	
	local category = 0
	
	if tweak_data.weapon[id].stats.damage <= 45 then
		category = 1 -- semi auto
	elseif tweak_data.weapon[id].stats.damage >= 46 and tweak_data.weapon[id].stats.damage <= 80 then
		category = 2 -- semi auto no mag
	elseif tweak_data.weapon[id].stats.damage >= 81 and tweak_data.weapon[id].stats.damage <= 150 then
		category = 3 -- pump
	elseif tweak_data.weapon[id].stats.damage > 150 and tweak_data.weapon[id].stats.damage <= 250 then
		category = 4 -- DB
	elseif tweak_data.weapon[id].stats.damage > 250 then
		category = 5 -- db that can oneshot tazers or some stupid omega buffed shotgun idk
	end
	
	local rof
	-- in case pump action shotguns have too high of a ROF we change it semi auto class
	if category == 3 then
		if tweak_data.weapon[id].single then
			rof = tweak_data.weapon[id].single.fire_rate
		end
		if tweak_data.weapon[id].fire_mode_data then
			rof = tweak_data.weapon[id].fire_mode_data.fire_rate
		end
		if (60/rof) >= 120 then
			category = 2
		end
	end
	
	if category == 1 then
		tweak_data.weapon[id].stats.damage = 110
		if secondary == false then
			tweak_data.weapon[id].AMMO_PICKUP = {2.8,4.2}
		else
			tweak_data.weapon[id].AMMO_PICKUP = {2.16,3.2}
		end
	elseif category == 2 then
		tweak_data.weapon[id].stats.damage = 305
		if secondary == false then
			tweak_data.weapon[id].AMMO_PICKUP = {1.12,1.67}
		else
			tweak_data.weapon[id].AMMO_PICKUP = {0.79,1.19}
		end
	elseif category == 3 then
		tweak_data.weapon[id].stats.damage = 420
		
		if secondary == false then
			tweak_data.weapon[id].AMMO_PICKUP = {0.57,0.97}
		else
			tweak_data.weapon[id].AMMO_PICKUP = {0.44,0.72}
		end
	elseif category == 4 then
		tweak_data.weapon[id].stats.damage = 1250
		
		if secondary == false then
			tweak_data.weapon[id].AMMO_PICKUP = {0.32,0.89}
		else
			tweak_data.weapon[id].AMMO_PICKUP = {0.23,0.73}
		end
	elseif category == 5 then
		tweak_data.weapon[id].stats.damage = 1600
		
		if secondary == false then
			tweak_data.weapon[id].AMMO_PICKUP = {0.27,0.8}
		else
			tweak_data.weapon[id].AMMO_PICKUP = {0.18,0.64}
		end
	end
	
	-- shothun ammo. dear god.
	local HE_custom_stats = {
		ignore_statistic = true,
		damage_far_mul = 1,
		damage_near_mul = 1,
		bullet_class = "InstantExplosiveBulletBase",
		rays = 1,
		ammo_pickup_max_mul = 0.4,
		ammo_pickup_min_mul = 0.4
	}
	local FAHEstats = {
		value = 5,
		total_ammo_mod = -10,
		damage = 130,
		recoil = -25
	}
	local SAHEstats = {
		value = 5,
		total_ammo_mod = -10,
		damage = 395,
		recoil = -25
	}
	local PAHEstats = {
		value = 5,
		total_ammo_mod = -10,
		damage = 450,
		recoil = -25
	}
	local DBHEstats = {
		value = 5,
		total_ammo_mod = -10,
		damage = 1350,
		recoil = -25
	}
	local ultraHEstats = {
		value = 5,
		total_ammo_mod = -10,
		damage = 69,
		recoil = -25
	}
	
	local BS_custom_stats = {
		damage_far_mul = 1,
		damage_near_mul = 1,
		ammo_pickup_max_mul = 0.8,
		ammo_pickup_min_mul = 0.8
	}
	local FABS_stats = {
		damage = 40
	}
	local SABS_stats = {
		damage = 90
	}
	local PABS_stats = {
		damage = 140
	}
	local DBBS_stats = {
		damage = 350
	}
	local ultraBS_stats = {
		damage = 69
	}

	local wpn_factory_id = managers.weapon_factory:get_factory_id_by_weapon_id(id)
	if category == 1 then
		tweak_data.weapon.factory[wpn_factory_id].override = {
			wpn_fps_upg_a_explosive = {stats = FAHEstats,custom_stats = HE_custom_stats},
			wpn_fps_upg_a_custom = {stats = FABS_stats,custom_stats = BS_custom_stats},
			wpn_fps_upg_a_custom_free = {stats = FABS_stats,custom_stats = BS_custom_stats}
		}
	elseif category == 2 then
		tweak_data.weapon.factory[wpn_factory_id].override = {
			wpn_fps_upg_a_explosive = {stats = SAHEstats,custom_stats = HE_custom_stats},
			wpn_fps_upg_a_custom = {stats = SABS_stats,custom_stats = BS_custom_stats},
			wpn_fps_upg_a_custom_free = {stats = SABS_stats,custom_stats = BS_custom_stats}
		}
	elseif category == 3 then
		tweak_data.weapon.factory[wpn_factory_id].override = {
			wpn_fps_upg_a_explosive = {stats = PAHEstats,custom_stats = HE_custom_stats},
			wpn_fps_upg_a_custom = {stats = PABS_stats,custom_stats = BS_custom_stats},
			wpn_fps_upg_a_custom_free = {stats = PABS_stats,custom_stats = BS_custom_stats}
		}
	elseif category == 4 then
		tweak_data.weapon.factory[wpn_factory_id].override = {
			wpn_fps_upg_a_explosive = {stats = DBHEstats,custom_stats = HE_custom_stats},
			wpn_fps_upg_a_custom = {stats = DBBS_stats,custom_stats = BS_custom_stats},
			wpn_fps_upg_a_custom_free = {stats = DBBS_stats,custom_stats = BS_custom_stats}
		}
	elseif category == 5 then
		tweak_data.weapon.factory[wpn_factory_id].override = {
			wpn_fps_upg_a_explosive = {stats = ultraHE_stats,custom_stats = HE_custom_stats},
			wpn_fps_upg_a_custom = {stats = ultraBS_stats,custom_stats = BS_custom_stats},
			wpn_fps_upg_a_custom_free = {stats = ultraBS_stats,custom_stats = BS_custom_stats}
		}
	end
end

function Gilza.applyCustomMELEE_stats()
	--log("[Gilza] Applying custom weapon stats to SHOTGUN with id: "..tostring(id))
	for melee, stats in pairs(tweak_data.blackmarket.melee_weapons) do
		if has_value (Gilza.default_melee_weapons, melee) then
			-- default weapon, dont do anything
		else
			log("[Gilza] Applying custom weapon stats to MELEE with id: "..tostring(melee))
			if stats.repeat_expire_t <= 0.5 then
				tweak_data.blackmarket.melee_weapons[melee].stats.min_damage = 2
				tweak_data.blackmarket.melee_weapons[melee].stats.max_damage = 3.5
				tweak_data.blackmarket.melee_weapons[melee].stats.min_damage_effect = 1
				tweak_data.blackmarket.melee_weapons[melee].stats.max_damage_effect = 1
			elseif stats.repeat_expire_t <= 0.65 then
				tweak_data.blackmarket.melee_weapons[melee].stats.min_damage = 2.5
				tweak_data.blackmarket.melee_weapons[melee].stats.max_damage = 5
				tweak_data.blackmarket.melee_weapons[melee].stats.min_damage_effect = 2
				tweak_data.blackmarket.melee_weapons[melee].stats.max_damage_effect = 2
			elseif stats.repeat_expire_t <= 0.8 then
				tweak_data.blackmarket.melee_weapons[melee].stats.min_damage = 2.5
				tweak_data.blackmarket.melee_weapons[melee].stats.max_damage = 5
				tweak_data.blackmarket.melee_weapons[melee].stats.min_damage_effect = 30
				tweak_data.blackmarket.melee_weapons[melee].stats.max_damage_effect = 25
				tweak_data.blackmarket.melee_weapons[melee].melee_damage_delay = 0.15
			elseif stats.repeat_expire_t <= 1 then
				tweak_data.blackmarket.melee_weapons[melee].stats.min_damage = 3.5
				tweak_data.blackmarket.melee_weapons[melee].stats.max_damage = 7.5
				tweak_data.blackmarket.melee_weapons[melee].stats.min_damage_effect = 2
				tweak_data.blackmarket.melee_weapons[melee].stats.max_damage_effect = 2
			elseif stats.repeat_expire_t <= 1.1 then
				tweak_data.blackmarket.melee_weapons[melee].stats.min_damage = 3.5
				tweak_data.blackmarket.melee_weapons[melee].stats.max_damage = 7.5
				tweak_data.blackmarket.melee_weapons[melee].stats.min_damage_effect = 1000/35
				tweak_data.blackmarket.melee_weapons[melee].stats.max_damage_effect = 1750/75
			elseif stats.repeat_expire_t > 1.1 then
				if stats.melee_damage_delay <= 0.4 then
					tweak_data.blackmarket.melee_weapons[melee].stats.min_damage = 3.5
					tweak_data.blackmarket.melee_weapons[melee].stats.max_damage = 7.5
					tweak_data.blackmarket.melee_weapons[melee].stats.min_damage_effect = 1000/35
					tweak_data.blackmarket.melee_weapons[melee].stats.max_damage_effect = 1750/75
				elseif stats.melee_damage_delay <= 0.6 then
					tweak_data.blackmarket.melee_weapons[melee].stats.min_damage = 5
					tweak_data.blackmarket.melee_weapons[melee].stats.max_damage = 10
					tweak_data.blackmarket.melee_weapons[melee].stats.min_damage_effect = 2
					tweak_data.blackmarket.melee_weapons[melee].stats.max_damage_effect = 1.5
				elseif stats.melee_damage_delay > 0.6 then
					tweak_data.blackmarket.melee_weapons[melee].stats.min_damage = 5
					tweak_data.blackmarket.melee_weapons[melee].stats.max_damage = 10
					tweak_data.blackmarket.melee_weapons[melee].stats.min_damage_effect = 26
					tweak_data.blackmarket.melee_weapons[melee].stats.max_damage_effect = 22.5
				end
			end
		end
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