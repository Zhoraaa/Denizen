# Человек
race_human_assign:
    type: assignment
    actions:
        on assignment:
        - trigger name:click state:true
    interact scripts:
        - human_select

human_select:
    type: interact
    steps:
        1:
            click trigger:
                script:
                    - flag player origin_marker:human
                    - narrate '<gold>Выбрана раса <aqua>"Человек"'
                    - execute as_op silent 'origin set <player.name> origin <player.flag[origin_marker]>'

# Пчёли
race_bee_assign:
    type: assignment
    actions:
        on assignment:
        - trigger name:click state:true
    interact scripts:
        - bee_select

bee_select:
    type: interact
    steps:
        1:
            click trigger:
                script:
                    - flag player origin_marker:bee
                    - narrate '<gold>Выбрана раса <aqua>"Анигол"'
                    - execute as_op silent 'origin set <player.name> origin <player.flag[origin_marker]>'

# Арахниды
race_arachnid_assign:
    type: assignment
    actions:
        on assignment:
        - trigger name:click state:true
    interact scripts:
        - arachnid_select

arachnid_select:
    type: interact
    steps:
        1:
            click trigger:
                script:
                    - flag player origin_marker:arachnid
                    - narrate '<gold>Выбрана раса <aqua>"Арахнид"'
                    - execute as_op silent 'origin set <player.name> origin <player.flag[origin_marker]>'


# Огнерождённые
race_blazeborn_assign:
    type: assignment
    actions:
        on assignment:
        - trigger name:click state:true
    interact scripts:
        - blazeborn_select

blazeborn_select:
    type: interact
    steps:
        1:
            click trigger:
                script:
                    - flag player origin_marker:blazeborn
                    - narrate '<gold>Выбрана раса <aqua>"Огнерождённый"'
                    - execute as_op silent 'origin set <player.name> origin <player.flag[origin_marker]>'


# Крипер
race_creeper_assign:
    type: assignment
    actions:
        on assignment:
        - trigger name:click state:true
    interact scripts:
        - creeper_select

creeper_select:
    type: interact
    steps:
        1:
            click trigger:
                script:
                    - flag player origin_marker:creeper
                    - narrate '<gold>Выбрана раса <aqua>"Крип-тид"'
                    - narrate '<red>[!] <white>"Нажатие клавиши приседания для вас взрывоопасно! Для того чтобы спешится используйте <gold>/dismount"'
                    - execute as_op silent 'origin set <player.name> origin <player.flag[origin_marker]>'

# Эндерианец
race_enderian_assign:
    type: assignment
    actions:
        on assignment:
        - trigger name:click state:true
    interact scripts:
        - enderian_select

enderian_select:
    type: interact
    steps:
        1:
            click trigger:
                script:
                    - flag player origin_marker:enderian
                    - narrate '<gold>Выбрана раса <aqua>"Эндерианец"'
                    - execute as_op silent 'origin set <player.name> origin <player.flag[origin_marker]>'

# Фелин
race_feline_assign:
    type: assignment
    actions:
        on assignment:
        - trigger name:click state:true
    interact scripts:
        - feline_select

feline_select:
    type: interact
    steps:
        1:
            click trigger:
                script:
                    - flag player origin_marker:feline
                    - narrate '<gold>Выбрана раса <aqua>"Фелин"'
                    - execute as_op silent 'origin set <player.name> origin <player.flag[origin_marker]>'

# Мерлинг
race_merling_assign:
    type: assignment
    actions:
        on assignment:
        - trigger name:click state:true
    interact scripts:
        - merling_select

merling_select:
    type: interact
    steps:
        1:
            click trigger:
                script:
                    - flag player origin_marker:merling
                    - narrate '<gold>Выбрана раса <aqua>"Мерлинг"'
                    - execute as_op silent 'origin set <player.name> origin <player.flag[origin_marker]>'

# Шалк
race_shulk_assign:
    type: assignment
    actions:
        on assignment:
        - trigger name:click state:true
    interact scripts:
        - shulk_select

shulk_select:
    type: interact
    steps:
        1:
            click trigger:
                script:
                    - flag player origin_marker:shulk
                    - narrate '<gold>Выбрана раса <aqua>"Шалк"'
                    - execute as_op silent 'origin set <player.name> origin <player.flag[origin_marker]>'

# Вызыватель
race_evoker_assign:
    type: assignment
    actions:
        on assignment:
        - trigger name:click state:true
    interact scripts:
        - evoker_select

evoker_select:
    type: interact
    steps:
        1:
            click trigger:
                script:
                    - flag player origin_marker:merling
                    - narrate '<gold>Выбрана раса <aqua>"Вызыватель"'
                    - execute as_op silent 'origin set <player.name> origin <player.flag[origin_marker]>'

