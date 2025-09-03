#Пёс-стражник | Пёс Посерединке
preparing_doge:
    type: world
    events:
        on player joins:
            - if !<player.has_flag[doge_name]>:
                - flag player doge_name:Пёс-стражник

doge_assign:
    type: assignment
    actions:
        on assignment:
            - trigger name:click state:true
            - trigger name:chat state:true cooldown:1s radius:50
    interact scripts:
        - doge_interact

doge_interact:
    type: interact
    steps:
        1:
            click trigger:
                script:
                - if <player.item_in_hand.material.name> == shield:
                    - narrate '<&lt><player.flag[doge_name]><&gt> Ву-у-уф??? (Это мне??? *виляет хвостом*)'
                    - playsound <player> sound:entity_wolf_ambient sound:1 pitch:1.6
                    - wait 2s
                    - narrate '<&lt><player.flag[doge_name]><&gt> Спасибо, но я не могу его принять... Это твой щит!'
                - else if <player.item_in_offhand.material.name> == shield:
                    - narrate '<&lt><player.flag[doge_name]><&gt> *Одышка* (О, прикольный щит!)'
                    - playsound <player> sound:entity_wolf_pant sound:1 pitch:0.8
                    - wait 2s
                    - narrate '<&lt><player.flag[doge_name]><&gt> *Скулит* (Эх, когда-то и у меня был щит...)'
                    - playsound <player> sound:entity_wolf_whine sound:1 pitch:0.8
                - else if <player.item_in_offhand.material.name> == bone:
                    - narrate '<&lt><player.flag[doge_name]><&gt> Ву-у-уф??? (Это мне??? *виляет хвостом*)'
                    - playsound <player> sound:entity_wolf_ambient sound:1 pitch:1.6
                    - wait 2s
                    - narrate '<&lt><player.flag[doge_name]><&gt> Аваф! Вуф-вуф!!! (Спасибо, большое! Вот, возьми взамен! Тут такого добра много!)'
                    - give clay
                - else:
                    - random:
                        - narrate '<&lt><player.flag[doge_name]><&gt> Вуф (День добрый)'
                        - narrate '<&lt><player.flag[doge_name]><&gt> Грр-вуф (Не воняй тут)'
                        - narrate '<&lt><player.flag[doge_name]><&gt> Вуф-вуф! (Какой хороший сегодня день!)'
                        - narrate '<&lt><player.flag[doge_name]><&gt> Вууаф~ (*зевок*)'
                        - narrate '<&lt><player.flag[doge_name]><&gt> Аваф? (Чего такое?)'
                        - narrate '<&lt><player.flag[doge_name]><&gt> Скуби-ду?'
                        - narrate '<&lt><player.flag[doge_name]><&gt> Гр-р-р... Р-рав! (Вонючий гоблин куда-то спрятался... Мерзость!)'
                        - narrate '<&lt><player.flag[doge_name]><&gt> Вуф вуф-афав грр... (Не люблю рыб, они громко кричат)'
                        - narrate '<&lt><player.flag[doge_name]><&gt> Фу-фуф... (Щас бы костей пожевать)'
                        - narrate '<&lt><player.flag[doge_name]><&gt> Грррак! (Этот плохой мальчик Водим стырил мой щит! Как не стыдно!)'
                        # - narrate '<&lt><player.flag[doge_name]><&gt> '
                    - playsound <player> sound:entity_wolf_ambient sound:1 pitch:0.8