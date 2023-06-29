local config = {}

config.general = {
    ['all'] = {
        shopType = 'all',
        hidePlayers = true,
        shopConfig = {
            [0] = { price = 500, item = { Male = {}, Female = {} } }, -- Defeitos
            [1] = { price = 500, item = { Male = {}, Female = {} } }, -- Barba
            [2] = { price = 500, item = { Male = {}, Female = {} } }, -- Sombrancelha
            [3] = { price = 500, item = { Male = {}, Female = {} } }, -- Envelhecimento
            [4] = { price = 500, item = { Male = {}, Female = {} } }, -- Maquiagem
            [5] = { price = 500, item = { Male = {}, Female = {} } }, -- Blush
            [6] = { price = 500, item = { Male = {}, Female = {} } }, -- Rugas
            [8] = { price = 500, item = { Male = {}, Female = {} } }, -- Batom
            [9] = { price = 500, item = { Male = {}, Female = {} } }, -- Sardas
            [10] = { price = 500, item = { Male = {}, Female = {} } }, -- Cabelo no Peito
            [11] = { price = 500, item = { Male = {}, Female = {} } }, -- Manchas no Corpo
            [12] = { price = 500, item = { Male = {}, Female = {} } }, -- Cabelo
            [13] = { price = 500, item = { Male = {}, Female = {} } }, -- Cor Sec. do Cabelo
        },
        clothes = {
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
        blip = {
            name = 'Barbearia',
            id = 71,
            color = 0,
            scale = 0.7
        }
    }
}

config.locs = {
    -- [ BARBERSHOP 1 ] --
    { blip = true, coord = vector4(138.5275, -1707.363, 29.27991, 45.35433), config = 'all' },
    { blip = true, coord = vector4(137.4857, -1708.497, 29.27991, 42.51968), config = 'all' },
    { blip = true, coord = vector4(136.6154, -1709.71, 29.27991, 42.51968), config = 'all' }
}

return config