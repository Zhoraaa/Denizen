vampire_ritual:
    type: world
    events:
        # Уничтожение ритуального блока
        on player breaks sculk_catalyst|sculk_shrieker|sculk_sensor location_flagged:ritual:
        - define heart <context.location.up[0.5].find_entities[item_display].within[1].first>
        - drop <context.location> <[heart].item> quantity:1 if:<player.gamemode.advanced_matches[!CREATIVE]>
        - remove <[heart]>
        - flag <context.location> ritual:!
        - flag <context.location> ritual_owner:! if:<context.location.has_flag[ritual_owner]>
        - flag <context.location> cooldown:! if:<context.location.has_flag[cooldown]>
        on sculk_catalyst|sculk_shrieker|sculk_sensor destroyed by explosion location_flagged:ritual:
        - flag <context.block> ritual:!
        - define heart <context.block.up[0.5].find_entities[item_display].within[1].first>
        - remove <[heart]>
        - drop <context.block> <[heart].item> quantity:1
        - flag <context.location> ritual_owner:! if:<context.location.has_flag[ritual_owner]>
        - flag <context.location> cooldown:! if:<context.location.has_flag[cooldown]>

        # Ритуал
        on player right clicks sculk_catalyst with:warden_heart:
        # 1 поместить сердце на катализатор
        - ratelimit <player> 1t
        - stop if:<player.gamemode.advanced_matches[SPECTATOR]>
        - stop if:<context.location.has_flag[ritual]>
        - flag <context.location> ritual:<element[<red>Нужна эссенция крови]>
        - define piedestal <context.location.center>
        - playeffect <[piedestal]> effect:TRIAL_SPAWNER_DETECT_PLAYER_OMINOUS offset:0
        - spawn ITEM_DISPLAY[item=<player.item_in_hand>] <[piedestal].up[0.53]> save:heart
        - take iteminhand if:<player.gamemode.advanced_matches[SURVIVAL|ADVENTURE]>
        - define heart <entry[heart].spawned_entity>
        - look <[heart]> pitch:90 yaw:<player.eye_location.yaw>
        - adjust <[heart]> <map[interpolation_start=0;interpolation_duration=2s]>
        - wait <[heart].interpolation_duration>
        #

        on player left clicks sculk_catalyst location_flagged:ritual|!cooldown:
        # Можно вырвать сердце в любой момент, но это прервёт ритуал
        - ratelimit <player> 1t
        - stop if:<player.gamemode.advanced_matches[SPECTATOR]>
        - define piedestal <context.location.center>
        - define heart <context.location.up[0.5].find_entities[item_display].within[1].first>
        - drop <[heart].location.backward[0.1]> <[heart].item>  quantity:1 if:<player.gamemode.advanced_matches[!CREATIVE]>
        - remove <[heart]>
        - flag <context.location> ritual:!

        on player right clicks block with:!blood_essence|blood_fire_essence|echo_shard location_flagged:ritual|!cooldown:
        - determine cancelled passively
        - actionbar targets:<player> <context.location.flag[ritual]>

        on player right clicks sculk_catalyst with:blood_essence location_flagged:ritual|!cooldown:
        - ratelimit <player> 1t
        - stop if:<player.gamemode.advanced_matches[SPECTATOR]>
        - stop if:<context.location.flag[ritual].equals[<element[<red>Нужна эссенция крови]>].not>

        - define piedestal <context.location.center>
        - define heart <context.location.up[0.5].find_entities[item_display].within[1].first>
        - flag <context.location> ritual:<element[<red>Нужен осколок тьмы]>
        - flag <context.location> cooldown:true expire:1m

        - definemap bottle_anim:
            interpolation_duration: 10t
            interpolation_start: 0t
            left_rotation: <location[0,0,1].to_axis_angle_quaternion[180]>

        - spawn ITEM_DISPLAY[item=<player.item_in_hand>] <[piedestal].up[1]> save:bottle
        - take iteminhand if:<player.gamemode.advanced_matches[SURVIVAL|ADVENTURE]>
        - define bottle <entry[bottle].spawned_entity>
        - look <[bottle]> yaw:<player.eye_location.yaw>
        - adjust <[bottle]> <[bottle_anim]>
        - take iteminhand if:<player.gamemode.advanced_matches[!CREATIVE]>
        - wait 10t

        - repeat 30:
            - playeffect effect:TRAIL at:<[heart].location.backward[0.5]> quantity:4 offset:0 special_data:[color=red;target=<[heart].location>;duration=10t]
            - wait 1t
        - adjust <[bottle]> item:glass_bottle
        - wait 1
        - remove <[bottle]>
        - give glass_bottle if:<player.gamemode.advanced_matches[!CREATIVE]>
        - playeffect effect:DUST_COLOR_TRANSITION at:<[heart].location.backward[0.3]> special_data:[size=1.2;from=red;to=<color[#29dce8]>] quantity:20 offset:0.3
        - flag <context.location> cooldown:!


        on player right clicks sculk_catalyst with:blood_fire_essence location_flagged:ritual|!cooldown:
        - ratelimit <player> 1t
        - stop if:<player.gamemode.advanced_matches[SPECTATOR]>
        - stop if:<context.location.flag[ritual].equals[<element[<red>Нужна эссенция крови]>].not>

        - define piedestal <context.location.center>
        - define heart <context.location.up[0.5].find_entities[item_display].within[1].first>
        - flag <context.location> cooldown:true expire:1m

        - definemap bottle_anim:
            interpolation_duration: 10t
            interpolation_start: 0t
            left_rotation: <location[0,0,1].to_axis_angle_quaternion[180]>

        - spawn ITEM_DISPLAY[item=<player.item_in_hand>] <[piedestal].up[1]> save:bottle
        - take iteminhand if:<player.gamemode.advanced_matches[SURVIVAL|ADVENTURE]>
        - define bottle <entry[bottle].spawned_entity>
        - look <[bottle]> yaw:<player.eye_location.yaw>
        - adjust <[bottle]> <[bottle_anim]>
        - take iteminhand if:<player.gamemode.advanced_matches[!CREATIVE]>
        - wait 10t

        - playeffect at:<[heart].location.backward[0.5]> effect:DUST quantity:10 offset:0
        - repeat 30:
            - playeffect effect:TRAIL at:<[heart].location.backward[0.5]> quantity:4 offset:0 special_data:[color=<color[#c37e00]>;target=<[heart].location>;duration=10t]
            - wait 1t
        - adjust <[bottle]> item:glass_bottle
        - wait 1
        - remove <[bottle]>
        - give glass_bottle if:<player.gamemode.advanced_matches[!CREATIVE]>
        - playeffect effect:lava at:<[heart].location.backward[0.3]> quantity:20 offset:0.3
        - remove <[heart]>
        - flag <context.location> cooldown:!
        - flag <context.location> ritual:!

        on player right clicks sculk_catalyst with:echo_shard location_flagged:ritual|!cooldown:
        - ratelimit <player> 1t
        - stop if:<player.gamemode.advanced_matches[SPECTATOR]>
        - stop if:<context.location.flag[ritual].equals[<element[<red>Нужен осколок тьмы]>].not>

        - define piedestal <context.location.center>
        - define heart <context.location.up[0.5].find_entities[item_display].within[1].first>
        - flag <context.location> cooldown:true expire:1m

        - playeffect effect:trial_spawner_become_ominous at:<[piedestal]> quantity:1 offset:0
        # - playeffect effect:DUST_COLOR_TRANSITION at:<[heart].location.backward[0.3]> special_data:[size=1.2;from=red;to=<color[#29dce8]>] quantity:20 offset:0.3

        - remove <[heart]>
        - modifyblock <context.location> sculk_sensor

        - take iteminhand if:<player.gamemode.advanced_matches[!CREATIVE]>
        - flag <context.location> cooldown:!
        - flag <context.location> ritual:<element[<red>Разверзни небеса]>
        - flag <context.location> ritual_owner:<player>

        on player dies flagged:infected:
        - determine cancelled passively if:true
        - define loop_index 0
        - repeat 20:
            - define loop_index:++
            - playsound <player.location> sound:entity.warden.heartbeat pitch:<element[2].sub[<[loop_index].sub[5].div[10]>]>
            - wait <[loop_index].add[4]>t

        on lightning strikes:
        - define locs <list[<context.location.down[1]>|<context.location>|<context.location.up[1]>]>
        - foreach <[locs]> as:y:
            - define points <[y].proc[search_ritual]>
            - foreach <[points]> as:p:
                - if <[p].has_flag[ritual]>:
                    - definemap context:
                        location: <[p]>
                        ritual_stage: <[p].flag[ritual]>
                        player: <[p].flag[ritual_owner]>
                    - customevent id:ritual_bolted context:<[context]>
                    - flag <[p]> ritual_owner:!

        on custom event id:ritual_bolted:
        - stop if:<context.ritual_stage.equals[<red>Разверзни небеса].not>
        - stop if:<context.ritual.material.name.equals[sculk_sensor].not>
        - define piedestal <context.location.center>
        - playeffect effect:trial_spawner_become_ominous at:<[piedestal]> quantity:1 offset:0
        - modifyblock <[piedestal]> sculk_shrieker
        - flag <context.player> vampire:<[piedestal]>
        - flag <[piedestal]> piedestal_owner:<context.player>
        - flag <[piedestal]> ritual:!

search_ritual:
    type: procedure
    definitions: loc
    script:
        - define locs <list[]>
        - define locs:->:<[loc]> if:<[loc].has_flag[ritual]>
        - foreach <[loc].points_around_y[points=8;radius=1]> as:p:
            - define locs:->:<[p]> if:<[p].has_flag[ritual]>
        - determine <[locs]>