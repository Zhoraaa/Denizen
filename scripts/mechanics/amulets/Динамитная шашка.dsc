amulet_of_exploding_arrows:
    type: item
    material: rabbit_foot
    display name: <&6>Динамитная шашка
    lore:
    - <&b>🗡 Боевой амулет
    - <&7><italic>Твои стрелы наполняются
    - <&7><italic>магией <&c>💥 прибабаха 💥

exploding_arrows:
    type: world
    events:
        on custom event id:update_amulet_belt:
        - flag <player> exploding_arrows:true if:<context.amulet_belt.contains[<item[amulet_of_exploding_arrows]>]>
        - flag <player> exploding_arrows:! if:<context.amulet_belt.contains[<item[amulet_of_exploding_arrows]>].not>

        on arrow hits block:!air shooter:player:
        - stop if:<context.shooter.has_flag[exploding_arrows].not>
        #
        - define exploding_position:<context.hit_block.add[<context.hit_face>].center>
        - define can_explode:<[exploding_position].material.advanced_matches[water|lava].not>
        #
        - playeffect at:<[exploding_position]> targets:<server.online_players> effect:redstone_torch_burnout if:<[can_explode].not>
        - stop if:<[can_explode].not>
        #
        - playsound <[exploding_position]> sound:entity.tnt.primed sound_category:blocks if:<[can_explode]>
        - modifyblock <[exploding_position]> material:light[level=6] if:<[can_explode]>
        - repeat 20:
            - define can_explode:<[exploding_position].material.advanced_matches[water|lava].not>
            - playeffect at:<[exploding_position]> targets:<server.online_players> effect:redstone_torch_burnout if:<[can_explode].not>
            - repeat stop if:<[can_explode].not>
            - playeffect at:<[exploding_position]> effect:flame offset:0.3 if:<[can_explode]> targets:<server.online_players>
            - wait 1t
        - modifyblock <[exploding_position]> material:air if:<[can_explode]>
        - explode power:1.5 <[exploding_position]> fire if:<[can_explode]> 
        - remove <context.projectile>