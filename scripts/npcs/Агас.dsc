#Агас
preparing_agas:
    type: world
    events:
        on player joins:
            - if !<player.has_flag[agas_quests_stage]>:
                - flag player agas_quests_stage:0

agas_assign:
    type: assignment
    actions:
        on assignment:
            - trigger name:click state:true
            - trigger name:chat state:true cooldown:1s radius:50
    interact scripts:
        - agas_interact

agas_interact:
    type: interact
    steps:
        1:
            click trigger:
                script:
                    - random:
                        # - narrate '<&lt>Агас<&gt> '
                        - narrate '<&lt>Агас<&gt> Приветствую путник, имя мне Агас, хранитель лесов. А каково вашего имени?'
                        - narrate '<&lt>Агас<&gt> Экие дивные лица! Дня доброго. Имя моё Агас, а как зовут вашего племени?'
                        - narrate '<&lt>Агас<&gt> Здравия вам, странник. Агас - имя моё. А вашего каково будет?'
                        - narrate '<&lt>Агас<&gt> Ваших, я думается, ещё не видывал. Счастья желаю! Имя мне Агас. Каково будет вашего?'
                    - ^playsound <player> sound:entity_villager_ambient volume:1 pitch:0.1
                    - ^wait 3
                    - run aliasing_notification
                    - zap 2
        2:
            click trigger:
                script:
                    - run aliasing_notification
            chat trigger:
                1:
                    trigger: Меня зовут /*/
                    script:
                        - flag player alias4agas:<player.chat_history>
                        - cooldown 2s
                        - wait 0.75
                        - random:
                            - narrate '<&lt>Агас<&gt> Рад новому знакомству, <player.flag[alias4agas]>. Природу-мать не трожьте, и сопутствовать вашему удача будет!'
                            - narrate '<&lt>Агас<&gt> О как! Имечко-то интересное у вас для наших краёв. Распологайтесь, <player.flag[alias4agas]>. Лес токмо не трожьте.'
                            - narrate '<&lt>Агас<&gt> А всё же приятно новых знакомств заиметь. Не стесняйтесь, <player.flag[alias4agas]>, проходьте. Всегда гостю рад лесной царь.'
                            - narrate '<&lt>Агас<&gt> Враждой от вас не веет, <player.flag[alias4agas]>. Отрадно, что к нам вы заглянули! Проходьте. Токмо осторожно! Цветков не заденьте.'
                        - ^playsound <player> sound:entity_villager_ambient volume:1 pitch:0.1
                        - zap 3
        3:
            click trigger:
                script:
                    - if <player.flag[agas_quests_stage]> == 0 && <player.item_in_hand.material.name> == bone_meal:
                        - cooldown 1m
                        - narrate '<&lt>Агас<&gt> Ой, нешто это то, чього я кумекаю?'
                        - ^playsound <player> sound:entity_villager_ambient volume:1 pitch:0.1
                        - ^wait 3s
                        - narrate '<&lt>Агас<&gt> А много ль ещё добра такого у вашего?'
                        - ^playsound <player> sound:entity_villager_ambient volume:1 pitch:0.1
                        - ^wait 3s
                        - narrate '<&lt>Агас<&gt> Мне в радость бы было, принеси ваши мне такого поболе.'
                        - ^playsound <player> sound:entity_villager_ambient volume:1 pitch:0.1
                        - ^wait 4s
                        - narrate '<&lt>Агас<&gt> А мы-б вам да отплатили! Слухал я, что вы тут все кристаллов рыскуете, так оно?'
                        - ^playsound <player> sound:entity_villager_ambient volume:1 pitch:0.1
                        - ^wait 6s
                        - narrate '<&lt>Агас<&gt> У нашего-то лесу найдётся чуток. Всему вашему племени хватит!'
                        - ^playsound <player> sound:entity_villager_ambient volume:1 pitch:0.1
                        - ^wait 5s
                        - execute as_player "quests take Сдобрения для леса"
                        - flag player agas_quests_stage:1
                    - else if <player.flag[agas_quests_stage]> >= 1 && <player.item_in_hand.material.name> == bundle:
                        - narrate '<&lt>Агас<&gt> Чудно, благодарю! Держите, вашему племени такое понравится!'
                        - ^playsound <player> sound:entity_villager_yes volume:1 pitch:0.1
                        - ^wait 3s
                        - narrate '<&lt>Агас<&gt> Приходьте ещё поболтать, халтурка авось найдётся'
                        - ^playsound <player> sound:entity_villager_yes volume:1 pitch:0.1
                        - flag player agas_quests_stage:2
                    - else:
                        - cooldown 1s
                        - random:
                            - run quest_logic_agas
                            - narrate '<&lt>Агас<&gt> Эко беда, опять дрова зря жгут! Лес-то не бездонный, беречь надо, а не рубить без счёта.'
                            - narrate '<&lt>Агас<&gt> Слышь, воду из реки черпают, а обратно грязь льют. Ну как так можно? Река ведь не помойная яма!'
                            - narrate '<&lt>Агас<&gt> Ох, траву вытоптали, яко скот ненасытный. Земля-то живая, ей больно, понимаешь?"'
                            - narrate '<&lt>Агас<&gt> Эх, зверей распугали, яко ветер злой. Лес без них — как дом без хозяина, пусто ведь!'
                            - narrate '<&lt>Агас<&gt> Смотри-ка, костёр развели, а потом не затушили. Огонь — он ведь как зверь, если не уследишь, всё спалит!'
                            - narrate '<&lt>Агас<&gt> Ой, ягоды незрелые рвут, грибы все подчистую. Ну хоть немного оставьте, для леса же!'
                            - narrate '<&lt>Агас<&gt> Эко дело, рыбу сетями ловят, всю подряд. Ну хоть мальков-то отпустили бы, да?'
                            - narrate '<&lt>Агас<&gt> Слышь, деревья молодые ломают, яко дети озорные. Они ведь тоже жить хотят, понимаешь?'
                            - narrate '<&lt>Агас<&gt> Ох, землю копают, а потом бросили, яко яму ненужную. Земля-то ведь не бессмертная, ей отдых нужен!'
                            - narrate '<&lt>Агас<&gt> Эх, птичьи гнёзда разоряют, яко разбойники лихие. Ну как так можно? Они ведь тоже семью имеют!'
                            # - narrate '<&lt>Агас<&gt> '
            chat trigger:
                work:
                    trigger: Есть /regex:(?i)(?u)работа|дел(а|о)|задани(я|е)/?
                    script:
                    - cooldown 1s
                    - run quest_logic_agas
                1:
                    trigger: Что это за огромное /regex:(?i)(?u)д(е)?рево/?
                    script:
                    - cooldown 1s
                    - wait 0.75
                    - random:
                        - narrate '<&lt>Агас<&gt> Се не просто древо, царь это наш лесной! Он живность всякую любит и благословит. Приютит в тени крон, да путь укажет.'
                        - narrate '<&lt>Агас<&gt> Лесной царь наш, сколь лес вширь - столь он ввысь. Деток мы поучаем уважить старшого и вам кличем - уважьте Його!'
                        - narrate '<&lt>Агас<&gt> Дом всякой живности и отец всяких древ - Лесной царь. Ваших и наших приют здешний.'
                        - narrate '<&lt>Агас<&gt> Чудо-юдо природы, лесной царь. Милосердный да великий крон его ни единой душонки не обделит.'
                    - ^playsound <player> sound:entity_villager_ambient volume:1 pitch:0.1
                2:
                    trigger: Что скажешь о /regex:(?i)(?u)Почтальон/е?
                    script:
                    - cooldown 1s
                    - wait 0.75
                    - narrate '<&lt>Агас<&gt> Этот сорванец то со свином шлялся, то ещё не знамо к кому.'
                    - ^playsound <player> sound:entity_villager_ambient volume:1 pitch:0.1
                    - ^wait 3
                    - narrate '<&lt>Агас<&gt> Однажды ко мне подошёл, да бумаги кусок протянул, изверг!'
                    - ^playsound <player> sound:entity_villager_ambient volume:1 pitch:0.1
                    - ^wait 3
                    - narrate '<&lt>Агас<&gt> Я с тех пор как токмо его у своём лесу заслышу - сразу корни свиваю за в землю тащу!'
                    - ^playsound <player> sound:entity_villager_ambient volume:1 pitch:0.1
                    - ^wait 4
                    - narrate '<&lt>Агас<&gt> Негоже моего племени осквернять!'
                    - ^playsound <player> sound:entity_villager_no volume:1 pitch:0.1
                3:
                    trigger: /regex:(?i)(?u)Кот-полиглот/ - это вообще кто?
                    script:
                    - cooldown 1s
                    - wait 0.75
                    - narrate '<&lt>Агас<&gt> Так это ж знакомы мой закадычный!'
                    - ^playsound <player> sound:entity_villager_yes volume:1 pitch:0.1
                    - ^wait 2
                    - narrate '<&lt>Агас<&gt> Иногда приходють сюды да историй расказуеть!'
                    - ^playsound <player> sound:entity_villager_yes volume:1 pitch:0.1
                    - ^wait 2
                    - narrate '<&lt>Агас<&gt> Токмо делся куда-то он...'
                    - ^playsound <player> sound:entity_villager_no volume:1 pitch:0.1
                4:
                    trigger: /regex:(?i)(?u)П(е|ё)с(\-|\s)стражник|Художник/, знаешь его?
                    script:
                    - cooldown 1s
                    - wait 0.75
                    - narrate '<&lt>Агас<&gt> Не знамо мне таких имён...'
                    - ^playsound <player> sound:entity_villager_no volume:1 pitch:0.1
                5:
                    trigger: Знаешь кто такая /regex:(?i)(?u)Девочка(\-|\s)скаут|Рана|Художница/?
                    script:
                    - cooldown 1s
                    - wait 0.75
                    - narrate '<&lt>Агас<&gt> Хто это? Впервые слышу!'
                    - ^playsound <player> sound:entity_villager_trade volume:1 pitch:0.1
                    - ^wait 2
                    - narrate '<&lt>Агас<&gt> Ещё один вашего племени?'
                    - ^playsound <player> sound:entity_villager_trade volume:1 pitch:0.1
                6:
                    trigger: Что такое /regex:(?i)(?u)Мимпи|Дух|Приведение/?
                    script:
                    - cooldown 1s
                    - wait 0.75
                    - narrate '<&lt>Агас<&gt> Се ж творец наш великой, нешто не знамо вашему?'
                    - ^playsound <player> sound:entity_villager_trade volume:1 pitch:0.1
                    - ^wait 1
                    - narrate '<&lt>Агас<&gt> Оно ж и травинку сотворило, и лесок, в поле - каждый колосок!'
                    - ^playsound <player> sound:entity_villager_yes volume:1 pitch:0.1
                    - ^wait 1
                    - narrate '<&lt>Агас<&gt> Жаль токмо, что покинул он нашего племени, лишь во снях являеться...'
                    - ^playsound <player> sound:entity_villager_ambient volume:1 pitch:0.1
                7:
                    trigger: Знаешь /regex:(?i)(?u)Шляпстер|Джентльмен/а?
                    script:
                    - cooldown 1s
                    - wait 0.75
                    - narrate '<&lt>Агас<&gt> Знаю, и я этого ирода даже в поля не пущу!'
                    - ^playsound <player> sound:entity_villager_no volume:1 pitch:0.1
                    - ^wait 2
                    - narrate '<&lt>Агас<&gt> Уж не знаю куда он спрятался, но из подземли я его достану если - не жить ему.'
                    - ^playsound <player> sound:entity_villager_no volume:1 pitch:0.1
                    - ^wait 4
                    - narrate '<&lt>Агас<&gt> Экое дело "бизнес"! Ух, попадись мне, рога пообломаю!'
                8:
                    trigger: Знаешь /regex:(?i)(?u)Пивовар/а?
                    script:
                    - cooldown 1s
                    - wait 0.75
                    - narrate '<&lt>Агас<&gt> ОН ХОТЕЛ СОТВОРИТЬ С ЛЕСНОГО ЦАРЯ БОЧКУ, Я ЕМУ КОРНИ В КИШКИ НАПИХАЮ!!!'
                    - ^playsound <player> sound:entity_villager_no volume:1 pitch:0.4
                    # - narrate '<&lt>Агас<&gt> '

# Квесты
# 000001 - Сдобрения для леса
# 000002 - Зелёная политика
# 000003 - Друиды и экзорцисты

quest_logic_agas:
    type: task
    script:
        - if <player.flag[agas_quests_stage]> == 0:
            - narrate '<&lt>Агас<&gt> Ой-ой-оюшки... Совсем лес исхудал...'
            - ^playsound <player> sound:entity_villager_no volume:1 pitch:0.1
            - ^wait 2s
            - narrate '<&lt>Агас<&gt> Вот бы принёс кто сдобрений...'
            - ^playsound <player> sound:entity_villager_trade volume:1 pitch:0.1
        - else if <player.flag[agas_quests_stage]> >= 1:
            - cooldown 20s
            - narrate '<&lt>Агас<&gt> Окак! День добрый! Видали, как наша чаща поредела?'
            - ^playsound <player> sound:entity_villager_yes volume:1 pitch:0.1
            - ^wait 2
            - narrate '<&lt>Агас<&gt> А мне давеча нажужжала бджолка, что у вашего племени множество побегов залежалось.'
            - ^playsound <player> sound:entity_villager_ambient volume:1 pitch:0.1
            - ^wait 4
            - narrate '<&lt>Агас<&gt> Могли б подсобить ваши с высадкой, в сем случае? В обиде не оставлю!'
            - ^playsound <player> sound:entity_villager_trade volume:1 pitch:0.1
            - ^wait 5s
            - execute as_player "quests take Зелёная политика"
            - flag player agas_quests_stage:3
        - else if <player.flag[agas_quests_stage]> == 3:
            - cooldown 20s
            - narrate '<&lt>Агас<&gt> Ух и много-ж тут развелось в последнее время нежити!'
            - ^playsound <player> sound:entity_villager_trade volume:1 pitch:0.1
            - ^wait 3s
            - narrate '<&lt>Агас<&gt> <player.flag[alias4agas]>, друже, не можешь подсобить? Ваше как мне поможет, если подрезать эти их мёртвые тушки!'
            - ^playsound <player> sound:entity_villager_trade volume:1 pitch:0.1
            - ^wait 4s
            - narrate '<&lt>Агас<&gt> Я-то со своими корнями за ними и не угонюсь...'
            - ^playsound <player> sound:entity_villager_trade volume:1 pitch:0.1
            - ^wait 5s
            - execute as_player "quests take Друиды и экзорцисты"
            - flag player agas_quests_stage:++
        - else if <player.flag[agas_quests_stage]> == 4:
            - narrate '<&lt>Агас<&gt> Покамест нет работки. Но чуй-что, обязавно скажум!'
#
academ_agas_assign:
    type: assignment
    actions:
        on assignment:
        - trigger name:click state:true
        - trigger name:chat state:true cooldown:1s radius:50
    interact scripts:
        - academ_agas_interact


academ_agas_interact:
    type: interact
    steps:
        1:
            click trigger:
                script:
                    - random:
                        - define msg "Всем пис!... Так же молодежь сейчас говорит, да?"
                        - define msg "Ты любишь субботники?"
                        - define msg "Когда-то я преподавал детишкам окружающий мир, теперь биологию."
                        - define msg "Все окружающее тебя, сделала сама природа, так что ты должен быть благодарен ей."
                    - ~run dialogue path:talk def.text:<list[<[msg]>]> def.target:<npc>
                    - run dialogue def:academ_agas|<npc>|<player>