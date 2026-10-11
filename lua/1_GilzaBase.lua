if Gilza then
	return
end

_G.Gilza = {
	_path = ModPath,
	_save_path = "mods/saves/Gilza_save.txt",
	files_loaded = {},
	settings = {
		v_fov = 90,
		blackmarket_weapon_sorting = 2,
		shotgun_skill_notification = true,
		menace_points_notification = true,
		melee_charge_tilt = 3,
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
		melee_toggle_mode_icon_scale = 1,
		melee_toggle_mode_icon_x_pos = 30,
		melee_toggle_mode_icon_y_pos = 380,
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
		vhud_compat_new_sicario = true,
		vhud_compat_new_aced_running_from_death = true,
		vhud_compat_offhand_reload = true,
		vhud_compat_new_aced_shotgunCQB = true,
	},
	grenade_multipliers = {
		dada_com = 33,
		fir_com = 35,
		frag_com = 33,
		wpn_prj_ace = 99,
		concussion = 40,
		poison_gas_grenade = 55,
		frag = 33,
		molotov = 30,
		dynamite = 33,
		wpn_prj_four = 99,
		wpn_prj_jav = 99,
		wpn_prj_target = 33,
		wpn_prj_hur = 99,
		sticky_grenade = 30,
		wpn_gre_electric = 25,
		laser_watch = 30,
	},
	shotgun_minimal_damage_multipliers = {},
	current_shotgun_shot_id = 0,
	weapon_shot_id = 0,
	zoomleveloffset = {[1] = 0, [2] = 0},
	intimidated_enemies = {},
	customWeaponFactoryIDs = {}
}

-- Add a posthook to beardlib's WeaponModule init to grab factory ids of custom weapons directly from the source,
-- because they are needed during factory tweak data load. Normaly you can get factory id from normal id only after upgradestweak file is loaded,
-- but since its loaded after factorytweaks, we cant use that function, so we do this arguably cursed workaround.
WeaponModule = WeaponModule or BeardLib:ModuleClass("Weapon", ItemModuleBase)
Hooks:PostHook(WeaponModule, "RegisterHook", "Gilza_post_beardlib_RegisterHook", function(self)
	Gilza.customWeaponFactoryIDs = Gilza.customWeaponFactoryIDs or {}
	if self._config and self._config.weapon and self._config.weapon.id and not Gilza.customWeaponFactoryIDs[self._config.weapon.id] then
		local fac_id = ("wpn_fps_"..self._config.weapon.id)
		if self._config.factory and self._config.factory.id then
			fac_id = self._config.factory.id
		end
		Gilza.customWeaponFactoryIDs[self._config.weapon.id] = fac_id
	end
end)

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
	-- beardlib mods
	for _, mod in pairs(BeardLib.Mods) do
		if mod.Name == "WeaponLib" then
			if mod.AssetUpdates.version then
				if type(mod.AssetUpdates.version) == "string" then
					local num_ver_str = string.gsub(mod.AssetUpdates.version,'%.','')
					if tonumber(num_ver_str) and tonumber(num_ver_str) <= 176 then
						Gilza.isWeaponLibBroken = true
						log("[Gilza] Found broken version of weaponlib, shotgun damage change applied.")
					else
						log("[Gilza] Found possibly unbroken version of weaponlib. If version is higher then 1.7.6, update Gilza to get rid of this log notification. Current weaponlib version: "..tostring(mod.AssetUpdates.version))
					end
				end
			end
		end
	end
	-- BLT mods
	local LMG_STEELSIGHTS = BLT.Mods:GetModByName("LMG Steelsights v0.64") or BLT.Mods:GetMod("Steelsights")
	if LMG_STEELSIGHTS and LMG_STEELSIGHTS._enabled then
		Gilza.LMG_STEELSIGHTS_enabled = true
	end
	local BTW = BLT.Mods:GetModByName("Bipods That (Actually) Work") or BLT.Mods:GetMod("Bipods That Work")
	if BTW and BTW._enabled then
		Gilza.BTAW_enabled = true
	end
	local VHUD = BLT.Mods:GetModByName("VanillaHUDPlus") or BLT.Mods:GetMod("VanillaHUD Plus")
	if VHUD and VHUD._enabled then
		Gilza.VHP_enabled = true
	end
	local AFSF = BLT.Mods:GetModByName("Auto-Fire Sound Fix") or BLT.Mods:GetMod("Auto-Fire Sound Fix")
	if AFSF then
		AFSF:SetEnabled(false, true)
		Gilza.AFSF_force_disabled = true
	end
end
Gilza:modCompatibility()

function Gilza:first_time_user_message()
	DelayedCalls:Add("Gilza_show_newbie_welcome_msg__delayed", 0.8, function()
		if not Gilza.settings.first_time_user_message_shown then
			local menu_options = {}
			menu_options[#menu_options+1] = {text = "Ok", is_cancel_button = true}
			local header = managers.localization:text("menu_Gilza_newbie_welcome_header")
			local message = managers.localization:text("menu_Gilza_newbie_welcome")
			local menu = QuickMenu:new(header, message, menu_options)
			menu:Show()
			Gilza.settings.first_time_user_message_shown = true
			Gilza.Save()
		end
	end)
end

function Gilza:changelog_message()
	local function Gilza_linkchangelog()
		managers.network.account:overlay_activate("url", "https://github.com/irbizzelus/Gilza/releases")
	end
	DelayedCalls:Add("Gilza_showchangelogmsg_delayed", 1, function()
		if not Gilza.settings.version or Gilza.settings.version < 2.82 then
			local menu_options = {}
			menu_options[#menu_options+1] ={text = "Check full changelog", data = nil, callback = Gilza_linkchangelog}
			menu_options[#menu_options+1] = {text = "Cancel", is_cancel_button = true}
			local message = "2.8.2 Changelog:\n\nThis update includes a few skill updates, most of them being minor, a lot of localization updates, and a couple of fixes. Notable not-so-minor skill updates:\n- Designated marksman now allows to tweak weapon zoom level on the fly in-game using custom keybinds.\n- Overkill aced now allows for all weapons to gain bonuses from shotgun-specific skills while active.\n-Fully Loaded aced now provides bulletstorm effect for 1 second every time an ammo pack is picked up."
			local menu = QuickMenu:new("Gilza", message, menu_options)
			menu:Show()
			Gilza.settings.version = 2.82
			Gilza.Save()
		end
	end)
end

dofile(Gilza._path.."lua/2_New_Gilza_Skills_Informer.lua")