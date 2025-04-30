if not Gilza then
	dofile("mods/Gilza/lua/1_GilzaBase.lua")
end

Hooks:PostHook(BlackMarketTweakData, "_init_melee_weapons", "Gilza_NewMeleeStats", function(self, tweak_data)
	-- list in order of appearance in my game, im only missing hotline miami 1 and alienware melee, they are all at the end
	-- also the event hammer is hidden outside of the event, so its at the end as well
	local melee_ids = {
		weapon = {class = 1},
		fists = {class = 3},
		brass_knuckles = {class = 3},
		kabartanto = {class = 3},
		toothbrush = {class = 2},
		kabar = {class = 3},
		swagger = {class = 4},
		aziz = {class = 2},
		clean = {class = 2},
		spoon_gold = {class = 5},
		nin = {class = 3},
		spoon = {class = 5},
		fork = {class = 2},
		spatula = {class = 4},
		shovel = {class = 4},
		moneybundle = {class = 3},
		
		fight = {class = 3},
		cutters = {class = 4},
		shawn = {class = 2},
		boxcutter = {class = 4},
		microphone = {class = 4},
		selfie = {class = 4},
		bayonet = {class = 3},
		gator = {class = 4},
		road = {class = 5},
		zeus = {class = "tazer"},
		iceaxe = {class = 4},
		oxide = {class = 4},
		sword = {class = 2},
		baton = {class = 4},
		slot_lever = {class = 4},
		chac = {class = 3},
		
		fear = {class = "poison"},
		hauteur = {class = 3},
		shock = {class = 4},
		baseballbat = {class = 5},
		oldbaton = {class = 4},
		hockey = {class = 4},
		meter = {class = 6},
		ballistic = {class = 3},
		pugio = {class = 2},
		agave = {class = 4},
		happy = {class = 3},
		kampfmesser = {class = 3},
		buck = {class = 5},
		wing = {class = 4},
		branding_iron = {class = 4},
		detector = {class = 4},
		
		croupier_rake = {class = 4},
		ostry = {class = 3},
		bullseye = {class = 3},
		cs = {class = 4},
		brick = {class = 5},
		model24 = {class = 4},
		scalper = {class = 4},
		switchblade = {class = 2},
		grip = {class = 3},
		boxing_gloves = {class = 3},
		push = {class = 3},
		sap = {class = 4},
		meat_cleaver = {class = 3},
		sandsteel = {class = 3},
		twins = {class = 3},
		pitchfork = {class = 4},
		
		bowie = {class = 4},
		micstand = {class = 4},
		chef = {class = 2},
		x46 = {class = 3},
		tiger = {class = 3},
		beardy = {class = 6},
		catch = {class = 2},
		cleaver = {class = 3},
		taser = {class = "tazer"},
		mining_pick = {class = 4},
		hammer = {class = 4},
		shillelagh = {class = 4},
		stick = {class = 4},
		scoutknife = {class = 2},
		gerber = {class = 3},
		fairbair = {class = 2},
		
		tomahawk = {class = 4},
		morning = {class = 3},
		poker = {class = 4},
		barbedwire = {class = 5},
		great = {class = 6},
		whiskey = {class = 4},
		freedom = {class = 5},
		dingdong = {class = 4},
		tenderizer = {class = 4},
		machete = {class = 4},
		becker = {class = 3},
		cqc = {class = "poison"},
		rambo = {class = 3},
		fireaxe = {class = 6},
		
		-- this one i dont own
		briefcase = {class = 5},
		-- this one is not even shown
		alien_maul = {class = 4},
		-- event special
		piggy_hammer = {class = 5}
	}
	
	Gilza.default_melee_weapons = {}
	for weapon, stats in pairs(melee_ids) do
		if self.melee_weapons[tostring(weapon)] then
			table.insert(Gilza.default_melee_weapons,tostring(weapon))
			if stats.class == 1 then
				self.melee_weapons[tostring(weapon)].stats.min_damage = 2.5
				self.melee_weapons[tostring(weapon)].stats.max_damage = 2.5
				self.melee_weapons[tostring(weapon)].stats.min_damage_effect = 8
				self.melee_weapons[tostring(weapon)].stats.max_damage_effect = 8
			elseif stats.class == 2 then
				self.melee_weapons[tostring(weapon)].stats.min_damage = 2
				self.melee_weapons[tostring(weapon)].stats.max_damage = 5
				self.melee_weapons[tostring(weapon)].stats.min_damage_effect = 7
				self.melee_weapons[tostring(weapon)].stats.max_damage_effect = 7
				self.melee_weapons[tostring(weapon)].stats.charge_time = 0.75
			elseif stats.class == 3 then
				self.melee_weapons[tostring(weapon)].stats.min_damage = 2.5
				self.melee_weapons[tostring(weapon)].stats.max_damage = 7
				self.melee_weapons[tostring(weapon)].stats.min_damage_effect = 7
				self.melee_weapons[tostring(weapon)].stats.max_damage_effect = 7
				self.melee_weapons[tostring(weapon)].stats.charge_time = 1.25
			elseif stats.class == 4 then
				self.melee_weapons[tostring(weapon)].stats.min_damage = 3.5
				self.melee_weapons[tostring(weapon)].stats.max_damage = 9
				self.melee_weapons[tostring(weapon)].stats.min_damage_effect = 7
				self.melee_weapons[tostring(weapon)].stats.max_damage_effect = 7
				self.melee_weapons[tostring(weapon)].stats.charge_time = 1.9
			elseif stats.class == 5 then
				self.melee_weapons[tostring(weapon)].stats.min_damage = 5
				self.melee_weapons[tostring(weapon)].stats.max_damage = 14
				self.melee_weapons[tostring(weapon)].stats.min_damage_effect = 7
				self.melee_weapons[tostring(weapon)].stats.max_damage_effect = 7
				self.melee_weapons[tostring(weapon)].stats.charge_time = 2.5
			elseif stats.class == 6 then
				self.melee_weapons[tostring(weapon)].stats.min_damage = 7.5
				self.melee_weapons[tostring(weapon)].stats.max_damage = 25
				self.melee_weapons[tostring(weapon)].stats.min_damage_effect = 7
				self.melee_weapons[tostring(weapon)].stats.max_damage_effect = 7
				self.melee_weapons[tostring(weapon)].stats.charge_time = 3.5
			elseif stats.class == "tazer" then
				self.melee_weapons[tostring(weapon)].stats.min_damage = 0.5
				self.melee_weapons[tostring(weapon)].stats.max_damage = 1
				self.melee_weapons[tostring(weapon)].stats.min_damage_effect = 1
				self.melee_weapons[tostring(weapon)].stats.max_damage_effect = 1
				self.melee_weapons[tostring(weapon)].stats.charge_time = 0.5
			elseif stats.class == "poison" then
				self.melee_weapons[tostring(weapon)].stats.min_damage = 2
				self.melee_weapons[tostring(weapon)].stats.max_damage = 3.5
				self.melee_weapons[tostring(weapon)].stats.min_damage_effect = 1
				self.melee_weapons[tostring(weapon)].stats.max_damage_effect = 1
				self.melee_weapons[tostring(weapon)].stats.charge_time = 1.25
			end
			self.melee_weapons[tostring(weapon)].sounds.charge = nil
		end
		local additional_wpn_range = self.melee_weapons[tostring(weapon)].stats.range - 150
		if additional_wpn_range >= 5 and not (stats.class == "poison" or stats.class == "tazer" or stats.class == 1) then
			local knock = (math.clamp(additional_wpn_range/5, 1, 24)) * 0.25
			self.melee_weapons[tostring(weapon)].stats.min_damage_effect = 7 - knock
			self.melee_weapons[tostring(weapon)].stats.max_damage_effect = 7 - knock
		end
	end
	
	-- chainsaw
	self.melee_weapons.cs.chainsaw_delay = 1.00
	self.melee_weapons.cs.repeat_chainsaw_delay = 0.2
	self.melee_weapons.cs.stats.tick_damage = 1.6
	self.melee_weapons.cs.chainsaw = true
	self.melee_weapons.cs.stats.charge_time = 1
	self.melee_weapons.cs.stats.min_damage = 3.5
	self.melee_weapons.cs.stats.max_damage = 3.5
	self.melee_weapons.cs.stats.min_damage_effect = 6
	self.melee_weapons.cs.stats.max_damage_effect = 6
	self.melee_weapons.cs.info_id = "bm_melee_cs_info"
	self.melee_weapons.cs.sounds.charge = "cs_charge"
	
	-- fidget spinners
	self.melee_weapons.ostry.chainsaw_delay = 0.70
	self.melee_weapons.ostry.repeat_chainsaw_delay = 0.2
	self.melee_weapons.ostry.stats.tick_damage = 1.2
	self.melee_weapons.ostry.chainsaw = true
	self.melee_weapons.ostry.stats.charge_time = 1
	self.melee_weapons.ostry.stats.min_damage = 2.5
	self.melee_weapons.ostry.stats.max_damage = 2.5
	self.melee_weapons.ostry.stats.min_damage_effect = 5
	self.melee_weapons.ostry.stats.max_damage_effect = 5
	self.melee_weapons.ostry.info_id = "bm_melee_ostry_info"
	self.melee_weapons.ostry.sounds.charge = "ostry_charge"

	-- gold spoon extra penalties
	self.melee_weapons.spoon_gold.stats.concealment = 22
	self.melee_weapons.spoon_gold.stats.min_damage_effect = 0.5
	self.melee_weapons.spoon_gold.stats.max_damage_effect = 0.5
	
	-- 'psycho' Myers knife
	self.melee_weapons.chef.stats.min_damage = 1.5
	self.melee_weapons.chef.stats.max_damage = 20
	self.melee_weapons.chef.stats.charge_time = 10
	self.melee_weapons.chef.stats.min_damage_effect = 1
	self.melee_weapons.chef.stats.max_damage_effect = 1
	self.melee_weapons.chef.sounds.charge = "halloween_charge"
	
	-- hotline miami fireaxe
	self.melee_weapons.fireaxe.repeat_expire_t = 1.2
	
	-- charge sounds too good
	self.melee_weapons.wing.sounds.charge = "wing_charge"
	self.melee_weapons.brick.sounds.charge = "brick_charge"
end)