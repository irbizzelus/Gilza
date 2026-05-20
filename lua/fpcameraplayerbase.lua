FPCameraPlayerBase._Gilza_shot_counter = 0 -- used to count how many shots were fired while user holds M1

-- when we start holding m1 again, reset the counter
Hooks:PreHook(FPCameraPlayerBase, "start_shooting", "GilzaCameraRecoil_start", function(self, ...)
	self._Gilza_shot_counter = 0
end)

-- Completely removes camera recoil compensation for shotguns, semi-auto weapons, and if recoil is high.
-- Keep compensation if total recoil is not that high, or we fired a 3 or less round burst that doesnt have high recoil
Hooks:PostHook(FPCameraPlayerBase, "stop_shooting", "GilzaCameraRecoil_stop", function(self, ...)
	if managers.controller:get_default_wrapper_type() == "pc" then
		if (self._Gilza_shot_counter <= 3 and self._recoil_kick.accumulated <= 1.25) or self._recoil_kick.accumulated <= 1 then
			self._recoil_kick.to_reduce = self._recoil_kick.accumulated
			self._recoil_kick.h.to_reduce = self._recoil_kick.h.accumulated
		else
			self._recoil_kick.to_reduce = 0
			self._recoil_kick.h.to_reduce = 0
		end
		
		local wpn_base = managers.player:equipped_weapon_unit():base()
		local function should_remove_compensation()
			if wpn_base:is_category("shotgun") then
				return true
			end
			if wpn_base:is_category("snp") then
				return true
			end
			if wpn_base:is_category("pistol") then
				if wpn_base._fire_mode_category == Idstring("single") or wpn_base._fire_mode_category == "single" then
					return true
				else
					return false
				end
			end
			return false
		end
		if should_remove_compensation() then
			self._recoil_kick.to_reduce = 0
			self._recoil_kick.h.to_reduce = 0
		end
	else -- controller compensation
		local wpn_base = managers.player:equipped_weapon_unit():base()
		if (self._Gilza_shot_counter <= 5 and self._recoil_kick.accumulated <= 1.5) or self._recoil_kick.accumulated <= 1.25 then
			self._recoil_kick.to_reduce = self._recoil_kick.accumulated
			self._recoil_kick.h.to_reduce = self._recoil_kick.h.accumulated
		else
			if wpn_base._fire_mode == Idstring("single") or wpn_base._fire_mode_category == Idstring("single") or wpn_base._fire_mode_category == "single" then
				self._recoil_kick.to_reduce = self._recoil_kick.to_reduce * 0.35
				self._recoil_kick.h.to_reduce = self._recoil_kick.h.to_reduce * 0.35
			else
				self._recoil_kick.to_reduce = 0
				self._recoil_kick.h.to_reduce = 0
			end
		end
	end
end)

-- imrpoved recoil for first few bullets fired
Hooks:OverrideFunction(FPCameraPlayerBase, "recoil_kick", function (self, up, down, left, right)
	-- shot counter
	self._Gilza_shot_counter = self._Gilza_shot_counter + 1
	local mul = 1
	local wpn_base = managers.player:equipped_weapon_unit():base()
	local function does_weapon_qualify()
		if wpn_base:is_category("shotgun") then
			return false
		end
		if wpn_base:is_category("snp") then
			return false
		end
		if wpn_base:is_category("pistol") then
			if wpn_base._fire_mode_category == Idstring("single") or wpn_base._fire_mode_category == "single" then
				return false
			else
				return true
			end
		end
		return true
	end
	-- if allowed, first 5-8 bullets have reduced recoil
	-- this makes short 1-3 round burst feel like they have almost no recoil
	if does_weapon_qualify() then
		-- first shot has highest reduction (aka better recoil), going lower and lower for further shots
		local shot_based_mul = {
			0.62,
			0.7,
			0.78,
			0.86,
			0.92,
		}
		if managers.player:has_category_upgrade("player", "less_start_recoil_for_longer") then
			shot_based_mul = {
				0.62,
				0.66,
				0.7,
				0.75,
				0.8,
				0.85,
				0.9,
				0.95,
			}
		end
		if self._Gilza_shot_counter <= 5 or (self._Gilza_shot_counter <= 8 and managers.player:has_category_upgrade("player", "less_start_recoil_for_longer")) then
			mul = shot_based_mul[self._Gilza_shot_counter] * managers.player:upgrade_value("player", "less_start_recoil", 1)
		end
	end
	
	if math.abs(self._recoil_kick.accumulated or 0) < 20 then
		local v = math.lerp(up, down, math.random())
		self._recoil_kick.accumulated = (self._recoil_kick.accumulated or 0) + v * mul
	end

	local h = math.lerp(left, right, math.random())
	self._recoil_kick.h.accumulated = (self._recoil_kick.h.accumulated or 0) + h * mul
end)

