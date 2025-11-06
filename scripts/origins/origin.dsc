origin_selection:
    type: world
    events:
        on player joins flagged:!origin:
        # - narrate 1

#
origin_list:
    type: data
    human:
        origin: human
        item: player_head[display=<red>123]

origin_selector:
    type: inventory
    inventory: chest
    gui: true
    definitions:
      name: item
    procedural items:
    - define result <list[<script[origin_list].data_key[human.item].parsed>|stick]>
    - determine <[result]>
    slots:
    - [] [] [] [] [] [] [] [] []
    - [] [] [] [] [] [] [] [] []
    - [] [] [] [] [] [] [] [] []