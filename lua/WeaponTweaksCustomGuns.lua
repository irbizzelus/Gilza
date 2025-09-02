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
							if tostring(tweak_data.weapon[customWeaponsList[j]].categories[k]) == "revolver" then
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
	
	local G_W_M = Gilza.Weapons_module
	local pickups = G_W_M.ammo_pickups.ARs
	
	local custom_ARs_with_GL = {
		"g3hk79",
		"mdr_308",
		"yayo",
		"m14e2",
		"soppo",
		"kurisumasu",
		"liberator",
		"xeno"
	}
	local has_gl = table.contains(custom_ARs_with_GL,id)
	local dmg_type = "nil"
	
	-- light AR's
	if tweak_data.weapon[id].stats.damage >= 115 and tweak_data.weapon[id].stats.damage <= 143 then
		tweak_data.weapon[id].stats.damage = 125
		tweak_data.weapon[id].AMMO_PICKUP = {(pickups._125 * 0.9),(pickups._125 * 1.1)}
		dmg_type = "105"
	-- low mid AR's
	elseif tweak_data.weapon[id].stats.damage >= 144 and tweak_data.weapon[id].stats.damage <= 174 then
		tweak_data.weapon[id].stats.damage = 155
		tweak_data.weapon[id].AMMO_PICKUP = {(pickups._155 * 0.9),(pickups._155 * 1.1)}
		dmg_type = "146"
	-- high mid AR's
	elseif tweak_data.weapon[id].stats.damage >= 175 and tweak_data.weapon[id].stats.damage <= 229 then
		tweak_data.weapon[id].stats.damage = 200
		tweak_data.weapon[id].AMMO_PICKUP = {((pickups._200 * 0.9)),((pickups._200 * 1.1))}
		dmg_type = "175"
	-- heavy AR's
	elseif tweak_data.weapon[id].stats.damage >= 230 and tweak_data.weapon[id].stats.damage <= 400 then
		tweak_data.weapon[id].stats.damage = 250
		tweak_data.weapon[id].AMMO_PICKUP = {(pickups._250 * 0.9),(pickups._250 * 1.1)}
		dmg_type = "210"
	-- super heavy AR's
	elseif tweak_data.weapon[id].stats.damage >= 401 then
		tweak_data.weapon[id].stats.damage = 450
		tweak_data.weapon[id].AMMO_PICKUP = {(pickups._450 * 0.9),(pickups._450 * 1.1)}
		dmg_type = "420"
	end
	
	tweak_data.weapon[id].damage_falloff = G_W_M.damage_dropoff.ARs
	
	if dmg_type == "nil" then
		dmg_type = "super_light"
		local weapon_avg_pickup = G_W_M:get_ammo_pickup(tweak_data.weapon[id].stats.damage, 0.28)
		tweak_data.weapon[id].AMMO_PICKUP = {(weapon_avg_pickup * 0.9),(weapon_avg_pickup * 1.1)}
	end
	
	local primary = true
	if tweak_data.weapon[id].use_data and tweak_data.weapon[id].use_data.selection_index then
		if tweak_data.weapon[id].use_data.selection_index == 1 then
			primary = false
		end
	end
	-- secondary adjust
	if not primary then
		tweak_data.weapon[id].AMMO_PICKUP[1] = tweak_data.weapon[id].AMMO_PICKUP[1] * secondary_mul
		tweak_data.weapon[id].AMMO_PICKUP[2] = tweak_data.weapon[id].AMMO_PICKUP[2] * secondary_mul
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
			allowed_acc = wpn_ACC + 1
		end
		
		-- apply
		tweak_data.weapon[id].stats.spread = allowed_acc
		tweak_data.weapon[id].stats.recoil = allowed_stab
	end
	updateHandlingStats()
	
	local recoil_lean = "left"
	if math.fmod(tweak_data.weapon[id].stats.recoil, 2) == 0 then
		recoil_lean = "right"
	end
	G_W_M:set_new_weapon_recoil(G_W_M.recoil_stats.ARs, id, recoil_lean)
	
end

