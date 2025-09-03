#Гоблин
preparing_goblin:
    type: world
    events:
        on player joins:
            - if !<player.has_flag[goblin_name]>:
                - flag player goblin_name:Гоблин
                - flag player goblin_mood:0

goblin_assign:
    type: assignment
    actions:
        on assignment:
            - trigger name:click state:true
            - trigger name:chat state:true cooldown:1s radius:50
    interact scripts:
        - goblin_interact

goblin_interact:
    type: interact
    steps:
        1:
            click trigger:
                script:
                - if <player.flag[quest_mimpi_start_stage]> == 0:
                    - random:
                        - narrate '<&lt><player.flag[goblin_name]><&gt> Дуй отсюда, не для тебя цвету!'
                        - narrate '<&lt><player.flag[goblin_name]><&gt> Не глазеть!'
                        - narrate '<&lt><player.flag[goblin_name]><&gt> Камень я не дам!'
                        - narrate '<&lt><player.flag[goblin_name]><&gt> Ты случайно не ищешь синие камни? НЕТ?! НУ И ПИЗДУЙ ОТСЕДАВА!!!'
                - else if <player.flag[quest_mimpi_start_stage]> == 1:
                    - if <player.flag[goblin_mood]> == 0:
                        - narrate '<&lt><player.flag[goblin_name]><&gt> О, я слышал как эта штука требовала от тебя принести синие кристаллы.'
                        - zap 2
                    - else:
                        - narrate '<&lt><player.flag[goblin_name]><&gt> О, кого я вижу! Что, передумал?'
                        - zap 2
                - else if <player.flag[quest_mimpi_start_stage]> == 2 && <player.has_flag[state_goblin_debtor]>:
                    - narrate '<&lt><player.flag[goblin_name]><&gt> Ты мой должник!'
                    - cooldown 10m
                - else if <player.flag[quest_mimpi_start_stage]> == 2 && !<player.has_flag[state_goblin_debtor]>:
                    - narrate '<&lt><player.flag[goblin_name]><&gt> ОТКУДА ТЫ ИХ ВЗЯЛ?!'
                    - cooldown 10m
        2:
            click trigger:
                script:
                    - cooldown 6s
                    - narrate '<&lt><player.flag[goblin_name]><&gt> Я дам тебе их, но взамен, ты будешь мне должен :)'
                    - wait 3s
                    - narrate '<&lt><player.flag[goblin_name]><&gt> Договор?'
                    - wait 1s
                    - run choice_notification
            chat trigger:
                1:
                    trigger: /regex:(?i)(?u)Да/
                    script:
                        - give cctlm_freethinking quantity:1
                        - narrate '<&lt><player.flag[goblin_name]><&gt> Приятно иметь с вами дело :)'
                        - flag player quest_mimpi_start_stage:2
                        - zap 1
                2:
                    trigger: /regex:(?i)(?u)Нет/
                    script:
                        - narrate '<&lt><player.flag[goblin_name]><&gt> Но учти! Тут больше ни у кого их нет!!!'
                        - ^flag player goblin_mood:1
                        - ^zap 1
                3:
                    trigger: /regex:(?i)(?u)Пош(е|ё)л нахуй/
                    hide trigger message: false
                    show as normal chat: false
                    script:
                        - narrate '<&lt><player.flag[goblin_name]><&gt> Сам иди!!! Они только у меня есть!!!'
                        - ^flag player goblin_mood:1
                        - ^zap 1