
## Команда для ровного спавна
## /ex spawn writ[flag_map=<map[id=АЙДИ]>] <player.eye_location.ray_trace[return=precise].add[<player.eye_location.ray_trace[return=normal].mul[0.01]>]>

WritHandler:
    type: world
    debug: false
    data:
        ##
        ## Айди:
        ##      Координат: Энтити
        ##
        ## Если вы хотите указать несколько энтити в одних координатах, то поставьте |
        template:
            0.1,0: text_display[text_shadowed=true;background_color=transparent;text=Не крути меня;scale=0.64,0.64,0.64;left_rotation=<location[0,0,1].to_axis_angle_quaternion[<element[60].to_radians>]>]
    events:
        on player joins:
        - adjust <player> unhide_entities:<server.worlds.parse[entities[writ]].combine||<list>>
        on Writ added to world:
        - adjust <server.players> show_to_players
        on tick every:3:
        - stop if:<server.worlds.parse[entities[writ]].combine.is_empty||true>
        - foreach <server.online_players_flagged[!writ]> as:__player:
            - define writ <player.eye_location.ray_trace[return=precise].find_entities[writ].within[0.4].first||null>
            - if <player.has_flag[select_writ].not> and <[writ].is_truthy> and <[writ].location.distance[<player.location>].is_less_than[3]>:
                - playsound <player> sound:block_copper_bulb_turn_on
                - flag <player> select_writ:<[writ]>
                - glow <[writ]> true for:<player>
                - actionbar "<&f>Нажмите <&6>«<&keybind[key.use]>»<&f> чтобы прочитать"
            - else if <player.has_flag[select_writ]> and ( <[writ].location.distance[<player.location>].is_more_than[3]||false> or <player.flag[select_writ].equals[<[writ]>].not> ):
                - playsound <player> sound:block_copper_bulb_turn_off
                - glow <player.flag[select_writ]> reset for:<player> if:<player.flag[select_writ].is_truthy||false>
                - flag <player> select_writ:!
        on player joins flagged:writ:
        - flag <player> writ:!
        on player swaps items flagged:writ:
        - determine passively cancelled
        - animate for:<player> animation:arm_swing if:<plugin[citizens].exists>
        - playsound <player.flag[writ.entity].location> <player> sound:item_book_page_turn volume:10
        - flag <player> writ.rotate:<player.flag[writ.rotate].if_true[false].if_false[true]>
        on player right clicks block flagged:select_writ|!writ:
        - determine passively cancelled
        - ratelimit <player> 4t
        # Анимация тычка
        - animate for:<player> animation:arm_swing if:<plugin[citizens].exists>
        # Достаётся инфа про конкретную записку
        - define writ <player.flag[select_writ]>
        # Локация записки
        - define location <[writ].location||<player.location.up[100]>>
        # В этой локации спавнится большая записка (та, что летает)
        - spawn WritBig <[location]> save:ent
        - define ent <entry[ent].spawned_entity>
        - adjust <player> <map[show_entity=<[ent]>;hide_entity=<[writ]>]>
        - flag <player> writ:<map[entity=<[ent]>;rotate=false]>
        - define entities <list>
        - foreach <script.data_key[data.<[writ].flag[id]||nil>]||<map>>:
            - foreach <[value].as[list]> as:entity:
                - spawn <[entity].parsed.as[entity].with[hide_from_players=true;force_no_persist=true;teleport_duration=<[ent].teleport_duration>]> <[location]> save:ent
                - define part <entry[ent].spawned_entity>
                - adjust <player> <map[show_entity=<[part]>]>
                - define data <map[offset=<[key].as[location].with_z[0.015]>;scale=<[part].scale.with_z[0.001]>;left_rotation=<[part].left_rotation||<quaternion[identity]>>]>
                - flag <[part]> data:<[data]>
                - define scale <[data.scale].mul[<[ent].scale.y>].with_z[0.001]>
                - adjust <[part]> <map[translation=<[ent].translation.add[<[data.offset].mul[<[scale].y>]>]>;scale=<[scale]>;left_rotation=<[ent].left_rotation.mul[<[data.left_rotation]>]>]>
                - mount <[part]>|<[ent]>
                - define entities:->:<[part]>
        - wait 2t
        - playsound <[location]> <player> sound:item_book_page_turn volume:10
        - repeat 4:
            - define location <[location].forward[<[value].add[0.5].div[12].sin>]>
            - teleport <[ent]> <[location]>
            - wait 1t
        - wait 2t
        - adjust <[ent]> <map[interpolation_start=0;interpolation_duration=<[ent].teleport_duration>;scale=1,1,1]>
        - define old_inter <map>
        - while <player.is_spawned> and <player.has_flag[writ]> and <[ent].is_spawned> and <[location].distance[<player.location>].is_less_than[4]> && <[location].is_truthy>:
            - actionbar "<&f>Нажмите <&6>«<&keybind[key.swapOffhand]>»<&f> чтобы перевернуть"
            - define face <[location].face[<player.eye_location.below[0.15]>]>
            - look <[entities].include[<[ent]>]> yaw:<[face].yaw.add[<player.flag[writ.rotate].if_true[180].if_false[0]>]> pitch:<player.flag[writ.rotate].if_true[<[face].pitch.mul[-1]>].if_false[<[face].pitch>]>
            - define inter <map[interpolation_start=0;interpolation_duration=<[ent].teleport_duration>;translation=0,<[loop_index].div[10].sin.mul[0.045]>,0;left_rotation=<location[0,1,0].to_axis_angle_quaternion[<[loop_index].div[12].sin.mul[4].to_radians>].mul[<location[1,0,0].to_axis_angle_quaternion[<[loop_index].div[8].sin.mul[4].to_radians>]>]>]>
            - adjust <[ent]> <[inter]> if:<[inter].equals[<[old_inter.<[ent]>]||nil>].not>
            - define old_inter.<[ent]>:<[inter]>
            - define left_rotation <[ent].left_rotation||<quaternion[identity]>>
            - foreach <[entities]> as:part:
                - define data <[part].flag[data]>
                - define scale <[data.scale].mul[<[ent].scale.y>]>
                - define inter <map[interpolation_start=0;interpolation_duration=<[ent].teleport_duration>;scale=<[scale]>;left_rotation=<[left_rotation].mul[<[data.left_rotation]>]>;translation=<[left_rotation].transform[<[ent].translation.add[<[data.offset].mul[<[scale].y>]>]>]>]>
                - adjust <[part]> <[inter]> if:<[inter].equals[<[old_inter.<[part]>]||nil>].not>
                - define old_inter.<[part]>:<[inter]>
            - wait 1t
        - flag <player> writ:!
        - look <[entities].include[<[ent]>]> yaw:<[location].yaw> pitch:<[location].pitch>
        - repeat 4:
            - define location <[location].backward[<[value].add[0.5].div[12].sin>]>
            - teleport <[ent]> <[location]>
            - wait 1t
        - wait 2t
        - playsound <[location]> <player> sound:ITEM_BOOK_PUT pitch:0.85 volume:10
        - adjust <player> show_entity:<[writ]> if:<[writ].is_truthy>
        - remove <[entities].include[<[ent]>].filter[is_spawned]>