-- adjust camera position when entering the bipod state, since it always forces un-toggleble ADS
Hooks:PreHook(FPCameraPlayerBase, "clbk_stance_entered", "Gilza_FPCameraPlayerBase_clbk_stance_entered_pre", function(self, new_shoulder_stance, new_head_stance, new_vel_overshot, new_fov, new_shakers, stance_mod, duration_multiplier, duration, head_duration_multiplier, head_duration)
	if managers.player.bipod_entry_started then
		local weap_base = managers.player:player_unit():movement():current_state()._equipped_unit:base()
		local wpn_id = weap_base.name_id or "new_m4"
		if stance_mod and tweak_data.player.stances[wpn_id].bipod and tweak_data.player.stances[wpn_id].bipod.leaning_offsets then
			local scope_part = managers.weapon_factory:get_parts_from_weapon_by_perk("scope", weap_base._parts)
			local scope_id = false
			local wpn_lean_offs = tweak_data.player.stances[wpn_id].bipod.leaning_offsets
			
			-- grab lean type
			local lean = "default_lean"
			if managers.player.bipod_entry_started == "right_lean" or managers.player.bipod_entry_started == "left_lean" then
				lean = managers.player.bipod_entry_started
			end
			
			if scope_part and scope_part[1] then
				-- grab used scope id
				for id, tbl in pairs(weap_base._parts) do
					if tbl.name == scope_part[1].name then
						scope_id = id
						break
					end
				end
				if weap_base:get_active_second_sight() then
					scope_id = weap_base:get_active_second_sight().part_id
				end
				
				-- if we have bipod scope adjustments
				if scope_id and wpn_lean_offs.scope_adjustment then
					-- we either use scope's individual values
					if wpn_lean_offs.scope_adjustment[tostring(scope_id)] then
						stance_mod.rotation = wpn_lean_offs.scope_adjustment[tostring(scope_id)][tostring(lean)].rotation or Rotation(0,0,0)
						stance_mod.translation = stance_mod.translation + (wpn_lean_offs.scope_adjustment[tostring(scope_id)][tostring(lean)].translation or Vector3(0,0,0))
						-- tweak value further if a scopemount (or any other weapon part) is present
						if wpn_lean_offs.scope_adjustment[tostring(scope_id)].scopemount then
							for id, tbl in pairs(weap_base._parts) do
								if wpn_lean_offs.scope_adjustment[tostring(scope_id)].scopemount[tostring(id)] then
									stance_mod.translation = stance_mod.translation + wpn_lean_offs.scope_adjustment[tostring(scope_id)].scopemount[tostring(id)][tostring(lean)]
									break
								end
							end
						end
					else -- or we use a "default" value which should handle majority of scopes since they can work with same values
						stance_mod.rotation = wpn_lean_offs.scope_adjustment.default[tostring(lean)].rotation or Rotation(0,0,0)
						stance_mod.translation = stance_mod.translation + (wpn_lean_offs.scope_adjustment.default[tostring(lean)].translation or Vector3(0,0,0))
						-- tweak value further if a scopemount (or any other weapon part) is present
						if wpn_lean_offs.scope_adjustment.default.scopemount then
							for id, tbl in pairs(weap_base._parts) do
								if wpn_lean_offs.scope_adjustment.default.scopemount[tostring(id)] then
									stance_mod.translation = stance_mod.translation + wpn_lean_offs.scope_adjustment.default.scopemount[tostring(id)][tostring(lean)]
									break
								end
							end
						end
					end
				end
			elseif wpn_lean_offs.iron_sights and wpn_lean_offs.iron_sights[tostring(lean)] then -- if no scope detected
				stance_mod.rotation = wpn_lean_offs.iron_sights[tostring(lean)].rotation or Rotation(0,0,0)
				stance_mod.translation = stance_mod.translation + (wpn_lean_offs.iron_sights[tostring(lean)].translation or Vector3(0,0,0))
			end
		end
	end
end)

-- new bipod camera limits func
function FPCameraPlayerBase:set_standard_bipod_limits(spin, pitch, lean)
	self._limits = {}
	
	local sentre_adjustment = 0
	local spin_offset = nil
	local pitch_offset = nil
	-- if we lean on a right/left wall, we shit the camera centre away from the wall to make centre of camera limits make more sense
	if lean == "right_lean" then
		sentre_adjustment = 10
		spin_offset = 24
		pitch_offset = 10
	elseif lean == "left_lean" then
		sentre_adjustment = -10
		spin_offset = 24
		pitch_offset = 10
	end
	
	if spin then
		self._limits.spin = {
			mid = self._camera_properties.spin + sentre_adjustment,
			offset = spin_offset or spin
		}
	end

	if pitch then
		self._limits.pitch = {
			mid = self._camera_properties.pitch,
			offset = pitch_offset or pitch
		}
	end
end