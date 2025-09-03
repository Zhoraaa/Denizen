# Пивовар
brewer_assign:
    type: assignment
    actions:
        on assignment:
            - trigger name:click state:true
    interact scripts:
        - brewer_interact

brewer_interact:
    type: interact
    steps:
        1:
            click trigger:
                script:
                - ~run dialogue path:talk def.text:<list[Захрючательное времечко!]> def.target:<npc>
                - run dialogue def:hub_brewer|<npc>|<player>
        beer_4_rana:
            click trigger:
                script:
                - run dialogue def:brewer_beer_4_rana|<npc>|<player>
        beer_4_rana_need_can:
            click trigger:
                script:
                - narrate Потом

# Трудовик
academ_brewer_assign:
    type: assignment
    actions:
        on assignment:
            - trigger name:click state:true
    interact scripts:
        - academ_brewer_interact

academ_brewer_interact:
    type: interact
    steps:
        1:
            click trigger:
                script:
                - random:
                    - define msg "Я согласился на эту работу лишь потому что здесь хоть кто-то будет меня слушать..."
                    - define msg "Ну что, мелкота, поработаем лобзиком?"
                    - define msg "На сегодня никаких уроков нет, можешь пока осмотреть все."
                    - define msg "Вообще, я не плохой повар.|Если хочешь, могу устроить как-нибудь мастер класс в кулинарном клубе.|&подмигнул"
                - ~run dialogue path:talk def.text:<list[<[msg]>]> def.target:<npc>
                - run dialogue def:academ_brewer|<npc>|<player>
        hruchevo_quest:
            click trigger:
                script:
                - define req <player.item_in_hand.display.advanced_matches[*Странная*жижа*|*Свиное*пиво*|*Отборное*свиное*хрючево*].and[<player.item_in_hand.proc[is_brew]>]||false>
                - random:
                    - define msg "Что, уже все сделал? Нет? Не теряй времени, мелкота."
                    - define msg "Я надеюсь, ты его там не выдул в одно рыло?"
                    - define msg "А что, ты и в правду хотел заняться <&dq>Трудом<&dq>? Зануда."
                    - define msg "Сгоняй к поварихе, у неё найдётся пару ингридиентов."
                - define msg "О, ты уже закончил? Молодчинка, держи свои 20 баллов, можешь быть свободен." if:<[req]>
                - ~run dialogue path:talk def.text:<list[<[msg]>]> def.target:<npc>
                - take from:<player.item_in_hand> if:<[req]>
                - run ap_bal_add def:20|<player> if:<[req]>
                - zap academ_brewer_interact 1 if:<[req]>
        drunken_brewer:
            click trigger:
                script:
                - ~run dialogue path:talk def.text:<list[М? Чё надо?|Дуй отсюда, мелкота, я занят.|Раньше надо было.]> def.target:<npc>
#
hruchevo_quest_start:
    type: task
    definitions: npc|__player
    script:
    - define name <context.args.get[1]>
    - flag <player> hruchevo:true
    - zap academ_brewer_interact hruchevo_quest
    - define lore <list[]>
    - define lore:->:<element[<gray>Котел с водой разогреть и добавить туда.]>
    - define lore:->:<element[<gray>- 5 колосьев пшена]>
    - define lore:->:<element[<gray>- Багровый гриб]>
    - define lore:->:<element[<gray>Варить 10 минут до готовности.]>
    - define lore:->:<element[<gray>Бражку ферментировать 8 раз.]>
    - define lore:->:<element[<gray>Оставить бродить в бочке на 2 года.]>
    - give paper[display=<&r>Рецепт;lore=<[lore].separated_by[|]>] to:<player.inventory>