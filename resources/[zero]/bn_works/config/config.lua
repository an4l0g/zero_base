config = {}

config.works = {
    ['Costureira'] = {
        ['name'] = 'Darnell Bros',
        ['text'] = '~g~E~w~ - ENTREGAR', ['blipWithCar'] = false,
        ['requireItem'] = { 
            ['spawn'] = 'caixa-roupa',
            ['quantity'] = 1
        },
        ['payment'] = { 
            ['money'] = { ['min'] = 2000, ['max'] = 3000 },
            ['bonus'] = { ['after'] = 7, ['multiply'] = 1.5 }
        },
        ['anim'] = 'caixa',
        ['vehicle'] = 'bison3',
        ['routes'] = {
            vector3(71.11, -1391.08, 29.38),
            vector3(429.69, -807.53, 29.5),
            vector3(117.38, -234.42, 54.56),
            vector3(-168.71, -300.6, 39.74),
            vector3(-823.55, -1069.39, 11.33),
            vector3(-704.68, -150.48, 37.42),
            vector3(-1180.37, -763.56, 17.33),
            vector3(-1446.38, -241.69, 49.83),
            vector3(-3179.63, 1033.66, 20.87),
            vector3(-1103.3, 2714.41, 19.11),
            vector3(617.43, 2775.93, 42.09),
            vector3(1197.73, 2714.32, 38.23),
            vector3(1698.07, 4822.38, 42.07),
            vector3(6.86, 6508.85, 31.88)
        },
        ['setTimeOut'] = 10000
    },
    ['Entregador'] = {
        ['name'] = 'Post OP',
        ['text'] = '~g~E~w~ - ENTREGAR', ['blipWithCar'] = false,
        ['requireItem'] = { 
            ['spawn'] = 'encomenda-postop',
            ['quantity'] = 1
        },
        ['payment'] = { 
            ['money'] = { ['min'] = 2000, ['max'] = 3000 },
            ['bonus'] = { ['after'] = 6, ['multiply'] = 1.5 }
        },
        ['anim'] = 'caixa',
        ['vehicle'] = 'boxville4',
        ['routes'] = {
            vector3(853.25, -2432.67, 28.08),
            vector3(918.5, -1262.36, 25.55),
            vector3(1001.28, -510.49, 60.7),
            vector3(514.39, 167.61, 99.37),
            vector3(-181.99, 219.18, 88.81),
            vector3(-43.32, -380.38, 38.12),
            vector3(-524.61, -1230.53, 18.46),
            vector3(-1247.41, -1198.95, 7.72),
            vector3(-522.87, -602.63, 30.45),
            vector3(-208.65, 21.01, 56.08),
            vector3(-769.01, 469.82, 100.18),
            vector3(-1152.45, -202.65, 37.96),
        },
        ['setTimeOut'] = 10000
    },
    ['Carteiro'] = {
        ['name'] = 'GO Postal',
        ['text'] = '~g~E~w~ - ENTREGAR', ['blipWithCar'] = false,
        ['requireItem'] = { 
            ['spawn'] = 'encomenda-gopostal',
            ['quantity'] = 1
        },
        ['payment'] = { 
            ['money'] = { ['min'] = 2000, ['max'] = 3000 },
            ['bonus'] = { ['after'] = 5, ['multiply'] = 1.5 }
        },
        ['anim'] = 'enviar',
        ['vehicle'] = 'boxville2',
        ['routes'] = {
            vector3(296.75, -230.73, 54.0),
            vector3(-378.9, 117.94, 65.82),
            vector3(-380.04, 510.49, 119.93),
            vector3(540.98, 88.16, 96.3),
            vector3(1166.1, -288.78, 69.03),
            vector3(1264.01, -513.27, 69.1),
            vector3(1185.5, -530.27, 64.84),
            vector3(528.07, 101.19, 96.34),
            vector3(208.82, -335.17, 44.03),
            vector3(-390.07, -235.44, 36.05)
        },
        ['setTimeOut'] = 10000
    },
    ['YellowJack'] = {
        ['name'] = 'Yellow Jack',
        ['text'] = '~g~E~w~ - ENTREGAR', ['blipWithCar'] = false,
        ['requireItem'] = { 
            ['spawn'] = 'caixa-bebidas',
            ['quantity'] = 1
        },
        ['payment'] = { 
            ['money'] = { ['min'] = 3500, ['max'] = 4500 },
            ['bonus'] = { ['after'] = 3, ['multiply'] = 1.5 }
        },
        ['anim'] = 'caixa',
        ['vehicle'] = 'boxville',
        ['routes'] = {
            vector3(1164.76, 2713.7, 38.16),
            vector3(-2963.38, 391.99, 15.05),
            vector3(-1485.1, -375.12, 40.17),
            vector3(-1219.33, -910.01, 12.33),
            vector3(1131.38, -984.08, 46.42)
        },
        ['setTimeOut'] = 10000
    },
    ['Gas'] = {
        ['name'] = 'Heavy Flow',
        ['text'] = '~g~E~w~ - TROCAR O GÁS', ['blipWithCar'] = false,
        ['requireItem'] = { 
            ['spawn'] = 'botijao-cheio',
            ['quantity'] = 1
        },
        ['payment'] = { 
            ['money'] = { ['min'] = 4000, ['max'] = 4800 },
            ['bonus'] = { ['after'] = 6, ['multiply'] = 1.5 }
        },
        ['anim'] = 'arrumar',
        ['vehicle'] = 'bison2',
        ['routes'] = {
            vector3(244.88, 2595.25, 45.1),
            vector3(1166.54, 2729.19, 38.01),
            vector3(2517.16, 2594.1, 37.95),
            vector3(2545.42, 374.06, 108.62),
            vector3(1173.45, -1490.93, 34.7),
            vector3(27.1, -1465.23, 30.41),
            vector3(-175.29, -1313.09, 32.3),
            vector3(-272.12, -774.26, 32.26),
            vector3(-695.91, -374.16, 34.22),
            vector3(-1299.14, -389.08, 36.52),
            vector3(-2057.49, -301.25, 13.32),
            vector3(-3064.14, 633.98, 7.36)
        },
        ['setTimeOut'] = 20000,
    },
    ['Pedreiro'] = {
        ['name'] = 'STD Contractors',
        ['text'] = '~g~E~w~ - CONSERTAR', ['blipWithCar'] = false,
        ['payment'] = { 
            ['money'] = { ['min'] = 500, ['max'] = 1000 },
            ['bonus'] = { ['after'] = 5, ['multiply'] = 1.5 }
        },
        ['anim'] = 'martelo',
        ['routes'] = {
            vector3(110.13, -381.4, 41.77),
            vector3(82.72, -360.5, 42.49),
            vector3(72.77, -337.82, 43.23),
            vector3(50.01, -348.77, 42.53),
            vector3(26.54, -428.71, 39.93),
            vector3(36.22, -456.86, 39.93),
            vector3(80.03, -422.84, 37.56),
            vector3(99.01, -416.17, 37.56),
            vector3(83.35, -458.82, 37.56),
            vector3(51.92, -411.55, 39.93)
        },
        ['setTimeOut'] = 10000,
    },
    ['Eletricista'] = {
        ['name'] = 'LSDWP',
        ['text'] = '~g~E~w~ - CONSERTAR', ['blipWithCar'] = false,
        ['requireItem'] = { 
            ['spawn'] = 'ferramentas',
            ['quantity'] = 1
        },
        ['payment'] = { 
            ['money'] = { ['min'] = 3500, ['max'] = 4000 },
            ['bonus'] = { ['after'] = 5, ['multiply'] = 1.5 }
        },
        ['vehicle'] = 'utillitruck',
        ['anim'] = 'arrumar',
        ['routes'] = {
            vector3(408.34, 134.42, 101.73),
            vector3(-17.47, 77.33, 74.9),
            vector3(43.48, -15.27, 69.49),
            vector3(49.85, -301.88, 47.48),
            vector3(215.66, -651.74, 38.57),
            vector3(-106.92, -741.64, 34.7),
            vector3(-287.92, -398.2, 30.43),
            vector3(-661.8, -210.02, 37.36),
            vector3(-525.88, -14.58, 44.46),
            vector3(-517.89, -805.88, 30.76),
        },
        ['setTimeOut'] = 20000,
    },
    ['Gari'] = {
        ['name'] = 'South L.S Recycling',
        ['text'] = '~g~E~w~ - VARRER', ['blipWithCar'] = false,
        ['payment'] = { 
            ['money'] = { ['min'] = 3500, ['max'] = 4000 },
            ['bonus'] = { ['after'] = 6, ['multiply'] = 1.5 }
        },
        ['vehicle'] = 'caddy',
        ['anim'] = 'varrer',
        ['routes'] = {
            vector3(-539.31, -1215.97, 18.46),
            vector3(-787.39, -1142.71, 10.6),
            vector3(-1106.66, -1365.58, 5.15), 
            vector3(-1236.46, -1458.18, 4.26),
            vector3(-1304.34, -1379.3, 4.5),
            vector3(-1291.98, -1147.43, 5.6),
            vector3(-1138.17, -921.91, 2.65),
            vector3(-846.06, -798.53, 19.44),
            vector3(-585.9, -750.04, 29.49),
            vector3(-331.65, -931.4, 31.09),
            vector3(-195.92, -1179.0, 23.08),
            vector3(247.08, -791.99, 30.44)
        },
        ['setTimeOut'] = 5000,
    },
}

