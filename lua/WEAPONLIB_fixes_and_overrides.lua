-- this here is a fix that uses BLT's persist_scripts feature. this feature constantly runs this file while an assosiated global var is nil or false
-- this was done in such way because weaponLib keeps overriding functions regardless of what it's priority is set to
-- i honestly dont know why, but my suspicion lies with the way it's hooks are added in the supermod.xml file
-- regardless, this will add anything that weaponlib is preventing me from adding through normal means
if not Gilzas_weaponlib_overrides_and_fixes then
	
	-- keep track of when a user clicks their primary fire button. if they do while reloading,
	-- and having run and reload skill, they can cancel the reload manualy
	PlayerStandard = PlayerStandard or class(PlayerMovementState)
	if PlayerStandard then
		Hooks:PreHook(PlayerStandard, "_check_action_primary_attack", "Gilza_prehook_check_action_primary_attack", function(self, t, input, params)
			local action_wanted = (not params or params.action_wanted == nil or params.action_wanted) and (input.btn_primary_attack_state or input.btn_primary_attack_release or self:is_shooting_count() or self:_is_charging_weapon())
			local weapon = self._equipped_unit:base() -- dont cancel reload if weapon is empty
			if weapon and weapon:can_reload() and weapon:clip_not_empty() and self.RUN_AND_RELOAD and self._running and action_wanted then
				self:_interupt_action_reload(t)
			end
		end)
	end
	
	-- fix an issue with weaponlib where all bipoded weapons are allowed to reload while bipoded by default, instead of
	-- exiting bipod state and then begining to reload. theoretically a good feature for custom weapons that might have
	-- reload animations while reloading, but why it's defauled to true for vanilla LMG's is beyond me.
	PlayerBipod = PlayerBipod or class(PlayerStandard)
	if PlayerBipod then
		Hooks:OverrideFunction(PlayerBipod, "_check_action_reload", function (self, t, input)
			local new_action = nil
			local action_wanted = input.btn_reload_press

			if action_wanted and self._equipped_unit and not self._equipped_unit:base():clip_full() then
				local weapon = self._equipped_unit:base()
				local weapon_tweak_data = weapon:weapon_tweak_data()
				if not (weapon_tweak_data.bipod_reload_allowed or false) then
					self:exit(nil, "standard")
					managers.player:set_player_state("standard")
				end

				self:_start_action_reload_enter(t)

				new_action = true
			end

			return new_action
		end)
	end
	
	_G.Gilzas_weaponlib_overrides_and_fixes = {} -- the needed global var
end