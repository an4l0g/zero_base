local config = {}

config.general = {
    ['all'] = {
        shopType = 'all',
        hidePlayers = true,
        shopConfig = {
            ['1'] = { item = { Male = {}, Female = {} } }, -- mascara
            ['3'] = { item = { Male = {}, Female = {} } }, -- maos
            ['4'] = { item = { Male = {}, Female = {} } }, -- calca
            ['5'] = { item = { Male = {}, Female = {} } }, -- mochila
            ['6'] = { item = { Male = {}, Female = {} } }, -- sapato
            ['7'] = { item = { Male = {}, Female = {} } }, -- gravata
            ['8'] = { item = { Male = {}, Female = {} } }, -- camisa
            ['9'] = { item = { Male = {}, Female = {} } }, -- colete
            ['11'] = { item = { Male = {}, Female = {} } }, -- jaqueta
            ['p0'] = { item = { Male = {}, Female = {} } }, -- bone/chapeu
            ['p1'] = { item = { Male = {}, Female = {} } }, -- oculos
            ['p2'] = { item = { Male = {}, Female = {} } }, -- brinco
            ['p6'] = { item = { Male = {}, Female = {} } }, -- relogio
            ['p7'] = { item = { Male = {}, Female = {} } }, -- bracelete
        },
        customPeds = {
            [GetHashKey('a_m_y_hipster_02')] = 'male',
        },
        blip = {
            name = 'Loja de Roupas',
            id = 73,
            color = 0,
            scale = 0.8
        }
    }
}

config.locs = {
    { blip = true, coord = vector4(70.87, -1399.49, 28.39, 359.29), config = 'all' }
}

return config