config.locs = {
    { 
        ['coord'] = vector3(720.99, -965.66, 30.4), 
        ['work'] = 'Costureira',
        ['url'] = 'https://i.imgur.com/mJ5hejb.png'
    },
    {
        ['coord'] = vector3(1197.2, -3253.5, 7.1),
        ['work'] = 'Entregador',
        ['url'] = 'https://i.imgur.com/cuDz4pk.png'
    },
    {
        ['coord'] = vector3(133.14, 96.56, 83.51),
        ['work'] = 'Carteiro',
        ['url'] = 'https://i.imgur.com/wDVSghK.png'
    },
    {
        ['coord'] = vector3(1987.57, 3051.1, 47.22),
        ['work'] = 'YellowJack',
        ['url'] = 'https://i.imgur.com/JzObkPi.png'
    },
    {
        ['coord'] = vector3(914.77, 3567.27, 33.8),
        ['work'] = 'Gas',
        ['url'] = 'https://i.imgur.com/jszJHBW.png'
    },
    {
        ['coord'] = vector3(141.59, -379.7, 43.26),
        ['work'] = 'Pedreiro',
        ['url'] = 'https://i.imgur.com/wx6ZEXR.jpeg'
    },
    {
        ['coord'] = vector3(718.85, 152.68, 80.76),
        ['work'] = 'Eletricista',
        ['url'] = 'https://i.imgur.com/KnalYKy.png'
    },
    {
        ['coord'] = vector3(-355.15, -1513.39, 27.72),
        ['work'] = 'Gari',
        ['url'] = 'https://i.imgur.com/KxrfgM4.png'
    }
}