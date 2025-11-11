ch_nick_mode:
    type: command
    name: nick
    description: Замена ника
    usage: /nick <&lt>arg<&gt>
    tab completions:
        1: reset
    permission: dscript.mycmd
    script:
    - define nick <context.args.get[1]>
    - flag <player> ch_nick:<[nick]> if:<[nick].equals[reset].not>
    - flag <player> ch_nick:! if:<[nick].equals[reset]>

ch_nick_world:
    type: world
    events:
        on player chats flagged:ch_nick:
            - announce <&a><player.flag[ch_nick]><&sp><dark_gray>»<&sp><&color[#DEDDDA]><&sp><context.message>
            - determine cancelled passively