## НЕ ТРОГАТЬ
Writ:
    type: entity
    entity_type: item_display
    debug: false
    mechanisms:
        item: paper[custom_model_data=<util.random.int[202].to[205]>]
        left_rotation: <location[0,1,0].to_axis_angle_quaternion[<util.random_boolean.if_true[180].if_false[0].to_radians>].mul[<location[0,0,1].to_axis_angle_quaternion[<util.random.int[-25].to[25].to_radians>]>]>
        glow_color: <&[green]>
    flags:
        id: <script[WritHandler].data_key[data].keys.random||nil>

WritBig:
    type: entity
    entity_type: item_display
    debug: false
    mechanisms:
        item: paper[custom_model_data=201]
        scale: 0.65,0.65,0.65
        hide_from_players: true
        force_no_persist: true
        teleport_duration: 4t
#
writ_remove:
    type: command
    name: writremove
    description: Does something
    usage: /writremove
    permission: dscript.mycmd
    script:
    - define target <player.eye_location.ray_trace[return=precise].find_entities[writ].within[0.4].first||null>
    - narrate <[target]>
    - if <[target].script.name> == writ:
        - remove <[target]>
        - foreach <server.players_flagged[writ]> as:__player:
            - narrate <player>
            - flag <player> select_writ:! if:<player.flag[select_writ].equals[<[target]>]>
    - narrate <[target]>
