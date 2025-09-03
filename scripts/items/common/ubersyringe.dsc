# Трули убершприц
ubersyringe:
    type: item
    material: stone_sword
    display name: <red>Убер-шприц
    lore:
    - <gray><italic>Настоящий шприц для сбора крови
    mechanisms:
        hides: all
        attribute_modifiers:
            ATTACK_DAMAGE:
                1:
                    operation: ADD_SCALAR
                    amount: 0
    recipes:
        1:
            type: shaped
            recipe_id: ubersyringe_1
            input:
            - iron_ingot|air|air
            - air|glass|iron_nugget
            - air|iron_nugget|iron_ingot
        2:
            type: shaped
            recipe_id: ubersyringe_2
            input:
            - air|air|iron_ingot
            - iron_nugget|glass|air
            - iron_ingot|iron_nugget|air

# Сбор крови с помощью убершприца
# Заражённый - чёрная слизь
# Огнерождённый - жгучая кровь
# Остальные - обычная кровь
ubersyringe_use:
    type: world
    events:
        on entity damaged by player:
        # Сбор крови
            - define bloodless <script[disease].data_key[bloodless]>
            - if <player.item_in_hand.display.strip_color.advanced_matches[Убер-шприц]||false> && <player.item_in_hand.script.name.advanced_matches[ubersyringe]||false> && <player.item_in_offhand.material.advanced_matches[glass_bottle]> && <context.cause.advanced_matches[entity_attack|entity_sweep_attack]> :
                - if !<context.entity.entity_type.advanced_matches[<[bloodless]>]>:
                    - take item:glass_bottle from:<player.inventory> quantity:1
                    - if <context.entity.has_flag[origin_marker]> && <context.entity.flag[origin_marker].advanced_matches[blazeborn|magmacube]> && !<context.entity.has_flag[infected]>:
                        - give item:infected_slime quantity:1
                    - else if <context.entity.has_flag[infected]>:
                        - give item:bottle_o_blood_fire quantity:1
                    - else:
                        - give item:bottle_o_blood quantity:1