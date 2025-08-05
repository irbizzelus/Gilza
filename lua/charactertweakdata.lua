-- healthpool updates and knockdown effect for grey/zeal swats

local city_swat_hurts = {
	tase = true,
	bullet = {
		health_reference = 1,
		zones = {{light = 1}}
	},
	explosion = {
		health_reference = 1,
		zones = {{explode = 1}}
	},
	melee = {
		health_reference = "current",
		zones = {
			{heavy = 0, health_limit = 0.3, light = 0.7, moderate = 0, none = 0.3},
			{heavy = 0, light = 1, moderate = 0, health_limit = 0.8},
			{heavy = 0.2, light = 0.6, moderate = 0.2, health_limit = 0.9},
			{light = 0, moderate = 0, heavy = 9}}
		},
	fire = {
		health_reference = 1,
		zones = {{fire = 1}}
	},
	poison = {
		health_reference = 1,
		zones = {{poison = 1}}
	}
}

local heavy_swat_hurts = {
	bullet = {
		health_reference = "current",
		zones = {
			{
				heavy = 0.0,
				health_limit = 0.3,
				light = 0.8,
				moderate = 0.0,
				none = 0.2
			},
			{
				heavy = 0.0,
				light = 0.5,
				moderate = 0.5,
				health_limit = 0.6
			},
			{
				heavy = 0.4,
				light = 0.0,
				moderate = 0.6,
				health_limit = 0.9
			},
			{
				light = 0,
				moderate = 0,
				heavy = 1
			}
		}
	},
	explosion = {
		health_reference = "current",
		zones = {
			{
				none = 0.6,
				heavy = 0.4,
				health_limit = 0.2
			},
			{
				explode = 0.4,
				heavy = 0.6,
				health_limit = 0.5
			},
			{
				explode = 0.8,
				heavy = 0.2
			}
		}
	},
	melee = {
		health_reference = "current",
		zones = {
			{
				heavy = 0,
				health_limit = 0.3,
				light = 0.7,
				moderate = 0,
				none = 0.3
			},
			{
				heavy = 0,
				light = 1,
				moderate = 0,
				health_limit = 0.8
			},
			{
				heavy = 0.2,
				light = 0.6,
				moderate = 0.2,
				health_limit = 0.9
			},
			{
				light = 0,
				moderate = 0,
				heavy = 9
			}
		}
	},
	fire = {
		health_reference = "current",
		zones = {
			{
				fire = 1
			}
		}
	},
	poison = {
		health_reference = "current",
		zones = {
			{
				poison = 1,
				none = 0
			}
		}
	}
}

