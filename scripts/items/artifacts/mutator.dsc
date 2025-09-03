mutate_item_map:
    type: data
    items:
        # Кровь
        bottle_o_blood_fire: blood_fire_essence
        blood_fire_essence: bottle_o_blood_fire
        bottle_o_blood: blood_essence
        blood_essence: bottle_o_blood
        infected_slime: infected_slime_extract
        infected_slime_extract: infected_slime
        # Вольгран
        netherite_scrap: wolgran_shard
        netherite_ingot: wolgran_ingot
        wolgran_shard: netherite_scrap
        wolgran_ingot: netherite_ingot
        # Камни
        end_stone: cobbled_deepsslate
        cobbled_deepsslate: end_stone
        stone: netherrack
        netherrack: stone
        cobblestone: blackstone
        blackstone: cobblestone
        # Нилий
        crimson_nylium: warped_nylium
        warped_nylium: crimson_nylium
        crimson_fungus: warped_fungus
        warped_fungus: crimson_fungus
        crimson_stem: warped_stem
        warped_stem: crimson_stem
        weeping_vines: warped_vines
        warped_vines: weeping_vines
        crimson_roots: warped_roots
        warped_roots: crimson_roots
        nether_wart_block: warped_wart_block
        warped_wart_block: nether_wart_block
        # Уголь
        coal: charcoal
        charcoal: coal
        # Чернильные мешки
        ink_sac: glow_ink_sac
        glow_ink_sac: ink_sac
        # Душный огонь
        lantern: soul_lantern
        soul_lantern: lantern
        torch: soul_torch
        soul_torch: torch
        campfire: soul_campfire
        soul_campfire: campfire
        # Душная земля
        soul_sand: soul_soil
        soul_soil: soul_sand
        # Дёрн
        grass_block: mycelium
        mycelium: grass_block
        # Песочик
        sand: red_sand
        red_sand: sand
        sandstone: red_sandstone
        red_sandstone: sandstone
        cut_sandstone: cut_red_sandstone
        cut_red_sandstone: cut_sandstone
        chiseled_sandstone: chiseled_red_sandstone
        chiseled_red_sandstone: chiseled_sandstone
        # Грибочке
        brown_mushroom: red_mushroom
        red_mushroom: brown_mushroom
        brown_mushroom_block: red_mushroom_block
        red_mushroom_block: brown_mushroom_block
        # Сьнежокь
        water_bucket: powder_snow_bucket
        powder_snow_bucket: water_bucket
        # Палки
        blaze_rod: breeze_rod
        breeze_rod: blaze_rod
        # Жабисветы
        ochre_froglight: verdant_froglight
        verdant_froglight: pearlescent_froglight
        pearlescent_froglight: ochre_froglight
        # Аметист-кварц
        amethyst_shard: quartz
        quartz: amethyst_shard
        amethyst_block: quartz_block
        quartz_block: amethyst_block
        # Кальций
        bone_block: calcite
        calcite: bone_block
        # Железо/Медь
        raw_copper: raw_iron
        raw_iron: raw_copper
        raw_copper_block: raw_iron_block
        raw_iron_block: raw_copper_block
        copper_ingot: iron_ingot
        iron_ingot: copper_ingot
        copper_block: iron_block
        iron_block: copper_block
        # Призмарин (Точка входа - армадилды)
        armadillo_scute: prismarine_shard
        prismarine_shard: prismarine_crystals
        prismarine_crystals: prismarine_shard
        # Обсидиан
        obsidian: crying_obsidian
        crying_obsidian: obsidian
        # Стекло
        glass: sand
        tinted_glass: glass
        white_stained_glass: glass
        light_gray_stained_glass: glass
        gray_stained_glass: glass
        black_stained_glass: glass
        brown_stained_glass: glass
        red_stained_glass: glass
        orange_stained_glass: glass
        yellow_stained_glass: glass
        lime_stained_glass: glass
        green_stained_glass: glass
        cyan_stained_glass: glass
        light_blue_stained_glass: glass
        blue_stained_glass: glass
        purple_stained_glass: glass
        magenta_stained_glass: glass
        pink_stained_glass: glass
        # Стеклопанели
        white_stained_glass_pane: glass_pane
        light_gray_stained_glass_pane: glass_pane
        gray_stained_glass_pane: glass_pane
        black_stained_glass_pane: glass_pane
        brown_stained_glass_pane: glass_pane
        red_stained_glass_pane: glass_pane
        orange_stained_glass_pane: glass_pane
        yellow_stained_glass_pane: glass_pane
        lime_stained_glass_pane: glass_pane
        green_stained_glass_pane: glass_pane
        cyan_stained_glass_pane: glass_pane
        light_blue_stained_glass_pane: glass_pane
        blue_stained_glass_pane: glass_pane
        purple_stained_glass_pane: glass_pane
        magenta_stained_glass_pane: glass_pane
        pink_stained_glass_pane: glass_pane
        # Семена
        wheat_seeds: pumpkin_seeds
        pumpkin_seeds: melon_seeds
        melon_seeds: cocoa_beans
        cocoa_beans: beetroot_seeds
        beetroot_seeds: wheat_seeds
        # Слизь
        slime_ball: magma_cream
        magma_cream: slime_ball
        # Икспа/дурной знак
        experience_bottle: ominous_bottle
        ominous_bottle: experience_bottle
        # Редстоун/Глоустоун
        redstone: glowstone_dust
        glowstone_dust: redstone
        redstone_block: glowstone
        glowstone: redstone_block
        # Гнилая плоть
        rotten_flesh: leather
        # Редстоун механизмы
        comporator: repeater
        repeater: comporator
        sculk_sensor: daylight_detector
        daylight_detector: sculk_sensor
        # Ягади
        sweet_berries: glow_berries
        glow_berries: sweet_berries
        # Глиноснег
        clay_ball: snowball
        snowball: clay_ball
        clay: snow_block
        snow_block: clay
        # Лёд
        ice: packed_ice
        packed_ice: blue_ice
        blue_ice: ice
        # Саженцы
        oak_sapling: spruce_sapling
        spruce_sapling: birch_sapling
        birch_sapling: jungle_sapling
        jungle_sapling: acacia_sapling
        acacia_sapling: dark_oak_sapling
        dark_oak_sapling: oak_sapling

