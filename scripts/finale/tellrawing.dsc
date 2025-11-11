ch_nick_mode:
    type: command
    name: nick
    description: Замена ника
    usage: /nick <&lt>arg<&gt>
    permission: dscript.mycmd
    script:
    - define nick <context.args.get[1]>
    - flag <player> ch_nick:<[nick]>

ch_nick_world:
    type: world
    events:
        on player chats flagged:ch_nick:
            - determine cancelled passively
            - announce <&a><player.flag[ch_nick]><&sp><dark_gray>»<&sp><&color[#DEDDDA]> <context.full_text>