function Gilza.applyCustomSMG_stats(id)

	table.insert(customWeaponsUpdated.Sub_Machine_guns, id)
	
	local G_W_M = Gilza.Weapons_module
	local pickups = G_W_M.ammo_pickups.SMGs
	
	-- same as with AR's
	local dmg_type = "nil"
	
	if tweak_data.weapon[id].stats.damage >= 105 and tweak_data.weapon[id].stats.damage <= 124 then
		tweak_data.weapon[id].stats.damage = 95
		tweak_data.weapon[id].AMMO_PICKUP = {((pickups._95 * 0.9)) * secondary_mul,((pickups._95 * 1.1)) * secondary_mul}
		dmg_type = "95"
	elseif tweak_data.weapon[id].stats.damage >= 125 and tweak_data.weapon[id].stats.damage <= 149 then
		tweak_data.weapon[id].stats.damage = 125
		tweak_data.weapon[id].AMMO_PICKUP = {((pickups._125 * 0.9)) * secondary_mul,((pickups._125 * 1.1)) * secondary_mul}
		dmg_type = "105"
	elseif tweak_data.weapon[id].stats.damage >= 150 and tweak_data.weapon[id].stats.damage <= 179 then
		tweak_data.weapon[id].stats.damage = 155
		tweak_data.weapon[id].AMMO_PICKUP = {((pickups._155 * 0.9)) * secondary_mul,((pickups._155 * 1.1)) * secondary_mul}
		dmg_type = "146"
	elseif tweak_data.weapon[id].stats.damage >= 180 and tweak_data.weapon[id].stats.damage <= 264 then
		tweak_data.weapon[id].stats.damage = 200
		tweak_data.weapon[id].AMMO_PICKUP = {((pickups._200 * 0.9)) * secondary_mul,((pickups._200 * 1.1)) * secondary_mul}
		dmg_type = "175"
	elseif tweak_data.weapon[id].stats.damage >= 265 then
		tweak_data.weapon[id].stats.damage = 250
		tweak_data.weapon[id].AMMO_PICKUP = {((pickups._250 * 0.9)) * secondary_mul,((pickups._250 * 1.1)) * secondary_mul}
		dmg_type = "210"
	end
	
	tweak_data.weapon[id].damage_falloff = G_W_M.damage_dropoff.SMGs
	
	if dmg_type == "nil" then
		dmg_type = "super_light"
		local weapon_avg_pickup = G_W_M:get_ammo_pickup(tweak_data.weapon[id].stats.damage)
		tweak_data.weapon[id].AMMO_PICKUP = {(weapon_avg_pickup * 0.9) * secondary_mul,(weapon_avg_pickup * 1.1) * secondary_mul}
	end
	
	-- primary adjust
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
	
	-- akimbo adjust
	local akmb = false
	for i=1, #tweak_data.weapon[id].categories do
		if tweak_data.weapon[id].categories[i] == "akimbo" then
			akmb = true
		end
	end
	if akmb then
		tweak_data.weapon[id].stats.damage = math.ceil(tweak_data.weapon[id].stats.damage / 2)
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
	local recoil_lean = "left"
	if math.fmod(tweak_data.weapon[id].stats.recoil, 2) == 0 then
		recoil_lean = "right"
	end
	G_W_M:set_new_weapon_recoil(G_W_M.recoil_stats.SMGs, id, recoil_lean)
	
end

