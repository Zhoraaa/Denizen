# t.me/shlacokot
# Люблю вас всех!

# Основная логика воды, сучка

ColoredWater:
    type: entity
    entity_type: text_display
    mechanisms:
        text: <&sp><&sp><&sp>
        scale: 2.85,3.45,1
        translation: 0.45,-0.95,0
        background_color: 51,96,186,0

CauldronHandler:
    type: world
    debug: false
    water_level: 0.2|0.5628|0.752|0.938
    events:
        on tick:
        - foreach <server.flag[colorwater]||<list>> key:loc as:ent:
            - foreach next if:<[loc].chunk.is_loaded.not||true>
            - if <[loc].material.name.advanced_matches[cauldron|water_cauldron].not> or <[ent].is_spawned.not||true>:
                - remove <[ent]> if:<[ent].is_truthy||false>
                - flag server colorwater.<[loc]>:!
                - foreach next
            - if <[ent].location.equals[<[loc].above[<script.data_key[water_level].as[list].get[<[loc].material.level.add[1]||1>]||0>].with_pitch[-90]>].not>:
                - adjust <[ent]> teleport_duration:1t
                - teleport <[ent]> <[loc].above[<script.data_key[water_level].as[list].get[<[loc].material.level.add[1]||1>]||0>].with_pitch[-90]>
            - adjust <[ent]> background_color:51,96,186,0 if:<[loc].material.level.is_less_than[1].and[<[ent].background_color.rgb.equals[51,96,186].not>]||true>
        on cauldron|water_cauldron physics:
        - stop if:<server.has_flag[colorwater.<context.location>]||false>
        - spawn ColoredWater <context.location> save:ent
        - flag server colorwater.<context.location>:<entry[ent].spawned_entity>

# Логика перекрашивания

GradientProc:
    type: procedure
    debug: false
    definitions: item_in_hand
    script:
    - define item_in_hand <[item_in_hand]||<player.item_in_hand>>
    - define colors <[item_in_hand].flag[color].as[list]||nil>
    - determine <&gradient[from=<[colors].get[1]||<white>>;to=<[colors].get[2]||<[colors].get[1]||<white>>>]>

ColorHandler:
    type: world
    debug: false
    colors:
        white_dye: 255,255,255
        light_gray_dye: 203,203,203
        gray_dye: 139,139,139
        black_dye: 0,0,0
        red_dye: 255,0,0
        blue_dye: 0,0,255
        brown_dye: 170,95,0
        orange_dye: 255,120,0
        yellow_dye: 255,225,50
        lime_dye: 170,255,0
        green_dye: 0,255,0
        light_blue_dye: 0,170,255
        cyan_dye: 0,255,235
        purple_dye: 160,0,255
        magenta_dye: 220,0,255
        pink_dye: 255,80,190
    events:
        on player clicks !air in inventory with:brush:
        - stop if:<context.cursor_item.has_flag[color].not>
        - determine passively cancelled
        - inventory adjust slot:<context.slot> display:<proc[GradientProc].context[<context.cursor_item>]><context.item.display.strip_color||<script[TranslateConfig].data_key[ru_ru.<context.item.material.name||stone>]||член>>
        on player right clicks water_cauldron with:brush:
        - ratelimit <player> 2t
        - define item_in_hand <player.item_in_hand>
        - define loc <context.location>
        - define ent <server.flag[colorwater.<[loc]>]||null>
        - if <[ent].background_color.alpha.is_more_than[0]>:
            - stop if:<[item_in_hand].flag[color].size.is_more_than_or_equal_to[2].or[<[item_in_hand].flag[color].get[1].equals[<[ent].background_color>]||false>]||false>
            - determine passively cancelled
            - inventory flag slot:hand color:->:<[ent].background_color>
            - inventory adjust slot:hand "display:<proc[GradientProc]>Перекрашенная кисть"
            - playsound <[loc]> <player> sound:item.ink_sac.use
            - if <[loc].material.level.sub[1].is_more_than[0]>:
                - adjustblock <[loc]> level:<[loc].material.level.sub[1]>
            - else:
                - modifyblock <[loc]> cauldron
        - else if <[item_in_hand].has_flag[color]>:
            - determine passively cancelled
            - inventory flag slot:hand color:<-:<[item_in_hand].flag[color].last>
            - playsound <[loc]> <player> sound:entity.generic.splash
            - if <player.item_in_hand.flag[color].size.is_more_than[0]||false>:
                - inventory adjust slot:hand "display:<proc[GradientProc]>Перекрашенная кисть"
            - else:
                - inventory adjust slot:hand display:<&f>Кисть
                - inventory flag slot:hand color:!
        on player right clicks water_cauldron with:*dye:
        - define loc <context.location>
        - define ent <server.flag[colorwater.<[loc]>]||null>
        - stop if:<[loc].has_flag[recolor].or[<[ent].is_truthy.not>]||true>
        - playsound <player> sound:item.bottle.fill
        - flag <[loc]> recolor expire:1s
        - define data <map[new=<script.data_key[colors.<player.item_in_hand.material.name>].as[color]>;old=<[ent].background_color.rgb.as[color]>]>
        - define mix <[data.old].mix[<[data.new]>].with_alpha[130]>
        - drop <player.item_in_hand.material.name> <[loc].center.above[0.55]> speed:0 delay:9h save:ent
        - adjust <entry[ent].dropped_entity> force_no_persist:true
        - wait 7t
        - remove <entry[ent].dropped_entity>
        - playsound <[loc]> sound:entity.generic.splash
        - playeffect <[loc].center.below[0.35]> effect:SPLASH quantity:4 offset:0.085
        - playeffect <[loc].center.below[0.35]> effect:dust special_data:0.95|<[mix]> quantity:7 offset:0.15
        - adjust <[ent]> background_color:<[mix]>
        - flag <[loc]> recolor:!