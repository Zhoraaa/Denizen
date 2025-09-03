# Экзорука Мори
exohand:
    type: item
    material: netherite_scrap
    display name: <red>Ручное управление
    lore:
        - <gold><italic>Незеритовый протез руки
        - <gold><italic>со вкраплениями неизвестных
        - <gold><italic>красных камней.
        - <red>Уникальный
        - <gray>При удержании в левой руке<&co>
    mechanisms:
        custom_model_data: 101
        attribute_modifiers:
            ENTITY_INTERACTION_RANGE:
                1:
                    operation: ADD_SCALAR
                    amount: 0.5
                    slot: offhand
            BLOCK_INTERACTION_RANGE:
                1:
                    operation: ADD_SCALAR
                    amount: 0.5
                    slot: offhand