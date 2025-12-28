# Парирование щитом с окном в 5 тиков
amulet_of_parry:
    type: item
    material: rabbit_foot
    display name: <&6>Возвращатель
    lore:
    - <&b>❤ Защитный амулет
    - <&7><italic>Позволяет <&a>парировать <&7><italic>удары
    - <&7><italic>при помощи <&6>щита
    mechanisms:
        components_patch: <map[minecraft:max_stack_size=int:1]>

parry:
    debug: false
    type: world
    events:
        on custom event id:update_amulet_belt:
        - flag <player> can_parry:true if:<context.amulet_belt.contains[<item[amulet_of_parry]>]>
        - flag <player> can_parry:! if:<context.amulet_belt.contains[<item[amulet_of_parry]>].not>

        after player raises shield flagged:can_parry|!parrying|!parry_cd:
        - define has_amulet <player.has_flag[amulet_belt].and[<player.flag[amulet_belt].contains[<item[amulet_of_parry]>]>]>
        - define amulet_level <player.flag[amulet_belt].find[<item[amulet_of_parry]>]>
        - flag <player> parrying:true expire:5t

        on player lowers shield:
        - flag <player> parrying:!

        on player damaged by entity flagged:parrying:
        # Парируемые типы урона
        - stop if:<context.cause.advanced_matches[ENTITY_ATTACK].not>
        # Для дополнительных амулетов
        - definemap context:
            defender: <context.entity>
            attacker: <context.damager>
        - customevent id:parry context:<[context]>
        #
        - flag <context.entity> parrying:!
        - flag <context.entity> parry_cd:true expire:3s
        - itemcooldown shield d:3s
        #
        - playsound <context.entity.location> sound:block.anvil.place pitch:2 volume:0.65
        - actionbar +<green>PARRY
        #
        - define vector <context.entity.eye_location.forward[2].sub[<context.entity.eye_location>].round_to_precision[0.5].add[0,0.5,0]>
        - push <context.damager> origin:<context.damager> destination:<context.damager.location.add[<[vector]>]>
        #
        - cast slow_digging duration:3s amplifier:1 no_icon <context.damager>
        - cast confusion duration:1s amplifier:1 no_icon <context.damager>

        on custom event id:parry:
        - cast REGENERATION duration:2 amplifier:3 no_icon <context.defender>