# Артефакты с Луны
belt_o_giant_strength:
    type: item
    material: leather_leggings
    display name: <aqua>Пояс силы великана
    lore:
        - <gray><italic>Этот пояс дарует силу великана
        - <gray><italic>всякому, кто его наденет.
        - <&0>
        - <blue>Редкий <white>артефакт
    flags:
        rarity: 5
    mechanisms:
        hides: all
        unbreakable: true
        attribute_modifiers:
            SCALE:
                1:
                    operation: MULTIPLY_SCALAR_1
                    amount: 0.2
                    slot: LEGS
            ATTACK_DAMAGE:
                1:
                    operation: MULTIPLY_SCALAR_1
                    amount: 0.2
                    slot: LEGS
            STEP_HEIGHT:
                1:
                    operation: MULTIPLY_SCALAR_1
                    amount: 0.2
                    slot: LEGS