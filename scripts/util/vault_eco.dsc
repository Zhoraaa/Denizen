# Дать денег
money_add:
    type: task
    definitions: sum|__player
    script:
    - define sum <[sum]||0>
    - money give quantity:<[sum]> players:<player>
    - actionbar targets:<player> "Вы заработали <aqua><[sum]><server.economy.currency_singular><&r>. Всего у вас <aqua><player.money><server.economy.currency_singular><&r>."
# Забрать денег
money_sub:
    type: task
    definitions: sum|__player
    script:
    - define sum <[sum]||0>
    - define ap_bal <player.flag[ap_bal]||0>
    - money take quantity:<[sum]> players:<player>
    - actionbar targets:<player> "Вы потратили <aqua><[sum]><server.economy.currency_singular><&r>. У вас осталось <aqua><player.money><server.economy.currency_singular><&r>."