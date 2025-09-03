
#
# Мировые скрипты
#

# Болезнь
disease:
    type: world
    debug: false
    bloodless: <map[GOLEM|ALLAY|SLIME|MAGMA_CUBE|PHANTOM|ITEM_FRAME|ARMOR_STAND|ZOMBIE|SKELETON|HUSK|DROWNED|AREA_EFFECT_CLOUD|ALLAY|ACACIA_CHEST_BOAT|ACACIA_BOAT|BIRCH_CHEST_BOAT|BIRCH_BOAT|CHERRY_CHEST_BOAT|CHERRY_BOAT|DARK_OAK_CHEST_BOAT|DARK_OAK_BOAT|JUNGLE_CHEST_BOAT|JUNGLE_BOAT|MANGROVE_CHEST_BOAT|MANGROVE_BOAT|OAK_CHEST_BOAT|OAK_BOAT|PALE_OAK_CHEST_BOAT|PALE_OAK_BOAT|SPRUCE_CHEST_BOAT|SPRUCE_BOAT|BAMBOO_CHEST_RAFT|BAMBOO_RAFT|BLAZE|BREEZE|CREEPER|EVOKER_FANGS|PAINTING|ZOMBIFIED|STRAY|INTERACTION]>
    events:
    # Случайные события для заражённых раз в 1 минуту
        on delta time minutely chance:2:
            - foreach <server.online_players_flagged[infected]> as:__player:
                - run minor_diseasing
                - define rand_disease_event <util.random.int[1].to[100]>
                # Кашель 25%
                - if <[rand_disease_event]> > 1 && <[rand_disease_event]> <= 25:
                    - playsound <player.eye_location> sound:entity.camel.hurt sound_category:master volume:0.6 pitch:2
                # Чих 25%
                - else if <[rand_disease_event]> > 25 && <[rand_disease_event]> <= 50:
                    - run achoo
                # Голод 20%
                - else if <[rand_disease_event]> > 50 && <[rand_disease_event]> <= 75 && <player.flag[disease_stage]> >= 2:
                    - run blood_hunger
                # Фантомные звуки 15%
                - else if <[rand_disease_event]> > 75 && <[rand_disease_event]> <= 90:
                    - random:
                        - playsound <player> sound:entity_enderian_ambient sound_category:master volume:0.3 pitch:2
                        - playsound <player> sound:entity_spider_step sound_category:master volume:0.3 pitch:0.2
                        - playsound <player> sound:entity_creeper_primed sound_category:master volume:1 pitch:1
                # Зрение хуёвит 10%
                - else if <[rand_disease_event]> > 90 && <[rand_disease_event]> <= 100:
                    - actionbar '<dark_red>Перед глазами всё плывёт...'
                    - cast confusion duration:5s amplifier:0 no_icon hide_particles

    # Плохо после возрождения
        after player respawns at bed:
            - run hp_reload def:<player>
            - if <player.has_flag[infected]> && <util.random_chance[<player.flag[disease_stage].mul[5]>]>:
                - actionbar '<dark_red>...'
                - cast darkness duration:10s amplifier:2 no_icon hide_particles
                - cast confusion duration:10s amplifier:2 no_icon hide_particles
                - cast slow duration:10s amplifier:2 no_icon hide_particles
                - if <util.random_chance[5]>:
                    - run blood_hunger
                    - wait 5s

    # Невозможность есть еду на поздних стадиях
        on player consumes item flagged:infected|disease_stage:
            - if <player.flag[disease_stage]> >= 3 && <context.item.material.is_in[<server.material_types.filter[food_points.exists]>]> && <context.item.script.name.advanced_matches[!disgusting_*]>:
                    - determine cancelled passively
                    - random:
                        - actionbar '<dark_red>На вкус как пыль...'
                        - actionbar '<dark_red>Совсем не насыщает...'
                        - actionbar '<dark_red>Мне нужна кровь...'
                        - actionbar '<dark_red>Блевать тянет...'
                        - actionbar '<dark_red>Невозможно есть...'
                        - actionbar '<dark_red>Меня сейчас вырвет...'
                        - actionbar '<dark_red>Не утолет голод...'
                    - cast confusion duration:10s amplifier:2 no_icon hide_particles
                    - cast hunger duration:10s amplifier:2 no_icon hide_particles

    # Заражённый ест омерзительные блюда
        on player consumes disgusting_sammych|disgusting_bbq flagged:infected|disease_stage:
            - cast absorption duration:infinite amplifier:1

    # Игрок ест омерзительные блюда
        on player consumes disgusting_sammych|disgusting_bbq flagged:!infected|!disease_stage:
            - run infection def:<player>|true

    # Заражённый выпил чёрную слизь
        on player consumes infected_slime flagged:!infected|!disease_stage:
            - run infection def:<player>|true

    # Заражённый выпил кровь
        on player consumes bottle_o_blood flagged:infected|disease_stage:
            - run blood_saturation def.raw_saturate:6 def.loud:true

    # Заражённый выпил кровь огнерождённого
        on player consumes bottle_o_blood_fire flagged:infected|disease_stage:
            - run saint_flaming

    # Игрок выпил кровь огнерождённого
        on player consumes bottle_o_blood_fire flagged:!infected|!disease_stage:
            - actionbar '<gold>Получи моё благословение, дитя'
            - cast fire_resistance duration:20s amplifier:0
            - wait 5
            - run minor_cure def:<player>

    # Игрок попал заражённой стрелой по игроку
        on arrow hits:
            - if <context.hit_entity.entity_type.advanced_matches[player]||false> && <context.projectile.custom_name.advanced_matches[<dark_purple>Прокажённая стрела]||false>:
                - run infection def:<player>|true

    # Хавать за счёт мобов
        on entity damaged by player flagged:infected|disease_stage:
            - define bloodless <script.data_key[bloodless]>
            - if <player.flag[disease_stage]> >= 2 && <context.cause.advanced_matches[entity_attack|entity_sweep_attack]>:
                - if !<context.entity.entity_type.advanced_matches[<[bloodless]>]>:
                    - if <context.entity.has_flag[origin_marker]> && <context.entity.flag[origin_marker].advanced_matches[blazeborn|magmacube]>:
                        - run saint_flaming
                    - else if <context.entity.has_flag[infected]>:
                        - actionbar '<red>Эта кровь не насыщает'
                    - else:
                        - run blood_saturation def.raw_saturate:<context.damage.mul[2]>

    # Заражённый умер от огня
        on player death flagged:infected|disease_stage:
            - if <player.flag[disease_stage].is_more_than_or_equal_to[1]> && <context.cause.advanced_matches[fire|fire_tick|campfire].or[<context.entity.on_fire>]>:
                - run minor_cure def:<player>
                - determine "<gold><player.name> очистился огнём"

    # Баффы от килла игрока
        on player death:
            - if <context.damager.exists.and[<context.damager.has_flag[infected].and[<context.damager.has_flag[disease_stage].and[<context.damager.flag[disease_stage].is_more_than_or_equal_to[2]>]>]>]>:
                # За убийство игрока на [Стадия*5/3-5] секунд дается сытость и сопротивление
                - cast saturation duration:<context.damager.flag[disease_stage].mul[5].div_int[3].sub[5]> amplifier:<context.damager.flag[disease_stage].div_int[5].sub[1]> <context.damager> no_icon hide_particles
                - cast resistance duration:<context.damager.flag[disease_stage].mul[5].div_int[3].sub[5]> amplifier:<context.damager.flag[disease_stage].div_int[5].sub[1]> <context.damager> no_icon hide_particles
                # Сила, если стадия 4+
                # [Стадия*5/4-5] секунд
                - if <context.damager.flag[disease_stage]> >= 5:
                    - cast strength duration:<context.damager.flag[disease_stage].mul[5].div_int[4].sub[5]> amplifier:<context.damager.flag[disease_stage].div_int[6].sub[1]> <context.damager> no_icon hide_particles
                    - cast regeneration duration:<context.damager.flag[disease_stage].mul[5].div_int[4].sub[5]> amplifier:<context.damager.flag[disease_stage].div_int[6].sub[1]> <context.damager> no_icon hide_particles
                - random:
                    - actionbar '<dark_red>Мне 13 но я как Ганнибал Лектор...'
                    - actionbar '<dark_red>То, что нужно...'
                    - actionbar '<dark_red>Выписываю им звезду Мишлен...'
                    - actionbar '<dark_red>Превосходная еда...'
                    - actionbar '<dark_red>Изумительно, наконец-то нормальная блять еда...'
                    - actionbar '<dark_red>BLOOD IS FUEL'
                    - actionbar '<dark_red>MANKIND IS DEAD'
                    - actionbar 'mortis'

        # Баффы от кила моба
        on entity death:
            #
            # Баффы за убийство мобов
            # За убийство мирного моба на [Стадия*5/3] секунд дается сопротивление
            #
            - stop if:<context.entity.entity_type.equals[PLAYER]>
            - define bloodless <script.data_key[bloodless]>
            - if <context.damager.exists.and[<context.damager.has_flag[infected].and[<context.damager.has_flag[disease_stage].and[<context.damager.flag[disease_stage].is_more_than_or_equal_to[5]>]>]>]>:
                - if !<context.entity.entity_type.advanced_matches[<[bloodless]>]>:
                    # За убийство мирного моба на [Стадия*5/4-5] секунд дается сопротивление
                    - cast saturation duration:<context.damager.flag[disease_stage].mul[5].div_int[3].sub[5]> amplifier:0 <context.damager> no_icon hide_particles
                    - if <context.damager.flag[disease_stage]> >= 6:
                    # За убийство мирного моба на [Стадия*5/4-5] секунд дается регенерация
                        - cast regeneration duration:<context.damager.flag[disease_stage].mul[5].div_int[4].sub[5]> amplifier:<context.damager.flag[disease_stage].div_int[7].sub[1]> <context.damager> no_icon hide_particles
                    - random:
                        - actionbar '<dark_red>Да...'
                        - actionbar '<dark_red>Кровь...'
                        - actionbar '<dark_red>А что, если гуманоида...'
                        - actionbar '<dark_red>Хочу человеческую кровь...'
                        - actionbar '<dark_red>Свежая...'

