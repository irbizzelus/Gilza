if not Gilza then
	dofile("mods/Gilza/lua/1_GilzaBase.lua")
end

Hooks:PostHook(MenuManager, "_node_selected", "Gilza_patch_notification", function(self, menu_name, node)
	if type(node) == "table" and node._parameters.name == "main" then
		Gilza:changelog_message()
	end
end)

Hooks:Add('MenuManagerInitialize', 'Gilza_init_menu', function(menu_manager)
	MenuCallbackHandler.Gilza_save = function(this, item)
		Gilza:Save()
	end
	
	MenuCallbackHandler.Gilza_donothing = function(this, item)
		-- warm, primordial blackness
	end

	MenuCallbackHandler.Gilza_v_fov = function(this, item)
		Gilza.settings.v_fov = tonumber(item:value())
		Gilza:Save()
		if tweak_data and tweak_data.vehicle then
			tweak_data.vehicle.falcogini.fov = tonumber(item:value())
			tweak_data.vehicle.muscle.fov = tonumber(item:value())
			tweak_data.vehicle.forklift.fov = tonumber(item:value())
			tweak_data.vehicle.forklift_2.fov = tonumber(item:value())
			tweak_data.vehicle.box_truck_1.fov = tonumber(item:value())
			tweak_data.vehicle.boat_rib_1.fov = tonumber(item:value())
			tweak_data.vehicle.mower_1.fov = tonumber(item:value())
			tweak_data.vehicle.blackhawk_1.fov = tonumber(item:value())
			tweak_data.vehicle.bike_1.fov = tonumber(item:value())
			tweak_data.vehicle.bike_2.fov = tonumber(item:value())
			tweak_data.vehicle.wanker.fov = tonumber(item:value())	
			tweak_data.vehicle.golfcart.fov = tonumber(item:value())
		end
	end
	
	MenuCallbackHandler.Gilza_melee_gui = function(this, item)
		Gilza.settings.melee_gui = tonumber(item:value())
		Gilza:Save()
	end
	
	MenuCallbackHandler.Gilza_shotgun_skill_notification = function(this, item)
		Gilza.settings.shotgun_skill_notification = item:value() == 'on'
		Gilza:Save()
	end
	
	MenuCallbackHandler.Gilza_perk_reset = function(this, item)
		local function Gilza_reset_perk_progression()
			managers.skilltree:reset_specializations()
			log("[Gilza] Perk Decks reset.")
		end
		
		local menu_options = {}
		menu_options[#menu_options+1] ={text = managers.localization:text("menu_Gilza_perk_reset_confirm"), data = nil, callback = Gilza_reset_perk_progression}
		menu_options[#menu_options+1] = {text = managers.localization:text("menu_Gilza_perk_reset_deny"), is_cancel_button = true}
		local menu = QuickMenu:new("Gilza", managers.localization:text("menu_Gilza_perk_reset_text"), menu_options)
		menu:Show()
	end
	
	MenuCallbackHandler.Gilza_spoof_custom_perks = function(this, item)
		Gilza.settings.spoof_custom_perks = item:value() == 'on'
		Gilza:Save()
	end
	
	MenuCallbackHandler.Gilza_flash_trigger = function(this, item)
		Gilza.settings.flash_trigger = tonumber(item:value())
		Gilza:Save()
	end
	
	MenuCallbackHandler.Gilza_flash_type = function(this, item)
		Gilza.settings.flash_type = tonumber(item:value())
		Gilza:Save()
	end
	
	MenuCallbackHandler.Gilza_flash_size = function(this, item)
		Gilza.settings.flash_size = tonumber(item:value())
		Gilza:Save()
	end
	
	MenuCallbackHandler.Gilza_flash_color_R = function(this, item)
		Gilza.settings.flash_color_R = tonumber(item:value())
		Gilza:Save()
	end
	
	MenuCallbackHandler.Gilza_flash_color_G = function(this, item)
		Gilza.settings.flash_color_G = tonumber(item:value())
		Gilza:Save()
	end
	
	MenuCallbackHandler.Gilza_flash_color_B = function(this, item)
		Gilza.settings.flash_color_B = tonumber(item:value())
		Gilza:Save()
	end
	
	MenuCallbackHandler.Gilza_junkie_icon_scale = function(this, item)
		Gilza.settings.junkie_icon_scale = tonumber(item:value())
		Gilza:Save()
		if not managers.hud or not managers.hud:script(PlayerBase.PLAYER_INFO_HUD_PD2) then
			return
		end
		local hud = managers.hud:script(PlayerBase.PLAYER_INFO_HUD_PD2)
		if hud.panel:child("Gilza_speed_junkie_GUI_icon") and hud.panel:child("Gilza_speed_junkie_GUI_counter") then
			local Gilza_junkie_icon_GUI = hud.panel:child("Gilza_speed_junkie_GUI_icon")
			local Gilza_junkie_counter_GUI = hud.panel:child("Gilza_speed_junkie_GUI_counter")
			Gilza_junkie_icon_GUI:set_w(Gilza.settings.junkie_icon_scale * 60)
			Gilza_junkie_counter_GUI:set_w(Gilza.settings.junkie_icon_scale * 60)
			Gilza_junkie_icon_GUI:set_h(Gilza.settings.junkie_icon_scale * 60)
			Gilza_junkie_counter_GUI:set_h(Gilza.settings.junkie_icon_scale * 60)
			Gilza_junkie_counter_GUI:set_font_size(math.floor(24 * Gilza.settings.junkie_icon_scale))
			Gilza_junkie_counter_GUI:set_y(60 * Gilza.settings.junkie_icon_scale + Gilza.settings.junkie_icon_y_pos)
			-- an extremely dumb hack that gains access to the panel on a class level to force background text to update properly
			-- idk why but both font size and set_w/h dont update background text parameters if main text is updated in vhp
			-- i could obviously fix it up by tweaking those funcs, but im trying to make this compatible with the mod,
			-- so in case user runs vhp with gilza, vhp's class is used instead of a copy of said class that gilza has
			local panel_class_access = managers.player._Gilza_junkie_counter_GUI
			for _, bg in ipairs(panel_class_access._bgs) do
				if bg.set_w and bg.set_h then
					bg:set_w(Gilza.settings.junkie_icon_scale * 60)
					bg:set_h(Gilza.settings.junkie_icon_scale * 60)
				end
				if bg.set_font_size then
					bg:set_font_size(math.floor(24 * Gilza.settings.junkie_icon_scale))
				end
			end
			
		end	
	end
	
	MenuCallbackHandler.Gilza_junkie_icon_x_pos = function(this, item)
		Gilza.settings.junkie_icon_x_pos = tonumber(item:value())
		Gilza:Save()
		if not managers.hud or not managers.hud:script(PlayerBase.PLAYER_INFO_HUD_PD2) then
			return
		end
		local hud = managers.hud:script(PlayerBase.PLAYER_INFO_HUD_PD2)
		if hud.panel:child("Gilza_speed_junkie_GUI_icon") and hud.panel:child("Gilza_speed_junkie_GUI_counter") then
			local Gilza_junkie_icon_GUI = hud.panel:child("Gilza_speed_junkie_GUI_icon")
			local Gilza_junkie_counter_GUI = hud.panel:child("Gilza_speed_junkie_GUI_counter")
			Gilza_junkie_icon_GUI:set_x(Gilza.settings.junkie_icon_x_pos)
			Gilza_junkie_counter_GUI:set_x(Gilza.settings.junkie_icon_x_pos)
		end	
	end
	
	MenuCallbackHandler.Gilza_junkie_icon_y_pos = function(this, item)
		Gilza.settings.junkie_icon_y_pos = tonumber(item:value())
		Gilza:Save()
		if not managers.hud or not managers.hud:script(PlayerBase.PLAYER_INFO_HUD_PD2) then
			return
		end
		local hud = managers.hud:script(PlayerBase.PLAYER_INFO_HUD_PD2)
		if hud.panel:child("Gilza_speed_junkie_GUI_icon") and hud.panel:child("Gilza_speed_junkie_GUI_counter") then
			local Gilza_junkie_icon_GUI = hud.panel:child("Gilza_speed_junkie_GUI_icon")
			local Gilza_junkie_counter_GUI = hud.panel:child("Gilza_speed_junkie_GUI_counter")
			Gilza_junkie_icon_GUI:set_y(Gilza.settings.junkie_icon_y_pos)
			Gilza_junkie_counter_GUI:set_y(60 * Gilza.settings.junkie_icon_scale + Gilza.settings.junkie_icon_y_pos)
		end	
	end
	
	MenuCallbackHandler.Gilza_MWS_page = function(this, item)
		managers.network.account:overlay_activate("url", "https://modworkshop.net/mod/39854")
	end
	
	MenuCallbackHandler.Gilza_Weapons_page = function(this, item)
		managers.network.account:overlay_activate("url", "https://github.com/irbizzelus/random-noncode-stuff/blob/main/Gilza%20txts/Weapons.md")
	end
	
	MenuCallbackHandler.Gilza_patch_notes = function(this, item)
		managers.network.account:overlay_activate("url", "https://github.com/irbizzelus/Gilza/releases")
	end

	Gilza:Load()

	MenuHelper:LoadFromJsonFile(Gilza._path .. 'menus/Gilza_menu.txt', Gilza, Gilza.settings)
end)