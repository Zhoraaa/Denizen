# Вход/выход
my_world:
    type: world
    events:
        on player right clicks interaction:
        - if <context.entity.has_flag[moonDungeon]>:
            - if <context.entity.flag[moonDungeon].equals[entry]>:
                - execute as_server silent 'warp entryMoonDungeon <player.name>'
                - adjust <player> gamemode:adventure
                # - teleport <player> <server.flag[entryMoonDungeon]>
            - if <context.entity.flag[moonDungeon].equals[exit]>:
                - execute as_server silent 'warp hotel_3 <player.name>'
                - adjust <player> gamemode:survival