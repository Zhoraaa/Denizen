moon:
    type: world
    debug: false
    events:
        on player changes world:
        - if <context.destination_world.equals[world_cctlm_moon]>:
            # Изменение гравитации на лунное значение
            - execute as_op silent 'attribute <player.name> minecraft:gravity modifier add moon -0.06 add_value'
            - execute as_op silent 'attribute <player.name> minecraft:safe_fall_distance modifier add moon 6 add_value'
        #
        - if <context.origin_world.equals[world_cctlm_moon]>:
            # Изменение гравитации на дефолтное значение
            - execute as_op silent 'attribute <player.name> minecraft:gravity modifier remove moon'
            - execute as_op silent 'attribute <player.name> minecraft:safe_fall_distance modifier remove moon'

        on delta time secondly every:1:
            - foreach <server.online_players.filter[location.world.name.advanced_matches[!world_cctlm_moon]].filter[location.y.is_more_than[320]]> as:__player:
                # Зайти на Луну
                - execute as_op silent 'warp moon <player.name>'
            - foreach <server.online_players.filter[location.world.name.advanced_matches[world_cctlm_moon]].filter[location.y.is_less_than[-32]]> as:__player:
                # Лив с Луны
                - execute as_op silent 'warp green_hills <player.name>'
        on delta time secondly every:2:
            - foreach <server.online_players.filter[location.world.name.advanced_matches[world_cctlm_moon]]> as:__player:
                - while !<player.proc[imprability_check]||false> && <player.is_online||false> && <player.is_spawned||false>:
                    - hurt <player> 1
                    - cast confusion duration:10s amplifier:0 no_icon hide_particles
                    # Заражение
                    - if <util.random_chance[50]> && <player.flag[origin_marker].advanced_matches[!shulk]>:
                        - run infection
                    #
                    - wait 1

imprability_check:
    type: procedure
    debug: false
    definitions: __player
    script:
    - define helm_list <list[Шлем T-51|Шлем T-45|Шлем X-01|Космо-шлем|Шлем штурмовика|*противогаз*|Головной комплект химзащиты|Последний вздох|*клюв]>
    - if <player.inventory.slot[40].display.strip_color.advanced_matches[<[helm_list]>]||null> || <player.inventory.slot[40].advanced_matches[*glass]||null>:
        - determine true
    - else:
        - determine false