if not Gilza then
	dofile("mods/Gilza/lua/wpntweaks.lua")
end

function Gilza:changelog_message()
	DelayedCalls:Add("Gilza_showchangelogmsg_delayed", 1, function()
		if not Gilza.customguns.version or Gilza.customguns.version < 1.52 then
			local menu_options = {}
			menu_options[#menu_options+1] ={text = "Check full changelog", data = nil, callback = Gilza_linkchangelog}
			menu_options[#menu_options+1] = {text = "Cancel", is_cancel_button = true}
			local message = "1.5.2 update changelog:\n- Fixed broomstick ammo pick while using the AP kit\n- Fixed custom weapons not saving properly\n- Rebalances to all AR's, SMG's and Pistols. More info in the changelog."
			local menu = QuickMenu:new("Gilza", message, menu_options)
			menu:Show()
			-- reset anyone on version 1.5, if they are unforunate enough to have it
			if Gilza.customguns.version and Gilza.customguns.version == 1.5 then
				managers.skilltree:reset_specializations()
			end
			
			Gilza.customguns.version = 1.52
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