Dialogue:
    ## run DIALOGUE def:ID|EntityTag|PlayerTag
    type: task
    debug: false
    definitions: id[Айди]|target[Энтити, которое говорит с вами]|__player[Для кого воспроизводить]|text
    script:
    - stop if:<player.has_flag[dialogue].or[<player.has_flag[talking]>]>
    #
    - define data <server.flag[dialogs].get[<[id]||nil>]||<map>>
    - define target <[target]||null>
    - stop if:<[data].is_empty.or[<[target].is_truthy.not>]>
    # Кнопки
    - define entities <list>
    - define offset_y <[data].size.add[1].mul[0.5].div[4].add[0.3]>
    - foreach <[data].keys>:
        - define value <[value].replace[\n].with[<&sp><&nl>]>
        - define option_symbols <server.flag[option_symbols]>
        - define option <[value].to_list.last.advanced_matches[<[option_symbols]>]>
        - define say_pref <[value].to_list.last> if:<[option]>
        - define say_pref - if:<[option].not>
        - define value <[value].replace_text[regex:(<[option_symbols].separated_by[|]>)]>
        - spawn text_display[force_no_persist=true;text=<&sp><[say_pref]><&sp><[value].parsed><&sp>;hide_from_players=true;line_width=9999;scale=0,0.75,0;pivot=center] <[target].eye_location.up[<[offset_y]>].with_pose[0,0]> save:ent
        - adjust <player> show_entity:<entry[ent].spawned_entity>
        - flag <entry[ent].spawned_entity> lines:<entry[ent].spawned_entity.text.to_list.find_all[<&nl>].size||<entry[ent].spawned_entity.text.text_width.div[<entry[ent].spawned_entity.line_width>].round_down||0>>
        - define entities:->:<entry[ent].spawned_entity>
    # Кнопка выхода
    - spawn text_display[force_no_persist=true;text=<&sp>✕<&sp>Пока<&sp>;hide_from_players=true;line_width=9999;scale=0,0.75,0;pivot=center] <[target].eye_location.up[<[offset_y]>].with_pose[0,0]> save:ent
    - adjust <player> show_entity:<entry[ent].spawned_entity>
    - define entities:->:<entry[ent].spawned_entity>
    #
    - wait 2t
    - adjust <player> item_slot:5
    - define flag_map <map[id=<[id]>;select=1;target=<[target]>]>
    - flag <player> dialogue:<[flag_map]>
    #
    - foreach <[entities]> as:ent:
        - define text_width <[ent].text.split[<&nl>].parse[text_width].highest>
        - define yof 0
        - foreach <[entities].filter[has_flag[lines]].get[<[loop_index].add[1]>].to[last].parse[flag[lines]]||<list>>:
            - define yof:+:<[value]>
        - define xof <[text_width].min[<[ent].line_width.sub[2]>].mul[<[ent].scale.y>].div[2]>
        - define yof <[loop_index].mul[-0.235].add[0.25].add[<[yof].mul[<[ent].scale.y.mul[0.25]>]>]>
        - adjust <[ent]> translation:<[xof].mul[0.025].add[0.6]>,<[yof].sub[0.4]>,0
    #
    - define old_inter <map>
    - while <player.is_online||false> and <player.is_spawned||false> and <player.has_flag[dialogue]||false> and <[entities].filter[is_spawned].size.equals[<[entities].size>]||false> and <[target].is_spawned||false> and <[target].location.distance[<player.location>].is_less_than[5]>:
        - define flag_map <player.flag[dialogue]>
        - actionbar "<&f>Используйте <&color[#3584E4]>колесо мыши<&f> для навигации"
        #
        - foreach <[entities]> as:ent:
            - definemap inter:
                interpolation_start: 0
                interpolation_duration: 4t
                scale: 0.75,0.75,0.75
                background_color: transparent
                text_shadowed: true
                text: <&color[#e8f6ff]><[ent].text.strip_color>
            - define inter <[inter].with[scale].as[0.8,0.8,0.8].with[text_shadowed].as[false].with[background_color].as[<&color[#e8f6ff]>].with[text].as[<&color[#052599]><[ent].text.strip_color>]> if:<[flag_map.select].equals[<[loop_index]>]>
            - foreach next if:<[inter].equals[<[old_inter.<[ent]>]||nil>]>
            - adjust <[ent]> <[inter]>
            - define old_inter.<[ent]>:<[inter]>
        #
        - define pitch_offset <[data].size.add[1].div[2]>
        - define face <player.eye_location.face[<[target].eye_location.below[<[flag_map.select].sub[<[pitch_offset]>].mul[0.1]>].left[0.5]>]>
        - stop if:<[face].is_truthy.not>
        #
        - define origin_yaw <[face].yaw.sub[<player.eye_location.yaw>]>
        - define origin_yaw:+:360 if:<[origin_yaw].is_less_than[-180]>
        - define origin_yaw:-:360 if:<[origin_yaw].is_more_than[180]>
        - stop if:<[origin_yaw].is_truthy.not>
        #
        - define yaw_scale_fix <[target].attribute_base_value[scale].sub[<player.attribute_base_value[scale]>].add[0.5].mul[1.3]>
        - look <player> yaw:<player.eye_location.yaw.add[<[origin_yaw].div[13].add[<[yaw_scale_fix]>]>]> pitch:<player.eye_location.pitch.add[<[face].pitch.sub[<player.eye_location.pitch>].div[13]>]> offthread_repeat:4
        - wait 1t
    #
    - flag <player> dialogue:! if:<player.has_flag[dialogue]>
    - define entities <[entities].filter[is_spawned]>
    - adjust <[entities]> <map[interpolation_start=0;interpolation_duration=4t;scale=0,0,0;translation=0,0,0]>
    - wait 5t
    - remove <[entities]>
    talk:
    ## ШПАРГАЛКА ПО ДИАЛОГАМ
    #- (Текст)|(Текст)       | Разделение сообщений
    #- *dialogue_id          | Скачок на другой диалог
    #- ~scipt_id             | Запуск скрипта <br>`run script_id def:<[target]>\|<player>`
    #- &(Сообщение)          | Описание действия
    #- %(Сообщение)          | Системные сообщения
    #- zap+script_id+step_id | Смена шага на интерактивном скрипте <br>`zap <script_id> <step_id>`
    #- 0t(Текст)             | Без задержки после сообщения. Ставить в последнем предложении
    # Список спецсимволов, которые могут выступать в качестве диалоговой подсказки:
    # ➥|❤|★|✦|Ⓞ|🍖|🔥|☠|🗡|⛏|✔|✘|⚠|‼|⌚|↔
    - define target_name <player.flag[dialogue.target].name||<[target].name||<[target]||???>>>
    - define text <[text].as[list]||<list>>
    - flag <player> d_target:<[target]> if:<[target].is_truthy>
    - flag <player> talking expire:10s
    - foreach <[text].parsed> as:sentence:
        - define wait 0
        # Технические триггеры
        - if  <[sentence].contains[~]>:
            - run <[sentence].replace_text[~]> def:<player.flag[d_target]>|<player>
        - else if <[sentence].contains[*]>:
            - run dialogue_jump def:<[sentence].replace_text[*]>|<player.flag[d_target]>|<player>
        - else if <[sentence].contains[zap]>:
            - define zapping <[sentence].replace[+].with[|].as[list]>
            - zap <[zapping].get[2]> <[zapping].get[3]>
        # Пишется в чат
        - else if <[sentence].contains[&]>:
            # Действие
            - playsound <player> sound:ui.button.click volume:0.35 pitch:1.3
            - narrate targets:<player> "<&sp><&color[#3584E4]>⏴<&sp><[target_name]> <[sentence].replace_text[&]><&sp>⏵"
            - define wait <[sentence].length.div[20].max[20]||20>t if:<[sentence].not>
        - else if <[sentence].contains[%]>:
            # Подсказка
            - playsound <player> sound:block.amethyst_block.break volume:1 pitch:0.5
            - narrate targets:<player> "<&sp><aqua><element[[?]].on_hover[<aqua>Подсказка]> <dark_gray>» <&color[#DEDDDA]><[sentence].replace_text[%]>"
            - define wait <[sentence].length.div[20].max[20]||20>t  if:<[sentence].contains[0t].not>
        - else:
            # Прямая речь
            - playsound <player> sound:ui.button.click volume:0.35 pitch:1.3
            - narrate targets:<player> <&sp><&color[#3584E4]><[target_name]><&sp><dark_gray>»<&sp><&color[#DEDDDA]><[sentence]>
            - define wait <[sentence].length.div[20].max[20]||20>t if:<[sentence].contains[0t].not>
        # - narrate <[sentence]>
        # - narrate <[wait]>
        # - narrate <player.flag[talking]>
        - wait <[wait]>
    #
    - flag <player> talking:!

DialogueHandler:
    type: world
    debug: false
    events:
        after script reload:
        - ~fileread path:data/dialogs.json save:dialogs
        - flag server dialogs:<entry[dialogs].data.text_decode[utf-8].parse_yaml>
        - flag server option_symbols:<list[➥|❤|★|✦|Ⓞ|🍖|🔥|☠|🗡|⛏|✔|✘|⚠|‼|⌚|↔]>
        on player joins flagged:d_target:
        - flag <player> d_target:!
        on player clicks block flagged:dialogue:
        - determine passively cancelled
        - ratelimit <player> 4t
        - define data <server.flag[dialogs].get[<player.flag[dialogue.id]>]>
        - define select <player.flag[dialogue.select]>
        - define say <[data].keys.get[<[select]>].replace[regex:<server.flag[option_symbols].separated_by[|]>]||Пока>
        - narrate targets:<player> <&sp><gold><player.name><&sp><dark_gray>»<&sp><&color[#DEDDDA]><[say]>
        - wait <[say].length.div[20].min[40].max[10]>t
        - run Dialogue path:talk def.text:<[data].values.get[<[select]>]> if:<[select].is_less_than[<[data].size.add[1]>]>
        - flag <player> dialogue:!
        on player scrolls their hotbar flagged:dialogue:
        - determine passively cancelled
        - define data <server.flag[dialogs].get[<player.flag[dialogue.id]>]>
        - define slot <context.new_slot.sub[<context.previous_slot>].min[1].max[-1]>
        - define new_pos <player.flag[dialogue.select].add[<[slot]>]>
        - playsound <player> sound:item_spyglass_stop_using pitch:0.85 volume:2
        - if <[new_pos].is_less_than_or_equal_to[0]>:
            - flag <player> dialogue.select:<[data].size.add[1]>
        - else if <[new_pos].is_more_than[<[data].size.add[1]>]>:
            - flag <player> dialogue.select:1
        - else:
            - flag <player> dialogue.select:<[new_pos]>

Dialogue_jump:
    type: task
    definitions: id|target|__player
    script:
    - wait 5t
    - run dialogue def:<[id]>|<[target]>|<player>