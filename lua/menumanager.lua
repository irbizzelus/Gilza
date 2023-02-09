if not Gilza then
	dofile("mods/Gilza/lua/wpntweaks.lua")
end

function Gilza:changelog_message()
	DelayedCalls:Add("Gilza_showchangelogmsg_delayed", 1, function()
		if not Gilza.customguns.version or Gilza.customguns.version < 1.54 then
			local menu_options = {}
			menu_options[#menu_options+1] ={text = "Check full changelog", data = nil, callback = Gilza_linkchangelog}
			menu_options[#menu_options+1] = {text = "Cancel", is_cancel_button = true}
			local message = "1.5.4 update changelog:\n- Fixed issues with ap kits on AK platforms, KS12, Gewehr 3\n- Fixed damage values on heavy bows/crossbows\n- Added McShay weapon pack 3 support\n\nPlease sell any purchased Akron HC lmg's to avoid freezes when trying to modify them."
			local menu = QuickMenu:new("Gilza", message, menu_options)
			menu:Show()
			
			-- reset anyone on version 1.5, if they were unforunate enough to have it
			if Gilza.customguns.version and Gilza.customguns.version == 1.5 then
				managers.skilltree:reset_specializations()
			end
			
			Gilza.customguns.version = 1.54
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