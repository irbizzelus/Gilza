-- Slow and steady skill damage multipliers
Hooks:PreHook(PlayerDamage, "damage_bullet", "SaS_skillresist", function(self, attack_data)
	if managers.network:session():local_peer():unit():movement()._current_state._moving == false then
		attack_data.damage = attack_data.damage * managers.player:upgrade_value("player", "not_moving_damage_reduction_bonus", 1)
	end
	if managers.player:current_state() == "bipod" then
		attack_data.damage = attack_data.damage * managers.player:upgrade_value("player", "not_moving_damage_reduction_bonus", 1) -- apply basic skill version reduction if bipoded
		attack_data.damage = attack_data.damage * managers.player:upgrade_value("player", "not_moving_damage_reduction_bonus_bipoded", 1)
	end
	if managers.player:has_category_upgrade("player", "damage_resist_brawler") then
		attack_data.damage = attack_data.damage * managers.player:upgrade_value("player", "damage_resist_brawler", 1)
	end
	if managers.player:has_category_upgrade("player", "damage_resist_faraway_brawler") then
		if ( self:_max_health() / self:get_real_health() ) >= 2 then
			if managers.player:player_unit():position() and attack_data.attacker_unit:position() then
				local ray = World:raycast( "ray", managers.player:player_unit():position(), attack_data.attacker_unit:position(), "slot_mask", managers.slot:get_mask( "bullet_impact_targets" ) )
				if ray and ray.distance >= 900 and ray.distance < 1600 then
					attack_data.damage = attack_data.damage * 0.61
				elseif ray and ray.distance >= 1600 then
					attack_data.damage = attack_data.damage * 0.26
				end
			end
		end
	end
end)

local Gilz_arrested = "CBT"
-- check for arrest when beeing revived
Hooks:PreHook(PlayerDamage, "revive", "Gilza_UYGBuffpt1", function(self)
	Gilz_arrested = self:arrested()
end)
-- if not arrested and we have Up you go, get more health + sync
Hooks:PostHook(PlayerDamage, "revive", "Gilza_UYGBuffpt2", function(self)
	if not Gilz_arrested and managers.player:has_category_upgrade("player", "health_regain_V2") then
		self:set_health(self:get_real_health() + (self:_max_health() * managers.player:upgrade_value("player", "health_regain_V2", 0)))
		managers.hud:set_player_health({
			current = self:get_real_health(),
			total = self:_max_health(),
			revives = Application:digest_value(self._revives, false)
		})
		self:_send_set_health()
	end
end)