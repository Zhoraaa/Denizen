#Лисица | Агент Фокс
preparing_agentFox:
    type: world
    events:
        on player joins:
            - if !<player.has_flag[agentFox_name]>:
                - flag player agentFox_name:Лисица

agentFox_assign:
    type: assignment
    actions:
        on assignment:
            - trigger name:click state:true
            - trigger name:chat state:true cooldown:1s radius:50
    interact scripts:
        - agentFox_interact

agentFox_interact:
    type: interact
    steps:
        1:
            click trigger:
                script:
                        - random:
                            # - narrate '<&lt><player.flag[agentFox_name]><&gt> '
                            - narrate '<&lt><player.flag[agentFox_name]><&gt> Ваше гуманитарное пособие на сегодня.'
                            - narrate '<&lt><player.flag[agentFox_name]><&gt> Один набор на руки.'
                        - execute as_player 'reward'