margo_core:
    type: item
    material: bedrock
    display name: <&6>Ядро Марго

margo_world:
    type: world
    events:
        on player places margo_core:
            - define margo_core <context.location.center>
            - spawn end_crystal <[margo_core].up[1.1]> save:core
            - define core <entry[core].spawned_entity>
            - adjust <[core]> invulnerable:true
            - flag <[core]> core:true
            - flag <[margo_core]> margo_core:<[core]>
        on player breaks block location_flagged:margo_core:
            - determine cancelled if:<context.location.has_flag[cd]>
            - remove <context.location.flag[margo_core]>
            - flag <context.location> margo_core:!
        on end_crystal damaged by entity:
            - determine cancelled if:<context.entity.has_flag[core]>

        on player right clicks bedrock location_flagged:margo_core with:redcon:
            - determine cancelled if:<context.location.has_flag[cd]>
            - flag <context.location> cd:true expire:1m
            - define margo_core <context.location.center>
            - define planBloc <[margo_core]>
            - take item:redcon if:<player.gamemode.advanced_matches[CREATIVE|SPECTATOR].not>
            - playsound <server.online_players.parse[location]> sound:block.end_portal.spawn targets:<server.online_players>
            - repeat 30:
                - playeffect effect:DUST at:<[margo_core]> offset:<util.random.int[1].to[3]> quantity:<util.random.int[20].to[50]> special_data:[color=<color[#2998ff]>;size=<util.random.int[1].to[3]>]
                - playeffect effect:DUST at:<[margo_core]> offset:<util.random.int[1].to[3]> quantity:<util.random.int[20].to[50]> special_data:[color=<color[#ffc929]>;size=<util.random.int[1].to[3]>]
                - wait <util.random.int[7].to[15]>t
            - run ambient_portal_sound def.core:<[margo_core]>
            - foreach <server.online_players.filter[gamemode.advanced_matches[!SPECTATOR]]> as:__player:
                - if <player.location.world> != <[margo_core].world>:
                    - teleport <player> <[planBloc]>
                - repeat 100:
                    - playeffect effect:DUST at:<[margo_core].points_between[<player.location.up[1]>].distance[0.1]> offset:0 quantity:1 special_data:[color=<color[#2998ff]>;size=0.5] targets:<server.online_players>
                    - playeffect effect:DUST at:<[margo_core].points_between[<[margo_core].up[2]>].distance[0.1]> offset:0 quantity:1 special_data:[color=<color[#ffc929]>;size=0.5] targets:<server.online_players>
                    - playeffect effect:DUST at:<server.online_players.filter[gamemode.advanced_matches[!SPECTATOR]].parse[location.up[1]]> offset:6 quantity:<util.random.int[4].to[12]> special_data:[color=<color[#ca14fc]>;size=<util.random.int[0].to[1]>.<util.random.int[1].to[5]>]
                    - wait 2t
                - playeffect effect:DUST_COLOR_TRANSITION at:<player.location.up[1]> offset:0.4,0.8,0.4 quantity:100 special_data:[size=1.5;from=<color[#2998ff]>;to=<color[#ffc929]>]
                - cast invisibility <player> hide_particles no_icon duration:infinite
                - adjust <player> gamemode:adventure
                - teleport <player> <server.flag[fin_loc]>
                - playsound <player.location> sound:block.portal.trigger targets:<player>
            - wait 5

            - define text <list[При помощи Редкона, вы смогли восстановить Маргариту,|словно она никогда и не знала тех бед, что пришлись на её век.]>

            - if <player.has_flag[team]> && <player.flag[team].advanced_matches[goners]>:
                - define text <[text].insert[Разобравшись в управлении, не без помощи заметок старой команды. Вы смогли найти дорогу домой.|Опасная случайность, сподвигшая вас биться насмерть за право вернуться не пройдёт бесследно.|Но новые тяготы не так страшны, когда уже прошел через ад.|Впрочем, это уже совсем другая история...].at[<[text].size.add[1]>]>
            - if <player.has_flag[team]> && <player.flag[team].advanced_matches[rewrit]>:
                - define text <[text].insert[Укрывшись на этом дивном островке безопасности, вы смогли пережить перестройку этого мира в нечто новое, более совершенное.|В новообретённом мире будет место каждому.|Для признания ошибок,|для роста над собой,|для восстановления некогда утраченной дружбы.|Второй шанс, заслуженный кровью и потом.|Впрочем, это уже совсем другая история...].at[<[text].size.add[1]>]>

            - define text <[text].insert[Спасибо, что остаётесь с нами.|Следующая остановка - ССТ:Technical Invasion!|Конец ССТ: Lost memories.|Конец деменции.].at[<[text].size.add[1]>]>

            - run titri def.text:<[text]>

            - flag <[margo_core]> cd:!

titri:
    type: task
    definitions: text[Текст титров]
    script:
        - foreach <[text].parsed> as:sentence:
            - playsound <server.online_players> sound:ui.button.click volume:0.35 pitch:1.3
            - announce <&sp><&color[#3584E4]>Титры<&sp><dark_gray>»<&sp><&color[#DEDDDA]><[sentence]>
            - wait <[sentence].length.round_up_to_precision[20].div[20].max[1].min[20]||1>

ambient_portal_sound:
    type: task
    definitions: core
    script:
        - while <[core].has_flag[cd]||false>:
            - ~playsound <[core]> sound:block.portal.ambient targets:<server.online_players>
            - wait 5