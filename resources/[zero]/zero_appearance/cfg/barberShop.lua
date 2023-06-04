config.generalBarberShop = {
    ['all'] = {
        ['shopType'] = 'all',
        ['hidePlayers'] = true,
        ['shopConfig'] = {
            [0] = { ['price'] = 500, ['item'] = { ['Male'] = {}, ['Female'] = {} } }, -- Defeitos
            [1] = { ['price'] = 500, ['item'] = { ['Male'] = {}, ['Female'] = {} } }, -- Barba
            [2] = { ['price'] = 500, ['item'] = { ['Male'] = {}, ['Female'] = {} } }, -- Sombrancelha
            [3] = { ['price'] = 500, ['item'] = { ['Male'] = {}, ['Female'] = {} } }, -- Envelhecimento
            [4] = { ['price'] = 500, ['item'] = { ['Male'] = {}, ['Female'] = {} } }, -- Maquiagem
            [5] = { ['price'] = 500, ['item'] = { ['Male'] = {}, ['Female'] = {} } }, -- Blush
            [6] = { ['price'] = 500, ['item'] = { ['Male'] = {}, ['Female'] = {} } }, -- Rugas
            [8] = { ['price'] = 500, ['item'] = { ['Male'] = {}, ['Female'] = {} } }, -- Batom
            [9] = { ['price'] = 500, ['item'] = { ['Male'] = {}, ['Female'] = {} } }, -- Sardas
            [10] = { ['price'] = 500, ['item'] = { ['Male'] = {}, ['Female'] = {} } }, -- Cabelo no Peito
            [11] = { ['price'] = 500, ['item'] = { ['Male'] = {}, ['Female'] = {} } }, -- Manchas no Corpo
            [12] = { ['price'] = 500, ['item'] = { ['Male'] = {}, ['Female'] = {} } }, -- Cabelo
            [13] = { ['price'] = 500, ['item'] = { ['Male'] = {}, ['Female'] = {} } }, -- Cor Sec. do Cabelo
        },
        ['roupaPelado'] = {
            [GetHashKey('mp_m_freemode_01')] = {                                      
                [1] = { -1,0 },
                [3] = { 15,0 },
                [4] = { 21,0 },
                [5] = { -1,0 },
                [6] = { 34,0 },
                [7] = { -1,0 },
                [8] = { 15,0 },
                [10] = { -1,0 },
                [11] = { 15,0 }
            },
            [GetHashKey('mp_f_freemode_01')] = {
                [1] = { -1,0 },
                [3] = { 15,0 },
                [4] = { 15,0 },
                [5] = { -1,0 },
                [6] = { 35,0 },
                [7] = { -1,0 },
                [8] = { 6,0 },
                [9] = { -1,0 },
                [10] = { -1,0 },
                [11] = { 15,0 }
            }
        },
    }
}

config.locsBarberShop = {
    { ['coord'] = vector4(-815.59, -182.16, 36.66, 204.29), ['config'] = 'all',
        ['blip'] = {
            ['name'] = 'Barbearia',
            ['id'] = 71,
            ['color'] = 0,
            ['scale'] = 0.7
        }, 
    }
}