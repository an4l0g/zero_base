```lua
    text = true -- ( True aparece o texto / False não aparece o texto ),
    hash = 0203103203 -- ( Hash da porta ),
    coord = vector3(0, 0, 0) -- ( Coordenada da porta ),
    lock = true -- ( True a porta irá começar trancada / False a porta irá começar destrancada )
    perm = 'true.permissao' -- ( Caso a porta precise de permissão para ser aberta, utilize os exemplos abaixo. ),

    -- Exemplos Perm
    -- Caso seja mais de 1 permissão utilize table:
    perm = { 'admin.permissao', 'hospital.permissao' }

    -- Caso seja somente 1 permissão:
    perm = 'admin.permissao'

    home = 'Homes0001' -- ( Caso seja uma porta de casa, você terá que por o nome da casa para somente quem mora nesta casa consiga abrir a porta ),

    other = 1664299099 -- ( Você so irá utilizar esse caso queira abrir 2 portas ao mesmo tempo. Exemplo abaixo:)

    -- Exemplo do other:
    { text = true, hash = 1664299099, coord = vector3(-1724.08, 359.13, 89.46), lock = true, home = 'MansaoRichmanSt', other = -1664299099 },

    -- Caso você abra o 2 irá abrir o 1 junto. Caso abra o 1 irá abrir o 2 junto.

    autoLock = 10000, -- ( Aqui você só irá utilizar caso queira que a porta feche sozinha após alguns segundos. Exemplo de como utilizar abaixo. )

    -- Cada 1000 milisegundos é 1 segundo.
    autoLock = 10000 -- 10 Segundos

    distance = 5.0 -- ( Distância da aonde irá começar a thread da porta. ( CASO SEJA GRADE DE GARAGEM OU SEI LÁ O QUE FOR, VOCÊ DEVE UTILIZAR 10.0 ) )
```
