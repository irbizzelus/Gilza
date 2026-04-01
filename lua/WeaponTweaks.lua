if not Gilza then
	dofile("mods/Gilza/lua/1_GilzaBase.lua")
end

Hooks:PostHook(WeaponTweakData, "_init_stats", "Gilza_post_WeaponTweakData_init_stats", function(self)
	-- default recoil multiplier. in vanilla it goes from 3 to 0.5, practically allowing you to improve recoil by a magnitude of 6x with recoil adjusting attachments/skills
	-- with new values maximum magnitude we will have is 3x. this makes weapons feel more unique because weapon's basic recoil is more important then what you can do with attachments/skills
	self.stats.recoil = {
		1.54,
		1.5,
		1.46,
		1.42,
		1.38,
		1.34,
		1.3,
		1.26,
		1.22,
		1.18,
		1.14,
		1.1,
		1.06,
		1.02,
		0.98,
		0.94,
		0.9,
		0.86,
		0.82,
		0.78,
		0.74,
		0.7,
		0.66,
		0.62,
		0.58,
		0.54
	}
	
	Gilza.Weapons_module = {}
	
	-- ammo pick up formula
	function Gilza.Weapons_module:get_ammo_pickup(weapon_damage, expected_accuracy, diff_modifier)
		if not weapon_damage then
			return 0
		end
		local acc = expected_accuracy or 0.3
		local diff = diff_modifier or 0.65
		-- light swat and heavy swat health pool based vars
		return (((math.ceil(250/weapon_damage) + math.ceil(450/weapon_damage)) / acc) / 2) * diff
	end
	
	Gilza.Weapons_module.ammo_pickups = {
		ARs = {
			_450 = Gilza.Weapons_module:get_ammo_pickup(450, 0.44),
			_250 = Gilza.Weapons_module:get_ammo_pickup(250, 0.4),
			_200 = Gilza.Weapons_module:get_ammo_pickup(155, 0.36) * 0.88, -- 12% less then 155
			_155 = Gilza.Weapons_module:get_ammo_pickup(155, 0.36),
			_125 = Gilza.Weapons_module:get_ammo_pickup(125, 0.34)
		},
		SHOTGUNs = {
			_900 = Gilza.Weapons_module:get_ammo_pickup(900, 0.95),
			_450 = Gilza.Weapons_module:get_ammo_pickup(450, 0.8),
			_325 = Gilza.Weapons_module:get_ammo_pickup(325, 0.85), -- better accuracy is not really expected, but their benefits from overkill skill are too good.
			_160 = Gilza.Weapons_module:get_ammo_pickup(160, 0.65)
		},
		LMGs = {
			-- better ammo with easier diff modifiers, should incentivize defence playstyle by allowing to pick up less often, and reducing dmg up close
			_325 = Gilza.Weapons_module:get_ammo_pickup(325, 0.36),
			_250 = Gilza.Weapons_module:get_ammo_pickup(250, 0.36, 0.85),
			_200 = Gilza.Weapons_module:get_ammo_pickup(155, 0.32, 0.85) * 0.88,
			_155 = Gilza.Weapons_module:get_ammo_pickup(155, 0.32, 0.85),
			_125 = Gilza.Weapons_module:get_ammo_pickup(125, 0.3, 0.85),
			_95 = Gilza.Weapons_module:get_ammo_pickup(95, 0.28, 0.85),
			_250_bipodless = Gilza.Weapons_module:get_ammo_pickup(250, 0.36, 0.75),
			_200_bipodless = Gilza.Weapons_module:get_ammo_pickup(155, 0.32, 0.75) * 0.88,
			_155_bipodless = Gilza.Weapons_module:get_ammo_pickup(155, 0.32, 0.75),
			_125_bipodless = Gilza.Weapons_module:get_ammo_pickup(125, 0.3, 0.75),
			_95_bipodless = Gilza.Weapons_module:get_ammo_pickup(95, 0.28, 0.75),
		},
		SNIPERs = {
			-- all can do 1 tap headshots. balanced around special bodyshot breakpoints. manualy.
			_650 = 0.75,
			_950 = 0.7,
			_1300 = 0.65,
			_1600 = 0.55,
			_50cal = 0.28
		},
		SMGs = {
			_250 = Gilza.Weapons_module:get_ammo_pickup(250, 0.38),
			_200 = Gilza.Weapons_module:get_ammo_pickup(155, 0.34) * 0.88,
			_155 = Gilza.Weapons_module:get_ammo_pickup(155, 0.34),
			_125 = Gilza.Weapons_module:get_ammo_pickup(125, 0.32),
			_95 = Gilza.Weapons_module:get_ammo_pickup(95, 0.30),
			_71 = Gilza.Weapons_module:get_ammo_pickup(71, 0.28),
		},
		PISTOLs = {
			_450 = Gilza.Weapons_module:get_ammo_pickup(450, 0.57),
			_250 = Gilza.Weapons_module:get_ammo_pickup(250, 0.46),
			_200 = Gilza.Weapons_module:get_ammo_pickup(155, 0.4) * 0.88,
			_155 = Gilza.Weapons_module:get_ammo_pickup(155, 0.4),
			_125 = Gilza.Weapons_module:get_ammo_pickup(125, 0.38),
			_95 = Gilza.Weapons_module:get_ammo_pickup(95, 0.36),
			_88 = Gilza.Weapons_module:get_ammo_pickup(88, 0.36),
		},
		GLs = {
			_1300 = 0.325,
			_960 = 0.4,
			_480 = 0.7,
			_360 = 0.775,
			_underbarrel = 0.15
		},
	}
	
	Gilza.Weapons_module.recoil_stats = {
		ARs = {
			v_base = 0.7,
			v_deviation = 1.8,
			h_base = 0.65,
			h_deviation = 0.65
		},
		SHOTGUNs = {
			v_base = 2.3,
			v_deviation = 2.3,
			h_base = 0.6,
			h_deviation = 1.6
		},
		LMGs = {
			v_base = 1.3,
			v_deviation = 1.4,
			h_base = 1.2,
			h_deviation = 0.75
		},
		SNIPERs = {
			v_base = 1.8,
			v_deviation = 1.8,
			h_base = 0.3,
			h_deviation = 0.5
		},
		SMGs = {
			v_base = 0.75,
			v_deviation = 1.3,
			h_base = 0.9,
			h_deviation = 1.1
		},
		PISTOLs = {
			v_base = 0.2,
			v_deviation = 2.2,
			h_base = 0.3,
			h_deviation = 2.8
		}
	}
	
	Gilza.Weapons_module.damage_dropoff = {
		ARs = {
			optimal_distance = 10,
			optimal_range = 10,
			near_falloff = 0,
			far_falloff = 0,
			near_multiplier = 1,
			far_multiplier = 1
		},
		SHOTGUNs = {
			_900 = {
				optimal_distance = 0,
				optimal_range = 1300,
				near_falloff = 0,
				far_falloff = 1000,
				near_multiplier = 1,
				far_multiplier = 0.5
			},
			_450 = {
				optimal_distance = 0,
				optimal_range = 1200,
				near_falloff = 0,
				far_falloff = 1000,
				near_multiplier = 1,
				far_multiplier = 0.5
			},
			_325 = {
				optimal_distance = 0,
				optimal_range = 1100,
				near_falloff = 0,
				far_falloff = 900,
				near_multiplier = 1,
				far_multiplier = 0.5
			},
			_160 = {
				optimal_distance = 0,
				optimal_range = 1000,
				near_falloff = 0,
				far_falloff = 900,
				near_multiplier = 1,
				far_multiplier = 0.5
			}
		},
		LMGs = {
			optimal_distance = 150,
			optimal_range = 1000,
			near_falloff = 0,
			far_falloff = 1000,
			near_multiplier = 0.8,
			far_multiplier = 1.5
		},
		SNIPERs = {
			optimal_distance = 10,
			optimal_range = 10,
			near_falloff = 0,
			far_falloff = 0,
			near_multiplier = 1,
			far_multiplier = 1
		},
		SMGs = {
			optimal_distance = 150,
			optimal_range = 650,
			near_falloff = 0,
			far_falloff = 800,
			near_multiplier = 1.2,
			far_multiplier = 0.5
		},
		PISTOLs = {
			optimal_distance = 10,
			optimal_range = 10,
			near_falloff = 0,
			far_falloff = 0,
			near_multiplier = 1,
			far_multiplier = 1
		}
	}
	
	function Gilza.Weapons_module:get_pickup_adjusments_for_wpn_mod(category, old_damage, new_damage, gained_ap, gained_underbarrel)
		if not category or not old_damage or not new_damage then
			return {min_mul = 1, max_mul = 1}
		end
		local cat_vars = Gilza.Weapons_module.ammo_pickups[category] or Gilza.Weapons_module.ammo_pickups[category.."s"]
		if not cat_vars then
			return {min_mul = 1, max_mul = 1}
		end
		
		local old_min = cat_vars["_"..old_damage] * 0.9
		local old_max = cat_vars["_"..old_damage] * 1.1
		local new_min = cat_vars["_"..new_damage] * 0.9
		local new_max = cat_vars["_"..new_damage] * 1.1
		
		if old_min == 0 or old_max == 0 then
			return {min_mul = 1, max_mul = 1}
		end
		
		local multiplier = 1
		if gained_ap then -- always adds max penalty assuming that all AP buffs are enabled. i am too lazy to refactor so much shit just to make it slightly more adaptable and future proof
			multiplier = multiplier * 0.6
		end
		if gained_underbarrel then
			multiplier = multiplier * 0.7
		end
		
		return {min_mul = new_min * multiplier / old_min, max_mul = new_max * multiplier / old_max}
	end
	
	-- Adds ammo_pickup_min and max _mul to custom_stats weapon attribute table. If return_string is requested, returns a generic description string with ap types,
	-- and total pickup change, also creates this string for localiz manager to add later.
	-- Otherwise returns total pickup reduction change as a string.
	function Gilza.Weapons_module:set_pickup_mul_based_on_ap(wpn_cstm_stats_tbl, return_string)
		local mul = 1
		local body_ap = "_nil_"
		local shield_ap = "_nil_"
		local wall_ap = "_nil_"
		local enemy_ap = "_nil_"
		if wpn_cstm_stats_tbl.armor_piercing_add and wpn_cstm_stats_tbl.armor_piercing_add == 1 then
			body_ap = "_BAP_"
			mul = mul - 0.15
		end
		if wpn_cstm_stats_tbl.can_shoot_through_shield then
			shield_ap = "_SAP_"
			mul = mul - 0.15
		end
		if wpn_cstm_stats_tbl.can_shoot_through_wall then
			wall_ap = "_WAP_"
			mul = mul - 0.05
		end
		if wpn_cstm_stats_tbl.can_shoot_through_enemy then
			enemy_ap = "_EAP_"
			mul = mul - 0.05
		end
		
		local str_name = "bm_wpn_gilza_generic_ap_desc"..body_ap..shield_ap..wall_ap..enemy_ap
		local total_decrease = tostring((1-mul)*100)
		
		-- create the string itself. due to file load order, create a string itself here, because loc manager does not exist yet
		local function Create_generic_ap_string()
			local lang = "en"
			local file = io.open(SavePath .. 'blt_data.txt', 'r')
			if file then
				for k, v in pairs(json.decode(file:read('*all')) or {}) do
					if k == "language" then
						lang = v
					end
				end
				file:close()
			end
			local chosen_language = "eng"
			if lang == "ru" then
				chosen_language = "ru"
			end
			
			local str_itself = "Allows to pierce through:"
			if chosen_language == "ru" then
				str_itself = "Позволяет пробивать насквозь:"
			end
			
			if body_ap == "_BAP_" then
				if chosen_language == "ru" then
					str_itself = str_itself.."\n- Нательную броню"
				else
					str_itself = str_itself.."\n- Enemy body armor"
				end
			end
			if shield_ap == "_SAP_" then
				if chosen_language == "ru" then
					str_itself = str_itself.."\n- Щитовиков"
				else
					str_itself = str_itself.."\n- Shields"
				end
			end
			if wall_ap == "_WAP_" then
				if chosen_language == "ru" then
					str_itself = str_itself.."\n- Стены"
				else
					str_itself = str_itself.."\n- Walls"
				end
			end
			if enemy_ap == "_EAP_" then
				if chosen_language == "ru" then
					str_itself = str_itself.."\n- Несколько врагов"
				else
					str_itself = str_itself.."\n- Multiple enemies"
				end
			end
			
			local str_end = "\n\nAmmo pick up reduced by "..total_decrease.."%."
			if chosen_language == "ru" then
				str_end = "\n\nПодбор боеприпасов уменьшен на "..total_decrease.."%."
			end
			
			str_itself = str_itself..str_end
			
			Gilza.strings_to_add = Gilza.strings_to_add or {}
			Gilza.strings_to_add[tostring(str_name)] = str_itself
		end
		
		if mul < 1 then
			wpn_cstm_stats_tbl.ammo_pickup_min_mul = mul
			wpn_cstm_stats_tbl.ammo_pickup_max_mul = mul
			Create_generic_ap_string()
		end
		
		if return_string then
			return str_name
		else
			return tostring(total_decrease)
		end
	end
	
	function Gilza.Weapons_module:set_new_weapon_recoil(recoil_data, weapon_data, lean, table_to_adjust)
		
		if not recoil_data or not type(weapon_data) == "table" then
			log("[Gilza] Error: new weapon recoil was not set properly due to missing recoil data. Weapon(s): ")
			Utils.PrintTable(weapon_data)
			return
		end
		
		if not weapon_data then
			log("[Gilza] Error: new weapon recoil was not set properly due to missing weapon data.")
			return
		end
		
		lean = lean or "right"
		if type(weapon_data) == "string" then
			weapon_data = {[tostring(weapon_data)] = lean}
		end
		
		local UPrecoil
		local DOWNrecoil
		local LEFTrecoil
		local RIGHTrecoil
		
		local V_base_recoil = recoil_data.v_base
		local V_recoil_deviation = recoil_data.v_deviation
		local H_base_recoil = recoil_data.h_base
		local H_recoil_deviation = recoil_data.h_deviation
	
		for weapon, recoil_lean in pairs(weapon_data) do
			local recoil = table_to_adjust[weapon].stats.recoil * 4 - 4 -- in game calculator seems to be inaccurate or is coded to favour values down
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
			table_to_adjust[weapon].kick = {
				standing = {
					UPrecoil,
					DOWNrecoil,
					LEFTrecoil,
					RIGHTrecoil
				}
			}
			table_to_adjust[weapon].kick.steelsight = table_to_adjust[weapon].kick.standing
			table_to_adjust[weapon].kick.crouching = table_to_adjust[weapon].kick.standing
		end
		
	end
	
end)

