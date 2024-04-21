-- new poison damage stats
Hooks:PostHook(DOTTweakData, "_init_dot_entries_poison", "Gilza_new_poison_dot", function(self)
	-- shotgun poison
	self.dot_entries.poison.ammo_rip = {
		hurt_animation_chance = 1,
		apply_hurt_once = false,
		dot_damage = 2.5,
		dot_length = 6.001,
		use_weapon_damage_falloff = true,
		dot_tick_period = 0.5
	}
	-- plainsrider
	self.dot_entries.poison.ammo_proj_bow = {
		damage_class = "ProjectilesPoisonBulletBase",
		apply_hurt_once = false,
		hurt_animation_chance = 1,
		dot_damage = 5,
		dot_length = 6.001,
		dot_tick_period = 0.25
	}
	-- pistol crossbow crossbow_poison_arrow
	self.dot_entries.poison.ammo_proj_crossbow = {
		damage_class = "ProjectilesPoisonBulletBase",
		apply_hurt_once = false,
		hurt_animation_chance = 1,
		dot_damage = 1.25,
		dot_length = 6.001,
		dot_tick_period = 0.25
	}
	-- heavy crossbow arblast_poison_arrow
	self.dot_entries.poison.ammo_proj_arblast = {
		damage_class = "ProjectilesPoisonBulletBase",
		apply_hurt_once = false,
		hurt_animation_chance = 1,
		dot_damage = 5,
		dot_length = 6.001,
		dot_tick_period = 0.25
	}
	-- light crossbow frankish_poison_arrow
	self.dot_entries.poison.ammo_proj_frankish = {
		damage_class = "ProjectilesPoisonBulletBase",
		apply_hurt_once = false,
		hurt_animation_chance = 1,
		dot_damage = 3.4,
		dot_length = 6.001,
		dot_tick_period = 0.25
	}
	-- eng longbow long_poison_arrow
	self.dot_entries.poison.ammo_proj_long = {
		damage_class = "ProjectilesPoisonBulletBase",
		apply_hurt_once = false,
		hurt_animation_chance = 1,
		dot_damage = 5,
		dot_length = 6.001,
		dot_tick_period = 0.25
	}
	-- h3h3 ecp_arrow_poison
	self.dot_entries.poison.ammo_proj_ecp = {
		damage_class = "ProjectilesPoisonBulletBase",
		apply_hurt_once = false,
		hurt_animation_chance = 1,
		dot_damage = 2.2,
		dot_length = 6.001,
		dot_tick_period = 0.25
	}
	-- deca compound elastic_arrow_poison
	self.dot_entries.poison.ammo_proj_elastic = {
		damage_class = "ProjectilesPoisonBulletBase",
		apply_hurt_once = false,
		hurt_animation_chance = 1,
		dot_damage = 5,
		dot_length = 6.001,
		dot_tick_period = 0.25
	}
	-- poison melee's
	self.dot_entries.poison.melee_piggy_hammer = {
		dot_length = 5,
		dot_damage = 12,
		hurt_animation_chance = 1,
	}
	self.dot_entries.poison.melee_cqc = {
		hurt_animation_chance = 0.5,
		apply_hurt_once = false,
		dot_damage = 10.8,
		dot_length = 2
	}
	self.dot_entries.poison.melee_fear = {
		hurt_animation_chance = 0.5,
		apply_hurt_once = false,
		dot_damage = 10.8,
		dot_length = 2
	}
	-- throwable nade
	self.dot_entries.poison.proj_gas_grenade_cloud = {
		apply_hurt_once = false,
		dot_damage = 1.5,
		dot_length = 15
	}
	-- shuriken
	self.dot_entries.poison.proj_four = {
		damage_class = "ProjectilesPoisonBulletBase",
		apply_hurt_once = false,
		dot_damage = 13,
		dot_length = 5
	}
	-- used by all GL's other then arbiter
	self.dot_entries.poison.proj_launcher_cloud = {
		apply_hurt_once = false,
		dot_damage = 0.35,
		dot_length = 30.01,
		dot_tick_period = 1
	}
	-- arbiter
	self.dot_entries.poison.proj_launcher_arbiter_cloud = {
		apply_hurt_once = false,
		dot_damage = 0.7,
		dot_length = 15,
		dot_tick_period = 1
	}
end)