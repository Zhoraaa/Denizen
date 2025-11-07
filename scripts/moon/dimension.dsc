moon:
    type: world
    debug: true
    events:
        on player changes world to:*moon*:
            - ratelimit <player> 4t
            # Изменение гравитации на лунное значение
            - adjust <player> attribute_base_values:<map[GRAVITY=0.013]>
            - adjust <player> attribute_base_values:<map[SAFE_FALL_DISTANCE=12]>
        on player changes world:
            - ratelimit <player> 4t
            # Изменение гравитации на лунное дефолтное значение
            - if <context.origin_world.name.advanced_matches[*moon*]>:
                - adjust <player> attribute_base_values:<map[GRAVITY=<player.attribute_default_value[GRAVITY]>]>
                - adjust <player> attribute_base_values:<map[SAFE_FALL_DISTANCE=<player.attribute_default_value[SAFE_FALL_DISTANCE]>]>

        on delta time secondly every:1:
            - foreach <server.online_players.filter[location.world.name.advanced_matches[!*moon*]].filter[location.y.is_more_than[320]]> as:__player:
                # Зайти на Луну
                - execute as_op silent 'warp moon <player.name>'
            - foreach <server.online_players.filter[location.world.name.advanced_matches[*moon*]].filter[location.y.is_less_than[-16]]> as:__player:
                # Лив с Луны
                - execute as_op silent 'warp green_hills <player.name>'
        on delta time secondly every:2:
            - foreach <server.online_players.filter[location.world.name.advanced_matches[*moon*]]> as:__player:
                - while !<player.proc[imprability_check]||false> && <player.is_online||false> && <player.is_spawned||false> && <player.location.world.name.advanced_matches[*moon*]>:
                    - stop if:<player.gamemode.advanced_matches[CREATIVE|SPECTATOR]>
                    - stop if:<player.has_flag[infected]>
                    - stop if:<player.has_flag[cured]>
                    - stop if:<player.has_flag[origin]>
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