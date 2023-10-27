if not Gilza then
	dofile("mods/Gilza/lua/wpntweaks.lua")
end

function Gilza:changelog_message()
	DelayedCalls:Add("Gilza_showchangelogmsg_delayed", 1, function()
		if not Gilza.settings.version or Gilza.settings.version < 1.863 then
			local menu_options = {}
			menu_options[#menu_options+1] ={text = "Check full changelog", data = nil, callback = Gilza_linkchangelog}
			menu_options[#menu_options+1] = {text = "Cancel", is_cancel_button = true}
			local message = "1.8.63 changelog:\n- U240.2 compatilibty."
			local menu = QuickMenu:new("Gilza", message, menu_options)
			menu:Show()
			Gilza.settings.version = 1.863
			Gilza.Save()
		end
	end)
end

function Gilza_linkchangelog()
	managers.network.account:overlay_activate("url", "https://github.com/irbizzelus/Gilza/releases/latest")
end

Hooks:PostHook(MenuManager, "_node_selected", "Gilza_changelog", function(self, menu_name, node)
	if type(node) == "table" and node._parameters.name == "main" then
		Gilza.changelog_message()
	end
end)

Hooks:Add('MenuManagerInitialize', 'Gilza_init', function(menu_manager)
	MenuCallbackHandler.Gilza_save = function(this, item)
		Gilza:Save()
	end
	
	MenuCallbackHandler.Gilza_donothing = function(this, item)
		-- warm, primordial blackness
	end

	MenuCallbackHandler.Gilza_v_fov = function(this, item)
		Gilza.settings.v_fov = tonumber(item:value())
		Gilza:Save()
		
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
	
	MenuCallbackHandler.Gilza_flash_trigger = function(this, item)
		Gilza.settings.flash_trigger = tonumber(item:value())
		Gilza:Save()
	end
	
	MenuCallbackHandler.Gilza_flash_type = function(this, item)
		Gilza.settings.flash_type = tonumber(item:value())
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
	
	MenuCallbackHandler.Gilza_page = function(this, item)
		managers.network.account:overlay_activate("url", "https://modworkshop.net/mod/39854")
	end

	Gilza:Load()

	MenuHelper:LoadFromJsonFile(Gilza._path .. 'menus/Gilza_menu.txt', Gilza, Gilza.settings)
end)