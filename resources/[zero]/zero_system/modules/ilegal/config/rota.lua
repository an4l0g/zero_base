Routes = {
    general = {
        ['Aviaozinho'] = {
            name = 'Aviaozinho',
            coords = {
                vector3(-1269.666, -1913.934, 5.858643),
                vector3(-1811.156, -1225.569, 13.01978),
                vector3(-1453.306, 417.2703, 109.8557),
                vector3(190.0088, 309.1516, 105.3737),
                vector3(-740.9275, 5571.93, 36.69373),
                vector3(1154.532, -785.3538, 57.58752),
                vector3(869.7231, -2326.932, 30.59412),
                vector3(-517.4374, -2904.277, 5.993408),
                vector3(-1079.143, -2726.202, 14.38464),
                vector3(-546.0527, -873.5472, 27.19043),
                vector3(313.5428, -174.5275, 58.10986),
                vector3(-85.7934, 357.1121, 112.4337),
                vector3(-1649.604, 248.7692, 62.38977),
                vector3(-191.3802, -1179.02, 23.06226),
            },
            itens = {
                {
                    item = 'maconha',
                    quantity = 1,
                    payment = 1400,
                    receive = 'dinheirosujo'
                },
                {
                    item = 'cocaina',
                    quantity = 1,
                    payment = 1400,
                    receive = 'dinheirosujo'
                },
                {
                    item = 'metanfetamina',
                    quantity = 1,
                    payment = 1400,
                    receive = 'dinheirosujo'
                },
            },
            texts = {
                text = '~b~E~w~ - Entregar',
                progress = 'Entregando droga...'
            },
            extras = {
                anim = 'mexer',
                drug = true, -- Deixar true somente quando for rota de venda de droga.
                police = 70,
                timeout = 5000,
            }
        },
        ['Droga'] = {
            name = 'Droga',
            coords = {
                vector3(-2002.339, -556.8791, 12.88501),
                vector3(-3109.081, 751.8726, 24.69666),
                vector3(-2521.081, 2310.369, 33.20581),
                vector3(-2311.714, 4385.42, 8.453491),
                vector3(-740.9275, 5571.93, 36.69373),
                vector3(1089.165, 6511.886, 21.07397),
                vector3(2195.512, 5593.53, 53.7627),
                vector3(2660.888, 3927.283, 42.15308),
                vector3(2327.934, 2569.728, 46.66882),
                vector3(2589.64, 482.8747, 108.6593),
                vector3(2484.264, -417.4418, 93.73047),
                vector3(1021.675, -1694.809, 33.55969),
                vector3(-200.5582, -1708.127, 32.64978),
                vector3(-876.2901, -1074.87, 2.151611),
            },
            itens = {
                item = 'm-droga',
                quantity = 1
            },
            texts = {
                text = '~b~E~w~ - Pegar',
                progress = 'Pegando material para drogas...'
            },
            extras = {
                anim = 'mexer',
                police = 70,
                timeout = 5000,
            }
        },
        ['ZeroFome'] = {
            name = 'Zero Fome',
            coords = {
                vector3(-1343.71, -240.9363, 42.67542),
                vector3(-602.1362, -1105.727, 22.32092),
                vector3(410.4791, -1910.031, 25.43811),
                vector3(281.2747, -801.1912, 29.3136),
                vector3(-838.5758, -607.6219, 29.01025),
                vector3(-1191.495, -1546.378, 4.359009),
                vector3(54.54066, -799.2527, 31.57141),
                vector3(81.09891, 274.4835, 110.1926),
                vector3(1241.552, -366.844, 69.0791),
                vector3(-242.5055, 279.7451, 92.02856),
                vector3(-1251.125, -294.9362, 37.33411),
                vector3(-1040.004, -1353.719, 5.538452),
                vector3(-1471.767, -135.5604, 51.10034),
                vector3(-1278.91, -876.2901, 11.92456),
            },
            itens = {
                item = 'c-ingredientes',
                quantity = 1
            },
            texts = {
                text = '~b~E~w~ - Pegar',
                progress = 'Coletando ingredientes...'
            },
            extras = {
                anim = 'mexer',
                police = 0,
                timeout = 5000,
            }
        },
        ['Arma'] = {
            name = 'Arma',
            coords = {
                vector3(1239.64, -3173.499, 7.088623),
                vector3(-458.8352, -2274.765, 8.504028),
                vector3(-1324.589, -1515.745, 4.426392),
                vector3(-2223.125, -365.5912, 13.30627),
                vector3(-3418.47, 971.3406, 11.92456),
                vector3(-1121.103, 2712.145, 18.8667),
                vector3(-1146.567, 4940.888, 222.2609),
                vector3(125.7231, 6644.044, 31.79053),
                vector3(1538.941, 6321.917, 25.06738),
                vector3(3309.798, 5189.815, 19.70911),
                vector3(2854.866, 1501.991, 24.7135),
                vector3(2503.807, -340.378, 92.98901),
                vector3(1743.93, -1622.809, 116.1912),
                vector3(900.4879, -2534.123, 28.28577),
            },
            itens = {
                item = 'p-armas',
                quantity = 1
            },
            texts = {
                text = '~b~E~w~ - Pegar',
                progress = 'Coletando peças de arma...'
            },
            extras = {
                anim = 'mexer',
                police = 0,
                timeout = 5000,
            }
        },
        ['Municao'] = {
            name = 'Municao',
            coords = {
                vector3(-1175.13, -2468.901, 15.44617),
                vector3(-1183.042, -1557.152, 4.915039),
                vector3(-2040.132, -358.7604, 22.48938),
                vector3(-2958.884, 426.8967, 18.79932),
                vector3(-2550.316, 2302.193, 33.20581),
                vector3(-1600.629, 5204.255, 4.308472),
                vector3(-425.4857, 6356.453, 13.32312),
                vector3(1417.398, 6339.205, 24.39343),
                vector3(3808.035, 4478.637, 6.364136),
                vector3(2461.2, 1575.6, 33.10474),
                vector3(2460.25, -384.0659, 93.3092),
                vector3(1075.49, -2330.651, 30.29089),
                vector3(1236.949, -2948.545, 9.312866),
                vector3(-98.30769, -2358.013, 9.363403),
            },
            itens = {
                item = 'm-municoes',
                quantity = 1
            },
            texts = {
                text = '~b~E~w~ - Pegar',
                progress = 'Coletando materiais para munições...'
            },
            extras = {
                anim = 'mexer',
                police = 0,
                timeout = 5000,
            }
        },
        ['Mecanica'] = {
            name = 'Mecanica',
            coords = {
                vector3(818.0967, -1040.835, 26.73547),
                vector3(-702.7912, -916.8659, 19.20361),
                vector3(-1829.143, 801.0725, 138.3993),
                vector3(-2073.059, -327.3099, 13.30627),
                vector3(-544.2989, -1227.6, 18.44543),
                vector3(1205.341, -1385.974, 35.21094),
                vector3(-342.5143, -1468.431, 30.59412),
                vector3(639.0593, 254.7824, 103.1494),
                vector3(-1408.734, -271.1472, 46.38245),
                vector3(289.4637, -1266.765, 29.43152),
                vector3(544.3384, -173.1033, 54.47034),
                vector3(166.8264, -1553.341, 29.24609),
                vector3(1160.743, -312.1846, 69.34875),
                vector3(-232.3648, -1311.996, 31.28503),
            },
            itens = {
                item = 'm-mec',
                quantity = 1
            },
            texts = {
                text = '~b~E~w~ - Pegar',
                progress = 'Coletando materiais para mecânica...'
            },
            extras = {
                anim = 'mexer',
                police = 0,
                timeout = 5000,
            }
        },
        ['Lavagem'] = {
            name = 'Lavagem',
            coords = {
                vector3(425.5253, -806.8088, 29.48206),
                vector3(-1216.352, -336, 37.77222),
                vector3(308.0308, -279.6396, 54.15015),
                vector3(-821.8549, -1073.314, 11.31799),
                vector3(374.3868, 328.6813, 103.5538),
                vector3(75.42857, -1392.105, 29.36414),
                vector3(-709.7802, -153.2308, 37.40149),
                vector3(25.67473, -1344.884, 29.48206),
                vector3(-821.9473, -184.8264, 37.5531),
                vector3(1163.815, -324.6725, 69.19702),
                vector3(133.9516, -1709.182, 29.27991),
                vector3(125.8022, -223.556, 54.55457),
                vector3(-1193.261, -768.1187, 17.31653),
                vector3(143.5648, -1041.481, 29.36414),
            },
            itens = {
                item = 'nota-fiscal',
                quantity = 1
            },
            texts = {
                text = '~b~E~w~ - Pegar',
                progress = 'Coletando nota-fiscal...'
            },
            extras = {
                anim = 'mexer',
                police = 0,
                timeout = 5000,
            }
        }
    },

    locations = {
        { coord = vector3(2.69011, -1215.073, 26.88721), config = 'Aviaozinho', cooldown = 900 },
        { coord = vector3(-1855.332, -1204.009, 13.00293), config = 'ZeroFome', cooldown = 900 },
        { coord = vector3(28.45715, -2669.842, 12.04248), config = 'Arma', cooldown = 900 },
        { coord = vector3(-317.0769, -2778.752, 4.999268), config = 'Municao', cooldown = 900 },
        { coord = vector3(-352.0615, -172.2198, 39.0022), config = 'Mecanica', cooldown = 900 },
        { coord = vector3(-1086.646, -247.8461, 37.75537), config = 'Lavagem', cooldown = 900 },
    }
}