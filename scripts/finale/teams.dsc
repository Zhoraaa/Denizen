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
            - flag <context.entity> team_goners:true
            - flag <context.entity> team_rewrit:!
            - narrate targets:<server.players_flagged[team_goners]> '<&c><context.entity.name> теперь в команде отступников.'
        on player right clicks player with:team_wand:
            - ratelimit <player> 4t
            - team name:rewrit add:<context.entity>
            - flag <context.entity> team_rewrit:true
            - flag <context.entity> team_goners:!
            - narrate targets:<server.players_flagged[team_rewrit]> '<&b><context.entity.name> теперь в команде переписи.'