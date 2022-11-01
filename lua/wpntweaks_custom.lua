--[[
################# HOW TO ADD CUSTOM GUNS TO GILZA MOD#########################

Currently supported weapon types: Assault rifles.

This procedure needs to be only done once: after you boot the game, your id's will be saved in a seperate save file, so future mod updates don't remove your custom weapons id's
If you want to add your beloved custom weapons to this mod, you will have to go to the mod folder of that weapon, most likely in assets/mod_overrides.

Once you get there, go to main.xml file, and search for "<weapon " (without "", they are used here to show the empty space after the tag)
This is a starting tag with all the values this weapon has. You will have to find weapon's ID
Most likely it will look something like this:

<weapon id="m200" based_on="model70" weapon_hold="m200" .... etc

Get that id, and put it bellow into Gilza's customguns variable under weapons, and you are done! Don't forget about proper syntax though

Syntax:
 - every id should be within "" like this: "m200"
 - after every id there should be a coma like this: "m200",

If you are unsure: after you got your custom gun's id, and put it into the variable bellow, it should look like this:

Gilza.customguns ={
	weapons = {
		"ak12",
		"bulldoge",
		"mcx_spear",
		"m200",
	},
	melee = {
		--placeholder
	}
}

################## IF YOUR GAME IS CRASHING OR DOESNT PROPERLY UPDATE VALUES FOR WEAPONS CHECK IF YOUR SYNTAX IS CORRECT #####################
]]

-- write your ID's here
Gilza.customguns ={
	weapons = {
		"ak12",
		"bulldoge",
		"mcx_spear",
	},
	melee = {
		--placeholder
	}
}

function Gilza:Save_gunz()
	local file = io.open(Gilza._guns_path, 'w+')
	if file then
		file:write(json.encode(Gilza.customguns))
		file:close()
	end
end

function Gilza:Load_gunz()
	local file = io.open(Gilza._guns_path, 'r')
	if file then
		for i, v in pairs(json.decode(file:read('*all')) or {}) do
			Gilza.customguns[i] = v
		end
		file:close()
	end
end

Gilza:Load_gunz()
Gilza:Save_gunz()

function Gilza.initCutsomGuns()
	for _, gun in pairs(Gilza.customguns.weapons) do
		if tweak_data.weapon[gun] then
		
			-- AR check
			for i=1, #tweak_data.weapon[gun].categories do
				if tweak_data.weapon[gun].categories[i] == "assault_rifle" then
					tweak_data.weapon[gun].stats.damage = math.floor(tweak_data.weapon[gun].stats.damage * 1.75)
					Gilza.applyCustomAR_stats(gun)
				end
			end
			
			-- More to do later
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

function Gilza.applyCustomAR_stats(id)
	-- adjust damage profiles and ammo pick up based on weapons damage (after dmg increase in the init function above)
	
	-- if AR has lower then 100 dmg, dont apply any changes to dmg or pick up, considering that the range of breakpoints down there is way to big, let normal stats work
	
	-- light AR's
	if tweak_data.weapon[id].stats.damage >= 100 and tweak_data.weapon[id].stats.damage <= 125 then
		tweak_data.weapon[id].stats.damage = 117
		tweak_data.weapon[id].AMMO_PICKUP = {4.9,7.64}
		
	-- low mid AR's
	elseif tweak_data.weapon[id].stats.damage >= 126 and tweak_data.weapon[id].stats.damage <= 146 then
		tweak_data.weapon[id].stats.damage = 146
		tweak_data.weapon[id].AMMO_PICKUP = {3.98,6.48}
		
	-- high mid AR's
	elseif tweak_data.weapon[id].stats.damage >= 147 and tweak_data.weapon[id].stats.damage <= 200 then
		tweak_data.weapon[id].AMMO_PICKUP = {4.22,6.88}
		
	-- heavy AR's
	elseif tweak_data.weapon[id].stats.damage >= 201 and tweak_data.weapon[id].stats.damage <= 350 then
		tweak_data.weapon[id].stats.damage = 210
		tweak_data.weapon[id].AMMO_PICKUP = {1.97,3.54}
		
	-- super heavy AR's
	elseif tweak_data.weapon[id].stats.damage >= 351 then
		tweak_data.weapon[id].stats.damage = 420
		tweak_data.weapon[id].AMMO_PICKUP = {0.75,1.59}
	end
end