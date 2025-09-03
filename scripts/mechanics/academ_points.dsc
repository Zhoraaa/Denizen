# Баланс каждого игрока
ap_init:
    type: world
    events:
        on player joins flagged:!ap_bal:
        - flag <player> ap_bal:0

# Дать баллы
ap_bal_add:
    type: task
    definitions: sum|__player
    script:
    - define sum <[sum]||0>
    - define ap_bal <player.flag[ap_bal]||0>
    - flag <player> ap_bal:<[ap_bal].add[<[sum]>]>
    - actionbar targets:<player> "Вы заслужили <gold><[sum]>★<&r>. Всего у вас <gold><player.flag[ap_bal]>★<&r>."
# Забрать баллы
ap_bal_sub:
    type: task
    definitions: sum|__player
    script:
    - define sum <[sum]||0>
    - define ap_bal <player.flag[ap_bal]||0>
    - flag <player> ap_bal:<[ap_bal].sub[<[sum]>]||<player.flag[ap_bal]>>
    - actionbar targets:<player> "Вы потратили <gold><[sum]>★<&r>. У вас осталось <gold><player.flag[ap_bal]>★<&r>."