function Gilza.applyCustomPISTOL_stats(id, isRevolver)

	table.insert(customWeaponsUpdated.Pistols, id)
	
	local G_W_M = Gilza.Weapons_module
	local pickups = G_W_M.ammo_pickups.PISTOLs
	
	local isActuallyRevolver = false
	if tweak_data.weapon[id].stats.damage >= 220 and tweak_data.weapon[id].CLIP_AMMO_MAX <= 6 then
		isActuallyRevolver = true
	end
	if isRevolver then
		isActuallyRevolver = true
	end
	
	local fire_mode = "single"
	if (tweak_data.weapon[id].FIRE_MODE and tweak_data.weapon[id].FIRE_MODE == "auto") or tweak_data.weapon[id].CAN_TOGGLE_FIREMODE then
		fire_mode = "auto"
	end
	
	-- same as with others - dont touch guns with REALLY low damage
	if tweak_data.weapon[id].stats.damage >= 50 and tweak_data.weapon[id].stats.damage <= 69 then
		tweak_data.weapon[id].stats.damage = 88
		local new_rof = 60/650
		if fire_mode == "single" then
			if tweak_data.weapon[id].fire_mode_data then
				tweak_data.weapon[id].fire_mode_data.fire_rate = new_rof
			end
			if tweak_data.weapon[id].single then
				tweak_data.weapon[id].single.fire_rate = new_rof
			end
			if tweak_data.weapon[id].auto then
				tweak_data.weapon[id].auto.fire_rate = new_rof
			end
		else
			if tweak_data.weapon[id].fire_mode_data then
				tweak_data.weapon[id].fire_mode_data.fire_rate = tweak_data.weapon[id].fire_mode_data.fire_rate * 0.75
			end
			if tweak_data.weapon[id].single then
				tweak_data.weapon[id].single.fire_rate = tweak_data.weapon[id].single.fire_rate * 0.75
			end
			if tweak_data.weapon[id].auto then
				tweak_data.weapon[id].auto.fire_rate = tweak_data.weapon[id].auto.fire_rate * 0.75
			end
		end
		tweak_data.weapon[id].AMMO_PICKUP = {((pickups._88 * 0.9)) * secondary_mul,((pickups._88 * 1.1)) * secondary_mul}
	elseif tweak_data.weapon[id].stats.damage >= 70 and tweak_data.weapon[id].stats.damage <= 124 then
		tweak_data.weapon[id].stats.damage = 95
		local new_rof = 60/450
		if fire_mode == "single" then
			if tweak_data.weapon[id].fire_mode_data then
				tweak_data.weapon[id].fire_mode_data.fire_rate = new_rof
			end
			if tweak_data.weapon[id].single then
				tweak_data.weapon[id].single.fire_rate = new_rof
			end
			if tweak_data.weapon[id].auto then
				tweak_data.weapon[id].auto.fire_rate = new_rof
			end
		else
			if tweak_data.weapon[id].fire_mode_data then
				tweak_data.weapon[id].fire_mode_data.fire_rate = tweak_data.weapon[id].fire_mode_data.fire_rate * 0.75
			end
			if tweak_data.weapon[id].single then
				tweak_data.weapon[id].single.fire_rate = tweak_data.weapon[id].single.fire_rate * 0.75
			end
			if tweak_data.weapon[id].auto then
				tweak_data.weapon[id].auto.fire_rate = tweak_data.weapon[id].auto.fire_rate * 0.75
			end
		end
		tweak_data.weapon[id].AMMO_PICKUP = {((pickups._95 * 0.9)) * secondary_mul,((pickups._95 * 1.1)) * secondary_mul}
	elseif tweak_data.weapon[id].stats.damage >= 125 and tweak_data.weapon[id].stats.damage <= 150 then
		tweak_data.weapon[id].stats.damage = 125
		local new_rof = 60/360
		if fire_mode == "auto" then
			new_rof = 60/540
		end
		if tweak_data.weapon[id].fire_mode_data then
			tweak_data.weapon[id].fire_mode_data.fire_rate = new_rof
		end
		if tweak_data.weapon[id].single then
			tweak_data.weapon[id].single.fire_rate = new_rof
		end
		if tweak_data.weapon[id].auto then
			tweak_data.weapon[id].auto.fire_rate = new_rof
		end
		tweak_data.weapon[id].AMMO_PICKUP = {((pickups._125 * 0.9)) * secondary_mul,((pickups._125 * 1.1)) * secondary_mul}
	elseif tweak_data.weapon[id].stats.damage >= 151 and tweak_data.weapon[id].stats.damage <= 219 then
		tweak_data.weapon[id].stats.damage = 155
		local new_rof = 60/330
		if fire_mode == "auto" then
			new_rof = 60/500
		end
		if tweak_data.weapon[id].fire_mode_data then
			tweak_data.weapon[id].fire_mode_data.fire_rate = new_rof
		end
		if tweak_data.weapon[id].single then
			tweak_data.weapon[id].single.fire_rate = new_rof
		end
		if tweak_data.weapon[id].auto then
			tweak_data.weapon[id].auto.fire_rate = new_rof
		end
		tweak_data.weapon[id].AMMO_PICKUP = {((pickups._155 * 0.9)) * secondary_mul,((pickups._155 * 1.1)) * secondary_mul}
	elseif tweak_data.weapon[id].stats.damage >= 220 then
		tweak_data.weapon[id].stats.damage = 250
		local new_rof = 60/300
		if fire_mode == "auto" then
			new_rof = 60/400
		end
		if tweak_data.weapon[id].fire_mode_data then
			tweak_data.weapon[id].fire_mode_data.fire_rate = new_rof
		end
		if tweak_data.weapon[id].single then
			tweak_data.weapon[id].single.fire_rate = new_rof
		end
		if tweak_data.weapon[id].auto then
			tweak_data.weapon[id].auto.fire_rate = new_rof
		end
		tweak_data.weapon[id].AMMO_PICKUP = {((pickups._250 * 0.9)) * secondary_mul,((pickups._250 * 1.1)) * secondary_mul}
	elseif tweak_data.weapon[id].stats.damage >= 300 then
		tweak_data.weapon[id].stats.damage = 450
		local new_rof = 60/240
		if tweak_data.weapon[id].fire_mode_data then
			tweak_data.weapon[id].fire_mode_data.fire_rate = new_rof
		end
		if tweak_data.weapon[id].single then
			tweak_data.weapon[id].single.fire_rate = new_rof
		end
		if tweak_data.weapon[id].auto then
			tweak_data.weapon[id].auto.fire_rate = new_rof
		end
		tweak_data.weapon[id].AMMO_PICKUP = {((pickups._450 * 0.9)) * secondary_mul,((pickups._450 * 1.1)) * secondary_mul}
	end
	
	if isActuallyRevolver then
		tweak_data.weapon[id].stats.damage = 450
		local new_rof = 60/240
		if tweak_data.weapon[id].fire_mode_data then
			tweak_data.weapon[id].fire_mode_data.fire_rate = new_rof
		end
		if tweak_data.weapon[id].single then
			tweak_data.weapon[id].single.fire_rate = new_rof
		end
		if tweak_data.weapon[id].auto then
			tweak_data.weapon[id].auto.fire_rate = new_rof
		end
		tweak_data.weapon[id].AMMO_PICKUP = {((pickups._450 * 0.9)) * secondary_mul,((pickups._450 * 1.1)) * secondary_mul}
	end
	
	if tweak_data.weapon[id].stats.damage < 50 then
		local weapon_avg_pickup = G_W_M:get_ammo_pickup(tweak_data.weapon[id].stats.damage, 0.34)
		if tweak_data.weapon[id].fire_mode_data then
			tweak_data.weapon[id].fire_mode_data.fire_rate = tweak_data.weapon[id].fire_mode_data.fire_rate * 0.75
		end
		if tweak_data.weapon[id].single then
			tweak_data.weapon[id].single.fire_rate = tweak_data.weapon[id].single.fire_rate * 0.75
		end
		if tweak_data.weapon[id].auto then
			tweak_data.weapon[id].auto.fire_rate = tweak_data.weapon[id].auto.fire_rate * 0.75
		end
		tweak_data.weapon[id].AMMO_PICKUP = {(weapon_avg_pickup * 0.9) * secondary_mul,(weapon_avg_pickup * 1.1)} * secondary_mul
	end
	
	tweak_data.weapon[id].damage_falloff = G_W_M.damage_dropoff.PISTOLs
	
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

	-- dont allow for full auto pistols to go over this amount of base stability
	if fire_mode == "auto" and tweak_data.weapon[id].stats.recoil > 16 then
		tweak_data.weapon[id].stats.recoil = 16
	end
	
	local recoil_lean = "left"
	if math.fmod(tweak_data.weapon[id].stats.recoil, 2) == 0 then
		recoil_lean = "right"
	end
	if fire_mode == "auto" then
		G_W_M:set_new_weapon_recoil(G_W_M.recoil_stats.SMGs, id, recoil_lean)
	else
		G_W_M:set_new_weapon_recoil(G_W_M.recoil_stats.PISTOLs, id, recoil_lean)
	end
	
