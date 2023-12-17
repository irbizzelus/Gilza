Hooks:PreHook(PlayerManager, "on_killshot", "Gilza_brawler_armor_regen", function(self, killed_unit, variant, headshot, weapon_id)
	local player_unit = self:player_unit()

	if not player_unit then
		return
	end

	if CopDamage.is_civilian(killed_unit:base()._tweak_table) then
		return
	end
	
	if player_unit:character_damage() and managers.player:has_category_upgrade("player", "armor_regen_brawler") and variant == "melee" then
		player_unit:character_damage():restore_armor(7.5)
	end
end)