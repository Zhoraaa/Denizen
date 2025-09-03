#Художница | Эльстер
preparing_artist:
    type: world
    events:
        on player joins:
            - if !<player.has_flag[artist_name]>:
                - flag player artist_name:Художница

artist_assign:
    type: assignment
    actions:
        on assignment:
            - trigger name:click state:true
            - trigger name:chat state:true cooldown:1s radius:50
    interact scripts:
        - artist_interact

artist_interact:
    type: interact
    steps:
        1:
            click trigger:
                script:
                    - random:
                        - narrate '<&lt><player.flag[artist_name]><&gt> Так епта бля... если свет теплый то тень холодная хуё-мое, но блять если тут полутон, то блять рефлекс получается темнее тааааак блять падажжи ебана.....'
                        - narrate '<&lt><player.flag[artist_name]><&gt> Сколько я не спал?'
                        - narrate '<&lt><player.flag[artist_name]><&gt> Блять. Завтра просмотр...'
                        - narrate '<&lt><player.flag[artist_name]><&gt> Блять. Меня заменит нейросеть...'
                        - narrate '<&lt><player.flag[artist_name]><&gt> Хр-р-р... Тень холодная...'
                        - narrate '<&lt><player.flag[artist_name]><&gt> Хр-р-р... Анатомию учить...'
                        - narrate '<&lt><player.flag[artist_name]><&gt> Я съел четыре кило акрила.'
                        - narrate '<&lt><player.flag[artist_name]><&gt> Я выпил банку растворителя.'
                        - narrate '<&lt><player.flag[artist_name]><&gt> Акварель, к слову, сладкая.'
                        - narrate '<&lt><player.flag[artist_name]><&gt> Моё любимое лакомство - медовая акварель.'
                    - execute as_player 'artmap'

#
academ_artist_assign:
    type: assignment
    actions:
        on assignment:
        - trigger name:click state:true
        - trigger name:chat state:true cooldown:1s radius:50
    interact scripts:
        - academ_artist_interact

academ_artist_interact:
    type: interact
    steps:
        1:
            click trigger:
                script:
                    - define req <player.item_in_hand.display.advanced_matches[*кофе*].and[<player.item_in_hand.proc[is_brew]>]||false>
                    - if <[req]>:
                        - if <player.has_flag[coffee_cd].not>:
                            - take from:<player.item_in_hand> if:<[req]>
                            - define msg "Ого, спасибо...|Держи, заслуженно :3"
                            - ~run dialogue path:talk def.text:<list[<[msg]>]> def.target:<npc>
                            - run ap_bal_add def:10|<player>
                            - flag <player> coffee_cd:true expire:15m
                        - else:
                            - define msg "Ого...|Я ценю твою заботу, но мне слишком много нельзя...|Пульс скачет."
                            - ~run dialogue path:talk def.text:<list[<[msg]>]> def.target:<npc>

                    - else:
                        - random:
                            - define msg "Что хотел?"
                            - define msg "Ммм... И на что я только потратила 4 года своей жизни..."
                            - define msg "Если сделаешь мне кофе, я тебе просто так могу балл нарисовать, что думаешь?"
                            - define msg "Носить такую одежду в такую жару... Просто издевательство..."
                        - ~run dialogue path:talk def.text:<list[<[msg]>]> def.target:<npc>
                        - run dialogue def:academ_artist|<npc>|<player>