end

function Gilza.applyCustomLMG_stats(id)

	table.insert(customWeaponsUpdated.Light_Machine_guns, id)
	
	local G_W_M = Gilza.Weapons_module
	local pickups = G_W_M.ammo_pickups.LMGs
	
	local dmg_type = "nil"
	
	if tweak_data.weapon[id].stats.damage >= 115 and tweak_data.weapon[id].stats.damage < 144 then
		tweak_data.weapon[id].stats.damage = 125
		tweak_data.weapon[id].AMMO_PICKUP = {(pickups._125 * 0.9),(pickups._125 * 1.1)}
		dmg_type = "105"
	elseif tweak_data.weapon[id].stats.damage >= 145 and tweak_data.weapon[id].stats.damage < 229 then
		tweak_data.weapon[id].stats.damage = 155
		tweak_data.weapon[id].AMMO_PICKUP = {(pickups._155 * 0.9),(pickups._155 * 1.1)}
		dmg_type = "140"
	elseif tweak_data.weapon[id].stats.damage >= 230 then
		tweak_data.weapon[id].stats.damage = 250
		tweak_data.weapon[id].AMMO_PICKUP = {(pickups._250 * 0.9),(pickups._250 * 1.1)}
		dmg_type = "210"
	end
	
	if dmg_type == "nil" then
		dmg_type = "super_light"
		local weapon_avg_pickup = G_W_M:get_ammo_pickup(tweak_data.weapon[id].stats.damage, 0.28, 0.85)
		tweak_data.weapon[id].AMMO_PICKUP = {(weapon_avg_pickup * 0.9),(weapon_avg_pickup * 1.1)}
	end

	tweak_data.weapon[id].damage_falloff = G_W_M.damage_dropoff.LMGs

	-- akimbo or primary
	local primary = true
	if tweak_data.weapon[id].use_data and tweak_data.weapon[id].use_data.selection_index then
		if tweak_data.weapon[id].use_data.selection_index == 1 then
			primary = false
		end
	end
	if not primary then
		tweak_data.weapon[id].AMMO_PICKUP[1] = tweak_data.weapon[id].AMMO_PICKUP[1] * secondary_mul
		tweak_data.weapon[id].AMMO_PICKUP[2] = tweak_data.weapon[id].AMMO_PICKUP[2] * secondary_mul
	end
	
	-- set new recoil
	local recoil_lean = "left"
	if math.fmod(tweak_data.weapon[id].stats.recoil, 2) == 0 then
		recoil_lean = "right"
	end
	G_W_M:set_new_weapon_recoil(G_W_M.recoil_stats.LMGs, id, recoil_lean)
	
end

function Gilza.applyCustomSNIPER_stats(id)

	table.insert(customWeaponsUpdated.Snipers, id)
	
	Gilza.customSnipersToUpdateScopesFor = Gilza.customSnipersToUpdateScopesFor or {}
	table.insert(Gilza.customSnipersToUpdateScopesFor, id)
	
	local G_W_M = Gilza.Weapons_module
	local pickups = G_W_M.ammo_pickups.SNIPERs
	if tweak_data.weapon[id].stats_modifiers then
		if tweak_data.weapon[id].stats_modifiers.damage then
			tweak_data.weapon[id].stats.damage = tweak_data.weapon[id].stats.damage * tweak_data.weapon[id].stats_modifiers.damage
			tweak_data.weapon[id].stats_modifiers.damage = 1
		end
	end
	
	local bolty = false
	local force_semi_auto = false
	local force_lever_action = false
	
	if tweak_data.weapon[id].stats.damage <= 180 then
		force_semi_auto = true
	elseif tweak_data.weapon[id].stats.damage > 180 and tweak_data.weapon[id].stats.damage <= 300 then
		if not tweak_data.weapon[id].use_shotgun_reload then
			if tweak_data.weapon[id].CLIP_AMMO_MAX <= 6 then
				force_lever_action = true
			else
				tweak_data.weapon[id].stats.damage = 1300
				tweak_data.weapon[id].AMMO_PICKUP = {(pickups._1300 * 0.9),(pickups._1300 * 1.1)}
			end
		else
			force_lever_action = true
		end
	elseif tweak_data.weapon[id].stats.damage > 300 and tweak_data.weapon[id].stats.damage < 1200 then
		if tweak_data.weapon[id].CLIP_AMMO_MAX > 6 then
			tweak_data.weapon[id].stats.damage = 1300
			tweak_data.weapon[id].AMMO_PICKUP = {(pickups._1300 * 0.9),(pickups._1300 * 1.1)}
		else
			tweak_data.weapon[id].stats.damage = 1600
			tweak_data.weapon[id].AMMO_PICKUP = {(pickups._1600 * 0.9),(pickups._1600 * 1.1)}
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
		tweak_data.weapon[id].fire_mode_data = {fire_rate = 60/210}
		tweak_data.weapon[id].single = {fire_rate = 60/210}
		tweak_data.weapon[id].stats.damage = 650
		tweak_data.weapon[id].AMMO_PICKUP = {(pickups._650 * 0.9),(pickups._650 * 1.1)}
	elseif force_lever_action then
		tweak_data.weapon[id].stats.damage = 950
		tweak_data.weapon[id].AMMO_PICKUP = {(pickups._950 * 0.9),(pickups._950 * 1.1)}
	end
	
	-- if weapon did not fall under either of 4 categories
	if not bolty and not force_semi_auto and not force_lever_action then
		local dmg = tweak_data.weapon[id].stats.damage
		local weapon_avg_pickup = pickups._1600
		-- if damage is high enough apply dozer buster pickups, otherwise keep it at 1600
		if tweak_data.weapon[id].stats.damage >= 4000 then
			weapon_avg_pickup = math.ceil(24000/dmg) * 0.07
		end
		tweak_data.weapon[id].AMMO_PICKUP = {(weapon_avg_pickup * 0.9),(weapon_avg_pickup * 1.1)}
	end
	
	-- secondary snipers
	if tweak_data.weapon[id].use_data and tweak_data.weapon[id].use_data.selection_index and tweak_data.weapon[id].use_data.selection_index == 1 then
		tweak_data.weapon[id].AMMO_PICKUP[1] = tweak_data.weapon[id].AMMO_PICKUP[1] * secondary_mul
		tweak_data.weapon[id].AMMO_PICKUP[2] = tweak_data.weapon[id].AMMO_PICKUP[2] * secondary_mul
	end
	
	tweak_data.weapon[id].damage_falloff = G_W_M.damage_dropoff.SNIPERs
	
	-- set new recoil
	local recoil_lean = "left"
	if math.fmod(tweak_data.weapon[id].stats.recoil, 2) == 0 then
		recoil_lean = "right"
	end
	G_W_M:set_new_weapon_recoil(G_W_M.recoil_stats.SNIPERs, id, recoil_lean)
	