# Инари
race_fox_assign:
    type: assignment
    actions:
        on assignment:
        - trigger name:click state:true
    interact scripts:
        - fox_select

fox_select:
    type: interact
    steps:
        1:
            click trigger:
                script:
                    - flag player origin_marker:fox
                    - narrate '<gold>Выбрана раса <aqua>"Инари"'
                    - execute as_op silent 'origin set <player.name> origin <player.flag[origin_marker]>'

# Слизень
race_slime_assign:
    type: assignment
    actions:
        on assignment:
        - trigger name:click state:true
    interact scripts:
        - slime_select

slime_select:
    type: interact
    steps:
        1:
            click trigger:
                script:
                    - flag player origin_marker:slime
                    - narrate '<gold>Выбрана раса <aqua>"Слизень"'
                    - execute as_op silent 'origin set <player.name> origin <player.flag[origin_marker]>'

# Клан Сноу
race_snow_golem_assign:
    type: assignment
    actions:
        on assignment:
        - trigger name:click state:true
    interact scripts:
        - snow_golem_select

snow_golem_select:
    type: interact
    steps:
        1:
            click trigger:
                script:
                    - flag player origin_marker:snow_golem
                    - narrate '<gold>Выбрана раса <aqua>"Клан Сноу"'
                    - execute as_op silent 'origin set <player.name> origin <player.flag[origin_marker]>'
# Ведьмин шабаш
race_witch_assign:
    type: assignment
    actions:
        on assignment:
        - trigger name:click state:true
    interact scripts:
        - witch_select

witch_select:
    type: interact
    steps:
        1:
            click trigger:
                script:
                    - flag player origin_marker:witch
                    - narrate '<gold>Выбрана раса <aqua>"Ведьмин шабаш"'
                    - execute as_op silent 'origin set <player.name> origin <player.flag[origin_marker]>'

# Бажкурт
race_wolf_assign:
    type: assignment
    actions:
        on assignment:
        - trigger name:click state:true
    interact scripts:
        - wolf_select

wolf_select:
    type: interact
    steps:
        1:
            click trigger:
                script:
                    - flag player origin_marker:wolf
                    - narrate '<gold>Выбрана раса <aqua>"Бажкурт"'
                    - execute as_op silent 'origin set <player.name> origin <player.flag[origin_marker]>'

# Страж
race_guardian_assign:
    type: assignment
    actions:
        on assignment:
        - trigger name:click state:true
    interact scripts:
        - guardian_select

guardian_select:
    type: interact
    steps:
        1:
            click trigger:
                script:
                    - flag player origin_marker:guardian
                    - narrate '<gold>Выбрана раса <aqua>"Страж"'
                    - execute as_op silent 'origin set <player.name> origin <player.flag[origin_marker]>'

# Зомби
race_zombie_assign:
    type: assignment
    actions:
        on assignment:
        - trigger name:click state:true
    interact scripts:
        - zombie_select

zombie_select:
    type: interact
    steps:
        1:
            click trigger:
                script:
                    - flag player origin_marker:zombie
                    - narrate '<gold>Выбрана раса <aqua>"Зомби"'
                    - execute as_op silent 'origin set <player.name> origin <player.flag[origin_marker]>'

# Скелет
race_skeleton_assign:
    type: assignment
    actions:
        on assignment:
        - trigger name:click state:true
    interact scripts:
        - skeleton_select

skeleton_select:
    type: interact
    steps:
        1:
            click trigger:
                script:
                    - flag player origin_marker:skeleton
                    - narrate '<gold>Выбрана раса <aqua>"Скелет"'
                    - execute as_op silent 'origin set <player.name> origin <player.flag[origin_marker]>'

# Визер-скелет
race_wither_skeleton_assign:
    type: assignment
    actions:
        on assignment:
        - trigger name:click state:true
    interact scripts:
        - wither_skeleton_select

wither_skeleton_select:
    type: interact
    steps:
        1:
            click trigger:
                script:
                    - flag player origin_marker:wither_skeleton
                    - narrate '<gold>Выбрана раса <aqua>"Визер-скелет"'
                    - execute as_op silent 'origin set <player.name> origin <player.flag[origin_marker]>'
# Магма-куб
race_magmacube_assign:
    type: assignment
    actions:
        on assignment:
        - trigger name:click state:true
    interact scripts:
        - magmacube_select

magmacube_select:
    type: interact
    steps:
        1:
            click trigger:
                script:
                    - flag player origin_marker:magmacube
                    - narrate '<gold>Выбрана раса <aqua>"Магма-куб"'
                    - execute as_op silent 'origin set <player.name> origin <player.flag[origin_marker]>'