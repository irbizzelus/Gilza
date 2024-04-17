-- new fire damage stats - UPDATE ME
Hooks:PostHook(FireTweakData, "_init_dot_entries_fire", "Gilza_new_fire_dot", function(self)
	-- flammenwerfers
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
	-- shotgun ammo
	self.dot_entries.fire.ammo_dragons_breath = {
		dot_trigger_chance = 1,
		dot_damage = 3.5,
		dot_length = 2.501,
		dot_trigger_max_distance = 1600,
		dot_tick_period = 0.25
	}
	-- underbarrel lmg flamen
	self.dot_entries.fire.weapon_kacchainsaw_flamethrower = {
		dot_trigger_chance = 0.25,
		dot_damage = 1.25,
		dot_length = 2.001,
		dot_trigger_max_distance = 3000,
		dot_tick_period = 0.25
	}
	-- event moneythrower - stats are left at vanilla values, since its op as fuck purely because of it's damage
	self.dot_entries.fire.weapon_money = {
		dot_trigger_max_distance = false,
		dot_damage = 10,
		dot_length = 1,
		burn_sound_name = "no_sound",
		dot_trigger_chance = 0.75,
		fire_effect_variant = "endless_money"
	}
	-- mhm
	self.dot_entries.fire.melee_spoon_gold = {
		dot_trigger_chance = 0.25,
		dot_damage = 9,
		dot_length = 3,
		dot_trigger_max_distance = false
	}
	-- GL's m79,m32,china,slap,ms3gl
	self.dot_entries.fire.proj_launcher_incendiary = {
		dot_trigger_max_distance = false,
		dot_trigger_chance = 1,
		dot_damage = 26,
		dot_length = 6,
		dot_tick_period = 0.5
	}
	-- arbiter GL
	self.dot_entries.fire.proj_launcher_incendiary_arbiter = {
		dot_trigger_max_distance = false,
		dot_trigger_chance = 1,
		dot_damage = 26,
		dot_length = 3,
		dot_tick_period = 0.5
	}
end)