local config = {}

config.general = {
    ['all'] = {
        shopType = 'all',
        hidePlayers = true,
        shopConfig = {
            [0] = { item = { Male = {}, Female = {} } }, -- Defeitos
            [1] = { item = { Male = {}, Female = {} } }, -- Barba
            [2] = { item = { Male = {}, Female = {} } }, -- Sombrancelha
            [3] = { item = { Male = {}, Female = {} } }, -- Envelhecimento
            [4] = { item = { Male = {}, Female = {} } }, -- Maquiagem
            [5] = { item = { Male = {}, Female = {} } }, -- Blush
            [6] = { item = { Male = {}, Female = {} } }, -- Rugas
            [8] = { item = { Male = {}, Female = {} } }, -- Batom
            [9] = { item = { Male = {}, Female = {} } }, -- Sardas
            [10] = { item = { Male = {}, Female = {} } }, -- Cabelo no Peito
            [11] = { item = { Male = {}, Female = {} } }, -- Manchas no Corpo
            [12] = { item = { Male = {}, Female = {} } }, -- Cabelo
            [13] = { item = { Male = {}, Female = {} } }, -- Cor Sec. do Cabelo
        },
        clothes = {
            [GetHashKey('mp_m_freemode_01')] = {                                      
                [1] = { model = -1, var = 0 },
                [3] = { model = 15, var = 0 },
                [4] = { model = 21, var = 0 },
                [5] = { model = -1, var = 0 },
                [6] = { model = 34, var = 0 },
                [7] = { model = -1, var = 0 },
                [8] = { model = 15, var = 0 },
                [10] = { model = -1, var = 0 },
                [11] = { model = 15, var = 0 }
            },
            [GetHashKey('mp_f_freemode_01')] = {
                [1] = { model = -1, var = 0 },
                [3] = { model = 15, var = 0 },
                [4] = { model = 15, var = 0 },
                [5] = { model = -1, var = 0 },
                [6] = { model = 35, var = 0 },
                [7] = { model = -1, var = 0 },
                [8] = { model = 6, var = 0 },
                [9] = { model = -1, var = 0 },
                [10] = { model = -1, var = 0 },
                [11] = { model = 15, var = 0 }
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
    { blip = true, coord = vector4(138.5275, -1707.363, 29.27991-0.97, 45.35433), config = 'all' },
    { coord = vector4(137.4857, -1708.497, 29.27991-0.97, 42.51968), config = 'all' },
    { coord = vector4(136.6154, -1709.71, 29.27991-0.97, 42.51968), config = 'all' }
}

return config