disc_burn_charge:
  type: command
  name: discburn
  description: "Charge 50 and run /disc burn args"
  usage: /discburn
  permission: discburn.use
  script:
    - define url <context.args.get[1]>
    - define label <context.args.get[2]>

    - if <player.money> < 50:
        - narrate "<red>У вас недостаточно вдохновения!"
        - stop

    - execute as_server "economy take <player.name> 50"
    - wait 10t

    - execute as_server "lp user <player.name> permission set pv.addon.discs.burn true"
    - wait 10t

    - narrate "<green>Снято 50 вдохновения... Получения пластинки выполнено"
    - execute as_player "disc burn <[url]> <[label]>"
    - wait 10t

    - execute as_server "lp user <player.name> permission set pv.addon.discs.burn false"
