amulet_belt:
    type: inventory
    title: Амулетный пояс
    inventory: hopper
    procedural items:
    - determine <player.flag[amulet_belt]>
    slots:
    - [] [] [] [] []

amulets_world:
    debug: false
    type: world
    events:
        on player joins flagged:!amulet_belt:
        - flag <player> amulet_belt:<list>

        on player closes amulet_belt:
        - flag <player> amulet_belt:<context.inventory.list_contents>
        # Контексты для кастом ивента обновления пояса
        - definemap context:
            player: <player>
            amulet_belt: <player.flag[amulet_belt]>
        - customevent id:update_amulet_belt context:<[context]>
        on player clicks in amulet_belt with:!amulet_*|air:
        - determine cancelled if:<context.clicked_inventory.script.name.equals[amulet_belt]>
        on player clicks in amulet_belt:
        - determine cancelled if:<context.is_shift_click.and[<context.item.script.name.advanced_matches[!amulet_*]||true>]>

        on player right clicks block with:amulet_*:
        - if <player.flag[amulet_belt].size> < 5:
            - flag <player> amulet_belt:<player.flag[amulet_belt].include_single[<player.item_in_hand>]>
            - take iteminhand from:<player.inventory>
            - definemap context:
                player: <player>
                amulet_belt: <player.flag[amulet_belt]>
            - customevent id:update_amulet_belt context:<[context]>
        - else:
            - actionbar '<&c>⚠ Недостаточно амулетных слотов ⚠'

        on player clicks item in inventory:
        - if <context.click> == RIGHT && <context.raw_slot> == 8 && <context.clicked_inventory.id_holder.equals[<player>]> && <context.slot_type> == ARMOR:
            - inventory open d:AMULET_BELT

        on custom event id:update_amulet_belt:
        - if <context.amulet_belt.contains[<item[amulet_of_roots]>]>:
            - flag <context.player> root_feeding:true
        - else:
            - flag <context.player> root_feeding:!
        - if <context.amulet_belt.contains[<item[amulet_of_undying]>]>:
            - flag <context.player> undummy:true
        - else:
            - flag <context.player> undummy:!

# ₪ - Утилитарный амулет
# ❤ - Защитный амулет
# ⛏ - Амулет добычи
# 🗡 - Боевой амулет