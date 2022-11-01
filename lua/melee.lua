Hooks:PostHook(BlackMarketTweakData, "_init_melee_weapons", "Gilza_NewMeleeStats", function(self, tweak_data)
	-- list in order of appearance in my game, im only missing hotline miami 1, raid community knifes, john wick promo pencil and alienware melee, they are all at the end
	local melee_ids = {
		weapon = 1,
		fists = 2,
		brass_knuckles = 2,
		kabartanto = 3,
		toothbrush = 2,
		kabar = 3,
		swagger = 4,
		aziz = 4,
		clean = 2,
		spoon_gold = 5,
		nin = 5,
		spoon = 5,
		fork = 2,
		spatula = 4,
		shovel = 7,
		moneybundle = 4,
		fight = 2,
		cutters = 6,
		shawn = 2,
		boxcutter = 3,
		microphone = 4,
		selfie = 4,
		bayonet = 3,
		gator = 5,
		road = 5,
		zeus = "tazer",
		iceaxe = 3,
		oxide = 5,
		baton = 4,
		slot_lever = 4,
		chac = 4,
		fear = "poison",
		hauteur = 5,
		shock = 6,
		baseballbat = 8,
		oldbaton = 6,
		hockey = 8,
		meter = 7,
		ballistic = 3,
		pugio = 2,
		agave = 5,
		happy = 4,
		kampfmesser = 3,
		buck = 8,
		wing = 5,
		branding_iron = 4,
		detector = 4,
		croupier_rake = 4,
		ostry = 5,
		bullseye = 5,
		cs = 6,
		brick = 5,
		model24 = 6,
		scalper = 5,
		switchblade = 2,
		boxing_gloves = 3,
		push = 3,
		sap = 4,
		meat_cleaver = 5,
		sandsteel = 5,
		twins = 5,
		pitchfork = 8,
		bowie = 3,
		micstand = 6,
		chef = 2,
		x46 = 3,
		tiger = 2,
		beardy = 7,
		catch = 3,
		cleaver = 5,
		taser = "tazer",
		mining_pick = 7,
		hammer = 6,
		shillelagh = 5,
		stick = 5,
		scoutknife = 2,
		gerber = 3,
		fairbair = 2,
		tomahawk = 5,
		morning = 5,
		poker = 5,
		barbedwire = 8,
		great = 7,
		whiskey = 8,
		freedom = 6,
		dingdong = 8,
		tenderizer = 4,
		machete = 5,
		becker = 3,
		cqc = "poison",
		rambo = 5,
		fireaxe = 7,
		-- those that i dont own
		briefcase = 6,
		grip = 3,
		-- those that are not even shown
		alien_maul = 6,
		sword = 2,
	}

	for weapon, profile in pairs(melee_ids) do
		if self.melee_weapons[tostring(weapon)] then
			if profile == 1 then
				self.melee_weapons[tostring(weapon)].stats.min_damage = 2.5
				self.melee_weapons[tostring(weapon)].stats.max_damage = 2.5
				self.melee_weapons[tostring(weapon)].stats.min_damage_effect = 4
				self.melee_weapons[tostring(weapon)].stats.max_damage_effect = 4
				self.melee_weapons[tostring(weapon)].stats.charge_time = 0
				--self.melee_weapons[tostring(weapon)].stats.range = 0
				--self.melee_weapons[tostring(weapon)].stats.concealment = 0
				self.melee_weapons[tostring(weapon)].melee_damage_delay = 0
				self.melee_weapons[tostring(weapon)].repeat_expire_t = 0.6
			end
			if profile == 2 then
				self.melee_weapons[tostring(weapon)].stats.min_damage = 2
				self.melee_weapons[tostring(weapon)].stats.max_damage = 3.5
				self.melee_weapons[tostring(weapon)].stats.min_damage_effect = 1
				self.melee_weapons[tostring(weapon)].stats.max_damage_effect = 1
				self.melee_weapons[tostring(weapon)].stats.charge_time = 1
				self.melee_weapons[tostring(weapon)].melee_damage_delay = 0.1
				self.melee_weapons[tostring(weapon)].repeat_expire_t = 0.3
				self.melee_weapons[tostring(weapon)].sounds.charge = nil
			end
			if profile == 3 then
				self.melee_weapons[tostring(weapon)].stats.min_damage = 2.5
				self.melee_weapons[tostring(weapon)].stats.max_damage = 5
				self.melee_weapons[tostring(weapon)].stats.min_damage_effect = 2
				self.melee_weapons[tostring(weapon)].stats.max_damage_effect = 2
				self.melee_weapons[tostring(weapon)].stats.charge_time = 1.5
				self.melee_weapons[tostring(weapon)].melee_damage_delay = 0.1
				self.melee_weapons[tostring(weapon)].repeat_expire_t = 0.6
				self.melee_weapons[tostring(weapon)].sounds.charge = nil
			end
			if profile == 4 then
				self.melee_weapons[tostring(weapon)].stats.min_damage = 2.5
				self.melee_weapons[tostring(weapon)].stats.max_damage = 5
				self.melee_weapons[tostring(weapon)].stats.min_damage_effect = 10
				self.melee_weapons[tostring(weapon)].stats.max_damage_effect = 9
				self.melee_weapons[tostring(weapon)].stats.charge_time = 2
				self.melee_weapons[tostring(weapon)].melee_damage_delay = 0.1
				self.melee_weapons[tostring(weapon)].repeat_expire_t = 0.7
				self.melee_weapons[tostring(weapon)].sounds.charge = nil
			end
			if profile == 5 then
				self.melee_weapons[tostring(weapon)].stats.min_damage = 3.5
				self.melee_weapons[tostring(weapon)].stats.max_damage = 7.5
				self.melee_weapons[tostring(weapon)].stats.min_damage_effect = 2
				self.melee_weapons[tostring(weapon)].stats.max_damage_effect = 2
				self.melee_weapons[tostring(weapon)].stats.charge_time = 3
				self.melee_weapons[tostring(weapon)].melee_damage_delay = 0.2
				self.melee_weapons[tostring(weapon)].repeat_expire_t = 0.9
				self.melee_weapons[tostring(weapon)].sounds.charge = nil
			end
			if profile == 6 then
				self.melee_weapons[tostring(weapon)].stats.min_damage = 3.5
				self.melee_weapons[tostring(weapon)].stats.max_damage = 7.5
				self.melee_weapons[tostring(weapon)].stats.min_damage_effect = 300/35
				self.melee_weapons[tostring(weapon)].stats.max_damage_effect = 6
				self.melee_weapons[tostring(weapon)].stats.charge_time = 3.5
				self.melee_weapons[tostring(weapon)].melee_damage_delay = 0.2
				self.melee_weapons[tostring(weapon)].repeat_expire_t = 1
				self.melee_weapons[tostring(weapon)].sounds.charge = nil
			end
			if profile == 7 then
				self.melee_weapons[tostring(weapon)].stats.min_damage = 5
				self.melee_weapons[tostring(weapon)].stats.max_damage = 10
				self.melee_weapons[tostring(weapon)].stats.min_damage_effect = 2
				self.melee_weapons[tostring(weapon)].stats.max_damage_effect = 1.5
				self.melee_weapons[tostring(weapon)].stats.charge_time = 4
				self.melee_weapons[tostring(weapon)].melee_damage_delay = 0.5
				self.melee_weapons[tostring(weapon)].repeat_expire_t = 1.2
				self.melee_weapons[tostring(weapon)].sounds.charge = nil
			end
			if profile == 8 then
				self.melee_weapons[tostring(weapon)].stats.min_damage = 5
				self.melee_weapons[tostring(weapon)].stats.max_damage = 10
				self.melee_weapons[tostring(weapon)].stats.min_damage_effect = 9
				self.melee_weapons[tostring(weapon)].stats.max_damage_effect = 7
				self.melee_weapons[tostring(weapon)].stats.charge_time = 4.5
				self.melee_weapons[tostring(weapon)].melee_damage_delay = 0.5
				self.melee_weapons[tostring(weapon)].repeat_expire_t = 1.4
				self.melee_weapons[tostring(weapon)].sounds.charge = nil
			end
			if profile == "tazer" then
				self.melee_weapons[tostring(weapon)].stats.min_damage = 0.1
				self.melee_weapons[tostring(weapon)].stats.max_damage = 1
				self.melee_weapons[tostring(weapon)].stats.min_damage_effect = 1
				self.melee_weapons[tostring(weapon)].stats.max_damage_effect = 1
				self.melee_weapons[tostring(weapon)].stats.charge_time = 0.5
				self.melee_weapons[tostring(weapon)].melee_damage_delay = 0.15
				self.melee_weapons[tostring(weapon)].repeat_expire_t = 0.625
				self.melee_weapons[tostring(weapon)].expire_t = 1
			end
			if profile == "poison" then
				self.melee_weapons[tostring(weapon)].stats.min_damage = 1.5
				self.melee_weapons[tostring(weapon)].stats.max_damage = 3.5
				self.melee_weapons[tostring(weapon)].stats.min_damage_effect = 2
				self.melee_weapons[tostring(weapon)].stats.max_damage_effect = 2
				self.melee_weapons[tostring(weapon)].stats.charge_time = 2
				self.melee_weapons[tostring(weapon)].melee_damage_delay = 0.2
				self.melee_weapons[tostring(weapon)].repeat_expire_t = 0.475
				self.melee_weapons[tostring(weapon)].expire_t = 1.2
				self.melee_weapons[tostring(weapon)].sounds.charge = nil
				self.melee_weapons[tostring(weapon)].dot_data = {
					type = "poison",
					custom_data = {
						dot_length = 1,
						hurt_animation_chance = 0.75
					}
				}
			end
		end
	end
	
	-- gold spoon extra penalties
	self.melee_weapons.spoon_gold.stats.charge_time = 6
	self.melee_weapons.spoon_gold.stats.concealment = 24
	self.melee_weapons.spoon_gold.repeat_expire_t = 1
	-- psycho myers knife changes and sounds
	self.melee_weapons.chef.stats.min_damage = 1.7
	self.melee_weapons.chef.stats.max_damage = 15
	self.melee_weapons.chef.stats.charge_time = 11
	self.melee_weapons.chef.stats.min_damage_effect = 1
	self.melee_weapons.chef.stats.max_damage_effect = 1
	self.melee_weapons.chef.sounds.charge = "halloween_charge"
	-- mine pick less delay but more time and less knock
	self.melee_weapons.mining_pick.melee_damage_delay = 0.3
	self.melee_weapons.mining_pick.stats.charge_time = 4.5
	self.melee_weapons.mining_pick.stats.min_damage_effect = 0.5
	self.melee_weapons.mining_pick.stats.max_damage_effect = 0.5
	
	-- adding back some charge sounds:
	-- sydney's butterfly
	self.melee_weapons.wing.sounds.charge = "wing_charge"
	-- chainsaw
	self.melee_weapons.cs.sounds.charge = "cs_charge"
	-- fidget spinners
	self.melee_weapons.ostry.sounds.charge = "ostry_charge"
	-- brick phone
	self.melee_weapons.brick.sounds.charge = "brick_charge"
end)