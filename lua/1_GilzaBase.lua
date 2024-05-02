if Gilza then
	return
end

_G.Gilza = {
	_path = "mods/Gilza/",
	_save_path = "mods/saves/Gilza_save.txt",
	settings = {
		v_fov = 90,
		shotgun_skill_notification = true,
		flash_color_R = 255,
		flash_color_G = 0,
		flash_color_B = 0,
		flash_type = 1,
		flash_trigger = 2,
		flash_size = 1
	},
	grenade_multipliers = {
		dada_com = 0.9,
		fir_com = 0.7,
		frag_com = 0.9,
		wpn_prj_ace = 2.5,
		concussion = 0.5,
		poison_gas_grenade = 0.8,
		frag = 0.9,
		molotov = 1,
		dynamite = 0.9,
		wpn_prj_four = 1.1,
		wpn_prj_jav = 0.5,
		wpn_prj_target = 0.8,
		wpn_prj_hur = 1.4,
		sticky_grenade = 1.1,
		wpn_gre_electric = 1,
	},
	shotgun_minimal_damage_multipliers = {},
	current_shotgun_shot_id = 0
}

function Gilza:Save()
	local file = io.open(Gilza._save_path, 'w+')
	if file then
		file:write(json.encode(Gilza.settings))
		file:close()
	end
end

function Gilza:Load()
	local file = io.open(Gilza._save_path, 'r')
	if file then
		for i, v in pairs(json.decode(file:read('*all')) or {}) do
			Gilza.settings[i] = v
		end
		file:close()
	end
end

Gilza:Load()
Gilza:Save()

function Gilza:modCompatibility()
	for _, mod in pairs(BeardLib.Mods) do
		if mod.Name == "WeaponLib" then
			if mod.AssetUpdates.version == "1.7.5" then
				Gilza.isWeaponLibBroken = true
				log("[Gilza] Found broken version of weaponlib, shotgun damage change applied.")
			elseif mod.AssetUpdates.version ~= "1.7.5" then
				log("[Gilza] Found possibly unbroken version of weaponlib. If version is higher then 1.7.5, update Gilza to get rid of this log notification. Current weaponlib version: "..tostring(mod.AssetUpdates.version))
			end
		elseif mod.Name == "Bipods That (Actually) Work" then
			Gilza.BTAW_enabled = true
		end
	end
end
Gilza:modCompatibility()

function Gilza:changelog_message()
	local function Gilza_linkchangelog()
		managers.network.account:overlay_activate("url", "https://github.com/irbizzelus/Gilza/releases")
	end
	DelayedCalls:Add("Gilza_showchangelogmsg_delayed", 1, function()
		if not Gilza.settings.version or Gilza.settings.version < 2.02 then
			local menu_options = {}
			menu_options[#menu_options+1] ={text = "Check full changelog", data = nil, callback = Gilza_linkchangelog}
			menu_options[#menu_options+1] = {text = "Cancel", is_cancel_button = true}
			local message = "2.0.20 changelog:\n\nThis patch includes a few fixes, melee blackmarket UI improvements and a few balance changes. For detailed information check full changelog. Most important bits:\n - Trigger happy skill nerfed\n - Akron HC LMG's conversion kit no longer accepts FrenchyAU's stocks - remove them to prevent a crash\n - Melee efficiency against dozers and bosses was nerfed\n - Viper launcher grenade - poison duration reduced"
			local menu = QuickMenu:new("Gilza", message, menu_options)
			menu:Show()
			Gilza.settings.version = 2.02
			Gilza.Save()
		end
	end)
end