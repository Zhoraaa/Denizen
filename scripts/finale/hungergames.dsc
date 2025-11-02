hg_wand:
    type: item
    material: blaze_rod
    display name: <gold>Указатель центра [HG]lt
    lore:
    - <&b>[ЛКМ] <&7>- Указать центр поля (Блок)
    - <&6>[ПКМ] <&7>- Просмотр круга спавна

hg_centering:
    type: world
    debug: false
    events:
        on player left clicks block with:hg_wand:
            - playeffect at:<context.location> effect:REDSTONE_TORCH_BURNOUT quantity:3
            - flag server hg.center:<context.location.center>
            - determine cancelled
        on player right clicks block with:hg_wand:
            - if <server.has_flag[hg.center].not>:
                - actionbar '<red>Сначала укажите центральную точку HG используя ЛКМ'
                - stop

            - playeffect at:<server.flag[hg.center]> effect:flame quantity:50 offset:0.3 targets:<server.online_players>
            - foreach <server.flag[hg.center].points_around_y[radius=<server.flag[hg.rad]||2>;points=90]> as:p:
                - playeffect at:<[p]> effect:flame quantity:1 offset:0 targets:<server.online_players>
        on player walks flagged:hg_stan:
            - determine cancelled
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
            - playeffect at:<[p]> effect:flame quantity:1 offset:0 targets:<server.online_players>
            - teleport <[pl]> <[p].down[0.5]>
            - look <[pl]> <server.flag[hg.center].up[1]>
            - modifyblock <[p].down[1]> material:chiseled_stone_bricks
            - wait 2t
            - flag <[pl]> hg_stan:true expire:1m

hg_start:
    type: task
    script:
        - flag <server.online_players_flagged[hg_stan]> hg_stan:!

