#Лисёнок | Агент Фокс Младший
preparing_agentMiniFox:
    type: world
    events:
        on player joins:
            - if !<player.has_flag[agentMiniFox_name]>:
                - flag player agentMiniFox_name:Лисёнок

agentMiniFox_assign:
    type: assignment
    actions:
        on assignment:
            - trigger name:click state:true
            - trigger name:chat state:true cooldown:1s radius:50
    interact scripts:
        - agentMiniFox_interact

agentMiniFox_interact:
    type: interact
    steps:
        1:
            click trigger:
                script:
                    - random:
                        - define msg 'Капитализм победил.'
                        - define msg 'Благодарим за покровительство.'
                        - define msg 'Ваша награда!'
                    - ~run dialogue path:talk def.text:<list[<[msg]>]> def.target:<npc>
                    - run dialogue def:agent_minifox|<npc>|<player>
#
academ_swap:
    type: task
    definitions: npc|__player
    script:
    - if <player.location.world.name.equals[academia]>:
        - teleport <player> <server.flag[academ_exit]>
    - else:
        - teleport <player> <server.flag[academ_entry]>
#
mecreward:
    type: task
    definitions: npc|__player
    script:
        - execute as_player 'mecreward'
# 
# race_dis_en:
#     type: world
#     definitions: npc|__player
#     events:
#         on player changes world:
#         - if <context.destination_world.name.advanced_matches[academia]>:
#             - execute as_server silent "origin set <player.name> origin human"
#         - else <context.origin_world.name.advanced_matches[academia]>:
#             - if <player.flag[origin_marker].is_truthy>:
#                 - execute as_op silent "origin set <player.name> origin <player.flag[origin_marker]>"
#             - else:
#                 - teleport <player> <server.flag[origin_select]>
#                 - execute as_player silent "warp <player.name> origin_select"
#                 - narrate <player> "<red>Похоже кто-то тут не проходил ивент `Командная работа`. Или я просто ебло. Выбери снова расу пжлст и сообщи мне"