tpwand:
    type: item
    material: stick
    display name: <&a>Посох телепортации
    lore:
    - <&a>[ЛКМ] <&7>Установить метку
    - <&a>[ПКМ] <&7>Телепортировать на метку

tpwand_world:
    type: world
    events:
        on player left clicks block with:tpwand:
            - stop if:<context.location.is_truthy.not>
            - ratelimit <player> 1t
            - define loc <context.location>
            - define desc <player.item_in_hand.lore.get[1|2]>
            - define desc:->:<[loc]>
            - inventory adjust slot:hand lore:<[desc]>
            - inventory flag slot:hand tploc:<[loc]>
            - determine cancelled
        on player right clicks block with:tpwand:
            - stop if:<player.item_in_hand.script.name.equals[tpwand].not>
            - stop if:<player.item_in_hand.lore.size.is_less_than[3]>
            - define tploc <player.item_in_hand.flag[tploc].up[1]>
            - teleport <server.online_players> <[tploc]>