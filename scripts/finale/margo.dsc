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
            - take item:redcon if:<player.gamemode.advanced_matches[CREATIVE|SPECTATOR].not>
            - define margo_core <context.location.center>
            - define planBloc <player.location>
            - repeat 30:
                - playeffect effect:DUST at:<[margo_core]> offset:<util.random.int[1].to[3]> quantity:<util.random.int[20].to[50]> special_data:[color=<color[#2998ff]>;size=<util.random.int[1].to[3]>]
                - playeffect effect:DUST at:<[margo_core]> offset:<util.random.int[1].to[3]> quantity:<util.random.int[20].to[50]> special_data:[color=<color[#ffc929]>;size=<util.random.int[1].to[3]>]
                - wait <util.random.int[7].to[15]>t
            - foreach <server.online_players.filter[gamemode.advanced_matches[!SPECTATOR]]> as:__player:
                - if <player.location.world> != <context.location.world>:
                    - teleport <player> <[planBloc]>
                - repeat 100:
                    - playeffect effect:DUST at:<[margo_core].points_between[<player.location.up[1]>].distance[0.1]> offset:0 quantity:1 special_data:[color=<color[#2998ff]>;size=0.5] targets:<server.online_players>
                    - playeffect effect:DUST at:<[margo_core].points_between[<[margo_core].up[2]>].distance[0.1]> offset:0 quantity:1 special_data:[color=<color[#ffc929]>;size=0.5] targets:<server.online_players>
                    - playeffect effect:DUST at:<server.online_players.filter[gamemode.advanced_matches[!SPECTATOR]].parse[location.up[1]]> offset:6 quantity:<util.random.int[4].to[12]> special_data:[color=<color[#ca14fc]>;size=<util.random.int[0].to[1]>.<util.random.int[1].to[5]>]
                    - wait 2t
                - playeffect effect:DUST_COLOR_TRANSITION at:<player.location.up[1]> offset:0.4,0.8,0.4 quantity:100 special_data:[size=1.5;from=<color[#2998ff]>;to=<color[#ffc929]>]
                - adjust <player> gamemode:spectator

            - if <player.has_flag[team_goners]>:
                - customevent id:goners_win
            - if <player.has_flag[team_rewrit]>:
                - customevent id:rewrit_win

            - flag <context.location> cd:!