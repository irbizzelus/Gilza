if Gilza then
	return
end

_G.Gilza = {
	_path = ModPath,
	_save_path = "mods/saves/Gilza_save.txt",
	settings = {
		v_fov = 90,
		shotgun_skill_notification = true,
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
	},
	grenade_multipliers = {
		dada_com = 0.9,
		fir_com = 0.6,
		frag_com = 0.9,
		wpn_prj_ace = 2.5,
		concussion = 0.5,
		poison_gas_grenade = 0.66,
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
		end
	end
	for i, mod in pairs(BLT.FindMods(BLT)) do
		if mod.id == "Bipods That Work" then
			Gilza.BTAW_enabled = true
		elseif mod.id == "VanillaHUD Plus" then
			Gilza.VHP_enabled = true
			-- add our skills to vanila hud's buff list so that it stops screaming about unknown effects in the logs
			local function tryaddingbuffs()
				if GameInfoManager and GameInfoManager._BUFFS and GameInfoManager._BUFFS.temporary then
					GameInfoManager._BUFFS.temporary.player_new_hitman_regen = "player_new_hitman_regen"
					GameInfoManager._BUFFS.temporary.player_dodge_armor_regen = "player_dodge_armor_regen"
					GameInfoManager._BUFFS.temporary.player_speed_junkie_armor_on_dodge = "player_speed_junkie_armor_on_dodge"
					GameInfoManager._BUFFS.temporary.speed_boost_on_panic_kill = "speed_boost_on_panic_kill"
					GameInfoManager._BUFFS.temporary.tased_electric_bullets = "tased_electric_bullets"
					GameInfoManager._BUFFS.temporary.new_berserk_melee_damage_multiplier_1 = "new_berserk_melee_damage_multiplier_1"
					GameInfoManager._BUFFS.temporary.new_berserk_melee_damage_multiplier_2 = "new_berserk_melee_damage_multiplier_2"
					GameInfoManager._BUFFS.temporary.new_berserk_weapon_damage_multiplier = "new_berserk_weapon_damage_multiplier"
				else
					DelayedCalls:Add("Gilza_wait_for_vhp_to_load", 0.25, function()
						tryaddingbuffs()
					end)
				end
			end
			tryaddingbuffs()
		end
	end
end
Gilza:modCompatibility()

function Gilza:changelog_message()
	local function Gilza_linkchangelog()
		managers.network.account:overlay_activate("url", "https://github.com/irbizzelus/Gilza/releases")
	end
	DelayedCalls:Add("Gilza_showchangelogmsg_delayed", 1, function()
		if not Gilza.settings.version or Gilza.settings.version < 2.3 then
			local menu_options = {}
			menu_options[#menu_options+1] ={text = "Check full changelog", data = nil, callback = Gilza_linkchangelog}
			menu_options[#menu_options+1] = {text = "Cancel", is_cancel_button = true}
			local message = "2.3 changelog:\n\nThis patch is BIG, and has a heavy focus on perks and skills:\n- New Custom Perk added: Speed Junkie.\n- Updated perks: Brawler (full rework), Yakuza, Hitman, Hacker, Tag Team, Gambler.\n- Updated skills in the Ghost's Artful Dodger sub-tree with skills that add new functionality.\n- Other updated skills: Berserk, Counterstrike, Shotgun Expert, Bloodthirst.\n- All skill/perk grenade pick ups were reduced by 20%.\n\nIn addition to all the perk and skill rebalances mentioned above a few fixes and QOL updates were added, such as ability to spoof custom perk decks (to avoid being kicked), ability to reset your perk decks (without loosing perk points), and new melee GUI to make using melee weapons better and easier. A few weapon balance updates and fixes are also included. Reading full changelog is recommended. GL HF!"
			local menu = QuickMenu:new("Gilza", message, menu_options)
			menu:Show()
			Gilza.settings.version = 2.3
			Gilza.Save()
		end
	end)
end