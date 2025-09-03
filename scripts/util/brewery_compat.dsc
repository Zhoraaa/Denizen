# Проверка из brewery ли зелье
is_brew:
    type: procedure
    definitions: potion
    script:
    - determine <[potion].custom_data.get[publicbukkitvalues].contains[breweryx:brewdata]||false>