team_item:
    type: item
    material: red_dye
    display name: <&c>Раздел<&b>итель
    lore:
    - <&f>[ЛКМ] <&7> - Выбрать команду
    - <&f>[ПКМ] <&7> - Присвоить команду
    - <&f>[Ударить игрока] <&7> - Убрать команду
    - <&c>Отстутпники
    - <&b>Переписчики

#
teams_world:
    type: world
    events:
        on player left clicks air with:team_item:
            - ratelimit <player> 4t
            - if <player.item_in_hand.material.name.equals[red_dye]>:
                - inventory adjust material:light_blue_dye slot:hand
            - else if <player.item_in_hand.material.name.equals[light_blue_dye]>:
                - inventory adjust material:red_dye slot:hand
        on player damages player with:team_item:
            - announce '<&f><context.entity.name> больше не в команде.' if:<context.entity.has_flag[team]>
            - flag <context.entity> team:! if:<context.entity.has_flag[team]>
        on player right clicks player with:team_item:
            - ratelimit <player> 4t
            - if <player.item_in_hand.material.name.equals[red_dye]>:
                - flag <context.entity> team:goners
                - announce '<&c><context.entity.name> теперь в команде отступников.'
            - if <player.item_in_hand.material.name.equals[light_blue_dye]>:
                - flag <context.entity> team:rewrit
                - announce '<&b><context.entity.name> теперь в команде переписи.'
        on player damages player flagged:team:
            - determine cancelled if:<context.damager.flag[team].equals[<context.entity.flag[team]>]||false>