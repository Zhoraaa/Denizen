disdeath:
    type: command
    name: disdeath
    description: Лорно умер по болезни.
    usage: /disdeath
    # debug: false
    script:
    - if <player.has_flag[infected]> && !<player.has_flag[disdying]>:
        - narrate "<red><italic>Эта команда запускает процесс лорной смерти вашего персонажа от лунной болезни. Если вы не хотите убивать персонажа, выпейте флакон крови (обычной) в ближайшее время. Если вы хотите убить персонажа - умрите, когда самочувствие ухудшится. Можете использовать /suicide"
        - flag player disdying:1

        # Механизм смерти
        - while <player.has_flag[disdying]>:
            - if <player.flag[disdying]> >= 1:
                - playeffect effect:WARPED_SPORE at:<player.eye_location> quantity:<player.flag[disdying].mul[5]>
                - playsound <player.eye_location> sound:entity.warden.heartbeat sound_category:master volume:1 pitch:0.75
            - if <player.flag[disdying]> >= 3 && <util.random_chance[<player.flag[disdying].mul[4]>]>:
                - playeffect effect:SQUID_INK at:<player.location> quantity:5
                - playeffect effect:SCULK_CHARGE_POP at:<player.eye_location> quantity:10
                - modifyblock <player.location.add[0,-1,0]> SCULK|SCULK_CATALYST 75|25
            - if <player.flag[disdying]> >= 4 && <util.random_chance[<player.flag[disdying].mul[5]>]>:
                - playsound <player.eye_location> sound:entity.warden.sniff sound_category:master volume:0.4 pitch:1.5
            # Прогрессия
            - if <player.flag[disdying]> < 6 && <util.random_chance[<player.flag[disdying].mul[0.2]>]>:
                - run disdie
            # КД
            - wait 10t
    - else if <player.has_flag[disdying]>:
        - narrate "<red><italic>Вы уже умираете"
    - else:
        - narrate "<red><italic>Вы не больны"

# Прогрессия
disdie:
    type: task
    script:
        - flag player disdying:++
        - playeffect effect:SQUID_INK at:<player.location> quantity:5
        - playsound <player.eye_location> sound:entity.zombie_villager.cure sound_category:master volume:0.2 pitch:0.5
        # Сообщения об ухудшении
        - if <player.flag[disdying]> == 2:
            - announce '<red>Тело <player.name> покрывается чёрными волдырями...'
        - if <player.flag[disdying]> == 3:
            - announce '<red>Волдыри на теле <player.name> начинают лопаться...'
        - if <player.flag[disdying]> == 4:
            - announce '<red><player.name> тяжело дышит...'
        - if <player.flag[disdying]> == 5:
            - cast <player> confusion duration:infinite hide_particles no_icon
            - announce '<red><player.name> шатается...'
            - narrate '<green><italic>Можно умирать'

warden_disdeath:
    type: world
    events:
        # Отмена операции
        on player consumes bottle_o_blood flagged:disdying:
            - playsound <player.eye_location> sound:entity.zombie_villager.cure sound_category:master volume:0.2 pitch:0.5
            - flag player disdying:!
            - narrate '<green><italic>Смерть персонажа отменена (Вы официально пусечка)'

        # Смерть и спавн вардена
        on player dies flagged:disdying:
            - if <player.flag[disdying]> >= 5:
                - run killcure delay:10s
                - playeffect <player.location> effect:SONIC_BOOM quantity:35 offset:1,1.5,1
                - playsound <player.eye_location> sound:entity.warden.emerge sound_category:master volume:1 pitch:1.5
                - spawn <player.location> warden persistent
                - modifyblock <player.location> sculk_shrieker
                - flag player disdying:!
                - determine "<red>Плоть <player.name> была разорвана изнутри"

killcure:
    type: task
    script:
        - narrate '<red><italic>Ваш персонаж умер. Пожалуйста, не используйте его больше и пометьте мёртвым на форуме персонажей'
        - flag player infected:!
        - flag player disease_stage:!
        - flag player wardened:!
        - run hp_reload