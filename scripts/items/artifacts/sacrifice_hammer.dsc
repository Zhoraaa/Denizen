#
# [ Молот босса ]
# Держащий получает силу второго уровня
# На ЛКМ взрывной удар вперёд.
# На ПКМ взрывной удар вокруг.
#
sacrifice_hammer:
    type: item
    material: mace
    display name: <red>Жертвенный молот
    lore:
    - <gray>Гравировка<&co>
    - <aqua><italic>Отец небесный, предали мы идеалы твои.
    - <aqua><italic>Проступок наш непростителен.
    - <aqua><italic>В мольбе о пощаде, мы приносим тебе
    - <aqua><italic>величайшую жертву из возможных.
    - <aqua><italic>Закованную во плоть из металла.
    - <red>Уникальный
    mechanisms:
        unbreakable: true

sacrifice_hammer_mechanics:
    type: world
    events:
        # Удар под себя
        on player right clicks block with:sacrifice_hammer flagged:!bhcd:
        - flag <player> JUDGEMENT:!
        - define cooldown 25s
        - flag <player> bhcd:true expire:<[cooldown]>
        - itemcooldown mace duration:<[cooldown]>
        - playsound <player.location> sound:block.anvil.use pitch:0.2
        - cast SLOW amplifier:15 duration:2s <player>
        - repeat 3:
            - foreach <player.location.points_around_y[radius=3;points=12].parse[add[0,0.33,0]]> as:loc:
                - explode <[loc]> power:1 source:<player>
                - playeffect targets:<server.online_players> <[loc].sub[0,1,0]> effect:sonic_boom offset:0.3 quantity:5
            - wait 15t
        - flag <player> JUDGEMENT:true expire:<[cooldown]>
        # Ударная волна
        on player left clicks block with:sacrifice_hammer flagged:!bhcd:
        - flag <player> JUDGEMENT:!
        - define cooldown 25s
        - flag <player> bhcd:true expire:<[cooldown]>
        - itemcooldown mace duration:<[cooldown]>
        - playsound <player.location> sound:block.anvil.land pitch:0.2
        - wait 3t
        - foreach <player.location.points_between[<player.eye_location.ray_trace[range=10]||<player.eye_location.forward[10]>>].distance[0.5]> as:loc:
            - explode <[loc]> power:2 source:<player>
            - playeffect <[loc]> effect:SHRIEK special_data:[duration=0] offset:0.3 quantity:10 targets:<server.online_players>
            - wait 2t
        - flag <player> JUDGEMENT:true expire:<[cooldown]>
        on player damages entity with:sacrifice_hammer flagged:JUDGEMENT:
        - adjust <player> velocity:<player.eye_location.direction.vector.add[0,1,0]>