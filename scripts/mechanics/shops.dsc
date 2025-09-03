shop_cmd:
    type: command
    name: shop
    # debug: false
    description: Открывает любой существующий магазин
    usage: /shop <&lt>Название магазина<&gt>
    permission: dscript.mycmd
    tab completions:
        1: <server.flag[shops].keys>
    script:
    - flag <player> current_shop:<context.args.separated_by[ ]>
    - inventory open d:SHOP_INTERFACE
#
shop_assort:
    type: procedure
    definitions: shop_name
    debug: false
    script:
    # Список всех магазинов сервера
    - define shop <server.flag[shops].get[<[shop_name]>]||null>
    - define list <list[]>
    - foreach <[shop]> as:pos:
        - define lore <list[]>
        - define lore:->:<gray>Цена:<&sp><gold><[pos].get[cost]>★<dark_gray><&sp>(ЛКМ)<&r> if:<[pos].get[cost].is_truthy>
        - define lore:->:<gray>Цена:<&sp><aqua><[pos].get[vault]><server.economy.currency_singular><dark_gray><&sp>(ПКМ)<&r> if:<[pos].get[vault].is_truthy>
        - define properties.display <[pos].get[display].is_truthy.if_true[<element[display=<[pos].get[display]>;]>].if_false[<element[]>]>
        - define properties.lore lore=<[pos].get[item].as[item].lore||<element[<[lore].separated_by[|]>]>>
        - define list:->:<[pos].get[item]>[<[properties.display]><[properties.lore]>]
    - determine <[list]>
#
shop_interface:
    type: inventory
    inventory: chest
    debug: false
    title: <player.flag[current_shop]||<element[<red>ERR:flag 'current_shop' existn't7]>>
    gui: true
    definitions:
        my item: nether_star
        other item: ink_sac
    procedural items:
    - define assort <player.flag[current_shop].proc[shop_assort]>
    - determine <[assort]>
    slots:
    - [] [] [] [] [] [] [] [] []
    - [] [] [] [] [] [] [] [] []
    - [] [] [] [] [] [] [] [] []
    - [] [] [] [] [] [] [] [] []
    - [] [] [] [] [] [] [] [] []
    - [] [] [] [] [] [] [] [] []
#
shopping:
    type: world
    debug: false
    events:
        after script reload:
        - fileread path:data/shops.json save:shops
        - flag server shops:<entry[shops].data.text_decode[utf-8].parse_yaml>
        on player clicks in shop_interface:
        - determine cancelled if:<context.clicked_inventory.title.equals[inventory]>
        - stop if:<context.item.material.name.equals[air]>
        - define item <context.item.script.name||<context.item.material.name>>
        - define pricelist <context.item.lore.strip_color.as[list].filter[contains[Цена: ]].parse[after[Цена: ]].replace_text[ (ЛКМ)].replace_text[ (ПКМ)]||<list[]>>
        - define ap_bal <player.flag[ap_bal]||0>
        - if <context.click.equals[LEFT]>:
            - define cost <[pricelist].filter[contains[★]].parse[replace_text[★]].get[1]||false>
            - if <[cost].is_integer.not>:
                - actionbar "<red>Этот предмет нельзя купить за ★!"
                - stop
            # Дропаем, если клиент челядь
            - if <[ap_bal]> < <[cost]>:
                - actionbar "<red>Ваши финансы поют романсы (<[ap_bal]>★)"
                - stop
            - run ap_bal_sub def:<[cost]>|<player> if:<[cost].equals[0].not>
            #
            - define properties.display <context.item.display.is_truthy.if_true[<element[<context.item.display>]>].if_false[<element[]>]>
            - give <[item]>[<[properties].to_list.separated_by[;].replace[/].with[=]>] to:<player.inventory>
        - if <context.click> == RIGHT:
            - define cost <[pricelist].filter[contains[<server.economy.currency_singular>]].parse[replace_text[<server.economy.currency_singular>]].get[1]||false>
            - if <[cost].is_integer.not>:
                - actionbar "<red>Этот предмет нельзя купить за <server.economy.currency_singular>!"
                - stop
            # Дропаем, если клиент челядь
            - if <player.money> < <[cost]>:
                - actionbar "<red>Ваши финансы поют романсы (<[ap_bal]><server.economy.currency_singular>)"
                - stop
                - stop
            - run money_sub def:<[cost]>|<player> if:<[cost].equals[0].not>
            - define properties.display <context.item.display.is_truthy.if_true[<element[<context.item.display>]>].if_false[<element[]>]>
            - give <[item]>[<[properties].to_list.separated_by[;].replace[/].with[=]>] to:<player.inventory>