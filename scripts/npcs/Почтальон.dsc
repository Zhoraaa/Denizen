# Почтальон
preparing_postman:
    type: world
    events:
        on player joins:
            - if !<player.has_flag[postman_name]>:
                - flag player postman_name:Почтальон

postman_assign:
    type: assignment
    actions:
        on assignment:
            - trigger name:click state:true
            - trigger name:chat state:true cooldown:1s radius:50
            - trigger name:proximity state:true radius:10
            - zap 1 postman_interact target:<server.whitelisted_players>
    interact scripts:
        - postman_interact

postman_interact:
    type: interact
    steps:
        1:
            click trigger:
                script:
                    - cooldown 5s
                    - narrate '<&lt><player.flag[postman_name]><&gt> Добрый день!'
                    - ^wait 2s
                    - narrate '<&lt><player.flag[postman_name]><&gt> Вы уже знаете последние новости?'
                    - ^wait 2s
            chat trigger:
                1:
                    trigger: /regex:(?i)(?u)да/
                    script:
                        - narrate '<&lt><player.flag[postman_name]><&gt> Отлично! Тогда хорошего дня!'
                        - zap 2
                2:
                    trigger: /regex:(?i)(?u)нет/
                    script:
                        - cooldown 6s
                        - narrate '<&lt><player.flag[postman_name]><&gt> О, тогда спросите меня о любой теме с доски!'
                        - wait 3s
                        - narrate '<gray><italic>Для выхода из <aqua>[✉] режима новостей <gray><italic>поблагодарите почтальона за помощь.'
                        - zap 3
        2:
            click trigger:
                script:
                    - narrate '<gray><italic>Сейчас новостной бот находится в режиме разговора. Чтобы перейти в режим новостей, спросите его о новостях.'
                    - narrate '<gray><italic>В обычном режиме вы можете с ним поговорить о прочих НИПах.'
            # Обычный диалог
            chat trigger:
                1:
                    trigger: /regex:(?i)(?u)Что нового(\?)?|(Какие )?новости/?
                    script:
                        - wait 0.75
                        - narrate '<&lt><player.flag[postman_name]><&gt> Всё на доске. Спрашивай по любой теме!'
                        - zap 3
                2:
                    trigger: Кто такой /regex:(?i)(?u)Джентльмен|Шляпстер/?
                    script:
                        - wait 0.75
                        - narrate '<&lt><player.flag[postman_name]><&gt> У него пропитый взгляд, хотя он и трезвенник... Вроде...'
                3:
                    trigger: Кто такой /regex:(?i)(?u)Агас/?
                    script:
                        - cooldown 10s
                        - wait 0.75
                        - narrate '<&lt><player.flag[postman_name]><&gt> Агас? Прикольный чел. Деревянный такой.'
                        - wait 3s
                        - narrate '<&lt><player.flag[postman_name]><&gt> Однажды я должен был доставить ему письмо...'
                        - wait 4s
                        - narrate '<&lt><player.flag[postman_name]><&gt> Так он на меня белок натравил!'
                        - wait 2s
                        - narrate '<&lt><player.flag[postman_name]><&gt> Еле живой выбрался!'
                4:
                    trigger: Кто такой /regex:(?i)(?u)Кот(\-|\s)полиглот/?
                    script:
                        - wait 0.75
                        - narrate '<&lt><player.flag[postman_name]><&gt> Он пишет много писем! Но платит исключительно рыбой...'
                5:
                    trigger: Кто такой /regex:(?i)(?u)П(е|ё)с(\-|\s)стражник/?
                    script:
                        - cooldown 6s
                        - wait 0.75
                        - narrate '<&lt><player.flag[postman_name]><&gt> Текст его писем состоит из отпечатков лап и клякс...'
                        - wait 4s
                        - narrate '<&lt><player.flag[postman_name]><&gt> Но почему получатели жалуются на это МНЕ?!'
                6:
                    trigger: Кто такая /regex:(?i)(?u)Художни(к|ца)|Эльстер/?
                    script:
                        - cooldown 6s
                        - wait 0.75
                        - narrate '<&lt><player.flag[postman_name]><&gt> Она очень талантлива... И у неё красивый почерк...'
                        - wait 4s
                        - narrate '<&lt><player.flag[postman_name]><&gt> Интересно, что она обо мне думает...'
                7:
                    trigger: Что за /regex:(?i)(?u)Девочка(\-|\s)скаут|Рана/?
                    script:
                        - cooldown 6s
                        - wait 0.75
                        - narrate '<&lt><player.flag[postman_name]><&gt> Импортозамещённая Даша-путешественница.'
                        - wait 3s
                        - narrate '<&lt><player.flag[postman_name]><&gt> Мне страшно спросить, что она сделала со своим подручным питомцем...'
                8:
                    trigger: Кто такой /regex:(?i)(?u)Пивовар/?
                    script:
                        - cooldown 6s
                        - wait 0.75
                        - narrate '<&lt><player.flag[postman_name]><&gt> Классный мужик!'
                        - wait 3s
                        - narrate '<&lt><player.flag[postman_name]><&gt> Но меня пугает его маниакальность в вопросах моей алкогольной зависимости.'
                9:
                    trigger: Что за /regex:(?i)(?u)Гоблин/?
                    script:
                        - wait 0.75
                        - narrate '<&lt><player.flag[postman_name]><&gt> Ты это о ком?'
        3:
            # Новости
            click trigger:
                script:
                    - narrate '<&lt><player.flag[postman_name]><&gt> Какая тема вас интересует?'
                    - wait 3s
                    - narrate '<gray><italic>Для пояснения, спросите о любой новости с доски.'
                    - narrate '<gray><italic>Для выхода из <aqua>[✉] режима новостей <gray><italic>поблагодарите почтальона за помощь.'
            proximity trigger:
                exit:
                    script:
                        - narrate '<&lt><player.flag[postman_name]><&gt> Хорошего дня! Увидимся!'
                        - zap 2
            chat trigger:
                # Выход
                1:
                    trigger: /regex:(?i)(?u)Спасибо/ за помощь!
                    script:
                        - narrate '<&lt><player.flag[postman_name]><&gt> Не за что! Спрашивайте обо всём!'
                        - zap 2
                # Новые персы
                2:
                    trigger: /regex:(?i)(?u)Новые персонажи/
                    script:
                        - cooldown 20s
                        - wait 0.75
                        - narrate '<aqua>[✉] <white>Слышали что в Вердене поселились новые жители?'
                        - wait 4s
                        - narrate '<aqua>[✉] <white>Можете пройтись и повзаимодействовать с ними, если захотите поговорить то просто напишите в чат.'
                        - narrate '<aqua>[✉] <gray><italic>Пример: Напишите рядом любым говорящим NPC имя любого другого NPC. Не работает в режиме новостей.'
                        - wait 6s
                        - narrate '<aqua>[✉] <white>Также в <green>Концепте: Зелень <white>появился новый сюжетный персонаж, который расскажет вам про особенности этого мира даст квест, за его выполнение вы получите особую награду.'
                # Пива
                3:
                    trigger: /regex:(?i)(?u)Пивоварение/
                    script:
                        - cooldown 8s
                        - wait 0.75
                        - narrate '<aqua>[✉] <white>"Добавлена механика пивоварения", мне сказали так передать.'
                        - wait 4s
                        - narrate '<aqua>[✉] <white>Хотя один мой знакомый за такую формулировку набил бы ебальник...'
                brewer:
                    trigger: Кто такой /regex:(?i)(?u)Пивовар/?
                    script:
                        - cooldown 6s
                        - wait 0.75
                        - narrate '<aqua>[✉] <white>Мой друг! Заселился в дом у парка. Говорит, скоро бар откроет!'
                # Вагинетки
                4:
                    trigger: /regex:(?i)(?u)Обновление вагонеток/
                    script:
                        - cooldown 20s
                        - wait 0.75
                        - narrate '<aqua>[✉] <white>С этим обновлением мы вступаем в эпоху железных дорог!'
                        - wait 4s
                        - narrate '<aqua>[✉] <white>...'
                        - wait 1s
                        - narrate '<aqua>[✉] <white>Ну... Наверно вступаем...'
                        - wait 2s
                        - narrate '<aqua>[✉] <white>Скорость вагонеток, перевозящих сущности, увеличена более, чем в три раза! Это скорость элитр!'
                        - wait 6s
                        - narrate '<aqua>[✉] <white>Плюсом к этому у них появилось подобие физики! Теперь можно сделать рабочий трамплин!'
                        - wait 6s
                        - narrate '<aqua>[✉] <white>Мало того, теперь энергорельсы стали вдвое дешевле!'

#
academ_postman_assign:
    type: assignment
    actions:
        on assignment:
        - trigger name:click state:true
        - trigger name:chat state:true cooldown:1s radius:50
    interact scripts:
        - academ_postman_interact

academ_postman_interact:
    type: interact
    steps:
        1:
            click trigger:
                script:
                - random:
                    - define msg "Привет! Ты учишься здесь? А да, конечно учишься, что за глупый вопрос..."
                    - define msg "Кому в голову пришла мысль делать деревянные полы? Их же фиг отмоешь!"
                    - define msg "Эхх... Почему я только согласился на эту работу... Мог бы сейчас у доски книжки читать..."
                    - define msg "А?! Ты все еще здесь?"
                - ~run dialogue path:talk def.text:<list[<[msg]>]> def.target:<npc>
                - run dialogue def:academ_postman|<npc>|<player>