# Кот-полиглот
preparing_catPolyglot:
    type: world
    events:
        on player joins:
            - if !<player.has_flag[relship_catPolyglot]>:
                - flag player relship_catPolyglot:0
            - if !<player.has_flag[relship_catPolyglot_to_present]>:
                - flag player relship_catPolyglot_to_present:128

catPolyglot_assign:
    type: assignment
    actions:
        on assignment:
            - trigger name:click state:true cooldown:1t
    interact scripts:
        - catPolyglot_interact

catPolyglot_interact:
    type: interact
    steps:
        1:
            click trigger:
                script:
                # Проверка ретинга игрока у кота
                    - if <player.flag[relship_catPolyglot]> >= <player.flag[relship_catPolyglot_to_present]>:
                        - ^cooldown 10s
                        - random:
                            - narrate '<&lt>Кот-полиглот<&gt> Hear me, я тут кое-что нашёл.'
                            - narrate '<&lt>Кот-полиглот<&gt> Check it! Я думаю, тебе понравится.'
                            - narrate '<&lt>Кот-полиглот<&gt> We are great team ya?'
                            - narrate '<&lt>Кот-полиглот<&gt> Кого я вижу? Да это же мой любимчик!'
                        - playsound <player> sound:entity_cat_ambient sound_category:voice volume:1 pitch:1
                        - wait 3
                        - random:
                            - narrate '<&lt>Кот-полиглот<&gt> Считай, it is for you за вкусняшки.'
                            - narrate '<&lt>Кот-полиглот<&gt> Держи хоуми, всё для тебя!'
                            - narrate '<&lt>Кот-полиглот<&gt> Blinking камушки! Держи :3'
                            - narrate '<&lt>Кот-полиглот<&gt> Возьми этот not-so-big present!'
                        - playsound <player> sound:entity_cat_ambient sound_category:voice volume:1 pitch:1
                        - wait 3
                        - drop <location[<npc.location>].add[0, 1, 0]> freethinking
                        - playeffect effect:bubble_pop at:<location[<npc.location>].add[0, 0.5, 0]> visibility:100 quantity:100 offset:0.0'
                        - flag player relship_catPolyglot:<player.flag[relship_catpolyglot].min[<player.flag[relship_catpolyglot_to_present]>]>
                        - flag player relship_catPolyglot_to_present:*:1.2
                        # Принимает рыбу
                    - else if <player.item_in_hand.material.name> == cod:
                        - take itemhand:cod quantity:1 from:inventory
                        - narrate '<&lt>Кот-полиглот<&gt> Pur-r-r (Sweet)'
                        - ^playeffect effect:composter at:<location[<npc.location>].add[0, 0.5, 0]> visibility:100 quantity:10 offset:0.0'
                        - ^playsound <player> sound:entity_cat_eat sound_category:voice volume:1 pitch:1
                        - flag player relship_catPolyglot:++
                    - else if <player.item_in_hand.material.name> == salmon:
                        - take itemhand:salmon quantity:1 from:inventory
                        - narrate '<&lt>Кот-полиглот<&gt> म्याऊँ (स्वादिष्ट)'
                        - ^playeffect effect:composter at:<location[<npc.location>].add[0, 0.5, 0]> visibility:100 quantity:10 offset:0.0'
                        - ^playsound <player> sound:entity_cat_eat sound_category:voice volume:1 pitch:1
                        - flag player relship_catPolyglot:++
                    - else if <player.item_in_hand.material.name> == tropical_fish:
                        - take itemhand:tropical_fish quantity:1 from:inventory
                        - narrate '<&lt>Кот-полиглот<&gt> Мр-р-рayк~ (Рәхмәт һыйланыу өсөн~)'
                        - ^playeffect effect:composter at:<location[<npc.location>].add[0, 0.5, 0]> visibility:100 quantity:10 offset:0.0'
                        - ^playsound <player> sound:entity_cat_purreow sound_category:voice volume:1 pitch:1
                        - flag player relship_catPolyglot:+:5
                    - else if <player.item_in_hand.material.name> == pufferfish:
                        - narrate '<&lt>Кот-полиглот<&gt> HSSSSSS!!! (Oksendada!!!)'
                        - ^playeffect effect:angry_villager at:<location[<npc.location>].add[0, 0.5, 0]> visibility:100 quantity:10 offset:0.0'
                        - ^playsound <player> sound:entity_cat_hiss sound_category:voice volume:1 pitch:1
                        - flag player relship_catPolyglot:-:10
                    - else if <player.item_in_hand.advanced_matches[milk_bucket]>:
                        - take itemhand:name_tag quantity:1 from:inventory
                        - narrate '<&lt>Кот-полиглот<&gt> Мр-р-р-р-р... (Мр-р-р...)'
                        - ^playeffect effect:composter at:<location[<npc.location>].add[0, 0.5, 0]> visibility:100 quantity:10 offset:0.0'
                        - ^playsound <player> sound:entity_cat_purreow sound_category:voice volume:1 pitch:1
                        - if <player.flag[relship_catpolyglot_to_present].is_more_than[256]>:
                            - flag player relship_catPolyglot:<player.flag[relship_catpolyglot_to_present].mul[0.6]>
                        - else:
                            - flag player relship_catPolyglot:+:10
                    - else:
                        # Рандомные фразы
                        - random:
                            - narrate '<&lt>Кот-полиглот<&gt> Мяу'
                            - narrate '<&lt>Кот-полиглот<&gt> Miyav'
                            - narrate '<&lt>Кот-полиглот<&gt> Meow'
                            - narrate '<&lt>Кот-полиглот<&gt> مواء'
                            - narrate '<&lt>Кот-полиглот<&gt> Miaau'
                            - narrate '<&lt>Кот-полиглот<&gt> মীআও'
                            - narrate '<&lt>Кот-полиглот<&gt> Mijau'
                            - narrate '<&lt>Кот-полиглот<&gt> Miau'
                            - narrate '<&lt>Кот-полиглот<&gt> Meo-meo'
                            - narrate '<&lt>Кот-полиглот<&gt> Miar'
                            - narrate '<&lt>Кот-полиглот<&gt> Miauw'
                            - narrate '<&lt>Кот-полиглот<&gt> Nιαούρισμα'
                            - narrate '<&lt>Кот-полиглот<&gt> મેઓવ'
                            - narrate '<&lt>Кот-полиглот<&gt> מיאַו'
                            - narrate '<&lt>Кот-полиглот<&gt> Maullar'
                            - narrate '<&lt>Кот-полиглот<&gt> ಮಿಯಾಂವ್'
                            - narrate '<&lt>Кот-полиглот<&gt> Miolar'
                            - narrate '<&lt>Кот-полиглот<&gt> 喵'
                            - narrate '<&lt>Кот-полиглот<&gt> 야옹'
                            - narrate '<&lt>Кот-полиглот<&gt> Ņau'
                            - narrate '<&lt>Кот-полиглот<&gt> Miauen'
                            - narrate '<&lt>Кот-полиглот<&gt> म्याऊ'
                            - narrate '<&lt>Кот-полиглот<&gt> Mjauer'
                            - narrate '<&lt>Кот-полиглот<&gt> صدای گربه'
                            - narrate '<&lt>Кот-полиглот<&gt> Miauczeć'
                            - narrate '<&lt>Кот-полиглот<&gt> Мијау'
                            - narrate '<&lt>Кот-полиглот<&gt> Mňau'
                            - narrate '<&lt>Кот-полиглот<&gt> Ngumyaw'
                            - narrate '<&lt>Кот-полиглот<&gt> பூனைகளின் ஒலி'
                            - narrate '<&lt>Кот-полиглот<&gt> మిఅవ్'
                            - narrate '<&lt>Кот-полиглот<&gt> میانو'
                            - narrate '<&lt>Кот-полиглот<&gt> Mňoukání'
                            - narrate '<&lt>Кот-полиглот<&gt> Jama'
                            - narrate '<&lt>Кот-полиглот<&gt> Mjäu'
                            - narrate '<&lt>Кот-полиглот<&gt> Kantha'
                            - narrate '<&lt>Кот-полиглот<&gt> ニャー'
                        - ^playsound <player> sound:entity_cat_beg_for_food sound_category:voice volume:1 pitch:1