mutate_mob_map:
    type: data
    mobs:
        SLIME: MAGMA_CUBE[size=1]
        MAGMA_CUBE: SLIME[size=1]
        SKELETON_HORSE: HORSE
        SPIDER: CAVE_SPIDER
        SKELETON: STRAY
        STRAY: BOGGED
        BOGGED: SKELETON
        ALLAY: VEX
        VEX: ALLAY
        VILLAGER: WANDERING_TRADER
        WANDERING_TRADER: VILLAGER
        LLAMA: TRADER_LLAMA
        TRADER_LLAMA: LLAMA
        SQUID: GLOW_SQUID
        GLOW_SQUID: SQUID
        POLAR_BEAR: PANDA
        PANDA: POLAR_BEAR
        WITCH: EVOKER
        EVOKER: WITCH
        PIG: HOGLIN[immune=true]
        HOGLIN: PIGLIN[immune=true]
        PIGLIN: PIG
        CHICKEN: PARROT
        PARROT: CHICKEN
        CAT: OCELOT
        OCELOT: CAT
        COW: MOOSHROOM
        MOOSHROOM: COW
        ZOMBIE: HUSK
        HUSK: DROWNED
        DROWNED: ZOMBIE
        HORSE: CAMEL
        CAMEL: HORSE
        FROG: RABBIT
        RABBIT: FROG
        BREEZE: BLAZE
        BLAZE: BREEZE
        SNIFFER: ARMADILLO
        ARMADILLO: SNIFFER
        PUFFERFISH: GUARDIAN
        GUARDIAN: ELDER_GUARDIAN

