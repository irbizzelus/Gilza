Hooks:PostHook(FireTweakData, "_init_dot_entries_fire", "Gilza_new_fire_dot", function(self)
	self.dot_entries.fire.weapon_flamethrower_mk2 = {
		dot_trigger_chance = 0.2,
		dot_damage = 7.5,
		dot_length = 2.001,
		dot_trigger_max_distance = 3000,
		dot_tick_period = 0.5
	}
	self.dot_entries.fire.ammo_flamethrower_mk2_rare = {
		dot_trigger_chance = 0.5,
		dot_damage = 6,
		dot_length = 3.001,
		dot_trigger_max_distance = 3000,
		dot_tick_period = 0.25
	}
	self.dot_entries.fire.ammo_flamethrower_mk2_welldone = {
		dot_trigger_chance = 0.1,
		dot_damage = 7.5,
		dot_length = 1.001,
		dot_trigger_max_distance = 3000,
		dot_tick_period = 0.5
	}
	self.dot_entries.fire.weapon_system = {
		dot_trigger_chance = 0.2,
		dot_damage = 7.5,
		dot_length = 2.001,
		dot_trigger_max_distance = 3000,
		dot_tick_period = 0.5
	}
	self.dot_entries.fire.ammo_system_low = {
		dot_trigger_chance = 0.5,
		dot_damage = 6,
		dot_length = 3.001,
		dot_trigger_max_distance = 3000,
		dot_tick_period = 0.25
	}
	self.dot_entries.fire.ammo_system_high = {
		dot_trigger_chance = 0.1,
		dot_damage = 7.5,
		dot_length = 1.001,
		dot_trigger_max_distance = 3000,
		dot_tick_period = 0.5
	}
	self.dot_entries.fire.ammo_dragons_breath = {
		dot_trigger_chance = 1,
		dot_damage = 8.4,
		dot_length = 3.001,
		dot_trigger_max_distance = 900,
		dot_tick_period = 0.25
	}
	self.dot_entries.fire.weapon_kacchainsaw_flamethrower = {
		dot_trigger_chance = 0.35,
		dot_damage = 3,
		dot_length = 1.001,
		dot_trigger_max_distance = 3000,
		dot_tick_period = 0.25
	}
	-- stats are left at vanilla values, since its op as fuck purely because of it's damage
	self.dot_entries.fire.weapon_money = {
		dot_trigger_max_distance = false,
		dot_damage = 10,
		dot_length = 1,
		burn_sound_name = "no_sound",
		dot_trigger_chance = 0.75,
		fire_effect_variant = "endless_money"
	}
	self.dot_entries.fire.melee_spoon_gold = {
		dot_trigger_chance = 0.2,
		dot_damage = 7,
		dot_length = 3,
		dot_trigger_max_distance = false
	}
	-- the molotov projectile itself, used for direct hits
	self.dot_entries.fire.proj_molotov = {
		dot_trigger_chance = 1,
		dot_damage = 1,
		dot_length = 1,
		dot_tick_period = 0.5,
		dot_trigger_max_distance = false,
		is_molotov = true
	}
	-- molotov fire circle 
	self.dot_entries.fire.proj_molotov_groundfire = {
		dot_trigger_chance = 1,
		dot_damage = 10,
		dot_length = 2.001,
		dot_tick_period = 0.2,
		is_molotov = true,
		dot_trigger_max_distance = false
	}
	-- afterburn for the incendiary nade
	self.dot_entries.fire.proj_fire_com = {
		dot_trigger_chance = 1,
		dot_damage = 20,
		dot_length = 5.001,
		dot_tick_period = 0.5,
		dot_trigger_max_distance = false
	}
	-- impact from fire gl40 and a-like
	self.dot_entries.fire.proj_launcher_incendiary = {
		dot_trigger_max_distance = false,
		dot_damage = 1,
		dot_length = 1,
		dot_tick_period = 0.5,
		dot_trigger_chance = 1
	}
	-- gl40 and a-like afterburn
	self.dot_entries.fire.proj_launcher_incendiary_groundfire = {
		dot_damage = 8.3,
		dot_length = 1.501,
		dot_trigger_chance = 1,
		dot_tick_period = 0.25,
		dot_trigger_max_distance = false
	}
	-- impact from fire arbiter
	self.dot_entries.fire.proj_launcher_incendiary_arbiter = {
		dot_trigger_max_distance = false,
		dot_damage = 1,
		dot_length = 1,
		dot_tick_period = 0.5,
		dot_trigger_chance = 1
	}
	-- arbiter afterburn
	self.dot_entries.fire.proj_launcher_incendiary_arbiter_groundfire = {
		dot_damage = 6.3,
		dot_length = 1.501,
		dot_trigger_chance = 1,
		dot_tick_period = 0.25,
		dot_trigger_max_distance = false
	}
	
	self.dot_entries.fire.equipment_tripmine_groundfire = clone(self.dot_entries.fire.proj_launcher_incendiary_groundfire)
	self.dot_entries.fire.enemy_triad_boss_groundfire = clone(self.dot_entries.fire.proj_launcher_incendiary_groundfire)
	self.dot_entries.fire.enemy_mutator_cloaker_groundfire = {
		dot_trigger_max_distance = false
	}
end)