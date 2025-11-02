parry:
    debug: false
    type: world
    events:
        after player raises shield flagged:!parrying|!parry_cd:
        - define has_amulet <player.has_flag[amulet_belt].and[<player.flag[amulet_belt].contains[<item[amulet_of_parry]>]>]>
        - define amulet_level <player.flag[amulet_belt].find[<item[amulet_of_parry]>]>
        - flag <player> parrying:true expire:5t

        on player lowers shield:
        - flag <player> parrying:!

        on player damaged by entity flagged:parrying:
        - stop if:<context.cause.advanced_matches[ENTITY_ATTACK].not>
        - stop if:<context.entity.flag[parrying].not>
        #
        - flag <context.entity> parrying:!
        - flag <context.entity> parry_cd:true expire:3s
        - itemcooldown shield d:3s
        #
        - playsound <context.entity.location> sound:block.anvil.place pitch:2
        - actionbar +<green>PARRY
        #
        - define vector <context.entity.eye_location.forward[2].sub[<context.entity.eye_location>].round_to_precision[0.5].add[0,0.5,0]>
        - push <context.damager> origin:<context.damager> destination:<context.damager.location.add[<[vector]>]>
        #
        - cast slow_digging duration:3s amplifier:1 no_icon <context.damager>
        - cast confusion duration:1s amplifier:1 no_icon <context.damager>