Tunnel = module('zero', 'lib/Tunnel')
Proxy = module('zero', 'lib/Proxy')
zero = Proxy.getInterface('zero')

config = {}

config.general = {
    ['comidas_bebidas'] = {
        ['hotdog'] = {
            name = 'Hotdog', index = 'hotdog',
            price = {
                buy = 250,
            },
            method = 'legal'
        },
        ['sanduiche'] = {
            name = 'Sanduiche', index = 'sanduiche',
            price = {
                buy = 250,
            },
            method = 'legal'
        },
        ['donut'] = {
            name = 'Donut', index = 'donut',
            price = {
                buy = 250,
            },
            method = 'legal'
        },
        ['pirulito'] = {
            name = 'Pirulito', index = 'pirulito',
            price = {
                buy = 250,
            },
            method = 'legal'
        },
        ['cola'] = {
            name = 'Cola', index = 'cola',
            price = {
                buy = 250,
            },
            method = 'legal'
        },
        ['agua'] = {
            name = 'Agua', index = 'agua',
            price = {
                buy = 250,
            },
            method = 'legal'
        },
        ['soda'] = {
            name = 'Soda', index = 'soda',
            price = {
                buy = 250,
            },
            method = 'legal'
        },
    },
    ['departament'] = {
        ['cordas'] = {
            name = 'Corda', index = 'cordas',
            price = {
                buy = 1000,
            },
            method = 'legal'
        },
        ['weapon_petrolcan'] = {
            name = 'Combustível', index = 'weapon_petrolcan',
            price = {
                buy = 300,
            },
            method = 'legal'
        },
        ['sanduiche'] = {
            name = 'Sanduiche', index = 'sanduiche',
            price = {
                buy = 250,
            },
            method = 'legal'
        },
        ['donut'] = {
            name = 'Donut', index = 'donut',
            price = {
                buy = 250,
            },
            method = 'legal'
        },
        ['pirulito'] = {
            name = 'Pirulito', index = 'pirulito',
            price = {
                buy = 250,
            },
            method = 'legal'
        },
        ['cola'] = {
            name = 'Cola', index = 'cola',
            price = {
                buy = 250,
            },
            method = 'legal'
        },
        ['agua'] = {
            name = 'Agua', index = 'agua',
            price = {
                buy = 250,
            },
            method = 'legal'
        },
        ['soda'] = {
            name = 'Soda', index = 'soda',
            price = {
                buy = 250,
            },
            method = 'legal'
        },
        ['radio'] = {
            name = 'Radio', index = 'radio',
            price = {
                buy = 500,
            },
            method = 'legal'
        },
        ['celular'] = {
            name = 'Celular', index = 'celular',
            price = {
                buy = 800,
            },
            method = 'legal'
        },
        ['kit-reparo'] = {
            name = 'Kit Reparo', index = 'kit-reparo',
            price = {
                buy = 7500,
            },
            method = 'legal'
        },
        ['par-alianca'] = {
            name = 'Par de alianças', index = 'par-alianca',
            price = {
                buy = 25000,
            },
            method = 'legal'
        },
        ['gps'] = {
            name = 'GPS', index = 'gps',
            price = {
                buy = 10000,
            },
            method = 'legal'
        },
        ['mochila-pequena'] = {
            name = 'Mochila Pequena', index = 'mochila-pequena',
            price = {
                buy = 500,
            },
            method = 'legal'
        },
        ['mochila-grande'] = {
            name = 'Mochila Grande', index = 'mochila-grande',
            price = {
                buy = 1750,
            },
            method = 'legal'
        },
        ['hotdog'] = {
            name = 'Hotdog', index = 'hotdog',
            price = {
                buy = 250,
            },
            method = 'legal'
        },
        ['racao'] = {
            name = 'Ração', index = 'racao',
            price = {
                buy = 100,
            },
            method = 'legal'
        },
        ['agua-animal'] = {
            name = 'Água para pets', index = 'agua-animal',
            price = {
                buy = 100,
            },
            method = 'legal'
        },
        ['petkit'] = {
            name = 'Kit veterinário', index = 'petkit',
            price = {
                buy = 100,
            },
            method = 'legal'
        },
    },
    ['ammu'] = {
        ['modificador-armas'] = {
            name = 'Modificador de Armas', index = 'modificador-armas',
            price = {
                buy = 15000
            },
            method = 'legal'
        },
        ['algema'] = {
            name = 'Algema', index = 'algema',
            price = {
                buy = 3500,
            },
            method = 'legal'
        },
        ['capuz'] = {
            name = 'Capuz', index = 'capuz',
            price = {
                buy = 3500,
            },
            method = 'legal'
        },
        ['weapon_ceramicpistol'] = {
            name = 'Pistola', index = 'weapon_ceramicpistol',
            price = {
                buy = 25000,
            },
            method = 'legal',
            perm = 'porte.permissao'
        },
        ['m_weapon_ceramicpistol'] = {
            name = 'M. Pistola', index = 'm_weapon_ceramicpistol',
            price = {
                buy = 500,
            },
            method = 'legal',
            perm = 'porte.permissao'
        },
    },
    ['bebidas'] = {
        ['cola'] = {
            name = 'Cola', index = 'cola',
            price = {
                buy = 250,
            },
            method = 'legal'
        },
        ['agua'] = {
            name = 'Água', index = 'agua',
            price = {
                buy = 250,
            },
            method = 'legal'
        },
        ['soda'] = {
            name = 'Soda', index = 'soda',
            price = {
                buy = 250,
            },
            method = 'legal'
        },
        ['vodka'] = {
            name = 'Vodka', index = 'vodka',
            price = {
                buy = 500,
            },
            method = 'legal'
        },
        ['whisky'] = {
            name = 'Whisky', index = 'whisky',
            price = {
                buy = 500,
            },
            method = 'legal'
        },
        ['cerveja'] = {
            name = 'Cerveja', index = 'cerveja',
            price = {
                buy = 500,
            },
            method = 'legal'
        },
        ['conhaque'] = {
            name = 'Conhaque', index = 'conhaque',
            price = {
                buy = 500,
            },
            method = 'legal'
        },
        ['tequila'] = {
            name = 'Tequila', index = 'tequila',
            price = {
                buy = 500,
            },
            method = 'legal'
        },
    }
}

