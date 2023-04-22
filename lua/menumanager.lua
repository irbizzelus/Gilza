if not Gilza then
	dofile("mods/Gilza/lua/wpntweaks.lua")
end

function Gilza:changelog_message()
	DelayedCalls:Add("Gilza_showchangelogmsg_delayed", 1, function()
		if not Gilza.customguns.version or Gilza.customguns.version < 1.7 then
			local menu_options = {}
			menu_options[#menu_options+1] ={text = "Check full changelog", data = nil, callback = Gilza_linkchangelog}
			menu_options[#menu_options+1] = {text = "Cancel", is_cancel_button = true}
			local message = "1.7 changelog:\nBiggest patch yet, all changes can not be fit here, please check all the changes on modworkshop.net\nTLDR:\n- Fixes to skills and weapon values, including some melee's\n- New pistol skills, body expertise nerf\n- New stability/recoil system for most full-auto weapons\n- Shotgun ammo rework\n- Support for custom pistols and SMG's\n- A lot of weapon stat tweaks"
			local menu = QuickMenu:new("Gilza", message, menu_options)
			menu:Show()
			
			-- reset anyone on version 1.5, if they were unforunate enough to have it
			if Gilza.customguns.version and Gilza.customguns.version == 1.5 then
				managers.skilltree:reset_specializations()
			end
			
			Gilza.customguns.version = 1.7
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