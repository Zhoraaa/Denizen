rideable_sniffers:
    type: world
    events:
    # Повесить на сниффера седло
        on player right clicks sniffer with:saddle:
        - ratelimit <player> 1t
        - if !<context.entity.has_flag[rideable]>:
            - flag <context.entity> rideable:true
            - take item:saddle from:<player.inventory> quantity:1
            - playsound <context.entity.location> sound:entity.horse.armor pitch:0.7 volume:0.6
    # Снять со сниффера седло
        on player right clicks sniffer with:shears:
        - ratelimit <player> 1t
        - if <context.entity.has_flag[rideable]>:
            - flag <context.entity> rideable:!
            - drop saddle <context.entity.location>
            - playsound <context.entity.location> sound:entity.sheep.shear pitch:0.7 volume:0.6
    # Сесть на сниффера
        on player right clicks sniffer with:air:
        - ratelimit <player> 4t
        - if <context.entity.has_flag[rideable]>:
            - mount <player>|<context.entity>
        - else:
            - actionbar targets:<player> "<gray>Мне нужно седло..."