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

--difficulties easier then ovkl are probably never played, and even if they are, they are pointless to adjust, cuz everything will be overpowered there regardless of stat changes
Hooks:PostHook(CharacterTweakData, "_set_overkill_145", "sethealthOVK", function(self)
	local enemies = {
		-- crooks
		"gangster",
		"biker",
		"captain",
		"biker_escape",
		"mobster",
		"bolivian",
		"bolivian_indoors",
		"triad",
		-- security guards
		"security",
		"security_undominatable",
		"mute_security_undominatable",
		"gensec",
		-- the boys in blue
		"cop",
		"cop_scared",
		"cop_female",
		-- FBIs, whiteshirtblackguy
		"fbi",
		-- blues, HRTs
		"swat",
		-- greens
		"fbi_swat",
		-- grays
		"city_swat",
		-- whiteheads
		"heavy_swat",
		"heavy_swat_sniper",
		-- tans
		"fbi_heavy_swat",
		-- SHIELD
		"shield",
		-- SNIPER
		"sniper",
		-- TASER
		"taser",
		-- MEDIC
		"medic",
		-- CLOAKER
		"spooc",
		"shadow_spooc",
		-- BULLDOZER
		"tank",
		"tank_medic", 
		"tank_mini",
		"tank_hw",
		-- THE WINTERS BRIGADE
		"phalanx_minion",
		"phalanx_vip",
		-- THE COMMISSAR
		"mobster_boss",
		-- LIEUTENANT WHO?
		"biker_boss",
		-- CHAVEZ
		"chavez_boss",
		-- HECTOR
		"hector_boss",
		-- ERNESTO SOSA
		"drug_lord_boss",
		-- mountain master guy
		"triad_boss",
		-- yeap, this happened
		"snowman_boss",
		-- marshals
		"marshal_marksman",
		-- shield ones
		"marshal_shield",
	}
	
	for i=1, #enemies do
		if self[tostring(enemies[i])] and self[tostring(enemies[i])].HEALTH_INIT then
			self[tostring(enemies[i])].HEALTH_INIT = self[tostring(enemies[i])].HEALTH_INIT * 1.3
			self[tostring(enemies[i])].headshot_dmg_mul = 3
		end
	end
	
	self.taser.HEALTH_INIT = self.taser.HEALTH_INIT * 0.68
	self.medic.HEALTH_INIT = self.medic.HEALTH_INIT * 0.68
	self.marshal_marksman.HEALTH_INIT = self.marshal_marksman.HEALTH_INIT * 0.68
	self.spooc.headshot_dmg_mul = 11.25
	self.tank_mini.headshot_dmg_mul = 10.5
	self.tank_medic.headshot_dmg_mul = 10.5
	self.tank.headshot_dmg_mul = 10.5
	
	self.phalanx_minion.Gilza_winters_tag = true
	self.phalanx_vip.Gilza_winters_tag = true
	
	self.mobster_boss.Gilza_boss_tag = true
	self.biker_boss.Gilza_boss_tag = true
	self.chavez_boss.Gilza_boss_tag = true
	self.hector_boss.Gilza_boss_tag = true
	self.drug_lord_boss.Gilza_boss_tag = true
	self.triad_boss.Gilza_boss_tag = true
	self.snowman_boss.Gilza_boss_tag = true
	
	self.city_swat.damage.hurt_severity = city_swat_hurts
	self.fbi_heavy_swat.damage.hurt_severity = heavy_swat_hurts
end)

