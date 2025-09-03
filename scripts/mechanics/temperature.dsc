t_config:
    type: data
    dim: world
    sunset: 12750
    normal:
        def: 36.6
        sense: 0.05
    fire:
        def: 1337
        sense: 0.1
    vamp:
        def: 20.0
        sense: 0.1
    snow:
        def: -10.0
        sense: 0.1

t_str:
    type: data
    75: <&sp><red>🔥<&sp>
    50: <&sp><gold>🔥<&sp>
    25: <&sp><yellow>🔥<&sp>
    0: <&sp><green>❤<&sp>
    a25: <&sp><aqua>❄<&sp>
    a50: <&sp><blue>❄<&sp>
    a75: <&sp><dark_blue>❄<&sp>

temperature_manipulating:
    type: world
    events:
        on player right clicks block with:coal|charcoal flagged:origin_marker:
        - stop if:<player.flag[origin_marker].advanced_matches[blazeborn|magmacube].not>
        - stop if:<player.location.world.name.equals[<script[t_config].data_key[dim]>].not>
        - stop if:<player.gamemode.equals[SPECTATOR]>
        # Скрипт
        - define config <script[t_config]>
        - define max <[config].data_key[fire.max].add[25]>
        - if <player.flag[temperature]> <= <[max]>:
            - flag <player> temperature:+:10
            - playsound <player.location> sound:entity.blaze.shoot sound_category:1 volume:0.4 pitch:1.2
            - stop if:<player.gamemode.equals[CREATIVE]>
            - take iteminhand quantity:1

temperature_handler:
    type: world
    debug: false
    disable: true
    events:
        on player joins flagged:!temperature:
        - flag <player> temperature:0
        # Триггер кастом ивента
        on delta time secondly every:1:
        - stop if:<script.data_key[disable]||false>
        - stop if:<server.online_players.size.equals[0]||false>
        - define world <script[t_config].data_key[dim]>
        - stop if:<server.online_players.filter[location.world.name.equals[<[world]>]].size.equals[0]>
        - if <server.online_players.filter[location.world.name.equals[<[world]>]].size>:
            - foreach <server.online_players.filter[location.world.name.equals[<[world]>]]> as:player:
                # Определяем тип существа
                - foreach next if:<[player].gamemode.advanced_matches[creative|spectator]>
                - define creature normal
                - define creature fire if:<[player].has_flag[origin_marker].and[<context.player.flag[origin_marker].advanced_matches[blazeborn|magmacube]>]>
                - define creature snow if:<[player].has_flag[origin_marker].and[<context.player.flag[origin_marker].advanced_matches[snowman]>]>
                - define creature vamp if:<[player].has_flag[vampire]>
                - definemap context:
                    player: <[player]>
                    temperature: <[player].flag[temperature]>
                    daytick: <[player].location.world.time>
                    place: <[player].location.up[0.2].center>
                    creature: <[creature]>
                - customevent id:player_temperatureing context:<[context]>
                - if <[player].flag[temperature]> >= 25:
                    - customevent id:hypertermia context:<[context]>
                - if <[player].flag[temperature]> <= -25:
                    - customevent id:hypotermia context:<[context]>
        # Греемся
        on custom event id:player_temperatureing:
        # Подгрузка данных и пристрелка кфг
        - define debug <script.data_key[debug]>
        - define config <script[t_config]>
        - define player <context.player>
        - define creature <context.creature>

        # Константы
        - define amplitude 2
        - define pi 3.14
        - define day <context.daytick.is_less_than[<script[t_config].data_key[sunset]>]>
        - define night <[day].not>
        - define in_water <context.place.material.name.advanced_matches[water|seagrass|tall_seagrass]||context.place.material.waterlogged>

        # Расчёты
        # Темпра места
        - define T0 <context.place.temperature.round_to[2]>
        # Влажность биома + дождь
        - define H <element[1].sub[<context.place.biome.humidity>].round_to[2]>
        - if <context.place.world.has_storm.and[<context.place.biome.humidity.is_more_than[0.15]>]> || <[in_water]>:
            - define H 0
        # Зависимость от времени суток
        - define T1 <element[2].mul[<[H]>].mul[<[pi].mul[2].mul[<context.daytick.div[24000].round_to[2]>].sin>].round_to[5]>
        # Модификатор искусственной освещённости
        - define T2 0
        - if <context.place.light.blocks> >= 9:
            - define T2 <context.place.light.blocks.sub[8].mul[0.1]>
        - else if <context.place.light.blocks> <= 3 && <context.place.light.sky> < 15 && !<[day]> && !<[in_water]> && !<[creature].advanced_matches[snow|vampire]>:
            - define T2 <context.place.light.blocks.sub[3].mul[0.1]>
        # Итоговая температура воздуха
        - define T <[T1].add[<[T2]>].round_to[2]>

        # Итоговая температура тела
        #
        # Tb - старая температура тела
        # K = 100 - Коэф. температур (от -100 до +200)
        # Tn = T * K - Целевая
        # Va - Скорость адаптации, зависит от расы. (Прим.: 0.1)
        # t - Промежуток времени между рассчётами в секундах
        # Delta = ((Tn - Tb) * Va)t
        # Новая температура тела:
        # Tb = Tb + Delta
        - define Tn <[T].mul[40].min[80].max[-80]>
        - define sense <[config].data_key[<[creature]>.sense]>
        - define delta <[Tn].sub[<context.temperature>].mul[<[sense]>].mul[1]>
        - define newT <context.temperature.add[<[delta]>].round_to[2]||0>
        - flag <[player]> temperature:<[newT].min[80].max[-80]>

        # Дебаг
        - if <[debug]>:
            - narrate targets:<context.player> 'Время суток в тиках: <context.daytick>'
            - narrate targets:<context.player> 'Искусственное освещение: <context.place.light.blocks>'
            - narrate targets:<context.player> '<yellow>Влажность в биоме <context.place.biome.humidity>'
            - narrate targets:<context.player> '<yellow>Температура биома <[T0]>'
            - narrate targets:<context.player> '<green>Влияние влажности: <element[1].sub[<[H]>]>'
            - narrate targets:<context.player> '<green>Модификатор времени суток <[T1]>'
            - narrate targets:<context.player> 'Мод. искусственного освщения <[T2]>'
            - narrate targets:<context.player> '<gold>Итоговая температура воздуха: <[T]>'
            - narrate targets:<context.player> '<aqua>Текущее отклонение температуры игрока: <context.temperature>|<context.temperature.round_down_to_precision[25]>'
            - narrate targets:<context.player> '<aqua>Целевое отклонение температуры игрока: <[Tn]>'
            - narrate targets:<context.player> '<aqua>Дельта температуры: <[delta]>'
            - narrate targets:<context.player> '<blue>Тип существа: <[creature]>'
            - narrate targets:<context.player> <light_purple>------------------------------

        #
        # Вывод температуры игрока
        #
        - define t_str <script[t_str].data_key[<context.temperature.round_down_to_precision[25].replace_text[-].with[a]>].parsed||<&sp><green>❤<&sp>>
        - define str_e <[t_str]>
        - define str_e <&sp><gold>↑ if:<[delta].is_more_than[0.1]>
        - define str_e <&sp><aqua>↓ if:<[delta].is_less_than[-0.1]>
        - define t_int <[config].data_key[<[creature]>.def].add[<context.player.flag[temperature].mul[<[sense].mul[7.5]>]>].round_to[1]>
        #
        - define debug_t_str <&r>
        - define debug_t_str <&sp>(<context.temperature>/<context.temperature.round_down_to_precision[25]>) if:<[debug]>

        - define T_str <[t_str]><[t_int]||->°С<[str_e]><[debug_t_str]>

        # Ивенты в зависимости от температуры воздуха
        - if <[T]> > 0.5:
            - narrate 1
        - if <[T]> < -0.5:
            - run cold_breathe def:<[in_water]>

        - if <context.player.item_in_hand.material.name.equals[conduit]> || <context.player.item_in_offhand.material.name.equals[conduit]>:
            - define temperature_str <[t_str]>-°С<[str_e]>
            - title title:<&sp> subtitle:<[T_str]> targets:<[player]> fade_in:0 stay:1s fade_out:10t
            - actionbar <[T_str]> targets:<[player]>
