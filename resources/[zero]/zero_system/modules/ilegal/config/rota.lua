Routes = {
    general = {
        ['Aviaozinho'] = {
            name = 'Aviaozinho',
            coords = {
                vector3(-1269.666, -1913.934, 5.858643),
                vector3(-1811.156, -1225.569, 13.01978),
                vector3(-1453.306, 417.2703, 109.8557),
                vector3(190.0088, 309.1516, 105.3737),
                vector3(143.9604, -689.2879, 33.12158),
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
                    payment = 2800,
                    receive = 'dinheirosujo'
                },
                {
                    item = 'cocaina',
                    quantity = 1,
                    payment = 2800,
                    receive = 'dinheirosujo'
                },
                {
                    item = 'metanfetamina',
                    quantity = 1,
                    payment = 2800,
                    receive = 'dinheirosujo'
                },
            },
            texts = {
                text = '~b~E~w~ - Entregar',
                progress = 'Entregando droga...'
            },
            extras = {
                anim = 'pegar',
                drug = true, -- Deixar true somente quando for rota de venda de droga.
                police = 70,
                timeout = 5000,
            }
        },
        ['Droga'] = {
            name = 'Droga',
            points = 1,
            coords = {
                vector3(-2002.18, -556.8132, 12.88501),
                vector3(-503.5385, 32.75605, 44.69739),
                vector3(900.4879, -1152.778, 26.06152),
                vector3(-598.7473, 147.033, 61.66516),
                vector3(-1177.688, -1185.112, 5.622681),
                vector3(-1245.376, 376.4572, 74.87549),
                vector3(-1380.857, 733.7802, 182.7817),
                vector3(-1380.857, 733.7802, 182.7817),
                vector3(-936.4088, 403.0681, 78.70032),
                vector3(-1471.187, -920.5055, 9.565552),
                vector3(368.7033, -1108.312, 28.92603),
                vector3(-1378.892, -499.5824, 32.68347),
                vector3(372.8571, -738.422, 28.79126),
                vector3(-1455.297, -691.1868, 25.85938) 
            },
            itens = {
                item = 'm-droga',
                quantity = 2
            },
            texts = {
                text = '~b~E~w~ - Pegar',
                progress = 'Pegando material para drogas...'
            },
            extras = {
                anim = 'pegar',
                police = 30,
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
                quantity = 2
            },
            texts = {
                text = '~b~E~w~ - Pegar',
                progress = 'Coletando ingredientes...'
            },
            extras = {
                anim = 'pegar',
                timeout = 5000,
            }
        },
        ['Arma'] = {
            name = 'Arma',
            points = 1,
            coords = {
                vector3(939.7714, -1866.725, 32.46448),
                vector3(-295.4373, -827.9473, 32.41394),
                vector3(-2223.231, -365.9077, 13.30627),
                vector3(-3147.561, 1121.512, 20.87183),
                vector3(-2521.108, 2310.369, 33.20581),
                vector3(-2511.244, 3616.8, 13.64319),
                vector3(-2976.897, 1586.44, 24.00586),
                vector3(-2678.268, -28.65494, 15.7832),
                vector3(-1327.543, -683.3934, 26.4491),
                vector3(447.7451, -898.7077, 28.67322),
                vector3(263.4198, -2507.156, 6.431519),
                vector3(1349.908, -1571.789, 54.04907),
                vector3(642.3428, 104.0835, 89.48425),
                vector3(-342.5011, -1464.396, 30.61096)
            },
            itens = {
                item = 'p-armas',
                quantity = 2
            },
            texts = {
                text = '~b~E~w~ - Pegar',
                progress = 'Coletando peças de arma...'
            },
            extras = {
                anim = 'pegar',
                police = 50,
                timeout = 5000,
            }
        },
        ['Municao'] = {
            name = 'Municao',
            points = 1,
            coords = {
                vector3(520.1934, -1652.598, 29.56628),
                vector3(-812.4923, -980.6506, 14.24988),
                vector3(-1579.147, 184.9187, 58.85132),
                vector3(-396.6198, 877.7011, 230.7869),
                vector3(435.811, 215.3011, 103.1494),
                vector3(980.0571, -1396.813, 31.67249),
                vector3(2560.932, -599.1824, 65.052),
                vector3(1432.048, -1682.703, 64.79932),
                vector3(-75.53406, -1423.727, 29.61682),
                vector3(-69.19121, 63.74506, 71.87622),
                vector3(-1393.134, -733.3846, 24.7135),
                vector3(382.2593, -1076.308, 29.41467),
                vector3(-528.4879, -1784.585, 21.57947),
                vector3(488.822, -801.4418, 24.98315),
            },
            itens = {
                item = 'm-municoes',
                quantity = 2
            },
            texts = {
                text = '~b~E~w~ - Pegar',
                progress = 'Coletando materiais para munições...'
            },
            extras = {
                anim = 'pegar',
                police = 50,
                timeout = 5000,
            }
        },
        ['Mecanica'] = {
            name = 'Mecanica',
            points = 1,
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
                quantity = 2
            },
            texts = {
                text = '~b~E~w~ - Pegar',
                progress = 'Coletando materiais para mecânica...'
            },
            extras = {
                anim = 'pegar',
                timeout = 5000,
            }
        },
        ['Lavagem'] = { 
            name = 'Lavagem',
            points = 1,
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
                quantity = 2
            },
            texts = {
                text = '~b~E~w~ - Pegar',
                progress = 'Coletando nota-fiscal...'
            },
            extras = {
                anim = 'pegar',
                police = 50,
                timeout = 5000,
            }
        }
    },

    locations = {
        { coord = vector3(-1857.007, -1234.985, 8.605103), config = 'Droga', cooldown = 300, perm = 'droga.permissao' },
        { coord = vector3(2.69011, -1215.073, 26.88721), config = 'Aviaozinho', cooldown = 300, notPerm = 'droga.permissao' },
        { coord = vector3(-1855.332, -1204.009, 13.00293), config = 'ZeroFome', cooldown = 300, perm = 'zerofome.permissao' },
        { coord = vector3(28.45715, -2669.842, 12.04248), config = 'Arma', cooldown = 300, perm = 'arma.permissao' },
        { coord = vector3(-317.0769, -2778.752, 4.999268), config = 'Municao', cooldown = 300, perm = 'municao.permissao' },
        { coord = vector3(-352.0615, -172.2198, 39.0022), config = 'Mecanica', cooldown = 300, perm = 'zeromecanica.permissao' },
        { coord = vector3(-1086.646, -247.8461, 37.75537), config = 'Lavagem', cooldown = 300, perm = 'lavagem.permissao' },
    }
}