Hooks:PostHook(CharacterTweakData, "_set_easy_wish", "sethealthMayhem", function(self)
	local enemies = {
		-- crooks
		"gangster",
		"biker",
		"captain",
		"biker_escape",
		"mobster",
		"bolivian",
		"bolivian_indoors",
		"triad",
		-- security guards
		"security",
		"security_undominatable",
		"mute_security_undominatable",
		"gensec",
		-- the boys in blue
		"cop",
		"cop_scared",
		"cop_female",
		-- FBIs, whiteshirtblackguy
		"fbi",
		-- blues, HRTs
		"swat",
		-- greens
		"fbi_swat",
		-- grays
		"city_swat",
		-- whiteheads
		"heavy_swat",
		"heavy_swat_sniper",
		-- tans
		"fbi_heavy_swat",
		-- SHIELD
		"shield",
		-- SNIPER
		"sniper",
		-- TASER
		"taser",
		-- MEDIC
		"medic",
		-- CLOAKER
		"spooc",
		"shadow_spooc",
		-- BULLDOZER
		"tank",
		"tank_medic", 
		"tank_mini",
		"tank_hw",
		-- THE WINTERS BRIGADE
		"phalanx_minion",
		"phalanx_vip",
		-- THE COMMISSAR
		"mobster_boss",
		-- LIEUTENANT WHO?
		"biker_boss",
		-- CHAVEZ
		"chavez_boss",
		-- HECTOR
		"hector_boss",
		-- ERNESTO SOSA
		"drug_lord_boss",
		-- mountain master guy
		"triad_boss",
		-- yeap, this happened
		"snowman_boss",
		-- marshals
		"marshal_marksman",
		-- shield ones
		"marshal_shield",
	}
	
	for i=1, #enemies do
		if self[tostring(enemies[i])] and self[tostring(enemies[i])].HEALTH_INIT then
			self[tostring(enemies[i])].HEALTH_INIT = self[tostring(enemies[i])].HEALTH_INIT * 1.3
			self[tostring(enemies[i])].headshot_dmg_mul = 3
		end
	end
	
	self.taser.HEALTH_INIT = self.taser.HEALTH_INIT * 0.68
	self.medic.HEALTH_INIT = self.medic.HEALTH_INIT * 0.68
	self.marshal_marksman.HEALTH_INIT = self.marshal_marksman.HEALTH_INIT * 0.68
	self.spooc.headshot_dmg_mul = 9
	self.tank_mini.headshot_dmg_mul = 10.5
	self.tank_medic.headshot_dmg_mul = 10.5
	self.tank.headshot_dmg_mul = 10.5
	
	self.phalanx_minion.Gilza_winters_tag = true
	self.phalanx_vip.Gilza_winters_tag = true
	
	self.mobster_boss.Gilza_boss_tag = true
	self.biker_boss.Gilza_boss_tag = true
	self.chavez_boss.Gilza_boss_tag = true
	self.hector_boss.Gilza_boss_tag = true
	self.drug_lord_boss.Gilza_boss_tag = true
	self.triad_boss.Gilza_boss_tag = true
	self.snowman_boss.Gilza_boss_tag = true
	
	self.city_swat.damage.hurt_severity = city_swat_hurts
	self.fbi_heavy_swat.damage.hurt_severity = heavy_swat_hurts
end)

Hooks:PostHook(CharacterTweakData, "_set_overkill_290", "sethealthDW", function(self)
	local enemies = {
		-- crooks
		"gangster",
		"biker",
		"captain",
		"biker_escape",
		"mobster",
		"bolivian",
		"bolivian_indoors",
		"triad",
		-- security guards
		"security",
		"security_undominatable",
		"mute_security_undominatable",
		"gensec",
		-- the boys in blue
		"cop",
		"cop_scared",
		"cop_female",
		-- FBIs, whiteshirtblackguy
		"fbi",
		-- blues, HRTs
		"swat",
		-- greens
		"fbi_swat",
		-- grays
		"city_swat",
		-- whiteheads
		"heavy_swat",
		"heavy_swat_sniper",
		-- tans
		"fbi_heavy_swat",
		-- SHIELD
		"shield",
		-- SNIPER
		"sniper",
		-- TASER
		"taser",
		-- MEDIC
		"medic",
		-- CLOAKER
		"spooc",
		"shadow_spooc",
		-- BULLDOZER
		"tank",
		"tank_medic", 
		"tank_mini",
		"tank_hw",
		-- THE WINTERS BRIGADE
		"phalanx_minion",
		"phalanx_vip",
		-- THE COMMISSAR
		"mobster_boss",
		-- LIEUTENANT WHO?
		"biker_boss",
		-- CHAVEZ
		"chavez_boss",
		-- HECTOR
		"hector_boss",
		-- ERNESTO SOSA
		"drug_lord_boss",
		-- mountain master guy
		"triad_boss",
		-- yeap, this happened
		"snowman_boss",
		-- marshals
		"marshal_marksman",
		-- shield ones. they allready have like 4k health is this even needed lmao
		"marshal_shield",
	}
	for i=1, #enemies do
		if self[tostring(enemies[i])] and self[tostring(enemies[i])].HEALTH_INIT then
			self[tostring(enemies[i])].HEALTH_INIT = self[tostring(enemies[i])].HEALTH_INIT * 1.3
			self[tostring(enemies[i])].headshot_dmg_mul = 3
		end
	end
	
	self.taser.HEALTH_INIT = self.taser.HEALTH_INIT * 0.68
	self.medic.HEALTH_INIT = self.medic.HEALTH_INIT * 0.68
	self.marshal_marksman.HEALTH_INIT = self.marshal_marksman.HEALTH_INIT * 0.68
	self.spooc.headshot_dmg_mul = 8.5
	self.tank_mini.headshot_dmg_mul = 8.5
	self.tank_medic.headshot_dmg_mul = 8.5
	self.tank.headshot_dmg_mul = 8.5
	
	self.phalanx_minion.Gilza_winters_tag = true
	self.phalanx_vip.Gilza_winters_tag = true
	
	self.mobster_boss.Gilza_boss_tag = true
	self.biker_boss.Gilza_boss_tag = true
	self.chavez_boss.Gilza_boss_tag = true
	self.hector_boss.Gilza_boss_tag = true
	self.drug_lord_boss.Gilza_boss_tag = true
	self.triad_boss.Gilza_boss_tag = true
	self.snowman_boss.Gilza_boss_tag = true
	
	self.city_swat.damage.hurt_severity = city_swat_hurts
	self.fbi_heavy_swat.damage.hurt_severity = heavy_swat_hurts
end)

