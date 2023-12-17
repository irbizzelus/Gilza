Hooks:PostHook(DOTTweakData, "_init_dot_entries_poison", "Gilza_new_poison_dot", function(self)
	self.dot_entries.poison.ammo_rip = {
		hurt_animation_chance = 1,
		dot_damage = 5,
		dot_length = 2.001,
		use_weapon_damage_falloff = true,
		dot_tick_period = 0.25
	}
	self.dot_entries.poison.proj_gas_grenade_cloud = {
		apply_hurt_once = false,
		hurt_animation_chance = 1,
		dot_damage = 1,
		dot_length = 15.001,
		dot_tick_period = 0.5
	}
	self.dot_entries.poison.proj_launcher_cloud = {
		apply_hurt_once = false,
		hurt_animation_chance = 1,
		dot_damage = 1.5,
		dot_length = 10.001,
		dot_tick_period = 0.5
	}
	self.dot_entries.poison.proj_launcher_arbiter_cloud = {
		apply_hurt_once = false,
		hurt_animation_chance = 1,
		dot_damage = 3,
		dot_length = 5.001,
		dot_tick_period = 0.5
	}
	self.dot_entries.poison.ammo_proj_bow = {
		damage_class = "ProjectilesPoisonBulletBase",
		apply_hurt_once = false,
		hurt_animation_chance = 1,
		dot_damage = 1,
		dot_length = 6.001,
		dot_tick_period = 1
	}
	self.dot_entries.poison.ammo_proj_crossbow = clone(self.dot_entries.poison.ammo_proj_bow)
	self.dot_entries.poison.ammo_proj_arblast = clone(self.dot_entries.poison.ammo_proj_bow)
	self.dot_entries.poison.ammo_proj_frankish = clone(self.dot_entries.poison.ammo_proj_bow)
	self.dot_entries.poison.ammo_proj_long = clone(self.dot_entries.poison.ammo_proj_bow)
	self.dot_entries.poison.ammo_proj_ecp = clone(self.dot_entries.poison.ammo_proj_bow)
	self.dot_entries.poison.ammo_proj_elastic = clone(self.dot_entries.poison.ammo_proj_bow)
	self.dot_entries.poison.melee_piggy_hammer = {
		dot_length = 5,
		dot_damage = 12,
		hurt_animation_chance = 1,
		dot_tick_period = 0.5
	}
	self.dot_entries.poison.melee_cqc = {
		hurt_animation_chance = 0.75,
		dot_length = 2
	}
	self.dot_entries.poison.melee_fear = {
		hurt_animation_chance = 0.75,
		dot_length = 2
	}
end)