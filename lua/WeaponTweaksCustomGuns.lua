local exceptions = {
	"npc_melee",
	"ceiling_turret_module_longer_range",
	"sentry_gun",
	"ceiling_turret_module_no_idle",
	"crate_turret_module",
	"ceiling_turret_module",
	"swat_van_turret_module",
	"ranc_heavy_machine_gun",
	"crosshair",
	"aa_turret_module",
	"factory",
	"stats",
	"trip_mines"
}

local customWeaponsList = {}
function Gilza.initCutsomGuns()
	if Gilza.defaultWeapons then
		for gun, stats in pairs(tweak_data.weapon) do
			if not (string.sub(gun,-5,-1) == "_crew" or string.sub(gun,-4,-1) == "_npc") and not (table.contains(Gilza.defaultWeapons,gun)) and not (table.contains(exceptions,gun)) then
				table.insert(customWeaponsList,gun)
			end
		end
		Gilza.tryAddingNewGuns()
	else
		log("[Gilza] Could not load default weapon list, custom weapon stats can not be applied.")
	end
end

local secondary_mul = 0.7
local secondary_to_primary_mul = 1/secondary_mul

local customWeaponsUpdated = {Assault_Rifles={}, Sub_Machine_guns={}, Pistols={}, Light_Machine_guns={}, Snipers={}, Shotguns={}, Melee={}}
function Gilza.tryAddingNewGuns()
	if #customWeaponsList >= 1 then
		log("[Gilza] Applying custom weapon tweaks...")
		for j=1, #customWeaponsList do
			if tweak_data.weapon[customWeaponsList[j]] and tweak_data.weapon[customWeaponsList[j]].categories then
				for i=1, #tweak_data.weapon[customWeaponsList[j]].categories do
					if tweak_data.weapon[customWeaponsList[j]].categories[i] == "assault_rifle" then
						tweak_data.weapon[customWeaponsList[j]].stats.damage = math.floor(tweak_data.weapon[customWeaponsList[j]].stats.damage * 2)
						Gilza.applyCustomAR_stats(customWeaponsList[j])
					elseif tweak_data.weapon[customWeaponsList[j]].categories[i] == "smg" then
						tweak_data.weapon[customWeaponsList[j]].stats.damage = math.floor(tweak_data.weapon[customWeaponsList[j]].stats.damage * 2)
						Gilza.applyCustomSMG_stats(customWeaponsList[j])
					elseif tweak_data.weapon[customWeaponsList[j]].categories[i] == "pistol" then
						local isRevolver = false
						for k=1, #tweak_data.weapon[customWeaponsList[j]].categories do
							if tweak_data.weapon[customWeaponsList[j]].categories[i] == "revolver" then
								isRevolver = true
							end							
						end
						tweak_data.weapon[customWeaponsList[j]].stats.damage = math.floor(tweak_data.weapon[customWeaponsList[j]].stats.damage * 2)
						Gilza.applyCustomPISTOL_stats(customWeaponsList[j],isRevolver)
					elseif tweak_data.weapon[customWeaponsList[j]].categories[i] == "lmg" then
						tweak_data.weapon[customWeaponsList[j]].stats.damage = math.floor(tweak_data.weapon[customWeaponsList[j]].stats.damage * 2)
						Gilza.applyCustomLMG_stats(customWeaponsList[j])
					elseif tweak_data.weapon[customWeaponsList[j]].categories[i] == "snp" then
						Gilza.applyCustomSNIPER_stats(customWeaponsList[j])
					elseif tweak_data.weapon[customWeaponsList[j]].categories[i] == "shotgun" then
						tweak_data.weapon[customWeaponsList[j]].stats.damage = math.floor(tweak_data.weapon[customWeaponsList[j]].stats.damage * 2)
						Gilza.applyCustomSHOTGUN_stats(customWeaponsList[j])
					end
				end
			end
		end
	end
	Gilza.applyCustomMELEE_stats()
	local hasCustomWeapons = false
	for category, tbl in pairs(customWeaponsUpdated) do
		local str = ""
		for _, id in pairs(customWeaponsUpdated[tostring(category)]) do
			str = str..tostring(id)..", "
		end
		str = str:sub(1, -3)
		if str ~= "" then
			log("[Gilza] Updated stats for "..tostring(category).." ("..str..")")
			hasCustomWeapons = true
		end
	end
	Gilza.applyCustomGunsIndividualStats()
	if hasCustomWeapons then
		log("[Gilza] Custom weapon stats applied.")
	end
end

