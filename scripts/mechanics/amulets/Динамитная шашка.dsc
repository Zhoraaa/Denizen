amulet_of_exploding_arrows:
    type: item
    material: rabbit_foot
    display name: <&6>Динамитная шашка
    lore:
    - <&b>🗡 Боевой амулет
    - <&7><italic>Теперь твои стрелы начинены
    - <&7><&c>💥 ВЗРЫВЧАТКОЙ 💥

exploding_arrows:
    type: world
    debug: false
    events:
        on custom event id:update_amulet_belt:
        - flag <player> exploding_arrows:true if:<context.amulet_belt.contains[<item[amulet_of_exploding_arrows]>]>
        - flag <player> exploding_arrows:! if:<context.amulet_belt.contains[<item[amulet_of_exploding_arrows]>].not>

        on arrow hits block:!air shooter:player:
        - stop if:<context.shooter.has_flag[exploding_arrows].not>
        #
        - define exploding_position:<context.hit_block.add[<context.hit_face>].center>
        - define can_explode:<proc[can_explode].context[<[exploding_position]>]>
        #
        - playeffect at:<[exploding_position]> targets:<server.online_players> effect:redstone_torch_burnout if:<[can_explode].not>
        - stop if:<[can_explode].not>
        #
        - playsound <[exploding_position]> sound:entity.tnt.primed sound_category:blocks if:<[can_explode]>
        - if <[exploding_position].material.equals[air]>:
            - modifyblock <[exploding_position]> material:light[level=7]
            - flag <[exploding_position]> temp_light:true
        - else:
            - define expl_flame <[exploding_position].find_blocks[air].within[2].get[1]>
            - flag <[expl_flame]> temp_light:true
            - modifyblock <[expl_flame]> material:light[level=7]
        #
        - repeat 20:
            - playeffect at:<[exploding_position]> effect:flame quantity:2 offset:0.3 targets:<server.online_players>
            - wait 1t
        #
        - define can_explode:<proc[can_explode].context[<[exploding_position]>]>
        #
        - foreach <[exploding_position].find_blocks_flagged[temp_light].within[2]> as:loc:
            - if <[loc].material.waterlogged.is_truthy>:
                - modifyblock <[loc]> material:water
            - else:
                - modifyblock <[loc]> material:air
        #
        - if <[can_explode]>:
            - explode power:1.5 <[exploding_position]> source:<context.shooter>
            - remove <context.projectile>
        - else:
            - playeffect at:<[exploding_position]> targets:<server.online_players> effect:redstone_torch_burnout if:<[can_explode].not>
            - modifyblock <[exploding_position]> material:water if:<[exploding_position].material.equals[light].and[<[exploding_position].material.waterlogged>]>

can_explode:
    type: procedure
    debug: false
    definitions: loc
    script:
    - define isnt_fluid:<[loc].is_liquid.not>
    - define is_dry:<[loc].material.waterlogged.is_truthy.not>
    - define can_explode:<[isnt_fluid].and[<[is_dry]>]>
    - determine <[can_explode]>