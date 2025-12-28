#
amulet_of_undying:
    type: item
    material: rabbit_foot
    display name: <&6>Болванчик
    lore:
    - <&b>❤ Защитный амулет
    - <&7><italic>Козёл отпущения
    mechanisms:
        components_patch: <map[minecraft:max_stack_size=int:1]>

undying_with_amulet:
    type: world
    events:
        on player dies flagged:undummy:
        # - ratelimit <player> 30s
        - run undummy_sacrifice def:<player>
        - determine cancelled

#
undummy_sacrifice:
    type: task
    definitions: __player
    script:
    - playsound <player.location> sound:entity.enderman.teleport pitch:0.8
    - create player <player.name> <player.location> save:dummy
    - define dummy <entry[dummy].created_npc>
    - adjust <[dummy]> skin:<player.name>
    - playeffect at:<[dummy].eye_location> effect:campfire_cosy_smoke quantity:30
    - lookclose <[dummy]> state:true realistic
    #
    - define player_vector <player.location.backward[1].sub[<player.location>].with_yaw[<player>].with_y[1].round_to_precision[1]>
    - push <player> origin:<player> destination:<player.location.add[<[player_vector]>]> speed:1 no_rotate
    - cast invisibility <player> duration:10s
    #
    - wait 5
    - playeffect at:<[dummy].location> effect:campfire_cosy_smoke quantity:30
    - remove <[dummy]>
