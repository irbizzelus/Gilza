-- weaponlib fix #2451 - this time a reload animation issue with the rotating mag shotgun added with the "under the hammer" auction heist DLC
-- force custom weaponlib function to be overriden by revlovlingshotgunbase class, similarly to how this class overrides the "is_clip_empty" func in vanilla, to make reload animation selection matched to vanilla
function RevolvingShotgunBase:should_do_empty_reload()
	self:check_bullet_objects()

	return not self._shell_state
end