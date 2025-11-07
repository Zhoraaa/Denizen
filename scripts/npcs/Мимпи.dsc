#Мимпи
preparing_mimpi:
    type: world
    events:
        on player joins:
            - if !<player.has_flag[mimpi_name]>:
                - flag player mimpi_name:Призрак
            - if !<player.has_flag[quest_mimpi_start_stage]>:
                - flag player quest_mimpi_start_stage:0
                # 0 - Игрок не взял квест
                # 1 - Игрок взял квест
                # 2 - Игрок взял кристаллы
                # 3 - Игрок сдал квест

mimpi_assign:
    type: assignment
    actions:
        on assignment:
            - trigger name:click state:true
            - trigger name:chat state:true cooldown:1s radius:50
    interact scripts:
        - mimpi_interact

mimpi_interact:
    type: interact
    steps:
        1:
            click trigger:
                script:
                    - narrate '<&lt><player.flag[mimpi_name]><&gt> Я хочу кушать! Принеси мне голубые кристаллы!'
                    - flag player quest_mimpi_start_stage:1
                    - zap 2
        2:
            click trigger:
                script:
                    - if <player.item_in_hand.script.name||null> == freethinking:
                        - take itemhand:freethinking quantity:1 from:inventory
                        - narrate '<&lt><player.flag[mimpi_name]><&gt> Ой, спасибочки! Ты доказал свою полезность! Теперь иди, и добудь мне ещё!'
                        - flag player quest_mimpi_start_stage:3
                        - execute as_op silent 'warp green_hills <player.name>'
                        - execute as_op silent 'spawnpoint <player> <player.location>'
                        - zap 3
                    - else:
                        - hurt 2
                        - random:
                            - narrate '<&lt><player.flag[mimpi_name]><&gt> Принеси мне голубые камушки!'
                            - narrate '<&lt><player.flag[mimpi_name]><&gt> Такие сладкие голубенькие кристалльчики!'
                            - narrate '<&lt><player.flag[mimpi_name]><&gt> Я хочу кушать!'
                            - narrate '<&lt><player.flag[mimpi_name]><&gt> У тебя невкусная рука!'
            chat trigger:
                1:
                    trigger: /regex:(?i)(?u)Что это|regex:(?i)(?u)Что они такое/
                    script:
                        - narrate 'Это как ты, но сырое!'
        3:
            click trigger:
                script:
                    - if <player.item_in_hand.script.name||null> == freethinking:
                        - take itemhand:freethinking quantity:1 from:inventory
                        - narrate '<&lt><player.flag[mimpi_name]><&gt> Ням-ням!!!'
                        - run count_freethinks_incrementing
                        - experience drop <player.location> 50
                        - run rand_drop def.repeats:5
                    - else if <player.item_in_hand.script.name||null> == canon:
                        - take itemhand:canon quantity:1 from:inventory
                        - narrate '<&lt><player.flag[mimpi_name]><&gt> Ням-ням!!!'
                        - run count_canons_incrementing
                        - run rand_drop def.repeats:2
                    - else if <player.item_in_hand.script.name||null> == redcon:
                        - take itemhand:redcon quantity:1 from:inventory
                        - narrate '<&lt><player.flag[mimpi_name]><&gt> Ням-ням!!!'
                        - run count_redcons_incrementing
                        - run rand_drop def.repeats:8
                    - else:
                        - hurt 1
                        - random:
                            - narrate '<&lt><player.flag[mimpi_name]><&gt> Ня-я-я!!!'
                            - narrate '<&lt><player.flag[mimpi_name]><&gt> :3'
                            - narrate '<&lt><player.flag[mimpi_name]><&gt> "Ты такой силли!" Что это значит?'
                            - narrate '<&lt><player.flag[mimpi_name]><&gt> Я хочу кушать!'
                            - narrate '<&lt><player.flag[mimpi_name]><&gt> Приветик!'
                            - narrate '<&lt><player.flag[mimpi_name]><&gt> Чем отличаются жёлтые от синих?'
                            - narrate '<&lt><player.flag[mimpi_name]><&gt> Ну как, нашёл ещё?'
                            - narrate '<&lt><player.flag[mimpi_name]><&gt> Ну слушай, я не могу ждать вечно!'
                            - narrate '<&lt><player.flag[mimpi_name]><&gt> Меня пугает тот, в розовом.'

rand_drop:
    type: task
    definitions: repeats
    script:
        - repeat <[repeats]||1>:
            - random:
                # Знамёна
                - random:
                    - drop <player.location> piglin_banner_pattern
                    - drop <player.location> mojang_banner_pattern
                    - drop <player.location> guster_banner_pattern
                    - drop <player.location> flow_banner_pattern
                # Пластинки
                - random:
                    - drop <player.location> music_disc_otherside
                    - drop <player.location> music_disc_creator
                    - drop <player.location> music_disc_creator_music_box
                    - drop <player.location> music_disc_pigstep
                    - drop <player.location> music_disc_precipice
                    - drop <player.location> music_disc_relic
                # Яйца
                - random:
                    - drop <player.location> cat_spawn_egg
                    - drop <player.location> goat_spawn_egg
                    - drop <player.location> sniffer_egg
                    - drop <player.location> camel_spawn_egg
                    - drop <player.location> allay_spawn_egg
                # Сокровища
                - random:
                    - drop <player.location> recovery_compass
                    - drop <player.location> enchanted_golden_apple
                    - drop <player.location> heart_of_the_sea
                    - drop <player.location> diamond_block quantity:2
                    - drop <player.location> netherite_ingot quantity:2
                 # Трофеи
                - random:
                    - drop <player.location> piglin_head
                    - drop <player.location> wither_skeleton_skull
                    - drop <player.location> shulker_shell quantity:16
                    - drop <player.location> ghast_tear quantity:8
            - playsound <player.location> sound:entity_experience_orb_pickup sound_category:master volume:1 pitch:1.2
            - wait 10t