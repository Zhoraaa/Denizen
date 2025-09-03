#Джентльмен | Шляпник
preparing_shlpstr:
    type: world
    events:
        on player joins flagged:shlpstr_name:
            - flag player shlpstr_name:!

shlpstr_assign:
    type: assignment
    actions:
        on assignment:
            - trigger name:click state:true
            - trigger name:chat state:true cooldown:1s radius:50
    interact scripts:
        - shlpstr_interact

shlpstr_interact:
    type: interact
    steps:
        1:
            click trigger:
                script:
                    - run dialogue def:hub_shlpstr|<npc>|<player>

shlpstr_tip:
    type: task
    definitions: npc|__player
    script:
        - if <player.inventory.contains_item[gold_nugget]>:
            - wait 1t
            - run dialogue def:shlpstr_tips_list|<[npc]>|<player>
            - take from:<player.inventory> item:GOLD_NUGGET quantity:1
        - else:
            - run Dialogue path:talk def.text:<list[За информацию придётся заплатить.|Один вопрос - один золотой самородок.]> def.target:<npc>
            - wait 3
            - run dialogue def:hub_shlpstr|<[npc]>|<player>

#
academ_shlpstr_assign:
    type: assignment
    actions:
        on assignment:
        - trigger name:click state:true
        - trigger name:chat state:true cooldown:1s radius:50
    interact scripts:
        - academ_shlpstr_interact

academ_shlpstr_interact:
    type: interact
    steps:
        1:
            click trigger:
                script:
                    - random:
                        - define msg "Здравствуйте! Я автоно..- ээ? Чет в глазах резко потемнело..."
                        - define msg ...
                        - define msg "Не дыши возле меня так громко."
                        - define msg "В молодости я увлекался гитарами."
                        - define msg "Вот бы управлять экономикой целой страны..."
                    - ~run dialogue path:talk def.text:<list[<[msg]>]> def.target:<npc>
                    - run dialogue def:academ_shlpstr|<npc>|<player>