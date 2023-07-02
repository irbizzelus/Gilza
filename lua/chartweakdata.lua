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
	self.gangster.HEALTH_INIT = 62
	self.biker.HEALTH_INIT = 62
	self.captain.HEALTH_INIT = 10
	self.biker_escape.HEALTH_INIT = 62
	self.mobster.HEALTH_INIT = 10
	self.bolivian.HEALTH_INIT = 62
	self.bolivian_indoors.HEALTH_INIT = 62
	self.triad.HEALTH_INIT = 62
	self.ranchmanager.HEALTH_INIT = 62
	self.security.HEALTH_INIT = 10
	self.security_undominatable.HEALTH_INIT = 10
	self.mute_security_undominatable.HEALTH_INIT = 10
	self.gensec.HEALTH_INIT = 10
	self.cop.HEALTH_INIT = 10
	self.cop_scared.HEALTH_INIT = 10
	self.cop_female.HEALTH_INIT = 10
	self.fbi.HEALTH_INIT = 62
	self.swat.HEALTH_INIT = 62
	self.fbi_swat.HEALTH_INIT = 62
	self.city_swat.HEALTH_INIT = 62
	self.heavy_swat.HEALTH_INIT = 124
	self.heavy_swat_sniper.HEALTH_INIT = 124
	self.fbi_heavy_swat.HEALTH_INIT = 124
	self.shield.HEALTH_INIT = 62
	self.sniper.HEALTH_INIT = 31
	self.taser.HEALTH_INIT = 158
	self.medic.HEALTH_INIT = 158
	self.spooc.HEALTH_INIT = 468
	self.shadow_spooc.HEALTH_INIT = 780
	self.tank.HEALTH_INIT = 1600
	self.tank_medic.HEALTH_INIT = 1600
	self.tank_mini.HEALTH_INIT = 3200
	self.tank_hw.HEALTH_INIT = 1600
	self.phalanx_minion.HEALTH_INIT = 500
	self.phalanx_vip.HEALTH_INIT = 1000
	self.mobster_boss.HEALTH_INIT = 1200
	self.biker_boss.HEALTH_INIT = 3900
	self.chavez_boss.HEALTH_INIT = 1200
	self.hector_boss.HEALTH_INIT = 1200
	self.drug_lord_boss.HEALTH_INIT = 2700
	self.triad_boss.HEALTH_INIT = 4200
	self.snowman_boss.HEALTH_INIT = 3400
	self.marshal_marksman.HEALTH_INIT = 158
	self.marshal_shield.HEALTH_INIT = 124
	self.deep_boss.HEALTH_INIT = 14000
	
	local enemies = {
		"gangster",
		"biker",
		"captain",
		"biker_escape",
		"mobster",
		"bolivian",
		"bolivian_indoors",
		"triad",
		"security",
		"security_undominatable",
		"mute_security_undominatable",
		"gensec",
		"cop",
		"cop_scared",
		"cop_female",
		"fbi",
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
		"shadow_spooc",
		"tank_hw",
		"mobster_boss",
		"biker_boss",
		"chavez_boss",
		"hector_boss",
		"drug_lord_boss",
		"triad_boss",
		"snowman_boss",
		"marshal_marksman",
		"marshal_shield"
	}
	
	for i=1, #enemies do
		if self[tostring(enemies[i])] and self[tostring(enemies[i])].HEALTH_INIT then
			self[tostring(enemies[i])].headshot_dmg_mul = 3
		end
	end
	
	self.spooc.headshot_dmg_mul = 8.5
	self.tank_mini.headshot_dmg_mul = 8.5
	self.tank_medic.headshot_dmg_mul = 8.5
	self.tank.headshot_dmg_mul = 8.5
	self.phalanx_minion.headshot_dmg_mul = 4
	self.phalanx_vip.headshot_dmg_mul = 4
	-- this guy has 1x HS mul in base game + 1.25 bonus from perk decks, so this is fair, if you take into account worse pick up. TTK should be about 30% faster then vanilla
	self.deep_boss.headshot_dmg_mul = 1.5
	
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
	
	self.city_swat.damage.hurt_severity = city_swat_hurts
	self.fbi_heavy_swat.damage.hurt_severity = heavy_swat_hurts
end

Hooks:PostHook(CharacterTweakData, "_set_normal", "Gilza_set_health_normal", function(self)
	Gilza_set_new_health(self)
end)

Hooks:PostHook(CharacterTweakData, "_set_hard", "Gilza_set_health_hard", function(self)
	Gilza_set_new_health(self)
end)

Hooks:PostHook(CharacterTweakData, "_set_overkill", "Gilza_set_health_veryHard", function(self)
	Gilza_set_new_health(self)
end)

Hooks:PostHook(CharacterTweakData, "_set_overkill_145", "Gilza_set_health_OVERKILL", function(self)
	Gilza_set_new_health(self)
end)

Hooks:PostHook(CharacterTweakData, "_set_easy_wish", "Gilza_set_health_mayhem", function(self)
	Gilza_set_new_health(self)
end)

Hooks:PostHook(CharacterTweakData, "_set_overkill_290", "Gilza_set_health_deathWish", function(self)
	Gilza_set_new_health(self)
end)

Hooks:PostHook(CharacterTweakData, "_set_sm_wish", "Gilza_set_health_deathSentence", function(self)
	Gilza_set_new_health(self)
	self.tank.HEALTH_INIT = 3200
	self.tank_medic.HEALTH_INIT = 3200
	self.tank_mini.HEALTH_INIT = 6400
	self.marshal_marksman.HEALTH_INIT = 220
end)
