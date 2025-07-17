FPCameraPlayerBase._Gilza_shot_counter = 0 -- used to count how many shots were fired while user holds M1

-- when we start holding m1 again, reset the counter
Hooks:PreHook(FPCameraPlayerBase, "start_shooting", "GilzaCameraRecoil_start", function(self, ...)
	self._Gilza_shot_counter = 0
end)

-- Completely removes camera recoil compensation for shotguns, semi-auto weapons, and if recoil is high.
-- Keep compensation if total recoil is not that high, or we fired a 3 or less round burst that doesnt have high recoil
Hooks:PostHook(FPCameraPlayerBase, "stop_shooting", "GilzaCameraRecoil_stop", function(self, ...)
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
	
	if math.abs(self._recoil_kick.accumulated) < 20 then
		local v = math.lerp(up, down, math.random())
		self._recoil_kick.accumulated = (self._recoil_kick.accumulated or 0) + v * mul
	end

	local h = math.lerp(left, right, math.random())
	self._recoil_kick.h.accumulated = (self._recoil_kick.h.accumulated or 0) + h * mul
end)