mutate_item:
    type: item
    display name: <aqua>Развратитель
    material: heart_of_the_sea
    lore:
        - <gray>Использование<&co>
        - <blue>Кликните ПКМ по предмету,
        - <blue>держа его в инвентаре.
        - <blue>Или кликните им по мобу.
        - <gray>Эффект<&co>
        - <blue>Предмет или моб изменятся.
        - <blue>Взамен вы потратите опыт.
        - <green>Необычный
    mechanisms:
        components_patch: <map[minecraft:max_stack_size=int:1]>
    recipes:
        1:
            type: shaped
            recipe_id: wolgran_ingot_from_nugget
            group: wolgran
            input:
                - echo_shard|wolgran_ingot|echo_shard
                - wolgran_shard|heart_of_the_sea|wolgran_shard
                - echo_shard|wolgran_ingot|echo_shard

mutate_events:
    type: world
    debug: false

    events:
        on player clicks !air in inventory with:mutate_item:
        - ratelimit <player> 1t
        - stop if:<player.gamemode.equals[CREATIVE]>
        - determine cancelled passively
        - define item_map <script[mutate_item_map]>
        - define cost 10
        #
        - define mutatable false
        - define mutatable true if:<[item_map].data_key[items].contains[<context.item.script.name||<context.item.material.name>>]>
        #
        - if <[mutatable]>:
            - if <player.xp_level> >= 1:
                - actionbar '<green>Предмет(ы) успешно изменен(ы)'
                - playsound <player.eye_location> sound:block.note_block.chime
                - playeffect <player.eye_location> effect:NOTE offset:0
                #
                - take from:<context.clicked_inventory> slot:<context.slot> quantity:<context.item.quantity>
                - give <[item_map].data_key[items.<context.item.script.name||<context.item.material.name>>]> to:<context.clicked_inventory> slot:<context.slot> quantity:<context.item.quantity>
                - experience take <[cost]>
            - else:
                - actionbar '<red>Недостаточно опыта, нужен минмум 1 уровень'
                - playsound <player.eye_location> sound:block.wet_sponge.dries sound:0.1 pitch:1.8
        - else:
            - actionbar '<red>Этот предмет не во что мутировать'
            - playsound <player.eye_location> sound:block.wet_sponge.dries sound:0.1 pitch:1.8

        on player right clicks entity with:mutate_item:
        - ratelimit <player> 1t
        - define mob_map <script[mutate_mob_map]>
        - determine cancelled passively
        - if <[mob_map].data_key[mobs].contains[<context.entity.entity_type>]> || <context.entity.entity_type.equals[PLAYER]>:
            - define cost 20
            - if <player.xp_level> >= 2 || <player.gamemode.equals[CREATIVE]>:
                - actionbar '<green>Моб успешно изменён'
                - playsound <context.entity.eye_location> sound:block.note_block.chime
                - playeffect <context.entity.eye_location.add[0,-0.5,0]> effect:NOTE offset:0
                - if <context.entity.entity_type.equals[PLAYER]>:
                    - actionbar '<red>Ну и что я по-твоему должен сделать?'
                    - wait 3s
                    - playsound <context.entity.eye_location> sound:block.note_block.chime
                    - playeffect <context.entity.eye_location.add[0,-0.5,0]> effect:NOTE offset:0
                    - actionbar '<red>Ну пусть будет это.'
                    - adjust <context.entity> gravity:false
                    - wait 10s
                    - playsound <context.entity.eye_location> sound:block.note_block.xylophone
                    - playeffect <context.entity.eye_location.add[0,-0.5,0]> effect:NOTE offset:0
                    - actionbar targets:<player>|<context.entity> <red>Ой...
                    - adjust <context.entity> gravity:true
                - else:
                    - spawn <[mob_map].data_key[mobs.<context.entity.entity_type>]>[custom_name=<context.entity.custom_name||<empty>>] <context.entity.location>
                    - remove <context.entity>
                - experience take <[cost]>
            - else:
                - actionbar '<red>Недостаточно опыта, нужно минимум 2 уровня'
                - playsound <player.eye_location> sound:block.wet_sponge.dries sound:0.1 pitch:1.8
        - else:
            - actionbar '<red>Этого моба не изменить'
            - playsound <player.eye_location> sound:block.wet_sponge.dries sound:0.1 pitch:1.8