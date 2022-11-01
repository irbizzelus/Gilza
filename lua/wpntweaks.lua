Hooks:PostHook(WeaponTweakData, "_init_new_weapons", "Gilza_NewWeaponStats", function(self, tweak_data)
	if not Gilza then 
		_G.Gilza = {}
		Gilza._path = "mods/Gilza/"
		Gilza._guns_path = "mods/saves/Gilza_customguns.txt"
		dofile("mods/Gilza/lua/wpntweaks_custom.lua")
		Gilza.checkforweapontweaks()
	end
	
	local special_weapon_ids = { -- not used but handy to have
		-- primary
		"ecp",
		"long",
		"flamethrower_mk2",
		"gre_m79",
		"arblast",
		"frankish",
		"saw",
		"m32",
		"plainsrider",
		"m134",
		"shuno",
		"hailstorm",
		-- secondary
		"arbiter",
		"china",
		"ray",
		"slap",
		"rpg7",
		"saw_secondary",
		"hunter",
		"system",
		"ms3gl",
	}
	local weapon_ids = {
		--akimbo
		"x_b92fs",
		"x_basset",
		"x_chinchilla",
		"x_g17",
		"jowi",
		"x_g22c",
		"x_mp5",
		"x_packrat",
		"x_1911",
		"x_shrew",
		"x_deagle",
		"x_sr2",
		"x_usp",
		"x_akmsu",
		"x_sparrow",
		"x_rage",
		"x_c96",
		"x_ppk",
		"x_hs2000",
		"x_2006m",
		"x_breech",
		"x_p226",
		"x_g18c",
		"x_pl14",
		"x_legacy",
		"x_rota",
		"x_judge",
		"x_tec9",
		"x_m1928",
		"x_mp9",
		"x_scorpion",
		"x_hajk",
		"x_schakal",
		"x_cobray",
		"x_p90",
		"x_polymer",
		"x_mac10",
		"x_baka",
		"x_erma",
		"x_olympic",
		"x_sterling",
		"x_shepheard",
		"x_mp7",
		"x_m45",
		"x_coal",
		"x_uzi",
		"x_beer",
		"x_czech",
		"x_stech",
		"x_holt",
		"x_model3",
		"x_m1911",
		"x_vityaz",
		"x_pm9",
		"x_type54",
		"x_maxim9",
		"x_korth",
		"x_sko12",
		--assault rifles
		"ak74",
		"akm",
		"ak5",
		"flint",
		"amcar",
		"m16",
		"tecci",
		"new_m4",
		"sub2000",
		"famas",
		"s552",
		"scar",
		"fal",
		"ching",
		"galil",
		"g3",
		"akm_gold",
		"g36",
		"contraband",
		"vhs",
		"new_m14",
		"l85a2",
		"aug",
		"corgi",
		"asval",
		"komodo",
		"groza",
		"shak12",
		-- machine guns
		"hk21",
		"mg42",
		"m249",
		"par",
		"rpk",
		"m60",
		"hk51b",
		-- pistols
		"lemming",
		"sparrow",
		"b92fs",
		"new_raging_bull",
		"c96",
		"chinchilla",
		"glock_17",
		"g26",
		"g22c",
		"packrat",
		"colt_1911",
		"shrew",
		"deagle",
		"ppk",
		"usp",
		"hs2000",
		"mateba",
		"breech",
		"peacemaker",
		"p226",
		"glock_18c",
		"pl14",
		"legacy",
		"beer",
		"czech",
		"stech",
		"holt",
		"model3",
		"m1911",
		"type54",
		"rsh12",
		"maxim9",
		"korth",
		-- shotguns
		"boot",
		"saiga",
		"b682",
		"benelli",
		"huntsman",
		"spas12",
		"ksg",
		"r870",
		"aa12",
		"m1897",
		"m590",
		"sko12",
		-- secondary shotguns
		"basset",
		"m37",
		"rota",
		"serbu",
		"striker",
		"judge",
		"coach",
		"ultima",
		-- snipers
		"tti",
		"desertfox",
		"siltstone",
		"wa2000",
		"mosin",
		"model70",
		"r93",
		"msr",
		"winchester1874",
		"m95",
		"r700",
		"sbl",
		"qbu88",
		"scout",
		-- sub machine guns
		"tec9",
		"m1928",
		"mp9",
		"scorpion",
		"new_mp5",
		"hajk",
		"sr2",
		"schakal",
		"cobray",
		"p90",
		"akmsu",
		"polymer",
		"mac10",
		"baka",
		"erma",
		"olympic",
		"sterling",
		"mp7",
		"m45",
		"coal",
		"uzi",
		"shepheard",
		"vityaz",
		"pm9",
		"fmg9",
	}
	
	for _, gun in ipairs(weapon_ids) do
		if self[gun] and self[gun].stats.damage then
			self[gun].stats.damage = math.floor(self[gun].stats.damage * 1.75)
		end
	end
	
	for _, gun in ipairs(weapon_ids) do
		if self[gun] and self[gun].spread.standing and self[gun].spread.steelsight and self[gun].spread.crouching and self[gun].spread.moving_standing and self[gun].spread.moving_crouching and self[gun].spread.moving_steelsight then
			self[gun].spread.standing = self[gun].spread.standing * 1
			self[gun].spread.steelsight = self[gun].spread.steelsight * 1
			self[gun].spread.crouching = self[gun].spread.crouching * 2
			self[gun].spread.moving_standing = self[gun].spread.moving_standing * 1.3
			self[gun].spread.moving_crouching = self[gun].spread.moving_crouching * 1.3
			self[gun].spread.moving_steelsight = self[gun].spread.moving_steelsight * 1
		end
	end
	
	-- Assault rifles --
	self.amcar.stats.damage = 146
	self.amcar.AMMO_PICKUP = {3.98,6.48}
	self.amcar.fire_mode_data = {fire_rate = 60/640}
	self.amcar.auto = {fire_rate = 60/640}
	
	self.new_m4.stats.damage = 210
	self.new_m4.AMMO_PICKUP = {1.97,3.54}
	
	self.s552.stats.damage = 146
	self.s552.AMMO_PICKUP = {3.98,6.48}
	self.s552.stats.recoil = 11
	
	self.scar.stats.damage = 420
	self.scar.CLIP_AMMO_MAX = 25
	self.scar.NR_CLIPS_MAX = 5
	self.scar.AMMO_MAX = self.scar.CLIP_AMMO_MAX * self.scar.NR_CLIPS_MAX
	self.scar.AMMO_PICKUP = {0.75,1.59}
	
	self.corgi.stats.damage = 146
	self.corgi.fire_mode_data = {fire_rate = 60/800}
	self.corgi.auto = {fire_rate = 60/800}
	self.corgi.AMMO_PICKUP = {3.98,6.48}
	
	self.ak74.stats.damage = 210
	self.ak74.AMMO_PICKUP = {1.97,3.54}
	
	self.aug.stats.damage = 210
	self.aug.stats.recoil = 15
	self.aug.AMMO_PICKUP = {1.97,3.54}
	
	self.groza.stats.damage = 210
	self.groza.AMMO_PICKUP = {1.36,2.65}
	
	self.sub2000.stats.damage = 210
	self.sub2000.AMMO_PICKUP = {1.97,3.54}
	
	self.akm.stats.damage = 420
	self.akm.AMMO_PICKUP = {0.75,1.59}
	
	self.g36.stats.damage = 146
	self.g36.AMMO_PICKUP = {3.98,6.48}
	
	self.flint.stats.damage = 240
	self.flint.NR_CLIPS_MAX = 4
	self.flint.AMMO_MAX = self.flint.CLIP_AMMO_MAX * self.flint.NR_CLIPS_MAX
	self.flint.AMMO_PICKUP = {1.67,3.12}
	
	self.akm_gold.stats.damage = 420
	self.akm_gold.AMMO_PICKUP = {0.75,1.59}
	
	self.tecci.stats.damage = 189 -- 146 profile but better
	self.tecci.stats.recoil = 12
	self.tecci.stats.spread = 11
	self.hk51b.stats.spread_moving = 9
	self.tecci.AMMO_PICKUP = {4.22,6.88}
	
	self.l85a2.stats.damage = 146
	self.l85a2.stats.reload = 15
	self.l85a2.AMMO_PICKUP = {3.98,6.48}
	
	self.ching.stats.damage = 420
	self.ching.stats.reload = 13
	self.ching.AMMO_PICKUP = {0.75,1.59}
	
	self.new_m14.stats.damage = 420
	self.new_m14.stats.reload = 9
	self.new_m14.CLIP_AMMO_MAX = 15
	self.new_m14.NR_CLIPS_MAX = 5
	self.new_m14.AMMO_MAX = self.new_m14.CLIP_AMMO_MAX * self.new_m14.NR_CLIPS_MAX
	self.new_m14.AMMO_PICKUP = {0.75,1.59}

	self.famas.stats.damage = 117
	self.famas.AMMO_PICKUP = {4.9,7.64}
	
	self.vhs.stats.damage = 210
	self.vhs.stats.recoil = 10
	self.vhs.stats.spread = 9
	self.vhs.AMMO_PICKUP = {1.97,3.54}
	
	self.asval.stats.damage = 146
	self.asval.CLIP_AMMO_MAX = 20
	self.asval.NR_CLIPS_MAX = 11
	self.asval.AMMO_MAX = self.asval.CLIP_AMMO_MAX * self.asval.NR_CLIPS_MAX
	self.asval.AMMO_PICKUP = {3.98,6.48}
	
	self.ak5.stats.damage = 117
	self.ak5.AMMO_PICKUP = {4.9,7.64}
	
	self.galil.stats.damage = 210
	self.galil.stats.recoil = 12
	self.galil.stats.spread = 8
	self.galil.stats.spread_moving = 6
	self.galil.AMMO_PICKUP = {1.97,3.54}
	
	self.komodo.stats.damage = 117
	self.komodo.fire_mode_data = {fire_rate = 60/850}
	self.komodo.auto = {fire_rate = 60/850}
	self.komodo.stats.recoil = 17
	self.komodo.stats.spread = 17
	self.komodo.stats.spread_moving = 15
	self.komodo.NR_CLIPS_MAX = 6
	self.komodo.AMMO_MAX = self.komodo.CLIP_AMMO_MAX * self.komodo.NR_CLIPS_MAX
	self.komodo.AMMO_PICKUP = {4.9,7.64}
	
	self.m16.stats.damage = 210
	self.m16.NR_CLIPS_MAX = 4
	self.m16.AMMO_MAX = self.m16.CLIP_AMMO_MAX * self.m16.NR_CLIPS_MAX
	self.m16.AMMO_PICKUP = {1.81,3.31}
	
	self.shak12.stats.damage = 420
	self.shak12.CLIP_AMMO_MAX = 25
	self.shak12.NR_CLIPS_MAX = 5
	self.shak12.AMMO_MAX = self.shak12.CLIP_AMMO_MAX * self.shak12.NR_CLIPS_MAX
	self.shak12.AMMO_PICKUP = {0.75,1.59}
	self.shak12.stats.recoil = 21
	self.shak12.stats.spread = 17
	self.shak12.stats.spread_moving = 15
	
	self.contraband.stats.damage = 420
	self.contraband.CLIP_AMMO_MAX = 25
	self.contraband.NR_CLIPS_MAX = 3
	self.contraband.AMMO_MAX = self.contraband.CLIP_AMMO_MAX * self.contraband.NR_CLIPS_MAX
	self.contraband.AMMO_PICKUP = {0.59,1.31}
	self.contraband.stats.recoil = 18
	self.contraband.stats.spread = 15
	self.contraband.stats.spread_moving = 13
	
	self.fal.stats.damage = 420
	self.fal.CLIP_AMMO_MAX = 20
	self.fal.NR_CLIPS_MAX = 5
	self.fal.AMMO_MAX = self.fal.CLIP_AMMO_MAX * self.fal.NR_CLIPS_MAX
	self.fal.AMMO_PICKUP = {0.75,1.59}
	self.fal.stats.recoil = 20
	self.fal.stats.spread = 17
	self.fal.stats.spread_moving = 15
	
	self.g3.stats.damage = 230
	self.g3.CLIP_AMMO_MAX = 25
	self.g3.NR_CLIPS_MAX = 4
	self.g3.AMMO_MAX = self.g3.CLIP_AMMO_MAX * self.g3.NR_CLIPS_MAX
	self.g3.AMMO_PICKUP = {4.5,8.25}
	self.g3.stats.recoil = 21
	self.g3.stats.spread = 22
	self.g3.stats.spread_moving = 21
	self.g3.AMMO_PICKUP = {1.97,3.54}
	
	-- Shotguns --
	-- Pump --
	self.r870.stats.damage = 420
	self.r870.CLIP_AMMO_MAX = 6
	self.r870.NR_CLIPS_MAX = 8
	self.r870.AMMO_MAX = self.r870.CLIP_AMMO_MAX * self.r870.NR_CLIPS_MAX
	self.r870.AMMO_PICKUP = {0.74,1.23}
	self.r870.stats.recoil = 24
	self.r870.stats.spread = 25
	self.r870.stats.spread_moving = 23
	self.r870.fire_mode_data = {fire_rate = 60/90}
	self.r870.single = {fire_rate = 60/90}
	
	self.m590.stats.damage = 420
	self.m590.CLIP_AMMO_MAX = 5
	self.m590.NR_CLIPS_MAX = 10
	self.m590.AMMO_MAX = self.m590.CLIP_AMMO_MAX * self.m590.NR_CLIPS_MAX
	self.m590.AMMO_PICKUP = {0.74,1.23}
	self.m590.stats.recoil = 14
	self.m590.stats.spread = 11
	self.m590.stats.spread_moving = 9
	self.m590.fire_mode_data = {fire_rate = 60/115}
	self.m590.single = {fire_rate = 60/115}
	
	self.m1897.stats.damage = 420
	self.m1897.CLIP_AMMO_MAX = 8
	self.m1897.NR_CLIPS_MAX = 6
	self.m1897.AMMO_MAX = self.m1897.CLIP_AMMO_MAX * self.m1897.NR_CLIPS_MAX
	self.m1897.AMMO_PICKUP = {0.74,1.23}
	self.m1897.stats.recoil = 24
	self.m1897.stats.spread = 25
	self.m1897.stats.concealment = 15
	self.m1897.stats.spread_moving = 23
	self.m1897.fire_mode_data = {fire_rate = 60/90}
	self.m1897.single = {fire_rate = 60/90}
	
	self.boot.stats.damage = 420
	self.boot.CLIP_AMMO_MAX = 7
	self.boot.NR_CLIPS_MAX = 7
	self.boot.AMMO_MAX = self.boot.CLIP_AMMO_MAX * self.boot.NR_CLIPS_MAX
	self.boot.AMMO_PICKUP = {0.74,1.23}
	self.boot.stats.recoil = 20
	self.boot.stats.spread = 25
	self.boot.stats.spread_moving = 23
	self.boot.fire_mode_data = {fire_rate = 60/90}
	self.boot.single = {fire_rate = 60/90}
	
	self.ksg.stats.damage = 420
	self.ksg.CLIP_AMMO_MAX = 14
	self.ksg.NR_CLIPS_MAX = 2.5
	self.ksg.AMMO_MAX = self.ksg.CLIP_AMMO_MAX * self.ksg.NR_CLIPS_MAX
	self.ksg.AMMO_PICKUP = {0.74,1.23}
	self.ksg.stats.recoil = 18
	self.ksg.stats.spread = 19
	self.ksg.stats.spread_moving = 17
	self.ksg.fire_mode_data = {fire_rate = 60/90}
	self.ksg.single = {fire_rate = 60/90}
	
	-- Semi-auto --
	self.benelli.stats.damage = 305
	self.benelli.CLIP_AMMO_MAX = 8
	self.benelli.NR_CLIPS_MAX = 8
	self.benelli.AMMO_MAX = self.benelli.CLIP_AMMO_MAX * self.benelli.NR_CLIPS_MAX
	self.benelli.AMMO_PICKUP = {1.12,1.67}
	self.benelli.stats.recoil = 18
	self.benelli.stats.spread = 13
	self.benelli.stats.spread_moving = 11
	self.benelli.fire_mode_data = {fire_rate = 60/360}
	self.benelli.single = {fire_rate = 60/360}
	
	self.spas12.stats.damage = 305
	self.spas12.CLIP_AMMO_MAX = 6
	self.spas12.NR_CLIPS_MAX = 11
	self.spas12.AMMO_MAX = self.spas12.CLIP_AMMO_MAX * self.spas12.NR_CLIPS_MAX
	self.spas12.AMMO_PICKUP = {1.12,1.67}
	self.spas12.stats.recoil = 18
	self.spas12.stats.spread = 13
	self.spas12.stats.spread_moving = 11
	self.spas12.fire_mode_data = {fire_rate = 60/360}
	self.spas12.single = {fire_rate = 60/360}
	
	-- Double barrel --
	self.b682.stats.damage = 1250
	self.b682.CLIP_AMMO_MAX = 2
	self.b682.NR_CLIPS_MAX = 10
	self.b682.AMMO_MAX = self.b682.CLIP_AMMO_MAX * self.b682.NR_CLIPS_MAX
	self.b682.AMMO_PICKUP = {0.32,1.04}
	self.b682.stats.recoil = 25
	self.b682.stats.spread = 25
	self.b682.stats.spread_moving = 23
	self.b682.fire_mode_data = {fire_rate = 60/360}
	self.b682.single = {fire_rate = 60/360}
	
	self.huntsman.stats.damage = 1250
	self.huntsman.CLIP_AMMO_MAX = 2
	self.huntsman.NR_CLIPS_MAX = 13
	self.huntsman.AMMO_MAX = self.huntsman.CLIP_AMMO_MAX * self.huntsman.NR_CLIPS_MAX
	self.huntsman.AMMO_PICKUP = {0.32,1.04}
	self.huntsman.stats.recoil = 25
	self.huntsman.stats.spread = 25
	self.huntsman.stats.spread_moving = 23
	self.huntsman.fire_mode_data = {fire_rate = 60/360}
	self.huntsman.single = {fire_rate = 60/360}
	
	-- Full auto --
	self.saiga.stats.damage = 110
	self.saiga.AMMO_PICKUP = {2.8,4.2}
	self.saiga.stats.recoil = 8
	self.saiga.stats.spread = 4
	self.saiga.stats.spread_moving = 2
	self.saiga.fire_mode_data = {fire_rate = 60/360}
	self.saiga.single = {fire_rate = 60/360}
	
	self.aa12.stats.damage = 110
	self.aa12.CLIP_AMMO_MAX = 8
	self.aa12.NR_CLIPS_MAX = 10
	self.aa12.AMMO_MAX = self.aa12.CLIP_AMMO_MAX * self.aa12.NR_CLIPS_MAX
	self.aa12.AMMO_PICKUP = {2.8,4.2}
	self.aa12.stats.recoil = 8
	self.aa12.stats.spread = 4
	self.aa12.stats.concealment = 20
	self.aa12.stats.spread_moving = 2
	self.aa12.fire_mode_data = {fire_rate = 60/360}
	self.aa12.single = {fire_rate = 60/360}
	
	self.sko12.stats.damage = 110
	self.sko12.AMMO_PICKUP = {2.8,4.2}
	self.sko12.stats.recoil = 8
	self.sko12.stats.spread = 7
	self.sko12.stats.spread_moving = 5
	self.sko12.fire_mode_data = {fire_rate = 60/360}
	self.sko12.single = {fire_rate = 60/360}
	
	self.x_sko12.stats.damage = 110
	self.x_sko12.AMMO_PICKUP = {2.8,4.2}
	self.x_sko12.stats.recoil = 0
	self.x_sko12.fire_mode_data = {fire_rate = 60/280}
	self.x_sko12.single = {fire_rate = 60/280}
	
	--Secondary shotguns
	self.serbu.stats.damage = 420
	self.serbu.CLIP_AMMO_MAX = 6
	self.serbu.NR_CLIPS_MAX = 6
	self.serbu.AMMO_MAX = self.serbu.CLIP_AMMO_MAX * self.serbu.NR_CLIPS_MAX
	self.serbu.AMMO_PICKUP = {0.52,0.89}
	self.serbu.stats.recoil = 8
	self.serbu.stats.spread = 10
	self.serbu.stats.spread_moving = 8
	self.serbu.fire_mode_data = {fire_rate = 60/90}
	self.serbu.single = {fire_rate = 60/90}
	
	self.m37.stats.damage = 420
	self.m37.CLIP_AMMO_MAX = 7
	self.m37.NR_CLIPS_MAX = 4
	self.m37.AMMO_MAX = self.m37.CLIP_AMMO_MAX * self.m37.NR_CLIPS_MAX
	self.m37.AMMO_PICKUP = {0.52,0.89}
	self.m37.stats.recoil = 11
	self.m37.stats.spread = 7
	self.m37.stats.spread_moving = 5
	self.m37.fire_mode_data = {fire_rate = 60/100}
	self.m37.single = {fire_rate = 60/100}
	
	self.coach.stats.damage = 1250
	self.coach.CLIP_AMMO_MAX = 2
	self.coach.NR_CLIPS_MAX = 10
	self.coach.AMMO_MAX = self.coach.CLIP_AMMO_MAX * self.coach.NR_CLIPS_MAX
	self.coach.AMMO_PICKUP = {0.23,0.73}
	self.coach.stats.recoil = 10
	self.coach.stats.spread = 19
	self.coach.stats.spread_moving = 17
	self.coach.fire_mode_data = {fire_rate = 60/360}
	self.coach.single = {fire_rate = 60/360}

	self.rota.stats.damage = 110
	self.rota.AMMO_PICKUP = {1.96,2.94}
	self.rota.stats.recoil = 10
	self.rota.stats.spread = 6
	self.rota.stats.spread_moving = 4
	self.rota.stats.reload = 15
	self.rota.fire_mode_data = {fire_rate = 60/360}
	self.rota.single = {fire_rate = 60/360}
	
	self.x_rota.stats.damage = 110
	self.x_rota.AMMO_PICKUP = {2.8,4.2}
	self.x_rota.stats.recoil = 5
	self.x_rota.stats.spread = 1
	self.x_rota.stats.spread_moving = 0
	self.x_rota.stats.reload = 15
	self.x_rota.fire_mode_data = {fire_rate = 60/360}
	self.x_rota.single = {fire_rate = 60/360}
	
	self.x_basset.stats.damage = 110
	self.x_basset.CLIP_AMMO_MAX = 14
	self.x_basset.NR_CLIPS_MAX = 6
	self.x_basset.AMMO_MAX = self.x_basset.CLIP_AMMO_MAX * self.x_basset.NR_CLIPS_MAX
	self.x_basset.AMMO_PICKUP = {2.8,4.2}
	self.x_basset.stats.recoil = 5
	self.x_basset.stats.spread = 1
	self.x_basset.stats.spread_moving = 0
	self.x_basset.fire_mode_data = {fire_rate = 60/300}
	self.x_basset.single = {fire_rate = 60/300}
	
	self.basset.stats.damage = 110
	self.basset.CLIP_AMMO_MAX = 7
	self.basset.NR_CLIPS_MAX = 7
	self.basset.AMMO_MAX = self.basset.CLIP_AMMO_MAX * self.basset.NR_CLIPS_MAX
	self.basset.AMMO_PICKUP = {1.96,2.94}
	self.basset.stats.recoil = 10
	self.basset.stats.spread = 6
	self.basset.stats.spread_moving = 4
	self.basset.fire_mode_data = {fire_rate = 60/300}
	self.basset.single = {fire_rate = 60/300}
	
	self.striker.stats.damage = 305
	self.striker.CLIP_AMMO_MAX = 12
	self.striker.NR_CLIPS_MAX = 4
	self.striker.AMMO_MAX = self.striker.CLIP_AMMO_MAX * self.striker.NR_CLIPS_MAX
	self.striker.AMMO_PICKUP = {0.784,1.169}
	self.striker.stats.recoil = 14
	self.striker.stats.spread = 9
	self.striker.stats.spread_moving = 8
	self.striker.fire_mode_data = {fire_rate = 60/360}
	self.striker.single = {fire_rate = 60/360}
	
	self.ultima.stats.damage = 305
	self.ultima.AMMO_PICKUP = {0.784,1.169}
	self.ultima.stats.recoil = 14
	self.ultima.stats.spread = 9
	self.ultima.stats.spread_moving = 8
	self.ultima.fire_mode_data = {fire_rate = 60/360}
	self.ultima.single = {fire_rate = 60/360}
	
	self.judge.stats.damage = 305
	self.judge.AMMO_PICKUP = {0.784,1.169}
	self.judge.stats.recoil = 1
	self.judge.stats.spread = 1
	self.judge.stats.spread_moving = 1
	self.judge.fire_mode_data = {fire_rate = 60/360}
	self.judge.single = {fire_rate = 60/360}
	-- fuck your shotgun pistol, irl its barely usable why tf should it be any other way here
	self.judge.shake = {
		fire_multiplier = 4.5,
		fire_steelsight_multiplier = 4.5
	}
	self.judge.kick = {
		standing = {
			3.9,
			4,
			-0.2,
			0.2
		}
	}
	self.judge.kick.crouching = self.judge.kick.standing
	self.judge.kick.steelsight = self.judge.kick.standing
	
	self.x_judge.stats.damage = 305
	self.x_judge.AMMO_PICKUP = {1.12,1.67}
	self.x_judge.stats.recoil = 3
	self.x_judge.stats.spread = 1
	self.x_judge.stats.spread_moving = 1
	self.x_judge.fire_mode_data = {fire_rate = 60/360}
	self.x_judge.single = {fire_rate = 60/360}
	self.x_judge.shake = {
		fire_multiplier = 2.3,
		fire_steelsight_multiplier = -1
	}
	self.x_judge.kick = {
		standing = {
			2.4,
			2.2,
			-0.7,
			0.7
		}
	}
	self.x_judge.kick.crouching = self.x_judge.kick.standing
	self.x_judge.kick.steelsight = self.x_judge.kick.standing
	
	-- light machine guns --
	
	--no bipod one
	self.hk51b.stats.spread = 10
	self.hk51b.stats.spread_moving = 8
	self.hk51b.stats.recoil = 9
	self.hk51b.AMMO_PICKUP = {4.8,6.89}
	
	--heavy
	self.hk21.AMMO_PICKUP = {5.9,8.89}
	self.rpk.AMMO_PICKUP = {5.9,8.89}
	self.m60.AMMO_PICKUP = {5.9,8.89}
	
	--light
	self.mg42.AMMO_PICKUP = {7.5,9.2}
	self.m249.AMMO_PICKUP = {7.5,9.2}
	self.par.AMMO_PICKUP = {7.5,9.2}

	-- Snipers --
	
	-- Semi autos
	self.qbu88.stats.damage = 550
	self.qbu88.CLIP_AMMO_MAX = 10
	self.qbu88.NR_CLIPS_MAX = 4
	self.qbu88.AMMO_MAX = self.qbu88.CLIP_AMMO_MAX * self.qbu88.NR_CLIPS_MAX
	self.qbu88.AMMO_PICKUP = {1.25,1.99}
	self.qbu88.stats.recoil = 13
	self.qbu88.stats.spread = 20
	self.qbu88.stats.spread_moving = 18
	self.qbu88.fire_mode_data = {fire_rate = 60/450}
	self.qbu88.single = {fire_rate = 60/450}
	-- svd
	self.siltstone.stats.damage = 550
	self.siltstone.CLIP_AMMO_MAX = 10
	self.siltstone.NR_CLIPS_MAX = 4
	self.siltstone.AMMO_MAX = self.siltstone.CLIP_AMMO_MAX * self.siltstone.NR_CLIPS_MAX
	self.siltstone.AMMO_PICKUP = {1.25,1.99}
	self.siltstone.stats.recoil = 8
	self.siltstone.stats.spread = 19
	self.siltstone.stats.spread_moving = 17
	self.siltstone.fire_mode_data = {fire_rate = 60/450}
	self.siltstone.single = {fire_rate = 60/450}
	-- 308
	self.tti.stats.damage = 550
	self.tti.CLIP_AMMO_MAX = 20
	self.tti.NR_CLIPS_MAX = 4
	self.tti.AMMO_MAX = self.tti.CLIP_AMMO_MAX * self.tti.NR_CLIPS_MAX
	self.tti.AMMO_PICKUP = {1.25,1.99}
	self.tti.stats.recoil = 9
	self.tti.stats.spread = 17
	self.tti.stats.spread_moving = 15
	self.tti.fire_mode_data = {fire_rate = 60/450}
	self.tti.single = {fire_rate = 60/450}
	
	self.wa2000.stats.damage = 550
	self.wa2000.CLIP_AMMO_MAX = 15
	self.wa2000.NR_CLIPS_MAX = 4
	self.wa2000.AMMO_MAX = self.wa2000.CLIP_AMMO_MAX * self.wa2000.NR_CLIPS_MAX
	self.wa2000.AMMO_PICKUP = {1.25,1.99}
	self.wa2000.stats.recoil = 3
	self.wa2000.stats.spread = 20
	self.wa2000.stats.spread_moving = 18
	self.wa2000.fire_mode_data = {fire_rate = 60/450}
	self.wa2000.single = {fire_rate = 60/450}
	
	-- Lever action
	self.winchester1874.stats.damage = 630/2
	self.winchester1874.CLIP_AMMO_MAX = 15
	self.winchester1874.NR_CLIPS_MAX = 3
	self.winchester1874.AMMO_MAX = self.winchester1874.CLIP_AMMO_MAX * self.winchester1874.NR_CLIPS_MAX
	self.winchester1874.AMMO_PICKUP = {1,2.1}
	self.winchester1874.stats.recoil = 13
	self.winchester1874.stats.spread = 22
	self.winchester1874.stats.spread_moving = 20
	self.winchester1874.fire_mode_data = {fire_rate = 60/100}
	self.winchester1874.single = {fire_rate = 60/100}
	
	self.sbl.stats.damage = 630/2
	self.sbl.CLIP_AMMO_MAX = 10
	self.sbl.NR_CLIPS_MAX = 5
	self.sbl.AMMO_MAX = self.sbl.CLIP_AMMO_MAX * self.sbl.NR_CLIPS_MAX
	self.sbl.AMMO_PICKUP = {1,2.1}
	self.sbl.stats.recoil = 13
	self.sbl.stats.spread = 22
	self.sbl.stats.spread_moving = 20
	self.sbl.fire_mode_data = {fire_rate = 60/120}
	self.sbl.single = {fire_rate = 60/120}
	
	-- Bolties
	self.mosin.stats.damage = 1260/4
	self.mosin.CLIP_AMMO_MAX = 5
	self.mosin.NR_CLIPS_MAX = 8
	self.mosin.AMMO_MAX = self.mosin.CLIP_AMMO_MAX * self.mosin.NR_CLIPS_MAX
	self.mosin.AMMO_PICKUP = {0.7,1}
	self.mosin.stats.recoil = 7
	self.mosin.stats.spread = 24
	self.mosin.stats.spread_moving = 23
	self.mosin.fire_mode_data = {fire_rate = 60/60}
	self.mosin.single = {fire_rate = 60/60}
	
	self.r93.stats.damage = 1260/4
	self.r93.CLIP_AMMO_MAX = 6
	self.r93.NR_CLIPS_MAX = 6
	self.r93.AMMO_MAX = self.r93.CLIP_AMMO_MAX * self.r93.NR_CLIPS_MAX
	self.r93.AMMO_PICKUP = {0.7,1}
	self.r93.stats.recoil = 7
	self.r93.stats.spread = 23
	self.r93.stats.spread_moving = 22
	self.r93.fire_mode_data = {fire_rate = 60/60}
	self.r93.single = {fire_rate = 60/60}
	
	self.model70.stats.damage = 1260/4
	self.model70.CLIP_AMMO_MAX = 5
	self.model70.NR_CLIPS_MAX = 8
	self.model70.AMMO_MAX = self.model70.CLIP_AMMO_MAX * self.model70.NR_CLIPS_MAX
	self.model70.AMMO_PICKUP = {0.7,1}
	self.model70.stats.recoil = 7
	self.model70.stats.spread = 24
	self.model70.stats.spread_moving = 23
	self.model70.fire_mode_data = {fire_rate = 60/60}
	self.model70.single = {fire_rate = 60/60}
	
	self.desertfox.stats.damage = 1260/4
	self.desertfox.CLIP_AMMO_MAX = 5
	self.desertfox.NR_CLIPS_MAX = 8
	self.desertfox.AMMO_MAX = self.desertfox.CLIP_AMMO_MAX * self.desertfox.NR_CLIPS_MAX
	self.desertfox.AMMO_PICKUP = {0.7,1}
	self.desertfox.stats.recoil = 9
	self.desertfox.stats.spread = 17
	self.desertfox.stats.spread_moving = 15
	self.desertfox.fire_mode_data = {fire_rate = 60/60}
	self.desertfox.single = {fire_rate = 60/60}
	
	self.msr.stats.damage = 1260/2
	self.msr.CLIP_AMMO_MAX = 10
	self.msr.NR_CLIPS_MAX = 4
	self.msr.AMMO_MAX = self.msr.CLIP_AMMO_MAX * self.msr.NR_CLIPS_MAX
	self.msr.AMMO_PICKUP = {0.7,1}
	self.msr.stats.recoil = 11
	self.msr.stats.spread = 23
	self.msr.stats.spread_moving = 21
	self.msr.fire_mode_data = {fire_rate = 60/50}
	self.msr.single = {fire_rate = 60/50}
	
	self.r700.stats.damage = 1260/2
	self.r700.CLIP_AMMO_MAX = 10
	self.r700.NR_CLIPS_MAX = 4
	self.r700.AMMO_MAX = self.r700.CLIP_AMMO_MAX * self.r700.NR_CLIPS_MAX
	self.r700.AMMO_PICKUP = {0.7,1}
	self.r700.stats.recoil = 11
	self.r700.stats.spread = 22
	self.r700.stats.spread_moving = 20
	self.r700.fire_mode_data = {fire_rate = 60/50}
	self.r700.single = {fire_rate = 60/50}

	-- Ze big dick gun
	self.m95.stats.damage = 230
	self.m95.AMMO_PICKUP = {0.03,0.68}

	-- Secondary bolty
	self.scout.stats.damage = 630/2
	self.scout.NR_CLIPS_MAX = 6
	self.scout.AMMO_MAX = self.scout.CLIP_AMMO_MAX * self.scout.NR_CLIPS_MAX
	self.scout.fire_mode_data = {fire_rate = 60/80}
	self.scout.single = {fire_rate = 60/80}





	-- Sub machine guns --
	-- Switch their stats based on my preferences lmao, but in general slower the ROF, higher the dmg
	
	
	
	
	
	-- 1-2 headshot kill
	local high_smg_ids = {
		"m45",
		"hajk",
		"olympic",
		"schakal",
		"erma",
		"sterling"
	}
	
	for _, gun in ipairs(high_smg_ids) do
		if self[gun] then
			self[gun].stats.damage = 210
			self[gun].AMMO_MAX = 120
			self[gun].NR_CLIPS_MAX = self[gun].AMMO_MAX / self[gun].CLIP_AMMO_MAX -- does this stat even do anything? its only used to calculate max ammo in base game, why is it so weird
			self[gun].AMMO_PICKUP = {1.23,2.1}
		end
	end
	
	self.m45.stats.reload = 15
	
	self.schakal.CLIP_AMMO_MAX = 25
	self.schakal.NR_CLIPS_MAX = self.schakal.AMMO_MAX / self.schakal.CLIP_AMMO_MAX
	
	self.sterling.stats.spread = 23
	self.sterling.stats.spread_moving = 21
	
	-- akimbo versions
	for _, gun in ipairs(high_smg_ids) do
		if self["x_"..gun] then
			self["x_"..gun].stats.damage = 210
			self["x_"..gun].AMMO_MAX = 150
			self["x_"..gun].NR_CLIPS_MAX = self["x_"..gun].AMMO_MAX / self["x_"..gun].CLIP_AMMO_MAX
			self["x_"..gun].AMMO_PICKUP[1] = self[gun].AMMO_PICKUP[1] * 1.4
			self["x_"..gun].AMMO_PICKUP[2] = self[gun].AMMO_PICKUP[2] * 1.4
		end
	end
	
	self.x_schakal.CLIP_AMMO_MAX = 50
	self.x_schakal.NR_CLIPS_MAX = self.x_schakal.AMMO_MAX / self.x_schakal.CLIP_AMMO_MAX
	
	self.x_sterling.stats.spread = 23
	self.x_sterling.stats.spread_moving = 21
	
	-- 2-3 headshot kill
	local avg_low_smg_ids = {
		"vityaz",
		"new_mp5",
		"m1928",
		"shepheard",
		"sr2",
		"coal",
		"uzi"
	}
	
	for _, gun in ipairs(avg_low_smg_ids) do
		if self[gun] then
			self[gun].stats.damage = 146
			self[gun].AMMO_MAX = 150
			self[gun].NR_CLIPS_MAX = self[gun].AMMO_MAX / self[gun].CLIP_AMMO_MAX
			self[gun].AMMO_PICKUP = {2.6,4.36}
		end
	end
	
	self.shepheard.stats.reload = 14
	
	self.coal.AMMO_MAX = 128
	self.coal.NR_CLIPS_MAX = self.coal.AMMO_MAX / self.coal.CLIP_AMMO_MAX
	self.coal.stats.reload = 9
	
	self.uzi.stats.spread = 19
	self.uzi.stats.spread_moving = 17
	
	-- akimbo versions
	for _, gun in ipairs(avg_low_smg_ids) do
		if self["x_"..gun] then
			self["x_"..gun].stats.damage = 146
			self["x_"..gun].AMMO_MAX = 180
			self["x_"..gun].NR_CLIPS_MAX = self["x_"..gun].AMMO_MAX / self["x_"..gun].CLIP_AMMO_MAX
			self["x_"..gun].AMMO_PICKUP[1] = self[gun].AMMO_PICKUP[1] * 1.4
			self["x_"..gun].AMMO_PICKUP[2] = self[gun].AMMO_PICKUP[2] * 1.4
		end
	end
	
	self.x_mp5.stats.damage = 146
	self.x_mp5.AMMO_MAX = 180
	self.x_mp5.NR_CLIPS_MAX = self.x_mp5.AMMO_MAX / self.x_mp5.CLIP_AMMO_MAX
	self.x_mp5.AMMO_PICKUP[1] = self.new_mp5.AMMO_PICKUP[1] * 1.4
	self.x_mp5.AMMO_PICKUP[2] = self.new_mp5.AMMO_PICKUP[2] * 1.4
	
	self.x_uzi.stats.spread = 19
	self.x_uzi.stats.spread_moving = 17
	
	-- 2-4 headshot kill
	local avg_high_smg_ids = {
		"mp7",
		"akmsu",
		"tec9",
		"polymer"
	}
	
	for _, gun in ipairs(avg_high_smg_ids) do
		if self[gun] then
			self[gun].stats.damage = 117
			self[gun].AMMO_MAX = 180
			self[gun].NR_CLIPS_MAX = self[gun].AMMO_MAX / self[gun].CLIP_AMMO_MAX
			self[gun].AMMO_PICKUP = {3.0,4.78}
		end
	end
	
	-- akimbo versions
	for _, gun in ipairs(avg_high_smg_ids) do
		if self["x_"..gun] then
			self["x_"..gun].stats.damage = 117
			self["x_"..gun].AMMO_MAX = 210
			self["x_"..gun].NR_CLIPS_MAX = self["x_"..gun].AMMO_MAX / self["x_"..gun].CLIP_AMMO_MAX
			self["x_"..gun].AMMO_PICKUP[1] = self[gun].AMMO_PICKUP[1] * 1.4
			self["x_"..gun].AMMO_PICKUP[2] = self[gun].AMMO_PICKUP[2] * 1.4
		end
	end
	
	
	
	-- 3-5 headshot kill
	local low_smg_ids = {
		"mac10",
		"cobray",
		"fmg9",
		"pm9",
		"scorpion",
		"mp9",
		"baka",
		"p90"
	}
	
	for _, gun in ipairs(low_smg_ids) do
		if self[gun] then
			self[gun].stats.damage = 95
			self[gun].AMMO_MAX = 210
			self[gun].NR_CLIPS_MAX = self[gun].AMMO_MAX / self[gun].CLIP_AMMO_MAX
			self[gun].AMMO_PICKUP = {3.79,5.89}
		end
	end
	
	self.fmg9.stats.spread = 11
	self.fmg9.stats.spread_moving = 9
	
	-- akimbo versions
	for _, gun in ipairs(low_smg_ids) do
		if self["x_"..gun] then
			self["x_"..gun].stats.damage = 95
			self["x_"..gun].AMMO_MAX = 240
			self["x_"..gun].NR_CLIPS_MAX = self["x_"..gun].AMMO_MAX / self["x_"..gun].CLIP_AMMO_MAX
			self["x_"..gun].AMMO_PICKUP[1] = self[gun].AMMO_PICKUP[1] * 1.4
			self["x_"..gun].AMMO_PICKUP[2] = self[gun].AMMO_PICKUP[2] * 1.4
		end
	end
	
	
	
	
	
	-- Pistols --
	
	
	
	
	
	-- 3-6 headshot kill
	self.beer.stats.damage = 77
	self.beer.AMMO_PICKUP = {3.29,4.79}
	self.beer.auto.fire_rate = self.beer.auto.fire_rate * 0.8
	self.beer.fire_mode_data.fire_rate = self.beer.fire_mode_data.fire_rate * 0.8
	
	self.x_beer.stats.damage = 77
	self.x_beer.AMMO_PICKUP[1] = self.beer.AMMO_PICKUP[1] * 1.3
	self.x_beer.AMMO_PICKUP[2] = self.beer.AMMO_PICKUP[2] * 1.3
	self.x_beer.single.fire_rate = self.x_beer.single.fire_rate * 0.8
	self.x_beer.fire_mode_data.fire_rate = self.x_beer.fire_mode_data.fire_rate * 0.8
	-- 3-5 headshot kill
	local low_pistol_ids = {
		"glock_18c",
		"czech"
	}
	
	for _, gun in ipairs(low_pistol_ids) do
		if self[gun] then
			self[gun].stats.damage = 95
			self[gun].AMMO_MAX = 150
			if self[gun].fire_mode_data then
				self[gun].fire_mode_data.fire_rate = self[gun].fire_mode_data.fire_rate * 0.8
			end
			if self[gun].single then
				self[gun].single.fire_rate = self[gun].single.fire_rate * 0.8
			end
			if self[gun].auto then
				self[gun].auto.fire_rate = self[gun].auto.fire_rate * 0.8
			end
			self[gun].NR_CLIPS_MAX = self[gun].AMMO_MAX / self[gun].CLIP_AMMO_MAX
			self[gun].AMMO_PICKUP = {2.99,4.37}
		end
	end
	
	-- akimbo versions
	for _, gun in ipairs(low_pistol_ids) do
		if self["x_"..gun] then
			self["x_"..gun].stats.damage = 95
			self["x_"..gun].AMMO_MAX = 200
			if self["x_"..gun].fire_mode_data then
				self["x_"..gun].fire_mode_data.fire_rate = self["x_"..gun].fire_mode_data.fire_rate * 0.8
			end
			if self["x_"..gun].single then
				self["x_"..gun].single.fire_rate = self["x_"..gun].single.fire_rate * 0.8
			end
			if self["x_"..gun].auto then
				self["x_"..gun].auto.fire_rate = self["x_"..gun].auto.fire_rate * 0.8
			end
			self["x_"..gun].NR_CLIPS_MAX = self["x_"..gun].AMMO_MAX / self["x_"..gun].CLIP_AMMO_MAX
			self["x_"..gun].AMMO_PICKUP[1] = self[gun].AMMO_PICKUP[1] * 1.3
			self["x_"..gun].AMMO_PICKUP[2] = self[gun].AMMO_PICKUP[2] * 1.3
		end
	end
	
	-- some akimbos have slighlty different names such as this glock 18, so we have to override them seperatly
	self.x_g18c.stats.damage = 95
	self.x_g18c.AMMO_MAX = 200
	self.x_g18c.fire_mode_data.fire_rate = self.x_g18c.fire_mode_data.fire_rate * 0.8
	self.x_g18c.single.fire_rate = self.x_g18c.single.fire_rate * 0.8
	self.x_g18c.NR_CLIPS_MAX = self.x_g18c.AMMO_MAX / self.x_g18c.CLIP_AMMO_MAX
	self.x_g18c.AMMO_PICKUP[1] = self.glock_18c.AMMO_PICKUP[1] * 1.3
	self.x_g18c.AMMO_PICKUP[2] = self.glock_18c.AMMO_PICKUP[2] * 1.3
	
	-- 2-4 headshot kill
	local mid_pistol_ids = {
		"glock_17",
		"ppk",
		"b92fs",
		"legacy",
		"g26",
		"shrew",
		"stech"
	}
	
	for _, gun in ipairs(mid_pistol_ids) do
		if self[gun] then
			self[gun].stats.damage = 117
			self[gun].AMMO_MAX = 160
			if self[gun].fire_mode_data then
				self[gun].fire_mode_data.fire_rate = self[gun].fire_mode_data.fire_rate * 0.8
			end
			if self[gun].single then
				self[gun].single.fire_rate = self[gun].single.fire_rate * 0.8
			end
			if self[gun].auto then
				self[gun].auto.fire_rate = self[gun].auto.fire_rate * 0.8
			end
			self[gun].NR_CLIPS_MAX = self[gun].AMMO_MAX / self[gun].CLIP_AMMO_MAX
			self[gun].AMMO_PICKUP = {2.4375,3.8025}
		end
	end
	
	-- why does this one have such a special name lmao
	self.jowi.stats.damage = 117
	self.jowi.AMMO_MAX = 160
	self.jowi.fire_mode_data.fire_rate = self.jowi.fire_mode_data.fire_rate * 0.8
	self.jowi.single.fire_rate = self.jowi.single.fire_rate * 0.8
	self.jowi.NR_CLIPS_MAX = self.jowi.AMMO_MAX / self.jowi.CLIP_AMMO_MAX
	self.jowi.AMMO_PICKUP[1] = self.g26.AMMO_PICKUP[1] * 1.3
	self.jowi.AMMO_PICKUP[2] = self.g26.AMMO_PICKUP[2] * 1.3
	
	-- akimbo versions
	for _, gun in ipairs(mid_pistol_ids) do
		if self["x_"..gun] then
			self["x_"..gun].stats.damage = 117
			self["x_"..gun].AMMO_MAX = 220
			if self["x_"..gun].fire_mode_data then
				self["x_"..gun].fire_mode_data.fire_rate = self["x_"..gun].fire_mode_data.fire_rate * 0.8
			end
			if self["x_"..gun].single then
				self["x_"..gun].single.fire_rate = self["x_"..gun].single.fire_rate * 0.8
			end
			if self["x_"..gun].auto then
				self["x_"..gun].auto.fire_rate = self["x_"..gun].auto.fire_rate * 0.8
			end
			self["x_"..gun].NR_CLIPS_MAX = self["x_"..gun].AMMO_MAX / self["x_"..gun].CLIP_AMMO_MAX
			self["x_"..gun].AMMO_PICKUP[1] = self[gun].AMMO_PICKUP[1] * 1.3
			self["x_"..gun].AMMO_PICKUP[2] = self[gun].AMMO_PICKUP[2] * 1.3
		end
	end
	
	self.x_g17.stats.damage = 117
	self.x_g17.AMMO_MAX = 220
	self.x_g17.fire_mode_data.fire_rate = self.x_g17.fire_mode_data.fire_rate * 0.8
	self.x_g17.single.fire_rate = self.x_g17.single.fire_rate * 0.8
	self.x_g17.NR_CLIPS_MAX = self.x_g17.AMMO_MAX / self.x_g17.CLIP_AMMO_MAX
	self.x_g17.AMMO_PICKUP[1] = self.glock_17.AMMO_PICKUP[1] * 1.3
	self.x_g17.AMMO_PICKUP[2] = self.glock_17.AMMO_PICKUP[2] * 1.3
	
	-- 2-3 headshot kill
	local upper_mid_pistol_ids = {
		"usp",
		"p226",
		"colt_1911",
		"maxim9",
		"g22c",
		"c96",
		"type54",
		"packrat",
		"lemming",
		"hs2000",
		"holt",
	}
	
	for _, gun in ipairs(upper_mid_pistol_ids) do
		if self[gun] then
			self[gun].stats.damage = 140
			self[gun].AMMO_MAX = 120
			if self[gun].fire_mode_data then
				self[gun].fire_mode_data.fire_rate = self[gun].fire_mode_data.fire_rate * 0.8
			end
			if self[gun].single then
				self[gun].single.fire_rate = self[gun].single.fire_rate * 0.8
			end
			if self[gun].auto then
				self[gun].auto.fire_rate = self[gun].auto.fire_rate * 0.8
			end
			self[gun].NR_CLIPS_MAX = self[gun].AMMO_MAX / self[gun].CLIP_AMMO_MAX
			self[gun].AMMO_PICKUP = {2.2125,3.615}
		end
	end
	self.lemming.AMMO_MAX = 75
	self.lemming.AMMO_PICKUP = {1.2,1.9}
	self.lemming.fire_mode_data.fire_rate = 0.1 -- why does it even have such high base rof?
	self.lemming.single.fire_rate = 0.1

	-- akimbo versions
	for _, gun in ipairs(upper_mid_pistol_ids) do
		if self["x_"..gun] then
			self["x_"..gun].stats.damage = 140
			self["x_"..gun].AMMO_MAX = 180
			if self["x_"..gun].fire_mode_data then
				self["x_"..gun].fire_mode_data.fire_rate = self["x_"..gun].fire_mode_data.fire_rate * 0.8
			end
			if self["x_"..gun].single then
				self["x_"..gun].single.fire_rate = self["x_"..gun].single.fire_rate * 0.8
			end
			if self["x_"..gun].auto then
				self["x_"..gun].auto.fire_rate = self["x_"..gun].auto.fire_rate * 0.8
			end
			self["x_"..gun].NR_CLIPS_MAX = self["x_"..gun].AMMO_MAX / self["x_"..gun].CLIP_AMMO_MAX
			self["x_"..gun].AMMO_PICKUP[1] = self[gun].AMMO_PICKUP[1] * 1.3
			self["x_"..gun].AMMO_PICKUP[2] = self[gun].AMMO_PICKUP[2] * 1.3
		end
	end
	
	self.x_1911.stats.damage = 140
	self.x_1911.AMMO_MAX = 180
	self.x_1911.fire_mode_data.fire_rate = self.x_1911.fire_mode_data.fire_rate * 0.8
	self.x_1911.single.fire_rate = self.x_1911.single.fire_rate * 0.8
	self.x_1911.NR_CLIPS_MAX = self.x_1911.AMMO_MAX / self.x_1911.CLIP_AMMO_MAX
	self.x_1911.AMMO_PICKUP[1] = self.colt_1911.AMMO_PICKUP[1] * 1.3
	self.x_1911.AMMO_PICKUP[2] = self.colt_1911.AMMO_PICKUP[2] * 1.3
	
	-- 1-2 headshot kill
	local heavy_pistol_ids = {
		"m1911",
		"pl14",
		"sparrow",
		"deagle",
		"breech"
	}
	
	for _, gun in ipairs(heavy_pistol_ids) do
		if self[gun] then
			self[gun].stats.damage = 210
			self[gun].AMMO_MAX = 80
			if self[gun].fire_mode_data then
				self[gun].fire_mode_data.fire_rate = self[gun].fire_mode_data.fire_rate * 0.8
			end
			if self[gun].single then
				self[gun].single.fire_rate = self[gun].single.fire_rate * 0.8
			end
			if self[gun].auto then
				self[gun].auto.fire_rate = self[gun].auto.fire_rate * 0.8
			end
			self[gun].NR_CLIPS_MAX = self[gun].AMMO_MAX / self[gun].CLIP_AMMO_MAX
			self[gun].AMMO_PICKUP = {1.1025,2.0025}
		end
	end
	
	-- akimbo versions
	for _, gun in ipairs(heavy_pistol_ids) do
		if self["x_"..gun] then
			self["x_"..gun].stats.damage = 210
			self["x_"..gun].AMMO_MAX = 120
			if self["x_"..gun].fire_mode_data then
				self["x_"..gun].fire_mode_data.fire_rate = self["x_"..gun].fire_mode_data.fire_rate * 0.8
			end
			if self["x_"..gun].single then
				self["x_"..gun].single.fire_rate = self["x_"..gun].single.fire_rate * 0.8
			end
			if self["x_"..gun].auto then
				self["x_"..gun].auto.fire_rate = self["x_"..gun].auto.fire_rate * 0.8
			end
			self["x_"..gun].NR_CLIPS_MAX = self["x_"..gun].AMMO_MAX / self["x_"..gun].CLIP_AMMO_MAX
			self["x_"..gun].AMMO_PICKUP[1] = self[gun].AMMO_PICKUP[1] * 1.3
			self["x_"..gun].AMMO_PICKUP[2] = self[gun].AMMO_PICKUP[2] * 1.3
		end
	end
	
	-- 1-1 headshot kill, mostly revolvers
	local heavy_pistol_ids = {
		"new_raging_bull",
		"chinchilla",
		"mateba",
		"model3",
		"rsh12",
		"korth",
	}
	
	for _, gun in ipairs(heavy_pistol_ids) do
		if self[gun] then
			self[gun].stats.damage = 420
			self[gun].AMMO_MAX = 40
			if self[gun].fire_mode_data then
				self[gun].fire_mode_data.fire_rate = self[gun].fire_mode_data.fire_rate * 0.8
			end
			if self[gun].single then
				self[gun].single.fire_rate = self[gun].single.fire_rate * 0.8
			end
			if self[gun].auto then
				self[gun].auto.fire_rate = self[gun].auto.fire_rate * 0.8
			end
			self[gun].NR_CLIPS_MAX = self[gun].AMMO_MAX / self[gun].CLIP_AMMO_MAX
			self[gun].AMMO_PICKUP = {0.73,1.23}
		end
	end
	
	self.korth.fire_mode_data.fire_rate = 0.12
	self.korth.stats.spread = 15
	self.korth.single.fire_rate = 0.12
	
	self.rsh12.AMMO_PICKUP = {0.4475,0.8225}
	self.rsh12.stats.damage = 210 -- why do you fuck me with your damage multipliers overkilllllllllllllllll
	
	-- akimbo versions
	for _, gun in ipairs(heavy_pistol_ids) do
		if self["x_"..gun] then
			self["x_"..gun].stats.damage = 420
			self["x_"..gun].AMMO_MAX = 74
			if self["x_"..gun].fire_mode_data then
				self["x_"..gun].fire_mode_data.fire_rate = self["x_"..gun].fire_mode_data.fire_rate * 0.8
			end
			if self["x_"..gun].single then
				self["x_"..gun].single.fire_rate = self["x_"..gun].single.fire_rate * 0.8
			end
			if self["x_"..gun].auto then
				self["x_"..gun].auto.fire_rate = self["x_"..gun].auto.fire_rate * 0.8
			end
			self["x_"..gun].NR_CLIPS_MAX = self["x_"..gun].AMMO_MAX / self["x_"..gun].CLIP_AMMO_MAX
			self["x_"..gun].AMMO_PICKUP[1] = self[gun].AMMO_PICKUP[1] * 1.3
			self["x_"..gun].AMMO_PICKUP[2] = self[gun].AMMO_PICKUP[2] * 1.3
		end
	end
	
	self.x_2006m.stats.damage = 420
	self.x_2006m.AMMO_MAX = 74
	self.x_2006m.fire_mode_data.fire_rate = self.x_2006m.fire_mode_data.fire_rate * 0.8
	self.x_2006m.single.fire_rate = self.x_2006m.single.fire_rate * 0.8
	self.x_2006m.NR_CLIPS_MAX = self.x_2006m.AMMO_MAX / self.x_2006m.CLIP_AMMO_MAX
	self.x_2006m.AMMO_PICKUP[1] = self.mateba.AMMO_PICKUP[1] * 1.3
	self.x_2006m.AMMO_PICKUP[2] = self.mateba.AMMO_PICKUP[2] * 1.3
	
	self.x_rage.stats.damage = 420
	self.x_rage.fire_mode_data.fire_rate = self.x_rage.fire_mode_data.fire_rate * 0.8
	self.x_rage.single.fire_rate = self.x_rage.single.fire_rate * 0.8
	self.x_rage.AMMO_PICKUP[1] = self.new_raging_bull.AMMO_PICKUP[1] * 1.3
	self.x_rage.AMMO_PICKUP[2] = self.new_raging_bull.AMMO_PICKUP[2] * 1.3
	
	-- stop it with stupid pay to win stats on new weapons overkill
	self.x_korth.fire_mode_data.fire_rate = 60/452
	self.x_korth.single.fire_rate = 60/452
	
	
	
	-- 1 shot to the body on normal swats, 1 shot headshot on everyone else (except dozers)
	-- the most badass cowboy on the west
	self.peacemaker.stats.damage = 630/2
	self.peacemaker.AMMO_PICKUP = {0.638,1.076}
	self.peacemaker.auto.fire_rate = self.peacemaker.auto.fire_rate * 0.8
	self.peacemaker.single.fire_rate = self.peacemaker.single.fire_rate * 0.8
	self.peacemaker.fire_mode_data.fire_rate = self.peacemaker.fire_mode_data.fire_rate * 0.8
	
	--buff reload speeds for almost all GL since they are worse now
	self.slap.stats.reload = 13
	self.gre_m79.stats.reload = 13 -- god is it slow in the base game
	self.m32.stats.reload = 16
	self.arbiter.stats.reload = 13
	
	-- flammenwerfers --
	
	-- flamethrower afterburn changes, more details in weapon mods file
	self.flamethrower_mk2.fire_dot_data = {
		dot_trigger_chance = 0,
		dot_damage = 30,
		dot_length = 1.6,
		dot_trigger_max_distance = 3000,
		dot_tick_period = 0.5
	}
	self.flamethrower_mk2.stats.damage = 35
	self.flamethrower_mk2.stats.reload = 17
	self.flamethrower_mk2.CLIP_AMMO_MAX = 200
	self.flamethrower_mk2.NR_CLIPS_MAX = 2
	self.flamethrower_mk2.AMMO_PICKUP = {4.706,9.62}
	self.flamethrower_mk2.AMMO_MAX = self.flamethrower_mk2.CLIP_AMMO_MAX * self.flamethrower_mk2.NR_CLIPS_MAX
	
	-- secondary flammenwerfer
	self.system.fire_dot_data = {
		dot_trigger_chance = 0,
		dot_damage = 30,
		dot_length = 1.6,
		dot_trigger_max_distance = 3000,
		dot_tick_period = 0.5
	}
	self.system.stats.damage = 25
	self.system.stats.reload = 17
	self.system.CLIP_AMMO_MAX = 150
	self.system.NR_CLIPS_MAX = 2
	self.system.AMMO_PICKUP = {3.2942,6.734}
	self.system.AMMO_MAX = self.system.CLIP_AMMO_MAX * self.system.NR_CLIPS_MAX
	
	--miniguns--
	
	--the ovkl one
	self.m134.stats.damage = 45
	--the other one
	self.shuno.stats.damage = 68
	self.shuno.stats.recoil = self.shuno.stats.recoil + 2
	-- the 'minigun' that is hailstorm
	self.shuno.stats.damage = 76
	
	-- all grenade launchers.
	-- add new nades and adjust values for blackmarket ui, all the dmg stats are handled by projectile properties
	self.slap.stats.damage = 400
	self.slap.stats.spread = 24
	self.slap.projectile_types.launcher_velocity = "launcher_velocity_slap"
	self.gre_m79.stats.damage = 400
	self.gre_m79.projectile_types.launcher_velocity = "launcher_velocity"
	self.m32.stats.damage = 400
	self.m32.projectile_types.launcher_velocity = "launcher_velocity_m32"
	self.china.stats.damage = 400
	self.china.projectile_types.launcher_velocity = "launcher_velocity_china"
	self.ray.stats.damage = 82
	self.rpg7.stats.damage = 163
	self.ms3gl.stats.damage = 400
	self.arbiter.stats.damage = 200
	
	-- bows and such --
	
	--secondary pistol
	self.hunter.stats.damage = 72
	--light bow
	self.plainsrider.stats.damage = 72
	--light crossbow
	self.frankish.stats.damage = 72
	--longbow
	self.long.stats.damage = 16
	--DECA compouns
	self.elastic.stats.damage = 16
	--heavy crossbow
	self.arblast.stats.damage = 16
	--h3h3 shit
	self.ecp.stats.damage = 50
end)