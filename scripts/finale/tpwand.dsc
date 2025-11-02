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
            - ratelimit <player> 1t
            - define loc <context.location>
            - define desc <player.item_in_hand.lore.exclude[1]>
            - define desc:->:<player.item_in_hand.lore.exclude[2]>
            - define desc:->:<element[<&a>Текущая метка: <[loc].as[list].comma_separated>]>
            - inventory adjust slot:hand lore:<[desc]>
            - determine cancelled