function Gilza.applyCustomAR_stats(id)

	table.insert(customWeaponsUpdated.Assault_Rifles, id)
	
	-- adjust damage profiles and ammo pick up based on weapons damage (after dmg increase in the init function above)
	-- if AR has lower then 115 dmg(so, lower then ~57 in vanilla values), only apply changes to pick up, considering that the range of breakpoints down there is way to big, let whatever stats work
	
	local avg_120_pickup = 7.08
	local avg_155_pickup = 4.76
	local avg_250_pickup = 2.63
	local avg_450_pickup = 1.62
	
	local custom_ARs_with_GL = {
		"g3hk79",
		"mdr_308",
		"yayo",
		"m14e2",
		"soppo",
		"kurisumasu",
		"xeno"
	}
	local has_gl = table.contains(custom_ARs_with_GL,id)
	local dmg_type = "nil"
	
	-- light AR's
	if tweak_data.weapon[id].stats.damage >= 115 and tweak_data.weapon[id].stats.damage <= 143 then
		tweak_data.weapon[id].stats.damage = 120
		tweak_data.weapon[id].AMMO_PICKUP = {(avg_120_pickup * 0.9) / 1.35,(avg_120_pickup * 1.1) / 1.35}
		dmg_type = "105"
	-- low mid AR's
	elseif tweak_data.weapon[id].stats.damage >= 144 and tweak_data.weapon[id].stats.damage <= 174 then
		tweak_data.weapon[id].stats.damage = 155
		tweak_data.weapon[id].AMMO_PICKUP = {(avg_155_pickup * 0.9) / 1.35,(avg_155_pickup * 1.1) / 1.35}
		dmg_type = "146"
	-- high mid AR's
	elseif tweak_data.weapon[id].stats.damage >= 175 and tweak_data.weapon[id].stats.damage <= 229 then
		tweak_data.weapon[id].stats.damage = 200
		tweak_data.weapon[id].AMMO_PICKUP = {((avg_155_pickup * 0.9) / 1.35) * 0.85,((avg_155_pickup * 1.1) / 1.35) * 0.85}
		dmg_type = "175"
	-- heavy AR's
	elseif tweak_data.weapon[id].stats.damage >= 230 and tweak_data.weapon[id].stats.damage <= 400 then
		tweak_data.weapon[id].stats.damage = 250
		tweak_data.weapon[id].AMMO_PICKUP = {(avg_250_pickup * 0.9) / 1.35,(avg_250_pickup * 1.1) / 1.35}
		dmg_type = "210"
	-- super heavy AR's
	elseif tweak_data.weapon[id].stats.damage >= 401 then
		tweak_data.weapon[id].stats.damage = 450
		tweak_data.weapon[id].AMMO_PICKUP = {(avg_450_pickup * 0.9) / 1.35,(avg_450_pickup * 1.1) / 1.35}
		dmg_type = "420"
	end
	
	if dmg_type == "nil" then
		dmg_type = "super_light"
		local dmg = tweak_data.weapon[id].stats.damage
		local weapon_avg_pickup = (((math.ceil(250/dmg) + math.ceil(450/dmg))/0.32)/2)*0.65
		tweak_data.weapon[id].AMMO_PICKUP = {(weapon_avg_pickup * 0.9) / 1.35,(weapon_avg_pickup * 1.1) / 1.35}
	end
	
	if has_gl then
		tweak_data.weapon[id].AMMO_PICKUP[1] = tweak_data.weapon[id].AMMO_PICKUP[1] * 0.7
		tweak_data.weapon[id].AMMO_PICKUP[2] = tweak_data.weapon[id].AMMO_PICKUP[2] * 0.7
	end
	
	local function updateHandlingStats()
	
		-- stat adjustments based on class - higher dmg means lower total stats
		local wpn_ACC = tweak_data.weapon[id].stats.spread
		local wpn_STAB = tweak_data.weapon[id].stats.recoil
		local wpn_ROF =  60 / tweak_data.weapon[id].fire_mode_data.fire_rate
		local wpn_AMMO = tweak_data.weapon[id].AMMO_MAX
		local max_stat_points = 150
		
		-- allocation of max amount of stab+accuracy stats based on ammo/rof
		if dmg_type == "105" then
			if wpn_AMMO <= 120 then
				max_stat_points = max_stat_points + 20
			end
			if wpn_AMMO <= 150 then
				max_stat_points = max_stat_points + 10
			end
			if wpn_AMMO >= 210 then
				max_stat_points = max_stat_points - 10
			end
			if wpn_AMMO >= 240 then
				max_stat_points = max_stat_points - 10
			end
			if wpn_AMMO >= 270 then
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
			if wpn_AMMO <= 150 then
				max_stat_points = max_stat_points + 10
			end
			if wpn_AMMO < 180 then
				max_stat_points = max_stat_points + 10
			end
			if wpn_AMMO >= 210 then
				max_stat_points = max_stat_points - 5
			end
			if wpn_AMMO >= 240 then
				max_stat_points = max_stat_points - 10
			end
			if wpn_AMMO >= 270 then
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
		elseif dmg_type == "175" then
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
			if wpn_AMMO <= 120 then
				max_stat_points = max_stat_points + 5
			end
			if wpn_AMMO > 150 then
				max_stat_points = max_stat_points - 5
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
			if wpn_AMMO <= 100 then
				max_stat_points = max_stat_points + 5
			end
			if wpn_AMMO > 125 then
				max_stat_points = max_stat_points - 10
			end
			if wpn_AMMO >= 150 then
				max_stat_points = max_stat_points - 20
			end
			if wpn_AMMO >= 175 then
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
			if wpn_AMMO <= 120 then
				max_stat_points = max_stat_points + 15
			end
			if wpn_AMMO <= 150 then
				max_stat_points = max_stat_points + 10
			end
			if wpn_AMMO > 210 then
				max_stat_points = max_stat_points - 5
			end
			if wpn_AMMO >= 240 then
				max_stat_points = max_stat_points - 5
			end
			if wpn_AMMO >= 270 then
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
	updateHandlingStats()
	
	-- set new recoil
	local AR_recoil = {
		v_base = 0.7,
		v_deviation = 0.75,
		h_base = 0.8,
		h_deviation = 0.25
	}
	
	local function set_new_weapon_recoil(weapon, recoil_data)
		local UPrecoil
		local DOWNrecoil
		local LEFTrecoil
		local RIGHTrecoil
		local V_base_recoil = recoil_data.v_base
		local V_recoil_deviation = recoil_data.v_deviation
		local H_base_recoil = recoil_data.h_base
		local H_recoil_deviation = recoil_data.h_deviation
		local recoil_lean = "left"
		if math.fmod(tweak_data.weapon[weapon].stats.recoil, 2) == 0 then
			recoil_lean = "right"
		end
		local recoil = tweak_data.weapon[weapon].stats.recoil * 4 - 4
		local recoil_weight = 1 - (recoil/100)
		UPrecoil = V_base_recoil + (recoil_weight * V_recoil_deviation)
		DOWNrecoil = UPrecoil * 0.9
		if recoil_lean == "left" then
			LEFTrecoil = H_base_recoil + (recoil_weight * H_recoil_deviation)
			RIGHTrecoil = LEFTrecoil * 0.05
		else
			RIGHTrecoil = H_base_recoil + (recoil_weight * H_recoil_deviation)
			LEFTrecoil = RIGHTrecoil * 0.05
		end
		LEFTrecoil = LEFTrecoil * -1
		tweak_data.weapon[weapon].kick = {
			standing = {
				UPrecoil,
				DOWNrecoil,
				LEFTrecoil,
				RIGHTrecoil
			}
		}
		tweak_data.weapon[weapon].kick.steelsight = tweak_data.weapon[weapon].kick.standing
		tweak_data.weapon[weapon].kick.crouching = tweak_data.weapon[weapon].kick.standing
	end
	set_new_weapon_recoil(id, AR_recoil)
	
end

