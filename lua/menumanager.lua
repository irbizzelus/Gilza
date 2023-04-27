if not Gilza then
	dofile("mods/Gilza/lua/wpntweaks.lua")
end

function Gilza:changelog_message()
	DelayedCalls:Add("Gilza_showchangelogmsg_delayed", 1, function()
		if not Gilza.customguns.version or Gilza.customguns.version < 1.711 then
			local menu_options = {}
			menu_options[#menu_options+1] ={text = "Check full changelog", data = nil, callback = Gilza_linkchangelog}
			menu_options[#menu_options+1] = {text = "Cancel", is_cancel_button = true}
			local message = "1.7.11 changelog:\n- Reduced accuracy for Deimos shotgun (still better then in vanilla)\n- Increased base visual recoil for Deimos shotgun\n- Deimos shotgun semi-auto fire mode recoil is now 1.5 times worse(was 2x)\n- Deimos shotgun semi-auto fire mode accuracy is now 3 times worse(was the same)\n\nFor more info on new weapon handling and new DLC weapon stats check the changelog (scroll down to update 1.7.1)."
			local menu = QuickMenu:new("Gilza", message, menu_options)
			menu:Show()
			
			-- reset anyone on version 1.5, if they were unforunate enough to have it
			if Gilza.customguns.version and Gilza.customguns.version == 1.5 then
				managers.skilltree:reset_specializations()
			end
			
			Gilza.customguns.version = 1.711
			Gilza.Save_gunz()
		end
	end)
end

function Gilza_linkchangelog()
	Steam:overlay_activate("url", "https://github.com/irbizzelus/Gilza/releases/latest")
end

Hooks:PostHook(MenuManager, "_node_selected", "Gilza_changelog", function(self, menu_name, node)
	if type(node) == "table" and node._parameters.name == "main" then
		Gilza.changelog_message()
	end
end)