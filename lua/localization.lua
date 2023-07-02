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

	if lang == "ru" then
		loc:load_localization_file(Gilza._path .. 'menus/lang/Gilza_ru.txt', false)
		LocalizationManager:add_localized_strings({
		-- perks	
		menu_deckall_8 = "Улучшенная физическая подготовка",
		menu_deckall_8_desc = "Вы получаете дополнительную скорость передвижения в размере ##10%##.\n\nВы можете бросать сумки на ##50%## дальше.",
		menu_deckall_6_desc = "Открывает сумку с броней, содержимое которой можно надеть во время ограбления.\n\nВраги оставляют на ##135%## больше патронов.\n\nВы также получаете базовый шанс ##0%## найти метательное оружие в оставленных врагами боеприпасах. Шанс увеличивается на ##1.2%## за каждый подобранный боеприпас, в котором не было метательного оружия. Когда метательное оружие будет найдено в боеприпасах, шанс будет сброшен до базового значения.",
		menu_deckall_2 = "Быстрый и разъярённый",
		menu_deckall_2_desc = "Увеличивает скорость взаимодействия с медицинскими сумками на ##20%##",
		menu_deck18_1_desc = "Разблокирует и позволяет взять с собой дымовую шашку.Если вы смените набор перков на другой, дымовая шашка будет недоступна для использования.\n\nПри использовании, дымовая шашка создаёт завесу, которая длится ##10## секунд. Пока вы и ваши напарники стоят в завесе, вы будете уворачиваться от ##50%## всех пуль. Любой враг, находящийся в дыму, будет менее точен при стрельбе на ##50%##.\n\nКак дым рассеется, вы не сможете использовать дымовую шашку в течение ##40## секунд. Тем не менее, убийство врагов сокращает время восстановления на ##1## секунду.",
		menu_deck10_1_desc = "Боеприпасы оставленные врагами, также содержат медицинские припасы которые могут восстановить вам от ##16## до ##24## здоровья.\n\nПерк срабатывает только один раз за ##3## секунды.\n\nЕсли текущее здоровье Шуллера меньше чем у другого игрока, эффект восстановления будет увеличен на ##35%##. Эффект не может складываться несколько раз.",
		menu_deck4_9_desc = "Шанс увернуться увеличен на ##5%##.\nШанс увернуться когда вы пригнулись увеличен на ##5%##.\nВаша скорость передвижения увеличена на ##15%##.\nВаш запас выносливости увеличен на ##25%##.\n\nШанс пробить вражескую броню из любого оружия равен ##50%##.\nУменьшает время переключения между оружием на ##80%##.\n\nБонус завершения ряда: Вероятность получить предмет высокого качества после завершения контракта увеличина на ##10%##.",
		
		-- skills
		menu_pack_mule_beta_desc = "БАЗОВЫЙ: ##$basic;##\nЗа каждые ##10## единиц брони штраф к скорости переноса добычи уменьшен на ##1%##.\n\nПРО: ##$pro;##\nВы теперь можете бегать с любой сумкой.",
		menu_awareness_beta_desc = "БАЗОВЫЙ: ##$basic;##\nСкорость подъёма по навесным лестницам увеличена на ##20%##.\n\nПозволяет бегать в любом направлении.\n\nПРО: ##$pro;##\nПерезарядка на бегу: вы можете перезаряжаться во время бега.",
		menu_overkill_beta_desc = "БАЗОВЫЙ: ##$basic;##\nПосле убийства врага с помощью дробовика или пилы OVE9000, вы будете наносить на ##40%## больше урона в течение ##30## секунд.\n\nПРО: ##$pro;##\nБонус к урону теперь применяется ко всему оружию. Навык должен быть активирован использованием дробовика или пилы OVE9000. Уменьшает время переключения между оружием на ##80%##\n\nВнимание: действие навыка не распространяется на оружие ближнего боя, метательное и гранатометы.",
		menu_far_away_beta = "БЕЗДУМНЫЙ РАЗНОС",
		menu_far_away_beta_desc = "BASIC: ##$basic##\nПри каждом выстреле из дробовика вы имеете ##7.5%## шанс выстрелить не потратив боезапас.\n\nACE: ##$pro##\nВаши шансы выстрела без траты боезапаса увеличины до ##20%##",
		menu_close_by_beta_desc = "БАЗОВЫЙ: ##$basic;##\nСтрельба на бегу: вы можете стрелять из дробовиков от бедра во время бега.\n\nПРО: ##$pro;##\nВаша скорострельность будет увеличена на ##25%## при стрельбе от бедра из дробовиков с одиночным режимом стрельбы.",
		menu_shotgun_cqb_beta_desc = "BASIC: ##$basic##\nПовышает скорость перезарядки дробовиков на ##15%##.\n\nACE: ##$pro##\nПовышает бонус к скорости перезарядки до ##35%##.",
		menu_shotgun_impact_beta = "Эксперт по дробовикам",
		menu_shotgun_impact_beta_desc = "БАЗОВЫЙ: ##$basic;##\nПовышает скорость прецеливания с дробовиками до ##125%##\nПовышает стабильность при стрельбе из дробовиков на ##15%##.\n\nПРО: ##$pro;##\nПовышает стабильность при стрельбе из дробовиков до ##40%##.",
		menu_steady_grip_beta_desc = "БАЗОВЫЙ: ##$basic;##\nВаше оружие стабильнее на ##4## единицы.\n\nПРО: ##$pro;##\nВаше оружие стабильнее на ##8## единиц, в итоге получая ##12## единиц.",
		menu_stable_shot_beta_desc = "БАЗОВЫЙ: ##$basic;##\nВаше оружие точнее на ##4## единицы.\n\nПРО: ##$pro;##\nВаше оружие точнее на ##4## единицы, в итоге получая ##8## единиц.",
		menu_sharpshooter_beta = "Медленно но верно",
		menu_sharpshooter_beta_desc = "BASIC: ##$basic##\nВы получаете ##5%## сопротивления урону если вы не двигаетесь или если важе оружие стоит на сошках.\n\nACE: ##$pro##\nВы получаете дополнительные ##35%## сопротивления урону если ваше оружие стоит на сошках.\nВаша скорость установки сошек увеличина на ##100%##.",
		menu_rifleman_beta = "ЛОВКИЙ СТРЕЛОК",
		menu_rifleman_beta_desc = "БАЗОВЫЙ: ##$basic;##\nВы прицеливаетесь на ##100%## быстрее со всего оружия.\nУвеличивает приближение (зум) прицела у всего оружия на ##25%##.\n\nПРО: ##$pro;##\nВо время прицеливания вы двигаетесь без штрафа к скорости передвижения.\n\nВаш ##25%## штраф к точности во время ##передвижения и прицеливания## удален.",
		menu_fire_control_beta_desc = "БАЗОВЫЙ: ##$basic;##\nТочность вашего оружия увеличена на ##12## при стрельбе от бедра.\n\nПРО: ##$pro;##\nВаш ##25%## штраф к точности во время ##передвижения и стрельбы от бедра## удален.",
		menu_bandoliers_beta_desc = "БАЗОВЫЙ: ##$basic;##\nПовышает количество переносимых боеприпасов на ##25%##.\n\nПРО: ##$pro;##\nВраги оставляют на ##75%## больше боеприпасов. У вас есть ##10%## шанс найти метательное оружие в оставленных врагами боеприпасах. Шанс увеличивается на ##2%## за каждый подобранный боеприпас, в котором не было метательного оружия. Когда метательное оружие будет найдено в боеприпасах, шанс будет сброшен к стандартному значению. Данный навык не складывается с бонусом 'Тяжёлый пехотинец' из набора перков.",
		menu_martial_arts_beta = "КРЕПКИЙ ПАРЕНЬ",
		menu_steroids_beta = "БОЕВЫЕ ИСКУССТВА",
		menu_steroids_beta_desc = "BASIC: ##$basic##\nСкорость заряда оружия ближнего боя увеличена на ##100%##.\n\nACE: ##$pro##\nВы теперь можете бегать с оружием ближнего боя.",
		menu_bloodthirst_desc = "БАЗОВЫЙ: ##$basic;##\nКаждый раз, когда вы убиваете врага, урон от оружия ближнего боя будет увеличен на ##25%##, до максимума в ##700%##. Внимание: прибавка к урону работает до тех пор, пока вы не убьёте врага оружием ближнего боя.\n\nПРО: ##$pro;##\nПри убийстве врага оружием ближнего боя, скорость вашей перезарядки будет увеличена на ##50%## в течение ##10## секунд.",
		menu_sociopathinfil_1_desc = "Когда по вам ведут огонь трое или более врагов, вы получаете на ##12%## меньше урона.\n\nВаш второй и каждый последующий удар в ближнем бою с перерывом не более чем в ##4## секунды, нанесёт на ##75%## больше урона от базового урона оружия.\n",
		menu_up_you_go_beta_desc = "БАЗОВЫЙ: ##$basic;##\nВы получаете на ##30%## меньше урона в течение ##10## секунд после того, как вас подняли.\n\nПРО: ##$pro;##\nВы получаете дополнительные ##35%## от своего максимального здоровья когда вас подняли.\n\nПометка от Гильзы: в итоге, после поднятия, вы получите около ##75%## здоровья на сложностях ниже Хаоса, и ##45%## здоровья на сложности Хаос и выше.",
		menu_body_expertise_beta_desc = "БАЗОВЫЙ: ##$basic;##\nМножитель попадания в голову применяется к телу противника с эффективностью в ##25%##. Этот навык работает только с пистолетами-пулемётами, пулемётами и штурмовыми винтовками в режиме автоматической стрельбы.\n\nПРО: ##$pro;##\nТеперь процент увеличен до ##50%##.\n\nПометка от Гильзы: из-за того как расчитывается урон от этого навыка, и изменений показателей здоровья и множителей от хэдшотов, вы можете воспринимать базовую версию этого навыка как множитель урона в ##1.5## раза при стрельбе в тело, и про версию как множитель урона в ##2## раза. Эти значения могут быть слегка другими если вы стреляете например по клокерам, чей множитель хедшота выше чем у других противников.",
		menu_dance_instructor_desc = "БАЗОВЫЙ: ##$basic;##\nПовышает скорострельность пистолетов на ##20%##.\n\nПРО: ##$pro;##\nРазмер магазина вашего пистолета увеличен на ##8## пуль.",
		menu_gun_fighter_beta = "БЕЗДОННЫЕ КАРМАНЫ",
		menu_gun_fighter_beta_desc = "БАЗОВЫЙ: ##$basic##\nВы получаете на ##15%## больше боезапаса для пистолетов.\n\nПРО: ##$pro##\nВы получаете на ##50%## больше боезапаса для пистолетов.\n\nПометка от Гильзы: данный навык складывается с другими навыками на увеличинный боезапас.",
		menu_speedy_reload_beta_desc = "БАЗОВЫЙ: ##$basic;##\nПовышает скорость перезарядки штурмовых винтовок, пистолетов-пулемётов и снайперских винтовок на ##20%##.\n\nПРО: ##$pro;##\nУбийство в голову увеличивает вашу скорость перезарядки на ##100%## в течение ##4## секунд. Навык срабатывает только для штурмовых винтовок, пистолетов-пулемётов и снайперских винтовок в одиночном режиме стрельбы. ",
		menu_carbon_blade_beta_desc = "БАЗОВЫЙ: ##$basic;##\nАтака врагов портативной пилой OVE9000 изнашивает лезвия на ##50%## меньше.\n\nПРО: ##$pro;##\nТеперь вы можете прорезать щитовиков своей пилой OVE9000. Убив противника пилой, у вас есть ##50%## шанс посеять панику в ##10## метровом радиусе. Паника будет подавлять противника, заставляя его испытывать страх.\n\nВраги теперь оставляют боезапас к пиле. Подбор боезапаса пилы не может быть увеличен используюя дополнительные навыки на подбор боезапаса.",
		menu_sniper_graze_damage_desc = "БАЗОВЫЙ: ##$basic;##\nЕсли выстрел из снайперской винтовки попал по противнику находившемуся дальше чем ##7.5м## от стрелка, то этот выстрел нанесёт ##33%## от урона винтовки противникам в ##75см## радиусе полёта пули.\n\nДанный урон не увеличивается если выстрел приземлится в голову первоначальной цели, но может быть увеличен с помощью других навыков.\n\nПРО: ##$pro;##\nРадиус урона увеличен до ##150см## а урон увеличен до ##66%## от урона оружия.",
		menu_wolverine_beta_desc = "БАЗОВЫЙ: ##$basic##\nВы наносите на ##50%## больше урона оружием ближнего боя.\n\nКогда ваша броня ломается и ваше здроровье ниже ##50%## от максимального, вы наносите на ##50%## больше урона оружием ближнего боя в течении ##20## секунд.\n\nПРО: ##$pro##\nПродолжительность бонусного урона для оружия ближнего боя теперь будет длиться ##40## секунд.\n\nКогда ваша броня ломается и ваше здроровье ниже ##50%## от максимального вы наносите на ##100%## больше урона с огнестрельного оружия в течении ##15## секунд.\n\nНа заметку: действие навыка не распространяется на метательное оружие, гранатометы и ракетометы.\n\nПометка от Гильзы: при входе в режим берсерка на экране появляется вспышка показывающая продолжительность эффекта. Данную вспышку можно кастомизировать или полностью выключить в настройках мода Gilza.",
		
		-- brawler deck
		menu_deck_brawler = "Задира",
		menu_deck_brawler_desc = "Гейдж подкинул Бейну наводку о поставке экспериментальных облегченных силовых бронекостюмов, которые Murkywater доставляли в одно из своих предприятий. Как бы вы себя называли если б упустили такую возможность? Конечно же вы их все спиздили! Но после тщательного осмотра в своем убежище вы обнаружили, что они крайне громоздкие, но все равно каким-то образом удобны для беготни.\n\nВот так вы и преобразились в... ЗАДИРУ!",
		menu_deck_brawler1 = "Улучшение бронекостюмов",
		menu_deck_brawler1_desc = "Использование этой высококачественной силовой брони с каким-либо нагрудным снаряжением практически невозможно из-за ее формы и размера. Но кому оно нахуй нужно?\n\nВаш запас боеприпасов уменьшен на ##85%##.\n\nШтраф к скорости передвижения в броне уменьшен на ##20%##.\n\nВы получаете сопротивление к пулевому урону в размере ##18%##.",
		menu_deck_brawler3 = "Улучшение пластин для бронекостюмов",
		menu_deck_brawler3_desc = "Вы получаете дополнительное сопротивление к пулевому урону в размере ##18%##.",
		menu_deck_brawler5 = "Легкие бронепластины",
		menu_deck_brawler5_desc = "Штраф к скорости передвижения в броне уменьшен дополнительно на ##20%##.",
		menu_deck_brawler7 = "Максимальное улучшение пластин для бронекостюмов",
		menu_deck_brawler7_desc = "Вы получаете дополнительное сопротивление к пулевому урону в размере ##18%##.",
		menu_deck_brawler9 = "Мясной щит",
		menu_deck_brawler9_desc = "Повышает вероятность того, что по вам начнут стрелять, когда вы будете рядом с напарниками на ##15%##.\n\nУбийство оружием ближнего боя дает вам ##75## очков брони.\n\nКогда ваше здоровье ниже ##50%##, вы получаете следующие бонусы:\n- Каждый враг находящийся дальше ##9##м от вас наносит на ##18%## меньше пулевого урона по вам\n- Каждый враг находящийся дальше ##16##м от вас наносит на ##16%## меньше пулевого урона по вам\n\nВсе сопротивления урону данного перка складываются между собой, так что враги дальше ##16##м от вас наносят только ##12%## урона.\n\nБонус завершения ряда: Вероятность получить предмет высокого качества после завершения контракта увеличина на ##10%##.",
		
		-- Weapon Mods
		-- shotgun ammo 	
		bm_wpn_fps_upg_a_rip_desc_new = "Пуля заставляющая противников безконтрольно мучаться от отравляющего урона после попадания, если стрелок находится достаточно близко.\n\nНаносит 400 урона в течение 2 секунд, с 'тиком' урона раз в 0.5 секунды.\nПодбор патронов уменьшен на 20%",
		bm_wpn_fps_upg_a_custom_desc_new = "Большая дробь с увеличенным уроном.\nПодбор патронов уменьшен на 20%",
		bm_wpn_fps_upg_a_explosive_desc_new = "Выстреливает один взрывной заряд, который убивает или оглушает цели.\nОтсутствует дополнительный урон при попадании в голову.\nПодбор патронов уменьшен на 60%",
		bm_wpn_fps_upg_a_piercing_desc_new = "Пробивает насквозь нательную броню врагов. Дистанция на которой оружие нанесёт свой максимавльный урон увеличина на 50%.\nПодбор патронов уменьшен на 10%\nКоличество дротиков в гильзе - 5",
		bm_wpn_fps_upg_a_slug_desc_new = "Выстреливает один свинцовый снаряд, пробивающий насквозь нательную броню, щиты и стены. Дистанция на которой оружие нанесёт свой максимавльный урон увеличина на 20%\nПодбор патронов уменьшен на 25%",
		bm_wpn_fps_upg_a_dragons_breath_desc_new = "Выстреливает пули, превращающиеся в искры и пламя. Прожигает щиты и нательную броню врагов.\nОтсутствует дополнительный урон при попадании в голову.\nНаносит 1180 урона огнем.\nПодбор патронов уменьшен на 80%",
		bm_wpn_fps_upg_br_shtgn = "Пробивной патрон",
		bm_wpn_fps_upg_br_shtgn_desc = "Позволяет вам пробивать все, что обычно может пробить пила OVE9000. Также может пробивать насквозь щиты и нательную броню врагов.\nДистанция на которой оружие нанесёт свой максимавльный урон уменьшенна до 33%.\n",
		
		-- weapon parts
		bm_wpn_fps_ass_g3_b_sniper_desc = "ДЕЙСТВИТЕЛЬНАЯ СКОРОСТРЕЛЬНОСТЬ: 450\nПробивает нательную броню, щиты и стены. Подбор патронов уменьшен.\n\nКомент от гильзы: скорострельность на экране не соответсвует скорострельности в игре тк код связанный с модификацией этих параметров, как бы так оно сказать... ебанутый.",
		bm_wpn_fps_ass_g3_b_short_desc = "ДЕЙСТВИТЕЛЬНАЯ СКОРОСТРЕЛЬНОСТЬ: 850\nКомплект для ближнего боя. Подбор патронов увеличен.\n\nКомент от гильзы: скорострельность на экране не соответсвует скорострельности в игре тк код связанный с модификацией этих параметров, как бы так оно сказать... ебанутый.",
		bm_wpn_fps_upg_ar_ap_rounds = "Бронебойные боеприпасы",
		bm_wpn_fps_upg_ar_ap_rounds_desc = "Пробивают нательную броню, щиты и стены.\n\nПодбор патронов уменьшен, но не так сильно, как при использовании полноценных бронебойных наборов.",
		bm_wpn_fps_upg_smg_ap_rounds = "Бронебойные боеприпасы",
		bm_wpn_fps_upg_smg_ap_rounds_desc = "Пробивают щиты и нательную броню врагов.\nПодбор патронов уменьшен.",
		bm_wpn_fps_upg_pist_ap_rounds = "Бронебойные боеприпасы",
		bm_wpn_fps_upg_pist_ap_rounds_desc = "Пробивают щиты и нательную броню врагов.\nПодбор патронов уменьшен.",
		bm_wpn_fps_upg_762_to_556_kit = "Комплект для конвертации на 5.56",
		bm_wpn_fps_upg_762_to_556_kit_desc = "Преобразует ресивер текущего оружия для использования патронов калибра 5.56.\nПодбор патронов увеличен.\n\n(Представь что эта модификация еще и визуально меняет ствол и магазин, чтобы было ещё круче :D)",
		bm_wpn_fps_smg_mp5_m_straight_R = "Патроны RIP",
		wpn_fps_ass_shak12_body_vks_R = "Бронебойный набор для KS-12",
		bm_wpn_fps_upg_ass_m4_b_beowulf_newname = "Бронебойный набор для M4",
		bm_wpn_fps_upg_ass_ak_b_zastava_newname = "Бронебойный набор для AK",
		bm_wp_akm_b_standard_gold = "Стандартный Золотой ствол AKM",
		bm_wpn_fps_ass_g3_b_sniper_newname = "Бронебойный набор для Gewehr3",
		bm_wpn_fps_ass_g3_b_long_newname = "Стандартный длинный ствол Gewehr3",
		bm_wpn_fps_pis_c96_b_long_newname = "Бронебойный набор для C96",
		bm_wp_c96_b_standard = "Стандартный ствол C96",
		bm_wpn_fps_anynewassaultkit_desc = "Позволяет пробивать насквозь щиты, стены и нательную броню врагов.\nПодбор патронов уменьшен.",
		wpn_fps_ass_hcar_barrel_dmr_PEN = "Бронебойный набор для Akron HC",
		bm_wpn_fps_ass_hcar_barrel_dmr_PEN_desc = "Позволяет пробивать насквозь стены и нательную броню врагов.\nОграничивает режим стрельбы оружия - только одиночными.\nПодбор патронов уменьшен.",
		bm_wp_hcar_barrel_standard = "Стандартный ствол для Akron HC",
		wpn_fps_upg_m4_hp_rounds = "Патрон с экспансивной пулей",
		wpn_fps_upg_m4_hp_rounds_desc = "Патрон с экспансивной пулей со свинцовым сердечником, с биметаллической оболочкой в стальной гильзе. Предназначены для охоты.\n\nПодбор патронов уменьшен.",
		
		-- flamethrower 'ammo'
		bm_wpn_fps_fla_mk2_mag_rare_desc = "Меньшая непосредственная огневая мощь, но увеличинный урон во время анимации горения.\n75% шанс начала анимации горения во время которой противник получает 700 единиц урона в течение 3 секунд.\nБазовые значения огнемета: 25% шанс на 300 урона в течение 2 секунд.",
		bm_wpn_fps_fla_mk2_mag_welldone_desc = "Большая непосредственная огневая мощь, но уменьшенный урон во время анимации горения.\n5% шанс начала анимации горения во время которой противник получает 150 единиц урона в течение 1 секунды.\nБазовые значения огнемета: 25% шанс на 300 урона в течение 2 секунд.",
		
		-- throwables
		bm_wpn_prj_ace_desc = "Урон: 560\nМожет убить кого угодно, кроме дозеров, попаданием в голову на сложности ЖС.\n",
		bm_grenade_frag_desc = "Урон: 5000\nРадиус: 350\n\nСтандартные характеристики гранаты в PD2:\nУрон 1600\nРадиус 500\n",
		bm_wpn_prj_four_desc = "Урон: 250\nНаносит достаточно ядовитого урона, чтобы убить любого врага, кроме клокеров и дозеров.\nУточнение: может убить клокеров ядовитым уроном, если попасть сюрикеном в голову.\n",
		bm_wpn_prj_hur_desc = "Урон: 1300\nМожет убить тяжелого сотрудника SWAT одним попаданием в тело на сложности ЖС.\n",
		bm_wpn_prj_jav_desc = "Урон: 8000\nМожет убить миниган дозеров двумя попаданиями в тело на сложности ЖС.\n",
		bm_wpn_prj_target_desc = "Урон: 700\nМожет убить легкого сотрудника SWAT одним попаданием в тело на сложности ЖС.\n",
		bm_concussion_desc = "МОИ ГЛАЗА!!!\nНет изменений по сравнению с базовой игрой, кроме максимального количества.\n",
		bm_dynamite_desc = "Урон: 2500\nРадиус: 700",
		bm_grenade_frag_com_desc = "Урон: 5000\nРадиус: 350\n\nСтандартные характеристики гранаты в PD2:\nУрон 1600\nРадиус 500\n",
		bm_grenade_sticky_grenade_desc = "Урон: 2000\nРадиус: 350\n\nУрон и радиус липучей гранаты в базовой игре: 1200 и 500\nДолжна быть немного более сложной в использовании. Количество остается неизменным для компенсации новой статистики.",
		bm_grenade_xmas_snowball_desc = "Урон: 400\nРадиус: 100\n\nУрон снежка в базовой игре: 280\nДолжно чувствоваться примерно так же с учетом изменений здоровья врагов Гилзы.",
		bm_grenade_fir_com_desc = "Урон взрыва: 1000 + 1500 урона от последующего горениея в течение 2 секунд.\n",
		bm_grenade_dada_com_desc = "Урон: 2500\nРадиус: 700",
		bm_grenade_molotov_desc = "Урона от взрыва нет, создает огненное кольцо на 15 секунд. Любой враг, попавший в контакт с огнем, получает 700 урона в течение 3 секунд.\nЕсли враг не выйдет из круга, он получит примерно 8000 урона в общей сложности.\n",
		bm_grenade_electric_desc = "Зап-зап.\nНет изменений по сравнению с базовой игрой, за исключением максимального количества.\n",
		bm_grenade_poison_gas_grenade_desc = "Урон: 100 от взрыва + 300 в течение 30 секунд. Облако длится 20 секунд.\n",
		
		-- launcher nades
		bm_wp_upg_a_grenade_launcher_velocity = "Высокоскоростной снаряд",
		bm_wp_upg_a_grenade_launcher_velocity_desc = "Увеличивает скорость снаряда до 300%, при этом уменьшая радиус взрыва до 50%.",
		bm_wpn_fps_upg_a_grenade_launcher_incendiary_desc = "После детонации создает огненное поле горящее 10 секунд.\nВраги попавшие в это поле получают 1000 ед. урона в течении 3 секунд и еще больше, если враг остается в радиусе поля.\nПодбор патронов существенно уменьшен.",
		bm_wpn_fps_upg_a_grenade_launcher_poison_desc = "Во время детонации наносит 100 ед. урона и затем создает газовое облако на 10 секунд.\nВраги попавшие в это поле получают максимум 500 ед. урона в течении 30 секунд.\nШансы убить врага минимальны, но данный снаряд эффективно ослабивает врагов, особенно тех которые далеко от вас.\n\nНа заметку: наносит 'тик' урона каждые 0.25 сек.",
		bm_wpn_fps_upg_a_grenade_launcher_incendiary_arbiter_desc = "После детонации создает огненное поле горящее 5 секунд.\nВраги попавшие в это поле получают 800 ед. урона в течении 3 секунд и еще больше, если враг остается в радиусе поля.\nПодбор патронов существенно уменьшен.",
		bm_wpn_fps_upg_a_grenade_launcher_poison_arbiter_desc = "Во время детонации наносит 100 ед. урона и затем создает (уменьшенное по сравнению с другими гранатометами) газовое облако на 10 секунд..\nВраги попавшие в это поле получают максимум 500 ед. урона в течении 11 секунд.\nШансы убить врага минимальны, но данный снаряд эффективно ослабивает врагов, особенно тех которые далеко от вас.",
		
	})
	else
		loc:load_localization_file(Gilza._path .. 'menus/lang/Gilza_en.txt', false)
		LocalizationManager:add_localized_strings({
		-- perks
		menu_deckall_8 = "Improved Physique",
		menu_deckall_8_desc = "You gain ##10%## additional movement speed.\n\nYou can throw bags ##50%## further.",
		menu_deckall_6_desc = "Unlocks an armor bag equipment for you to use. The armor bag can be used to change your armor during a heist.\n\nIncreases your ammo pickup to ##135%## of the normal rate.\n\nYou also gain a base ##0%## chance to get a throwable from an ammo box. The base chance is increased by ##1.2%## for each ammo box you pick up that does not contain a throwable. When a throwable has been found, the chance is reset to its base value.",
		menu_deckall_2 = "Fast and Furious",
		menu_deckall_2_desc = "Increases your doctor bag interaction speed by ##20%##",
		menu_deck18_1_desc = "Unlocks and equips the throwable Smoke Bomb.\n\nChanging to another perk deck will make the Smoke Bomb unavailable again. The Smoke Bomb replaces your current throwable, is equipped in your throwable slot and can be switched out if desired.\n\nWhile in game you can use throwable key to deploy the Smoke Bomb.\n\nWhen deployed, the smoke bomb creates a smoke screen that lasts for ##10## seconds. While standing inside the smoke screen, you and any of your allies automatically avoid ##50%## of all bullets. Any enemies that stand in the smoke will see their accuracy reduced by ##50%##.\n\nAfter the smoke screen dissipates, the Smoke Bomb is on a cooldown for ##40## seconds, but killing enemies will reduce this cooldown by ##1## second.",
		menu_deck10_1_desc = "Ammo packs you pick up also yield medical supplies and heal you for ##16## to ##24## health.\n\nCannot occur more than once every ##3## seconds.\n\nIf the Gambler's current health is lower than another player's, the heal effect on the Gambler is increased by ##35%##. Does not stack.",
		menu_deck4_9_desc = "Your chance to dodge is increased by an additional ##5%##.\nYour chance to dodge while crouched is increased by ##5%##.\nYour movement speed is increased by ##15%##.\nYour stamina is increased by ##25%##.\n\nAll your weapons have a ##50%## chance to pierce enemy armor.\nIncreases weapon swapping speed by ##80%##.\n\nDeck Completion Bonus: Your chance of getting a higher quality item during a Payday is increased by ##10%##.",
		
		-- skills
		menu_pack_mule_beta_desc = "BASIC: ##$basic##\nFor each ##10## armor points, the bag movement penalty is reduced by ##1%##.\n\nACE: ##$pro##\nYou can sprint with any bag.",
		menu_awareness_beta_desc = "BASIC: ##$basic##\nYou gain ##20%## increased speed when climbing ladders.\n\nYou gain the ability to sprint in any direction.\n\nACE: ##$pro##\nRun and reload - you can reload your weapons while sprinting.",
		menu_overkill_beta_desc = "BASIC: ##$basic##\nWhen you kill an enemy with a Shotgun or the OVE9000 portable saw, you receive a ##40%## damage increase for ##30## seconds.\n\nACE: ##$pro##\nThe damage bonus now applies to all weapons. Skill must be activated using a Shotgun or the OVE9000 portable saw. Your weapon swap speed is increased by ##80%##\n\nNote: Does not apply to melee damage, throwables, grenade launchers or rocket launchers.",
		menu_far_away_beta = "BLAST AWAY",
		menu_far_away_beta_desc = "BASIC: ##$basic##\nEvery time you fire any Shotgun you get ##7.5%## chance to not consume any ammo.\n\nACE: ##$pro##\nYour chances to not consume any ammo increase to ##20%##",
		menu_close_by_beta_desc = "BASIC: ##$basic##\nYou can now hip-fire with your Shotguns while sprinting.\n\nACE: ##$pro##\nYour rate of fire is increased by ##25%## while firing from the hip with single shot Shotguns.",
		menu_shotgun_cqb_beta_desc = "BASIC: ##$basic##\nYou reload Shotguns ##15%## faster.\n\nACE: ##$pro##\nYou reload Shotguns ##35%## faster.",
		menu_shotgun_impact_beta = "Shotgun expert",
		menu_shotgun_impact_beta_desc = "BASIC: ##$basic##\nYou gain ##125%## increased steel sight zoom speed when using shotguns.\nYou gain ##15%## better stability with all shotguns.\n\nACE: ##$pro##\nYou gain ##40%## better stability with all shotguns.",
		menu_steady_grip_beta_desc = "BASIC: ##$basic##\nYou gain ##4## weapon Stability.\n\nACE: ##$pro##\nYou gain ##8## more weapon Stability, for a total of ##12##.",
		menu_stable_shot_beta_desc = "BASIC: ##$basic##\nYou gain ##4## weapon Accuracy.\n\nACE: ##$pro##\nYou gain ##4## more weapon Accuracy, for a total of ##8##.",
		menu_sharpshooter_beta = "Slow and Steady",
		menu_sharpshooter_beta_desc = "BASIC: ##$basic##\nYou gain ##5%## damage resistance while standing still or bipoded.\n\nACE: ##$pro##\nYou gain extra ##35%## damage resistance while bipoded.\nYour bipod deploy speed is increased by ##100%##.",
		menu_rifleman_beta = "Agile Marksman",
		menu_rifleman_beta_desc = "BASIC: ##$basic##\nYour snap to zoom is ##100%## faster with all weapons.\n\nYour weapon zoom level is increased by ##25%## with all weapons.\n\nACE: ##$pro##\nWhile aiming down sights your movement speed is unhindered.\n\nYour ##25%## accuracy penalty while ##moving and aiming## is removed.",
		menu_fire_control_beta_desc = "BASIC: ##$basic##\nYou gain ##12## weapon accuracy while firing from the hip.\n\nACE: ##$pro##\nYour ##25%## accuracy penalty while ##moving and hip-firing## is removed.",
		menu_bandoliers_beta_desc = "BASIC: ##$basic##\nYour total ammo capacity is increased by ##25%##.\n\nACE: ##$pro##\nIncreases the amount of ammo you gain from ammo boxes by ##75%##.You also gain a base ##10%## chance to get a throwable from an ammo box. The base chance is increased by ##2%## for each ammo box you pick up that does not contain a throwable. When a throwable has been found, the chance is reset to its base value.\n\nNote: Does not stack with the perk skill 'Walk-in Closet'.",
		menu_martial_arts_beta = "Tough Guy",
		menu_steroids_beta = "Martial Arts",
		menu_steroids_beta_desc = "BASIC: ##$basic##\nYou charge your melee weapons ##100%## faster.\n\nACE: ##$pro##\nYou can now sprint while using melee weapons.",
		menu_bloodthirst_desc = "BASIC: ##$basic##\nEvery kill you get will increase your next melee attack damage by ##25%##, up to a maximum of ##700%##. This effect gets reset when you kill an enemy with a melee attack.\n\nACE: ##$pro##\nWhenever you kill an enemy with a melee attack, you will gain a ##50%## increase in reload speed for ##10## seconds.",
		menu_sociopathinfil_1_desc = "When you are surrounded by three enemies or more, you receive ##12%## less damage from enemies.\n\nYour second and each consecutive melee hit within ##4## seconds of the last one will deal ##75%## more damage.\n",
		menu_up_you_go_beta_desc = "BASIC: ##$basic##\nYou take ##30%## less damage for ##10## seconds after being revived.\n\nACE: ##$pro##\nYou receive additonal ##35%## of your maximum health when revived.\n\nNote: This adds up to about ##75%## health on difficulties lower then Mayhem, and ##45%## health on all difficulties above and including Mayhem.",
		menu_body_expertise_beta_desc = "BASIC: ##$basic##\n##25%## from the bonus headshot damage is permanently applied to hitting enemies on the body. This skill is only activated by SMGs, LMGs, Assault Rifles or Special Weapons fired in automatic mode.\n\nACE: ##$pro##\n##50%## from the bonus headshot damage is permanently applied to hitting enemies on the body. This skill is only activated by SMGs, LMGs, Assault Rifles or Special Weapons fired in automatic mode.\n\nGilza note: due to how this skill calculates additional bodyshot damage, you can think of basic version of the skill giving you ##1.5x## times the damage on bodyshots, and aced version giving you ##2x## times the damage, since normally, headshots in Gilza deal ##3x## damage to every enemy, except for cloakers and bulldozers.",
		menu_dance_instructor_desc = "BASIC: ##$basic##\nYou gain ##20%## increased rate of fire with pistols.\n\nACE: ##$pro##\nYour pistol magazine sizes are increased by ##8## bullets.",
		menu_gun_fighter_beta = "Bottomless pockets",
		menu_gun_fighter_beta_desc = "BASIC: ##$basic##\nYou gain ##15%## more reserve ammunition with all pistols.\n\nACE: ##$pro##\nYou gain ##50%## more reserve ammunition with all pistols.\n\nGilza note: both versions stack with akimbo ammo reserve increasing skills.",
		menu_speedy_reload_beta_desc = "BASIC: ##$basic##\nIncreases your reload speed with SMGs, Assault Rifles and Sniper Rifles by ##20%##.\n\nACE: ##$pro##\nAny killing headshot will increase your reload speed by ##100%## for ##4## seconds. Can only be triggered by SMGs, Assault Rifles and Sniper Rifles fired in single shot fire mode.",
		menu_carbon_blade_beta_desc = "BASIC: ##$basic##\nReducing the wear down of the blades on enemies by ##50%##.\n\nACE: ##$pro##\nYou can now saw through shield enemies with your OVER9000 portable saw. When killing an enemy with the saw, you have a ##50%## chance to cause nearby enemies in a ##10## m radius to panic. Panic will make enemies go into short bursts of uncontrollable fear.\n\nYou can now gain ammunition for the saw from ammo boxes. This pick up is not affected by fully loaded skill or walk-in-closet skill from perk deck cards.",
		menu_sniper_graze_damage_desc = "BASIC: ##$basic##\nSniper rifles that hit targets further then ##7.5m## away deal ##33%## of the their damage in a ##75cm## radius around the bullet trajectory.\n\nThis damage does not increase if initial target was shot in the head, but can be increased by other skills.\n\nACE: ##$pro##\nDamage radius is increased to ##150cm##, damage in this radius is increased to ##66%## of your sniper's damage.",
		menu_wolverine_beta_desc = "BASIC: ##$basic##\nYou deal ##50%## more melee damage.\n\nIf your armor breaks while your health is below ##50%## you gain ##50%## more melee damage for ##20## seconds.\n\nACE: ##$pro##\nMelee damage increase now lasts for ##40## seconds.\n\nIf your armor breaks while your health is below ##50%## you gain ##100%## more damage with ranged weapons for ##15## seconds.\n\nNote: Does not apply to throwables, grenade launchers or rocket launchers.\n\nGilza note: entering berserker state will enable visual screen flash. You can customize or completely disable it in Gilza's mod options.",	
		
		-- brawler deck
		menu_deck_brawler = "Brawler",
		menu_deck_brawler_desc = "Gage tipped Bain off about a shipment of experimental lightweight high power armor suits being transported by Murkywater to one of their facitilies. And who are you, if not THE fucking payday gang? Of course you had to steal it! But after properly inspecting them in your safe house, you found out that they are extremely bulky, yet still somehow comfortable to run around in.\n\nThis, is how you became... THE BRAWLER!",
		menu_deck_brawler1 = "Armor suit upgrade",
		menu_deck_brawler1_desc = "Using this high profile armor suit with any kind of a chest rig is pretty much imposible due to it's form and size. But who needs them, right?\n\nYour total ammo capacity is reduced by ##85%##.\n\nArmor movement penalty is reduced by ##20%##.\n\nYou gain ##18%## bullet damage resistance.",
		menu_deck_brawler3 = "High level armor plates",
		menu_deck_brawler3_desc = "You gain ##18%## more bullet damage resistance.",
		menu_deck_brawler5 = "Lightweight armor plates",
		menu_deck_brawler5_desc = "Armor movement penalty is reduced by additional ##20%##.",
		menu_deck_brawler7 = "Max level armor plates",
		menu_deck_brawler7_desc = "You gain ##18%## more bullet damage resistance.",
		menu_deck_brawler9 = "Meat shield",
		menu_deck_brawler9_desc = "You are ##15%## more likely to be targeted when you are close to your crew members.\n\nSecuring a kill with a melee weapon grants you ##75## points of armor.\n\nWhen you are under ##50%## health you recieve following bonuses:\n- Every enemy further then ##9## meters away from you deals ##18%## less damage\n- Every enemy further then ##16## meters away from you deals ##16%## less damage\n\nAll perk resistance bonuses stack, so enemies beyond ##16## meters will only deal ##12%## damage.\n\nDeck Completion Bonus: Your chance of getting a higher quality item during a Payday is increased by ##10%##.",
		
		-- Weapon Mods
		-- shotgun ammo 
		bm_wpn_fps_upg_a_rip_desc_new = "Poisoned bullet that deals damage over time and can interrupt enemies if they are close enough.\n\nDeals 400 damage over 2 seconds, with a damage tick every 0.5 seconds.\n\nAmmo pick up reduced by 20%",
		bm_wpn_fps_upg_a_custom_desc_new = "Bigger pellets with more impact.\nAmmo pick up reduced by 20%",
		bm_wpn_fps_upg_a_explosive_desc_new = "Fires one explosive charge that kills or stuns targets.\nNo extra headshot damage.\nAmmo pick up reduced by 60%",
		bm_wpn_fps_upg_a_piercing_desc_new = "Peirces enemy body armor. Damage range increased by 50%.\nAmount of darts per shell - 5\nAmmo pick up reduced by 10%",
		bm_wpn_fps_upg_a_slug_desc_new = "Fires a single lead slug that penetrates body armor, enemies, shields and walls. Damage range increased by 20%\nAmmo pick up reduced by 25%",
		bm_wpn_fps_upg_a_dragons_breath_desc_new = "Fires pellets that go up in sparks and flames. Burns through shields and body armor.\nNo extra headshot damage.\nDeals 1180 in fire damage.\nAmmo pick up reduced by 80%",
		bm_wpn_fps_upg_br_shtgn = "Breaching round",
		bm_wpn_fps_upg_br_shtgn_desc = "Allows you to breach everything that saw OVE9000 usually can. Can also penetrate shield and body armor.\nDamage range reduced to only 33%\n", 
		
		-- weapon parts
		bm_wpn_fps_ass_g3_b_sniper_desc = "ACTUAL RATE OF FIRE: 450\nPierce enemy body armor, shields and walls. Ammo pick up decreased.",
		bm_wpn_fps_ass_g3_b_short_desc = "ACTUAL RATE OF FIRE: 850\nClose quaters assault kit. Ammo pick up increased.",
		bm_wpn_fps_upg_ar_ap_rounds = "AP rounds",
		bm_wpn_fps_upg_ar_ap_rounds_desc = "Pierce enemy body armor, shields and walls.\n\nAmmo pick up is reduced, but not as much as full on AP kits.",
		bm_wpn_fps_upg_smg_ap_rounds = "AP rounds",
		bm_wpn_fps_upg_smg_ap_rounds_desc = "Pierce enemy shields and body armor.\nAmmo pick up reduced.",
		bm_wpn_fps_upg_pist_ap_rounds = "AP rounds",
		bm_wpn_fps_upg_pist_ap_rounds_desc = "Pierce enemy shields and body armor.\nAmmo pick up reduced.",
		bm_wpn_fps_upg_762_to_556_kit = "5.56 Conversion kit",
		bm_wpn_fps_upg_762_to_556_kit_desc = "Convers current weapon's reciever to support 5.56 caliber ammunition.\nAmmo pick up increased.\n\n(Pretend that it actually changes the reciever and the mag visually, so its even cooler)",
		bm_wpn_fps_smg_mp5_m_straight_R = "RIP rounds",
		wpn_fps_ass_shak12_body_vks_R = "KS12 Armor Piercing Kit",
		bm_wpn_fps_upg_ass_m4_b_beowulf_newname = "M4 Armor Piercing Kit",
		bm_wpn_fps_upg_ass_ak_b_zastava_newname = "AK Armor Piercing Kit",
		bm_wp_akm_b_standard_gold = "Standard AKM Gold Barrel",
		bm_wpn_fps_ass_g3_b_sniper_newname = "Gewehr3 Armor Piercing Kit",
		bm_wpn_fps_ass_g3_b_long_newname = "Standard Gewehr3 Long Barrel",
		bm_wpn_fps_pis_c96_b_long_newname = "C96 Armor Piercing Kit",
		bm_wp_c96_b_standard = "Standard C96 Barrel",
		bm_wpn_fps_anynewassaultkit_desc = "Allows you to penetrate shields, walls and enemy body armor.\nAmmo pick up is reduced.",
		wpn_fps_ass_hcar_barrel_dmr_PEN = "Akron HC AP Kit",
		bm_wpn_fps_ass_hcar_barrel_dmr_PEN_desc = "Allows you to penetrate enemy body armor and walls.\nLimits weapon to single-fire mode.\nAmmo pick up reduced.",
		bm_wp_hcar_barrel_standard = "Standard Akron HC Barrel",
		wpn_fps_upg_m4_hp_rounds = "HP rounds",
		wpn_fps_upg_m4_hp_rounds_desc = "Lead core hollow-point bullet with a bimetallic jacket in a steel case. Intended for hunting.\n\nAmmo pick up reduced.",
		
		-- flamethrower 'ammo'
		bm_wpn_fps_fla_mk2_mag_rare_desc = "Less direct firepower but more afterburn damage.\n75% chance to start afterburn damage that deals 700 damage over 3 seconds.\nBase flamethrower values: 25% chance for 300dmg over 2 seconds.",
		bm_wpn_fps_fla_mk2_mag_welldone_desc = "More direct firepower but less afterburn damage.\n5% chance to start afterburn damage that deals 150 damage over 1 second.\nBase flamethrower values: 25% chance for 300dmg over 2 seconds.",
		
		-- throwables
		bm_wpn_prj_ace_desc = "Damage: 560\nCan one-shot anyone other then dozers in the head on DW difficulty.\n",
		bm_grenade_frag_desc = "Damage: 5000\nRadius: 350\n\nVanilla PD2 grenade stats: 1600 damage\n500 radius\n",
		bm_wpn_prj_four_desc = "Damage: 250\nDeals enough poison damage to finish off every enemy except for cloaker/dozer.\nClarification: can actually finish off cloakers if you land shuriken in the head.\n",
		bm_wpn_prj_hur_desc = "Damage: 1300\nCan one-shot heavy swat in the body on DW difficulty.\n",
		bm_wpn_prj_jav_desc = "Damage: 8000\nCan two-shot non-minigun dozers on DW difficulty.\n",
		bm_wpn_prj_target_desc = "Damage: 700\nCan one-shot normal swat in the body on DW difficulty.\n",
		bm_concussion_desc = "MY EYES!!!\nNo changes compared to base game other then the max amount.\n",
		bm_dynamite_desc = "Damage: 2500\nRadius: 700",
		bm_grenade_frag_com_desc = "Damage: 5000\nRadius: 350\n\nVanilla PD2 grenade stats: 1600 damage\n500 radius\n",
		bm_grenade_sticky_grenade_desc = "Damage: 2000\nRadius: 350\n\nBase game sticky damage and radius: 1200 and 500\nShould be a bit more of a skill shot nade. Amounts are kept the same to compensate.",
		bm_grenade_xmas_snowball_desc = "Damage: 400\nRadius: 100\n\nBase game snowball damage: 280\nShould feel roughly the same considering Gilza's health pool changes.",
		bm_grenade_fir_com_desc = "Damage: 1000 direct + 1500 with afterburn over 2 seconds.\n",
		bm_grenade_dada_com_desc = "Damage: 2500\nRadius: 700",
		bm_grenade_molotov_desc = "No direct damage, creates a fire ring for 15 seconds. Any enemy that comes in contact with fire recieves 700 damage over 3 seconds.\nIf enemy doesn't get out of the circle they will recieve roughly 8000 damage overall.\n",
		bm_grenade_electric_desc = "Zap-zap.\nNo changes compared to base game other then the max amount.\n",
		bm_grenade_poison_gas_grenade_desc = "Damage: 100 direct + 300 over 30 seconds. Cloud lasts for 20 seconds.\n",
		
		-- launcher nades
		bm_wp_upg_a_grenade_launcher_velocity = "High Velocity Round",
		bm_wp_upg_a_grenade_launcher_velocity_desc = "Increases grenade velocity to 300%, but decreases blast radius to 50%.",
		bm_wpn_fps_upg_a_grenade_launcher_incendiary_desc = "Upon impact creates a fire field that lasts for 10 seconds.\nEnemies that come in contact with fire, recieve 1000dmg over 3 seconds, or even more if they stay inside the ring of fire.\nAmmo pick-up is drastically reduced.",
		bm_wpn_fps_upg_a_grenade_launcher_poison_desc = "Upon impact deals 100dmg and creates a gas field that lasts for 10 seconds.\nEnemies that come in contact with gas, recieve at max 500dmg over 30 seconds.\nLow kill potential, but is really effective at weakening enemies who haven't come close to you yet.\n\nNote: deals ticks of damage every 0.25s.",
		bm_wpn_fps_upg_a_grenade_launcher_incendiary_arbiter_desc = "Upon impact creates a fire field that lasts for 5 seconds.\nEnemies that come in contact with fire, recieve 800dmg over 3 seconds, or even more if they stay inside the ring of fire.\nAmmo pick-up is drastically reduced.",
		bm_wpn_fps_upg_a_grenade_launcher_poison_arbiter_desc = "Upon impact deals 100dmg and creates a (smaller compared to other launchers) gas field that lasts for 10 seconds.\nEnemies that come in contact with gas, recieve at max 500dmg over 11 seconds.\nLow kill potential, but is really effective at weakening enemies who haven't come close to you yet.",
		
	})	
	end

end)