function Gilza.applyCustomSMG_stats(id)

	table.insert(customWeaponsUpdated.Sub_Machine_guns, id)
	
	local avg_95_pickup = 8.1
	local avg_120_pickup = 7.1
	local avg_155_pickup = 4.8
	local avg_250_pickup = 2.63
	
	-- same as with AR's
	local dmg_type = "nil"
	
	local primary = false
	if tweak_data.weapon[id].use_data and tweak_data.weapon[id].use_data.selection_index then
		if tweak_data.weapon[id].use_data.selection_index == 2 then
			primary = true
		end
	end
	
	if tweak_data.weapon[id].stats.damage >= 105 and tweak_data.weapon[id].stats.damage <= 124 then
		tweak_data.weapon[id].stats.damage = 95
		tweak_data.weapon[id].AMMO_PICKUP = {((avg_95_pickup * 0.9) / 1.35) * secondary_mul,((avg_95_pickup * 1.1) / 1.35) * secondary_mul}
		dmg_type = "95"
	elseif tweak_data.weapon[id].stats.damage >= 125 and tweak_data.weapon[id].stats.damage <= 149 then
		tweak_data.weapon[id].stats.damage = 120
		tweak_data.weapon[id].AMMO_PICKUP = {((avg_120_pickup * 0.9) / 1.35) * secondary_mul,((avg_120_pickup * 1.1) / 1.35) * secondary_mul}
		dmg_type = "105"
	elseif tweak_data.weapon[id].stats.damage >= 150 and tweak_data.weapon[id].stats.damage <= 179 then
		tweak_data.weapon[id].stats.damage = 155
		tweak_data.weapon[id].AMMO_PICKUP = {((avg_155_pickup * 0.9) / 1.35) * secondary_mul,((avg_155_pickup * 1.1) / 1.35) * secondary_mul}
		dmg_type = "146"
	elseif tweak_data.weapon[id].stats.damage >= 180 and tweak_data.weapon[id].stats.damage <= 264 then
		tweak_data.weapon[id].stats.damage = 200
		tweak_data.weapon[id].AMMO_PICKUP = {((avg_250_pickup * 0.9) / 1.35) * 0.85 * secondary_mul,((avg_250_pickup * 1.1) / 1.35) * 0.85 * secondary_mul}
		dmg_type = "175"
	elseif tweak_data.weapon[id].stats.damage >= 265 then
		tweak_data.weapon[id].stats.damage = 250
		tweak_data.weapon[id].AMMO_PICKUP = {((avg_250_pickup * 0.9) / 1.35) * secondary_mul,((avg_250_pickup * 1.1) / 1.35) * secondary_mul}
		dmg_type = "210"
	end
	
	tweak_data.weapon[id].damage_falloff = {optimal_distance = 200,optimal_range = 700,near_falloff = 0,far_falloff = 1200,near_multiplier = 1.2,far_multiplier = 0.5}
	
	if dmg_type == "nil" then
		dmg_type = "super_light"
		local dmg = tweak_data.weapon[id].stats.damage
		local weapon_avg_pickup = (((math.ceil(250/dmg) + math.ceil(450/dmg))/0.3)/2)*0.65
		tweak_data.weapon[id].AMMO_PICKUP = {(weapon_avg_pickup * 0.9) / 1.35 * secondary_mul,(weapon_avg_pickup * 1.1) / 1.35 * secondary_mul}
	end
	
	-- primary adjust
	if primary then
		tweak_data.weapon[id].AMMO_PICKUP[1] = tweak_data.weapon[id].AMMO_PICKUP[1] * secondary_to_primary_mul
		tweak_data.weapon[id].AMMO_PICKUP[2] = tweak_data.weapon[id].AMMO_PICKUP[2] * secondary_to_primary_mul
	end
	
	-- akimbo adjust
	local akmb = false
	for i=1, #tweak_data.weapon[id].categories do
		if tweak_data.weapon[id].categories[i] == "akimbo" then
			akmb = true
		end
	end
	if akmb then
		tweak_data.weapon[id].stats.damage = tweak_data.weapon[id].stats.damage / 2
		tweak_data.weapon[id].AMMO_PICKUP[1] = tweak_data.weapon[id].AMMO_PICKUP[1] * 2
		tweak_data.weapon[id].AMMO_PICKUP[2] = tweak_data.weapon[id].AMMO_PICKUP[2] * 2
	end
	
	local function updateHandlingStats()
		-- stat adjustments based on class - higher dmg means lower total stats
		local wpn_ACC = tweak_data.weapon[id].stats.spread
		local wpn_STAB = tweak_data.weapon[id].stats.recoil
		local wpn_ROF =  60 / tweak_data.weapon[id].fire_mode_data.fire_rate
		local wpn_AMMO = tweak_data.weapon[id].AMMO_MAX
		local max_stat_points = 175
		
		-- allocation of max amount of stab+accuracy stats based on ammo/rof
		if dmg_type == "95" then
			if wpn_AMMO <= 120 then
				max_stat_points = max_stat_points + 15
			end
			if wpn_AMMO <= 150 then
				max_stat_points = max_stat_points + 10
			end
			if wpn_AMMO <= 180 then
				max_stat_points = max_stat_points + 5
			end
			if wpn_AMMO >= 210 then
				max_stat_points = max_stat_points - 5
			end
			if wpn_AMMO >= 240 then
				max_stat_points = max_stat_points - 15
			end
			if wpn_AMMO >= 270 then
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
		elseif dmg_type == "105" then
			if wpn_AMMO <= 120 then
				max_stat_points = max_stat_points + 10
			end
			if wpn_AMMO <= 150 then
				max_stat_points = max_stat_points + 5
			end
			if wpn_AMMO > 180 then
				max_stat_points = max_stat_points - 5
			end
			if wpn_AMMO >= 210 then
				max_stat_points = max_stat_points - 10
			end
			if wpn_AMMO >= 240 then
				max_stat_points = max_stat_points - 25
			end
			if wpn_AMMO >= 270 then
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
			if wpn_AMMO < 150 then
				max_stat_points = max_stat_points + 10
			end
			if wpn_AMMO >= 210 then
				max_stat_points = max_stat_points - 15
			end
			if wpn_AMMO >= 240 then
				max_stat_points = max_stat_points - 20
			end
			if wpn_AMMO >= 270 then
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
		elseif dmg_type == "175" then
			if wpn_AMMO < 150 then
				max_stat_points = max_stat_points + 5
			end
			if wpn_AMMO >= 210 then
				max_stat_points = max_stat_points - 15
			end
			if wpn_AMMO >= 240 then
				max_stat_points = max_stat_points - 20
			end
			if wpn_AMMO >= 270 then
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
			if wpn_AMMO > 150 then
				max_stat_points = max_stat_points - 10
			end
			if wpn_AMMO >= 180 then
				max_stat_points = max_stat_points - 20
			end
			if wpn_AMMO >= 210 then
				max_stat_points = max_stat_points - 25
			end
			if wpn_AMMO >= 240 then
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
			if wpn_AMMO <= 120 then
				max_stat_points = max_stat_points + 15
			end
			if wpn_AMMO <= 150 then
				max_stat_points = max_stat_points + 10
			end
			if wpn_AMMO > 210 then
				max_stat_points = max_stat_points - 5
			end
			if wpn_AMMO >= 240 then
				max_stat_points = max_stat_points - 10
			end
			if wpn_AMMO >= 270 then
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
	updateHandlingStats()
	
	-- set new recoil
	local SMG_recoil = {
		v_base = 0.4,
		v_deviation = 0.9,
		h_base = 0.55,
		h_deviation = 0.6
	}
	
	local function set_new_weapon_recoil(weapon, recoil_data)
		local UPrecoil
		local DOWNrecoil
		local LEFTrecoil
		local RIGHTrecoil
		local V_base_recoil = recoil_data.v_base
		local V_recoil_deviation = recoil_data.v_deviation
		local H_base_recoil = recoil_data.h_base
		local H_recoil_deviation = recoil_data.h_deviation
		local recoil_lean = "left"
		if math.fmod(tweak_data.weapon[weapon].stats.recoil, 2) == 0 then
			recoil_lean = "right"
		end
		local recoil = tweak_data.weapon[weapon].stats.recoil * 4 - 4
		local recoil_weight = 1 - (recoil/100)
		UPrecoil = V_base_recoil + (recoil_weight * V_recoil_deviation)
		DOWNrecoil = UPrecoil * 0.9
		if recoil_lean == "left" then
			LEFTrecoil = H_base_recoil + (recoil_weight * H_recoil_deviation)
			RIGHTrecoil = LEFTrecoil * 0.05
		else
			RIGHTrecoil = H_base_recoil + (recoil_weight * H_recoil_deviation)
			LEFTrecoil = RIGHTrecoil * 0.05
		end
		LEFTrecoil = LEFTrecoil * -1
		tweak_data.weapon[weapon].kick = {
			standing = {
				UPrecoil,
				DOWNrecoil,
				LEFTrecoil,
				RIGHTrecoil
			}
		}
		tweak_data.weapon[weapon].kick.steelsight = tweak_data.weapon[weapon].kick.standing
		tweak_data.weapon[weapon].kick.crouching = tweak_data.weapon[weapon].kick.standing
	end
	set_new_weapon_recoil(id, SMG_recoil)
	
end