Hooks:PostHook(WeaponTweakData, "_init_data_player_weapons", "Gilza_init_new_vanilla_weapon_stats", function(self, tweak_data)
	local special_weapon_ids = {
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
		"welrod",
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
	
	local function TableConcat(t1,t2)
		for i=1,#t2 do
			t1[#t1+1] = t2[i]
		end
		return t1
	end
	Gilza.defaultWeapons = TableConcat(special_weapon_ids,weapon_ids)
	
	-- accuracy no longer affected by player pose
	local function setUpWeapons()
		for _, gun in ipairs(Gilza.defaultWeapons) do
			if self[gun] and self[gun].spread.standing and self[gun].spread.steelsight and self[gun].spread.crouching and self[gun].spread.moving_standing and self[gun].spread.moving_crouching and self[gun].spread.moving_steelsight then
				self[gun].spread.steelsight = self[gun].spread.standing
				self[gun].spread.crouching = self[gun].spread.standing
				self[gun].spread.moving_standing = self[gun].spread.standing
				self[gun].spread.moving_crouching = self[gun].spread.standing
				self[gun].spread.moving_steelsight = self[gun].spread.standing
			end
		end
	end
	setUpWeapons()
	
	local secondary_mul = 0.7
	local secondary_to_primary_mul = 1/secondary_mul
	local akimbo_rof_mul = 1.3 -- increase relative to secondaries
	local G_W_M = Gilza.Weapons_module
	
	-- Assault rifles --
	local function setARs() -- using funcs for the sake of readability
		-- all reload timer overrides check if the reload speed is default, in case user runs custom animations that allready change the reload timers
		
		local pickups = G_W_M.ammo_pickups.ARs
		
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
			
			local pick_up = pickups._450

			for id, status in pairs(ARs_450) do
				if self[id] then
					self[id].stats.damage = 450
					if ARs_450[id] == "underbarrel" then
						self[id].AMMO_PICKUP = {((pick_up * 0.9)) * 0.7,((pick_up * 1.1)) * 0.7}
					else
						self[id].AMMO_PICKUP = {(pick_up * 0.9),(pick_up * 1.1)}
					end	
				end
			end
			
			self.scar.CLIP_AMMO_MAX = 25
			self.scar.NR_CLIPS_MAX = 4
			self.scar.AMMO_MAX = self.scar.CLIP_AMMO_MAX * self.scar.NR_CLIPS_MAX
			self.scar.stats.spread = 17
			self.scar.stats.recoil = 6
			self.scar.fire_mode_data = {fire_rate = 60/600}
			self.scar.auto = {fire_rate = 60/600}
			
			self.ching.stats.reload = 14
			self.ching.NR_CLIPS_MAX = 8
			self.ching.AMMO_MAX = self.ching.CLIP_AMMO_MAX * self.ching.NR_CLIPS_MAX
			self.ching.fire_mode_data = {fire_rate = 60/300}
			self.ching.single = {fire_rate = 60/300}
			
			self.new_m14.stats.reload = 8
			self.new_m14.CLIP_AMMO_MAX = 15
			self.new_m14.NR_CLIPS_MAX = 5
			self.new_m14.AMMO_MAX = self.new_m14.CLIP_AMMO_MAX * self.new_m14.NR_CLIPS_MAX
			self.new_m14.fire_mode_data = {fire_rate = 60/300}
			self.new_m14.single = {fire_rate = 60/300}
			
			self.shak12.CLIP_AMMO_MAX = 25
			self.shak12.NR_CLIPS_MAX = 4
			self.shak12.AMMO_MAX = self.shak12.CLIP_AMMO_MAX * self.shak12.NR_CLIPS_MAX
			self.shak12.stats.recoil = 11
			self.shak12.stats.spread = 19
			
			self.contraband.CLIP_AMMO_MAX = 25
			self.contraband.NR_CLIPS_MAX = 3
			self.contraband.AMMO_MAX = self.contraband.CLIP_AMMO_MAX * self.contraband.NR_CLIPS_MAX
			self.contraband.stats.recoil = 5
			self.contraband.stats.spread = 17
			self.contraband.fire_mode_data = {fire_rate = 60/600}
			self.contraband.auto = {fire_rate = 60/600}
			
			self.fal.CLIP_AMMO_MAX = 20
			self.fal.NR_CLIPS_MAX = 5
			self.fal.AMMO_MAX = self.fal.CLIP_AMMO_MAX * self.fal.NR_CLIPS_MAX
			self.fal.stats.recoil = 7
			self.fal.stats.spread = 15
			self.fal.fire_mode_data = {fire_rate = 60/660}
			self.fal.auto = {fire_rate = 60/660}
			
		end
		init_super_heavy()
		
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
			
			local pick_up = pickups._250

			for id, status in pairs(ARs_250) do
				if self[id] then
					self[id].stats.damage = 250
					if ARs_250[id] == "underbarrel" then
						self[id].AMMO_PICKUP = {((pick_up * 0.9)) * 0.7,((pick_up * 1.1)) * 0.7}
					else
						self[id].AMMO_PICKUP = {(pick_up * 0.9),(pick_up * 1.1)}
					end	
				end
			end
			
			self.groza.CLIP_AMMO_MAX = 25
			self.groza.NR_CLIPS_MAX = 4
			self.groza.AMMO_MAX = self.groza.CLIP_AMMO_MAX * self.groza.NR_CLIPS_MAX
			self.groza.stats.recoil = 13
			self.groza.stats.spread = 13
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
		init_heavy()
		
		-- 2-3 headshot kill - 155 profile breakpoints on swats but tiny bit better breakpoints on specials
		local function init_medium_heavy()
			
			local ARs_200 = {
				amcar = true,
				ak74 = true,
				sub2000 = true,
				l85a2 = true,
				asval = true,		
			}
			
			local pick_up = pickups._200

			for id, status in pairs(ARs_200) do
				if self[id] then
					self[id].stats.damage = 200
					self[id].AMMO_PICKUP = {((pick_up * 0.9)),((pick_up * 1.1))}
				end
			end
			
			self.amcar.CLIP_AMMO_MAX = 25
			self.amcar.NR_CLIPS_MAX = 6
			self.amcar.AMMO_MAX = self.amcar.CLIP_AMMO_MAX * self.amcar.NR_CLIPS_MAX
			self.amcar.fire_mode_data = {fire_rate = 60/650}
			self.amcar.auto = {fire_rate = 60/650}
			self.amcar.stats.recoil = 9
			self.amcar.stats.spread = 14
			
			self.ak74.NR_CLIPS_MAX = 5
			self.ak74.AMMO_MAX = self.ak74.CLIP_AMMO_MAX * self.ak74.NR_CLIPS_MAX
			self.ak74.stats.spread = 11
			self.ak74.stats.recoil = 13
			self.ak74.fire_mode_data = {fire_rate = 60/650}
			self.ak74.auto = {fire_rate = 60/650}
			
			self.sub2000.NR_CLIPS_MAX = 4
			self.sub2000.AMMO_MAX = self.sub2000.CLIP_AMMO_MAX * self.sub2000.NR_CLIPS_MAX
			self.sub2000.stats.spread = 21
			self.sub2000.fire_mode_data = {fire_rate = 60/669}
			self.sub2000.single = {fire_rate = 60/669}
			
			self.l85a2.stats.reload = 16
			self.l85a2.stats.recoil = 17
			self.l85a2.stats.spread = 15
			self.l85a2.NR_CLIPS_MAX = 5
			self.l85a2.AMMO_MAX = self.l85a2.CLIP_AMMO_MAX * self.l85a2.NR_CLIPS_MAX
			
			self.asval.CLIP_AMMO_MAX = 20
			self.asval.NR_CLIPS_MAX = 7
			self.asval.AMMO_MAX = self.asval.CLIP_AMMO_MAX * self.asval.NR_CLIPS_MAX
			self.asval.stats.spread = 22
			self.asval.stats.reload = 20
			self.asval.stats.recoil = 16
			self.asval.auto = {fire_rate = 60/900}
			self.asval.fire_mode_data = {fire_rate = 60/900}
			
		end
		init_medium_heavy()
		
		-- 2-3 headshot kill
		local function init_medium()
			
			local ARs_155 = {
				corgi = true,
				s552 = true,
				new_m4 = true,			
				g36 = true,	
				flint = true,
				tecci = true,		
				tkb = true,
			}
			
			local pick_up = pickups._155

			for id, status in pairs(ARs_155) do
				if self[id] then
					self[id].stats.damage = 155
					self[id].AMMO_PICKUP = {(pick_up * 0.9),(pick_up * 1.1)}
				end
			end
			
			self.corgi.NR_CLIPS_MAX = 5
			self.corgi.AMMO_MAX = self.corgi.CLIP_AMMO_MAX * self.corgi.NR_CLIPS_MAX
			self.corgi.auto = {fire_rate = 60/875}
			self.corgi.fire_mode_data = {fire_rate = 60/875}
			self.corgi.stats.recoil = 15
			self.corgi.stats.spread = 19
			self.corgi.stats.concealment = 19
			
			self.s552.NR_CLIPS_MAX = 7
			self.s552.AMMO_MAX = self.s552.CLIP_AMMO_MAX * self.s552.NR_CLIPS_MAX
			self.s552.stats.recoil = 15
			self.s552.stats.spread = 11
			self.s552.fire_mode_data = {fire_rate = 60/700}
			self.s552.auto = {fire_rate = 60/700}
			self.s552.stats.reload = 15
			
			self.new_m4.stats.recoil = 9
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
			self.g36.stats.spread = 9
			self.g36.AMMO_MAX = self.g36.CLIP_AMMO_MAX * self.g36.NR_CLIPS_MAX
			self.g36.stats.recoil = 22
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
			
			self.tecci.stats.recoil = 19
			self.tecci.stats.spread = 6
			self.tecci.NR_CLIPS_MAX = 2
			self.tecci.AMMO_MAX = self.tecci.CLIP_AMMO_MAX * self.tecci.NR_CLIPS_MAX
			self.tecci.fire_mode_data = {fire_rate = 60/666}
			self.tecci.auto = {fire_rate = 60/666}
			
			self.tkb.NR_CLIPS_MAX = 2
			self.tkb.AMMO_MAX = self.tkb.CLIP_AMMO_MAX * self.tkb.NR_CLIPS_MAX
			self.tkb.stats.spread = 6
			self.tkb.stats.reload = 9
			self.tkb.stats.concealment = 12
			self.tkb.fire_mode_data.volley.spread_mul = 2
			self.tkb.fire_mode_data.volley.damage_mul = 1
			self.tkb.has_description = true
		
		end
		init_medium()
		
		-- 3-4 headshot kill
		local function init_light()
			
			local ARs_120 = {
				famas = true,
				ak5 = true,
				aug = true,
				komodo = true,
				m16 = true
			}
			
			local pick_up = pickups._125

			for id, status in pairs(ARs_120) do
				if self[id] then
					self[id].stats.damage = 125
					self[id].AMMO_PICKUP = {(pick_up * 0.9),(pick_up * 1.1)}
				end
			end	
			
			self.famas.NR_CLIPS_MAX = 8
			self.famas.AMMO_MAX = self.famas.CLIP_AMMO_MAX * self.famas.NR_CLIPS_MAX
			self.famas.stats.recoil = 19
			self.famas.stats.spread = 6
		
			self.ak5.NR_CLIPS_MAX = 7
			self.ak5.AMMO_MAX = self.ak5.CLIP_AMMO_MAX * self.ak5.NR_CLIPS_MAX
			self.ak5.fire_mode_data = {fire_rate = 60/680}
			self.ak5.auto = {fire_rate = 60/680}
			self.ak5.stats.recoil = 14
			self.ak5.stats.spread = 16	

			self.aug.stats.recoil = 18
			self.aug.stats.spread = 18
			self.aug.fire_mode_data = {fire_rate = 60/730}
			self.aug.auto = {fire_rate = 60/730}
			self.aug.NR_CLIPS_MAX = 6
			self.aug.AMMO_MAX = self.aug.CLIP_AMMO_MAX * self.aug.NR_CLIPS_MAX
			
			self.komodo.fire_mode_data = {fire_rate = 60/850}
			self.komodo.auto = {fire_rate = 60/850}
			self.komodo.stats.recoil = 16
			self.komodo.stats.spread = 16
			self.komodo.NR_CLIPS_MAX = 6
			self.komodo.AMMO_MAX = self.komodo.CLIP_AMMO_MAX * self.komodo.NR_CLIPS_MAX
			if self.komodo.timers.reload_empty == 3.35 then
				self.komodo.timers.reload_not_empty = 2.2
				self.komodo.timers.reload_empty = 3.1
			end
			
			self.m16.NR_CLIPS_MAX = 7
			self.m16.AMMO_MAX = self.m16.CLIP_AMMO_MAX * self.m16.NR_CLIPS_MAX
			self.m16.stats.recoil = 1
			self.m16.stats.spread = 22
			self.m16.fire_mode_data = {fire_rate = 60/900}
			self.m16.auto = {fire_rate = 60/900}
		
		end
		init_light()
		
	end
	setARs()
	
	-- Shotguns --
	local function setSHOTGUNs()
		
		local pickups = G_W_M.ammo_pickups.SHOTGUNs
		
		-- Double barrel
		local function init_DB()
			
			local DB_shotguns = {
				huntsman = true,
				b682 = true,
				coach = "secondary"
			}
			
			local pick_up = pickups._900

			for id, status in pairs(DB_shotguns) do
				if self[id] then
					self[id].stats.damage = 900
					self[id].stats.recoil = 14
					self[id].stats.spread = 21
					self[id].rays = 10
					Gilza.shotgun_minimal_damage_multipliers[id] = 1
					if status == "secondary" then
						self[id].AMMO_PICKUP = {((pick_up * 0.9)) * secondary_mul,((pick_up * 1.1)) * secondary_mul}
					else
						self[id].AMMO_PICKUP = {(pick_up * 0.9),(pick_up * 1.1)}
					end
					self[id].damage_falloff = G_W_M.damage_dropoff.SHOTGUNs._900
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
			
			local pick_up = pickups._450

			for id, status in pairs(PA_shotguns) do
				if self[id] then
					self[id].stats.damage = 450
					self[id].rays = 10
					Gilza.shotgun_minimal_damage_multipliers[id] = 0.8
					if status == "secondary" then
						self[id].AMMO_PICKUP = {((pick_up * 0.9)) * secondary_mul,((pick_up * 1.1)) * secondary_mul}
					else
						self[id].AMMO_PICKUP = {(pick_up * 0.9),(pick_up * 1.1)}
					end
					self[id].damage_falloff = G_W_M.damage_dropoff.SHOTGUNs._450
				end
			end	
			
			self.boot.NR_CLIPS_MAX = 5
			self.boot.AMMO_MAX = self.boot.CLIP_AMMO_MAX * self.boot.NR_CLIPS_MAX
			self.boot.stats.recoil = 20
			self.boot.stats.spread = 15
			self.boot.fire_mode_data = {fire_rate = 60/90}
			self.boot.single = {fire_rate = 60/90}
			
			self.r870.NR_CLIPS_MAX = 6
			self.r870.AMMO_MAX = self.r870.CLIP_AMMO_MAX * self.r870.NR_CLIPS_MAX
			self.r870.stats.recoil = 11
			self.r870.stats.spread = 17
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
			self.ksg.stats.spread = 17
			self.ksg.fire_mode_data = {fire_rate = 60/105}
			self.ksg.single = {fire_rate = 60/105}
			
			self.m1897.CLIP_AMMO_MAX = 7
			self.m1897.NR_CLIPS_MAX = 5
			self.m1897.AMMO_MAX = self.m1897.CLIP_AMMO_MAX * self.m1897.NR_CLIPS_MAX
			self.m1897.stats.recoil = 19
			self.m1897.stats.spread = 15
			self.m1897.stats.reload = 14
			self.m1897.stats.concealment = 15
			self.m1897.fire_mode_data = {fire_rate = 60/95}
			self.m1897.single = {fire_rate = 60/95}	
			
			self.supernova.CLIP_AMMO_MAX = 6
			self.supernova.NR_CLIPS_MAX = 5
			self.supernova.AMMO_MAX = self.supernova.CLIP_AMMO_MAX * self.supernova.NR_CLIPS_MAX
			self.supernova.stats.spread = 13
			self.supernova.stats.recoil = 4
			self.supernova.fire_mode_data = {fire_rate = 60/70}
			self.supernova.single = {fire_rate = 60/70}
			self.supernova.alt_fire_data.fire_rate = 60/175
			self.supernova.alt_fire_data.spread_mul = 3
			self.supernova.alt_fire_data.damage_mul = 1
			self.supernova.alt_fire_data.recoil_mul = 1.5
			self.supernova.has_description = true
			
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
			self.m37.fire_mode_data = {fire_rate = 60/120}
			self.m37.single = {fire_rate = 60/120}
		
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
			
			local pick_up = pickups._325

			for id, status in pairs(SA_shotguns) do
				if self[id] then
					self[id].stats.damage = 325
					self[id].rays = 10
					Gilza.shotgun_minimal_damage_multipliers[id] = 0.67
					self[id].fire_mode_data = {fire_rate = 60/250}
					self[id].single = {fire_rate = 60/250}
					if status == "secondary" then
						self[id].AMMO_PICKUP = {(pick_up * 0.9) * secondary_mul,(pick_up * 1.1) * secondary_mul}
					else
						self[id].AMMO_PICKUP = {(pick_up * 0.9),(pick_up * 1.1)}
					end
					if status == "akimbo" then
						self[id].stats.damage = math.ceil(self[id].stats.damage/2)
						self[id].AMMO_PICKUP[1] = self[id].AMMO_PICKUP[1] * 2
						self[id].AMMO_PICKUP[2] = self[id].AMMO_PICKUP[2] * 2
					end
					self[id].damage_falloff = G_W_M.damage_dropoff.SHOTGUNs._325
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
			self.benelli.stats.suppression = 5
			
			self.striker.NR_CLIPS_MAX = 2.5
			self.striker.AMMO_MAX = self.striker.CLIP_AMMO_MAX * self.striker.NR_CLIPS_MAX
			self.striker.stats.recoil = 11
			self.striker.stats.reload = 13
			self.striker.stats.spread = 10
			self.striker.fire_mode_data = {fire_rate = 60/280}
			self.striker.single = {fire_rate = 60/280}
			
			self.ultima.NR_CLIPS_MAX = 4
			self.ultima.AMMO_MAX = self.ultima.CLIP_AMMO_MAX * self.ultima.NR_CLIPS_MAX
			self.ultima.stats.recoil = 7
			self.ultima.stats.spread = 16
			self.ultima.fire_mode_data = {fire_rate = 60/265}
			self.ultima.single = {fire_rate = 60/265}
			
			self.judge.NR_CLIPS_MAX = 4
			self.judge.AMMO_MAX = self.judge.CLIP_AMMO_MAX * self.judge.NR_CLIPS_MAX
			self.judge.stats.recoil = 7
			self.judge.stats.spread = 1
			self.judge.stats.reload = 9
			self.judge.fire_mode_data = {fire_rate = 60/210}
			self.judge.single = {fire_rate = self.judge.fire_mode_data.fire_rate}
			
			self.x_judge.NR_CLIPS_MAX = 6
			self.x_judge.AMMO_MAX = self.x_judge.CLIP_AMMO_MAX * self.x_judge.NR_CLIPS_MAX
			self.x_judge.stats.recoil = 7
			self.x_judge.stats.spread = 1
			self.x_judge.fire_mode_data = {fire_rate = self.judge.fire_mode_data.fire_rate / akimbo_rof_mul}
			self.x_judge.single = {fire_rate = self.judge.fire_mode_data.fire_rate / akimbo_rof_mul}
			self.x_judge.auto = {fire_rate = self.judge.fire_mode_data.fire_rate / akimbo_rof_mul}
			self.x_judge.stats.reload = 13
			
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
			
			local pick_up = pickups._160

			for id, status in pairs(FA_shotguns) do
				if self[id] then
					self[id].stats.damage = 160
					self[id].rays = 10
					Gilza.shotgun_minimal_damage_multipliers[id] = 0.5
					self[id].fire_mode_data = {fire_rate = 60/350}
					self[id].single = {fire_rate = 60/350}
					if status == "secondary" then
						self[id].AMMO_PICKUP = {(pick_up * 0.9) * secondary_mul,(pick_up * 1.1) * secondary_mul}
					else
						self[id].AMMO_PICKUP = {(pick_up * 0.9),(pick_up * 1.1)}
					end
					if status == "akimbo" then
						self[id].stats.damage = math.ceil(self[id].stats.damage/2)
						self[id].AMMO_PICKUP[1] = self[id].AMMO_PICKUP[1] * 2
						self[id].AMMO_PICKUP[2] = self[id].AMMO_PICKUP[2] * 2
					end
					self[id].damage_falloff = G_W_M.damage_dropoff.SHOTGUNs._160
				end
			end
			
			self.saiga.NR_CLIPS_MAX = 9
			self.saiga.AMMO_MAX = self.saiga.CLIP_AMMO_MAX * self.saiga.NR_CLIPS_MAX
			self.saiga.stats.recoil = 11
			self.saiga.stats.spread = 6
			self.saiga.fire_mode_data = {fire_rate = 60/330}
			self.saiga.single = {fire_rate = self.saiga.fire_mode_data.fire_rate}
			
			self.aa12.NR_CLIPS_MAX = 9
			self.aa12.AMMO_MAX = self.aa12.CLIP_AMMO_MAX * self.aa12.NR_CLIPS_MAX
			self.aa12.stats.recoil = 9
			self.aa12.stats.spread = 9
			self.aa12.stats.reload = 15
			self.aa12.stats.concealment = 20
			self.aa12.fire_mode_data = {fire_rate = 60/415}
			self.aa12.single = {fire_rate = self.aa12.fire_mode_data.fire_rate}
			
			self.sko12.NR_CLIPS_MAX = 2.5
			self.sko12.AMMO_MAX = self.sko12.CLIP_AMMO_MAX * self.sko12.NR_CLIPS_MAX
			self.sko12.stats.recoil = 12
			self.sko12.stats.spread = 7
			self.sko12.fire_mode_data = {fire_rate = 60/375}
			self.sko12.single = {fire_rate = self.sko12.fire_mode_data.fire_rate}
			self.sko12.stats.reload = 9
			
			self.x_sko12.NR_CLIPS_MAX = 5
			self.x_sko12.AMMO_MAX = self.x_sko12.CLIP_AMMO_MAX * self.x_sko12.NR_CLIPS_MAX
			self.x_sko12.stats.recoil = 12
			self.x_sko12.stats.reload = 13
			self.x_sko12.stats.spread = 7
			self.x_sko12.fire_mode_data = {fire_rate = self.sko12.fire_mode_data.fire_rate / akimbo_rof_mul}
			self.x_sko12.single = {fire_rate = self.sko12.fire_mode_data.fire_rate / akimbo_rof_mul}
			self.x_sko12.auto = {fire_rate = self.sko12.fire_mode_data.fire_rate / akimbo_rof_mul}
			
			self.rota.NR_CLIPS_MAX = 9
			self.rota.AMMO_MAX = self.rota.CLIP_AMMO_MAX * self.rota.NR_CLIPS_MAX
			self.rota.stats.recoil = 14
			self.rota.stats.spread = 20
			self.rota.stats.reload = 18
			self.rota.fire_mode_data = {fire_rate = 60/335}
			self.rota.single = {fire_rate = self.rota.fire_mode_data.fire_rate}
			
			self.x_rota.NR_CLIPS_MAX = 8.5
			self.x_rota.AMMO_MAX = self.x_rota.CLIP_AMMO_MAX * self.x_rota.NR_CLIPS_MAX
			self.x_rota.stats.recoil = 14
			self.x_rota.stats.spread = 20
			self.x_rota.stats.reload = 16
			self.x_rota.fire_mode_data = {fire_rate = self.rota.fire_mode_data.fire_rate / akimbo_rof_mul}
			self.x_rota.single = {fire_rate = self.rota.fire_mode_data.fire_rate / akimbo_rof_mul}
			self.x_rota.auto = {fire_rate = self.rota.fire_mode_data.fire_rate / akimbo_rof_mul}
			
			self.basset.CLIP_AMMO_MAX = 6
			self.basset.NR_CLIPS_MAX = 8
			self.basset.AMMO_MAX = self.basset.CLIP_AMMO_MAX * self.basset.NR_CLIPS_MAX
			self.basset.stats.recoil = 16
			self.basset.stats.spread = 4
			
			self.x_basset.CLIP_AMMO_MAX = 12
			self.x_basset.NR_CLIPS_MAX = 8
			self.x_basset.AMMO_MAX = self.x_basset.CLIP_AMMO_MAX * self.x_basset.NR_CLIPS_MAX
			self.x_basset.stats.recoil = 16
			self.x_basset.stats.spread = 4
			self.x_basset.stats.reload = 14
			self.x_basset.fire_mode_data = {fire_rate = self.basset.fire_mode_data.fire_rate / akimbo_rof_mul}
			self.x_basset.single = {fire_rate = self.basset.fire_mode_data.fire_rate / akimbo_rof_mul}
			self.x_basset.auto = {fire_rate = self.basset.fire_mode_data.fire_rate / akimbo_rof_mul}
			
		end
		init_FA()
		
	end
	setSHOTGUNs()
	
	-- Light Machine Guns --
	local function setLMGs()
		
		local pickups = G_W_M.ammo_pickups.LMGs
		local new_lmg_damage_falloff = G_W_M.damage_dropoff.LMGs
		
		-- NO BIPOD --
		self.hk51b.stats.damage = 200
		self.hk51b.stats.spread = 11
		self.hk51b.stats.recoil = 10
		self.hk51b.NR_CLIPS_MAX = 3
		self.hk51b.AMMO_MAX = self.hk51b.CLIP_AMMO_MAX * self.hk51b.NR_CLIPS_MAX
		self.hk51b.AMMO_PICKUP = {(pickups._200_bipodless * 0.9),(pickups._200_bipodless * 1.1)}
		self.hk51b.damage_falloff = deep_clone(new_lmg_damage_falloff)
		self.hk51b.damage_falloff.far_multiplier = 1
		self.hk51b.damage_falloff.near_multiplier = 1
		
		self.hcar.stats.damage = 250
		self.hcar.NR_CLIPS_MAX = 8
		self.hcar.AMMO_MAX = self.hcar.CLIP_AMMO_MAX * self.hcar.NR_CLIPS_MAX
		self.hcar.AMMO_PICKUP = {(pickups._250_bipodless * 0.9),(pickups._250_bipodless * 1.1)}
		self.hcar.damage_falloff = deep_clone(new_lmg_damage_falloff)
		self.hcar.damage_falloff.far_multiplier = 1
		self.hcar.damage_falloff.near_multiplier = 1
		
		self.kacchainsaw.stats.damage = 125
		self.kacchainsaw.stats.recoil = 13
		self.kacchainsaw.NR_CLIPS_MAX = 350/150
		self.kacchainsaw.AMMO_MAX = self.kacchainsaw.CLIP_AMMO_MAX * self.kacchainsaw.NR_CLIPS_MAX
		self.kacchainsaw.AMMO_PICKUP = {(pickups._125_bipodless * 0.9),(pickups._125_bipodless * 1.1)}
		self.kacchainsaw.damage_falloff = deep_clone(new_lmg_damage_falloff)
		self.kacchainsaw.damage_falloff.far_multiplier = 1
		self.kacchainsaw.damage_falloff.near_multiplier = 1
		self.kacchainsaw_flamethrower.CLIP_AMMO_MAX = 150
		self.kacchainsaw_flamethrower.NR_CLIPS_MAX = 250/150
		self.kacchainsaw_flamethrower.AMMO_MAX = self.kacchainsaw_flamethrower.CLIP_AMMO_MAX * self.kacchainsaw_flamethrower.NR_CLIPS_MAX
		self.kacchainsaw_flamethrower.AMMO_PICKUP = {8.1,9.9}
		self.kacchainsaw_flamethrower.stats.damage = 25
		
		-- HEAVY --
		self.hk21.AMMO_PICKUP = {(pickups._250 * 0.9),(pickups._250 * 1.1)}
		self.hk21.AMMO_MAX = 400
		self.hk21.NR_CLIPS_MAX = self.hk21.AMMO_MAX / self.hk21.CLIP_AMMO_MAX
		self.hk21.stats.spread = 10
		self.hk21.stats.recoil = 12
		self.hk21.damage_falloff = deep_clone(new_lmg_damage_falloff)
		self.hk21.stats.damage = 250
		self.rpk.AMMO_PICKUP = {(pickups._250 * 0.9),(pickups._250 * 1.1)}
		self.rpk.NR_CLIPS_MAX = 4
		self.rpk.AMMO_MAX = self.rpk.CLIP_AMMO_MAX * self.rpk.NR_CLIPS_MAX
		self.rpk.stats.spread = 5
		self.rpk.stats.suppression = 5
		self.rpk.stats.recoil = 13
		self.rpk.damage_falloff = deep_clone(new_lmg_damage_falloff)
		self.rpk.stats.damage = 250
		
		self.m60.stats.damage = 325
		self.m60.AMMO_PICKUP = {(pickups._325 * 0.9),(pickups._325 * 1.1)}
		self.m60.AMMO_MAX = 350
		self.m60.NR_CLIPS_MAX = self.m60.AMMO_MAX / self.m60.CLIP_AMMO_MAX
		self.m60.stats.spread = 10
		self.m60.stats.recoil = 10
		self.m60.damage_falloff = deep_clone(new_lmg_damage_falloff)
		self.m60.fire_mode_data = {fire_rate = 60/420}
		self.m60.auto = {fire_rate = 60/420}
		
		-- LIGHT --
		self.m249.AMMO_PICKUP = {(pickups._155 * 0.9),(pickups._155 * 1.1)}
		self.m249.NR_CLIPS_MAX = 2.5
		self.m249.AMMO_MAX = self.m249.CLIP_AMMO_MAX * self.m249.NR_CLIPS_MAX
		self.m249.stats.spread = 8
		self.m249.stats.recoil = 10
		self.m249.damage_falloff = deep_clone(new_lmg_damage_falloff)
		self.m249.stats.damage = 155
		self.par.AMMO_PICKUP = {(pickups._155 * 0.9),(pickups._155 * 1.1)}
		self.par.NR_CLIPS_MAX = 2.5
		self.par.AMMO_MAX = self.par.CLIP_AMMO_MAX * self.par.NR_CLIPS_MAX
		self.par.stats.spread = 9
		self.par.stats.recoil = 16
		self.par.damage_falloff = deep_clone(new_lmg_damage_falloff)
		self.par.stats.damage = 155
		
		-- SUPER LIGHT --
		self.mg42.stats.damage = 125
		self.mg42.AMMO_PICKUP = {(pickups._125 * 0.9),(pickups._125 * 1.1)}
		self.mg42.CLIP_AMMO_MAX = 100
		self.mg42.NR_CLIPS_MAX = 6
		self.mg42.AMMO_MAX = self.mg42.CLIP_AMMO_MAX * self.mg42.NR_CLIPS_MAX
		self.mg42.stats.spread = 7
		self.mg42.stats.reload = 15
		self.mg42.stats.recoil = 15
		self.mg42.damage_falloff = deep_clone(new_lmg_damage_falloff)
	end
	setLMGs()
	
	-- Snipers --
	local function setSNIPERs()
		
		local pickups = G_W_M.ammo_pickups.SNIPERs
		
		local new_sniper_damage_falloff = G_W_M.damage_dropoff.SNIPERs
		
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
					self[id].stats.concealment = self[id].stats.concealment - 1
					if status == "secondary" then
						self[id].AMMO_PICKUP = {((pickups._650 * 0.9)) * secondary_mul,((pickups._650 * 1.1)) * secondary_mul}
					else
						self[id].AMMO_PICKUP = {(pickups._650 * 0.9),(pickups._650 * 1.1)}
					end
					self[id].fire_mode_data = {fire_rate = 60/210}
					self[id].single = {fire_rate = 60/210}
					self[id].damage_falloff = new_sniper_damage_falloff
					self[id].AMMO_MAX = 40
					self[id].NR_CLIPS_MAX = self[id].AMMO_MAX / self[id].CLIP_AMMO_MAX
				end
			end	
			
			self.qbu88.stats.recoil = 13
			self.qbu88.stats.spread = 17
			self.qbu88.fire_mode_data = {fire_rate = 60/270}
			self.qbu88.single = {fire_rate = 60/270}
			
			self.wa2000.stats.recoil = 23
			self.wa2000.stats.spread = 18
			self.wa2000.stats.concealment = 10
			self.wa2000.fire_mode_data = {fire_rate = 60/240}
			self.wa2000.single = {fire_rate = 60/240}
			
			self.tti.stats.recoil = 10
			self.tti.stats.spread = 12
			
			self.siltstone.stats.recoil = 11
			self.siltstone.stats.spread = 22
			self.siltstone.stats.reload = 14
			
			if self.victor.timers.reload_empty == 3 then
				self.victor.timers.reload_empty = 2.75
			end
			self.victor.stats.reload = 14
			self.victor.stats.spread = 16
			self.victor.stats.recoil = 8
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
					self[id].stats.concealment = self[id].stats.concealment - 1
					if status == "secondary" then
						self[id].AMMO_PICKUP = {((pickups._950 * 0.9)) * secondary_mul,((pickups._950 * 1.1)) * secondary_mul}
					else
						self[id].AMMO_PICKUP = {(pickups._950 * 0.9),(pickups._950 * 1.1)}
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
			self.winchester1874.stats.concealment = self.winchester1874.stats.concealment + 1 -- since it starts scopeless, dont adjust it
			
			self.scout.stats.spread = 19
			self.scout.fire_mode_data = {fire_rate = 60/70}
			self.scout.single = {fire_rate = 60/70}
			self.scout.stats.reload = 14
			
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
					self[id].stats.concealment = self[id].stats.concealment - 1
					if status == "secondary" then
						self[id].AMMO_PICKUP = {((pickups._1300 * 0.9)) * secondary_mul,((pickups._1300 * 1.1)) * secondary_mul}
					else
						self[id].AMMO_PICKUP = {(pickups._1300 * 0.9),(pickups._1300 * 1.1)}
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
			self.contender.NR_CLIPS_MAX = 13
			self.contender.AMMO_MAX = self.contender.CLIP_AMMO_MAX * self.contender.NR_CLIPS_MAX
			self.contender.rays = 1
			self.contender.stats.recoil = 14
			self.contender.stats.spread = 18
			self.contender.stats.reload = 15
			
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
					self[id].stats.concealment = self[id].stats.concealment - 1
					self[id].AMMO_PICKUP = {(pickups._1600 * 0.9),(pickups._1600 * 1.1)}
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
			self.r93.stats.spread = 20
			self.r93.NR_CLIPS_MAX = 3.35
			self.r93.AMMO_MAX = self.r93.CLIP_AMMO_MAX * self.r93.NR_CLIPS_MAX
			self.r93.stats.reload = 8
			
			self.mosin.stats.recoil = 7
			self.mosin.stats.spread = 24	
			self.mosin.stats.reload = 12
			
		end
		init_bolt_heavy()

		-- 50 cal
		self.m95.stats.damage = 6500
		self.m95.AMMO_PICKUP = {(pickups._50cal * 0.8),(pickups._50cal * 1.2)}
		self.m95.damage_falloff = new_sniper_damage_falloff
		self.m95.stats_modifiers = {damage = 1}
		
		-- Musket. Mwahahahaha
		self.bessy.stats.damage = 12000
		self.bessy.AMMO_PICKUP = {((pickups._50cal * 0.5) * 0.8),((pickups._50cal * 0.5) * 1.2)}
		self.bessy.damage_falloff = new_sniper_damage_falloff
		self.bessy.stats_modifiers = {damage = 1}
		
	end
	setSNIPERs()
	
	-- Sub machine guns --
	local function setSMGs()
		
		local pickups = G_W_M.ammo_pickups.SMGs
		local new_smg_damage_falloff = G_W_M.damage_dropoff.SMGs
		
		-- 1-2 headshot kill
		local function init_heavy()
			
			local SMGs_250 = {
				m45 = true,
				hajk = true,
				erma = true,
				sterling = true
			}
			
			local pick_up = pickups._250

			for id, status in pairs(SMGs_250) do
				if self[id] then
					self[id].stats.damage = 250
					self[id].AMMO_PICKUP = {((pick_up * 0.9)) * secondary_mul,((pick_up * 1.1)) * secondary_mul}
					self[id].damage_falloff = new_smg_damage_falloff
				end
			end
			
			self.m45.stats.reload = 14
			self.m45.stats.recoil = 13
			self.m45.stats.spread = 21
			self.m45.CLIP_AMMO_MAX = 36
			self.m45.NR_CLIPS_MAX = 3
			self.m45.AMMO_MAX = self.m45.CLIP_AMMO_MAX * self.m45.NR_CLIPS_MAX
			
			self.hajk.stats.recoil = 17
			self.hajk.stats.spread = 15
			self.hajk.NR_CLIPS_MAX = 3
			self.hajk.AMMO_MAX = self.hajk.CLIP_AMMO_MAX * self.hajk.NR_CLIPS_MAX
			self.hajk.fire_mode_data = {fire_rate = 60/775}
			self.hajk.auto = {fire_rate = self.hajk.fire_mode_data.fire_rate}
			
			self.erma.stats.recoil = 21
			self.erma.stats.spread = 13
			self.erma.NR_CLIPS_MAX = 3.5
			self.erma.CLIP_AMMO_MAX = 32
			self.erma.AMMO_MAX = self.erma.CLIP_AMMO_MAX * self.erma.NR_CLIPS_MAX
			self.erma.fire_mode_data = {fire_rate = 60/650}
			self.erma.auto = {fire_rate = self.erma.fire_mode_data.fire_rate}
			
			self.sterling.stats.spread = 18
			self.sterling.stats.recoil = 17
			self.sterling.stats.reload = 10
			self.sterling.fire_mode_data = {fire_rate = 60/550}
			self.sterling.auto = {fire_rate = self.sterling.fire_mode_data.fire_rate}
			self.sterling.NR_CLIPS_MAX = 4
			self.sterling.CLIP_AMMO_MAX = 28
			self.sterling.AMMO_MAX = self.sterling.CLIP_AMMO_MAX * self.sterling.NR_CLIPS_MAX
			
			-- akimbos
			self.x_m45.stats.recoil = 13
			self.x_m45.stats.reload = 12
			self.x_m45.stats.spread = 21
			self.x_m45.CLIP_AMMO_MAX = 72
			self.x_m45.NR_CLIPS_MAX = 2.25
			self.x_m45.AMMO_MAX = self.x_m45.CLIP_AMMO_MAX * self.x_m45.NR_CLIPS_MAX
			
			self.x_hajk.stats.recoil = 17
			self.x_hajk.stats.spread = 15
			self.x_hajk.stats.reload = 13
			self.x_hajk.NR_CLIPS_MAX = 2.25
			self.x_hajk.AMMO_MAX = self.x_hajk.CLIP_AMMO_MAX * self.x_hajk.NR_CLIPS_MAX
			self.x_hajk.fire_mode_data = {fire_rate = self.hajk.fire_mode_data.fire_rate}
			self.x_hajk.single = {fire_rate = self.hajk.fire_mode_data.fire_rate}
			
			self.x_erma.stats.recoil = 21
			self.x_erma.stats.spread = 13
			self.x_erma.stats.reload = 13
			self.x_erma.NR_CLIPS_MAX = 2.625
			self.x_erma.CLIP_AMMO_MAX = 64
			self.x_erma.AMMO_MAX = self.x_erma.CLIP_AMMO_MAX * self.x_erma.NR_CLIPS_MAX
			self.x_erma.fire_mode_data = {fire_rate = self.erma.fire_mode_data.fire_rate}
			self.x_erma.auto = {fire_rate = self.erma.fire_mode_data.fire_rate}
			
			self.x_sterling.stats.spread = 18
			self.x_sterling.stats.recoil = 17
			self.x_sterling.stats.reload = 12
			self.x_sterling.fire_mode_data = {fire_rate = self.sterling.fire_mode_data.fire_rate}
			self.x_sterling.single = {fire_rate = self.sterling.fire_mode_data.fire_rate}
			self.x_sterling.CLIP_AMMO_MAX = 56
			self.x_sterling.NR_CLIPS_MAX = 3
			self.x_sterling.AMMO_MAX = self.x_sterling.NR_CLIPS_MAX * self.x_sterling.CLIP_AMMO_MAX
			
			for id, status in pairs(SMGs_250) do
				if self["x_"..id] then
					self["x_"..id].stats.damage = math.ceil(250/2)
					self["x_"..id].AMMO_PICKUP[1] = self[id].AMMO_PICKUP[1] * secondary_to_primary_mul * 2
					self["x_"..id].AMMO_PICKUP[2] = self[id].AMMO_PICKUP[2] * secondary_to_primary_mul * 2
					self["x_"..id].damage_falloff = new_smg_damage_falloff
					if self["x_"..id].fire_mode_data then
						self["x_"..id].fire_mode_data.fire_rate = self["x_"..id].fire_mode_data.fire_rate / akimbo_rof_mul
					end
					if self["x_"..id].single then
						self["x_"..id].single.fire_rate = self["x_"..id].single.fire_rate / akimbo_rof_mul
					end
					if self["x_"..id].auto then
						self["x_"..id].auto.fire_rate = self["x_"..id].auto.fire_rate / akimbo_rof_mul
					end
				end
			end
			
		end
		init_heavy()
		
		-- 2-3 headshot kill - extra damage
		local function init_medium_heavy()
			
			local SMGs_200 = {
				olympic = true,
				schakal = true,
				sr2 = true,
				coal = true,
				uzi = true			
			}
			
			local pick_up = pickups._200

			for id, status in pairs(SMGs_200) do
				if self[id] then
					self[id].stats.damage = 200
					self[id].AMMO_PICKUP = {((pick_up * 0.9)) * secondary_mul,((pick_up * 1.1)) * secondary_mul}
					self[id].damage_falloff = new_smg_damage_falloff
				end
			end
			
			self.olympic.stats.spread = 10
			self.olympic.stats.recoil = 13
			self.olympic.NR_CLIPS_MAX = 6
			self.olympic.AMMO_MAX = self.olympic.CLIP_AMMO_MAX * self.olympic.NR_CLIPS_MAX
			self.olympic.fire_mode_data = {fire_rate = 60/710}
			self.olympic.auto = {fire_rate = self.olympic.fire_mode_data.fire_rate}
			
			self.schakal.stats.spread = 16
			self.schakal.stats.recoil = 16
			self.schakal.CLIP_AMMO_MAX = 25
			self.schakal.NR_CLIPS_MAX = 6
			self.schakal.AMMO_MAX = self.schakal.CLIP_AMMO_MAX * self.schakal.NR_CLIPS_MAX
			self.schakal.fire_mode_data = {fire_rate = 60/690}
			self.schakal.auto = {fire_rate = self.schakal.fire_mode_data.fire_rate}
			
			self.sr2.stats.spread = 11
			self.sr2.stats.recoil = 20
			self.sr2.CLIP_AMMO_MAX = 30
			self.sr2.NR_CLIPS_MAX = 5
			self.sr2.AMMO_MAX = self.sr2.CLIP_AMMO_MAX * self.sr2.NR_CLIPS_MAX
			self.sr2.fire_mode_data = {fire_rate = 60/950}
			self.sr2.auto = {fire_rate = self.sr2.fire_mode_data.fire_rate}
			
			self.coal.NR_CLIPS_MAX = 2
			self.coal.AMMO_MAX = self.coal.CLIP_AMMO_MAX * self.coal.NR_CLIPS_MAX
			self.coal.stats.reload = 9
			self.coal.stats.recoil = 16
			self.coal.stats.spread = 13
			self.coal.fire_mode_data = {fire_rate = 60/700}
			self.coal.auto = {fire_rate = self.coal.fire_mode_data.fire_rate}
			
			self.uzi.stats.spread = 22
			self.uzi.stats.recoil = 12
			self.uzi.CLIP_AMMO_MAX = 32
			self.uzi.NR_CLIPS_MAX = 4.5
			self.uzi.AMMO_MAX = self.uzi.CLIP_AMMO_MAX * self.uzi.NR_CLIPS_MAX
			self.uzi.fire_mode_data = {fire_rate = 60/625}
			self.uzi.auto = {fire_rate = self.uzi.fire_mode_data.fire_rate}
			
			-- akimbos
			self.x_olympic.stats.spread = 10
			self.x_olympic.stats.recoil = 13
			self.x_olympic.stats.reload = 13
			self.x_olympic.NR_CLIPS_MAX = 4.5
			self.x_olympic.AMMO_MAX = self.x_olympic.CLIP_AMMO_MAX * self.x_olympic.NR_CLIPS_MAX
			self.x_olympic.fire_mode_data = {fire_rate = self.olympic.fire_mode_data.fire_rate}
			self.x_olympic.single = {fire_rate = self.olympic.fire_mode_data.fire_rate}
			
			self.x_schakal.stats.spread = 18
			self.x_schakal.stats.recoil = 18
			self.x_schakal.CLIP_AMMO_MAX = 50
			self.x_schakal.NR_CLIPS_MAX = 4.5
			self.x_schakal.AMMO_MAX = self.x_schakal.CLIP_AMMO_MAX * self.x_schakal.NR_CLIPS_MAX
			self.x_schakal.fire_mode_data = {fire_rate = self.schakal.fire_mode_data.fire_rate}
			self.x_schakal.single = {fire_rate = self.schakal.fire_mode_data.fire_rate}
			if self.x_schakal.timers.reload_not_empty == 3 then
				self.x_schakal.timers.reload_not_empty = 2.5
			end
			
			self.x_sr2.stats.spread = 11
			self.x_sr2.stats.recoil = 20
			self.x_sr2.CLIP_AMMO_MAX = 60
			self.x_sr2.NR_CLIPS_MAX = 3.75
			self.x_sr2.AMMO_MAX = self.x_sr2.CLIP_AMMO_MAX * self.x_sr2.NR_CLIPS_MAX
			self.x_sr2.fire_mode_data = {fire_rate = self.sr2.fire_mode_data.fire_rate}
			self.x_sr2.single = {fire_rate = self.sr2.fire_mode_data.fire_rate}
			self.x_sr2.stats.reload = 8
			
			self.x_coal.NR_CLIPS_MAX = 1.5
			self.x_coal.AMMO_MAX = self.x_coal.CLIP_AMMO_MAX * self.x_coal.NR_CLIPS_MAX
			self.x_coal.stats.recoil = 16
			self.x_coal.stats.reload = 9
			self.x_coal.stats.spread = 13
			self.x_coal.fire_mode_data = {fire_rate = self.coal.fire_mode_data.fire_rate}
			self.x_coal.single = {fire_rate = self.coal.fire_mode_data.fire_rate}
			
			self.x_uzi.stats.spread = 22
			self.x_uzi.stats.recoil = 12
			self.x_uzi.stats.reload = 12
			self.x_uzi.CLIP_AMMO_MAX = 64
			self.x_uzi.NR_CLIPS_MAX = 3.375
			self.x_uzi.AMMO_MAX = self.x_uzi.CLIP_AMMO_MAX * self.x_uzi.NR_CLIPS_MAX
			self.x_uzi.fire_mode_data = {fire_rate = self.uzi.fire_mode_data.fire_rate}
			self.x_uzi.single = {fire_rate = self.uzi.fire_mode_data.fire_rate}
			
			for id, status in pairs(SMGs_200) do
				if self["x_"..id] then
					self["x_"..id].stats.damage = math.ceil(200/2)
					self["x_"..id].AMMO_PICKUP[1] = self[id].AMMO_PICKUP[1] * secondary_to_primary_mul * 2
					self["x_"..id].AMMO_PICKUP[2] = self[id].AMMO_PICKUP[2] * secondary_to_primary_mul * 2
					self["x_"..id].damage_falloff = new_smg_damage_falloff
					if self["x_"..id].fire_mode_data then
						self["x_"..id].fire_mode_data.fire_rate = self["x_"..id].fire_mode_data.fire_rate / akimbo_rof_mul
					end
					if self["x_"..id].single then
						self["x_"..id].single.fire_rate = self["x_"..id].single.fire_rate / akimbo_rof_mul
					end
					if self["x_"..id].auto then
						self["x_"..id].auto.fire_rate = self["x_"..id].auto.fire_rate / akimbo_rof_mul
					end
				end
			end
			
		end
		init_medium_heavy()
		
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
			
			local pick_up = pickups._155

			for id, status in pairs(SMGs_155) do
				if self[id] then
					self[id].stats.damage = 155
					self[id].AMMO_PICKUP = {((pick_up * 0.9)) * secondary_mul,((pick_up * 1.1)) * secondary_mul}
					self[id].damage_falloff = new_smg_damage_falloff
				end
			end
			
			self.vityaz.stats.spread = 20
			self.vityaz.stats.recoil = 12
			self.vityaz.NR_CLIPS_MAX = 5
			self.vityaz.AMMO_MAX = self.vityaz.CLIP_AMMO_MAX * self.vityaz.NR_CLIPS_MAX
			self.vityaz.fire_mode_data = {fire_rate = 60/680}
			self.vityaz.auto = {fire_rate = self.vityaz.fire_mode_data.fire_rate}
			
			self.new_mp5.stats.recoil = 19
			self.new_mp5.stats.reload = 13
			self.new_mp5.stats.spread = 13
			self.new_mp5.NR_CLIPS_MAX = 5
			self.new_mp5.AMMO_MAX = self.new_mp5.CLIP_AMMO_MAX * self.new_mp5.NR_CLIPS_MAX
			self.new_mp5.fire_mode_data = {fire_rate = 60/800}
			self.new_mp5.auto = {fire_rate = self.new_mp5.fire_mode_data.fire_rate}
			
			self.m1928.stats.spread = 12
			self.m1928.stats.recoil = 22
			self.m1928.stats.reload = 12
			self.m1928.NR_CLIPS_MAX = 3
			self.m1928.AMMO_MAX = self.m1928.CLIP_AMMO_MAX * self.m1928.NR_CLIPS_MAX
			
			self.shepheard.stats.reload = 16
			self.shepheard.stats.recoil = 17
			self.shepheard.stats.spread = 14
			self.shepheard.NR_CLIPS_MAX = 7.5
			self.shepheard.AMMO_MAX = self.shepheard.CLIP_AMMO_MAX * self.shepheard.NR_CLIPS_MAX
			self.shepheard.fire_mode_data = {fire_rate = 60/850}
			self.shepheard.auto = {fire_rate = self.shepheard.fire_mode_data.fire_rate}
			
			self.akmsu.stats.recoil = 12
			self.akmsu.stats.spread = 16
			self.akmsu.NR_CLIPS_MAX = 5
			self.akmsu.AMMO_MAX = self.akmsu.CLIP_AMMO_MAX * self.akmsu.NR_CLIPS_MAX
			self.akmsu.fire_mode_data = {fire_rate = 60/700}
			self.akmsu.auto = {fire_rate = self.akmsu.fire_mode_data.fire_rate}
			
			self.tec9.stats.recoil = 18
			self.tec9.stats.spread = 14
			self.tec9.stats.reload = 14
			self.tec9.NR_CLIPS_MAX = 7.5
			self.tec9.AMMO_MAX = self.tec9.CLIP_AMMO_MAX * self.tec9.NR_CLIPS_MAX
			
			-- akimbos
			self.x_vityaz.stats.spread = 20
			self.x_vityaz.stats.recoil = 12
			self.x_vityaz.stats.reload = 12
			self.x_vityaz.NR_CLIPS_MAX = 3.75
			self.x_vityaz.AMMO_MAX = self.x_vityaz.CLIP_AMMO_MAX * self.x_vityaz.NR_CLIPS_MAX
			self.x_vityaz.fire_mode_data = {fire_rate = self.vityaz.fire_mode_data.fire_rate}
			self.x_vityaz.single = {fire_rate = self.vityaz.fire_mode_data.fire_rate}
			
			self.x_mp5.stats.damage = math.ceil(155/2)
			self.x_mp5.AMMO_PICKUP[1] = self.new_mp5.AMMO_PICKUP[1] * secondary_to_primary_mul * 2
			self.x_mp5.AMMO_PICKUP[2] = self.new_mp5.AMMO_PICKUP[2] * secondary_to_primary_mul * 2
			self.x_mp5.damage_falloff = new_smg_damage_falloff
			self.x_mp5.stats.recoil = 19
			self.x_mp5.stats.reload = 13
			self.x_mp5.stats.spread = 13
			self.x_mp5.NR_CLIPS_MAX = 3.75
			self.x_mp5.AMMO_MAX = self.x_mp5.CLIP_AMMO_MAX * self.x_mp5.NR_CLIPS_MAX
			self.x_mp5.fire_mode_data = {fire_rate = self.new_mp5.fire_mode_data.fire_rate / akimbo_rof_mul}
			self.x_mp5.single = {fire_rate = self.new_mp5.fire_mode_data.fire_rate / akimbo_rof_mul}
			
			self.x_m1928.stats.spread = 12
			self.x_m1928.stats.recoil = 22
			self.x_m1928.stats.reload = 10
			self.x_m1928.NR_CLIPS_MAX = 2.25
			self.x_m1928.AMMO_MAX = self.x_m1928.CLIP_AMMO_MAX * self.x_m1928.NR_CLIPS_MAX
			
			self.x_shepheard.stats.recoil = 17
			self.x_shepheard.stats.spread = 14
			self.x_shepheard.stats.reload = 15
			self.x_shepheard.NR_CLIPS_MAX = 5.625
			self.x_shepheard.AMMO_MAX = self.x_shepheard.CLIP_AMMO_MAX * self.x_shepheard.NR_CLIPS_MAX
			self.x_shepheard.fire_mode_data = {fire_rate = self.shepheard.fire_mode_data.fire_rate}
			self.x_shepheard.single = {fire_rate = self.shepheard.fire_mode_data.fire_rate}
			
			self.x_akmsu.stats.recoil = 12
			self.x_akmsu.stats.spread = 16
			self.x_akmsu.stats.reload = 13
			self.x_akmsu.NR_CLIPS_MAX = 3.75
			self.x_akmsu.AMMO_MAX = self.x_akmsu.CLIP_AMMO_MAX * self.x_akmsu.NR_CLIPS_MAX
			self.x_akmsu.fire_mode_data = {fire_rate = self.akmsu.fire_mode_data.fire_rate}
			self.x_akmsu.single = {fire_rate = self.akmsu.fire_mode_data.fire_rate}
			
			self.x_tec9.stats.recoil = 18
			self.x_tec9.stats.spread = 14
			self.x_tec9.stats.reload = 15
			self.x_tec9.NR_CLIPS_MAX = 5.625
			self.x_tec9.AMMO_MAX = self.x_tec9.CLIP_AMMO_MAX * self.x_tec9.NR_CLIPS_MAX
			
			for id, status in pairs(SMGs_155) do
				if self["x_"..id] then
					self["x_"..id].stats.damage = math.ceil(155/2)
					self["x_"..id].AMMO_PICKUP[1] = self[id].AMMO_PICKUP[1] * secondary_to_primary_mul * 2
					self["x_"..id].AMMO_PICKUP[2] = self[id].AMMO_PICKUP[2] * secondary_to_primary_mul * 2
					self["x_"..id].damage_falloff = new_smg_damage_falloff
					if self["x_"..id].fire_mode_data then
						self["x_"..id].fire_mode_data.fire_rate = self["x_"..id].fire_mode_data.fire_rate / akimbo_rof_mul
					end
					if self["x_"..id].single then
						self["x_"..id].single.fire_rate = self["x_"..id].single.fire_rate / akimbo_rof_mul
					end
					if self["x_"..id].auto then
						self["x_"..id].auto.fire_rate = self["x_"..id].auto.fire_rate / akimbo_rof_mul
					end
				end
			end
			
		end
		init_medium()
		
		-- 3-4 headshot kill
		local function init_light()
			
			local SMGs_120 = {
				mp7 = true,
				cobray = true,
				pm9 = true,
				mp9 = true,
				p90 = true
			}
			
			local pick_up = pickups._125
			
			for id, status in pairs(SMGs_120) do
				if self[id] then
					self[id].stats.damage = 125
					self[id].AMMO_PICKUP = {((pick_up * 0.9)) * secondary_mul,((pick_up * 1.1)) * secondary_mul}
					self[id].damage_falloff = new_smg_damage_falloff
				end
			end
			
			self.mp7.stats.spread = 20
			self.mp7.stats.recoil = 14
			self.mp7.stats.reload = 14
			self.mp7.stats.concealment = 25
			self.mp7.AMMO_MAX = 180
			self.mp7.NR_CLIPS_MAX = self.mp7.AMMO_MAX / self.mp7.CLIP_AMMO_MAX
			self.mp7.fire_mode_data = {fire_rate = 60/950}
			self.mp7.auto = {fire_rate = self.mp7.fire_mode_data.fire_rate}
			
			self.cobray.stats.spread = 15
			self.cobray.stats.recoil = 19
			self.cobray.AMMO_MAX = 184
			self.cobray.NR_CLIPS_MAX = self.cobray.AMMO_MAX / self.cobray.CLIP_AMMO_MAX
			
			self.pm9.stats.recoil = 21
			self.pm9.stats.spread = 13
			self.pm9.AMMO_MAX = 175
			self.pm9.NR_CLIPS_MAX = self.pm9.AMMO_MAX / self.pm9.CLIP_AMMO_MAX
			self.pm9.stats.reload = 14
			
			self.mp9.stats.spread = 12
			self.mp9.stats.recoil = 23
			self.mp9.stats.concealment = 27
			self.mp9.AMMO_MAX = 180
			self.mp9.NR_CLIPS_MAX = self.mp9.AMMO_MAX / self.mp9.CLIP_AMMO_MAX
			self.mp9.fire_mode_data = {fire_rate = 60/1000}
			self.mp9.auto = {fire_rate = self.mp9.fire_mode_data.fire_rate}
			
			self.p90.stats.spread = 18
			self.p90.stats.recoil = 17
			self.p90.AMMO_MAX = 175
			self.p90.NR_CLIPS_MAX = self.p90.AMMO_MAX / self.p90.CLIP_AMMO_MAX
			self.p90.fire_mode_data = {fire_rate = 60/900}
			self.p90.auto = {fire_rate = self.p90.fire_mode_data.fire_rate}
			
			-- akimbos
			self.x_mp7.stats.spread = 20
			self.x_mp7.stats.recoil = 14
			self.x_mp7.stats.reload = 16
			self.x_mp7.stats.concealment = 25
			self.x_mp7.AMMO_MAX = 270
			self.x_mp7.NR_CLIPS_MAX = self.x_mp7.AMMO_MAX / self.x_mp7.CLIP_AMMO_MAX
			self.x_mp7.fire_mode_data = {fire_rate = self.mp7.fire_mode_data.fire_rate}
			self.x_mp7.single = {fire_rate = self.mp7.fire_mode_data.fire_rate}
			
			self.x_cobray.AMMO_MAX = 276
			self.x_cobray.NR_CLIPS_MAX = self.x_cobray.AMMO_MAX / self.x_cobray.CLIP_AMMO_MAX
			self.x_cobray.stats.spread = 15
			self.x_cobray.stats.recoil = 19
			self.x_cobray.stats.reload = 12
			
			self.x_pm9.stats.recoil = 21
			self.x_pm9.stats.spread = 13
			self.x_pm9.NR_CLIPS_MAX = 5.25
			self.x_pm9.AMMO_MAX = self.x_pm9.CLIP_AMMO_MAX * self.x_pm9.NR_CLIPS_MAX
			self.x_pm9.stats.reload = 14
			
			self.x_mp9.stats.spread = 12
			self.x_mp9.stats.recoil = 23
			self.x_mp9.stats.concealment = 27
			self.x_mp9.AMMO_MAX = 270
			self.x_mp9.NR_CLIPS_MAX = self.x_mp9.AMMO_MAX / self.x_mp9.CLIP_AMMO_MAX
			self.x_mp9.fire_mode_data = {fire_rate = self.mp9.fire_mode_data.fire_rate}
			self.x_mp9.single = {fire_rate = self.mp9.fire_mode_data.fire_rate}
			
			self.x_p90.stats.spread = 18
			self.x_p90.stats.recoil = 17
			self.x_p90.NR_CLIPS_MAX = 2.625
			self.x_p90.AMMO_MAX = self.x_p90.CLIP_AMMO_MAX * self.x_p90.NR_CLIPS_MAX
			self.x_p90.fire_mode_data = {fire_rate = self.p90.fire_mode_data.fire_rate}
			self.x_p90.single = {fire_rate = self.p90.fire_mode_data.fire_rate}
			
			for id, status in pairs(SMGs_120) do
				if self["x_"..id] then
					self["x_"..id].stats.damage = math.ceil(125/2)
					self["x_"..id].AMMO_PICKUP[1] = self[id].AMMO_PICKUP[1] * secondary_to_primary_mul * 2
					self["x_"..id].AMMO_PICKUP[2] = self[id].AMMO_PICKUP[2] * secondary_to_primary_mul * 2
					self["x_"..id].damage_falloff = new_smg_damage_falloff
					if self["x_"..id].fire_mode_data then
						self["x_"..id].fire_mode_data.fire_rate = self["x_"..id].fire_mode_data.fire_rate / akimbo_rof_mul
					end
					if self["x_"..id].single then
						self["x_"..id].single.fire_rate = self["x_"..id].single.fire_rate / akimbo_rof_mul
					end
					if self["x_"..id].auto then
						self["x_"..id].auto.fire_rate = self["x_"..id].auto.fire_rate / akimbo_rof_mul
					end
				end
			end
			
		end
		init_light()
		
		-- 3-5 headshot kill
		local function init_super_light()
			
			local SMGs_95 = {
				mac10 = true,
				fmg9 = true,
				scorpion = true,
				baka = true,
				polymer = true
			}
			
			local pick_up = pickups._95
			
			for id, status in pairs(SMGs_95) do
				if self[id] then
					self[id].stats.damage = 95
					self[id].AMMO_PICKUP = {((pick_up * 0.9)) * secondary_mul,((pick_up * 1.1)) * secondary_mul}
					self[id].damage_falloff = new_smg_damage_falloff
				end
			end
			
			self.mac10.stats.spread = 15
			self.mac10.stats.recoil = 19
			self.mac10.AMMO_MAX = 200
			self.mac10.NR_CLIPS_MAX = self.mac10.AMMO_MAX / self.mac10.CLIP_AMMO_MAX
			
			self.fmg9.stats.spread = 13
			self.fmg9.stats.recoil = 20
			self.fmg9.AMMO_MAX = 210
			self.fmg9.NR_CLIPS_MAX = self.fmg9.AMMO_MAX / self.fmg9.CLIP_AMMO_MAX
			
			self.scorpion.stats.spread = 19
			self.scorpion.stats.recoil = 15
			self.scorpion.AMMO_MAX = 200
			self.scorpion.NR_CLIPS_MAX = self.scorpion.AMMO_MAX / self.scorpion.CLIP_AMMO_MAX
			
			self.baka.stats.spread = 14
			self.baka.stats.recoil = 19
			self.baka.AMMO_MAX = 208
			self.baka.NR_CLIPS_MAX = self.baka.AMMO_MAX / self.baka.CLIP_AMMO_MAX
			
			self.polymer.stats.spread = 12
			self.polymer.stats.recoil = 22
			self.polymer.AMMO_MAX = 180
			self.polymer.NR_CLIPS_MAX = self.polymer.AMMO_MAX / self.polymer.CLIP_AMMO_MAX
			
			-- akimbos
			self.x_mac10.stats.spread = 15
			self.x_mac10.stats.recoil = 19
			self.x_mac10.stats.reload = 13
			self.x_mac10.AMMO_MAX = 300
			self.x_mac10.NR_CLIPS_MAX = self.x_mac10.AMMO_MAX / self.x_mac10.CLIP_AMMO_MAX
			
			self.x_scorpion.stats.spread = 19
			self.x_scorpion.stats.recoil = 15
			self.x_scorpion.AMMO_MAX = 300
			self.x_scorpion.NR_CLIPS_MAX = self.x_scorpion.AMMO_MAX / self.x_scorpion.CLIP_AMMO_MAX
			
			self.x_baka.stats.spread = 14
			self.x_baka.stats.recoil = 19
			self.x_baka.AMMO_MAX = 312
			self.x_baka.stats.reload = 14
			self.x_baka.NR_CLIPS_MAX = self.x_baka.AMMO_MAX / self.x_baka.CLIP_AMMO_MAX
			
			self.x_polymer.stats.spread = 12
			self.x_polymer.stats.recoil = 22
			self.x_polymer.AMMO_MAX = 270
			self.x_polymer.NR_CLIPS_MAX = self.x_polymer.AMMO_MAX / self.x_polymer.CLIP_AMMO_MAX
			
			for id, status in pairs(SMGs_95) do
				if self["x_"..id] then
					self["x_"..id].stats.damage = math.ceil(95/2)
					self["x_"..id].AMMO_PICKUP[1] = self[id].AMMO_PICKUP[1] * secondary_to_primary_mul * 2
					self["x_"..id].AMMO_PICKUP[2] = self[id].AMMO_PICKUP[2] * secondary_to_primary_mul * 2
					self["x_"..id].damage_falloff = new_smg_damage_falloff
					if self["x_"..id].fire_mode_data then
						self["x_"..id].fire_mode_data.fire_rate = self["x_"..id].fire_mode_data.fire_rate / akimbo_rof_mul
					end
					if self["x_"..id].single then
						self["x_"..id].single.fire_rate = self["x_"..id].single.fire_rate / akimbo_rof_mul
					end
					if self["x_"..id].auto then
						self["x_"..id].auto.fire_rate = self["x_"..id].auto.fire_rate / akimbo_rof_mul
					end
				end
			end
			
		end
		init_super_light()
		
	end
	setSMGs()
	
	-- Pistols --
	local function setPISTOLs()
	
		local pickups = G_W_M.ammo_pickups.PISTOLs
		local new_pistol_damage_falloff = G_W_M.damage_dropoff.PISTOLs

		---- 88 pistols ----
		local function Gilza_init_FA_very_low_pistols()
			
			local pick_up = pickups._88
			local new_damage = 88
			
			self.beer.stats.damage = new_damage
			self.beer.AMMO_PICKUP = {((pick_up * 0.9)) * secondary_mul,((pick_up * 1.1)) * secondary_mul}
			self.beer.stats.spread = 13
			self.beer.stats.recoil = 19
			self.beer.CLIP_AMMO_MAX = 24
			self.beer.NR_CLIPS_MAX = 6
			self.beer.AMMO_MAX = self.beer.NR_CLIPS_MAX * self.beer.CLIP_AMMO_MAX
			self.beer.fire_mode_data = {fire_rate = 60/1150}
			self.beer.single = {fire_rate = self.beer.fire_mode_data.fire_rate}
			self.beer.auto = {fire_rate = self.beer.fire_mode_data.fire_rate}
			self.beer.damage_falloff = new_pistol_damage_falloff
			
			self.x_beer.stats.damage = math.ceil(new_damage/2)
			self.x_beer.AMMO_PICKUP = {((pick_up * 0.9)) * 2,((pick_up * 1.1)) * 2}
			self.x_beer.stats.spread = 13
			self.x_beer.stats.recoil = 19
			self.x_beer.CLIP_AMMO_MAX = 48
			self.x_beer.NR_CLIPS_MAX = 4.5
			self.x_beer.stats.reload = 19
			self.x_beer.AMMO_MAX = self.x_beer.NR_CLIPS_MAX * self.x_beer.CLIP_AMMO_MAX
			self.x_beer.fire_mode_data = {fire_rate = self.beer.fire_mode_data.fire_rate / akimbo_rof_mul}
			self.x_beer.single = {fire_rate = self.beer.fire_mode_data.fire_rate / akimbo_rof_mul}
			self.x_beer.auto = {fire_rate = self.beer.fire_mode_data.fire_rate / akimbo_rof_mul}
			self.x_beer.damage_falloff = new_pistol_damage_falloff
			
		end
		Gilza_init_FA_very_low_pistols()
		
		---- 95 pistols ----
		local function Gilza_init_FA_low_pistols()
			
			-- 3-5 headshot kill
			local low_pistols = {
				glock_18c = {fmd = "auto",akimbo = "x_g18c"},
				czech = {fmd = "auto",akimbo = true}
			}
			
			local pick_up = pickups._95
			local new_damage = 95
			
			for gun, tbl in pairs(low_pistols) do
				local function apply_stats(id, is_akimbo)
					if self[id] then
						self[id].damage_falloff = new_pistol_damage_falloff
						if is_akimbo then
							self[id].stats.damage = math.ceil(new_damage/2)
							self[id].AMMO_PICKUP = {((pick_up * 0.9)) * 2,((pick_up * 1.1)) * 2}
						else
							self[id].stats.damage = new_damage
							self[id].AMMO_PICKUP = {((pick_up * 0.9)) * secondary_mul,((pick_up * 1.1)) * secondary_mul}
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
			self.czech.stats.recoil = 17
			self.czech.CLIP_AMMO_MAX = 20
			self.czech.NR_CLIPS_MAX = 7
			self.czech.AMMO_MAX = self.czech.NR_CLIPS_MAX * self.czech.CLIP_AMMO_MAX
			self.czech.fire_mode_data = {fire_rate = 60/1050}
			self.czech.single = {fire_rate = self.czech.fire_mode_data.fire_rate}
			self.czech.auto = {fire_rate = self.czech.fire_mode_data.fire_rate}
			
			self.x_czech.stats.spread = 13
			self.x_czech.stats.recoil = 17
			self.x_czech.stats.reload = 19
			self.x_czech.CLIP_AMMO_MAX = 40
			self.x_czech.NR_CLIPS_MAX = 5.25
			self.x_czech.AMMO_MAX = self.x_czech.NR_CLIPS_MAX * self.x_czech.CLIP_AMMO_MAX
			self.x_czech.fire_mode_data = {fire_rate = self.czech.fire_mode_data.fire_rate / akimbo_rof_mul}
			self.x_czech.single = {fire_rate = self.czech.fire_mode_data.fire_rate / akimbo_rof_mul}
			self.x_czech.auto = {fire_rate = self.czech.fire_mode_data.fire_rate / akimbo_rof_mul}
			
			self.glock_18c.stats.spread = 13
			self.glock_18c.stats.recoil = 15
			self.glock_18c.NR_CLIPS_MAX = 7
			self.glock_18c.AMMO_MAX = self.glock_18c.NR_CLIPS_MAX * self.glock_18c.CLIP_AMMO_MAX
			self.glock_18c.fire_mode_data = {fire_rate = 60/950}
			self.glock_18c.single = {fire_rate = self.glock_18c.fire_mode_data.fire_rate}
			self.glock_18c.auto = {fire_rate = self.glock_18c.fire_mode_data.fire_rate}
			
			self.x_g18c.stats.spread = 13
			self.x_g18c.stats.recoil = 15
			self.x_g18c.stats.reload = 19
			self.x_g18c.NR_CLIPS_MAX = 5.25
			self.x_g18c.AMMO_MAX = self.x_g18c.NR_CLIPS_MAX * self.x_g18c.CLIP_AMMO_MAX
			self.x_g18c.fire_mode_data = {fire_rate = self.glock_18c.fire_mode_data.fire_rate / akimbo_rof_mul}
			self.x_g18c.single = {fire_rate = self.glock_18c.fire_mode_data.fire_rate / akimbo_rof_mul}
			self.x_g18c.auto = {fire_rate = self.glock_18c.fire_mode_data.fire_rate / akimbo_rof_mul}
			
		end
		Gilza_init_FA_low_pistols()
		
		---- 125 pistols ----
		local function Gilza_init_mid_pistols()
			
			-- 2-4 headshot kill
			local mid_pistols = {
				glock_17 = {fmd = "single",akimbo = "x_g17"},
				ppk = {fmd = "single",akimbo = true},
				b92fs = {fmd = "single",akimbo = true},
				legacy = {fmd = "single",akimbo = true},
				g26 = {fmd = "single",akimbo = "jowi"},
				shrew = {fmd = "single",akimbo = true},
				maxim9 = {fmd = "single",akimbo = true},
				stech = {fmd = "auto",akimbo = true}
			}
			
			local pick_up = pickups._125
			local new_damage = 125
			
			for gun, tbl in pairs(mid_pistols) do
				local new_fire_rate = 60/360
				if tbl.fmd == "auto" then
					new_fire_rate = 60/540
				end
				local function apply_stats(id, is_akimbo)
					if self[id] then
						self[id].damage_falloff = new_pistol_damage_falloff
						if is_akimbo then
							self[id].stats.damage = math.ceil(new_damage/2)
							self[id].AMMO_PICKUP = {((pick_up * 0.9)) * 2,((pick_up * 1.1)) * 2}
							self[id].fire_mode_data = {fire_rate = new_fire_rate / akimbo_rof_mul}
							self[id].single = {fire_rate = new_fire_rate / akimbo_rof_mul}
							self[id].auto = {fire_rate = new_fire_rate / akimbo_rof_mul}
						else
							self[id].fire_mode_data = {fire_rate = new_fire_rate}
							self[id].single = {fire_rate = new_fire_rate}
							self[id].auto = {fire_rate = new_fire_rate}
							self[id].stats.damage = new_damage
							self[id].AMMO_PICKUP = {((pick_up * 0.9)) * secondary_mul,((pick_up * 1.1)) * secondary_mul}
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
			self.glock_17.stats.recoil = 23
			self.glock_17.NR_CLIPS_MAX = 6
			self.glock_17.AMMO_MAX = self.glock_17.NR_CLIPS_MAX * self.glock_17.CLIP_AMMO_MAX
			self.x_g17.stats.spread = 9
			self.x_g17.stats.recoil = 23
			self.x_g17.stats.reload = 19
			self.x_g17.NR_CLIPS_MAX = 4.5
			self.x_g17.AMMO_MAX = self.x_g17.NR_CLIPS_MAX * self.x_g17.CLIP_AMMO_MAX
			
			self.ppk.stats.recoil = 21
			self.ppk.NR_CLIPS_MAX = 8
			self.ppk.AMMO_MAX = self.ppk.NR_CLIPS_MAX * self.ppk.CLIP_AMMO_MAX
			self.x_ppk.stats.recoil = 21
			self.x_ppk.stats.reload = 19
			self.x_ppk.NR_CLIPS_MAX = 6
			self.x_ppk.AMMO_MAX = self.x_ppk.NR_CLIPS_MAX * self.x_ppk.CLIP_AMMO_MAX
			
			self.b92fs.stats.spread = 22
			self.b92fs.stats.recoil = 13
			self.b92fs.NR_CLIPS_MAX = 5
			self.b92fs.AMMO_MAX = self.b92fs.NR_CLIPS_MAX * self.b92fs.CLIP_AMMO_MAX
			self.x_b92fs.stats.spread = 22
			self.x_b92fs.stats.recoil = 13
			self.x_b92fs.stats.reload = 19
			self.x_b92fs.stats.concealment = 30
			self.x_b92fs.NR_CLIPS_MAX = 3.75
			self.x_b92fs.AMMO_MAX = self.x_b92fs.NR_CLIPS_MAX * self.x_b92fs.CLIP_AMMO_MAX
			
			self.legacy.stats.spread = 15
			self.legacy.stats.recoil = 17
			self.legacy.NR_CLIPS_MAX = 7
			self.legacy.AMMO_MAX = self.legacy.NR_CLIPS_MAX * self.legacy.CLIP_AMMO_MAX
			self.x_legacy.stats.spread = 15
			self.x_legacy.stats.recoil = 17
			self.x_legacy.stats.reload = 19
			self.x_legacy.NR_CLIPS_MAX = 5.25
			self.x_legacy.AMMO_MAX = self.x_legacy.NR_CLIPS_MAX * self.x_legacy.CLIP_AMMO_MAX
			
			self.g26.stats.spread = 9
			self.g26.stats.recoil = 21
			self.g26.NR_CLIPS_MAX = 11
			self.g26.AMMO_MAX = self.g26.NR_CLIPS_MAX * self.g26.CLIP_AMMO_MAX
			self.jowi.stats.spread = 9
			self.jowi.stats.recoil = 21
			self.jowi.stats.reload = 19
			self.jowi.NR_CLIPS_MAX = 8.25
			self.jowi.AMMO_MAX = self.jowi.NR_CLIPS_MAX * self.jowi.CLIP_AMMO_MAX
			
			self.shrew.stats.spread = 22
			self.shrew.stats.recoil = 11
			self.shrew.NR_CLIPS_MAX = 6
			self.shrew.AMMO_MAX = self.shrew.NR_CLIPS_MAX * self.shrew.CLIP_AMMO_MAX
			self.x_shrew.stats.spread = 22
			self.x_shrew.stats.recoil = 11
			self.x_shrew.stats.reload = 19
			self.x_shrew.NR_CLIPS_MAX = 4.5
			self.x_shrew.AMMO_MAX = self.x_shrew.NR_CLIPS_MAX * self.x_shrew.CLIP_AMMO_MAX
			
			self.stech.stats.spread = 13
			self.stech.stats.recoil = 14
			self.stech.NR_CLIPS_MAX = 6
			self.stech.AMMO_MAX = self.stech.NR_CLIPS_MAX * self.stech.CLIP_AMMO_MAX
			self.x_stech.stats.spread = 13
			self.x_stech.stats.recoil = 14
			self.x_stech.stats.reload = 15
			self.x_stech.NR_CLIPS_MAX = 4.5
			self.x_stech.AMMO_MAX = self.x_stech.NR_CLIPS_MAX * self.x_stech.CLIP_AMMO_MAX
			
			self.maxim9.stats.spread = 19
			self.maxim9.stats.recoil = 15
			self.maxim9.CLIP_AMMO_MAX = 15
			self.maxim9.NR_CLIPS_MAX = 6
			self.maxim9.AMMO_MAX = self.maxim9.NR_CLIPS_MAX * self.maxim9.CLIP_AMMO_MAX
			self.x_maxim9.stats.spread = 19
			self.x_maxim9.stats.recoil = 15
			self.x_maxim9.stats.reload = 19
			self.x_maxim9.CLIP_AMMO_MAX = 30
			self.x_maxim9.NR_CLIPS_MAX = 4.5
			self.x_maxim9.AMMO_MAX = self.x_maxim9.NR_CLIPS_MAX * self.x_maxim9.CLIP_AMMO_MAX
			
		end
		Gilza_init_mid_pistols()
		
		---- 155 pistols ----
		local function Gilza_init_upper_mid_pistols()
			
			-- 2-3 headshot kill
			local upper_mid_pistols = {
				usp = {fmd = "single",akimbo = true},
				p226 = {fmd = "single",akimbo = true},
				colt_1911 = {fmd = "single",akimbo = "x_1911"},
				g22c = {fmd = "single",akimbo = true},
				c96 = {fmd = "single",akimbo = true},
				type54 = {fmd = "single",akimbo = true},
				packrat = {fmd = "single",akimbo = true},
				lemming = {fmd = "single",akimbo = false},
				holt = {fmd = "single",akimbo = true}
			}
			
			local pick_up = pickups._155
			local new_damage = 155
			
			for gun, tbl in pairs(upper_mid_pistols) do
				local new_fire_rate = 60/330
				if tbl.fmd == "auto" then
					new_fire_rate = 60/500
				end
				local function apply_stats(id, is_akimbo)
					if self[id] then
						self[id].damage_falloff = new_pistol_damage_falloff
						if is_akimbo then
							self[id].stats.damage = math.ceil(new_damage/2)
							self[id].AMMO_PICKUP = {((pick_up * 0.9)) * 2,((pick_up * 1.1)) * 2}
							self[id].fire_mode_data = {fire_rate = new_fire_rate / akimbo_rof_mul}
							self[id].single = {fire_rate = new_fire_rate / akimbo_rof_mul}
							self[id].auto = {fire_rate = new_fire_rate / akimbo_rof_mul}
						else
							self[id].stats.damage = new_damage
							self[id].AMMO_PICKUP = {((pick_up * 0.9)) * secondary_mul,((pick_up * 1.1)) * secondary_mul}
							self[id].fire_mode_data = {fire_rate = new_fire_rate}
							self[id].single = {fire_rate = new_fire_rate}
							self[id].auto = {fire_rate = new_fire_rate}
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
			self.x_usp.stats.spread = 21
			self.x_usp.stats.recoil = 15
			self.x_usp.stats.reload = 19
			self.x_usp.CLIP_AMMO_MAX = 24
			self.x_usp.NR_CLIPS_MAX = 4.125
			self.x_usp.AMMO_MAX = self.x_usp.NR_CLIPS_MAX * self.x_usp.CLIP_AMMO_MAX
			
			self.p226.stats.spread = 13
			self.p226.stats.recoil = 22
			self.p226.NR_CLIPS_MAX = 6
			self.p226.AMMO_MAX = self.p226.NR_CLIPS_MAX * self.p226.CLIP_AMMO_MAX
			self.x_p226.stats.spread = 13
			self.x_p226.stats.recoil = 22
			self.x_p226.stats.reload = 19
			self.x_p226.NR_CLIPS_MAX = 4.5
			self.x_p226.AMMO_MAX = self.x_p226.NR_CLIPS_MAX * self.x_p226.CLIP_AMMO_MAX
			
			self.colt_1911.stats.spread = 19
			self.colt_1911.stats.recoil = 20
			self.colt_1911.CLIP_AMMO_MAX = 8
			self.colt_1911.NR_CLIPS_MAX = 7
			self.colt_1911.AMMO_MAX = self.colt_1911.NR_CLIPS_MAX * self.colt_1911.CLIP_AMMO_MAX
			self.x_1911.stats.spread = 19
			self.x_1911.stats.recoil = 20
			self.x_1911.stats.reload = 19
			self.x_1911.stats.concealment = 29
			self.x_1911.CLIP_AMMO_MAX = 16
			self.x_1911.NR_CLIPS_MAX = 5.25
			self.x_1911.AMMO_MAX = self.x_1911.NR_CLIPS_MAX * self.x_1911.CLIP_AMMO_MAX
			
			self.g22c.stats.spread = 17
			self.g22c.stats.recoil = 17
			self.g22c.NR_CLIPS_MAX = 4
			self.g22c.AMMO_MAX = self.g22c.NR_CLIPS_MAX * self.g22c.CLIP_AMMO_MAX
			self.x_g22c.stats.spread = 17
			self.x_g22c.stats.recoil = 17
			self.x_g22c.stats.reload = 19
			self.x_g22c.NR_CLIPS_MAX = 3
			self.x_g22c.AMMO_MAX = self.x_g22c.NR_CLIPS_MAX * self.x_g22c.CLIP_AMMO_MAX
			
			self.c96.stats.recoil = 15
			self.c96.stats.reload = 20
			self.c96.CLIP_AMMO_MAX = 10
			self.c96.NR_CLIPS_MAX = 6
			self.c96.AMMO_MAX = self.c96.NR_CLIPS_MAX * self.c96.CLIP_AMMO_MAX
			self.x_c96.stats.recoil = 15
			self.x_c96.stats.reload = 13
			self.x_c96.CLIP_AMMO_MAX = 20
			self.x_c96.NR_CLIPS_MAX = 4.5
			self.x_c96.AMMO_MAX = self.x_c96.NR_CLIPS_MAX * self.x_c96.CLIP_AMMO_MAX
			
			self.type54_underbarrel.rays = 10
			self.type54_underbarrel.stats.damage = 66
			self.type54_underbarrel.stats.spread = 10
			self.type54_underbarrel.AMMO_PICKUP = {0.35,0.45}
			Gilza.shotgun_minimal_damage_multipliers.type54_underbarrel = 1
			self.x_type54_underbarrel.rays = 10
			self.x_type54_underbarrel.stats.damage = 33
			self.x_type54_underbarrel.stats.spread = 10
			self.x_type54_underbarrel.AMMO_PICKUP = {0.8,1}
			Gilza.shotgun_minimal_damage_multipliers.x_type54_underbarrel = 1
			
			self.type54.stats.recoil = 12
			self.type54.NR_CLIPS_MAX = 5
			self.type54.AMMO_MAX = self.type54.NR_CLIPS_MAX * self.type54.CLIP_AMMO_MAX
			
			self.x_type54.stats.recoil = 12
			self.x_type54.stats.reload = 19
			self.x_type54.NR_CLIPS_MAX = 3.75
			self.x_type54.AMMO_MAX = self.x_type54.NR_CLIPS_MAX * self.x_type54.CLIP_AMMO_MAX
			
			self.packrat.stats.spread = 22
			self.packrat.stats.recoil = 13
			self.packrat.NR_CLIPS_MAX = 4
			self.packrat.AMMO_MAX = self.packrat.NR_CLIPS_MAX * self.packrat.CLIP_AMMO_MAX
			self.x_packrat.stats.spread = 22
			self.x_packrat.stats.recoil = 13
			self.x_packrat.stats.reload = 19
			self.x_packrat.NR_CLIPS_MAX = 3
			self.x_packrat.AMMO_MAX = self.x_packrat.NR_CLIPS_MAX * self.x_packrat.CLIP_AMMO_MAX
			
			self.lemming.stats.spread = 16
			self.lemming.stats.recoil = 16
			self.lemming.CLIP_AMMO_MAX = 20
			self.lemming.NR_CLIPS_MAX = 2.5
			self.lemming.AMMO_MAX = self.lemming.NR_CLIPS_MAX * self.lemming.CLIP_AMMO_MAX
			self.lemming.AMMO_PICKUP = {((pick_up * 0.9 * 0.6)) * secondary_mul,((pick_up * 1.1 * 0.6)) * secondary_mul}
			
			self.holt.stats.spread = 23
			self.holt.stats.recoil = 20
			self.holt.NR_CLIPS_MAX = 2
			self.holt.AMMO_MAX = self.holt.NR_CLIPS_MAX * self.holt.CLIP_AMMO_MAX
			self.x_holt.stats.spread = 23
			self.x_holt.stats.recoil = 20
			self.x_holt.stats.reload = 19
			self.x_holt.NR_CLIPS_MAX = 2.25
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
				breech = {fmd = "single",akimbo = true},
				hs2000 = {fmd = "single",akimbo = true},
			}
			
			local pick_up = pickups._250
			local new_damage = 250
			
			for gun, tbl in pairs(heavy_pistols) do
				local new_fire_rate = 60/300
				if tbl.fmd == "auto" then
					new_fire_rate = 60/300
				end
				local function apply_stats(id, is_akimbo)
					if self[id] then
						self[id].damage_falloff = new_pistol_damage_falloff
						if is_akimbo then
							self[id].stats.damage = math.ceil(new_damage/2)
							self[id].AMMO_PICKUP = {((pick_up * 0.9)) * 2,((pick_up * 1.1)) * 2}
							self[id].fire_mode_data = {fire_rate = new_fire_rate / akimbo_rof_mul}
							self[id].single = {fire_rate = new_fire_rate / akimbo_rof_mul}
							self[id].auto = {fire_rate = new_fire_rate / akimbo_rof_mul}
						else
							self[id].stats.damage = new_damage
							self[id].AMMO_PICKUP = {((pick_up * 0.9)) * secondary_mul,((pick_up * 1.1)) * secondary_mul}
							self[id].fire_mode_data = {fire_rate = new_fire_rate}
							self[id].single = {fire_rate = new_fire_rate}
							self[id].auto = {fire_rate = new_fire_rate}
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
			self.m1911.stats.recoil = 12
			self.m1911.NR_CLIPS_MAX = 4
			self.m1911.AMMO_MAX = self.m1911.NR_CLIPS_MAX * self.m1911.CLIP_AMMO_MAX
			self.x_m1911.stats.spread = 14
			self.x_m1911.stats.reload = 14
			self.x_m1911.stats.recoil = 12
			self.x_m1911.NR_CLIPS_MAX = 3
			self.x_m1911.AMMO_MAX = self.x_m1911.NR_CLIPS_MAX * self.x_m1911.CLIP_AMMO_MAX
			
			self.pl14.stats.spread = 16
			self.pl14.stats.recoil = 7
			self.pl14.NR_CLIPS_MAX = 4
			self.pl14.AMMO_MAX = self.pl14.NR_CLIPS_MAX * self.pl14.CLIP_AMMO_MAX
			self.x_pl14.stats.spread = 16
			self.x_pl14.stats.recoil = 7
			self.x_pl14.stats.reload = 14
			self.x_pl14.NR_CLIPS_MAX = 3
			self.x_pl14.AMMO_MAX = self.x_pl14.NR_CLIPS_MAX * self.x_pl14.CLIP_AMMO_MAX
			
			self.sparrow.stats.spread = 16
			self.sparrow.stats.recoil = 7
			self.sparrow.NR_CLIPS_MAX = 4
			self.sparrow.AMMO_MAX = self.sparrow.NR_CLIPS_MAX * self.sparrow.CLIP_AMMO_MAX
			self.x_sparrow.stats.spread = 16
			self.x_sparrow.stats.recoil = 7
			self.x_sparrow.stats.reload = 14
			self.x_sparrow.NR_CLIPS_MAX = 3
			self.x_sparrow.AMMO_MAX = self.x_sparrow.NR_CLIPS_MAX * self.x_sparrow.CLIP_AMMO_MAX
			
			self.breech.stats.spread = 21
			self.breech.stats.recoil = 7
			self.breech.NR_CLIPS_MAX = 6
			self.breech.AMMO_MAX = self.breech.NR_CLIPS_MAX * self.breech.CLIP_AMMO_MAX
			self.x_breech.stats.spread = 21
			self.x_breech.stats.recoil = 5
			self.x_breech.stats.reload = 16
			self.x_breech.NR_CLIPS_MAX = 4.5
			self.x_breech.AMMO_MAX = self.x_breech.NR_CLIPS_MAX * self.x_breech.CLIP_AMMO_MAX
			
			self.deagle.stats.spread = 15
			self.deagle.stats.recoil = 6
			self.deagle.NR_CLIPS_MAX = 5
			self.deagle.AMMO_MAX = self.deagle.NR_CLIPS_MAX * self.deagle.CLIP_AMMO_MAX
			self.x_deagle.stats.spread = 15
			self.x_deagle.stats.recoil = 6
			self.x_deagle.stats.reload = 14
			self.x_deagle.stats.concealment = 28
			self.x_deagle.NR_CLIPS_MAX = 3.75
			self.x_deagle.AMMO_MAX = self.x_deagle.NR_CLIPS_MAX * self.x_deagle.CLIP_AMMO_MAX
			
			self.hs2000.stats.spread = 11
			self.hs2000.stats.recoil = 13
			self.hs2000.CLIP_AMMO_MAX = 13
			self.hs2000.NR_CLIPS_MAX = 4
			self.hs2000.AMMO_MAX = self.hs2000.NR_CLIPS_MAX * self.hs2000.CLIP_AMMO_MAX
			self.x_hs2000.stats.spread = 11
			self.x_hs2000.stats.recoil = 13
			self.x_hs2000.stats.reload = 14
			self.x_hs2000.CLIP_AMMO_MAX = 26
			self.x_hs2000.NR_CLIPS_MAX = 3
			self.x_hs2000.AMMO_MAX = self.x_hs2000.NR_CLIPS_MAX * self.x_hs2000.CLIP_AMMO_MAX
			
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
				peacemaker = {fmd = "single",akimbo = false},
				welrod = {fmd = "single",akimbo = false}
			}
			
			local pick_up = pickups._450
			local new_damage = 450
			
			for gun, tbl in pairs(heavy_pistol_ids) do
				local new_fire_rate = 60/240
				if tbl.fmd == "auto" then
					new_fire_rate = 60/240
				end
				local function apply_stats(id, is_akimbo)
					if self[id] then
						self[id].damage_falloff = new_pistol_damage_falloff
						if is_akimbo then
							self[id].stats.damage = math.ceil(new_damage/2)
							self[id].AMMO_PICKUP = {((pick_up * 0.9)) * 2,((pick_up * 1.1)) * 2}
							self[id].fire_mode_data = {fire_rate = new_fire_rate / akimbo_rof_mul}
							self[id].single = {fire_rate = new_fire_rate / akimbo_rof_mul}
							self[id].auto = {fire_rate = new_fire_rate / akimbo_rof_mul}
						else
							self[id].stats.damage = new_damage
							self[id].AMMO_PICKUP = {((pick_up * 0.9)) * secondary_mul,((pick_up * 1.1)) * secondary_mul}
							self[id].fire_mode_data = {fire_rate = new_fire_rate}
							self[id].single = {fire_rate = new_fire_rate}
							self[id].auto = {fire_rate = new_fire_rate}
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
			
			self.new_raging_bull.stats.spread = 17
			self.new_raging_bull.stats.recoil = 4
			self.new_raging_bull.stats.reload = 9
			self.new_raging_bull.NR_CLIPS_MAX = 6
			self.new_raging_bull.AMMO_MAX = self.new_raging_bull.NR_CLIPS_MAX * self.new_raging_bull.CLIP_AMMO_MAX
			self.x_rage.stats.spread = 19
			self.x_rage.stats.recoil = 4
			self.x_rage.stats.reload = 13
			self.x_rage.NR_CLIPS_MAX = 4.5
			self.x_rage.AMMO_MAX = self.x_rage.NR_CLIPS_MAX * self.x_rage.CLIP_AMMO_MAX
			
			self.korth.stats.spread = 11
			self.korth.stats.recoil = 2
			self.korth.NR_CLIPS_MAX = 4
			self.korth.AMMO_MAX = self.korth.NR_CLIPS_MAX * self.korth.CLIP_AMMO_MAX
			self.x_korth.stats.spread = 11
			self.x_korth.stats.recoil = 2
			self.x_korth.NR_CLIPS_MAX = 3
			self.x_korth.AMMO_MAX = self.x_korth.NR_CLIPS_MAX * self.x_korth.CLIP_AMMO_MAX
			
			self.chinchilla.stats.spread = 21
			self.chinchilla.stats.recoil = 3
			self.chinchilla.NR_CLIPS_MAX = 5
			self.chinchilla.AMMO_MAX = self.chinchilla.NR_CLIPS_MAX * self.chinchilla.CLIP_AMMO_MAX
			self.x_chinchilla.stats.spread = 21
			self.x_chinchilla.stats.recoil = 3
			self.x_chinchilla.stats.reload = 12
			self.x_chinchilla.NR_CLIPS_MAX = 3.75
			self.x_chinchilla.AMMO_MAX = self.x_chinchilla.NR_CLIPS_MAX * self.x_chinchilla.CLIP_AMMO_MAX
			
			self.model3.stats.spread = 19
			self.model3.stats.recoil = 7
			self.model3.NR_CLIPS_MAX = 7
			self.model3.AMMO_MAX = self.model3.NR_CLIPS_MAX * self.model3.CLIP_AMMO_MAX
			self.x_model3.stats.spread = 18
			self.x_model3.stats.recoil = 7
			self.x_model3.stats.reload = 13
			self.x_model3.NR_CLIPS_MAX = 5.25
			self.x_model3.AMMO_MAX = self.x_model3.NR_CLIPS_MAX * self.x_model3.CLIP_AMMO_MAX
			
			self.rsh12.stats.spread = 19
			self.rsh12.stats.recoil = 3
			self.rsh12.AMMO_PICKUP = {((pick_up * 0.9 * 0.6)) * secondary_mul,((pick_up * 1.1 * 0.6)) * secondary_mul}
			self.rsh12.NR_CLIPS_MAX = 4
			self.rsh12.AMMO_MAX = self.rsh12.NR_CLIPS_MAX * self.rsh12.CLIP_AMMO_MAX
			self.rsh12.stats_modifiers = {damage = 1}
			
			self.mateba.stats.reload = 15
			self.mateba.stats.recoil = 9
			self.mateba.stats.spread = 20
			self.mateba.NR_CLIPS_MAX = 4
			self.mateba.AMMO_MAX = self.mateba.NR_CLIPS_MAX * self.mateba.CLIP_AMMO_MAX
			self.x_2006m.stats.spread = 20
			self.x_2006m.stats.recoil = 9
			self.x_2006m.stats.reload = 13
			self.x_2006m.NR_CLIPS_MAX = 3
			self.x_2006m.AMMO_MAX = self.x_2006m.NR_CLIPS_MAX * self.x_2006m.CLIP_AMMO_MAX
			
			-- 1 shot to the body on normal swats, 1 shot headshot on everyone else (except dozers)
			-- the most badass cowboy in the west
			self.peacemaker.stats.damage = 650
			self.peacemaker.AMMO_PICKUP = {pick_up * 0.9 * 0.9 * secondary_mul, pick_up * 1.1 * 0.9 * secondary_mul}
			self.peacemaker.has_description = true
			self.peacemaker.can_shoot_through_enemy = true
			self.peacemaker.armor_piercing_chance = 1
			self.peacemaker.stats.spread = 23
			self.peacemaker.stats_modifiers = {damage = 1}
			self.peacemaker.NR_CLIPS_MAX = 4
			self.peacemaker.AMMO_MAX = self.peacemaker.NR_CLIPS_MAX * self.peacemaker.CLIP_AMMO_MAX
			
			-- 1 shot to the body on normal swats, 1 shot headshot on everyone else (except dozers)
			-- the most badass cowboy in the west
			self.welrod.stats.damage = 950
			self.welrod.AMMO_PICKUP = {pick_up * 0.9 * 0.7 * secondary_mul, pick_up * 1.1 * 0.7 * secondary_mul}
			self.welrod.has_description = true
			self.welrod.stats_modifiers = {damage = 1}
			self.welrod.stats.spread = 20
			self.welrod.NR_CLIPS_MAX = 4
			self.welrod.AMMO_MAX = self.welrod.NR_CLIPS_MAX * self.welrod.CLIP_AMMO_MAX
			self.welrod.fire_mode_data = {fire_rate = 60/27}
			self.welrod.single = {fire_rate = 60/27}
			self.welrod.auto = {fire_rate = 60/27}
			
		end
		Gilza_init_revolver_pistols()
		
	end
	setPISTOLs()
	
	-- Grenade launchers, includes underbarrels + rocket launchers
	local function setGLs()
		
		self.m32.stats.reload = 17 -- fml this thing is slow
		self.m32.stats.recoil = 17
		self.gre_m79.stats.recoil = 19
		self.slap.stats.recoil = 19
		self.china.stats.recoil = 17
		self.arbiter.stats.recoil = 21
		self.ms3gl.stats.recoil = 13
		self.ms3gl.stats.spread = 18
		
		self.rpg7.stats.reload = 13
		
		self.ray.NR_CLIPS_MAX = 1.5
		self.ray.AMMO_MAX = self.ray.CLIP_AMMO_MAX * self.ray.NR_CLIPS_MAX
		self.ray.stats.reload = 10
		
		local pickups = G_W_M.ammo_pickups.GLs
		
		self.m32.AMMO_PICKUP = {pickups._1300 * 0.9, pickups._1300 * 1.1}
		Gilza.shotgun_minimal_damage_multipliers.m32 = 1
		
		self.slap.AMMO_PICKUP = {((pickups._1300 * 0.9)) * secondary_mul,((pickups._1300 * 1.1)) * secondary_mul}
		Gilza.shotgun_minimal_damage_multipliers.slap = 1
		
		self.gre_m79.AMMO_PICKUP = {pickups._1300 * 0.9, pickups._1300 * 1.1}
		Gilza.shotgun_minimal_damage_multipliers.gre_m79 = 1
		
		self.china.AMMO_PICKUP = {((pickups._960 * 0.9)) * secondary_mul,((pickups._960 * 1.1)) * secondary_mul}
		Gilza.shotgun_minimal_damage_multipliers.china = 1
		
		self.ms3gl.AMMO_PICKUP = {((pickups._360 * 0.9)) * secondary_mul,((pickups._360 * 1.1)) * secondary_mul}
		Gilza.shotgun_minimal_damage_multipliers.ms3gl = 1
		
		self.arbiter.AMMO_PICKUP = {((pickups._480 * 0.9)) * secondary_mul,((pickups._480 * 1.1)) * secondary_mul}
		Gilza.shotgun_minimal_damage_multipliers.arbiter = 1
		
		self.slap.projectile_types.launcher_velocity = "launcher_velocity_slap"
		self.gre_m79.projectile_types.launcher_velocity = "launcher_velocity"
		self.m32.projectile_types.launcher_velocity = "launcher_velocity_m32"
		self.china.projectile_types.launcher_velocity = "launcher_velocity_china"
		
		self.groza_underbarrel.AMMO_PICKUP = {pickups._underbarrel * 0.9, pickups._underbarrel * 1.1}
		Gilza.shotgun_minimal_damage_multipliers.groza_underbarrel = 1
		self.contraband_m203.AMMO_PICKUP = {pickups._underbarrel * 0.9, pickups._underbarrel * 1.1}
		Gilza.shotgun_minimal_damage_multipliers.contraband_m203 = 1

		self.contraband_m203.projectile_types.underbarrel_velocity_frag = "underbarrel_velocity_frag"
		self.groza_underbarrel.projectile_types.underbarrel_velocity_frag = "underbarrel_velocity_frag_groza"
		
		
	end
	setGLs()
	
	-- Flammenwerfers --
	local function setFLAMENs()
		
		local flamen_pickup = 13.2
		
		self.flamethrower_mk2.stats.damage = 15
		self.flamethrower_mk2.stats.reload = 18
		self.flamethrower_mk2.CLIP_AMMO_MAX = 400
		self.flamethrower_mk2.NR_CLIPS_MAX = 2
		self.flamethrower_mk2.AMMO_PICKUP = {(flamen_pickup * 0.9),(flamen_pickup * 1.1)}
		self.flamethrower_mk2.AMMO_MAX = self.flamethrower_mk2.CLIP_AMMO_MAX * self.flamethrower_mk2.NR_CLIPS_MAX
		
		self.system.stats.damage = 15
		self.system.stats.reload = 18
		self.system.CLIP_AMMO_MAX = 300
		self.system.NR_CLIPS_MAX = 2
		self.system.AMMO_PICKUP = {((flamen_pickup * 0.9)) * secondary_mul,((flamen_pickup * 1.1)) * secondary_mul}
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
		self.m134.stats.recoil = 23
		self.m134.stats.spread = 10
		self.m134.stats.suppression = 1
		self.m134.CLIP_AMMO_MAX = 600
		self.m134.NR_CLIPS_MAX = 1.5
		self.m134.AMMO_MAX = self.m134.CLIP_AMMO_MAX * self.m134.NR_CLIPS_MAX
		local m134_avg = G_W_M:get_ammo_pickup(46, 0.25, 0.7)
		self.m134.AMMO_PICKUP = {(m134_avg * 0.7),(m134_avg * 1.3)}
		self.m134.stats.reload = 15
		--the other one
		self.shuno.CLIP_AMMO_MAX = 600
		self.shuno.NR_CLIPS_MAX = 1.5
		self.shuno.AMMO_MAX = self.shuno.CLIP_AMMO_MAX * self.shuno.NR_CLIPS_MAX
		self.shuno.stats.damage = 68
		self.shuno.stats.recoil = 19
		self.shuno.stats.spread = 10
		self.shuno.stats.reload = 15
		self.shuno.stats.suppression = 1
		local shuno_avg = G_W_M:get_ammo_pickup(68, 0.28, 0.7)
		self.shuno.AMMO_PICKUP = {(shuno_avg * 0.7),(shuno_avg * 1.3)}
		--the 'minigun' that is hailstorm
		self.hailstorm.CLIP_AMMO_MAX = 210
		self.hailstorm.NR_CLIPS_MAX = 2.5
		self.hailstorm.AMMO_MAX = self.hailstorm.CLIP_AMMO_MAX * self.hailstorm.NR_CLIPS_MAX
		self.hailstorm.stats.damage = 71
		self.hailstorm.stats.recoil = 21
		self.hailstorm.stats.spread = 18
		local hailstorm_avg = G_W_M:get_ammo_pickup(71, 0.34)
		self.hailstorm.AMMO_PICKUP = {(hailstorm_avg * 0.9),(hailstorm_avg * 1.1)}
		self.hailstorm.damage_falloff = G_W_M.damage_dropoff.ARs
		self.hailstorm.fire_mode_data.volley.spread_mul = 1
		self.hailstorm.fire_mode_data.volley.can_shoot_through_enemy = false
		self.hailstorm.has_description = true
	end
	setMINIGUNs()
	
	--Bows--
	local function setBOWs()
		
		-- in their infinite wisdom overkill gave a multiplier of 100 to the "long" bow, which means that any mod that adjusts damage stat, also has a multiplier of 100
		-- problem arises when you realise that attachments that change the projectile, take their new damage stat from the projectiletweakdata
		-- instead of ammunition mod that updates the projectile
		-- poison arrow projectile for example, has 300 damage, when the base arrow has 2k damage, but because of the damage multipliers,
		-- poison arrow gets multiplied by 100 instead of 10, so the game thinks that the poision arrow would be 3000 damage total, which is higher then the base arrow
		-- this fixes the issue by overriding the modifier to a value that actually works, and overrides the default damage so that default arrow's 2k damage is correct
		-- godbless weapon lib that can handle weapons with high damage and doesnt clamp anything for no reason, so we don't have to use damage modifiers that fuck everything up
		
		-- BOWS
		self.long.stats.damage = 130
		self.long.stats_modifiers = {damage = 10} -- same fix as longbow
		self.long.stats.recoil = 17
		
		self.elastic.stats.damage = 130
		self.elastic.stats_modifiers = {damage = 10} -- same fix as longbow
		self.elastic.stats.recoil = 15
		
		self.plainsrider.stats.recoil = 21
		self.plainsrider.stats.damage = 50
		
		-- CROSSBOWS
		self.frankish.stats.spread = 18
		self.frankish.fire_mode_data.fire_rate = 60/75
		self.frankish.single.fire_rate = 60/75
		self.frankish.stats.damage = 41
		
		self.arblast.stats.damage = 90
		self.arblast.stats_modifiers = {damage = 10} -- same fix as longbow
		self.arblast.stats.spread = 20
		self.arblast.fire_mode_data.fire_rate = 60/75
		self.arblast.single.fire_rate = 60/75
		
		self.ecp.stats.spread = 17
		self.ecp.stats.damage = 20
		self.ecp.stats.concealment = 12
		
		self.hunter.stats.damage = 41
		self.hunter.stats.spread = 19
		self.hunter.fire_mode_data.fire_rate = 60/75
		self.hunter.single.fire_rate = 60/75
		self.hunter.stats.concealment = 28
		
	end
	setBOWs()
	
	--Saws--
	local function setSAWs()
		self.saw.stats.damage = 220
		self.saw_secondary.stats.damage = 220
	end
	setSAWs()
	
	local function setNewRecoil()
		
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
		G_W_M:set_new_weapon_recoil(G_W_M.recoil_stats.ARs, AR_list, nil, self)
		
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
		G_W_M:set_new_weapon_recoil(G_W_M.recoil_stats.SMGs, SMG_list, nil, self)
		
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
		G_W_M:set_new_weapon_recoil(G_W_M.recoil_stats.LMGs, LMG_list, nil, self)
		
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
		G_W_M:set_new_weapon_recoil(G_W_M.recoil_stats.SNIPERs, Sniper_list, nil, self)
		
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
			welrod = "right",
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
		G_W_M:set_new_weapon_recoil(G_W_M.recoil_stats.PISTOLs, Pistol_list, nil, self)
		
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
		G_W_M:set_new_weapon_recoil(G_W_M.recoil_stats.SHOTGUNs, Shotgun_list, nil, self)
	
	end
	setNewRecoil()
	
	local function addBURSTFIRE()
		-- add burst fire to whichever weapons i feel like here
		-- this can be done with any weapon, even custom, by adding required properties to their tweak_data by whatever means you want
		
		-- add burst
		self.m16.HAS_BURST_AS_THIRD = true
		-- determine № of rounds per burst. if weapon is akimbo, both guns are fired out in the same fashion, so 3 round burst in the code = 6 round burst in practice in total
		self.m16.BURST_COUNT = 3
		-- determine delay between bursts in seconds. delay starts after last shot was fired
		-- this, for example, specifically takes natural delay after firing 2 shots, instead of just 1, with default ROF, to reduce overall dps by 25% (total delay of 4 shots, after firing 3)
		self.m16.fire_mode_data.burst_cooldown = self.m16.fire_mode_data.fire_rate * 2
		-- ROF during the burst. reminder that this is a delay - set as 60/1200 if you want custom ROF of 1200, instead of weapon's vanilla ROF.
		self.m16.burst = {fire_rate = self.m16.fire_mode_data.fire_rate}
		self.m16.has_description = true
		
		-- fix ms3gl values for new burst system
		self.ms3gl.fire_mode_data.burst_cooldown = 1
		self.ms3gl.burst = {fire_rate = 0.33}
		
		self.famas.HAS_BURST_AS_THIRD = true
		self.famas.BURST_COUNT = 3
		self.famas.fire_mode_data.burst_cooldown = self.famas.fire_mode_data.fire_rate * 2
		self.famas.burst = {fire_rate = self.famas.fire_mode_data.fire_rate}
		self.famas.has_description = true
		
		self.flint.HAS_BURST_AS_THIRD = true
		self.flint.BURST_COUNT = 2
		self.flint.fire_mode_data.burst_cooldown = 60/1200 * 2 -- bootleg an94
		self.flint.burst = {fire_rate = 60/1200}
		self.flint.has_description = true
		
		self.g36.HAS_BURST_AS_THIRD = true
		self.g36.BURST_COUNT = 2
		self.g36.fire_mode_data.burst_cooldown = self.g36.fire_mode_data.fire_rate * 1.666
		self.g36.burst = {fire_rate = self.g36.fire_mode_data.fire_rate}
		self.g36.has_description = true
		
		self.komodo.HAS_BURST_AS_THIRD = true
		self.komodo.BURST_COUNT = 3
		self.komodo.fire_mode_data.burst_cooldown = self.komodo.fire_mode_data.fire_rate * 2
		self.komodo.burst = {fire_rate = self.komodo.fire_mode_data.fire_rate}
		self.komodo.has_description = true
		
		self.g3.HAS_BURST_AS_THIRD = true
		self.g3.BURST_COUNT = 2
		self.g3.fire_mode_data.burst_cooldown = self.g3.fire_mode_data.fire_rate * 1.666
		self.g3.burst = {fire_rate = self.g3.fire_mode_data.fire_rate}
		self.g3.has_description = true
		
		self.s552.HAS_BURST_AS_THIRD = true
		self.s552.BURST_COUNT = 3
		self.s552.fire_mode_data.burst_cooldown = self.s552.fire_mode_data.fire_rate * 2
		self.s552.burst = {fire_rate = self.s552.fire_mode_data.fire_rate}
		self.s552.has_description = true
		
		self.new_m4.HAS_BURST_AS_THIRD = true
		self.new_m4.BURST_COUNT = 3
		self.new_m4.fire_mode_data.burst_cooldown = self.new_m4.fire_mode_data.fire_rate * 2
		self.new_m4.burst = {fire_rate = self.new_m4.fire_mode_data.fire_rate}
		self.new_m4.has_description = true
		
		self.groza.HAS_BURST_AS_THIRD = true
		self.groza.BURST_COUNT = 3
		self.groza.fire_mode_data.burst_cooldown = self.groza.fire_mode_data.fire_rate * 2
		self.groza.burst = {fire_rate = self.groza.fire_mode_data.fire_rate}
		self.groza.has_description = true
		
		self.asval.HAS_BURST_AS_THIRD = true
		self.asval.BURST_COUNT = 3
		self.asval.fire_mode_data.burst_cooldown = self.asval.fire_mode_data.fire_rate * 2
		self.asval.burst = {fire_rate = self.asval.fire_mode_data.fire_rate}
		self.asval.has_description = true
		
		self.aug.HAS_BURST_AS_THIRD = true
		self.aug.BURST_COUNT = 3
		self.aug.fire_mode_data.burst_cooldown = self.aug.fire_mode_data.fire_rate * 2
		self.aug.burst = {fire_rate = self.aug.fire_mode_data.fire_rate}
		self.aug.has_description = true
		
		self.scar.HAS_BURST_AS_THIRD = true
		self.scar.BURST_COUNT = 2
		self.scar.fire_mode_data.burst_cooldown = self.scar.fire_mode_data.fire_rate * 1.666
		self.scar.burst = {fire_rate = self.scar.fire_mode_data.fire_rate}
		self.scar.has_description = true
		
		self.beer.HAS_BURST_AS_THIRD = true
		self.beer.BURST_COUNT = 3
		self.beer.fire_mode_data.burst_cooldown = self.beer.fire_mode_data.fire_rate * 2
		self.beer.burst = {fire_rate = self.beer.fire_mode_data.fire_rate}
		self.beer.has_description = true
		self.x_beer.HAS_BURST_AS_THIRD = true
		self.x_beer.BURST_COUNT = 3
		self.x_beer.fire_mode_data.burst_cooldown = self.x_beer.fire_mode_data.fire_rate * 2
		self.x_beer.burst = {fire_rate = self.x_beer.fire_mode_data.fire_rate}
		self.x_beer.has_description = true
		
		self.hajk.HAS_BURST_AS_THIRD = true
		self.hajk.BURST_COUNT = 3
		self.hajk.fire_mode_data.burst_cooldown = self.hajk.fire_mode_data.fire_rate * 2
		self.hajk.burst = {fire_rate = self.hajk.fire_mode_data.fire_rate}
		self.hajk.has_description = true
		self.x_hajk.HAS_BURST_AS_THIRD = true
		self.x_hajk.BURST_COUNT = 3
		self.x_hajk.fire_mode_data.burst_cooldown = self.x_hajk.fire_mode_data.fire_rate * 2
		self.x_hajk.burst = {fire_rate = self.x_hajk.fire_mode_data.fire_rate}
		self.x_hajk.has_description = true
		
		self.vityaz.HAS_BURST_AS_THIRD = true
		self.vityaz.BURST_COUNT = 3
		self.vityaz.fire_mode_data.burst_cooldown = self.vityaz.fire_mode_data.fire_rate * 2
		self.vityaz.burst = {fire_rate = self.vityaz.fire_mode_data.fire_rate}
		self.vityaz.has_description = true
		self.x_vityaz.HAS_BURST_AS_THIRD = true
		self.x_vityaz.BURST_COUNT = 3
		self.x_vityaz.fire_mode_data.burst_cooldown = self.x_vityaz.fire_mode_data.fire_rate * 2
		self.x_vityaz.burst = {fire_rate = self.x_vityaz.fire_mode_data.fire_rate}
		self.x_vityaz.has_description = true
		
		self.new_mp5.HAS_BURST_AS_THIRD = true
		self.new_mp5.BURST_COUNT = 3
		self.new_mp5.fire_mode_data.burst_cooldown = self.new_mp5.fire_mode_data.fire_rate * 2
		self.new_mp5.burst = {fire_rate = self.new_mp5.fire_mode_data.fire_rate}
		self.new_mp5.has_description = true
		self.x_mp5.HAS_BURST_AS_THIRD = true
		self.x_mp5.BURST_COUNT = 3
		self.x_mp5.fire_mode_data.burst_cooldown = self.x_mp5.fire_mode_data.fire_rate * 2
		self.x_mp5.burst = {fire_rate = self.x_mp5.fire_mode_data.fire_rate}
		self.x_mp5.has_description = true
		
		self.scorpion.HAS_BURST_AS_THIRD = true
		self.scorpion.BURST_COUNT = 3
		self.scorpion.fire_mode_data.burst_cooldown = self.scorpion.fire_mode_data.fire_rate * 2
		self.scorpion.burst = {fire_rate = self.scorpion.fire_mode_data.fire_rate}
		self.scorpion.has_description = true
		self.x_scorpion.HAS_BURST_AS_THIRD = true
		self.x_scorpion.BURST_COUNT = 3
		self.x_scorpion.fire_mode_data.burst_cooldown = self.x_scorpion.fire_mode_data.fire_rate * 2
		self.x_scorpion.burst = {fire_rate = self.x_scorpion.fire_mode_data.fire_rate}
		self.x_scorpion.has_description = true
		
		self.mp9.HAS_BURST_AS_THIRD = true
		self.mp9.BURST_COUNT = 3
		self.mp9.fire_mode_data.burst_cooldown = self.mp9.fire_mode_data.fire_rate * 2
		self.mp9.burst = {fire_rate = self.mp9.fire_mode_data.fire_rate}
		self.mp9.has_description = true
		self.x_mp9.HAS_BURST_AS_THIRD = true
		self.x_mp9.BURST_COUNT = 3
		self.x_mp9.fire_mode_data.burst_cooldown = self.x_mp9.fire_mode_data.fire_rate * 2
		self.x_mp9.burst = {fire_rate = self.x_mp9.fire_mode_data.fire_rate}
		self.x_mp9.has_description = true
		
		self.shepheard.HAS_BURST_AS_THIRD = true
		self.shepheard.BURST_COUNT = 3
		self.shepheard.fire_mode_data.burst_cooldown = self.shepheard.fire_mode_data.fire_rate * 2
		self.shepheard.burst = {fire_rate = self.shepheard.fire_mode_data.fire_rate}
		self.shepheard.has_description = true
		self.x_shepheard.HAS_BURST_AS_THIRD = true
		self.x_shepheard.BURST_COUNT = 3
		self.x_shepheard.fire_mode_data.burst_cooldown = self.x_shepheard.fire_mode_data.fire_rate * 2
		self.x_shepheard.burst = {fire_rate = self.x_shepheard.fire_mode_data.fire_rate}
		self.x_shepheard.has_description = true
		
		self.polymer.HAS_BURST_AS_THIRD = true
		self.polymer.BURST_COUNT = 2
		self.polymer.fire_mode_data.burst_cooldown = self.polymer.fire_mode_data.fire_rate * 1.666
		self.polymer.burst = {fire_rate = self.polymer.fire_mode_data.fire_rate}
		self.polymer.has_description = true
		self.x_polymer.HAS_BURST_AS_THIRD = true
		self.x_polymer.BURST_COUNT = 2
		self.x_polymer.fire_mode_data.burst_cooldown = self.x_polymer.fire_mode_data.fire_rate * 2
		self.x_polymer.burst = {fire_rate = self.x_polymer.fire_mode_data.fire_rate}
		self.x_polymer.has_description = true
		
		self.olympic.HAS_BURST_AS_THIRD = true
		self.olympic.BURST_COUNT = 2
		self.olympic.fire_mode_data.burst_cooldown = 60/1050 * 2
		self.olympic.burst = {fire_rate = 60/1050}
		self.olympic.has_description = true
		self.x_olympic.HAS_BURST_AS_THIRD = true
		self.x_olympic.BURST_COUNT = 2
		self.x_olympic.fire_mode_data.burst_cooldown = 60/1050 * 2
		self.x_olympic.burst = {fire_rate = 60/1050}
		self.x_olympic.has_description = true
		
	end
	addBURSTFIRE()
	
end)