config.blips = {
    ['departament'] = {
        sprite = 59,
        color = 0,
        scale = 0.7,
        name = 'Conveniência'
    },
    ['ammu'] = {
        sprite = 313,
        color = 0,
        scale = 0.7,
        name = 'Ammunation'
    },
    ['bebidas'] = {
        sprite = 93,
        color = 0,
        scale = 0.7,
        name = 'Loja de Bebidas'
    }
}

config.shops = {
    { name = 'Supermarket', type = 'buy', coord = vector3(25.64835, -1346.585, 29.48206), config = 'departament', blip = true },
    { name = 'Supermarket', type = 'buy', coord = vector3(2556.739, 382.0088, 108.6088), config = 'departament', blip = true },
    { name = 'Supermarket', type = 'buy', coord = vector3(1163.433, -323.0374, 69.19702), config = 'departament', blip = true },
    { name = 'Supermarket', type = 'buy', coord = vector3(-707.3802, -913.6879, 19.20361), config = 'departament', blip = true },
    { name = 'Supermarket', type = 'buy', coord = vector3(-1820.927, 793.1736, 138.0959), config = 'departament', blip = true },
    { name = 'Supermarket', type = 'buy', coord = vector3(374.0044, 326.9407, 103.5538), config = 'departament', blip = true },
    { name = 'Supermarket', type = 'buy', coord = vector3(-3243.112, 1001.235, 12.81763), config = 'departament', blip = true },
    { name = 'Supermarket', type = 'buy', coord = vector3(1729.358, 6415.53, 35.02563), config = 'departament', blip = true },
    { name = 'Supermarket', type = 'buy', coord = vector3(547.8989, 2670.356, 42.13623), config = 'departament', blip = true },
    { name = 'Supermarket', type = 'buy', coord = vector3(1960.747, 3741.323, 32.32971), config = 'departament', blip = true },
    { name = 'Supermarket', type = 'buy', coord = vector3(2677.899, 3280.879, 55.22852), config = 'departament', blip = true },
    { name = 'Supermarket', type = 'buy', coord = vector3(1698.448, 4924.141, 42.052), config = 'departament', blip = true },
    { name = 'Supermarket', type = 'buy', coord = vector3(-47.72308, -1757.248, 29.41467), config = 'departament', blip = true },
    { name = 'Supermarket', type = 'buy', coord = vector3(1392.462, 3604.945, 34.9751), config = 'departament', blip = true },
    { name = 'Supermarket', type = 'buy', coord = vector3(-3040.101, 585.4418, 7.897461), config = 'departament', blip = true },
    -- [Helipa] --
    { name = 'Supermarket', type = 'buy', coord = vector3(240.7253, 1870.787, 189.8923), config = 'departament' },
    -- [Polonia] --
    { name = 'Supermarket', type = 'buy', coord = vector3(3019.767, 2709.415, 74.42053), config = 'departament' },
    -- [Russia] --
    { name = 'Supermarket', type = 'buy', coord = vector3(1338.475, -689.9604, 73.08936), config = 'departament' },

    -- [ Iate Mohammed ] --
    { name = 'Iate', type = 'buy', coord = vector3(-1403.512, 6749.235, 11.89087), config = 'comidas_bebidas' },

    { name = 'Ammunation', type = 'buy', coord = vector3(1692.62, 3759.481, 34.6886), config = 'ammu', blip = true },
    { name = 'Ammunation', type = 'buy', coord = vector3(252.8703, -49.25275, 69.92163), config = 'ammu', blip = true },
    { name = 'Ammunation', type = 'buy', coord = vector3(843.2571, -1034.031, 28.18457), config = 'ammu', blip = true },
    { name = 'Ammunation', type = 'buy', coord = vector3(-331.3714, 6083.446, 31.43665), config = 'ammu', blip = true },
    { name = 'Ammunation', type = 'buy', coord = vector3(-663.1649, -934.9319, 21.81543), config = 'ammu', blip = true },
    { name = 'Ammunation', type = 'buy', coord = vector3(-1305.191, -393.4813, 36.67688), config = 'ammu', blip = true },
    { name = 'Ammunation', type = 'buy', coord = vector3(-1118.822, 2698.22, 18.54651), config = 'ammu', blip = true },
    { name = 'Ammunation', type = 'buy', coord = vector3(2568.818, 293.8813, 108.7267), config = 'ammu', blip = true },
    { name = 'Ammunation', type = 'buy', coord = vector3(-3172.695, 1087.094, 20.82129), config = 'ammu', blip = true },
    { name = 'Ammunation', type = 'buy', coord = vector3(21.29671, -1106.453, 29.7854), config = 'ammu', blip = true },
    { name = 'Ammunation', type = 'buy', coord = vector3(811.1736, -2157.679, 29.59998), config = 'ammu', blip = true },

    { name = 'Perls', type = 'buy', coord = vector3(1166.07, 2709.297, 38.14282), config = 'bebidas', blip = true },
    { name = 'Perls', type = 'buy', coord = vector3(-2967.956, 390.7385, 15.04175), config = 'bebidas', blip = true },
    { name = 'Perls', type = 'buy', coord = vector3(1135.648, -982.1406, 46.39929), config = 'bebidas', blip = true },
    { name = 'Perls', type = 'buy', coord = vector3(-1486.919, -379.3846, 40.14795), config = 'bebidas', blip = true },
    { name = 'Perls', type = 'buy', coord = vector3(-1222.998, -907.2132, 12.31213), config = 'bebidas', blip = true },
    { name = 'Perls', type = 'buy', coord = vector3(127.7934, -1284.593, 29.26306), config = 'bebidas', blip = true },
    { name = 'Perls', type = 'buy', coord = vector3(-560.2286, 286.1011, 82.17139), config = 'bebidas', blip = true },
    { name = 'Perls', type = 'buy', coord = vector3(1985.71, 3053.802, 47.20801), config = 'bebidas', blip = true },
}