function Gilza.applyCustomPISTOL_stats(id, isRevolver)

	table.insert(customWeaponsUpdated.Pistols, id)
	
	local avg_88_pickup = 6.8
	local avg_95_pickup = 6.48
	local avg_120_pickup = 5.67
	local avg_155_pickup = 3.59
	local avg_250_pickup = 2.16
	local avg_450_pickup = 1.44
	
	local isActuallyRevolver = false
	if tweak_data.weapon[id].CLIP_AMMO_MAX <= 8 then
		isActuallyRevolver = true
	end
	if isRevolver then
		isActuallyRevolver = true
	end
	
	-- same as with others - dont touch guns with REALLY low damage
	if tweak_data.weapon[id].stats.damage >= 50 and tweak_data.weapon[id].stats.damage <= 69 then
		tweak_data.weapon[id].stats.damage = 88
		tweak_data.weapon[id].AMMO_PICKUP = {((avg_88_pickup * 0.9) / 1.35) * secondary_mul,((avg_88_pickup * 1.1) / 1.35) * secondary_mul}
	elseif tweak_data.weapon[id].stats.damage >= 70 and tweak_data.weapon[id].stats.damage <= 124 then
		tweak_data.weapon[id].stats.damage = 95
		tweak_data.weapon[id].AMMO_PICKUP = {((avg_95_pickup * 0.9) / 1.35) * secondary_mul,((avg_95_pickup * 1.1) / 1.35) * secondary_mul}
	elseif tweak_data.weapon[id].stats.damage >= 125 and tweak_data.weapon[id].stats.damage <= 150 then
		tweak_data.weapon[id].stats.damage = 120
		tweak_data.weapon[id].AMMO_PICKUP = {((avg_120_pickup * 0.9) / 1.35) * secondary_mul,((avg_120_pickup * 1.1) / 1.35) * secondary_mul}
	elseif tweak_data.weapon[id].stats.damage >= 151 and tweak_data.weapon[id].stats.damage <= 219 then
		tweak_data.weapon[id].stats.damage = 155
		tweak_data.weapon[id].AMMO_PICKUP = {((avg_155_pickup * 0.9) / 1.35) * secondary_mul,((avg_155_pickup * 1.1) / 1.35) * secondary_mul}
	elseif tweak_data.weapon[id].stats.damage >= 220 then
		tweak_data.weapon[id].stats.damage = 250
		tweak_data.weapon[id].AMMO_PICKUP = {((avg_250_pickup * 0.9) / 1.35) * secondary_mul,((avg_250_pickup * 1.1) / 1.35) * secondary_mul}
	elseif tweak_data.weapon[id].stats.damage >= 300 and isActuallyRevolver then
		tweak_data.weapon[id].stats.damage = 450
		tweak_data.weapon[id].AMMO_PICKUP = {((avg_450_pickup * 0.9) / 1.35) * secondary_mul,((avg_450_pickup * 1.1) / 1.35) * secondary_mul}
	end
	
	if tweak_data.weapon[id].stats.damage < 50 then
		local dmg = tweak_data.weapon[id].stats.damage
		local weapon_avg_pickup = (((math.ceil(250/dmg) + math.ceil(450/dmg))/0.36)/2)*0.65
		tweak_data.weapon[id].AMMO_PICKUP = {(weapon_avg_pickup * 0.9) / 1.35 * secondary_mul,(weapon_avg_pickup * 1.1) / 1.35} * secondary_mul
	end
	
	tweak_data.weapon[id].damage_falloff = {optimal_distance = 10,optimal_range = 10,near_falloff = 0,far_falloff = 0,near_multiplier = 1,far_multiplier = 1}
	
	-- akimbo or primary pistols
	local primary = false
	if tweak_data.weapon[id].use_data and tweak_data.weapon[id].use_data.selection_index then
		if tweak_data.weapon[id].use_data.selection_index == 2 then
			primary = true
		end
	end
	if primary then
		tweak_data.weapon[id].AMMO_PICKUP[1] = tweak_data.weapon[id].AMMO_PICKUP[1] * secondary_to_primary_mul
		tweak_data.weapon[id].AMMO_PICKUP[2] = tweak_data.weapon[id].AMMO_PICKUP[2] * secondary_to_primary_mul
	end
	
	local fire_mode = "single"
	if (tweak_data.weapon[id].FIRE_MODE and tweak_data.weapon[id].FIRE_MODE == "auto") or tweak_data.weapon[id].CAN_TOGGLE_FIREMODE then
		fire_mode = "auto"
	end
	
	if fire_mode == "single" then
		if tweak_data.weapon[id].fire_mode_data then
			tweak_data.weapon[id].fire_mode_data.fire_rate = tweak_data.weapon[id].fire_mode_data.fire_rate * 1.2
		end
		if tweak_data.weapon[id].single then
			tweak_data.weapon[id].single.fire_rate = tweak_data.weapon[id].single.fire_rate * 1.2
		end
		if tweak_data.weapon[id].auto then
			tweak_data.weapon[id].auto.fire_rate = tweak_data.weapon[id].auto.fire_rate * 1.2
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

	-- dont allow for full auto pistols to go over this amount of base stability
	if fire_mode == "auto" and tweak_data.weapon[id].stats.recoil > 16 then
		tweak_data.weapon[id].stats.recoil = 16
	end
	
	-- set new recoil
	local SMG_recoil = {
		v_base = 0.4,
		v_deviation = 0.9,
		h_base = 0.55,
		h_deviation = 0.6
	}
	local Pistol_recoil = {
		v_base = 0.1,
		v_deviation = 1,
		h_base = 0.2,
		h_deviation = 1
	}
	
	local function set_new_weapon_recoil(weapon, recoil_data)
		local UPrecoil
		local DOWNrecoil
		local LEFTrecoil
		local RIGHTrecoil
		local V_base_recoil = recoil_data.v_base
		local V_recoil_deviation = recoil_data.v_deviation
		local H_base_recoil = recoil_data.h_base
		local H_recoil_deviation = recoil_data.h_deviation
		local recoil_lean = "left"
		if math.fmod(tweak_data.weapon[weapon].stats.recoil, 2) == 0 then
			recoil_lean = "right"
		end
		local recoil = tweak_data.weapon[weapon].stats.recoil * 4 - 4
		local recoil_weight = 1 - (recoil/100)
		UPrecoil = V_base_recoil + (recoil_weight * V_recoil_deviation)
		DOWNrecoil = UPrecoil * 0.9
		if recoil_lean == "left" then
			LEFTrecoil = H_base_recoil + (recoil_weight * H_recoil_deviation)
			RIGHTrecoil = LEFTrecoil * 0.05
		else
			RIGHTrecoil = H_base_recoil + (recoil_weight * H_recoil_deviation)
			LEFTrecoil = RIGHTrecoil * 0.05
		end
		LEFTrecoil = LEFTrecoil * -1
		tweak_data.weapon[weapon].kick = {
			standing = {
				UPrecoil,
				DOWNrecoil,
				LEFTrecoil,
				RIGHTrecoil
			}
		}
		tweak_data.weapon[weapon].kick.steelsight = tweak_data.weapon[weapon].kick.standing
		tweak_data.weapon[weapon].kick.crouching = tweak_data.weapon[weapon].kick.standing
	end
	
	if fire_mode == "auto" then
		set_new_weapon_recoil(id, SMG_recoil)
	else
		set_new_weapon_recoil(id, Pistol_recoil)
	end
	
end

