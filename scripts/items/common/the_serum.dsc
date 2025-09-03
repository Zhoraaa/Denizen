# Лекарство
the_serum:
    type: item
    material: splash_potion
    display name: <gold>Cыворотка
    lore:
    - <gold><bold>☉
    mechanisms:
        components_patch: <map[minecraft:enchantment_glint_override=true]>
        hides: all
        color: orange
    recipes:
        1:
            type: brewing
            input: blood_fire_essence
            ingredient: infected_slime_extract

brew_serum:
    type: world
    events:
        on brewing stand brews:
        - if <context.result.script.name.equals[the_serum]>:
            - explode power:1 <context.location> fire
        on brewing starts:
        - if <context.item.script.name.equals[infected_slime_extract]>:
            - flag <context.location> serum_brewing:true expire:<context.brew_time>
            - while <context.location.has_flag[serum_brewing]> and <context.location.block.material.name.equals[brewing_stand]>:
                - playeffect effect:lava at:<context.location.center.up[0.5]> quantity:<util.random.int[0].to[3]> offset:0
                - wait 5t
        on potion splashes:
        - if <context.entities.any>:
            - foreach <context.entities.filter[entity_type.equals[player]]> as:__player:
                - run cure def:<player>|true
        on player clicks item in inventory:
        - wait 1t
        - if <context.clicked_inventory.id_holder.has_flag[serum_brewing]> and !<context.clicked_inventory.slot[<context.raw_slot>].script.name.equals[infected_slime_extract]||false>:
            - flag <context.clicked_inventory.id_holder> serum_brewing:!