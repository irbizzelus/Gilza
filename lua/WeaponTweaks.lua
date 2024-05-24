if not Gilza then
	dofile("mods/Gilza/lua/1_GilzaBase.lua")
end

Hooks:PostHook(WeaponTweakData, "_init_new_weapons", "Gilza_NewWeaponStats", function(self, tweak_data)
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
		"elastic",
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
		"money"
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
		"x_type54_underbarrel",
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
		"contraband_m203",
		"vhs",
		"new_m14",
		"l85a2",
		"aug",
		"corgi",
		"asval",
		"komodo",
		"groza",
		"groza_underbarrel",
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
		"kacchainsaw_flamethrower",
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
		"type54_underbarrel",
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
		"bessy",
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
	
	local function setUpWeapons()
		-- accuracy no longer affected by player pose
		for _, gun in ipairs(weapon_ids) do
			if self[gun] and self[gun].spread.standing and self[gun].spread.steelsight and self[gun].spread.crouching and self[gun].spread.moving_standing and self[gun].spread.moving_crouching and self[gun].spread.moving_steelsight then
				self[gun].spread.steelsight = self[gun].spread.standing
				self[gun].spread.crouching = self[gun].spread.standing
				self[gun].spread.moving_standing = self[gun].spread.standing
				self[gun].spread.moving_crouching = self[gun].spread.standing
				self[gun].spread.moving_steelsight = self[gun].spread.standing
			end
		end
		
		local function TableConcat(t1,t2)
			for i=1,#t2 do
				t1[#t1+1] = t2[i]
			end
			return t1
		end
		
		Gilza.defaultWeapons = TableConcat(special_weapon_ids,weapon_ids)
	end
	setUpWeapons()
	
	local secondary_mul = 0.7
	local secondary_to_primary_mul = 1/secondary_mul
	
	-- Assault rifles --
	local function setARs() -- using funcs for the sake of readability
		
		-- all reload timer overrides check if the reload speed is default, in case user runs custom animations that allready change the reload timers
		
		local avg_120_pickup = 7.08
		local avg_155_pickup = 4.76
		local avg_250_pickup = 2.63
		local avg_450_pickup = 1.62
		
		-- 1-1 headshot kill
		local function init_super_heavy()
			
			local ARs_450 = {
				scar = true,
				ching = true,
				new_m14 = true,
				shak12 = true,
				contraband = "underbarrel",
				fal = true
			}

			for id, status in pairs(ARs_450) do
				if self[id] then
					self[id].stats.damage = 450
					if ARs_450[id] == "underbarrel" then
						self[id].AMMO_PICKUP = {((avg_450_pickup * 0.9) / 1.35) * 0.7,((avg_450_pickup * 1.1) / 1.35) * 0.7}
					else
						self[id].AMMO_PICKUP = {(avg_450_pickup * 0.9) / 1.35,(avg_450_pickup * 1.1) / 1.35}
					end	
				end
			end
			
			self.scar.CLIP_AMMO_MAX = 25
			self.scar.NR_CLIPS_MAX = 4
			self.scar.AMMO_MAX = self.scar.CLIP_AMMO_MAX * self.scar.NR_CLIPS_MAX
			self.scar.stats.spread = 18
			self.scar.stats.recoil = 9
			self.scar.fire_mode_data = {fire_rate = 60/600}
			self.scar.auto = {fire_rate = 60/600}
			
			self.ching.stats.reload = 14
			self.ching.NR_CLIPS_MAX = 8
			self.ching.AMMO_MAX = self.ching.CLIP_AMMO_MAX * self.ching.NR_CLIPS_MAX
			
			self.new_m14.stats.reload = 8
			self.new_m14.CLIP_AMMO_MAX = 15
			self.new_m14.NR_CLIPS_MAX = 5
			self.new_m14.AMMO_MAX = self.new_m14.CLIP_AMMO_MAX * self.new_m14.NR_CLIPS_MAX
			self.new_m14.fire_mode_data = {fire_rate = 60/600}
			self.new_m14.single = {fire_rate = 60/600}
			
			self.shak12.CLIP_AMMO_MAX = 25
			self.shak12.NR_CLIPS_MAX = 4
			self.shak12.AMMO_MAX = self.shak12.CLIP_AMMO_MAX * self.shak12.NR_CLIPS_MAX
			self.shak12.stats.recoil = 11
			self.shak12.stats.spread = 19
			
			self.contraband.CLIP_AMMO_MAX = 25
			self.contraband.NR_CLIPS_MAX = 3
			self.contraband.AMMO_MAX = self.contraband.CLIP_AMMO_MAX * self.contraband.NR_CLIPS_MAX
			self.contraband.stats.recoil = 9
			self.contraband.stats.spread = 19
			self.contraband.fire_mode_data = {fire_rate = 60/600}
			self.contraband.auto = {fire_rate = 60/600}
			
			self.fal.CLIP_AMMO_MAX = 20
			self.fal.NR_CLIPS_MAX = 5
			self.fal.AMMO_MAX = self.fal.CLIP_AMMO_MAX * self.fal.NR_CLIPS_MAX
			self.fal.stats.recoil = 8
			self.fal.stats.spread = 16
			self.fal.fire_mode_data = {fire_rate = 60/660}
			self.fal.auto = {fire_rate = 60/660}
			
		end
		
		-- 1-2 headshot kill
		local function init_heavy()
			
			local ARs_250 = {
				groza = "underbarrel",
				akm = true,
				akm_gold = true,
				vhs = true,
				galil = true,
				g3 = true
			}

			for id, status in pairs(ARs_250) do
				if self[id] then
					self[id].stats.damage = 250
					if ARs_250[id] == "underbarrel" then
						self[id].AMMO_PICKUP = {((avg_250_pickup * 0.9) / 1.35) * 0.7,((avg_250_pickup * 1.1) / 1.35) * 0.7}
					else
						self[id].AMMO_PICKUP = {(avg_250_pickup * 0.9) / 1.35,(avg_250_pickup * 1.1) / 1.35}
					end	
				end
			end
			
			self.groza.CLIP_AMMO_MAX = 25
			self.groza.NR_CLIPS_MAX = 4
			self.groza.AMMO_MAX = self.groza.CLIP_AMMO_MAX * self.groza.NR_CLIPS_MAX
			self.groza.stats.recoil = 13
			self.groza.stats.spread = 11
			self.groza.auto = {fire_rate = 60/700}
			self.groza.fire_mode_data = {fire_rate = 60/700}
			
			self.akm.NR_CLIPS_MAX = 5
			self.akm.AMMO_MAX = self.akm.CLIP_AMMO_MAX * self.akm.NR_CLIPS_MAX
			self.akm.stats.recoil = 12
			self.akm.stats.spread = 11
			self.akm.auto = {fire_rate = 60/600}
			self.akm.fire_mode_data = {fire_rate = 60/600}
			if self.akm.timers.reload_not_empty == 2.8 then
				self.akm.timers.reload_not_empty = 2.4
			end
			
			self.akm_gold.NR_CLIPS_MAX = 5
			self.akm_gold.AMMO_MAX = self.akm_gold.CLIP_AMMO_MAX * self.akm_gold.NR_CLIPS_MAX
			self.akm_gold.stats.recoil = 14
			self.akm_gold.stats.spread = 10
			self.akm_gold.stats.concealment = 8
			self.akm_gold.auto = {fire_rate = 60/600}
			self.akm_gold.fire_mode_data = {fire_rate = 60/600}
			if self.akm_gold.timers.reload_not_empty == 2.8 then
				self.akm_gold.timers.reload_not_empty = 2.4
			end
			
			self.vhs.stats.recoil = 20
			self.vhs.stats.spread = 5
			self.vhs.stats.reload = 14
			self.vhs.NR_CLIPS_MAX = 5
			self.vhs.AMMO_MAX = self.vhs.CLIP_AMMO_MAX * self.vhs.NR_CLIPS_MAX
			self.vhs.auto = {fire_rate = 60/850}
			self.vhs.fire_mode_data = {fire_rate = 60/850}
			
			self.galil.stats.recoil = 17
			self.galil.stats.spread = 8
			self.galil.NR_CLIPS_MAX = 5
			self.galil.AMMO_MAX = self.galil.CLIP_AMMO_MAX * self.galil.NR_CLIPS_MAX
			self.galil.NR_CLIPS_MAX = 4
			self.galil.auto = {fire_rate = 60/700}
			self.galil.fire_mode_data = {fire_rate = 60/700}
			
			self.g3.CLIP_AMMO_MAX = 25
			self.g3.NR_CLIPS_MAX = 5
			self.g3.AMMO_MAX = self.g3.CLIP_AMMO_MAX * self.g3.NR_CLIPS_MAX
			self.g3.stats.recoil = 16
			self.g3.stats.spread = 19
			self.g3.fire_mode_data = {fire_rate = 60/650}
			self.g3.auto = {fire_rate = 60/650}
			
		end
		
		-- 2-3 headshot kill - 155 profile breakpoints on swats but tiny bit better breakpoints on specials
		local function init_medium_heavy()
			
			local ARs_200 = {
				amcar = true,
				ak74 = true,
				aug = true,
				sub2000 = true,
				l85a2 = true,
				asval = true,		
			}

			for id, status in pairs(ARs_200) do
				if self[id] then
					self[id].stats.damage = 200
					self[id].AMMO_PICKUP = {((avg_155_pickup * 0.9) / 1.35) * 0.85,((avg_155_pickup * 1.1) / 1.35) * 0.85}
				end
			end
			
			self.amcar.CLIP_AMMO_MAX = 25
			self.amcar.NR_CLIPS_MAX = 6
			self.amcar.AMMO_MAX = self.amcar.CLIP_AMMO_MAX * self.amcar.NR_CLIPS_MAX
			self.amcar.fire_mode_data = {fire_rate = 60/650}
			self.amcar.auto = {fire_rate = 60/650}
			self.amcar.stats.recoil = 7
			
			self.ak74.NR_CLIPS_MAX = 5
			self.ak74.AMMO_MAX = self.ak74.CLIP_AMMO_MAX * self.ak74.NR_CLIPS_MAX
			self.ak74.stats.spread = 11
			self.ak74.stats.recoil = 12
			self.ak74.fire_mode_data = {fire_rate = 60/650}
			self.ak74.auto = {fire_rate = 60/650}
			
			self.aug.stats.recoil = 13
			self.aug.stats.spread = 17
			self.aug.fire_mode_data = {fire_rate = 60/680}
			self.aug.auto = {fire_rate = 60/680}
			self.aug.NR_CLIPS_MAX = 5
			self.aug.AMMO_MAX = self.aug.CLIP_AMMO_MAX * self.aug.NR_CLIPS_MAX
			
			self.sub2000.NR_CLIPS_MAX = 3
			self.sub2000.AMMO_MAX = self.sub2000.CLIP_AMMO_MAX * self.sub2000.NR_CLIPS_MAX
			self.sub2000.stats.spread = 20
			self.sub2000.fire_mode_data = {fire_rate = 60/669}
			self.sub2000.single = {fire_rate = 60/669}
			
			self.l85a2.stats.reload = 15
			self.l85a2.stats.recoil = 14
			self.l85a2.stats.spread = 13
			self.l85a2.NR_CLIPS_MAX = 5
			self.l85a2.AMMO_MAX = self.l85a2.CLIP_AMMO_MAX * self.l85a2.NR_CLIPS_MAX
			
			self.asval.CLIP_AMMO_MAX = 20
			self.asval.NR_CLIPS_MAX = 6
			self.asval.AMMO_MAX = self.asval.CLIP_AMMO_MAX * self.asval.NR_CLIPS_MAX
			self.asval.stats.spread = 22
			self.asval.stats.reload = 20
			self.asval.stats.recoil = 17
			self.asval.auto = {fire_rate = 60/900}
			self.asval.fire_mode_data = {fire_rate = 60/900}
			
		end
		
		-- 2-3 headshot kill
		local function init_medium()
			
			local ARs_155 = {
				corgi = true,
				s552 = true,
				new_m4 = true,			
				g36 = true,	
				flint = true,
				tecci = true,
				m16 = true,			
				tkb = true,
			}

			for id, status in pairs(ARs_155) do
				if self[id] then
					self[id].stats.damage = 155
					self[id].AMMO_PICKUP = {(avg_155_pickup * 0.9) / 1.35,(avg_155_pickup * 1.1) / 1.35}
				end
			end
			
			self.corgi.NR_CLIPS_MAX = 5
			self.corgi.AMMO_MAX = self.corgi.CLIP_AMMO_MAX * self.corgi.NR_CLIPS_MAX
			self.corgi.auto = {fire_rate = 60/875}
			self.corgi.fire_mode_data = {fire_rate = 60/875}
			self.corgi.stats.recoil = 15
			self.corgi.stats.spread = 17
			self.corgi.stats.concealment = 19
			
			self.s552.NR_CLIPS_MAX = 7
			self.s552.AMMO_MAX = self.s552.CLIP_AMMO_MAX * self.s552.NR_CLIPS_MAX
			self.s552.stats.recoil = 13
			self.s552.stats.spread = 10
			self.s552.fire_mode_data = {fire_rate = 60/700}
			self.s552.auto = {fire_rate = 60/700}
			self.s552.stats.reload = 15
			
			self.new_m4.stats.recoil = 8
			self.new_m4.stats.spread = 12
			self.new_m4.NR_CLIPS_MAX = 6
			self.new_m4.AMMO_MAX = self.new_m4.CLIP_AMMO_MAX * self.new_m4.NR_CLIPS_MAX
			self.new_m4.fire_mode_data = {fire_rate = 60/750}
			self.new_m4.auto = {fire_rate = 60/750}
			-- compatibility with my favourite custom AR animations since they override timer data
			if self.new_m4.timers.reload_not_empty == 2.665 then
				self.new_m4.stats.reload = 15
			end
			
			self.g36.NR_CLIPS_MAX = 6
			self.g36.stats.spread = 5
			self.g36.AMMO_MAX = self.g36.CLIP_AMMO_MAX * self.g36.NR_CLIPS_MAX
			self.g36.stats.recoil = 23
			self.g36.stats.concealment = 20
			self.g36.stats.reload = 13
			self.g36.auto = {fire_rate = 60/750}
			self.g36.fire_mode_data = {fire_rate = 60/750}
			
			self.flint.NR_CLIPS_MAX = 5
			self.flint.AMMO_MAX = self.flint.CLIP_AMMO_MAX * self.flint.NR_CLIPS_MAX
			self.flint.stats.concealment = 11
			self.flint.stats.spread = 14
			self.flint.stats.recoil = 14
			self.flint.fire_mode_data = {fire_rate = 60/700}
			self.flint.auto = {fire_rate = 60/700}
			
			self.tecci.stats.recoil = 20
			self.tecci.stats.spread = 2
			self.tecci.NR_CLIPS_MAX = 2
			self.tecci.AMMO_MAX = self.tecci.CLIP_AMMO_MAX * self.tecci.NR_CLIPS_MAX
			self.tecci.fire_mode_data = {fire_rate = 60/600}
			self.tecci.auto = {fire_rate = 60/600}
			
			self.m16.NR_CLIPS_MAX = 5
			self.m16.AMMO_MAX = self.m16.CLIP_AMMO_MAX * self.m16.NR_CLIPS_MAX
			self.m16.stats.recoil = 1
			self.m16.stats.spread = 22
			self.m16.fire_mode_data = {fire_rate = 60/900}
			self.m16.auto = {fire_rate = 60/900}
			
			self.tkb.NR_CLIPS_MAX = 2.5
			self.tkb.AMMO_MAX = self.tkb.CLIP_AMMO_MAX * self.tkb.NR_CLIPS_MAX
			self.tkb.stats.spread = 5
			self.tkb.stats.concealment = 12
		
		end
		
		-- 3-4 headshot kill
		local function init_light()
			
			local ARs_120 = {
				famas = true,
				ak5 = true,
				komodo = true
			}

			for id, status in pairs(ARs_120) do
				if self[id] then
					self[id].stats.damage = 120
					self[id].AMMO_PICKUP = {(avg_120_pickup * 0.9) / 1.35,(avg_120_pickup * 1.1) / 1.35}
				end
			end	
			
			self.famas.NR_CLIPS_MAX = 8
			self.famas.AMMO_MAX = self.famas.CLIP_AMMO_MAX * self.famas.NR_CLIPS_MAX
			self.famas.stats.recoil = 19
			self.famas.stats.spread = 6
		
			self.ak5.NR_CLIPS_MAX = 5
			self.ak5.AMMO_MAX = self.ak5.CLIP_AMMO_MAX * self.ak5.NR_CLIPS_MAX
			self.ak5.stats.recoil = 19
			self.ak5.stats.spread = 18		
			
			self.komodo.fire_mode_data = {fire_rate = 60/850}
			self.komodo.auto = {fire_rate = 60/850}
			self.komodo.stats.recoil = 15
			self.komodo.stats.spread = 15
			self.komodo.NR_CLIPS_MAX = 6
			self.komodo.AMMO_MAX = self.komodo.CLIP_AMMO_MAX * self.komodo.NR_CLIPS_MAX
		
		end
		
		init_super_heavy()
		init_heavy()
		init_medium_heavy()
		init_medium()
		init_light()
		
	end
	setARs()
	
	-- Shotguns --
	local function setSHOTGUNs()
		
		local avg_1000_pickup = 0.65
		local avg_450_pickup = 0.87
		local avg_310_pickup = 1.77
		local avg_110_pickup = 5.78
		
		local new_DB_shotgun_damage_falloff = {
			optimal_distance = 0,
			optimal_range = 1850,
			near_falloff = 0,
			far_falloff = 1000,
			near_multiplier = 1,
			far_multiplier = 0.5
		}
		local new_pump_shotgun_damage_falloff = {
			optimal_distance = 0,
			optimal_range = 1500,
			near_falloff = 0,
			far_falloff = 1000,
			near_multiplier = 1,
			far_multiplier = 0.5
		}
		local new_semi_shotgun_damage_falloff = {
			optimal_distance = 0,
			optimal_range = 1250,
			near_falloff = 0,
			far_falloff = 1000,
			near_multiplier = 1,
			far_multiplier = 0.5
		}
		local new_auto_shotgun_damage_falloff = {
			optimal_distance = 0,
			optimal_range = 1000,
			near_falloff = 0,
			far_falloff = 1000,
			near_multiplier = 1,
			far_multiplier = 0.5
		}
		
		-- Double barrel
		local function init_DB()
			
			local DB_shotguns = {
				huntsman = true,
				b682 = true,
				coach = "secondary"
			}

			for id, status in pairs(DB_shotguns) do
				if self[id] then
					self[id].stats.damage = 1000
					self[id].stats.recoil = 21
					self[id].stats.spread = 22
					self[id].rays = 10
					Gilza.shotgun_minimal_damage_multipliers[id] = 1
					if status == "secondary" then
						self[id].AMMO_PICKUP = {((avg_1000_pickup * 0.9) / 1.35) * secondary_mul,((avg_1000_pickup * 1.1) / 1.35) * secondary_mul}
					else
						self[id].AMMO_PICKUP = {(avg_1000_pickup * 0.9) / 1.35,(avg_1000_pickup * 1.1) / 1.35}
					end
					self[id].damage_falloff = new_DB_shotgun_damage_falloff
				end
			end	
			
			self.huntsman.NR_CLIPS_MAX = 13
			self.huntsman.AMMO_MAX = self.huntsman.CLIP_AMMO_MAX * self.huntsman.NR_CLIPS_MAX
			self.huntsman.fire_mode_data = {fire_rate = 60/300}
			self.huntsman.single = {fire_rate = 60/300}
			
			self.b682.NR_CLIPS_MAX = 10
			self.b682.AMMO_MAX = self.b682.CLIP_AMMO_MAX * self.b682.NR_CLIPS_MAX
			self.b682.fire_mode_data = {fire_rate = 60/350}
			self.b682.single = {fire_rate = 60/350}
			
			self.coach.NR_CLIPS_MAX = 8
			self.coach.AMMO_MAX = self.coach.CLIP_AMMO_MAX * self.coach.NR_CLIPS_MAX
			self.coach.stats.recoil = 8
			self.coach.stats.spread = 20
			self.coach.fire_mode_data = {fire_rate = 60/325}
			self.coach.single = {fire_rate = 60/325}
		
		end
		init_DB()
		
		-- Pump action
		local function init_PA()
			
			local PA_shotguns = {
				boot = true, -- lever action technically, but is shares the damage class
				r870 = true,
				m590 = true,
				ksg = true,
				m1897 = true,
				supernova = true, -- technically a hybrid
				serbu = "secondary",
				m37 = "secondary"
			}

			for id, status in pairs(PA_shotguns) do
				if self[id] then
					self[id].stats.damage = 450
					self[id].rays = 10
					Gilza.shotgun_minimal_damage_multipliers[id] = 0.8
					if status == "secondary" then
						self[id].AMMO_PICKUP = {((avg_450_pickup * 0.9) / 1.35) * secondary_mul,((avg_450_pickup * 1.1) / 1.35) * secondary_mul}
					else
						self[id].AMMO_PICKUP = {(avg_450_pickup * 0.9) / 1.35,(avg_450_pickup * 1.1) / 1.35}
					end
					self[id].damage_falloff = new_pump_shotgun_damage_falloff
				end
			end	
			
			self.boot.NR_CLIPS_MAX = 5
			self.boot.AMMO_MAX = self.boot.CLIP_AMMO_MAX * self.boot.NR_CLIPS_MAX
			self.boot.stats.recoil = 21
			self.boot.stats.spread = 16
			self.boot.fire_mode_data = {fire_rate = 60/80}
			self.boot.single = {fire_rate = 60/80}
			
			self.r870.NR_CLIPS_MAX = 6
			self.r870.AMMO_MAX = self.r870.CLIP_AMMO_MAX * self.r870.NR_CLIPS_MAX
			self.r870.stats.recoil = 11
			self.r870.stats.spread = 19
			self.r870.fire_mode_data = {fire_rate = 60/110}
			self.r870.single = {fire_rate = 60/110}
			
			self.m590.CLIP_AMMO_MAX = 5
			self.m590.NR_CLIPS_MAX = 7
			self.m590.AMMO_MAX = self.m590.CLIP_AMMO_MAX * self.m590.NR_CLIPS_MAX
			self.m590.stats.recoil = 14
			self.m590.stats.spread = 12
			self.m590.fire_mode_data = {fire_rate = 60/120}
			self.m590.single = {fire_rate = 60/120}
			
			self.ksg.CLIP_AMMO_MAX = 14
			self.ksg.NR_CLIPS_MAX = 2
			self.ksg.AMMO_MAX = self.ksg.CLIP_AMMO_MAX * self.ksg.NR_CLIPS_MAX
			self.ksg.stats.recoil = 11
			self.ksg.stats.spread = 19
			self.ksg.fire_mode_data = {fire_rate = 60/100}
			self.ksg.single = {fire_rate = 60/100}
			
			self.m1897.CLIP_AMMO_MAX = 7
			self.m1897.NR_CLIPS_MAX = 5
			self.m1897.AMMO_MAX = self.m1897.CLIP_AMMO_MAX * self.m1897.NR_CLIPS_MAX
			self.m1897.stats.recoil = 21
			self.m1897.stats.spread = 14
			self.m1897.stats.reload = 14
			self.m1897.stats.concealment = 15
			self.m1897.fire_mode_data = {fire_rate = 60/90}
			self.m1897.single = {fire_rate = 60/90}	
			
			self.supernova.CLIP_AMMO_MAX = 6
			self.supernova.NR_CLIPS_MAX = 5
			self.supernova.AMMO_MAX = self.supernova.CLIP_AMMO_MAX * self.supernova.NR_CLIPS_MAX
			self.supernova.stats.spread = 14
			self.supernova.stats.recoil = 5
			self.supernova.fire_mode_data = {fire_rate = 60/70}
			self.supernova.single = {fire_rate = 60/70}
			self.supernova.alt_fire_data.fire_rate = 60/280
			self.supernova.alt_fire_data.spread_mul = 3
			self.supernova.alt_fire_data.damage_mul = 1
			self.supernova.alt_fire_data.recoil_mul = 1.5
			
			self.serbu.NR_CLIPS_MAX = 4
			self.serbu.AMMO_MAX = self.serbu.CLIP_AMMO_MAX * self.serbu.NR_CLIPS_MAX
			self.serbu.stats.recoil = 9
			self.serbu.stats.spread = 11
			self.serbu.fire_mode_data = {fire_rate = 60/100}
			self.serbu.single = {fire_rate = 60/100}
			
			self.m37.NR_CLIPS_MAX = 3
			self.m37.AMMO_MAX = self.m37.CLIP_AMMO_MAX * self.m37.NR_CLIPS_MAX
			self.m37.stats.recoil = 15
			self.m37.stats.spread = 10
			self.m37.fire_mode_data = {fire_rate = 60/110}
			self.m37.single = {fire_rate = 60/110}
		
		end
		init_PA()
		
		-- Semi-auto
		local function init_SA()
			
			local SA_shotguns = {
				spas12 = true,
				benelli = true,
				striker = "secondary",
				ultima = "secondary",
				judge = "secondary",
				x_judge = "akimbo"
			}

			for id, status in pairs(SA_shotguns) do
				if self[id] then
					self[id].stats.damage = 325
					self[id].rays = 10
					Gilza.shotgun_minimal_damage_multipliers[id] = 0.67
					self[id].fire_mode_data = {fire_rate = 60/320}
					self[id].single = {fire_rate = 60/320}
					if status == "secondary" then
						self[id].AMMO_PICKUP = {(avg_310_pickup * 0.9) / 1.35 * secondary_mul,(avg_310_pickup * 1.1) / 1.35 * secondary_mul}
					else
						self[id].AMMO_PICKUP = {(avg_310_pickup * 0.9) / 1.35,(avg_310_pickup * 1.1) / 1.35}
					end
					if status == "akimbo" then
						self[id].stats.damage = math.ceil(self[id].stats.damage/2)
						self[id].AMMO_PICKUP[1] = self[id].AMMO_PICKUP[1] * 2
						self[id].AMMO_PICKUP[2] = self[id].AMMO_PICKUP[2] * 2
					end
					self[id].damage_falloff = new_semi_shotgun_damage_falloff	
				end
			end
			
			self.spas12.NR_CLIPS_MAX = 8
			self.spas12.AMMO_MAX = self.spas12.CLIP_AMMO_MAX * self.spas12.NR_CLIPS_MAX
			self.spas12.stats.recoil = 17
			self.spas12.stats.spread = 12
			
			self.benelli.NR_CLIPS_MAX = 6
			self.benelli.AMMO_MAX = self.benelli.CLIP_AMMO_MAX * self.benelli.NR_CLIPS_MAX
			self.benelli.stats.recoil = 17
			self.benelli.stats.spread = 12
			
			self.striker.NR_CLIPS_MAX = 2.5
			self.striker.AMMO_MAX = self.striker.CLIP_AMMO_MAX * self.striker.NR_CLIPS_MAX
			self.striker.stats.recoil = 13
			self.striker.stats.reload = 13
			self.striker.stats.spread = 10
			self.striker.fire_mode_data = {fire_rate = 60/380}
			self.striker.single = {fire_rate = 60/380}
			
			self.ultima.NR_CLIPS_MAX = 4
			self.ultima.AMMO_MAX = self.ultima.CLIP_AMMO_MAX * self.ultima.NR_CLIPS_MAX
			self.ultima.stats.recoil = 5
			self.ultima.stats.spread = 15
			self.ultima.fire_mode_data = {fire_rate = 60/330}
			self.ultima.single = {fire_rate = 60/330}
			
			self.judge.NR_CLIPS_MAX = 4
			self.judge.AMMO_MAX = self.judge.CLIP_AMMO_MAX * self.judge.NR_CLIPS_MAX
			self.judge.stats.recoil = 7
			self.judge.stats.spread = 1
			self.judge.stats.reload = 9
			self.judge.fire_mode_data = {fire_rate = 60/250}
			self.judge.single = {fire_rate = 60/250}
			
			self.x_judge.stats.recoil = 7
			self.x_judge.stats.spread = 1
			self.x_judge.fire_mode_data = {fire_rate = 60/250}
			self.x_judge.single = {fire_rate = 60/250}
			
		end
		init_SA()
		
		-- Full auto
		local function init_FA()
			
			local FA_shotguns = {
				sko12 = true,
				saiga = true,
				aa12 = true,
				x_sko12 = "akimbo",
				rota = "secondary",
				x_rota = "akimbo",
				basset = "secondary",
				x_basset = "akimbo"
			}

			for id, status in pairs(FA_shotguns) do
				if self[id] then
					self[id].stats.damage = 100
					self[id].rays = 10
					Gilza.shotgun_minimal_damage_multipliers[id] = 0.5
					self[id].fire_mode_data = {fire_rate = 60/350}
					self[id].single = {fire_rate = 60/350}
					if status == "secondary" then
						self[id].AMMO_PICKUP = {(avg_110_pickup * 0.9) / 1.35 * secondary_mul,(avg_110_pickup * 1.1) / 1.35 * secondary_mul}
					else
						self[id].AMMO_PICKUP = {(avg_110_pickup * 0.9) / 1.35,(avg_110_pickup * 1.1) / 1.35}
					end
					if status == "akimbo" then
						self[id].stats.damage = math.ceil(self[id].stats.damage/2)
						self[id].AMMO_PICKUP[1] = self[id].AMMO_PICKUP[1] * 2
						self[id].AMMO_PICKUP[2] = self[id].AMMO_PICKUP[2] * 2
					end
					self[id].damage_falloff = new_auto_shotgun_damage_falloff
				end
			end
			
			self.sko12.NR_CLIPS_MAX = 2
			self.sko12.AMMO_MAX = self.sko12.CLIP_AMMO_MAX * self.sko12.NR_CLIPS_MAX
			self.sko12.stats.recoil = 10
			self.sko12.stats.spread = 7
			
			self.saiga.NR_CLIPS_MAX = 7
			self.saiga.AMMO_MAX = self.saiga.CLIP_AMMO_MAX * self.saiga.NR_CLIPS_MAX
			self.saiga.stats.recoil = 9
			self.saiga.stats.spread = 6
			self.saiga.fire_mode_data = {fire_rate = 60/400}
			self.saiga.single = {fire_rate = 60/400}
			
			self.aa12.NR_CLIPS_MAX = 7
			self.aa12.AMMO_MAX = self.aa12.CLIP_AMMO_MAX * self.aa12.NR_CLIPS_MAX
			self.aa12.stats.recoil = 5
			self.aa12.stats.spread = 9
			self.aa12.stats.reload = 14
			self.aa12.stats.concealment = 20
			
			self.x_sko12.stats.recoil = 8
			self.x_sko12.fire_mode_data = {fire_rate = 60/340}
			self.x_sko12.single = {fire_rate = 60/340}
			
			self.rota.NR_CLIPS_MAX = 7
			self.rota.AMMO_MAX = self.rota.CLIP_AMMO_MAX * self.rota.NR_CLIPS_MAX
			self.rota.stats.recoil = 8
			self.rota.stats.spread = 20
			self.rota.stats.reload = 16
			self.rota.fire_mode_data = {fire_rate = 60/310}
			self.rota.single = {fire_rate = 60/310}
			
			self.x_rota.NR_CLIPS_MAX = 5.5
			self.x_rota.AMMO_MAX = self.x_rota.CLIP_AMMO_MAX * self.x_rota.NR_CLIPS_MAX
			self.x_rota.stats.recoil = 8
			self.x_rota.stats.spread = 20
			self.x_rota.fire_mode_data = {fire_rate = 60/310}
			self.x_rota.single = {fire_rate = 60/310}
			
			self.basset.CLIP_AMMO_MAX = 6
			self.basset.NR_CLIPS_MAX = 6
			self.basset.AMMO_MAX = self.basset.CLIP_AMMO_MAX * self.basset.NR_CLIPS_MAX
			self.basset.stats.recoil = 14
			self.basset.stats.spread = 4
			
			self.x_basset.CLIP_AMMO_MAX = 14
			self.x_basset.NR_CLIPS_MAX = 4
			self.x_basset.AMMO_MAX = self.x_basset.CLIP_AMMO_MAX * self.x_basset.NR_CLIPS_MAX
			self.x_basset.stats.recoil = 14
			self.x_basset.stats.spread = 4
			
		end
		init_FA()
		
	end
	setSHOTGUNs()
	
	-- Light Machine Guns --
	local function setLMGs()
		
		-- +25% compared to AR, should incentivize defence playstyle by allowing to pick up less often, and reducing dmg up close
		local avg_250_pickup = 3.29
		local avg_155_pickup = 5.95
		local avg_120_pickup = 8.85
		
		local new_lmg_damage_falloff = {
			optimal_distance = 200,
			optimal_range = 1000,
			near_falloff = 0,
			far_falloff = 1000,
			near_multiplier = 0.5,
			far_multiplier = 1.65
		}
		
		-- NO BIPOD -- +15%
		self.hk51b.stats.damage = 200
		self.hk51b.stats.spread = 11
		self.hk51b.stats.recoil = 10
		self.hk51b.NR_CLIPS_MAX = 3
		self.hk51b.AMMO_MAX = self.hk51b.CLIP_AMMO_MAX * self.hk51b.NR_CLIPS_MAX
		self.hk51b.AMMO_PICKUP = {(4.64 * 0.9) / 1.35,(4.64 * 1.1) / 1.35}
		self.hk51b.damage_falloff = deep_clone(new_lmg_damage_falloff)
		self.hk51b.damage_falloff.far_multiplier = 1
		self.hk51b.damage_falloff.near_multiplier = 1
		
		self.hcar.stats.damage = 250
		self.hcar.NR_CLIPS_MAX = 8
		self.hcar.AMMO_MAX = self.hcar.CLIP_AMMO_MAX * self.hcar.NR_CLIPS_MAX
		self.hcar.AMMO_PICKUP = {(3.02 * 0.9) / 1.35,(3.02 * 1.1) / 1.35}
		self.hcar.damage_falloff = deep_clone(new_lmg_damage_falloff)
		self.hcar.damage_falloff.far_multiplier = 1
		self.hcar.damage_falloff.near_multiplier = 1
		
		self.kacchainsaw.stats.damage = 120
		self.kacchainsaw.AMMO_PICKUP = {(8.14 * 0.9) / 1.35,(8.14 * 1.1) / 1.35}
		self.kacchainsaw.damage_falloff = deep_clone(new_lmg_damage_falloff)
		self.kacchainsaw.damage_falloff.far_multiplier = 1
		self.kacchainsaw.damage_falloff.near_multiplier = 1
		self.kacchainsaw_flamethrower.CLIP_AMMO_MAX = 150
		self.kacchainsaw_flamethrower.NR_CLIPS_MAX = 250/150
		self.kacchainsaw_flamethrower.AMMO_MAX = self.kacchainsaw_flamethrower.CLIP_AMMO_MAX * self.kacchainsaw_flamethrower.NR_CLIPS_MAX
		self.kacchainsaw_flamethrower.AMMO_PICKUP = {1.7,3.5}
		self.kacchainsaw_flamethrower.stats.damage = 25
		
		-- HEAVY --
		self.hk21.AMMO_PICKUP = {(avg_250_pickup * 0.9) / 1.35,(avg_250_pickup * 1.1) / 1.35}
		self.hk21.NR_CLIPS_MAX = 2
		self.hk21.AMMO_MAX = self.hk21.CLIP_AMMO_MAX * self.hk21.NR_CLIPS_MAX
		self.hk21.stats.spread = 10
		self.hk21.stats.recoil = 12
		self.hk21.damage_falloff = deep_clone(new_lmg_damage_falloff)
		self.hk21.stats.damage = 250
		self.rpk.AMMO_PICKUP = {(avg_250_pickup * 0.9) / 1.35,(avg_250_pickup * 1.1) / 1.35}
		self.rpk.NR_CLIPS_MAX = 3
		self.rpk.AMMO_MAX = self.rpk.CLIP_AMMO_MAX * self.rpk.NR_CLIPS_MAX
		self.rpk.stats.spread = 5
		self.rpk.stats.suppression = 5
		self.rpk.stats.recoil = 13
		self.rpk.damage_falloff = deep_clone(new_lmg_damage_falloff)
		self.rpk.stats.damage = 250
		self.m60.AMMO_PICKUP = {(avg_250_pickup * 0.9) / 1.35,(avg_250_pickup * 1.1) / 1.35}
		self.m60.NR_CLIPS_MAX = 1.5
		self.m60.AMMO_MAX = self.m60.CLIP_AMMO_MAX * self.m60.NR_CLIPS_MAX
		self.m60.stats.spread = 10
		self.m60.stats.recoil = 10
		self.m60.damage_falloff = deep_clone(new_lmg_damage_falloff)
		self.m60.stats.damage = 250
		
		-- LIGHT --
		self.m249.AMMO_PICKUP = {(avg_155_pickup * 0.9) / 1.35,(avg_155_pickup * 1.1) / 1.35}
		self.m249.NR_CLIPS_MAX = 2
		self.m249.AMMO_MAX = self.m249.CLIP_AMMO_MAX * self.m249.NR_CLIPS_MAX
		self.m249.stats.spread = 8
		self.m249.stats.recoil = 10
		self.m249.damage_falloff = deep_clone(new_lmg_damage_falloff)
		self.m249.stats.damage = 155
		self.par.AMMO_PICKUP = {(avg_155_pickup * 0.9) / 1.35,(avg_155_pickup * 1.1) / 1.35}
		self.par.NR_CLIPS_MAX = 2
		self.par.AMMO_MAX = self.par.CLIP_AMMO_MAX * self.par.NR_CLIPS_MAX
		self.par.stats.spread = 8
		self.par.stats.recoil = 13
		self.par.damage_falloff = deep_clone(new_lmg_damage_falloff)
		self.par.stats.damage = 155
		
		-- SUPER LIGHT --
		self.mg42.stats.damage = 120
		self.mg42.AMMO_PICKUP = {(avg_120_pickup * 0.9) / 1.35,(avg_120_pickup * 1.1) / 1.35}
		self.mg42.CLIP_AMMO_MAX = 100
		self.mg42.NR_CLIPS_MAX = 4
		self.mg42.AMMO_MAX = self.mg42.CLIP_AMMO_MAX * self.mg42.NR_CLIPS_MAX
		self.mg42.stats.spread = 7
		self.mg42.stats.reload = 15
		self.mg42.stats.recoil = 15
		self.mg42.damage_falloff = deep_clone(new_lmg_damage_falloff)
		self.mg42.damage_falloff.far_multiplier = 2.1
	end
	setLMGs()
	
	-- Snipers --
	local function setSNIPERs()
		
		local sniper_SA_avg_pickup = 0.8
		local sniper_LA_avg_pickup = 0.74
		local sniper_BA_avg_pickup = 0.64
		local sniper_BAH_avg_pickup = 0.57
		
		local new_sniper_damage_falloff = {
			optimal_distance = 10,
			optimal_range = 10,
			near_falloff = 0,
			far_falloff = 0,
			near_multiplier = 1,
			far_multiplier = 1
		}
		
		-- Semi autos
		local function init_SA()
			
			local Sniper_SA = {
				qbu88 = true,
				wa2000 = true,
				tti = true,
				siltstone = true,
				victor = "secondary"
			}

			for id, status in pairs(Sniper_SA) do
				if self[id] then
					self[id].stats.damage = 650
					if status == "secondary" then
						self[id].AMMO_PICKUP = {((sniper_SA_avg_pickup * 0.9) / 1.35) * secondary_mul,((sniper_SA_avg_pickup * 1.1) / 1.35) * secondary_mul}
					else
						self[id].AMMO_PICKUP = {(sniper_SA_avg_pickup * 0.9) / 1.35,(sniper_SA_avg_pickup * 1.1) / 1.35}
					end
					self[id].fire_mode_data = {fire_rate = 60/300}
					self[id].single = {fire_rate = 60/300}
					self[id].damage_falloff = new_sniper_damage_falloff
					self[id].AMMO_MAX = 40
					self[id].NR_CLIPS_MAX = self[id].AMMO_MAX / self[id].CLIP_AMMO_MAX
				end
			end	
			
			self.qbu88.stats.recoil = 13
			self.qbu88.stats.spread = 17
			
			self.wa2000.stats.recoil = 23
			self.wa2000.stats.spread = 18
			self.wa2000.stats.concealment = 10
			
			self.tti.stats.recoil = 10
			self.tti.stats.spread = 14
			
			self.siltstone.stats.recoil = 11
			self.siltstone.stats.spread = 22
			
			if self.victor.timers.reload_empty == 3 then
				self.victor.timers.reload_empty = 2.75
			end
			self.victor.stats.reload = 14
			self.victor.stats.spread = 16
			self.victor.CLIP_AMMO_MAX = 7
			self.victor.NR_CLIPS_MAX = 4
			self.victor.AMMO_MAX = self.victor.CLIP_AMMO_MAX * self.victor.NR_CLIPS_MAX
			-- ?????
			self.victor.auto = {fire_rate = 60/300}
			
		end
		init_SA()
		
		-- Lever action
		local function init_LA()
			
			local Sniper_LA = {
				sbl = true,
				winchester1874 = true,
				scout = "secondary"
			}

			for id, status in pairs(Sniper_LA) do
				if self[id] then
					self[id].stats.damage = 950
					if status == "secondary" then
						self[id].AMMO_PICKUP = {((sniper_LA_avg_pickup * 0.9) / 1.35) * secondary_mul,((sniper_LA_avg_pickup * 1.1) / 1.35) * secondary_mul}
					else
						self[id].AMMO_PICKUP = {(sniper_LA_avg_pickup * 0.9) / 1.35,(sniper_LA_avg_pickup * 1.1) / 1.35}
					end
					self[id].damage_falloff = new_sniper_damage_falloff
					self[id].stats_modifiers = {damage = 1}
				end
			end
			
			self.sbl.NR_CLIPS_MAX = 3
			self.sbl.AMMO_MAX = self.sbl.CLIP_AMMO_MAX * self.sbl.NR_CLIPS_MAX
			self.sbl.stats.recoil = 15
			self.sbl.stats.spread = 17
			
			self.winchester1874.NR_CLIPS_MAX = 2
			self.winchester1874.AMMO_MAX = self.winchester1874.CLIP_AMMO_MAX * self.winchester1874.NR_CLIPS_MAX
			self.winchester1874.stats.recoil = 11
			self.winchester1874.stats.spread = 24
			self.winchester1874.fire_mode_data = {fire_rate = 60/100}
			self.winchester1874.single = {fire_rate = 60/100}
			
			self.scout.stats.spread = 19
			self.scout.fire_mode_data = {fire_rate = 60/70}
			self.scout.single = {fire_rate = 60/70}
			
		end
		init_LA()
		
		-- Bolt action
		local function init_bolt()
			
			local Sniper_Bolt = {
				msr = true,
				r700 = true,
				awp = true,
				-- single shot sniper pistol. not really a bolty, but it stays in this damage class
				contender = "secondary"
			}

			for id, status in pairs(Sniper_Bolt) do
				if self[id] then
					self[id].stats.damage = 1300
					if status == "secondary" then
						self[id].AMMO_PICKUP = {((sniper_BA_avg_pickup * 0.9) / 1.35) * secondary_mul,((sniper_BA_avg_pickup * 1.1) / 1.35) * secondary_mul}
					else
						self[id].AMMO_PICKUP = {(sniper_BA_avg_pickup * 0.9) / 1.35,(sniper_BA_avg_pickup * 1.1) / 1.35}
					end
					self[id].NR_CLIPS_MAX = 2.5
					self[id].AMMO_MAX = self[id].CLIP_AMMO_MAX * self[id].NR_CLIPS_MAX
					self[id].damage_falloff = new_sniper_damage_falloff
					self[id].stats_modifiers = {damage = 1}
				end
			end
			
			self.msr.stats.recoil = 13
			self.msr.stats.spread = 20
			self.msr.stats.concealment = 11
			self.msr.fire_mode_data = {fire_rate = 60/60}
			self.msr.single = {fire_rate = 60/60}
			
			self.r700.stats.recoil = 11
			self.r700.stats.spread = 19
			self.r700.fire_mode_data = {fire_rate = 60/70}
			self.r700.single = {fire_rate = 60/70}
			
			self.awp.stats.recoil = 16
			self.awp.stats.spread = 22
			self.awp.stats.concealment = 9
			self.awp.NR_CLIPS_MAX = 3.57
			self.awp.AMMO_MAX = self.awp.CLIP_AMMO_MAX * self.awp.NR_CLIPS_MAX
			self.awp.fire_mode_data = {fire_rate = 60/50}
			self.awp.single = {fire_rate = 60/50}
			
			self.contender.fire_mode_data = {fire_rate = 60/50}
			self.contender.single = {fire_rate = 60/50}
			self.contender.NR_CLIPS_MAX = 12
			self.contender.AMMO_MAX = self.contender.CLIP_AMMO_MAX * self.contender.NR_CLIPS_MAX
			
		end
		init_bolt()
		
		-- Heavy bolt action
		local function init_bolt_heavy()
			
			local Sniper_Bolt_heavy = {
				model70 = true,
				desertfox = true,
				r93 = true,
				mosin = true
			}

			for id, status in pairs(Sniper_Bolt_heavy) do
				if self[id] then
					self[id].stats.damage = 1600
					self[id].AMMO_PICKUP = {(sniper_BAH_avg_pickup * 0.9) / 1.35,(sniper_BAH_avg_pickup * 1.1) / 1.35}
					self[id].NR_CLIPS_MAX = 4
					self[id].AMMO_MAX = self[id].CLIP_AMMO_MAX * self[id].NR_CLIPS_MAX
					self[id].fire_mode_data = {fire_rate = 60/60}
					self[id].single = {fire_rate = 60/60}
					self[id].damage_falloff = new_sniper_damage_falloff
					self[id].stats_modifiers = {damage = 1}
				end
			end
			
			self.model70.stats.recoil = 7
			self.model70.stats.spread = 24
			
			self.desertfox.stats.recoil = 9
			self.desertfox.stats.spread = 17
			
			self.r93.stats.recoil = 7
			self.r93.stats.spread = 22
			self.r93.NR_CLIPS_MAX = 3.35
			self.r93.AMMO_MAX = self.r93.CLIP_AMMO_MAX * self.r93.NR_CLIPS_MAX
			
			self.mosin.stats.recoil = 7
			self.mosin.stats.spread = 24	
			
		end
		init_bolt_heavy()

		-- 50 cal
		self.m95.stats.damage = 6500
		self.m95.AMMO_PICKUP = {(0.3 * 0.8) / 1.35,(0.3 * 1.2) / 1.35}
		self.m95.damage_falloff = new_sniper_damage_falloff
		self.m95.stats_modifiers = {damage = 1}
		
		-- Musket. Mwahahahaha
		self.bessy.stats.damage = 12000
		self.bessy.AMMO_PICKUP = {(0.16 * 0.8) / 1.35,(0.16 * 1.2) / 1.35}
		self.bessy.damage_falloff = new_sniper_damage_falloff
		self.bessy.stats_modifiers = {damage = 1}
		
	end
	setSNIPERs()

	-- Sub machine guns --
	local function setSMGs()
		
		local avg_95_pickup = 8.1
		local avg_120_pickup = 7.1
		local avg_155_pickup = 4.8
		local avg_250_pickup = 2.63
		
		local new_smg_damage_falloff = {optimal_distance = 200,optimal_range = 700,near_falloff = 0,far_falloff = 1200,near_multiplier = 1.2,far_multiplier = 0.5}
		
		-- 1-2 headshot kill
		local function init_heavy()
			
			local SMGs_250 = {
				m45 = true,
				hajk = true,
				erma = true,
				sterling = true
			}

			for id, status in pairs(SMGs_250) do
				if self[id] then
					self[id].stats.damage = 250
					self[id].AMMO_PICKUP = {((avg_250_pickup * 0.9) / 1.35) * secondary_mul,((avg_250_pickup * 1.1) / 1.35) * secondary_mul}
					self[id].damage_falloff = new_smg_damage_falloff
				end
			end
			
			self.m45.stats.reload = 14
			self.m45.stats.recoil = 8
			self.m45.stats.spread = 21
			self.m45.CLIP_AMMO_MAX = 36
			self.m45.NR_CLIPS_MAX = 3
			self.m45.AMMO_MAX = self.m45.CLIP_AMMO_MAX * self.m45.NR_CLIPS_MAX
			
			self.hajk.stats.recoil = 14
			self.hajk.stats.spread = 12
			self.hajk.NR_CLIPS_MAX = 3
			self.hajk.AMMO_MAX = self.hajk.CLIP_AMMO_MAX * self.hajk.NR_CLIPS_MAX
			self.hajk.fire_mode_data = {fire_rate = 60/775}
			self.hajk.auto = {fire_rate = 60/775}
			
			self.erma.stats.recoil = 21
			self.erma.stats.spread = 7
			self.erma.NR_CLIPS_MAX = 3.5
			self.erma.CLIP_AMMO_MAX = 32
			self.erma.AMMO_MAX = self.erma.CLIP_AMMO_MAX * self.erma.NR_CLIPS_MAX
			self.erma.fire_mode_data = {fire_rate = 60/550}
			self.erma.auto = {fire_rate = 60/550}
			
			self.sterling.stats.spread = 16
			self.sterling.stats.recoil = 16
			self.sterling.stats.reload = 10
			self.sterling.fire_mode_data = {fire_rate = 60/550}
			self.sterling.auto = {fire_rate = 60/550}
			self.sterling.NR_CLIPS_MAX = 4
			self.sterling.CLIP_AMMO_MAX = 28
			self.sterling.AMMO_MAX = self.erma.CLIP_AMMO_MAX * self.erma.NR_CLIPS_MAX
			
			-- akimbo
			for id, status in pairs(SMGs_250) do
				if self["x_"..id] then
					self["x_"..id].stats.damage = math.ceil(250/2)
					self["x_"..id].AMMO_PICKUP[1] = self[id].AMMO_PICKUP[1] * secondary_to_primary_mul * 2
					self["x_"..id].AMMO_PICKUP[2] = self[id].AMMO_PICKUP[2] * secondary_to_primary_mul * 2
					self["x_"..id].damage_falloff = new_smg_damage_falloff
				end
			end
			
			self.x_m45.stats.recoil = 8
			self.x_m45.stats.spread = 21
			self.x_m45.CLIP_AMMO_MAX = 72
			self.x_m45.AMMO_MAX = 144
			self.x_m45.NR_CLIPS_MAX = 1.5
			self.x_m45.AMMO_MAX = self.x_m45.CLIP_AMMO_MAX * self.x_m45.NR_CLIPS_MAX
			
			self.x_hajk.stats.recoil = 14
			self.x_hajk.stats.spread = 12
			self.x_hajk.NR_CLIPS_MAX = 1.5
			self.x_hajk.AMMO_MAX = self.x_hajk.CLIP_AMMO_MAX * self.x_hajk.NR_CLIPS_MAX
			self.x_hajk.fire_mode_data = {fire_rate = 60/775}
			self.x_hajk.single = {fire_rate = 60/775}
			
			self.x_erma.stats.recoil = 21
			self.x_erma.stats.spread = 7
			self.x_erma.NR_CLIPS_MAX = 1.75
			self.x_erma.CLIP_AMMO_MAX = 64
			self.x_erma.AMMO_MAX = self.x_erma.CLIP_AMMO_MAX * self.x_erma.NR_CLIPS_MAX
			self.x_erma.fire_mode_data = {fire_rate = 60/550}
			self.x_erma.auto = {fire_rate = 60/550}
			
			self.x_sterling.stats.spread = 16
			self.x_sterling.stats.recoil = 16
			self.x_sterling.fire_mode_data = {fire_rate = 60/550}
			self.x_sterling.single = {fire_rate = 60/550}
			self.x_sterling.CLIP_AMMO_MAX = 56
			self.x_sterling.NR_CLIPS_MAX = 2
			self.x_sterling.AMMO_MAX = self.x_sterling.NR_CLIPS_MAX * self.x_sterling.CLIP_AMMO_MAX
			
		end
		
		-- 2-3 headshot kill - extra damage
		local function init_medium_heavy()
			
			local SMGs_200 = {
				olympic = true,
				schakal = true,
				sr2 = true,
				coal = true,
				uzi = true			
			}

			for id, status in pairs(SMGs_200) do
				if self[id] then
					self[id].stats.damage = 200
					self[id].AMMO_PICKUP = {((avg_155_pickup * 0.9) / 1.35) * 0.85 * secondary_mul,((avg_155_pickup * 1.1) / 1.35) * 0.85 * secondary_mul}
					self[id].damage_falloff = new_smg_damage_falloff
				end
			end
			
			self.olympic.stats.spread = 8
			self.olympic.stats.recoil = 11
			self.olympic.NR_CLIPS_MAX = 6
			self.olympic.AMMO_MAX = self.olympic.CLIP_AMMO_MAX * self.olympic.NR_CLIPS_MAX
			self.olympic.fire_mode_data = {fire_rate = 60/710}
			self.olympic.auto = {fire_rate = 60/710}
			
			self.schakal.stats.spread = 12
			self.schakal.stats.recoil = 15
			self.schakal.CLIP_AMMO_MAX = 25
			self.schakal.NR_CLIPS_MAX = 6
			self.schakal.AMMO_MAX = self.schakal.CLIP_AMMO_MAX * self.schakal.NR_CLIPS_MAX
			self.schakal.fire_mode_data = {fire_rate = 60/666}
			self.schakal.auto = {fire_rate = 60/666}
			
			self.sr2.stats.spread = 6
			self.sr2.stats.recoil = 20
			self.sr2.CLIP_AMMO_MAX = 30
			self.sr2.NR_CLIPS_MAX = 5
			self.sr2.AMMO_MAX = self.sr2.CLIP_AMMO_MAX * self.sr2.NR_CLIPS_MAX
			self.sr2.fire_mode_data = {fire_rate = 60/950}
			self.sr2.auto = {fire_rate = 60/950}
			
			self.coal.NR_CLIPS_MAX = 2
			self.coal.AMMO_MAX = self.coal.CLIP_AMMO_MAX * self.coal.NR_CLIPS_MAX
			self.coal.stats.reload = 9
			self.coal.stats.recoil = 15
			self.coal.stats.spread = 11
			self.coal.fire_mode_data = {fire_rate = 60/700}
			self.coal.auto = {fire_rate = 60/700}
			
			self.uzi.stats.spread = 21
			self.uzi.stats.recoil = 9
			self.uzi.CLIP_AMMO_MAX = 32
			self.uzi.NR_CLIPS_MAX = 4.5
			self.uzi.AMMO_MAX = self.uzi.CLIP_AMMO_MAX * self.uzi.NR_CLIPS_MAX
			self.uzi.fire_mode_data = {fire_rate = 60/625}
			self.uzi.auto = {fire_rate = 60/625}
			
			-- akimbo
			for id, status in pairs(SMGs_200) do
				if self["x_"..id] then
					self["x_"..id].stats.damage = math.ceil(200/2)
					self["x_"..id].AMMO_PICKUP[1] = self[id].AMMO_PICKUP[1] * secondary_to_primary_mul * 2
					self["x_"..id].AMMO_PICKUP[2] = self[id].AMMO_PICKUP[2] * secondary_to_primary_mul * 2
					self["x_"..id].damage_falloff = new_smg_damage_falloff
				end
			end
			
			self.x_olympic.stats.spread = 8
			self.x_olympic.stats.recoil = 11
			self.x_olympic.NR_CLIPS_MAX = 3
			self.x_olympic.AMMO_MAX = self.x_olympic.CLIP_AMMO_MAX * self.x_olympic.NR_CLIPS_MAX
			self.x_olympic.fire_mode_data = {fire_rate = 60/710}
			self.x_olympic.single = {fire_rate = 60/710}
			
			self.x_schakal.stats.spread = 12
			self.x_schakal.stats.recoil = 15
			self.x_schakal.CLIP_AMMO_MAX = 50
			self.x_schakal.NR_CLIPS_MAX = 3
			self.x_schakal.AMMO_MAX = self.x_schakal.CLIP_AMMO_MAX * self.x_schakal.NR_CLIPS_MAX
			self.x_schakal.fire_mode_data = {fire_rate = 60/666}
			self.x_schakal.single = {fire_rate = 60/666}
			
			self.x_sr2.stats.spread = 6
			self.x_sr2.stats.recoil = 20
			self.x_sr2.CLIP_AMMO_MAX = 60
			self.x_sr2.NR_CLIPS_MAX = 2.5
			self.x_sr2.AMMO_MAX = self.x_sr2.CLIP_AMMO_MAX * self.x_sr2.NR_CLIPS_MAX
			self.x_sr2.fire_mode_data = {fire_rate = 60/950}
			self.x_sr2.single = {fire_rate = 60/950}
			self.x_sr2.stats.reload = 8
			
			self.x_coal.NR_CLIPS_MAX = 1
			self.x_coal.AMMO_MAX = self.x_coal.CLIP_AMMO_MAX * self.x_coal.NR_CLIPS_MAX
			self.x_coal.stats.recoil = 15
			self.x_coal.stats.spread = 11
			self.x_coal.fire_mode_data = {fire_rate = 60/700}
			self.x_coal.single = {fire_rate = 60/700}
			
			self.x_uzi.stats.spread = 21
			self.x_uzi.stats.recoil = 9
			self.x_uzi.CLIP_AMMO_MAX = 64
			self.x_uzi.NR_CLIPS_MAX = 2.25
			self.x_uzi.AMMO_MAX = self.x_uzi.CLIP_AMMO_MAX * self.x_uzi.NR_CLIPS_MAX
			self.x_uzi.fire_mode_data = {fire_rate = 60/625}
			self.x_uzi.single = {fire_rate = 60/625}
			
		end
		
		-- 2-3 headshot kill
		local function init_medium()
			
			local SMGs_155 = {
				vityaz = true,
				new_mp5 = true,
				m1928 = true,
				shepheard = true,
				akmsu = true,
				tec9 = true
			}

			for id, status in pairs(SMGs_155) do
				if self[id] then
					self[id].stats.damage = 155
					self[id].AMMO_PICKUP = {((avg_155_pickup * 0.9) / 1.35) * secondary_mul,((avg_155_pickup * 1.1) / 1.35) * secondary_mul}
					self[id].damage_falloff = new_smg_damage_falloff
				end
			end
			
			self.vityaz.stats.spread = 20
			self.vityaz.stats.recoil = 10
			self.vityaz.NR_CLIPS_MAX = 5
			self.vityaz.AMMO_MAX = self.vityaz.CLIP_AMMO_MAX * self.vityaz.NR_CLIPS_MAX
			self.vityaz.fire_mode_data = {fire_rate = 60/710}
			self.vityaz.auto = {fire_rate = 60/710}
			
			self.new_mp5.stats.recoil = 18
			self.new_mp5.stats.reload = 13
			self.new_mp5.stats.spread = 11
			self.new_mp5.NR_CLIPS_MAX = 5
			self.new_mp5.AMMO_MAX = self.new_mp5.CLIP_AMMO_MAX * self.new_mp5.NR_CLIPS_MAX
			self.new_mp5.fire_mode_data = {fire_rate = 60/800}
			self.new_mp5.auto = {fire_rate = 60/800}
			
			self.m1928.stats.spread = 7
			self.m1928.stats.recoil = 23
			self.m1928.NR_CLIPS_MAX = 3
			self.m1928.AMMO_MAX = self.m1928.CLIP_AMMO_MAX * self.m1928.NR_CLIPS_MAX
			
			self.shepheard.stats.reload = 14
			self.shepheard.stats.recoil = 15
			self.shepheard.stats.spread = 14
			self.shepheard.NR_CLIPS_MAX = 7.5
			self.shepheard.AMMO_MAX = self.shepheard.CLIP_AMMO_MAX * self.shepheard.NR_CLIPS_MAX
			self.shepheard.fire_mode_data = {fire_rate = 60/850}
			self.shepheard.auto = {fire_rate = 60/850}
			
			self.akmsu.stats.recoil = 7
			self.akmsu.stats.spread = 15
			self.akmsu.NR_CLIPS_MAX = 5
			self.akmsu.AMMO_MAX = self.akmsu.CLIP_AMMO_MAX * self.akmsu.NR_CLIPS_MAX
			self.akmsu.fire_mode_data = {fire_rate = 60/700}
			self.akmsu.auto = {fire_rate = 60/700}
			
			self.tec9.stats.recoil = 17
			self.tec9.stats.spread = 12
			self.tec9.stats.reload = 14
			self.tec9.NR_CLIPS_MAX = 7.5
			self.tec9.AMMO_MAX = self.tec9.CLIP_AMMO_MAX * self.tec9.NR_CLIPS_MAX
			
			-- akimbo
			for id, status in pairs(SMGs_155) do
				if self["x_"..id] then
					self["x_"..id].stats.damage = math.ceil(155/2)
					self["x_"..id].AMMO_PICKUP[1] = self[id].AMMO_PICKUP[1] * secondary_to_primary_mul * 2
					self["x_"..id].AMMO_PICKUP[2] = self[id].AMMO_PICKUP[2] * secondary_to_primary_mul * 2
					self["x_"..id].damage_falloff = new_smg_damage_falloff
				end
			end
			
			self.x_vityaz.stats.spread = 20
			self.x_vityaz.stats.recoil = 10
			self.x_vityaz.NR_CLIPS_MAX = 2.5
			self.x_vityaz.AMMO_MAX = self.x_vityaz.CLIP_AMMO_MAX * self.x_vityaz.NR_CLIPS_MAX
			self.x_vityaz.fire_mode_data = {fire_rate = 60/710}
			self.x_vityaz.single = {fire_rate = 60/710}
			
			self.x_mp5.stats.damage = math.ceil(155/2)
			self.x_mp5.AMMO_PICKUP[1] = self.new_mp5.AMMO_PICKUP[1] * secondary_to_primary_mul * 2
			self.x_mp5.AMMO_PICKUP[2] = self.new_mp5.AMMO_PICKUP[2] * secondary_to_primary_mul * 2
			self.x_mp5.damage_falloff = new_smg_damage_falloff
			self.x_mp5.stats.recoil = 18
			self.x_mp5.stats.spread = 11
			self.x_mp5.NR_CLIPS_MAX = 2.5
			self.x_mp5.AMMO_MAX = self.x_mp5.CLIP_AMMO_MAX * self.x_mp5.NR_CLIPS_MAX
			self.x_mp5.fire_mode_data = {fire_rate = 60/800}
			self.x_mp5.single = {fire_rate = 60/800}
			
			self.x_m1928.stats.spread = 7
			self.x_m1928.stats.recoil = 23
			self.x_m1928.NR_CLIPS_MAX = 1.5
			self.x_m1928.AMMO_MAX = self.x_m1928.CLIP_AMMO_MAX * self.x_m1928.NR_CLIPS_MAX
			
			self.x_shepheard.stats.recoil = 15
			self.x_shepheard.stats.spread = 14
			self.x_shepheard.NR_CLIPS_MAX = 3.75
			self.x_shepheard.AMMO_MAX = self.x_shepheard.CLIP_AMMO_MAX * self.x_shepheard.NR_CLIPS_MAX
			self.x_shepheard.fire_mode_data = {fire_rate = 60/850}
			self.x_shepheard.single = {fire_rate = 60/850}
			
			self.x_akmsu.stats.recoil = 12
			self.x_akmsu.stats.spread = 18
			self.x_akmsu.NR_CLIPS_MAX = 2.5
			self.x_akmsu.AMMO_MAX = self.x_akmsu.CLIP_AMMO_MAX * self.x_akmsu.NR_CLIPS_MAX
			self.x_akmsu.fire_mode_data = {fire_rate = 60/700}
			self.x_akmsu.single = {fire_rate = 60/700}
			
			self.x_tec9.stats.recoil = 17
			self.x_tec9.stats.spread = 12
			self.x_tec9.NR_CLIPS_MAX = 3.75
			self.x_tec9.AMMO_MAX = self.x_tec9.CLIP_AMMO_MAX * self.x_tec9.NR_CLIPS_MAX
			
		end
		
		-- 3-4 headshot kill
		local function init_light()
			
			local SMGs_120 = {
				mp7 = true,
				cobray = true,
				pm9 = true,
				mp9 = true,
				p90 = true
			}
			for id, status in pairs(SMGs_120) do
				if self[id] then
					self[id].stats.damage = 120
					self[id].AMMO_PICKUP = {((avg_120_pickup * 0.9) / 1.35) * secondary_mul,((avg_120_pickup * 1.1) / 1.35) * secondary_mul}
					self[id].damage_falloff = new_smg_damage_falloff
				end
			end
			
			self.mp7.stats.spread = 12
			self.mp7.stats.reload = 14
			self.mp7.AMMO_MAX = 180
			self.mp7.NR_CLIPS_MAX = self.mp7.AMMO_MAX / self.mp7.CLIP_AMMO_MAX
			self.mp7.fire_mode_data = {fire_rate = 60/950}
			self.mp7.auto = {fire_rate = 60/950}
			
			self.cobray.stats.spread = 11
			self.cobray.stats.recoil = 18
			self.cobray.AMMO_MAX = 184
			self.cobray.NR_CLIPS_MAX = self.cobray.AMMO_MAX / self.cobray.CLIP_AMMO_MAX
			
			self.pm9.stats.recoil = 21
			self.pm9.AMMO_MAX = 175
			self.pm9.NR_CLIPS_MAX = self.pm9.AMMO_MAX / self.pm9.CLIP_AMMO_MAX
			self.pm9.stats.reload = 14
			
			self.mp9.stats.spread = 7
			self.mp9.stats.recoil = 21
			self.mp9.AMMO_MAX = 180
			self.mp9.NR_CLIPS_MAX = self.mp9.AMMO_MAX / self.mp9.CLIP_AMMO_MAX
			self.mp9.fire_mode_data = {fire_rate = 60/1000}
			self.mp9.auto = {fire_rate = 60/1000}
			
			self.p90.stats.spread = 16
			self.p90.stats.recoil = 14
			self.p90.AMMO_MAX = 175
			self.p90.NR_CLIPS_MAX = self.p90.AMMO_MAX / self.p90.CLIP_AMMO_MAX
			self.p90.fire_mode_data = {fire_rate = 60/900}
			self.p90.auto = {fire_rate = 60/900}
			
			-- akimbo
			for id, status in pairs(SMGs_120) do
				if self["x_"..id] then
					self["x_"..id].stats.damage = math.ceil(120/2)
					self["x_"..id].AMMO_PICKUP[1] = self[id].AMMO_PICKUP[1] * secondary_to_primary_mul * 2
					self["x_"..id].AMMO_PICKUP[2] = self[id].AMMO_PICKUP[2] * secondary_to_primary_mul * 2
					self["x_"..id].damage_falloff = new_smg_damage_falloff
				end
			end
			
			self.x_mp7.stats.spread = 12
			self.x_mp7.stats.reload = 14
			self.x_mp7.AMMO_MAX = 180
			self.x_mp7.NR_CLIPS_MAX = self.x_mp7.AMMO_MAX / self.x_mp7.CLIP_AMMO_MAX
			self.x_mp7.fire_mode_data = {fire_rate = 60/950}
			self.x_mp7.single = {fire_rate = 60/950}
			
			self.x_cobray.AMMO_MAX = 184
			self.x_cobray.NR_CLIPS_MAX = self.x_cobray.AMMO_MAX / self.x_cobray.CLIP_AMMO_MAX
			self.x_cobray.stats.spread = 11
			self.x_cobray.stats.recoil = 18
			
			self.x_pm9.stats.recoil = 21
			self.x_pm9.AMMO_MAX = 175
			self.x_pm9.NR_CLIPS_MAX = self.x_pm9.AMMO_MAX / self.x_pm9.CLIP_AMMO_MAX
			self.x_pm9.stats.reload = 14
			
			self.x_mp9.stats.spread = 7
			self.x_mp9.stats.recoil = 23
			self.x_mp9.AMMO_MAX = 180
			self.x_mp9.NR_CLIPS_MAX = self.x_mp9.AMMO_MAX / self.x_mp9.CLIP_AMMO_MAX
			self.x_mp9.fire_mode_data = {fire_rate = 60/1000}
			self.x_mp9.single = {fire_rate = 60/1000}
			
			self.x_p90.stats.spread = 16
			self.x_p90.stats.recoil = 14
			self.x_p90.AMMO_MAX = 175
			self.x_p90.NR_CLIPS_MAX = self.x_p90.AMMO_MAX / self.x_p90.CLIP_AMMO_MAX
			self.x_p90.fire_mode_data = {fire_rate = 60/900}
			self.x_p90.single = {fire_rate = 60/900}
			
		end
		
		-- 3-5 headshot kill
		local function init_super_light()
			
			local SMGs_95 = {
				mac10 = true,
				fmg9 = true,
				scorpion = true,
				baka = true,
				polymer = true
			}
			for id, status in pairs(SMGs_95) do
				if self[id] then
					self[id].stats.damage = 95
					self[id].AMMO_PICKUP = {((avg_95_pickup * 0.9) / 1.35) * secondary_mul,((avg_95_pickup * 1.1) / 1.35) * secondary_mul}
					self[id].damage_falloff = new_smg_damage_falloff
				end
			end
			
			self.mac10.stats.spread = 13
			self.mac10.stats.recoil = 18
			self.mac10.AMMO_MAX = 200
			self.mac10.NR_CLIPS_MAX = self.mac10.AMMO_MAX / self.mac10.CLIP_AMMO_MAX
			
			self.fmg9.stats.spread = 4
			self.fmg9.stats.recoil = 21
			self.fmg9.AMMO_MAX = 210
			self.fmg9.NR_CLIPS_MAX = self.fmg9.AMMO_MAX / self.fmg9.CLIP_AMMO_MAX
			
			self.scorpion.stats.spread = 12
			self.scorpion.stats.recoil = 19
			self.scorpion.AMMO_MAX = 200
			self.scorpion.NR_CLIPS_MAX = self.scorpion.AMMO_MAX / self.scorpion.CLIP_AMMO_MAX
			
			self.baka.stats.spread = 10
			self.baka.stats.recoil = 18
			self.baka.AMMO_MAX = 208
			self.baka.NR_CLIPS_MAX = self.baka.AMMO_MAX / self.baka.CLIP_AMMO_MAX
			
			self.polymer.stats.spread = 7
			self.polymer.stats.recoil = 23
			self.polymer.AMMO_MAX = 180
			self.polymer.NR_CLIPS_MAX = self.polymer.AMMO_MAX / self.polymer.CLIP_AMMO_MAX
			
			-- akimbo
			for id, status in pairs(SMGs_95) do
				if self["x_"..id] then
					self["x_"..id].stats.damage = math.ceil(95/2)
					self["x_"..id].AMMO_PICKUP[1] = self[id].AMMO_PICKUP[1] * secondary_to_primary_mul * 2
					self["x_"..id].AMMO_PICKUP[2] = self[id].AMMO_PICKUP[2] * secondary_to_primary_mul * 2
					self["x_"..id].damage_falloff = new_smg_damage_falloff
				end
			end
			
			self.x_mac10.stats.spread = 13
			self.x_mac10.stats.recoil = 18
			self.x_mac10.AMMO_MAX = 200
			self.x_mac10.NR_CLIPS_MAX = self.x_mac10.AMMO_MAX / self.x_mac10.CLIP_AMMO_MAX
			
			self.x_scorpion.stats.spread = 12
			self.x_scorpion.stats.recoil = 19
			self.x_scorpion.AMMO_MAX = 200
			self.x_scorpion.NR_CLIPS_MAX = self.x_scorpion.AMMO_MAX / self.x_scorpion.CLIP_AMMO_MAX
			
			self.x_baka.stats.spread = 10
			self.x_baka.stats.recoil = 18
			self.x_baka.AMMO_MAX = 208
			self.x_baka.NR_CLIPS_MAX = self.x_baka.AMMO_MAX / self.x_baka.CLIP_AMMO_MAX
			
			self.x_polymer.stats.spread = 7
			self.x_polymer.stats.recoil = 23
			self.x_polymer.AMMO_MAX = 180
			self.x_polymer.NR_CLIPS_MAX = self.x_polymer.AMMO_MAX / self.x_polymer.CLIP_AMMO_MAX	
			
		end
		
		init_heavy()
		init_medium_heavy()
		init_medium()
		init_light()
		init_super_light()
	end
	setSMGs()
	
	-- Pistols --
	local function setPISTOLs()
	
		local avg_88_pickup = 6.8
		local avg_95_pickup = 6.48
		local avg_120_pickup = 5.67
		local avg_155_pickup = 3.59
		local avg_250_pickup = 2.16
		local avg_450_pickup = 1.44
		
		local new_pistol_damage_falloff = {optimal_distance = 10,optimal_range = 10,near_falloff = 0,far_falloff = 0,near_multiplier = 1,far_multiplier = 1}

		---- 88 pistols ----
		local function Gilza_init_FA_very_low_pistols()
			
			-- 3-6 headshot kill
			local low_FA_pistols = {
				beer = {fmd = "auto",akimbo = true}
			}
			
			local new_fire_rate_multiplier = 1.2
			local new_damage = 88
			
			for gun, tbl in pairs(low_FA_pistols) do
				if tbl.fmd == "auto" then
					new_fire_rate_multiplier = 0.8
				else
					new_fire_rate_multiplier = 1.2
				end
				local function apply_stats(id, is_akimbo)
					if self[id] then
						if self[id].fire_mode_data then
							self[id].fire_mode_data.fire_rate = self[id].fire_mode_data.fire_rate * new_fire_rate_multiplier
						end
						if self[id].single then
							self[id].single.fire_rate = self[id].single.fire_rate * new_fire_rate_multiplier
						end
						if self[id].auto then
							self[id].auto.fire_rate = self[id].auto.fire_rate * new_fire_rate_multiplier
						end
						self[id].damage_falloff = new_pistol_damage_falloff
						if is_akimbo then
							self[id].stats.damage = math.ceil(new_damage/2)
							self[id].AMMO_PICKUP = {((avg_88_pickup * 0.9) / 1.35) * 2,((avg_88_pickup * 1.1) / 1.35) * 2}
						else
							self[id].stats.damage = new_damage
							self[id].AMMO_PICKUP = {((avg_88_pickup * 0.9) / 1.35) * secondary_mul,((avg_88_pickup * 1.1) / 1.35) * secondary_mul}
						end
					end
				end
				
				apply_stats(gun)
				
				if tbl.akimbo then
					local akimbo_string
					if type(tbl.akimbo) == "string" then
						akimbo_string = tbl.akimbo
					else
						akimbo_string = "x_"..gun
					end
					apply_stats(akimbo_string, true)
				end
				
			end
			
			self.beer.stats.spread = 13
			self.beer.stats.recoil = 17
			self.beer.CLIP_AMMO_MAX = 20
			self.beer.NR_CLIPS_MAX = 8
			self.beer.AMMO_MAX = self.beer.NR_CLIPS_MAX * self.beer.CLIP_AMMO_MAX
			self.x_beer.stats.spread = 13
			self.x_beer.stats.recoil = 17
			self.x_beer.CLIP_AMMO_MAX = 40
			self.x_beer.NR_CLIPS_MAX = 4
			self.x_beer.AMMO_MAX = self.x_beer.NR_CLIPS_MAX * self.x_beer.CLIP_AMMO_MAX
			
		end
		Gilza_init_FA_very_low_pistols()
		
		---- 95 pistols ----
		local function Gilza_init_FA_low_pistols()
			
			-- 3-5 headshot kill
			local low_pistols = {
				glock_18c = {fmd = "auto",akimbo = "x_g18c"},
				czech = {fmd = "auto",akimbo = true}
			}
			
			local new_fire_rate_multiplier = 1.2
			local new_damage = 95
			
			for gun, tbl in pairs(low_pistols) do
				if tbl.fmd == "auto" then
					new_fire_rate_multiplier = 0.8
				else
					new_fire_rate_multiplier = 1.2
				end
				local function apply_stats(id, is_akimbo)
					if self[id] then
						if self[id].fire_mode_data then
							self[id].fire_mode_data.fire_rate = self[id].fire_mode_data.fire_rate * new_fire_rate_multiplier
						end
						if self[id].single then
							self[id].single.fire_rate = self[id].single.fire_rate * new_fire_rate_multiplier
						end
						if self[id].auto then
							self[id].auto.fire_rate = self[id].auto.fire_rate * new_fire_rate_multiplier
						end
						self[id].damage_falloff = new_pistol_damage_falloff
						if is_akimbo then
							self[id].stats.damage = math.ceil(new_damage/2)
							self[id].AMMO_PICKUP = {((avg_95_pickup * 0.9) / 1.35) * 2,((avg_95_pickup * 1.1) / 1.35) * 2}
						else
							self[id].stats.damage = new_damage
							self[id].AMMO_PICKUP = {((avg_95_pickup * 0.9) / 1.35) * secondary_mul,((avg_95_pickup * 1.1) / 1.35) * secondary_mul}
						end
					end
				end
				
				apply_stats(gun)
				
				if tbl.akimbo then
					local akimbo_string
					if type(tbl.akimbo) == "string" then
						akimbo_string = tbl.akimbo
					else
						akimbo_string = "x_"..gun
					end
					apply_stats(akimbo_string, true)
				end
				
			end
			
			self.czech.stats.spread = 13
			self.czech.stats.recoil = 15
			self.czech.CLIP_AMMO_MAX = 16
			self.czech.NR_CLIPS_MAX = 9
			self.czech.AMMO_MAX = self.czech.NR_CLIPS_MAX * self.czech.CLIP_AMMO_MAX
			self.x_czech.stats.spread = 13
			self.x_czech.stats.recoil = 15
			self.x_czech.CLIP_AMMO_MAX = 32
			self.x_czech.NR_CLIPS_MAX = 4.5
			self.x_czech.AMMO_MAX = self.x_czech.NR_CLIPS_MAX * self.x_czech.CLIP_AMMO_MAX
			
			self.glock_18c.stats.spread = 13
			self.glock_18c.stats.recoil = 13
			self.glock_18c.NR_CLIPS_MAX = 7
			self.glock_18c.AMMO_MAX = self.glock_18c.NR_CLIPS_MAX * self.glock_18c.CLIP_AMMO_MAX
			self.x_g18c.stats.spread = 13
			self.x_g18c.stats.recoil = 13
			self.x_g18c.NR_CLIPS_MAX = 3.5
			self.x_g18c.AMMO_MAX = self.x_g18c.NR_CLIPS_MAX * self.x_g18c.CLIP_AMMO_MAX
			
		end
		Gilza_init_FA_low_pistols()
		
		---- 120 pistols ----
		local function Gilza_init_mid_pistols()
			
			-- 2-4 headshot kill
			local mid_pistols = {
				glock_17 = {fmd = "single",akimbo = "x_g17"},
				ppk = {fmd = "single",akimbo = true},
				b92fs = {fmd = "single",akimbo = true},
				legacy = {fmd = "single",akimbo = true},
				g26 = {fmd = "single",akimbo = "jowi"},
				shrew = {fmd = "single",akimbo = true},
				stech = {fmd = "auto",akimbo = true}
			}
			
			local new_fire_rate_multiplier = 1.2
			local new_damage = 120
			
			for gun, tbl in pairs(mid_pistols) do
				if tbl.fmd == "auto" then
					new_fire_rate_multiplier = 0.8
				else
					new_fire_rate_multiplier = 1.2
				end
				local function apply_stats(id, is_akimbo)
					if self[id] then
						if self[id].fire_mode_data then
							self[id].fire_mode_data.fire_rate = self[id].fire_mode_data.fire_rate * new_fire_rate_multiplier
						end
						if self[id].single then
							self[id].single.fire_rate = self[id].single.fire_rate * new_fire_rate_multiplier
						end
						if self[id].auto then
							self[id].auto.fire_rate = self[id].auto.fire_rate * new_fire_rate_multiplier
						end
						self[id].damage_falloff = new_pistol_damage_falloff
						if is_akimbo then
							self[id].stats.damage = math.ceil(new_damage/2)
							self[id].AMMO_PICKUP = {((avg_120_pickup * 0.9) / 1.35) * 2,((avg_120_pickup * 1.1) / 1.35) * 2}
						else
							self[id].stats.damage = new_damage
							self[id].AMMO_PICKUP = {((avg_120_pickup * 0.9) / 1.35) * secondary_mul,((avg_120_pickup * 1.1) / 1.35) * secondary_mul}
						end
					end
				end
				
				apply_stats(gun)
				
				if tbl.akimbo then
					local akimbo_string
					if type(tbl.akimbo) == "string" then
						akimbo_string = tbl.akimbo
					else
						akimbo_string = "x_"..gun
					end
					apply_stats(akimbo_string, true)
				end
				
			end
			
			self.glock_17.stats.spread = 9
			self.glock_17.stats.recoil = 22
			self.glock_17.NR_CLIPS_MAX = 6
			self.glock_17.AMMO_MAX = self.glock_17.NR_CLIPS_MAX * self.glock_17.CLIP_AMMO_MAX
			self.x_g17.fire_mode_data.fire_rate = 60/455
			self.x_g17.single.fire_rate = 60/455
			self.x_g17.stats.spread = 9
			self.x_g17.stats.recoil = 22
			self.x_g17.NR_CLIPS_MAX = 3
			self.x_g17.AMMO_MAX = self.x_g17.NR_CLIPS_MAX * self.x_g17.CLIP_AMMO_MAX
			
			self.ppk.stats.recoil = 20
			self.ppk.NR_CLIPS_MAX = 8
			self.ppk.AMMO_MAX = self.ppk.NR_CLIPS_MAX * self.ppk.CLIP_AMMO_MAX
			self.x_ppk.fire_mode_data.fire_rate = 60/455
			self.x_ppk.single.fire_rate = 60/455
			self.x_ppk.stats.recoil = 20
			self.x_ppk.NR_CLIPS_MAX = 4
			self.x_ppk.AMMO_MAX = self.x_ppk.NR_CLIPS_MAX * self.x_ppk.CLIP_AMMO_MAX
			
			self.b92fs.stats.spread = 22
			self.b92fs.stats.recoil = 11
			self.b92fs.NR_CLIPS_MAX = 5
			self.b92fs.AMMO_MAX = self.b92fs.NR_CLIPS_MAX * self.b92fs.CLIP_AMMO_MAX
			self.x_b92fs.fire_mode_data.fire_rate = 60/455
			self.x_b92fs.single.fire_rate = 60/455
			self.x_b92fs.stats.spread = 22
			self.x_b92fs.stats.recoil = 11
			self.x_b92fs.stats.concealment = 30
			self.x_b92fs.NR_CLIPS_MAX = 2.5
			self.x_b92fs.AMMO_MAX = self.x_b92fs.NR_CLIPS_MAX * self.x_b92fs.CLIP_AMMO_MAX
			
			self.legacy.stats.spread = 10
			self.legacy.stats.recoil = 22
			self.legacy.NR_CLIPS_MAX = 7
			self.legacy.AMMO_MAX = self.legacy.NR_CLIPS_MAX * self.legacy.CLIP_AMMO_MAX
			self.x_legacy.stats.spread = 10
			self.x_legacy.stats.recoil = 22
			self.x_legacy.NR_CLIPS_MAX = 3.5
			self.x_legacy.AMMO_MAX = self.x_legacy.NR_CLIPS_MAX * self.x_legacy.CLIP_AMMO_MAX
			
			self.g26.stats.spread = 9
			self.g26.stats.recoil = 20
			self.g26.NR_CLIPS_MAX = 11
			self.g26.AMMO_MAX = self.g26.NR_CLIPS_MAX * self.g26.CLIP_AMMO_MAX
			self.jowi.fire_mode_data.fire_rate = 60/455
			self.jowi.single.fire_rate = 60/455
			self.jowi.stats.spread = 9
			self.jowi.stats.recoil = 20
			self.jowi.NR_CLIPS_MAX = 5.5
			self.jowi.AMMO_MAX = self.jowi.NR_CLIPS_MAX * self.jowi.CLIP_AMMO_MAX
			
			self.shrew.stats.spread = 22
			self.shrew.stats.recoil = 9
			self.shrew.NR_CLIPS_MAX = 6
			self.shrew.AMMO_MAX = self.shrew.NR_CLIPS_MAX * self.shrew.CLIP_AMMO_MAX
			self.x_shrew.fire_mode_data.fire_rate = 60/455
			self.x_shrew.single.fire_rate = 60/455
			self.x_shrew.stats.spread = 22
			self.x_shrew.stats.recoil = 9
			self.x_shrew.NR_CLIPS_MAX = 3
			self.x_shrew.AMMO_MAX = self.x_shrew.NR_CLIPS_MAX * self.x_shrew.CLIP_AMMO_MAX
			
			self.stech.stats.spread = 13
			self.stech.stats.recoil = 12
			self.stech.NR_CLIPS_MAX = 6
			self.stech.AMMO_MAX = self.stech.NR_CLIPS_MAX * self.stech.CLIP_AMMO_MAX
			self.x_stech.stats.spread = 13
			self.x_stech.stats.recoil = 12
			self.x_stech.NR_CLIPS_MAX = 3
			self.x_stech.AMMO_MAX = self.x_stech.NR_CLIPS_MAX * self.x_stech.CLIP_AMMO_MAX
			
		end
		Gilza_init_mid_pistols()
		
		---- 155 pistols ----
		local function Gilza_init_upper_mid_pistols()
			
			-- 2-3 headshot kill
			local upper_mid_pistols = {
				usp = {fmd = "single",akimbo = true},
				p226 = {fmd = "single",akimbo = true},
				colt_1911 = {fmd = "single",akimbo = "x_1911"},
				maxim9 = {fmd = "single",akimbo = true},
				g22c = {fmd = "single",akimbo = true},
				c96 = {fmd = "single",akimbo = true},
				type54 = {fmd = "single",akimbo = true},
				packrat = {fmd = "single",akimbo = true},
				lemming = {fmd = "single",akimbo = false},
				hs2000 = {fmd = "single",akimbo = true},
				holt = {fmd = "single",akimbo = true}
			}
			
			local new_fire_rate_multiplier = 1.2
			local new_damage = 155
			
			for gun, tbl in pairs(upper_mid_pistols) do
				if tbl.fmd == "auto" then
					new_fire_rate_multiplier = 0.8
				else
					new_fire_rate_multiplier = 1.2
				end
				local function apply_stats(id, is_akimbo)
					if self[id] then
						if self[id].fire_mode_data then
							self[id].fire_mode_data.fire_rate = self[id].fire_mode_data.fire_rate * new_fire_rate_multiplier
						end
						if self[id].single then
							self[id].single.fire_rate = self[id].single.fire_rate * new_fire_rate_multiplier
						end
						if self[id].auto then
							self[id].auto.fire_rate = self[id].auto.fire_rate * new_fire_rate_multiplier
						end
						self[id].damage_falloff = new_pistol_damage_falloff
						if is_akimbo then
							self[id].stats.damage = math.ceil(new_damage/2)
							self[id].AMMO_PICKUP = {((avg_155_pickup * 0.9) / 1.35) * 2,((avg_155_pickup * 1.1) / 1.35) * 2}
						else
							self[id].stats.damage = new_damage
							self[id].AMMO_PICKUP = {((avg_155_pickup * 0.9) / 1.35) * secondary_mul,((avg_155_pickup * 1.1) / 1.35) * secondary_mul}
						end
					end
				end
				
				apply_stats(gun)
				
				if tbl.akimbo then
					local akimbo_string
					if type(tbl.akimbo) == "string" then
						akimbo_string = tbl.akimbo
					else
						akimbo_string = "x_"..gun
					end
					apply_stats(akimbo_string, true)
				end
				
			end
			
			self.usp.stats.spread = 21
			self.usp.stats.recoil = 15
			self.usp.CLIP_AMMO_MAX = 12
			self.usp.NR_CLIPS_MAX = 5.5
			self.usp.AMMO_MAX = self.usp.NR_CLIPS_MAX * self.usp.CLIP_AMMO_MAX
			self.x_usp.fire_mode_data.fire_rate = 60/400
			self.x_usp.single.fire_rate = 60/400
			self.x_usp.stats.spread = 21
			self.x_usp.stats.recoil = 15
			self.x_usp.CLIP_AMMO_MAX = 24
			self.x_usp.NR_CLIPS_MAX = 2.75
			self.x_usp.AMMO_MAX = self.x_usp.NR_CLIPS_MAX * self.x_usp.CLIP_AMMO_MAX
			
			self.p226.stats.spread = 13
			self.p226.stats.recoil = 21
			self.p226.NR_CLIPS_MAX = 6
			self.p226.AMMO_MAX = self.p226.NR_CLIPS_MAX * self.p226.CLIP_AMMO_MAX
			self.x_p226.fire_mode_data.fire_rate = 60/400
			self.x_p226.single.fire_rate = 60/400
			self.x_p226.stats.spread = 13
			self.x_p226.stats.recoil = 21
			self.x_p226.NR_CLIPS_MAX = 3
			self.x_p226.AMMO_MAX = self.x_p226.NR_CLIPS_MAX * self.x_p226.CLIP_AMMO_MAX
			
			self.colt_1911.stats.spread = 19
			self.colt_1911.stats.recoil = 19
			self.colt_1911.CLIP_AMMO_MAX = 8
			self.colt_1911.NR_CLIPS_MAX = 7
			self.colt_1911.AMMO_MAX = self.colt_1911.NR_CLIPS_MAX * self.colt_1911.CLIP_AMMO_MAX
			self.x_1911.fire_mode_data.fire_rate = 60/400
			self.x_1911.single.fire_rate = 60/400
			self.x_1911.stats.spread = 19
			self.x_1911.stats.recoil = 19
			self.x_1911.stats.concealment = 29
			self.x_1911.CLIP_AMMO_MAX = 16
			self.x_1911.NR_CLIPS_MAX = 3.5
			self.x_1911.AMMO_MAX = self.x_1911.NR_CLIPS_MAX * self.x_1911.CLIP_AMMO_MAX
			
			self.maxim9.stats.spread = 20
			self.maxim9.stats.recoil = 12
			self.maxim9.CLIP_AMMO_MAX = 15
			self.maxim9.NR_CLIPS_MAX = 5
			self.maxim9.AMMO_MAX = self.maxim9.NR_CLIPS_MAX * self.maxim9.CLIP_AMMO_MAX
			self.x_maxim9.fire_mode_data.fire_rate = 60/400
			self.x_maxim9.single.fire_rate = 60/400
			self.x_maxim9.stats.spread = 20
			self.x_maxim9.stats.recoil = 12
			self.x_maxim9.CLIP_AMMO_MAX = 30
			self.x_maxim9.NR_CLIPS_MAX = 2.5
			self.x_maxim9.AMMO_MAX = self.x_maxim9.NR_CLIPS_MAX * self.x_maxim9.CLIP_AMMO_MAX
			
			self.g22c.stats.spread = 18
			self.g22c.stats.recoil = 17
			self.g22c.NR_CLIPS_MAX = 4
			self.g22c.AMMO_MAX = self.g22c.NR_CLIPS_MAX * self.g22c.CLIP_AMMO_MAX
			self.x_g22c.fire_mode_data.fire_rate = 60/400
			self.x_g22c.single.fire_rate = 60/400
			self.x_g22c.stats.spread = 18
			self.x_g22c.stats.recoil = 17
			self.x_g22c.NR_CLIPS_MAX = 2
			self.x_g22c.AMMO_MAX = self.x_g22c.NR_CLIPS_MAX * self.x_g22c.CLIP_AMMO_MAX
			
			self.c96.stats.recoil = 15
			self.c96.stats.reload = 16
			self.c96.CLIP_AMMO_MAX = 10
			self.c96.NR_CLIPS_MAX = 6
			self.c96.AMMO_MAX = self.c96.NR_CLIPS_MAX * self.c96.CLIP_AMMO_MAX
			self.x_c96.stats.recoil = 15
			self.x_c96.fire_mode_data.fire_rate = 60/400
			self.x_c96.single.fire_rate = 60/400
			self.x_c96.CLIP_AMMO_MAX = 20
			self.x_c96.NR_CLIPS_MAX = 3
			self.x_c96.AMMO_MAX = self.x_c96.NR_CLIPS_MAX * self.x_c96.CLIP_AMMO_MAX
			
			self.type54_underbarrel.rays = 10
			self.type54_underbarrel.stats.damage = 66
			self.type54_underbarrel.stats.spread = 10
			self.type54_underbarrel.AMMO_PICKUP = {0.25,0.3}
			Gilza.shotgun_minimal_damage_multipliers.type54_underbarrel = 1
			self.x_type54_underbarrel.rays = 10
			self.x_type54_underbarrel.stats.damage = 33
			self.x_type54_underbarrel.stats.spread = 10
			self.x_type54_underbarrel.AMMO_PICKUP = {0.5,0.6}
			Gilza.shotgun_minimal_damage_multipliers.x_type54_underbarrel = 1
			
			self.type54.NR_CLIPS_MAX = 5
			self.type54.AMMO_MAX = self.type54.NR_CLIPS_MAX * self.type54.CLIP_AMMO_MAX
			self.x_type54.fire_mode_data.fire_rate = 60/400
			self.x_type54.single.fire_rate = 60/400
			self.x_type54.NR_CLIPS_MAX = 2.5
			self.x_type54.AMMO_MAX = self.x_type54.NR_CLIPS_MAX * self.x_type54.CLIP_AMMO_MAX
			
			self.packrat.stats.spread = 20
			self.packrat.stats.recoil = 11
			self.packrat.NR_CLIPS_MAX = 4
			self.packrat.AMMO_MAX = self.packrat.NR_CLIPS_MAX * self.packrat.CLIP_AMMO_MAX
			self.x_packrat.fire_mode_data.fire_rate = 60/400
			self.x_packrat.single.fire_rate = 60/400
			self.x_packrat.stats.spread = 20
			self.x_packrat.stats.recoil = 11
			self.x_packrat.NR_CLIPS_MAX = 2
			self.x_packrat.AMMO_MAX = self.x_packrat.NR_CLIPS_MAX * self.x_packrat.CLIP_AMMO_MAX
			
			self.lemming.stats.spread = 16
			self.lemming.stats.recoil = 14
			self.lemming.CLIP_AMMO_MAX = 20
			self.lemming.NR_CLIPS_MAX = 2.5
			self.lemming.AMMO_MAX = self.lemming.NR_CLIPS_MAX * self.lemming.CLIP_AMMO_MAX
			self.lemming.AMMO_PICKUP = {((avg_155_pickup * 0.9) / 1.35) * 0.5 * secondary_mul,((avg_155_pickup * 1.1) / 1.35) * 0.5 * secondary_mul}
			self.lemming.fire_mode_data.fire_rate = 60/400 -- why does it even have such high base rof?
			self.lemming.single.fire_rate = 60/400
			
			self.hs2000.stats.spread = 16
			self.hs2000.stats.recoil = 13
			self.hs2000.CLIP_AMMO_MAX = 13
			self.hs2000.NR_CLIPS_MAX = 6
			self.hs2000.AMMO_MAX = self.hs2000.NR_CLIPS_MAX * self.hs2000.CLIP_AMMO_MAX
			self.x_hs2000.fire_mode_data.fire_rate = 60/400
			self.x_hs2000.single.fire_rate = 60/400
			self.x_hs2000.stats.spread = 16
			self.x_hs2000.stats.recoil = 13
			self.x_hs2000.CLIP_AMMO_MAX = 26
			self.x_hs2000.NR_CLIPS_MAX = 3
			self.x_hs2000.AMMO_MAX = self.x_hs2000.NR_CLIPS_MAX * self.x_hs2000.CLIP_AMMO_MAX
			
			self.holt.stats.spread = 23
			self.holt.stats.recoil = 13
			self.holt.NR_CLIPS_MAX = 2
			self.holt.AMMO_MAX = self.holt.NR_CLIPS_MAX * self.holt.CLIP_AMMO_MAX
			self.x_holt.fire_mode_data.fire_rate = 60/400
			self.x_holt.single.fire_rate = 60/400
			self.x_holt.stats.spread = 23
			self.x_holt.stats.recoil = 13
			self.x_holt.NR_CLIPS_MAX = 1.5
			self.x_holt.AMMO_MAX = self.x_holt.NR_CLIPS_MAX * self.x_holt.CLIP_AMMO_MAX
			
		end
		Gilza_init_upper_mid_pistols()
		
		---- 250 pistols ----
		local function Gilza_init_heavy_pistols()
			
			-- 1-2 headshot kill
			local heavy_pistols = {
				m1911 = {fmd = "single",akimbo = true},
				pl14 = {fmd = "single",akimbo = true},
				sparrow = {fmd = "single",akimbo = true},
				deagle = {fmd = "single",akimbo = true},
				breech = {fmd = "single",akimbo = true}
			}
			
			local new_fire_rate_multiplier = 1.2
			local new_damage = 250
			
			for gun, tbl in pairs(heavy_pistols) do
				if tbl.fmd == "auto" then
					new_fire_rate_multiplier = 0.8
				else
					new_fire_rate_multiplier = 1.2
				end
				local function apply_stats(id, is_akimbo)
					if self[id] then
						if self[id].fire_mode_data then
							self[id].fire_mode_data.fire_rate = self[id].fire_mode_data.fire_rate * new_fire_rate_multiplier
						end
						if self[id].single then
							self[id].single.fire_rate = self[id].single.fire_rate * new_fire_rate_multiplier
						end
						if self[id].auto then
							self[id].auto.fire_rate = self[id].auto.fire_rate * new_fire_rate_multiplier
						end
						self[id].damage_falloff = new_pistol_damage_falloff
						if is_akimbo then
							self[id].stats.damage = math.ceil(new_damage/2)
							self[id].AMMO_PICKUP = {((avg_250_pickup * 0.9) / 1.35) * 2,((avg_250_pickup * 1.1) / 1.35) * 2}
						else
							self[id].stats.damage = new_damage
							self[id].AMMO_PICKUP = {((avg_250_pickup * 0.9) / 1.35) * secondary_mul,((avg_250_pickup * 1.1) / 1.35) * secondary_mul}
						end
					end
				end
				
				apply_stats(gun)
				
				if tbl.akimbo then
					local akimbo_string
					if type(tbl.akimbo) == "string" then
						akimbo_string = tbl.akimbo
					else
						akimbo_string = "x_"..gun
					end
					apply_stats(akimbo_string, true)
				end
				
			end
			
			self.m1911.stats.spread = 14
			self.m1911.stats.recoil = 13
			self.m1911.fire_mode_data.fire_rate = 60/333
			self.m1911.single.fire_rate = 60/333
			self.m1911.NR_CLIPS_MAX = 4
			self.m1911.AMMO_MAX = self.m1911.NR_CLIPS_MAX * self.m1911.CLIP_AMMO_MAX
			self.x_m1911.stats.spread = 14
			self.x_m1911.stats.recoil = 13
			self.x_m1911.fire_mode_data.fire_rate = 60/333
			self.x_m1911.single.fire_rate = 60/333
			self.x_m1911.NR_CLIPS_MAX = 2
			self.x_m1911.AMMO_MAX = self.x_m1911.NR_CLIPS_MAX * self.x_m1911.CLIP_AMMO_MAX
			
			self.pl14.stats.spread = 16
			self.pl14.stats.recoil = 7
			self.pl14.NR_CLIPS_MAX = 4
			self.pl14.AMMO_MAX = self.pl14.NR_CLIPS_MAX * self.pl14.CLIP_AMMO_MAX
			self.x_pl14.fire_mode_data.fire_rate = 60/333
			self.x_pl14.single.fire_rate = 60/333
			self.x_pl14.stats.spread = 16
			self.x_pl14.stats.recoil = 7
			self.x_pl14.NR_CLIPS_MAX = 2
			self.x_pl14.AMMO_MAX = self.x_pl14.NR_CLIPS_MAX * self.x_pl14.CLIP_AMMO_MAX
			
			self.sparrow.stats.spread = 16
			self.sparrow.stats.recoil = 7
			self.sparrow.NR_CLIPS_MAX = 4
			self.sparrow.AMMO_MAX = self.sparrow.NR_CLIPS_MAX * self.sparrow.CLIP_AMMO_MAX
			self.x_sparrow.fire_mode_data.fire_rate = 60/333
			self.x_sparrow.single.fire_rate = 60/333
			self.x_sparrow.stats.spread = 16
			self.x_sparrow.stats.recoil = 7
			self.x_sparrow.NR_CLIPS_MAX = 2
			self.x_sparrow.AMMO_MAX = self.x_sparrow.NR_CLIPS_MAX * self.x_sparrow.CLIP_AMMO_MAX
			
			self.breech.stats.spread = 19
			self.breech.stats.recoil = 5
			self.breech.NR_CLIPS_MAX = 6
			self.breech.AMMO_MAX = self.breech.NR_CLIPS_MAX * self.breech.CLIP_AMMO_MAX
			self.x_breech.fire_mode_data.fire_rate = 60/333
			self.x_breech.single.fire_rate = 60/333
			self.x_breech.stats.spread = 19
			self.x_breech.stats.recoil = 5
			self.x_breech.NR_CLIPS_MAX = 3
			self.x_breech.AMMO_MAX = self.x_breech.NR_CLIPS_MAX * self.x_breech.CLIP_AMMO_MAX
			
			self.deagle.stats.spread = 15
			self.deagle.stats.recoil = 6
			self.deagle.NR_CLIPS_MAX = 5
			self.deagle.AMMO_MAX = self.deagle.NR_CLIPS_MAX * self.deagle.CLIP_AMMO_MAX
			self.x_deagle.stats.spread = 15
			self.x_deagle.stats.recoil = 6
			self.x_deagle.stats.concealment = 28
			self.x_deagle.fire_mode_data.fire_rate = 60/333
			self.x_deagle.single.fire_rate = 60/333
			self.x_deagle.NR_CLIPS_MAX = 2.5
			self.x_deagle.AMMO_MAX = self.x_deagle.NR_CLIPS_MAX * self.x_deagle.CLIP_AMMO_MAX
			
		end
		Gilza_init_heavy_pistols()
		
		---- 450 pistols ----
		local function Gilza_init_revolver_pistols()
			
			-- 1-1 headshot kill
			local heavy_pistol_ids = {
				new_raging_bull = {fmd = "single",akimbo = "x_rage"},
				chinchilla = {fmd = "single",akimbo = true},
				mateba = {fmd = "single",akimbo = "x_2006m"},
				model3 = {fmd = "single",akimbo = true},
				rsh12 = {fmd = "single",akimbo = false},
				korth = {fmd = "single",akimbo = true},
				peacemaker = {fmd = "single",akimbo = false}
			}
			
			local new_fire_rate_multiplier = 1.2
			local new_damage = 450
			
			for gun, tbl in pairs(heavy_pistol_ids) do
				if tbl.fmd == "auto" then
					new_fire_rate_multiplier = 0.8
				else
					new_fire_rate_multiplier = 1.2
				end
				local function apply_stats(id, is_akimbo)
					if self[id] then
						if self[id].fire_mode_data then
							self[id].fire_mode_data.fire_rate = self[id].fire_mode_data.fire_rate * new_fire_rate_multiplier
						end
						if self[id].single then
							self[id].single.fire_rate = self[id].single.fire_rate * new_fire_rate_multiplier
						end
						if self[id].auto then
							self[id].auto.fire_rate = self[id].auto.fire_rate * new_fire_rate_multiplier
						end
						self[id].damage_falloff = new_pistol_damage_falloff
						if is_akimbo then
							self[id].stats.damage = math.ceil(new_damage/2)
							self[id].AMMO_PICKUP = {((avg_450_pickup * 0.9) / 1.35) * 2,((avg_450_pickup * 1.1) / 1.35) * 2}
						else
							self[id].stats.damage = new_damage
							self[id].AMMO_PICKUP = {((avg_450_pickup * 0.9) / 1.35) * secondary_mul,((avg_450_pickup * 1.1) / 1.35) * secondary_mul}
						end
					end
				end
				
				apply_stats(gun)
				
				if tbl.akimbo then
					local akimbo_string
					if type(tbl.akimbo) == "string" then
						akimbo_string = tbl.akimbo
					else
						akimbo_string = "x_"..gun
					end
					apply_stats(akimbo_string, true)
				end
				
			end
			
			self.new_raging_bull.stats.spread = 19
			self.new_raging_bull.stats.recoil = 4
			self.new_raging_bull.NR_CLIPS_MAX = 6
			self.new_raging_bull.AMMO_MAX = self.new_raging_bull.NR_CLIPS_MAX * self.new_raging_bull.CLIP_AMMO_MAX
			self.x_rage.fire_mode_data.fire_rate = 60/333
			self.x_rage.single.fire_rate = 60/333
			self.x_rage.stats.spread = 19
			self.x_rage.stats.recoil = 4
			self.x_rage.NR_CLIPS_MAX = 3
			self.x_rage.AMMO_MAX = self.x_rage.NR_CLIPS_MAX * self.x_rage.CLIP_AMMO_MAX
			
			self.korth.stats.spread = 11
			self.korth.stats.recoil = 2
			self.korth.fire_mode_data.fire_rate = 60/333
			self.korth.single.fire_rate = 60/333
			self.korth.NR_CLIPS_MAX = 4
			self.korth.AMMO_MAX = self.korth.NR_CLIPS_MAX * self.korth.CLIP_AMMO_MAX
			self.x_korth.stats.spread = 11
			self.x_korth.stats.recoil = 2
			self.x_korth.fire_mode_data.fire_rate = 60/333
			self.x_korth.single.fire_rate = 60/333
			self.x_korth.NR_CLIPS_MAX = 2
			self.x_korth.AMMO_MAX = self.x_korth.NR_CLIPS_MAX * self.x_korth.CLIP_AMMO_MAX
			
			self.chinchilla.stats.spread = 21
			self.chinchilla.stats.recoil = 3
			self.chinchilla.NR_CLIPS_MAX = 5
			self.chinchilla.AMMO_MAX = self.chinchilla.NR_CLIPS_MAX * self.chinchilla.CLIP_AMMO_MAX
			self.x_chinchilla.fire_mode_data.fire_rate = 60/333
			self.x_chinchilla.single.fire_rate = 60/333
			self.x_chinchilla.stats.spread = 21
			self.x_chinchilla.stats.recoil = 3
			self.x_chinchilla.NR_CLIPS_MAX = 2.5
			self.x_chinchilla.AMMO_MAX = self.x_chinchilla.NR_CLIPS_MAX * self.x_chinchilla.CLIP_AMMO_MAX
			
			self.model3.stats.spread = 17
			self.model3.stats.recoil = 7
			self.model3.NR_CLIPS_MAX = 7
			self.model3.AMMO_MAX = self.model3.NR_CLIPS_MAX * self.model3.CLIP_AMMO_MAX
			self.x_model3.fire_mode_data.fire_rate = 60/333
			self.x_model3.single.fire_rate = 60/333
			self.x_model3.stats.spread = 17
			self.x_model3.stats.recoil = 7
			self.x_model3.NR_CLIPS_MAX = 3.5
			self.x_model3.AMMO_MAX = self.x_model3.NR_CLIPS_MAX * self.x_model3.CLIP_AMMO_MAX
			
			self.rsh12.stats.spread = 16
			self.rsh12.AMMO_PICKUP = {((avg_450_pickup * 0.9) / 1.35) * 0.5 * secondary_mul,((avg_450_pickup * 1.1) / 1.35) * 0.5 * secondary_mul}
			self.rsh12.NR_CLIPS_MAX = 4
			self.rsh12.AMMO_MAX = self.rsh12.NR_CLIPS_MAX * self.rsh12.CLIP_AMMO_MAX
			self.rsh12.stats_modifiers = {damage = 1}
			
			self.mateba.stats.reload = 15
			self.mateba.stats.recoil = 9
			self.mateba.stats.spread = 20
			self.mateba.NR_CLIPS_MAX = 4
			self.mateba.AMMO_MAX = self.mateba.NR_CLIPS_MAX * self.mateba.CLIP_AMMO_MAX
			self.x_2006m.fire_mode_data.fire_rate = 60/333
			self.x_2006m.single.fire_rate = 60/333
			self.x_2006m.stats.spread = 20
			self.x_2006m.stats.recoil = 9
			self.x_2006m.NR_CLIPS_MAX = 2
			self.x_2006m.AMMO_MAX = self.x_2006m.NR_CLIPS_MAX * self.x_2006m.CLIP_AMMO_MAX
			
			-- 1 shot to the body on normal swats, 1 shot headshot on everyone else (except dozers)
			-- the most badass cowboy in the west
			self.peacemaker.stats.damage = 650
			self.peacemaker.stats.spread = 23
			self.peacemaker.stats_modifiers = {damage = 1}
			self.peacemaker.NR_CLIPS_MAX = 4
			self.peacemaker.AMMO_MAX = self.peacemaker.NR_CLIPS_MAX * self.peacemaker.CLIP_AMMO_MAX
			
		end
		Gilza_init_revolver_pistols()
		
	end
	setPISTOLs()
	
	-- Grenade launchers, includes underbarrels
	local function setGLs()
		-- fml this thing is slow
		self.m32.stats.reload = 17
		self.m32.stats.recoil = 15
		self.gre_m79.stats.recoil = 19
		self.slap.stats.recoil = 19
		self.china.stats.recoil = 17
		self.arbiter.stats.recoil = 21
		self.ms3gl.stats.recoil = 13
		self.ms3gl.stats.spread = 18
		
		local gl_1300_avg_pickup = 0.26
		
		self.m32.AMMO_PICKUP = {gl_1300_avg_pickup * 0.9 / 1.35, gl_1300_avg_pickup * 1.1 / 1.35}
		Gilza.shotgun_minimal_damage_multipliers.m32 = 0.75
		
		self.slap.AMMO_PICKUP = {((gl_1300_avg_pickup * 0.9) / 1.35) * secondary_mul,((gl_1300_avg_pickup * 1.1) / 1.35) * secondary_mul}
		Gilza.shotgun_minimal_damage_multipliers.slap = 0.75
		
		self.gre_m79.AMMO_PICKUP = {gl_1300_avg_pickup * 0.9 / 1.35, gl_1300_avg_pickup * 1.1 / 1.35}
		Gilza.shotgun_minimal_damage_multipliers.gre_m79 = 0.75
		
		self.china.AMMO_PICKUP = {((0.32 * 0.9) / 1.35) * secondary_mul,((0.32 * 1.1) / 1.35) * secondary_mul}
		Gilza.shotgun_minimal_damage_multipliers.china = 0.75
		
		self.ms3gl.AMMO_PICKUP = {((0.62 * 0.9) / 1.35) * secondary_mul,((0.62 * 1.1) / 1.35) * secondary_mul}
		Gilza.shotgun_minimal_damage_multipliers.ms3gl = 0.75
		
		self.arbiter.AMMO_PICKUP = {((0.56 * 0.9) / 1.35) * secondary_mul,((0.56 * 1.1) / 1.35) * secondary_mul}
		Gilza.shotgun_minimal_damage_multipliers.arbiter = 0.75
		
		self.slap.projectile_types.launcher_velocity = "launcher_velocity_slap"
		self.gre_m79.projectile_types.launcher_velocity = "launcher_velocity"
		self.m32.projectile_types.launcher_velocity = "launcher_velocity_m32"
		self.china.projectile_types.launcher_velocity = "launcher_velocity_china"
		
		self.groza_underbarrel.AMMO_PICKUP = {0.12 * 0.9 / 1.35, 0.12 * 1.1 / 1.35}
		Gilza.shotgun_minimal_damage_multipliers.groza_underbarrel = 0.75
		self.contraband_m203.AMMO_PICKUP = {0.12 * 0.9 / 1.35, 0.12 * 1.1 / 1.35}
		Gilza.shotgun_minimal_damage_multipliers.contraband_m203 = 0.75

		self.contraband_m203.projectile_types.underbarrel_velocity_frag = "underbarrel_velocity_frag"
		self.groza_underbarrel.projectile_types.underbarrel_velocity_frag = "underbarrel_velocity_frag_groza"
		
		
	end
	setGLs()
	
	-- Flammenwerfers --
	local function setFLAMENs()
		
		self.flamethrower_mk2.stats.damage = 15
		self.flamethrower_mk2.stats.reload = 18
		self.flamethrower_mk2.CLIP_AMMO_MAX = 400
		self.flamethrower_mk2.NR_CLIPS_MAX = 2
		self.flamethrower_mk2.AMMO_PICKUP = {(15 * 0.9) / 1.35,(15 * 1.1) / 1.35}
		self.flamethrower_mk2.AMMO_MAX = self.flamethrower_mk2.CLIP_AMMO_MAX * self.flamethrower_mk2.NR_CLIPS_MAX
		
		self.system.stats.damage = 10
		self.system.stats.reload = 18
		self.system.CLIP_AMMO_MAX = 300
		self.system.NR_CLIPS_MAX = 2
		self.system.AMMO_PICKUP = {((15 * 0.9) / 1.35) * secondary_mul,((15 * 1.1) / 1.35) * secondary_mul}
		self.system.AMMO_MAX = self.system.CLIP_AMMO_MAX * self.system.NR_CLIPS_MAX
		
		-- Event moneythrower, only dmg tweak since its op as fuck anyways and dot data wont change much, so just bring it up to new health values
		if self.money then
			self.money.stats.damage = 90
		end
		
	end
	setFLAMENs()
	
	--Miniguns--
	local function setMINIGUNs()
		--the ovkl one
		self.m134.stats.damage = 46
		self.m134.stats.recoil = 21
		self.m134.stats.spread = 10
		self.m134.stats.suppression = 2
		self.m134.CLIP_AMMO_MAX = 600
		self.m134.NR_CLIPS_MAX = 1.5
		self.m134.AMMO_MAX = self.m134.CLIP_AMMO_MAX * self.m134.NR_CLIPS_MAX
		self.m134.AMMO_PICKUP = {(17.5 * 0.7) / 1.35,(17.5 * 1.3) / 1.35}
		self.m134.stats.reload = 14
		--the other one
		self.shuno.CLIP_AMMO_MAX = 600
		self.shuno.NR_CLIPS_MAX = 1.5
		self.shuno.AMMO_MAX = self.shuno.CLIP_AMMO_MAX * self.shuno.NR_CLIPS_MAX
		self.shuno.stats.damage = 68
		self.shuno.stats.recoil = 17
		self.shuno.stats.spread = 10
		self.shuno.stats.reload = 14
		self.shuno.stats.suppression = 2
		self.shuno.AMMO_PICKUP = {(11 * 0.7) / 1.35,(11 * 1.3) / 1.35}
		--the 'minigun' that is hailstorm
		self.hailstorm.CLIP_AMMO_MAX = 210
		self.hailstorm.NR_CLIPS_MAX = 3
		self.hailstorm.AMMO_MAX = self.hailstorm.CLIP_AMMO_MAX * self.hailstorm.NR_CLIPS_MAX
		self.hailstorm.stats.damage = 71
		self.hailstorm.stats.recoil = 20
		self.hailstorm.AMMO_PICKUP = {(8.1 * 0.9) / 1.35,(8.1 * 1.1) / 1.35}
		self.hailstorm.damage_falloff = {
			optimal_distance = 100,
			optimal_range = 100,
			near_falloff = 100,
			far_falloff = 100,
			near_multiplier = 1,
			far_multiplier = 1
		}
	end
	setMINIGUNs()
	
	--Bows--
	local function setBOWs()
		-- in their infinite wisdom overkill gave this bow a multiplier of 100, which means that any mod that adjusts damage stat, also has a multiplier of 100
		-- problem arises when you realise that attachments that change the projectile, take their new damage stat from the projectiletweakdata
		-- instead of ammunition mod that updates the projectile
		-- poison arrow projectile for example, has 300 damage, when the base arrow has 2k damage, but because of the damage multipliers,
		-- poison arrow gets multiplied by 100 instead of 10, so the game thinks that the poision arrow would be 3000 damage total, which is higher then the base arrow
		-- this fixes the issue by overriding the modifier to a value that actually works, and overrides the default damage so that default arrow's 2k damage is correct
		-- godbless weapon lib that can handle weapons with high damage and doesnt clamp anything for no reason, so we don't have to use damage modifiers that fuck everything up
		self.long.stats.damage = 200
		self.long.stats_modifiers = {
			damage = 10
		}
		-- same as longbow
		self.elastic.stats.damage = 200
		self.elastic.stats_modifiers = {
			damage = 10
		}
		-- same as longbow
		self.arblast.stats.damage = 200
		self.arblast.stats_modifiers = {
			damage = 10
		}
		-- crossbows
		self.frankish.stats.spread = 20
		self.arblast.stats.spread = 22
		self.ecp.stats.spread = 15
		self.hunter.stats.spread = 19
		-- bows
		self.plainsrider.stats.recoil = 21
		self.long.stats.recoil = 17
		self.elastic.stats.recoil = 15
	end
	setBOWs()
	
	local function setNewRecoil()
		
		local function set_new_weapon_recoil(weapon_table, recoil_data)
		
			local UPrecoil
			local DOWNrecoil
			local LEFTrecoil
			local RIGHTrecoil
			
			local V_base_recoil = recoil_data.v_base
			local V_recoil_deviation = recoil_data.v_deviation
			local H_base_recoil = recoil_data.h_base
			local H_recoil_deviation = recoil_data.h_deviation
		
			for weapon, recoil_lean in pairs(weapon_table) do
				local recoil = self[weapon].stats.recoil * 4 - 4 -- in game calculator seems to be inaccurate or is coded to favour values down
				local recoil_weight = 1 - (recoil/100)
				UPrecoil = V_base_recoil + (recoil_weight * V_recoil_deviation)
				DOWNrecoil = UPrecoil * 0.9
				if recoil_lean == "left" then
					LEFTrecoil = H_base_recoil + (recoil_weight * H_recoil_deviation)
					RIGHTrecoil = LEFTrecoil * 0.05
				else
					RIGHTrecoil = H_base_recoil + (recoil_weight * H_recoil_deviation)
					LEFTrecoil = RIGHTrecoil * 0.05
				end
				LEFTrecoil = LEFTrecoil * -1
				self[weapon].kick = {
					standing = {
						UPrecoil,
						DOWNrecoil,
						LEFTrecoil,
						RIGHTrecoil
					}
				}
				self[weapon].kick.steelsight = self[weapon].kick.standing
				self[weapon].kick.crouching = self[weapon].kick.standing
			end
			
		end
		
		local AR_list = {
			ak74 = "left",
			akm = "right",
			ak5 = "right",
			flint = "left",
			amcar = "left",
			m16 = "left",
			tecci = "right",
			new_m4 = "right",
			sub2000 = "left",
			famas = "right",
			s552 = "right",
			scar = "right",
			fal = "left",
			ching = "left",
			galil = "right",
			g3 = "right",
			akm_gold = "right",
			g36 = "left",
			contraband = "left",
			vhs = "left",
			new_m14 = "right",
			l85a2 = "right",
			aug = "left",
			corgi = "left",
			asval = "right",
			komodo = "left",
			groza = "right",
			shak12 = "left",
			tkb = "right"
		}
		local AR_recoil = {
			v_base = 0.7,
			v_deviation = 0.75,
			h_base = 0.8,
			h_deviation = 0.25
		}
		set_new_weapon_recoil(AR_list, AR_recoil)
		
		local SMG_list = {
			m45 = "left",
			mp7 = "right",
			mac10 = "left",
			hajk = "right",
			vityaz = "right",
			cobray = "left",
			new_mp5 = "right",
			m1928 = "right",
			fmg9 = "left",
			pm9 = "right",
			scorpion = "left",
			mp9 = "left",
			olympic = "left",
			baka = "left",
			shepheard = "left",
			schakal = "right",
			erma = "right",
			sr2 = "right",
			akmsu = "left",
			tec9 = "left",
			p90 = "right",
			polymer = "left",
			coal = "right",
			sterling = "right",	
			uzi = "left",			
			-- akimbos
			x_m45 = "left",
			x_hajk = "right",
			x_olympic = "left",
			x_schakal = "right",
			x_erma = "right",
			x_sterling = "right",
			x_vityaz = "right",
			x_mp5 = "right",
			x_m1928 = "right",
			x_shepheard = "left",
			x_sr2 = "right",
			x_coal = "right",
			x_uzi = "left",
			x_mp7 = "right",
			x_akmsu = "left",
			x_tec9 = "left",
			x_polymer = "left",
			x_mac10 = "left",
			x_cobray = "left",
			x_pm9 = "right",
			x_scorpion = "left",
			x_mp9 = "left",
			x_baka = "left",
			x_p90 = "right",
			-- full auto pistols have smg recoil because they kinda are?
			beer = "left",
			x_beer = "left",
			glock_18c = "right",
			x_g18c = "right",
			czech = "left",
			x_czech = "left",
			stech = "right",
			x_stech = "right",
		}
		local SMG_recoil = {
			v_base = 0.4,
			v_deviation = 0.9,
			h_base = 0.55,
			h_deviation = 0.6
		}
		set_new_weapon_recoil(SMG_list, SMG_recoil)
		
		-- includes miniguns
		local LMG_list = {
			hk21 = "left",
			mg42 = "left",
			m249 = "right",
			par = "left",
			rpk = "right",
			m60 = "left",
			hk51b = "right",
			hcar = "right",
			kacchainsaw = "right",
			shuno = "right",
			m134 = "right",
			hailstorm = "right",
		}
		local LMG_recoil = {
			v_base = 0.85,
			v_deviation = 0.65,
			h_base = 0.75,
			h_deviation = 0.4
		}
		set_new_weapon_recoil(LMG_list, LMG_recoil)
		
		local Sniper_list = {
			tti = "left",
			desertfox = "right",
			siltstone = "right",
			wa2000 = "right",
			mosin = "right",
			model70 = "left",
			r93 = "right",
			msr = "left",
			winchester1874 = "right",
			m95 = "right",
			r700 = "left",
			sbl = "left",
			qbu88 = "right",
			scout = "left",
			contender = "right",
			victor = "left",
			awp = "left",
			bessy = "left",
		}
		local Sniper_recoil = {
			v_base = 0.7,
			v_deviation = 1.2,
			h_base = 0.1,
			h_deviation = 0.9
		}
		set_new_weapon_recoil(Sniper_list, Sniper_recoil)
		
		-- only semi auto, full autos are under smg's
		local Pistol_list = {
			lemming = "right",
			sparrow = "left",
			b92fs = "right",
			new_raging_bull = "left",
			c96 = "right",
			chinchilla = "right",
			glock_17 = "left",
			g26 = "left",
			g22c = "left",
			packrat = "left",
			colt_1911 = "left",
			shrew = "left",
			deagle = "right",
			ppk = "right",
			usp = "right",
			hs2000 = "left",
			mateba = "left",
			breech = "right",
			peacemaker = "left",
			p226 = "right",
			pl14 = "right",
			legacy = "right",
			holt = "left",
			model3 = "right",
			m1911 = "left",
			type54 = "left",
			rsh12 = "right",
			maxim9 = "right",
			korth = "left",
			-- akimbo
			x_sparrow = "left",
			x_b92fs = "right",
			x_rage = "left",
			x_c96 = "right",
			x_chinchilla = "right",
			x_g17 = "left",
			jowi = "left",
			x_g22c = "left",
			x_packrat = "left",
			x_1911 = "left",
			x_shrew = "left",
			x_deagle = "right",
			x_ppk = "right",
			x_usp = "right",
			x_hs2000 = "left",
			x_2006m = "left",
			x_breech = "right",
			x_p226 = "right",
			x_pl14 = "right",
			x_legacy = "right",
			x_holt = "left",
			x_model3 = "right",
			x_m1911 = "left",
			x_type54 = "left",
			x_maxim9 = "right",
			x_korth = "left",
		}
		local Pistol_recoil = {
			v_base = 0.1,
			v_deviation = 1,
			h_base = 0.2,
			h_deviation = 1
		}
		set_new_weapon_recoil(Pistol_list, Pistol_recoil)
		
		local Shotgun_list = {
			boot = "left",
			saiga = "left",
			b682 = "left",
			benelli = "right",
			huntsman = "right",
			spas12 = "left",
			ksg = "right",
			r870 = "right",
			aa12 = "right",
			m1897 = "right",
			m590 = "left",
			sko12 = "left",
			supernova = "left",
			basset = "left",
			m37 = "left",
			rota = "right",
			serbu = "right",
			striker = "left",
			judge = "right",
			coach = "right",
			ultima = "right",
			-- akimbo
			x_rota = "right",
			x_sko12 = "left",
			x_basset = "left",
			x_judge = "right",
		}
		local Shotgun_recoil = {
			v_base = 1,
			v_deviation = 1.5,
			h_base = 0.6,
			h_deviation = 0.8
		}
		set_new_weapon_recoil(Shotgun_list, Shotgun_recoil)
	
	end
	setNewRecoil()
	
	-- remove spread_moving stat from all weapons
	for i=1, #Gilza.defaultWeapons do
		if self[Gilza.defaultWeapons[i]].stats.spread_moving then
			self[Gilza.defaultWeapons[i]].stats.spread_moving = self[Gilza.defaultWeapons[i]].stats.spread
		end
	end
	
end)

dofile("mods/Gilza/lua/WeaponTweaksCustomGuns.lua")