function Gilza.applyCustomLMG_stats(id)

	table.insert(customWeaponsUpdated.Light_Machine_guns, id)
	
	local avg_250_pickup = 3.29
	local avg_155_pickup = 5.95
	local avg_120_pickup = 8.85
	
	local dmg_type = "nil"
	
	if tweak_data.weapon[id].stats.damage >= 115 and tweak_data.weapon[id].stats.damage < 144 then
		tweak_data.weapon[id].stats.damage = 120
		tweak_data.weapon[id].AMMO_PICKUP = {(avg_120_pickup * 0.9) / 1.35,(avg_120_pickup * 1.1) / 1.35}
		dmg_type = "105"
	elseif tweak_data.weapon[id].stats.damage >= 145 and tweak_data.weapon[id].stats.damage < 229 then
		tweak_data.weapon[id].stats.damage = 155
		tweak_data.weapon[id].AMMO_PICKUP = {(avg_155_pickup * 0.9) / 1.35,(avg_155_pickup * 1.1) / 1.35}
		dmg_type = "140"
	elseif tweak_data.weapon[id].stats.damage >= 230 then
		tweak_data.weapon[id].stats.damage = 250
		tweak_data.weapon[id].AMMO_PICKUP = {(avg_250_pickup * 0.9) / 1.35,(avg_250_pickup * 1.1) / 1.35}
		dmg_type = "210"
	end
	
	if dmg_type == "nil" then
		dmg_type = "super_light"
		local dmg = tweak_data.weapon[id].stats.damage
		local weapon_avg_pickup = (((math.ceil(250/dmg) + math.ceil(450/dmg))/0.3)/2)*0.65
		tweak_data.weapon[id].AMMO_PICKUP = {(weapon_avg_pickup * 0.9) / 1.35,(weapon_avg_pickup * 1.1) / 1.35}
	end

	tweak_data.weapon[id].damage_falloff = {optimal_distance = 200,optimal_range = 1000,near_falloff = 0,far_falloff = 1000,near_multiplier = 0.5,far_multiplier = 1.65}
	
	if dmg_type == "super_light" or dmg_type == "105" then
		tweak_data.weapon[id].damage_falloff.far_multiplier = 2.1
	end

	-- set new recoil
	local LMG_recoil = {
		v_base = 0.85,
		v_deviation = 0.65,
		h_base = 0.75,
		h_deviation = 0.4
	}
	
	local function set_new_weapon_recoil(weapon, recoil_data)
		local UPrecoil
		local DOWNrecoil
		local LEFTrecoil
		local RIGHTrecoil
		local V_base_recoil = recoil_data.v_base
		local V_recoil_deviation = recoil_data.v_deviation
		local H_base_recoil = recoil_data.h_base
		local H_recoil_deviation = recoil_data.h_deviation
		local recoil_lean = "left"
		if math.fmod(tweak_data.weapon[weapon].stats.recoil, 2) == 0 then
			recoil_lean = "right"
		end
		local recoil = tweak_data.weapon[weapon].stats.recoil * 4 - 4
		local recoil_weight = 1 - (recoil/100)
		UPrecoil = V_base_recoil + (recoil_weight * V_recoil_deviation)
		DOWNrecoil = UPrecoil * 0.9
		if recoil_lean == "left" then
			LEFTrecoil = H_base_recoil + (recoil_weight * H_recoil_deviation)
			RIGHTrecoil = LEFTrecoil * 0.05
		else
			RIGHTrecoil = H_base_recoil + (recoil_weight * H_recoil_deviation)
			LEFTrecoil = RIGHTrecoil * 0.05
		end
		LEFTrecoil = LEFTrecoil * -1
		tweak_data.weapon[weapon].kick = {
			standing = {
				UPrecoil,
				DOWNrecoil,
				LEFTrecoil,
				RIGHTrecoil
			}
		}
		tweak_data.weapon[weapon].kick.steelsight = tweak_data.weapon[weapon].kick.standing
		tweak_data.weapon[weapon].kick.crouching = tweak_data.weapon[weapon].kick.standing
	end
	set_new_weapon_recoil(id, LMG_recoil)
	
end

