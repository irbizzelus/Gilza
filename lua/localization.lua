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
		
		local function Perk_strings_vanilla()
			
			local function Neutral_cards()
				LocalizationManager:add_localized_strings({
					menu_deckall_2 = "Fast and Furious",
					menu_deckall_2_desc = "Increases your doctor bag interaction speed by ##20%##.\n\nBody armor movement speed penalty is reduced by ##25%##.",
					menu_deckall_4_desc = "You gain ##+1## increased concealment.\n\nYou gain ##45%## more experience when you complete days and jobs.",
					menu_deckall_6_desc = "Unlocks an armor bag equipment for you to use. The armor bag can be used to change your armor during a heist.\n\nIncreases amount of ammo you gain from ammo boxes by ##35%##.\n\nYou also gain a base ##0%## chance to get a throwable from an ammo box. The base chance is increased by ##1% * x## (where x - throwable pick up multiplier) for each ammo box you pick up that does not contain a throwable. When a throwable has been found, the chance is reset to its base value.\n\nNote: Throwable pick up multipliers are different for each throwable - you can find them under throwable descriptions.",
					menu_deckall_8 = "Improved Physique",
					menu_deckall_8_desc = "You gain ##10%## additional movement speed.\n\nYou can throw bags ##50%## further.",
				})
			end
			Neutral_cards()
			
			local function Crew_chief_str()
				LocalizationManager:add_localized_strings({
					menu_deck1_3_desc = "You and your crew's stamina is increased by ##50%##.\n\nWhile trying to intimidate a law enforcer or a civilian, marking a special enemy, or using \"Inspire\" skill on your teammates, your shout distance is increased by ##25%##.\n\nWhile you are within ##18m## of an enemy that you can see, you receive a ##8%## damage reduction. This damage reduction lingers for ##5## seconds after you are no longer close to an enemy.\nNote: Crew perks do not stack.",
					menu_deck1_5_desc = "You and your crew's health is increased by ##10%##.\n\nYou gain ##10%## health that is only applied to you.\n\nNote: Crew perks do not stack.",
					menu_deck1_7_desc = "You and your crew's armor is increased by ##5%##.\n\nYou gain ##5%## armor that is only applied to you.\n\nNote: Crew perks do not stack.",
					menu_deck1_9_desc = "You and your crew will gain ##6%## max health and ##12%## stamina for each hostage up to ##4## times.\n\nYou and your crew will gain ##8%## damage reduction for having one or more hostages.\n\nIntimidated law enforcers count as hostages for this perk card. Enemies who were converted to fight on your side will provide hostage bonuses from this perk card only to the crew member who converted such enemy.\n\nNote: Crew perks do not stack.\n\nDeck Completion Bonus: Your chance of getting a higher quality item during a Payday is increased by ##10%##.",
					-- short descs
					menu_deck1_3_short = "You and your crew's stamina is increased by ##50%##. Increases your shout distance by ##25%##. While you are within ##18m## of an enemy that you can see, you receive a ##8%## damage reduction. Note: Crew perks do not stack.",
					menu_deck1_5_short = "You and your crew's health is increased by ##10%##. You gain ##10%## health that is only applied to you. Note: Crew perks do not stack.",
					menu_deck1_7_short = "You and your crew's armor is increased by ##5%##. You gain ##5%## armor that is only applied to you. Note: Crew perks do not stack.",
				})
			end
			Crew_chief_str()
			
			local function Muscle_str()
				LocalizationManager:add_localized_strings({
					menu_deck2_7_desc = "All firearms, that do not have a silencer equipped, have a ##20%## chance to spread panic among your enemies when fired.\n\nPanic will make enemies go into short bursts of uncontrollable fear, preventing them from making other actions. Some enemies have resistance for this effect and some, like Bulldozers, are completely immune to it.",
					menu_deck2_9_desc = "You gain an additional ##60%## more health.\n\nYou regenerate ##3%## of your health every ##5## seconds.\n\nWhile playing on Death Sentence difficulty your passive health regeneration is increased to ##5%## every ##5## seconds.\n\nDeck Completion Bonus: Your chance of getting a higher quality item during a Payday is increased by ##10%##.",
					-- short descs
					menu_deck2_9_short = "You gain an additional ##60%## more health. You regenerate ##3%## of your health every ##5## seconds. Passive healing bonus is increased while playing on Death Sentence difficulty.",
				})
			end
			Muscle_str()
			
			local function Rogue_str()
				LocalizationManager:add_localized_strings({
					menu_deck4_9_desc = "Your chances to pierce enemy body armor are increased by ##40%##.\nIncreases weapon swapping speed by ##80%##.\n\nYour chance to dodge is increased by an additional ##5%##.\nYour chance to dodge while crouched is increased by ##5%##.\n\nYour movement speed is increased by ##15%##.\nYour stamina is increased by ##25%##.\n\nDeck Completion Bonus: Your chance of getting a higher quality item during a Payday is increased by ##10%##.",
					-- short descs
					menu_deck4_9_short = "All your weapons have a ##40%## chance to pierce enemy armor. Increases weapon swapping speed by ##80%##. Your chance to dodge is increased by ##5%## and your chance to dodge while crouched is increased by ##5%##. Your movement speed is increased by ##15%##. Your stamina is increased by ##25%##.",
				})
			end
			Rogue_str()
			
			local function Hitman_str()
				LocalizationManager:add_localized_strings({
					menu_deck5_1 = "Master of arms",
					menu_deck5_1_desc = "Securing a kill with a melee weapon or a throwable non-explosive weapon regenerates ##25%## of your armor. This can not happen more often than once every ##1## seconds.",
					menu_deck5_3_desc = "Stability penalty that your akimbo weapons have is reduced by ##8##.\nAmmo capacity for your akimbo weapons is increased by ##50%##.\n\nKilling an enemy using a pistol, SMG or an akimbo weapon grants you ##25%## faster armor recovery rate for ##10## seconds. If you secure a kill with a pistol, SMG or akimbo weapon while this skill is already active, skill duration timer we be refreshed.",
					menu_deck5_5 = "Rhythm of Death",
					menu_deck5_5_desc = "\nNew ability: Rhythm of Death.\nTo activate, you need to secure ##4## combo kills in a row. Time between each kill can not be less then ##0.5## seconds and can not be more than ##1.5## seconds. If you secure a kill faster than required, the kill is ignored for the combo; if you are too late, combo is reset.\n\nFirst kill of the combo must be achieved using either a melee weapon or a throwable non-explosive weapon. Securing kills with melee or throwable non-explosive weapons during the combo, will count as 2 kills instead of 1, except for the very first kill of the combo.\n\nOn ability activation: gain ##5## seconds of invulnerability. This effect has a cooldown of ##20## seconds.\n\nGilza's perk UI will show you your current combo amount, if invulnerability is active (blue skull), and if it is on cooldown (red timer).",
					menu_deck5_7 = "Bounty Hunter",
					menu_deck5_7_desc = "\nNew passive trait: Bounty Hunter.\nRandom enemy within ##25m## of you becomes your bounty target, this target will get a white outline visible only to you. If you kill your bounty you gain a bounty bonus.\n\nBounty bonus lasts for ##30## seconds. After bounty bonus duration expires, you would not be able to receive a new bounty for ##10## seconds. If your bounty target escapes or is killed by someone else, you don't get a bounty bonus and you would not be able to receive a new bounty for ##40## seconds. If your bounty target is still alive ##40## seconds after they have become your bounty, their bounty status is removed and you can't get another bounty for ##10## seconds.\n\nBounty bonus:\nWhile active, amplifies effects of Hitman's perk cards 1, 3 and 5.\nFirst card's armor regeneration is increased to ##50%##, third card's armor recovery bonus is increased to ##50%##, and fifth card's invulnerability duration is increased to ##10## seconds, without affecting the cooldown.\n\nGilza's perk UI will show you if you currently have a bounty (bright white), and if bounty bonus is active (green).",
					menu_deck5_9_desc = "Your armor will recover ##1.5## seconds after being broken no matter what the situation.\n\nDeck Completion Bonus: Your chance of getting a higher quality item during a Payday is increased by ##10%##.",
					-- short descs
					menu_deck5_1_short = "Securing kills with melee or throwable non-explosive weapons regenerates ##25%## armor. This can only occur more often than once every ##1## second.",
					menu_deck5_3_short = "Akimbo weapons gain increased ammo capacity and stability. Kills with pistols, SMG's and akimbo weapons will grant ##25%## faster armor recovery bonus.",
					menu_deck5_5_short = "New ability: Rhythm of Death. Securing ##4## perfectly timed combo kills in a row grants ##5## seconds of invulnerability, with a ##20## second cooldown. Combo requires a melee or throwable non-explosive weapon kill to begin.",
					menu_deck5_7_short = "New passive trait Bounty Hunter. Random enemy becomes your bounty target, if you kill this target you gain a bounty bonus. Bounty bonus amplifies effects of other Hitman perk deck cards.",
					menu_deck5_9_short = "Your armor will recover ##1.5## seconds after being broken no matter what the situation.",
				})
			end
			Hitman_str()
			
			local function Crook_str()
				LocalizationManager:add_localized_strings({
					menu_deck6_5_desc = "Your chance to dodge is increased by ##5%## for ballistic vests.\n\nYour armor is increased by ##20%## for ballistic vests.",
					menu_deck6_7_desc = "Your chance to dodge is increased by ##15%## for ballistic vests.\n\nYour armor is increased by ##25%## for ballistic vests.",
					menu_deck6_9_desc = "Your armor recovery rate is increased by ##10%##.\n\nYour chances to pierce enemy body armor are incresed by ##75%##.\n\nDeck Completion Bonus: Your chance of getting a higher quality item during a Payday is increased by ##10%##.",
					-- short descs
					menu_deck6_5_short = "Your chance to dodge is increased by ##5%## for ballistic vests. Your armor is increased by ##20%## for ballistic vests.",
					menu_deck6_7_short = "Your chance to dodge is increased by ##15%## for ballistic vests. Your armor is increased by ##25%## for ballistic vests.",
					menu_deck6_9_short = "Your armor recovery rate is increased by ##10%##. Your chances to pierce enemy body armor are increased by ##75%##.",
				})
			end
			Crook_str()
			
			local function Burglar_str()
				LocalizationManager:add_localized_strings({
					menu_deck7_3_desc = "Standing still and crouching decreases your chances to be targeted by ##10%##.\n\nYou bag corpses ##25%## faster.",
					menu_deck7_5_desc = "Your chance to dodge is increased by an additional ##5%##.\n\nYour chance to be targeted while standing still and crouching is decreased by an additional ##5%##.\n\nYour chance to dodge is increased by ##10%## while using the Lightweight Ballistic Vest.\n\nYou gain ##2## concealment for each silenced weapon you equip.\n\nYou pick locks ##25%## faster.",
					menu_deck7_7_desc = "Your chance to dodge is increased by an additional ##5%##.\n\nYour chance to be targeted while standing still and crouching is decreased by an additional ##5%##.\n\nYou answer pagers ##25%## faster.",
					menu_deck7_9_desc = "Standing still increases your armor recovery rate by ##20%##.\n\nYou gain ##10%## crouching movement speed.\n\nDeck Completion Bonus: Your chance of getting a higher quality item during a Payday is increased by ##10%##.",
					-- short descs
					menu_deck7_3_short = "Standing still and crouching decreases your chances to be targeted by ##10%##. You bag corpses ##25%## faster.",
					menu_deck7_5_short = "Your chance to dodge is increased by an additional ##5%##. our chance to be targeted while standing still and crouching is decreased by an additional ##5%##. Your chance to dodge is increased by ##10%## while using the Lightweight Ballistic Vest. You gain ##2## concealment for each silenced weapon you equip. You pick locks ##25%## faster.",
					menu_deck7_7_short = "Your chance to dodge is increased by an additional ##5%##. Your chance to be targeted while standing still and crouching is decreased by an additional ##5%##. You answer pagers ##25%## faster.",
					menu_deck7_9_short = "Standing still increases your armor recovery rate by ##20%##. You gain ##10%## crouching movement speed.",
				})
			end
			Burglar_str()
			
			-- Socio/Infil shared first card
			LocalizationManager:add_localized_strings({
				menu_sociopathinfil_1 = "OVERDOG",
				menu_sociopathinfil_1_desc = "While you are surrounded by three or more visible enemies within ##18m## of you, you receive a ##12%## damage reduction. This damage reduction lingers for ##5## seconds after you are no longer surrounded.\n\nYour second and each consecutive melee hit within ##4## seconds of the last one will deal ##100%## more damage.",
				menu_sociopathinfil_1_short = "While you are surrounded by three or more visible enemies within ##18m## of you, you receive a ##12%## damage reduction. Your second and each consecutive melee hit within ##4## seconds of the last one will deal ##100%## more damage.",
			})
			
			local function Infiltrator_str()
				LocalizationManager:add_localized_strings({
					menu_deck8_3 = "Basic Close Combat",
					menu_deck8_3_desc = "While you are within ##18m## of an enemy that you can see, you receive a ##8%## damage reduction. This damage reduction lingers for ##5## seconds after you are no longer close to an enemy.",
					menu_deck8_5 = "Advanced Close Combat",
					menu_deck8_5_desc = "While you are within ##18m## of an enemy that you can see, you receive an additional ##7%## damage reduction. This damage reduction lingers for ##5## seconds after you are no longer close to an enemy.",
					menu_deck8_7 = "Expert Close Combat",
					menu_deck8_7_desc = "While you are within ##18m## of an enemy that you can see, you receive an additional ##7%## damage reduction. This damage reduction lingers for ##5## seconds after you are no longer close to an enemy.",
					-- short descs
					menu_deck8_3_short = "While you are within ##18m## of an enemy that you can see, you receive a ##8%## damage reduction.",
					menu_deck8_5_short = "While you are within ##18m## of an enemy that you can see, you receive an additional ##7%## damage reduction.",
					menu_deck8_7_short = "While you are within ##18m## of an enemy that you can see, you receive an additional ##7%## damage reduction.",
				})
			end
			Infiltrator_str()
			
			local function Sociopath_str()
				LocalizationManager:add_localized_strings({
					menu_deck9_5_desc = "Killing an enemy with a melee weapon regenerates ##10%## health. Note: armor regeneration from \"Tension\" perk card will activate along with this skill.\n\nThis cannot occur more than once every ##1## second.\n\nWhile you are within ##18m## of an enemy that you can see, you receive additional ##8%## damage reduction. This damage reduction lingers for ##5## seconds after you are no longer close to an enemy.",
					menu_deck9_7_desc = "Killing an enemy within ##18m## of you increases your armor recovery on kill by ##30##.\n\nYou gain an additional ##10%## more armor.",
					menu_deck9_9_desc = "Killing an enemy within ##18m## of you has a ##75%## chance to spread panic among your enemies.\n\nPanic will make enemies go into short bursts of uncontrollable fear, preventing them from making other actions. Some enemies have resistance for this effect and some, like Bulldozers, are completely immune to it.\n\nThis effect can only occur once every ##1## second and is synced with other \"on kill\" effects from this perk deck.\n\nDeck Completion Bonus: Your chance of getting a higher quality item during a Payday is increased by ##10%##.",
					-- short descs
					menu_deck9_3_short = "Killing an enemy regenerates ##30%## armor. You gain ##10%## more armor.",
					menu_deck9_5_short = "Killing an enemy with a melee weapon regenerates ##10%## health. While you are within ##18m## of an enemy that you can see, you receive additional ##8%## damage reduction.",
					menu_deck9_7_short = "Killing an enemy within ##18m## of you increases your armor recovery on kill by ##30##. You gain ##10%## more armor.",
					menu_deck9_9_short = "Killing an enemy within ##18m## of you has a ##75%## chance to spread panic among your enemies. Panic will make enemies go into short bursts of uncontrollable fear.",
				})
			end
			Sociopath_str()
			
			local function Gambler_str()
				LocalizationManager:add_localized_strings({
					menu_deck10_1_desc = "Ammo packs you pick up can sometimes yield medical supplies - when ammo pack is picked up, you roll your chances to get healed. This can not occur more often than once every ##4## seconds.\n\nOn pick up, you have a ##70%## chance to be healed for a random amount of health points: from ##16## to ##24##. If you succeed an additional ##20%## chance roll, you will get a jackpot and triple your earned health.\nOtherwise there is a ##15%## chance you will find poisonous medical supplies and will lose a random amount of health points: from ##32## to ##48##. If you succeed an additional ##10%## failure roll, you will get a failure jackpot and triple your lost health.\nLastly you have a ##15%## chance for this skill to do nothing, but go on cooldown.\n\nYour ammo box pick up range is increased by ##50%##.\n\nNote: Gilza's perk UI will show you if this skill is on cooldown (bright white), if effect was positive (green) or negative (red), and if effect is available to be activated again (faded out white). If you get a jackpot, icon will flash.",
					menu_deck10_3_desc = "When you pick up ammo, you trigger an ammo pickup for ##50%## of normal pickup to other players in your team.\n\nCan not occur more than once every ##4## seconds.\n\nYou gain ##20%## more health.",
					menu_deck10_5_desc = "When you pick up ammo packs that contain medical supplies, your teammates will also get healed for ##15## health points, regardless of what kind of effect you got.\n\nYou gain ##20%## more health.",
					menu_deck10_7 = "Against all odds",
					menu_deck10_7_desc = "Health you gain from ammo packs on a successful roll is increased by ##16## health points, but health you lose on a failure roll is also increased by ##32##.",
					menu_deck10_9 = "Even more dice",
					menu_deck10_9_desc = "When you pick up ammo packs that contain medical supplies, you will now also receive passive dodge chance. Maximum dodge chance you can get from this perk card is ##35%##. Your chances of getting positive/negative bonuses are shared and depend on this perk deck's first card activation.\n\nOn a successful roll you gain random amount of dodge chance: from ##2%## to ##8%##. On a successful jackpot, your dodge chance bonus from this perk card is set to the maximum.\nOn a failure roll you will lose a random amount of dodge chance: from ##4%## to ##16%##. On a failure jackpot your bonus dodge chance from this perk card is reset to ##0%##.\n\nDeck Completion Bonus: Your chance of getting a higher quality item during a Payday is increased by ##10%##.\n\nNote: Gilza's perk UI that appears while using Gambler will now also show bonus dodge chance that this perk card provides.",
					-- short descs
					menu_deck10_1_short = "Ammo pickups can heal or damage you. Your ammo box pick up range is increased.",
					menu_deck10_3_short = "Ammo pickups refill ammo for your teammates. Your health is increased.",
					menu_deck10_5_short = "Ammo pickups heal your teammates. Your health is increased.",
					menu_deck10_7_short = "Amount of gained/lost health from ammo pickups is increased.",
					menu_deck10_9_short = "Ammo pickups can now adjust you dodge chances.",
				})
			end
			Gambler_str()
			
			local function Grinder_str()
				LocalizationManager:add_localized_strings({
					menu_deck11_5_desc = "Damaging an enemy now heals ##3## life points every ##0.3## seconds for ##3## seconds.\n\nYour chances to pierce enemy body armor are increased by ##10%##.",
					menu_deck11_9_desc = "Damaging an enemy now heals ##4## life points every ##0.3## seconds for ##4.2## seconds.\n\nYour chances to pierce enemy body armor are increased by additional ##25%##.\n\nDeck Completion Bonus: Your chance of getting a higher quality item during a Payday is increased by ##10%##.",
					-- short descs
					menu_deck11_9_short = "Damaging an enemy now heals ##4## life points every ##0.3## seconds for ##4.2## seconds. Increase your chance to pierce enemy armor by ##25%##.",
				})
			end
			Grinder_str()
			
			local function Yakuza_str()
				LocalizationManager:add_localized_strings({
					menu_deck12_1_desc = "The lower your health, the more armor recovery rate you have. When your health is below ##25%##, you will gain up to ##20%## armor recovery rate.\n\nWhenever you are revived, your health will always be set to ##10%## of your max health.\n\nAll skills that provide health regeneration are completely ignored.",
					menu_deck12_7_desc = "The lower your health, the more armor recovery rate you have. When your health is below ##25%##, you will gain up to an additional ##20%## armor recovery rate.\n\nWhile your health is below ##50%## you are immune to the armor piercing effect.",
					menu_deck12_9_desc = "All berserker state effects in this perk deck will start at ##50%## health instead of ##25%##.\n\nEnemies that are behind you will deal ##25%## less damage to you. This bonus is increased to ##50%## while playing on Death Sentence difficulty.\n\nWhile your health is below ##50%## you are immune to armor suppression effect.\n\nNote: normally, armor suppression effect is applied to you whenever you are shot, regardless of if you are hit or not. If you get suppressed, your armor recovery timer will be set to it's maximum duration and additional ##1## second will be added from armor suppression effect to your total recovery timer. This addition is not affected by armor recovery or any other skills.\nArmor suppression immunity effect from this perk card reduces this timer extension to ##0.5## seconds, and also disables your armor recovery timer from resetting to it's maximum duration when you are being shot at, without getting hit.\n\nDeck Completion Bonus: Your chance of getting a higher quality item during a Payday is increased by ##10%##.",
					-- short descs
					menu_deck12_1_short = "The lower your health, the more armor recovery rate you have. When your health is below ##25%##, you will gain up to ##20%## armor recovery rate. All skills that provide health regeneration are completely ignored.",
					menu_deck12_5_short = "When your health is below ##25%##, you will gain up to an additional ##20%## armor recovery rate.",
					menu_deck12_7_short = "When your health is below ##25%##, you will gain up to an additional ##20%## armor recovery rate. While your health is below ##50%## you are immune to the armor piercing effect.",
					menu_deck12_9_short = "All berserker state effects in this perk deck will start at ##50%## health instead of ##25%##. While your health is below ##50%## you are immune to armor suppression effect.",
				})
			end
			Yakuza_str()
			
			local function Ex_president_str()
				LocalizationManager:add_localized_strings({
					menu_deck13_5_desc = "Increases the maximum health that your armor can store by ##50%##.\n\nYou gain ##10%## more health.\n\nYou now have ##20%## static dodge chance. Static dodge chance can not be increased or decreased regardless of equipped skills and armor.",
					menu_deck13_7_desc = "Increases the amount of health stored from kills by ##4##.\n\nYou gain ##20%## more health.\n\nIf you were to take damage to your health while having any amount of stored health, your stored health will absorb incoming damage.\nIf incoming damage is greater than your stored health, your stored health will absorb damage equal to amount of stored health, and the remaining damage will be applied to your health directly.",
					menu_deck13_9_desc = "For each kill you or your crew performs, your next armor recovery timer will be reduced by a few centiseconds. Timer reduction depends on your equipped armor - higher armor equipped provides smaller timer bonus. Your armor recovery timer can not go lower than ##0.8## seconds total with this skill.\nArmor recovery timer bonus is reset when your armor fully recovers.\n\nNote: armor recovery timer is a flat ##3## seconds timer. Armor recovery rate is a multiplier that applies after the timer duration is calculated.\n\nDeck Completion Bonus: Your chance of getting a higher quality item during a Payday is increased by ##10%##.",
					-- armor description for blackmarket UI
					bm_menu_armor_max_health_store = "Ex-President Perk Deck:\nMaximum amount of health that can be stored: $amount;\nArmor recovery timer reduction per kill: $amount_2;s",
					-- short descs
					menu_deck13_5_short = "Increases the maximum health that your armor can store by ##50%##. You gain ##10%## more health. You now have ##20%## static dodge chance.",
					menu_deck13_7_short = "Increases the amount of health stored from kills by ##4##. You gain ##20%## more health. Your stored health can now shield your normal health.",
					menu_deck13_9_short = "For each kill you or your crew performs, your next armor recovery timer will be reduced by a few centiseconds. Timer reduction depends on your equipped armor - higher armor equipped provides smaller timer bonus.",
				})
			end
			Ex_president_str()
			
			local function Maniac_str()
				LocalizationManager:add_localized_strings({
					menu_deck14_1_desc = "##100%## of damage you deal is converted into Hysteria Stacks, up to ##120## every ##1.5## second. Max amount of stacks is ##600##.\n\nHysteria Stacks\nYou gain ##1## damage absorption for every ##30## stacks of Hysteria.\n\nIf you don't deal any damage for ##3## seconds, you will lose ##20% + 80## Hysteria Stacks.",
					menu_deck14_5_desc = "Change decay of your Hysteria Stacks when you don't deal damage for ##3## seconds to ##20% + 40##.",
					menu_deck14_9_desc = "Damage absorption from Hysteria Stacks on you is increased by ##100%##.\nIf you are playing on Death Sentence difficulty, this bonus is increased to ##200%##.\n\nDeck Completion Bonus: Your chance of getting a higher quality item during a Payday is increased by ##$multiperk2;##.",
					-- short descs
					menu_deck14_1_short = "##100%## of damage you deal is converted into Hysteria Stacks, up to ##120## every ##1.5## second. Max amount of stacks is ##600##. Hysteria Stacks - you gain ##1## damage absorption for every ##30## stacks of Hysteria.\nIf you don't deal any damage for ##3## seconds, you will lose ##20% + 80## Hysteria Stacks.",
					menu_deck14_5_short = "Change decay of your Hysteria Stacks when you don't deal damage for ##3## seconds to ##20% + 40##.",
					menu_deck14_9_short = "Damage absorption from Hysteria Stacks on you is increased by ##100%##, or ##200%## if you are playing on Death Sentence difficulty.",
				})
			end
			Maniac_str()
			
			local function Anarchist_str()
				LocalizationManager:add_localized_strings({
					menu_deck15_1_desc = "Instead of fully regenerating armor when out of combat, The Anarchist will continuously regenerate armor throughout the entire combat. Heavier armor regenerates less armor, but with shorter intervals.\nYou can view specific values in armor descriptions.\n\nWhen your armor gets depleted you will be immune to health damage for ##2## seconds. This cannot occur more often than once every ##15## seconds.\n\nNote: Skills that increase armor recovery rate are disabled when using this perk deck.",
					menu_deck15_9_desc = "Dealing damage will grant you a few points of armor - this ability can only occur once every few seconds. Heavier armor regenerates less armor, but has shorter cooldown for this effect.\nYou can view specific values in armor descriptions.\n\nDeck Completion Bonus: Your chance of getting a higher quality item during a Payday is increased by ##10%##.",
					-- armor description for blackmarket UI
					bm_menu_anarchist_armor_desc = "Anarchist Perk Deck:\nPassive armor regeneration: $amount_1; points every $amount_2; seconds;\nArmor regeneration on dealt damage: $amount_3; armor points every $amount_4; seconds",
					-- short descs
					menu_deck15_1_short = "Instead of fully regenerating armor when out of combat, The Anarchist will continuously regenerate armor throughout the entire combat. Heavier armor regenerates less armor, but during shorter intervals. When your armor gets depleted you will be immune to health damage for ##2## seconds. This cannot occur more often than once every ##15## seconds.",
					menu_deck15_9_short = "Dealing damage will grant you a few points of armor - this ability can only occur once every few seconds. Heavier armor regenerates less armor, but has shorter cooldown for this effect. You can view specific values in armor descriptions.",
				})
			end
			Anarchist_str()
			
			local function Biker_str()
				LocalizationManager:add_localized_strings({
					menu_deck16_1_desc = "You gain ##5%## more armor and ##10%## more health.\n\nEvery time you or your crew performs a kill, 1 Stack of Regeneration can be received. When received, Stack of Regeneration instantly restores ##5## health and ##5## armor and then activates it's ##4## second cooldown, after which this stack will be removed.\n\nYou have a maximum of ##4## Stack of Regeneration slots. New Stacks of Regeneration can not be added if your Stack of Regeneration slots are full. New Stacks of Regeneration will not be added if both your armor and health are full.\n\nWhile you have any amount of armor remaining, upon receiving a Stack of Regeneration, you will also receive a ##1## second Overstack Prevention cooldown.\nWhile Overstack Prevention cooldown is active, you can not receive additional Stacks of Regeneration unless your armor is completely broken.",
					menu_deck16_3_desc = "Every ##10%## health missing will increase the amount of armor gained from a single Stack of Regeneration by ##1##.",
					menu_deck16_5_desc = "Every ##10%## health missing will reduce the ##4## second cooldown that Stack of Regeneration has before it's removed by ##0.1## seconds.\n\nEvery ##10%## health missing will reduce the ##1## second Overstack Prevention cooldown by ##0.025## seconds.",
					menu_deck16_7_desc = "Every ##10%## armor missing will increase the amount of health gained from a single Stack of Regeneration by ##1##.",
					menu_deck16_9_desc = "Every ##10%## armor missing will reduce the ##4## second cooldown that Stack of Regeneration has before it's removed by ##0.1## seconds.\n\nEvery ##10%## armor missing will reduce the ##1## second Overstack Prevention cooldown by ##0.025## seconds.\n\nDeck Completion Bonus: Your chance of getting a higher quality item during a Payday is increased by ##10%##.",
				})
			end
			Biker_str()
			
			local function Kingpin_str()
				LocalizationManager:add_localized_strings({
					menu_deck17_1_desc = "Unlocks and equips the Kingpin Injector.\n\nChanging to another perk deck will make the Injector unavailable again. The Injector replaces your current throwable, is equipped in your throwable slot and can be switched out if desired.\n\nWhile in game you can use throwable key ##$BTN_ABILITY;## to activate the Injector.\n\nActivating the injector will heal you with ##75%## of all damage taken for ##6## seconds.\n\nYou can still take damage during the effect. The Injector can only be used once every ##30## seconds.\n\nKilling an enemy reduces The Injector cooldown by ##1## second.",
					menu_deck17_9_desc = "You gain ##40%## more health.\n\nFor every ##50## points of health gained during the injector effect while at maximum health, the recharge time of the injector is reduced by ##1## second.\n\nDeck Completion Bonus: Your chance of getting a higher quality item during a Payday is increased by ##10%##.",
					-- short descs
					menu_deck17_1_short = "Unlocks and equips the Kingpin Injector, replacing your current throwable. The injector will heal you with ##75%## of all damage taken for ##6## seconds. The Injector can only be used once every ##30## seconds. Killing an enemy reduces The Injector cooldown by ##1## second.",
					menu_deck17_9_short = "You gain ##40%## more health. For every ##50## points of health gained during the injector effect while at maximum health, the recharge time of the injector is reduced by ##1## second.",
				})
			end
			Kingpin_str()
			
			local function Sicario_str()
				LocalizationManager:add_localized_strings({
					menu_deck18_1_desc = "Unlocks and equips the throwable Smoke Bomb.\n\nChanging to another perk deck will make the Smoke Bomb unavailable again. The Smoke Bomb replaces your current throwable, is equipped in your throwable slot and can be switched out if desired.\n\nWhile in game you can use throwable key ##$BTN_ABILITY;## to deploy the Smoke Bomb.\n\nWhen deployed, the smoke bomb creates a smoke screen that lasts for ##10## seconds. While standing inside the smoke screen, you and any of your allies automatically avoid ##50%## of all bullets. Any enemies that stand in the smoke will see their accuracy reduced by ##50%##.\n\nAfter the smoke screen dissipates, the Smoke Bomb is on a cooldown for ##45## seconds, but killing enemies will reduce this cooldown by ##1## second.",	
					-- short descs
					menu_deck18_1_short = "Unlocks and equips the throwable Smoke Bomb, replacing your current throwable. When deployed, the smoke bomb creates a smoke screen that lasts for ##10## seconds. While standing inside the smoke screen, all players avoid ##50%## of all bullets. Enemies standing in the smoke will see their accuracy reduced by ##50%##. Smoke Bomb requires a cooldown of ##40## seconds, but killing enemies will reduce this cooldown by ##1## second.",
				})
			end
			Sicario_str()
			
			local function Stoic_str()
				LocalizationManager:add_localized_strings({
					menu_deck19_1_desc = "Unlocks and equips the Stoic Hip Flask.\n\nChanging to another perk deck will make the Stoic Hip Flask unavailable again. The Stoic Hip Flask replaces your current throwable, is equipped in your throwable slot and can be switched out if desired.\n\nDamage taken is now reduced by ##70%##. The remaining damage will be applied directly.\n\nThe ##70%## reduced damage will be applied over-time (##10## seconds) instead.\n\nYou can use the throwable key ##$BTN_ABILITY;## to activate the Stoic Hip Flask and immediately negate any pending damage. The flask has a ##10## second cooldown, but time remaining will be lessened by ##1## second per enemy killed.",
					menu_deck19_7_desc = "When your health is below ##45%##, the cooldown of your flask will be reduced by ##1.5## seconds for each enemy you kill instead of ##1## second.",
					menu_deck19_9_desc = "When damage-over-time is removed you will be healed for an additional ##60%## of the damage-over-time remaining at that point.\n\nDeck Completion Bonus: Your chance of getting a higher quality item during a Payday is increased by ##10%##.",
					-- short descs
					menu_deck19_1_short = "Unlocks and equips the Stoic Hip Flask, replacing your current throwable. Damage taken is now reduced by ##70%## and reduced damage will be applied over-time (##10## seconds). Stoic Hip Flask immediately negates any pending damage when used. The flask has a ##10## second cooldown, but time remaining will be lessened by ##1## second per enemy killed.",
					menu_deck19_7_short = "When your health is below ##45%##, the cooldown of your flask will be reduced by ##1.5## seconds for each enemy you kill instead of ##1## second.",
					menu_deck19_9_short = "When damage-over-time is removed you will be healed for an additional ##60%## of the damage-over-time remaining at that point.",
				})
			end
			Stoic_str()
			
			local function TagTeam_str()
				LocalizationManager:add_localized_strings({
					menu_deck20_1_desc = "Unlocks and equips the Gas Dispenser.\n\nChanging to another perk deck will make the Gas Dispenser unavailable again. The Gas Dispenser replaces your current throwable, it can be switched out if desired.\n\nTo activate the Gas Dispenser you need to look at another allied unit within a ##24## meter radius and press the throwable key ##$BTN_ABILITY;## to tag them.\n\nEach enemy you or the tagged unit kills will now heal you for ##15## health and the tagged unit for ##7.5## health.\n\nEach enemy you kill will now extend the duration by ##1.7## seconds and reduce the cooldown timer by ##2## seconds.\n\nThe effect will last for a duration of ##12## seconds and has a cooldown of ##60## seconds.",
					menu_deck20_5_desc = "Each enemy you or the tagged unit kills will now grant you ##4## absorption up to a maximum of ##32##.\n\nThis effect will last until the perk deck item goes out of cooldown.",
					-- short descs
					menu_deck20_1_short = "Unlocks and equips the Gas Dispenser, replacing your current throwable. To activate, you need to look at another allied unit within a ##24## meter radius and press the throwable key ##$BTN_ABILITY;## to tag them. Each enemy you or the tagged unit kills will now heal you for ##15## health and the tagged unit for ##7.5## health. Your kills will extend the duration of the effect by ##1.7## seconds and reduce the cooldown timer by ##2## seconds. The effect will last for a duration of ##12## seconds and has a cooldown of ##60## seconds.",
					menu_deck20_5_short = "Each enemy you or the tagged unit kills will now grant you ##4## absorption up to a maximum of ##32##. This effect will last until the perk deck item goes out of cooldown.",
				})
			end
			TagTeam_str()
			
			local function Hacker_str()
				LocalizationManager:add_localized_strings({
					menu_deck21_1_desc = "Unlocks and equips the Pocket ECM Device.\n\nChanging to another perk deck will make the Pocket ECM Device unavailable again. The Pocket ECM Device replaces your current throwable, it can be switched out if desired.\n\nWhile in game you can use the throwable key ##$BTN_ABILITY;## to activate the Pocket ECM.\n\nActivating the Pocket ECM Device before the alarm is raised will trigger the jamming effect, disabling all electronics and pagers for a ##6## second duration.\n\nActivating the Pocket ECM Device after the alarm is raised will trigger the feedback effect, granting a chance to stun enemies on the map every second for a ##12## second duration.\n\nThe Pocket ECM Device has ##2## charges with a ##140## second cooldown timer, but each kill you perform will shorten the cooldown timer by ##4## seconds.",
					menu_deck21_5_desc = "Killing an enemy while the feedback effect is active will regenerate ##40## health.\nYour chance to dodge is increased by ##15%##.",
					menu_deck21_7_desc = "Killing at least ##3## enemies while the feedback or jamming effect is active will grant ##20## dodge for ##50## seconds.",
					-- short descs
					menu_deck21_1_short = "Unlocks and equips the Pocket ECM.",
					menu_deck21_5_short = "Killing an enemy while the feedback effect is active will regenerate ##40## health. Your chance to dodge is increased by ##15%##.",
					menu_deck21_7_short = "Killing at least ##3## enemies while the feedback or jamming effect is active will grant ##20## dodge for ##50## seconds.",
				})
			end
			Hacker_str()
			
			local function Leech_str()
				LocalizationManager:add_localized_strings({
					menu_deck22_1_desc = "Unlocks and equips the Leech Ampule. The Leech Ampule replaces your current throwable, is equipped in your throwable slot and can be switched out if desired. While in game you can use throwable key ##$BTN_ABILITY;## to activate the Leech Ampule.\nThe Leech Ampule lasts ##6## seconds with a ##60## seconds cooldown.\nIf you revive a teammate while the Leech Ampule is active, you will fully recover your health and armor after the Leech Ampule effect ends.\nIf you go down while your Leech Ampule cooldown is lower than ##30## seconds, the cooldown will be increased to ##30## seconds.\n\nActivating the Leech Ampule will restore ##50%## health and disable your armor for the duration of the Leech Ampule. While the Leech Ampule is active your health is divided into segments of ##25%## and damage taken from enemies removes one segment. Taking a hit that deals over 150 damage will remove two segments at once.\nUpon losing a segment all damage taken is blocked for ##0.5## seconds. If you secure a kill during this period, you will recover 1 lost segment - this can only occur once during a single invulnerability period. When you recover a segment this way your teammates are also healed for ##5%## of their health. For every additional Leech player on your team, this team heal bonus is reduced by ##25%##.",
					menu_deck22_3_desc = "Your maximum health is increased by ##20%##.\n\nWhile the Leech Ampule is active you cannot go into bleedout, but being out of health makes you go into \"Last Breath\" state which will slow you down by ##80%##.\n\nIf Leech Ampule effect ends, while you are in the Last Breath state, you will automatically go down, unless you have revived a teammate during the Leech Ampule effect duration.\n\nHealing yourself during the invulnerability period you receive after losing a health segment, can prevent you from entering Last Breath state, even if you are out of health.\n\nEntering Last Breath state disables healing from skills, automatic revive from \"Uppers\" Aced skill, and your ability to heal from First Aid Kits and Doctor Bags.",
					menu_deck22_5_desc = "The Leech Ampule duration is increased to ##10## seconds.\n\nKilling an enemy reduces the cooldown of the Leech Ampule by ##1.5## second(s).\n\nRecovering health during invulnerability state now heals teammates for ##10%## of their health.",
					menu_deck22_9_desc = "You can now activate Leech Ampule while downed, temporarily reviving you until the end of the Leech Ampule.\nIf, after reviving yourself with the Leech Ampule, you successfully use a doctor bag before the effect ends, you may stay alive if you are above 0 health.\nIf, after reviving yourself with the Leech Ampule, you successfully revive a teammate before the effect ends, you will stay alive after effect ends.\n\nWhile the Leech Ampule is active your health is now divided into segments of ##12.5%##.\n\nDeck Completion Bonus: Your chance of getting a higher quality item during a Payday is increased by ##10%##.",
					-- short descs
					menu_deck22_1_short = "Unlocks and equips the Leech Ampule throwable, which will restore ##50%## health, disable your armor, and divide your health into segments. Taking damage removes one segment. Hits worth over 150 damage will remove two segments. When segment is removed you gain ##0.5## seconds of invulnerability. If you secure a kill during this period you will restore ##1## health segment and heal your teammates for ##5%## of their health. The Leech Ampule lasts ##6## seconds with a ##60## seconds cooldown.",
					menu_deck22_5_short = "The Leech Ampule duration is increased to ##10## seconds. Killing an enemy reduces the cooldown of the Leech Ampule by ##1.5## second(s). Recovering health segments now heals teammates by ##10%## of their health.",
					menu_deck22_9_short = "You can now activate Leech Ampule while downed, temporarily reviving you.",
				})
			end
			Leech_str()
			
			local function Copycat_str()
				LocalizationManager:add_localized_strings({
					menu_deck23_3_desc = "Each headshot you land heals ##10## health points.\nThis cannot occur more than once every ##2## seconds.\n\nIf you have \"Bullseye\" Aced skill equipped, you will regenerate ##7.5## health points per headshot with a cooldown of ##1.5## seconds instead.",
					menu_deck23_7_desc = "If you receive damage that brings your health below ##50%##, you will gain health damage immunity for ##2## seconds.\n\nYou will still receive damage from the triggering hit, but this hit can not bring you bellow ##1## health.\nThis skill will only trigger when you have no armor.\nThis skill cannot occur more often than once every ##20## seconds.",
					menu_deck23_1_1_desc = "Your maximum health is increased by ##15%##.",
					menu_deck23_3_1_desc = "Your maximum health is increased by ##15%##.",
					menu_deck23_5_1_desc = "Your maximum health is increased by ##15%##.",
					menu_deck23_7_1_desc = "Your maximum health is increased by ##15%##.",
					menu_deck23_1_4_desc = "Your crouched and carry movement speed is increased by ##10%##. Your total ammo capacity is increased by ##7.5%##.",
					menu_deck23_3_4_desc = "Your crouched and carry movement speed is increased by ##10%##. Your total ammo capacity is increased by ##7.5%##.",
					menu_deck23_5_4_desc = "Your crouched and carry movement speed is increased by ##10%##. Your total ammo capacity is increased by ##7.5%##.",
					menu_deck23_7_4_desc = "Your crouched and carry movement speed is increased by ##10%##. Your total ammo capacity is increased by ##7.5%##.",
					-- 9th card bonuses
					menu_deck23_9_crew_chief_desc = "You grant ##8%## damage reduction for players in your group. This bonus is doubled for you when you are under ##50%## health.\n\nYou and your crew's stamina is increased by ##50%##.\n\nWhile trying to intimidate a law enforcer or a civilian, marking a special enemy, or using Inspire skill on your teammates, your shout distance is increased by ##25%##.\n\nWhile you are within ##18m## of an enemy that you can see, you receive a ##8%## damage reduction. This damage reduction lingers for ##5## seconds after you are no longer close to an enemy.\nNote: Crew perks do not stack.",
					menu_deck23_9_muscle_desc = "You gain an additional ##20%## more health.\n\nYou regenerate ##1.5%## of your health every ##5## seconds.\n\nWhile playing on Death Sentence difficulty your passive health regeneration is increased to ##2.5%## every ##5## seconds.",
					menu_deck23_9_armorer_desc = "You gain ##10%## more armor.\n\nWhen your armor gets depleted you will be immune to health damage for ##2## seconds. This cannot occur more often than once every ##30## seconds.",
					menu_deck23_9_rogue_desc = "Your chance to dodge is increased by ##20%##.\n\nYour chance to dodge while crouched is increased by ##5%##.",
					menu_deck23_9_hitman_desc = "Securing a kill with a melee weapon or a throwable non-explosive weapon regenerates ##25%## of your armor. This can not happen more often than once every ##1## seconds.\n\nStability penalty that your akimbo weapons have is reduced by ##8##.\nAmmo capacity for your akimbo weapons is increased by ##50%##.\n\nKilling an enemy using a pistol, SMG or an akimbo weapon grants you ##25%## faster armor recovery rate for ##10## seconds. If you secure a kill with a pistol, SMG or akimbo weapon while this skill is already active, skill duration timer we be refreshed.",
					menu_deck23_9_crook_desc = "Your chance to dodge is increased by ##5%## for ballistic vests.\n\nYour armor is increased by ##20%## for ballistic vests.\n\nYour chances to pierce enemy body armor are increased by ##75%##.",
					menu_deck23_9_burglar_desc = "Your chance to dodge is increased by ##10%## while using the Lightweight Ballistic Vest.\n\nYou gain ##2## concealment for each silenced weapon you equip.\n\nYou answer pagers ##25%## faster.\n\nStanding still and crouching decreases your chances to be targeted by ##10%##.",
					menu_deck23_9_infil_desc = "Your second and each consecutive melee hit within ##4## seconds of the last one will deal ##100%## more damage.\n\nStriking an enemy with your melee weapon regenerates ##20%## of your health. This cannot occur more than once every ##10## seconds.",
					menu_deck23_9_gambler_desc = "Ammo packs you pick up can sometimes yield medical supplies - when ammo pack is picked up, you roll your chances to get healed. This can not occur more often than once every ##4## seconds.\nOn pick up, you have a ##70%## chance to be healed for a random amount of health points: from ##16## to ##24##. If you succeed an additional ##20%## chance roll, you will get a jackpot and triple your earned health.\nOtherwise there is a ##15%## chance you will find poisonous medical supplies and will lose a random amount of health points: from ##32## to ##48##. If you succeed an additional ##10%## failure roll, you will get a failure jackpot and triple your lost health.\nLastly you have a ##15%## chance for this skill to do nothing, but go on cooldown.\n\nYour ammo box pick up range is increased by ##50%##.\nWhen you pick up ammo, you trigger an ammo pickup for ##50%## of normal pickup to other players in your team, but only once every ##4## seconds.\n\nNote: Gilza's perk UI will show you if this skill is on cooldown and if you get a positive or negative effect. If you get a jackpot, icon will flash.",
					menu_deck23_9_grinder_desc = "Damaging an enemy now heals ##2## life points every ##0.3## seconds for ##3## seconds.\n\nThis effect stacks but cannot occur more than once every ##1.5## seconds and only while wearing the Two-piece Suit or Lightweight Ballistic Vest.",
					menu_deck23_9_yakuza_desc = "The lower your health, the more movement speed you gain. When your health is below ##50%##, you will gain up to ##20%## movement speed.\n\nWhile your health is below ##50%## you are immune to armor suppression effect.\n\nNote: normally, armor suppression effect is applied to you whenever you are shot, regardless of if you are hit or not. If you get suppressed, your armor recovery timer will be set to it's maximum duration and additional ##1## second will be added from armor suppression effect to your total recovery timer. This addition is not affected by armor recovery or any other skills.\nArmor suppression immunity effect from this perk card reduces this timer extension to ##0.5## seconds, and also disables your armor recovery timer from resetting to it's maximum duration when you are being shot at, without getting hit.",
					menu_deck23_9_expres_desc = "While your armor is up, you will store ##8## health for every ##1## enemy you or your crew kills.\n\nWhen your armor regenerates after depletion, you will gain health equal to the stored health amount.\n\nMaximum amount of stored health depends on your equipped armor.\n\nYou gain ##10%## more health.",
					menu_deck23_9_maniac_desc = "##100%## of damage you deal is converted into Hysteria Stacks, up to ##120## every ##1.5## second. Max amount of stacks is ##600##.\n\nHysteria Stacks\nYou gain ##1## damage absorption for every ##30## stacks of Hysteria.\nIf you don't deal any damage for ##3## seconds, you will lose ##20% + 80## Hysteria Stacks.\n\nMembers of your crew also gain the effect of your Hysteria Stacks.\n\nHysteria Stacks from multiple crew members do not stack and only the stacks that gives the highest damage absorption will have an effect.",
					menu_deck23_9_anarchist_desc = "Instead of fully regenerating armor when out of combat, The Anarchist will continuously regenerate armor throughout the entire combat. Heavier armor regenerates less armor, but during shorter intervals.\nYou can view specific values in armor descriptions.\n\nWhen your armor gets depleted you will be immune to health damage for ##2## seconds. This cannot occur more often than once every ##40## seconds.\n\nNote: Skills that increase armor recovery rate are disabled when using this perk deck card.",
					menu_deck23_9_biker_desc = "Every time you or your crew performs a kill, 1 Stack of Regeneration can be received. When received, Stack of Regeneration instantly restores ##5## health and ##5## armor and then activates it's ##4## second cooldown, after which this stack will be removed.\n\nYou have a maximum of ##4## Stack of Regeneration slots. New Stacks of Regeneration can not be added if your Stack of Regeneration slots are full. New Stacks of Regeneration will not be added if both your armor and health are full.\n\nWhile you have any amount of armor remaining, upon receiving a Stack of Regeneration, you will also receive a ##1## second Overstack Prevention cooldown.\nWhile Overstack Prevention cooldown is active, you can not receive additional Stacks of Regeneration unless your armor is completely broken.",
					menu_deck23_9_leech_desc = "Unlocks and equips the Leech Ampule, replacing your current throwable. While in game you can use throwable key ##$BTN_ABILITY;## to activate the Leech Ampule.\nThe Leech Ampule lasts ##6## seconds with a ##60## seconds cooldown.\nIf you revive a teammate while the Leech Ampule is active, you will fully recover your health and armor after the Leech Ampule effect ends.\nIf you go down while your Leech Ampule cooldown is lower than ##30## seconds, the cooldown will be increased to ##30## seconds.\nActivating the Leech Ampule will restore ##50%## health and disable your armor for the duration of the Leech Ampule. While the Leech Ampule is active your health is divided into segments of ##25%## and damage taken from enemies removes one segment. Taking a hit that deals over 150 damage will remove two segments at once.\nUpon losing a segment all damage taken is blocked for ##0.5## seconds. If you secure a kill during this period, you will recover 1 lost segment - this can only occur once during a single invulnerability period. When you recover a segment this way your teammates are also healed for ##5%## of their health. For every additional Leech Ampule user on your team, this team heal bonus is reduced by ##25%##.",
					menu_deck23_9_brawler_desc = "You can now receive up to ##3## simultaneous armor regeneration effects from this perk card. If you have no regeneration effects active, you can activate one by securing a kill by any means. To achieve more simultaneous regeneration effects you need to secure kills with melee weapons or the OVE9000 Saw.\n\nArmor regeneration effect: regenerate ##25## points of armor over a period of ##6## seconds, with a \"tick\" of regeneration every ##0.75## seconds.\n\nTotal armor regeneration from one effect is increased to ##50## while playing on Death Sentence difficulty.\n\nNote: Gilza's perk UI will show you how many regeneration effects you currently have as \"1x\" text under the Brawler icon.",
					menu_deck23_9_junkie = "Speed Junkie",
					menu_deck23_9_junkie_desc = "You can now obtain up to ##100## adrenaline stacks by moving. Moving at high speeds will add adrenaline stacks to your meter - higher your speed, more stacks you gain. If you don't move quickly enough, your adrenaline stacks will begin to deplete.\n\nFor every adrenaline stack you have you gain a chance to dodge, up to ##40%## maximum dodge chance at ##100## stacks.\n\nIf you maintain ##90## or more stacks of adrenaline for longer than ##4## seconds you will become exhausted. Becoming exhausted completely depletes your stamina and some of your adrenaline stacks.\n\nYou can recover your armor only when you stand still.\n\nGilza's perk UI will show your current amount of adrenaline stacks, if you have too much adrenaline (red) and if you are exhausted (purple).",
					menu_deck23_9_guardian = "Guardian",
					menu_deck23_9_guardian_desc = "Your movement speed is reduced by ##20%##.\nAll interaction speeds, excluding player revives and pager answering, are now ##50%## slower.\n\nYou gain an ability to create a personal defensive area by standing perfectly still for ##5## seconds. This area has a ##3m## radius. If you stay outside of your defensive area for more than ##8## seconds, area will be removed. You would have to wait ##8## more seconds after your last area was removed before a new defensive area could be created.\n\nWhile standing inside of your defensive area you regenerate ##20## points of health every ##2## seconds.\n\nGilza's perk UI will show if you are currently inside of your defensive area (bright white) and if you have an active area, but you are not inside of it(faded out white).",
					-- short descs
					menu_deck23_7_short = "When your health gets below ##50%## you will be immune to health damage for ##2## seconds. This cannot occur more than once every ##20## seconds.",
				})
			end
			Copycat_str()
			
		end
		Perk_strings_vanilla()
		
		local function Perk_strings_custom()
			
			local function Brawler_str()
				LocalizationManager:add_localized_strings({
					menu_deck_brawler = "Brawler",
					menu_deck_brawler_desc = "Nothing brings more pleasure to you than bashing someone's nose in or slicing open thier aorta. Warmth of blood tickles something in your brain. You have finally decided to give in to your thoughts and got yourself an armor suit that does not seem to fit you perfectly well, but it sure is armored. It might need some tuning, and it may prevent you from equipping any sort of an ammo rig, but after you are done with it you will become the image of fearlessness and brutality.",
					menu_deck_brawler1 = "New armor suit",
					menu_deck_brawler1_desc = "Your ammo capacity and ammo pick up rate are reduced by ##80%##. Note that this reduction is applied after all other ammo related skills, as a ##0.2## multiplier, which means you can't effectively counter this effect with other skills.\nIf you are using bows or crossbows, you only have a ##20%## chance for bolts to return when you try to pick them up.\n\nYour second and each consecutive melee hit within ##4## seconds of the last one will deal ##100%## more damage.\n\nYour armor recovery rate is reduced by ##350%##.\n\nYour armor has ##5%## bullet damage resistance.",
					menu_deck_brawler3 = "Flexibility improvements",
					menu_deck_brawler3_desc = "Your armor now has ##5%## more bullet damage resistance.\n\nBody armor movement speed penalty is reduced by additional ##25%##.",
					menu_deck_brawler5 = "Armor plate upgrade",
					menu_deck_brawler5_desc = "Your armor can no longer be penetrated by armor piercing ammunition.\n\nYour armor now has ##10%## more bullet damage resistance.\n\nBody armor movement speed penalty is reduced by additional ##25%##.\n\nSecuring a kill with a melee weapon restores ##5%## of your stamina.",
					menu_deck_brawler7 = "Meat shield",
					menu_deck_brawler7_desc = "While you are under ##50%## health, you gain ##2.5%##  bullet damage resistance for your armor and ##3.5## damage absorption for every teammate within ##21m## from you. This bonus can stack up to ##3## times.\nEnemies converted by you count as teammates for this mechanic.\nWhile playing on Death Sentence difficulty, defensive bonuses from this perk card are increased to ##5%## damage resistance and ##7## damage absorption per teammate.\n\nYou are ##15%## more likely to be targeted when you are close to your crew members. All other skills that adjust your likelihood of being targeted are now ignored.\n\nNote: Gilza's perk UI will show you how many teammates you currently have around you: icon will be faded out for 0 players, colored white for 1, yellow for 2, and green for 3.",
					menu_deck_brawler9 = "Bloodlusty kevlar",
					menu_deck_brawler9_desc = "You can now receive up to ##3## simultaneous armor regeneration effects from this perk card. If you have no regeneration effects active, you can activate one by securing a kill by any means. To achieve more simultaneous regeneration effects you need to secure kills with melee weapons or the OVE9000 Saw.\n\nArmor regeneration effect: regenerate ##25## points of armor over a period of ##6## seconds, with a \"tick\" of regeneration every ##0.75## seconds.\n\nTotal armor regeneration from one effect is increased to ##100## while playing on Death Sentence difficulty.\n\nDeck Completion Bonus: Your chance of getting a higher quality item during a Payday is increased by ##10%##.\n\nNote: Gilza's perk UI will show you how many regeneration effects you currently have as \"1x\" text under the icon.",
					-- short descs
					menu_deck_brawler1_desc_short = "Your ammo capacity and pick up rate are reduced by ##80%##. Your armor recovery rate is reduced by ##350%##. Your armor gains bullet damage resistance. Your second and each consecutive melee hit within ##4## seconds of the last one will deal ##100%## more damage.",
					menu_deck_brawler3_desc_short = "Your armor has more bullet damage resistance and it's movement speed penalty is reduced.",
					menu_deck_brawler5_desc_short = "Your armor is now immune to the AP effect, it has more bullet damage resistance, and it's movement penalty is reduced even more. Melee kills restore stamina.",
					menu_deck_brawler7_desc_short = "You are more likely to be targeted when you are close to your crew members. While you are under ##50%## health, enemies will deal less damage to you, depending on amount of teammates in close proximity.",
					menu_deck_brawler9_desc_short = "Melee kills grant armor regeneration over a short time period.",
				})
			end
			Brawler_str()
			
			local function Speed_Junkie_str()
				LocalizationManager:add_localized_strings({
					menu_deck_SJ = "Speed Junkie",
					menu_deck_SJ_desc = "Stimulation... stimulation. Snort it. But you always need more. Swallow it. But there is never enough. Fill your veins with it. Yet you don't even notice it anymore?!?! Stimulation. Theres is only one way you can get some more.",
					menu_deck_SJ_1 = "Your solution",
					menu_deck_SJ_1_desc = "You can now obtain up to ##100## adrenaline stacks by moving. Moving at high speeds will add adrenaline stacks to your meter - higher your speed, more stacks you gain. If you don't move quickly enough, your adrenaline stacks will begin to deplete.\n\nFor every adrenaline stack you have you gain a chance to dodge, up to ##40%## maximum dodge chance at ##100## stacks.\n\nIf you maintain ##90## or more stacks of adrenaline for longer than ##4## seconds you will become exhausted. Becoming exhausted completely depletes your stamina and some of your adrenaline stacks.\n\nYou can recover your armor only when you stand still.\n\nYou convert ##90%## of your health to ##42%## of armor.\n\nGilza's perk UI will show your current amount of adrenaline stacks, if you have too much adrenaline (red) and if you are exhausted (purple).",
					menu_deck_SJ_3 = "Beyond all reason",
					menu_deck_SJ_3_desc = "Your chance to dodge is increased by ##15%##.\n\nYou restore ##5%## of your stamina for every kill you get.\n\nYou convert ##90%## of your health to ##46%## of armor.",
					menu_deck_SJ_5 = "Stimulation",
					menu_deck_SJ_5_desc = "Securing a kill adds ##10## stacks of adrenaline.\nSecuring a kill while your adrenaline stack amount is higher than ##90## will instead remove ##10## stacks of adrenaline.\n\nNew ability: adrenaline spike.\nWhile your adrenaline stack amount is over ##70## you gain ##1## adrenaline spike point every second. When your reach ##20## adrenaline spike points, you become eligible for an adrenaline spike. While you are eligible for an adrenaline spike you have a ##10%## chance to activate it by securing a kill by any means. Adrenaline spike overdoses your adrenaline stacks for ##8## seconds. After adrenaline spike is over you become exhausted and your adrenaline spike points are reset to ##0##.\n\nYou convert ##90%## of your health to ##52%## of armor.",
					menu_deck_SJ_7 = "Only one end",
					menu_deck_SJ_7_desc = "You gain ##15## points of armor when you dodge. If you have no armor remaining, you will receive ##45## armor points instead. This can not occur more often than once every ##1## second.",
					menu_deck_SJ_9 = "Overdose",
					menu_deck_SJ_9_desc = "You can gain up to ##25%## more movement speed if your armor is damaged - lower your armor percentage is, higher the movement speed.\n\nAdrenaline stacks will now provide additional bonuses that scale with amount of adrenaline stacks, this includes:\n- Up to ##40%## faster weapon reload speed\n- Up to ##100%## faster weapon swap speed\n- Up to ##40%## faster interaction speeds, excluding pager answers and crew member revives.\n\nDeck Completion Bonus: Your chance of getting a higher quality item during a Payday is increased by ##10%##.",
					-- short descs
					menu_deck_SJ_1_desc_short = "Unlocks adrenaline stacks, earned for quick movement. Stacks provide up to ##40%## dodge. You can recover your armor only when you stand still. Convert ##90%## health for ##42%## armor.",
					menu_deck_SJ_3_desc_short = "Gain ##15%## dodge. Kills refill ##8%## stamina. Convert ##90%## health for ##46%## armor.",
					menu_deck_SJ_5_desc_short = "Kills provide ##10## adrenaline stacks. Convert ##90%## health for ##52%## armor. New ability: adrenaline spike.",
					menu_deck_SJ_7_desc_short = "Dodging provides ##15-45## points of armor once every ##1## second.",
					menu_deck_SJ_9_desc_short = "Move up to ##25%## faster lower your armor percentage is. Adrenaline stacks now provide faster reload, interaction and weapon swap speeds.",
				})
			end
			Speed_Junkie_str()
			
			local function Guardian_str()
				LocalizationManager:add_localized_strings({
					menu_deck_Gilza_guardian = "Guardian",
					menu_deck_Gilza_guardian_desc = "Guardian. A true defender.\nAll the heisting experience you've gathered over the years led you to a simple, yet truthful conclusion - the better you can defend that \"broke dick piece of shit drill\", the faster you will get to the riches that it's trying to uncover. And now that you have learned all the defensive techniques you could, you have become THE wall. No match for any force that tries to move you. If only you did not forget a few things along the way...",
					menu_deck_Gilza_guardian_1 = "Hunkering down",
					menu_deck_Gilza_guardian_1_desc = "Your movement speed is reduced by ##20%##.\nAll interaction speeds, excluding player revives and pager answering, are now ##50%## slower.\n\nWhile in game, you will have ##0## armor.\n\nYou gain an ability to create a personal defensive area by standing perfectly still for ##5## seconds. This area has a ##3m## radius. If you stay outside of your defensive area for more than ##8## seconds, area will be removed. You would have to wait ##8## more seconds after your last area was removed before a new defensive area could be created.\n\nWhile standing inside of your defensive area you regenerate ##10## points of health every ##2## seconds.\n\nGilza's perk UI will show if you are currently inside of your defensive area (bright white) and if you have an active area, but you are not inside of it(faded out white).",
					menu_deck_Gilza_guardian_3 = "Personal limits",
					menu_deck_Gilza_guardian_3_desc = "While inside of your defensive area you can not receive more than ##160## damage per hit, but you also can not receive less than ##80## damage per hit.\nWhile outside of your defensive area you can not receive more than ##200## damage per hit, but but you also can not receive less than ##100## damage per hit.\n\nYou gain ##100%## extra health.\n\nYou now regenerate ##20## points of health every ##2## seconds while inside of your defensive area.",
					menu_deck_Gilza_guardian_5 = "I am the wall afterall",
					menu_deck_Gilza_guardian_5_desc = "You gain ##150%## more health.\n\nSecuring a kill by any means while inside of the defensive area heals you for ##20## points of health. Healing amount is ##doubled## while playing on Death Sentence difficulty.\n\nYou now regenerate ##30## points of health every ##2## seconds while inside of your defensive area.\n\nYour defensive area now has a range of ##5m##.\n\nDoctor bags and first aid kits can now heal you only for ##50%## of your health.",
					menu_deck_Gilza_guardian_7 = "Porcupine",
					menu_deck_Gilza_guardian_7_desc = "For every ##10## armor points your equipped armor has, you gain a ##3%## chance for any bullet damage to be mirrored back at the target who damaged you.\n\nIt now only takes ##3## seconds of standing still to activate a defensive area.",
					menu_deck_Gilza_guardian_9 = "Best defense...",
					menu_deck_Gilza_guardian_9_desc = "If you have no active defensive area, and area's re-activation cooldown has ended, you can create a defensive area at your position by securing a kill.\n\nWhile inside of your defensive area you will automatically pick up ammo boxes from any enemy you kill.*\n\nWhile inside of your defensive area you can not receive more than ##120## damage per hit, but you also can not receive less than ##60## damage per hit.\nWhile outside of your defensive area you can not receive more than ##160## damage per hit, but you also can not receive less than ##80## damage per hit.\n\nDeck Completion Bonus: Your chance of getting a higher quality item during a Payday is increased by ##10%##.\n\n*Gilza note: due to the way this feature is implemented, while playing as a client, you may have a delay of up to 3 seconds (depends on ping) before ammo from the kill is picked up.",
					-- short descs
					menu_deck_Gilza_guardian_1_desc_short = "Your movement and interaction speeds are reduced and you lose all of your armor. You gain an ability to create a personal defense area that allows you to regenerate health.",
					menu_deck_Gilza_guardian_3_desc_short = "Any damage you receive will be clamped to specific amounts, making you take more damage while outside of your defensive area. You gain more health and more health regeneration while inside the defensive area.",
					menu_deck_Gilza_guardian_5_desc_short = "You gain more health, health regeneration, and an ability to be healed from kills while inside of your defensive area.",
					menu_deck_Gilza_guardian_7_desc_short = "You can now automatically mirror back damage at enemies, higher armor provides higher chances.",
					menu_deck_Gilza_guardian_9_desc_short = "You automatically pick up ammo from your kills while inside of the defensive area. You receive slightly less clamped damage.",
			})
			end
			Guardian_str()
			
		end
		Perk_strings_custom()
		
		local function Skill_strings()
			
			local function Mastermind_str()
				LocalizationManager:add_localized_strings({
					-- M1
					menu_combat_medic_beta_desc = "BASIC: ##$basic;##\nYou gain a ##25%## damage reduction for ##5## seconds both after and during reviving another player.\n\nACE: ##$pro;##\nReviving a crew member restores ##35%## of your maximum armor.\n\nIf you have Stoic or Guardian perk deck equiped, and upgraded to the level that completely removes your armor, you restore ##35%## of your maximum health instead.\n\nThis skill does not apply to ACED Inspire skill.",
					menu_inspire_beta_desc = "BASIC: ##$basic##\nYou revive crew members ##100%## faster. Shouting at your teammates grants both you and your teammate a morale boost for ##10## seconds. This boost increases movement and reload speed by ##20%## for your teammate, and by ##10%## for you.\n\nACE: ##$pro##\nThere is a ##100%## chance that you can revive crew members at a distance of up to ##9## meters by shouting at them. This cannon occur more than once every ##20## seconds.",
					-- M2
					menu_triathlete_beta_desc = "BASIC: ##$basic;##\nIncreases your supply of cable ties by ##4##. You can cable tie hostages ##75%## faster.\n\nYou and your crew gain ##0.5## damage absorption for each hostage you have. This effect stacks with up to a maximum of ##8## hostages.\n\nNote: This skill does not stack with other players Forced Friendship skill.\n\nACE: ##$pro;##\nYou can convert a non-special enemy to fight on your side.\nThis can not be done during stealth and the enemy must have surrendered in order for you to convert them.\nYou can only convert one non-special enemy at a time.",
					menu_joker_beta_desc = "BASIC: ##$basic;##\nYour converted enemy's damage penalty of ##35%## is removed. The time to convert an enemy is reduced by ##65%##.\n\nACE: ##$pro;##\nYou can now have ##2## converted enemies at the same time.",
					menu_cable_guy_beta_desc = "BASIC: ##$basic;##\nThe power and range of your intimidation is increased by ##50%##\n\nACE: ##$pro;##\nCivilians are intimidated by the noise you make and remain intimidated ##50%## longer.",
					menu_stockholm_syndrome_beta_desc = "BASIC: ##$basic;##\nKilling a civilian grants you ##1.5## menace points. Killing a law enforcer after they have surrendered grants you ##0.25## menace points. You can not have more than ##4## menace points. Menace points are set to ##0## when you get into custody.\n\nWhen you kill an enemy, you have a ##10%## chance to cause enemies in a ##10m## radius around you to panic. Panic can make enemies go into short bursts of uncontrollable fear.\nYour menace points increase your panic spread chances by ##10%## for ##1## full point, and increase amount of panic caused, raising chances for enemies to panic for longer.\n\nACE: ##$pro;##\nYour hostages will not flee when they have been rescued by law enforcers. Whenever you get into custody, your hostages will trade themselves for your safe return. This effect can occur during assaults, but only ##1## time during a single heist day.",
					-- M3
					menu_stable_shot_beta_desc = "BASIC: ##$basic##\nYou gain ##4## weapon Accuracy.\n\nACE: ##$pro##\nYou gain ##12## more weapon Accuracy.",
					menu_rifleman_beta = "Designated Marksman",
					menu_rifleman_beta_desc = "BASIC: ##$basic##\nYour snap to zoom is ##100%## faster with all weapons.\n\nYour weapon zoom level is increased by ##0-2x## with all weapons. This bonus can be adjusted in Gilza's mod options.\n\nWhenever you start firing your weapon, first ##5## bullets fired gain additional ##15%## recoil reduction. Does not apply to Shotguns, Snipers and single shot fire mode Pistols.\n\nACE: ##$pro##\nWhile aiming down sights your movement speed is unhindered.\n\nInitital recoil reduction is increased to ##50%## and is now applied to first ##10## fired bullets.",
					menu_sharpshooter_beta = "Slow and Steady",
					menu_sharpshooter_beta_desc = "BASIC: ##$basic##\nYou gain ##7.5%## damage resistance while standing still or bipoded.\n\nACE: ##$pro##\nYou gain additional ##30%## damage resistance while bipoded.\nYour bipod deploy speed is increased by ##100%##.",
					menu_speedy_reload_beta = "Body economy",
					menu_speedy_reload_beta_desc = "BASIC: ##$basic##\nYour reload speed with SMGs, Assault Rifles and Sniper Rifles is increased by ##20%##.\n\nSecuring a bodyshot kill with an SMG, Assault Rifle or a Sniper Rifle in single shot fire mode, refills ##10%## of a standard ammo pick up for both of your weapons.\n\nACE: ##$pro##\nBodyshot kills in single shot fire mode now refill ##40%## of a standard ammo pick up.\n\nSecuring a bodyshot kill with an SMG, Assault Rifle or a Sniper Rifle in single shot fire mode, will increase reload speed with all weapons by ##7.5%##, stacking up to ##75%##. Securing a kill after a reload will reset this bonus to ##0%##.",
					menu_sniper_graze_damage_desc = "BASIC: ##$basic##\nWhenever your shot hits an enemy further than ##6m## away, all enemies in a ##80cm## radius around the bullet trajectory, will also receive grazing damage.\nGrazing damage is equal to your weapon's base damage + relevant damage increasing skills, multiplied by ##0.33##. Grazing damage is not affected by bonus headshot damage.\nEnemies killed by grazing damage count as bodyshot kills.\n\nThis skill can only be activated by Sniper Rifles, Assault Rifles and SMGs fired in single shot fire mode.\n\nACE: ##$pro##\nGrazing damage radius is increased to ##160cm##, and damage multiplier is increased to ##0.66##.",
				})
			end
			Mastermind_str()
			
			local function Enforcer_str()
				LocalizationManager:add_localized_strings({
					-- E1
					menu_underdog_beta_desc = "BASIC: ##$basic;##\nWhile you are surrounded by three or more visible enemies within ##18m## of you, you receive a ##10%## damage bonus. This bonus lingers for ##5## seconds after you are no longer surrounded.\n\nACE: ##$pro;##\nWhile you are surrounded by three or more visible enemies within ##18m## of you, you also receive a ##10%## damage reduction. This damage reduction lingers for ##5## seconds after you are no longer surrounded.\n\nNote: Does not apply to melee damage, throwables, grenade launchers or rocket launchers.",
					menu_shotgun_cqb_beta_desc = "BASIC: ##$basic##\nYour Shotgun reload speed is sped up by ##15%##.\n\nACE: ##$pro##\nYour Shotgun reload speed is sped up by ##50%## total.",
					menu_shotgun_impact_beta = "Shotgun expert",
					menu_shotgun_impact_beta_desc = "BASIC: ##$basic##\nYou gain ##125%## increased steel sight zoom speed when using shotguns.\nYou gain ##20%## better stability with all shotguns.\n\nACE: ##$pro##\nYou gain ##30%## more stability with all shotguns.\nYou gain ##30%## accuracy while aiming down sights with shotguns.",
					menu_far_away_beta = "BLAST AWAY",
					menu_far_away_beta_desc = "BASIC: ##$basic##\nEvery time you fire any Shotgun you get ##6.5%## chance to not consume any ammo.\n\nACE: ##$pro##\nYour chances to not consume any ammo increase to ##20%##.\n\nNote: This skill will prevent ammo from depleting both from your ammo reserves and your magazine.",
					menu_close_by_beta = "Fearmonger",
					menu_close_by_beta_desc = "BASIC: ##$basic##\nYou can now hip-fire with your Shotguns while sprinting.\n\nACE: ##$pro##\nIf you kill an enemy with a Shotgun that has more than ##35## threat, you have a ##75%## chance to cause enemies in a ##12m## radius around you to panic. Panic can make enemies go into short bursts of uncontrollable fear.\n\nKilling enemies during their bursts of fear fully restores your stamina and grants you ##25%## movement speed bonus for ##20## seconds.\n\nNote: Upon activation this skill creates a pop up notification. You can disable it in Gilza mod options.",
					menu_overkill_beta_desc = "BASIC: ##$basic##\nWhen you kill an enemy with a Shotgun or the OVE9000 portable saw, you receive an Overkill™ boost that lasts for ##30## seconds. While boost is active you receive ##40%## damage and ##50%## reload speed increase with Shotguns and OVE9000 saw.\n\nACE: ##$pro##\nOverkill™ bonuses now apply to all weapons. Skill must be activated using a Shotgun or the OVE9000 portable saw. Your weapon swap speed is increased by ##80%##\n\nNote: Does not apply to melee damage, throwables, grenade launchers or rocket launchers.",
					-- E2
					menu_show_of_force_beta_desc = "BASIC: ##$basic;##\nYou take ##40%## less damage while interacting with objects.\n\nACE: ##$pro;##\nIncreases the armor of all Ballistic vests by ##20##.",
					menu_pack_mule_beta_desc = "BASIC: ##$basic##\nFor each ##10## armor points, the bag movement penalty is reduced by ##1%##.\n\nACE: ##$pro##\nYou can sprint with any bag.",
					menu_iron_man_beta_desc = "BASIC: ##$basic;##\nIncreases the armor recovery rate for you and your crew by ##25%##.\n\nThis skill does not stack with other players Shock And Awe skill.\n\nACE: ##$pro;##\nEnables your weapons to have a chance to knock back Shield enemies when attacking them. Ranged weapons' knock back chance is increased the higher the total damage of the weapon is. Melee weapons' knock back chance is ##100%##.",
					menu_prison_wife_beta_desc = "BASIC: ##$basic;##\nYou regenerate ##5## armor for each successful headshot. This can not occur more than once every ##2## seconds.\n\nACE: ##$pro;##\nYour armor regeneration from this skill is increased to ##25##, and cooldown is decreased to ##1.5## seconds.",
					-- E3
					menu_ammo_2x_beta_desc = "BASIC: ##$basic;##\nEach ammo bag now contains ##50%## more ammunition.\n\nACE: ##$pro;##\nYou can now place ##2## ammo bags instead of just one.",
					menu_carbon_blade_beta_desc = "BASIC: ##$basic##\nReducing the wear down of the blades on enemies by ##50%##.\n\nACE: ##$pro##\nYou can now saw through shield enemies with your OVER9000 portable saw. When killing an enemy with the saw, you have a ##50%## chance to cause nearby enemies in a ##10## m radius to panic. Panic will make enemies go into short bursts of uncontrollable fear.\n\nYou can now gain ammunition for the saw from dropped ammo boxes. Saw ammo pick up can't be increased/decreased by other ammo pick up related skills.",
					menu_bandoliers_beta_desc = "BASIC: ##$basic##\nYour total ammo capacity is increased by ##25%##.\n\nACE: ##$pro##\nIncreases the amount of ammo you gain from ammo boxes by ##75%##. You also gain a base ##10%## chance to get a throwable from an ammo box. The base chance is increased by ##3% * x## (where x - throwable pick up multiplier) for each ammo box you pick up that does not contain a throwable. When a throwable has been found, the chance is reset to its base value.\n\nNotes:\nThis skill does not stack with the perk skill 'Walk-in Closet'.\nThrowable pick up multipliers are different for each throwable - you can find them under throwable descriptions.",
				})
			end
			Enforcer_str()
			
			local function Technician_str()
				LocalizationManager:add_localized_strings({
					-- T1
					menu_defense_up_beta_desc = "BASIC: ##$basic;##\nThe cost of deploying a sentry gun is reduced by ##10%##.\n\nACE: ##$pro;##\nYour sentry guns gain ##150%## increased health.\n\nYour sentry guns also have ##50%## more ammunition.",
					menu_sentry_targeting_package_beta = "Little helper",
					menu_sentry_targeting_package_beta_desc = "BASIC: ##$basic;##\nYour sentry guns gain a ##100%## increase in accuracy.\n\nYour sentry guns rotation speed is increased by ##150%##.\n\nACE: ##$pro;##\nYour sentry guns gain a protective shield.",
					menu_eco_sentry_beta = "Gun Oil",
					menu_eco_sentry_beta_desc = "BASIC: ##$basic;##\nRate of fire of your Assault Rifles, SMG's, and LMG's is increased by ##30##.\n\nACE: ##$pro;##\nRate of fire of your Assault Rifles, SMG's, and LMG's is now increased by ##150##.",
					menu_tower_defense_beta_desc = "BASIC: ##$basic;##\nYou can now carry ##3## extra sentry gun.\n\nACE: ##$pro;##\nYour sentry gun carry capacity is reduced by ##1##.\nIf your sentry gun is destroyed, you will be able to pick it back up, but any remaining ammo that sentry gun had will not return back to you.\n\nWhile standing within ##8m## of a sentry gun, you gain ##10%## damage resistance.\n\nIf your sentry gun gets a kill, you will receive ammo equal to ##25%## of one ammo box pick up. This bonus does not affect grenade pick up rates.\nEnemies killed by your sentry gun, will still drop ammo boxes you can come and collect at a standard pick up rate.",
					-- T2
					menu_hardware_expert_beta_desc = "BASIC: ##$basic;##\nYou fix drills and saws ##15%## faster. Decreases trip mine deploy time by ##20%##. Drills and saws are also silent. Civilians and guards must see the drill or saw in order to become alerted.\n\nACE: ##$pro;##\nYour drills and saws have a ##10%## chance to gain an ability to automatically restart after breaking. This chance is only rolled once per drill or saw, and lasts untill it has finished working. Automatic restart will occur a few seconds after the drill or saw breaks, regardless of why it broke.\n\nNote: Skill does not affect the OVE9000 saw.",
					menu_kick_starter_beta_desc = "BASIC: ##$basic;##\nYour drills and saws gain additional ##20%## chance to gain an ability to automatically restart after breaking. This chance is only rolled once per drill or saw, and lasts untill it has finished working. Automatic restart will occur a few seconds after the drill or saw breaks, regardless of why it broke.\n\nACE: ##$pro;##\nEnables the ability to reset a broken drill or saw with a melee attack. The ability has a ##50%## chance to fix the drill or saw. The ability can only be used once per time the drill or saw is broken.\n\nYou now fix drills and saws ##50%## faster.\n\nNote: Skill does not affect the OVE9000 saw.",
					menu_fire_trap_beta_desc = "BASIC: ##$basic;##\nYour trip mines now spread fire around the area of detonation for ##10## seconds in a ##4## meter diameter.\n\nACE: ##$pro;##\nIncreases the fire effect duration to ##30## seconds and increases the fire effect radius by ##75%##.",
					-- T3
					menu_steady_grip_beta_desc = "BASIC: ##$basic##\nYou gain ##4## weapon Stability.\n\nACE: ##$pro##\nYou gain ##12## more weapon Stability.",
					menu_heavy_impact_beta_desc = "BASIC: ##$basic##\nYour shots can now stagger all enemies except Bulldozers and Captain Winters. Your base stagger chance is ##5%##, which is then multiplied by the ##threat modifier##.\n\nACE: ##$pro##\nIncreases your base stagger chance to ##20%##.\n\nNote: Threat modifier scales with weapon's threat: having ##0## threat provides you a ##1x## multiplier, with up to ##3x## multiplier at ##40## or higher threat.",
					menu_fire_control_beta_desc = "BASIC: ##$basic##\nYour ##36## point recoil penalty while firing from the hip is removed.\n\nACE: ##$pro##\nYour ##28## point accuracy penalty while firing from the hip is removed.",
					menu_shock_and_awe_beta_desc = "BASIC: ##$basic;##\nYou can now hip-fire with your weapons while sprinting.\n\nACE: ##$pro;##\nKilling ##3## enemies with SMGs, LMGs, Assault Rifles or Special Weapons set on automatic fire mode will increase your next reload speed.\nReload speed bonus starts at ##35%##, and is increased by ##1%## for every bullet that you have fired before initiating the reload. First ##15## bullets you fire do not increase the reload speed bonus. Maximum bonus that you can get is ##125%##.\n\nNote: Skills that allow you to fire your weapon without depleting ammo, and basic 'Surefire' skill, are ignored when calculating bonus reload speed from fired bullets.",
					menu_fast_fire_beta_desc = "BASIC: ##$basic##\nYour SMGs, LMGs and Assault Rifles gain ##15## more bullets in their magazines. This does not affect the 'Lock n' Load' Ace skill.\n\nACE: ##$pro##\nYour chances to pierce enemy body armor are increased by ##25%##.\n\nIf your body armor piercing chance succeeds you will deal full damage to the enemy, but if your chance fails you would still be able to pierce enemy body armor, but damage from such piercing shot is reduced by ##50%##.",
					menu_body_expertise_beta_desc = "BASIC: ##$basic##\n##100%## from the bonus headshot damage is permanently applied to hitting enemies on the body. This skill does not apply to Bulldozers and Captain Winters.\nThis skill is only activated by SMGs, LMGs, Assault Rifles and Miniguns in automatic or burst fire mode, and also Bows, Crossbows and the OVE9000 saw.\n\nACE: ##$pro##\nHitting enemies on the body now grants ##125%## of the bonus damage from headshots.\n\nIf your body armor piercing chance fails, you would still be able to pierce enemy body armor, but damage from such piercing shot is reduced by ##50%##.\nNote: When combined with \"Surefire\" Aced, damage penalty from armor piercing shots triggered by unsuccessful AP rolls is effectievely reduced to 0.",
				})
			end
			Technician_str()
			
			local function Ghost_str()
				LocalizationManager:add_localized_strings({
					-- G1
					menu_jail_workout_beta = "Inside man",
					menu_jail_workout_beta_desc = "BASIC: ##$basic##\nYou gain access to additional insider assets.\n\nACE: ##$pro##\nYou can pick up items while in casing mode. You also gain ##30%## more value to items and cash that you pick up.",
					menu_asset_lock_additional_assets = "Requires the 'inside man' basic skill to unlock",
					menu_cleaner_beta_desc = "BASIC: ##$basic##\nYou gain ##1## additional body bag in your inventory. Also increases the body bag inventory space to ##3##.\nCleaning costs after killing a civilian is reduced by ##75%##.\n\nACE: ##$pro##\nYou gain the ability to place ##2## body bag cases.\nYou gain access to the body bag asset.",
					menu_asset_lock_buy_bodybags_asset = "Requires the 'cleaner' aced skill to unlock",
					menu_chameleon_beta = "Awareness",
					menu_chameleon_beta_desc = "BASIC: ##$basic##\nIncreases the time before you start getting detected by ##25%## while in casing mode. You can also mark enemies while in casing mode.\nYou gain access to the spotter and spycam assets.\n\nACE: ##$pro##\nYou gain the ability to automatically mark enemies within a ##10## meter radius around you after standing still for ##3.5## seconds while in stealth.",
					menu_asset_lock_buy_spotter_asset = "Requires the 'awareness' basic skill to unlock",
					-- G2
					menu_awareness_beta_desc = "BASIC: ##$basic##\nYou gain ##20%## increased speed when climbing ladders.\n\nYou gain ##20%## extra vertical and horizontal jump power.\n\nYou gain the ability to sprint in any direction.\n\nACE: ##$pro##\nYou gain ##1## lethal fall damage immunity charge. If you fall from a lethal height instead of going down you will consume a charge and survive. Lethal fall damage immunity charge can be replenished by using a doctor bag.\n\nRun and reload - you can reload your weapons while sprinting. You can cancel this reload by pressing your \"Fire Weapon\" keybind if your weapon's magazine is not empty.",
					menu_dire_need_beta = "Sneaky Bastard",
					menu_dire_need_beta_desc = "BASIC: ##$basic##\nYou gain a ##1%## dodge chance for every ##3## points of detection rate under ##35## up to ##10%##.\n\nACE: ##$pro##\nYou gain a ##1%## dodge chance for every ##1## point of detection rate under ##35## up to ##10%##.",
					menu_insulation_beta = "Backfire",
					menu_insulation_beta_desc = "BASIC: ##$basic##\nWhen your armor breaks, the first shot on every enemy will cause that enemy to stagger. This effect persists for ##2## seconds after your armor has recovered.\n\nACE: ##$pro##\nWhen tased, you are able to instantly free yourself from the taser by interacting with it within ##2## seconds of getting tased. After the ##2## seconds window expires, shock effect will be backfired onto taser automatically.\n\nIf you get tased by any means your bullets will become electrified for ##20## seconds allowing you to shock enemies, except for Bulldozers and Captain Winters, from any distance.",
					menu_jail_diet_beta = "Revitalized",
					menu_jail_diet_beta_desc = "BASIC: ##$basic##\nSuccessfully dodging while you have no armor remaining restores ##10## points of armor. This cannot occur more often than once every ##25## seconds.\n\nACE: ##$pro##\nArmor gain from this skill is increased to ##50## points.\nCooldown for this skill is reduced to ##10## seconds.",
					-- G3
					menu_silence_expert_beta_desc = "BASIC: ##$basic;##\nYou gain ##8## weapon stability and ##100%## snap to zoom speed increase with silenced weapons.\n\nYour chances to pierce enemy body armor are increased by ##15%## while using silenced weapons.\n\nACE: ##$pro;##\nYou gain ##12## weapon accuracy with silenced weapons.\n\nYour chances to pierce enemy body armor are increased by additional ##35%## while using silenced weapons.",
					menu_backstab_beta_desc = "BASIC: ##$basic;##\nYou gain a ##3%## critical hit chance for every ##3## points of detection rate under ##35## up to ##30%##.\n\nACE: ##$pro;##\nYou gain ##3%## critical hit chance for every ##1## point of detection rate under ##35## up to ##30%##.\n\nNotes: \n-Landing a critical hit multiplies your damage by ##2.25x##\n-Critical hits can't be triggered by Grenade Launchers",
					menu_unseen_strike_beta_desc = "BASIC: ##$basic;##\nIf, after taking damage, you avoid further incoming damage for ##6## or more seconds, by either taking cover or dodging, you become eligible for an Unseen Strike effect. If you take damage while eligible, you lose your eligibility.\n\nYou can only receive Unseen Strike effect if you are eligible for it, you currently don't have it, and at least ##6## seconds have past since previous Unseen Strike effect has ended.\n\nOn activation Unseen Strike increases your critical hit chance by ##35%## for ##6## seconds.\n\nACE: ##$pro;##\nThe critical hit chance duration is increased to ##18## seconds.\n\nNotes: \n-Landing a critical hit multiplies your damage by ##2.25x##\n-Critical hits can't be triggered by Grenade Launchers",
				})
			end
			Ghost_str()
			
			local function Fugitive_str()
				LocalizationManager:add_localized_strings({
					-- F1
					menu_equilibrium_beta_desc = "BASIC: ##$basic;##\nDecreases the time it takes to draw and holster pistols by ##33%##.\n\nACE: ##$pro;##\nDecreases the time it takes to draw and holster pistols by ##50%##.\n\nYou gain ##12## weapon accuracy with all pistols.",
					menu_dance_instructor_desc = "BASIC: ##$basic##\nYou gain ##20%## increased rate of fire with pistols.\n\nACE: ##$pro##\nYou reload all pistols ##33%## faster.",
					menu_gun_fighter_beta = "Trigger happy",
					menu_gun_fighter_beta_desc = "BASIC: ##$basic##\nEach successful pistol hit gives you a ##32%## increased accuracy bonus for ##6## seconds and can stack ##1## times.\n\nACE: ##$pro##\nEach successful pistol hit gives you a ##75%## damage boost for ##6## seconds and can stack ##1## times.",
					menu_expert_handling = "Double trouble",
					menu_expert_handling_desc = "BASIC: ##$basic##\nYour akimbo pistols receive following bonuses:\n - ##16## more stability\n - ##12## more accuracy\n - ##35%## faster reload speed\n - ##2x## faster weapon swap speed\n\nACE: ##$pro##\nYour akimbo SMGs now receive same bonuses.",
					menu_trigger_happy_beta = "Bottomless pockets",
					menu_trigger_happy_beta_desc = "BASIC: ##$basic##\nYou gain ##50%## more reserve ammunition with all Pistols and SMGs.\n\nACE: ##$pro##\nYou gain additional ##100%## reserve ammunition with all Pistols and SMGs.\n\nAll weapons in the secondary slot lose their ##30%## ammo pick up penalty.",
					-- F2
					menu_running_from_death_beta_desc = "BASIC: ##$basic;##\nYou reload and swap weapons ##100%## faster for ##30## seconds after being revived.\n\nACE: ##$pro;##\nYou move ##30%## faster for ##30## seconds after being revived.",
					menu_up_you_go_beta_desc = "BASIC: ##$basic##\nYou take ##30%## less damage for ##10## seconds after being revived.\n\nACE: ##$pro##\nYou receive additional ##30%## of your maximum health when revived.",
					menu_perseverance_beta_desc = "BASIC: ##$basic##\nInstead of getting downed instantly, you gain the ability to keep on fighting for ##4## seconds with a ##60%## movement penalty before going down.\nDoes not trigger on fall of fire damage.\n\nYour Swan Song speed penalty will be ignored for ##3## seconds, if at the moment of skill activation or at any point during it's duration, one of your crew members is downed.\n\nACE: ##$pro##\nIncreases Swan Song's duration to ##8## seconds.\n\nWhile the effect is active, ammunition will be depleted directly from your total ammo reserve, instead of your magazine, and any damage you deal is increased by ##50%##.",
					menu_pistol_beta_messiah_desc = "BASIC: ##$basic;##\nWhile in bleedout, you can revive yourself if you kill an enemy. You only have ##1## charge.\n\nYou gain near infinite health while in bleedout.\n\nACE: ##$pro;##\nYour messiah charge is replenished whenever you use a doctor bag.",
					-- F3
					menu_martial_arts_beta = "Tough Guy",
					menu_martial_arts_beta_desc = "BASIC: ##$basic##\nYou are ##50%## more likely to knock down enemies with a melee strike.\nYour camera shake when hit by a melee attack is reduced by ##30%##.\n\nACE: ##$pro##\nYou take ##50%## less damage from all melee attacks.\nYour camera shake when hit by a melee attack is now reduced by ##90%##.\nBecause of training.",
					menu_bloodthirst_desc = "BASIC: ##$basic##\nEvery kill you get will increase your next melee attack damage by ##20%##, up to a maximum of ##300%##. This effect gets reset when you kill an enemy with a melee attack.\n\nACE: ##$pro##\nWhenever you kill an enemy with a melee attack, you will gain a ##50%## increase in reload speed for ##10## seconds.",
					menu_steroids_beta = "Martial Arts",
					menu_steroids_beta_desc = "BASIC: ##$basic##\nYou can now sprint while using melee weapons.\n\nACE: ##$pro##\nYou charge your melee weapons ##100%## faster.",
					menu_drop_soap_beta_desc = "BASIC: ##$basic##\nWhen charging your melee weapon you will counter-attack enemies that try to strike you, damaging and knocking them down.\n\nCounter-attack damage is identical to your melee weapon's damage and scales with charge time.\n\nSuccessful counter-attacks instantly uneqiup your melee weapon.\n\nACE: ##$pro##\nYou gain the ability to counter-attack cloakers and their kicks.\nCounter-attacks will now deal ##doubled## damage.",
					menu_wolverine_beta_desc = "BASIC: ##$basic##\nYour melee damage is increased by ##50%##.\n\nIf your armor breaks while your health is below ##50%## you will gain ##50%## more melee damage for ##40## seconds.\n\nACE: ##$pro##\nIf your armor breaks while your health is below ##50%## you will gain ##100%## more damage with ranged weapons for ##30## seconds.\nIncreased ranged weapon damage has a ##10## second cooldown in-between activations, and it does not increase damage of Throwables, Grenade Launchers and Rocket Launchers.\n\nGilza note: entering berserker state will enable visual screen flash that indicates skill duration. You can customize or completely disable it in Gilza's mod options.",
				})
			end
			Fugitive_str()
			
		end
		Skill_strings()
		
		local function Weapon_strings()
		
			local function Vanilla_attachs_universal()
				LocalizationManager:add_localized_strings({
					bm_combined_gadget_module = "Combined module that includes both laser and flashlight.",
					bm_laser_gadget_module = "Laser module used for easier target acquisition while hip-firing.",
					bm_flashlight_gadget_module = "Flashlight for all the dark places you may find.",
					bm_menu_custom_plural = "Fire mode selectors",
				})
			end
			Vanilla_attachs_universal()
			
			local function Vanilla_attachs_individual()
				LocalizationManager:add_localized_strings({
					-- Assault rifle
					bm_wp_akm_b_standard_gold = "Standard AKM Gold Barrel",
					bm_wpn_fps_ass_g3_b_long_newname = "Standard Gewehr3 Long Barrel",
					bm_wpn_fps_upg_ass_m4_b_beowulf_newname = "M4 AP Kit",
					bm_wpn_fps_upg_ass_ak_b_zastava_newname = "AK AP Kit",
					bm_wp_famas_b_sniper_newname = "Famas AP Kit",
					wpn_fps_ass_shak12_body_vks_R = "ASh-12 AP Kit",
					bm_wpn_fps_shak12_upg_ap_kit_desc = "Allows you to penetrate shields, walls and enemy body armor.\nLimits your fire mode to single fire.\nAmmo pick up reduced by 50%.",
					bm_wpn_fps_ass_g3_b_sniper_newname = "G3 AP Kit",
					bm_wpn_fps_ass_g3_b_short_desc = "Close quarters assault kit.\nAmmo pick up increased to match new damage class.",
					bm_wpn_fps_upg_ar_ap_kit_desc = "Allows you to penetrate shields, walls and enemy body armor.\nAmmo pick up reduced by 50%.", -- used by all AR's that have AP kits instead of long barrels
					bm_m4_upg_fg_mk12_desc = "This set limits your fire mode to full auto.",
					
					-- Pistol mods
					bm_wpn_fps_pis_c96_b_long_newname = "C96 AP Kit",
					bm_wpn_fps_pis_c96_b_long_newdesc = "Allows you to penetrate shields, walls and enemy body armor.\nAmmo pick up reduced to compensate both new damage class and gained AP.",
					bm_wpn_fps_pis_type54_underbarrel_desc = "Underbarrel shotgun. Stats:\n -Damage: 660\n -Minimal shotgun damage multiplier: 1\n -Ammo pick up: 0.33-0.4, with Walk-in Closet perk skill.",
					bm_wpn_fps_pis_type54_underbarrel_slug_desc = "Underbarrel shotgun slug. Pierces shields, walls and enemy body armor. Increases damage range by 15%. Stats:\n -Damage: 660\n -Minimal shotgun damage multiplier: 1\n -Ammo pick up: 0.25-0.3, with Walk-in Closet perk skill.",
					bm_wpn_fps_pis_type54_underbarrel_ap_desc = "Underbarrel shotgun flechette. Pierces enemy body armor. Shoots 6 darts. Damage range increased by 40%. Stats:\n -Damage: 660\n -Minimal shotgun damage multiplier: 1\n -Ammo pick up: 0.29-0.36, with Walk-in Closet perk skill.",
					bm_wpn_fps_pis_x_type54_underbarrel_desc = "Underbarrel shotgun. Stats:\n -Damage: 330\n -Minimal shotgun damage multiplier: 1\n -Ammo pick up: 0.66-0.8, with Walk-in Closet perk skill.",
					bm_wpn_fps_pis_x_type54_underbarrel_slug_desc = "Underbarrel shotgun slug. Pierces shields, walls and enemy body armor. Increases damage range by 15%. Stats:\n -Damage: 330\n -Minimal shotgun damage multiplier: 1\n -Ammo pick up: 0.5-0.6, with Walk-in Closet perk skill.",
					bm_wpn_fps_pis_x_type54_underbarrel_ap_desc = "Underbarrel shotgun flechette. Pierces enemy body armor. Shoots 6 darts. Damage range increased by 40%. Stats:\n -Damage: 330\n -Minimal shotgun damage multiplier: 1\n -Ammo pick up: 0.58-0.72, with Walk-in Closet perk skill.",
					
					-- SMG mods
					bm_wpn_fps_smg_mp5_m_straight_R = "RIP rounds",
					bm_wpn_fps_smg_mp5_m_straight_R_desc = "Ammo pick up reduced to match new damage class.",
					bm_wp_coal_g_standard = "Standard Tatonka Grip",
					
					-- LMG mods
					wpn_fps_lmg_hcar_barrel_dmr_PEN = "Akron HC AP Kit",
					bm_wpn_fps_lmg_hcar_barrel_dmr_PEN_desc = "Allows you to penetrate shiels, body armor and walls.\nLimits weapon to single-fire mode.\nAmmo pick up reduced by 50%.",
					bm_wpn_fps_upg_lmg_kacchainsaw_underbarrel_flamethrower_desc = "Underbarrel flamethrower. Deals 25 direct damage with 2000 rate of fire. Has 25% chance to apply afterburn.\nAfterburn deals 100 damage over 2 seconds.\n\nReduces ammo pick up for LMG itself by 30%.",
					bm_wpn_fps_upg_lmg_kacchainsaw_conversionkit_desc = "Increases ammo pick up to match new damage class.",
					bm_wpn_fps_lmg_hcar_body_conversionkit_desc = "Increases ammo pick up to match new damage class.",
					bm_wp_hcar_barrel_standard = "Standard Akron HC Barrel",
					
					-- Shotgun mods
					bm_wpn_fps_upg_a_rip_desc_new = "Poisoned bullet that causes enemies to vomit uncontrollably, preventing them from making any actions.\n\nDeals 250 poison damage over 6 seconds.\nAmmo pick up reduced by 20%",
					bm_wpn_fps_upg_a_custom_desc_new = "12 pellets with stronger impact.\n\nPierces enemy body armor.\nDisables bonus damage from headshots.\nDamage range reduced by 25%.\nAmmo pick up reduced by 15%",
					bm_wpn_fps_upg_a_explosive_desc_new = "Fires one explosive charge that kills or stuns targets.\n\nDisables bonus damage from headshots.\nAmmo pick up reduced by 55%",
					bm_wpn_fps_upg_a_piercing_desc_new = "Peirces enemy body armor.\nDamage range increased by 25%.\n\nAmount of darts per shell - 5.\nAmmo pick up reduced by 15%",
					bm_wpn_fps_upg_a_slug_desc_new = "Fires a single lead slug that penetrates body armor, enemies, shields and walls.\n\nDamage range increased by 20%\nAmmo pick up reduced by 25%",
					bm_wpn_fps_upg_a_dragons_breath_desc_new = "Fires 8 pellets that go up in sparks and flames. Burns through shields and body armor.\n\nDeals 350 fire damage over 2.5 seconds.\nDamage range decreased by 20%.\nAmmo pick up reduced by 30%",
					wpn_fps_upg_ns_duck_desc = "Reduces vertical pellet spread to 50%, increases horizontal pellet spread to 225%",
					
					-- Flamethrower mods
					bm_wpn_fps_fla_mk2_mag_rare_desc = "Less direct firepower but more afterburn damage.\n50% chance to start afterburn damage that deals 720 damage over 3 seconds. This afterburn deals damage in smaller chunks but more times per second.\nBase flamethrower values for comparison: 20% chance for 300dmg over 2 seconds.\nAmmo pick up reduced by 60%",
					bm_wpn_fps_fla_mk2_mag_welldone_desc = "More direct firepower but less afterburn damage.\n10% chance to start afterburn damage that deals 150 damage over 1 second.\nBase flamethrower values for comparison: 20% chance for 300dmg over 2 seconds.\nAmmo pick up increased by 45%",
					
					-- Launcher mods
					bm_wpn_fps_upg_a_grenade_launcher_poison_default_desc = "Upon impact deals damage in a 6m radius, then creates a 6m wide gas cloud for 15 seconds. Enemies that come in contact with said cloud will vomit uncontrollably for 16 seconds, preventing them from making any other actions. Enemies receive 3.5 damage per second while poisoned.\n\nAmmo pick up reduced by 70%.",
					bm_wpn_fps_upg_a_grenade_launcher_poison_ms3gl_desc = "Upon impact deals damage in a 3m radius, then creates a 6m wide gas cloud for 15 seconds. Enemies that come in contact with said cloud will vomit uncontrollably for 16 seconds, preventing them from making any other actions. Enemies receive 3.5 damage per second while poisoned.\n\nAmmo pick up reduced by 85%.",
					bm_wpn_fps_upg_a_grenade_launcher_poison_ms3gl_CK_desc = "Upon impact deals damage in a 3m radius, then creates a 8m wide gas cloud for 15 seconds. Enemies that come in contact with said cloud will vomit uncontrollably for 16 seconds, preventing them from making any other actions. Enemies receive 3.5 damage per second while poisoned.\n\nAmmo pick up reduced by 85%.",
					bm_wpn_fps_upg_a_grenade_launcher_poison_underbarrel_desc = "Upon impact deals 860 damage in a 6m radius, then creates a 6m wide gas cloud for 15 seconds. Enemies that come in contact with said cloud will vomit uncontrollably for 16 seconds, preventing them from making any other actions. Enemies receive 3.5 damage per second while poisoned.\n\nAmmo pick up for the underbarrel launcher reduced by 70%.",
					bm_wpn_fps_upg_a_grenade_launcher_poison_arbiter_desc = "Upon impact deals damage in a 3m radius, then creates a 4m wide gas cloud for 15 seconds. Enemies that come in contact with said cloud will vomit uncontrollably for 8 seconds, preventing them from making any other actions. Enemies receive 7 damage per second while poisoned.\n\nAmmo pick up reduced by 85%.",
					bm_wpn_fps_upg_a_grenade_launcher_incendiary_desc = "Upon impact creates a fire field for 6 seconds. Enemies that walk through it, receive afterburn.\n\nAfterburn stats:\n -Duration: 6 seconds\n -Damage per second: 250\nWhile enemy is standing inside the fire field, they receive triple damage per second.\n\nAmmo pick up reduced by 50%.",
					bm_wpn_fps_upg_a_grenade_launcher_incendiary_ms3gl_desc = "Upon impact creates a fire field for 6 seconds. Enemies that walk through it, receive afterburn.\n\nAfterburn stats:\n -Duration: 6 seconds\n -Damage per second: 250\nWhile enemy is standing inside the fire field, they receive triple damage per second.\n\nAmmo pick up reduced by 75%.",
					bm_wpn_fps_upg_a_grenade_launcher_incendiary_arbiter_desc = "Upon impact creates a fire field for 3 seconds. Enemies that walk through it, receive afterburn.\n\nAfterburn stats:\n -Duration: 3 seconds\n -Damage per second: 250\nWhile enemy is standing inside the fire field, they receive triple damage per second.\n\nAmmo pick up reduced by 50%.",
					bm_wpn_fps_upg_a_grenade_launcher_electric_desc = "Upon impact creates a wider 8m electrical explosion. Enemies caught in the blast radius get stunned due to high-voltage electricity for 3-5 seconds.\nDamage scales with range more aggressively, which leads to enemies on the edge of the explosion radius to receiving minimal damage.\n\nAmmo pick up increased by 20%.",
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
			end
			Vanilla_attachs_individual()
			
			local function Custom_Gilza_attachs()
				LocalizationManager:add_localized_strings({
					bm_wpn_fps_upg_br_shtgn = "Breaching round",
					bm_wpn_fps_upg_br_shtgn_desc = "Fires a single slug round that allows you to breach everything that saw OVE9000 usually can. Also penetrates shield and body armor.\n\nDamage range decreased by 50%.\nAmmo pick up reduced by 20%.",
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
					bm_wpn_fps_upg_pis_mid_ap_rounds_lv_desc = "Pierce enemy shields and body armor.\nAmmo pick up reduced to compensate both new damage class and gained AP.\n",
					wpn_fps_upg_sub2000_250_dmg_kit = "9x19mm QuakeMaker",
					wpn_fps_upg_sub2000_250_dmg_kit_desc = "An 11.9 gram hollow-point bullet made entirely of lead in a lightweight case of steel.\n\nAmmo pick up reduced to match new damage class.",
					-- GL section
					bm_wp_upg_a_grenade_launcher_velocity = "High Velocity Round",
					bm_wp_upg_a_grenade_launcher_velocity_desc = "Fragmentation grenade with tripled projectile velocity. Reduces ammo pick up by 20%.\n\nNote: only works if you are the lobby host, otherwise acts like a normal grenade with normal ammo pick up.",
					bm_wp_upg_a_underbarrel_velocity_frag_desc = "Fragmentation round with tripled projectile velocity. Max damage: 1300. Reduces underbarrel ammo pick up by 20%.\n\nNote: only works if you are the lobby host, otherwise acts like a normal frag round with normal ammo pick up.",
					bm_menu_mag_limiter = "Mag Limiter",
					bm_menu_mag_limiter_plural = "Mag Limiters",
					bm_wp_wpn_fps_gre_ms3gl_ml_double_round = "2 round limit",
					bm_wp_wpn_fps_gre_ms3gl_ml_double_round_desc = "Limits weapon to double round bursts by limiting mag capacity to 2.",
					bm_wp_wpn_fps_gre_ms3gl_ml_single_round = "1 round limit",
					bm_wp_wpn_fps_gre_ms3gl_ml_single_round_desc = "Limits weapon to single fire by limiting mag capacity to 1.",
				})
			end
			Custom_Gilza_attachs()
			
			local function Custom_attachs_non_Gilza()
				LocalizationManager:add_localized_strings({
					-- playbonk offhand kniv
					bm_wp_wpn_fps_offhandknif_Gilza_desc = "Increases melee damage and knockdown while using weapon butt. Also adds style points.\nStats:\n -Damage: 50\n -Knockdown: 400",
					-- Frenchy's missing strings on some parts - no translations required
					bm_wp_wpn_fps_upg_m_celerity = "\"Big Stick\" 30-round mag",
					bm_wp_wpn_fps_upg_m_308dmmag = "Lightweight 30-round mag",
				})
			end
			Custom_attachs_non_Gilza()
			
			local function Weapon_descs()
				LocalizationManager:add_localized_strings({
					bm_w_supernova_desc = "Alt-fire: gain 3x rate of fire, but 3x worse accuracy and 1.5x worse stability.",
					bm_w_saw_desc = "Ammo pickups are disabled unless \"Saw Massacre\" skill is used. Does not deal bonus damage on headshots, except for Bulldozers.",
				})
			end
			Weapon_descs()
			
			local function Throwable_descs()
				LocalizationManager:add_localized_strings({
					bm_wpn_prj_ace_desc = "Damage: 300\nPick up multiplier: "..tostring(Gilza.grenade_multipliers.wpn_prj_ace).."\n",
					bm_grenade_frag_desc = "Damage: 1600\nRadius: 500\nPick up multiplier: "..tostring(Gilza.grenade_multipliers.frag).."\n",
					bm_wpn_prj_four_desc = "Damage: 150\nPick up multiplier: "..tostring(Gilza.grenade_multipliers.wpn_prj_four).."\n\nHit enemies become poisoned and begin to vomit uncontrollably, preventing them from making any other actions.\n\nPoison stats:\n -Duration: 5 seconds\n -Damage per second: 130",
					bm_wpn_prj_hur_desc = "Damage: 1300\nPick up multiplier: "..tostring(Gilza.grenade_multipliers.wpn_prj_hur).."\n",
					bm_wpn_prj_jav_desc = "Damage: 3250\nPick up multiplier: "..tostring(Gilza.grenade_multipliers.wpn_prj_jav).."\n",
					bm_wpn_prj_target_desc = "Damage: 1000\nPick up multiplier: "..tostring(Gilza.grenade_multipliers.wpn_prj_target).."\n",
					bm_concussion_desc = "Damage: 0\nRadius: 1500\nPick up multiplier: "..tostring(Gilza.grenade_multipliers.concussion).."\n",
					bm_dynamite_desc = "Damage: 1600\nRadius: 500\nPick up multiplier: "..tostring(Gilza.grenade_multipliers.dynamite).."\n",
					bm_grenade_frag_com_desc = "Damage: 1600\nRadius: 500\nPick up multiplier: "..tostring(Gilza.grenade_multipliers.frag_com).."\n",
					bm_grenade_sticky_grenade_desc = "Damage: 1200\nRadius: 500\nPick up multiplier: "..tostring(Gilza.grenade_multipliers.sticky_grenade).."\n",
					bm_grenade_xmas_snowball_desc = "Damage: 280\nRadius: 100\n",
					bm_grenade_fir_com_desc = "Damage: 30\nRadius: 500\nPick up multiplier: "..tostring(Gilza.grenade_multipliers.fir_com).."\n\nCreates an incendiary explosion. Enemies caught in the blast radius, receive afterburn.\n\nAfterburn stats:\n -Duration: 2 seconds\n Damage per second: 420",
					bm_grenade_dada_com_desc = "Damage: 1600\nRadius: 500\nPick up multiplier: "..tostring(Gilza.grenade_multipliers.dada_com).."\n",
					bm_grenade_molotov_desc = "Damage: 30\nRadius: 350\nPick up multiplier: "..tostring(Gilza.grenade_multipliers.molotov).."\n\nCreates a fire field for 15 seconds. Enemies that walk through it, receive afterburn.\n\nAfterburn stats:\n -Duration: 10 seconds\n Damage per second: 260\n\nIf you land a direct hit, afterburn damage per second is increased to 420 for hit target.",
					bm_grenade_electric_desc = "Damage: 600\nRadius: 1000\nPick up multiplier: "..tostring(Gilza.grenade_multipliers.wpn_gre_electric).."\n\nZap-zap.\nThis grenade has increased damage fall off, because of it, enemies caught in the blast radius, but not directly in the middle of it, will receive minuscular damage.\n",
					bm_grenade_poison_gas_grenade_desc = "Damage: 1000\nRadius: 200\nPick up multiplier: "..tostring(Gilza.grenade_multipliers.poison_gas_grenade).."\n\nCreates a gas cloud for 20 seconds. Enemies caught in the cloud become poisoned and begin to vomit uncontrollably, preventing them from making any other actions.\n\nPoison stats:\n -Duration: 15 seconds\n -Damage per second: 30",
				})
			end
			Throwable_descs()
			
			local function Melee_descs()
				LocalizationManager:add_localized_strings({
					bm_melee_cs_info = "Hold melee button to deal continuous damage.\n\nChainsaw effect stats:\nDelay before effect begins: 1s\nDamage: 80% health per second",
					bm_melee_ostry_info = "Hold melee button to deal continuous damage.\n\nChainsaw effect stats:\nDelay before effect begins: 0.7s\nDamage: 60% health per second",
				})
			end
			Melee_descs()
			
		end
		Weapon_strings()
		
		local function UI_strings()
			LocalizationManager:add_localized_strings({
				-- perk reset button
				menu_Gilza_perk_reset_text = "WARNING!\n\nBy pressing 'Yes' you will reset your perk deck progression. Resetting perk deck progression will remove progression from all of your perk decks, BUT it will keep all the perk points you have accumulated so far. This option should be used to try new Gilza perk decks without earning required perk points needed for their unlock.\n\nAre you sure you want to proceed?",
				menu_Gilza_perk_reset_confirm = "Yes",
				menu_Gilza_perk_reset_deny = "No",
				-- Fearmonger's in-game pop up notification
				Gilza_fearmonger_trigger_notification = "Fearmonger speed boost activated.",
				-- stockholm's in-game pop up notification
				Gilza_menace_panic_spread_notification = "Stockholm syndrome menace points: ",
				-- fall damage immunity charges in-game pop up notification
				Gilza_used_limited_fall_damage_immunity_charge = "Lethal fall damage prevented. Remaining charges: ",
				-- custom attachments tag
				menu_l_global_value_Gilza = "This is a Gilza Item!",
				-- VHUD compatibility with burst warning
				Gilza_vhud_burst_warning_str = "It seems like you have \"Burst Fire\" setting enabled in VanillaHUD. Please disable it for Gilza's burst fire feature to work correctly.\n\nYou can do so in Options->Mod options->VanillaHUD Plus Settings->Equipment Tweaks->Enable Burst Fire.",
			})
		end
		UI_strings()
		
	end
	AddEnglishLoc() -- always add eng loc to avoid errors for missing strings, this way all strings will default to eng if they did not get updated properly 
	
	local function AddRussianLoc()
		
		local function Perk_strings_vanilla()
			
			local function Neutral_cards()
				LocalizationManager:add_localized_strings({
					menu_deckall_2 = "Быстрый и разъярённый",
					menu_deckall_2_desc = "Увеличивает скорость взаимодействия с медицинскими сумками на ##20%##\n\nНошение брони влияет на скорость передвижения на ##25%## меньше.",
					menu_deckall_4_desc = "Параметр скрытности увеличен на ##+1##.\n\nКоличество очков опыта при завершении дней и контрактов увеличено на ##45%##.",
					menu_deckall_6_desc = "Открывает сумку с броней, содержимое которой можно надеть во время ограбления.\n\nВраги оставляют на ##35%## больше патронов.\n\nВы также получаете базовый шанс ##0%## найти метательное оружие в оставленных врагами боеприпасах. Шанс увеличивается на ##1% * x## (где x - метательный множитель) за каждый подобранный боеприпас, в котором не было метательного оружия. Когда метательное оружие будет найдено в боеприпасах, шанс будет сброшен до базового значения.\n\nПометка: метательный множитель зависит от используемого вами метательного оружия, а его значение можно узнать в описании каждого метательного оружия.",
					menu_deckall_8 = "Улучшенная физическая подготовка",
					menu_deckall_8_desc = "Вы получаете дополнительную скорость передвижения в размере ##10%##.\n\nВы можете бросать сумки на ##50%## дальше.",
				})
			end
			Neutral_cards()
			
			local function Crew_chief_str()
				LocalizationManager:add_localized_strings({
					menu_deck1_3_desc = "Выносливость всех членов команды, включая вас, увеличена на ##50%##.\n\nКогда вы пытаетесь запугать гражданского, убедить врага сдаться, пометить специальнього врага, или использовать навык \"Вдохновление\" на союзнике, дальность вашего крика увеличена на ##25%##.\n\nПока вы находитесь в пределах ##18## метров от видимого врага, вы получаете ##8%## сопротивления урону. Это сопротивление остаеется с вами в течении еще ##5## секунд после того как вы больше не окружены.\n\nПометка: Навыки распространяющиеся на напарников не складываются сами с собой.",
					menu_deck1_5_desc = "Ваше здоровье и здоровье вашей команды увеличено на ##10%##.\n\nВы, и только вы, получаете еще ##10%## здоровья.\n\nПометка: Навыки распространяющиеся на напарников не складываются сами с собой.",
					menu_deck1_7_desc = "Прочность вашей брони и брони вашей команды увеличена на ##5%##.\n\nВы, и только вы, получаете еще ##5%## к прочности брони.\n\nПометка: Навыки распространяющиеся на напарников не складываются сами с собой.",
					menu_deck1_9_desc = "Вы и ваша команда получаете ##6%## здоровья и ##12%## выносливости за каждого взятого вами заложника. Навык складывается вплоть до ##4## заложников.\n\nЕсли у вас есть заложник, то все члены команды получают ##8%## сопротивления урону.\n\nЕсли вы убедили врага сдаться, он будет считаться за заложника для этого навыка. Враги, которых перевели сражаться на вашей стороне, будут давать бонусы от данной карточки перка только игроку который перевел врага на вашу сторону.\n\nПометка: Перки, распространяющие своё действие на напарников, не складываются сами с собой.\n\nБонус завершения ряда: Вероятность получить предмет высокого качества после завершения контракта увеличена на ##10%##.",
					-- short descs
					menu_deck1_3_short = "Выносливость всех членов команды, увеличена на ##50%##. Дальность вашего крика увелиена на ##25%##. Пока вы находитесь близко к врагу, вы получаете меньше урона.",
					menu_deck1_5_short = "Здоровье вашей команды увеличено на ##10%##, а ваше на ##20%##.",
					menu_deck1_7_short = "Прочность брони вашей команды увеличена на ##5%##, а вашей на ##10%##.",
				})
			end
			Crew_chief_str()
			
			local function Muscle_str()
				LocalizationManager:add_localized_strings({
					menu_deck2_7_desc = "Всё ваше оружие имеет шанс ##20%## посеять панику среди врагов, если на нём не установлен глушитель.\n\nПаника будет подавлять противника, заставляя его испытывать страх, предотвращая его совершать какие либо действия. Некоторые враги могут сопротивляться этому эффекту, а некоторые, например Бульдозеры, полностью его игнорируют.",
					menu_deck2_9_desc = "Здоровье увеличено ещё на ##60%##.\n\nВы будете восполнять ##3%## здоровья каждые ##5## секунд.\n\nПри игре на сложности Смертный Приговор ваше пассивное восполнение здоровья увеличено до ##5%## раз в ##5## секунд.\n\nБонус завершения ряда: Вероятность получить предмет высокого качества после завершения контракта увеличена на ##10%##.",
					-- short descs
					menu_deck2_9_short = "Здоровье увеличено ещё на ##60%##. Вы будете восполнять ##3%## здоровья каждые ##5## секунд. При игре на сложности Смертный Приговор пассивное восполнение здоровья увеличено.",
				})
			end
			Muscle_str()
			
			local function Rogue_str()
				LocalizationManager:add_localized_strings({
					menu_deck4_9_desc = "Шанс пробить вражескую нательную броню из любого оружия увеличен на ##40%##.\nУменьшает время переключения между оружием на ##80%##.\n\nШанс увернуться увеличен на еще ##5%##.\nШанс увернуться когда вы пригнулись увеличен на ##5%##.\n\nВаша скорость передвижения увеличена на ##15%##.\nВаш запас выносливости увеличен на ##25%##.\n\nБонус завершения ряда: Вероятность получить предмет высокого качества после завершения контракта увеличина на ##10%##.",
					-- short descs
					menu_deck4_9_short = "Шанс пробить вражескую нательную броню из любого оружия увеличен на ##40%##. Уменьшает время переключения между оружием на ##80%##. Шанс увернуться увеличен на еще ##5%## и шанс увернуться когда вы пригнулись увеличен на ##5%##. Ваша скорость передвижения увеличена на ##15%##. Ваш запас выносливости увеличен на ##25%##.",
				})
			end
			Rogue_str()
			
			local function Hitman_str()
				LocalizationManager:add_localized_strings({
					menu_deck5_1 = "Мастер оружий",
					menu_deck5_1_desc = "Убийство врага оружием ближнего боя, или не-взрывчатым метательным оружием восполнит ##25%## вашей брони. Навык срабатывает только один раз в ##1## секунду.",
					menu_deck5_3_desc = "Штраф к стабильности вашего парного оружия уменьшен на ##8## единиц.\nКоличество переносимых боеприпасов для парного оружия увеличено на ##50%##.\n\nУбийство врага используя пистолет, пистолет-пулемет или парное оружие ускоряет скорость восставновления брони на ##25%## в течении ##10## секунд. Если вы опять убьете врага используя пистолет, пистолет-пулемет или парное оружие пока навык активен, таймер навыка будет пополнен до ##10## секунд.",
					menu_deck5_5 = "В ритме смерти",
					menu_deck5_5_desc = "\nНовая способность: В Ритме Смерти.\nДля активации необходимо совершить ##4## убийства подряд в комбо. Время между каждым убийством не должно быть меньше ##0.5## секунд и не больше ##1.5## секунд. Если убийство совершено быстрее требуемого времени, оно не засчитывается в комбо; если слишком медленно — комбо сбрасывается.\n\nПервое убийство комбо должно быть выполнено с помощью оружия ближнего боя, или не-взрывчатым метательным оружием. Убийства оружием ближнего боя, или не-взрывчатым метательным оружием будут засчитываться как 2 убийства вместо 1, за исключением самого первого убийства комбо.\n\nПри активации: вы получаете ##5## секунд неуязвимости. Данный эффект не может происходить чаще чем раз в ##20## секунд.\n\nПометка: иконка перков мода Gilza покажет текущее комбо, если у вас есть эффект неуязвимости (синий череп) и если эффект на кулдауне (красный таймер).",
					menu_deck5_7 = "Охотник за головами",
					menu_deck5_7_desc = "\nНовая пассивная черта: Охотник за головами.\nСлучайный враг в радиусе ##25м## становится вашей приоритетной целью, и будет подсвечен для вас белым контуром. Убийство цели даёт бонус охотника за головами.\n\nБонус охотника за головами действует ##30## секунд. После того как бонус будет исчерпан вы не сможете получить новую цель в течении ##10## секунд. Если цель сбежит или её убьют, вы не получите бонус и вы не сможете получить новую цель в течении ##40## секунд. Враг перестанет быть вашей целью если он пережил ##40## секунд будучи вашей целью, и вы не сможете получить новую цель в течении еще ##10## секунд.\nБонус охотника за головами:\nУсиливает эффекты навыков Киллера для карт 1, 3 и 5.\nВосполнение брони 1 карты увеличивается до ##50%##, скорость восставновления брони 3 карты увеличивается до ##50%##, и продолжиельность неуязвимости 5 карты увеличивается до ##10## секунд, не затрагивая кулдаун.\n\nПометка: иконка перков мода Gilza покажет если у вас есть приоритетная цель (ярко-белый) и если бонус охотника за головами активен (зелёный).",
					menu_deck5_9_desc = "Когда вы лишитесь брони, то она восстановится через ##1.5## секунды вне зависимости от того в каких вы находитесь условиях.\n\nБонус завершения ряда: Вероятность получить предмет высокого качества после завершения контракта увеличена на ##10%##.",
					-- short descs
					menu_deck5_1_short = "Убийство врага оружием ближнего боя или не-взрывчатым метательным оружием восполняет ##25%## брони. Навык срабатывает только один раз в ##1## секунду.",
					menu_deck5_3_short = "Парное оружие получает увеличенную ёмкость боезапаса и улучшенную стабильность. Убийства пистолетами, пистолет-пулеметами или парным оружием ускоряет скорость восставновления брони на ##25%##.",
					menu_deck5_5_short = "Новая способность: В ритме смерти. ##4## убийства в идеальном комбо дают ##5## секунд неуязвимости, с кулдауном в ##20## секунд. Первое убийство должно быть совершено оружием ближнего боя или не-взрывчатым метательным оружием.",
					menu_deck5_7_short = "Новая пассивная черта: Охотник за Головами. Случайный враг становится целью - убийство даёт бонус, усиливающий эффекты других карт перка Киллера.",
					menu_deck5_9_short = "Броня восстанавливается через ##1.5## секунды после разрушения в любых условиях.",
				})
			end
			Hitman_str()
			
			local function Crook_str()
				LocalizationManager:add_localized_strings({
					menu_deck6_5_desc = "При ношении баллистических бронежилетов, шанс увернуться от вражеского огня увеличен на ##5%##.\n\nПрочность брони всех баллистических бронежилетов увеличена на ##20%##.",
					menu_deck6_7_desc = "При ношении баллистических бронежилетов, шанс увернуться от вражеского огня увеличен на ##15%##.\n\nПрочность брони всех баллистических бронежилетов увеличена на ##25%##.",
					menu_deck6_9_desc = "Скорость восстановления брони увеличена на ##10%##.\n\nШансы пробития вражеской нательной брони увеличены на ##75%##.\n\nБонус завершения ряда: Вероятность получить предмет высокого качества после завершения контракта увеличена на ##10%##.",
					-- short descs
					menu_deck6_5_short = "При ношении баллистических бронежилетов, шанс увернуться от вражеского огня увеличен на ##5%##. Прочность брони всех баллистических бронежилетов увеличена на ##20%##.",
					menu_deck6_7_short = "При ношении баллистических бронежилетов, шанс увернуться от вражеского огня увеличен на ##15%##. Прочность брони всех баллистических бронежилетов увеличена на ##25%##.",
					menu_deck6_9_short = "Скорость восстановления брони увеличена на ##10%##. Шансы пробития вражеской нательной брони увеличены на ##75%##."
				})
			end
			Crook_str()
			
			local function Burglar_str()
				LocalizationManager:add_localized_strings({
					menu_deck7_3_desc = "Вероятность того, что враги начнут стрелять по вам снижена на ##10%##, если вы пригнулись и не двигаетесь.\n\nСкорость упаковки трупов увеличена на ##25%##.",
					menu_deck7_5_desc = "Шанс увернуться увеличен на ##5%##.\n\nВероятность того, что враги начнут стрелять по вам уменьшена на ##5%##, если вы пригнулись и не двигаетесь.\n\nШанс увернуться увеличен на ##10%##, когда вы используете Легкий Баллистический Бронежилет.\n\nВы получаете ##2## очка скрытности за каждое используемое оружие с глушителем.\n\nСкорость взлома замков увеличена на ##25%##.",
					menu_deck7_7_desc = "Шанс увернуться увеличен на еще ##5%##. Вероятность того, что враги начнут стрелять по вам уменьшена на ##5%##, если вы пригнулись и не двигаетесь.\n\nСкорость ответа на пейджеры увеличена на ##25%##.",
					menu_deck7_9_desc = "Скорость восстановления брони будет увеличена на ##20%##, если вы не двигаетесь.\n\nВы передвигаетесь на ##10%## быстрее в присяди.\n\nБонус завершения ряда: Вероятность получить предмет высокого качества после завершения контракта увеличена на ##10%##.",
					-- short descs
					menu_deck7_3_short = "Враги будут стрелять по вам реже, если вы пригнулись и не двигаетесь. Скорость упаковки трупов увеличена.",
					menu_deck7_5_short = "Шанс увернуться увеличен, оссобенно при использовании ЛББ. Враги будут стрелять по вам еще реже, если вы пригнулись и не двигаетесь. Вы получаете скрытность за оружия с глушителем. Скорость взлома замков увеличена.",
					menu_deck7_7_short = "Шанс увернуться увеличен. Враги будут стрелять по вам еще реже, если вы пригнулись и не двигаетесь. Скорость ответа на пейджеры увеличена.",
					menu_deck7_9_short = "Скорость восстановления брони увеличена, если вы не двигаетесь. Вы быстрее передвигаетесь в присяди.",
				})
			end
			Burglar_str()
			
			-- Socio/Infil shared first card
			LocalizationManager:add_localized_strings({
				menu_sociopathinfil_1 = "OVERDOG",
				menu_sociopathinfil_1_desc = "Пока вас окружают как минимум три видимых врага в пределах ##18## метров от вас, вы получаете ##12%## сопротивления урону. Это сопротивление остаеется с вами в течении еще ##5## секунд после того как вы больше не окружены.\n\nВаш второй и каждый последующий удар в ближнем бою с перерывом не более чем в ##4## секунды, нанесёт на ##100%## больше урона от базового урона оружия.",
				menu_sociopathinfil_1_short = "Пока вас окружают как минимум три видимых врага в пределах ##18## метров от вас, вы получаете ##12%## сопротивления урону. Ваш второй и каждый последующий удар в ближнем бою с перерывом не более чем в ##4## секунды, нанесёт на ##100%## больше урона от базового урона оружия.",
			})
			
			local function Infiltrator_str()
				LocalizationManager:add_localized_strings({
					menu_deck8_3 = "Специалист ближнего боя",
					menu_deck8_3_desc = "Пока вы находитесь в пределах ##18## метров от видимого врага, вы получаете ##8%## сопротивления урону. Это сопротивление остаеется с вами в течении еще ##5## секунд после того как вы больше не окружены.",
					menu_deck8_5 = "Эксперт ближнего боя",
					menu_deck8_5_desc = "Пока вы находитесь в пределах ##18## метров от видимого врага, вы получаете еще ##7%## сопротивления урону. Это сопротивление остаеется с вами в течении еще ##5## секунд после того как вы больше не окружены.",
					menu_deck8_7 = "Мастер ближнего боя",
					menu_deck8_7_desc = "Пока вы находитесь в пределах ##18## метров от видимого врага, вы получаете еще ##7%## сопротивления урону. Это сопротивление остаеется с вами в течении еще ##5## секунд после того как вы больше не окружены.",
					-- short descs
					menu_deck8_3_short = "Пока вы находитесь в пределах ##18## метров от видимого врага, вы получаете ##8%## сопротивления урону.",
					menu_deck8_5_short = "Пока вы находитесь в пределах ##18## метров от видимого врага, вы получаете еще ##7%## сопротивления урону.",
					menu_deck8_7_short = "Пока вы находитесь в пределах ##18## метров от видимого врага, вы получаете еще ##7%## сопротивления урону.",
				})
			end
			Infiltrator_str()
			
			local function Sociopath_str()
				LocalizationManager:add_localized_strings({
					menu_deck9_5_desc = "При убийстве врага оружием ближнего боя вы восстановите ##10%## здоровья. Пометка: восполнение брони от карточка перка  \"Напряженность\" активируется одновременно с этим навыком.\n\nПерк срабатывает только один раз за ##1## секунду.\n\nПока вы находитесь в пределах ##18## метров от видимого врага, вы получаете ##8%## сопротивления урону. Это сопротивление остаеется с вами в течении еще ##5## секунд после того как вы больше не окружены.",
					menu_deck9_7_desc = "Если при убийстве врага он был в пределах ##18## метров от вас, вы восполните на ##30## больше брони.\n\nПрочность брони увеличена на еще ##10%##.",
					menu_deck9_9_desc = "При убийстве противника в пределах ##18## метров от вас у вас есть ##75%## вероятность посеять панику среди врагов.\n\nПаника будет подавлять противника, заставляя его испытывать страх, предотвращая его совершать какие либо действия. Некоторые враги могут сопротивляться этому эффекту, а некоторые, например Бульдозеры, полностью его игнорируют.\n\nНавык срабатывает только один раз за ##1## секунду, и активируется синхронно с другими эффектами перка, активирующимися при убийстве.\n\nБонус завершения ряда: Вероятность получить предмет высокого качества после завершения контракта увеличена на ##10%##.",
					-- short descs
					menu_deck9_3_short = "Убийство врага восполнит ##30## единиц брони. Прочность брони увеличена.",
					menu_deck9_5_short = "Убийство врага оружием ближнего боя восполнит здоровье.",
					menu_deck9_7_short = "Убийство врага в пределах ##18## метров от вас восполнит больше брони. Прочность брони увеличена.",
					menu_deck9_9_short = "При убийстве противника у вас есть ##75%## вероятность посеять панику среди врагов.",
				})
			end
			Sociopath_str()
			
			local function Gambler_str()
				LocalizationManager:add_localized_strings({
					menu_deck10_1_desc = "Боеприпасы, оставленные врагами, будут содержать медицинские припасы - при подборе боеприпаса вы испытываете свои шансы на исцеление. Данный эффект не может срабатывать чаще чем раз в ##4## секунды.\n\nПри подборе есть ##70%## шанс восполнить случайное количество здоровья: от ##16## до ##24##. Если вам повезет с дополнительным шансом в ##20%##, вы получите позитивный джекпот и утроите полученное здоровье.\nТакже есть ##15%## шанс найти ядовитые медицинские припасы и потерять случайное количество здоровья: от ##32## до ##48##. Если вам \"повезет\" с дополнительным шансом в ##10%##, вы получите негативный джекпот и утроите потерянное здоровье.\nНаконец, есть ##15%## шанс, что навык ничего не сделает, но уйдёт на кулдаун.\n\nРадиус подбора боеприпасов увеличен на ##50%##.\n\nПометка: иконка перков мода Gilza покажет если навык на кулдауне (ярко-белый), если эффект был положительным (зелёный) или отрицательным (красный), и если эффект снова доступен (бледно-белый). При получении джекпота иконка будет мигать.",
					menu_deck10_3_desc = "Когда вы собираете боеприпасы, оставленные врагами, ваши напарники будут получать ##50%## от собранного вами количества.\n\nДанный эффект не может срабатывать чаще чем раз в ##4## секунды.\n\nВаше здоровье увеличено на ##20%##.",
					menu_deck10_5_desc = "Когда вы находите медицинские припасы, ваши напарники также будут получать ##15## здоровья вне зависимости от полученого вами эффекта.\n\nВаше здоровье увеличено на еще ##20%##.",
					menu_deck10_7 = "Вопреки всему",
					menu_deck10_7_desc = "При восполнении здоровья от боеприпасов вы получаете на ##16## здоровья больше, но при потере здоровья вы теряете на ##32## здоровья больше.",
					menu_deck10_9 = "Еще больше шансов",
					menu_deck10_9_desc = "При подборе боеприпасов с медицинскими припасами вы также получаете пассивный шанс уклонения. Максимальный шанс уклонения от этой карты перка - ##35%##. Шансы получения положительных/отрицательных бонусов напрямую зависят от того какой эффект вы получили от первой карты данного набора перков.\n\nПри успехе вы получаете случайное количество уклонения: от ##2%## до ##8%##. При получении позитивного джекпота, бонус уклонения устанавливается на максимум.\nПри неудаче вы потеряете от ##4%## до ##16%## уклонения. При получении негативного джекпота бонус уклонения данной карты перка опускается до ##0%##.\n\nПометка: иконка перков мода Gilza теперь будет отображать текущий бонус уклонения от этой карточка перка.\n\nБонус завершения ряда: Вероятность получить предмет высокого качества после завершения контракта увеличена на ##10%##.",
					-- short descs
					menu_deck10_1_short = "Подбираемые боеприпасы теперь могут восполнить или убавить здоровье. Радус подбора боеприпасов увеличен.",
					menu_deck10_3_short = "Подбираемые боеприпасы восполняют боезапас ваших напарников. Ваше здоровье увеличено.",
					menu_deck10_5_short = "Подбираемые боеприпасы восполняют здоровье ваших напарников. Ваше здоровье увеличено.",
					menu_deck10_7_short = "Количество восполняемого или убавляемого здоровья увеличено.",
					menu_deck10_9_short = "Подбираемые боеприпасы теперь влияют на ваш шанс уворота.",
				})
			end
			Gambler_str()
			
			local function Grinder_str()
				LocalizationManager:add_localized_strings({
					menu_deck11_5_desc = "Эффект восстанавливающий здоровье теперь восстанавливает ##3## единицы здоровья каждые ##0.3## секунды в течение ##3## секунд.\n\nВероятность пробить вражескую нательную броню увеличена на ##10%##.",
					menu_deck11_9_desc = "Эффект восстанавливающий здоровье теперь восстанавливает ##4## единицы здоровья каждые ##0.3## секунды в течение ##4.2## секунд.\n\nВероятность пробить вражескую нательную броню увеличена на еще ##25%##.\n\nБонус завершения ряда: Вероятность получить предмет высокого качества после завершения контракта увеличена на ##10%##.",
					-- short descs
					menu_deck11_9_short = "Вы восстанавливаете больше здоровья и дольше. Вероятность пробить вражескую нательную броню увеличена.",
				})
			end
			Grinder_str()
			
			local function Yakuza_str()
				LocalizationManager:add_localized_strings({
					menu_deck12_1_desc = "Чем ниже ваше здоровье, тем быстрее восстанавливается ваша броня. Эффект активируется только когда ваше здоровье ниже ##25%##. Максимальный бонус к скорости восстанавления брони равен ##20%##.\n\nПосле того как вас подняли, ваше здоровье всегда будет равно ##10%##.\n\nВсе навыки восстанавливающие ваше здоровье отныне игнорируются.",
					menu_deck12_7_desc = "Максимальный бонус к скорости восстанавления брони при низком уровне здоровья увеличен на еще ##20%##.\n\nКогда ваше здоровье ниже ##50%## ваша броня не может быть пробита бронебойными выстрелами.",
					menu_deck12_9_desc = "Теперь все эффекты в этом наборе перков активируемые на уровне здоровья ниже ##25%##, будут активированы на уровне здоровья ниже ##50%##.\n\nВы получаете ##25%## сопротивления пулевому урону от врагов которые находятся у вас за спиной. Данный бонус увеличен до ##50%## при игре на сложности Смертный Приговор.\n\nКогда ваше здоровье ниже ##50%## вы получаете иммунитет к эффекту подавления. Пометка: когда в вас стреляют, вне зависимости от того попали по вам или нет, на вас накладывается эффект подавления. Если вас подавили, ваш таймер восставновления брони сбрасывается до максимального значения, и сверху накладывается ##1## секунда от эффекта подавления. Эта секунда не уменьшаема навыками влияющими на скорость восставновления брони. Имея иммунитет к данному эффекту, ваш таймер регенерации брони больше не будет сбрасываться если по вам выстрелили, но не попали, а эффект подавления при удачном попадании будет уменьшен с одной секунды до ##0.5##.\n\nБонус завершения: Вероятность получить предмет высокого качества после завершения контракта увеличена на ##10%##.",
					-- short descs
					menu_deck12_1_short = "Чем ниже ваше здоровье, тем быстрее восстанавливается ваша броня.",
					menu_deck12_5_short = "Максимальный бонус к скорости восстанавления брони увеличен.",
					menu_deck12_7_short = "Максимальный бонус к скорости восстанавления брони увеличен. Когда ваше здоровье ниже ##50%## ваша броня не может быть пробита бронебойными выстрелами.",
					menu_deck12_9_short = "Все эффекты в этом наборе перков активируемые на ##<25%## уровне здоровья, будут активированы на ##<50%## уровне здоровья. Когда ваше здоровье ниже ##50%## вы получаете иммунитет к эффекту подавления.",
				})
			end
			Yakuza_str()
			
			local function Ex_president_str()
				LocalizationManager:add_localized_strings({
					menu_deck13_5_desc = "Максимальное количество запасного здоровья, которое вы можете накопить, увеличено на ##50%##.\n\nВаше основное здоровье увеличено на ##10%##.\n\nВы получаете статичный шанс увернуться в ##20%##. Статичный шанс уворота нельзя увеличить или уменьшить используя навыки влияющие на уворот или заменяя используемую броню.",
					menu_deck13_7_desc = "Количество запасного здоровья, получаемого за убийство противников, увеличено на еще ##4##.\n\nВаше основное здоровье увеличено на еще ##20%##.\n\nЕсли у вас есть запасное здоровье, при риске получения урона по вашему основному здоровью, получаемый урон будет нанесен по вашему запасному здоровью, убавляя его количество. Если получаемый урон выше чем количество вашего запасного здоровья, урон будет уменьшен вашим запасным здоровьем и затем нанесен по вашему основному здоровью.",
					menu_deck13_9_desc = "За каждого убитого вами или вашей командой противника вы будете уменьшать ваш таймер восставновления брони на несколько сантисекунд. Насколько именно сантисекунд вы будете сокращать ваш таймер, зависит от используемой вами брони - чем сильнее броня, тем меньше бонус. Подробные количества можно узнать в описаниях брони.\nДанный бонус обнуляется после того как ваша броня полностью восстановилась.\nДанный бонус не может сократить таймер регенерации брони до значения меньше чем ##0.8## секунд.\n\nПометка: таймер восставновления брони обычно равен ##3## секундам. Навыки влияющие на скорость восстановления брони умножают данный таймер на объем своего бонуса после того как таймер был высчитан.\n\nБонус завершения ряда: Вероятность получить предмет высокого качества после завершения контракта увеличена на ##10%##.",
					-- armor description for blackmarket UI
					bm_menu_armor_max_health_store = "Набор перков Экс-Президент:\nМаксимальное количество запасного здоровья: $amount;\nСокращение таймера регенерации за убийство: $amount_2; сек.",
					-- short descs
					menu_deck13_5_short = "Максимальное количество запасного здоровья, которое вы можете накопить, увеличено. Ваше здоровье увеличено. Вы получаете статичный шанс увернуться.",
					menu_deck13_7_short = "Количество запасного здоровья, получаемого за убийство увеличено. Ваше здоровье увеличено. Запасное здорове теперь может защищать основное здорвоье.",
					menu_deck13_9_short = "За каждого убитого вами или вашей командой противника вы будете уменьшать ваш таймер восставновления брони на несколько сантисекунд.",
				})
			end
			Ex_president_str()
			
			local function Maniac_str()
				LocalizationManager:add_localized_strings({
					menu_deck14_1_desc = "Нанесённый вами урон конвертируются в \"Очки истерии\" в соотношении 1 к 1. Вы не можете получить больше чем ##120## очков истерии за ##1.5## секундный интервал. Максимальное количество очков истерии которое вы можете иметь - ##600##.\n\n\"Очки истерии\"\nЗа каждые ##30## очков истерии вы поглощаете ##1## единицу урона.\n\nЕсли вы не нанесете ни единицы урона в течении ##3## секунд вы потеряете ##20% + 80## очков истерии.",
					menu_deck14_5_desc = "Если вы не нанесете ни единицы урона в течении ##3## секунд вы теперь потеряете ##20% + 40## очков истерии, вместо ##20% + 80##.",
					menu_deck14_9_desc = "Поглощение урона от очков истерии увеличено на ##100%## для вас.\nПри игре на сложности Смертный Приговор, данный бонус равен ##200%##.\n\nБонус завершения ряда: Вероятность получить предмет высокого качества после завершения контракта увеличена на ##10%##.",
					-- short descs
					menu_deck14_1_short = "Нанесённый вами урон конвертируются в \"Очки истерии\". Максимальное количество очков истерии которое вы можете иметь - ##600##. За каждые ##30## очков истерии вы поглощаете ##1## единицу урона. Если вы не нанесете ни единицы урона в течении ##3## секунд вы потеряете ##20% + 80## очков истерии.",
					menu_deck14_5_short = "Если вы не нанесете ни единицы урона в течении ##3## секунд вы теперь потеряете ##20% + 40## очков истерии.",
					menu_deck14_9_short = "Поглощение урона от очков истерии увеличено на ##100%## для вас. При игре на сложности Смертный Приговор, данный бонус равен ##200%##.",
				})
			end
			Maniac_str()
			
			local function Anarchist_str()
				LocalizationManager:add_localized_strings({
					menu_deck15_1_desc = "Вместо того, чтобы полностью восстановить броню вне боя, Анархист может делать это постепенно и в самом бою. Чем мощнее ваша броня, тем меньше брони вы восстанавливаете за раз, но чаще.\n\nКогда ваша броня опустится до нуля, вы получите неуязвимость ко всем видам урона на ##2## секунды. Эффект срабатывает один раз в ##15## секунд.\n\nПометка: навыки сокращающие время восстановления брони не работают с данным набором перков.",
					menu_deck15_9_desc = "Нанося урон врагу, вы восполните несколько единиц брони. Эффект может срабатывать только один раз в несколько секунд. Чем мощнее ваша броня, тем меньше брони вы восполните но эффект может срабатывать чаще.\nВы можете узнать конкретные значения, в описаниях брони.\n\nБонус завершения ряда: Вероятность получить предмет высокого качества после завершения контракта увеличена на ##10%##.",
					-- armor description for blackmarket UI
					bm_menu_anarchist_armor_desc = "Набор перков Анархист:\nПассивное восставновление брони: $amount_1; единиц брони раз в $amount_2; секунд(ы);\nКол-во восполняемой брони за нанесенный урон: $amount_3; единиц брони раз в $amount_4; секунд(ы)",
					-- short descs
					menu_deck15_1_short = "Вместо того, чтобы полностью восстановить броню вне боя, Анархист может делать это постепенно и в самом бою. Чем мощнее ваша броня, тем меньше брони вы восстанавливаете за раз, но чаще. Когда ваша броня опустится до нуля, вы получите неуязвимость ко всем видам урона на ##2## секунды, с кулдауном в ##15## секунд.",
					menu_deck15_9_short = "Нанося урон врагу, вы восполните несколько единиц брони. Эффект может срабатывать только один раз в несколько секунд. Чем мощнее ваша броня, тем меньше брони вы восполните но эффект может срабатывать чаще.",
				})
			end
			Anarchist_str()
			
			local function Biker_str()
				LocalizationManager:add_localized_strings({
					menu_deck16_1_desc = "Вы получаете ##5%## к прочности вашей брони и на ##10%## больше здоровья.\n\nКаждое убийство, совершенное вами или вашей командой, может добавить вам 1 Стак Регенерации. Полученный Стак мгновенно восполняет ##5## здоровья и ##5## брони, после чего активирует свой кулдаун в ##4## секунды, по истечении которого Стак исчезает.\n\nМаксимальное количество слотов для Стаков Регенерации - ##4##. Новые Стаки не могут быть получены, если все слоты заняты, или если вы одновременно имеете максимальный уровень здоровья и брони.\n\nЕсли ваш уровень брони не равен нулю, при получении Стака Регенерации активируется эффект Предотвращения Переполнения Стаков длительностью в ##1## секунду.\nВо время действия этого эффекта новые Стаки Регенерации не могут быть получены, если уровень вашей брони выше нуля.",
					menu_deck16_3_desc = "Каждые ##10%## потерянного уровня здоровья, увеличат количество восполняемой брони от Стака Регенерации на ##1##.",
					menu_deck16_5_desc = "Каждые ##10%## потерянного уровня здоровья уменьшат ##4## секундную задержку перед тем как Стак Регенерации будет удален на ##0.1## секунду.\n\nКаждые ##10%## потерянного уровня здоровья уменьшат продолжительность эффекта Предотвращения Переполнения Стаков на ##0.025## секунд.",
					menu_deck16_7_desc = "Каждые ##10%## потерянного уровня брони, увеличат количество восполняемого здоровья от Стака Регенерации на ##1##.",
					menu_deck16_9_desc = "Каждые ##10%## потерянного уровня брони уменьшат ##4## секундную задержку перед тем как Стак Регенерации будет удален на ##0.1## секунд.\n\nКаждые ##10%## потерянного уровня брони уменьшат продолжительность эффекта Предотвращения Переполнения Стаков на ##0.025## секунд.\n\nБонус завершения ряда: Вероятность получить предмет высокого качества после завершения контракта увеличена на ##10%##.",
				})
			end
			Biker_str()
			
			local function Kingpin_str()
				LocalizationManager:add_localized_strings({
					menu_deck17_1_desc = "Разблокирует и позволяет взять с собой инъектор \"Вора в законе\".\n\nЕсли вы смените набор перков на другой, инъектор будет недоступен для использования. Инъектор использует слот для метательного оружия, но вы можете взять вместо него что-нибудь другое.\n\nЧтобы воспользоваться инъектором, достаточно нажать на кнопку для метательного оружия ##$BTN_ABILITY;##.\n\nВо время действия инъектора, вы будете восстанавливать ##75%## от всего полученного урона. Длительность эффекта инъектора равна ##6## секундам.\n\nПока активен инъектор, вы всё ещё можете получать урон. Воспользоваться инъектором можно раз в ##30## секунд.\n\nУбийство врага моментально сокращает кулдаун инъектора на ##1## секунду.",
					menu_deck17_9_desc = "Здоровье увеличено ещё на ##40%##.\n\nЗа каждые ##50## восстановленных очков здоровья во время действия инъектора при полном показателе здоровья, кулдаун инъектора будет сокращен на ##1## секунду.\n\nБонус завершения ряда: Вероятность получить предмет высокого качества после завершения контракта увеличена на ##10%##.",
					-- short descs
					menu_deck17_1_short = "Разблокирует и позволяет взять инъектор \"Вора в законе\". Во время действия инъектора, вы будете восстанавливать ##75%## от всего полученного урона. Эффект инъектора длиться ##6## секунд с кулдауном в ##30## секунд. Убийства врагов сокращает кулдаун инъектора.",
					menu_deck17_9_short = "Здоровье увеличено ещё на ##40%##. За каждые ##50## восстановленных очков здоровья во время действия инъектора при полном показателе здоровья, кулдаун инъектора будет сокращен на ##1## секунду.",
				})
			end
			Kingpin_str()
			
			local function Sicario_str()
				LocalizationManager:add_localized_strings({
					menu_deck18_1_desc = "Разблокирует и позволяет взять с собой дымовую шашку. Если вы смените набор перков на другой, дымовая шашка будет недоступна для использования.\n\nПри использовании, с помощи кнопки ##$BTN_ABILITY;##, дымовая шашка создаёт завесу, которая длится ##10## секунд. Пока вы и ваши напарники стоят в завесе, вы будете уворачиваться от ##50%## всех пуль. Любой враг, находящийся в дыму, будет менее точен при стрельбе на ##50%##.\n\nКак дым рассеется, вы не сможете использовать дымовую шашку в течение ##45## секунд. Тем не менее, убийство врагов сокращает время восстановления на ##1## секунду.",
					-- short descs
					menu_deck18_1_short = "Разблокирует и позволяет взять с собой дымовую шашку. При использовании, дымовая шашка создаёт завесу, которая длится ##10## секунд. Вы и ваши напарники стоя в завесе,  уворачиваетесь от ##50%## всех пуль. Любой враг, находящийся в дыму, будет менее точен при стрельбе на ##50%##. Как дым рассеется, вы не сможете использовать дымовую шашку в течение ##45## секунд. Тем не менее, убийство врагов сокращает время восстановления на ##1## секунду.",
				})
			end
			Sicario_str()
			
			local function Stoic_str()
				LocalizationManager:add_localized_strings({
					menu_deck19_1_desc = "Разблокирует и позволяет взять с собой флягу.\n\nЕсли вы смените набор перков на другой, фляга будет недоступна для использования. Фляга использует слот для метательного оружия, но вы можете взять вместо неё что-нибудь другое.\n\nЧтобы отпить из фляги, достаточно нажать на кнопку для метательного оружия ##$BTN_ABILITY;##.\n\nВесь получаемый урон разделен. ##30%## урона будут нанесёны сразу, а оставшиеся ##70%## будут наноситься по вам периодически в течении ##10## секунд.\n\nОтпив из фляги, весь периодический урон исчезает. Фляга имеет ##10## секундный кулдаун, но каждое совершенное убийство будет сокращать кулдаун на ##1## секунду.",
					menu_deck19_7_desc = "Пока ваш показатель здоровья ниже ##45%##, время сокращения кулдауна вашей фляги за каждого убитого врага будет увеличено с ##1## секунды до ##1.5## секунд.",
					menu_deck19_9_desc = "Когда периодический урон будет отменён, вы восполните здоровье. Восполненное здоровье будет равно ##60%## количества оставшегося периодического урона.\n\nБонус завершения ряда: Вероятность получить предмет высокого качества после завершения контракта увеличена на ##10%##.",
					-- short descs
					menu_deck19_1_short = "Разблокирует и позволяет взять с собой флягу. Весь получаемый урон разделен. ##30%## урона будут нанесёны сразу, а оставшиеся ##70%## будут наноситься по вам периодически в течении ##10## секунд. Отпив из фляги, весь периодический урон исчезает. Фляга имеет ##10## секундный кулдаун, но каждое совершенное убийство будет сокращать кулдаун на ##1## секунду.",
					menu_deck19_7_short = "Пока ваш показатель здоровья ниже ##45%##, сокращение кулдауна фляги за убийство увеличивается.",
					menu_deck19_9_short = "Когда периодический урон отменяется, он восполняет здоровье.",
				})
			end
			Stoic_str()
			
			local function TagTeam_str()
				LocalizationManager:add_localized_strings({
					menu_deck20_1_desc = "Разблокирует и позволяет взять с собой \"Парилку\".\n\nЧтобы использовать парилку, достаточно посмотреть на союзника в ##24## метровом радиусе и нажать на кнопку метательного оружия ##$BTN_ABILITY;##, чтобы пометить его.\n\nКаждый убитый вами, или выбранным вами союзником, противник восстановит ##15## единиц здоровья для вас и ##7.5## единиц здоровья для помеченного союзника.\n\nКаждый убитый вами противник продолжит время действия парилки на ##1.7## секунд и снизит кулдаун самой парилки на ##2## секунды.\n\nЭффект парилки длится ##12## секунд и имеет кулдаун в ##60## секунд.",
					menu_deck20_5_desc = "Убитый вами, или выбранным вами напарником, противник дает вам ##4## единицы поглощения урона. Максимальное количество поглощемого урона от данной карты перка равно ##32##. Данный эффект длится до тех пор, пока \"Парилка\" на кулдауне.",
					-- short descs
					menu_deck20_1_short = "Разблокирует и позволяет взять с собой \"Парилку\". При использовании парилки вы помечаете союзника. Каждый убитый вами, или выбранным вами союзником, противник восстановит ##15## единиц здоровья для вас и ##7.5## единиц здоровья для помеченного союзника. Каждый убитый противник продолжит время действия парилки на ##1.7## секунд. Эффект парилки длится ##12## секунд и имеет кулдаун ##60## секунд.",
					menu_deck20_5_short = "Убитый вами или выбранным вами напарником противник гарантирует вам ##4## единицы поглащения урона из максимальных ##32##. Данный эффект длится до тех пор, пока восстанавливается \"Парилка\".",
				})
			end
			TagTeam_str()
			
			local function Hacker_str()
				LocalizationManager:add_localized_strings({
					menu_deck21_1_desc = "Разблокирует и позволяет взять с собой карманный генератор помех.\n\nЕсли вы смените набор перков на другой, карманный генератор помех будет недоступен для использования. Карманный генератор помех использует слот для метательного оружия, но вы можете взять вместо него что-нибудь другое.\nЧтобы воспользоваться карманным генератором помех, достаточно нажать на кнопку для метательного оружия ##$BTN_ABILITY;##.\n\nЕсли генератор помех был использован до поднятия тревоги, то он отключит все пейджеры и электронику на ##6## секунд. \n\nИспользование генератора помех после поднятия тревоги будет генерировать поле со Звуковой петлей в течении ##12## секунд. Данное поле имеет шанс оглушить противников.\n\nКарманный генератор помех имеет ##2## заряда с ##140## секундным кулдауном, но каждое убийтво уменьшает кулдаун на ##4## секунды.",
					menu_deck21_5_desc = "При убийстве противников во время действия Звуковой петли вы будете восполнять ##40## единиц здоровья.\nШанс увернуться увеличен на ##15%##.",
					menu_deck21_7_desc = "При убийстве как минимум ##3## противников во время Звуковой петли вы получаете ##20%## бонус к шансу уклонения на ##50## секунд.",
					-- short descs
					menu_deck21_1_short = "Разблокирует и позволяет взять с собой карманный генератор помех.",
					menu_deck21_5_short = "При убийстве противников во время действия Звуковой петли вы будете восполнять ##40## единиц здоровья. Шанс увернуться увеличен на ##15%##.",
					menu_deck21_7_short = "При убийстве как минимум ##3## противников во время Звуковой петли вы получаете ##20%## бонус к шансу уклонения на ##50## секунд.",
				})
			end
			Hacker_str()
			
			local function Leech_str()
				LocalizationManager:add_localized_strings({
					menu_deck22_1_desc = "Открывает и экипирует Ампулу Кровопийцы в слот метательного оружия. После активации клавишей ##$BTN_ABILITY;##, Ампула будет длиться ##6## секунд, с кулдауном ##60## секунд.\nЕсли вы поднимите союзника под действием Ампулы, вы полностью восполните ваше здоровье и броню после окончания эффекта.\nЕсли вы упадете при кулдауне Ампулы меньше ##30## секунд, таймер кулдауна увеличится до ##30## секунд.\n\nАктивация Ампулы восстанавливает ##50%## здоровья, но временно отключает броню. Во время действия, здоровье делится на ##25%## сегменты, и любой полученный урон отнимает сегмент. Если инстанция урона нанесла вам больше 150 урона, вы теряете два сегмента.\nПри потере сегмента(-ов) вы получаете неуязвимость на ##0.5## секунд. Убийство в период неуязвимости восстановит один потерянный сегмент - это не может произойти чаще чем один раз за период неуязвимости. При восстановлении сегмента таким образом, ваши союзники восполнят ##5%## своего здоровья. Каждый дополнительный игрок с набором перков Кровопийца уменьшает данное командное восполнение здоровья на ##25%##.",
					menu_deck22_3_desc = "Ваше здоровье увеличено на ##20%##.\n\nВо время действия Ампулы Кровопийцы вы не можете упасть, но при потере всего здоровья перейдёте в режим \"Последнего Дыхания\", снижающий скорость передвижения на ##80%##.\n\nЕсли эффект Ампулы закончится во время режима Последнего Дыхания, вы автоматически упадёте, если только не возродили союзника за время действия Ампулы.\n\nВосполнение здоровья во время периода неуязвимости, после потери сегмента здоровья, может предотвратить переход в режим Последнего Дыхания, даже при отсутствии здоровья.\n\nВ режиме Последнего Дыхания отключается возможность лечения от навыков, предотвращение падения от навыка \"Колеса\", и возможность лечиться с помощью аптечек первой помощи и медицинских сумок.",
					menu_deck22_5_desc = "Длительность эффекта Ампулы Кровопийцы увеличена до ##10## секунд.\n\nУбийство противника сокращает кулдаун Ампулы на ##1.5## секунды.\n\nВостановление сегмента здоровья в период неуязвимости теперь будет восполнять ##10%## здоровья вашим союзникам.",
					menu_deck22_9_desc = "Теперь вы можете активировать Ампулу Кровопийцы после падения, что временно поднимет вас на ноги до истечения эффекта Ампулы.\nЕсли вы успешно используете медицинскую сумку до окончания эффекта Ампулы и ваше здоровье будет выше 0, вы останетесь в живых.\nЕсли вы успешно поднимете союзника до окончания эффекта Ампулы, вы останетесь в живых.\n\nПока Ампула Кровопийцы активна, ваше здоровье разбивается на сегменты, равные ##12.5%## вашего здоровья.\n\nБонус завершения ряда: Вероятность получить предмет высокого качества после завершения контракта увеличена на ##10%##.",
					-- short descs
					menu_deck22_1_short = "Открывает и экипирует Ампулу Кровопийцы, позваляющую вам поддерживать своих тиммейтов и себя дополнительным здоровьем.",
					menu_deck22_5_short = "Длительность эффекта Ампулы увеличена. Убийство противника сокращает кулдаун Ампулы. Вы востанавливаете больше здоровья вашим союзникам.",
					menu_deck22_9_short = "Теперь вы можете активировать Ампулу Кровопийцы после падения, что временно поднимет вас на ноги до истечения эффекта Ампулы.",
				})
			end
			Leech_str()
			
			local function Copycat_str()
				LocalizationManager:add_localized_strings({
					menu_deck23_3_desc = "Каждое попадание в голову восполняет ##10## единиц здоровья. Данный эффект срабатывает не чаще, чем раз в ##2## секунды.\n\nПри наличии ПРО навыка \"Меткий стрелок\" попадания в голову будут восполнять ##7.5## здоровья с кулдауном ##1.5## секунды.",
					menu_deck23_7_desc = "При получении урона, снижающего здоровье ниже ##50%##, вы получаете иммунитет к урону по здоровью на ##2## секунды.\n\nУрон активирующий данный навык всё равно будет нанесён, но он не сможет снизить ваше здоровье ниже ##1##.\nНавык срабатывает только при уровне брони ниже нуля.\nНавык не может активироваться чаще, чем раз в ##20## секунд.",
					menu_deck23_1_1_desc = "Ваше здоровье увеличено на ##15%##.",
					menu_deck23_3_1_desc = "Ваше здоровье увеличено на ##15%##.",
					menu_deck23_5_1_desc = "Ваше здоровье увеличено на ##15%##.",
					menu_deck23_7_1_desc = "Ваше здоровье увеличено на ##15%##.",
					menu_deck23_1_4_desc = "Ваша скорость передвижения в присяди и во время переноса сумок ускорена на ##10%##. Количество боезапаса которое вы можете взять с собой увеличено на ##7.5%##.",
					menu_deck23_3_4_desc = "Ваша скорость передвижения в присяди и во время переноса сумок ускорена на ##10%##. Количество боезапаса которое вы можете взять с собой увеличено на ##7.5%##.",
					menu_deck23_5_4_desc = "Ваша скорость передвижения в присяди и во время переноса сумок ускорена на ##10%##. Количество боезапаса которое вы можете взять с собой увеличено на ##7.5%##.",
					menu_deck23_7_4_desc = "Ваша скорость передвижения в присяди и во время переноса сумок ускорена на ##10%##. Количество боезапаса которое вы можете взять с собой увеличено на ##7.5%##.",
					-- 9th card bonuses
					menu_deck23_9_crew_chief_desc = "Вы и члены вашей команды получаете ##8%## сопротивления урону. Эффект сопротивления урону будет увеличен для вас в два раза, если уровень вашего здоровья ниже ##50%##.\n\nВыносливость всех членов команды, включая вас, увеличена на ##50%##.\n\nКогда вы пытаетесь запугать гражданского, убедить врага сдаться, пометить специальнього врага, или использовать навык \"Вдохновление\" на союзнике, дальность вашего крика увеличена на ##25%##.\n\nПока вы находитесь в пределах ##18## метров от видимого врага, вы получаете ##8%## сопротивления урону. Это сопротивление остаеется с вами в течении еще ##5## секунд после того как вы больше не окружены.\nПометка: Навыки распространяющиеся на напарников не складываются сами с собой.",
					menu_deck23_9_muscle_desc = "Ваше здоровье увеличено на ##20%##. Вы будете восполнять ##1.5%## здоровья каждые ##5## секунд. При игре на сложности Смертный Приговор пассивное восполнение здоровья увеличено до ##2.5%## каждые ##5## секунд.",
					menu_deck23_9_armorer_desc = "Прочность вашей брони увеличена на ##10%##.\n\nКогда ваша броня опустится до нуля, вы получите неуязвимость ко всем видам урона на ##2## секунды. Эффект срабатывает один раз в ##30## секунд.",
					menu_deck23_9_rogue_desc = "Ваш шанс увернуться увеличен на ##20%##.\n\nШанс увернуться когда вы пригнулись увеличен на ##5%##.",
					menu_deck23_9_hitman_desc = "Убийство врага оружием ближнего боя, или не-взрывчатым метательным оружием восполнит ##25%## вашей брони. Навык срабатывает только один раз в ##1## секунду.\n\nШтраф к стабильности вашего парного оружия уменьшен на ##8##.\nКоличество переносимых боеприпасов для парного оружия увеличено на ##50%##.\n\nУбийство врага используя пистолет, пистолет-пулемет или парное оружие ускоряет скорость восставновления брони на ##25%## в течении ##10## секунд. Если вы опять убьете врага используя пистолет, пистолет-пулемет или парное оружие пока навык активен, таймер навыка будет пополнен до ##10## секунд.",
					menu_deck23_9_crook_desc = "При ношении баллистических бронежилетов, шанс увернуться от вражеского огня увеличен на ##5%##.\n\nПрочность брони всех баллистических бронежилетов увеличена на ##20%##.\n\nШансы пробития вражеской нательной брони увеличены на ##75%##.",
					menu_deck23_9_burglar_desc = "Шанс увернуться увеличен на ##10%##, когда вы используете Легкий Баллистический Бронежилет.\n\nВы получаете ##2## очка скрытности за каждое используемое оружие с глушителем.\n\nСкорость ответа на пейджеры увеличена на ##25%##.\n\nВероятность того, что враги начнут стрелять по вам уменьшена на ##10%##, если вы пригнулись и не двигаетесь.",
					menu_deck23_9_infil_desc = "Ваш второй и каждый последующий удар в ближнем бою с перерывом не более чем в ##4## секунды, нанесёт на ##100%## больше урона от базового урона оружия.\n\nВы восстановите ##20%## здоровья, если ударите врага оружием ближнего боя. Навык срабатывает только один раз за ##10## секунд.",
					menu_deck23_9_gambler_desc = "Боеприпасы, оставленные врагами, будут содержать медицинские припасы - при подборе боеприпаса вы испытываете свои шансы на исцеление. Данный эффект не может срабатывать чаще чем раз в ##4## секунды.\nПри подборе есть ##70%## шанс восполнить случайное количество здоровья: от ##16## до ##24##. Если вам повезет с дополнительным шансом в ##20%##, вы получите позитивный джекпот и утроите полученное здоровье.\nТакже есть ##15%## шанс найти ядовитые медицинские припасы и потерять случайное количество здоровья: от ##32## до ##48##. Если вам \"повезет\" с дополнительным шансом в ##10%##, вы получите негативный джекпот и утроите потерянное здоровье.\nНаконец, есть ##15%## шанс, что навык ничего не сделает, но уйдёт на кулдаун.\nРадиус подбора боеприпасов увеличен на ##50%##. Когда вы собираете боеприпасы, ваши напарники будут получать ##50%## одного подобранного боеприпаса, но не чаще чем раз в ##4## секунды.\nПометка: иконка перков мода Gilza покажет если навык на кулдауне, и если эффект был положительным или отрицательным. При получении джекпота иконка будет мигать.",
					menu_deck23_9_grinder_desc = "Нанесение урона противнику добавляет вам эффект восстанавливающий здоровье. Данный эффект восстанавливает ##2## единицы здоровья каждые ##0.3## секунды в течение ##3## секунд.\n\nВы можете иметь несколько эффектов восстанавливающих здоровье, но вы не можете добавлять новый эффект чаще чем один раз за ##1.5## секунды.\nНавык работает только с Костюмом-Двойкой или Лёгким Баллистическим Бронежилетом.",
					menu_deck23_9_yakuza_desc = "Чем ниже ваше здоровье, тем быстрее вы передвигаетесь. Эффект активируется только когда ваше здоровье ниже ##50%##. Максимальный бонус к скорости передвижения равен ##20%##.\n\nКогда ваше здоровье ниже ##50%## вы получаете иммунитет к эффекту подавления. Пометка: когда в вас стреляют, вне зависимости от того попали по вам или нет, на вас накладывается эффект подавления. Если вас подавили, ваш таймер восставновления брони сбрасывается до максимального значения, и сверху накладывается ##1## секунда от эффекта подавления. Эта секунда не уменьшаема навыками влияющими на скорость восставновления брони. Имея иммунитет к данному эффекту, ваш таймер регенерации брони больше не будет сбрасываться если по вам выстрелили, но не попали, а эффект подавления при удачном попадании будет уменьшен с одной секунды до ##0.5##.",
					menu_deck23_9_expres_desc = "Вы будете накапливать ##8## единиц запасного здоровья за каждого ##1## убитого вами или вашей командой противника при условии, что ваша броня полностью цела.\n\nПосле того как ваша броня полностью сломается, и затем закончит восстанавливаться, вы восполните ваше основное здоровье с помощью накопленного вами запасного здоровья. Вне зависимости от того сколько запасного здоровья было использовано, после восставновления брони его количество всегда будет сброшено до ##0##.\n\nМаксимальное количество запасного здоровья, которое можно накопить, зависит от используемой вами брони, и доступно вам для просмотра в описанях брони.\n\nВаше основное здоровье увеличено на ##10%##.",
					menu_deck23_9_maniac_desc = "Нанесённый вами урон конвертируются в \"Очки истерии\" в соотношении 1 к 1. Вы не можете получить больше чем ##120## очков истерии за ##1.5## секундный интервал. Максимальное количество очков истерии которое вы можете иметь - ##600##.\n\n\"Очки истерии\"\nЗа каждые ##30## очков истерии вы поглощаете ##1## единицу урона.\n\nЕсли вы не нанесете ни единицы урона в течении ##3## секунд вы потеряете ##20% + 80## очков истерии.\n\nДругие члены команды так же будут получать бонусы от ваших очков истерии.\nОчки истерии разных членов команды не складываются и работают только очки, дающие большую прибавку к урону.",
					menu_deck23_9_anarchist_desc = "Вместо того, чтобы полностью восстановить броню вне боя, Анархист может делать это постепенно и в самом бою. Чем мощнее ваша броня, тем меньше брони вы восстанавливаете за раз, но чаще.\n\nКогда ваша броня опустится до нуля, вы получите неуязвимость ко всем видам урона на ##2## секунды. Эффект срабатывает один раз в ##40## секунд.\n\nПометка: навыки сокращающие время восстановления брони не работают с данным набором перков.",
					menu_deck23_9_biker_desc = "Каждое убийство, совершенное вами или вашей командой, может добавить вам 1 Стак Регенерации. Полученный Стак мгновенно восполняет ##5## здоровья и ##5## брони, после чего активирует свой кулдаун в ##4## секунды, по истечении которого Стак исчезает.\n\nМаксимальное количество слотов для Стаков Регенерации - ##4##. Новые Стаки не могут быть получены, если все слоты заняты, или если вы одновременно имеете максимальный уровень здоровья и брони.\n\nЕсли ваш уровень брони не равен нулю, при получении Стака Регенерации активируется эффект Предотвращения Переполнения Стаков длительностью в ##1## секунду.\nВо время действия этого эффекта новые Стаки Регенерации не могут быть получены, если уровень вашей брони выше нуля.",
					menu_deck23_9_leech_desc = "Открывает и экипирует Ампулу Кровопийцы в слот метательного оружия, активируемую клавишей ##$BTN_ABILITY;##. Ампула длится ##6## секунд, с кулдауном ##60## секунд. Если вы поднимите союзника под действием Ампулы, вы полностью восполните ваше здоровье и броню после окончания эффекта. Если вы упадете при кулдауне Ампулы меньше ##30## секунд, таймер кулдауна увеличится до ##30## секунд.\nАктивация Ампулы восстанавливает ##50%## здоровья, но временно отключает броню. Во время действия, здоровье делится на ##25%## сегменты, и любой полученный урон отнимает сегмент. Если инстанция урона нанесла вам больше 150 урона, вы теряете два сегмента.\nПри потере сегмента(-ов) вы получаете неуязвимость на ##0.5## секунд. Убийство в период неуязвимости восстановит один потерянный сегмент - это не может произойти чаще чем один раз за период неуязвимости. При восстановлении сегмента таким образом, ваши союзники восполнят ##5%## своего здоровья. Каждый дополнительный игрок с набором перков Кровопийца уменьшает данное командное восполнение здоровья на ##25%##.",
					menu_deck23_9_brawler_desc = "Вы можете получить вплоть до ##3## одновременных эффектов регенерации брони от данной карточки перка. Если у вас нет ни одного эффекта регенерации брони, вы можете активировать его убив врага. Чтобы получить больше одновременных эффектов вам нужно убивать врагов использую оружие ближнего боя или пилу OVE9000.\n\nЭфеект регенерации брони: восполните ##25## очков брони в течении ##6## секунд с \"тиком\" регенрации раз в ##0.75## секунд.\n\nИграя на сложности Смертельный Приговор вы будете восполнять ##50## очков брони вместо ##25## за такой же срок.\n\nПометка: иконка перков мода Gilza покажет количество эффектов регенерации которое вы имеете в виде текста \"1x\" под иконкой.\n\nБонус завершения ряда: Вероятность получить предмет высокого качества после завершения контракта увеличина на ##10%##.",
					menu_deck23_9_junkie = "Под спидами",
					menu_deck23_9_junkie_desc = "Вы можете иметь вплоть до ##100## стаков адреналина. Быстрое передвижение добавляет адреналин - чем быстрее вы двигаетесь, тем больше стаков вы получаете. Если вы двигаетесь недостаточно быстро ваш адреналин будет уменьшаться.\n\nЗа каждый стак адреналина вы получаете шанс увернуться, вплоть до максимального шанса в ##40%## при ##100## стаках.\n\nЕсли вы будете поддерживать ##90## и более адреналина дольше чем ##4## секунды вы обессилете. Обессилее полностью исчерпывает вашу выносливость и некоторую часть ваших стаков адреналина.\n\nВаша броня теперь может восстанавливаться только когда вы полностью неподвижны.\n\nПометка: иконка перков мода Gilza покажет количество стаков адреналина, если ваш уровень адреналина слишком высок (красный) и если вы обессилите (фиолетовый).",
					menu_deck23_9_guardian = "Страж",
					menu_deck23_9_guardian_desc = "Ваша скорость передвижения уменьшена на ##20%##.\nВремя взаимодействия с любыми предметами, кроме пейджеров и окозания помощи напарникам, замедлены на ##50%##.\n\nВы получаете возможность создать личную оборонную позицию, если вы будете неподвижно стоять в течении ##5## секунд. Данная позиция имеет ##3м## радиус. Если вы будете находиться вне зоны вашей позиции дольше ##8## секунд, позиция будет удалена. Вам придется подождать еще ##8## секунд, перед тем как вы сможете создать новую позицию.\n\nПока вы стоите внутри вашей оборонной позиции, вы восполняете ##20## единиц здоровья раз в ##2## секунды.\n\nПометка: иконка перков мода Gilza покажет если вы в данный момент внутри вашей оборонной позиции (яркий белый), и если ваша оборонная позиция существует, но вы вне ее пределов (тусклый белый).",
					-- short descs
					menu_deck23_3_short = "Попадания в голову восполняют здоровье.",
					menu_deck23_7_short = "При получении урона, снижающего здоровье ниже ##50%##, вы получаете иммунитет к урону.",
				})
			end
			Copycat_str()
			
		end
		Perk_strings_vanilla()
		
		local function Perk_strings_custom()
			
			local function Brawler_str()
				LocalizationManager:add_localized_strings({
					menu_deck_brawler = "Дебошир",
					menu_deck_brawler_desc = "Ничто не приносит тебе так много удовольствия как звук хруста костей и звук брыжащей крови прямо из аорты. Тепло крови заставляет тебя неконтролируемо улыбаться. Ты наконец решился отдаться этим мыслям, и найти себе подходящий бронекостюм. Да, он не особо хорошо сидит, и шансы одеть разгрузку с боеприпасами вместе с ним равны нулю, но после того как ты его подстроишь под себя, ты станешь воплащением жестокости и бесстрашия.",
					menu_deck_brawler1 = "Улучшеный бронекостюм",
					menu_deck_brawler1_desc = "Ваш запас и подбираемое количество боеприпасов уменьшены на ##80%##. Заметьте что данное снижение накладывается после всех других навыков связанных с боезапасом/подбором как множитель ##0.2##, что не повзолит вам компенсировать данный эффект другими навыками.\nПри использовании арбалета/лука подбирая обратно болт/стрелу вы имеете только ##20%## шанс получить ее обратно в боезапас.\n\nВаш второй и каждый последующий удар в ближнем бою с перерывом не более чем в ##4## секунды, нанесёт на ##100%## больше урона от базового урона оружия.\n\nВремя восстановления брони замедлено на ##350%##.\n\nВаша броня получает сопротивление к пулевому урону в размере ##5%##.",
					menu_deck_brawler3 = "Улучшения маневренности",
					menu_deck_brawler3_desc = "Ваша броня получает дополнительное сопротивление к пулевому урону в размере ##5%##.\n\nШтраф к скорости передвижения в броне уменьшен на еще ##25%##.",
					menu_deck_brawler5 = "Улучшение бронепластины",
					menu_deck_brawler5_desc = "Вашу броню теперь невозможно пробить насквозь бронебойными выстрелами.\n\nВаша броня получает дополнительное сопротивление к пулевому урону в размере ##10%##.\n\nШтраф к скорости передвижения в броне уменьшен на еще ##25%##.\n\nУбийство противника в рукопашном бою восстанавливает ##5%## вашей выносливости.",
					menu_deck_brawler7 = "Мясной щит",
					menu_deck_brawler7_desc = "Когда ваше здоровье ниже ##50%##, вы получаете по ##2.5%## сопротивления пулевому урону по вашей броне и ##3.5## поглощения урона за каждого союзника в радиусе ##21м## вокруг вас. Данный бонус не складывается больше ##3## раз.\nВраги которых лично вы перевели на свою сторону будут считаться как союзники для данной карточки перка.\nПри игре на сложности Смертный Приговор защитные бонусы данной карточки перка увеличиваются до ##5%## сопротивления урону и ##7## поглощения урона.\n\nВероятность того что по вам начнут стрелять когда вы находитесь рядом с союзниками выше на ##15%##. Все остальные навыки уменьшающие эту вероятность отныне игнорируются.\n\nПометка: иконка перков мода Gilza покажет количество союзников в радиусе: 0 - тусклый белый цвет, 1 - белый цвет, 2 - желтый цвет, 3 - зеленый цвет.",
					menu_deck_brawler9 = "Кровожадный кевлар",
					menu_deck_brawler9_desc = "Вы можете получить вплоть до ##3## одновременных эффектов регенерации брони от данной карточки перка. Если у вас нет ни одного эффекта регенерации брони, вы можете активировать его убив врага. Чтобы получить больше одновременных эффектов вам нужно убивать врагов использую оружие ближнего боя или пилу OVE9000.\n\nЭфеект регенерации брони восполняет ##25## очков брони в течении ##6## секунд с \"тиком\" регенрации раз в ##0.75## секунд.\nИграя на сложности Смертельный Приговор вы будете восполнять ##100## очков брони вместо ##25## за такой же срок.\n\nПометка: иконка перков мода Gilza покажет количество эффектов регенерации которое вы имеете в виде текста \"1x\" под иконкой.\n\nБонус завершения ряда: Вероятность получить предмет высокого качества после завершения контракта увеличина на ##10%##.",
					-- short descs
					menu_deck_brawler1_desc_short = "Ваш запас и подбираемое количество боеприпасов уменьшены. Ваш второй и каждый последующий удар в ближнем бою, нанесёт больше урона. Ваша броня получает сопротивление к пулевому урону.",
					menu_deck_brawler3_desc_short = "Сопротивление к пулевому урону увеличено и штраф к скорости передвижения в броне уменьшен.",
					menu_deck_brawler5_desc_short = "Сопротивление к пулевому урону увеличено и штраф к скорости передвижения в броне уменьшен. Броня получает иммунитет к бронебойному урону.",
					menu_deck_brawler7_desc_short = "Пока ваше здоровье меньше ##50%##, враги будут наносить меньше урона по вам, в зависимости от количество союзников поблизости.",
					menu_deck_brawler9_desc_short = "Убийства в ближнем бою восполняют броню в течении короткого срока.",
				})
			end
			Brawler_str()
			
			local function Speed_Junkie_str()
				LocalizationManager:add_localized_strings({
					menu_deck_SJ = "Под Спидами",
					menu_deck_SJ_desc = "Стимуляция... стимуляция. Нюхни ка. Но ведь этого мало. Проглоти ее. Только этого никогда не хватало. Пусти по вене. И даже это ты уже не замечаешь?!?! Стимуляция. Есть еще один способ раздобыть её.",
					menu_deck_SJ_1 = "Твоё решение",
					menu_deck_SJ_1_desc = "Вы можете иметь вплоть до ##100## стаков адреналина. Быстрое передвижение добавляет адреналин - чем быстрее вы двигаетесь, тем больше стаков вы получаете. Если вы двигаетесь недостаточно быстро ваш адреналин будет уменьшаться.\n\nЗа каждый стак адреналина вы получаете шанс увернуться, вплоть до максимального шанса в ##40%## при ##100## стаках.\n\nЕсли вы будете поддерживать ##90## и более адреналина дольше чем ##4## секунды вы обессилете. Обессилее полностью исчерпывает вашу выносливость и некоторую часть ваших стаков адреналина.\n\nВаша броня теперь может восстанавливаться только когда вы полностью неподвижны.\n\nВы преобразуете ##90%## вашего здоровья в ##42%## брони.\n\nПометка: иконка перков мода Gilza покажет количество стаков адреналина, если ваш уровень адреналина слишком высок (красный) и если вы обессилите (фиолетовый).",
					menu_deck_SJ_3 = "Непереубеждаем",
					menu_deck_SJ_3_desc = "Шанс увернуться увеличен на ##15%##.\n\nВы восстанавливаете ##5%## вашей выносливости за каждое убийство.\n\nВы преобразуете ##90%## вашего здоровья в ##46%## брони.",
					menu_deck_SJ_5 = "Стимуляция",
					menu_deck_SJ_5_desc = "Убийсто врага добавит вам ##10## стаков адреналина.\nЕсли вы убьете врага когда количество стаков адреналина превышает ##90##, вы уменьшите ваш адреналин на ##10## стаков.\n\nДополнительный эффект: вспышка адреналина.\nКогда количество стаков адреналина выше ##70## вы будуте получать ##1## очко вспышки адреналина в секунду. При накоплении ##20## очков вспышки адреналина вы получаете право ее активировать. Если вы имеете право ее активировать, убийство врага имеет ##10%## шанс активировать вспышку адреналина. При активации вспышки, ваши стаки адреналина получают передоз. После окончания вспышки адреналина, вы обессилете, а количество очко вспышки опустится до ##0##.\n\nВы преобразуете ##90%## вашего здоровья в ##52%## брони.",
					menu_deck_SJ_7 = "Только один конец",
					menu_deck_SJ_7_desc = "При удачном увороте от урона вы получите ##15## единиц брони, однако если ваша броня полностью сломана, вы получите ##45## единицы брони. Данный эффект не может срабатывать чаще чем раз в ##1## секунду.",
					menu_deck_SJ_9 = "Передоз.",
					menu_deck_SJ_9_desc = "Ваша скорость передвижения может увеличиться вплоть до ##25%## если ваша броня повреждена - чем меньше процент оставшейся у вас брони, тем выше данный бонус скорости.\n\nАдреналин теперь предоставляет вам дополнительные бонусы которые напрямую зависят от количества стаков. Вы можете получить:\n- Вплоть до ##40%## ускоренную перезарядку оружия\n- Вплоть до ##100%## ускоренную смену оружия\n- Вплоть до ##40%## ускоренного времени взаимодействия с любыми объектами, кроме ответа на пейджеры и поднятия союзников.\n\nБонус завершения ряда: Вероятность получить предмет высокого качества после завершения контракта увеличина на ##10%##.",
					-- short descs
					menu_deck_SJ_1_desc_short = "Открывает стаки адреналина, добавляющие вплоть до ##40%## шанса увернуться. Восстановление брони теперь недоступно в движении. Преобразует здоровье в броню.",
					menu_deck_SJ_3_desc_short = "Добавляет ##15%## шанс увернуться. Убийства восполняют выносливость. Преобразует здоровье в больше брони.",
					menu_deck_SJ_5_desc_short = "Убийсива добавляют ##10## стаков адреналина. Преобразует здоровье в больше брони. Новый эффект: вспышка адреналина.",
					menu_deck_SJ_7_desc_short = "Уклонение предоставляет ##15-45## единиц брони раз в ##1## секунду.",
					menu_deck_SJ_9_desc_short = "Вы двигаетесь вплоть до ##25%## быстрее, в зависимости от поврежденности брони. Стаки адреналина теперь ускоряют скорость взаимодействия, перезарядки и смены оружия.",
				})
			end
			Speed_Junkie_str()
			
			local function Guardian_str()
				LocalizationManager:add_localized_strings({
					menu_deck_Gilza_guardian = "Страж",
					menu_deck_Gilza_guardian_desc = "Страж. Настоящий защитник.\nЗа свои годы ограблений вы заметили одну закономерность - чем лучше вы можете удерживать позицию, тем легче у вас получается защищать эту ебучую дрель, и быстрее уматывать обратно в убежище. После самообучения всем известным способам держать оборону, вы превратились в неодолимую стену. Никто и ничто не способно вас сдвинуть. Если бы вы только не забыли о некоторых вещах во время своего обучения...",
					menu_deck_Gilza_guardian_1 = "Время окопаться",
					menu_deck_Gilza_guardian_1_desc = "Ваша скорость передвижения уменьшена на ##20%##.\nВремя взаимодействия с любыми объектами, кроме пейджеров и окозания помощи напарникам, замедлены на ##50%##.\n\nБудучи в игре ваша броня не может быть выше ##0##.\n\nВы получаете возможность создать личную оборонную позицию, если вы будете неподвижно стоять в течении ##5## секунд. Данная позиция имеет ##3м## радиус. Если вы будете находиться вне зоны вашей позиции дольше ##8## секунд, позиция будет удалена. Вам придется подождать еще ##8## секунд, перед тем как вы сможете создать новую позицию.\n\nПока вы стоите внутри вашей оборонной позиции, вы восполняете ##10## единиц здоровья раз в ##2## секунды.\n\nПометка: иконка перков мода Gilza покажет если вы в данный момент внутри вашей оборонной позиции (яркий белый), и если ваша оборонная позиция существует, но вы вне ее пределов (тусклый белый).",
					menu_deck_Gilza_guardian_3 = "Личные границы",
					menu_deck_Gilza_guardian_3_desc = "Пока вы находитесь внутри своей оборонной позиции вы не можете получить больше чем ##160## урона за попадание, но вы так же не можете получить меньше чем ##80## урона за попадание.\nПока вы находитесь вне своей оборонной позиции вы не можете получить больше чем ##200## урона за попадание, но вы так же не можете получить меньше чем ##100## урона за попадание.\n\nВы получаете ##100%## бонусного здоровья.\n\nПока вы стоите внутри вашей оборонной позиции, вы теперь будете восполнять ##20## единиц здоровья раз в ##2## секунды.",
					menu_deck_Gilza_guardian_5 = "Я непробиваем",
					menu_deck_Gilza_guardian_5_desc = "Вы получаете еще ##150%## бонусного здоровья.\n\nСовершая убийство находясь внутри вашей оборонной позиции вы восполняете ##20## единиц здоровья. Количество восполняемого здоровья ##множится на 3## если вы играете на сложности Смертный Приговор.\n\nПока вы стоите внутри вашей оборонной позиции, вы теперь будете восполнять ##30## единиц здоровья раз в ##2## секунды.\n\nВаша оборонная позиция теперь имеет ##5м## радиус.\n\nМедицинская сумка и Аптечка первой помощи теперь восполняют только ##50%## вашего здоровья.",
					menu_deck_Gilza_guardian_7 = "Дикобраз",
					menu_deck_Gilza_guardian_7_desc = "За каждые ##10## единиц надетой вами брони вы получаете ##3%## шанс автоматически нанести урон врагу который выстрелил по вам. Данный урон идентичен полученому вами урону.\n\nВы теперь можете создать вашу оборонную позицию стоя на месте только ##3## секунды.",
					menu_deck_Gilza_guardian_9 = "От обороны до атаки..",
					menu_deck_Gilza_guardian_9_desc = "Если вы не имеете оборонной позиции, и вы уже можете создать новую позицию, вы можете создать ее убив врага.\n\nПока вы находитесь внутри вашей оборонной позиции вы автоматически подбираете боеприпасы оставленные врагами.*\n\nПока вы находитесь внутри своей оборонной позиции вы не можете получить больше чем ##120## урона за попадание, но вы так же не можете получить меньше чем ##60## урона за попадание.\nПока вы находитесь вне своей оборонной позиции вы не можете получить больше чем ##160## урона за попадание, но вы так же не можете получить меньше чем ##80## урона за попадание.\n\nБонус завершения ряда: Вероятность получить предмет высокого качества после завершения контракта увеличина на ##10%##.\n\n*Gilza: из-за того как данный навык работает, может пройти вплоть до 3 секунд (зависит от пинга), перед тем как вы подберете патроны, будучи клиентом лобби.",
					-- short descs
					menu_deck_Gilza_guardian_1_desc_short = "Ваша скорость передвижения и взаимодействия с объектами уменьшена. Вы теряете всю броню. Вы можете создать оборонную позицию восполняющую ваше здоровье.",
					menu_deck_Gilza_guardian_3_desc_short = "Проходящий по вам урон теперь будет увеличиваться если он слишком мал и уменьшаться если он слишком велик. Вы получаете здоровье, и увеличенную скорость регенерации здоровься.",
					menu_deck_Gilza_guardian_5_desc_short = "Вы получаете больше здоровья, регенерации здоровья, и регенерацию здоровья за убийства.",
					menu_deck_Gilza_guardian_7_desc_short = "Вы можете автоматически отражать нанесеный по вам урон.",
					menu_deck_Gilza_guardian_9_desc_short = "Вы автоматически подбираете боезапас со своих убийств. Вы получаете меньше урона.",
				})
			end
			Guardian_str()
			
		end
		Perk_strings_custom()
		
		local function Skill_strings()
			
			local function Mastermind_str()
				LocalizationManager:add_localized_strings({
					-- M1
					menu_combat_medic_beta_desc = "БАЗОВЫЙ: ##$basic;##\nВы получаете ##25%## сопротивления урону во время поднятия напарника и в течение ##5## секунд после окончания помощи.\n\nПРО: ##$pro;##\nПосле успешной помощи напарнику, вы получаете ##35%## вашей максимальной брони.\n\nЕсли вы используете перк Стоик или Страж, улучшенный до навыка убирающий вашу броню, вы получите ##35%## здоровья вместо брони.\n\nДанный навык не распространяется на ПРО версию навыка Вдохновление.",
					menu_inspire_beta_desc = "БАЗОВЫЙ: ##$basic##\nВы поднимаете напарников быстрее на ##100%##. Если вы крикните на вашего напарника, вы и ваш напарник получите моральный буст на ##10## секунд. Данный буст увеличивает скорость передвижения и перезарядки на ##20%## для вашего напарника и на ##10%## для вас.\n\nПРО: ##$pro##\nВы можете поднять напарника с вероятностью ##100%##, если вы крикните на него. Ваш крик от данного навыка имеет ##9## метровый радиус и не может быть использован чаще чем раз в ##20## секунд.",
					-- M2
					menu_triathlete_beta_desc = "БАЗОВЫЙ: ##$basic;##\nКоличество переносимых кабельных стяжек увеличено на ##4##. Скорость связывания заложников увеличена на ##75%##.\n\nВы и ваши напарники будете получать по ##0.5## поглощения урона за каждого связанного заложника. Данный эффект складывается до максимума в ##8## заложников.\n\nПометка: Данный навык не складывается сам с собой.\n\nПРО: ##$pro;##\nВзятого в заложники врага можно уговорить сражаться на вашей стороне. Вы можете перевести только одного врага на свою сторону. Навык работает только после поднятия тревоги, и не рапространяется на специальных врагов.",
					menu_joker_beta_desc = "БАЗОВЫЙ: ##$basic;##\nВраг сражающийся на вашей стороне больше не наносит на ##35%## меньше урона.\nВремя затрачиваемое на уговор противника уменьшено на ##65%##.\n\nПРО: ##$pro;##\nТеперь вы можете перевести на свою сторону до ##2## врагов одновременно.",
					menu_cable_guy_beta_desc = "БАЗОВЫЙ: ##$basic;##\nУбедительность и дальность вашего запугивания увеличена на ##50%##.\n\nПРО: ##$pro;##\nГражданские остаются запуганными на ##50%## дольше. Шум, создаваемый вами, устрашает гражданских.",
					menu_stockholm_syndrome_beta_desc = "БАЗОВЫЙ: ##$basic;##\nУбийство гражданского дает вам ##1.5## очко(в) запугивания. Убийство взятого в заложники врага дает вам ##0.25## очко(в) запугивания. Вы не можете иметь больше ##4## очков запугивания. При попадании в тюрьму ваши очки запугивания збрасываются до ##0##.\n\nПри убийстве противника у вас есть ##10%## шанс посеять панику в ##10## метровом радиусе от вас. Паника будет подавлять противника, периодически заставляя его испытывать приступы неконтролируемого страха.\nЗа каждое ##1## очко запугивания вы увеличиваете свой шанс посеять панику на ##10%##, и увеличиваете количество создаваемой паники, что увеличит шансы врагов оставаться в паническом состоянии дольше.\n\nПРО: ##$pro;##\nВаши заложники не станут убегать, если они были освобождены полицией. Как только вы попадёте в тюрьму, они попытаются обменять себя на вас. Этот эффект может сработать даже во время полицейского штурма, но только ##1## раз за день ограбления.",
					-- M3
					menu_stable_shot_beta_desc = "БАЗОВЫЙ: ##$basic;##\nВаше оружие точнее на ##4## единицы.\n\nПРО: ##$pro;##\nВаше оружие точнее на еще ##12## единиц.",
					menu_rifleman_beta = "Стрелок в отставке",
					menu_rifleman_beta_desc = "БАЗОВЫЙ: ##$basic;##\nВы прицеливаетесь на ##100%## быстрее с любым оружием.\nПриближение (зум) прицела у всего оружия увеличен на ##0-2x##. Данный бонус можно изменить в настройках мода Gilza.\n\nКогда вы начинаете стрелять из своего оружия, первые ##5## пуль имеют на ##15%## меньше отдачи. Не распространяется на Дробовики, Снайперские винтовки и Пистолеты стреляющие в одиночном режиме стрельбы.\n\nПРО: ##$pro;##\nВо время прицеливания вы двигаетесь без штрафа к скорости передвижения.\n\nКогда вы начинаете стрелять из своего оружия, бонус к отдаче теперь рапространяется на первые ##10## пуль, а сама отдача уменьшена на ##50%##.",
					menu_sharpshooter_beta = "Медленно но верно",
					menu_sharpshooter_beta_desc = "БАЗОВЫЙ: ##$basic##\nВы получаете ##7.5%## сопротивления урону если вы не двигаетесь.\n\nПРО: ##$pro##\nВы получаете дополнительные ##30%## сопротивления урону если ваше оружие стоит на сошках.\nВаша скорость установки сошек увеличина на ##100%##.",
					menu_speedy_reload_beta = "Экономика тел",
					menu_speedy_reload_beta_desc = "БАЗОВЫЙ: ##$basic##\nПовышает скорость перезарядки штурмовых винтовок, пистолетов-пулемётов и снайперских винтовок на ##20%##.\n\nИспользуя штурмовую винтовку, пистолет-пулемёт или снайперскую винтовку в одиночном режиме стрельбы, убийство противника в тело будет восполнять боезапас ваших оружий в количестве ##10%## от одной пачки боеприпасов оставленной врагом.\n\nПРО: ##$pro##\nУбийство врагов в одиночном режиме стрельбы теперь восполняет ##40%## от одной пачки боеприпасов.\n\nИспользуя штурмовую винтовку, пистолет-пулемёт или снайперскую винтовку в одиночном режиме стрельбы, убийство противника в тело увеличет скорость перезарядки с любым оружием на ##7.5%## вплоть до ##75%##. Убийство после удачной перезарядки сбросит данный бонус до ##0##.",
					menu_sniper_graze_damage_desc = "БАЗОВЫЙ: ##$basic;##\nЕсли выстрел попал по противнику находившемуся дальше чем ##6м## от вас, все противники в ##80см## радиусе полёта пули получат зацепляющий урон.\nЗацепляющий урон равен урону вашего оружия + доступные вам навыки увеличивающие урон, умноженный на ##0.33##. Зацепляющий урон не увеличивается при попадании в голову.\nВраги убитые зацепляющим уроном расцениваются как убийства в тело.\n\nДанный навык может быть активирован только штурмовыми винтовками, пистолетами-пулемётами и снайперскими винтовками в одиночном режиме стрельбы.\n\nПРО: ##$pro;##\nЗацепляющий урон теперь имеет радиус ##160см## а множитель урона увеличен до ##0.66%##.",
				})
			end
			Mastermind_str()
			
			local function Enforcer_str()
				LocalizationManager:add_localized_strings({
					-- E1
					menu_underdog_beta_desc = "БАЗОВЫЙ: ##$basic;##\nПока вас окружают как минимум три видимых врага в пределах ##18## метров от вас, вы получаете ##10%## бонус к урону. Этот бонус остаеется с вами в течении еще ##5## секунд после того как вы больше не окружены.\n\nПометка: бонусный урон не рапространяется на урон в ближнем бою, метательное оружие, гранатометы и ракетометы.\n\nПРО: ##$pro;##\nПока вас окружают как минимум три видимых врага в пределах ##18## метров от вас, вы получаете ##10%## сопротивления урону. Это сопротивление остаеется с вами в течении еще ##5## секунд после того как вы больше не окружены.",
					menu_shotgun_cqb_beta_desc = "БАЗОВЫЙ: ##$basic##\nВаша скорость перезарядки с дробовиками улучшена на ##15%##.\n\nПРО: ##$pro##\nВаша скорость перезарядки с дробовиками теперь улучшена на ##50%##.",
					menu_shotgun_impact_beta = "Эксперт по дробовикам",
					menu_shotgun_impact_beta_desc = "БАЗОВЫЙ: ##$basic;##\nСтабильность дробовиков улучшена на ##20%##.\n\nВаша скорость прецеливания с дробовиками улучшена на ##125%##.\n\nПРО: ##$pro;##\nСтабильность дробовиков улучшена на еще ##30%##.\n\nВы получаете ##30%## бонус к точности при прицеливании с дробовиками.",
					menu_far_away_beta = "БЕЗДУМНЫЙ РАЗНОС",
					menu_far_away_beta_desc = "БАЗОВЫЙ: ##$basic##\nПри каждом выстреле из Дробовика вы имеете ##6.5%## шанс выстрелить не потратив боезапас.\n\nПРО: ##$pro##\nВаши шансы выстрела без траты боезапаса увеличины до ##20%##.\n\nПометка: данный навык распространяется как на ваш общий боезапас, так и на оружейный магазин.",
					menu_close_by_beta = "РАЗЖИГАТЕЛЬ СТРАХА",
					menu_close_by_beta_desc = "БАЗОВЫЙ: ##$basic;##\nСтрельба на бегу: вы можете стрелять из дробовиков от бедра во время бега.\n\nПРО: ##$pro;##\nУбив противника Дробовиком, с подавлением ##35## и выше, у вас есть ##75%## шанс посеять панику в ##12## метровом радиусе от вас. Паника будет подавлять противника, периодически заставляя его испытывать приступы неконтролируемого страха.\n\nУбийство противника испытывающего приступ страха, полностью восстанавливает вашу выносливость и дает ##25%## бонус к скорости передвижения на ##20## секунд.\n\nПометка: при активации данный навык показывает оповещение на экране. Вы можете отключить его в настройках мода Gilza.",
					menu_overkill_beta_desc = "БАЗОВЫЙ: ##$basic;##\nПосле убийства врага с помощью дробовика или пилы OVE9000, вы получаете Overkill™ буст который длится ##30## секунд. Пока буст активен ваши Дробовики и пила OVE9000 наносят на ##40%## больше урона и перезаряжаются на ##50%## быстрее.\n\nПРО: ##$pro;##\nБонусы от буста Overkill™ теперь применяется ко всему оружию. Навык должен быть активирован с помощью дробовика или пилы OVE9000. Время переключения между оружием уменьшено на ##80%##.\n\nПометка: бонусный урон навыка не распространяется на урон в ближнем бою, метательное оружие, гранатометы и ракетометы.",
					-- E2
					menu_show_of_force_beta_desc = "БАЗОВЫЙ: ##$basic;##\nВы получаете ##40%## сопротивления урону пока вы взаимодействуете с каким-либо объектом.\n\nПРО: ##$pro;##\nПрочность всех баллистических бронежилетов увеличена на ##20##.",
					menu_pack_mule_beta_desc = "БАЗОВЫЙ: ##$basic;##\nЗа каждые ##10## единиц брони штраф к скорости передвижения при переносе сумок с добычей уменьшен на ##1%##.\n\nПРО: ##$pro;##\nВы теперь можете бегать с любой сумкой.",
					menu_iron_man_beta_desc = "БАЗОВЫЙ: ##$basic;##\nУвеличивает скорость восстановления брони у вас и у напарников на ##25%##.\n\nПометка: Данный навык не складывается сам с собой.\n\nПРО: ##$pro;##\nПри стрельбе по щитовику, у вас есть шанс отбросить его назад. Чем больше урона у вашего оружия, тем выше шанс.\n\nШанс отбросить щитовика назад при использовании оружия ближнего боя равен ##100%##.",
					menu_prison_wife_beta_desc = "БАЗОВЫЙ: ##$basic;##\nВы восполняете ##5## единиц брони за удачное попадание в голову. Навык срабатывает только один раз в ##2## секунды.\n\nПРО: ##$pro;##\nКоличество восполняемой брони от данного навыка увеличено до ##25## единиц, а кулдаун снижен до ##1.5## секунд.",
					-- E3
					menu_ammo_2x_beta_desc = "БАЗОВЫЙ: ##$basic;##\nВ каждой сумке с патронами на ##50%## больше патронов.\n\nПРО: ##$pro;##\nПозволяет устанавливать ##2## сумки с патронами вместо одной.",
					menu_carbon_blade_beta_desc = "БАЗОВЫЙ: ##$basic;##\nАтака врагов портативной пилой OVE9000 изнашивает лезвия на ##50%## меньше.\n\nПРО: ##$pro;##\nТеперь вы можете прорезать щитовиков своей пилой OVE9000. Убив противника пилой, у вас есть ##50%## шанс посеять панику в ##10## метровом радиусе. Паника будет подавлять противника, заставляя его испытывать страх.\n\nВраги теперь оставляют боезапас к пиле. Подбор боезапаса пилы не может быть увеличен/уменьшен другими навыками влияющими на подбор боезапаса.",
					menu_bandoliers_beta_desc = "БАЗОВЫЙ: ##$basic;##\nПовышает количество переносимых боеприпасов на ##25%##.\n\nПРО: ##$pro;##\nВраги оставляют на ##75%## больше боеприпасов. У вас есть ##10%## шанс найти метательное оружие в оставленных врагами боеприпасах. Шанс увеличивается на ##3% * x## (где x - метательный множитель) за каждый подобранный боеприпас, в котором не было метательного оружия. Когда метательное оружие будет найдено в боеприпасах, шанс будет сброшен к стандартному значению.\n\nПометки:\nНавык не складывается с бонусом \"Тяжёлый пехотинец\" из набора перков.\nМетательный множитель зависит от используемого вами метательного оружия, а его значение можно узнать в описании каждого метательного оружия.",
				})
			end
			Enforcer_str()
			
			local function Technician_str()
				LocalizationManager:add_localized_strings({
					-- T1
					menu_defense_up_beta_desc = "БАЗОВЫЙ: ##$basic;##\nВаши турели стоят на ##10%## меньше амуниции, чтобы её поставить.\n\nПРО: ##$pro;##\nУ ваших турелей на ##150%## больше здоровья.\n\nТурели получает дополнительные ##50%## боеприпасов.",
					menu_sentry_targeting_package_beta = "Маленький помощник",
					menu_sentry_targeting_package_beta_desc = "БАЗОВЫЙ: ##$basic;##\nПовышает точность ваших турелей на ##100%##.\n\nСкорость вращения турелей увеличена на ##150%##.\n\nПРО: ##$pro;##\nУ турелей появляется защитный экран.",
					menu_eco_sentry_beta = "Оружейное масло",
					menu_eco_sentry_beta_desc = "БАЗОВЫЙ: ##$basic;##\nСкорострельность ваших штурмовых винтовок, пистолет-пулеметов и пулеметов увеличена на ##30##.\n\nПРО: ##$pro;##\nСкорострельность ваших штурмовых винтовок, пистолет-пулеметов и пулеметов теперь увеличена на ##150##.",
					menu_tower_defense_beta_desc = "БАЗОВЫЙ: ##$basic;##\nТеперь у вас есть ещё ##3## дополнительные турели.\n\nПРО: ##$pro;##\nКоличество турелей которые вы можете переносить теперь уменьшено на ##1##.\nЕсли ваша турель будет уничтожена, вы можете подобрать ее обратно, но патроны оставшиеся в туреле не будут восполнены.\n\nПока вы находитесь в ##8м## от турели, вы получаете ##10%## сопротивления урону.\n\nЕсли ваша турель совершает убийство, вы получаете патроны, равные ##25%## стандартной пачки боезапаса которые оставляют враги после смерти. Данный бонус не увеличивает шансы подбора гранат.\nВраги все еще будут оставлять боезапас после смерти, который вы можете поднять со стандартным количеством патронов.",
					-- T2
					menu_hardware_expert_beta_desc = "БАЗОВЫЙ: ##$basic;##\nВы чините дрели и пилы на ##15%## быстрее. Время нужное для установки мин уменьшено на ##20%##. Ваши пилы и дрели бесшумны. Гражданские и охранники должны увидеть их, чтобы поднять тревогу.\n\nПРО: ##$pro;##\nВаши дрели и пилы имеют ##10%## шанс получить возможность автоматически продолжить работу после поломки. Данный шанс может быть испытан только один раз для каждой пилы или дрели. Если шанс был удачен, данная возможность останется с дрелью до конца ее работы. Дрель автоматически продолжит работу только спустя несколько секунд после поломки, вне зависимости от причины поломки.\n\nПометка: навык не распространяется на пилу OVE9000.",
					menu_kick_starter_beta_desc = "БАЗОВЫЙ: ##$basic;##\nВаши дрели и пилы получают дополнительные ##20%## к шансу получения возможности автоматически продолжить работу после поломки. Данный шанс может быть испытан только один раз для каждой пилы или дрели. Есил шанс был удачен, данная возможность останется с дрелью до конца ее работы. Дрель автоматически продолжит работу только спустя несколько секунд после поломки, вне зависимости от причины поломки.\n\nПРО: ##$pro;##\nТеперь вы можете починить дрель или пилу, ударив по ней оружием ближнего боя - шанс что у вас это получится равен ##50%##. Данный навык срабатывает только один раз за поломку дрели или пилы.\n\nТеперь вы чините дрели и пилы на ##50%## быстрее.\n\nПометка: действие навыка не распространяется на пилу OVE9000.",
					menu_fire_trap_beta_desc = "БАЗОВЫЙ: ##$basic;##\nВаши мины оставляют на месте взрыва огненную ловушку в течение ##10## секунд в ##4## метровом радиусе.\n\nПРО: ##$pro;##\nДлительность огненной ловушки увеличена до ##30## секунд. Радиус поражения увеличен на ##75%##.",
					-- T3
					menu_steady_grip_beta_desc = "БАЗОВЫЙ: ##$basic;##\nВаше оружие стабильнее на ##4## единицы.\n\nПРО: ##$pro;##\nВаше оружие стабильнее на еще ##12## единиц.",
					menu_heavy_impact_beta_desc = "БАЗОВЫЙ: ##$basic##\nВаши выстрелы теперь могут оглушать всех противников за исключением Бульдозера и Капитана Уинтерса сбивая их с ног. Ваш базовый шанс оглушения равен ##5%##, который затем множится на ##модификатор подавления##.\n\nПРО: ##$pro##\nУвеличивает базовый шанс оглушения до ##20%##.\n\nПометка: Модификатор подавления напрямую зависит от подавления оружия: при показателе подавления ##0## ваш шанс умножается на ##1x##, увеличиавясь вплоть до ##3x## когда подавление выше или равно ##40##.",
					menu_fire_control_beta_desc = "БАЗОВЫЙ: ##$basic;##\nВаш ##36## единичный штраф к отдаче во время стрельбы от бедра аннулируется.\n\nПРО: ##$pro;##\nВаш ##28## единичный штраф к точности во время стрельбы от бедра аннулируется.",
					menu_shock_and_awe_beta_desc = "БАЗОВЫЙ: ##$basic;##\nСтрельба на бегу: вы можете стрелять от бедра во время бега.\n\nПРО: ##$pro;##\nУбив ##3## противников с пистолета-пулемета, пулемета, штурмовой винтовки или особого оружия в режиме автоматической стрельбы, скорость вашей следующей перезарядки будет увеличена.\nМинимальный бонус к скорости перезарядки равен ##35%##. Данный бонус увеличивается на ##1%## за каждую выстреленную вами пулю перед началом перезарядки. Первые отстреленные ##15## пуль не увеличивают данный бонус. Максимальный бонус перезарядки данного навыка равен ##125%##.\n\nПометка: Навыки повозляющие вам стрелять не тратя боезапас, и базовая версия навыка \"Шквальный Огонь\" не учитываются при вычислении бонуса скорости перезарядки данного навыка.",
					menu_fast_fire_beta_desc = "БАЗОВЫЙ: ##$basic##\nВаши пистолеты-пулеметы, пулеметы и штурмовые винтовки получают прибавку в виде ##15## патронов в магазинах. Данный навык не работает с ПРО версией навыка \"Оружие к бою\".\n\nПРО: ##$pro##\nВаши шансы пробить вражескую нательную броню увеличены на ##25%##.\n\nЕсли ваши шансы пробить нательную броню дадут вам позитивный результат, вы нанесете полный урон по врагу. Однако если вам не повезет, вы все равно сможете пробить вражескую нательную броню, но урон от такого пробития будет уменьшен на ##50%##.",
					menu_body_expertise_beta_desc = "БАЗОВЫЙ: ##$basic;##\nМножитель бонусного урона при попадании в голову теперь применяется и при попадании по телу противника, с эффективностью в ##100%##. Навык не рапространяется на Бульдозера и Капитана Уинтерса.\nЭтот навык работает только с пистолетами-пулемётами, пулемётами, миниганами и штурмовыми винтовками если вы используете их в режиме автоматической или очередной стрельбы, а так же при использовании луков, арбалетов и пилы OVE9000.\n\nПРО: ##$pro;##\nБонусный урон при попадании в тело увеличен до ##125%##.\n\nЕсли ваши шансы пробить нательную броню не дадут вам позитивный результат вы все равно сможете пробить вражескую нательную броню, но урон от такого пробития будет уменьшен на ##50%##.\nПри совмещении с ПРО версией навыка \"Шквальный огонь\" штраф к урону при стрельбе сквозь нательную броню, в случае когда ваш шанс пробития не был успешен, аннулируется.",
				})
			end
			Technician_str()
			
			local function Ghost_str()
				LocalizationManager:add_localized_strings({
					-- G1
					menu_jail_workout_beta = "Свой человек",
					menu_jail_workout_beta_desc = "БАЗОВЫЙ: ##$basic##\nТеперь вы можете приобрести услуги \"своего человека\".\n\nПРО: ##$pro##\nВы можете подбирать предметы в режиме исследования. Мелкие ценные предметы, украденные вами, стоят на ##30%## дороже.",
					menu_asset_lock_additional_assets = "Необходима БАЗОВАЯ версия навыка \"Свой Человек\"",
					menu_cleaner_beta_desc = "БАЗОВЫЙ: ##$basic##\nВы можете носить с собой ##1## дополнительный мешок для трупов. Теперь у вас будет ##3## мешка для трупов.\nПомимо этого, денежный штраф за убийство гражданских уменьшен на ##75%##.\n\nПРО: ##$pro##\nВы можете устанавливать ##2## кейса с мешками для трупов.\nТеперь вы можете приобрести услугу \"Кейс с мешками для трупов.\"",
					menu_asset_lock_buy_bodybags_asset = "Необходима ПРО версия навыка \"Чистильщик\"",
					menu_chameleon_beta = "Осведомленность",
					menu_chameleon_beta_desc = "БАЗОВЫЙ: ##$basic##\nВы на ##25%## скрытнее для гражданских и врагов до тех пор, пока не наденете маску. Вы можете подсвечивать охрану и камеры в режиме исследования.\nТеперь вы можете приобрести услуги \"камера-шпион\" и \"наблюдатель\".\n\nПРО: ##$pro##\nКогда вы стоите не двигаясь в течение ##3.5## секунд, противники будут подсвечиваться вокруг вас в радиусе ##10## метров. Навык действует только до тех пор, пока вы остаётесь незамеченным.",
					menu_asset_lock_buy_spotter_asset = "Необходима БАЗОВАЯ версия навыка \"Осведомленность\"",
					-- G2
					menu_awareness_beta_desc = "БАЗОВЫЙ: ##$basic;##\nСкорость подъёма по навесным лестницам увеличена на ##20%##.\n\nВертикальная и горизонтальная сила вашего прыжка увеличина на ##20%##.\n\nТеперь вы можете бегать в любом направлении.\n\nПРО: ##$pro;##\nВы получаете ##1## заряд сопротивления смертельному урону от падения. Если вы упадете со смертельной высоты, вы потратите один заряд и выживите. Заряд(ы) сопротивления смертельному урону можно восполнить с помощью медицинской сумки.\n\nПерезарядка на бегу: вы можете перезаряжаться во время бега. Вы можете отменить данную перезарядку нажав на клавишу \"Выстрелить\" если магазин вашего оружия не пуст.",
					menu_dire_need_beta = "Подлый ублюдок",
					menu_dire_need_beta_desc = "БАЗОВЫЙ: ##$basic;##\nШанс увернуться от вражеского огня увеличивается на ##1%## за каждые ##3## пункта риска обнаружения меньше ##35##. Навык складывается вплоть до ##10%##.\n\nПРО: ##$pro;##\nШанс увернуться от вражеского огня увеличивается на ##1%## за каждый ##1## пункт риска обнаружения меньше ##35##. Навык складывается вплоть до ##10%##.",
					menu_insulation_beta = "Обратный эффект",
					menu_insulation_beta_desc = "БАЗОВЫЙ: ##$basic##\nКогда вы остались без брони, первый выстрел по противнику отбросит его назад. Эффект работает до тех пор, пока ваша броня не восстановилась и затем еще ##2## секунды.\n\nПРО: ##$pro##\nКогда тэйзер оглушил вас током, у вас есть ##2## секунды, чтобы вырваться из его плена. После ##2## секунд эффект шока будет автоматически направлен обратно на тэйзера.\n\nЕсли вас ударило током каким-либо образом, ваши пули заряжаются электричеством на ##20## секунд, что позваляет вам оглушать током всех противников, кроме Бульдозера и Капитана Уинтерса, на расстоянии.",
					menu_jail_diet_beta = "Оживленный",
					menu_jail_diet_beta_desc = "БАЗОВЫЙ: ##$basic##\nУдачный уворот от урона предоставит вам ##10## единиц брони если ваша броня полностью разбита. Данный эффект не может срабатывать чаще чем раз в ##25## секунд.\n\nПРО: ##$pro##\nКоличество получаемой брони от данного навыка увеличено до ##40## единиц, а кулдаун уменьшен до ##10## секунд.",
					-- G3
					menu_silence_expert_beta_desc = "БАЗОВЫЙ: ##$basic;##\nПовышает стабильность оружия с установленным глушителем на ##8##. Вы прицеливаетесь на ##100%## быстрее со всем оружием, на котором установлен глушитель.\n\nВаши шансы пробить вражескую нательную броню увеличены на ##15%## при использовании оружия с установленным глушителем.\n\nПРО: ##$pro;##\nТочность оружия с установленным глушителем увеличена на ##12##.\n\nВаши шансы пробить вражескую нательную броню увеличены на еще ##35%## при использовании оружия с установленным глушителем.",
					menu_backstab_beta_desc = "БАЗОВЫЙ: ##$basic;##\nВы можете нанести критический урон с вероятностью ##3%## за каждые ##3## пункта риска обнаружения меньше ##35##. Навык складывается вплоть до ##30%##.\n\nПРО: ##$pro;##\nВы можете нанести критический урон с вероятностью ##3%## за каждый ##1## пункт риска обнаружения меньше ##35##. Навык складывается вплоть до ##30%##.\n\nПометки:\n-Успешный крит увеличивает ваш урон в ##2.25x## раза.\n-Действие навыка не распространяется на гранатомёты.",
					menu_unseen_strike_beta_desc = "БАЗОВЫЙ: ##$basic;##\nЕсли, после получения урона, вы не получите урон в течении ##6## или более секунд, будучи в укрытии либо уворачиваясь от пуль, вы получаете право активировать эффект Исподтишка. Если вы получите урон пока вы имеете право на активацию, вы лишаетесь этого права.\n\nВы можете получить эффект Исподтишка только если вы имеете на это право, у вас его нету в данный момент, и как минимум ##6## секунд прошло после того как этот эффект был активен последний раз.\n\nПри аквтивации, эффект Исподтишка увеличивает ваши шансы нанести критический урон на ##35%## в течении ##6## секунд.\n\nПРО: ##$pro;##\nПри аквтивации, эффект Исподтишка теперь будет увеличивать ваши шансы нанести критический урон в течении ##18## секунд.\n\nПометка: \n-Успешный крит увеличивает ваш урон в ##2.25x## раза.\n-Действие навыка не распространяется на гранатомёты.",
				})
			end
			Ghost_str()
			
			local function Fugitive_str()
				LocalizationManager:add_localized_strings({
					-- F1
					menu_equilibrium_beta_desc = "БАЗОВЫЙ: ##$basic;##\nУменьшает на ##33%## время, нужное, чтобы достать и убрать пистолеты.\n\nПРО: ##$pro;##\nУменьшает на ##50%## время, нужное, чтобы достать и убрать пистолеты.\n\nПовышает точность пистолетов на ##12##.",
					menu_dance_instructor_desc = "БАЗОВЫЙ: ##$basic;##\nПовышает скорострельность пистолетов на ##20%##.\n\nПРО: ##$pro;##\nВы перезаряжаете пистолеты на ##33%## быстрее.",
					menu_gun_fighter_beta = "Однорукий бандит",
					menu_gun_fighter_beta_desc = "БАЗОВЫЙ: ##$basic##\nКаждое попадание из пистолета увеличивает вашу точность с пистолетами на ##32%## в течение ##6## секунд и может складываться до ##1## раз.\n\nПРО: ##$pro##\nКаждое попадание из пистолета даёт ##75%## к наносимому урону пистолетов на ##6## секунд и может складываться до ##1## раз.",
					menu_expert_handling = "Вдвоем веселей",
					menu_expert_handling_desc = "БАЗОВЫЙ: ##$basic##\nВаши парные пистолеты получают следующие бонусы:\n - ##16## стабильности\n - ##12## точности\n - ##35%## бонус с скорости перезарядки\n - ##удвоенная## скорость смены оружия\n\nПРО: ##$pro##\nВаши парные пистолет-пулеметы теперь тоже получают эти бонусы.",
					menu_trigger_happy_beta = "БЕЗДОННЫЕ КАРМАНЫ",
					menu_trigger_happy_beta_desc = "БАЗОВЫЙ: ##$basic##\nВы получаете на ##50%## больше боезапаса для пистолетов и пистолет-пулеметов.\n\nПРО: ##$pro##\nВы получаете на еще ##100%## больше боезапаса для пистолетов и пистолет-пулеметов.\n\nВсе вторичное оружие больше не имеет ##30%## штрафа к количеству подбираемого боезапаса.",
					-- F2
					menu_running_from_death_beta_desc = "БАЗОВЫЙ: ##$basic;##\nВы перезаряжаете и переключаетесь между оружием на ##100%## быстрее в течение ##30## секунд после того, как вас подняли.\n\nПРО: ##$pro;##\nСкорость вашего передвижения увеличена на ##30%## в течение ##30## секунд после того, как вас подняли.",
					menu_up_you_go_beta_desc = "БАЗОВЫЙ: ##$basic;##\nВы получаете на ##30%## меньше урона в течение ##10## секунд после того, как вас подняли.\n\nПРО: ##$pro;##\nВы получаете дополнительные ##30%## от своего максимального здоровья когда вас подняли.",
					menu_perseverance_beta_desc = "БАЗОВЫЙ: ##$basic##\nВместо того чтобы сразу упасть, вы сможете сражаться ещё ##4## секунды. Скорость передвижения при этом будет уменьшена на ##60%##.\nДанный навык не срабатывает при падении с высоты или если вы упали под воздействием огня.\n\nШтраф к скорости передвижения Лебединой Песни будет проигнорирован на ##3## секунды, если в момент активации навыка, или на протяжении его действия, ваш союзник упал.\n\nПРО: ##$pro##\nВремя действия навыка увеличено до ##8## секунд.\n\nВо время действия навыка ваш боезопас будет исчерпываться напрямую из вашего запаса, вместо магазина, а ваш урон будет увеличен на ##50%##.",
					menu_pistol_beta_messiah_desc = "БАЗОВЫЙ: ##$basic;##\nВы самостоятельно подниметесь на ноги, если убьёте врага когда вы лежите. Навык срабатывает только ##1## раз.\n\nКогда вы лежите, вы имеете почти бесконечное здоровье.\n\nПРО: ##$pro;##\nВы сможете снова использовать навык, если воспользуетесь медицинской сумкой.",
					-- F3
					menu_martial_arts_beta = "КРЕПКИЙ ПАРЕНЬ",
					menu_martial_arts_beta_desc = "БАЗОВЫЙ: ##$basic##\nПовышает шанс сбить врага с ног рукопашной атакой на ##50%##.\nТряска камеры при получении урона в ближнем бою снижена на ##30%##.\n\nПРО: ##$pro##\nБлагодаря интенсивным тренировкам, вы получаете на ##50%## меньше урона в рукопашном бою.\nТряска камеры при получении урона в ближнем бою теперь снижена на ##90%##.",
					menu_bloodthirst_desc = "БАЗОВЫЙ: ##$basic;##\nКаждый раз, когда вы убиваете врага, урон от оружия ближнего боя будет увеличен на ##20%##, до максимума в ##300%##.\n\nПометка: прибавка к урону работает до тех пор, пока вы не убьёте врага оружием ближнего боя.\n\nПРО: ##$pro;##\nПри убийстве врага оружием ближнего боя, скорость вашей перезарядки будет увеличена на ##50%## в течение ##10## секунд.",
					menu_steroids_beta = "БОЕВЫЕ ИСКУССТВА",
					menu_steroids_beta_desc = "БАЗОВЫЙ: ##$basic##\nВы теперь можете бегать когда используете оружие ближнего боя.\n\nПРО: ##$pro##\nСкорость заряда оружия ближнего боя увеличена на ##100%##.",
					menu_drop_soap_beta_desc = "БАЗОВЫЙ: ##$basic##\nВы будете контратаковать противников и сбивать их с ног, если держите оружие ближнего боя наготове. Когда вы контратакуете врага, вы так же нанесете им урон своим холодным оружием.\n\nУрон от контратаки идентичен обычному урону в ближнем бою и зависит от продолжительности заряда оружия.\n\nУдачные контратаки будут моментально убирать оружие ближнего боя из рук.\n\nПРО: ##$pro##\nТеперь вы можете контратаковать клокеров.\n\nКонтратака теперь наносит ##удвоенный## урон.",
					menu_wolverine_beta_desc = "БАЗОВЫЙ: ##$basic##\nВаше оружие ближнего боя теперь наносит на ##50%## больше урона.\n\nЕсли ваша броня разрушится при уровне здроровья ниже ##50%##, вы начнете наносить на ##50%## больше урона оружием ближнего боя в течении ##40## секунд.\n\nПРО: ##$pro##\nЕсли ваша броня разрушится при уровне здроровья ниже ##50%## вы начнете наносить на ##100%## больше урона с огнестрельного оружия в течении ##30## секунд.\nУвеличение урона огнестрельного оружия имеет ##10## секундный кулдаун между активациями, и не распространяется на Метательное Оружие, Гранатометы и Ракетометы.\n\nПометка: при входе в режим берсерка на экране появляется вспышка показывающая продолжительность эффекта. Данную вспышку можно кастомизировать или полностью выключить в настройках мода Gilza.",
				})
			end
			Fugitive_str()
			
		end
		Skill_strings()
		
		local function Weapon_strings()
		
			local function Vanilla_attachs_universal()
				LocalizationManager:add_localized_strings({
					bm_combined_gadget_module = "Двойной модуль - позволяет пользоваться одновременно лазером и фонариком.",
					bm_laser_gadget_module = "Лазерный модуль помогающий стрелку целиться при стрельбе от бедра.",
					bm_flashlight_gadget_module = "Фонарик для освещения темных закаулков.",
					bm_menu_custom_plural = "Переключатели режима огня",
				})
			end
			Vanilla_attachs_universal()
			
			local function Vanilla_attachs_individual()
				LocalizationManager:add_localized_strings({
					-- Assault rifle
					bm_wp_akm_b_standard_gold = "Стандартный Золотой ствол AKM",
					bm_wpn_fps_ass_g3_b_long_newname = "Стандартный длинный ствол Gewehr3",
					bm_wpn_fps_upg_ass_m4_b_beowulf_newname = "Бронебойный набор M4",
					bm_wpn_fps_upg_ass_ak_b_zastava_newname = "Бронебойный набор AK",
					bm_wp_famas_b_sniper_newname = "Бронебойный набор Famas",
					wpn_fps_ass_shak12_body_vks_R = "Бронебойный набор KS-12",
					bm_wpn_fps_shak12_upg_ap_kit_desc = "Пробивает нательную броню, щиты и стены.\nОграничивает режим огня используя только одиночный.\nПодбор боеприпасов уменьшен на 50%.",
					bm_wpn_fps_ass_g3_b_sniper_newname = "Бронебойный набор Gewehr3",
					bm_wpn_fps_ass_g3_b_short_desc = "Комплект для ближнего боя. Подбор боеприпасов увеличен для соответствия новому классу урона.",
					bm_wpn_fps_upg_ar_ap_kit_desc = "Пробивает нательную броню, щиты и стены.\nПодбор боеприпасов уменьшен на 50%.", -- used by all AR's that have AP kits instead of long barrels
					bm_m4_upg_fg_mk12_desc = "Данный набор ограничивает режим огня используя только автоматический.",
					
					-- Pistol mods
					bm_wpn_fps_pis_c96_b_long_newname = "Бронебойный набор для C96",
					bm_wpn_fps_pis_c96_b_long_newdesc = "Пробивает нательную броню, щиты и стены.\nПодбор боеприпасов уменьшен для соответствия новому классу урона и полученому бронебойному эффекту.",
					bm_wpn_fps_pis_type54_underbarrel_desc = "Подствольный дробовик. Стата:\n -Урон: 660\n -Множитель минимального урона с дробовика: 1\n -Подбор патронов: 0.33-0.4, учитывая навык \"Тяжёлый пехотинец\" из карт перков.",
					bm_wpn_fps_pis_type54_underbarrel_slug_desc = "Подствольный дробовик со свинцовой пулей. Пробивает щиты, стены и нательную броню. Эффективная дистанция оружия увеличина на 15% Стата:\n -Урон: 660\n -Множитель минимального урона с дробовика: 1\n -Подбор патронов: 0.25-0.3, учитывая навык \"Тяжёлый пехотинец\" из карт перков.",
					bm_wpn_fps_pis_type54_underbarrel_ap_desc = "Подствольный дробовик со флешеттой, пробивающей нательную броню. Выстреливает 6 дротиков. Эффективная дистанция оружия увеличина на 40%.  Стата:\n -Урон: 660\n -Множитель минимального урона с дробовика: 1\n -Подбор патронов: 0.29-0.36, учитывая навык \"Тяжёлый пехотинец\" из карт перков.",
					bm_wpn_fps_pis_x_type54_underbarrel_desc = "Подствольный дробовик. Стата:\n -Урон: 330\n -Множитель минимального урона с дробовика: 1\n -Подбор патронов: 0.66-0.8, учитывая навык \"Тяжёлый пехотинец\" из карт перков.",
					bm_wpn_fps_pis_x_type54_underbarrel_slug_desc = "Подствольный дробовик со свинцовой пулей. Пробивает щиты, стены и нательную броню. Эффективная дистанция оружия увеличина на 15% Стата:\n -Урон: 330\n -Множитель минимального урона с дробовика: 1\n -Подбор патронов: 0.5-0.6, учитывая навык \"Тяжёлый пехотинец\" из карт перков.",
					bm_wpn_fps_pis_x_type54_underbarrel_ap_desc = "Подствольный дробовик со флешеттой, пробивающей нательную броню. Выстреливает 6 дротиков. Эффективная дистанция оружия увеличина на 40%. Стата:\n -Урон: 330\n -Множитель минимального урона с дробовика: 1\n -Подбор патронов: 0.58-0.72, учитывая навык \"Тяжёлый пехотинец\" из карт перков.",
					
					-- SMG mods
					bm_wpn_fps_smg_mp5_m_straight_R = "Патроны RIP",
					bm_wpn_fps_smg_mp5_m_straight_R_desc = "Подбор боеприпасов уменьшен для соответствия новому классу урона.",
					bm_wp_coal_g_standard = "Стандартная рукоятка Tatonka",
					
					-- LMG mods
					wpn_fps_lmg_hcar_barrel_dmr_PEN = "Бронебойный набор Akron HC",
					bm_wpn_fps_lmg_hcar_barrel_dmr_PEN_desc = "Пробивает нательную броню, щиты и стены.\nОграничивает режим огня используя только одиночный.\nПодбор боеприпасов уменьшен на 50%.",
					bm_wpn_fps_upg_lmg_kacchainsaw_underbarrel_flamethrower_desc = "Подствольный огнемет. Наносит 25 урона напрямую со скорострельностью в 2000. Имеет 25% шанс поджечь врага.\nПодожженные враги получают 100 урона в течении 2 секунд.\n\nПодбор боеприпасов уменьшен на 30% для самого пулемета.",
					bm_wpn_fps_upg_lmg_kacchainsaw_conversionkit_desc = "Подбор боеприпасов увеличен для соответствия новому классу урона.",
					bm_wpn_fps_lmg_hcar_body_conversionkit_desc = "Подбор боеприпасов увеличен для соответствия новому классу урона.",
					bm_wp_hcar_barrel_standard = "Стандартный ствол для Akron HC",
					
					-- Shotgun mods
					bm_wpn_fps_upg_a_rip_desc_new = "Пуля вызывающая у протвника неконтролируемую рвоту, блокируя их возможность делать какие либо действия.\n\nНаносит 250 урона в течение 6 секунд.\nПодбор боеприпасов уменьшен на 20%",
					bm_wpn_fps_upg_a_custom_desc_new = "12 дробинок с увеличенным уроном.\nПробивает нательную броню.\n\nОтключает возможность наносить бонусный урон при попадании в голову.\nЭффективная дистанция оружия уменьшена на 25%.\nПодбор боеприпасов уменьшен на 15%.",
					bm_wpn_fps_upg_a_explosive_desc_new = "Выстреливает один взрывной заряд, который убивает или оглушает цели.\nОтключает возможность наносить увеличенный урон при попадании в голову.\nПодбор боеприпасов уменьшен на 55%.",
					bm_wpn_fps_upg_a_piercing_desc_new = "Пробивает нательную броню.\nЭффективная дистанция оружия увеличина на 25%.\n\nВыстреливает 5 дротиков за выстрел.\nПодбор боеприпасов уменьшен на 15%.",
					bm_wpn_fps_upg_a_slug_desc_new = "Выстреливает один свинцовый снаряд, пробивающий насквозь нательную броню, щиты и стены.\n\nЭффективная дистанция оружия увеличина на 20%.\nПодбор боеприпасов уменьшен на 25%.",
					bm_wpn_fps_upg_a_dragons_breath_desc_new = "Выстреливает 8 дробинок, превращающиеся в искры и пламя. Прожигает щиты и нательную броню врагов.\n\nНаносит 350 урона подоженным врагам в течении 2.5 секунд.\nЭффективная дистанция оружия уменьшена на 20%.\nПодбор боеприпасов уменьшен на 30%.",
					wpn_fps_upg_ns_duck_desc = "Уменьшеает вертикальный разброс дроби до 50%, увеличивает горизонтальный разброс дроби до 225%.",
			
					-- Flamethrower mods
					bm_wpn_fps_fla_mk2_mag_rare_desc = "Меньшая огневая мощь, но увеличинный урон от горения.\n50% шанс поджечь врага. Пока враг горит, он получает 720 единиц урона в течение 3 секунд. Эффект горения наносит урон чаще но в меньших количествах.\nСтандартные значения огнемета для сравнения: 20% шанс на 300 урона в течение 2 секунд.\nПодбор боеприпасов уменьшен на 60%.",
					bm_wpn_fps_fla_mk2_mag_welldone_desc = "Большая огневая мощь, но уменьшенный урон от горения.\n10% шанс поджечь врага. Пока враг горит, он получает получает 150 единиц урона в течение 1 секунды.\nСтандартные значения огнемета для сравнения: 20% шанс на 300 урона в течение 2 секунд.\nПодбор боеприпасов увеличен на 45%.",
					
					-- Launcher mods
					bm_wpn_fps_upg_a_grenade_launcher_poison_default_desc = "Наносит урон в 6м радиусе, после чего создает 6м облако газа на 15 секунд. Враги попавшие в данное облако поучат отравление вызывающее неконтролируемую рвоту на 16 секунд, блокируя их возможность делать какие либо действия. Враги получают 3.5 урона в секунду пока они  отравлены.\n\nПодбор боеприпасов уменьшен на 70%.",
					bm_wpn_fps_upg_a_grenade_launcher_poison_ms3gl_desc = "Наносит урон в 3м радиусе, после чего создает 6м облако газа на 15 секунд. Враги попавшие в данное облако поучат отравление вызывающее неконтролируемую рвоту на 16 секунд, блокируя их возможность делать какие либо действия. Враги получают 3.5 урона в секунду пока они  отравлены.\n\nПодбор боеприпасов уменьшен на 85%.",
					bm_wpn_fps_upg_a_grenade_launcher_poison_ms3gl_CK_desc = "Наносит урон в 3м радиусе, после чего создает 8м облако газа на 15 секунд. Враги попавшие в данное облако поучат отравление вызывающее неконтролируемую рвоту на 16 секунд, блокируя их возможность делать какие либо действия. Враги получают 3.5 урона в секунду пока они  отравлены.\n\nПодбор боеприпасов уменьшен на 85%.",
					bm_wpn_fps_upg_a_grenade_launcher_poison_underbarrel_desc = "Наносит 860 урона в 6м радиусе, после чего создает 6м облако газа на 15 секунд. Враги попавшие в данное облако поучат отравление вызывающее неконтролируемую рвоту на 16 секунд, блокируя их возможность делать какие либо действия. Враги получают 3.5 урона в секунду пока они  отравлены.\n\nПодбор боеприпасов для подствольного грагатомета уменьшен на 70%.",
					bm_wpn_fps_upg_a_grenade_launcher_poison_arbiter_desc = "Наносит урон в 3м радиусе, после чего создает 4м облако газа на 15 секунд. Враги попавшие в данное облако поучат отравление вызывающее неконтролируемую рвоту на 8 секунд, блокируя их возможность делать какие либо действия. Враги получают 7 урона в секунду пока они  отравлены.\n\nПодбор боеприпасов уменьшен на 85%.",
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
			end
			Vanilla_attachs_individual()
			
			local function Custom_Gilza_attachs()
				LocalizationManager:add_localized_strings({
					bm_wpn_fps_upg_br_shtgn = "Пробивной патрон",
					bm_wpn_fps_upg_br_shtgn_desc = "Пуля позволяющая вам пробивать все, что обычно может пробить пила OVE9000. Также может пробивать насквозь щиты и нательную броню врагов.\nЭффективная дистанция оружия уменьшена на 50%.\nПодбор боеприпасов уменьшен на 20%.",
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
					bm_wpn_fps_upg_pis_mid_ap_rounds_lv_desc = "Пробивает нательную броню и щиты.\n\nПодбор боеприпасов уменьшен на 10%.\n",
					wpn_fps_upg_sub2000_250_dmg_kit = "9x19mm QuakeMaker",
					wpn_fps_upg_sub2000_250_dmg_kit_desc = "Патрон 9x19мм с экспансивной свинцовой пулей массой 11,9 грамм в легкой стальной гильзе с закраиной из анодированного в красный алюминия.\n\nПодбор патронов уменьшен для соответствия новому классу урона.",
					-- GL section
					bm_wp_upg_a_grenade_launcher_velocity = "Высокоскоростной снаряд",
					bm_wp_upg_a_grenade_launcher_velocity_desc = "Разрывная граната с утроенной скоростью полета снаряда. Подбор боеприпасов уменьшен на 20%.\n\nПометка: работает только если вы лидер лобби, в противном случае будет работать как обычная граната со стандартным подбором боеприпасов.",
					bm_wp_upg_a_underbarrel_velocity_frag_desc = "Разрывная граната с утроенной скоростью полета снаряда. Максимальный урон: 1300. Подбор боеприпасов для подствольного гранатомета уменьшен на 20%.\n\nПометка: работает только если вы лидер лобби, в противном случае будет работать как обычная граната со стандартным подбором боеприпасов.",
					bm_menu_mag_limiter = "Ограничитель",
					bm_menu_mag_limiter_plural = "Ограничители",
					bm_wp_wpn_fps_gre_ms3gl_ml_double_round = "Двух-зарядный",
					bm_wp_wpn_fps_gre_ms3gl_ml_double_round_desc = "Ограничевает стрельбу очередями до 2 выстрелов, уменьшая максимальный размер магазина до 2.",
					bm_wp_wpn_fps_gre_ms3gl_ml_single_round = "Одно-зарядный",
					bm_wp_wpn_fps_gre_ms3gl_ml_single_round_desc = "Ограничевает оружие одиночной стрельбой, уменьшая максимальный размер магазина до 1.",
				})
			end
			Custom_Gilza_attachs()
			
			local function Custom_attachs_non_Gilza()
				LocalizationManager:add_localized_strings({
					-- playbonk offhand kniv
					bm_wp_wpn_fps_offhandknif_Gilza_desc = "Увеличивает урон и шанс нокдауна при ударе врага оружием. Также добавляет очки крутоты.\nСтатистика:\n -Урон: 50\n -Нокдаун: 400",
					-- Frenchy's missing strings on some parts - no translations required
					bm_wp_wpn_fps_upg_m_celerity = "\"Big Stick\" 30-round mag",
					bm_wp_wpn_fps_upg_m_308dmmag = "Lightweight 30-round mag",
				})
			end
			Custom_attachs_non_Gilza()
			
			local function Weapon_descs()
				LocalizationManager:add_localized_strings({
					bm_w_supernova_desc = "Альтернативный режим: ускоряет скорострельность в 3x раза, ухудшая точность в 3x раза, а стабильность в 1.5x раза.",
					bm_w_saw_desc = "Подбор боеприпасов недоступен без использования навыка \"Резня Пилой\". Не наносит бонусный урон при попадании в голову, за исключением Бульдозеров.",
				})
			end
			Weapon_descs()
			
			local function Throwable_descs()
				LocalizationManager:add_localized_strings({
					bm_wpn_prj_ace_desc = "Урон: 300\nМножитель подбора: "..tostring(Gilza.grenade_multipliers.wpn_prj_ace).."\n",
					bm_grenade_frag_desc = "Урон: 1600\nРадиус: 500\nМножитель подбора: "..tostring(Gilza.grenade_multipliers.frag).."\n",
					bm_wpn_prj_four_desc = "Урон: 150\nМножитель подбора: "..tostring(Gilza.grenade_multipliers.wpn_prj_four).."\n\nПораженные враги поучают отравление вызывающее неконтролируемую рвоту, блокируя их возможность делать какие либо действия.\n\nСтата отравления:\n -Продолжительность: 5 секунд\n -Урон в секунду: 130",
					bm_wpn_prj_hur_desc = "Урон: 1300\nМножитель подбора: "..tostring(Gilza.grenade_multipliers.wpn_prj_hur).."\n",
					bm_wpn_prj_jav_desc = "Урон: 3250\nМножитель подбора: "..tostring(Gilza.grenade_multipliers.wpn_prj_jav).."\n",
					bm_wpn_prj_target_desc = "Урон: 1000\nМножитель подбора: "..tostring(Gilza.grenade_multipliers.wpn_prj_target).."\n",
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
			end
			Throwable_descs()
			
			local function Melee_descs()
				LocalizationManager:add_localized_strings({
					bm_melee_cs_info = "Удерживайте кнопку ближнего боя дабы наносить непрерывный урон.\n\nСтатистика эффекта бензопилы:\nЗадержка перед началом эффекта: 1 сек.\nУрон: 80% здоровья в секунду",
					bm_melee_ostry_info = "Удерживайте кнопку ближнего боя дабы наносить непрерывный урон.\n\nСтатистика эффекта бензопилы:\nЗадержка перед началом эффекта: 0.7 сек.\nУрон: 60% здоровья в секунду",
				})
			end
			Melee_descs()
			
		end
		Weapon_strings()
		
		local function UI_strings()
			LocalizationManager:add_localized_strings({
				-- perk reset button
				menu_Gilza_perk_reset_text = "ВНИМАНИЕ!\n\nНажимая \"Да\" вы обнулите прогресс открытия ваших перков. Обнуление прорессии удалит прогресс всех ваших перков, НО оставит количество очков перков которое у вас есть нетронутым. Данную опцию можно использовать для того, чтобы попробовать новые перки мода Gilza не тратя время на зарабатывание очков перков.\n\nВы уверены что хотите продолжить?",
				menu_Gilza_perk_reset_confirm = "Да",
				menu_Gilza_perk_reset_deny = "Нет",
				-- Fearmonger's in-game pop up notification
				Gilza_fearmonger_trigger_notification = "Бонус скорости разжигателя страха активирован.",
				-- stockholm's in-game pop up notification
				Gilza_menace_panic_spread_notification = "Очки запугивания стокгольмского синдрома: ",
				-- fall damage immunity charges in-game pop up notification
				Gilza_used_limited_fall_damage_immunity_charge = "Смертельный урон от падения предотвращен. Кол-во зарядов: ",
				-- custom attachments tag
				menu_l_global_value_Gilza = "Это Предмет Мода Gilza!",
				-- VHUD compatibility with burst warning
				Gilza_vhud_burst_warning_str = "У вас включена опция \"Стрельба Очередями\" в моде VanillaHUD. Пожалуйста, выключите данную опцию дабы стрельба очередями мода Gilza работала без проблем.\n\nВы можете сделать это перейдя в Настройки->Настройки модов->VanillaHUD Plus Настройки->Настройки снаряжения->Включить стрельбу очередями.",
			})
		end
		UI_strings()
		
		-- strings that have either incorrect or inaccurate information, or use different-from-the-rest terminology.
		local function Additional_fix_strings()
			LocalizationManager:add_localized_strings({
				-- SKILLS
				menu_tea_time_beta_desc = "БАЗОВЫЙ: ##$basic;##\nУвеличивает скорость для установки аптечек первой помощи и медицинских сумок на ##50%##.\n\nПРО: ##$pro;##\nПосле использования вашей аптечки первой помощи или медицинской сумки, вы получаете ##10%## сопротивления урону в течении ##120## секунд.\n\nДанный навык распространяется на членов вашей команды если они воспользуются вашей аптечкой первой помощи или медицинской сумкой.",
				menu_fast_learner_beta_desc = "БАЗОВЫЙ: ##$basic;##\nНапарники, поднятые вами, получают ##30%## сопротивления урону в течение ##5## секунд.\n\nПРО: ##$pro;##\nНапарники, поднятые вами, получают ещё ##50%## сопротивления урону.",
				menu_tea_cookies_beta_desc = "БАЗОВЫЙ: ##$basic;##\nВы теперь можете взять с собой ##7## дополнительных аптечек первой помощи.\n\nПРО: ##$pro;##\nВы теперь можете взять с собой еще ##3## дополнительных аптечек первой помощи.\n\nПосле установки, аптечки первой помощи будут автоматически использоваться, если игрок будет повален в ##5## метровом радиусе от них, предотвращая падение. Эффект может срабатывать только раз в ##20## секунд, но отсчитывается он отдельно для каждого игрока.",
				menu_medic_2x_beta_desc = "БАЗОВЫЙ: ##$basic;##\nВы теперь можете взять с собой ##2## медицинских сумки вместо одной.\n\nПРО: ##$pro;##\nВаши медицинские сумки получают по ##2## дополнительных использования.",
				menu_control_freak_beta_desc = "БАЗОВЫЙ: ##$basic;##\nВаша скорость передвижения увеличится на ##10%##, если есть враг, которого вы перевели сражаться на вашей стороне.\n\nВраг, которого вы перевели сражаться на вашей стороне, получает ##45%## сопротивления урону.\n\nПРО: ##$pro;##\nВаше здоровье увеличится на ##30%##, если есть враг, которого вы перевели сражаться на вашей стороне.\n\nВраг, которого вы перевели сражаться на вашей стороне, получает еще ##54%## сопротивления урону.",
				menu_black_marketeer_beta = "Захватчик заложников",
				menu_black_marketeer_beta_desc = "БАЗОВЫЙ: ##$basic;##\nЕсли у вас есть как минимум один заложник или переведённый на вашу сторону полицейский, то вы будете восполнять ##1.5%## здоровья каждые ##5## секунд.\n\nПРО: ##$pro;##\nЕсли у вас есть как минимум один заложник или переведённый на вашу сторону полицейский, то вы будете восполнять ##4.5%## здоровья каждые ##5## секунд.",
				menu_stable_shot_beta = "Стабильный стрелок",
				menu_ammo_reservoir_beta_desc = "БАЗОВЫЙ: ##$basic;##\nПосле взаимодействия с установленной вами сумки с патронами, вы или ваша команда можете стрелять из своего оружия не расходуя боеприпасы в течение ##5## или меньше секунд. Чем больше амуниции вы восстановите из сумки, тем дольше будет эффект непрерывной стрельбы.\n\nПРО: ##$pro;##\nМаксимальная продолжительность эффекта увеличена до ##15## секунд.\n\nПометка: Если взаимодействие с сумкой у которой есть данный эффект полностью ее расходует, данный эффект будет наложен на игрока в течении максимальной возможной продолжительности умноженой на ##4##.",
				menu_drill_expert_beta = "Майор дрель",
				menu_drill_expert_beta_desc = "БАЗОВЫЙ: ##$basic;##\nПовышает эффективность ваших пил и дрелей, делая их на ##15%## быстрее.\n\nПРО: ##$pro;##\nУвеличивает эффективность ваших пил и дрелей на ещё ##15%##.\n\nПометка: действие навыка не распространяется на пилу OVE9000.",
				menu_akimbo_skill_beta_desc = "БАЗОВЫЙ: ##$basic;##\nШтраф стабильности парного оружия снижен на ##8## единиц.\n\nПРО: ##$pro;##\nШтраф стабильности парного оружия снижен на еще ##8## единиц.\nКоличество переносимых боеприпасов для парного оружия увеличено на ##$multipro4;##.\n\nВнимание: количество дополнительных патронов для парного оружия от карточка перка \"Амбидекстрия\" и навыка \"Парное оружие\" суммируется.",
				menu_frenzy_desc = "БАЗОВЫЙ: ##$basic;##\nТеперь у вас только ##30%## от максимального запаса здоровья и вы не сможете восполнить его выше этой отметки. Вы получаете ##10%## сопротивления урону.\n\nНавыки восполняеющие ваше здоровье восполняют на ##75%## меньше здоровья.\n\nПРО: ##$pro;##\nВаше сопротивление урону от данного навыка теперь равно ##25%##. Навыки восполняеющие ваше здоровье теперь восполняют здоровье в полной силе.",
				-- PERKS
				menu_specialization_tier = "Карта",
				menu_deck1_1_desc = "Вы и члены вашей команды получаете ##8%## сопротивления урону.\n\nЭффект сопротивления урону будет увеличен для вас в два раза, если уровень вашего здоровья ниже ##50%##.",
				menu_deck1_1_short = "Вы и члены вашей команды получаете ##8%## сопротивления урону, этот бонус удвоен для вас, если уровень вашего здоровья ниже ##50%##.",
				menu_deck1_5 = "Стая волков",
				menu_deck1_9_short = "Вы и ваша команда получаете ##6%## здоровья и ##12%## выносливости за каждого взятого вами заложника, вплоть до ##4##. Если у вас есть заложник, то все члены команды получают ##8%## сопротивления урону. Пометка: Все навыки набора перков распространяющиеся на напарников, не складываются сами с собой.",
				menu_deck2_1_desc = "Ваше здоровье увеличено на ##10%##.",
				menu_deck2_3_desc = "Повышает вероятность того, что по вам начнут стрелять, когда вы будете рядом с напарниками на ##15%##.\n\nВаше здоровье увеличено еще на ##10%##.",
				menu_deck3_9_desc = "Прочность брони увелчится еще на ##5%##.\n\nБроня всех членов команды, включая вас, восстанавливается быстрее на ##10%##.\n\nПометка: Навыки, распространяющие своё действие на напарников, не складываются.\n\nБонус завершения ряда: Вероятность получить предмет высокого качества после завершения контракта увеличена на ##10%##.",
				menu_deck3_9_short = "Прочность брони увелчится еще на ##5%##. Броня всех членов команды, включая вас, восстанавливается быстрее на ##10%##. Пометка: Навыки, распространяющие своё действие на напарников, не складываются.",
				menu_deck4_5_desc = "Шанс увернуться увеличен еще на ##15%##.",
				menu_deck4_5_short = "Шанс увернуться увеличен еще на ##15%##.",
				menu_deck4_7_desc = "Шанс увернуться увеличен еще на ##15%##.",
				menu_deck4_7_short = "Шанс увернуться увеличен еще на ##15%##.",
				menu_deck8_9_desc = "Вы восполните ##20%## здоровья, если ударите врага оружием ближнего боя. Навык срабатывает только один раз за ##10## секунд.\n\nБонус завершения ряда: Вероятность получить предмет высокого качества после завершения контракта увеличена на ##10%##.",
				menu_deck8_9_short = "Вы восполните ##20%## здоровья, если ударите врага оружием ближнего боя. Навык срабатывает только один раз за ##10## секунд.",
				menu_deck9_3 = "Напряженность",
				menu_deck9_5 = "Прямое Попадание",
				menu_deck9_7 = "Передозировка",
				menu_deck9_9 = "В Открытую",
				menu_deck9_3_desc = "При убийстве противника вы восполните ##30## единиц брони.\n\nПерк не срабатывает чаще чем раз за ##1## секунду.\n\nПрочность брони увеличена на ##10%##.",
				menu_st_spec_10 = "Азартник",
				menu_st_spec_10_desc = "Чтобы преуспеть в бою, требуется опыт, сноровка и чуть больше, чем просто удача. Некоторым присуща лишь удача.\n\nНа самом деле удача обманчива. В древней Греции удачу считали благословлением богов. В действительности это не так. Удача существует, но её нужно заслужить. Чтобы достичь самой большой вероятности успеха, требуется подготовка и тщательное продумывание. Лучше следить за картами, чем надеяться на Фортуну.\n\nНабор перков \"Азартник\" - это набор класса поддержки. С любым напарником можно выиграть, но только с азартником можно выиграть по-крупному.",
				menu_deck11_1_desc = "Нанесение урона противнику добавляет вам эффект восстанавливающий здоровье. Данный эффект восстанавливает ##1## единицу здоровья каждые ##0.3## секунды в течение ##3## секунд.\n\nВы можете иметь несколько эффектов восстанавливающих здоровье, но вы не можете добавлять новый эффект чаще чем один раз за ##1.5## секунды.\nНавык работает только с Костюмом-Двойкой или Лёгким Баллистическим Бронежилетом.",
				menu_deck11_1_short = "Нанесение урона противнику добавляет вам эффект восстанавливающий здоровье. Навык работает только с Костюмом-Двойкой или Лёгким Баллистическим Бронежилетом.",
				menu_deck11_3_desc = "Эффект восстанавливающий здоровье теперь восстанавливает ##2## единицы здоровья каждые ##0.3## секунды в течение ##3## секунд.\n\nВаше здоровье увеличено на ##20%##.",
				menu_deck11_3_short = "Вы восстанавливаете больше здоровья. Ваше здоровье увеличено.",
				menu_deck11_5_short = "Вы восстанавливаете больше здоровья. Вероятность пробить вражескую нательную броню увеличена.",
				menu_deck11_7_desc = "Эффект восстанавливающий здоровье теперь восстанавливает ##4## единицы здоровья каждые ##0.3## секунды в течение ##3## секунд.\n\nВаше здоровье увеличено еще на ##20%##.",
				menu_deck11_7_short = "Вы восстанавливаете больше здоровья. Ваше здоровье увеличено.",
				menu_deck12_3_desc = "Чем ниже ваше здоровье, тем быстрее вы передвигаетесь. Эффект активируется только когда ваше здоровье ниже ##25%##. Максимальный бонус к скорости передвижения равен ##20%##.",
				menu_deck12_3_short = "Чем ниже ваше здоровье, тем быстрее вы передвигаетесь.",
				menu_deck12_5_desc = "Максимальный бонус к скорости восстанавления брони при низком уровне здоровья увеличен на ##20%##.",
				menu_deck13_1 = "На гребне волны",
				menu_deck13_1_desc = "Вы будете накапливать ##4## единицы запасного здоровья за каждого ##1## убитого вами или вашей командой противника при условии, что ваша броня полностью цела.\n\nПосле того как ваша броня полностью сломается, и затем закончит восстанавливаться, вы восполните ваше основное здоровье с помощью накопленного вами запасного здоровья. Вне зависимости от того сколько запасного здоровья было использовано, после восставновления брони его количество всегда будет сброшено до ##0##.\n\nМаксимальное количество запасного здоровья, которое можно накопить, зависит от используемой вами брони, и доступно вам для просмотра в описанях брони.",
				menu_deck13_1_short = "Вы можете накапливать запасное здоровья за каждого убитого вами или вашей командой противника. После того как ваша броня полностью сломается, и затем закончит восстанавливаться, вы восполните ваше основное здоровье с помощью накопленного вами запасного здоровья.",
				menu_deck13_3_desc = "Количество запасного здоровья, получаемого за убийство противников, увеличено на ##4##.\n\nВаше основное здоровье увеличено на ##10%##.",
				menu_deck13_3_short = "Количество запасного здоровья, получаемого за убийство противников, увеличено. Ваше здоровье увеличено.",
				menu_deck14_7_desc = "Вы и ваша команда теперь получаете ##1## поглощение урона за каждые ##25## очков истерии вместо ##30##.",
				menu_deck16_9_short = "Каждые ##10%## потерянной брони, уменьшат ##4## секундную задержку восстановления на ##0.1## секунд.",
				menu_deck18_3_desc = "Когда вы получаете урон, вы получаете прибавку к вашему шансу увернуться в размере ##20%##. Данный эффект сбросится в случае удачного уворота и перестанет работать в течении следующих ##4## секунд.",
				menu_deck18_3_short = "Когда вы получаете урон, вы получаете прибавку к вашему шансу увернуться в размере ##20%##. Данный эффект сбросится в случае удачного уворота и перестанет работать в течении следующих ##4## секунд.",
				menu_deck18_9_short = "Все бонусы от вашего набора перков будут увеличены на ##100%## пока вы стоите в дымовой завесе. Если кто-то из ваших напарников стоит в дыму, они получают ##10%## к шансу увернуться.",
				menu_deck19_5_desc = "Если вы не получали урона в течение ##4## секунд, весь оставшийся периодический урон будет отменён.",
				menu_deck20_3_desc = "Ваше здоровье увеличено на ##20%##.",
				menu_deck20_3_short = "Ваше здоровье увеличено на ##20%##.",
				menu_deck20_7_desc = "Ваше здоровье увеличено на ##20%##.",
				menu_deck20_7_short = "Ваше здоровье увеличено на ##20%##.",
				menu_deck20_9_desc = "Каждый убитый враг вашим выбранным напарником сокращает кулдаун \"Парилки\" на ##2## секунды до тех пор, пока вы в паре.\n\nБонус завершения ряда: Вероятность получить предмет высокого качества после завершения контракта увеличена на ##10%##.",
				menu_deck20_9_short = "Каждый враг убитый вашим выбранным напарником сокращает кулдаун \"Парилки\" на ##2## секунды.",
				menu_deck21_3_desc = "Ваше здоровье увеличено на ##20%##.",
				menu_deck21_9_desc = "Пока Звуковая петля активна, члены вашей команды будут восполнять по ##10## единиц здоровья за каждое убийство.\nВаш шанс уворота увеличен на дополнительные ##15%##.\n\nБонус завершения ряда: Вероятность получить предмет высокого качества после завершения контракта увеличена на ##10%##.",
				menu_deck21_9_short = "Пока Звуковая петля активна, члены вашей команды будут восполнять по ##10## единиц здоровья за каждое убийство. Ваш шанс уворота увеличен на дополнительные ##15%##.",
				menu_deck22_3_short = "Вы не можете упасть во время действия Ампулы. Ваше здоровье увеличено.",
				menu_deck22_7_short = "Ваше здоровье увеличено.",
				-- COPYCAT
				menu_st_spec_23 = "КопиКэт",
				menu_st_spec_23_desc = "Обладая эйдетической памятью и фотографическими рефлексами, КопиКэт — это физический феномен. Способность предугадывать движения сделала вас невероятно быстрым, вплоть до возможности уклоняться и даже отражать пули. Вы тщательно изучили другие наборы перков и теперь можете копировать их базовые способности, усиливая свои собственные. Комбинируйте техники, чтобы создать стиль, одновременно повторяющий и уникальный. Если другие обвинят вас в воровстве, напомните им, что подражание — это наивысшая форма лести.",
				menu_deck23_1 = "Тактическая перезарядка (Выберите Буст)",
				menu_pxp4_deck23_1_short = "##10## убийств автоматически перезаряжает оружие в другом слоте.",
				menu_deck23_3 = "Игры разума (Выберите Буст)",
				menu_deck23_5 = "Это твоя пуля? (Выберите Буст)",
				menu_deck23_5_desc = "При удачном увороте, пуля отрикошетит во врага который выстрелил по вам.",
				menu_deck23_5_short = "При удачном увороте, пуля отрикошетит во врага.",
				menu_deck23_7 = "Период милости (Выберите Буст)",
				-- bullshit with boost cards
				menu_deck23_1_1 = "Процветающий",
				menu_deck23_3_1 = "Процветающий",
				menu_deck23_5_1 = "Процветающий",
				menu_deck23_7_1 = "Процветающий",
				menu_deck23_1_1_short = "Здоровье увеличено на ##15%##",
				menu_deck23_3_1_short = "Здоровье увеличено на ##15%##",
				menu_deck23_5_1_short = "Здоровье увеличено на ##15%##",
				menu_deck23_7_1_short = "Здоровье увеличено на ##15%##",
				menu_deck23_1_2 = "Ужесточённый",
				menu_deck23_3_2 = "Ужесточённый",
				menu_deck23_5_2 = "Ужесточённый",
				menu_deck23_7_2 = "Ужесточённый",
				menu_deck23_1_2_desc = "Вы получаете ##5%## к прочности брони.",
				menu_deck23_3_2_desc = "Вы получаете ##5%## к прочности брони.",
				menu_deck23_5_2_desc = "Вы получаете ##5%## к прочности брони.",
				menu_deck23_7_2_desc = "Вы получаете ##5%## к прочности брони.",
				menu_deck23_1_2_short = "Прочность брони увеличена на ##5%##",
				menu_deck23_3_2_short = "Прочность брони увеличена на ##5%##",
				menu_deck23_5_2_short = "Прочность брони увеличена на ##5%##",
				menu_deck23_7_2_short = "Прочность брони увеличена на ##5%##",
				menu_deck23_1_3 = "Кошачий рефлекс",
				menu_deck23_3_3 = "Кошачий рефлекс",
				menu_deck23_5_3 = "Кошачий рефлекс",
				menu_deck23_7_3 = "Кошачий рефлекс",
				menu_deck23_1_3_desc = "Ваш шанса уворота увеличен на ##5%##.",
				menu_deck23_3_3_desc = "Ваш шанса уворота увеличен на ##5%##.",
				menu_deck23_5_3_desc = "Ваш шанса уворота увеличен на ##5%##.",
				menu_deck23_7_3_desc = "Ваш шанса уворота увеличен на ##5%##.",
				menu_deck23_1_3_short = "Шанса уворота увеличен на ##5%##",
				menu_deck23_3_3_short = "Шанса уворота увеличен на ##5%##",
				menu_deck23_5_3_short = "Шанса уворота увеличен на ##5%##",
				menu_deck23_7_3_short = "Шанса уворота увеличен на ##5%##",
				menu_deck23_bonus_speed = "Грузоподъемный",
				menu_deck23_1_4_short = "Передвижение в присяди или с сумкой, и боеприпасы увеличены.",
				menu_deck23_3_4_short = "Передвижение в присяди или с сумкой, и боеприпасы увеличены.",
				menu_deck23_5_4_short = "Передвижение в присяди или с сумкой, и боеприпасы увеличены.",
				menu_deck23_7_4_short = "Передвижение в присяди или с сумкой, и боеприпасы увеличены.",
				menu_deck23_9_short = "Копируете: $CLONED_CARD;.",
				menu_deck23_9_desc = "Бонус завершения: Вероятность получить предмет высокого качества после завершения контракта увеличена на ##10%##.",
			})
		end
		Additional_fix_strings()
		
	end

	if chosen_language == "eng" then
		loc:load_localization_file(Gilza._path .. 'menus/lang/Gilza_en.txt', false)
	elseif chosen_language == "ru" then
		loc:load_localization_file(Gilza._path .. 'menus/lang/Gilza_ru.txt', false)
		AddRussianLoc()
	end

end)