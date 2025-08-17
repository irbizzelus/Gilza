if Gilza then
	return
end

_G.Gilza = {
	_path = ModPath,
	_save_path = "mods/saves/Gilza_save.txt",
	settings = {
		v_fov = 90,
		blackmarket_weapon_sorting = 2,
		shotgun_skill_notification = true,
		menace_points_notification = true,
		designated_marksman_zoom = 2,
		melee_gui = 4,
		flash_color_R = 255,
		flash_color_G = 0,
		flash_color_B = 0,
		flash_type = 1,
		flash_trigger = 2,
		flash_size = 1,
		spoof_custom_perks = true,
		junkie_icon_scale = 1,
		junkie_icon_x_pos = 50,
		junkie_icon_y_pos = 320,
		single_fire_input_buffering = true,
		-- VHUD STUFF
		vhud_compat_new_melee_zerk = false,
		vhud_compat_new_weapon_zerk = true,
		vhud_compat_stockholm_menace = true,
		vhud_compat_body_economy = true,
		vhud_compat_fearmonger_speed = true,
		vhud_compat_electric_bullets = true,
		vhud_compat_dire_need_override = false,
		vhud_compat_revitalized = true,
		vhud_compat_unseen_strike_override = true,
		vhud_compat_new_lock_n_load = true,
		vhud_compat_total_dmg_resist = true,
		vhud_compat_total_dmg_absorb = true,
		vhud_compat_total_dodge = true,
		vhud_compat_new_hitman_recovery = true,
		vhud_compat_new_trigger_happy = true,
	},
	grenade_multipliers = {
		dada_com = 0.9,
		fir_com = 0.4,
		frag_com = 0.9,
		wpn_prj_ace = 2,
		concussion = 0.45,
		poison_gas_grenade = 0.3,
		frag = 0.9,
		molotov = 1,
		dynamite = 0.9,
		wpn_prj_four = 1.1,
		wpn_prj_jav = 0.5,
		wpn_prj_target = 1.25,
		wpn_prj_hur = 0.8,
		sticky_grenade = 1.1,
		wpn_gre_electric = 1.1,
	},
	shotgun_minimal_damage_multipliers = {},
	current_shotgun_shot_id = 0,
	weapon_shot_id = 0,
	intimidated_enemies = {}
}

-- settings file management, using gilza.settings list
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
			if mod.AssetUpdates.version then
				if type(mod.AssetUpdates.version) == "string" then
					local num_ver_str = string.gsub(mod.AssetUpdates.version,'%.','')
					if tonumber(num_ver_str) and tonumber(num_ver_str) <= 175 then
						Gilza.isWeaponLibBroken = true
						log("[Gilza] Found broken version of weaponlib, shotgun damage change applied.")
					else
						log("[Gilza] Found possibly unbroken version of weaponlib. If version is higher then 1.7.5, update Gilza to get rid of this log notification. Current weaponlib version: "..tostring(mod.AssetUpdates.version))
					end
				end
			end
		end
	end
	-- based on folder name
	for i, mod in pairs(BLT.FindMods(BLT)) do
		if mod.id == "Bipods That Work" then
			Gilza.BTAW_enabled = true
		elseif mod.id == "VanillaHUD Plus" then
			Gilza.VHP_enabled = true
		elseif mod.id == "AFSF2" then
			local afsf = BLT.Mods:GetModByName("Auto-Fire Sound Fix")
			if afsf then
				afsf:SetEnabled(false, true)
				Gilza.AFSF_force_disabled = true
			end
		end
	end
	-- based on mod.txt name
	if BLT.Mods:GetModByName("Bipods That (Actually) Work") then
		Gilza.BTAW_enabled = true
	end
	if BLT.Mods:GetModByName("VanillaHUDPlus") then
		Gilza.VHP_enabled = true
	end
	if BLT.Mods:GetModByName("Auto-Fire Sound Fix") then
		local afsf = BLT.Mods:GetModByName("Auto-Fire Sound Fix")
		if afsf then
			afsf:SetEnabled(false, true)
			Gilza.AFSF_force_disabled = true
		end
	end
end
Gilza:modCompatibility()

function Gilza:changelog_message()
	local function Gilza_linkchangelog()
		managers.network.account:overlay_activate("url", "https://github.com/irbizzelus/Gilza/releases")
	end
	DelayedCalls:Add("Gilza_showchangelogmsg_delayed", 1, function()
		if not Gilza.settings.version or Gilza.settings.version < 2.5 then
			local menu_options = {}
			menu_options[#menu_options+1] ={text = "Check full changelog", data = nil, callback = Gilza_linkchangelog}
			menu_options[#menu_options+1] = {text = "Cancel", is_cancel_button = true}
			local message = "2.5 changelog:\n\nThis update required a full game restart.\n\nThis patch is focused on perks, and introduces, both minor and major, reworks to almost every perk in the game. This update also includes some new skills and updates to allready existing skills. Weapons now have 20 point innacuracy in full-auto fire mode instead of 28, and a bunch of minor adjustments to weapons and their attachments were added. Added support for VanillaHUD+.\n\nFor additional information go to the full changelog."
			local menu = QuickMenu:new("Gilza", message, menu_options)
			menu:Show()
			Gilza.settings.version = 2.5
			Gilza.Save()
		end
	end)
end

dofile(Gilza._path.."lua/2_New_Gilza_Skills_Informer.lua")