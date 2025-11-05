hg_wand:
    type: item
    material: blaze_rod
    display name: <gold>Указатель центра [HG]
    lore:
    - <&b>[ЛКМ] <&7>- Указать центр поля (Блок)
    - <&6>[ПКМ] <&7>- Просмотр круга спавна

hg_centering:
    type: world
    debug: false
    events:
        on player left clicks block with:hg_wand:
            - define loc <context.location>
            - define loc <context.location.up[1]> if:<[loc].material.is_solid>
            - playeffect at:<[loc]> effect:REDSTONE_TORCH_BURNOUT quantity:3
            - flag server hg.center:<[loc].center>
            - determine cancelled
        on player right clicks block with:hg_wand:
            - if <server.has_flag[hg.center].not>:
                - actionbar '<red>Сначала укажите центральную точку HG используя ЛКМ'
                - stop

            - playeffect at:<server.flag[hg.center]> effect:flame quantity:50 offset:0.3 targets:<server.online_players>
            - foreach <server.flag[hg.center].points_around_y[radius=<server.flag[hg.rad]||2>;points=90]> as:p:
                - playeffect at:<[p]> effect:flame quantity:1 offset:0 targets:<server.online_players>
        on player jumps flagged:hg_stan:
            - determine cancelled

hg_spawnrad:
    type: command
    name: hgsr
    description: Строго радиус для HG
    usage: /hgsr <&lt>число<&gt>
    tab completions:
        1: unset|6|8|10|12
    permission: dscript.mycmd
    script:
        - flag server hg.rad:<context.args.get[1]>

hg_state:
    type: command
    name: hg
    desription: Начать HG. Все игроки в режиме выживания и приключения отправляются на исходные в указанном радиусе (см. /hgrs). Прочие - в центр поля, становятся наблюдателями.
    usage: /hg <&lt>state<&gt>
    tab completions:
        1: ready|start
    permission: dscript.mycmd
    script:
        - run hg_ready if:<context.args.get[1].equals[ready]>
        - run hg_start if:<context.args.get[1].equals[start]>

hg_ready:
    type: task
    script:
        - define members <list>

        - foreach <server.online_players> as:__player:
            - if <player.gamemode.advanced_matches[SURVIVAL|ADVENTURE]>:
                - define members:->:<player>
            - else:
                - adjust <player> gamemode:SPECTATOR
                - teleport <player> <server.flag[hg.center]>

        - foreach <server.flag[hg.center].points_around_y[radius=<server.flag[hg.rad]||2>;points=<[members].size>]> as:p:
            - define pl <[members].get[<[loop_index]>]>
            - adjust <[pl]> fov_multiplier:1.5
            - playeffect at:<[p]> effect:flame quantity:1 offset:0 targets:<server.online_players>
            - teleport <[pl]> <[p].down[0.5]>
            - look <[pl]> <server.flag[hg.center].up[1]>
            - modifyblock <[p].down[1]> material:chiseled_stone_bricks
            - wait 2t
            - flag <[pl]> hg_stan:true expire:5m
            - cast SLOWNESS duration:5m <[pl]> amplifier:255

        - runlater hg_start delay:1m

hg_start:
    type: task
    script:
        - playsound sound:block.note_block.pling <player.location> pitch:1.2
        - title title:<red><bold>3 fade_in:5t stay:15t
        - wait 1
        - playsound sound:block.note_block.pling <player.location> pitch:1.2
        - title title:<gold><bold>2 fade_in:0 stay:1s
        - wait 1
        - playsound sound:block.note_block.pling <player.location> pitch:1.2
        - title title:<yellow><bold>1  fade_in:0 stay:1s
        - wait 1
        - playsound sound:block.note_block.pling <player.location> pitch:1.5
        - title title:<green><bold>GO! fade_in:0 stay:1s
        - wait 10t
        - title title: stay:1s

        - cast SLOWNESS remove <server.online_players>
        - flag <server.online_players_flagged[hg_stan]> hg_stan:!

