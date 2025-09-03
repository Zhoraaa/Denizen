# Рана
rana_assign:
    type: assignment
    actions:
        on assignment:
            - trigger name:click state:true
    interact scripts:
        - rana_interact

rana_interact:
    type: interact
    steps:
        1:
            click trigger:
                script:
                    - run dialogue def:hub_rana|<npc>|<player>

# Квест на пиво
beer_4_rana:
    type: task
    script:
    - zap brewer_interact beer_4_rana

# Повариха
academ_rana_assign:
    type: assignment
    actions:
        on assignment:
        - trigger name:click state:true
        - trigger name:chat state:true cooldown:1s radius:50
    interact scripts:
        - academ_rana_interact


academ_rana_interact:
    type: interact
    steps:
        1:
            click trigger:
                script:
                - random:
                    - define msg "Привет, что брать будешь?"
                    - define msg "Ха-ха, странно что я работаю здесь, да?"
                    - define msg "Все самое свежее, покупай, не стесняйся."
                - ~run dialogue path:talk def.text:<list[<[msg]>]> def.target:<npc>
                - run dialogue def:academ_rana|<npc>|<player>
#
shop_rana:
    type: task
    definitions: npc|__player
    script:
    - execute as_op "shop Столовая"