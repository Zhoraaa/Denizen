warden_heart:
    type: item
    material: fermented_spider_eye
    display name: <dark_purple>Прокажённое сердце

wardenheart:
    type: world
    events:
        # Уничтожение ритуального каталиста
        on player breaks sculk_catalyst:
        - stop if:<context.location.has_flag[ritual].not>
        - define heart <context.location.up[0.5].find_entities[item_display].within[1].first>
        - drop <context.location> <[heart].item> quantity:1 if:<player.gamemode.advanced_matches[!CREATIVE]>
        - remove <[heart]>
        - flag <context.location> ritual:!
        - flag <context.location> cooldown:! if:<context.location.has_flag[cooldown]>
        on sculk_catalyst destroyed by explosion:
        - if <context.block.has_flag[ritual]>:
            - flag <context.block> ritual:!
            - define heart <context.block.up[0.5].find_entities[item_display].within[1].first>
            - remove <[heart]>
            - drop <context.block> <[heart].item> quantity:1
        - flag <context.location> cooldown:! if:<context.location.has_flag[cooldown]>

        # Сердце вардена
        on warden dies:
        - drop warden_heart <context.entity.location>

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

        on player left clicks sculk_catalyst with:air:
        # Можно вырвать сердце в любой момент, но это прервёт ритуал
        - ratelimit <player> 1t
        - stop if:<context.location.has_flag[ritual].not>
        - stop if:<context.location.has_flag[cooldown]>
        - stop if:<player.gamemode.advanced_matches[SPECTATOR]>
        - define piedestal <context.location.center>
        - define heart <context.location.up[0.5].find_entities[item_display].within[1].first>
        - give <[heart].item> if:<player.gamemode.advanced_matches[!CREATIVE]> quantity:1
        - remove <[heart]>
        - flag <context.location> ritual:!

        on player right clicks sculk_catalyst with:!blood_essence|echo_shard:
        - stop if:<context.location.has_flag[cooldown]>
        - stop if:<context.location.has_flag[ritual].not>
        - actionbar targets:<player> <context.location.flag[ritual]>

        on player right clicks sculk_catalyst with:blood_essence:
        - ratelimit <player> 1t
        - stop if:<player.gamemode.advanced_matches[SPECTATOR]>
        - stop if:<context.location.has_flag[ritual].not>
        - stop if:<context.location.has_flag[cooldown]>
        - stop if:<context.location.flag[ritual]>

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
        - announce <[bottle].display>
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

        on player right clicks sculk_catalyst with:echo_shard:
        - ratelimit <player> 1t
        - stop if:<player.gamemode.advanced_matches[SPECTATOR]>
        - stop if:<context.location.has_flag[ritual].not>
        - stop if:<context.location.has_flag[cooldown]>
        - stop if:<context.location.flag[ritual].equals[<element[<red>Нужен осколок тьмы]>].not>

        - define piedestal <context.location.center>
        - define heart <context.location.up[0.5].find_entities[item_display].within[1].first>
        - flag <context.location> cooldown:true expire:1m

        - playeffect effect:trial_spawner_become_ominous at:<[heart].location.backward[0.3]> quantity:1 offset:0
        # - playeffect effect:DUST_COLOR_TRANSITION at:<[heart].location.backward[0.3]> special_data:[size=1.2;from=red;to=<color[#29dce8]>] quantity:20 offset:0.3

        - take iteminhand if:<player.gamemode.advanced_matches[!CREATIVE]>
        - flag <context.location> cooldown:!

        on player dies flagged:infected:
        - determine cancelled passively if:true
        - define loop_index 0
        - repeat 20:
            - define loop_index:++
            - playsound <player.location> sound:entity.warden.heartbeat pitch:<element[2].sub[<[loop_index].sub[5].div[10]>]>
            - wait <[loop_index].add[4]>t