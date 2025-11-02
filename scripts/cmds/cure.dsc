cure_cmd:
    type: command
    name: cure
    description: Лечит игрока от болезни
    usage: /cure <&lt>arg<&gt>
    tab completions:
        1: <server.online_players.parse[name]>
    permission: dscript.mycmd
    script:
    - define target <server.match_player[<context.args.get[1]>]>
    - flag <[target]> infected:!
    - flag <[target]> disease_stage:!
    - flag <[target]> wardened:!
    - run hp_reload