# Стрела из слизи заражённого
infected_arrow:
    type: item
    material: tipped_arrow
    display name: <dark_purple>Прокажённая стрела
    lore:
    - <gray><italic>Мерзость
    - <gray><italic>Несёт в себе опасность для организма
    mechanisms:
        hides: all
        color: black
    recipes:
        1:
            type: shapeless
            recipe_id: infected_arrow
            category: misc
            input: arrow|infected_slime