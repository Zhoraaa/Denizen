# Робот-менеджер.
dualDungeonBot_assign:
    type: assignment
    actions:
        on assignment:
            - trigger name:click state:true
            - trigger name:chat state:true cooldown:1s radius:50
    interact scripts:
        - dualDungeonBot_interact

dualDungeonBot_interact:
    type: interact
    steps:
        1:
            click trigger:
                script: