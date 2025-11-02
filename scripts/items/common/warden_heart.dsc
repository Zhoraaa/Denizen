warden_heart:
    type: item
    material: fermented_spider_eye
    display name: <dark_purple>Прокажённое сердце
    mechanisms:
        components_patch: <map[minecraft:max_stack_size=int:1]>

wardenheart:
    type: world
    events:
        # Сердце вардена
        on warden dies:
        - drop warden_heart <context.entity.location>
