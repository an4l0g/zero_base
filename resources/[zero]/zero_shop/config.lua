Tunnel = module('zero', 'lib/Tunnel')
Proxy = module('zero', 'lib/Proxy')
zero = Proxy.getInterface('zero')

config = {}

config.general = {
    ['departament'] = {
        ['algema'] = {
            name = 'Algema', index = 'algema',
            price = {
                buy = 5000,
                sell = 2000
            },
            method = 'legal'
        },
        ['spray'] = {
            name = 'Spray', index = 'spray',
            price = {
                buy = 5000,
                sell = 2000
            },
            method = 'legal'
        },
        ['nitro'] = {
            name = 'Nitro', index = 'nitro',
            price = {
                buy = 5000,
                sell = 2000
            },
            method = 'ilegal'
        }
    }
}

config.shops = {
        { name = 'Supermarket', type = 'all', coord = vector3(25.64835, -1346.585, 29.48206), config = 'departament' },
    { name = 'Supermarket', type = 'all', coord = vector3(2556.739, 382.0088, 108.6088), config = 'departament' },
    { name = 'Supermarket', type = 'all', coord = vector3(1163.433, -323.0374, 69.19702), config = 'departament' },
    { name = 'Supermarket', type = 'all', coord = vector3(-707.3802, -913.6879, 19.20361), config = 'departament' },
    { name = 'Supermarket', type = 'all', coord = vector3(-1820.927, 793.1736, 138.0959), config = 'departament' },
    { name = 'Supermarket', type = 'all', coord = vector3(374.0044, 326.9407, 103.5538), config = 'departament' },
    { name = 'Supermarket', type = 'all', coord = vector3(-3243.112, 1001.235, 12.81763), config = 'departament' },
    { name = 'Supermarket', type = 'all', coord = vector3(1729.358, 6415.53, 35.02563), config = 'departament' },
    { name = 'Supermarket', type = 'all', coord = vector3(547.8989, 2670.356, 42.13623), config = 'departament' },
    { name = 'Supermarket', type = 'all', coord = vector3(1960.747, 3741.323, 32.32971), config = 'departament' },
    { name = 'Supermarket', type = 'all', coord = vector3(2677.899, 3280.879, 55.22852), config = 'departament' },
    { name = 'Supermarket', type = 'all', coord = vector3(1698.448, 4924.141, 42.052), config = 'departament' },
    { name = 'Supermarket', type = 'all', coord = vector3(-47.72308, -1757.248, 29.41467), config = 'departament' },
    { name = 'Supermarket', type = 'all', coord = vector3(1392.462, 3604.945, 34.9751), config = 'departament' },
    { name = 'Supermarket', type = 'all', coord = vector3(-3040.101, 585.4418, 7.897461), config = 'departament' },
    { name = 'Ammunation', type = 'all', coord = vector3(1692.62, 3759.481, 34.6886), config = 'ammu' },
    { name = 'Ammunation', type = 'all', coord = vector3(252.8703, -49.25275, 69.92163), config = 'ammu' },
    { name = 'Ammunation', type = 'all', coord = vector3(843.2571, -1034.031, 28.18457), config = 'ammu' },
    { name = 'Ammunation', type = 'all', coord = vector3(-331.3714, 6083.446, 31.43665), config = 'ammu' },
    { name = 'Ammunation', type = 'all', coord = vector3(-663.1649, -934.9319, 21.81543), config = 'ammu' },
    { name = 'Ammunation', type = 'all', coord = vector3(-1305.191, -393.4813, 36.67688), config = 'ammu' },
    { name = 'Ammunation', type = 'all', coord = vector3(-1118.822, 2698.22, 18.54651), config = 'ammu' },
    { name = 'Ammunation', type = 'all', coord = vector3(2568.818, 293.8813, 108.7267), config = 'ammu' },
    { name = 'Ammunation', type = 'all', coord = vector3(-3172.695, 1087.094, 20.82129), config = 'ammu' },
    { name = 'Ammunation', type = 'all', coord = vector3(21.29671, -1106.453, 29.7854), config = 'ammu' },
    { name = 'Ammunation', type = 'all', coord = vector3(811.1736, -2157.679, 29.59998), config = 'ammu' },
    { name = "Perls", type = 'all', coord = vector3(1166.07, 2709.297, 38.14282), config = 'bebidas' },
    { name = "Perls", type = 'all', coord = vector3(-2967.956, 390.7385, 15.04175), config = 'bebidas' },
    { name = "Perls", type = 'all', coord = vector3(1135.648, -982.1406, 46.39929), config = 'bebidas' },
    { name = "Perls", type = 'all', coord = vector3(-1486.919, -379.3846, 40.14795), config = 'bebidas' },
    { name = "Perls", type = 'all', coord = vector3(-1222.998, -907.2132, 12.31213), config = 'bebidas' },
    { name = "Perls", type = 'all', coord = vector3(127.7934, -1284.593, 29.26306), config = 'bebidas' },
    { name = "Perls", type = 'all', coord = vector3(-560.2286, 286.1011, 82.17139), config = 'bebidas' },
    { name = "Perls", type = 'all', coord = vector3(1985.71, 3053.802, 47.20801), config = 'bebidas' },
}