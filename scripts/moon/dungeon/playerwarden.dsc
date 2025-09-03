# [ Зрение вардена ]
wardened_mechanics:
    type: world
    debug: false
    events:
        # Отклик на любую вибрацию
        on player hears sound flagged:wardened:
        - define entity <context.location.find_entities[*].within[0.01].exclude[<player>].get[1]||false>
        - define reasons_to_cancel <player.eye_location.points_between[<context.location>].distance[1].filter[material.name.contains_text[wool]].size>
        - if <context.location.material.name.contains_text[carpet]>:
            - define reasons_to_cancel:++
        - if <context.location.sub[0,0.01,0].material.name.contains_text[wool]||false>:
            - define reasons_to_cancel:++

        - if <[reasons_to_cancel]> == 0 && <[entity]>:
            - playeffect <context.location> effect:SHRIEK special_data:[duration=0] offset:0 quantity:1 targets:<player>
            - ~run vibrender defmap:[from=<context.location>;to=<player.eye_location.sub[0,0.5,0]>]
            - if !<[entity].has_flag[loud]>:
                - glow <[entity]> true for:<player>
                - flag <[entity]> loud:true expire:44t
                - wait 30t
                - glow <[entity]> false for:<player>
        after player respawns flagged:wardened:
        - cast blindness amplifier:0 duration:infinite hide_particles <player>
        on player potion effects cleared flagged:wardened effect:blindness:
        - determine cancelled

# Рендер вибрации
vibrender:
    type: task
    debug: false
    definitions: from|to
    script:
    - define duration 10t
    - playeffect effect:VIBRATION at:<[from]> offset:0 special_data:[origin=<[from]>;destination=<[to]>;duration=<[duration]>] targets:<server.online_players>
    - wait <[duration]>
    - playsound <[to]> sound:block_sculk_sensor_clicking volume:1 sound_category:hostile
# дать тег варденед
wardened:
    type: command
    name: wardened
    description: Помечает варданутого
    usage: /wardened <&lt>player<&gt> <&lt>bool<&gt>
    permission: dscript.wardening
    tab completions:
        1: <server.online_players.parse[name]>
        2: true|false
    script:
    - define target <server.match_player[<context.args.get[1]>]>
    - define bool <context.args.get[2]>
    - run warden_player defmap:<map[target=<[target]>;bool=<[bool]>]>
#
warden_player:
    type: task
    definitions: target|bool
    script:
    - narrate "<gold>Ты теперь <aqua>Варден<gold>, существо, заражённое Тёмным Небом"
    - narrate "<green>Ты передвигаешься быстрее. <red>Но не можешь бегать"
    - narrate "<red>Ты слеп<white>, но <green>слух твой засечёт любого даже за блоками... <red>Кроме шерсти."
    - if <[bool]>:
        - flag <[target]> wardened:true
        - cast blindness amplifier:1 duration:infinite hide_particles <[target]>
        - cast speed amplifier:1 duration:infinite hide_particles <[target]>
    - else:
        - flag <[target]> wardened:!
        - cast remove blindness
        - cast remove speed