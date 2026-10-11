if managers.player and managers.player:player_unit() and alive(managers.player:player_unit()) then
	local player = managers.player:player_unit()
	local pl_state = player:movement() and player:movement()._current_state
	if pl_state and pl_state:in_steelsight() and managers.player:has_category_upgrade("player", "adjustable_zoom_level") then
		local gun = player:inventory() and player:inventory():equipped_unit() and player:inventory():equipped_unit():base() and player:inventory():equipped_unit():base()._name_id
		if gun and tweak_data.weapon[gun] and tweak_data.weapon[gun].use_data then
			local selection_index = tweak_data.weapon[gun].use_data.selection_index
			Gilza.zoomleveloffset[selection_index] = Gilza.zoomleveloffset[selection_index] + 1
			Gilza.zoomleveloffset[selection_index] = math.clamp(Gilza.zoomleveloffset[selection_index],-2,2)
			local stance_id = pl_state._equipped_unit:base():get_stance_id()
			local stances = tweak_data.player.stances[stance_id] or tweak_data.player.stances.default
			local misc_attribs = pl_state._state_data.in_steelsight and stances.steelsight or pl_state._state_data.ducking and stances.crouched or stances.standard
			local new_fov = pl_state:get_zoom_fov(misc_attribs) + 0
			player:camera()._camera_unit:base():set_fov_instant(new_fov)
		end
	end
end