function Gilza.applyCustomSNIPER_stats(id)

	table.insert(customWeaponsUpdated.Snipers, id)
	
	Gilza.customSnipersToUpdateScopesFor = Gilza.customSnipersToUpdateScopesFor or {}
	table.insert(Gilza.customSnipersToUpdateScopesFor, id)
	
	local sniper_SA_avg_pickup = 0.8
	local sniper_LA_avg_pickup = 0.74
	local sniper_BA_avg_pickup = 0.64
	local sniper_BAH_avg_pickup = 0.57
	
	if tweak_data.weapon[id].stats_modifiers then
		if tweak_data.weapon[id].stats_modifiers.damage then
			tweak_data.weapon[id].stats.damage = tweak_data.weapon[id].stats.damage * tweak_data.weapon[id].stats_modifiers.damage
			tweak_data.weapon[id].stats_modifiers.damage = 1
		end
	end
	
	local bolty = false
	local force_semi_auto = false
	local force_lever_action = false
	
	if tweak_data.weapon[id].stats.damage <= 240 then
		force_semi_auto = true
	elseif tweak_data.weapon[id].stats.damage >= 241 and tweak_data.weapon[id].stats.damage <= 450 then
		force_lever_action = true
	elseif tweak_data.weapon[id].stats.damage >= 451 and tweak_data.weapon[id].stats.damage <= 1750 then
		if tweak_data.weapon[id].CLIP_AMMO_MAX > 6 then
			tweak_data.weapon[id].stats.damage = 1300
			tweak_data.weapon[id].AMMO_PICKUP = {(sniper_BA_avg_pickup * 0.9) / 1.35,(sniper_BA_avg_pickup * 1.1) / 1.35}
		else
			tweak_data.weapon[id].stats.damage = 1600
			tweak_data.weapon[id].AMMO_PICKUP = {(sniper_BAH_avg_pickup * 0.9) / 1.35,(sniper_BAH_avg_pickup * 1.1) / 1.35}
		end
		bolty = true
	end
	
	local rof = 0
	if tweak_data.weapon[id].single then
		rof = tweak_data.weapon[id].single.fire_rate
	end
	if tweak_data.weapon[id].fire_mode_data then
		rof = tweak_data.weapon[id].fire_mode_data.fire_rate
	end
	rof = 60 / rof
	if rof > 150 then
		force_semi_auto = true
	end
	
	if tweak_data.weapon[id].use_shotgun_reload == true then
		force_lever_action = true
	end
	
	if force_semi_auto then
		tweak_data.weapon[id].fire_mode_data = {fire_rate = 60/300}
		tweak_data.weapon[id].single = {fire_rate = 60/300}
		tweak_data.weapon[id].stats.damage = 650
		tweak_data.weapon[id].AMMO_PICKUP = {(sniper_SA_avg_pickup * 0.9) / 1.35,(sniper_SA_avg_pickup * 1.1) / 1.35}
	elseif force_lever_action then
		tweak_data.weapon[id].stats.damage = 950
		tweak_data.weapon[id].AMMO_PICKUP = {(sniper_LA_avg_pickup * 0.9) / 1.35,(sniper_LA_avg_pickup * 1.1) / 1.35}
	end
	
	-- if weapon did not fall under either of 4 categories
	if not bolty and not force_semi_auto and not force_lever_action then
		local dmg = tweak_data.weapon[id].stats.damage
		local weapon_avg_pickup = (((math.ceil(250/dmg) + math.ceil(450/dmg))/0.65)/2)*0.65
		-- if sniper can one shot headshot both normal and heavy swats, check it's bodyshot capabilities
		if math.ceil(250/dmg) + math.ceil(450/dmg) == 2 then
			-- if we can one-shot-bodyshot them, test against tazer and cloaker health
			if math.ceil(500/dmg) + math.ceil(900/dmg) == 2 then
				-- if we can one-shot-bodyshot tazer and cloaker apply dozer buster pickups
				if math.ceil(1250/dmg) + math.ceil(1540/dmg) == 2 then
					weapon_avg_pickup = math.ceil(24000/dmg) * 0.07
				else
					weapon_avg_pickup = (((math.ceil(1250/dmg) + math.ceil(1540/dmg))/0.65)/2)*0.65
				end
			else
				weapon_avg_pickup = (((math.ceil(500/dmg) + math.ceil(900/dmg))/0.65)/2)*0.65
			end
		end
		tweak_data.weapon[id].AMMO_PICKUP = {(weapon_avg_pickup * 0.9) / 1.35,(weapon_avg_pickup * 1.1) / 1.35}
	end
	
	-- secondary snipers
	if tweak_data.weapon[id].use_data and tweak_data.weapon[id].use_data.selection_index and tweak_data.weapon[id].use_data.selection_index == 1 then
		tweak_data.weapon[id].AMMO_PICKUP[1] = tweak_data.weapon[id].AMMO_PICKUP[1] * secondary_mul
		tweak_data.weapon[id].AMMO_PICKUP[2] = tweak_data.weapon[id].AMMO_PICKUP[2] * secondary_mul
	end
	
	tweak_data.weapon[id].damage_falloff = {
		optimal_distance = 10,
		optimal_range = 10,
		near_falloff = 0,
		far_falloff = 0,
		near_multiplier = 1,
		far_multiplier = 1
	}
	
	-- set new recoil
	local Sniper_recoil = {
		v_base = 0.7,
		v_deviation = 1.2,
		h_base = 0.1,
		h_deviation = 0.9
	}
	
	local function set_new_weapon_recoil(weapon, recoil_data)
		local UPrecoil
		local DOWNrecoil
		local LEFTrecoil
		local RIGHTrecoil
		local V_base_recoil = recoil_data.v_base
		local V_recoil_deviation = recoil_data.v_deviation
		local H_base_recoil = recoil_data.h_base
		local H_recoil_deviation = recoil_data.h_deviation
		local recoil_lean = "left"
		if math.fmod(tweak_data.weapon[weapon].stats.recoil, 2) == 0 then
			recoil_lean = "right"
		end
		local recoil = tweak_data.weapon[weapon].stats.recoil * 4 - 4
		local recoil_weight = 1 - (recoil/100)
		UPrecoil = V_base_recoil + (recoil_weight * V_recoil_deviation)
		DOWNrecoil = UPrecoil * 0.9
		if recoil_lean == "left" then
			LEFTrecoil = H_base_recoil + (recoil_weight * H_recoil_deviation)
			RIGHTrecoil = LEFTrecoil * 0.05
		else
			RIGHTrecoil = H_base_recoil + (recoil_weight * H_recoil_deviation)
			LEFTrecoil = RIGHTrecoil * 0.05
		end
		LEFTrecoil = LEFTrecoil * -1
		tweak_data.weapon[weapon].kick = {
			standing = {
				UPrecoil,
				DOWNrecoil,
				LEFTrecoil,
				RIGHTrecoil
			}
		}
		tweak_data.weapon[weapon].kick.steelsight = tweak_data.weapon[weapon].kick.standing
		tweak_data.weapon[weapon].kick.crouching = tweak_data.weapon[weapon].kick.standing
	end
	set_new_weapon_recoil(id, Sniper_recoil)
	
end

