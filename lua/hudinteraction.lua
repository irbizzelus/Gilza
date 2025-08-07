-- this file is used to set up new melee UI
if not Gilza then
	dofile("mods/Gilza/lua/1_GilzaBase.lua")
end

local function create_OutlinedText_class()
	OutlinedText = OutlinedText or class()

	function OutlinedText:init(panel, params)
		self._name = params.name
		self._parent = panel
		self._outlines_disabled = false

		self._text = panel:text(params)
		self._bgs = {}

		local bg_params = deep_clone(params)
		bg_params.name = nil
		bg_params.color = Color.black:with_alpha(0.5)
		bg_params.layer = self._text:layer() - 1
		for i = 1, 4 do
			bg_params.name = string.format("bg_%d", i)
			self._bgs[i] = panel:text(bg_params)
		end

		self:_update_positions()
	end

	function OutlinedText:set_outlines_visible(status)
		if self._outlines_disabled ~= not status then
			self._outlines_disabled = not status
			self:_update_visibility()
		end
	end

	function OutlinedText:set_outlines_color(color)
		if color then
			self:_call_func_bgs("set_color", color:with_alpha(0.5))
		end
	end

	function OutlinedText:remove()
		self._parent:remove(self._text)
		for _, bg in pairs(self._bgs) do
			self._parent:remove(bg)
		end
	end

	function OutlinedText:x() return self._text:x() end
	function OutlinedText:y() return self._text:y() end
	function OutlinedText:w() return self._text:w() end
	function OutlinedText:h() return self._text:h() end
	function OutlinedText:center() return self._text:center() end
	function OutlinedText:center_x() return self._text:center_x() end
	function OutlinedText:center_y() return self._text:center_y() end
	function OutlinedText:text() return self._text:text() end
	function OutlinedText:font() return self._text:font() end
	function OutlinedText:font_size() return self._text:font_size() end
	function OutlinedText:visible() return self._text:visible() end
	function OutlinedText:color() return self._text:color() end
	function OutlinedText:alpha() return self._text:alpha() end

	function OutlinedText:set_x(...) return self:_call_func_text("set_x", ...) end
	function OutlinedText:set_y(...) return self:_call_func_text("set_y", ...) end
	function OutlinedText:set_w(...) return self:_call_func_text("set_w", ...) end
	function OutlinedText:set_h(...) return self:_call_func_text("set_h", ...) end
	function OutlinedText:set_center(...) return self:_call_func_text("set_center", ...) end
	function OutlinedText:set_center_x(...) return self:_call_func_text("set_center_x", ...) end
	function OutlinedText:set_center_y(...) return self:_call_func_text("set_center_y", ...) end
	function OutlinedText:set_text(...) return self:_call_func_all("set_text", ...) end
	function OutlinedText:set_font(...) return self:_call_func_all("set_font", ...) end
	function OutlinedText:set_font_size(...) return self:_call_func_all("set_font_size", ...) end
	function OutlinedText:set_visible(...) return self:_call_func_text("set_visible", ...) end
	function OutlinedText:show(...) return self:_call_func_text("show", ...) end
	function OutlinedText:hide(...) return self:_call_func_text("hide", ...) end
	function OutlinedText:set_color(...) return self:_call_func_text("set_color", ...) end
	function OutlinedText:set_alpha(...) return self:_call_func_all("set_alpha", ...) end
	function OutlinedText:animate(...) return self:_call_func_text("animate", ...) end
	function OutlinedText:stop(...) return self:_call_func_text("stop", ...) end

	function OutlinedText:_call_func_all(func, ...)
		local results
		if self._text[func] then
			results = { self._text[func](self._text, ...) }
		end

		self:_call_func_bgs(func, ...)

		return unpack(results or {})
	end

	function OutlinedText:_call_func_text(func, ...)
		local results
		if self._text[func] then
			results = { self._text[func](self._text, ...) }
		end

		self:_update_visibility()
		self:_update_positions()

		return unpack(results or {})
	end

	function OutlinedText:_call_func_bgs(func, ...)
		for _, bg in ipairs(self._bgs) do
			if bg[func] then
				bg[func](bg, ...)
			end
		end

		self:_update_visibility()
		self:_update_positions()
	end

	function OutlinedText:_update_positions()
		local x, y = self._text:x(), self._text:y()
		self._bgs[1]:set_x(x - 1)
		self._bgs[1]:set_y(y - 1)
		self._bgs[2]:set_x(x + 1)
		self._bgs[2]:set_y(y - 1)
		self._bgs[3]:set_x(x - 1)
		self._bgs[3]:set_y(y + 1)
		self._bgs[4]:set_x(x + 1)
		self._bgs[4]:set_y(y + 1)
	end

	function OutlinedText:_update_visibility()
		for _, bg in pairs(self._bgs) do
			bg:set_visible(not self._outlines_disabled and self._text:visible())
		end
	end