Hooks:PostHook(CharacterTweakData, "_set_sm_wish", "sethealthDS", function(self)
	local enemies = {
		-- crooks
		"gangster",
		"biker",
		"captain",
		"biker_escape",
		"mobster",
		"bolivian",
		"bolivian_indoors",
		"triad",
		-- idek which one this is
		"ranchmanager",
		-- security guards
		"security",
		"security_undominatable",
		"mute_security_undominatable",
		"gensec",
		-- the boys in blue
		"cop",
		"cop_scared",
		"cop_female",
		-- FBIs, whiteshirtblackguy
		"fbi",
		-- blues, HRTs
		"swat",
		-- greens
		"fbi_swat",
		-- grays
		"city_swat",
		-- whiteheads
		"heavy_swat",
		"heavy_swat_sniper",
		-- tans
		"fbi_heavy_swat",
		-- SHIELD
		"shield",
		-- SNIPER
		"sniper",
		-- TASER
		"taser",
		-- MEDIC
		"medic",
		-- CLOAKER
		"spooc",
		"shadow_spooc",
		-- BULLDOZER
		"tank",
		"tank_medic", 
		"tank_mini",
		"tank_hw",
		-- THE WINTERS BRIGADE
		"phalanx_minion",
		"phalanx_vip",
		-- THE COMMISSAR
		"mobster_boss",
		-- LIEUTENANT WHO?
		"biker_boss",
		-- CHAVEZ
		"chavez_boss",
		-- HECTOR
		"hector_boss",
		-- ERNESTO SOSA
		"drug_lord_boss",
		-- mountain master guy
		"triad_boss",
		-- yeap, this happened
		"snowman_boss",
		-- marshals
		"marshal_marksman",
		-- shield ones. they allready have like 4k health is this even needed lmao
		"marshal_shield",
	}
	
	for i=1, #enemies do
		if self[tostring(enemies[i])] and self[tostring(enemies[i])].HEALTH_INIT then
			self[tostring(enemies[i])].HEALTH_INIT = self[tostring(enemies[i])].HEALTH_INIT * 1.3
			self[tostring(enemies[i])].headshot_dmg_mul = 3
		end
	end
	
	self.taser.HEALTH_INIT = self.taser.HEALTH_INIT * 0.68
	self.medic.HEALTH_INIT = self.medic.HEALTH_INIT * 0.68
	self.marshal_marksman.HEALTH_INIT = self.marshal_marksman.HEALTH_INIT * 0.68
	self.spooc.headshot_dmg_mul = 8.5
	self.tank_mini.headshot_dmg_mul = 8.5
	self.tank_medic.headshot_dmg_mul = 8.5
	self.tank.headshot_dmg_mul = 8.5
	
	self.phalanx_minion.Gilza_winters_tag = true
	self.phalanx_vip.Gilza_winters_tag = true
	
	self.mobster_boss.Gilza_boss_tag = true
	self.biker_boss.Gilza_boss_tag = true
	self.chavez_boss.Gilza_boss_tag = true
	self.hector_boss.Gilza_boss_tag = true
	self.drug_lord_boss.Gilza_boss_tag = true
	self.triad_boss.Gilza_boss_tag = true
	self.snowman_boss.Gilza_boss_tag = true
	
	self.city_swat.damage.hurt_severity = city_swat_hurts
	self.fbi_heavy_swat.damage.hurt_severity = heavy_swat_hurts
end)