#
# Функции
#

# Заражение
infection:
    type: task
    definitions: __player|loud
    debug: false
    script:
        - if !<player.has_flag[cured]> && !<player.has_flag[infected]> && !<player.flag[origin_marker].advanced_matches[blazeborn|magmacube]>:
            - if <[loud]||null>:
                - actionbar '<red>Нечто тёмное забралось внутрь вас.'
                - cast darkness amplifier:0 duration:5
            - flag player infected:true
            - flag player disease_stage:1
        - else if <player.has_flag[cured]>:
            - if <[loud]||null>:
                - actionbar '<green>Вы чувствуете, что нечто тёмное в вас выжжено.'
            - burn duration:2s
            - flag player infected:!
            - flag player disease_stage:!
        - else if <player.flag[origin_marker].advanced_matches[blazeborn|magmacube]>:
            - if <[loud]||null>:
                - playeffect effect:FLAME <player.eye_location> visibility:100 quantity:25 offset:2.0 velocity:<player.velocity.add[0,-0.02,0]>
                - actionbar '<gold>Нечто тёмное сгорает под вашей кожей.'
                - wait 3
                - actionbar '<gold>Священный пламень защитил вас.'
        - else if <player.has_flag[infected]>:
            - if <[loud]||null>:
                - actionbar '<italic>Нос чешется...'
                - wait 30t
                - run achoo