end

-- melee hud element is taken from vanila hud plus so only add this class if VHP is not installed
if Gilza and not Gilza.VHP_enabled then
	create_OutlinedText_class()
end

local orig_show_interaction_bar = HUDInteraction.show_interaction_bar
Hooks:OverrideFunction(HUDInteraction, "show_interaction_bar", function (self, current, total)
	local circlesetting = false
	local damagesetting = false
	if Gilza and Gilza.settings and Gilza.settings.melee_gui and Gilza.settings.melee_gui >= 1 then
		if Gilza.settings.melee_gui == 2 then
			circlesetting = true
		elseif Gilza.settings.melee_gui == 3 then
			damagesetting = true
		elseif Gilza.settings.melee_gui == 4 then
			circlesetting = true
			damagesetting = true
		end
	end
	if managers.player.player_unit and managers.player:player_unit() and alive(managers.player:player_unit()) and managers.player:player_unit().movement and managers.player:player_unit():movement()._state_data and managers.player:player_unit():movement()._state_data.meleeing then
		if circlesetting then
			orig_show_interaction_bar(self, current, total)
		else
			self.hide_interaction_bar(self)
		end
		if damagesetting then
			if Gilza.VHP_enabled then
				-- this should disable the timer counter for melee interaction in vhp, but due to the way vhp function override works, i can only properly do it for the update func
				-- this leads to vhp users who have interaction timer enabled having 1 frame where interaction timer is still on screen, as well as the Gilza's damage counter
				-- after that the update func properly removes vhp's interaction timer. this sucks, but i cant do anything about it, so i just hope that not a lot of people run that option in vhp
				HUDInteraction.SHOW_TIME_REMAINING = false
			end
			if not self._Gilza_melee_damage then
				self._Gilza_melee_damage = OutlinedText:new(self._hud_panel, {
					name = "melee_damage",
					visible = false,
					text = "",
					valign = "center",
					align = "center",
					layer = 2,
					color = Color(1, 1, 1, 1),
					font = tweak_data.menu.pd2_large_font,
					font_size = 24,
					h = 64
				})
			else
				self._Gilza_melee_damage:set_font_size(24)
			end
			
			local min_dmg = tweak_data.blackmarket.melee_weapons[managers.blackmarket:equipped_melee_weapon()].stats.min_damage or 1
			if managers.player:player_unit():movement()._state_data.chainsaw_t then
				min_dmg = (tweak_data.blackmarket.melee_weapons[managers.blackmarket:equipped_melee_weapon()].stats.tick_damage or 1) * 5 -- DPS, becuase all chainsaw wpns have 5 ticks/s
			end
			local dmg_multiplier = 1
			
			if managers.player:has_category_upgrade("temporary", "new_berserk_melee_damage_multiplier_2") then
				dmg_multiplier = dmg_multiplier * managers.player:temporary_upgrade_value("temporary", "new_berserk_melee_damage_multiplier_2", 1)
			elseif managers.player:has_category_upgrade("temporary", "new_berserk_melee_damage_multiplier_1") then
				dmg_multiplier = dmg_multiplier * managers.player:temporary_upgrade_value("temporary", "new_berserk_melee_damage_multiplier_1", 1)
			end
			dmg_multiplier = dmg_multiplier + managers.player:upgrade_value("player", "melee_damage_newzerk_addin", 0)
			dmg_multiplier = dmg_multiplier * managers.player:get_melee_dmg_multiplier()
			if managers.player:has_category_upgrade("melee", "stacking_hit_damage_multiplier") then
				local statedata = managers.player:player_unit():movement()._state_data
				statedata.stacking_dmg_mul = statedata.stacking_dmg_mul or {}
				statedata.stacking_dmg_mul.melee = statedata.stacking_dmg_mul.melee or {nil,0}
				local stack = statedata.stacking_dmg_mul and statedata.stacking_dmg_mul.melee
				if stack[1] and managers.player:player_timer():time() < stack[1] then
					dmg_multiplier = dmg_multiplier * (1 + managers.player:upgrade_value("melee", "stacking_hit_damage_multiplier", 0) * stack[2])
				end
			end
			
			min_dmg = min_dmg * dmg_multiplier
			
			local text = string.format("%.0f%%", min_dmg*10)
			if managers.player:player_unit():movement()._state_data.chainsaw_t then
				text = string.format("%.0f%% DPS", min_dmg*10)
			end
			self._Gilza_melee_damage:set_y(self._hud_panel:center_y() + self._circle_radius - (1.5 * self._Gilza_melee_damage:font_size()))
			self._Gilza_melee_damage:set_text(text)
			self._Gilza_melee_damage:set_outlines_visible(true)
			self._Gilza_melee_damage:show()
		end
	else
		orig_show_interaction_bar(self, current, total)
	end
end)

