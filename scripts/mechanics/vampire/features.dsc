# Пьедестал
vampire_piedestal:
    type: world
    events:
        on player right clicks sculk_shrieker flagged:vampire location_flagged:piedestal_owner:
        - stop if:<player.flag[vampire].equals[<context.location.center>].not>
        - narrate "Всепрощений"`

        on player breaks sculk_shrieker location_flagged:piedestal_owner:
            - flag <context.location> piedestal_owner:!
        on sculk_shrieker destroyed by explosion location_flagged:piedestal_owner:
            - flag <context.location> piedestal_owner:!

# Игрок-