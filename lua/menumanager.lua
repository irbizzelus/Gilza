if not Gilza then
	dofile("mods/Gilza/lua/wpntweaks.lua")
end

function Gilza:changelog_message()
	DelayedCalls:Add("Gilza_showchangelogmsg_delayed", 1, function()
		if not Gilza.customguns.version or Gilza.customguns.version < 1.8 then
			local menu_options = {}
			menu_options[#menu_options+1] ={text = "Check full changelog", data = nil, callback = Gilza_linkchangelog}
			menu_options[#menu_options+1] = {text = "Cancel", is_cancel_button = true}
			local message = "1.8 changelog:\n- Some skill/perk changes\n- 5.56 conversion kit for 7.62 Little friend AR\n- Major changes to accuracy and recoil systems\n- HUGE amount of rebalances for ALL AR's, SMG's, LMG's, Snipers, Pistols, some shotguns and some specials"
			local menu = QuickMenu:new("Gilza", message, menu_options)
			menu:Show()
			
			-- reset anyone on version 1.5, if they were unforunate enough to have it
			if Gilza.customguns.version and Gilza.customguns.version == 1.5 then
				managers.skilltree:reset_specializations()
			end
			
			Gilza.customguns.version = 1.8
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