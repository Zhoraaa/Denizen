# Присвоение роста
# /scale <Ник игрока/Тег сущности> <id категории роста/reset> -s(ave - закрепить рост) -l(oud - прислать уведу целевому игроку)
scale_change:
    type: command
    # debug: false
    name: scale
    permission: dscript.mycmd
    description: Команда меняет рост существуе по категориям и может закрепить его за ним. Ключ -l Уведромит игрока об изменениях. Ключ -s сохранит рост и будет возвращать его игроку, если в качестве категории указано `reset`.
    usage: /scale <&lt>player<&gt> <&lt>category<&gt>
    tab completions:
        1: <server.online_players.parse[name]>|<player.target||<element[]>>
        2: <script.data_key[categories].keys.parsed>|reset
        3 4: -s|-l
    categories:
        1-tiny:
            ATTACK_DAMAGE: 0.75
            BLOCK_BREAK_SPEED: 0.5
            BLOCK_INTERACTION_RANGE: 3
            ENTITY_INTERACTION_RANGE: 2
            FALL_DAMAGE_MULTIPLIER: 0.3
            JUMP_STRENGTH: 0.3
            KNOCKBACK_RESISTANCE: reset
            MOVEMENT_EFFICIENCY: reset
            MOVEMENT_SPEED: 0.075
            OXYGEN_BONUS: reset
            SAFE_FALL_DISTANCE: 6
            SCALE: 0.5
            SNEAKING_SPEED: 0.2
            STEP_HEIGHT: 0.3
            SUBMERGED_MINING_SPEED: 0.1
            WATER_MOVEMENT_EFFICIENCY: 1
        2-small:
            ATTACK_DAMAGE: 0.875
            BLOCK_BREAK_SPEED: 0.75
            BLOCK_INTERACTION_RANGE: 3.75
            ENTITY_INTERACTION_RANGE: 2.5
            FALL_DAMAGE_MULTIPLIER: 0.4
            JUMP_STRENGTH: reset
            KNOCKBACK_RESISTANCE: reset
            MOVEMENT_EFFICIENCY: reset
            MOVEMENT_SPEED: 0.0875
            OXYGEN_BONUS: reset
            SAFE_FALL_DISTANCE: 4.5
            SCALE: 0.75
            SNEAKING_SPEED: 0.25
            STEP_HEIGHT: reset
            SUBMERGED_MINING_SPEED: 0.15
            WATER_MOVEMENT_EFFICIENCY: 0.5
        3-default:
            ATTACK_DAMAGE: reset
            BLOCK_BREAK_SPEED: reset
            BLOCK_INTERACTION_RANGE: reset
            ENTITY_INTERACTION_RANGE: reset
            FALL_DAMAGE_MULTIPLIER: reset
            JUMP_STRENGTH: reset
            KNOCKBACK_RESISTANCE: reset
            MOVEMENT_EFFICIENCY: reset
            MOVEMENT_SPEED: 0.1
            # Денизен неверно определяет дефолт значение у аттра скорости (0.7), поэтому указано строго 0.1
            OXYGEN_BONUS: reset
            SAFE_FALL_DISTANCE: reset
            SCALE: 1
            # Атрибуты ситизенов доставать сложнее, чем прописать сюда 1
            SNEAKING_SPEED: reset
            STEP_HEIGHT: reset
            SUBMERGED_MINING_SPEED: reset
            WATER_MOVEMENT_EFFICIENCY: reset
        4-big:
            ATTACK_DAMAGE: 1.125
            BLOCK_BREAK_SPEED: 1.25
            BLOCK_INTERACTION_RANGE: 5.25
            ENTITY_INTERACTION_RANGE: 3.5
            FALL_DAMAGE_MULTIPLIER: reset
            JUMP_STRENGTH: 0.5
            KNOCKBACK_RESISTANCE: 0.1
            MOVEMENT_EFFICIENCY: 0.5
            MOVEMENT_SPEED: 0.1125
            OXYGEN_BONUS: 2.5
            SAFE_FALL_DISTANCE: 4
            SCALE: 1.25
            SNEAKING_SPEED: 0.35
            STEP_HEIGHT: 0.75
            SUBMERGED_MINING_SPEED: 0.25
            WATER_MOVEMENT_EFFICIENCY: reset
        5-giant:
            ATTACK_DAMAGE: 1.25
            BLOCK_BREAK_SPEED: 1.5
            BLOCK_INTERACTION_RANGE: 6
            ENTITY_INTERACTION_RANGE: 4
            FALL_DAMAGE_MULTIPLIER: reset
            JUMP_STRENGTH: 0.6
            KNOCKBACK_RESISTANCE: 0.2
            MOVEMENT_EFFICIENCY: 1.0
            MOVEMENT_SPEED: 0.125
            OXYGEN_BONUS: 5.0
            SAFE_FALL_DISTANCE: 5
            SCALE: 1.5
            SNEAKING_SPEED: 0.4
            STEP_HEIGHT: 1
            SUBMERGED_MINING_SPEED: 0.3
            WATER_MOVEMENT_EFFICIENCY: reset
    loud_msgs:
        1-tiny:
            name: Крошечный
            plus: Крошечный хитбокс, сильно уменьшен урон от падения, увеличена скорость в воде.
            minus: Значительно уменьшен урон, дальность взаимодействий с блоками и сущностями, скорость копания, высота прыжка и высота шага.
        2-small:
            name: Маленький
            plus: Маленький хитбокс, уменьшен урон от падения, слегка увеличена скорость в воде.
            minus: Уменьшен урон, дальность взаимодействий с блоками и сущностями и скорость копания.
        3-default:
            name: Средний
            plus: Вы нормис
            minus: Вы нормис
        4-big:
            name: Большой
            plus: Увеличена скорость передвижения, высота шага, высота прыжка, дальность взаимодействий с блоками и сущностями, скорость передвижения в вязких блоках, длительность дыхания под водой.
            minus: Увеличен хитбокс, уменьшена сила отбрасывания, оставлен стандартный урон от падения.
        5-giant:
            name: Гигантский
            plus: Значительно увеличена скорость передвижения, высота шага, высота прыжка, дальность взаимодействий с блоками и сущностями, скорость передвижения в вязких блоках, длительность дыхания под водой.
            minus: Сильно увеличен хитбокс, значительно уменьшена сила отбрасывания, оставлен стандартный урон от падения.
    script:
        # Константы
        - define target <context.args.get[1]>
        - define target <[target].as[npc]> if:<[target].contains[<&at>].and[<[target].contains[/].not>]>
        - define target <server.match_player[<context.args.get[1]>]> if:<[target].contains[<&at>].not>
        - narrate <[target]>
        - if !<[target]>:
            - narrate "<red><&nl><&sp>[⚠]<&sp>Ошибка при выполнении команды. Передайте в качестве первого аргумента ник игрока или Denizen EntityTag сущности.<&nl>"
            - stop
        - narrate <green>[<[target]>] if:<script.data_key[debug]||true>
        - define category <context.args.get[2]>
        - define category <[target].flag[scale_marker]||3-default> if:<[category].equals[reset]>
        - narrate <red>[<[category]>] if:<script.data_key[debug]||true>
        - define anchoring <context.args.get[3]||false>
        - define loud <context.args.get[4]||false>
        # Присваиваем спискам атрибутов знаяения на каждый рост (вот бы можно было записать в константу)
        - define categories <script.data_key[categories]>
        # Атрибуты применяются с использованием цикла foreach. Проходимся по спису называний и применяем соответстующим атрибутам нужные значения
        - foreach <[categories].get[<[category]>]>:
            # - foreach next if:<[target].attribute_default_value[<[key]>].not||false>
            - foreach next if:<[target].contains[n<&at>].and[<[key].equals[SCALE].not>]||false>
            - if <[value].equals[reset]>:
                # Обнуление изменённых атрибутов
                - narrate <aqua><[key]><gray>=<[target].attribute_default_value[<[key]>]><aqua> if:<script.data_key[debug]||true>
                - adjust <[target]> attribute_base_values:<map[<[key]>=<[target].attribute_default_value[<[key]>]>]>
            - else:
                # Изменение атрибутов
                - narrate <yellow><[key]><gray>=<[value]> if:<script.data_key[debug]||true>
                - if <[target].is_npc.not>:
                    - adjust <[target]> attribute_base_values:<map[<[key]>=<[value]>]>
                - else:
                    - execute as_server "npc<&sp>attribute scale <[value]> --id <[target].id>"
        - narrate <dark_gray> if:<script.data_key[debug]||true>
        # - adjust <[pl]> attribute_base_values:<map[GENERIC_SCALE=5]>
        # Уведомление игроку о смене роста
        - if <[loud]> && <[target].entity_type.equals[PLAYER]>:
            - narrate targets:<server.online_players.filter[name.equals[<[target]>]]> '<gold>Ваш рост - <aqua><script.data_key[loud_msgs.<[category]>.name]>'
            - narrate targets:<server.online_players.filter[name.equals[<[target]>]]> '<green>- Бонусы: <white><script.data_key[loud_msgs.<[category]>.plus]>'
            - narrate targets:<server.online_players.filter[name.equals[<[target]>]]> '<red>- Недостатки: <white><script.data_key[loud_msgs.<[category]>.minus]>'
        # Вешаем ли мы на игрока якорь того, что это его новый рост
        - if <[anchoring]>:
            - flag <[target]> scale_marker:<[category]>
            - if <[loud]> && <[target].entity_type.equals[PLAYER]>:
                - narrate targets:<server.online_players.filter[name.equals[<[target]>]]> '<gold>Рост закреплён'