local function Gilza_set_new_health(self)
	self.gangster.HEALTH_INIT = 50
	self.zeal_swat.HEALTH_INIT = 50
	self.zeal_heavy_swat.HEALTH_INIT = 90
	self.bolivian_indoors_mex.HEALTH_INIT = 50
	self.security_mex_no_pager.HEALTH_INIT = 25
	self.biker.HEALTH_INIT = 50
	self.captain.HEALTH_INIT = 25
	self.biker_escape.HEALTH_INIT = 50
	self.biker_female.HEALTH_INIT = 50
	self.mobster.HEALTH_INIT = 25
	self.bolivian.HEALTH_INIT = 50
	self.bolivian_indoors.HEALTH_INIT = 50
	self.triad.HEALTH_INIT = 50
	self.ranchmanager.HEALTH_INIT = 50
	self.security.HEALTH_INIT = 25
	self.security_undominatable.HEALTH_INIT = 25
	self.mute_security_undominatable.HEALTH_INIT = 25
	self.gensec.HEALTH_INIT = 25
	self.cop.HEALTH_INIT = 25
	self.cop_scared.HEALTH_INIT = 25
	self.cop_female.HEALTH_INIT = 25
	self.fbi.HEALTH_INIT = 50
	self.fbi_female.HEALTH_INIT = 50
	self.swat.HEALTH_INIT = 50
	self.fbi_swat.HEALTH_INIT = 50
	self.city_swat.HEALTH_INIT = 50
	self.heavy_swat.HEALTH_INIT = 90
	self.heavy_swat_sniper.HEALTH_INIT = 90
	self.fbi_heavy_swat.HEALTH_INIT = 90
	self.shield.HEALTH_INIT = 50
	self.sniper.HEALTH_INIT = 25
	self.taser.HEALTH_INIT = 125
	self.medic.HEALTH_INIT = 125
	self.spooc.HEALTH_INIT = 154
	self.shadow_spooc.HEALTH_INIT = 280
	self.tank.HEALTH_INIT = 1200
	self.tank_medic.HEALTH_INIT = 1200
	self.tank_mini.HEALTH_INIT = 2400
	self.tank_hw.HEALTH_INIT = 1200
	self.phalanx_minion.HEALTH_INIT = 400
	self.phalanx_vip.HEALTH_INIT = 800
	self.mobster_boss.HEALTH_INIT = 450
	self.biker_boss.HEALTH_INIT = 3000
	self.chavez_boss.HEALTH_INIT = 450
	self.hector_boss.HEALTH_INIT = 450
	self.drug_lord_boss.HEALTH_INIT = 2550
	self.drug_lord_boss_stealth.HEALTH_INIT = 50
	self.triad_boss.HEALTH_INIT = 3300
	self.triad_boss_no_armor.HEALTH_INIT = 50
	self.snowman_boss.HEALTH_INIT = 3300
	self.piggydozer.HEALTH_INIT = 2600
	self.marshal_marksman.HEALTH_INIT = 125
	self.marshal_shield.HEALTH_INIT = 90
	self.marshal_shield_break.HEALTH_INIT = 250
	self.deep_boss.HEALTH_INIT = 15000
	
	local enemies = {
		"gangster",
		"zeal_swat",
		"zeal_heavy_swat",
		"bolivian_indoors_mex",
		"security_mex_no_pager",
		"biker",
		"captain",
		"biker_escape",
		"biker_female",
		"mobster",
		"bolivian",
		"bolivian_indoors",
		"triad",
		"ranchmanager",
		"security",
		"security_undominatable",
		"mute_security_undominatable",
		"gensec",
		"cop",
		"cop_scared",
		"cop_female",
		"fbi",
		"fbi_female",
		"swat",
		"fbi_swat",
		"city_swat",
		"heavy_swat",
		"heavy_swat_sniper",
		"fbi_heavy_swat",
		"shield",
		"sniper",
		"taser",
		"medic",
		"mobster_boss",
		"biker_boss",
		"chavez_boss",
		"hector_boss",
		"drug_lord_boss",
		"drug_lord_boss_stealth",
		"triad_boss",
		"triad_boss_no_armor",
		"snowman_boss",
		"piggydozer",
		"marshal_marksman",
		"marshal_shield",
		"marshal_shield_break"
	}
	
	for i=1, #enemies do
		if self[tostring(enemies[i])] and self[tostring(enemies[i])].headshot_dmg_mul then
			self[tostring(enemies[i])].headshot_dmg_mul = 2
		end
	end
	
	self.spooc.headshot_dmg_mul = 2.8
	self.shadow_spooc.headshot_dmg_mul = 2.8
	self.tank_mini.headshot_dmg_mul = 6
	self.tank_medic.headshot_dmg_mul = 6
	self.tank.headshot_dmg_mul = 6
	self.phalanx_minion.headshot_dmg_mul = 4
	self.phalanx_vip.headshot_dmg_mul = 4
	-- this guy has 1x HS mul in base game, so we keepin it, TTK might be a bit faster due to higher overall dmg, but higher base health should compensate it
	self.deep_boss.headshot_dmg_mul = 1
	
	-- tags used for melee damage adjustments
	self.phalanx_minion.Gilza_winters_tag = true
	self.phalanx_vip.Gilza_winters_tag = true
	self.mobster_boss.Gilza_boss_tag = true
	self.biker_boss.Gilza_boss_tag = true
	self.chavez_boss.Gilza_boss_tag = true
	self.hector_boss.Gilza_boss_tag = true
	self.drug_lord_boss.Gilza_boss_tag = true
	self.triad_boss.Gilza_boss_tag = true
	self.snowman_boss.Gilza_boss_tag = true
	self.deep_boss.Gilza_boss_tag_deep = true
	self.tank_hw.Gilza_headless_dozer_tag = true
	
	-- headless dozer tag used to reduce their bullet damage. needed to be done this way, because all bodyshot bullet damage in this mod is about 2x higher,
	-- while bodyshots are about the same. also health can not be altered to avoid fucking with explosive breakpoints too much.
	self.tank_hw.Gilza_headless_tag = true
	
	-- knockdown
	self.city_swat.damage.hurt_severity = city_swat_hurts
	self.fbi_heavy_swat.damage.hurt_severity = heavy_swat_hurts
end

Hooks:PostHook(CharacterTweakData, "_set_normal", "Gilza_CharacterTweakData_set_health_normal", function(self)
	Gilza_set_new_health(self)
end)

Hooks:PostHook(CharacterTweakData, "_set_hard", "Gilza_CharacterTweakData_set_health_hard", function(self)
	Gilza_set_new_health(self)
end)

Hooks:PostHook(CharacterTweakData, "_set_overkill", "Gilza_CharacterTweakData_set_health_veryHard", function(self)
	Gilza_set_new_health(self)
end)

Hooks:PostHook(CharacterTweakData, "_set_overkill_145", "Gilza_CharacterTweakData_set_health_OVERKILL", function(self)
	Gilza_set_new_health(self)
end)

Hooks:PostHook(CharacterTweakData, "_set_easy_wish", "Gilza_CharacterTweakData_set_health_mayhem", function(self)
	Gilza_set_new_health(self)
end)

Hooks:PostHook(CharacterTweakData, "_set_overkill_290", "Gilza_CharacterTweakData_set_health_deathWish", function(self)
	Gilza_set_new_health(self)
end)

Hooks:PostHook(CharacterTweakData, "_set_sm_wish", "Gilza_CharacterTweakData_set_health_deathSentence", function(self)
	Gilza_set_new_health(self)
	-- 2x to keep in line with DS
	self.tank.HEALTH_INIT = 2400
	self.tank_medic.HEALTH_INIT = 2400
	self.tank_mini.HEALTH_INIT = 4800
	-- why are you this way as well?
	self.marshal_marksman.HEALTH_INIT = 250
end)
