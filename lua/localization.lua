Hooks:Add('LocalizationManagerPostInit', 'Gilza_localizations', function(loc)

	Gilza:Load()
	
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
	
	local function AddEnglishLoc()
		
		---- PERKS ----
		LocalizationManager:add_localized_strings({
			-- General
			menu_deckall_2 = "Fast and Furious",
			menu_deckall_2_desc = "Increases your doctor bag interaction speed by ##20%##",
			-- Fix for custom perk decks for 4th card missing reference values
			menu_deckall_4_desc_new = "You gain ##+1## increased concealment.\n\nWhen wearing armor, your movement speed is ##15%## less affected.\n\nYou gain ##45%## more experience when you complete days and jobs.",
			menu_deckall_6_desc = "Unlocks an armor bag equipment for you to use. The armor bag can be used to change your armor during a heist.\n\nIncreases your ammo pickup to ##135%## of the normal rate.\n\nYou also gain a base ##0%## chance to get a throwable from an ammo box. The base chance is increased by ##0.8% * x## (where x - throwable pick up multiplier) for each ammo box you pick up that does not contain a throwable. When a throwable has been found, the chance is reset to its base value.\n\nNote: Throwable pick up multipliers are different for each throwable - you can find them under throwable descriptions.",
			menu_deckall_8 = "Improved Physique",
			menu_deckall_8_desc = "You gain ##10%## additional movement speed.\n\nYou can throw bags ##50%## further.",
			
			-- Vanilla decks
			menu_deck4_9_desc = "All your weapons have a ##50%## chance to pierce enemy armor.\nIncreases weapon swapping speed by ##80%##.\n\nYour chance to dodge is increased by an additional ##5%##.\nYour chance to dodge while crouched is increased by ##5%##.\nYour movement speed is increased by ##15%##.\nYour stamina is increased by ##25%##.\n\nDeck Completion Bonus: Your chance of getting a higher quality item during a Payday is increased by ##10%##.",
			menu_deck5_1_desc = "When you receive damage while recovering armor, your armor recovery timer will pause for a brief duration instead of reseting to it's maximum duration.\n\nRecovery pause lasts for ##40%## of your maximum armor recovery time, unless it would exceed your total armor recovery beyond the maximum, in which case it is reduced.\n\nYour armor recovery rate is increased by ##5%##.\n\n",
			menu_sociopathinfil_1_desc = "When you are surrounded by three enemies or more, you receive ##12%## less damage from enemies.\n\nYour second and each consecutive melee hit within ##4## seconds of the last one will deal ##75%## more damage.\n",
			menu_deck10_1_desc = "Ammo packs you pick up also yield medical supplies and heal you for ##16## to ##24## health.\n\nCannot occur more than once every ##3## seconds.\n\nIf the Gambler's current health is lower than another player's, the heal effect on the Gambler is increased by ##40%##. Does not stack.\n\nYour ammo box pick up range is increased by ##50%##.",
			menu_deck12_9_desc = "All berserker state effects in this perk deck will start at ##50%## health instead of ##25%##.\n\nEntering berserker state makes you immune to armor piercing and armor suppression effects.\n\nDeck Completion Bonus: Your chance of getting a higher quality item during a Payday is increased by ##10%##.",
			menu_deck18_1_desc = "Unlocks and equips the throwable Smoke Bomb.\n\nChanging to another perk deck will make the Smoke Bomb unavailable again. The Smoke Bomb replaces your current throwable, is equipped in your throwable slot and can be switched out if desired.\n\nWhile in game you can use throwable key ##$BTN_ABILITY;## to deploy the Smoke Bomb.\n\nWhen deployed, the smoke bomb creates a smoke screen that lasts for ##10## seconds. While standing inside the smoke screen, you and any of your allies automatically avoid ##50%## of all bullets. Any enemies that stand in the smoke will see their accuracy reduced by ##50%##.\n\nAfter the smoke screen dissipates, the Smoke Bomb is on a cooldown for ##40## seconds, but killing enemies will reduce this cooldown by ##1## second.",	
			menu_deck20_1_desc = "Unlocks and equips the Gas Dispenser.\n\nChanging to another perk deck will make the Gas Dispenser unavailable again. The Gas Dispenser replaces your current throwable, it can be switched out if desired.\n\nTo activate the Gas Dispenser you need to look at another allied unit within a ##24## meter radius and press the throwable key ##$BTN_ABILITY;## to tag them.\n\nEach enemy you or the tagged unit kills will now heal you for ##15## health and the tagged unit for ##7.5## health.\n\nEach enemy you kill will now extend the duration by ##1.7## seconds and reduce the cooldown timer by ##2## seconds.\n\nThe effect will last for a duration of ##12## seconds and has a cooldown of ##60## seconds.",
			menu_deck20_5_desc = "Each enemy you or the tagged unit kills will now grant you ##4## absorption up to a maximum of ##32##.\n\nThis effect will last until the perk deck item goes out of cooldown.",
			menu_deck21_1_desc = "Unlocks and equips the Pocket ECM Device.\n\nChanging to another perk deck will make the Pocket ECM Device unavailable again. The Pocket ECM Device replaces your current throwable, it can be switched out if desired.\n\nWhile in game you can use the throwable key ##$BTN_ABILITY;## to activate the Pocket ECM.\n\nActivating the Pocket ECM Device before the alarm is raised will trigger the jamming effect, disabling all electronics and pagers for a ##6## second duration.\n\nActivating the Pocket ECM Device after the alarm is raised will trigger the feedback effect, granting a chance to stun enemies on the map every second for a ##12## second duration.\n\nThe Pocket ECM Device has ##2## charges with a ##140## second cooldown timer, but each kill you perform will shorten the cooldown timer by ##4## seconds.",
			menu_deck21_5_desc = "Killing an enemy while the feedback effect is active will regenerate ##40## health.\nYour chance to dodge is increased by ##15%##.",
			menu_deck21_7_desc = "Killing at least ##3## enemies while the feedback or jamming effect is active will grant ##20## dodge for ##50## seconds.",
			-- Short descs for vanilla decks
			menu_deck4_9_desc_short = "All your weapons have a ##50%## chance to pierce enemy armor. Increases weapon swapping speed by ##80%##.\nYour chance to dodge is increased by an additional ##5%##. Your chance to dodge while crouched is increased by ##5%##. Your movement speed is increased by ##15%##. Your stamina is increased by ##25%##.",
			menu_deck5_1_desc_short = "When you receive damage while recovering armor, your armor recovery timer will pause for a brief duration instead of reseting to it's maximum duration.\nYour armor recovery rate is increased by ##5%##.\n\n",
			menu_deck10_1_desc_short = "Ammo pickups heal you. Your ammo box pick up range is increased by ##50%##.",
			menu_deck12_9_desc_short = "All berserker state effects in this perk deck will start at ##50%## health instead of ##25%##. Entering berserker state makes you immune to armor piercing and armor suppression effects.",
			menu_deck18_1_desc_short = "Unlocks and equips the throwable Smoke Bomb, replacing your current throwable. When deployed, the smoke bomb creates a smoke screen that lasts for ##10## seconds. While standing inside the smoke screen, all players avoid ##50%## of all bullets. Enemies standing in the smoke will see their accuracy reduced by ##50%##. Smoke Bomb requires a cooldown of ##40## seconds, but killing enemies will reduce this cooldown by ##1## second.",	
			menu_deck20_1_desc_short = "Unlocks and equips the Gas Dispenser, replaces your current throwable. To activate, you need to look at another allied unit within a ##24## meter radius and press the throwable key ##$BTN_ABILITY;## to tag them. Each enemy you or the tagged unit kills will now heal you for ##15## health and the tagged unit for ##7.5## health. Your kills will extend the duration of the effect by ##1.7## seconds and reduce the cooldown timer by ##2## seconds. The effect will last for a duration of ##12## seconds and has a cooldown of ##60## seconds.",
			menu_deck20_5_desc_short = "Each enemy you or the tagged unit kills will now grant you ##4## absorption up to a maximum of ##32##. This effect will last until the perk deck item goes out of cooldown.",
			menu_deck21_1_desc_short = "Unlocks and equips the Pocket ECM.",
			menu_deck21_5_desc_short = "Killing an enemy while the feedback effect is active will regenerate ##40## health. Your chance to dodge is increased by ##15%##.",
			menu_deck21_7_desc_short = "Killing at least ##3## enemies while the feedback or jamming effect is active will grant ##20## dodge for ##50## seconds.",
			
			---- Custom decks:
			-- Brawler
			menu_deck_brawler = "Brawler",
			menu_deck_brawler_desc = "Gage tipped Bain off about a shipment of experimental lightweight high power armor suits being transported by Murkywater to one of their facitilies. And who are you, if not THE fucking payday gang? Of course you had to steal it! But after properly inspecting them in your safehouse, you found out that they are extremely bulky, yet still somehow comfortable to run around in.\n\nThis, is how you became... THE BRAWLER!",
			menu_deck_brawler1 = "Armor suit upgrade",
			menu_deck_brawler1_desc = "Using this high profile armor suit with any kind of a chest rig is pretty much imposible due to it's form and size. But who needs them, right?\n\nYour total ammo capacity and ammo pick up rate are reduced by ##80%##.\n\nYour armor recovery rate is reduced by ##300%##.\n\nYour armor has ##10%## bullet damage resistance.",
			menu_deck_brawler3 = "Meat shield",
			menu_deck_brawler3_desc = "You are ##15%## more likely to be targeted when you are close to your crew members.\n\nYour armor now has ##10%## more bullet damage resistance.\n\nArmor movement speed penalty is reduced by ##20%##.",
			menu_deck_brawler5 = "Reflective armor plates",
			menu_deck_brawler5_desc = "Your armor can no longer be penetrated by armor piercing ammunition.\n\nYour armor now has ##10%## more bullet damage resistance.\n\nArmor movement penalty is reduced by additional ##20%##.\n\nSecuring a kill with a melee weapon restores ##10%## of your stamina.",
			menu_deck_brawler7 = "Fear inducing",
			menu_deck_brawler7_desc = "While you are under ##50%## health, you receive following bonuses:\n- Enemies within ##18## meters of you deal ##7%## less bullet damage to your armor\n- Enemies within ##10## meters of you deal ##16%## less bullet damage to your armor\n- Enemies within ##5## meters of you deal ##27%## less bullet damage to your armor\n\nDamage resistance bonuses from this perk card are ##doubled## on Death Sentence difficulty.",
			menu_deck_brawler9 = "Bloodlust",
			menu_deck_brawler9_desc = "Securing a kill with a melee weapon starts regenerating ##100## points of armor over a period of ##6## seconds, with a \"tick\" of regeneration every ##0.75## seconds.\nYou can have up to ##3## armor regeneration effects from this perk card at the same time.\n\nDeck Completion Bonus: Your chance of getting a higher quality item during a Payday is increased by ##10%##.",
			-- Short descs for Brawler
			menu_deck_brawler1_desc_short = "Your ammo capacity and pick up rate are reduced by ##80%##. Your armor recovery rate is reduced by ##300%##. Your armor has ##10%## bullet damage resistance.",
			menu_deck_brawler3_desc_short = "You are ##15%## more likely to be targeted when you are close to your crew members. Your armor has ##10%## more bullet damage resistance. Armor movement speed penalty is reduced by ##20%##.",
			menu_deck_brawler5_desc_short = "Your armor is now immune to AP effects. Your armor has ##10%## more bullet damage resistance. Armor movement penalty is reduced by additional ##20%##. Melee kills restore ##10%## of your stamina.",
			menu_deck_brawler7_desc_short = "While you are under ##50%## health, enemies will deal less damage to your armor. Closer they are, less damage they deal.",
			menu_deck_brawler9_desc_short = "Melee kills grant ##100## points of armor regeneration over a period of ##6## seconds. You can have up to ##3## armor regeneration effects from this perk card at the same time.",
			
			-- Speed Junkie
			menu_deck_SJ = "Speed Junkie",
			menu_deck_SJ_desc = "are you there? or have you been gone for a long time? WHO CARES WE ARE HERE TO PARTY BABY!!! TAKE THIS PILL, OR WAIT, MAYBE THIS ONE? FUCK IT, TAKE THEM ALL! ...\ndays? weeks? months? when was the last time you saw SO MANY PEOPLE IN ONE PLACE? ALL OUT OF THEIR MINDS AND HAPPY TO SEE YOU, COME ON! JOIN THE FUN! ...\nis it even worth it? maybe i just need to take a walk and clear my miND IS SO FUCKING DULL! I NEED TO GO, I NEED TO RUN, I NEED TO SPRINT AND JUMP, I NEED TO FEEL IT ALL! SPEED IS THE ONLY THING THAT MATTERS! SPEED IS MY WAY TO LIVE! speed is my way to die.",
			menu_deck_SJ_1 = "a powerful distraction",
			menu_deck_SJ_1_desc = "it seems like the only way you can keep your sanity in check is to go very, very fast. so be it.\n\nYou can now obtain up to ##100## adrenaline stacks by moving. Moving at higher speeds will add adrenaline stacks to your meter - faster your move, more stacks you gain. If you don't move quickly enough, your adrenaline stacks will begin to deplete.\n\nIf you maintain ##90## or more stacks of adrenaline for longer then ##4## seconds you will become exhausted. Becoming exhausted completely depletes your stamina and some of your adrenaline stacks.\n\nAdrenaline stacks counter will appear on your HUD. This counter will be colored in red when you have more then ##90## adrenaline stacks. If you become exhausted it will be colored in purple.\n\nFor every adrenaline stack you have you gain a chance to dodge, up to ##40%## maximum dodge chance at ##100## stacks.\n\nYou armor recovery can now only begin when you stand still.\n\nYou convert ##90%## of your health to ##42%## of armor.",
			menu_deck_SJ_3 = "I NEED TO MOVE! ",
			menu_deck_SJ_3_desc = "Your chance to dodge is increased by ##15%##.\n\nYou restore ##5%## of your stamina for every kill you get.\n\nYou convert ##90%## of your health to ##46%## of armor.",
			menu_deck_SJ_5 = "OUT OF MY WAY! ",
			menu_deck_SJ_5_desc = "Securing a kill adds ##3## stacks of adrenaline, but if that kill was a bodyshot you will get ##9## stacks instead.\nSecuring kills while your adrenaline stack amount is higher then ##90## will instead remove your adrenaline stacks at the same rate.\n\nNew ability: adrenaline spike.\nWhile your adrenaline stack amount is over ##70## you gain ##1## adrenaline spike point every second. When your reach ##20## adrenaline spike points, you become eligible for an adrenaline spike. While you are eligible for an adrenaline spike you have a ##10%## chance to activate it by securing a kill by any means. Adrenaline spike overdoses your adrenaline stacks for ##8## seconds. After adrenaline spike is over you become exhausted and your adrenaline spike points are reset to ##0##.\n\nYou convert ##90%## of your health to ##52%## of armor.",
			menu_deck_SJ_7 = "somebody.. STOP ME! ",
			menu_deck_SJ_7_desc = "You gain ##6## points of armor when you dodge. If you have no armor remaining, you will recieve ##24## armor points instead. This can not occur more often then once every ##1.5## seconds.",
			menu_deck_SJ_9 = "Overdose",
			menu_deck_SJ_9_desc = "You can gain up to ##25%## more movement speed if your armor is damaged - lower your armor percentage is, higher the movement speed.\n\nAdrenaline stacks will now provide additional bonuses that scale with amount of adrenaline stacks, this includes:\n- Up to ##40%## faster weapon reload speed\n- Up to ##100%## faster weapon swap speed\n- Up to ##40%## faster interaction speeds, excluding pager answers and crew member revives.\n\nDeck Completion Bonus: Your chance of getting a higher quality item during a Payday is increased by ##10%##.",
			-- Short descs for junkie
			menu_deck_SJ_1_desc_short = "Unlocks adrenaline stacks, earned for quick movement. Stacks provide up to ##40%## dodge. Armor recovery only begins when stationary. Convert ##90%## health for ##42%## armor.",
			menu_deck_SJ_3_desc_short = "Gain ##15%## dodge. Kills refill ##8%## of stamina. Convert ##90%## health for ##46%## armor.",
			menu_deck_SJ_5_desc_short = "Kills provide ##2-6## adrenaline stacks. Convert ##90%## health for ##52%## armor.",
			menu_deck_SJ_7_desc_short = "Dodging provides ##6-24## points of armor.",
			menu_deck_SJ_9_desc_short = "Move up to ##25%## faster lower your armor is. Adrenaline stacks now provide faster reload, interaction and weapon swap speeds.",
		})
		
		---- SKILLS ----
		LocalizationManager:add_localized_strings({
			-- Mastermind
			-- M1
			menu_inspire_beta_desc = "BASIC: ##$basic##\nYou revive crew members ##100%## faster. Shouting at your teammates grants both you and your teammate a morale boost for ##10## seconds. This boost increases movement and reload speed by ##20%## for your teammate, and by ##10%## for you.\n\nACE: ##$pro##\nThere is a ##100%## chance that you can revive crew members at a distance of up to ##9## meters by shouting at them. This cannon occur more than once every ##20## seconds.",
			-- M3
			menu_stable_shot_beta_desc = "BASIC: ##$basic##\nYou gain ##4## weapon Accuracy.\n\nACE: ##$pro##\nYou gain ##8## more weapon Accuracy.",
			menu_rifleman_beta = "Designated Marksman",
			menu_rifleman_beta_desc = "BASIC: ##$basic##\nYour snap to zoom is ##100%## faster with all weapons.\n\nYour weapon zoom level is increased by ##25%## with all weapons.\n\nACE: ##$pro##\nWhile aiming down sights your movement speed is unhindered.\n\nWhenever you start firing your weapon, first ##5## bullets fired gain additional ##35%## recoil reduction. Does not apply to Shotguns, Snipers and single shot fire mode Pistols.",
			menu_sharpshooter_beta = "Slow and Steady",
			menu_sharpshooter_beta_desc = "BASIC: ##$basic##\nYou gain ##7.5%## damage resistance while standing still or bipoded.\n\nACE: ##$pro##\nYou gain additional ##35%## damage resistance while bipoded.\nYour bipod deploy speed is increased by ##100%##.",
			menu_speedy_reload_beta_desc = "BASIC: ##$basic##\nIncreases your reload speed with SMGs, Assault Rifles and Sniper Rifles by ##20%##.\n\nACE: ##$pro##\nAny killing headshot will increase your reload speed by ##100%## for ##4## seconds. Can only be triggered by SMGs, Assault Rifles and Sniper Rifles fired in single shot fire mode.",
			menu_sniper_graze_damage_desc = "BASIC: ##$basic##\nSniper rifles that hit targets further then ##7.5m## away, will deal ##33%## of their damage in a ##75cm## radius around the bullet trajectory.\n\nDamage in the bullet trajectory does not increase if initial target was shot in the head, but can be increased by other skills.\n\nACE: ##$pro##\nDamage radius is increased to ##150cm##, damage in the radius is increased to ##66%## of your Sniper's damage.",
			
			-- Enforcer
			-- E1
			menu_shotgun_cqb_beta_desc = "BASIC: ##$basic##\nYour Shotgun reload speed is now ##15%## faster.\n\nACE: ##$pro##\nYour Shotgun reload speed is now ##35%## faster.",
			menu_shotgun_impact_beta = "Shotgun expert",
			menu_shotgun_impact_beta_desc = "BASIC: ##$basic##\nYou gain ##125%## increased steel sight zoom speed when using shotguns.\nYou gain ##20%## better stability with all shotguns.\n\nACE: ##$pro##\nYou gain ##50%## better stability with all shotguns.\n\nNote: Stability increase can push your shotgun stability beyond ##100##.",
			menu_far_away_beta = "BLAST AWAY",
			menu_far_away_beta_desc = "BASIC: ##$basic##\nEvery time you fire any Shotgun you get ##7.5%## chance to not consume any ammo.\n\nACE: ##$pro##\nYour chances to not consume any ammo increase to ##20%##.",
			menu_close_by_beta = "Fearmonger",
			menu_close_by_beta_desc = "BASIC: ##$basic##\nYou can now hip-fire with your Shotguns while sprinting.\n\nACE: ##$pro##\nIf you kill an enemy with a Shotgun that has more then ##35## threat, you have a ##75%## chance to cause enemies in a ##12m## radius around you to panic. Panic can make enemies go into short bursts of uncontrollable fear.\n\nKilling enemies during their bursts of fear fully restores your stamina and grants you ##25%## movement speed bonus for ##20## seconds.\n\nNote: Upon activation this skill creates a pop up notification. You can disable it in Gilza mod options.",
			-- Fearmonger's in-game pop up notification
			Gilza_fearmonger_trigger_notification = "Fearmonger speed boost activated.",
			menu_overkill_beta_desc = "BASIC: ##$basic##\nWhen you kill an enemy with a Shotgun or the OVE9000 portable saw, you receive an Overkill™ boost that lasts for ##30## seconds. While boost is active you receive ##40%## damage and ##50%## reload speed increase with Shotguns and OVE9000 saw.\n\nACE: ##$pro##\nOverkill™ bonuses now apply to all weapons. Skill must be activated using a Shotgun or the OVE9000 portable saw. Your weapon swap speed is increased by ##80%##\n\nNote: Does not apply to melee damage, throwables, grenade launchers or rocket launchers.",
			-- E2
			menu_pack_mule_beta_desc = "BASIC: ##$basic##\nFor each ##10## armor points, the bag movement penalty is reduced by ##1%##.\n\nACE: ##$pro##\nYou can sprint with any bag.",
			-- E3
			menu_carbon_blade_beta_desc = "BASIC: ##$basic##\nReducing the wear down of the blades on enemies by ##50%##.\n\nACE: ##$pro##\nYou can now saw through shield enemies with your OVER9000 portable saw. When killing an enemy with the saw, you have a ##50%## chance to cause nearby enemies in a ##10## m radius to panic. Panic will make enemies go into short bursts of uncontrollable fear.\n\nYou can now gain ammunition for the saw from dropped ammo boxes. This pick up can not be affected by other skills.",
			menu_bandoliers_beta_desc = "BASIC: ##$basic##\nYour total ammo capacity is increased by ##25%##.\n\nACE: ##$pro##\nIncreases the amount of ammo you gain from ammo boxes by ##75%##. You also gain a base ##10%## chance to get a throwable from an ammo box. The base chance is increased by ##1.6% * x## (where x - throwable pick up multiplier) for each ammo box you pick up that does not contain a throwable. When a throwable has been found, the chance is reset to its base value.\n\nNotes:\nThis skill does not stack with the perk skill 'Walk-in Closet'.\n\nThrowable pick up multipliers are different for each throwable - you can find them under throwable descriptions.",
			
			-- Technician
			-- T3
			menu_steady_grip_beta_desc = "BASIC: ##$basic##\nYou gain ##4## weapon Stability.\n\nACE: ##$pro##\nYou gain ##8## more weapon Stability.",
			menu_heavy_impact_beta_desc = "BASIC: ##$basic##\nYour shots can now stagger all enemies except Bulldozers and Captain Winters. Your base stagger chance is ##2-4%##, which is then multiplied by the ##threat modifier##.\n\nACE: ##$pro##\nIncreases your base stagger chance to ##10-20%##.\n\nNote: Base stagger chance is scaled with damage. With ##100## or less damage, lower base chance value is used. This chance is gradually increased with higher weapon damage, up to it's max chance value at ##400## or more damage.\nThreat modifier scales with weapon's threat: having ##0## threat provides you a ##1x## multiplier, with up to ##2x## multiplier at ##40## or higher threat.",
			menu_fire_control_beta_desc = "BASIC: ##$basic##\nYour ##40%## recoil penalty while firing from the hip is removed.\n\nACE: ##$pro##\nYour ##25%## accuracy penalty while firing from the hip is removed.",
			menu_fast_fire_beta_desc = "BASIC: ##$basic##\nYour SMGs, LMGs and Assault Rifles gain ##15## more bullets in their magazines. This does not affect the 'Lock n' Load' Ace skill.\n\nACE: ##$pro##\nYour ranged weapons can now pierce enemy body armor, but any damage that goes through armor gets cut by ##50%##.",
			menu_body_expertise_beta_desc = "BASIC: ##$basic##\n##50%## from the bonus headshot damage is permanently applied to hitting enemies on the body. This skill is only activated by SMGs, LMGs, Assault Rifles or Special Weapons fired in automatic mode.\n\nYour ammo pick up is reduced by ##20%##.\n\nYour ranged weapons can now pierce enemy body armor, but any damage that goes through armor gets cut by ##50%##.\nCan be combined with 'Surefire' Aced, to completely negate damage penalties when shooting through body armor.\n\nACE: ##$pro##\nHitting enemies on the body now grants ##100%## of the bonus damage from headshots.\n\nAmmo pick up reduction from this skill is now ##35%##.",
			
			-- GHOST
			-- G1
			menu_jail_workout_beta = "Inside man",
			menu_jail_workout_beta_desc = "BASIC: ##$basic##\nYou can pick up items while in casing mode. You also gain ##30%## more value to items and cash that you pick up.\n\nACE: ##$pro##\nYou gain access to additional insider assets.",
			menu_asset_lock_additional_assets = "Requires the 'inside man' aced skill to unlock",
			menu_cleaner_beta_desc = "BASIC: ##$basic##\nYou gain ##1## additional body bag in your inventory. Also increases the body bag inventory space to ##3##.\nCleaning costs after killing a civilian is reduced by ##75%##.\n\nACE: ##$pro##\nYou gain the ability to place ##2## body bag cases.\nYou gain access to the body bag asset.",
			menu_asset_lock_buy_bodybags_asset = "Requires the 'cleaner' aced skill to unlock",
			menu_chameleon_beta = "Awareness",
			menu_chameleon_beta_desc = "BASIC: ##$basic##\nIncreases the time before you start getting detected by ##25%## while in casing mode. You can also mark enemies while in casing mode.\nYou gain access to the spotter and spycam assets.\n\nACE: ##$pro##\nYou gain the ability to automatically mark enemies within a ##10## meter radius around you after standing still for ##3.5## seconds while in stealth.",
			menu_asset_lock_buy_spotter_asset = "Requires the 'awareness' basic skill to unlock",
			-- G2
			menu_awareness_beta_desc = "BASIC: ##$basic##\nYou gain ##20%## increased speed when climbing ladders.\n\nYou gain ##20%## extra vertical and horizontal jump power.\n\nACE: ##$pro##\nYou gain the ability to sprint in any direction.\n\nRun and reload - you can reload your weapons while sprinting.",
			menu_dire_need_beta = "Sneaky Bastard",
			menu_dire_need_beta_desc = "BASIC: ##$basic##\nYou gain a ##1%## dodge chance for every ##3## points of detection rate under ##35## up to ##10%##.\n\nACE: ##$pro##\nYou gain a ##1%## dodge chance for every ##1## point of detection rate under ##35## up to ##10%##.",
			menu_insulation_beta = "Backfire",
			menu_insulation_beta_desc = "BASIC: ##$basic##\nWhen your armor breaks, the first shot on every enemy will cause that enemy to stagger. This effect persists for ##3## seconds after your armor has recovered.\n\nACE: ##$pro##\nWhen tased, you are able to instantly free yourself from the taser by interacting with it within ##2## seconds of getting tased. After the ##2## seconds window expires, shock effect will be backfired onto taser automatically.\n\nIf you get tased by any means your bullets will become electrified for ##20## seconds allowing you to shock enemies, except for Bulldozers and Captain Winters, from any distance.",
			menu_jail_diet_beta = "Revitalized",
			menu_jail_diet_beta_desc = "BASIC: ##$basic##\nSuccessfully dodging while you have no armor remaining restores ##10## points of armor. This cannot occur more often then once every ##20## seconds.\n\nACE: ##$pro##\nArmor gain from this skill is increased to ##40## points.\nCooldown for this skill is reduced to ##14## seconds.",
			
			-- FUGITIVE
			-- F1
			menu_dance_instructor_desc = "BASIC: ##$basic##\nYou gain ##20%## increased rate of fire with pistols.\n\nACE: ##$pro##\nYou reload all pistols ##33%## faster.",
			menu_gun_fighter_beta = "Trigger happy",
			menu_gun_fighter_beta_desc = "BASIC: ##$basic##\nEach successful pistol hit gives you a ##10%## increased accuracy bonus for ##15## seconds and can stack ##3## times.\n\nACE: ##$pro##\nEach successful pistol hit gives you a ##80%## damage boost for ##1.5## seconds. Does not stack with itself.",
			menu_expert_handling = "Double trouble",
			menu_expert_handling_desc = "BASIC: ##$basic##\nYour akimbo pistols receive following bonuses:\n - ##16## more stability\n - ##12## more accuracy\n - ##35%## faster reload speed\n - ##2x## faster weapon swap speed\n\nACE: ##$pro##\nYour akimbo SMGs now receive same bonuses.",
			menu_trigger_happy_beta = "Bottomless pockets",
			menu_trigger_happy_beta_desc = "BASIC: ##$basic##\nYou gain ##40%## more reserve ammunition with all Pistols and SMGs.\n\nACE: ##$pro##\nYou gain ##100%## more reserve ammunition with all Pistols and SMGs.",
			-- F2
			menu_up_you_go_beta_desc = "BASIC: ##$basic##\nYou take ##30%## less damage for ##10## seconds after being revived.\n\nACE: ##$pro##\nYou receive additonal ##25%## of your maximum health when revived.",
			menu_perseverance_beta_desc = "BASIC: ##$basic##\nInstead of getting downed instantly, you gain the ability to keep on fighting for ##3## seconds with a ##60%## movement penalty before going down.\nDoes not trigger on fall of fire damage.\n\nYour Swan Song speed penalty will be ignored for ##3## seconds, if at the moment of skill activation or at any point during it's duration, one of your crew members is downed.\n\nACE: ##$pro##\nIncreases Swan Song's duration to ##9## seconds.\n\nWhile the effect is active, ammuntion will be depleted directly from your total ammo reserve, instead of your magazine, and any damage you deal is increased by ##50%##.",
			-- F3
			menu_martial_arts_beta = "Tough Guy",
			menu_martial_arts_beta_desc = "BASIC: ##$basic##\nYou are ##50%## more likely to knock down enemies with a melee strike.\nYour camera shake when hit by a melee attack is reduced by ##30%##.\n\nACE: ##$pro##\nYou take ##50%## less damage from all melee attacks.\nYour camera shake when hit by a melee attack is now reduced by ##90%##.\nBecause of training.",
			menu_bloodthirst_desc = "BASIC: ##$basic##\nEvery kill you get will increase your next melee attack damage by ##20%##, up to a maximum of ##300%##. This effect gets reset when you kill an enemy with a melee attack.\n\nACE: ##$pro##\nWhenever you kill an enemy with a melee attack, you will gain a ##50%## increase in reload speed for ##10## seconds.",
			menu_steroids_beta = "Martial Arts",
			menu_steroids_beta_desc = "BASIC: ##$basic##\nYou can now sprint while using melee weapons.\n\nACE: ##$pro##\nYou charge your melee weapons ##100%## faster.",
			menu_drop_soap_beta_desc = "BASIC: ##$basic##\nWhen charging your melee weapon you will counter-attack enemies that try to strike you, damaging and knocking them down.\n\nCounter-attack damage is identical to your melee weapon's damage and scales with charge time.\n\nSuccessfull counter-attacks instantly uneqiup your melee weapon.\n\nACE: ##$pro##\nYou gain the ability to counter-attack cloakers and their kicks.\nCounter-attacks will now deal ##doubled## damage.",
			menu_wolverine_beta_desc = "BASIC: ##$basic##\nYou deal ##50%## more melee damage.\n\nIf your armor breaks while your health is below ##50%## you gain ##50%## more melee damage for ##20## seconds.\n\nACE: ##$pro##\nIf your armor breaks while your health is below ##50%## you gain ##100%## more damage with ranged weapons for ##20## seconds, and your ##50%## melee damage increase now lasts for ##40## seconds.\n\nNote: Does not apply to throwables, grenade launchers or rocket launchers.\n\nGilza note: entering berserker state will enable visual screen flash. You can customize or completely disable it in Gilza's mod options.",
		})
		
		---- WEAPON MODS ----
		LocalizationManager:add_localized_strings({
			-- Initial stuff: new gadget descriptions + some missing base game strings
			bm_combined_gadget_module = "Combined module that includes both laser and flashlight.",
			bm_laser_gadget_module = "Laser module used for easier target acquisition while hip-firing.",
			bm_flashlight_gadget_module = "Flashlight for all the dark places you may find.",
			bm_menu_custom_plural = "Fire mode selectors",
			bm_wp_akm_b_standard_gold = "Standard AKM Gold Barrel",
			bm_wpn_fps_ass_g3_b_long_newname = "Standard Gewehr3 Long Barrel",
			bm_wp_coal_g_standard = "Standard Tatonka Grip",
			bm_wp_hcar_barrel_standard = "Standard Akron HC Barrel",
			
			-- Compatibility for other mods
			bm_wp_wpn_fps_offhandknif_Gilza_desc = "Increases melee damage and knockdown while using weapon butt. Also adds style points.\nStats:\n -Damage: 50\n -Knockdown: 400",
			-- Frenchy's missing strings on some parts - no translations required
			bm_wp_wpn_fps_upg_m_celerity = "\"Big Stick\" 30-round mag",
			bm_wp_wpn_fps_upg_m_308dmmag = "Lightweight 30-round mag",
			
			-- New weapon mods added by Gilza, no specific order
			menu_l_global_value_Gilza = "This is a Gilza Item!",
			bm_wpn_fps_upg_br_shtgn = "Breaching round",
			bm_wpn_fps_upg_br_shtgn_desc = "Fires a single round that allows you to breach everything that saw OVE9000 usually can. Also penetrates shield and body armor.\n\nDamage range decreased by 50%.",
			bm_wpn_fps_upg_ar_dmr_ap_rounds = "DMR AP rounds",
			bm_wpn_fps_upg_ar_dmr_ap_rounds_desc = "Pierce enemy body armor, shields and walls.\n\nAmmo pick up reduced by 50%.",
			bm_wpn_fps_upg_ap_kit_ap_rounds = "AP ammunition", -- hidden
			bm_wpn_fps_upg_smg_p90_ap_rounds = "P90 AP rounds",
			bm_wpn_fps_upg_smg_p90_ap_rounds_desc = "Pierce enemy shields and body armor.\nAmmo pick up reduced by 50%.",
			bm_wpn_fps_upg_pist_mateba_ap_rounds = "Mateba AP rounds",
			bm_wpn_fps_upg_pist_mateba_ap_rounds_desc = "Pierce enemy shields and body armor.\nAmmo pick up reduced by 50%.",
			bm_wpn_fps_upg_contraband_762_to_556_kit = "5.56 Conversion kit",
			bm_wpn_fps_upg_contraband_762_to_556_kit_desc = "Converts current weapon's receiver to support 5.56 caliber ammunition.\nAmmo pick up increased to match new damage class.",
			wpn_fps_upg_ak_hp_rounds = "7.62 HP rounds",
			wpn_fps_upg_ak_hp_rounds_desc = "Lead core hollow-point bullet with a bimetallic jacket in a steel case.\n\nAmmo pick up reduced to match new damage class.",
			wpn_fps_upg_m4_hp_rounds = "5.56 HP rounds",
			wpn_fps_upg_m4_hp_rounds_desc = "Lead core hollow-point bullet with a bimetallic jacket in a steel case.\n\nAmmo pick up reduced to match new damage class.",
			bm_wpn_fps_upg_groza_762_to_545_kit = "5.45 Conversion kit",
			bm_wpn_fps_upg_groza_762_to_545_kit_desc = "Converts current weapon's receiver to support 5.45 caliber ammunition.\nAmmo pick up increased to match new damage class.",
			wpn_fps_upg_fal_sp_rounds = "7.62x51mm SP rounds",
			wpn_fps_upg_fal_sp_rounds_desc = "Cartridge with a lead core soft-point (SP) bullet with a bimetallic semi-jacket in a steel case.\n\nAmmo pick up increased to match new damage class.",
			wpn_fps_upg_amcar_rrlp_rounds = "5.56x45mm MK 255 Mod 0 (RRLP)",
			wpn_fps_upg_amcar_rrlp_rounds_desc = "A 5.56x45mm NATO MK 255 Mod 0 (Reduced Ricochet Limited Penetration) cartridge with a 4 gram bullet with a copper/polymer composite core with a copper jacket, in a brass case.\n\nAmmo pick up increased to match new damage class.",
			bm_wpn_fps_upg_pis_mid_ap_rounds = "AP rounds",
			bm_wpn_fps_upg_pis_mid_ap_rounds_desc = "Pierce enemy shields and body armor.\nAmmo pick up reduced by 50%.\n",
			bm_wpn_fps_upg_pis_mid_ap_rounds_lv = "Low velocity AP rounds",
			bm_wpn_fps_upg_pis_mid_ap_rounds_lv_desc = "Pierce enemy shields and body armor.\nAmmo pick up reduced by 30%.\n",
			
			-- New custom GL mods
			bm_wp_upg_a_grenade_launcher_velocity = "High Velocity Round",
			bm_wp_upg_a_grenade_launcher_velocity_desc = "Fragmentation grenade with tripled projectile velocity. Reduces ammo pick up by 20%.\n\nNote: only works if you are the lobby host, otherwise acts like a normal grenade with normal ammo pick up.",
			bm_wp_upg_a_underbarrel_velocity_frag_desc = "Fragmentation round with tripled projectile velocity. Max damage: 1300. Reduces underbarrel ammo pick up by 20%.\n\nNote: only works if you are the lobby host, otherwise acts like a normal frag round with normal ammo pick up.",
			bm_menu_mag_limiter = "Mag Limiter",
			bm_menu_mag_limiter_plural = "Mag Limiters",
			bm_wp_wpn_fps_gre_ms3gl_ml_double_round = "2 round limit",
			bm_wp_wpn_fps_gre_ms3gl_ml_double_round_desc = "Limits weapon to double round bursts by limiting mag capacity to 2.",
			bm_wp_wpn_fps_gre_ms3gl_ml_single_round = "1 round limit",
			bm_wp_wpn_fps_gre_ms3gl_ml_single_round_desc = "Limits weapon to single fire by limiting mag capacity to 1.",
			
			-- Assault rifle mods
			bm_wpn_fps_upg_ass_m4_b_beowulf_newname = "M4 AP Kit",
			bm_wpn_fps_upg_ass_ak_b_zastava_newname = "AK AP Kit",
			bm_wp_famas_b_sniper_newname = "Famas AP Kit",
			wpn_fps_ass_shak12_body_vks_R = "ASh-12 AP Kit",
			bm_wpn_fps_shak12_upg_ap_kit_desc = "Allows you to penetrate shields, walls and enemy body armor.\nLimits your fire mode to single fire.\nAmmo pick up reduced by 50%.",
			bm_wpn_fps_ass_g3_b_sniper_newname = "G3 AP Kit",
			bm_wpn_fps_ass_g3_b_short_desc = "Close quaters assault kit.\nAmmo pick up increased by 60%.",
			bm_wpn_fps_upg_ar_ap_kit_desc = "Allows you to penetrate shields, walls and enemy body armor.\nAmmo pick up reduced by 50%.", -- used by all AR's that have AP kits instead of long barrels
			bm_m4_upg_fg_mk12_desc = "This set limits your fire mode to full auto.",
			
			-- Pistol mods
			bm_wpn_fps_pis_c96_b_long_newname = "C96 AP Kit",
			bm_wpn_fps_pis_c96_b_long_newdesc = "Allows you to penetrate shields, walls and enemy body armor.\nAmmo pick up reduced by 70%.",
			bm_wpn_fps_pis_type54_underbarrel_desc = "Underbarrel shotgun. Stats:\n -Damage: 660\n -Minimal shotgun damage multiplier: 1\n -Ammo pick up: 0.33-0.4, with Walk-in Closet perk skill.",
			bm_wpn_fps_pis_type54_underbarrel_slug_desc = "Underbarrel shotgun slug. Pierces shields, walls and enemy body armor. Increases damage range by 15%. Stats:\n -Damage: 660\n -Minimal shotgun damage multiplier: 1\n -Ammo pick up: 0.25-0.3, with Walk-in Closet perk skill.",
			bm_wpn_fps_pis_type54_underbarrel_ap_desc = "Underbarrel shotgun flechette. Pierces enemy body armor. Shoots 6 darts. Damage range increased by 40%. Stats:\n -Damage: 660\n -Minimal shotgun damage multiplier: 1\n -Ammo pick up: 0.29-0.36, with Walk-in Closet perk skill.",
			bm_wpn_fps_pis_x_type54_underbarrel_desc = "Underbarrel shotgun. Stats:\n -Damage: 330\n -Minimal shotgun damage multiplier: 1\n -Ammo pick up: 0.66-0.8, with Walk-in Closet perk skill.",
			bm_wpn_fps_pis_x_type54_underbarrel_slug_desc = "Underbarrel shotgun slug. Pierces shields, walls and enemy body armor. Increases damage range by 15%. Stats:\n -Damage: 330\n -Minimal shotgun damage multiplier: 1\n -Ammo pick up: 0.5-0.6, with Walk-in Closet perk skill.",
			bm_wpn_fps_pis_x_type54_underbarrel_ap_desc = "Underbarrel shotgun flechette. Pierces enemy body armor. Shoots 6 darts. Damage range increased by 40%. Stats:\n -Damage: 330\n -Minimal shotgun damage multiplier: 1\n -Ammo pick up: 0.58-0.72, with Walk-in Closet perk skill.",
			
			-- SMG mods
			bm_wpn_fps_smg_mp5_m_straight_R = "RIP rounds",
			bm_wpn_fps_smg_mp5_m_straight_R_desc = "Ammo pick up reduced to match new damage class.",
			
			-- LMG mods
			wpn_fps_lmg_hcar_barrel_dmr_PEN = "Akron HC AP Kit",
			bm_wpn_fps_lmg_hcar_barrel_dmr_PEN_desc = "Allows you to penetrate shiels, body armor and walls.\nLimits weapon to single-fire mode.\nAmmo pick up reduced by 50%.",
			bm_wpn_fps_upg_lmg_kacchainsaw_underbarrel_flamethrower_desc = "Underbarrel flamethrower. Deals 25 direct damage with 2000 rate of fire. Has 25% chance to apply afterburn.\nAfterburn deals 100 damage over 2 seconds.\n\nReduces ammo pick up for LMG itself by 30%.",
			bm_wpn_fps_upg_lmg_kacchainsaw_conversionkit_desc = "Increases ammo pick up by 15%",
			bm_wpn_fps_lmg_hcar_body_conversionkit_desc = "Increases ammo pick up to match new damage class.",
			
			-- Shotgun mods
			bm_wpn_fps_upg_a_rip_desc_new = "Poisoned bullet that causes enemies to vomit uncontrollably, preventing then from making any actions.\n\nDeals 250 poison damage over 6 seconds.\nAmmo pick up reduced by 20%",
			bm_wpn_fps_upg_a_custom_desc_new = "8 big pellets with triple the impact.\n\nDisables bonus damage from headshots.\nDamage range reduced by 20%.\nAmmo pick up reduced by 50%",
			bm_wpn_fps_upg_a_explosive_desc_new = "Fires one explosive charge that kills or stuns targets.\n\nDisables bonus damage from headshots.\nAmmo pick up reduced by 65%",
			bm_wpn_fps_upg_a_piercing_desc_new = "Peirces enemy body armor.\nDamage range increased by 40%.\n\nAmount of darts per shell - 6.\nAmmo pick up reduced by 10%",
			bm_wpn_fps_upg_a_slug_desc_new = "Fires a single lead slug that penetrates body armor, enemies, shields and walls.\n\nDamage range increased by 15%\nAmmo pick up reduced by 25%",
			bm_wpn_fps_upg_a_dragons_breath_desc_new = "Fires 8 pellets that go up in sparks and flames. Burns through shields and body armor.\n\nDeals 350 fire damage over 2.5 seconds.\nDamage range decreased by 20%.\nAmmo pick up reduced by 30%",
			wpn_fps_upg_ns_duck_desc = "Reduces vertical pellet spread to 50%, increases horizontal pellet spread to 225%",
			
			-- Flamethrower mods
			bm_wpn_fps_fla_mk2_mag_rare_desc = "Less direct firepower but more afterburn damage.\n50% chance to start afterburn damage that deals 720 damage over 3 seconds.\nBase flamethrower values: 20% chance for 300dmg over 2 seconds.",
			bm_wpn_fps_fla_mk2_mag_welldone_desc = "More direct firepower but less afterburn damage.\n10% chance to start afterburn damage that deals 150 damage over 1 second.\nBase flamethrower values: 20% chance for 300dmg over 2 seconds.",
			
			-- Launcher mods
			bm_wpn_fps_upg_a_grenade_launcher_poison_default_desc = "Upon impact deals damage in a 6m radius, then creates a 6m wide gas cloud for 15 seconds. Enemies that come in contact with said cloud will vomit uncontrollably for 16 seconds, preventing them from making any other actions. Enemies receive 3.5 damage per second while poisoned.\n\nAmmo pick up reduced by 70%.",
			bm_wpn_fps_upg_a_grenade_launcher_poison_ms3gl_desc = "Upon impact deals damage in a 3m radius, then creates a 6m wide gas cloud for 15 seconds. Enemies that come in contact with said cloud will vomit uncontrollably for 16 seconds, preventing them from making any other actions. Enemies receive 3.5 damage per second while poisoned.\n\nAmmo pick up reduced by 82%.",
			bm_wpn_fps_upg_a_grenade_launcher_poison_ms3gl_CK_desc = "Upon impact deals damage in a 3m radius, then creates a 8m wide gas cloud for 15 seconds. Enemies that come in contact with said cloud will vomit uncontrollably for 16 seconds, preventing them from making any other actions. Enemies receive 3.5 damage per second while poisoned.\n\nAmmo pick up reduced by 82%.",
			bm_wpn_fps_upg_a_grenade_launcher_poison_underbarrel_desc = "Upon impact deals 860 damage in a 6m radius, then creates a 6m wide gas cloud for 15 seconds. Enemies that come in contact with said cloud will vomit uncontrollably for 16 seconds, preventing them from making any other actions. Enemies receive 3.5 damage per second while poisoned.\n\nAmmo pick up for the underbarrel launcher reduced by 70%.",
			bm_wpn_fps_upg_a_grenade_launcher_poison_arbiter_desc = "Upon impact deals damage in a 3m radius, then creates a 4m wide gas cloud for 15 seconds. Enemies that come in contact with said cloud will vomit uncontrollably for 8 seconds, preventing them from making any other actions. Enemies receive 7 damage per second while poisoned.\n\nAmmo pick up reduced by 70%.",
			bm_wpn_fps_upg_a_grenade_launcher_incendiary_desc = "Upon impact creates a fire field for 6 seconds. Enemies that walk through it, receive afterburn.\n\nAfterburn stats:\n -Duration: 6 seconds\n -Damage per second: 250\nWhile enemy is standing inside the fire field, they receive triple damage per second.\n\nAmmo pick up reduced by 50%.",
			bm_wpn_fps_upg_a_grenade_launcher_incendiary_ms3gl_desc = "Upon impact creates a fire field for 6 seconds. Enemies that walk through it, receive afterburn.\n\nAfterburn stats:\n -Duration: 6 seconds\n -Damage per second: 250\nWhile enemy is standing inside the fire field, they receive triple damage per second.\n\nAmmo pick up reduced by 75%.",
			bm_wpn_fps_upg_a_grenade_launcher_incendiary_arbiter_desc = "Upon impact creates a fire field for 3 seconds. Enemies that walk through it, receive afterburn.\n\nAfterburn stats:\n -Duration: 3 seconds\n -Damage per second: 250\nWhile enemy is standing inside the fire field, they receive triple damage per second.\n\nAmmo pick up reduced by 50%.",
			bm_wpn_fps_upg_a_grenade_launcher_electric_desc = "Upon impact creates a wider 8m electrical explosion. Enemies caught in the blast radius get stunned due to high-voltage electricity for 3-5 seconds.\nDamage scales with range more aggressively, which leads to enemies on the edge of the explosion radius to receiving minimal damage.\n\nAmmo pick up increased by 10%.",
			bm_wpn_fps_upg_a_underbarrel_launcher_electric_desc = "Upon impact creates a wider 8m electrical explosion, with 800 max damage. Enemies caught in the blast radius get stunned due to high-voltage electricity for 3-5 seconds.\nDamage scales with range more aggressively, which leads to enemies on the edge of the explosion radius to receiving minimal damage.\n\nAmmo pick up for the underbarrel launcher increased by 10%.",
			bm_wpn_fps_upg_a_grenade_launcher_hornet_desc = "Fires 20 shotgun-like rounds upon detonation that can pierce shields. Minimal shotgun damage multiplier: 0.75.\n\nAmmo pick up increased by 250%.",
			bm_wpn_fps_upg_a_grenade_launcher_hornet_underbarrel_desc = "Fires 20 shotgun-like rounds upon detonation that can pierce shields. Max total damage: 550. Minimal shotgun damage multiplier: 0.75.\n\nAmmo pick up for the underbarrel launcher increased by 350%.",
			bm_wp_upg_a_grenade_launcher_frag_desc = "Default rounds. Causes fragments to disperse on detonation. Max damage: 1300.",
			
			-- Poison bow arrows
			bm_wpn_fps_upg_a_pistol_crossbow_poison_desc = "Arrow with a poisoned tip. Causes receiver to vomit uncontrollably for the full duration of the effect.\nDeals 50 damage per second and lasts for 6 seconds.",
			bm_wpn_fps_upg_a_light_crossbow_poison_desc = "Arrow with a poisoned tip. Causes receiver to vomit uncontrollably for the full duration of the effect.\nDeals 135 damage per second and lasts for 6 seconds.",
			bm_wpn_fps_upg_a_h3h3_poison_desc = "Arrow with a poisoned tip. Causes receiver to vomit uncontrollably for the full duration of the effect.\nDeals 90 damage per second and lasts for 6 seconds.",
			bm_wpn_fps_upg_a_crossbow_poison_desc_new = "Arrow with a poisoned tip. Causes receiver to vomit uncontrollably for the full duration of the effect.\nDeals 100 damage per second and lasts for 6 seconds.",
			
			-- Sniper mods
			bm_wp_mosin_ns_bayonet_desc = "Increases melee damage and knockdown while using weapon butt.\nMore specifically:\n -Damage: 50\n -Knockdown: 400",
			bm_wpn_fps_upg_snp_awp_conversionkit_new_desc = "Adjusts ammo pick up to match new damage class.",
		})
		
		---- THROWABLES ----
		LocalizationManager:add_localized_strings({
			bm_wpn_prj_ace_desc = "Damage: 40\nPick up multiplier: "..tostring(Gilza.grenade_multipliers.wpn_prj_ace).."\n",
			bm_grenade_frag_desc = "Damage: 1600\nRadius: 500\nPick up multiplier: "..tostring(Gilza.grenade_multipliers.frag).."\n",
			bm_wpn_prj_four_desc = "Damage: 100\nPick up multiplier: "..tostring(Gilza.grenade_multipliers.wpn_prj_four).."\n\nHit enemies become poisoned and begin to vomit uncontrollably, preventing them from making any other actions.\n\nPoison stats:\n -Duration: 5 seconds\n -Damage per second: 130",
			bm_wpn_prj_hur_desc = "Damage: 1100\nPick up multiplier: "..tostring(Gilza.grenade_multipliers.wpn_prj_hur).."\n",
			bm_wpn_prj_jav_desc = "Damage: 3250\nPick up multiplier: "..tostring(Gilza.grenade_multipliers.wpn_prj_jav).."\n",
			bm_wpn_prj_target_desc = "Damage: 1100\nPick up multiplier: "..tostring(Gilza.grenade_multipliers.wpn_prj_target).."\n",
			bm_concussion_desc = "Damage: 0\nRadius: 1500\nPick up multiplier: "..tostring(Gilza.grenade_multipliers.concussion).."\n",
			bm_dynamite_desc = "Damage: 1600\nRadius: 500\nPick up multiplier: "..tostring(Gilza.grenade_multipliers.dynamite).."\n",
			bm_grenade_frag_com_desc = "Damage: 1600\nRadius: 500\nPick up multiplier: "..tostring(Gilza.grenade_multipliers.frag_com).."\n",
			bm_grenade_sticky_grenade_desc = "Damage: 1200\nRadius: 500\nPick up multiplier: "..tostring(Gilza.grenade_multipliers.sticky_grenade).."\n",
			bm_grenade_xmas_snowball_desc = "Damage: 280\nRadius: 100\n",
			bm_grenade_fir_com_desc = "Damage: 30\nRadius: 500\nPick up multiplier: "..tostring(Gilza.grenade_multipliers.fir_com).."\n\nCreates an incendiary explosion. Enemies caught in the blast radius, receive afterburn.\n\nAfterburn stats:\n -Duration: 2 seconds\n Damgae per second: 420",
			bm_grenade_dada_com_desc = "Damage: 1600\nRadius: 500\nPick up multiplier: "..tostring(Gilza.grenade_multipliers.dada_com).."\n",
			bm_grenade_molotov_desc = "Damage: 30\nRadius: 350\nPick up multiplier: "..tostring(Gilza.grenade_multipliers.molotov).."\n\nCreates a fire field for 15 seconds. Enemies that walk through it, receive afterburn.\n\nAfterburn stats:\n -Duration: 10 seconds\n Damgae per second: 260\n\nIf you land a direct hit, afterburn damage per second is increased to 420 for hit target.",
			bm_grenade_electric_desc = "Damage: 600\nRadius: 1000\nPick up multiplier: "..tostring(Gilza.grenade_multipliers.wpn_gre_electric).."\n\nZap-zap.\nThis grenade has increased damage fall off, because of it, enemies caught in the blast radius, but not directly in the middle of it, will receive minuscular damage.\n",
			bm_grenade_poison_gas_grenade_desc = "Damage: 1000\nRadius: 200\nPick up multiplier: "..tostring(Gilza.grenade_multipliers.poison_gas_grenade).."\n\nCreates a gas cloud for 20 seconds. Enemies caught in the cloud become poisoned and begin to vomit uncontrollably, preventing them from making any other actions.\n\nPoison stats:\n -Duration: 15 seconds\n -Damage per second: 30",
		})
		
		---- MELEE ----
		LocalizationManager:add_localized_strings({
			bm_melee_cs_info = "Hold melee button to deal continuous damage.\n\nChainsaw effect stats:\nDelay before effect begins: 1s\nDamage: 80% health per second",
			bm_melee_ostry_info = "Hold melee button to deal continuous damage.\n\nChainsaw effect stats:\nDelay before effect begins: 0.7s\nDamage: 60% health per second",
		})
		
		---- MENU ----
		LocalizationManager:add_localized_strings({
			menu_Gilza_perk_reset_text = "WARNING!\n\nBy pressing 'Yes' you will reset your perk deck progression. Resetting perk deck progression will remove progression from all of your perk decks, BUT it will keep all the perk points you have accumulated so far. This option should be used to try new Gilza perk decks without earning required perk points needed for their unlock.\n\nAre you sure you want to proceed?",
			menu_Gilza_perk_reset_confirm = "Yes",
			menu_Gilza_perk_reset_deny = "No"
		})
		
	end
	AddEnglishLoc() -- always add eng loc to avoid errors for missing strings, this way all strings will default to eng if they did not get updated properly 
	
	local function AddRussianLoc()
		
		---- PERKS ----
		LocalizationManager:add_localized_strings({
			-- General
			menu_deckall_2 = "Быстрый и разъярённый",
			menu_deckall_2_desc = "Увеличивает скорость взаимодействия с медицинскими сумками на ##20%##",
			-- Fix for custom perk decks for 4th card missing reference values
			menu_deckall_4_desc_new = "Параметр скрытности увеличен на ##+1##.\n\nНошение брони влияет на скорость передвижения на ##15%## меньше.\n\nКоличество очков опыта при завершении дней и контрактов увеличено на ##45%##.",
			menu_deckall_6_desc = "Открывает сумку с броней, содержимое которой можно надеть во время ограбления.\n\nВраги оставляют на ##35%## больше патронов.\n\nВы также получаете базовый шанс ##0%## найти метательное оружие в оставленных врагами боеприпасах. Шанс увеличивается на ##0.8% * x## (где x - метательный множитель) за каждый подобранный боеприпас, в котором не было метательного оружия. Когда метательное оружие будет найдено в боеприпасах, шанс будет сброшен до базового значения.\n\nПометка: метательный множитель зависит от используемого вами метательного оружия, а его значение можно узнать в описании каждого метательного оружия.",
			menu_deckall_8 = "Улучшенная физическая подготовка",
			menu_deckall_8_desc = "Вы получаете дополнительную скорость передвижения в размере ##10%##.\n\nВы можете бросать сумки на ##50%## дальше.",
			
			-- Vanilla decks
			menu_deck4_9_desc = "Шанс увернуться увеличен на ##5%##.\nШанс увернуться когда вы пригнулись увеличен на ##5%##.\nВаша скорость передвижения увеличена на ##15%##.\nВаш запас выносливости увеличен на ##25%##.\n\nШанс пробить вражескую броню из любого оружия равен ##50%##.\nУменьшает время переключения между оружием на ##80%##.\n\nБонус завершения ряда: Вероятность получить предмет высокого качества после завершения контракта увеличина на ##10%##.",
			menu_deck5_1_desc = "Получение урона во время регенерации брони отныне будет ставить таймер регенерации брони на паузу вместо сброса таймера до максимального значения.\n\nПродолжительность паузы составляет ##40%## максимальной продолжительности регенерации брони, но она может быть сокращена если продолжительность регенерации брони вместе с паузой превосходит стандартную продолжительность регенерации.\n\nВремя восстановления брони уменьшено на ##5%##.\n\n",
			menu_sociopathinfil_1_desc = "Когда по вам ведут огонь трое или более врагов, вы получаете на ##12%## меньше урона.\n\nВаш второй и каждый последующий удар в ближнем бою с перерывом не более чем в ##4## секунды, нанесёт на ##75%## больше урона от базового урона оружия.\n",
			menu_deck10_1_desc = "Боеприпасы оставленные врагами, также содержат медицинские припасы которые могут восстановить вам от ##16## до ##24## здоровья.\n\nПерк срабатывает только один раз за ##3## секунды.\n\nЕсли текущее здоровье Шуллера меньше чем у другого игрока, эффект восстановления будет увеличен на ##40%##. Эффект не может складываться несколько раз.\n\nРадиус с которого вы можете поднимать патроны увеличен на ##50%##.",
			menu_deck12_9_desc = " Теперь все эффекты берсерка в этом наборе перков активируется не на ##25%## уровне здоровья, а на ##50%##.\n\nПри входе в режим берсерка вы получаете иммунитет к эффекту подавления и ваша броня больше не может быть пробита насквозь бронебойными выстрелами.\n\nБонус завершения ряда: Вероятность получить предмет высокого качества после завершения контракта увеличена на ##10%##.",
			menu_deck18_1_desc = "Разблокирует и позволяет взять с собой дымовую шашку. Если вы смените набор перков на другой, дымовая шашка будет недоступна для использования.\n\nПри использовании, дымовая шашка создаёт завесу, которая длится ##10## секунд. Пока вы и ваши напарники стоят в завесе, вы будете уворачиваться от ##50%## всех пуль. Любой враг, находящийся в дыму, будет менее точен при стрельбе на ##50%##.\n\nКак дым рассеется, вы не сможете использовать дымовую шашку в течение ##40## секунд. Тем не менее, убийство врагов сокращает время восстановления на ##1## секунду.",
			menu_deck20_1_desc = "Разблокирует и позволяет взять с собой «Парилку».\n\nЧтобы использовать парилку, достаточно посмотреть на союзника в ##24## метровом радиусе и нажать на кнопку метательного ##$BTN_ABILITY;##, чтобы пометить его.\n\nКаждый убитый вами или вашим выбранным союзником противник восстановит ##15## единиц здоровья для вас и ##7.5## единиц здоровья для помеченного союзника.\n\nКаждый убитый вами противник продолжит время действия парилки на ##1.7## секунд и снизит время восстановления самой парилки на ##2## секунды.\n\nЭффект парилки длится ##12## секунд и имеет время восстановления в ##60## секунд.",
			menu_deck20_5_desc = "Убитый вами или выбранным вами напарником противник гарантирует вам ##4## единицы поглощения урона из максимальных ##32##.\nДанный эффект длится до тех пор, пока восстанавливается «Парилка».",
			menu_deck21_1_desc = "Разблокирует и позволяет взять с собой карманный генератор помех.\n\nЕсли вы смените набор перков на другой, карманный генератор помех будет недоступен для использования. Карманный генератор помех использует слот для метательного оружия, но выможете взять вместо него что-нибудь другое.\nЧтобы воспользоваться карманным генератором помех, достаточно нажать на кнопку для метательного оружия ##$BTN_ABILITY;##.\n\nЕсли генератор помех был использован до поднятия тревоги, то он отключит все пейджеры и электронику на ##6## секунд. \n\nИспользование генератора помех после поднятия тревоги будет генерировать поле, которое имеет шанс оглушить противников на ##12## секунд.\n\nКарманный генератор помех имеет ##2## заряда с ##140## секундным временем восстановления, но каждое убийтво уменьшает время восставновления на ##4## секунды.",
			menu_deck21_5_desc = "При убийстве противников во время действия Звуковой петли будет возвращаться ##40## единиц здоровья.\nШанс увернуться увеличен на ##15%##.",
			menu_deck21_7_desc = "При убийстве как минимум ##3## противников во время Звуковой петли вам дается ##20## единиц уклонения на ##50## секунд.",
			-- Short descs for vanilla decks
			menu_deck4_9_desc_short = "Шанс увернуться увеличен на ##5%##. Шанс увернуться когда вы пригнулись увеличен на ##5%##. Ваша скорость передвижения увеличена на ##15%##. Ваш запас выносливости увеличен на ##25%##. Шанс пробить вражескую броню из любого оружия равен ##50%##. Уменьшает время переключения между оружием на ##80%##.",
			menu_deck5_1_desc_short = "Получение урона во время регенерации брони отныне будет ставить таймер регенерации брони на паузу вместо сброса таймера до максимального значения. Время восстановления брони уменьшено на ##5%##.",
			menu_deck10_1_desc_short = "Боеприпасы оставленные врагами, восстанавливают ваше здоровье. Радиус с которого вы можете поднимать патроны увеличен на ##50%##.",
			menu_deck12_9_desc_short = " Теперь все эффекты берсерка в этом наборе перков активируется не на ##25%## уровне здоровья, а на ##50%##. При входе в режим берсерка вы получаете иммунитет к эффекту подавления и ваша броня больше не может быть пробита насквозь бронебойными выстрелами.",
			menu_deck18_1_desc_short = "Разблокирует и позволяет взять с собой дымовую шашку. При использовании, дымовая шашка создаёт завесу, которая длится ##10## секунд. Вы и ваши напарники стоя в завесе,  уворачиваетесь от ##50%## всех пуль. Любой враг, находящийся в дыму, будет менее точен при стрельбе на ##50%##. Как дым рассеется, вы не сможете использовать дымовую шашку в течение ##40## секунд. Тем не менее, убийство врагов сокращает время восстановления на ##1## секунду.",
			menu_deck20_1_desc_short = "Разблокирует и позволяет взять с собой «Парилку». Чтобы использовать парилку, достаточно посмотреть на союзника в ##24## метровом радиусе и нажать на кнопку метательного ##$BTN_ABILITY;##, чтобы пометить его. Каждый убитый вами или вашим выбранным союзником противник восстановит ##15## единиц здоровья для вас и ##7.5## единиц здоровья для помеченного союзника. Каждый убитый вами противник продолжит время действия парилки на ##1.7## секунд и снизит время восстановления самой парилки на ##2## секунды. Эффект парилки длится ##12## секунд и имеет время восстановления в ##60## секунд.",
			menu_deck20_5_desc_short = "Убитый вами или выбранным вами напарником противник гарантирует вам ##4## единицы поглощения урона из максимальных ##32##. Данный эффект длится до тех пор, пока восстанавливается «Парилка».",
			menu_deck21_1_desc_short = "Разблокирует и позволяет взять с собой карманный генератор помех.",
			menu_deck21_5_desc_short = "При убийстве противников во время действия Звуковой петли будет возвращаться ##40## единиц здоровья. Шанс увернуться увеличен на ##15%##.",
			menu_deck21_7_desc_short = "При убийстве как минимум ##3## противников во время Звуковой петли вам дается ##20## единиц уклонения на ##50## секунд.",
			
			---- Custom decks:
			-- Brawler
			menu_deck_brawler = "Дебошир",
			menu_deck_brawler_desc = "Гейдж подкинул Бейну наводку о поставке экспериментальных облегченных силовых бронекостюмов, которые Murkywater перевозили на один из своих складов. Как бы вы себя называли если б упустили такую возможность? Конечно же вы их все спиздили! Но после тщательного осмотра в своем убежище вы обнаружили, что они крайне громоздкие, но все равно каким-то образом удобны для беготни.\n\nВот так вы и преобразились в... ДЕБОШИРА!",
			menu_deck_brawler1 = "Улучшение бронекостюмов",
			menu_deck_brawler1_desc = "Использование этой высококачественной силовой брони с каким-либо нагрудным снаряжением практически невозможно из-за ее формы и размера. Но кому оно нахуй нужно?\n\nВаш запас и подбираемое количество боеприпасов уменьшены на ##80%##.\n\nВремя восстановления брони замедлено на ##300%##.\n\nВаша броня получает сопротивление к пулевому урону в размере ##10%##.",
			menu_deck_brawler3 = "Мясной щит",
			menu_deck_brawler3_desc = "Повышает вероятность того, что по вам начнут стрелять, когда вы будете рядом с напарниками на ##15%##.\n\nВаша броня получает дополнительное сопротивление к пулевому урону в размере ##10%##.\n\nШтраф к скорости передвижения в броне уменьшен на ##20%##",
			menu_deck_brawler5 = "Отражающие бронепластины",
			menu_deck_brawler5_desc = "Вашу броню теперь невозможно пробить насквозь бронебойными выстрелами.\n\nВаша броня получает дополнительное сопротивление к пулевому урону в размере ##10%##.\n\nШтраф к скорости передвижения в броне уменьшен на еще ##20%##.\n\nУбийство противника в рукопашном бою восстанавливает ##10%## вашей выносливости.",
			menu_deck_brawler7 = "Внушая страх",
			menu_deck_brawler7_desc = "Когда ваше здоровье ниже ##50%##, вы получаете следующие бонусы:\n- Каждый враг находящийся в пределах ##18## метров от вас наносит на ##7%## меньше пулевого урона по вашей броне\n- Каждый враг находящийся в пределах ##10## метров от вас наносит на ##16%## меньше пулевого урона по вашей броне\n- Каждый враг находящийся в пределах ##5## метров от вас наносит на ##27%## меньше пулевого урона по вашей броне\n\nСопротивления к пулевому урону от данной карточки перка ##удваивается## при игре на сложности Смертный Приговор.",
			menu_deck_brawler9 = "Страстность крови",
			menu_deck_brawler9_desc = "Убийство противника в ближнем бою начинает восполнять ##100## единиц вашей брони в течении ##6## секунд, с \"тиком\" регенерации раз в ##0.75## секунд.\nВы можете иметь вплоть до ##3## эффектов регенрации от данной карточки перка одновременно.\n\nБонус завершения ряда: Вероятность получить предмет высокого качества после завершения контракта увеличина на ##10%##.",
			-- Short descs for Brawler
			menu_deck_brawler1_desc_short = "Боезапас уменьшен на ##80%##. Броня регенится на ##300%## медленнее. Броня получает на ##10%## меньше урона от пуль.",
			menu_deck_brawler3_desc_short = "Вероятность что по вам начнут стрелять увеличена на ##15%##. Броня получает на еще ##10%## меньше урона от пуль. Штраф к скорости передвижения в броне уменьшен на ##20%##",
			menu_deck_brawler5_desc_short = "Броню теперь невозможно пробить насквозь. Броня получает на еще ##10%## меньше урона от пуль. Штраф к скорости передвижения в броне уменьшен на еще ##20%##. Убийство в ближнем бою дает ##10%## выносливости.",
			menu_deck_brawler7_desc_short = "Когда ваше здоровье ниже ##50%##, враги наносят меньше урона по броне. Чем они ближе, тем меньше урона наносят.",
			menu_deck_brawler9_desc_short = "Убийства в ближнем бою начинают восполнять ##100## единиц брони в течении ##6## секунд. Вы можете иметь вплоть до ##3## эффектов регенрации одновременно.",
			
			-- Speed Junkie
			menu_deck_SJ = "Под Спидами",
			menu_deck_SJ_desc = "ты тут? или ты уже давно пропал? КОМУ НЕ ПОХУЙ, МЫ ЗДЕСЬ ЧТОБЫ ВЕСЕЛИТЬСЯ!!! КАКУЮ ТАБЛЕТОЧКУ ВОЗЬМЕМ СЕГОДНЯ? РОЗОВЕНЬКУЮ? А МОЖЕТ ЛУЧШЕ СИНИЮ? ПОХУЙ, БЕРИ ИХ ВСЕ! ...\nдни? недели? месяцы? когда в последний раз ты видел СТКОЛЬКО ЛЮДЕЙ В ОНДОМ МЕСТЕ? ВСЕ БЕЗДУМНЫ И РАДЫ ТЕБЕ! НУ ЖЕ, ПРЫГАЙ К НАМ! ...\nради чего мне это все? может мне просто прогуляться и освежить свою голОВУ МОЮ ЗАБИЛА ХУЙНЯ! МНЕ НУЖНО УЙТИ, УМЧАТЬСЯ! МНЕ НУЖНО ПРЫГАТЬ, НЕТ, ЛЕТАТЬ! МНЕ НУЖНО ЧУВСТВОВАТЬ ХОТЬ ЧТО-ТО! СКОРОСТЬ МНЕ ПОМОЖЕТ, ДА! СКОРОСТЬ ЭТО МОЯ ЖИЗНЬ! скорость это моя смерть.",
			menu_deck_SJ_1 = "сильное абстрагирование",
			menu_deck_SJ_1_desc = "видимо единственный твой способ держать свою психику под контролем это быстро, быстро убегать. вперед.\n\n        Вы можете иметь вплоть до ##100## стаков адреналина. Движение на высоких скоростях будет добавлять адреналин - чем быстрее вы двигаетесь, тем больше стаков вы получаете. Если вы двигаетесь недостаточно быстро ваш адреналин будет уменьшаться.\n        Если вы будете поддерживать ##90## и более адреналина дольше чем ##4## секунды вы обессилете. Обессилее полностью исчерпывает вашу выносливость и некоторую часть ваших стаков адреналина.\n        Стаки адреналина отображены на вашем интерфейсе. Когда у вас ##90## и выше стаков, данный элемент интерфейса будет подсвечиваться красным цветом, а во время обессилия фиолетовым цветом.\n        За каждый стак адреналина вы получаете шанс увернуться, вплоть до максимального шанса в ##40%## при ##100## стаках.\n        Ваша броня теперь может восстанавливаться только когда вы полностью неподвижны.\n        Вы преобразуете ##90%## вашего здоровья в ##42%## брони.",
			menu_deck_SJ_3 = "МНЕ НУЖНО ДВИГАТЬСЯ! ",
			menu_deck_SJ_3_desc = "Шанс увернуться увеличен на ##15%##.\n\nВы восстанавливаете ##5%## вашей выносливости за каждое убийство.\n\nВы преобразуете ##90%## вашего здоровья в ##46%## брони.",
			menu_deck_SJ_5 = "ПРОЧЬ С ДОРОГИ! ",
			menu_deck_SJ_5_desc = "Убийсто врага добавит вам ##3## стака адреналина. При убийстве в тело вы получите ##9## стаков адреналина.\nЕсли вы убиваете врага когда количество стаков адреналина превышает ##90##, убийства будут убавлять количество стаков в таком же количестве.\n\nДополнительный эффект: вспышка адреналина.\nКогда количество стаков адреналина выше ##70## вы будуте получать ##1## очко вспышки адреналина в секунду. При накоплении ##20## очков вспышки адреналина вы получаете возможность ее активировать. Дабы активировать вспышку адреналина вам необходимо убить врага, что с ##10%## шансом активирует вспышку. При активации вспышки, ваши стаки адреналина получают передоз. После окончания вспышки адреналина, вы обессилете, а количество очко вспышки опустится до ##0##.\n\nВы преобразуете ##90%## вашего здоровья в ##52%## брони.",
			menu_deck_SJ_7 = "кто-нибудь.. ОСТАНОВИТЕ МЕНЯ! ",
			menu_deck_SJ_7_desc = "При удачном увороте от урона вы получите ##6## единиц брони, однако если ваша броня полностью сломана, вы получите ##24## единицы брони. Данный эффект не может срабатывать чаще чем раз в ##1.5## секунды.",
			menu_deck_SJ_9 = "Передоз.",
			menu_deck_SJ_9_desc = "Ваша скорость передвижения может увеличиться вплоть до ##25%## если ваша броня повреждена - чем меньше процент оставшейся у вас брони, тем выше данный бонус скорости.\n\nАдреналин теперь предоставляет вам дополнительные бонусы которые напрямую зависят от количества стаков. Вы можете получить:\n- Вплоть до ##40%## ускоренную перезарядку оружия\n- Вплоть до ##100%## ускоренную смену оружия\n- Вплоть до ##40%## ускоренного время взаимодействия с любыми объектами, кроме ответа на пейджеры и поднятия союзников.\n\nБонус завершения ряда: Вероятность получить предмет высокого качества после завершения контракта увеличина на ##10%##.",
			-- Short descs for junkie
			menu_deck_SJ_1_desc_short = "Открывает стаки адреналина, добавляющие вплоть до ##40%## шанса увернуться. Восстановление брони теперь недоступно в движении. Преобразует здоровье в броню.",
			menu_deck_SJ_3_desc_short = "Добавляет ##15%## шанс увернуться. Убийства восполняют выносливость. Преобразует здоровье в больше брони.",
			menu_deck_SJ_5_desc_short = "Убийсива предоставляют ##2-6## стаков адреналина. Преобразует здоровье в больше брони.",
			menu_deck_SJ_7_desc_short = "Уклонение предоставляет ##6-24## единиц брони.",
			menu_deck_SJ_9_desc_short = "Вы двигаетесь вплоть до ##25%## быстрее, в зависимости от повреженности брони. Стаки адреналина теперь ускоряют скорость взаимодействия, перезарядки и смены оружия.",
		})
		
		---- SKILLS ----
		LocalizationManager:add_localized_strings({
			-- Mastermind
			-- M1
			menu_inspire_beta_desc = "БАЗОВЫЙ: ##$basic##\nВы поднимаете напарников быстрее на ##100%##. Если вы крикните на вашего напарника, вы и ваш напарник получите моральный буст на ##10## секунд. Данный буст увеличивает скорость передвижения и перезарядки на ##20%## для вашего напарника и на ##10%## для вас.\n\nПРО: ##$pro##\nВы можете поднять напарника с вероятностью ##100%##, крича на него в ##9## метровом радиусе. Навык срабатывает раз в ##20## секунд.",
			-- M3
			menu_stable_shot_beta_desc = "БАЗОВЫЙ: ##$basic;##\nВаше оружие точнее на ##4## единицы.\n\nПРО: ##$pro;##\nВаше оружие точнее на еще ##8## единиц.",
			menu_rifleman_beta = "СТРЕЛОК В ОТСТАВКЕ",
			menu_rifleman_beta_desc = "БАЗОВЫЙ: ##$basic;##\nВы прицеливаетесь на ##100%## быстрее с любым оружием.\nПриближение (зум) прицела у всего оружия увеличен на ##25%##.\n\nПРО: ##$pro;##\nВо время прицеливания вы двигаетесь без штрафа к скорости передвижения.\n\nКогда вы начиаете стрелять из своего оружия, первые ##5## пуль имеют на ##35%## меньше отдачи. Не распространяется на Дробовики, Снайперские винтовки и Пистолеты стреляющие в одиночном режиме стрельбы.",
			menu_sharpshooter_beta = "Медленно но верно",
			menu_sharpshooter_beta_desc = "БАЗОВЫЙ: ##$basic##\nВы получаете ##7.5%## сопротивления урону если вы не двигаетесь или если важе оружие стоит на сошках.\n\nПРО: ##$pro##\nВы получаете дополнительные ##35%## сопротивления урону если ваше оружие стоит на сошках.\nВаша скорость установки сошек увеличина на ##100%##.",
			menu_speedy_reload_beta_desc = "БАЗОВЫЙ: ##$basic;##\nПовышает скорость перезарядки штурмовых винтовок, пистолетов-пулемётов и снайперских винтовок на ##20%##.\n\nПРО: ##$pro;##\nУбийство в голову увеличивает вашу скорость перезарядки на ##100%## в течение ##4## секунд. Навык срабатывает только для штурмовых винтовок, пистолетов-пулемётов и снайперских винтовок в одиночном режиме стрельбы. ",
			menu_sniper_graze_damage_desc = "БАЗОВЫЙ: ##$basic;##\nЕсли выстрел из снайперской винтовки попал по противнику находившемуся дальше чем ##7.5м## от стрелка, то этот выстрел нанесёт ##33%## от урона винтовки противникам в ##75см## радиусе полёта пули.\n\nУрон в радиусе полета пули не увеличивается, если выстрел приземлится в голову первоначальной цели, но может быть увеличен с помощью других навыков.\n\nПРО: ##$pro;##\nРадиус урона увеличен до ##150см## а урон увеличен до ##66%## от урона оружия.",
			
			-- Enforcer
			-- E1
			menu_shotgun_cqb_beta_desc = "БАЗОВЫЙ: ##$basic##\nПовышает скорость перезарядки дробовиков на ##15%##.\n\nПРО: ##$pro##\nПовышает бонус к скорости перезарядки до ##35%##.",
			menu_shotgun_impact_beta = "Эксперт по дробовикам",
			menu_shotgun_impact_beta_desc = "БАЗОВЫЙ: ##$basic;##\nПовышает скорость прецеливания с дробовиками до ##125%##\nПовышает стабильность при стрельбе из дробовиков на ##20%##.\n\nПРО: ##$pro;##\nПовышает стабильность при стрельбе из дробовиков до ##50%##.\n\nПометка: увеличение стабильности с помощью данного навыка может предоставить показатель стабильности выше ##100##.",
			menu_far_away_beta = "БЕЗДУМНЫЙ РАЗНОС",
			menu_far_away_beta_desc = "БАЗОВЫЙ: ##$basic##\nПри каждом выстреле из Дробовика вы имеете ##7.5%## шанс выстрелить не потратив боезапас.\n\nПРО: ##$pro##\nВаши шансы выстрела без траты боезапаса увеличины до ##20%##.",
			menu_close_by_beta = "РАЗЖИГАТЕЛЬ СТРАХА",
			menu_close_by_beta_desc = "БАЗОВЫЙ: ##$basic;##\nСтрельба на бегу: вы можете стрелять из дробовиков от бедра во время бега.\n\nПРО: ##$pro;##\nУбив противника Дробовиком, с подавлением ##35## и выше, у вас есть ##75%## шанс посеять панику в ##12## метровом радиусе от вас. Паника будет подавлять противника, периодически заставляя его испытывать приступы неконтролируемого страха.\n\nУбийство противника испытывающего приступ страха, полностью восстанавливает вашу выносливость и дает ##25%## бонус к скорости передвижения на ##20## секунд.\n\nПометка: при активации данный навык показывает оповещение на экране. Вы можете отключить его в настройках Гильзы.",
			-- Fearmonger's in-game pop up notification
			Gilza_fearmonger_trigger_notification = "Бонус скорости разжигателя страха активирован.",
			menu_overkill_beta_desc = "БАЗОВЫЙ: ##$basic;##\nПосле убийства врага с помощью дробовика или пилы OVE9000, вы получаете Overkill™ буст который длится ##30## секунд. Пока буст активен ваши Дробовики и пила OVE9000 наносят на ##40%## больше урона и перезаряжаются на ##50%## быстрее.\n\nПРО: ##$pro;##\nБонус к урону теперь применяется ко всему оружию. Навык должен быть активирован с помощью дробовика или пилы OVE9000. Уменьшает время переключения между оружием на ##80%##\n\nВнимание: действие навыка не распространяется на оружие ближнего боя, метательное и гранатометы.",
			-- E2
			menu_pack_mule_beta_desc = "БАЗОВЫЙ: ##$basic;##\nЗа каждые ##10## единиц брони штраф к скорости переноса добычи уменьшен на ##1%##.\n\nПРО: ##$pro;##\nВы теперь можете бегать с любой сумкой.",
			-- E3
			menu_carbon_blade_beta_desc = "БАЗОВЫЙ: ##$basic;##\nАтака врагов портативной пилой OVE9000 изнашивает лезвия на ##50%## меньше.\n\nПРО: ##$pro;##\nТеперь вы можете прорезать щитовиков своей пилой OVE9000. Убив противника пилой, у вас есть ##50%## шанс посеять панику в ##10## метровом радиусе. Паника будет подавлять противника, заставляя его испытывать страх.\n\nВраги теперь оставляют боезапас к пиле. Подбор боезапаса пилы не может быть увеличен используюя дополнительные навыки на подбор боезапаса.",
			menu_bandoliers_beta_desc = "БАЗОВЫЙ: ##$basic;##\nПовышает количество переносимых боеприпасов на ##25%##.\n\nПРО: ##$pro;##\nВраги оставляют на ##75%## больше боеприпасов. У вас есть ##10%## шанс найти метательное оружие в оставленных врагами боеприпасах. Шанс увеличивается на ##1.6% * x## (где x - метательный множитель) за каждый подобранный боеприпас, в котором не было метательного оружия. Когда метательное оружие будет найдено в боеприпасах, шанс будет сброшен к стандартному значению.\n\nПометки: навык не складывается с бонусом 'Тяжёлый пехотинец' из набора перков.\n\nМетательный множитель зависит от используемого вами метательного оружия, а его значение можно узнать в описании каждого метательного оружия.",
			
			-- Technician
			-- T3
			menu_steady_grip_beta_desc = "БАЗОВЫЙ: ##$basic;##\nВаше оружие стабильнее на ##4## единицы.\n\nПРО: ##$pro;##\nВаше оружие стабильнее на еще ##8## единиц.",
			menu_heavy_impact_beta_desc = "БАЗОВЫЙ: ##$basic##\nВаши выстрелы теперь могут оглушать всех противников за исключением бульдозера и Капитана Уинтерса сбивая их с ног. Ваш базовый шанс оглушения ##2-4%##, который затем множится на ##модификатор подавления##.\n\nПРО: ##$pro##\nУвеличивает базовый шанс оглушения до ##10-20%##.\n\nНа заметку: базовый шанс оглушения напрямую зависит от урона оружия. С уроном меньшим или равным ##100## используется меньший шанс, который постепенно увеличивается с уроном оружия, вплоть до максимального значения шанса когда урон выше или равен ##400##.\nМодификатор подавления напрямую зависит от подавления оружия: при показателе подавления ##0## ваш шанс умножается на ##1x##, увеличиавясь вплоть до ##2x## когда подавление выше или равно ##40##.",
			menu_fire_control_beta_desc = "БАЗОВЫЙ: ##$basic;##\nВаш ##40%## штраф к отдаче во время стрельбы от бедра аннулируется.\n\nПРО: ##$pro;##\nВаш ##25%## штраф к точности во время стрельбы от бедра аннулируется.",
			menu_fast_fire_beta_desc = "БАЗОВЫЙ: ##$basic##\nВаши пистолеты-пулеметы, пулеметы и штурмовые винтовки получают прибавку в виде ##15## патронов в магазинах. Данный навык не работает с ПРО версией навыка 'Оружие к бою'.\n\nПРО: ##$pro##\nВаше оружие получает возможность пробивать вражескую нательную броню, но урон при таком попадании уменьшается на ##50%##.",
			menu_body_expertise_beta_desc = "БАЗОВЫЙ: ##$basic;##\nМножитель попадания в голову применяется к телу противника с эффективностью в ##50%##. Этот навык работает только с пистолетами-пулемётами, пулемётами и штурмовыми винтовками в режиме автоматической стрельбы.\n\nВраги оставляют на ##20%## меньше боеприпасов.\n\nВаше оружие получает возможность пробивать вражескую нательную броню, но урон при таком попадании уменьшается на ##50%##.\nПри совмещении с ПРО версией навыка 'Шквальный огонь' штраф к урону при стрельбе по нательной броне аннулируется.\n\nПРО: ##$pro;##\nБонусный урон при попадании в тело увеличен до ##100%##.\n\nВраги теперь оставляют на ##35%## меньше боеприпасов.",
			
			-- GHOST
			-- G1
			menu_jail_workout_beta = "Свой человек",
			menu_jail_workout_beta_desc = "БАЗОВЫЙ: ##$basic##\nВы можете подбирать предметы в режиме исследования. Мелкие ценные предметы, украденные вами, стоят на ##30%## дороже.\n\nПРО: ##$pro##\nТеперь вы можете приобрести услуги 'своего человека'.",
			menu_asset_lock_additional_assets = "Необходима ПРО версия навыка 'Свой Человек'",
			menu_cleaner_beta_desc = "БАЗОВЫЙ: ##$basic##\nВы можете носить с собой ##1## дополнительный мешок для трупов. Теперь у вас будет ##3## мешка для трупов.\nПомимо этого, денежный штраф за убийство гражданских уменьшен на ##75%##.\n\nПРО: ##$pro##\nВы можете устанавливать ##2## кейса с мешками для трупов.\nТеперь вы можете приобрести услугу 'кейс с мешками для трупов.'",
			menu_asset_lock_buy_bodybags_asset = "Необходима ПРО версия навыка 'Чистильщик'",
			menu_chameleon_beta = "Осведомленность",
			menu_chameleon_beta_desc = "БАЗОВЫЙ: ##$basic##\nВы на ##25%## скрытнее для гражданских и врагов до тех пор, пока не наденете маску. Вы можете подсвечивать охрану и камеры в режиме исследования.\nТеперь вы можете приобрести услуги 'камера-шпион' и 'наблюдатель'.\n\nПРО: ##$pro##\nКогда вы стоите не двигаясь в течение ##3.5## секунд, противники будут подсвечиваться вокруг вас в радиусе ##10## метров. Навык действует только до тех пор, пока вы остаётесь незамеченным.",
			menu_asset_lock_buy_spotter_asset = "Необходима БАЗОВАЯ версия навыка 'Осведомленность'",
			-- G2
			menu_awareness_beta_desc = "БАЗОВЫЙ: ##$basic;##\nСкорость подъёма по навесным лестницам увеличена на ##20%##.\n\nВертикальная и горизонтальная сила вашего прыжка увеличина на ##20%##.\n\nПРО: ##$pro;##\nПозволяет бегать в любом направлении.\nПерезарядка на бегу: вы можете перезаряжаться во время бега.",
			menu_dire_need_beta = "Подлый ублюдок",
			menu_dire_need_beta_desc = "БАЗОВЫЙ: ##$basic;##\nШанс увернуться от вражеского огня увеличивается на ##1%## за каждые ##3## пункта риска обнаружения меньше ##35##. Навык складывается вплоть до ##10%##.\n\nПРО: ##$pro;##\nШанс увернуться от вражеского огня увеличивается на ##1%## за каждый ##1## пункт риска обнаружения меньше ##35##. Навык складывается вплоть до ##10%##.",
			menu_insulation_beta = "Обратный эффект",
			menu_insulation_beta_desc = "БАЗОВЫЙ: ##$basic##\nКогда вы остались без брони, первый выстрел по противнику отбросит его назад. Эффект работает до тех пор, пока ваша броня не восстановилась и затем еще ##3## секунды.\n\nПРО: ##$pro##\nКогда тэйзер оглушил вас током, у вас есть ##2## секунды, чтобы вырваться из его плена. После ##2## секунд эффект шока будет автоматически направлен обратно на тэйзера.\n\nЕсли вас ударило током каким-либо образом, ваши пули заряжаются электричеством на ##20## секунд, что позваляет вам оглушать током всех противников, кроме бульдозера и Капитана Уинтерса, на расстоянии.",
			menu_jail_diet_beta = "Оживленный",
			menu_jail_diet_beta_desc = "БАЗОВЫЙ: ##$basic##\nУдачный уворот от урона предоставит вам ##10## единиц брони если ваша броня полностью разбита. Данный эффект не может срабатывать чаще чем раз в ##20## секунд.\n\nПРО: ##$pro##\nКоличество получаемой брони от данного навыка увеличено до ##40## единиц.\nВремя восставновления навыка уменьшено до ##14## секунд.",
			
			-- FUGITIVE
			-- F1
			menu_dance_instructor_desc = "БАЗОВЫЙ: ##$basic;##\nПовышает скорострельность пистолетов на ##20%##.\n\nПРО: ##$pro;##\nВы перезаряжаете пистолеты на ##33%## быстрее",
			menu_gun_fighter_beta = "Однорукий бандит",
			menu_gun_fighter_beta_desc = "БАЗОВЫЙ: ##$basic##\nКаждое попадание из пистолета увеличивает вашу точность на ##10%## в течение ##15## секунд и может складываться до ##3## раз.\n\nПРО: ##$pro##\nКаждое попадание из пистолета даёт ##80%## к наносимому урону на ##1.5## секунды. Пиковый навык не может складываться сам с собой.",
			menu_expert_handling = "Вдвоем веселей",
			menu_expert_handling_desc = "БАЗОВЫЙ: ##$basic##\nВаши парные пистолеты получают следующие бонусы:\n - ##16## стабильности\n - ##12## точности\n - ##35%## бонус с скорости перезарядки\n - ##удвоенная## скорость смены оружия\n\nПРО: ##$pro##\nВаши парные пистолет-пулеметы теперь тоже получают эти бонусы.",
			menu_trigger_happy_beta = "БЕЗДОННЫЕ КАРМАНЫ",
			menu_trigger_happy_beta_desc = "БАЗОВЫЙ: ##$basic##\nВы получаете на ##40%## больше боезапаса для пистолетов и пистолет-пулеметов.\n\nПРО: ##$pro##\nВы получаете на ##100%## больше боезапаса для пистолетов и пистолет-пулеметов.",
			-- F2
			menu_up_you_go_beta_desc = "БАЗОВЫЙ: ##$basic;##\nВы получаете на ##30%## меньше урона в течение ##10## секунд после того, как вас подняли.\n\nПРО: ##$pro;##\nВы получаете дополнительные ##25%## от своего максимального здоровья когда вас подняли.",
			menu_perseverance_beta_desc = "БАЗОВЫЙ: ##$basic##\nВместо того чтобы сразу упасть, вы сможете сражаться ещё ##3## секунды. Скорость передвижения при этом будет уменьшена на ##60%##.\nДанный навык не срабатывает при падении с высоты или если вы упали под воздействием огня.\n\nШтраф к скорости передвижения Лебединой Песни будет проигнорирован на ##3## секунды, если в момент активации навыка, или на протяжении его действия, ваш союзник упал.\n\nПРО: ##$pro##\nВремя действия навыка увеличено до ##9## секунд.\n\nВо время действия навыка ваш боезопас будет исчерпываться напрямую из вашего запаса, вместо магазина, а ваш урон будет увеличен на ##50%##.",
			-- F3
			menu_martial_arts_beta = "КРЕПКИЙ ПАРЕНЬ",
			menu_martial_arts_beta_desc = "BASIC: ##$basic##\nПовышает шанс сбить врага с ног рукопашной атакой на ##50%##.\nТряска камеры при получении урона в ближнем бою снижена на ##30%##.\n\nACE: ##$pro##\nБлагодаря интенсивным тренировкам, вы получаете на ##50%## меньше урона в рукопашном бою.\nТряска камеры при получении урона в ближнем бою теперь снижена на ##90%##.",
			menu_bloodthirst_desc = "БАЗОВЫЙ: ##$basic;##\nКаждый раз, когда вы убиваете врага, урон от оружия ближнего боя будет увеличен на ##20%##, до максимума в ##300%##. Внимание: прибавка к урону работает до тех пор, пока вы не убьёте врага оружием ближнего боя.\n\nПРО: ##$pro;##\nПри убийстве врага оружием ближнего боя, скорость вашей перезарядки будет увеличена на ##50%## в течение ##10## секунд.",
			menu_steroids_beta = "БОЕВЫЕ ИСКУССТВА",
			menu_steroids_beta_desc = "БАЗОВЫЙ: ##$basic##\nВы теперь можете бегать когда используете оружие ближнего боя.\n\nПРО: ##$pro##\nСкорость заряда оружия ближнего боя увеличена на ##100%##.",
			menu_drop_soap_beta_desc = "БАЗОВЫЙ: ##$basic##\nВы будете контратаковать противников и сбивать их с ног, если держите оружие ближнего боя наготове. Когда вы контратакуете врага, вы так же нанесете им урон своим холодным оружием.\n\nУрон от контратаки идентичен обычному урону в ближнем бою и зависит от продолжительности заряда оружия.\n\nУдачные контратаки будут моментально убирать оружие ближнего боя из рук.\n\nПРО: ##$pro##\nТеперь вы можете контратаковать клокеров.\n\nКонтратака теперь наносит ##удвоенный## урон.",
			menu_wolverine_beta_desc = "БАЗОВЫЙ: ##$basic##\nВы наносите на ##50%## больше урона оружием ближнего боя.\n\nКогда ваша броня ломается и ваше здроровье ниже ##50%## от максимального, вы наносите на ##50%## больше урона оружием ближнего боя в течении ##20## секунд.\n\nПРО: ##$pro##\nКогда ваша броня ломается и ваше здроровье ниже ##50%## от максимального вы наносите на ##100%## больше урона с огнестрельного оружия в течении ##20## секунд, а продолжительность увеличеного урона в ближнем бою теперь будет длиться ##40## секунд.\n\nНа заметку: действие навыка не распространяется на метательное оружие, гранатометы и ракетометы.\n\nПометка от Гильзы: при входе в режим берсерка на экране появляется вспышка показывающая продолжительность эффекта. Данную вспышку можно кастомизировать или полностью выключить в настройках мода Gilza.",
		})
		
		---- WEAPON MODS ----
		LocalizationManager:add_localized_strings({
			-- Initial stuff: new gadget descriptions + some missing base game strings
			bm_combined_gadget_module = "Двойной модуль - позволяет пользоваться одновременно лазером и фонариком.",
			bm_laser_gadget_module = "Лазерный модуль помогающий стрелку целиться при стрельбе от бедра.",
			bm_flashlight_gadget_module = "Фонарик для освещения темных закаулков.",
			bm_menu_custom_plural = "Переключатели режима огня",
			bm_wp_akm_b_standard_gold = "Стандартный Золотой ствол AKM",
			bm_wpn_fps_ass_g3_b_long_newname = "Стандартный длинный ствол Gewehr3",
			bm_wp_coal_g_standard = "Стандартная рукоятка Tatonka",
			bm_wp_hcar_barrel_standard = "Стандартный ствол для Akron HC",
			
			-- Compatibility for other mods
			bm_wp_wpn_fps_offhandknif_Gilza_desc = "Увеличивает урон и шанс нокдауна при ударе врага оружием. Также добавляет очки крутоты.\nСтатистика:\n -Урон: 50\n -Нокдаун: 400",
			-- Frenchy's missing strings on some parts - no translations required
			bm_wp_wpn_fps_upg_m_celerity = "\"Big Stick\" 30-round mag",
			bm_wp_wpn_fps_upg_m_308dmmag = "Lightweight 30-round mag",
			
			-- New weapon mods added by Gilza, no specific order
			menu_l_global_value_Gilza = "This is a Gilza Item!",
			bm_wpn_fps_upg_br_shtgn = "Пробивной патрон",
			bm_wpn_fps_upg_br_shtgn_desc = "Позволяет вам пробивать все, что обычно может пробить пила OVE9000. Также может пробивать насквозь щиты и нательную броню врагов.\nЭффективная дистанция оружия уменьшена на 50%.\n",
			bm_wpn_fps_upg_ar_dmr_ap_rounds = "Бронебойный DMR патрон",
			bm_wpn_fps_upg_ar_dmr_ap_rounds_desc = "Пробивает нательную броню, щиты и стены.\n\nПодбор боеприпасов уменьшен на 50%.",
			bm_wpn_fps_upg_ap_kit_ap_rounds = "AP ammunition", -- hidden
			bm_wpn_fps_upg_smg_p90_ap_rounds = "Бронебойный патрон P90",
			bm_wpn_fps_upg_smg_p90_ap_rounds_desc = "Пробивает нательную броню и щиты.\n\nПодбор боеприпасов уменьшен на 50%.",
			bm_wpn_fps_upg_pist_mateba_ap_rounds = "Бронебойный патрон Mateba",
			bm_wpn_fps_upg_pist_mateba_ap_rounds_desc = "Пробивает нательную броню и щиты.\n\nПодбор боеприпасов уменьшен на 50%.",
			bm_wpn_fps_upg_contraband_762_to_556_kit = "Комплект для конвертации на 5.56",
			bm_wpn_fps_upg_contraband_762_to_556_kit_desc = "Конвертирует ресивер данного оружия для использования патронов калибра 5.56.\nПодбор боеприпасов увеличен для соответствия новому классу урона.",
			wpn_fps_upg_ak_hp_rounds = "7.62 HP",
			wpn_fps_upg_ak_hp_rounds_desc = "Патрон с экспансивной пулей со свинцовым сердечником, с биметаллической оболочкой в стальной гильзе.\n\nПодбор патронов уменьшен для соответствия новому классу урона.",
			wpn_fps_upg_m4_hp_rounds = "5.56 HP",
			wpn_fps_upg_m4_hp_rounds_desc = "Патрон с экспансивной пулей со свинцовым сердечником, с биметаллической оболочкой в стальной гильзе.\n\nПодбор патронов уменьшен для соответствия новому классу урона.",
			bm_wpn_fps_upg_groza_762_to_545_kit = "Комплект для конвертации на 5.45",
			bm_wpn_fps_upg_groza_762_to_545_kit_desc = "Конвертирует ресивер данного оружия для использования патронов калибра 5.45.\nПодбор боеприпасов увеличен для соответствия новому классу урона.",
			wpn_fps_upg_fal_sp_rounds = "7.62x51mm SP",
			wpn_fps_upg_fal_sp_rounds_desc = "Патрон с пулей с мягким наконечником (Soft-Point) со свинцовым сердечником, в биметаллической полуоболочке, в стальной гильзе.\n\nПодбор патронов увеличен для соответствия новому классу урона.",
			wpn_fps_upg_amcar_rrlp_rounds = "5.56x45mm MK 255 Mod 0 (RRLP)",
			wpn_fps_upg_amcar_rrlp_rounds_desc = "Патрон 5.56x45mm NATO MK 255 Mod 0 (Reduced Ricochet Limited Penetration) с пулей массой 4 грамма с медно-полимерным композитным сердечником, с медной рубашкой, в латунной гильзе.\n\nПодбор патронов увеличен для соответствия новому классу урона.",
			bm_wpn_fps_upg_pis_mid_ap_rounds = "Бронебойные патроны",
			bm_wpn_fps_upg_pis_mid_ap_rounds_desc = "Пробивает нательную броню и щиты.\n\nПодбор боеприпасов уменьшен на 50%.\n",
			bm_wpn_fps_upg_pis_mid_ap_rounds_lv = "Утяжеленные бронебойные патроны",
			bm_wpn_fps_upg_pis_mid_ap_rounds_lv_desc = "Пробивает нательную броню и щиты.\n\nПодбор боеприпасов уменьшен на 30%.\n",
			
			-- New custom GL mods
			bm_wp_upg_a_grenade_launcher_velocity = "Высокоскоростной снаряд",
			bm_wp_upg_a_grenade_launcher_velocity_desc = "Разрывная граната с утроенной скоростью полета снаряда. Подбор боеприпасов уменьшен на 20%.\n\nПометка: работает только если вы лидер лобби, в противном случае будет работать как обычная граната со стандартным подбором боеприпасов.",
			bm_wp_upg_a_underbarrel_velocity_frag_desc = "Разрывная граната с утроенной скоростью полета снаряда. Максимальный урон: 1300. Подбор боеприпасов для подствольного гранатомета уменьшен на 20%.\n\nПометка: работает только если вы лидер лобби, в противном случае будет работать как обычная граната со стандартным подбором боеприпасов.",
			bm_menu_mag_limiter = "Ограничитель",
			bm_menu_mag_limiter_plural = "Ограничители",
			bm_wp_wpn_fps_gre_ms3gl_ml_double_round = "Двух-зарядный",
			bm_wp_wpn_fps_gre_ms3gl_ml_double_round_desc = "Ограничевает стрельбу очередями до 2 выстрелов, уменьшая максимальный размер магазина до 2.",
			bm_wp_wpn_fps_gre_ms3gl_ml_single_round = "Одно-зарядный",
			bm_wp_wpn_fps_gre_ms3gl_ml_single_round_desc = "Ограничевает оружие одиночной стрельбой, уменьшая максимальный размер магазина до 1.",
			
			-- Assault rifle mods
			bm_wpn_fps_upg_ass_m4_b_beowulf_newname = "Бронебойный набор M4",
			bm_wpn_fps_upg_ass_ak_b_zastava_newname = "Бронебойный набор AK",
			bm_wp_famas_b_sniper_newname = "Бронебойный набор Famas",
			wpn_fps_ass_shak12_body_vks_R = "Бронебойный набор KS-12",
			bm_wpn_fps_shak12_upg_ap_kit_desc = "Пробивает нательную броню, щиты и стены.\nОграничивает режим огня используя только одиночный.\nПодбор боеприпасов уменьшен на 50%.",
			bm_wpn_fps_ass_g3_b_sniper_newname = "Бронебойный набор Gewehr3",
			bm_wpn_fps_ass_g3_b_short_desc = "Комплект для ближнего боя. Подбор боеприпасов увеличен на 60%.",
			bm_wpn_fps_upg_ar_ap_kit_desc = "Пробивает нательную броню, щиты и стены.\nПодбор боеприпасов уменьшен на 50%.", -- used by all AR's that have AP kits instead of long barrels
			bm_m4_upg_fg_mk12_desc = "Данный набор ограничивает режим огня используя только автоматический.",
			
			-- Pistol mods
			bm_wpn_fps_pis_c96_b_long_newname = "Бронебойный набор для C96",
			bm_wpn_fps_pis_c96_b_long_newdesc = "Пробивает нательную броню, щиты и стены.\nПодбор боеприпасов уменьшен на 70%.",
			bm_wpn_fps_pis_type54_underbarrel_desc = "Подствольный дробовик. Стата:\n -Урон: 660\n -Множитель минимального урона с дробовика: 1\n -Подбор патронов: 0.33-0.4, учитывая навык 'Тяжёлый пехотинец' из карт перков.",
			bm_wpn_fps_pis_type54_underbarrel_slug_desc = "Подствольный дробовик со свинцовой пулей. Пробивает щиты, стены и нательную броню. Эффективная дистанция оружия увеличина на 15% Стата:\n -Урон: 660\n -Множитель минимального урона с дробовика: 1\n -Подбор патронов: 0.25-0.3, учитывая навык 'Тяжёлый пехотинец' из карт перков.",
			bm_wpn_fps_pis_type54_underbarrel_ap_desc = "Подствольный дробовик со флешеттой, пробивающей нательную броню. Выстреливает 6 дротиков. Эффективная дистанция оружия увеличина на 40%.  Стата:\n -Урон: 660\n -Множитель минимального урона с дробовика: 1\n -Подбор патронов: 0.29-0.36, учитывая навык 'Тяжёлый пехотинец' из карт перков.",
			bm_wpn_fps_pis_x_type54_underbarrel_desc = "Подствольный дробовик. Стата:\n -Урон: 330\n -Множитель минимального урона с дробовика: 1\n -Подбор патронов: 0.66-0.8, учитывая навык 'Тяжёлый пехотинец' из карт перков.",
			bm_wpn_fps_pis_x_type54_underbarrel_slug_desc = "Подствольный дробовик со свинцовой пулей. Пробивает щиты, стены и нательную броню. Эффективная дистанция оружия увеличина на 15% Стата:\n -Урон: 330\n -Множитель минимального урона с дробовика: 1\n -Подбор патронов: 0.5-0.6, учитывая навык 'Тяжёлый пехотинец' из карт перков.",
			bm_wpn_fps_pis_x_type54_underbarrel_ap_desc = "Подствольный дробовик со флешеттой, пробивающей нательную броню. Выстреливает 6 дротиков. Эффективная дистанция оружия увеличина на 40%. Стата:\n -Урон: 330\n -Множитель минимального урона с дробовика: 1\n -Подбор патронов: 0.58-0.72, учитывая навык 'Тяжёлый пехотинец' из карт перков.",
			
			-- SMG mods
			bm_wpn_fps_smg_mp5_m_straight_R = "Патроны RIP",
			bm_wpn_fps_smg_mp5_m_straight_R_desc = "Подбор боеприпасов уменьшен для соответствия новому классу урона.",
			
			-- LMG mods
			wpn_fps_lmg_hcar_barrel_dmr_PEN = "Бронебойный набор Akron HC",
			bm_wpn_fps_lmg_hcar_barrel_dmr_PEN_desc = "Пробивает нательную броню, щиты и стены.\nОграничивает режим огня используя только одиночный.\nПодбор боеприпасов уменьшен на 50%.",
			bm_wpn_fps_upg_lmg_kacchainsaw_underbarrel_flamethrower_desc = "Подствольный огнемет. Наносит 25 урона напрямую со скорострельностью в 2000. Имеет 25% шанс поджечь врага.\nПодожженные враги получают 100 урона в течении 2 секунд.\n\nПодбор боеприпасов уменьшен на 30% для самого пулемета.",
			bm_wpn_fps_upg_lmg_kacchainsaw_conversionkit_desc = "Подбор боеприпасов увеличен на 15%.",
			bm_wpn_fps_lmg_hcar_body_conversionkit_desc = "Подбор боеприпасов увеличен для соответствия новому классу урона.",
			
			-- Shotgun mods
			bm_wpn_fps_upg_a_rip_desc_new = "Пуля вызывающая у протвника неконтролируемую рвоту, блокируя их возможность делать какие либо действия.\n\nНаносит 250 урона в течение 6 секунд.\nПодбор боеприпасов уменьшен на 20%",
			bm_wpn_fps_upg_a_custom_desc_new = "8 Больших дробинок с утроенным уроном.\n\nОтключает возможность наносить увеличенный урон при попадании в голову.\nЭффективная дистанция оружия уменьшена на 20%.\nПодбор боеприпасов уменьшен на 50%.",
			bm_wpn_fps_upg_a_explosive_desc_new = "Выстреливает один взрывной заряд, который убивает или оглушает цели.\nОтключает возможность наносить увеличенный урон при попадании в голову.\nПодбор боеприпасов уменьшен на 65%.",
			bm_wpn_fps_upg_a_piercing_desc_new = "Пробивает нательную броню.\nЭффективная дистанция оружия увеличина на 40%.\n\nВыстреливает 6 дротиков за выстрел.\nПодбор боеприпасов уменьшен на 10%.",
			bm_wpn_fps_upg_a_slug_desc_new = "Выстреливает один свинцовый снаряд, пробивающий насквозь нательную броню, щиты и стены.\n\nЭффективная дистанция оружия увеличина на 15%.\nПодбор боеприпасов уменьшен на 25%.",
			bm_wpn_fps_upg_a_dragons_breath_desc_new = "Выстреливает 8 дробинок, превращающиеся в искры и пламя. Прожигает щиты и нательную броню врагов.\n\nНаносит 350 урона подоженным врагам в течении 2.5 секунд.\nЭффективная дистанция оружия уменьшена на 20%.\nПодбор боеприпасов уменьшен на 30%.",
			wpn_fps_upg_ns_duck_desc = "Уменьшеает вертикальный разброс дроби до 50%, увеличивает горизонтальный разброс дроби до 225%.",
			
			-- Flamethrower mods
			bm_wpn_fps_fla_mk2_mag_rare_desc = "Меньшая огневая мощь, но увеличинный урон от горения.\n50% шанс поджечь врага. Пока враг горит, он получает 720 единиц урона в течение 3 секунд.\nБазовые значения огнемета: 20% шанс на 300 урона в течение 2 секунд.",
			bm_wpn_fps_fla_mk2_mag_welldone_desc = "Большая огневая мощь, но уменьшенный урон от горения.\n10% шанс поджечь врага. Пока враг горит, он получает получает 150 единиц урона в течение 1 секунды.\nБазовые значения огнемета: 20% шанс на 300 урона в течение 2 секунд.",
			
			-- Launcher mods
			bm_wpn_fps_upg_a_grenade_launcher_poison_default_desc = "Наносит урон в 6м радиусе, после чего создает 6м облако газа на 15 секунд. Враги попавшие в данное облако поучат отравление вызывающее неконтролируемую рвоту на 16 секунд, блокируя их возможность делать какие либо действия. Враги получают 3.5 урона в секунду пока они  отравлены.\n\nПодбор боеприпасов уменьшен на 70%.",
			bm_wpn_fps_upg_a_grenade_launcher_poison_ms3gl_desc = "Наносит урон в 3м радиусе, после чего создает 6м облако газа на 15 секунд. Враги попавшие в данное облако поучат отравление вызывающее неконтролируемую рвоту на 16 секунд, блокируя их возможность делать какие либо действия. Враги получают 3.5 урона в секунду пока они  отравлены.\n\nПодбор боеприпасов уменьшен на 82%.",
			bm_wpn_fps_upg_a_grenade_launcher_poison_ms3gl_CK_desc = "Наносит урон в 3м радиусе, после чего создает 8м облако газа на 15 секунд. Враги попавшие в данное облако поучат отравление вызывающее неконтролируемую рвоту на 16 секунд, блокируя их возможность делать какие либо действия. Враги получают 3.5 урона в секунду пока они  отравлены.\n\nПодбор боеприпасов уменьшен на 82%.",
			bm_wpn_fps_upg_a_grenade_launcher_poison_underbarrel_desc = "Наносит 860 урона в 6м радиусе, после чего создает 6м облако газа на 15 секунд. Враги попавшие в данное облако поучат отравление вызывающее неконтролируемую рвоту на 16 секунд, блокируя их возможность делать какие либо действия. Враги получают 3.5 урона в секунду пока они  отравлены.\n\nПодбор боеприпасов для подствольного грагатомета уменьшен на 70%.",
			bm_wpn_fps_upg_a_grenade_launcher_poison_arbiter_desc = "Наносит урон в 3м радиусе, после чего создает 4м облако газа на 15 секунд. Враги попавшие в данное облако поучат отравление вызывающее неконтролируемую рвоту на 8 секунд, блокируя их возможность делать какие либо действия. Враги получают 7 урона в секунду пока они  отравлены.\n\nПодбор боеприпасов уменьшен на 70%.",
			bm_wpn_fps_upg_a_grenade_launcher_incendiary_desc = "После детонации создает огненное поле на 6 секунд.\nВраги попавшие в это поле начинают гореть.\n\nСтата поджога:\n -Продолжительность: 6 секунд\n -Урон в секунду: 250\nПока враг стоит в огненном поле он получает утроенный урон в секунду.\n\nПодбор боеприпасов уменьшен на 50%.",
			bm_wpn_fps_upg_a_grenade_launcher_incendiary_ms3gl_desc = "После детонации создает огненное поле на 6 секунд.\nВраги попавшие в это поле начинают гореть.\n\nСтата поджога:\n -Продолжительность: 6 секунд\n -Урон в секунду: 250\nПока враг стоит в огненном поле он получает утроенный урон в секунду.\n\nПодбор боеприпасов уменьшен на 75%.",
			bm_wpn_fps_upg_a_grenade_launcher_incendiary_arbiter_desc = "После детонации создает огненное поле на 3 секунды.\nВраги попавшие в это поле начинают гореть.\n\nСтата поджога:\n -Продолжительность: 3 секунд\n -Урон в секунду: 250\nПока враг стоит в огненном поле он получает утроенный урон в секунду.\n\nПодбор боеприпасов уменьшен на 50%.",
			bm_wpn_fps_upg_a_grenade_launcher_electric_desc = "После детонации создает увеличинное 8м взрывное поле поражающее врагов электрическим шоком. Пораженные враги будут неконтролируемо дергаться в спазмах в течении 3-5 секунд.\nУрон от взрыва теряет свою эффективность быстрее, из-за чего враги находящиеся максимально далеко, но все еще в радиусе взрыва, будут получать мизерный урон.\n\nПодбор боеприпасов увеличен на 10%.",
			bm_wpn_fps_upg_a_underbarrel_launcher_electric_desc = "После детонации создает увеличинное 8м взрывное поле поражающее врагов электрическим шоком. Макс. урон: 800. Пораженные враги будут неконтролируемо дергаться в спазмах в течении 3-5 секунд.\nУрон от взрыва теряет свою эффективность быстрее, из-за чего враги находящиеся максимально далеко, но все еще в радиусе взрыва, будут получать мизерный урон.\n\nПодбор боеприпасов для подствольного грагатомета увеличен на 10%.",
			bm_wpn_fps_upg_a_grenade_launcher_hornet_desc = "Выстреливает 20 похожих на дробь зарядов, которые могут пробивать щиты. Множитель минимального урона с дробовика: 0.75\n\nПодбор боеприпасов увеличен на 250%.",
			bm_wpn_fps_upg_a_grenade_launcher_hornet_underbarrel_desc = "Выстреливает 20 похожих на дробь зарядов, которые могут пробивать щиты. Максимальный урон: 460. Множитель минимального урона с дробовика: 0.75\n\nПодбор боеприпасов для подствольного грагатомета увеличен на 350%.",
			bm_wp_upg_a_grenade_launcher_frag_desc = "Осколочный снаряд. Вызывает разлет фрагментов при детонации. Максимальный урон: 1300.",
			
			-- Poison bow arrows
			bm_wpn_fps_upg_a_pistol_crossbow_poison_desc = "Стрела с ядовитым наконечником. Отравляет врагов, и вызываюет неконтролируемую рвоту, блокируя их возможность делать какие либо действия.\nНаносит 50 урона в секунду на протяжении 6 секунд.",
			bm_wpn_fps_upg_a_light_crossbow_poison_desc = "Стрела с ядовитым наконечником. Отравляет врагов, и вызываюет неконтролируемую рвоту, блокируя их возможность делать какие либо действия.\nНаносит 135 урона в секунду на протяжении 6 секунд.",
			bm_wpn_fps_upg_a_h3h3_poison_desc = "Стрела с ядовитым наконечником. Отравляет врагов, и вызываюет неконтролируемую рвоту, блокируя их возможность делать какие либо действия.\nНаносит 90 урона в секунду на протяжении 6 секунд.",
			bm_wpn_fps_upg_a_crossbow_poison_desc_new = "Стрела с ядовитым наконечником. Отравляет врагов, и вызываюет неконтролируемую рвоту, блокируя их возможность делать какие либо действия.\nНаносит 100 урона в секунду на протяжении 6 секунд.",
			
			-- Sniper mods
			bm_wp_mosin_ns_bayonet_desc = "Увеличивает урон и шанс нокдауна при ударе врага оружием.\nСтатистика:\n -Урон: 50\n -Нокдаун: 400",
			bm_wpn_fps_upg_snp_awp_conversionkit_new_desc = "Подбор патронов изменен для соответствия новому классу урона.",
		})
		
		---- THROWABLES ----
		LocalizationManager:add_localized_strings({
			bm_wpn_prj_ace_desc = "Урон: 40\nМножитель подбора: "..tostring(Gilza.grenade_multipliers.wpn_prj_ace).."\n",
			bm_grenade_frag_desc = "Урон: 1600\nРадиус: 500\nМножитель подбора: "..tostring(Gilza.grenade_multipliers.frag).."\n",
			bm_wpn_prj_four_desc = "Урон: 100\nМножитель подбора: "..tostring(Gilza.grenade_multipliers.wpn_prj_four).."\n\nПораженные враги поучают отравление вызывающее неконтролируемую рвоту, блокируя их возможность делать какие либо действия.\n\nСтата отравления:\n -Продолжительность: 5 секунд\n -Урон в секунду: 130",
			bm_wpn_prj_hur_desc = "Урон: 1100\nМножитель подбора: "..tostring(Gilza.grenade_multipliers.wpn_prj_hur).."\n",
			bm_wpn_prj_jav_desc = "Урон: 3250\nМножитель подбора: "..tostring(Gilza.grenade_multipliers.wpn_prj_jav).."\n",
			bm_wpn_prj_target_desc = "Урон: 1100\nМножитель подбора: "..tostring(Gilza.grenade_multipliers.wpn_prj_target).."\n",
			bm_concussion_desc = "Урон: 0\nРадиус: 1500\nМножитель подбора: "..tostring(Gilza.grenade_multipliers.concussion).."\n",
			bm_dynamite_desc = "Урон: 1600\nРадиус: 500\nМножитель подбора: "..tostring(Gilza.grenade_multipliers.dynamite).."\n",
			bm_grenade_frag_com_desc = "Урон: 1600\nРадиус: 500\nМножитель подбора: "..tostring(Gilza.grenade_multipliers.frag_com).."\n",
			bm_grenade_sticky_grenade_desc = "Урон: 1200\nРадиус: 500\nМножитель подбора: "..tostring(Gilza.grenade_multipliers.sticky_grenade).."\n",
			bm_grenade_xmas_snowball_desc = "Урон: 280\nРадиус: 100\n",
			bm_grenade_fir_com_desc = "Урон: 30\nРадиус: 500\nМножитель подбора: "..tostring(Gilza.grenade_multipliers.fir_com).."\n\nСоздает зажигательный взрыв. Враги попавшие в радиус взрыва начинают гореть.\n\nСтата поджога:\n -Продолжительность: 2 секунды\n -Урон в секунду: 420",
			bm_grenade_dada_com_desc = "Урон: 1600\nРадиус: 500\nМножитель подбора: "..tostring(Gilza.grenade_multipliers.dada_com).."\n",
			bm_grenade_molotov_desc = "Урон: 30\nРадиус: 350\nМножитель подбора: "..tostring(Gilza.grenade_multipliers.molotov).."\n\nСоздает огненное поле на 15 секунд. Враги попавшие в это поле начинают гореть.\n\nСтата поджога:\n -Продолжительность: 10 секунд\n -Урон в секунду: 260\n\nЕсли вы попадете прямо по врагу, урон в секунду от поджога будет увеличен до 420 для этой цели.",
			bm_grenade_electric_desc = "Урон: 600\nРадиус: 1000\nМножитель подбора: "..tostring(Gilza.grenade_multipliers.wpn_gre_electric).."\n\nЗап-зап.\nДанная граната имеет увеличенный дроп-офф урона, из-за чего противники в радиусе взрыва, но не в его центре, будут получать очень маленький урон.\n",
			bm_grenade_poison_gas_grenade_desc = "Урон: 1000\nРадиус: 200\nМножитель подбора: "..tostring(Gilza.grenade_multipliers.poison_gas_grenade).."\n\nСоздает облако газа на 20 секунд. Враги попавшие в данное облако поучат отравление вызывающее неконтролируемую рвоту, блокируя их возможность делать какие либо действия.\n\nСтата отравления:\n -Продолжительность: 15 секунд\n -Урон в секунду: 30",
		})
		
		---- MELEE ----
		LocalizationManager:add_localized_strings({
			bm_melee_cs_info = "Удерживайте кнопку ближнего боя дабы наносить непрерывный урон.\n\nСтатистика эффекта бензопилы:\nЗадержка перед началом эффекта: 1 сек.\nУрон: 80% здоровья в секунду",
			bm_melee_ostry_info = "Удерживайте кнопку ближнего боя дабы наносить непрерывный урон.\n\nСтатистика эффекта бензопилы:\nЗадержка перед началом эффекта: 0.7 сек.\nУрон: 60% здоровья в секунду",
		})
		
		---- MENU ----
		LocalizationManager:add_localized_strings({
			menu_Gilza_perk_reset_text = "ВНИМАНИЕ!\n\nНажимая 'Да' вы обнулите прогрессию ваших перков. Обнуление прорессии перков удалит прогрессию всех ваших перков, НО оставит количество очков перков которое у вас есть нетронутым. Данную опцию можно использовать для того, чтобы попробовать новые перки Гильзы не тратя время на зарабатывание очков перков.\n\nВы уверены что хотите продолжить?",
			menu_Gilza_perk_reset_confirm = "Да",
			menu_Gilza_perk_reset_deny = "Нет"
		})
		
	end

	if chosen_language == "eng" then
		loc:load_localization_file(Gilza._path .. 'menus/lang/Gilza_en.txt', false)
	elseif chosen_language == "ru" then
		loc:load_localization_file(Gilza._path .. 'menus/lang/Gilza_ru.txt', false)
		AddRussianLoc()
	end

end)