function Gilza.applyCustomSHOTGUN_stats(id)

	table.insert(customWeaponsUpdated.Shotguns, id)
	
	local avg_1000_pickup = 0.65
	local avg_450_pickup = 0.87
	local avg_310_pickup = 1.77
	local avg_110_pickup = 5.78
	
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
	
	if tweak_data.weapon[id].stats.damage <= 109 then
		category = 1 -- full auto
	elseif tweak_data.weapon[id].stats.damage >= 110 and tweak_data.weapon[id].stats.damage <= 160 then
		category = 2 -- semi auto no mag
	elseif tweak_data.weapon[id].stats.damage >= 161 and tweak_data.weapon[id].stats.damage <= 270 then
		category = 3 -- pump
	elseif tweak_data.weapon[id].stats.damage >= 271 and tweak_data.weapon[id].stats.damage <= 500 then
		category = 4 -- DB
	else
		category = 5
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
		if (60/rof) >= 160 then
			category = 2
		end
	end
	
	if tweak_data.weapon[id].rays < 10 then
		tweak_data.weapon[id].rays = 10
	end
	
	if category == 1 then
		tweak_data.weapon[id].stats.damage = 100
		tweak_data.weapon[id].damage_falloff = {
			optimal_distance = 0,
			optimal_range = 1000,
			near_falloff = 0,
			far_falloff = 1000,
			near_multiplier = 1,
			far_multiplier = 0.5
		}
		Gilza.shotgun_minimal_damage_multipliers[id] = 0.35
		if secondary == false then
			tweak_data.weapon[id].AMMO_PICKUP = {(avg_110_pickup * 0.9) / 1.35,(avg_110_pickup * 1.1) / 1.35}
		else
			tweak_data.weapon[id].AMMO_PICKUP = {(avg_110_pickup * 0.9) / 1.35 * secondary_mul,(avg_110_pickup * 1.1) / 1.35 * secondary_mul}
		end
	elseif category == 2 then
		tweak_data.weapon[id].stats.damage = 325
		tweak_data.weapon[id].damage_falloff = {
			optimal_distance = 0,
			optimal_range = 1250,
			near_falloff = 0,
			far_falloff = 1000,
			near_multiplier = 1,
			far_multiplier = 0.5
		}
		Gilza.shotgun_minimal_damage_multipliers[id] = 0.5
		if secondary == false then
			tweak_data.weapon[id].AMMO_PICKUP = {(avg_310_pickup * 0.9) / 1.35 * secondary_mul,(avg_310_pickup * 1.1) / 1.35 * secondary_mul}
		else
			tweak_data.weapon[id].AMMO_PICKUP = {(avg_310_pickup * 0.9) / 1.35,(avg_310_pickup * 1.1) / 1.35}
		end
	elseif category == 3 then
		tweak_data.weapon[id].stats.damage = 450
		tweak_data.weapon[id].damage_falloff = {
			optimal_distance = 0,
			optimal_range = 1500,
			near_falloff = 0,
			far_falloff = 1000,
			near_multiplier = 1,
			far_multiplier = 0.5
		}
		Gilza.shotgun_minimal_damage_multipliers[id] = 0.67
		if secondary == false then
			tweak_data.weapon[id].AMMO_PICKUP = {(avg_450_pickup * 0.9) / 1.35,(avg_450_pickup * 1.1) / 1.35}
		else
			tweak_data.weapon[id].AMMO_PICKUP = {((avg_450_pickup * 0.9) / 1.35) * secondary_mul,((avg_450_pickup * 1.1) / 1.35) * secondary_mul}
		end
	elseif category == 4 then
		tweak_data.weapon[id].stats.damage = 1250
		tweak_data.weapon[id].damage_falloff = {
			optimal_distance = 0,
			optimal_range = 1850,
			near_falloff = 0,
			far_falloff = 1000,
			near_multiplier = 1,
			far_multiplier = 0.5
		}
		Gilza.shotgun_minimal_damage_multipliers[id] = 1
		if secondary == false then
			tweak_data.weapon[id].AMMO_PICKUP = {(avg_1000_pickup * 0.9) / 1.35,(avg_1000_pickup * 1.1) / 1.35}
		else
			tweak_data.weapon[id].AMMO_PICKUP = {((avg_1000_pickup * 0.9) / 1.35) * secondary_mul,((avg_1000_pickup * 1.1) / 1.35) * secondary_mul}
		end
	elseif category == 5 then
		local dmg = tweak_data.weapon[id].stats.damage
		local weapon_avg_pickup = (((math.ceil(250/dmg) + math.ceil(450/dmg))/0.4)/2)*0.65
		if secondary == false then
			tweak_data.weapon[id].AMMO_PICKUP = {(weapon_avg_pickup * 0.9) / 1.35,(weapon_avg_pickup * 1.1) / 1.35}
		else
			tweak_data.weapon[id].AMMO_PICKUP = {(weapon_avg_pickup * 0.9) / 1.35 * secondary_mul,(weapon_avg_pickup * 1.1) / 1.35} * secondary_mul
		end
	end
	
	-- shothun ammo. dear god.
	local HE_custom_stats = {
		ignore_statistic = true,
		damage_far_mul = 1,
		damage_near_mul = 1,
		bullet_class = "InstantExplosiveBulletBase",
		rays = 1,
		ammo_pickup_max_mul = 0.35,
		ammo_pickup_min_mul = 0.35
	}
	local FAHEstats = {
		value = 5,
		total_ammo_mod = -10,
		damage = 120,
		recoil = -8
	}
	local SAHEstats = {
		value = 5,
		total_ammo_mod = -10,
		damage = 400,
		recoil = -8
	}
	local PAHEstats = {
		value = 5,
		total_ammo_mod = -10,
		damage = 550,
		recoil = -8
	}
	local DBHEstats = {
		value = 5,
		total_ammo_mod = -10,
		damage = 1100,
		recoil = -8
	}
	local ultraHEstats = {
		value = 5,
		total_ammo_mod = -10,
		damage = tweak_data.weapon[id].stats.damage * 1.1,
		recoil = -8
	}
	
	local BS_custom_stats = {
		damage_far_mul = 0.8,
		damage_near_mul = 0.8,
		ammo_pickup_max_mul = 0.5,
		ammo_pickup_min_mul = 0.5,
		is_buckshot = true,
		rays = 8
	}
	local FABS_stats = {
		total_ammo_mod = -5,
		damage = 100
	}
	local SABS_stats = {
		total_ammo_mod = -5,
		damage = 325
	}
	local PABS_stats = {
		total_ammo_mod = -5,
		damage = 450
	}
	local DBBS_stats = {
		total_ammo_mod = -5,
		damage = 1000
	}
	local ultraBS_stats = {
		total_ammo_mod = -5,
		damage = tweak_data.weapon[id].stats.damage * 1.1
	}

	local wpn_factory_id = managers.weapon_factory:get_factory_id_by_weapon_id(id)
	tweak_data.weapon.factory[wpn_factory_id].override = tweak_data.weapon.factory[wpn_factory_id].override or {}
	if category == 1 then
		tweak_data.weapon.factory[wpn_factory_id].override.wpn_fps_upg_a_explosive = {stats = FAHEstats,custom_stats = HE_custom_stats}
		tweak_data.weapon.factory[wpn_factory_id].override.wpn_fps_upg_a_custom = {stats = FABS_stats,custom_stats = BS_custom_stats}
		tweak_data.weapon.factory[wpn_factory_id].override.wpn_fps_upg_a_custom_free = {stats = FABS_stats,custom_stats = BS_custom_stats}
	elseif category == 2 then
		tweak_data.weapon.factory[wpn_factory_id].override.wpn_fps_upg_a_explosive = {stats = SAHEstats,custom_stats = HE_custom_stats}
		tweak_data.weapon.factory[wpn_factory_id].override.wpn_fps_upg_a_custom = {stats = SABS_stats,custom_stats = BS_custom_stats}
		tweak_data.weapon.factory[wpn_factory_id].override.wpn_fps_upg_a_custom_free = {stats = SABS_stats,custom_stats = BS_custom_stats}
	elseif category == 3 then
		tweak_data.weapon.factory[wpn_factory_id].override.wpn_fps_upg_a_explosive = {stats = PAHEstats,custom_stats = HE_custom_stats}
		tweak_data.weapon.factory[wpn_factory_id].override.wpn_fps_upg_a_custom = {stats = PABS_stats,custom_stats = BS_custom_stats}
		tweak_data.weapon.factory[wpn_factory_id].override.wpn_fps_upg_a_custom_free = {stats = PABS_stats,custom_stats = BS_custom_stats}
	elseif category == 4 then
		tweak_data.weapon.factory[wpn_factory_id].override.wpn_fps_upg_a_explosive = {stats = DBHEstats,custom_stats = HE_custom_stats}
		tweak_data.weapon.factory[wpn_factory_id].override.wpn_fps_upg_a_custom = {stats = DBBS_stats,custom_stats = BS_custom_stats}
		tweak_data.weapon.factory[wpn_factory_id].override.wpn_fps_upg_a_custom_free = {stats = DBBS_stats,custom_stats = BS_custom_stats}
	elseif category == 5 then
		tweak_data.weapon.factory[wpn_factory_id].override.wpn_fps_upg_a_explosive = {stats = ultraHE_stats,custom_stats = HE_custom_stats}
		tweak_data.weapon.factory[wpn_factory_id].override.wpn_fps_upg_a_custom = {stats = ultraBS_stats,custom_stats = BS_custom_stats}
		tweak_data.weapon.factory[wpn_factory_id].override.wpn_fps_upg_a_custom_free = {stats = ultraBS_stats,custom_stats = BS_custom_stats}
	end
	
	-- set new recoil
	local Shotgun_recoil = {
		v_base = 1,
		v_deviation = 1.5,
		h_base = 0.6,
		h_deviation = 0.8
	}
	
	local function set_new_weapon_recoil(weapon, recoil_data)
		local UPrecoil
		local DOWNrecoil
		local LEFTrecoil
		local RIGHTrecoil
		local V_base_recoil = recoil_data.v_base
		local V_recoil_deviation = recoil_data.v_deviation
		local H_base_recoil = recoil_data.h_base
		local H_recoil_deviation = recoil_data.h_deviation
		local recoil_lean = "left"
		if math.fmod(tweak_data.weapon[weapon].stats.recoil, 2) == 0 then
			recoil_lean = "right"
		end
		local recoil = tweak_data.weapon[weapon].stats.recoil * 4 - 4
		local recoil_weight = 1 - (recoil/100)
		UPrecoil = V_base_recoil + (recoil_weight * V_recoil_deviation)
		DOWNrecoil = UPrecoil * 0.9
		if recoil_lean == "left" then
			LEFTrecoil = H_base_recoil + (recoil_weight * H_recoil_deviation)
			RIGHTrecoil = LEFTrecoil * 0.05
		else
			RIGHTrecoil = H_base_recoil + (recoil_weight * H_recoil_deviation)
			LEFTrecoil = RIGHTrecoil * 0.05
		end
		LEFTrecoil = LEFTrecoil * -1
		tweak_data.weapon[weapon].kick = {
			standing = {
				UPrecoil,
				DOWNrecoil,
				LEFTrecoil,
				RIGHTrecoil
			}
		}
		tweak_data.weapon[weapon].kick.steelsight = tweak_data.weapon[weapon].kick.standing
		tweak_data.weapon[weapon].kick.crouching = tweak_data.weapon[weapon].kick.standing
	end
	set_new_weapon_recoil(id, Shotgun_recoil)
	
