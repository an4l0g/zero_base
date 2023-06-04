Tunnel = module('vrp', 'lib/Tunnel')
Proxy = module('vrp', 'lib/Proxy')
vRP = Proxy.getInterface('vRP')

config = {}

config.generalSkinShop = {
    ['all'] = {
        ['shopType'] = 'exclude',
        ['hidePlayers'] = true,
        ['shopConfig'] = {
            [1] = { ['price'] = 500, ['item'] = { ['male'] = {}, ['female'] = {} } }, -- mascara
            [3] = { ['price'] = 500, ['item'] = { ['male'] = {}, ['female'] = {} } }, -- maos
            [4] = { ['price'] = 500, ['item'] = { ['male'] = {}, ['female'] = {} } }, -- calca
            [5] = { ['price'] = 500, ['item'] = { ['male'] = {}, ['female'] = {} } }, -- mochila
            [6] = { ['price'] = 500, ['item'] = { ['male'] = {}, ['female'] = {} } }, -- sapato
            [7] = { ['price'] = 500, ['item'] = { ['male'] = {}, ['female'] = {} } }, -- gravata
            [8] = { ['price'] = 500, ['item'] = { ['male'] = {}, ['female'] = {} } }, -- camisa
            [9] = { ['price'] = 500, ['item'] = { ['male'] = {}, ['female'] = {} } }, -- colete
            [10] = { ['price'] = 500, ['item'] = { ['male'] = {}, ['female'] = {} } }, -- decals (adesivos)
            [11] = { ['price'] = 500, ['item'] = { ['male'] = {}, ['female'] = {} } }, -- jaqueta
            ['p0'] = { ['price'] = 500, ['item'] = { ['male'] = {}, ['female'] = {} } }, -- bone/chapeu
            ['p1'] = { ['price'] = 500, ['item'] = { ['male'] = {}, ['female'] = {} } }, -- oculos
            ['p2'] = { ['price'] = 500, ['item'] = { ['male'] = {}, ['female'] = {} } }, -- brinco
            ['p6'] = { ['price'] = 500, ['item'] = { ['male'] = {}, ['female'] = {} } }, -- relogio
            ['p7'] = { ['price'] = 500, ['item'] = { ['male'] = {}, ['female'] = {} } }, -- bracelete
        },
        ['customPeds'] = {
            [GetHashKey('a_m_y_hipster_02')] = 'Male',
        }
    }
}

config.locsSkinShop = {
    { ['coord'] = vector4(70.87, -1399.49, 28.39, 359.29), ['config'] = 'all',
        ['blip'] = {
            ['name'] = 'Loja de Roupas',
            ['id'] = 73,
            ['color'] = 13,
            ['scale'] = 0.5
        }, 
    }
}