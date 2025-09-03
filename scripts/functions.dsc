# Уведомления
choice_notification:
    type: task
    script:
        - narrate '<gray><italic>Ответьте <green><italic>ДА <gray><italic>или <red><italic>НЕТ'
        - playsound <player> sound:entity_experience_orb_pickup volume:0.8 pitch:0.8

aliasing_notification:
    type: task
    script:
        - narrate '<gray><italic>Назовитесь новому знакомому'
        - playsound <player> sound:entity_experience_orb_pickup volume:0.8 pitch:0.8

# Инициировать счётчики мимпы
initiate_counters:
    type: task
    script:
        - flag server count_freethinks:20
        - flag server count_canons:0
        - flag server count_redcon:0

count_freethinks_incrementing:
    type: task
    script:
        - flag server count_freethinks:++
        - flag player count_freethinks:++
        - title "subtitle:<aqua>Новая связь сформирована" fade_in:0.2s fade_out:0.2s stay:3s targets:<server.online_players>
        - narrate "<aqua>Мир вокруг стал реальнее." targets:<server.online_players>
        - playsound target:<server.online_players> sound:entity_experience_orb_pickup sound_category:master volume:0.8 pitch:1.2

count_canons_incrementing:
    type: task
    script:
        - flag server count_canons:++
        - flag player count_canons:++
        - title "subtitle:<gold>Осваивается новый канон" fade_in:0.2s fade_out:0.2s stay:3s targets:<server.online_players>
        - narrate "<gold>Части другой истории просачиваются в этот мир." targets:<server.online_players>
        - playsound target:<server.online_players> sound:item_totem_use sound_category:master volume:0.4 pitch:0.2

count_redcons_incrementing:
    type: task
    script:
        - flag server count_redcons:++
        - flag player count_redcons:++
        - title "title:<aqua>Ред<gold>кон <light_purple>применён" "subtitle:<light_purple>Мир ВСЕГДА был иным" stay:15s targets:<server.online_players>
        - narrate "<light_purple>Вы вспоминаете то, чего не было." targets:<server.online_players>
        - playsound target:<server.online_players> sound:entity_wither_death sound_category:master volume:1 pitch:0.8
        - wait 15s
        # - ban <server.online_players> "reason:В среду вносятся изменения. Ожидайте." source:<player.name> expire:10m