end

function Gilza.applyCustomMELEE_stats()
	for melee, stats in pairs(tweak_data.blackmarket.melee_weapons) do
		if table.contains (Gilza.default_melee_weapons, melee) then
			-- default weapon, dont do anything
		else
			table.insert(customWeaponsUpdated.Melee, melee)
			if stats.repeat_expire_t <= 0.35 then
				tweak_data.blackmarket.melee_weapons[melee].stats.min_damage = 2
				tweak_data.blackmarket.melee_weapons[melee].stats.max_damage = 3.5
				tweak_data.blackmarket.melee_weapons[melee].stats.min_damage_effect = 7
				tweak_data.blackmarket.melee_weapons[melee].stats.max_damage_effect = 7
			elseif stats.repeat_expire_t <= 0.65 then
				tweak_data.blackmarket.melee_weapons[melee].stats.min_damage = 2.5
				tweak_data.blackmarket.melee_weapons[melee].stats.max_damage = 5
				tweak_data.blackmarket.melee_weapons[melee].stats.min_damage_effect = 7
				tweak_data.blackmarket.melee_weapons[melee].stats.max_damage_effect = 7
			elseif stats.repeat_expire_t <= 1 then
				tweak_data.blackmarket.melee_weapons[melee].stats.min_damage = 3.5
				tweak_data.blackmarket.melee_weapons[melee].stats.max_damage = 7.5
				tweak_data.blackmarket.melee_weapons[melee].stats.min_damage_effect = 7
				tweak_data.blackmarket.melee_weapons[melee].stats.max_damage_effect = 7
			elseif stats.repeat_expire_t > 1 then
				if stats.melee_damage_delay <= 0.35 then
					tweak_data.blackmarket.melee_weapons[melee].stats.min_damage = 5
					tweak_data.blackmarket.melee_weapons[melee].stats.max_damage = 10
					tweak_data.blackmarket.melee_weapons[melee].stats.min_damage_effect = 7
					tweak_data.blackmarket.melee_weapons[melee].stats.max_damage_effect = 7
				elseif stats.melee_damage_delay > 0.35 then
					tweak_data.blackmarket.melee_weapons[melee].stats.min_damage = 7.5
					tweak_data.blackmarket.melee_weapons[melee].stats.max_damage = 15
					tweak_data.blackmarket.melee_weapons[melee].stats.min_damage_effect = 7
					tweak_data.blackmarket.melee_weapons[melee].stats.max_damage_effect = 7
				end
			end
			local additional_wpn_range = tweak_data.blackmarket.melee_weapons[melee].stats.range - 150
			if additional_wpn_range >= 20 then
				local knock = math.clamp(additional_wpn_range/20, 1, 6)
				tweak_data.blackmarket.melee_weapons[melee].stats.min_damage_effect = 7 - knock
				tweak_data.blackmarket.melee_weapons[melee].stats.max_damage_effect = 7 - knock
			end
			-- poison
			if tweak_data.blackmarket.melee_weapons[melee].dot_data_name then
				tweak_data.blackmarket.melee_weapons[melee].stats.min_damage = 2
				tweak_data.blackmarket.melee_weapons[melee].stats.max_damage = 3.5
				tweak_data.blackmarket.melee_weapons[melee].stats.min_damage_effect = 1
				tweak_data.blackmarket.melee_weapons[melee].stats.max_damage_effect = 1
				tweak_data.blackmarket.melee_weapons[melee].stats.concealment = tweak_data.blackmarket.melee_weapons[melee].stats.concealment - 2
			end
			-- tazer
			if tweak_data.blackmarket.melee_weapons[melee].tase_data then
				tweak_data.blackmarket.melee_weapons[melee].stats.min_damage = 0.5
				tweak_data.blackmarket.melee_weapons[melee].stats.max_damage = 1
				tweak_data.blackmarket.melee_weapons[melee].stats.min_damage_effect = 1
				tweak_data.blackmarket.melee_weapons[melee].stats.max_damage_effect = 1
				tweak_data.blackmarket.melee_weapons[melee].stats.charge_time = 0.5
			end
			-- special
			if tweak_data.blackmarket.melee_weapons[melee].random_special_effects then
				tweak_data.blackmarket.melee_weapons[melee].stats.concealment = tweak_data.blackmarket.melee_weapons[melee].stats.concealment - 4
			end
		end
	end
end

-- this will go through every single custom weapon that i had time to tweak, executed after normal custom gun tweaks
function Gilza.applyCustomGunsIndividualStats()
	
	local function adjustSniperScopeStats()
	
		if not tweak_data.weapon.factory.parts then
			return
		end
		
		if not Gilza.customSnipersToUpdateScopesFor then
			return
		end

		local sights_list = {}
		for id, _table_ in pairs(tweak_data.weapon.factory.parts) do
			if tweak_data.weapon.factory.parts[id].type and tweak_data.weapon.factory.parts[id].type == "sight" and tweak_data.weapon.factory.parts[id].stats then
				table.insert(sights_list, tostring(id))
			end
		end
		
		table.delete(sights_list,"wpn_fps_upg_o_shortdot")
		table.delete(sights_list,"wpn_fps_upg_o_shortdot_vanilla")
		table.delete(sights_list,"wpn_fps_upg_winchester_o_classic")
		
		local snipers = Gilza.customSnipersToUpdateScopesFor
		
		for _, weapon in pairs(snipers) do
			local sniper = managers.weapon_factory:get_factory_id_by_weapon_id(weapon)
			if tweak_data.weapon.factory[sniper] then
				tweak_data.weapon.factory[sniper].override = tweak_data.weapon.factory[sniper].override or {}
				for __, part in pairs(sights_list) do
					tweak_data.weapon.factory[sniper].override[part] = {stats = deep_clone(tweak_data.weapon.factory.parts[part].stats)}
					if not tweak_data.weapon.factory.parts[part].stats.concealment or tweak_data.weapon.factory.parts[part].stats.concealment >= 0 then
						tweak_data.weapon.factory[sniper].override[part].stats.concealment = 3
					elseif tweak_data.weapon.factory.parts[part].stats.concealment == -1 then
						tweak_data.weapon.factory[sniper].override[part].stats.concealment = 2
					elseif tweak_data.weapon.factory.parts[part].stats.concealment == -2 then
						tweak_data.weapon.factory[sniper].override[part].stats.concealment = 1
					elseif tweak_data.weapon.factory.parts[part].stats.concealment == -3 then
						tweak_data.weapon.factory[sniper].override[part].stats.concealment = 0
					else
						tweak_data.weapon.factory[sniper].override[part].stats.concealment = -1
					end
				end
			end
		end
	end
	adjustSniperScopeStats()
	
	-- might add custom guns later, i am too tired rn
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