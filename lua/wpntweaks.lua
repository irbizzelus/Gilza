Hooks:PostHook(WeaponTweakData, "_init_new_weapons", "Gilza_NewWeaponStats", function(self, tweak_data)
	if not Gilza then 
		_G.Gilza = {}
		Gilza._path = "mods/Gilza/"
		Gilza._guns_path = "mods/saves/Gilza_customguns.txt"
		dofile("mods/Gilza/lua/wpntweaks_custom.lua")
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
		"tkb",
		-- light machine guns
		"hk21",
		"mg42",
		"m249",
		"par",
		"rpk",
		"m60",
		"hk51b",
		"hcar",
		"kacchainsaw",
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
		"supernova",
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
		"contender",
		"victor",
		"awp",
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
	
	-- increase DMG for all weapons, before making unique adjustments
	for _, gun in ipairs(weapon_ids) do
		if self[gun] and self[gun].stats.damage then
			self[gun].stats.damage = math.floor(self[gun].stats.damage * 1.75)
		end
	end
	
	-- acc rework: gives 20% acc for ADS'ing and for crouching while standing still
	for _, gun in ipairs(weapon_ids) do
		if self[gun] and self[gun].spread.standing and self[gun].spread.steelsight and self[gun].spread.crouching and self[gun].spread.moving_standing and self[gun].spread.moving_crouching and self[gun].spread.moving_steelsight then
			self[gun].spread.standing = self[gun].spread.standing
			self[gun].spread.steelsight = self[gun].spread.standing * 0.8
			self[gun].spread.crouching = self[gun].spread.standing * 0.8
			self[gun].spread.moving_standing = self[gun].spread.standing
			self[gun].spread.moving_crouching = self[gun].spread.standing
			self[gun].spread.moving_steelsight = self[gun].spread.standing * 0.8
		end
	end
	
	local function TableConcat(t1,t2)
		for i=1,#t2 do
			t1[#t1+1] = t2[i]
		end
		return t1
	end
	local allguns = TableConcat(special_weapon_ids,weapon_ids)
	Gilza.defaultWeapons = {}
	-- converts numerised table into a basic one
	for i, j in ipairs(allguns) do
		table.insert(Gilza.defaultWeapons,j)
	end
	
	-- Assault rifles --
	local function setARs() -- just for the sake of readability
	
	-- listed in order of appearance in-game. at least for me
	self.amcar.stats.damage = 146
	self.amcar.CLIP_AMMO_MAX = 25
	self.amcar.NR_CLIPS_MAX = 8
	self.amcar.AMMO_MAX = self.amcar.CLIP_AMMO_MAX * self.amcar.NR_CLIPS_MAX
	self.amcar.AMMO_PICKUP = {3.111,4.35}
	self.amcar.fire_mode_data = {fire_rate = 60/630}
	self.amcar.auto = {fire_rate = 60/630}
	self.amcar.stats.recoil = 8
	
	self.s552.stats.damage = 146
	self.s552.NR_CLIPS_MAX = 6
	self.s552.AMMO_MAX = self.s552.CLIP_AMMO_MAX * self.s552.NR_CLIPS_MAX
	self.s552.AMMO_PICKUP = {3.111,4.35}
	self.s552.stats.recoil = 7
	self.s552.stats.spread = 12
	self.s552.fire_mode_data = {fire_rate = 60/735}
	self.s552.auto = {fire_rate = 60/735}
	
	self.scar.stats.damage = 420
	self.scar.CLIP_AMMO_MAX = 25
	self.scar.NR_CLIPS_MAX = 4
	self.scar.AMMO_MAX = self.scar.CLIP_AMMO_MAX * self.scar.NR_CLIPS_MAX
	self.scar.AMMO_PICKUP = {0.6937,1.294}
	self.scar.stats.spread = 18
	self.scar.stats.recoil = 9
	self.scar.fire_mode_data = {fire_rate = 60/600}
	self.scar.auto = {fire_rate = 60/600}
	
	self.corgi.stats.damage = 146
	self.corgi.NR_CLIPS_MAX = 4
	self.corgi.AMMO_MAX = self.corgi.CLIP_AMMO_MAX * self.corgi.NR_CLIPS_MAX
	self.corgi.auto = {fire_rate = 60/875}
	self.corgi.fire_mode_data = {fire_rate = 60/875}
	self.corgi.AMMO_PICKUP = {3.111,4.35}
	self.corgi.stats.recoil = 12
	self.corgi.stats.spread = 19
	self.corgi.stats.concealment = 15
	
	self.ak74.stats.damage = 210
	self.ak74.AMMO_PICKUP = {2.12,3.12}
	self.ak74.stats.spread = 12
	self.ak74.stats.recoil = 5
	
	self.new_m4.stats.damage = 177  -- 146 profile breakpoints on swats but tiny bit better on specials
	self.new_m4.AMMO_PICKUP = {2.8,3.73}
	self.new_m4.stats.recoil = 8
	self.new_m4.stats.spread = 12
	self.new_m4.NR_CLIPS_MAX = 6
	self.new_m4.AMMO_MAX = self.new_m4.CLIP_AMMO_MAX * self.new_m4.NR_CLIPS_MAX
	self.new_m4.fire_mode_data = {fire_rate = 60/570}
	self.new_m4.auto = {fire_rate = 60/570}
	
	self.aug.stats.damage = 210
	self.aug.stats.recoil = 9
	self.aug.stats.spread = 15
	self.aug.fire_mode_data = {fire_rate = 60/680}
	self.aug.auto = {fire_rate = 60/680}
	self.aug.AMMO_PICKUP = {2.12,3.12}
	
	self.groza.stats.damage = 210
	self.groza.AMMO_PICKUP = {1.46,2.15}
	
	self.sub2000.stats.damage = 210
	self.sub2000.AMMO_PICKUP = {2.12,3.12}
	self.sub2000.stats.spread = 21
	self.sub2000.fire_mode_data = {fire_rate = 60/320}
	self.sub2000.single = {fire_rate = 60/320}
	
	self.akm.stats.damage = 420
	self.akm.NR_CLIPS_MAX = 3
	self.akm.AMMO_MAX = self.akm.CLIP_AMMO_MAX * self.akm.NR_CLIPS_MAX
	self.akm.AMMO_PICKUP = {0.6937,1.294}
	self.akm.stats.recoil = 9
	self.akm.auto = {fire_rate = 60/540}
	self.akm.fire_mode_data = {fire_rate = 60/540}
	
	self.g36.stats.damage = 146
	self.g36.NR_CLIPS_MAX = 8
	self.g36.stats.spread = 5
	self.g36.AMMO_MAX = self.g36.CLIP_AMMO_MAX * self.g36.NR_CLIPS_MAX
	self.g36.AMMO_PICKUP = {3.111,4.35}
	self.g36.stats.recoil = 21
	self.g36.stats.concealment = 11
	self.g36.auto = {fire_rate = 60/750}
	self.g36.fire_mode_data = {fire_rate = 60/750}
	
	self.flint.stats.damage = 210
	self.flint.NR_CLIPS_MAX = 4
	self.flint.AMMO_MAX = self.flint.CLIP_AMMO_MAX * self.flint.NR_CLIPS_MAX
	self.flint.AMMO_PICKUP = {2.12,3.12}
	self.flint.stats.concealment = 11
	self.flint.stats.spread = 12
	self.flint.stats.recoil = 12
	
	self.akm_gold.stats.damage = 420
	self.akm_gold.NR_CLIPS_MAX = 3
	self.akm_gold.AMMO_MAX = self.akm_gold.CLIP_AMMO_MAX * self.akm_gold.NR_CLIPS_MAX
	self.akm_gold.AMMO_PICKUP = {0.6937,1.294}
	self.akm_gold.stats.recoil = 9
	self.akm_gold.auto = {fire_rate = 60/540}
	self.akm_gold.fire_mode_data = {fire_rate = 60/540}
	
	self.tecci.stats.damage = 177
	self.tecci.stats.recoil = 21
	self.tecci.stats.spread = 3
	self.tecci.AMMO_PICKUP = {2.8,3.73}
	self.tecci.fire_mode_data = {fire_rate = 60/640}
	self.tecci.auto = {fire_rate = 60/640}
	
	self.l85a2.stats.damage = 146
	self.l85a2.stats.reload = 15
	self.l85a2.stats.recoil = 15
	self.l85a2.NR_CLIPS_MAX = 5
	self.l85a2.AMMO_MAX = self.l85a2.CLIP_AMMO_MAX * self.l85a2.NR_CLIPS_MAX
	self.l85a2.AMMO_PICKUP = {3.111,4.35}
	
	self.ching.stats.damage = 420
	self.ching.stats.reload = 13
	self.ching.AMMO_PICKUP = {0.6937,1.294}
	
	self.new_m14.stats.damage = 420
	self.new_m14.stats.reload = 9
	self.new_m14.CLIP_AMMO_MAX = 15
	self.new_m14.NR_CLIPS_MAX = 5
	self.new_m14.AMMO_MAX = self.new_m14.CLIP_AMMO_MAX * self.new_m14.NR_CLIPS_MAX
	self.new_m14.AMMO_PICKUP = {0.6937,1.294}
	self.new_m14.fire_mode_data = {fire_rate = 60/600}
	self.new_m14.single = {fire_rate = 60/600}

	self.famas.stats.damage = 117
	self.famas.AMMO_PICKUP = {3.64,6.15}
	self.famas.stats.recoil = 18
	self.famas.stats.spread = 6
	
	self.vhs.stats.damage = 210
	self.vhs.stats.recoil = 22
	self.vhs.stats.spread = 7
	self.vhs.AMMO_PICKUP = {2.12,3.12}
	self.vhs.NR_CLIPS_MAX = 5
	self.vhs.AMMO_MAX = self.vhs.CLIP_AMMO_MAX * self.vhs.NR_CLIPS_MAX
	
	self.asval.stats.damage = 146
	self.asval.CLIP_AMMO_MAX = 20
	self.asval.NR_CLIPS_MAX = 6
	self.asval.AMMO_MAX = self.asval.CLIP_AMMO_MAX * self.asval.NR_CLIPS_MAX
	self.asval.AMMO_PICKUP = {3.111,4.35}
	self.asval.stats.spread = 23
	self.asval.stats.reload = 20
	self.asval.stats.recoil = 13
	self.asval.auto = {fire_rate = 60/900}
	self.asval.fire_mode_data = {fire_rate = 60/900}
	
	self.ak5.stats.damage = 117
	self.ak5.AMMO_PICKUP = {3.64,6.15}
	self.ak5.stats.recoil = 19
	self.ak5.stats.spread = 19
	
	self.galil.stats.damage = 210
	self.galil.stats.recoil = 17
	self.galil.stats.spread = 7
	self.galil.AMMO_PICKUP = {2.12,3.12}
	self.galil.NR_CLIPS_MAX = 4
	self.galil.AMMO_MAX = self.galil.CLIP_AMMO_MAX * self.galil.NR_CLIPS_MAX
	
	self.komodo.stats.damage = 117
	self.komodo.fire_mode_data = {fire_rate = 60/850}
	self.komodo.auto = {fire_rate = 60/850}
	self.komodo.stats.recoil = 15
	self.komodo.stats.spread = 15
	self.komodo.NR_CLIPS_MAX = 6
	self.komodo.AMMO_MAX = self.komodo.CLIP_AMMO_MAX * self.komodo.NR_CLIPS_MAX
	self.komodo.AMMO_PICKUP = {3.64,6.15}
	
	self.m16.stats.damage = 177
	self.m16.NR_CLIPS_MAX = 5
	self.m16.AMMO_MAX = self.m16.CLIP_AMMO_MAX * self.m16.NR_CLIPS_MAX
	self.m16.AMMO_PICKUP = {2.8,3.73}
	self.m16.stats.recoil = 1
	self.m16.stats.spread = 22
	self.m16.fire_mode_data = {fire_rate = 60/900}
	self.m16.auto = {fire_rate = 60/900}
	
	self.shak12.stats.damage = 420
	self.shak12.CLIP_AMMO_MAX = 25
	self.shak12.NR_CLIPS_MAX = 4
	self.shak12.AMMO_MAX = self.shak12.CLIP_AMMO_MAX * self.shak12.NR_CLIPS_MAX
	self.shak12.AMMO_PICKUP = {0.6937,1.294}
	self.shak12.stats.recoil = 12
	self.shak12.stats.spread = 17
	
	self.contraband.stats.damage = 420
	self.contraband.CLIP_AMMO_MAX = 25
	self.contraband.NR_CLIPS_MAX = 3
	self.contraband.AMMO_MAX = self.contraband.CLIP_AMMO_MAX * self.contraband.NR_CLIPS_MAX
	self.contraband.AMMO_PICKUP = {0.471,0.935}
	self.contraband.stats.recoil = 21
	self.contraband.stats.spread = 13
	self.contraband.fire_mode_data = {fire_rate = 60/600}
	self.contraband.auto = {fire_rate = 60/600}
	
	self.fal.stats.damage = 420
	self.fal.CLIP_AMMO_MAX = 20
	self.fal.NR_CLIPS_MAX = 5
	self.fal.AMMO_MAX = self.fal.CLIP_AMMO_MAX * self.fal.NR_CLIPS_MAX
	self.fal.AMMO_PICKUP = {0.6937,1.294}
	self.fal.stats.recoil = 6
	self.fal.stats.spread = 17
	self.fal.fire_mode_data = {fire_rate = 60/660}
	self.fal.auto = {fire_rate = 60/660}
	
	self.tkb.stats.damage = 146
	self.tkb.AMMO_PICKUP = {3.111,4.35}
	self.tkb.stats.spread = 2
	self.tkb.stats.concealment = 12
	
	self.g3.stats.damage = 210
	self.g3.CLIP_AMMO_MAX = 25
	self.g3.NR_CLIPS_MAX = 4
	self.g3.AMMO_MAX = self.g3.CLIP_AMMO_MAX * self.g3.NR_CLIPS_MAX
	self.g3.AMMO_PICKUP = {2.12,3.12}
	self.g3.stats.recoil = 16
	self.g3.stats.spread = 22
	end
	setARs()
	
	-- Shotguns --
	local function setSHOTGUNs()
	-- Pump --
	self.r870.stats.damage = 420
	self.r870.CLIP_AMMO_MAX = 6
	self.r870.NR_CLIPS_MAX = 7
	self.r870.AMMO_MAX = self.r870.CLIP_AMMO_MAX * self.r870.NR_CLIPS_MAX
	self.r870.AMMO_PICKUP = {0.57,0.97}
	self.r870.stats.recoil = 24
	self.r870.stats.spread = 25
	self.r870.fire_mode_data = {fire_rate = 60/90}
	self.r870.single = {fire_rate = 60/90}
	
	self.m590.stats.damage = 420
	self.m590.CLIP_AMMO_MAX = 5
	self.m590.NR_CLIPS_MAX = 9
	self.m590.AMMO_MAX = self.m590.CLIP_AMMO_MAX * self.m590.NR_CLIPS_MAX
	self.m590.AMMO_PICKUP = {0.57,0.97}
	self.m590.stats.recoil = 14
	self.m590.stats.spread = 11
	self.m590.fire_mode_data = {fire_rate = 60/115}
	self.m590.single = {fire_rate = 60/115}
	
	self.m1897.stats.damage = 420
	self.m1897.CLIP_AMMO_MAX = 8
	self.m1897.NR_CLIPS_MAX = 5
	self.m1897.AMMO_MAX = self.m1897.CLIP_AMMO_MAX * self.m1897.NR_CLIPS_MAX
	self.m1897.AMMO_PICKUP = {0.57,0.97}
	self.m1897.stats.recoil = 24
	self.m1897.stats.spread = 25
	self.m1897.stats.concealment = 15
	self.m1897.fire_mode_data = {fire_rate = 60/90}
	self.m1897.single = {fire_rate = 60/90}
	
	self.boot.stats.damage = 420
	self.boot.CLIP_AMMO_MAX = 7
	self.boot.NR_CLIPS_MAX = 6
	self.boot.AMMO_MAX = self.boot.CLIP_AMMO_MAX * self.boot.NR_CLIPS_MAX
	self.boot.AMMO_PICKUP = {0.57,0.97}
	self.boot.stats.recoil = 20
	self.boot.stats.spread = 25
	self.boot.fire_mode_data = {fire_rate = 60/90}
	self.boot.single = {fire_rate = 60/90}
	
	self.ksg.stats.damage = 420
	self.ksg.CLIP_AMMO_MAX = 14
	self.ksg.NR_CLIPS_MAX = 2
	self.ksg.AMMO_MAX = self.ksg.CLIP_AMMO_MAX * self.ksg.NR_CLIPS_MAX
	self.ksg.AMMO_PICKUP = {0.57,0.97}
	self.ksg.stats.recoil = 18
	self.ksg.stats.spread = 19
	self.ksg.fire_mode_data = {fire_rate = 60/90}
	self.ksg.single = {fire_rate = 60/90}
	
	-- mcshay 4
	self.supernova.stats.damage = 420
	self.supernova.NR_CLIPS_MAX = 7
	self.supernova.AMMO_MAX = self.supernova.CLIP_AMMO_MAX * self.supernova.NR_CLIPS_MAX
	self.supernova.AMMO_PICKUP = {0.57,0.97}
	self.supernova.stats.spread = 13
	self.supernova.fire_mode_data = {
		fire_rate = 60/70
	}
	self.supernova.single = {
		fire_rate = 60/70
	}
	self.supernova.alt_fire_data = {
		fire_rate = 60/280,
		spread_mul = 3,
		damage_mul = 1,
		shell_ejection = "effects/payday2/particles/weapons/shells/shell_slug",
		recoil_mul = 1.5,
		animations = {
			fire_steelsight = "recoil_steelsight_alt",
			fire = "recoil_alt"
		}
	}
	
	self.supernova.kick.standing = {
		2.3,
		2.5,
		-0.45,
		0.45
	}
	self.supernova.kick.crouching = self.supernova.kick.standing
	self.supernova.kick.steelsight = self.supernova.kick.standing
	
	-- Semi-auto --
	self.benelli.stats.damage = 305
	self.benelli.CLIP_AMMO_MAX = 8
	self.benelli.NR_CLIPS_MAX = 8
	self.benelli.AMMO_MAX = self.benelli.CLIP_AMMO_MAX * self.benelli.NR_CLIPS_MAX
	self.benelli.AMMO_PICKUP = {1.12,1.67}
	self.benelli.stats.recoil = 18
	self.benelli.stats.spread = 13
	self.benelli.fire_mode_data = {fire_rate = 60/360}
	self.benelli.single = {fire_rate = 60/360}
	
	self.spas12.stats.damage = 305
	self.spas12.CLIP_AMMO_MAX = 6
	self.spas12.NR_CLIPS_MAX = 11
	self.spas12.AMMO_MAX = self.spas12.CLIP_AMMO_MAX * self.spas12.NR_CLIPS_MAX
	self.spas12.AMMO_PICKUP = {1.12,1.67}
	self.spas12.stats.recoil = 18
	self.spas12.stats.spread = 13
	self.spas12.fire_mode_data = {fire_rate = 60/360}
	self.spas12.single = {fire_rate = 60/360}
	
	-- Double barrel --
	self.b682.stats.damage = 1250
	self.b682.CLIP_AMMO_MAX = 2
	self.b682.NR_CLIPS_MAX = 10
	self.b682.AMMO_MAX = self.b682.CLIP_AMMO_MAX * self.b682.NR_CLIPS_MAX
	self.b682.AMMO_PICKUP = {0.32,0.89}
	self.b682.stats.recoil = 25
	self.b682.stats.spread = 25
	self.b682.fire_mode_data = {fire_rate = 60/360}
	self.b682.single = {fire_rate = 60/360}
	
	self.huntsman.stats.damage = 1250
	self.huntsman.CLIP_AMMO_MAX = 2
	self.huntsman.NR_CLIPS_MAX = 13
	self.huntsman.AMMO_MAX = self.huntsman.CLIP_AMMO_MAX * self.huntsman.NR_CLIPS_MAX
	self.huntsman.AMMO_PICKUP = {0.32,0.89}
	self.huntsman.stats.recoil = 25
	self.huntsman.stats.spread = 25
	self.huntsman.fire_mode_data = {fire_rate = 60/360}
	self.huntsman.single = {fire_rate = 60/360}
	
	-- Full auto --
	self.saiga.stats.damage = 110
	self.saiga.CLIP_AMMO_MAX = 7
	self.saiga.NR_CLIPS_MAX = 7
	self.saiga.AMMO_MAX = self.saiga.CLIP_AMMO_MAX * self.saiga.NR_CLIPS_MAX
	self.saiga.AMMO_PICKUP = {2.8,4.2}
	self.saiga.stats.recoil = 8
	self.saiga.stats.spread = 4
	self.saiga.fire_mode_data = {fire_rate = 60/360}
	self.saiga.single = {fire_rate = 60/360}
	
	self.aa12.stats.damage = 110
	self.aa12.CLIP_AMMO_MAX = 8
	self.aa12.NR_CLIPS_MAX = 8
	self.aa12.AMMO_MAX = self.aa12.CLIP_AMMO_MAX * self.aa12.NR_CLIPS_MAX
	self.aa12.AMMO_PICKUP = {2.8,4.2}
	self.aa12.stats.recoil = 8
	self.aa12.stats.spread = 4
	self.aa12.stats.concealment = 20
	self.aa12.fire_mode_data = {fire_rate = 60/360}
	self.aa12.single = {fire_rate = 60/360}
	
	self.sko12.stats.damage = 110
	self.sko12.AMMO_PICKUP = {2.8,4.2}
	self.sko12.stats.recoil = 8
	self.sko12.stats.spread = 7
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
	self.serbu.AMMO_PICKUP = {0.44,0.72}
	self.serbu.stats.recoil = 8
	self.serbu.stats.spread = 10
	self.serbu.fire_mode_data = {fire_rate = 60/90}
	self.serbu.single = {fire_rate = 60/90}
	
	self.m37.stats.damage = 420
	self.m37.CLIP_AMMO_MAX = 7
	self.m37.NR_CLIPS_MAX = 4
	self.m37.AMMO_MAX = self.m37.CLIP_AMMO_MAX * self.m37.NR_CLIPS_MAX
	self.m37.AMMO_PICKUP = {0.44,0.72}
	self.m37.stats.recoil = 11
	self.m37.stats.spread = 7
	self.m37.fire_mode_data = {fire_rate = 60/100}
	self.m37.single = {fire_rate = 60/100}
	
	self.coach.stats.damage = 1250
	self.coach.CLIP_AMMO_MAX = 2
	self.coach.NR_CLIPS_MAX = 10
	self.coach.AMMO_MAX = self.coach.CLIP_AMMO_MAX * self.coach.NR_CLIPS_MAX
	self.coach.AMMO_PICKUP = {0.23,0.73}
	self.coach.stats.recoil = 10
	self.coach.stats.spread = 19
	self.coach.fire_mode_data = {fire_rate = 60/360}
	self.coach.single = {fire_rate = 60/360}

	self.rota.stats.damage = 110
	self.rota.AMMO_PICKUP = {2.16,3.2}
	self.rota.stats.recoil = 10
	self.rota.stats.spread = 6
	self.rota.stats.reload = 15
	self.rota.fire_mode_data = {fire_rate = 60/360}
	self.rota.single = {fire_rate = 60/360}
	
	self.x_rota.stats.damage = 110
	self.x_rota.AMMO_PICKUP = {2.8,4.2}
	self.x_rota.stats.recoil = 5
	self.x_rota.stats.spread = 1
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
	self.x_basset.fire_mode_data = {fire_rate = 60/300}
	self.x_basset.single = {fire_rate = 60/300}
	
	self.basset.stats.damage = 110
	self.basset.CLIP_AMMO_MAX = 7
	self.basset.NR_CLIPS_MAX = 7
	self.basset.AMMO_MAX = self.basset.CLIP_AMMO_MAX * self.basset.NR_CLIPS_MAX
	self.basset.AMMO_PICKUP = {2.16,3.2}
	self.basset.stats.recoil = 10
	self.basset.stats.spread = 6
	self.basset.fire_mode_data = {fire_rate = 60/300}
	self.basset.single = {fire_rate = 60/300}
	
	self.striker.stats.damage = 305
	self.striker.CLIP_AMMO_MAX = 12
	self.striker.NR_CLIPS_MAX = 4
	self.striker.AMMO_MAX = self.striker.CLIP_AMMO_MAX * self.striker.NR_CLIPS_MAX
	self.striker.AMMO_PICKUP = {0.79,1.19}
	self.striker.stats.recoil = 14
	self.striker.stats.spread = 9
	self.striker.fire_mode_data = {fire_rate = 60/360}
	self.striker.single = {fire_rate = 60/360}
	
	self.ultima.stats.damage = 305
	self.ultima.AMMO_PICKUP = {0.79,1.19}
	self.ultima.stats.recoil = 14
	self.ultima.stats.spread = 9
	self.ultima.fire_mode_data = {fire_rate = 60/360}
	self.ultima.single = {fire_rate = 60/360}
	
	self.judge.stats.damage = 305
	self.judge.AMMO_PICKUP = {0.79,1.19}
	self.judge.stats.recoil = 1
	self.judge.stats.spread = 1
	self.judge.fire_mode_data = {fire_rate = 60/360}
	self.judge.single = {fire_rate = 60/360}
	-- fuck your shotgun pistol, irl its barely usable why tf should it be any other way here
	self.judge.kick = {
		standing = {
			4.3,
			4.9,
			-0.7,
			0.9
		}
	}
	self.judge.kick.crouching = self.judge.kick.standing
	self.judge.kick.steelsight = self.judge.kick.standing
	
	self.x_judge.stats.damage = 305
	self.x_judge.AMMO_PICKUP = {1.12,1.67}
	self.x_judge.stats.recoil = 3
	self.x_judge.stats.spread = 1
	self.x_judge.fire_mode_data = {fire_rate = 60/360}
	self.x_judge.single = {fire_rate = 60/360}
	self.x_judge.kick = {
		standing = {
			4.3,
			4.9,
			-0.7,
			0.9
		}
	}
	self.x_judge.kick.crouching = self.x_judge.kick.standing
	self.x_judge.kick.steelsight = self.x_judge.kick.standing
	end
	setSHOTGUNs()
	
	-- Light Machine Guns --
	local function setLMGs()
	--no bipod ones
	self.hk51b.stats.damage = 177
	self.hk51b.stats.spread = 11
	self.hk51b.stats.recoil = 8
	self.hk51b.AMMO_PICKUP = {3.3,4.89}
	
	self.hcar.stats.damage = 210
	self.hcar.AMMO_PICKUP = {2.1,3.3}
	
	
	--heavy
	self.hk21.AMMO_PICKUP = {3.18,5.92}
	self.hk21.stats.spread = 10
	self.hk21.stats.recoil = 9
	self.rpk.AMMO_PICKUP = {3.18,5.92}
	self.rpk.stats.spread = 5
	self.rpk.stats.recoil = 13
	self.m60.AMMO_PICKUP = {3.18,5.92}
	self.m60.stats.spread = 10
	self.m60.stats.recoil = 9
	
	--light
	self.mg42.AMMO_PICKUP = {4.97,8.2}
	self.mg42.stats.spread = 7
	self.mg42.stats.recoil = 15
	self.m249.AMMO_PICKUP = {4.97,8.2}
	self.m249.stats.spread = 8
	self.par.AMMO_PICKUP = {4.97,8.2}
	self.par.stats.spread = 8
	self.par.stats.recoil = 10
	-- mcshay pack 4
	self.kacchainsaw.stats.damage = 117
	self.kacchainsaw.AMMO_PICKUP = {5.78,8.99}
	self.kacchainsaw_flamethrower.CLIP_AMMO_MAX = 125
	self.kacchainsaw_flamethrower.NR_CLIPS_MAX = 2
	self.kacchainsaw_flamethrower.AMMO_MAX = self.kacchainsaw_flamethrower.CLIP_AMMO_MAX * self.kacchainsaw_flamethrower.NR_CLIPS_MAX
	self.kacchainsaw_flamethrower.AMMO_PICKUP = {1.7,3.5}
	self.kacchainsaw_flamethrower.stats.damage = 60
	self.kacchainsaw_flamethrower.fire_dot_data = {
		dot_trigger_chance = 5,
		dot_damage = 3,
		dot_length = 1.1,
		dot_trigger_max_distance = 3000,
		dot_tick_period = 0.25
	}
	
	end
	setLMGs()
	
	-- Snipers --
	local function setSNIPERs()
	-- Semi autos
	self.qbu88.stats.damage = 550
	self.qbu88.CLIP_AMMO_MAX = 10
	self.qbu88.NR_CLIPS_MAX = 4
	self.qbu88.AMMO_MAX = self.qbu88.CLIP_AMMO_MAX * self.qbu88.NR_CLIPS_MAX
	self.qbu88.AMMO_PICKUP = {0.444,0.814}
	self.qbu88.stats.recoil = 13
	self.qbu88.stats.spread = 20
	self.qbu88.fire_mode_data = {fire_rate = 60/260}
	self.qbu88.single = {fire_rate = 60/260}
	
	-- svd
	self.siltstone.stats.damage = 550
	self.siltstone.CLIP_AMMO_MAX = 10
	self.siltstone.NR_CLIPS_MAX = 4
	self.siltstone.AMMO_MAX = self.siltstone.CLIP_AMMO_MAX * self.siltstone.NR_CLIPS_MAX
	self.siltstone.AMMO_PICKUP = {0.444,0.814}
	self.siltstone.stats.recoil = 8
	self.siltstone.stats.spread = 19
	self.siltstone.fire_mode_data = {fire_rate = 60/260}
	self.siltstone.single = {fire_rate = 60/260}
	
	-- 308
	self.tti.stats.damage = 550
	self.tti.CLIP_AMMO_MAX = 20
	self.tti.NR_CLIPS_MAX = 2
	self.tti.AMMO_MAX = self.tti.CLIP_AMMO_MAX * self.tti.NR_CLIPS_MAX
	self.tti.AMMO_PICKUP = {0.444,0.814}
	self.tti.stats.recoil = 9
	self.tti.stats.spread = 17
	self.tti.fire_mode_data = {fire_rate = 60/260}
	self.tti.single = {fire_rate = 60/260}
	
	self.wa2000.stats.damage = 550
	self.wa2000.CLIP_AMMO_MAX = 15
	self.wa2000.NR_CLIPS_MAX = 3
	self.wa2000.AMMO_MAX = self.wa2000.CLIP_AMMO_MAX * self.wa2000.NR_CLIPS_MAX
	self.wa2000.AMMO_PICKUP = {0.444,0.814}
	self.wa2000.stats.recoil = 3
	self.wa2000.stats.spread = 20
	self.wa2000.fire_mode_data = {fire_rate = 60/260}
	self.wa2000.single = {fire_rate = 60/260}
	
	-- Lever action
	self.winchester1874.stats.damage = 630/2
	self.winchester1874.CLIP_AMMO_MAX = 15
	self.winchester1874.NR_CLIPS_MAX = 2
	self.winchester1874.AMMO_MAX = self.winchester1874.CLIP_AMMO_MAX * self.winchester1874.NR_CLIPS_MAX
	self.winchester1874.AMMO_PICKUP = {0.444,0.814}
	self.winchester1874.stats.recoil = 13
	self.winchester1874.stats.spread = 22
	self.winchester1874.fire_mode_data = {fire_rate = 60/100}
	self.winchester1874.single = {fire_rate = 60/100}
	
	self.sbl.stats.damage = 630/2
	self.sbl.CLIP_AMMO_MAX = 10
	self.sbl.NR_CLIPS_MAX = 3
	self.sbl.AMMO_MAX = self.sbl.CLIP_AMMO_MAX * self.sbl.NR_CLIPS_MAX
	self.sbl.AMMO_PICKUP = {0.444,0.814}
	self.sbl.stats.recoil = 13
	self.sbl.stats.spread = 22
	self.sbl.fire_mode_data = {fire_rate = 60/120}
	self.sbl.single = {fire_rate = 60/120}
	
	-- Bolties
	self.mosin.stats.damage = 1260/4
	self.mosin.CLIP_AMMO_MAX = 5
	self.mosin.NR_CLIPS_MAX = 6
	self.mosin.AMMO_MAX = self.mosin.CLIP_AMMO_MAX * self.mosin.NR_CLIPS_MAX
	self.mosin.AMMO_PICKUP = {0.444,0.814}
	self.mosin.stats.recoil = 7
	self.mosin.stats.spread = 24
	self.mosin.fire_mode_data = {fire_rate = 60/60}
	self.mosin.single = {fire_rate = 60/60}
	
	self.r93.stats.damage = 1260/4
	self.r93.CLIP_AMMO_MAX = 6
	self.r93.NR_CLIPS_MAX = 5
	self.r93.AMMO_MAX = self.r93.CLIP_AMMO_MAX * self.r93.NR_CLIPS_MAX
	self.r93.AMMO_PICKUP = {0.444,0.814}
	self.r93.stats.recoil = 7
	self.r93.stats.spread = 23
	self.r93.fire_mode_data = {fire_rate = 60/60}
	self.r93.single = {fire_rate = 60/60}
	
	self.model70.stats.damage = 1260/4
	self.model70.CLIP_AMMO_MAX = 5
	self.model70.NR_CLIPS_MAX = 6
	self.model70.AMMO_MAX = self.model70.CLIP_AMMO_MAX * self.model70.NR_CLIPS_MAX
	self.model70.AMMO_PICKUP = {0.444,0.814}
	self.model70.stats.recoil = 7
	self.model70.stats.spread = 24
	self.model70.fire_mode_data = {fire_rate = 60/60}
	self.model70.single = {fire_rate = 60/60}
	
	self.desertfox.stats.damage = 1260/4
	self.desertfox.CLIP_AMMO_MAX = 5
	self.desertfox.NR_CLIPS_MAX = 6
	self.desertfox.AMMO_MAX = self.desertfox.CLIP_AMMO_MAX * self.desertfox.NR_CLIPS_MAX
	self.desertfox.AMMO_PICKUP = {0.444,0.814}
	self.desertfox.stats.recoil = 9
	self.desertfox.stats.spread = 17
	self.desertfox.fire_mode_data = {fire_rate = 60/60}
	self.desertfox.single = {fire_rate = 60/60}
	
	self.msr.stats.damage = 1260/2
	self.msr.CLIP_AMMO_MAX = 10
	self.msr.NR_CLIPS_MAX = 3
	self.msr.AMMO_MAX = self.msr.CLIP_AMMO_MAX * self.msr.NR_CLIPS_MAX
	self.msr.AMMO_PICKUP = {0.444,0.814}
	self.msr.stats.recoil = 11
	self.msr.stats.spread = 23
	self.msr.fire_mode_data = {fire_rate = 60/50}
	self.msr.single = {fire_rate = 60/50}
	
	self.r700.stats.damage = 1260/2
	self.r700.CLIP_AMMO_MAX = 10
	self.r700.NR_CLIPS_MAX = 3
	self.r700.AMMO_MAX = self.r700.CLIP_AMMO_MAX * self.r700.NR_CLIPS_MAX
	self.r700.AMMO_PICKUP = {0.444,0.814}
	self.r700.stats.recoil = 11
	self.r700.stats.spread = 22
	self.r700.fire_mode_data = {fire_rate = 60/50}
	self.r700.single = {fire_rate = 60/50}
	
	--mcshay 4
	self.awp.stats.damage = 1260/5
	self.awp.NR_CLIPS_MAX = 3
	self.awp.AMMO_MAX = self.awp.CLIP_AMMO_MAX * self.awp.NR_CLIPS_MAX
	self.awp.AMMO_PICKUP = {0.444,0.814}
	self.awp.stats_modifiers = {
		damage = 5
	}

	-- Ze big dick gun
	self.m95.stats.damage = 230
	self.m95.AMMO_PICKUP = {0.03,0.68}

	-- Secondary bolty
	self.scout.stats.damage = 630/2
	self.scout.NR_CLIPS_MAX = 5
	self.scout.AMMO_MAX = self.scout.CLIP_AMMO_MAX * self.scout.NR_CLIPS_MAX
	self.scout.fire_mode_data = {fire_rate = 60/80}
	self.scout.single = {fire_rate = 60/80}
	self.scout.AMMO_PICKUP = {0.341,0.626}
	
	-- Secondary semi-auto
	self.victor.stats.damage = 420
	self.victor.timers.reload_empty = 2.75
	self.victor.stats.reload = 13
	self.victor.CLIP_AMMO_MAX = 7
	self.victor.stats.spread = 17
	self.victor.NR_CLIPS_MAX = 5
	self.victor.AMMO_MAX = self.victor.CLIP_AMMO_MAX * self.victor.NR_CLIPS_MAX
	self.victor.AMMO_PICKUP = {0.474,0.88}
	
	-- Secondary single shot
	self.contender.stats.damage = 625
	self.contender.fire_mode_data = {fire_rate = 60/50}
	self.contender.single = {fire_rate = 60/50}
	self.contender.stats_modifiers = {damage = 1}
	self.contender.AMMO_PICKUP = {0.441,0.626}
	
	end
	setSNIPERs()

	-- Sub machine guns --
	local function setSMGs()
	
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
			self[gun].AMMO_PICKUP = {1.62,2.39}
		end
	end
	
	self.erma.stats.recoil = 20
	self.erma.stats.spread = 9
	self.erma.NR_CLIPS_MAX = 4
	self.erma.CLIP_AMMO_MAX = 32
	self.erma.AMMO_MAX = self.erma.CLIP_AMMO_MAX * self.erma.NR_CLIPS_MAX
	
	self.hajk.stats.recoil = 12
	self.hajk.stats.spread = 13
	
	self.olympic.AMMO_MAX = 125
	self.olympic.NR_CLIPS_MAX = self.olympic.AMMO_MAX / self.olympic.CLIP_AMMO_MAX
	self.olympic.stats.spread = 10
	self.olympic.stats.recoil = 16
	
	self.schakal.AMMO_MAX = 125
	self.schakal.CLIP_AMMO_MAX = 25
	self.schakal.NR_CLIPS_MAX = self.schakal.AMMO_MAX / self.schakal.CLIP_AMMO_MAX
	self.schakal.stats.spread = 11
	self.schakal.stats.recoil = 18
	
	self.m45.stats.reload = 14
	self.m45.stats.recoil = 4
	self.m45.stats.spread = 24
	
	self.sterling.stats.spread = 18
	self.sterling.stats.recoil = 14
	
	-- akimbo versions
	for _, gun in ipairs(high_smg_ids) do
		if self["x_"..gun] then
			self["x_"..gun].stats.damage = 210
			self["x_"..gun].AMMO_MAX = 150
			self["x_"..gun].NR_CLIPS_MAX = self["x_"..gun].AMMO_MAX / self["x_"..gun].CLIP_AMMO_MAX
			self["x_"..gun].AMMO_PICKUP[1] = self[gun].AMMO_PICKUP[1] * 1.3
			self["x_"..gun].AMMO_PICKUP[2] = self[gun].AMMO_PICKUP[2] * 1.3
		end
	end
	
	self.x_erma.stats.recoil = 20
	self.x_erma.stats.spread = 9
	self.x_erma.NR_CLIPS_MAX = 3
	self.x_erma.CLIP_AMMO_MAX = 64
	self.x_erma.AMMO_MAX = self.x_erma.CLIP_AMMO_MAX * self.x_erma.NR_CLIPS_MAX
	
	self.x_hajk.stats.recoil = 12
	self.x_hajk.stats.spread = 13
	self.x_hajk.AMMO_MAX = 180
	self.x_hajk.NR_CLIPS_MAX = self.x_hajk.AMMO_MAX / self.x_hajk.CLIP_AMMO_MAX
	
	self.x_olympic.AMMO_MAX = 200
	self.x_olympic.NR_CLIPS_MAX = self.x_olympic.AMMO_MAX / self.x_olympic.CLIP_AMMO_MAX
	self.x_olympic.stats.spread = 10
	self.x_olympic.stats.recoil = 16
	
	self.x_schakal.AMMO_MAX = 200
	self.x_schakal.CLIP_AMMO_MAX = 50
	self.x_schakal.NR_CLIPS_MAX = self.x_schakal.AMMO_MAX / self.x_schakal.CLIP_AMMO_MAX
	self.x_schakal.stats.spread = 11
	self.x_schakal.stats.recoil = 18
	
	self.x_m45.stats.reload = 14
	self.x_m45.stats.recoil = 4
	self.x_m45.stats.spread = 24
	self.x_m45.AMMO_MAX = 160
	self.x_m45.NR_CLIPS_MAX = self.x_m45.AMMO_MAX / self.x_m45.CLIP_AMMO_MAX
	
	self.x_sterling.stats.spread = 18
	self.x_sterling.stats.recoil = 14
	self.x_sterling.AMMO_MAX = 192
	self.x_sterling.NR_CLIPS_MAX = self.x_sterling.AMMO_MAX / self.x_sterling.CLIP_AMMO_MAX
	
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
			self[gun].AMMO_PICKUP = {2.39,3.34}
		end
	end
	
	self.vityaz.stats.spread = 16
	self.vityaz.stats.recoil = 15
	
	self.m1928.stats.spread = 7
	self.m1928.stats.recoil = 22
	
	self.sr2.AMMO_MAX = 160
	self.sr2.NR_CLIPS_MAX = self.sr2.AMMO_MAX / self.sr2.CLIP_AMMO_MAX
	
	self.shepheard.stats.reload = 14
	self.shepheard.stats.recoil = 11
	self.shepheard.stats.spread = 21
	
	self.coal.AMMO_MAX = 128
	self.coal.NR_CLIPS_MAX = self.coal.AMMO_MAX / self.coal.CLIP_AMMO_MAX
	self.coal.stats.reload = 9
	self.coal.stats.recoil = 19
	self.coal.stats.spread = 11
	
	self.uzi.stats.spread = 15
	
	-- akimbo versions
	for _, gun in ipairs(avg_low_smg_ids) do
		if self["x_"..gun] then
			self["x_"..gun].stats.damage = 146
			self["x_"..gun].AMMO_PICKUP[1] = self[gun].AMMO_PICKUP[1] * 1.3
			self["x_"..gun].AMMO_PICKUP[2] = self[gun].AMMO_PICKUP[2] * 1.3
		end
	end
	
	self.x_mp5.stats.damage = 146
	self.x_mp5.AMMO_MAX = 210
	self.x_mp5.NR_CLIPS_MAX = self.x_mp5.AMMO_MAX / self.x_mp5.CLIP_AMMO_MAX
	self.x_mp5.AMMO_PICKUP[1] = self.new_mp5.AMMO_PICKUP[1] * 1.3
	self.x_mp5.AMMO_PICKUP[2] = self.new_mp5.AMMO_PICKUP[2] * 1.3
	
	self.x_shepheard.AMMO_MAX = 240
	self.x_shepheard.NR_CLIPS_MAX = self.x_shepheard.AMMO_MAX / self.x_shepheard.CLIP_AMMO_MAX
	self.x_shepheard.stats.recoil = 11
	self.x_shepheard.stats.spread = 21
	
	self.x_m1928.AMMO_MAX = 200
	self.x_m1928.NR_CLIPS_MAX = self.x_m1928.AMMO_MAX / self.x_m1928.CLIP_AMMO_MAX
	self.x_m1928.stats.spread = 7
	self.x_m1928.stats.recoil = 22
	
	self.x_sr2.AMMO_MAX = 256
	self.x_sr2.NR_CLIPS_MAX = self.x_sr2.AMMO_MAX / self.x_sr2.CLIP_AMMO_MAX
	self.x_sr2.stats.reload = 7
	
	self.x_vityaz.stats.spread = 16
	self.x_vityaz.stats.recoil = 15
	
	self.x_uzi.AMMO_MAX = 240
	self.x_uzi.NR_CLIPS_MAX = self.x_uzi.AMMO_MAX / self.x_uzi.CLIP_AMMO_MAX
	self.x_uzi.stats.spread = 15
	
	self.x_coal.AMMO_MAX = 256
	self.x_coal.NR_CLIPS_MAX = self.x_coal.AMMO_MAX / self.x_coal.CLIP_AMMO_MAX
	self.x_coal.stats.reload = 8
	self.x_coal.stats.recoil = 19
	self.x_coal.stats.spread = 11
	
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
			self[gun].AMMO_PICKUP = {2.79,4.72}
		end
	end
	
	self.mp7.stats.spread = 9
	self.mp7.stats.reload = 13
	
	self.tec9.stats.reload = 14
	
	self.polymer.stats.spread = 10
	self.polymer.stats.recoil = 25
	self.polymer.stats.reload = 12
	
	-- akimbo versions
	for _, gun in ipairs(avg_high_smg_ids) do
		if self["x_"..gun] then
			self["x_"..gun].stats.damage = 117
			self["x_"..gun].AMMO_MAX = 240
			self["x_"..gun].NR_CLIPS_MAX = self["x_"..gun].AMMO_MAX / self["x_"..gun].CLIP_AMMO_MAX
			self["x_"..gun].AMMO_PICKUP[1] = self[gun].AMMO_PICKUP[1] * 1.3
			self["x_"..gun].AMMO_PICKUP[2] = self[gun].AMMO_PICKUP[2] * 1.3
		end
	end
	
	self.x_mp7.stats.spread = 9
	
	self.x_polymer.stats.spread = 10
	self.x_polymer.stats.recoil = 25
	
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
			self[gun].AMMO_PICKUP =  {3.98,6.83}
		end
	end
	
	self.mac10.AMMO_MAX = 200
	self.mac10.NR_CLIPS_MAX = self.mac10.AMMO_MAX / self.mac10.CLIP_AMMO_MAX
	self.mac10.stats.spread = 10
	self.mac10.stats.recoil = 21
	
	self.mp9.stats.spread = 22
	self.mp9.stats.recoil = 6

	self.pm9.AMMO_MAX = 200
	self.pm9.NR_CLIPS_MAX = self.pm9.AMMO_MAX / self.pm9.CLIP_AMMO_MAX
	self.pm9.stats.reload = 14

	self.scorpion.AMMO_MAX = 200
	self.scorpion.NR_CLIPS_MAX = self.scorpion.AMMO_MAX / self.scorpion.CLIP_AMMO_MAX
	self.scorpion.stats.spread = 11
	self.scorpion.stats.recoil = 22
	
	self.baka.AMMO_MAX = 224
	self.baka.NR_CLIPS_MAX = self.baka.AMMO_MAX / self.baka.CLIP_AMMO_MAX

	self.cobray.AMMO_MAX = 224
	self.cobray.NR_CLIPS_MAX = self.cobray.AMMO_MAX / self.cobray.CLIP_AMMO_MAX

	self.uzi.AMMO_MAX = 160
	self.uzi.NR_CLIPS_MAX = self.uzi.AMMO_MAX / self.uzi.CLIP_AMMO_MAX
	
	self.mac10.AMMO_MAX = 200
	self.mac10.NR_CLIPS_MAX = self.mac10.AMMO_MAX / self.mac10.CLIP_AMMO_MAX
	
	self.p90.AMMO_MAX = 200
	self.p90.NR_CLIPS_MAX = self.p90.AMMO_MAX / self.p90.CLIP_AMMO_MAX
	
	self.fmg9.stats.spread = 11
	self.fmg9.stats.recoil = 15
	
	-- akimbo versions
	for _, gun in ipairs(low_smg_ids) do
		if self["x_"..gun] then
			self["x_"..gun].stats.damage = 95
			self["x_"..gun].NR_CLIPS_MAX = 4
			self["x_"..gun].AMMO_MAX = self["x_"..gun].NR_CLIPS_MAX * self["x_"..gun].CLIP_AMMO_MAX
			self["x_"..gun].AMMO_PICKUP[1] = self[gun].AMMO_PICKUP[1] * 1.3
			self["x_"..gun].AMMO_PICKUP[2] = self[gun].AMMO_PICKUP[2] * 1.3
		end
	end
	
	self.x_pm9.AMMO_MAX = 300
	self.x_pm9.NR_CLIPS_MAX = self.x_pm9.AMMO_MAX / self.x_pm9.CLIP_AMMO_MAX
	
	self.x_scorpion.AMMO_MAX = 280
	self.x_scorpion.NR_CLIPS_MAX = self.x_scorpion.AMMO_MAX / self.x_scorpion.CLIP_AMMO_MAX
	self.x_scorpion.stats.spread = 11
	self.x_scorpion.stats.recoil = 22
	
	self.x_baka.AMMO_MAX = 310
	self.x_baka.NR_CLIPS_MAX = self.x_baka.AMMO_MAX / self.x_baka.CLIP_AMMO_MAX
	
	self.x_mp9.stats.spread = 22
	self.x_mp9.stats.recoil = 6
	
	self.x_p90.AMMO_MAX = 300
	self.x_p90.NR_CLIPS_MAX = self.x_p90.AMMO_MAX / self.x_p90.CLIP_AMMO_MAX
	
	end
	setSMGs()
	
	-- Pistols --
	local function setPISTOLs()
	
	-- 3-6 headshot kill
	self.beer.stats.damage = 77
	self.beer.stats.recoil = 11
	self.beer.CLIP_AMMO_MAX = 16
	self.beer.NR_CLIPS_MAX = 10
	self.beer.AMMO_MAX = self.beer.NR_CLIPS_MAX * self.beer.CLIP_AMMO_MAX
	self.beer.AMMO_PICKUP = {4.26,7.1}
	self.beer.auto.fire_rate = self.beer.auto.fire_rate * 0.8
	self.beer.fire_mode_data.fire_rate = self.beer.fire_mode_data.fire_rate * 0.8
	
	self.x_beer.stats.damage = 77
	self.x_beer.stats.recoil = 11
	self.x_beer.CLIP_AMMO_MAX = 32
	self.x_beer.NR_CLIPS_MAX = 6
	self.x_beer.AMMO_MAX = self.x_beer.NR_CLIPS_MAX * self.x_beer.CLIP_AMMO_MAX
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
			self[gun].NR_CLIPS_MAX = 8
			if self[gun].fire_mode_data then
				self[gun].fire_mode_data.fire_rate = self[gun].fire_mode_data.fire_rate * 0.8
			end
			if self[gun].single then
				self[gun].single.fire_rate = self[gun].single.fire_rate * 0.8
			end
			if self[gun].auto then
				self[gun].auto.fire_rate = self[gun].auto.fire_rate * 0.8
			end
			self[gun].AMMO_MAX = self[gun].NR_CLIPS_MAX * self[gun].CLIP_AMMO_MAX
			self[gun].AMMO_PICKUP = {3.98,6.83}
		end
	end
	
	self.glock_18c.stats.recoil = 8
	
	self.czech.NR_CLIPS_MAX = 10
	self.czech.stats.spread = 14
	self.czech.stats.recoil = 9
	self.czech.AMMO_MAX = self.czech.NR_CLIPS_MAX * self.czech.CLIP_AMMO_MAX
	
	-- akimbo versions
	for _, gun in ipairs(low_pistol_ids) do
		if self["x_"..gun] then
			self["x_"..gun].stats.damage = 95
			self["x_"..gun].NR_CLIPS_MAX = 5
			if self["x_"..gun].fire_mode_data then
				self["x_"..gun].fire_mode_data.fire_rate = self["x_"..gun].fire_mode_data.fire_rate * 0.8
			end
			if self["x_"..gun].single then
				self["x_"..gun].single.fire_rate = self["x_"..gun].single.fire_rate * 0.8
			end
			if self["x_"..gun].auto then
				self["x_"..gun].auto.fire_rate = self["x_"..gun].auto.fire_rate * 0.8
			end
			self["x_"..gun].AMMO_MAX = self["x_"..gun].NR_CLIPS_MAX * self["x_"..gun].CLIP_AMMO_MAX
			self["x_"..gun].AMMO_PICKUP[1] = self[gun].AMMO_PICKUP[1] * 1.3
			self["x_"..gun].AMMO_PICKUP[2] = self[gun].AMMO_PICKUP[2] * 1.3
		end
	end
	
	self.x_czech.NR_CLIPS_MAX = 7
	self.x_czech.AMMO_MAX = self.x_czech.NR_CLIPS_MAX * self.x_czech.CLIP_AMMO_MAX
	self.x_czech.stats.spread = 14
	self.x_czech.stats.recoil = 9
	
	-- some akimbos have slighlty different names such as this glock 18, so will have to override them seperatly
	self.x_g18c.stats.damage = 95
	self.x_g18c.stats.recoil = 8
	self.x_g18c.NR_CLIPS_MAX = 5
	self.x_g18c.fire_mode_data.fire_rate = self.x_g18c.fire_mode_data.fire_rate * 0.8
	self.x_g18c.single.fire_rate = self.x_g18c.single.fire_rate * 0.8
	self.x_g18c.AMMO_MAX = self.x_g18c.NR_CLIPS_MAX * self.x_g18c.CLIP_AMMO_MAX
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
		--"stech"
	}
	
	for _, gun in ipairs(mid_pistol_ids) do
		if self[gun] then
			self[gun].stats.damage = 117
			self[gun].NR_CLIPS_MAX = 7
			if self[gun].fire_mode_data then
				self[gun].fire_mode_data.fire_rate = self[gun].fire_mode_data.fire_rate * 1.5
			end
			if self[gun].single then
				self[gun].single.fire_rate = self[gun].single.fire_rate * 1.5
			end
			if self[gun].auto then
				self[gun].auto.fire_rate = self[gun].auto.fire_rate * 1.5
			end
			self[gun].AMMO_MAX = self[gun].NR_CLIPS_MAX * self[gun].CLIP_AMMO_MAX
			self[gun].AMMO_PICKUP = {2.79,4.72}
		end
	end
	
	self.g26.CLIP_AMMO_MAX = 11
	self.g26.NR_CLIPS_MAX = 7
	self.g26.AMMO_MAX = self.g26.NR_CLIPS_MAX * self.g26.CLIP_AMMO_MAX
	
	self.stech.stats.damage = 117
	self.stech.stats.recoil = 6
	self.stech.NR_CLIPS_MAX = 7
	self.stech.fire_mode_data.fire_rate = self.stech.fire_mode_data.fire_rate * 0.8
	self.stech.auto.fire_rate = self.stech.auto.fire_rate * 0.8
	self.stech.AMMO_MAX = self.stech.NR_CLIPS_MAX * self.stech.CLIP_AMMO_MAX
	self.stech.AMMO_PICKUP = {2.79,4.72}
	
	-- akimbo versions
	for _, gun in ipairs(mid_pistol_ids) do
		if self["x_"..gun] then
			self["x_"..gun].stats.damage = 117
			self["x_"..gun].NR_CLIPS_MAX = 5
			if self["x_"..gun].fire_mode_data then
				self["x_"..gun].fire_mode_data.fire_rate = self["x_"..gun].fire_mode_data.fire_rate * 1.5
			end
			if self["x_"..gun].single then
				self["x_"..gun].single.fire_rate = self["x_"..gun].single.fire_rate * 1.5
			end
			if self["x_"..gun].auto then
				self["x_"..gun].auto.fire_rate = self["x_"..gun].auto.fire_rate * 1.5
			end
			self["x_"..gun].AMMO_MAX = self["x_"..gun].NR_CLIPS_MAX * self["x_"..gun].CLIP_AMMO_MAX
			self["x_"..gun].AMMO_PICKUP[1] = self[gun].AMMO_PICKUP[1] * 1.3
			self["x_"..gun].AMMO_PICKUP[2] = self[gun].AMMO_PICKUP[2] * 1.3
		end
	end
	
	self.x_shrew.fire_mode_data.fire_rate = 60/320
	self.x_shrew.single.fire_rate = 60/320
	
	self.x_legacy.fire_mode_data.fire_rate = 60/320
	self.x_legacy.single.fire_rate = 60/320
	
	self.x_ppk.fire_mode_data.fire_rate = 60/320
	self.x_ppk.single.fire_rate = 60/320
	
	self.x_b92fs.stats.spread = 15
	self.x_b92fs.stats.concealment = 30
	self.x_b92fs.fire_mode_data.fire_rate = 60/320
	self.x_b92fs.single.fire_rate = 60/320
	
	self.x_g17.stats.damage = 117
	self.x_g17.NR_CLIPS_MAX = 5
	self.x_g17.fire_mode_data.fire_rate = self.x_g17.fire_mode_data.fire_rate * 1.5
	self.x_g17.single.fire_rate = self.x_g17.single.fire_rate * 1.5
	self.x_g17.AMMO_MAX = self.x_g17.NR_CLIPS_MAX * self.x_g17.CLIP_AMMO_MAX
	self.x_g17.AMMO_PICKUP[1] = self.glock_17.AMMO_PICKUP[1] * 1.3
	self.x_g17.AMMO_PICKUP[2] = self.glock_17.AMMO_PICKUP[2] * 1.3
	
	self.x_stech.stats.damage = 117
	self.x_stech.stats.recoil = 6
	self.x_stech.NR_CLIPS_MAX = 5
	self.x_stech.fire_mode_data.fire_rate = self.x_stech.fire_mode_data.fire_rate * 0.8
	self.x_stech.single.fire_rate = self.x_stech.single.fire_rate * 0.8
	self.x_stech.AMMO_MAX = self.x_stech.NR_CLIPS_MAX * self.x_stech.CLIP_AMMO_MAX
	self.x_stech.AMMO_PICKUP[1] = self.stech.AMMO_PICKUP[1] * 1.3
	self.x_stech.AMMO_PICKUP[2] = self.stech.AMMO_PICKUP[2] * 1.3
	
	-- why does this akimbo have such a special name? 
	-- revelation: apparently it stands for john wick lmao
	self.jowi.stats.damage = 117
	self.jowi.CLIP_AMMO_MAX = 22
	self.jowi.NR_CLIPS_MAX = 5
	self.jowi.AMMO_MAX = self.jowi.NR_CLIPS_MAX * self.jowi.CLIP_AMMO_MAX
	self.jowi.fire_mode_data.fire_rate = 60/320
	self.jowi.single.fire_rate = 60/320
	self.jowi.AMMO_PICKUP[1] = self.g26.AMMO_PICKUP[1] * 1.3
	self.jowi.AMMO_PICKUP[2] = self.g26.AMMO_PICKUP[2] * 1.3
	
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
			self[gun].NR_CLIPS_MAX = 6
			if self[gun].fire_mode_data then
				self[gun].fire_mode_data.fire_rate = self[gun].fire_mode_data.fire_rate * 1.5
			end
			if self[gun].single then
				self[gun].single.fire_rate = self[gun].single.fire_rate * 1.5
			end
			if self[gun].auto then
				self[gun].auto.fire_rate = self[gun].auto.fire_rate * 1.5
			end
			self[gun].AMMO_MAX = self[gun].NR_CLIPS_MAX * self[gun].CLIP_AMMO_MAX
			self[gun].AMMO_PICKUP = {2.39,3.34}
		end
	end
	
	self.colt_1911.CLIP_AMMO_MAX = 8
	self.colt_1911.NR_CLIPS_MAX = 10
	self.colt_1911.AMMO_MAX = self.colt_1911.NR_CLIPS_MAX * self.colt_1911.CLIP_AMMO_MAX
	
	self.c96.AMMO_MAX = 90
	self.c96.CLIP_AMMO_MAX = 10
	self.c96.NR_CLIPS_MAX = self.c96.AMMO_MAX / self.c96.CLIP_AMMO_MAX
	self.c96.stats.reload = 13
	
	self.lemming.AMMO_MAX = 60
	self.lemming.CLIP_AMMO_MAX = 20
	self.lemming.NR_CLIPS_MAX = self.lemming.AMMO_MAX / self.lemming.CLIP_AMMO_MAX
	self.lemming.AMMO_PICKUP = {1.19,1.67}
	self.lemming.fire_mode_data.fire_rate = 60/320 -- why does it even have such high base rof?
	self.lemming.single.fire_rate = 60/320

	-- akimbo versions
	for _, gun in ipairs(upper_mid_pistol_ids) do
		if self["x_"..gun] then
			self["x_"..gun].stats.damage = 140
			self["x_"..gun].NR_CLIPS_MAX = 4
			if self["x_"..gun].fire_mode_data then
				self["x_"..gun].fire_mode_data.fire_rate = self["x_"..gun].fire_mode_data.fire_rate * 1.5
			end
			if self["x_"..gun].single then
				self["x_"..gun].single.fire_rate = self["x_"..gun].single.fire_rate * 1.5
			end
			if self["x_"..gun].auto then
				self["x_"..gun].auto.fire_rate = self["x_"..gun].auto.fire_rate * 1.5
			end
			self["x_"..gun].AMMO_MAX = self["x_"..gun].NR_CLIPS_MAX * self["x_"..gun].CLIP_AMMO_MAX
			self["x_"..gun].AMMO_PICKUP[1] = self[gun].AMMO_PICKUP[1] * 1.3
			self["x_"..gun].AMMO_PICKUP[2] = self[gun].AMMO_PICKUP[2] * 1.3
		end
	end
	
	self.x_holt.stats.spread = 16
	self.x_holt.AMMO_MAX = 150
	self.x_holt.CLIP_AMMO_MAX = 30
	self.x_holt.NR_CLIPS_MAX = self.x_holt.AMMO_MAX / self.x_holt.CLIP_AMMO_MAX
	
	self.x_type54.AMMO_MAX = 100
	self.x_type54.CLIP_AMMO_MAX = 20
	self.x_type54.NR_CLIPS_MAX = self.x_type54.AMMO_MAX / self.x_type54.CLIP_AMMO_MAX
	
	self.x_c96.AMMO_MAX = 140
	self.x_c96.CLIP_AMMO_MAX = 20
	self.x_c96.NR_CLIPS_MAX = self.x_c96.AMMO_MAX / self.x_c96.CLIP_AMMO_MAX
	
	self.x_1911.stats.damage = 140
	self.x_1911.stats.concealment = 29
	self.x_1911.CLIP_AMMO_MAX = 16
	self.x_1911.NR_CLIPS_MAX = 7
	self.x_1911.AMMO_MAX = self.x_1911.NR_CLIPS_MAX * self.x_1911.CLIP_AMMO_MAX
	self.x_1911.fire_mode_data.fire_rate = self.x_1911.fire_mode_data.fire_rate * 1.5
	self.x_1911.single.fire_rate = self.x_1911.single.fire_rate * 1.5
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
			self[gun].NR_CLIPS_MAX = 5
			if self[gun].fire_mode_data then
				self[gun].fire_mode_data.fire_rate = self[gun].fire_mode_data.fire_rate * 1.5
			end
			if self[gun].single then
				self[gun].single.fire_rate = self[gun].single.fire_rate * 1.5
			end
			if self[gun].auto then
				self[gun].auto.fire_rate = self[gun].auto.fire_rate * 1.5
			end
			self[gun].AMMO_MAX = self[gun].NR_CLIPS_MAX * self[gun].CLIP_AMMO_MAX
			self[gun].AMMO_PICKUP = {1.62,2.39}
		end
	end
	
	self.m1911.fire_mode_data.fire_rate = 60/267
	self.m1911.single.fire_rate = 60/267
	
	-- akimbo versions
	for _, gun in ipairs(heavy_pistol_ids) do
		if self["x_"..gun] then
			self["x_"..gun].stats.damage = 210
			self["x_"..gun].NR_CLIPS_MAX = 4
			if self["x_"..gun].fire_mode_data then
				self["x_"..gun].fire_mode_data.fire_rate = self["x_"..gun].fire_mode_data.fire_rate * 1.5
			end
			if self["x_"..gun].single then
				self["x_"..gun].single.fire_rate = self["x_"..gun].single.fire_rate * 1.5
			end
			if self["x_"..gun].auto then
				self["x_"..gun].auto.fire_rate = self["x_"..gun].auto.fire_rate * 1.5
			end
			self["x_"..gun].AMMO_MAX = self["x_"..gun].NR_CLIPS_MAX * self["x_"..gun].CLIP_AMMO_MAX
			self["x_"..gun].AMMO_PICKUP[1] = self[gun].AMMO_PICKUP[1] * 1.3
			self["x_"..gun].AMMO_PICKUP[2] = self[gun].AMMO_PICKUP[2] * 1.3
		end
	end
	
	self.x_deagle.fire_mode_data.fire_rate = 60/241
	self.x_deagle.single.fire_rate = 60/241
	self.x_deagle.CLIP_AMMO_MAX = 20
	self.x_deagle.NR_CLIPS_MAX = 4
	self.x_deagle.AMMO_MAX = self.x_deagle.NR_CLIPS_MAX * self.x_deagle.CLIP_AMMO_MAX
	self.x_deagle.stats.concealment = 28
	
	self.x_m1911.fire_mode_data.fire_rate = 60/241
	self.x_m1911.single.fire_rate = 60/241
	
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
			self[gun].NR_CLIPS_MAX = 5
			if self[gun].fire_mode_data then
				self[gun].fire_mode_data.fire_rate = self[gun].fire_mode_data.fire_rate * 1.5
			end
			if self[gun].single then
				self[gun].single.fire_rate = self[gun].single.fire_rate * 1.5
			end
			if self[gun].auto then
				self[gun].auto.fire_rate = self[gun].auto.fire_rate * 1.5
			end
			self[gun].AMMO_MAX = self[gun].NR_CLIPS_MAX * self[gun].CLIP_AMMO_MAX
			self[gun].AMMO_PICKUP = {0.53,0.99}
		end
	end
	
	self.mateba.stats.reload = 15
	self.mateba.stats.recoil = 10
	self.mateba.stats.spread = 21
	
	self.korth.fire_mode_data.fire_rate = 0.12
	self.korth.stats.spread = 12
	-- stop it with stupid pay to win stats on new weapons overkill
	self.korth.fire_mode_data.fire_rate = 60/267
	self.korth.single.fire_rate = 60/267
	
	self.rsh12.AMMO_PICKUP = {0.265,0.49}
	self.rsh12.NR_CLIPS_MAX = 4
	self.rsh12.AMMO_MAX = self.rsh12.NR_CLIPS_MAX * self.rsh12.CLIP_AMMO_MAX
	self.rsh12.stats.damage = 210 -- why do you fuck me with your damage multipliers overkilllllllllllllllll
	
	-- akimbo versions
	for _, gun in ipairs(heavy_pistol_ids) do
		if self["x_"..gun] then
			self["x_"..gun].stats.damage = 420
			self["x_"..gun].NR_CLIPS_MAX = 4
			if self["x_"..gun].fire_mode_data then
				self["x_"..gun].fire_mode_data.fire_rate = self["x_"..gun].fire_mode_data.fire_rate * 1.5
			end
			if self["x_"..gun].single then
				self["x_"..gun].single.fire_rate = self["x_"..gun].single.fire_rate * 1.5
			end
			if self["x_"..gun].auto then
				self["x_"..gun].auto.fire_rate = self["x_"..gun].auto.fire_rate * 1.5
			end
			self["x_"..gun].AMMO_MAX = self["x_"..gun].NR_CLIPS_MAX * self["x_"..gun].CLIP_AMMO_MAX
			self["x_"..gun].AMMO_PICKUP[1] = self[gun].AMMO_PICKUP[1] * 1.3
			self["x_"..gun].AMMO_PICKUP[2] = self[gun].AMMO_PICKUP[2] * 1.3
		end
	end
	
	self.x_2006m.stats.damage = 420
	self.x_2006m.stats.spread = 21
	self.x_2006m.NR_CLIPS_MAX = 4
	self.x_2006m.fire_mode_data.fire_rate = self.x_2006m.fire_mode_data.fire_rate * 1.5
	self.x_2006m.single.fire_rate = self.x_2006m.single.fire_rate * 1.5
	self.x_2006m.AMMO_MAX = self.x_2006m.NR_CLIPS_MAX * self.x_2006m.CLIP_AMMO_MAX
	self.x_2006m.AMMO_PICKUP[1] = self.mateba.AMMO_PICKUP[1] * 1.3
	self.x_2006m.AMMO_PICKUP[2] = self.mateba.AMMO_PICKUP[2] * 1.3
	
	self.x_rage.stats.damage = 420
	self.x_rage.NR_CLIPS_MAX = 4
	self.x_rage.AMMO_MAX = self.x_rage.NR_CLIPS_MAX * self.x_rage.CLIP_AMMO_MAX
	self.x_rage.fire_mode_data.fire_rate = self.x_rage.fire_mode_data.fire_rate * 1.5
	self.x_rage.single.fire_rate = self.x_rage.single.fire_rate * 1.5
	self.x_rage.AMMO_PICKUP[1] = self.new_raging_bull.AMMO_PICKUP[1] * 1.3
	self.x_rage.AMMO_PICKUP[2] = self.new_raging_bull.AMMO_PICKUP[2] * 1.3
	
	self.x_korth.stats.spread = 12
	self.x_korth.fire_mode_data.fire_rate = 60/241
	self.x_korth.single.fire_rate = 60/241
	
	-- 1 shot to the body on normal swats, 1 shot headshot on everyone else (except dozers)
	-- the most badass cowboy in the west
	self.peacemaker.stats.damage = 630/2
	self.peacemaker.AMMO_PICKUP = {0.53,0.99}
	self.peacemaker.NR_CLIPS_MAX = 4
	self.peacemaker.AMMO_MAX = self.peacemaker.NR_CLIPS_MAX * self.peacemaker.CLIP_AMMO_MAX
	self.peacemaker.auto.fire_rate = self.peacemaker.auto.fire_rate * 1.5
	self.peacemaker.single.fire_rate = self.peacemaker.single.fire_rate * 1.5
	self.peacemaker.fire_mode_data.fire_rate = self.peacemaker.fire_mode_data.fire_rate * 1.5
	end
	setPISTOLs()
	
	-- Grenade launchers
	local function setGLs()
	--buff reload speeds for almost all GL's since they are worse now
	self.slap.stats.reload = 13
	self.gre_m79.stats.reload = 13
	self.m32.stats.reload = 16 -- fml is it slow in the base game
	self.arbiter.stats.reload = 13
	
	-- add new nades and adjust values for blackmarket ui, all the dmg stats are handled by projectile properties
	self.slap.stats.damage = 400
	self.slap.stats.spread = 24
	self.slap.projectile_types.launcher_velocity = "launcher_velocity_slap"
	self.slap.AMMO_PICKUP = {self.slap.AMMO_PICKUP[1] * 0.75,self.slap.AMMO_PICKUP[2] * 0.75}
	self.gre_m79.stats.damage = 400
	self.gre_m79.projectile_types.launcher_velocity = "launcher_velocity"
	self.gre_m79.AMMO_PICKUP = {self.gre_m79.AMMO_PICKUP[1] * 0.75,self.gre_m79.AMMO_PICKUP[2] * 0.75}
	self.m32.stats.damage = 400
	self.m32.projectile_types.launcher_velocity = "launcher_velocity_m32"
	self.m32.AMMO_PICKUP = {self.m32.AMMO_PICKUP[1] * 0.75,self.m32.AMMO_PICKUP[2] * 0.75}
	self.china.stats.damage = 400
	self.china.projectile_types.launcher_velocity = "launcher_velocity_china"
	self.china.AMMO_PICKUP = {self.china.AMMO_PICKUP[1] * 0.75,self.china.AMMO_PICKUP[2] * 0.75}
	self.ray.stats.damage = 82
	self.rpg7.stats.damage = 163
	self.ms3gl.stats.damage = 400
	self.ms3gl.AMMO_PICKUP = {self.ms3gl.AMMO_PICKUP[1] * 0.75,self.ms3gl.AMMO_PICKUP[2] * 0.75}
	self.arbiter.stats.damage = 200
	self.arbiter.AMMO_PICKUP = {self.arbiter.AMMO_PICKUP[1] * 0.75,self.arbiter.AMMO_PICKUP[2] * 0.75}
	
	end
	setGLs()
	
	-- Flammenwerfers --
	local function setFLAMENs()
	
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
	self.flamethrower_mk2.CLIP_AMMO_MAX = 300
	self.flamethrower_mk2.NR_CLIPS_MAX = 2
	self.flamethrower_mk2.AMMO_PICKUP = {6.906,11.02}
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
	self.system.CLIP_AMMO_MAX = 250
	self.system.NR_CLIPS_MAX = 2
	self.system.AMMO_PICKUP = {4.83,7.934}
	self.system.AMMO_MAX = self.system.CLIP_AMMO_MAX * self.system.NR_CLIPS_MAX
	end
	setFLAMENs()
	
	--Miniguns--
	
	--the ovkl one
	self.m134.stats.damage = 45
	self.m134.stats.recoil = 17
	self.m134.CLIP_AMMO_MAX = 600
	self.m134.NR_CLIPS_MAX = 1.5
	self.m134.AMMO_MAX = self.m134.CLIP_AMMO_MAX * self.m134.NR_CLIPS_MAX
	self.m134.AMMO_PICKUP = {8.888,22.222}
	self.m134.stats.reload = 14
	--the other one
	self.shuno.CLIP_AMMO_MAX = 600
	self.shuno.NR_CLIPS_MAX = 1.5
	self.shuno.AMMO_MAX = self.shuno.CLIP_AMMO_MAX * self.shuno.NR_CLIPS_MAX
	self.shuno.stats.damage = 68
	self.shuno.stats.recoil = 11
	self.shuno.stats.reload = 14
	self.shuno.AMMO_PICKUP = {6.666,16.666}
	--the 'minigun' that is hailstorm
	self.hailstorm.CLIP_AMMO_MAX = 210
	self.hailstorm.NR_CLIPS_MAX = 3
	self.hailstorm.AMMO_MAX = self.hailstorm.CLIP_AMMO_MAX * self.hailstorm.NR_CLIPS_MAX
	self.hailstorm.stats.damage = 71
	self.hailstorm.stats.recoil = 20
	self.hailstorm.AMMO_PICKUP = {5.54,9.23}
	
	-- Bows and such --
	
	--secondary pistol
	self.hunter.stats.damage = 72
	--light bow
	self.plainsrider.stats.damage = 72
	--light crossbow
	self.frankish.stats.damage = 72
	--longbow
	self.long.stats.damage = 160
	self.long.stats_modifiers = {damage = 10}
	--DECA compouns
	self.elastic.stats.damage = 160
	self.elastic.stats_modifiers = {damage = 10}
	--heavy crossbow
	self.arblast.stats.damage = 160
	self.arblast.stats_modifiers = {damage = 10}
	--h3h3 shit
	self.ecp.stats.damage = 50
	
	local function setNewRecoil() 
		local recoil_ARs = {
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
			"tkb"
		}
		
		local recoil_SMGs = {
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
			-- akimbos
			"x_m45",
			"x_hajk",
			"x_olympic",
			"x_schakal",
			"x_erma",
			"x_sterling",
			"x_vityaz",
			"x_mp5",
			"x_m1928",
			"x_shepheard",
			"x_sr2",
			"x_coal",
			"x_uzi",
			"x_mp7",
			"x_akmsu",
			"x_tec9",
			"x_polymer",
			"x_mac10",
			"x_cobray",
			"x_pm9",
			"x_scorpion",
			"x_mp9",
			"x_baka",
			"x_p90",
			-- full auto pistols and their akimbo's
			"beer",
			"x_beer",
			"glock_18c",
			"x_g18c",
			"czech",
			"x_czech",
			"stech",
			"x_stech"
		}
		
		local recoil_LMGs = {
			"hk21",
			"mg42",
			"m249",
			"par",
			"rpk",
			"m60",
			"hk51b",
			"hcar",
			"kacchainsaw",
			"shuno",
			"m134",
			"hailstorm"
		}
		
		local recoil
		local UPrecoil
		local DOWNrecoil
		local LEFTrecoil
		local RIGHTrecoil
		local tenth
		local recoil_weight
		
		-- set new AR recoil
		for i=1, #recoil_ARs do
			recoil = self[recoil_ARs[i]].stats.recoil * 4 - 4 -- in game calculator seems to be slighlty inaccurate or favours stability down
			tenth = math.floor(recoil / 10)
			recoil_weight = 1 - (recoil/100)
			UPrecoil = 0.4 + (recoil_weight * 1.2)
			if UPrecoil >= 1 then
				DOWNrecoil = UPrecoil * 0.75
			else
				DOWNrecoil = UPrecoil
			end
			-- if base stability value is 0-10/20-30/40-50 etc, recoil favours left, and right for 10-20/30-40 etc
			if math.fmod(tenth,2) == 0 or tenth < 1 then
				LEFTrecoil = 0.5 + (recoil_weight * 0.75)
				RIGHTrecoil = LEFTrecoil * 0.66
			else
				RIGHTrecoil = 0.5 + (recoil_weight * 0.75)
				LEFTrecoil = RIGHTrecoil * 0.66
			end
			LEFTrecoil = LEFTrecoil * -1
			self[recoil_ARs[i]].kick = {
				standing = {
					UPrecoil,
					DOWNrecoil,
					LEFTrecoil,
					RIGHTrecoil
				}
			}
			-- i'd love to give extra 10-20% recoil for beeing crouched, but it only gives such bonuses
			-- for hip-firing while crouched. if you ads, you always use ads stats, no matter if u r 
			-- crouched or not. giving better recoil in ads is pointless, so let it be the same.
			self[recoil_ARs[i]].kick.steelsight = self[recoil_ARs[i]].kick.standing
			self[recoil_ARs[i]].kick.crouching = self[recoil_ARs[i]].kick.standing
		end
		
		-- set new SMG recoil
		for i=1, #recoil_SMGs do
			recoil = self[recoil_SMGs[i]].stats.recoil * 4 - 4
			tenth = math.floor(recoil / 10)
			recoil_weight = 1 - (recoil/100)
			UPrecoil = 0.3 + (recoil_weight * 0.8)
			if UPrecoil >= 0.7 then
				DOWNrecoil = UPrecoil * 0.8
			else
				DOWNrecoil = UPrecoil
			end
			if math.fmod(tenth,2) == 0 or tenth < 1 then
				LEFTrecoil = 0.4 + (recoil_weight * 0.75)
				RIGHTrecoil = LEFTrecoil * 0.73
			else
				RIGHTrecoil = 0.4 + (recoil_weight * 0.75)
				LEFTrecoil = RIGHTrecoil * 0.73
			end
			LEFTrecoil = LEFTrecoil * -1
			self[recoil_SMGs[i]].kick = {
				standing = {
					UPrecoil,
					DOWNrecoil,
					LEFTrecoil,
					RIGHTrecoil
				}
			}
			self[recoil_SMGs[i]].kick.steelsight = self[recoil_SMGs[i]].kick.standing
			self[recoil_SMGs[i]].kick.crouching = self[recoil_SMGs[i]].kick.standing
		end
		
		-- set new LMG recoil
		for i=1, #recoil_LMGs do
			recoil = self[recoil_LMGs[i]].stats.recoil * 4 - 4
			tenth = math.floor(recoil / 10)
			recoil_weight = 1 - (recoil/100)
			UPrecoil = 1.25 + (recoil_weight * 0.5)
			if UPrecoil >= 1.5 then
				DOWNrecoil = UPrecoil * 0.75
			else
				DOWNrecoil = UPrecoil
			end
			if math.fmod(tenth,2) == 0 or tenth < 1 then
				LEFTrecoil = 0.6 + (recoil_weight * 0.5)
				RIGHTrecoil = LEFTrecoil * 0.45
			else
				RIGHTrecoil = 0.6 + (recoil_weight * 0.5)
				LEFTrecoil = RIGHTrecoil * 0.45
			end
			LEFTrecoil = LEFTrecoil * -1
			self[recoil_LMGs[i]].kick = {
				standing = {
					UPrecoil,
					DOWNrecoil,
					LEFTrecoil,
					RIGHTrecoil
				}
			}
			self[recoil_LMGs[i]].kick.steelsight = self[recoil_LMGs[i]].kick.standing
			self[recoil_LMGs[i]].kick.crouching = self[recoil_LMGs[i]].kick.standing
		end
	
	end
	setNewRecoil()
	
	-- remove spread_moving stat from all weapons
	for i=1, #Gilza.defaultWeapons do
		if self[Gilza.defaultWeapons[i]].stats.spread_moving then
			self[Gilza.defaultWeapons[i]].stats.spread_moving = self[Gilza.defaultWeapons[i]].stats.spread
		end
	end
	
end)