local orig_set_interaction_bar_width = HUDInteraction.set_interaction_bar_width
Hooks:OverrideFunction(HUDInteraction, "set_interaction_bar_width", function (self, current, total)
	local circlesetting = false
	local damagesetting = false
	if Gilza and Gilza.settings and Gilza.settings.melee_gui and Gilza.settings.melee_gui >= 1 then
		if Gilza.settings.melee_gui == 2 then
			circlesetting = true
		elseif Gilza.settings.melee_gui == 3 then
			damagesetting = true
		elseif Gilza.settings.melee_gui == 4 then
			circlesetting = true
			damagesetting = true
		end
	end
	if managers.player.player_unit and managers.player:player_unit() and alive(managers.player:player_unit()) and managers.player:player_unit().movement and managers.player:player_unit():movement()._state_data and managers.player:player_unit():movement()._state_data.meleeing then
		if circlesetting then
			orig_set_interaction_bar_width(self, current, total)
		else
			self.hide_interaction_bar(self)
		end
		if damagesetting then
			if Gilza.VHP_enabled and self._interact_time then
				self._interact_time:set_text("")
				self._interact_time:set_visible(false)
				HUDInteraction.SHOW_TIME_REMAINING = false
			end
			local min_dmg = tweak_data.blackmarket.melee_weapons[managers.blackmarket:equipped_melee_weapon()].stats.min_damage or 1
			local max_dmg = tweak_data.blackmarket.melee_weapons[managers.blackmarket:equipped_melee_weapon()].stats.max_damage or 1
			if managers.player:player_unit():movement()._state_data.chainsaw_t then
				min_dmg = (tweak_data.blackmarket.melee_weapons[managers.blackmarket:equipped_melee_weapon()].stats.tick_damage or 1) * 5 -- DPS, becuase all chainsaw wpns have 5 ticks/s
				max_dmg = (tweak_data.blackmarket.melee_weapons[managers.blackmarket:equipped_melee_weapon()].stats.tick_damage or 1) * 5
			end
			local cur_charge_percent = current/total
			local cur_dmg = min_dmg + ((max_dmg-min_dmg) * cur_charge_percent)
			local dmg_multiplier = 1
			
			if managers.player:has_category_upgrade("temporary", "new_berserk_melee_damage_multiplier_2") then
				dmg_multiplier = dmg_multiplier * managers.player:temporary_upgrade_value("temporary", "new_berserk_melee_damage_multiplier_2", 1)
			elseif managers.player:has_category_upgrade("temporary", "new_berserk_melee_damage_multiplier_1") then
				dmg_multiplier = dmg_multiplier * managers.player:temporary_upgrade_value("temporary", "new_berserk_melee_damage_multiplier_1", 1)
			end
			dmg_multiplier = dmg_multiplier + managers.player:upgrade_value("player", "melee_damage_newzerk_addin", 0)
			dmg_multiplier = dmg_multiplier * managers.player:get_melee_dmg_multiplier()
			if managers.player:has_category_upgrade("melee", "stacking_hit_damage_multiplier") then
				local statedata = managers.player:player_unit():movement()._state_data
				statedata.stacking_dmg_mul = statedata.stacking_dmg_mul or {}
				statedata.stacking_dmg_mul.melee = statedata.stacking_dmg_mul.melee or {nil,0}
				local stack = statedata.stacking_dmg_mul and statedata.stacking_dmg_mul.melee
				if stack[1] and managers.player:player_timer():time() < stack[1] then
					dmg_multiplier = dmg_multiplier * (1 + managers.player:upgrade_value("melee", "stacking_hit_damage_multiplier", 0) * stack[2])
				end
			end

			cur_dmg = cur_dmg * dmg_multiplier
			
			local text = string.format("%.0f%%", math.max(cur_dmg*10, 0))
			if managers.player:player_unit():movement()._state_data.chainsaw_t then
				text = string.format("%.0f%% DPS", cur_dmg*10)
			end
			if cur_charge_percent >= 1 then
				self.hide_interaction_bar(self)
			end
			self._Gilza_melee_damage:set_text(text)
			self._Gilza_melee_damage:set_color(Color(1, 1, 1, 1))
			self._Gilza_melee_damage:set_alpha(1)
			self._Gilza_melee_damage:set_visible(true)
		end
	else
		orig_set_interaction_bar_width(self, current, total)
	end
end)

Hooks:PostHook(HUDInteraction, "hide_interaction_bar", "Gilza_HUDInteraction_hide_interaction_bar_GUI_post", function(self, ...)
	if self._Gilza_melee_damage then
		self._Gilza_melee_damage:set_text("")
		self._Gilza_melee_damage:set_visible(false)
	end
end)

Hooks:PostHook(HUDInteraction, "destroy", "Gilza_HUDInteraction_destroy_GUI_post", function(self, ...)
	if self._Gilza_melee_damage and self._hud_panel then
		self._Gilza_melee_damage:remove()
		self._Gilza_melee_damage = nil
	end
end)