local gilza_on_picked_up_orig = SentryGunBase.on_picked_up
Hooks:OverrideFunction(SentryGunBase, "on_picked_up", function (self, sentry_type, ammo_ratio, sentry_uid)
	if managers.player.owned_broken_sentries and managers.player.owned_broken_sentries[sentry_uid] then
		managers.player.owned_broken_sentries[sentry_uid] = nil
		ammo_ratio = 0
	end
	gilza_on_picked_up_orig(self, sentry_type, ammo_ratio, sentry_uid)
end)