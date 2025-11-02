timeskip:
    type: command
    name: timeskip
    description: Принимает аргументы в реальных секундах: целевое игровое время (от -1 до 1200) и временной шаг за итерацию (от 1 до 300). Попытка выставить значения, выходящие за обозначенные диапазоны, отсечёт лишнее время и возмёт минимум или максимум. <red>При прокрутке времени назад, фазы луны будут меняться при каждой итерации смены времени.
    usage: /timeskip <&lt>tick<&gt> <&lt>step<&gt>
    tab completions:
        1: 0|300|600|900|1200
        2: 1|2|3|4|5|10|15|20
    permission: dscript.mycmd
    script:
    - narrate "<&nl><red> ⚠ Дождитесь завершения таймскипа.<&nl>" if:<player.location.world.has_flag[timeskipping]>
    - stop if:<player.location.world.has_flag[timeskipping]>
    - flag <player.location.world> timeskipping:true expire:60
    #
    - define target_time <context.args.get[1].min[1200].max[0]>
    - define step <context.args.get[2].min[20].max[1]||3>
    - narrate "<&nl><red> ⚠ Ошибка, укажите время от 0 до 1199.<&nl>" if:<[target_time].is_integer.not>
    - stop if:<[target_time].is_integer.not>
    - define current_time <player.location.world.time.div[20].round_to[0]>
    - define diff <[target_time].sub[<[current_time]>]>
    - narrate "<&nl><red> ⚠ Ошибка, вы выставили текущее время.<&nl>" if:<[diff].equals[0]>
    #
    - while <[diff].abs> != 0:
        - stop if:<[loop_index].equals[1200]>
        - define current_time <[current_time].add[<[diff].min[<[step]>].max[-<[step]>]>]>
        - time <[current_time]> <player.location.world.name>
        - define diff <[diff].add[<[diff].min[<[step]>].max[-<[step]>].mul[-1]>]>
        #
        - wait 1t
    #
    - flag <player.location.world> timeskipping:!