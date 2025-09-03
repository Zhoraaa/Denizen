# Игрок-босс-варден
playerboss_init:
    type: task
    definitions: target|boss_type
    script:
    - define <[target]> <server.match_player[<context.args.get[1]>]>
    - if <[target].has_flag[playerboss]>:
        - announce 'Босс удалён'
        - flag <[target]> playerboss:!
    - else:
        - announce 'Босс создан'
        - flag <[target]> playerboss:<[boss_type]>

playerboss_warden:
    type: world
    events:
        on player clicks sacrifice_hammer in inventory flagged:playerboss:
        - if <player.flag[playerboss].equals[warden]>:
            - announce '<red>С Крадиусом что-то не так...'
            - wait 2s
            - announce '<red>Тело Крадиуса покрывается чёрными наростами...'
            - bossbar create playerboss_warden_bossbar players:<server.players> title:<light_purple>Крадиус-адепт color:PINK style:SEGMENTED_20 uuid:<player.uuid> progress:<player.health.div[<player.health_max>]>
            - adjust <player> invulnerable:true
        on player damaged flagged:playerboss:
        - if <player.flag[playerboss].equals[warden]>:
            - bossbar update playerboss_warden_bossbar players:<server.players> title:<light_purple>Крадиус-адепт color:PINK style:SEGMENTED_20 uuid:<player.uuid> progress:<player.health.div[<player.health_max>]>
        on player heals flagged:playerboss:
        - if <player.flag[playerboss].equals[warden]>:
            - bossbar update playerboss_warden_bossbar players:<server.players> title:<light_purple>Крадиус-адепт color:PINK style:SEGMENTED_20 uuid:<player.uuid> progress:<player.health.div[<player.health_max>]>
        on player dies flagged:playerboss:
        - bossbar remove playerboss_warden_bossbar
        - run playerboss_init defmap:<map[target=<player>;boss_type=<player.flag[playerboss]>]>
        - adjust <player> invulnerable:true
        - wait 3m
        - adjust <player> invulnerable:false