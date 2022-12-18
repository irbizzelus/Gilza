--difficulties easier then ovkl are probably never played, and even if they are, they are pointless to adjust, cuz everything will be overpowered there regardless of stat changes
Hooks:PostHook(CharacterTweakData, "_set_overkill_145", "sethealthOVK", function(self)
	local enemies = {
		"marshal_marksman",
		-- crooks
		"gangster",
		"biker",
		"captain",
		"biker_escape",
		"mobster",
		"bolivian",
		"bolivian_indoors",
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
	self.spooc.headshot_dmg_mul = 12
	self.tank_mini.headshot_dmg_mul = 12
	self.tank_medic.headshot_dmg_mul = 12
	self.tank.headshot_dmg_mul = 12
end)

Hooks:PostHook(CharacterTweakData, "_set_easy_wish", "sethealthMayhem", function(self)
	local enemies = {
		"marshal_marksman",
		-- crooks
		"gangster",
		"biker",
		"captain",
		"biker_escape",
		"mobster",
		"bolivian",
		"bolivian_indoors",
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
	self.spooc.headshot_dmg_mul = 12
	self.tank_mini.headshot_dmg_mul = 12
	self.tank_medic.headshot_dmg_mul = 12
	self.tank.headshot_dmg_mul = 12
end)

Hooks:PostHook(CharacterTweakData, "_set_overkill_290", "sethealthDW", function(self)
	local enemies = {
		"marshal_marksman",
		-- crooks
		"gangster",
		"biker",
		"captain",
		"biker_escape",
		"mobster",
		"bolivian",
		"bolivian_indoors",
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
	self.spooc.headshot_dmg_mul = 12
	self.tank_mini.headshot_dmg_mul = 12
	self.tank_medic.headshot_dmg_mul = 12
	self.tank.headshot_dmg_mul = 12
end)

Hooks:PostHook(CharacterTweakData, "_set_sm_wish", "sethealthDS", function(self)
	local enemies = {
		"marshal_marksman",
		-- crooks
		"gangster",
		"biker",
		"captain",
		"biker_escape",
		"mobster",
		"bolivian",
		"bolivian_indoors",
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
	self.spooc.headshot_dmg_mul = 12
	self.tank_mini.headshot_dmg_mul = 12
	self.tank_medic.headshot_dmg_mul = 12
	self.tank.headshot_dmg_mul = 12
end)