end

function Gilza.applyCustomSHOTGUN_stats(id)

	table.insert(customWeaponsUpdated.Shotguns, id)
	
	local G_W_M = Gilza.Weapons_module
	local pickups = G_W_M.ammo_pickups.SHOTGUNs
	
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
	
	if not tweak_data.weapon[id].use_shotgun_reload and category > 1 then
		local mag_size = tweak_data.weapon[id].CLIP_AMMO_MAX
		if mag_size > 3 then
			if mag_size > 6 then
				category = 1
			else
				category = 2
			end
		end
	end
	
	if tweak_data.weapon[id].rays < 10 then
		tweak_data.weapon[id].rays = 10
	end
	
	if category == 1 then
		tweak_data.weapon[id].stats.damage = 155
		tweak_data.weapon[id].damage_falloff = G_W_M.damage_dropoff.SHOTGUNs._155
		Gilza.shotgun_minimal_damage_multipliers[id] = 0.35
		if secondary == false then
			tweak_data.weapon[id].AMMO_PICKUP = {(pickups._155 * 0.9),(pickups._155 * 1.1)}
		else
			tweak_data.weapon[id].AMMO_PICKUP = {(pickups._155 * 0.9) * secondary_mul,(pickups._155 * 1.1) * secondary_mul}
		end
	elseif category == 2 then
		tweak_data.weapon[id].stats.damage = 325
		tweak_data.weapon[id].damage_falloff = G_W_M.damage_dropoff.SHOTGUNs._325
		Gilza.shotgun_minimal_damage_multipliers[id] = 0.5
		if secondary == false then
			tweak_data.weapon[id].AMMO_PICKUP = {(pickups._325 * 0.9),(pickups._325 * 1.1)}
		else
			tweak_data.weapon[id].AMMO_PICKUP = {(pickups._325 * 0.9) * secondary_mul,(pickups._325 * 1.1) * secondary_mul}
		end
	elseif category == 3 then
		tweak_data.weapon[id].stats.damage = 450
		tweak_data.weapon[id].damage_falloff = G_W_M.damage_dropoff.SHOTGUNs._450
		Gilza.shotgun_minimal_damage_multipliers[id] = 0.67
		if secondary == false then
			tweak_data.weapon[id].AMMO_PICKUP = {(pickups._450 * 0.9),(pickups._450 * 1.1)}
		else
			tweak_data.weapon[id].AMMO_PICKUP = {((pickups._450 * 0.9)) * secondary_mul,((pickups._450 * 1.1)) * secondary_mul}
		end
	elseif category == 4 then
		tweak_data.weapon[id].stats.damage = 900
		tweak_data.weapon[id].damage_falloff = G_W_M.damage_dropoff.SHOTGUNs._900
		Gilza.shotgun_minimal_damage_multipliers[id] = 1
		if secondary == false then
			tweak_data.weapon[id].AMMO_PICKUP = {(pickups._900 * 0.9),(pickups._900 * 1.1)}
		else
			tweak_data.weapon[id].AMMO_PICKUP = {((pickups._900 * 0.9)) * secondary_mul,((pickups._900 * 1.1)) * secondary_mul}
		end
	elseif category == 5 then
		local weapon_avg_pickup = G_W_M:get_ammo_pickup(tweak_data.weapon[id].stats.damage, 1, 0.55)
		if secondary == false then
			tweak_data.weapon[id].AMMO_PICKUP = {(weapon_avg_pickup * 0.9),(weapon_avg_pickup * 1.1)}
		else
			tweak_data.weapon[id].AMMO_PICKUP = {(weapon_avg_pickup * 0.9) * secondary_mul,(weapon_avg_pickup * 1.1)} * secondary_mul
		end
	end
	
	-- shothun ammo. dear god.
	local HE_custom_stats = {
		ignore_statistic = true,
		damage_far_mul = 1,
		damage_near_mul = 1,
		bullet_class = "InstantExplosiveBulletBase",
		rays = 1,
		ammo_pickup_max_mul = 0.6,
		ammo_pickup_min_mul = 0.6
	}
	local FAHEstats = {
		value = 5,
		total_ammo_mod = -6.66,
		damage = 186,
		recoil = -8
	}
	local SAHEstats = {
		value = 5,
		total_ammo_mod = -6.66,
		damage = 400,
		recoil = -8
	}
	local PAHEstats = {
		value = 5,
		total_ammo_mod = -6.66,
		damage = 550,
		recoil = -8
	}
	local DBHEstats = {
		value = 5,
		total_ammo_mod = -6.66,
		damage = 1050,
		recoil = -8
	}
	local ultraHEstats = {
		value = 5,
		total_ammo_mod = -6.66,
		damage = tweak_data.weapon[id].stats.damage * 1.1,
		recoil = -8
	}
	
	local BS_custom_stats = {
		damage_far_mul = 0.75,
		damage_near_mul = 0.75,
		armor_piercing_add = 1,
		ammo_pickup_max_mul = 0.9,
		ammo_pickup_min_mul = 0.9,
		is_buckshot = true,
		rays = 12
	}
	local FABS_stats = {
		total_ammo_mod = 5,
		damage = 155
	}
	local SABS_stats = {
		total_ammo_mod = 5,
		damage = 325
	}
	local PABS_stats = {
		total_ammo_mod = 5,
		damage = 450
	}
	local DBBS_stats = {
		total_ammo_mod = 5,
		damage = 900
	}
	local ultraBS_stats = {
		total_ammo_mod = 5,
		damage = tweak_data.weapon[id].stats.damage
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
		tweak_data.weapon.factory[wpn_factory_id].override.wpn_fps_upg_a_explosive = {stats = ultraHEstats,custom_stats = HE_custom_stats}
		tweak_data.weapon.factory[wpn_factory_id].override.wpn_fps_upg_a_custom = {stats = ultraBS_stats,custom_stats = BS_custom_stats}
		tweak_data.weapon.factory[wpn_factory_id].override.wpn_fps_upg_a_custom_free = {stats = ultraBS_stats,custom_stats = BS_custom_stats}
	end
	
	-- set new recoil
	local recoil_lean = "left"
	if math.fmod(tweak_data.weapon[id].stats.recoil, 2) == 0 then
		recoil_lean = "right"
	end
	G_W_M:set_new_weapon_recoil(G_W_M.recoil_stats.SHOTGUNs, id, recoil_lean)
	
end

function Gilza.applyCustomMELEE_stats()
	for melee, stats in pairs(tweak_data.blackmarket.melee_weapons) do
		if table.contains (Gilza.default_melee_weapons, melee) then
			-- default weapon, dont do anything
		else
			table.insert(customWeaponsUpdated.Melee, melee)
			if stats.repeat_expire_t <= 0.35 then
				tweak_data.blackmarket.melee_weapons[melee].stats.min_damage = 2
				tweak_data.blackmarket.melee_weapons[melee].stats.max_damage = 5
				tweak_data.blackmarket.melee_weapons[melee].stats.min_damage_effect = 7
				tweak_data.blackmarket.melee_weapons[melee].stats.max_damage_effect = 7
			elseif stats.repeat_expire_t <= 0.65 then
				tweak_data.blackmarket.melee_weapons[melee].stats.min_damage = 2.5
				tweak_data.blackmarket.melee_weapons[melee].stats.max_damage = 7
				tweak_data.blackmarket.melee_weapons[melee].stats.min_damage_effect = 7
				tweak_data.blackmarket.melee_weapons[melee].stats.max_damage_effect = 7
			elseif stats.repeat_expire_t <= 1 then
				tweak_data.blackmarket.melee_weapons[melee].stats.min_damage = 3.5
				tweak_data.blackmarket.melee_weapons[melee].stats.max_damage = 9
				tweak_data.blackmarket.melee_weapons[melee].stats.min_damage_effect = 7
				tweak_data.blackmarket.melee_weapons[melee].stats.max_damage_effect = 7
			elseif stats.repeat_expire_t > 1 then
				if stats.melee_damage_delay <= 0.35 then
					tweak_data.blackmarket.melee_weapons[melee].stats.min_damage = 5
					tweak_data.blackmarket.melee_weapons[melee].stats.max_damage = 14
					tweak_data.blackmarket.melee_weapons[melee].stats.min_damage_effect = 7
					tweak_data.blackmarket.melee_weapons[melee].stats.max_damage_effect = 7
				elseif stats.melee_damage_delay > 0.35 then
					tweak_data.blackmarket.melee_weapons[melee].stats.min_damage = 7.5
					tweak_data.blackmarket.melee_weapons[melee].stats.max_damage = 25
					tweak_data.blackmarket.melee_weapons[melee].stats.min_damage_effect = 7
					tweak_data.blackmarket.melee_weapons[melee].stats.max_damage_effect = 7
				end
			end
			local additional_wpn_range = tweak_data.blackmarket.melee_weapons[melee].stats.range - 150
			if additional_wpn_range >= 5 then
				local knock = (math.clamp(additional_wpn_range/5, 1, 24)) * 0.25
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
-- if recoil needs adjustments, it can be reapplied with the weapon module func
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
	
	local secondary_mul = 0.7
	local secondary_to_primary_mul = 1/secondary_mul
	local G_W_M = Gilza.Weapons_module
	local pickupsAR = G_W_M.ammo_pickups.ARs
	local pickupsGL = G_W_M.ammo_pickups.GLs
	local pickupsSMG = G_W_M.ammo_pickups.SMGs
	
	-- https://modworkshop.net/mod/52553 M4 Liberator
	if tweak_data.weapon.liberator then
		tweak_data.weapon.liberator.stats.concealment = 9
	end
	
	-- https://modworkshop.net/mod/23676 HK G3A3 HK79
	if tweak_data.weapon.g3hk79 then
		tweak_data.weapon.g3hk79.stats.damage = 250
		tweak_data.weapon.g3hk79.AMMO_PICKUP = {(pickupsAR._250 * 0.9) * 0.7,(pickupsAR._250 * 1.1) * 0.7}
		tweak_data.weapon.g3hk79.NR_CLIPS_MAX = 5
		tweak_data.weapon.g3hk79.AMMO_MAX = tweak_data.weapon.g3hk79.CLIP_AMMO_MAX * tweak_data.weapon.g3hk79.NR_CLIPS_MAX
		tweak_data.weapon.g3hk79.stats.recoil = 4
		G_W_M:set_new_weapon_recoil(G_W_M.recoil_stats.ARs, "g3hk79", "right")
		-- add inherited 2 round burst desciption from g3
		LocalizationManager:add_localized_strings({bm_w_g3hk79_desc = managers.localization:text("bm_w_g3_desc")})
	end
	
	-- https://modworkshop.net/mod/35608 DT MDRX 7.62x51mm
	if tweak_data.weapon.mdr_308 then
		tweak_data.weapon.mdr_308.FIRE_MODE = "auto"
		tweak_data.weapon.mdr_308.stats.damage = 155
		tweak_data.weapon.mdr_308.AMMO_PICKUP = {(pickupsAR._155 * 0.9) * 0.7,(pickupsAR._155 * 1.1) * 0.7}
		tweak_data.weapon.mdr_308.NR_CLIPS_MAX = 6
		tweak_data.weapon.mdr_308.AMMO_MAX = tweak_data.weapon.mdr_308.CLIP_AMMO_MAX * tweak_data.weapon.mdr_308.NR_CLIPS_MAX
		tweak_data.weapon.mdr_308.stats.spread = 16
		tweak_data.weapon.mdr_308.stats.recoil = 12
		tweak_data.weapon.mdr_308.fire_mode_data = {fire_rate = 60/680}
		tweak_data.weapon.mdr_308.auto = {fire_rate = 60/680}
		tweak_data.weapon.mdr_308.HAS_BURST_AS_THIRD = false
		G_W_M:set_new_weapon_recoil(G_W_M.recoil_stats.ARs, "mdr_308", "right")
		-- UGL
		tweak_data.weapon.mdr_308_underbarrel.NR_CLIPS_MAX = 2
		tweak_data.weapon.mdr_308_underbarrel.AMMO_MAX = tweak_data.weapon.mdr_308_underbarrel.CLIP_AMMO_MAX * tweak_data.weapon.mdr_308_underbarrel.NR_CLIPS_MAX
		tweak_data.weapon.mdr_308_underbarrel.AMMO_PICKUP = {(pickupsGL._underbarrel * 0.9),(pickupsGL._underbarrel * 1.1)}
		tweak_data.weapon.factory.parts.wpn_fps_ass_mdr_308_barrel_sniper.override_weapon_multiply.fire_mode_data.fire_rate = 2
		tweak_data.weapon.factory.parts.wpn_fps_ass_mdr_308_snp_am.custom_stats.ammo_pickup_max_mul = G_W_M:get_pickup_adjusments_for_wpn_mod("AR", 155, 450, true).max_mul
		tweak_data.weapon.factory.parts.wpn_fps_ass_mdr_308_snp_am.custom_stats.ammo_pickup_min_mul = G_W_M:get_pickup_adjusments_for_wpn_mod("AR", 155, 450, true).min_mul
	end
	
	-- https://modworkshop.net/mod/37996 M4A1 Grenadier
	if tweak_data.weapon.kurisumasu then
		tweak_data.weapon.kurisumasu.AMMO_PICKUP = {(pickupsAR._125 * 0.9) * 0.7,(pickupsAR._125 * 1.1) * 0.7}
		tweak_data.weapon.kurisumasu.NR_CLIPS_MAX = 5
		tweak_data.weapon.kurisumasu.AMMO_MAX = tweak_data.weapon.kurisumasu.CLIP_AMMO_MAX * tweak_data.weapon.kurisumasu.NR_CLIPS_MAX
		tweak_data.weapon.kurisumasu.stats.spread = 11
		tweak_data.weapon.kurisumasu.stats.recoil = 18
		G_W_M:set_new_weapon_recoil(G_W_M.recoil_stats.ARs, "kurisumasu", "right")
		LocalizationManager:add_localized_strings({bm_w_kurisumasu_desc = managers.localization:text("bm_w_m16_desc")})
	end
	
	-- https://modworkshop.net/mod/51546 Payday 3 Tribune 32
	if tweak_data.weapon.tribune32 then
		tweak_data.weapon.tribune32.stats.damage = 155
		tweak_data.weapon.tribune32.AMMO_PICKUP = {(pickupsSMG._155 * 0.9) * secondary_mul,(pickupsSMG._155 * 1.1) * secondary_mul}
		tweak_data.weapon.tribune32.stats.recoil = 19
		G_W_M:set_new_weapon_recoil(G_W_M.recoil_stats.SMGs, "tribune32", "right")
		tweak_data.weapon.tribune32.stats.reload = 9
		-- akimbos
		tweak_data.weapon.x_tribune32.stats.damage = 78
		tweak_data.weapon.x_tribune32.AMMO_PICKUP = {(pickupsSMG._155 * 0.9) * 2,(pickupsSMG._155 * 1.1) * 2}
		tweak_data.weapon.x_tribune32.AMMO_PICKUP[1] = tweak_data.weapon.tribune32.AMMO_PICKUP[1] * secondary_to_primary_mul * 2
		tweak_data.weapon.x_tribune32.AMMO_PICKUP[2] = tweak_data.weapon.tribune32.AMMO_PICKUP[2] * secondary_to_primary_mul * 2
		tweak_data.weapon.x_tribune32.NR_CLIPS_MAX = 2.25
		tweak_data.weapon.x_tribune32.AMMO_MAX = tweak_data.weapon.x_tribune32.CLIP_AMMO_MAX * tweak_data.weapon.x_tribune32.NR_CLIPS_MAX
		tweak_data.weapon.x_tribune32.stats.recoil = 19
		G_W_M:set_new_weapon_recoil(G_W_M.recoil_stats.SMGs, "x_tribune32", "right")
	end
	
	-- https://modworkshop.net/mod/17368 L115
	if tweak_data.weapon.l115 then
		tweak_data.weapon.l115.NR_CLIPS_MAX = 5
		tweak_data.weapon.l115.AMMO_MAX = tweak_data.weapon.l115.CLIP_AMMO_MAX * tweak_data.weapon.l115.NR_CLIPS_MAX
	end
	
	-- https://modworkshop.net/mod/42220 MW2022 Marlin Model 336
	if tweak_data.weapon.sbeta then
		tweak_data.weapon.sbeta.NR_CLIPS_MAX = 5
		tweak_data.weapon.sbeta.AMMO_MAX = tweak_data.weapon.sbeta.CLIP_AMMO_MAX * tweak_data.weapon.sbeta.NR_CLIPS_MAX
		tweak_data.weapon.sbeta.fire_mode_data = {fire_rate = 60/85}
		tweak_data.weapon.sbeta.single = {fire_rate = 60/85}
		tweak_data.weapon.sbeta.stats.recoil = 13
		G_W_M:set_new_weapon_recoil(G_W_M.recoil_stats.SMGs, "sbeta", "right")
		tweak_data.weapon.sbeta.stats.reload = 14
	end
	
	-- https://modworkshop.net/mod/17243 SKS
	if tweak_data.weapon.sks then
		tweak_data.weapon.sks.NR_CLIPS_MAX = 11
		tweak_data.weapon.sks.AMMO_MAX = tweak_data.weapon.sks.CLIP_AMMO_MAX * tweak_data.weapon.sks.NR_CLIPS_MAX
		tweak_data.weapon.sks.fire_mode_data = {fire_rate = 60/390}
		tweak_data.weapon.sks.single = {fire_rate = 60/390}
		tweak_data.weapon.sks.stats.spread = 18
		tweak_data.weapon.sks.stats.recoil = 11
		tweak_data.weapon.sks.stats.concealment = 20
		G_W_M:set_new_weapon_recoil(G_W_M.recoil_stats.ARs, "sks", "left")
	end
	
	-- https://modworkshop.net/mod/42438 MW2022 S&W Model 500
	if tweak_data.weapon.swhiskey then
		tweak_data.weapon.swhiskey.NR_CLIPS_MAX = 7
		tweak_data.weapon.swhiskey.AMMO_MAX = tweak_data.weapon.swhiskey.CLIP_AMMO_MAX * tweak_data.weapon.swhiskey.NR_CLIPS_MAX
		tweak_data.weapon.swhiskey.stats.spread = 19
		G_W_M:set_new_weapon_recoil(G_W_M.recoil_stats.ARs, "sks", "left")
		tweak_data.weapon.factory.parts.wpn_fps_pis_swhiskey_am_piercing.custom_stats.ammo_pickup_max_mul = 0.5
		tweak_data.weapon.factory.parts.wpn_fps_pis_swhiskey_am_snakeshot.custom_stats.ammo_pickup_max_mul = 1.3235294117647
		tweak_data.weapon.factory.parts.wpn_fps_pis_swhiskey_am_snakeshot.custom_stats.ammo_pickup_min_mul = 1.3235294117647
		tweak_data.weapon.factory.parts.wpn_fps_pis_swhiskey_am_snakeshot.custom_stats.falloff_override = {optimal_distance = 0, optimal_range = 1000, near_falloff = 0, far_falloff = 900, near_mul = 1, far_mul = 0.5, _meta = "falloff_override"}
		Gilza.shotgun_minimal_damage_multipliers.swhiskey = 0.67
	end
	
end

function Gilza.checkforweapontweaks()
	if tweak_data and tweak_data.weapon then
		Gilza.initCutsomGuns()
	else
		-- if we dont have tweak_data yet, wait for it
		DelayedCalls:Add("Gilza_wpntweaks", 0.15, function()
			Gilza.checkforweapontweaks()
		end)
	end
end
Gilza.checkforweapontweaks()