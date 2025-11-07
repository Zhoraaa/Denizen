margo_core:
    type: item
    material: bedrock
    display name: Ядро Марго

margo_world:
    type: world
    events:
        on player places margo_core:
            - define margo_core <context.location.center>
            - flag <[margo_core]> margo_core:true
            - spawn end_crystal <[margo_core].up[1.1]> save:core
            - define core <entry[core].spawned_entity>
            - adjust <[core]> invulnerable:true
        on player right clicks bedrock location_flagged:margo_core with:redcon:
            - take item:redcon if:<player.gamemode.advanced_matches[CREATIVE|SPECTATOR].not>
            - define margo_core <context.location.center>
            - repeat 30:
                - playeffect effect:TRAIL at:<[margo_core]> offset:<util.random.int[1].to[3]> quantity:<util.random.int[20].to[50]> special_data:[color=<color[#2998ff]>;target=<[margo_core]>;duration=<util.random.int[1].to[3]>s]
                - playeffect effect:TRAIL at:<[margo_core]> offset:<util.random.int[1].to[3]> quantity:<util.random.int[20].to[50]> special_data:[color=<color[#ffc929]>;target=<[margo_core]>;duration=<util.random.int[1].to[3]>s]
                - wait 10t
            - foreach <server.online_players.filter[gamemode.advanced_matches[!SPECTATOR]]> as:__player:
                - repeat 100:
                    - playeffect effect:TRAIL at:<[margo_core]> offset:0 quantity:1 special_data:[color=<color[#2998ff]>;target=<player.location.up[1]>;duration=1s] targets:<server.online_players>
                    - playeffect effect:TRAIL at:<[margo_core]> offset:0 quantity:1 special_data:[color=<color[#ffc929]>;target=<[margo_core].up[2]>;duration=1s] targets:<server.online_players>
                    - playeffect effect:TRAIL at:<[margo_core].up[2]> offset:2 quantity:1 special_data:[color=<color[#ca14fc]>;target=<[margo_core].up[2]>;duration=1s] targets:<server.online_players>
                    - wait 1t
                - playeffect effect:DUST_COLOR_TRANSITION at:<player.location.up[1]> offset:0.4,0.8,0.4 quantity:100 special_data:[size=1.5;from=<color[#2998ff]>;to=<color[#ffc929]>]
                - adjust <player> gamemode:spectator
            - if <player.has_flag[team_goners]>:
                - customevent id:goners_win
            - if <player.has_flag[team_rewrit]>:
                - customevent id:rewrit_win