Hooks:PostHook(WeaponTweakData, "_init_data_player_weapons", "Gilza_init_custom_weapon_stats", function(self, tweak_data)
	
	local secondary_mul = 0.7
	local secondary_to_primary_mul = 1/secondary_mul
	local akimbo_rof_mul = 1.3
	local G_W_M = Gilza.Weapons_module

	local customWeaponsUpdated = {Assault_Rifles={}, Sub_Machine_guns={}, Pistols={}, Light_Machine_guns={}, Snipers={}, Shotguns={}, Melee={}}
	function WeaponTweakData:_gilza_add_custom_weapons()
		local customWeaponsList = Gilza.customWeaponsList or {}
		if #customWeaponsList >= 1 then
			log("[Gilza] Loading custom weapon tweaks...")
			for j=1, #customWeaponsList do
				if self[customWeaponsList[j]] and self[customWeaponsList[j]].categories then
					for i=1, #self[customWeaponsList[j]].categories do
						if self[customWeaponsList[j]].categories[i] == "assault_rifle" then
							self[customWeaponsList[j]].stats.damage = math.floor(self[customWeaponsList[j]].stats.damage * 2)
							self:_gilza_custom_AR_stats(customWeaponsList[j])
						elseif self[customWeaponsList[j]].categories[i] == "smg" then
							self[customWeaponsList[j]].stats.damage = math.floor(self[customWeaponsList[j]].stats.damage * 2)
							self:_gilza_custom_SMG_stats(customWeaponsList[j])
						elseif self[customWeaponsList[j]].categories[i] == "pistol" then
							local isRevolver = false
							for k=1, #self[customWeaponsList[j]].categories do
								if tostring(self[customWeaponsList[j]].categories[k]) == "revolver" then
									isRevolver = true
								end							
							end
							self[customWeaponsList[j]].stats.damage = math.floor(self[customWeaponsList[j]].stats.damage * 2)
							self:_gilza_custom_PISTOL_stats(customWeaponsList[j],isRevolver)
						elseif self[customWeaponsList[j]].categories[i] == "lmg" then
							self[customWeaponsList[j]].stats.damage = math.floor(self[customWeaponsList[j]].stats.damage * 2)
							self:_gilza_custom_LMG_stats(customWeaponsList[j])
						elseif self[customWeaponsList[j]].categories[i] == "snp" then
							self[customWeaponsList[j]].stats.damage = math.floor(self[customWeaponsList[j]].stats.damage * 2)
							self:_gilza_custom_SNIPER_stats(customWeaponsList[j])
						elseif self[customWeaponsList[j]].categories[i] == "shotgun" then
							self[customWeaponsList[j]].stats.damage = math.floor(self[customWeaponsList[j]].stats.damage * 2)
							self:_gilza_custom_SHOTGUN_stats(customWeaponsList[j])
						end
					end
				end
			end
		end
		self:_gilza_custom_weapon_individual()
		self:_gilza_custom_MELEE_stats()
	end

	function WeaponTweakData:_gilza_custom_AR_stats(id)
		
		table.insert(customWeaponsUpdated.Assault_Rifles, id)
		
		local pickups = G_W_M.ammo_pickups.ARs
		
		if self[id].stats_modifiers then
			if self[id].stats_modifiers.damage then
				self[id].stats.damage = self[id].stats.damage * self[id].stats_modifiers.damage
				self[id].stats_modifiers.damage = 1
			end
		end
		
		if self[id].rays and self[id].rays >= 2 then
			self[id].stats.damage = self[id].stats.damage * self[id].rays
			self[id].rays = 1
		end
		
		if self[id].stats.damage <= 115 then
			local weapon_avg_pickup = G_W_M:get_ammo_pickup(self[id].stats.damage, 0.32)
			self[id].AMMO_PICKUP = {weapon_avg_pickup * 0.9, weapon_avg_pickup * 1.1}
		elseif self[id].stats.damage >= 116 and self[id].stats.damage <= 140 then
			self[id].stats.damage = 125
			self[id].AMMO_PICKUP = {pickups._125 * 0.9, pickups._125 * 1.1}
		elseif self[id].stats.damage >= 141 and self[id].stats.damage <= 170 then
			self[id].stats.damage = 155
			self[id].AMMO_PICKUP = {pickups._155 * 0.9, pickups._155 * 1.1}
		elseif self[id].stats.damage >= 171 and self[id].stats.damage <= 200 then
			self[id].stats.damage = 200
			self[id].AMMO_PICKUP = {pickups._200 * 0.9, pickups._200 * 1.1}
		elseif self[id].stats.damage >= 201 and self[id].stats.damage <= 310 then
			self[id].stats.damage = 250
			self[id].AMMO_PICKUP = {pickups._250 * 0.9, pickups._250 * 1.1}
		elseif self[id].stats.damage >= 311 then
			self[id].stats.damage = 450
			self[id].AMMO_PICKUP = {pickups._450 * 0.9, pickups._450 * 1.1}
		end
		
		self[id].damage_falloff = G_W_M.damage_dropoff.ARs
		
		-- known ones, added manualy
		local custom_ARs_with_GL = {
			"g3hk79",
			"mdr_308",
			"yayo",
			"m14e2",
			"soppo",
			"kurisumasu",
			"liberator",
			"xeno"
		}
		
		if table.contains(custom_ARs_with_GL,id) then
			self[id].AMMO_PICKUP[1] = self[id].AMMO_PICKUP[1] * 0.7
			self[id].AMMO_PICKUP[2] = self[id].AMMO_PICKUP[2] * 0.7
		end
		
		-- if not primary
		if self[id].use_data and self[id].use_data.selection_index and self[id].use_data.selection_index == 1 then
			self[id].AMMO_PICKUP[1] = self[id].AMMO_PICKUP[1] * secondary_mul
			self[id].AMMO_PICKUP[2] = self[id].AMMO_PICKUP[2] * secondary_mul
		end
		
		-- akimbo
		for i=1, #self[id].categories do
			if self[id].categories[i] == "akimbo" then
				self[id].stats.damage = math.ceil(self[id].stats.damage / 2)
				self[id].AMMO_PICKUP[1] = self[id].AMMO_PICKUP[1] * 2
				self[id].AMMO_PICKUP[2] = self[id].AMMO_PICKUP[2] * 2
				local current_rof = self[id].fire_mode_data.fire_rate
				if self[string.sub(tostring(id), 3,-1)] then -- check for non akimbo version of the gun, if it exists base ROF increase on that
					current_rof = self[string.sub(tostring(id), 3,-1)].fire_mode_data.fire_rate
				end
				self[id].fire_mode_data = {fire_rate = current_rof / akimbo_rof_mul}
				self[id].single = {fire_rate = current_rof / akimbo_rof_mul}
				self[id].auto = {fire_rate = current_rof / akimbo_rof_mul}
			end
		end
		
		-- nerf recoil stat because this mod is ass :)
		self[id].stats.recoil = self[id].stats.recoil - 4
		if self[id].stats.recoil < 0 then
			self[id].stats.recoil = 0
		end
		
		local recoil_lean = "left"
		if math.fmod(self[id].stats.recoil, 2) == 0 then
			recoil_lean = "right"
		end
		G_W_M:set_new_weapon_recoil(G_W_M.recoil_stats.ARs, id, recoil_lean, self)
		
	end

	function WeaponTweakData:_gilza_custom_SMG_stats(id)

		table.insert(customWeaponsUpdated.Sub_Machine_guns, id)
		
		local pickups = G_W_M.ammo_pickups.SMGs
		
		if self[id].stats_modifiers then
			if self[id].stats_modifiers.damage then
				self[id].stats.damage = self[id].stats.damage * self[id].stats_modifiers.damage
				self[id].stats_modifiers.damage = 1
			end
		end
		
		if self[id].rays and self[id].rays >= 2 then
			self[id].stats.damage = self[id].stats.damage * self[id].rays
			self[id].rays = 1
		end
		
		if self[id].stats.damage <= 79 then
			local weapon_avg_pickup = G_W_M:get_ammo_pickup(self[id].stats.damage, 0.32)
			self[id].AMMO_PICKUP = {weapon_avg_pickup * 0.9, weapon_avg_pickup * 1.1}
		elseif self[id].stats.damage >= 80 and self[id].stats.damage <= 115 then
			self[id].stats.damage = 95
			self[id].AMMO_PICKUP = {pickups._95 * 0.9, pickups._95 * 1.1}
		elseif self[id].stats.damage >= 116 and self[id].stats.damage <= 140 then
			self[id].stats.damage = 125
			self[id].AMMO_PICKUP = {pickups._125 * 0.9, pickups._125 * 1.1}
		elseif self[id].stats.damage >= 141 and self[id].stats.damage <= 170 then
			self[id].stats.damage = 155
			self[id].AMMO_PICKUP = {pickups._155 * 0.9, pickups._155 * 1.1}
		elseif self[id].stats.damage >= 171 and self[id].stats.damage <= 200 then
			self[id].stats.damage = 200
			self[id].AMMO_PICKUP = {pickups._200 * 0.9, pickups._200 * 1.1}
		elseif self[id].stats.damage >= 201 then
			self[id].stats.damage = 250
			self[id].AMMO_PICKUP = {pickups._250 * 0.9, pickups._250 * 1.1}
		end
		
		self[id].damage_falloff = G_W_M.damage_dropoff.SMGs
		
		-- if not primary
		if self[id].use_data and self[id].use_data.selection_index and self[id].use_data.selection_index == 1 then
			self[id].AMMO_PICKUP[1] = self[id].AMMO_PICKUP[1] * secondary_mul
			self[id].AMMO_PICKUP[2] = self[id].AMMO_PICKUP[2] * secondary_mul
		end
		
		-- akimbo
		for i=1, #self[id].categories do
			if self[id].categories[i] == "akimbo" then
				self[id].stats.damage = math.ceil(self[id].stats.damage / 2)
				self[id].AMMO_PICKUP[1] = self[id].AMMO_PICKUP[1] * 2
				self[id].AMMO_PICKUP[2] = self[id].AMMO_PICKUP[2] * 2
				local current_rof = self[id].fire_mode_data.fire_rate
				if self[string.sub(tostring(id), 3,-1)] then -- check for non akimbo version of the gun, if it exists base ROF increase on that
					current_rof = self[string.sub(tostring(id), 3,-1)].fire_mode_data.fire_rate
				end
				self[id].fire_mode_data = {fire_rate = current_rof / akimbo_rof_mul}
				self[id].single = {fire_rate = current_rof / akimbo_rof_mul}
				self[id].auto = {fire_rate = current_rof / akimbo_rof_mul}
			end
		end
		
		self[id].stats.recoil = self[id].stats.recoil - 3
		if self[id].stats.recoil < 0 then
			self[id].stats.recoil = 0
		end
		
		-- set new recoil
		local recoil_lean = "left"
		if math.fmod(self[id].stats.recoil, 2) == 0 then
			recoil_lean = "right"
		end
		G_W_M:set_new_weapon_recoil(G_W_M.recoil_stats.SMGs, id, recoil_lean, self)
		
	end

	function WeaponTweakData:_gilza_custom_PISTOL_stats(id, isRevolver)

		table.insert(customWeaponsUpdated.Pistols, id)
		
		local pickups = G_W_M.ammo_pickups.PISTOLs
		
		local fire_mode = "single"
		if (self[id].FIRE_MODE and self[id].FIRE_MODE == "auto") or self[id].CAN_TOGGLE_FIREMODE then
			fire_mode = "auto"
		end
		
		if self[id].stats_modifiers then
			if self[id].stats_modifiers.damage then
				self[id].stats.damage = self[id].stats.damage * self[id].stats_modifiers.damage
				self[id].stats_modifiers.damage = 1
			end
		end
		
		if self[id].rays and self[id].rays >= 2 then
			self[id].stats.damage = self[id].stats.damage * self[id].rays
			self[id].rays = 1
		end
		
		if self[id].stats.damage <= 59 then
			local weapon_avg_pickup = G_W_M:get_ammo_pickup(self[id].stats.damage, 0.32)
			if self[id].fire_mode_data then
				self[id].fire_mode_data.fire_rate = self[id].fire_mode_data.fire_rate * 0.75
			end
			if self[id].single then
				self[id].single.fire_rate = self[id].single.fire_rate * 0.75
			end
			if self[id].auto then
				self[id].auto.fire_rate = self[id].auto.fire_rate * 0.75
			end
			self[id].AMMO_PICKUP = {weapon_avg_pickup * 0.9, weapon_avg_pickup * 1.1}
		elseif self[id].stats.damage >= 60 and self[id].stats.damage <= 78 then
			self[id].stats.damage = 88
			self[id].AMMO_PICKUP = {pickups._88 * 0.9, pickups._88 * 1.1}
			local new_rof = 60/650
			if fire_mode == "single" then
				if self[id].fire_mode_data then
					self[id].fire_mode_data.fire_rate = new_rof
				end
				if self[id].single then
					self[id].single.fire_rate = new_rof
				end
				if self[id].auto then
					self[id].auto.fire_rate = new_rof
				end
			else
				if self[id].fire_mode_data then
					self[id].fire_mode_data.fire_rate = self[id].fire_mode_data.fire_rate * 0.75
				end
				if self[id].single then
					self[id].single.fire_rate = self[id].single.fire_rate * 0.75
				end
				if self[id].auto then
					self[id].auto.fire_rate = self[id].auto.fire_rate * 0.75
				end
			end
		elseif self[id].stats.damage >= 79 and self[id].stats.damage <= 115 then
			self[id].stats.damage = 95
			self[id].AMMO_PICKUP = {pickups._95 * 0.9, pickups._95 * 1.1}
			local new_rof = 60/450
			if fire_mode == "single" then
				if self[id].fire_mode_data then
					self[id].fire_mode_data.fire_rate = new_rof
				end
				if self[id].single then
					self[id].single.fire_rate = new_rof
				end
				if self[id].auto then
					self[id].auto.fire_rate = new_rof
				end
			else
				if self[id].fire_mode_data then
					self[id].fire_mode_data.fire_rate = self[id].fire_mode_data.fire_rate * 0.75
				end
				if self[id].single then
					self[id].single.fire_rate = self[id].single.fire_rate * 0.75
				end
				if self[id].auto then
					self[id].auto.fire_rate = self[id].auto.fire_rate * 0.75
				end
			end
		elseif self[id].stats.damage >= 116 and self[id].stats.damage <= 140 then
			self[id].stats.damage = 125
			self[id].AMMO_PICKUP = {pickups._125 * 0.9, pickups._125 * 1.1}
			local new_rof = 60/360
			if fire_mode == "auto" then
				new_rof = 60/540
			end
			if self[id].fire_mode_data then
				self[id].fire_mode_data.fire_rate = new_rof
			end
			if self[id].single then
				self[id].single.fire_rate = new_rof
			end
			if self[id].auto then
				self[id].auto.fire_rate = new_rof
			end
		elseif self[id].stats.damage >= 141 and self[id].stats.damage <= 200 then
			self[id].stats.damage = 155
			self[id].AMMO_PICKUP = {pickups._155 * 0.9, pickups._155 * 1.1}
			local new_rof = 60/330
			if fire_mode == "auto" then
				new_rof = 60/500
			end
			if self[id].fire_mode_data then
				self[id].fire_mode_data.fire_rate = new_rof
			end
			if self[id].single then
				self[id].single.fire_rate = new_rof
			end
			if self[id].auto then
				self[id].auto.fire_rate = new_rof
			end
		elseif self[id].stats.damage >= 201 and self[id].stats.damage <= 310 then
			self[id].stats.damage = 250
			self[id].AMMO_PICKUP = {pickups._250 * 0.9, pickups._250 * 1.1}
			local new_rof = 60/300
			if fire_mode == "auto" then
				new_rof = 60/400
			end
			if self[id].fire_mode_data then
				self[id].fire_mode_data.fire_rate = new_rof
			end
			if self[id].single then
				self[id].single.fire_rate = new_rof
			end
			if self[id].auto then
				self[id].auto.fire_rate = new_rof
			end
		end
		
		if isRevolver or self[id].stats.damage >= 311 or (self[id].stats.damage >= 201 and self[id].stats.damage <= 310 and self[id].CLIP_AMMO_MAX <= 6) then
			self[id].stats.damage = 450
			self[id].AMMO_PICKUP = {pickups._450 * 0.9, pickups._450 * 1.1}
			local new_rof = 60/240
			if self[id].fire_mode_data then
				self[id].fire_mode_data.fire_rate = new_rof
			end
			if self[id].single then
				self[id].single.fire_rate = new_rof
			end
			if self[id].auto then
				self[id].auto.fire_rate = new_rof
			end
		end
		
		self[id].damage_falloff = G_W_M.damage_dropoff.PISTOLs
		
		-- if not primary
		if self[id].use_data and self[id].use_data.selection_index and self[id].use_data.selection_index == 1 then
			self[id].AMMO_PICKUP[1] = self[id].AMMO_PICKUP[1] * secondary_mul
			self[id].AMMO_PICKUP[2] = self[id].AMMO_PICKUP[2] * secondary_mul
		end
		
		-- akimbo
		for i=1, #self[id].categories do
			if self[id].categories[i] == "akimbo" then
				self[id].stats.damage = math.ceil(self[id].stats.damage / 2)
				self[id].AMMO_PICKUP[1] = self[id].AMMO_PICKUP[1] * 2
				self[id].AMMO_PICKUP[2] = self[id].AMMO_PICKUP[2] * 2
				local current_rof = self[id].fire_mode_data.fire_rate
				if self[string.sub(tostring(id), 3,-1)] then -- check for non akimbo version of the gun, if it exists base ROF increase on that
					current_rof = self[string.sub(tostring(id), 3,-1)].fire_mode_data.fire_rate
				end
				self[id].fire_mode_data = {fire_rate = current_rof / akimbo_rof_mul}
				self[id].single = {fire_rate = current_rof / akimbo_rof_mul}
				self[id].auto = {fire_rate = current_rof / akimbo_rof_mul}
			end
		end
		
		self[id].stats.recoil = self[id].stats.recoil - 4
		if self[id].stats.recoil < 0 then
			self[id].stats.recoil = 0
		end

		-- dont allow for full auto pistols to go over this amount of base stability
		if fire_mode == "auto" and self[id].stats.recoil > 16 then
			self[id].stats.recoil = 16
		end
		
		local recoil_lean = "left"
		if math.fmod(self[id].stats.recoil, 2) == 0 then
			recoil_lean = "right"
		end
		if fire_mode == "auto" then
			G_W_M:set_new_weapon_recoil(G_W_M.recoil_stats.SMGs, id, recoil_lean, self)
		else
			G_W_M:set_new_weapon_recoil(G_W_M.recoil_stats.PISTOLs, id, recoil_lean, self)
		end
		
	end

	function WeaponTweakData:_gilza_custom_LMG_stats(id)

		table.insert(customWeaponsUpdated.Light_Machine_guns, id)
		
		local pickups = G_W_M.ammo_pickups.LMGs
		
		if self[id].stats_modifiers then
			if self[id].stats_modifiers.damage then
				self[id].stats.damage = self[id].stats.damage * self[id].stats_modifiers.damage
				self[id].stats_modifiers.damage = 1
			end
		end
		
		if self[id].rays and self[id].rays >= 2 then
			self[id].stats.damage = self[id].stats.damage * self[id].rays
			self[id].rays = 1
		end
		
		local has_bipod = false
		local wpn_factory_id = Gilza.customWeaponFactoryIDs[id] or nil
		if wpn_factory_id then
			if table.contains(self.factory[wpn_factory_id].uses_parts, "wpn_fps_upg_bp_lmg_lionbipod") then
				has_bipod = true
			end
			for _, part in pairs(self.factory[wpn_factory_id].uses_parts) do
				if self.factory.parts[part].type and self.factory.parts[part].type == "bipod" then
					has_bipod = true
				end
				if self.factory.parts[part].perks then
					for __, perk in pairs(self.factory.parts[part].perks) do
						if perk == "bipod" then
							has_bipod = true
						end
					end
				end
			end
		end
		
		if has_bipod then
			self[id].damage_falloff = G_W_M.damage_dropoff.LMGs
			if self[id].stats.damage <= 115 then
				local weapon_avg_pickup = G_W_M:get_ammo_pickup(self[id].stats.damage, 0.28, 0.85)
				self[id].AMMO_PICKUP = {weapon_avg_pickup * 0.9, weapon_avg_pickup * 1.1}
			elseif self[id].stats.damage >= 116 and self[id].stats.damage <= 140 then
				self[id].stats.damage = 125
				self[id].AMMO_PICKUP = {pickups._125 * 0.9, pickups._125 * 1.1}
			elseif self[id].stats.damage >= 141 and self[id].stats.damage <= 200 then
				self[id].stats.damage = 155
				self[id].AMMO_PICKUP = {pickups._155 * 0.9, pickups._155 * 1.1}
			elseif self[id].stats.damage >= 201 then
				self[id].stats.damage = 250
				self[id].AMMO_PICKUP = {pickups._250 * 0.9, pickups._250 * 1.1}
			end
			-- total ammo buff
			local increase = 50
			if self[id].AMMO_MAX < 150 then
				-- dont bother
				increase = 0
			elseif self[id].AMMO_MAX <= 200 then
				increase = 75
			elseif self[id].AMMO_MAX <= 350 then
				increase = 100
			else
				increase = 150
			end
			self[id].AMMO_MAX = self[id].AMMO_MAX + increase
			self[id].NR_CLIPS_MAX = self[id].AMMO_MAX / self[id].CLIP_AMMO_MAX
		else
			self[id].damage_falloff = G_W_M.damage_dropoff.ARs
			if self[id].stats.damage <= 115 then
				local weapon_avg_pickup = G_W_M:get_ammo_pickup(self[id].stats.damage, 0.28, 0.75)
				self[id].AMMO_PICKUP = {weapon_avg_pickup * 0.9, weapon_avg_pickup * 1.1}
			elseif self[id].stats.damage >= 116 and self[id].stats.damage <= 140 then
				self[id].stats.damage = 125
				self[id].AMMO_PICKUP = {pickups._125_bipodless * 0.9, pickups._125_bipodless * 1.1}
			elseif self[id].stats.damage >= 141 and self[id].stats.damage <= 200 then
				self[id].stats.damage = 155
				self[id].AMMO_PICKUP = {pickups._155_bipodless * 0.9, pickups._155_bipodless * 1.1}
			elseif self[id].stats.damage >= 201 then
				self[id].stats.damage = 250
				self[id].AMMO_PICKUP = {pickups._250_bipodless * 0.9, pickups._250_bipodless * 1.1}
			end
		end

		-- if not primary
		if self[id].use_data and self[id].use_data.selection_index and self[id].use_data.selection_index == 1 then
			self[id].AMMO_PICKUP[1] = self[id].AMMO_PICKUP[1] * secondary_mul
			self[id].AMMO_PICKUP[2] = self[id].AMMO_PICKUP[2] * secondary_mul
		end
		
		-- akimbo
		for i=1, #self[id].categories do
			if self[id].categories[i] == "akimbo" then
				self[id].stats.damage = math.ceil(self[id].stats.damage / 2)
				self[id].AMMO_PICKUP[1] = self[id].AMMO_PICKUP[1] * 2
				self[id].AMMO_PICKUP[2] = self[id].AMMO_PICKUP[2] * 2
				local current_rof = self[id].fire_mode_data.fire_rate
				if self[string.sub(tostring(id), 3,-1)] then -- check for non akimbo version of the gun, if it exists base ROF increase on that
					current_rof = self[string.sub(tostring(id), 3,-1)].fire_mode_data.fire_rate
				end
				self[id].fire_mode_data = {fire_rate = current_rof / akimbo_rof_mul}
				self[id].single = {fire_rate = current_rof / akimbo_rof_mul}
				self[id].auto = {fire_rate = current_rof / akimbo_rof_mul}
			end
		end
		
		self[id].stats.recoil = self[id].stats.recoil - 6
		if self[id].stats.recoil < 0 then
			self[id].stats.recoil = 0
		end
		
		-- set new recoil
		local recoil_lean = "left"
		if math.fmod(self[id].stats.recoil, 2) == 0 then
			recoil_lean = "right"
		end
		G_W_M:set_new_weapon_recoil(G_W_M.recoil_stats.LMGs, id, recoil_lean, self)
		
	end

	function WeaponTweakData:_gilza_custom_SNIPER_stats(id)

		table.insert(customWeaponsUpdated.Snipers, id)
		
		Gilza.customSnipersToUpdateScopesFor = Gilza.customSnipersToUpdateScopesFor or {}
		table.insert(Gilza.customSnipersToUpdateScopesFor, id)
		
		local pickups = G_W_M.ammo_pickups.SNIPERs
		
		if self[id].stats_modifiers then
			if self[id].stats_modifiers.damage then
				self[id].stats.damage = self[id].stats.damage * self[id].stats_modifiers.damage
				self[id].stats_modifiers.damage = 1
			end
		end
		
		if self[id].rays and self[id].rays >= 2 then
			self[id].stats.damage = self[id].stats.damage * self[id].rays
			self[id].rays = 1
		end
		
		local bolty = false
		local force_semi_auto = false
		local force_lever_action = false
		
		if self[id].use_shotgun_reload or self[id].timers.shotgun_reload_shell then
			force_lever_action = true
		end
		
		local rof = 0
		if self[id].single then
			rof = self[id].single.fire_rate
		end
		if self[id].fire_mode_data then
			rof = self[id].fire_mode_data.fire_rate
		end
		rof = 60 / rof
		if rof > 150 then
			force_semi_auto = true
		end
		
		if self[id].stats.damage <= 330 then
			force_semi_auto = true
		elseif self[id].stats.damage >= 331 and self[id].stats.damage <= 500 and not force_lever_action then
			if self[id].CLIP_AMMO_MAX <= 6 then
				force_lever_action = true
			else
				self[id].stats.damage = 1300
				self[id].AMMO_PICKUP = {pickups._1300 * 0.9, pickups._1300 * 1.1}
			end
		elseif self[id].stats.damage >= 501 and self[id].stats.damage <= 2200 then
			if self[id].CLIP_AMMO_MAX > 6 then
				self[id].stats.damage = 1300
				self[id].AMMO_PICKUP = {pickups._1300 * 0.9, pickups._1300 * 1.1}
			else
				self[id].stats.damage = 1600
				self[id].AMMO_PICKUP = {pickups._1600 * 0.9, pickups._1600 * 1.1}
			end
			bolty = true
		end
		
		if force_lever_action then
			self[id].stats.damage = 950
			self[id].AMMO_PICKUP = {pickups._950 * 0.9, pickups._950 * 1.1}
		elseif force_semi_auto then
			self[id].fire_mode_data = {fire_rate = 60/210}
			self[id].single = {fire_rate = 60/210}
			self[id].stats.damage = 650
			self[id].AMMO_PICKUP = {pickups._650 * 0.9, pickups._650 * 1.1}
		end
		
		if not bolty and not force_semi_auto and not force_lever_action then
			local dmg = self[id].stats.damage
			local weapon_avg_pickup = pickups._50cal
			local mul = 1
			if dmg >= 9000 then
				mul = 0.75
			end
			if dmg >= 12000 then
				mul = 0.5
			end
			if dmg >= 16000 then
				mul = 0.25
			end
			weapon_avg_pickup = weapon_avg_pickup * mul
			self[id].AMMO_PICKUP = {weapon_avg_pickup * 0.9, weapon_avg_pickup * 1.1}
		end
		
		self[id].damage_falloff = G_W_M.damage_dropoff.SNIPERs
		
		self[id].stats.concealment = self[id].stats.concealment - 1
		
		-- if not primary
		if self[id].use_data and self[id].use_data.selection_index and self[id].use_data.selection_index == 1 then
			self[id].AMMO_PICKUP[1] = self[id].AMMO_PICKUP[1] * secondary_mul
			self[id].AMMO_PICKUP[2] = self[id].AMMO_PICKUP[2] * secondary_mul
		end
		
		-- akimbo
		for i=1, #self[id].categories do
			if self[id].categories[i] == "akimbo" then
				self[id].stats.damage = math.ceil(self[id].stats.damage / 2)
				self[id].AMMO_PICKUP[1] = self[id].AMMO_PICKUP[1] * 2
				self[id].AMMO_PICKUP[2] = self[id].AMMO_PICKUP[2] * 2
				local current_rof = self[id].fire_mode_data.fire_rate
				if self[string.sub(tostring(id), 3,-1)] then -- check for non akimbo version of the gun, if it exists base ROF increase on that
					current_rof = self[string.sub(tostring(id), 3,-1)].fire_mode_data.fire_rate
				end
				self[id].fire_mode_data = {fire_rate = current_rof / akimbo_rof_mul}
				self[id].single = {fire_rate = current_rof / akimbo_rof_mul}
				self[id].auto = {fire_rate = current_rof / akimbo_rof_mul}
			end
		end
		
		self[id].stats.recoil = self[id].stats.recoil - 7
		if self[id].stats.recoil < 0 then
			self[id].stats.recoil = 0
		end
		
		-- set new recoil
		local recoil_lean = "left"
		if math.fmod(self[id].stats.recoil, 2) == 0 then
			recoil_lean = "right"
		end
		G_W_M:set_new_weapon_recoil(G_W_M.recoil_stats.SNIPERs, id, recoil_lean, self)
		
	end

	function WeaponTweakData:_gilza_custom_SHOTGUN_stats(id)
		
		table.insert(customWeaponsUpdated.Shotguns, id)
		
		local pickups = G_W_M.ammo_pickups.SHOTGUNs
		
		if self[id].stats_modifiers then
			if self[id].stats_modifiers.damage then
				self[id].stats.damage = self[id].stats.damage * self[id].stats_modifiers.damage
				self[id].stats_modifiers.damage = 1
			end
		end
		
		local category = 0
		
		if self[id].stats.damage >= 80 and self[id].stats.damage <= 140 then
			category = 1 -- full auto
		elseif self[id].stats.damage >= 141 and self[id].stats.damage <= 200 then
			category = 2 -- semi auto no mag
		elseif self[id].stats.damage >= 201 and self[id].stats.damage <= 300 then
			category = 3 -- pump
		elseif self[id].stats.damage >= 301 and self[id].stats.damage <= 500 then
			category = 4 -- DB
		else
			category = 5
		end
		
		-- in case pump action shotguns have too high of a ROF we change them to semi auto class
		if category == 3 then
			local rof = 1
			if self[id].single then
				rof = self[id].single.fire_rate
			end
			if self[id].fire_mode_data then
				rof = self[id].fire_mode_data.fire_rate
			end
			if (60/rof) >= 160 then
				category = 2
			end
		end
		
		local has_shotgun_reload = false
		if self[id].use_shotgun_reload or self[id].timers.shotgun_reload_shell then
			has_shotgun_reload = true
		end
		
		if not has_shotgun_reload and category > 1 then
			local mag_size = self[id].CLIP_AMMO_MAX
			if mag_size > 3 then
				if mag_size > 6 then
					category = 1
				else
					category = 2
				end
			end
		end
		
		if self[id].rays ~= 10 then
			self[id].rays = 10
		end
		
		if category == 1 then
			self[id].stats.damage = 160
			self[id].damage_falloff = G_W_M.damage_dropoff.SHOTGUNs._160
			Gilza.shotgun_minimal_damage_multipliers[id] = 0.5
			self[id].AMMO_PICKUP = {pickups._160 * 0.9, pickups._160 * 1.1}
		elseif category == 2 then
			self[id].stats.damage = 325
			self[id].damage_falloff = G_W_M.damage_dropoff.SHOTGUNs._325
			Gilza.shotgun_minimal_damage_multipliers[id] = 0.67
			self[id].AMMO_PICKUP = {pickups._325 * 0.9, pickups._325 * 1.1}
		elseif category == 3 then
			self[id].stats.damage = 450
			self[id].damage_falloff = G_W_M.damage_dropoff.SHOTGUNs._450
			Gilza.shotgun_minimal_damage_multipliers[id] = 0.8
			self[id].AMMO_PICKUP = {pickups._450 * 0.9, pickups._450 * 1.1}
		elseif category == 4 then
			self[id].stats.damage = 900
			self[id].damage_falloff = G_W_M.damage_dropoff.SHOTGUNs._900
			Gilza.shotgun_minimal_damage_multipliers[id] = 1
			self[id].AMMO_PICKUP = {pickups._900 * 0.9, pickups._900 * 1.1}
		elseif category == 5 then
			local weapon_avg_pickup = G_W_M:get_ammo_pickup(self[id].stats.damage, 1, 0.55)
			self[id].AMMO_PICKUP = {weapon_avg_pickup * 0.9, weapon_avg_pickup * 1.1}
		end
		
		-- if not primary
		if self[id].use_data and self[id].use_data.selection_index and self[id].use_data.selection_index == 1 then
			self[id].AMMO_PICKUP[1] = self[id].AMMO_PICKUP[1] * secondary_mul
			self[id].AMMO_PICKUP[2] = self[id].AMMO_PICKUP[2] * secondary_mul
		end
		
		-- akimbo
		for i=1, #self[id].categories do
			if self[id].categories[i] == "akimbo" then
				self[id].stats.damage = math.ceil(self[id].stats.damage / 2)
				self[id].AMMO_PICKUP[1] = self[id].AMMO_PICKUP[1] * 2
				self[id].AMMO_PICKUP[2] = self[id].AMMO_PICKUP[2] * 2
				local current_rof = self[id].fire_mode_data.fire_rate
				if self[string.sub(tostring(id), 3,-1)] then -- check for non akimbo version of the gun, if it exists base ROF increase on that
					current_rof = self[string.sub(tostring(id), 3,-1)].fire_mode_data.fire_rate
				end
				self[id].fire_mode_data = {fire_rate = current_rof / akimbo_rof_mul}
				self[id].single = {fire_rate = current_rof / akimbo_rof_mul}
				self[id].auto = {fire_rate = current_rof / akimbo_rof_mul}
			end
		end
		
		self[id].stats.recoil = self[id].stats.recoil - 8
		if self[id].stats.recoil < 0 then
			self[id].stats.recoil = 0
		end
		
		-- shothun ammo. dear god.
		local HE_custom_stats = {
			ignore_statistic = true,
			damage_far_mul = 1,
			damage_near_mul = 1,
			bullet_class = "InstantExplosiveBulletBase",
			rays = 1,
			ammo_pickup_max_mul = 0.6,
			ammo_pickup_min_mul = 0.6
		}
		local FAHEstats = {
			value = 5,
			total_ammo_mod = -6.66,
			damage = 192,
			recoil = -8
		}
		local SAHEstats = {
			value = 5,
			total_ammo_mod = -6.66,
			damage = 400,
			recoil = -8
		}
		local PAHEstats = {
			value = 5,
			total_ammo_mod = -6.66,
			damage = 550,
			recoil = -8
		}
		local DBHEstats = {
			value = 5,
			total_ammo_mod = -6.66,
			damage = 1050,
			recoil = -8
		}
		local ultraHEstats = {
			value = 5,
			total_ammo_mod = -6.66,
			damage = self[id].stats.damage * 1.1,
			recoil = -8
		}
		
		local BS_custom_stats = {
			damage_far_mul = 0.75,
			damage_near_mul = 0.75,
			armor_piercing_add = 1,
			can_shoot_through_enemy = true,
			ammo_pickup_max_mul = 0.8,
			ammo_pickup_min_mul = 0.8,
			is_buckshot = true,
			rays = 12
		}
		local FABS_stats = {
			total_ammo_mod = 5,
			damage = 160
		}
		local SABS_stats = {
			total_ammo_mod = 5,
			damage = 325
		}
		local PABS_stats = {
			total_ammo_mod = 5,
			damage = 450
		}
		local DBBS_stats = {
			total_ammo_mod = 5,
			damage = 900
		}
		local ultraBS_stats = {
			total_ammo_mod = 5,
			damage = self[id].stats.damage
		}
		
		local wpn_factory_id = Gilza.customWeaponFactoryIDs[id] or nil
		if wpn_factory_id then
			self.factory[wpn_factory_id].override = self.factory[wpn_factory_id].override or {}
			if category == 1 then
				self.factory[wpn_factory_id].override.wpn_fps_upg_a_explosive = {stats = FAHEstats,custom_stats = HE_custom_stats}
				self.factory[wpn_factory_id].override.wpn_fps_upg_a_custom = {stats = FABS_stats,custom_stats = BS_custom_stats}
				self.factory[wpn_factory_id].override.wpn_fps_upg_a_custom_free = {stats = FABS_stats,custom_stats = BS_custom_stats}
			elseif category == 2 then
				self.factory[wpn_factory_id].override.wpn_fps_upg_a_explosive = {stats = SAHEstats,custom_stats = HE_custom_stats}
				self.factory[wpn_factory_id].override.wpn_fps_upg_a_custom = {stats = SABS_stats,custom_stats = BS_custom_stats}
				self.factory[wpn_factory_id].override.wpn_fps_upg_a_custom_free = {stats = SABS_stats,custom_stats = BS_custom_stats}
			elseif category == 3 then
				self.factory[wpn_factory_id].override.wpn_fps_upg_a_explosive = {stats = PAHEstats,custom_stats = HE_custom_stats}
				self.factory[wpn_factory_id].override.wpn_fps_upg_a_custom = {stats = PABS_stats,custom_stats = BS_custom_stats}
				self.factory[wpn_factory_id].override.wpn_fps_upg_a_custom_free = {stats = PABS_stats,custom_stats = BS_custom_stats}
			elseif category == 4 then
				self.factory[wpn_factory_id].override.wpn_fps_upg_a_explosive = {stats = DBHEstats,custom_stats = HE_custom_stats}
				self.factory[wpn_factory_id].override.wpn_fps_upg_a_custom = {stats = DBBS_stats,custom_stats = BS_custom_stats}
				self.factory[wpn_factory_id].override.wpn_fps_upg_a_custom_free = {stats = DBBS_stats,custom_stats = BS_custom_stats}
			elseif category == 5 then
				self.factory[wpn_factory_id].override.wpn_fps_upg_a_explosive = {stats = ultraHEstats,custom_stats = HE_custom_stats}
				self.factory[wpn_factory_id].override.wpn_fps_upg_a_custom = {stats = ultraBS_stats,custom_stats = BS_custom_stats}
				self.factory[wpn_factory_id].override.wpn_fps_upg_a_custom_free = {stats = ultraBS_stats,custom_stats = BS_custom_stats}
			end
		end
		
		-- set new recoil
		local recoil_lean = "left"
		if math.fmod(self[id].stats.recoil, 2) == 0 then
			recoil_lean = "right"
		end
		G_W_M:set_new_weapon_recoil(G_W_M.recoil_stats.SHOTGUNs, id, recoil_lean, self)
		
	end

	function WeaponTweakData:_gilza_custom_MELEE_stats()
		
		local function initCutsomMelee()
			for melee, stats in pairs(tweak_data.blackmarket.melee_weapons) do
				if table.contains (Gilza.default_melee_weapons, melee) then
					-- default weapon, dont do anything
				else
					table.insert(customWeaponsUpdated.Melee, melee)
					if stats.repeat_expire_t <= 0.35 then
						tweak_data.blackmarket.melee_weapons[melee].stats.min_damage = 2.5
						tweak_data.blackmarket.melee_weapons[melee].stats.max_damage = 7.5
						tweak_data.blackmarket.melee_weapons[melee].stats.min_damage_effect = 7
						tweak_data.blackmarket.melee_weapons[melee].stats.max_damage_effect = 7
						tweak_data.blackmarket.melee_weapons[melee].stats.charge_time = 0.75
						tweak_data.blackmarket.melee_weapons[melee].sort_order = 2
					elseif stats.repeat_expire_t <= 0.5 then
						tweak_data.blackmarket.melee_weapons[melee].stats.min_damage = 3.5
						tweak_data.blackmarket.melee_weapons[melee].stats.max_damage = 10.5
						tweak_data.blackmarket.melee_weapons[melee].stats.min_damage_effect = 7
						tweak_data.blackmarket.melee_weapons[melee].stats.max_damage_effect = 7
						tweak_data.blackmarket.melee_weapons[melee].stats.charge_time = 1.4
						tweak_data.blackmarket.melee_weapons[melee].sort_order = 3
					elseif stats.repeat_expire_t <= 0.75 then
						tweak_data.blackmarket.melee_weapons[melee].stats.min_damage = 5
						tweak_data.blackmarket.melee_weapons[melee].stats.max_damage = 15
						tweak_data.blackmarket.melee_weapons[melee].stats.min_damage_effect = 7
						tweak_data.blackmarket.melee_weapons[melee].stats.max_damage_effect = 7
						tweak_data.blackmarket.melee_weapons[melee].stats.charge_time = 1.9
						tweak_data.blackmarket.melee_weapons[melee].sort_order = 4
					elseif stats.repeat_expire_t > 0.75 then
						if stats.melee_damage_delay <= 0.35 and stats.repeat_expire_t < 1 then
							tweak_data.blackmarket.melee_weapons[melee].stats.min_damage = 6.8
							tweak_data.blackmarket.melee_weapons[melee].stats.max_damage = 20.5
							tweak_data.blackmarket.melee_weapons[melee].stats.min_damage_effect = 7
							tweak_data.blackmarket.melee_weapons[melee].stats.max_damage_effect = 7
							tweak_data.blackmarket.melee_weapons[melee].stats.charge_time = 2.5
							tweak_data.blackmarket.melee_weapons[melee].sort_order = 5
						elseif stats.melee_damage_delay > 0.35 then
							tweak_data.blackmarket.melee_weapons[melee].stats.min_damage = 10
							tweak_data.blackmarket.melee_weapons[melee].stats.max_damage = 30
							tweak_data.blackmarket.melee_weapons[melee].stats.min_damage_effect = 7
							tweak_data.blackmarket.melee_weapons[melee].stats.max_damage_effect = 7
							tweak_data.blackmarket.melee_weapons[melee].stats.charge_time = 3.5
							tweak_data.blackmarket.melee_weapons[melee].sort_order = 6
						end
					end
					local additional_wpn_range = tweak_data.blackmarket.melee_weapons[melee].stats.range - 150
					if additional_wpn_range >= 5 then
						local knock = (math.clamp(additional_wpn_range/5, 1, 24)) * 0.25
						tweak_data.blackmarket.melee_weapons[melee].stats.min_damage_effect = 7 - knock
						tweak_data.blackmarket.melee_weapons[melee].stats.max_damage_effect = 7 - knock
					end
					-- poison
					if tweak_data.blackmarket.melee_weapons[melee].dot_data then
						tweak_data.blackmarket.melee_weapons[melee].stats.min_damage = 2
						tweak_data.blackmarket.melee_weapons[melee].stats.max_damage = 3.5
						tweak_data.blackmarket.melee_weapons[melee].stats.min_damage_effect = 1
						tweak_data.blackmarket.melee_weapons[melee].stats.max_damage_effect = 1
						tweak_data.blackmarket.melee_weapons[melee].stats.concealment = tweak_data.blackmarket.melee_weapons[melee].stats.concealment - 2
						tweak_data.blackmarket.melee_weapons[melee].sort_order = -1
					end
					-- tazer
					if tweak_data.blackmarket.melee_weapons[melee].tase_data then
						tweak_data.blackmarket.melee_weapons[melee].stats.min_damage = 0.5
						tweak_data.blackmarket.melee_weapons[melee].stats.max_damage = 1
						tweak_data.blackmarket.melee_weapons[melee].stats.min_damage_effect = 1
						tweak_data.blackmarket.melee_weapons[melee].stats.max_damage_effect = 1
						tweak_data.blackmarket.melee_weapons[melee].stats.charge_time = 0.5
						tweak_data.blackmarket.melee_weapons[melee].sort_order = -2
					end
					-- special and fire
					if tweak_data.blackmarket.melee_weapons[melee].random_special_effects or tweak_data.blackmarket.melee_weapons[melee].fire_dot_data then
						tweak_data.blackmarket.melee_weapons[melee].stats.min_damage_effect = 1
						tweak_data.blackmarket.melee_weapons[melee].stats.max_damage_effect = 1
						tweak_data.blackmarket.melee_weapons[melee].stats.concealment = tweak_data.blackmarket.melee_weapons[melee].stats.concealment - 4
					end
				end
			end
			
			local hasCustomWeapons = false
			for category, tbl in pairs(customWeaponsUpdated) do
				local str = ""
				for _, id in pairs(customWeaponsUpdated[tostring(category)]) do
					str = str..tostring(id)..", "
				end
				str = str:sub(1, -3)
				if str ~= "" then
					log("[Gilza] Updated stats for "..tostring(category).." ("..str..")")
					hasCustomWeapons = true
				end
			end
			if hasCustomWeapons then
				log("[Gilza] Custom weapon stats applied.")
			end
		end
		
		local function wait_for_weapon_tweaks()
			if tweak_data and tweak_data.weapon then
				initCutsomMelee()
			else
				DelayedCalls:Add("Gilza_wait_melee_wpntweaks", 0.15, function()
					wait_for_weapon_tweaks()
				end)
			end
		end
		wait_for_weapon_tweaks()
	end

	-- this will go through every single custom weapon that i had time to tweak, executed after normal custom gun tweaks
	function WeaponTweakData:_gilza_custom_weapon_individual()
		
		local secondary_mul = 0.7
		local secondary_to_primary_mul = 1/secondary_mul
		local pickupsAR = G_W_M.ammo_pickups.ARs
		local pickupsGL = G_W_M.ammo_pickups.GLs
		local pickupsSMG = G_W_M.ammo_pickups.SMGs
		
		local function Custom_ARs()
			
			-- https://modworkshop.net/mod/23676 HK G3A3 HK79
			if self.g3hk79 then
				self.g3hk79.stats.damage = 250
				self.g3hk79.AMMO_PICKUP = {(pickupsAR._250 * 0.9) * 0.7,(pickupsAR._250 * 1.1) * 0.7}
				self.g3hk79.NR_CLIPS_MAX = 5
				self.g3hk79.AMMO_MAX = self.g3hk79.CLIP_AMMO_MAX * self.g3hk79.NR_CLIPS_MAX
				self.g3hk79.stats.recoil = 4
				G_W_M:set_new_weapon_recoil(G_W_M.recoil_stats.ARs, "g3hk79", "right", self)
				self.g3hk79.has_description = true
				self.g3hk79.HAS_BURST_AS_THIRD = true
				self.g3hk79.BURST_COUNT = 2
				self.g3hk79.fire_mode_data.burst_cooldown = self.g3hk79.fire_mode_data.fire_rate * 1.666
				self.g3hk79.burst = {fire_rate = self.g3hk79.fire_mode_data.fire_rate}
				self.g3hk79.has_description = true
				self.factory.wpn_fps_ass_g3hk79.override = self.factory.wpn_fps_ass_g3hk79.override or {}
				self.factory.wpn_fps_ass_g3hk79.override.wpn_fps_upg_a_underbarrel_hornet = {
					custom_stats = {
							rays = 20,
							ammo_pickup_min_mul = 5.5,
							ammo_pickup_max_mul = 5.5,
							base_stats_modifiers = {spread = -10,damage = -52},
							falloff_override = {near_falloff = 0,optimal_range = 100,optimal_distance = 100,near_multiplier = 1,far_multiplier = 1,far_falloff = 100},
							can_shoot_through_shield = true,
							armor_piercing_add = 1,
							can_shoot_through_enemy = true,
							muzzleflash = "effects/payday2/particles/weapons/shotgun/sho_muzzleflash_hornet",
							ignore_damage_upgrades = false,
					},
					muzzleflash = "effects/payday2/particles/weapons/shotgun/sho_muzzleflash_hornet"
				}
			end
			
			-- https://modworkshop.net/mod/35608 DT MDRX 7.62x51mm
			if self.mdr_308 then
				self.mdr_308.FIRE_MODE = "auto"
				self.mdr_308.stats.damage = 155
				self.mdr_308.AMMO_PICKUP = {(pickupsAR._155 * 0.9) * 0.7,(pickupsAR._155 * 1.1) * 0.7}
				self.mdr_308.NR_CLIPS_MAX = 6
				self.mdr_308.AMMO_MAX = self.mdr_308.CLIP_AMMO_MAX * self.mdr_308.NR_CLIPS_MAX
				self.mdr_308.stats.spread = 16
				self.mdr_308.stats.recoil = 12
				self.mdr_308.fire_mode_data = {fire_rate = 60/680}
				self.mdr_308.auto = {fire_rate = 60/680}
				self.mdr_308.HAS_BURST_AS_THIRD = false
				G_W_M:set_new_weapon_recoil(G_W_M.recoil_stats.ARs, "mdr_308", "right", self)
				-- UGL
				self.mdr_308_underbarrel.NR_CLIPS_MAX = 2
				self.mdr_308_underbarrel.AMMO_MAX = self.mdr_308_underbarrel.CLIP_AMMO_MAX * self.mdr_308_underbarrel.NR_CLIPS_MAX
				self.mdr_308_underbarrel.AMMO_PICKUP = {pickupsGL._underbarrel * 0.9, pickupsGL._underbarrel * 1.1}
				-- sniper kit barrel
				self.factory.parts.wpn_fps_ass_mdr_308_barrel_sniper.override_weapon_multiply.fire_mode_data.fire_rate = 2
				self.factory.parts.wpn_fps_ass_mdr_308_barrel_sniper.stats.recoil = -5
				self.factory.parts.wpn_fps_ass_mdr_308_barrel_sniper.stats.spread = 5
				self.factory.parts.wpn_fps_ass_mdr_308_barrel_sniper.stats.damage = nil
				self.factory.parts.wpn_fps_ass_mdr_308_barrel_sniper.stats.concealment = -4
				-- sniper kit ammo
				self.factory.parts.wpn_fps_ass_mdr_308_snp_am.stats.recoil = -2
				self.factory.parts.wpn_fps_ass_mdr_308_snp_am.stats.spread = -2
				self.factory.parts.wpn_fps_ass_mdr_308_snp_am.stats.damage = 295
				self.factory.parts.wpn_fps_ass_mdr_308_snp_am.stats.total_ammo_mod = -3.33
				self.factory.parts.wpn_fps_ass_mdr_308_snp_am.desc_id = "bm_wpn_fps_ass_mdr_308_snp_am_Gilza_desc"
				self.factory.parts.wpn_fps_ass_mdr_308_snp_am.custom_stats.ammo_pickup_max_mul = G_W_M:get_pickup_adjusments_for_wpn_mod("AR", 155, 450, true).max_mul
				self.factory.parts.wpn_fps_ass_mdr_308_snp_am.custom_stats.ammo_pickup_min_mul = G_W_M:get_pickup_adjusments_for_wpn_mod("AR", 155, 450, true).min_mul
			end
			
			-- https://modworkshop.net/mod/37996 M4A1 Grenadier
			if self.kurisumasu then
				self.kurisumasu.NR_CLIPS_MAX = 5
				self.kurisumasu.AMMO_MAX = self.kurisumasu.CLIP_AMMO_MAX * self.kurisumasu.NR_CLIPS_MAX
				self.kurisumasu.stats.spread = 11
				self.kurisumasu.stats.recoil = 18
				G_W_M:set_new_weapon_recoil(G_W_M.recoil_stats.ARs, "kurisumasu", "right", self)
				self.kurisumasu.timers.reload_not_empty = 2.92
				self.kurisumasu.timers.reload_empty = 3.7
				self.kurisumasu.has_description = true
				self.kurisumasu.HAS_BURST_AS_THIRD = true
				self.kurisumasu.BURST_COUNT = 3
				self.kurisumasu.fire_mode_data.burst_cooldown = self.kurisumasu.fire_mode_data.fire_rate * 2
				self.kurisumasu.burst = {fire_rate = self.kurisumasu.fire_mode_data.fire_rate}
				self.kurisumasu.has_description = true
				-- parts
				self.factory.parts.wpn_fps_ass_kurisumasu_s_sopmod.stats.recoil = 3
				self.factory.parts.wpn_fps_ass_kurisumasu_s_sopmod.stats.spread = 1
				self.factory.parts.wpn_fps_ass_kurisumasu_s_sopmod.stats.concealment = -4
				self.factory.parts.wpn_fps_ass_kurisumasu_s_m4ss.stats.recoil = -1
				self.factory.parts.wpn_fps_ass_kurisumasu_s_m4ss.stats.spread = 3
				self.factory.parts.wpn_fps_ass_kurisumasu_s_m4ss.stats.concealment = -3
				-- m16 barrel from an addon mod - https://modworkshop.net/mod/40785
				if self.factory.parts.wpn_fps_ass_kurisumasu_b_m16 then
					self.factory.parts.wpn_fps_ass_kurisumasu_b_m16.stats.spread = 1
					self.factory.parts.wpn_fps_ass_kurisumasu_b_m16.stats.recoil = 1
				end
			end
			
			-- https://modworkshop.net/mod/17243 SKS
			if self.sks then
				self.sks.NR_CLIPS_MAX = 8
				self.sks.AMMO_MAX = self.sks.CLIP_AMMO_MAX * self.sks.NR_CLIPS_MAX
				self.sks.fire_mode_data = {fire_rate = 60/355}
				self.sks.single = {fire_rate = 60/355}
				self.sks.stats.spread = 21
				self.sks.stats.recoil = 11
				self.sks.stats.concealment = 20
				G_W_M:set_new_weapon_recoil(G_W_M.recoil_stats.ARs, "sks", "left", self)
				-- parts
				self.factory.parts.wpn_fps_upg_sks_sightrail_long.stats.recoil = nil
				self.factory.parts.wpn_fps_upg_sks_mag_detach10.stats.total_ammo_mod = -2.5
				self.factory.parts.wpn_fps_upg_sks_mag_detach10.stats.recoil = -1
				self.factory.parts.wpn_fps_upg_sks_mag_detach20.stats.total_ammo_mod = -5
				self.factory.parts.wpn_fps_upg_sks_mag_detach20.stats.spread = -1
				self.factory.parts.wpn_fps_upg_sks_mag_detach20.stats.recoil = 3
				self.factory.parts.wpn_fps_upg_sks_mag_detach20.stats.reload = -4
				self.factory.parts.wpn_fps_upg_sks_bayonet.stats = {
					min_damage = 5,
					max_damage = 5,
					min_damage_effect = 8,
					max_damage_effect = 8,
					concealment = -2,
					value = 1
				}
				self.factory.parts.wpn_fps_upg_sks_bayonet.has_description = true
				self.factory.parts.wpn_fps_upg_sks_bayonet.desc_id = "bm_wp_mosin_ns_bayonet_desc"
				self.factory.parts.wpn_fps_upg_sks_barrel_med.stats.damage = -200
				self.factory.parts.wpn_fps_upg_sks_barrel_med.stats.concealment = 2
				self.factory.parts.wpn_fps_upg_sks_barrel_med.stats.recoil = 9
				self.factory.parts.wpn_fps_upg_sks_barrel_med.stats.spread = 3
				self.factory.parts.wpn_fps_upg_sks_barrel_med.custom_stats = {
					ammo_pickup_max_mul = G_W_M:get_pickup_adjusments_for_wpn_mod("AR", 450, 250).max_mul,
					ammo_pickup_min_mul = G_W_M:get_pickup_adjusments_for_wpn_mod("AR", 450, 250).min_mul,
					fire_rate_multiplier = 1.549295774
				}
				self.factory.parts.wpn_fps_upg_sks_barrel_med.has_description = true
				self.factory.parts.wpn_fps_upg_sks_barrel_med.desc_id = "bm_wpn_fps_damage_class_update_increase"
				self.factory.parts.wpn_fps_upg_sks_barrel_short.stats.concealment = 5
				self.factory.parts.wpn_fps_upg_sks_barrel_short.stats.reload = 2
				self.factory.parts.wpn_fps_upg_sks_barrel_short.stats.recoil = 2
				self.factory.parts.wpn_fps_upg_sks_barrel_short.stats.spread = -4
			end
			
			-- https://modworkshop.net/mod/35603 XR-2
			if self.xr2 then
				self.xr2.stats.spread = 17
				self.xr2.stats.recoil = 12
				G_W_M:set_new_weapon_recoil(G_W_M.recoil_stats.ARs, "xr2", "right", self)
				self.xr2.timers.reload_not_empty = 2.2
				-- parts
				self.factory.parts.wpn_fps_upg_xr2_upperrec_01.stats.spread = 2
				self.factory.parts.wpn_fps_upg_xr2_upperrec_01.stats.recoil = -3
				self.factory.parts.wpn_fps_upg_xr2_upperrec_01.stats.damage = 2
				self.factory.parts.wpn_fps_upg_xr2_upperrec_02.stats.damage = 4
				self.factory.parts.wpn_fps_upg_xr2_upperrec_02.stats.spread = -3
				self.factory.parts.wpn_fps_upg_xr2_upperrec_02.stats.recoil = 3
				self.factory.parts.wpn_fps_upg_xr2_mag_ext_01.stats.reload = -3
				self.factory.parts.wpn_fps_upg_xr2_mag_ext_01.has_description = false
				self.factory.parts.wpn_fps_upg_xr2_mag_ext_02.stats.reload = -5
				self.factory.parts.wpn_fps_upg_xr2_mag_ext_02.has_description = false
				self.factory.parts.wpn_fps_upg_xr2_mag_fast_01.stats.spread = -1
				self.factory.parts.wpn_fps_upg_xr2_mag_fast_01.has_description = false
				self.factory.parts.wpn_fps_upg_xr2_handle_01.stats.recoil = 2
				self.factory.parts.wpn_fps_upg_xr2_handle_01.stats.damage = nil
				self.factory.parts.wpn_fps_upg_xr2_handle_02.stats.spread = -1
				self.factory.parts.wpn_fps_upg_xr2_handle_02.stats.spread = -2
				self.factory.parts.wpn_fps_upg_xr2_handle_02.stats.damage = nil
				self.factory.parts.wpn_fps_upg_xr2_barrel_01.stats.damage = 200
				self.factory.parts.wpn_fps_upg_xr2_barrel_01.stats.total_ammo_mod = -7.14
				self.factory.parts.wpn_fps_upg_xr2_barrel_01.custom_stats.ammo_pickup_max_mul = G_W_M:get_pickup_adjusments_for_wpn_mod("AR", 250, 450).max_mul
				self.factory.parts.wpn_fps_upg_xr2_barrel_01.custom_stats.ammo_pickup_min_mul = G_W_M:get_pickup_adjusments_for_wpn_mod("AR", 250, 450).min_mul
				self.factory.parts.wpn_fps_upg_xr2_barrel_01.desc_id = "bm_wpn_fps_damage_class_update_decrease"
				self.factory.parts.wpn_fps_upg_xr2_barrel_02.stats.damage = -50
				self.factory.parts.wpn_fps_upg_xr2_barrel_02.stats.total_ammo_mod = 5
				self.factory.parts.wpn_fps_upg_xr2_barrel_02.custom_stats.ammo_pickup_max_mul = G_W_M:get_pickup_adjusments_for_wpn_mod("AR", 250, 200).max_mul
				self.factory.parts.wpn_fps_upg_xr2_barrel_02.custom_stats.ammo_pickup_min_mul = G_W_M:get_pickup_adjusments_for_wpn_mod("AR", 250, 200).min_mul
				self.factory.parts.wpn_fps_upg_xr2_barrel_02.desc_id = "bm_wpn_fps_damage_class_update_increase"
			end
			
			-- https://modworkshop.net/mod/40135 Stoner 63A LMG & AR
			if self.stoner63a_rifle then
				self.stoner63a_rifle.stats.damage = 155
				self.stoner63a_rifle.AMMO_PICKUP = {pickupsAR._155 * 0.9,pickupsAR._155 * 1.1}
				self.stoner63a_rifle.stats.recoil = 21
				G_W_M:set_new_weapon_recoil(G_W_M.recoil_stats.ARs, "stoner63a_rifle", "left", self)
				self.stoner63a_rifle.stats.spread = 14
				self.stoner63a_rifle.NR_CLIPS_MAX = 5
				self.stoner63a_rifle.AMMO_MAX = self.stoner63a_rifle.CLIP_AMMO_MAX * self.stoner63a_rifle.NR_CLIPS_MAX
				-- parts
				self.factory.parts.wpn_fps_ass_stoner63a_rifle_magazine_xmag.stats.reload = -5
				self.factory.parts.wpn_fps_ass_stoner63a_rifle_magazine_xmag.stats.spread = -1
				self.factory.parts.wpn_fps_ass_stoner63a_rifle_magazine_xmag.stats.recoil = 2
			end
			
			-- https://modworkshop.net/mod/36582 SIG Sauer MCX SPEAR/XM7 NGSW-R
			if self.mcx_spear then
				self.mcx_spear.HAS_BURST_AS_THIRD = false
				self.mcx_spear.has_description = true
				self.mcx_spear.stats.damage = 200
				self.mcx_spear.AMMO_PICKUP = {pickupsAR._200 * 0.9,pickupsAR._200 * 1.1}
				self.mcx_spear.NR_CLIPS_MAX = 6
				self.mcx_spear.AMMO_MAX = self.mcx_spear.CLIP_AMMO_MAX * self.mcx_spear.NR_CLIPS_MAX
				self.mcx_spear.stats.spread = 19
				self.mcx_spear.stats.recoil = 8
				G_W_M:set_new_weapon_recoil(G_W_M.recoil_stats.ARs, "mcx_spear", "left", self)
				-- parts
				self.factory.parts.wpn_fps_ass_mcx_spear_am_default.stats.total_ammo_mod = nil
				self.factory.parts.wpn_fps_ass_mcx_spear_am_default.stats.recoil = 0
				self.factory.parts.wpn_fps_ass_mcx_spear_am_default.custom_stats.ammo_pickup_min_mul = 0.6
				self.factory.parts.wpn_fps_ass_mcx_spear_am_default.custom_stats.ammo_pickup_max_mul = 0.6
				self.factory.parts.wpn_fps_ass_mcx_spear_am_creedmoor.custom_stats = {armor_piercing_add=0, can_shoot_through_enemy=false, can_shoot_through_shield=false, can_shoot_through_wall=false}
				self.factory.parts.wpn_fps_ass_mcx_spear_am_creedmoor.stats.total_ammo_mod = 3.33
				self.factory.parts.wpn_fps_ass_mcx_spear_am_creedmoor.stats.damage = nil
				self.factory.parts.wpn_fps_ass_mcx_spear_am_creedmoor.stats.recoil = 2
				self.factory.parts.wpn_fps_ass_mcx_spear_am_762.custom_stats = {armor_piercing_add=0, can_shoot_through_enemy=false, can_shoot_through_shield=false, can_shoot_through_wall=false}
				self.factory.parts.wpn_fps_ass_mcx_spear_am_762.custom_stats.ammo_pickup_max_mul = G_W_M:get_pickup_adjusments_for_wpn_mod("AR", 200, 155).max_mul
				self.factory.parts.wpn_fps_ass_mcx_spear_am_762.custom_stats.ammo_pickup_min_mul = G_W_M:get_pickup_adjusments_for_wpn_mod("AR", 200, 155).min_mul
				self.factory.parts.wpn_fps_ass_mcx_spear_am_762.stats.damage = -45
				self.factory.parts.wpn_fps_ass_mcx_spear_am_762.stats.total_ammo_mod = 10
				self.factory.parts.wpn_fps_ass_mcx_spear_am_762.stats.spread = -2
				self.factory.parts.wpn_fps_ass_mcx_spear_barrel_marksman.custom_stats.ammo_pickup_max_mul = G_W_M:get_pickup_adjusments_for_wpn_mod("AR", 200, 250).max_mul
				self.factory.parts.wpn_fps_ass_mcx_spear_barrel_marksman.custom_stats.ammo_pickup_min_mul = G_W_M:get_pickup_adjusments_for_wpn_mod("AR", 200, 250).min_mul
				self.factory.parts.wpn_fps_ass_mcx_spear_barrel_marksman.stats.spread = 0
				self.factory.parts.wpn_fps_ass_mcx_spear_barrel_marksman.stats.recoil = 0
				self.factory.parts.wpn_fps_ass_mcx_spear_barrel_marksman.perks = nil
				table.insert(self.factory.parts.wpn_fps_ass_mcx_spear_barrel_marksman.forbids, "wpn_fps_ass_mcx_spear_am_762")
				self.factory.parts.wpn_fps_ass_mcx_spear_suppressor.stats.spread = 1
				self.factory.parts.wpn_fps_ass_mcx_spear_suppressor.stats.recoil = 1
				self.factory.parts.wpn_fps_ass_mcx_spear_suppressor.stats.concealment = 0
				self.factory.parts.wpn_fps_ass_mcx_spear_grip_lt.stats.spread = 0
				self.factory.parts.wpn_fps_ass_mcx_spear_grip_lt.stats.concealment = 0
				self.factory.parts.wpn_fps_ass_mcx_spear_stock.stats.recoil = 0
				self.factory.parts.wpn_fps_ass_mcx_spear_vg.stats.spread = 0
				self.factory.parts.wpn_fps_ass_mcx_spear_vg.stats.recoil = 0
				self.factory.parts.wpn_fps_ass_mcx_spear_magazine.stats.reload = 0
				self.factory.parts.wpn_fps_ass_mcx_spear_magazine_l7awm.stats.reload = -2
				self.factory.parts.wpn_fps_ass_mcx_spear_magazine_l7awm.stats.concealment = -2
				self.factory.parts.wpn_fps_ass_mcx_spear_magazine_l7awm.override_weapon_add = {CLIP_AMMO_MAX = 5}
				self.factory.parts.wpn_fps_ass_mcx_spear_magazine_pmag.stats.reload = -5
				self.factory.parts.wpn_fps_ass_mcx_spear_magazine_pmag.stats.recoil = 1
				self.factory.parts.wpn_fps_ass_mcx_spear_magazine_pmag.stats.concealment = -3
				self.factory.parts.wpn_fps_ass_mcx_spear_magazine_pmag.override_weapon_add = {CLIP_AMMO_MAX = 10}
				self.factory.parts.wpn_fps_ass_mcx_spear_magazine_meme.stats.reload = -3
				self.factory.parts.wpn_fps_ass_mcx_spear_magazine_meme.stats.spread = 1
				self.factory.parts.wpn_fps_ass_mcx_spear_magazine_meme.stats.recoil = -1
				self.factory.parts.wpn_fps_ass_mcx_spear_magazine_meme.override_weapon_add = {CLIP_AMMO_MAX = 5}
			end
			
			-- https://modworkshop.net/mod/32588 Defiance Blast Rifle
			if self.blast and self.factory.parts.wpn_fps_ass_blast_barrel then
				self.blast.has_description = true
				self.blast.CLIP_AMMO_MAX = 40
				self.blast.NR_CLIPS_MAX = 5
				self.blast.AMMO_MAX = self.blast.CLIP_AMMO_MAX * self.blast.NR_CLIPS_MAX
				self.blast.stats.spread = 22
				self.blast.stats.recoil = 5
				G_W_M:set_new_weapon_recoil(G_W_M.recoil_stats.ARs, "blast", "left", self)
				self.blast.stats.damage = 51
				self.blast.AMMO_PICKUP = {pickupsAR._155 * 0.9,pickupsAR._155 * 1.1}
				self.blast.rays = 3
				-- parts
				self.factory.parts.wpn_fps_upg_blast_barrel_apex.stats.damage = 0
				self.factory.parts.wpn_fps_upg_blast_barrel_bulwark.stats.damage = 0
				self.factory.parts.wpn_fps_upg_blast_barrel_powerbore.stats.damage = 0
				self.factory.parts.wpn_fps_upg_blast_bayonet.stats = {min_damage = 5,max_damage = 5,min_damage_effect = 8,max_damage_effect = 8,concealment = -2,value = 1}
				self.factory.parts.wpn_fps_upg_blast_bayonet.desc_id = "bm_wp_mosin_ns_bayonet_desc"
				self.factory.parts.wpn_fps_upg_blast_bayonet_grn.stats = {min_damage = 5,max_damage = 5,min_damage_effect = 8,max_damage_effect = 8,concealment = -2,value = 1}
				self.factory.parts.wpn_fps_upg_blast_bayonet_grn.desc_id = "bm_wp_mosin_ns_bayonet_desc"
				self.factory.parts.wpn_fps_upg_blast_bayonet_red.stats = {min_damage = 5,max_damage = 5,min_damage_effect = 8,max_damage_effect = 8,concealment = -2,value = 1}
				self.factory.parts.wpn_fps_upg_blast_bayonet_red.desc_id = "bm_wp_mosin_ns_bayonet_desc"
				self.factory.parts.wpn_fps_upg_blast_bayonet_ylw.stats = {min_damage = 5,max_damage = 5,min_damage_effect = 8,max_damage_effect = 8,concealment = -2,value = 1}
				self.factory.parts.wpn_fps_upg_blast_bayonet_ylw.desc_id = "bm_wp_mosin_ns_bayonet_desc"
				self.factory.wpn_fps_ass_blast.override = {wpn_fps_upg_i_singlefire = {},wpn_fps_upg_i_autofire = {}}
				self.factory.wpn_fps_ass_blast.override.wpn_fps_upg_i_singlefire.stats = {spread = 2,recoil = -3,value = 5}
				self.factory.wpn_fps_ass_blast.override.wpn_fps_upg_i_autofire.stats = {value = 8,spread = -3,recoil = 3}
				self.factory.parts.wpn_fps_upg_blast_mag_size.stats.extra_ammo = 10
				self.factory.parts.wpn_fps_upg_blast_mag_size.stats.reload = -5
				self.factory.parts.wpn_fps_upg_blast_mag_fast.stats.reload = 7
				self.factory.parts.wpn_fps_upg_blast_ammo_syphon.stats.damage = 104
				self.factory.parts.wpn_fps_upg_blast_ammo_syphon.stats.total_ammo_mod = -4
				self.factory.parts.wpn_fps_upg_blast_ammo_syphon.stats.spread = 0
				self.factory.parts.wpn_fps_upg_blast_ammo_syphon.stats.recoil = 0
				self.factory.parts.wpn_fps_upg_blast_ammo_syphon.custom_stats.rays = 1
				self.factory.parts.wpn_fps_upg_blast_ammo_syphon.custom_stats.ammo_pickup_max_mul = 0.65
				self.factory.parts.wpn_fps_upg_blast_ammo_syphon.custom_stats.ammo_pickup_min_mul = 0.65
				self.factory.parts.wpn_fps_upg_blast_ammo_ap.stats.total_ammo_mod = -4
				self.factory.parts.wpn_fps_upg_blast_ammo_ap.stats.damage = 0
				self.factory.parts.wpn_fps_upg_blast_ammo_ap.stats.recoil = 2
				self.factory.parts.wpn_fps_upg_blast_ammo_ap.stats.spread = -1
				self.factory.parts.wpn_fps_upg_blast_ammo_ap.custom_stats.can_shoot_through_wall = true
				self.factory.parts.wpn_fps_upg_blast_ammo_ap.custom_stats.ammo_pickup_max_mul = 0.6
				self.factory.parts.wpn_fps_upg_blast_ammo_ap.custom_stats.ammo_pickup_min_mul = 0.6
				self.factory.parts.wpn_fps_upg_blast_ammo_fire.custom_stats = {
					armor_piercing_add = 1,
					can_shoot_through_shield = true,
					muzzleflash = "effects/payday2/particles/weapons/shotgun/sho_muzzleflash_dragons_breath",
					damage_far_mul = 1,
					damage_near_mul = 1,
					ammo_pickup_max_mul = 0.6,
					ammo_pickup_min_mul = 0.6,
					bullet_class = "FlameBulletBase",
					rays = 3,
					dot_data_name = "ammo_blast_rifle_fire"
				}
				self.factory.parts.wpn_fps_upg_blast_ammo_fire.stats = {value = 5,total_ammo_mod = -6,spread = -4,recoil = -3}
				self.factory.parts.wpn_fps_upg_blast_ammo_poison.stats = {
					value = 5,
					total_ammo_mod = -6,
					damage = -25,
					spread = 1
				}
				self.factory.parts.wpn_fps_upg_blast_ammo_poison.custom_stats = {
					armor_piercing_add = 1,
					can_shoot_through_enemy = true,
					muzzleflash = "effects/payday2/particles/weapons/shotgun/sho_muzzleflash_rip",
					dot_data_name = "ammo_blast_rifle_rip",
					damage_far_mul = 1,
					ammo_pickup_max_mul = 0.8,
					ammo_pickup_min_mul = 0.8,
					damage_near_mul = 1,
					bullet_class = "PoisonBulletBase"
				}
				self.factory.parts.wpn_fps_upg_blast_ammo_stun.stats = {value = 5,total_ammo_mod = -4,spread = -5,recoil = 16}
				self.factory.parts.wpn_fps_upg_blast_ammo_stun.custom_stats.ammo_pickup_min_mul = 1.2
				self.factory.parts.wpn_fps_upg_blast_ammo_stun.custom_stats.ammo_pickup_max_mul = 1.2
			end
			
			-- https://modworkshop.net/mod/19357 HK416
			if self.hk416 then
				self.hk416.stats.spread = 16
				self.hk416.HAS_BURST_AS_THIRD = false
			end
		
		end
		Custom_ARs()
		
		local function Custom_SNIPERs()
			
			-- https://modworkshop.net/mod/17368 L115
			if self.l115 then
				self.l115.NR_CLIPS_MAX = 4
				self.l115.AMMO_MAX = self.l115.CLIP_AMMO_MAX * self.l115.NR_CLIPS_MAX
				self.factory.parts.wpn_fps_upg_l115_stock_ax.stats.spread = -1
			end
			
			-- https://modworkshop.net/mod/42220 MW2022 Marlin Model 336
			if self.sbeta then
				self.sbeta.NR_CLIPS_MAX = 5
				self.sbeta.AMMO_MAX = self.sbeta.CLIP_AMMO_MAX * self.sbeta.NR_CLIPS_MAX
				self.sbeta.fire_mode_data = {fire_rate = 60/85}
				self.sbeta.single = {fire_rate = 60/85}
				self.sbeta.stats.recoil = 13
				G_W_M:set_new_weapon_recoil(G_W_M.recoil_stats.SNIPERs, "sbeta", "right", self)
				self.sbeta.stats.reload = 14
				-- starts scopeless
				table.delete(Gilza.customSnipersToUpdateScopesFor, "sbeta")
				self.sbeta.stats.concealment = self.sbeta.stats.concealment + 1
				-- parts
				local default_parts = {
					"wpn_fps_snp_sbeta_barrel",
					"wpn_fps_snp_sbeta_lever",
					"wpn_fps_snp_sbeta_handguard",
					"wpn_fps_snp_sbeta_irons",				
					"wpn_fps_snp_sbeta_magazine",
					"wpn_fps_snp_sbeta_receiver",
					"wpn_fps_snp_sbeta_stock",
				}
				for _, part in pairs(default_parts) do
					if self.factory.parts[part] then
						self.factory.parts[part].stats.damage = nil
						self.factory.parts[part].stats.spread = nil
						self.factory.parts[part].stats.recoil = nil
						self.factory.parts[part].stats.concealment = nil
						self.factory.parts[part].stats.suppression = nil
					end
				end
				self.factory.parts.wpn_fps_snp_sbeta_barrel_fluted.stats.spread = 0
				self.factory.parts.wpn_fps_snp_sbeta_barrel_fluted.stats.recoil = 2
				self.factory.parts.wpn_fps_snp_sbeta_barrel_heavy.stats.spread = -1
				self.factory.parts.wpn_fps_snp_sbeta_barrel_heavy.stats.damage = nil
				self.factory.parts.wpn_fps_snp_sbeta_barrel_heavy.stats.total_ammo_mod = nil
				self.factory.parts.wpn_fps_snp_sbeta_barrel_heavy.stats.reload = -2
				self.factory.parts.wpn_fps_snp_sbeta_barrel_short.stats.damage = nil
				self.factory.parts.wpn_fps_snp_sbeta_barrel_short.stats.spread = -2
				self.factory.parts.wpn_fps_snp_sbeta_barrel_short.stats.total_ammo_mod = nil
				self.factory.parts.wpn_fps_snp_sbeta_barrel_short.stats.reload = 4
				self.factory.parts.wpn_fps_snp_sbeta_barrel_short.stats.concealment = 2
				self.factory.parts.wpn_fps_snp_sbeta_barrel_sil.stats.damage = -3
				self.factory.parts.wpn_fps_snp_sbeta_barrel_sil.stats.concealment = 2
				self.factory.parts.wpn_fps_snp_sbeta_barrel_sil.stats.total_ammo_mod = nil
				self.factory.parts.wpn_fps_snp_sbeta_barrel_sn.stats.damage = nil
				self.factory.parts.wpn_fps_snp_sbeta_barrel_sn.stats.spread = 1
				self.factory.parts.wpn_fps_snp_sbeta_barrel_sn.stats.concealment = -1
			end
		
		end
		Custom_SNIPERs()
		
		local function Custom_SMGs()
			
			-- https://modworkshop.net/mod/51546 Payday 3 Tribune 32
			if self.tribune32 then
				self.tribune32.has_description = true
				self.tribune32.stats.damage = 155
				self.tribune32.AMMO_PICKUP = {(pickupsSMG._155 * 0.9) * secondary_mul,(pickupsSMG._155 * 1.1) * secondary_mul}
				self.tribune32.stats.recoil = 19
				G_W_M:set_new_weapon_recoil(G_W_M.recoil_stats.SMGs, "tribune32", "right", self)
				self.tribune32.stats.reload = 9
				-- akimbos
				self.x_tribune32.has_description = true
				self.x_tribune32.stats.damage = 78
				self.x_tribune32.AMMO_PICKUP = {pickupsSMG._155 * 0.9 * 2, pickupsSMG._155 * 1.1 * 2}
				self.x_tribune32.NR_CLIPS_MAX = 2.25
				self.x_tribune32.AMMO_MAX = self.x_tribune32.CLIP_AMMO_MAX * self.x_tribune32.NR_CLIPS_MAX
				self.x_tribune32.stats.recoil = 19
				G_W_M:set_new_weapon_recoil(G_W_M.recoil_stats.SMGs, "x_tribune32", "right", self)
				-- parts
				-- remove the dumbass thing where default parts add stats, leading to attachments being useless/confusing in most cases
				local default_parts = {
					"wpn_fps_smg_tribune32_barrel",
					"wpn_fps_smg_tribune32_bolt", 
					"wpn_fps_smg_tribune32_charging_handle",
					"wpn_fps_smg_tribune32_flash_hider", 
					"wpn_fps_smg_tribune32_irons",
					"wpn_fps_smg_tribune32_optic_rail",
					"wpn_fps_smg_tribune32_receiver_lower",
					"wpn_fps_smg_tribune32_receiver_upper",
					"wpn_fps_smg_tribune32_magazine_release",
					"wpn_fps_smg_tribune32_magazine",
					"wpn_fps_smg_tribune32_stock",
					"wpn_fps_smg_tribune32_stock_adapter",
				}
				for _, part in pairs(default_parts) do
					if self.factory.parts[part] then
						self.factory.parts[part].stats.damage = nil
						self.factory.parts[part].stats.spread = nil
						self.factory.parts[part].stats.recoil = nil
						self.factory.parts[part].stats.concealment = nil
						self.factory.parts[part].stats.suppression = nil
					end
				end
				-- mags
				self.factory.parts.wpn_fps_smg_tribune32_magazine_short.stats.reload = 6
				self.factory.parts.wpn_fps_smg_tribune32_magazine_fool.stats.reload = -3
				self.factory.parts.wpn_fps_smg_tribune32_magazine_speedpull.stats.reload = 3
				self.factory.parts.wpn_fps_smg_tribune32_xmag.stats.reload = -3
				-- akimbo mag overrides
				self.factory.wpn_fps_smg_x_tribune32.override.wpn_fps_smg_tribune32_magazine_short = self.factory.wpn_fps_smg_x_tribune32.override.wpn_fps_smg_tribune32_magazine_short or {stats={}}
				self.factory.wpn_fps_smg_x_tribune32.override.wpn_fps_smg_tribune32_magazine_short.stats.reload = 6
				self.factory.wpn_fps_smg_x_tribune32.override.wpn_fps_smg_tribune32_magazine_fool = self.factory.wpn_fps_smg_x_tribune32.override.wpn_fps_smg_tribune32_magazine_fool or {stats={}}
				self.factory.wpn_fps_smg_x_tribune32.override.wpn_fps_smg_tribune32_magazine_fool.stats.reload = -3
				self.factory.wpn_fps_smg_x_tribune32.override.wpn_fps_smg_tribune32_magazine_speedpull = self.factory.wpn_fps_smg_x_tribune32.override.wpn_fps_smg_tribune32_magazine_speedpull or {stats={}}
				self.factory.wpn_fps_smg_x_tribune32.override.wpn_fps_smg_tribune32_magazine_speedpull.stats.reload = 3
				self.factory.wpn_fps_smg_x_tribune32.override.wpn_fps_smg_tribune32_magazine_speedpull.stats.concealment = -2
				self.factory.wpn_fps_smg_x_tribune32.override.wpn_fps_smg_tribune32_xmag = self.factory.wpn_fps_smg_x_tribune32.override.wpn_fps_smg_tribune32_xmag or {stats={}}
				self.factory.wpn_fps_smg_x_tribune32.override.wpn_fps_smg_tribune32_xmag.stats.reload = -3
			end
			
			-- https://modworkshop.net/mod/36055 Typhoon
			if self.crysis3_typhoon then
				self.crysis3_typhoon.rays = 5
				self.crysis3_typhoon.CLIP_AMMO_MAX = 140
				self.crysis3_typhoon.NR_CLIPS_MAX = 2.5
				self.crysis3_typhoon.AMMO_MAX = self.crysis3_typhoon.CLIP_AMMO_MAX * self.crysis3_typhoon.NR_CLIPS_MAX
				self.crysis3_typhoon.FIRE_MODE = "auto"
				self.crysis3_typhoon.fire_mode_data = {fire_rate = 60/1700}
				self.crysis3_typhoon.stats.damage = 14
				self.crysis3_typhoon.AMMO_PICKUP = {(pickupsSMG._71 * 0.9) * secondary_mul,(pickupsSMG._71 * 1.1) * secondary_mul}
				self.crysis3_typhoon.stats.spread = 15
				self.crysis3_typhoon.stats.recoil = 21
				self.crysis3_typhoon.stats.reload = 14
				G_W_M:set_new_weapon_recoil(G_W_M.recoil_stats.SMGs, "crysis3_typhoon", "left", self)
				self.crysis3_typhoon.stats.concealment = 15
				self.crysis3_typhoon.has_description = true
				-- parts
				if self.factory.wpn_fps_smg_crysis3_typhoon then
					self.factory.wpn_fps_smg_crysis3_typhoon.override = {wpn_fps_upg_i_singlefire = {},wpn_fps_upg_i_autofire = {}}
					self.factory.wpn_fps_smg_crysis3_typhoon.override.wpn_fps_upg_i_singlefire.stats = {spread = 2,recoil = -3,value = 5}
					self.factory.wpn_fps_smg_crysis3_typhoon.override.wpn_fps_upg_i_autofire.stats = {value = 8,spread = -3,recoil = 3}
					table.delete(self.factory.wpn_fps_smg_crysis3_typhoon.uses_parts, "wpn_fps_upg_a_custom")
					table.delete(self.factory.wpn_fps_smg_crysis3_typhoon.uses_parts, "wpn_fps_upg_a_custom_free")
					table.delete(self.factory.wpn_fps_smg_crysis3_typhoon.uses_parts, "wpn_fps_upg_a_dragons_breath")
				end
			end
			
		end
		Custom_SMGs()
		
		local function Custom_PISTOLs()
			
			-- https://modworkshop.net/mod/42438 MW2022 S&W Model 500
			if self.swhiskey then
				self.swhiskey.NR_CLIPS_MAX = 7
				self.swhiskey.AMMO_MAX = self.swhiskey.CLIP_AMMO_MAX * self.swhiskey.NR_CLIPS_MAX
				self.swhiskey.stats.spread = 19
				Gilza.shotgun_minimal_damage_multipliers.swhiskey = 0.67
				-- parts
				self.factory.parts.wpn_fps_pis_swhiskey_trigger_hair.stats.recoil = 5
				self.factory.parts.wpn_fps_pis_swhiskey_trigger_hair.stats.spread = -3
				self.factory.parts.wpn_fps_pis_swhiskey_trigger_hair.custom_stats = {fire_rate_multiplier = 1.1}
				self.factory.parts.wpn_fps_pis_swhiskey_trigger_heavy.stats.recoil = 1
				self.factory.parts.wpn_fps_pis_swhiskey_trigger_heavy.stats.spread = 1
				self.factory.parts.wpn_fps_pis_swhiskey_trigger_heavy.custom_stats = {fire_rate_multiplier = 0.95}
				self.factory.parts.wpn_fps_pis_swhiskey_trigger_heavy.has_description = false
				self.factory.parts.wpn_fps_pis_swhiskey_trigger_light.stats.recoil = 1
				self.factory.parts.wpn_fps_pis_swhiskey_trigger_light.stats.spread = -1
				self.factory.parts.wpn_fps_pis_swhiskey_trigger_light.custom_stats = {fire_rate_multiplier = 1.05}
				self.factory.parts.wpn_fps_pis_swhiskey_barrel_short.stats.spread = -3
				self.factory.parts.wpn_fps_pis_swhiskey_barrel_mini.stats.spread = -4
				self.factory.parts.wpn_fps_pis_swhiskey_barrel_long.stats.damage = nil
				self.factory.parts.wpn_fps_pis_swhiskey_barrel_long.stats.reload = -1
				self.factory.parts.wpn_fps_pis_swhiskey_barrel_heavy_long.stats.damage = nil
				self.factory.parts.wpn_fps_pis_swhiskey_barrel_heavy_long.stats.reload = -1
				self.factory.parts.wpn_fps_pis_swhiskey_am_piercing.stats.damage = nil
				self.factory.parts.wpn_fps_pis_swhiskey_am_piercing.stats.total_ammo_mod = -5.71
				self.factory.parts.wpn_fps_pis_swhiskey_am_piercing.custom_stats.ammo_pickup_min_mul = 0.6
				self.factory.parts.wpn_fps_pis_swhiskey_am_piercing.custom_stats.ammo_pickup_max_mul = 0.6
				self.factory.parts.wpn_fps_pis_swhiskey_am_snakeshot.stats.damage = -125
				self.factory.parts.wpn_fps_pis_swhiskey_am_snakeshot.stats.spread = -15
				self.factory.parts.wpn_fps_pis_swhiskey_am_snakeshot.stats.total_ammo_mod = -8.57
				self.factory.parts.wpn_fps_pis_swhiskey_am_snakeshot.custom_stats.ammo_pickup_max_mul = 1.3235294117647
				self.factory.parts.wpn_fps_pis_swhiskey_am_snakeshot.custom_stats.ammo_pickup_min_mul = 1.3235294117647
				self.factory.parts.wpn_fps_pis_swhiskey_am_snakeshot.custom_stats.falloff_override = {optimal_distance = 0, optimal_range = 1000, near_falloff = 0, far_falloff = 900, near_mul = 1, far_mul = 0.5, _meta = "falloff_override"}
			end
			
		end
		Custom_PISTOLs()
		
		local function Custom_LMGs()
			
			-- https://modworkshop.net/mod/40135 Stoner 63A LMG & AR
			if self.stoner63a then
				self.stoner63a.CLIP_AMMO_MAX = 150
				self.stoner63a.NR_CLIPS_MAX = 3
				self.stoner63a.AMMO_MAX = self.stoner63a.CLIP_AMMO_MAX * self.stoner63a.NR_CLIPS_MAX
				self.stoner63a.stats.recoil = 11
				G_W_M:set_new_weapon_recoil(G_W_M.recoil_stats.LMGs, "stoner63a", "left", self)
				self.stoner63a.stats.reload = 13
				-- parts
				self.factory.parts.wpn_fps_lmg_stoner63a_barrel.stats.damage = nil
				self.factory.parts.wpn_fps_lmg_stoner63a_barrel.stats.spread = nil
				self.factory.parts.wpn_fps_lmg_stoner63a_barrel.stats.recoil = nil
				self.factory.parts.wpn_fps_lmg_stoner63a_barrel.stats.concealment = nil
				self.factory.parts.wpn_fps_lmg_stoner63a_barrel.hidden = true
			end
			
			-- https://modworkshop.net/mod/48405 PAYDAY 3 - Blyspruta MX63 Light Machine Gun
			if self.mx63 then
				self.mx63.NR_CLIPS_MAX = 3
				self.mx63.AMMO_MAX = self.mx63.CLIP_AMMO_MAX * self.mx63.NR_CLIPS_MAX
				self.mx63.stats.recoil = 12
				G_W_M:set_new_weapon_recoil(G_W_M.recoil_stats.LMGs, "mx63", "right", self)
			end
			
			-- https://modworkshop.net/mod/54327 Crosskill Sawblade (Colt LMG)
			if self.lsw then
				self.lsw.fire_mode_data = {fire_rate = 60/650}
				self.lsw.stats.spread = 11
				self.lsw.stats.recoil = 11
				G_W_M:set_new_weapon_recoil(G_W_M.recoil_stats.LMGs, "lsw", "left", self)
				self.lsw.NR_CLIPS_MAX = 9
				self.lsw.AMMO_MAX = self.lsw.CLIP_AMMO_MAX * self.lsw.NR_CLIPS_MAX
				self.lsw.stats.concealment = 5
				-- parts
				self.factory.parts.wpn_fps_lmg_lsw_m_drum.stats.spread = -2
				self.factory.parts.wpn_fps_lmg_lsw_m_drum.stats.recoil = 4
				self.factory.parts.wpn_fps_lmg_lsw_m_drum.stats.reload = -5
				self.factory.parts.wpn_fps_lmg_lsw_m_drum.stats.concealment = -3
				self.factory.parts.wpn_fps_lmg_lsw_m_quad.stats.recoil = 2 
				self.factory.parts.wpn_fps_lmg_lsw_m_quad.stats.spread = -1
				self.factory.parts.wpn_fps_lmg_lsw_m_quad.stats.reload = -1
				self.factory.parts.wpn_fps_lmg_lsw_ck_m27.stats.damage = 45
				self.factory.parts.wpn_fps_lmg_lsw_ck_m27.stats.fire_rate_multiplier = 0.95
				self.factory.parts.wpn_fps_lmg_lsw_ck_m27.stats.spread = 2
				self.factory.parts.wpn_fps_lmg_lsw_ck_m27.stats.concealment = -4
				self.factory.parts.wpn_fps_lmg_lsw_ck_m27.stats.total_ammo_mod = -8.89
				self.factory.parts.wpn_fps_lmg_lsw_ck_m27.custom_stats.ammo_pickup_max_mul = G_W_M:get_pickup_adjusments_for_wpn_mod("LMG", 155, 200).max_mul
				self.factory.parts.wpn_fps_lmg_lsw_ck_m27.custom_stats.ammo_pickup_min_mul = G_W_M:get_pickup_adjusments_for_wpn_mod("LMG", 155, 200).min_mul
				self.factory.parts.wpn_fps_lmg_lsw_ck_m27.custom_stats.fire_rate_multiplier = 0.923076921
				self.factory.parts.wpn_fps_lmg_lsw_ck_m231.custom_stats.fire_rate_multiplier = 1.538461
				self.factory.parts.wpn_fps_lmg_lsw_ck_m231.stats.concealment = 5
				self.factory.parts.wpn_fps_lmg_lsw_ck_m231.stats.recoil = -3
				self.factory.parts.wpn_fps_lmg_lsw_ck_m231.stats.total_ammo_mod = -6.67
				self.factory.wpn_fps_lmg_lsw.override = self.factory.wpn_fps_lmg_lsw.override or {}
				self.factory.wpn_fps_lmg_lsw.override.wpn_fps_upg_m4_m_quad = {
					stats = {
						recoil = 2,
						spread = -1,
						concealment = -2,
					},
				}
			end
			
		end
		Custom_LMGs()
		
		local function Custom_SPECIALs()
			
			-- https://modworkshop.net/mod/21556 HX25 Handheld Grenade Launcher
			if self.hx25 then
				self.hx25.stats.damage = 150
				self.hx25.AMMO_PICKUP = {0.39 * 0.9,0.39 * 1.1}
				self.hx25.stats.spread = 17
				self.hx25.NR_CLIPS_MAX = 9
				self.hx25.AMMO_MAX = self.hx25.CLIP_AMMO_MAX * self.hx25.NR_CLIPS_MAX
				self.hx25.stats.reload = 14
				self.hx25.stats.concealment = 26
				self.hx25.fire_mode_data = {fire_rate = 60/85}
				self.hx25.stats_modifiers.damage = 1
				self.hx25.damage_falloff = G_W_M.damage_dropoff.SHOTGUNs._900
				self.hx25.has_description = true
				Gilza.shotgun_minimal_damage_multipliers.hx25 = 0.8
				-- parts
				-- holy shit this is so fucking cursed
				local shotgun_override = {{_meta = "categories","shotgun"},_meta = "override_weapon"}
				shotgun_override.categories = shotgun_override[1]
				table.insert(self.factory.parts.wpn_fps_upg_hx25_buckshot_ammo, shotgun_override)
				self.factory.parts.wpn_fps_upg_hx25_buckshot_ammo.override_weapon = shotgun_override
				-- end of cursery
				self.factory.parts.wpn_fps_upg_hx25_buckshot_ammo.stats.damage = 500
				self.factory.parts.wpn_fps_upg_hx25_buckshot_ammo.stats.total_ammo_mod = 11
				self.factory.parts.wpn_fps_upg_hx25_buckshot_ammo.custom_stats.rays = 10
				self.factory.parts.wpn_fps_upg_hx25_buckshot_ammo.custom_stats.damage_near_mul = 1
				self.factory.parts.wpn_fps_upg_hx25_buckshot_ammo.custom_stats.damage_far_mul = 1
				self.factory.parts.wpn_fps_upg_hx25_buckshot_ammo.custom_stats.ammo_pickup_max_mul = 1.46
				self.factory.parts.wpn_fps_upg_hx25_buckshot_ammo.custom_stats.ammo_pickup_min_mul = 1.46
			end
			
			-- https://modworkshop.net/mod/22281 Railgun Rorsch MK-1
			if self.roach then
				self.roach.damage_falloff = Gilza.Weapons_module.damage_dropoff.ARs
				self.roach.NR_CLIPS_MAX = 6
				self.roach.AMMO_MAX = self.roach.CLIP_AMMO_MAX * self.roach.NR_CLIPS_MAX
				self.roach.AMMO_PICKUP = {0.15,0.27}
				self.roach.stats.damage = 16000
				self.roach.stats_modifiers.damage = 1
				self.roach.stats.spread = 23
				self.roach.stats.recoil = 1
				G_W_M:set_new_weapon_recoil(G_W_M.recoil_stats.SHOTGUNs, "roach", "left", self)
				self.roach.stats.reload = 9
				-- parts
				self.factory.parts.wpn_fps_special_roach_a_thermal.stats.damage = -14500
				self.factory.parts.wpn_fps_special_roach_a_thermal.stats.extra_ammo = nil
				self.factory.parts.wpn_fps_special_roach_a_thermal.stats.total_ammo_mod = 6.67
				self.factory.parts.wpn_fps_special_roach_a_thermal.custom_stats.rays = 8
				self.factory.parts.wpn_fps_special_roach_a_thermal.custom_stats.ammo_pickup_min_mul = 0
				self.factory.parts.wpn_fps_special_roach_a_thermal.custom_stats.ammo_pickup_max_mul = 0
				self.factory.parts.wpn_fps_special_roach_a_tungsten.stats.damage = -8000
				self.factory.parts.wpn_fps_special_roach_a_tungsten.stats.extra_ammo = 1
				self.factory.parts.wpn_fps_special_roach_a_tungsten.stats.total_ammo_mod = 13.33
				self.factory.parts.wpn_fps_special_roach_a_tungsten.custom_stats.ammo_pickup_min_mul = 1
				self.factory.parts.wpn_fps_special_roach_a_tungsten.custom_stats.ammo_pickup_max_mul = 1
				self.factory.parts.wpn_fps_special_roach_a_sabot.custom_stats.ammo_pickup_min_mul = 0
				self.factory.parts.wpn_fps_special_roach_a_sabot.custom_stats.ammo_pickup_max_mul = 0
				
			end
		end
		Custom_SPECIALs()
		
		local function adjustSniperScopeStats()
		
			if not self.factory.parts then
				return
			end
			
			if not Gilza.customSnipersToUpdateScopesFor then
				return
			end

			local sights_list = {}
			for id, _table_ in pairs(self.factory.parts) do
				if self.factory.parts[id].type and self.factory.parts[id].type == "sight" and self.factory.parts[id].stats then
					table.insert(sights_list, tostring(id))
				end
			end
			
			table.delete(sights_list,"wpn_fps_upg_o_shortdot")
			table.delete(sights_list,"wpn_fps_upg_o_shortdot_vanilla")
			table.delete(sights_list,"wpn_fps_upg_winchester_o_classic")
			
			local snipers = Gilza.customSnipersToUpdateScopesFor
			
			for _, weapon in pairs(snipers) do
				local sniper = Gilza.customWeaponFactoryIDs[weapon] or nil
				if self.factory[sniper] then
					self.factory[sniper].override = self.factory[sniper].override or {}
					for __, part in pairs(sights_list) do
						self.factory[sniper].override[part] = {stats = deep_clone(self.factory.parts[part].stats)}
						if not self.factory.parts[part].stats.concealment or self.factory.parts[part].stats.concealment >= 0 then
							self.factory[sniper].override[part].stats.concealment = 3
						elseif self.factory.parts[part].stats.concealment == -1 then
							self.factory[sniper].override[part].stats.concealment = 2
						elseif self.factory.parts[part].stats.concealment == -2 then
							self.factory[sniper].override[part].stats.concealment = 1
						elseif self.factory.parts[part].stats.concealment == -3 then
							self.factory[sniper].override[part].stats.concealment = 0
						else
							self.factory[sniper].override[part].stats.concealment = -1
						end
					end
				end
			end
		end
		adjustSniperScopeStats()
		
	end
	
	local exceptions = {
		"npc_melee",
		"ceiling_turret_module_longer_range",
		"sentry_gun",
		"ceiling_turret_module_no_idle",
		"crate_turret_module",
		"ceiling_turret_module",
		"swat_van_turret_module",
		"ranc_heavy_machine_gun",
		"crosshair",
		"aa_turret_module",
		"factory",
		"stats",
		"trip_mines"
	}
	Gilza.customWeaponsList = {}
	if Gilza.defaultWeapons then
		for gun, stats in pairs(self) do
			if not (string.sub(gun,-5,-1) == "_crew" or string.sub(gun,-4,-1) == "_npc") and not (table.contains(Gilza.defaultWeapons,gun)) and not (table.contains(exceptions,gun)) then
				table.insert(Gilza.customWeaponsList,gun)
			end
		end
		self:_gilza_add_custom_weapons()
	else
		log("[Gilza] CRITICAL ERROR: Could not load default weapon list, weapon stats can not be applied.")
	end
	
	-- "remove" spread_moving stat from all weapons
	for gun, tbl in pairs(self) do
		if self[gun] and self[gun].stats and self[gun].stats.spread_moving and self[gun].stats.spread then
			self[gun].stats.spread_moving = self[gun].stats.spread
		end
	end
end)