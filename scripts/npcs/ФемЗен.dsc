# Медсестра
academ_femzen_assign:
    type: assignment
    actions:
        on assignment:
        - trigger name:click state:true
        - trigger name:chat state:true cooldown:1s radius:50
    interact scripts:
        - academ_femzen_interact


academ_femzen_interact:
    type: interact
    steps:
        1:
            click trigger:
                script:
                - random:
                    - define msg "Не тычь в меня."
                    - define msg "Не дам."
                    - define msg "Не задумывался почему лимузины внезапно исчезли?"
                    - define msg "У меня точно стопроцентно есть медицинское образование"
                - ~run dialogue path:talk def.text:<list[<[msg]>]> def.target:<npc>
                - run dialogue def:academ_femzen|<npc>|<player>