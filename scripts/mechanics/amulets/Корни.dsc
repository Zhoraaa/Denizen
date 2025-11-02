amulet_of_roots:
    type: item
    material: rabbit_foot
    display name: <&6>Корни
    lore:
    - <&b>₪ Утилитарный амулет
    - <&7><italic>Восполняет <&6>сытость <&7><italic>при хождении
    - <&7><italic>по <&a>мшистым <&7><italic>и <&a>земляным <&7><italic>блокам
    mechanisms:
        components_patch: <map[minecraft:max_stack_size=int:1]>

feed_from_amulet:
    # debug: false
    type: world
    events:
        on player steps on grass_block|podzol|mycelium|*dirt*|clay|mud|*moss* flagged:root_feeding chance:5:
        - stop if:<player.saturation.is_less_than[20].not>
        - playsound <player.location> sound:entity.generic.eat pitch:1.4 volume:0.4
        - feed <player> amount:1 saturation:1