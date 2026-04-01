Hooks:PostHook(InteractionTweakData, "init", "Gilza_InteractionTweakData_init_post", function(self)
	self.sentry_gun_revive = {
		icon = "equipment_ammo_bag",
		requires_upgrade = {
			upgrade = "can_revive",
			category = "sentry_gun"
		},
		timer = 4,
		blocked_hint = "hint_reload_sentry",
		sound_start = "bar_bag_generic",
		sound_interupt = "bar_bag_generic_cancel",
		sound_done = "bar_bag_generic_finished",
		action_text_id = "hud_action_reload_sentry",
		no_contour = true
	}
end)