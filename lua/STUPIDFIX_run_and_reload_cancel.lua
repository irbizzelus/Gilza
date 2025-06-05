-- for whatever retarded reason this function somehow can not be overriden. if i remove it from weaponlib, it's overridable just fine, but as long as it exists
-- in weaponlib's playerstandard file, it does not allow for anything. prehooks, posthooks, blt's function override, standrad function override.
-- mod priority is also irrelevant for whatever reason.
-- my best guess is that weaponlib's playerstandard file is somehow loaded twice after Gilza is loaded, despite gilza having priority.
-- why it happens to this file in particular is beyond me. other weaponlib functions so far i was allowed to override or get hooks to without any issues.
-- this here is a fix that uses BLT's persist_scripts feature. this feature constantly runs this file while an assosiated global var is nil or false
-- 
-- regardless, this is needed to keep track of when a user clicks their primary fire button. if he does while reloading,
-- and having run and reload skill, he can cancel the reload manualy.
if not Gilza_fucking_stupid_action_primary_attack_fix then
	PlayerStandard = PlayerStandard or class(PlayerMovementState)
	if PlayerStandard then
		Hooks:PreHook(PlayerStandard, "_check_action_primary_attack", "Gilza_prehook_check_action_primary_attack", function(self, t, input, params)
			local action_wanted = (not params or params.action_wanted == nil or params.action_wanted) and (input.btn_primary_attack_state or input.btn_primary_attack_release or self:is_shooting_count() or self:_is_charging_weapon())
			local weapon = self._equipped_unit:base() -- dont cancel reload if weapon is empty
			if weapon and weapon:can_reload() and weapon:clip_not_empty() and self.RUN_AND_RELOAD and self._running and action_wanted then
				self:_interupt_action_reload(t)
			end
		end)
		_G.Gilza_fucking_stupid_action_primary_attack_fix = {} -- the needed global var
	end
end