# Лечение
cure:
    type: task
    debug: false
    definitions: __player|loud
    script:
        - if <player.has_flag[infected]>:
            - if <[loud]||false>:
                - playeffect effect:FLAME <player.eye_location> visibility:100 quantity:25 offset:2.0 velocity:<player.velocity.add[0,-0.02,0]>
                - actionbar '<green>Вы чувствуете, что нечто тёмное в вас выжжено.'
            - burn duration:2s
            - flag player infected:!
            - flag player disease_stage:!
        - run hp_reload def:<player>

# Малое исцеление
minor_cure:
    type: task
    debug: false
    definitions: __player
    script:
        - if <player.has_flag[disease_stage]> && <player.flag[disease_stage].is_more_than_or_equal_to[1]>:
            - flag player disease_stage:--
            - playeffect effect:FLAME <player.eye_location> visibility:100 quantity:25 offset:2.0 velocity:<player.velocity.add[0,-0.02,0]>
            - actionbar "<green>Вы чувствуете, как нечто тёмное внутри вас сгорает."
            - run hp_reload def:<player>

# Развитие болезни
minor_diseasing:
    type: task
    debug: false
    script:
        - if <player.has_flag[disease_stage]> && <player.flag[disease_stage].is_less_than[6]>:
            - playeffect effect:WARPED_SPORE <player.eye_location> quantity:10 offset:0.1,0,0.1
            - flag player disease_stage:+:0.2
            - run hp_reload def:<player>
        - else if <player.has_flag[disease_stage]> && <player.flag[disease_stage].is_more_than_or_equal_to[6]>:
            - run achoo

