dice:
    type: command
    name: dice
    description: Кидает указанное число игральных костей
    usage: /dice <&lt>Число<&gt>
    tab completions:
        1: 2|3|4|5|6
    replace:
        1: <&color[#E01B24]>⚀<&r>
        2: <&color[#FFA348]>⚁<&r>
        3: <&color[#F9F06B]>⚂<&r>
        4: <&color[#8FF0A4]>⚃<&r>
        5: <&color[#57E389]>⚄<&r>
        6: <&color[#33D17A]>⚅<&r>
    script:
    - define int <context.args.get[1]||1>
    - if <[int].is_integer.not> || <[int]> < 1:
        - narrate "<red>Как я тебе кину <&dq><[int]><&dq> кубиков?"
        - stop
    - if <[int]> > 18:
        - narrate "<red>Не, бро 18 - максимум."
    #
    - define str <&sp>
    - define sum 0
    - repeat <[int].min[18]>:
        - define i <util.random.int[1].to[6]>
        - define sum <[sum].add[<[i]>]>
        - define d <script.data_key[replace.<[i]>]>
        - define str <[str]><[d]>
    #
    - announce "<gold><player.name> бросает кости! (x<[int].min[18]>)"
    - announce <gray>⏴<[str].parsed.replace_text[ ]><gray>⏵<&sp>⏸<[sum]>⏸

roll:
    type: command
    name: roll
    description: Кидает указанное число игральных костей. Второй аргумент - прибавляемый модификатор.
    usage: /roll <&lt>1d20/1к20<&gt> <&lt>±1<&gt>
    tab completions:
        1: 1d4|1d6|1d8|1к12|d20|4d6
        2: +1|-1
    script:
    - define dices <context.args.get[1].split[+]||<list[<list[1d20]>]>>
    - define mod <context.args.get[2]||>
    - define keep <context.args.get[3]||>
    - define str <&r>
    - define roll_result <list[]>
    - define dices_l <list[]>
    # Роллим
    - foreach <[dices]> as:dice:
        - define roll <[dice].split[regex:d|к]>
        - define count <[roll].get[1]>
        - define dice <[roll].get[2]||NaN>
        - define count 1 if:<[count].is_integer.not>
        - if !<[dice].is_integer>:
            - narrate "<red>Невозможно бросить кость 'd<[dice]>'"
            - playsound <player.location> sound:block_redstone_torch_burnout pitch:2
            - wait 10t
        - else:
            - define count <[count].min[100]>
            - define dice <[dice].min[10000]>
            - define dices_l <[dices_l].insert[<[count]>d<[dice]>].at[<[roll_result].size.add[1]>]>
            - repeat <[count]>:
                - define i <util.random.int[1].to[<[dice]>]>
                - define pref <element[]>
                - define pref ★ if:<[i].equals[1]>
                - define pref ^ if:<[i].equals[<[dice]>]>
                - define roll_result <[roll_result].insert[<[pref]><[i]>].at[<[roll_result].size.add[1]>]>
    #
    - define sum 0
    - foreach <[roll_result].parse[replace_text[regex:\^|\★]]> as:i:
        - define sum:+:<[i]>
    - define sum:+:<[mod]> if:<[mod].is_integer>
    #
    - announce "<gold><player.name> бросает <[dices_l].separated_by[+]><[mod]>!"
    - announce "<gray>Результат каждого броска: <gray>⏴<&r><[roll_result].parse[replace_text[^].with[<gold>].replace_text[★].with[<red>]].separated_by[<gray>+<&r>]><gray>⏵"
    - announce "<gray>Суммарный результат: <aqua>⏴<[sum]>⏵"