team_wand:
    type: item
    material: breeze_rod
    display name: <&c>Раздел<&b>итель
    lore:
    - <&c>[ЛКМ] - Отстутпники
    - <&b>[ПКМ] - Переписчики

#
teams_world:
    type: world
    events:
        after script reload:
            - team name:goners color:red
            - team name:goners option:FRIENDLY_FIRE status:never
            - team name:rewrit color:aqua
            - team name:rewrit option:FRIENDLY_FIRE status:never
        on player damages player with:team_wand:
            - ratelimit <player> 4t
            - team name:goners add:<context.entity>
            - announce goners
        on player right clicks player with:team_wand:
            - ratelimit <player> 4t
            - team name:rewrit add:<context.entity>
            - announce rewrit