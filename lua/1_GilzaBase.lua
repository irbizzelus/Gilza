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
		designated_marksman_zoom = 2,
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
	intimidated_enemies = {}
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

function Gilza:changelog_message()
	local function Gilza_linkchangelog()
		managers.network.account:overlay_activate("url", "https://github.com/irbizzelus/Gilza/releases")
	end
	DelayedCalls:Add("Gilza_showchangelogmsg_delayed", 1, function()
		if not Gilza.settings.version or Gilza.settings.version < 2.7 then
			local menu_options = {}
			menu_options[#menu_options+1] ={text = "Check full changelog", data = nil, callback = Gilza_linkchangelog}
			menu_options[#menu_options+1] = {text = "Cancel", is_cancel_button = true}
			local message = "2.7 Changelog:\n\nBig patch, big patch notes. It's recommended you read the full notes, as this menu is too small for this patch.\nNotable changes:\n- Compatibility with update 246\n- Complete bipod deploy system rework\n- Major LMG rebalance\n- Armor now affects ammo pick up rates\n- Updated 7 skills\n- Updated 6 perks, with Bralwer getting major changes\n- New melee charge tilt QOL option\n- A bunch of weapon stat updates\n- Various fixes"
			local menu = QuickMenu:new("Gilza", message, menu_options)
			menu:Show()
			Gilza.settings.version = 2.7
			Gilza.Save()
		end
	end)
end

dofile(Gilza._path.."lua/2_New_Gilza_Skills_Informer.lua")