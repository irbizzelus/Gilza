-- swat van turret dmg adjustment to compenste new dmg numbers
local local_shotgun_shot_id = -1
Hooks:PreHook(SentryGunDamage, "damage_bullet", "Gilza_SentryGunDamage_damage_bullet_pre", function(self, attack_data)
	if attack_data.attacker_unit == managers.player:player_unit() then
		
		local shotgun_min_mul = 1
		local min_shot_dmg = 1
		-- shotgun damage
		if attack_data and attack_data.weapon_unit and attack_data.weapon_unit:base() and attack_data.weapon_unit:base().is_category and (attack_data.weapon_unit:base():is_category("shotgun") or attack_data.weapon_unit:base():is_category("grenade_launcher")) and attack_data.weapon_unit:base()._rays and attack_data.weapon_unit:base()._rays >= 2 then
			
			if not Gilza.isWeaponLibBroken then
				attack_data.damage = attack_data.damage * attack_data.weapon_unit:base()._rays
			end
			
			shotgun_min_mul = Gilza.shotgun_minimal_damage_multipliers[attack_data.weapon_unit:base()._name_id] or (1 / attack_data.weapon_unit:base()._rays)
			min_shot_dmg = attack_data.damage * shotgun_min_mul
			
			if Gilza.current_shotgun_shot_id > local_shotgun_shot_id then
				local_shotgun_shot_id = Gilza.current_shotgun_shot_id
				Gilza.was_first_pellet_proccessed = {}
				Gilza.first_pellet_headshot_bonus = {}
				Gilza.rolled_shotgun_crit_already = {}
				Gilza.is_current_shotgun_critical = {}
			end
			
			if not Gilza.was_first_pellet_proccessed[tostring(self._unit:id())] then
				attack_data.damage = min_shot_dmg
				Gilza.was_first_pellet_proccessed[tostring(self._unit:id())] = true
			else
				attack_data.damage = (attack_data.damage * (1 - shotgun_min_mul)) / (attack_data.weapon_unit:base()._rays - 1)
			end
			managers.statistics:shot_fired({
				weapon_unit = attack_data.weapon_unit,
				hit = true,
				gilza_authorized = true,
				hit_unit = self._unit,
			})
		end
		
		-- overall dmg increase compensation
		attack_data.damage = attack_data.damage * 0.5
	end
end)