#
hypertermia:
    type: world
    events:
        on custom event id:hypertermia:
        - define repeats <context.temperature.round_down_to_precision[25].div[25]>
        - define repeats <[repeats].mul[5]> if:<context.creature.equals[snow]>
        - repeat <[repeats]>:
            - wait <util.random.int[1].to[5]>t
            - if <util.random_chance[<context.temperature.sub[20].div[5]>]> && <context.player.location.light.sky.is_more_than[14]>:
                - if <context.player.has_flag[origin_marker].and[<context.player.flag[origin_marker].advanced_matches[blazeborn|magmacube]>]> || <player.has_flag[vampire]||false>:
                    - playeffect effect:dust at:<context.player.eye_location.add[0,0,0]> quantity:1 offset:0.15,0.15,0.15 special_data:[size=0.75;color=gray]
                    - playeffect effect:dust at:<context.player.location.add[0,0.7,0]> quantity:1 offset:0.1,0.5,0.1 special_data:[size=0.75;color=gray]
                - else:
                    - playeffect effect:FALLING_DRIPSTONE_WATER at:<context.player.eye_location.add[0,0,0]> quantity:1 offset:0.15,0.15,0.15
                    - playeffect effect:FALLING_DRIPSTONE_WATER at:<context.player.location.add[0,0.7,0]> quantity:1 offset:0.1,0.5,0.1
#
# hypotermia:
#     type: world
#     events:
        # on custom event id:hypotermia:
#
cold_breathe:
    type: task
    definitions: in_water
    script:
    - define in_water <[in_water]||false>
    - if <util.current_time_millis.div[1000].round_to[0].div[4].length.equals[9]> && !<[in_water]>:
        - repeat 25:
            - playeffect at:<context.player.eye_location.forward[0.3].down[0.15]> effect:dust special_data:[size=0.4;color=white] quantity:1 offset:0
            - wait 1t