# Чих | Получить чёрную слизь
achoo:
    type: task
    debug: false
    script:
        - playsound <player.eye_location> sound:entity_warden_hurt volume:1 pitch:2 sound_category:master
        - playeffect effect:zombie_infect at:<player.eye_location>
        - if <player.item_in_hand.material.advanced_matches[glass_bottle].or[<player.item_in_offhand.material.advanced_matches[glass_bottle]>]>:
            - take item:glass_bottle from:<player.inventory> quantity:1
            - give infected_slime quantity:1
        - else:
            - playeffect effect:SQUID_INK at:<player.eye_location> quantity:10 offset:1,0,1 velocity:<player.velocity.add[0,0.25,0]>

# Голод по крови
blood_hunger:
    type: task
    debug: false
    definitions: raw_hunger
    script:
        - define hunger <[raw_hunger]||<player.flag[disease_stage]>>
        - actionbar "<dark_red><italic>Голод..."
        - repeat <[hunger]>:
            - adjust <player> food_level:<player.food_level.sub[1]>
            - cast confusion duration:10s amplifier:2 no_icon hide_particles
            - cast hunger duration:10s amplifier:2 no_icon hide_particles
            - wait 10t

# Голод сытость от крови
blood_saturation:
    type: task
    debug: false
    definitions: saturate|loud
    script:
        # Уведомление
        - if <[loud]||false>:
            - actionbar "<dark_red><italic>Освежает"
        # Насыщение
        - repeat <[saturate]||4>:
            - adjust <player> food_level:<player.food_level.add[1]>
            - wait 10t
        - adjust <player> saturation:<player.saturation.add[<[saturate]||4>]>

# Священное пламя
saint_flaming:
    type: task
    debug: false
    script:
        - burn 2s
        - actionbar '<gold>НЕ ТРОЖЬ МОИХ ДЕТЕЙ'
        - playsound <player> sound:entity_blaze_burn volume:1 pitch:0.6
        - playeffect effect:FLAME <player.location.add[0,1,0]> visibility:100 quantity:25 offset:2.0 velocity:<player.velocity.add[0,-0.02,0]>

# Тест изменения хп
hp_reload:
    type: task
    debug: false
    definitions: __player
    script:
        - if <player.has_flag[infected]> && <player.flag[disease_stage].is_less_than_or_equal_to[8]>:
            - define hp_minus:<player.flag[disease_stage].mul[1.25]>
        - else if <player.has_flag[infected]>:
            - define hp_minus:10
        - else:
            - define hp_minus:0
        - adjust <player> max_health:<player.attribute_default_value[max_health].sub[<[hp_minus]>]>