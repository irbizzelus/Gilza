if not Gilza then
	dofile("mods/Gilza/lua/1_GilzaBase.lua")
end

-- new melee stats
Hooks:PostHook(BlackMarketTweakData, "_init_melee_weapons", "Gilza_BlackMarketTweakData_init_melee_weapons_post", function(self, tweak_data)
	-- list in order of appearance in my game, im only missing hotline miami 1 and alienware melee, they are all at the end
	-- also the event hammer is hidden outside of the event, so its at the end as well
	local melee_ids = {
		weapon = {class = 1},
		fists = {class = 3},
		brass_knuckles = {class = 3},
		kabartanto = {class = 3},
		toothbrush = {class = 2},
		kabar = {class = 3},
		swagger = {class = 3},
		aziz = {class = 2},
		clean = {class = 2},
		spoon_gold = {class = 5},
		nin = {class = 4},
		spoon = {class = 5},
		fork = {class = 2},
		spatula = {class = 3},
		shovel = {class = 3},
		moneybundle = {class = 2},
		
		fight = {class = 3},
		cutters = {class = 5},
		shawn = {class = 2},
		boxcutter = {class = 2},
		microphone = {class = 3},
		selfie = {class = 3},
		bayonet = {class = 3},
		gator = {class = 2},
		road = {class = 5},
		zeus = {class = "tazer"},
		iceaxe = {class = 3},
		oxide = {class = 3},
		sword = {class = 2},
		baton = {class = 3},
		slot_lever = {class = 3},
		chac = {class = 4},
		
		fear = {class = "poison"},
		hauteur = {class = 4},
		shock = {class = 3},
		baseballbat = {class = 5},
		oldbaton = {class = 3},
		hockey = {class = 5},
		meter = {class = 6},
		ballistic = {class = 4},
		pugio = {class = 2},
		agave = {class = 2},
		happy = {class = 2},
		kampfmesser = {class = 3},
		buck = {class = 5},
		wing = {class = 4},
		branding_iron = {class = 4},
		detector = {class = 3},
		
		croupier_rake = {class = 3},
		ostry = {class = 3},
		bullseye = {class = 3},
		cs = {class = 4},
		brick = {class = 5},
		model24 = {class = 3},
		scalper = {class = 3},
		switchblade = {class = 2},
		grip = {class = 2},
		boxing_gloves = {class = 3},
		push = {class = 3},
		sap = {class = 3},
		meat_cleaver = {class = 3},
		sandsteel = {class = 4},
		twins = {class = 4},
		pitchfork = {class = 4},
		
		bowie = {class = 4},
		micstand = {class = 3},
		chef = {class = 2},
		x46 = {class = 4},
		tiger = {class = 3},
		beardy = {class = 6},
		catch = {class = 2},
		cleaver = {class = 4},
		taser = {class = "tazer"},
		mining_pick = {class = 5},
		hammer = {class = 3},
		shillelagh = {class = 3},
		stick = {class = 5},
		scoutknife = {class = 4},
		gerber = {class = 3},
		fairbair = {class = 2},
		
		tomahawk = {class = 3},
		morning = {class = 3},
		poker = {class = 4},
		barbedwire = {class = 5},
		great = {class = 6},
		whiskey = {class = 3},
		freedom = {class = 5},
		dingdong = {class = 5},
		tenderizer = {class = 3},
		machete = {class = 2},
		becker = {class = 2},
		cqc = {class = "poison"},
		rambo = {class = 4},
		fireaxe = {class = 6},
		
		-- this one i dont own
		briefcase = {class = 5},
		-- this one is not even shown
		alien_maul = {class = 5},
		-- event special
		piggy_hammer = {class = 5}
	}
	
	-- range adjusted before knockdown adjustments in the func bellow
	-- 'merican flag thing
	self.melee_weapons.freedom.stats.range = 300
	-- HL miami axe
	self.melee_weapons.fireaxe.stats.range = 300
	
	Gilza.default_melee_weapons = {}
	for weapon, stats in pairs(melee_ids) do
		if self.melee_weapons[tostring(weapon)] then
			table.insert(Gilza.default_melee_weapons,tostring(weapon))
			if stats.class == 1 then
				self.melee_weapons[tostring(weapon)].stats.min_damage = 2.5
				self.melee_weapons[tostring(weapon)].stats.max_damage = 2.5
				self.melee_weapons[tostring(weapon)].stats.min_damage_effect = 8
				self.melee_weapons[tostring(weapon)].stats.max_damage_effect = 8
				self.melee_weapons[tostring(weapon)].stats.concealment = 31 -- buff weapon butt since its literally a "no melee weapon" option. also it doesnt charge for more dmg
				self.melee_weapons[tostring(weapon)].sort_order = -3 -- always on top
			elseif stats.class == 2 then
				self.melee_weapons[tostring(weapon)].stats.min_damage = 2.5
				self.melee_weapons[tostring(weapon)].stats.max_damage = 7.5
				self.melee_weapons[tostring(weapon)].stats.min_damage_effect = 7
				self.melee_weapons[tostring(weapon)].stats.max_damage_effect = 7
				self.melee_weapons[tostring(weapon)].stats.charge_time = 0.75
				self.melee_weapons[tostring(weapon)].sort_order = 2
			elseif stats.class == 3 then
				self.melee_weapons[tostring(weapon)].stats.min_damage = 3.5
				self.melee_weapons[tostring(weapon)].stats.max_damage = 10.5
				self.melee_weapons[tostring(weapon)].stats.min_damage_effect = 7
				self.melee_weapons[tostring(weapon)].stats.max_damage_effect = 7
				self.melee_weapons[tostring(weapon)].stats.charge_time = 1.4
				self.melee_weapons[tostring(weapon)].sort_order = 3
			elseif stats.class == 4 then
				self.melee_weapons[tostring(weapon)].stats.min_damage = 5
				self.melee_weapons[tostring(weapon)].stats.max_damage = 15
				self.melee_weapons[tostring(weapon)].stats.min_damage_effect = 7
				self.melee_weapons[tostring(weapon)].stats.max_damage_effect = 7
				self.melee_weapons[tostring(weapon)].stats.charge_time = 1.9
				self.melee_weapons[tostring(weapon)].sort_order = 4
			elseif stats.class == 5 then
				self.melee_weapons[tostring(weapon)].stats.min_damage = 6.8
				self.melee_weapons[tostring(weapon)].stats.max_damage = 20.5
				self.melee_weapons[tostring(weapon)].stats.min_damage_effect = 7
				self.melee_weapons[tostring(weapon)].stats.max_damage_effect = 7
				self.melee_weapons[tostring(weapon)].stats.charge_time = 2.5
				self.melee_weapons[tostring(weapon)].sort_order = 5
			elseif stats.class == 6 then
				self.melee_weapons[tostring(weapon)].stats.min_damage = 10
				self.melee_weapons[tostring(weapon)].stats.max_damage = 30
				self.melee_weapons[tostring(weapon)].stats.min_damage_effect = 7
				self.melee_weapons[tostring(weapon)].stats.max_damage_effect = 7
				self.melee_weapons[tostring(weapon)].stats.charge_time = 3.5
				self.melee_weapons[tostring(weapon)].sort_order = 6
			elseif stats.class == "tazer" then
				self.melee_weapons[tostring(weapon)].stats.min_damage = 0.5
				self.melee_weapons[tostring(weapon)].stats.max_damage = 1
				self.melee_weapons[tostring(weapon)].stats.min_damage_effect = 1
				self.melee_weapons[tostring(weapon)].stats.max_damage_effect = 1
				self.melee_weapons[tostring(weapon)].stats.charge_time = 0.5
				self.melee_weapons[tostring(weapon)].sort_order = -2
			elseif stats.class == "poison" then
				self.melee_weapons[tostring(weapon)].stats.min_damage = 2
				self.melee_weapons[tostring(weapon)].stats.max_damage = 3.5
				self.melee_weapons[tostring(weapon)].stats.min_damage_effect = 1
				self.melee_weapons[tostring(weapon)].stats.max_damage_effect = 1
				self.melee_weapons[tostring(weapon)].stats.charge_time = 1.25
				self.melee_weapons[tostring(weapon)].sort_order = -1
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
	self.melee_weapons.cs.repeat_expire_t = 0.8
	self.melee_weapons.cs.expire_t = 1.05
	self.melee_weapons.cs.sort_order = 0
	
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
	self.melee_weapons.ostry.sort_order = 0

	-- gold spoon extra penalties
	self.melee_weapons.spoon_gold.stats.concealment = 22
	self.melee_weapons.spoon_gold.stats.min_damage_effect = 0.5
	self.melee_weapons.spoon_gold.stats.max_damage_effect = 0.5
	
	-- 'psycho' Myers knife
	self.melee_weapons.chef.stats.min_damage = 2.5
	self.melee_weapons.chef.stats.max_damage = 40
	self.melee_weapons.chef.stats.charge_time = 10
	self.melee_weapons.chef.stats.min_damage_effect = 1
	self.melee_weapons.chef.stats.max_damage_effect = 1
	self.melee_weapons.chef.sounds.charge = "halloween_charge"
	self.melee_weapons.chef.expire_t = 1
	
	-- charge sounds too good to remove
	self.melee_weapons.wing.sounds.charge = "wing_charge"
	self.melee_weapons.brick.sounds.charge = "brick_charge"
	
	-- animation swaps and animation timing fixes
	self.melee_weapons.fists.expire_t = 0.95
	self.melee_weapons.brass_knuckles.expire_t = 0.95
	self.melee_weapons.toothbrush.expire_t = 1.05
	self.melee_weapons.swagger.expire_t = 0.65
	self.melee_weapons.swagger.repeat_expire_t = 0.5
	self.melee_weapons.aziz.expire_t = 1.05
	self.melee_weapons.spoon_gold.repeat_expire_t = 0.95
	self.melee_weapons.spoon.repeat_expire_t = 0.95
	self.melee_weapons.fork.expire_t = 1.05
	self.melee_weapons.spatula.expire_t = 0.65
	self.melee_weapons.spatula.repeat_expire_t = 0.5
	self.melee_weapons.shovel.expire_t = 0.65
	self.melee_weapons.shovel.repeat_expire_t = 0.5
	self.melee_weapons.moneybundle.expire_t = 0.7
	self.melee_weapons.moneybundle.repeat_expire_t = 0.4
	self.melee_weapons.shawn.expire_t = 0.9
	self.melee_weapons.shawn.repeat_expire_t = 0.31
	self.melee_weapons.boxcutter.expire_t = 0.65
	self.melee_weapons.boxcutter.repeat_expire_t = 0.4
	self.melee_weapons.microphone.expire_t = 0.65
	self.melee_weapons.microphone.repeat_expire_t = 0.5
	self.melee_weapons.selfie.expire_t = 0.65
	self.melee_weapons.selfie.repeat_expire_t = 0.5
	self.melee_weapons.bayonet.expire_t = 0.8
	self.melee_weapons.gator.anim_global_param = "melee_agave"
	self.melee_weapons.gator.expire_t = 0.5
	self.melee_weapons.gator.repeat_expire_t = 0.32
	self.melee_weapons.road.expire_t = 0.9
	self.melee_weapons.road.repeat_expire_t = 0.7
	self.melee_weapons.iceaxe.expire_t = 0.65
	self.melee_weapons.iceaxe.repeat_expire_t = 0.5
	self.melee_weapons.zeus.expire_t = 0.95
	self.melee_weapons.oxide.expire_t = 0.65
	self.melee_weapons.oxide.repeat_expire_t = 0.5
	self.melee_weapons.sword.expire_t = 1.05
	self.melee_weapons.baton.expire_t = 0.65
	self.melee_weapons.baton.repeat_expire_t = 0.5
	self.melee_weapons.slot_lever.expire_t = 0.65
	self.melee_weapons.slot_lever.repeat_expire_t = 0.5
	self.melee_weapons.chac.expire_t = 0.8
	self.melee_weapons.chac.repeat_expire_t = 0.6
	self.melee_weapons.chac.anim_attack_vars = {"var2","var3","var4"} -- cut 1st animation variant cause it's timings are extremely slow compared to others
	self.melee_weapons.chac.anims = { -- same here
		var2_attack = {
			anim = "var2"
		},
		var3_attack = {
			anim = "var3"
		},
		var4_attack = {
			anim = "var4"
		},
		charge = {
			loop = true,
			anim = "charge"
		}
	}
	self.melee_weapons.fear.expire_t = 0.95
	self.melee_weapons.shock.expire_t = 0.65
	self.melee_weapons.shock.repeat_expire_t = 0.5
	self.melee_weapons.oldbaton.expire_t = 0.65
	self.melee_weapons.oldbaton.repeat_expire_t = 0.5
	self.melee_weapons.hockey.anim_global_param = "melee_baseballbat_miami"
	self.melee_weapons.hockey.repeat_expire_t = 0.85
	self.melee_weapons.hockey.expire_t = 1.1
	self.melee_weapons.hockey.melee_damage_delay = 0.2
	self.melee_weapons.ballistic.expire_t = 0.9
	self.melee_weapons.agave.expire_t = 0.55
	self.melee_weapons.agave.repeat_expire_t = 0.32
	self.melee_weapons.happy.expire_t = 0.5
	self.melee_weapons.happy.repeat_expire_t = 0.32
	self.melee_weapons.buck.expire_t = 1.2
	self.melee_weapons.wing.expire_t = 0.8
	self.melee_weapons.wing.repeat_expire_t = 0.6
	self.melee_weapons.detector.expire_t = 0.65
	self.melee_weapons.detector.repeat_expire_t = 0.5
	self.melee_weapons.croupier_rake.expire_t = 0.65
	self.melee_weapons.croupier_rake.repeat_expire_t = 0.5
	self.melee_weapons.branding_iron.anim_global_param = "melee_blunt"
	self.melee_weapons.branding_iron.repeat_expire_t = 0.7
	self.melee_weapons.bullseye.expire_t = 0.65
	self.melee_weapons.bullseye.repeat_expire_t = 0.5
	self.melee_weapons.brick.expire_t = 1.1
	self.melee_weapons.brick.repeat_expire_t = 0.9
	self.melee_weapons.model24.expire_t = 0.65
	self.melee_weapons.model24.repeat_expire_t = 0.5
	self.melee_weapons.scalper.expire_t = 0.65
	self.melee_weapons.scalper.repeat_expire_t = 0.5
	self.melee_weapons.boxing_gloves.expire_t = 0.8
	self.melee_weapons.sap.expire_t = 0.65
	self.melee_weapons.sap.repeat_expire_t = 0.5
	self.melee_weapons.grip.expire_t = 0.6
	self.melee_weapons.grip.repeat_expire_t = 0.365
	self.melee_weapons.push.expire_t = 0.9
	self.melee_weapons.meat_cleaver.expire_t = 0.65
	self.melee_weapons.meat_cleaver.repeat_expire_t = 0.5
	self.melee_weapons.sandsteel.expire_t = 0.95
	self.melee_weapons.sandsteel.repeat_expire_t = 0.65
	self.melee_weapons.twins.expire_t = 0.9
	self.melee_weapons.twins.repeat_expire_t = 0.67
	self.melee_weapons.pitchfork.expire_t = 1
	self.melee_weapons.pitchfork.repeat_expire_t = 0.7
	self.melee_weapons.bowie.expire_t = 1.2
	self.melee_weapons.bowie.repeat_expire_t = 0.75
	self.melee_weapons.micstand.expire_t = 0.65
	self.melee_weapons.micstand.repeat_expire_t = 0.5
	self.melee_weapons.x46.expire_t = 1.05
	self.melee_weapons.tiger.expire_t = 0.95
	self.melee_weapons.cleaver.expire_t = 1.05
	self.melee_weapons.cleaver.repeat_expire_t = 0.7
	self.melee_weapons.taser.expire_t = 0.9
	self.melee_weapons.taser.repeat_expire_t = 0.6
	self.melee_weapons.mining_pick.expire_t = 1.2
	self.melee_weapons.mining_pick.repeat_expire_t = 1.1
	self.melee_weapons.mining_pick.melee_damage_delay = 0.15
	self.melee_weapons.hammer.expire_t = 0.65
	self.melee_weapons.hammer.repeat_expire_t = 0.5
	self.melee_weapons.shillelagh.expire_t = 0.65
	self.melee_weapons.shillelagh.repeat_expire_t = 0.5
	self.melee_weapons.stick.expire_t = 1.2
	self.melee_weapons.stick.repeat_expire_t = 0.9
	self.melee_weapons.scoutknife.anim_global_param = "melee_taser"
	self.melee_weapons.scoutknife.align_objects = {"a_weapon_right"}
	self.melee_weapons.scoutknife.expire_t = 0.9
	self.melee_weapons.scoutknife.repeat_expire_t = 0.65
	self.melee_weapons.gerber.expire_t = 0.9
	self.melee_weapons.fairbair.expire_t = 1
	self.melee_weapons.tomahawk.expire_t = 0.65
	self.melee_weapons.tomahawk.repeat_expire_t = 0.5
	self.melee_weapons.morning.expire_t = 0.65
	self.melee_weapons.morning.repeat_expire_t = 0.5
	self.melee_weapons.poker.repeat_expire_t = 0.7
	self.melee_weapons.barbedwire.repeat_expire_t = 0.9
	self.melee_weapons.whiskey.expire_t = 0.65
	self.melee_weapons.whiskey.repeat_expire_t = 0.5
	self.melee_weapons.freedom.expire_t = 1.25
	self.melee_weapons.dingdong.repeat_expire_t = 0.9
	self.melee_weapons.tenderizer.expire_t = 0.65
	self.melee_weapons.tenderizer.repeat_expire_t = 0.5
	self.melee_weapons.machete.anim_global_param = "melee_agave"
	self.melee_weapons.machete.expire_t = 0.55
	self.melee_weapons.machete.repeat_expire_t = 0.32
	self.melee_weapons.becker.anim_global_param = "melee_agave"
	self.melee_weapons.becker.expire_t = 0.55
	self.melee_weapons.becker.repeat_expire_t = 0.32
	self.melee_weapons.cqc.expire_t = 1
	self.melee_weapons.rambo.anim_global_param = "melee_knife"
	self.melee_weapons.rambo.expire_t = 1.05
	self.melee_weapons.rambo.repeat_expire_t = 0.75
	self.melee_weapons.fireaxe.expire_t = 1.5
	self.melee_weapons.fireaxe.repeat_expire_t = 1.2
	self.melee_weapons.briefcase.expire_t = 1.3
end)