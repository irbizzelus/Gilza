if not Gilza then
	dofile("mods/Gilza/lua/wpntweaks.lua")
end

Hooks:PostHook(BlackMarketTweakData, "_init_melee_weapons", "Gilza_NewMeleeStats", function(self, tweak_data)
	-- list in order of appearance in my game, im only missing hotline miami 1, raid community knifes, john wick promo pencil and alienware melee, they are all at the end
	local melee_ids = {
		weapon = 1,
		fists = 4,
		brass_knuckles = 4,
		kabartanto = 3,
		toothbrush = 2,
		kabar = 3,
		swagger = 4,
		aziz = 2,
		clean = 2,
		spoon_gold = 7,
		nin = 4,
		spoon = 7,
		fork = 2,
		spatula = 5,
		shovel = 6,
		moneybundle = 4,
		
		fight = 4,
		cutters = 6,
		shawn = 2,
		boxcutter = 5,
		microphone = 6,
		selfie = 5,
		bayonet = 3,
		gator = 5,
		road = 8,
		zeus = "tazer",
		iceaxe = 5,
		oxide = 5,
		baton = 6,
		slot_lever = 4,
		chac = 4,
		fear = "poison",
		
		hauteur = 3,
		shock = 6,
		baseballbat = 8,
		oldbaton = 6,
		hockey = 6,
		meter = 7,
		ballistic = 3,
		pugio = 2,
		agave = 5,
		happy = 4,
		kampfmesser = 3,
		buck = 8,
		wing = 5,
		branding_iron = 4,
		detector = 6,
		croupier_rake = 4,
		
		ostry = 4,
		bullseye = 4,
		cs = 6,
		brick = 5,
		model24 = 6,
		scalper = 5,
		switchblade = 2,
		boxing_gloves = 4,
		push = 4,
		sap = 5,
		meat_cleaver = 4,
		sandsteel = 4,
		twins = 3,
		pitchfork = 7,
		bowie = 5,
		micstand = 6,
		
		chef = 2,
		x46 = 3,
		tiger = 3,
		beardy = 7,
		catch = 2,
		cleaver = 4,
		taser = "tazer",
		mining_pick = 7,
		hammer = 6,
		shillelagh = 6,
		stick = 5,
		scoutknife = 2,
		gerber = 3,
		fairbair = 2,
		tomahawk = 5,
		morning = 4,
		
		poker = 5,
		barbedwire = 8,
		great = 7,
		whiskey = 8,
		freedom = 6,
		dingdong = 7,
		tenderizer = 6,
		machete = 5,
		becker = 3,
		cqc = "poison",
		rambo = 4,
		fireaxe = 7,
		
		-- those that i dont own
		briefcase = 7,
		grip = 3,
		-- those that are not even shown (to me)
		alien_maul = 6,
		sword = 2,
	}
	
	Gilza.default_melee_weapons = {}
	for weapon, profile in pairs(melee_ids) do
		table.insert(Gilza.default_melee_weapons,tostring(weapon))
		if self.melee_weapons[tostring(weapon)] then
			if profile == 1 then
				self.melee_weapons[tostring(weapon)].stats.min_damage = 2.5
				self.melee_weapons[tostring(weapon)].stats.max_damage = 2.5
				self.melee_weapons[tostring(weapon)].stats.min_damage_effect = 4
				self.melee_weapons[tostring(weapon)].stats.max_damage_effect = 4
				self.melee_weapons[tostring(weapon)].stats.charge_time = 0
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
				self.melee_weapons[tostring(weapon)].stats.min_damage_effect = 30
				self.melee_weapons[tostring(weapon)].stats.max_damage_effect = 25
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
				self.melee_weapons[tostring(weapon)].stats.min_damage_effect = 1000/35
				self.melee_weapons[tostring(weapon)].stats.max_damage_effect = 1750/75
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
				self.melee_weapons[tostring(weapon)].stats.min_damage_effect = 26
				self.melee_weapons[tostring(weapon)].stats.max_damage_effect = 22.5
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
			end
		end
	end
	
	
	self.melee_weapons.cs.chainsaw_delay = 1.00
	self.melee_weapons.cs.repeat_chainsaw_delay = 0.2
	self.melee_weapons.cs.stats.tick_damage = 1.32
	self.melee_weapons.cs.chainsaw = true
	self.melee_weapons.cs.stats.charge_time = 1
	self.melee_weapons.cs.stats.min_damage = 2.5
	self.melee_weapons.cs.stats.max_damage = 2.5
	self.melee_weapons.cs.stats.min_damage_effect = 750/25
	self.melee_weapons.cs.stats.max_damage_effect = 750/25
	self.melee_weapons.cs.info_id = "bm_melee_cs_info"
	
	self.melee_weapons.ostry.chainsaw_delay = 0.70
	self.melee_weapons.ostry.repeat_chainsaw_delay = 0.2
	self.melee_weapons.ostry.stats.tick_damage = 1.0
	self.melee_weapons.ostry.chainsaw = true
	self.melee_weapons.ostry.stats.charge_time = 1
	self.melee_weapons.ostry.stats.min_damage = 1
	self.melee_weapons.ostry.stats.max_damage = 1
	self.melee_weapons.ostry.stats.min_damage_effect = 15
	self.melee_weapons.ostry.stats.max_damage_effect = 15
	self.melee_weapons.ostry.info_id = "bm_melee_ostry_info"

	-- gold spoon extra penalties
	self.melee_weapons.spoon_gold.stats.charge_time = 6
	self.melee_weapons.spoon_gold.stats.concealment = 23
	self.melee_weapons.spoon_gold.melee_damage_delay = 0.42
	-- psycho myers knife changes and sounds
	self.melee_weapons.chef.stats.min_damage = 1.7
	self.melee_weapons.chef.stats.max_damage = 15
	self.melee_weapons.chef.stats.charge_time = 11
	self.melee_weapons.chef.stats.min_damage_effect = 1
	self.melee_weapons.chef.stats.max_damage_effect = 1
	self.melee_weapons.chef.sounds.charge = "halloween_charge"
	-- mine pick less delay but less knock and no charged dmg
	self.melee_weapons.mining_pick.melee_damage_delay = 0.3
	self.melee_weapons.mining_pick.stats.max_damage = 5
	self.melee_weapons.mining_pick.stats.charge_time = 1
	self.melee_weapons.mining_pick.stats.min_damage_effect = 0.5
	self.melee_weapons.mining_pick.stats.max_damage_effect = 1
	-- glen bottle faster attacks no charge dmg
	self.melee_weapons.whiskey.melee_damage_delay = 0.33
	self.melee_weapons.whiskey.repeat_expire_t = 0.9
	self.melee_weapons.whiskey.stats.charge_time = 3
	self.melee_weapons.whiskey.stats.max_damage = 5
	self.melee_weapons.whiskey.stats.min_damage_effect = 3
	self.melee_weapons.whiskey.stats.max_damage_effect = 12
	self.melee_weapons.whiskey.expire_t = 0.85
	-- animation sync issue fixes
	self.melee_weapons.buck.repeat_expire_t = 1.1
	self.melee_weapons.baseballbat.melee_damage_delay = 0.42
	self.melee_weapons.barbedwire.melee_damage_delay = 0.42
	self.melee_weapons.dingdong.repeat_expire_t = 1.15
	self.melee_weapons.swagger.expire_t = 0.55
	self.melee_weapons.spoon.melee_damage_delay = 0.42
	self.melee_weapons.spoon.repeat_expire_t = 1.1
	self.melee_weapons.spatula.expire_t = 0.58
	self.melee_weapons.moneybundle.expire_t = 0.58
	self.melee_weapons.shawn.expire_t = 1.25
	self.melee_weapons.microphone.expire_t = 0.65
	self.melee_weapons.chac.expire_t = 0.65
	self.melee_weapons.shock.expire_t = 0.9
	self.melee_weapons.oldbaton.expire_t = 0.9
	self.melee_weapons.wing.expire_t = 0.9
	self.melee_weapons.branding_iron.expire_t = 0.75
	self.melee_weapons.detector.expire_t = 0.9
	self.melee_weapons.bullseye.expire_t = 0.75
	self.melee_weapons.model24.expire_t = 0.9
	self.melee_weapons.meat_cleaver.expire_t = 0.75
	self.melee_weapons.twins.expire_t = 1
	self.melee_weapons.pitchfork.melee_damage_delay = 0.42
	self.melee_weapons.pitchfork.expire_t = 1
	self.melee_weapons.hammer.expire_t = 1
	self.melee_weapons.shillelagh.expire_t = 1
	self.melee_weapons.stick.expire_t = 1
	self.melee_weapons.tomahawk.expire_t = 0.7
	self.melee_weapons.morning.expire_t = 0.9
	self.melee_weapons.dingdong.stats.range = 325
	self.melee_weapons.tenderizer.expire_t = 1
	
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