if not Gilza then
	dofile("mods/Gilza/lua/1_GilzaBase.lua")
end

Hooks:PostHook(BlackMarketTweakData, "_init_melee_weapons", "Gilza_NewMeleeStats", function(self, tweak_data)
	-- list in order of appearance in my game, im only missing hotline miami 1 and alienware melee, they are all at the end
	-- also the event hammer is hidden outside of the event, so its at the end as well
	local melee_ids = {
		weapon = {class = 1, knock_power = false},
		fists = {class = 3, knock_power = 5},
		brass_knuckles = {class = 3, knock_power = 5},
		kabartanto = {class = 3, knock_power = 3},
		toothbrush = {class = 2, knock_power = false},
		kabar = {class = 3, knock_power = 3},
		swagger = {class = 4, knock_power = 5},
		aziz = {class = 3, knock_power = 5},
		clean = {class = 2, knock_power = false},
		spoon_gold = {class = 5, knock_power = false},
		nin = {class = 3, knock_power = 3},
		spoon = {class = 5, knock_power = false},
		fork = {class = 2, knock_power = false},
		spatula = {class = 4, knock_power = 7},
		shovel = {class = 4, knock_power = 2},
		moneybundle = {class = 3, knock_power = 5},
		
		fight = {class = 3, knock_power = 5},
		cutters = {class = 4, knock_power = false},
		shawn = {class = 2, knock_power = false},
		boxcutter = {class = 4, knock_power = 7},
		microphone = {class = 4, knock_power = 8},
		selfie = {class = 4, knock_power = 2},
		bayonet = {class = 3, knock_power = 3},
		gator = {class = 4, knock_power = 3},
		road = {class = 5, knock_power = 9},
		zeus = {class = "tazer", knock_power = false},
		iceaxe = {class = 4, knock_power = 2},
		oxide = {class = 4, knock_power = 3},
		sword = {class = 2, knock_power = false},
		baton = {class = 4, knock_power = 2},
		slot_lever = {class = 4, knock_power = 3},
		chac = {class = 3, knock_power = 5},
		
		fear = {class = "poison", knock_power = false},
		hauteur = {class = 3, knock_power = 5},
		shock = {class = 4, knock_power = 7},
		baseballbat = {class = 5, knock_power = 3},
		oldbaton = {class = 4, knock_power = 2},
		hockey = {class = 4, knock_power = 2},
		meter = {class = 6, knock_power = 3},
		ballistic = {class = 3, knock_power = 5},
		pugio = {class = 2, knock_power = false},
		agave = {class = 4, knock_power = 5},
		happy = {class = 3, knock_power = false},
		kampfmesser = {class = 3, knock_power = 3},
		buck = {class = 5, knock_power = 7},
		wing = {class = 4, knock_power = 7},
		branding_iron = {class = 4, knock_power = 5},
		detector = {class = 4, knock_power = 5},
		
		croupier_rake = {class = 4, knock_power = 2},
		ostry = {class = 3, knock_power = false},
		bullseye = {class = 3, knock_power = 3},
		cs = {class = 4, knock_power = false},
		brick = {class = 5, knock_power = 9},
		model24 = {class = 4, knock_power = 7},
		scalper = {class = 4, knock_power = 6},
		switchblade = {class = 2, knock_power = false},
		grip = {class = 3, knock_power = 5},
		boxing_gloves = {class = 3, knock_power = 5},
		push = {class = 3, knock_power = 5},
		sap = {class = 4, knock_power = 6},
		meat_cleaver = {class = 3, knock_power = 2},
		sandsteel = {class = 3, knock_power = false},
		twins = {class = 3, knock_power = 5},
		pitchfork = {class = 4, knock_power = 5},
		
		bowie = {class = 4, knock_power = 5},
		micstand = {class = 4, knock_power = 2},
		chef = {class = 2, knock_power = false},
		x46 = {class = 3, knock_power = 2},
		tiger = {class = 3, knock_power = 3},
		beardy = {class = 6, knock_power = 5},
		catch = {class = 2, knock_power = false},
		cleaver = {class = 3, knock_power = 2},
		taser = {class = "tazer", knock_power = false},
		mining_pick = {class = 4, knock_power = 5},
		hammer = {class = 4, knock_power = 7},
		shillelagh = {class = 4, knock_power = 7},
		stick = {class = 4, knock_power = 5},
		scoutknife = {class = 2, knock_power = false},
		gerber = {class = 3, knock_power = 3},
		fairbair = {class = 2, knock_power = false},
		
		tomahawk = {class = 4, knock_power = 5},
		morning = {class = 3, knock_power = false},
		poker = {class = 4, knock_power = 7},
		barbedwire = {class = 5, knock_power = false},
		great = {class = 6, knock_power = 3},
		whiskey = {class = 4, knock_power = 7},
		freedom = {class = 5, knock_power = false},
		dingdong = {class = 4, knock_power = false},
		tenderizer = {class = 4, knock_power = 7},
		machete = {class = 4, knock_power = 5},
		becker = {class = 3, knock_power = 2},
		cqc = {class = "poison", knock_power = false},
		rambo = {class = 3, knock_power = 2},
		fireaxe = {class = 6, knock_power = 3},
		
		-- this one i dont own
		briefcase = {class = 5, knock_power = false},
		-- this one is not even shown
		alien_maul = {class = 4, knock_power = false},
		-- event special
		piggy_hammer = {class = 5, knock_power = false}
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
				self.melee_weapons[tostring(weapon)].stats.max_damage = 3.5
				self.melee_weapons[tostring(weapon)].stats.min_damage_effect = 1
				self.melee_weapons[tostring(weapon)].stats.max_damage_effect = 1
				self.melee_weapons[tostring(weapon)].stats.charge_time = 1
			elseif stats.class == 3 then
				self.melee_weapons[tostring(weapon)].stats.min_damage = 2.5
				self.melee_weapons[tostring(weapon)].stats.max_damage = 5
				self.melee_weapons[tostring(weapon)].stats.charge_time = 1.5
				if stats.knock_power then
					self.melee_weapons[tostring(weapon)].stats.min_damage_effect = stats.knock_power
					self.melee_weapons[tostring(weapon)].stats.max_damage_effect = stats.knock_power
				else
					self.melee_weapons[tostring(weapon)].stats.min_damage_effect = 1
					self.melee_weapons[tostring(weapon)].stats.max_damage_effect = 1
				end
			elseif stats.class == 4 then
				self.melee_weapons[tostring(weapon)].stats.min_damage = 3.5
				self.melee_weapons[tostring(weapon)].stats.max_damage = 7.5
				self.melee_weapons[tostring(weapon)].stats.charge_time = 2.5
				if stats.knock_power then
					self.melee_weapons[tostring(weapon)].stats.min_damage_effect = stats.knock_power
					self.melee_weapons[tostring(weapon)].stats.max_damage_effect = stats.knock_power
				else
					self.melee_weapons[tostring(weapon)].stats.min_damage_effect = 1
					self.melee_weapons[tostring(weapon)].stats.max_damage_effect = 1
				end
			elseif stats.class == 5 then
				self.melee_weapons[tostring(weapon)].stats.min_damage = 5
				self.melee_weapons[tostring(weapon)].stats.max_damage = 10
				self.melee_weapons[tostring(weapon)].stats.charge_time = 3.5
				if stats.knock_power then
					self.melee_weapons[tostring(weapon)].stats.min_damage_effect = stats.knock_power
					self.melee_weapons[tostring(weapon)].stats.max_damage_effect = stats.knock_power
				else
					self.melee_weapons[tostring(weapon)].stats.min_damage_effect = 1
					self.melee_weapons[tostring(weapon)].stats.max_damage_effect = 1
				end
			elseif stats.class == 6 then
				self.melee_weapons[tostring(weapon)].stats.min_damage = 7.5
				self.melee_weapons[tostring(weapon)].stats.max_damage = 15
				self.melee_weapons[tostring(weapon)].stats.charge_time = 4.5
				if stats.knock_power then
					self.melee_weapons[tostring(weapon)].stats.min_damage_effect = stats.knock_power
					self.melee_weapons[tostring(weapon)].stats.max_damage_effect = stats.knock_power
				else
					self.melee_weapons[tostring(weapon)].stats.min_damage_effect = 1
					self.melee_weapons[tostring(weapon)].stats.max_damage_effect = 1
				end
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
				self.melee_weapons[tostring(weapon)].stats.charge_time = 2
			end
			self.melee_weapons[tostring(weapon)].sounds.charge = nil
		end
	end
	
	-- chainsaw
	self.melee_weapons.cs.chainsaw_delay = 1.00
	self.melee_weapons.cs.repeat_chainsaw_delay = 0.2
	self.melee_weapons.cs.stats.tick_damage = 2
	self.melee_weapons.cs.chainsaw = true
	self.melee_weapons.cs.stats.charge_time = 1
	self.melee_weapons.cs.stats.min_damage = 3.5
	self.melee_weapons.cs.stats.max_damage = 3.5
	self.melee_weapons.cs.stats.min_damage_effect = 20
	self.melee_weapons.cs.stats.max_damage_effect = 20
	self.melee_weapons.cs.info_id = "bm_melee_cs_info"
	self.melee_weapons.cs.sounds.charge = "cs_charge"
	
	-- fidget spinners
	self.melee_weapons.ostry.chainsaw_delay = 0.70
	self.melee_weapons.ostry.repeat_chainsaw_delay = 0.2
	self.melee_weapons.ostry.stats.tick_damage = 1.5
	self.melee_weapons.ostry.chainsaw = true
	self.melee_weapons.ostry.stats.charge_time = 1
	self.melee_weapons.ostry.stats.min_damage = 2.5
	self.melee_weapons.ostry.stats.max_damage = 2.5
	self.melee_weapons.ostry.stats.min_damage_effect = 16
	self.melee_weapons.ostry.stats.max_damage_effect = 16
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
	
	-- charge sounds too good
	self.melee_weapons.wing.sounds.charge = "wing_charge"
	self.melee_weapons.brick.sounds.charge = "brick_charge"
end)