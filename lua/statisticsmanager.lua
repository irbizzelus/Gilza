-- fix for shotgun and shotgun style weapons having incorrect accuracy in the end statistics screen
local local_shotgun_shot = {id = -99, units_hit = {}}
local gilza_orig_statistics_manager_shot_fired = Hooks:GetFunction(StatisticsManager, "shot_fired")
Hooks:OverrideFunction(StatisticsManager, "shot_fired", function (self, data)
	
	if data and data.weapon_unit and data.weapon_unit:base() and data.weapon_unit:base().is_category and (data.weapon_unit:base():is_category("shotgun") or data.weapon_unit:base():is_category("grenade_launcher")) and data.weapon_unit:base()._rays and data.weapon_unit:base()._rays >= 2 then
		if not data.skip_bullet_count and not data.hit then
			if Gilza.current_shotgun_shot_id > local_shotgun_shot.id then
				local_shotgun_shot.id = Gilza.current_shotgun_shot_id
				local_shotgun_shot.units_hit = {}
			elseif Gilza.current_shotgun_shot_id == local_shotgun_shot.id then
				return
			end
		elseif data.hit and data.gilza_authorized then
			if Gilza.current_shotgun_shot_id > local_shotgun_shot.id then
				local_shotgun_shot.id = Gilza.current_shotgun_shot_id
				local_shotgun_shot.units_hit = {}
				local_shotgun_shot.units_hit[tostring(data.hit_unit:id())] = true
			else
				if not local_shotgun_shot.units_hit[tostring(data.hit_unit:id())] then
					local_shotgun_shot.units_hit[tostring(data.hit_unit:id())] = true
					data.skip_bullet_count = true
				else
					return
				end
			end
		else
			return
		end
	end
	
	gilza_orig_statistics_manager_shot_fired(self, data)
	
end)