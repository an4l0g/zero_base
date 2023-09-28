Routes = {
    general = {
        ['Aviaozinho'] = {
            name = 'Aviaozinho',
            coords = {
                vector3(447.7451, -898.6945, 28.67322),
                vector3(1119.771, -983.9077, 46.28137),
                vector3(474.8044, -1457.011, 29.27991),
                vector3(-324.2374, -1356.211, 31.28503),
                vector3(65.53846, -137.4989, 55.09375),
                vector3(-1270.484, -305.011, 37.06445),
                vector3(-1289.67, -851.7626, 14.94067),
                vector3(-271.8857, -694.1407, 34.26746),
                vector3(134.9802, -1494.145, 29.12817),
                vector3(-582.4484, -1744.18, 22.422),
                vector3(-812.1494, -980.2286, 14.26672),
                vector3(-1151.314, -163.7011, 40.08057),
                vector3(-756.5802, 240.7912, 75.65051),
                vector3(352.6022, -142.9055, 66.6864),
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
                police = 80,
                timeout = 5000,
            }
        },
        ['Droga'] = {
            name = 'Droga',
            points = 1,
            coords = {
                vector3(-1311.758, -1336.945, 4.62854),
                vector3(-714.6198, -676.2593, 30.61096),
                vector3(144.1055, -688.8527, 33.12158),
                vector3(494.0703, -729.5868, 24.88208),
                vector3(520.1011, -1652.242, 29.51575),
                vector3(-163.6483, -1456.18, 31.6051),
                vector3(-272.4659, -602.0044, 33.54285),
                vector3(-379.3978, 217.9648, 83.65417),
                vector3(-1409.182, -109.345, 51.63953),
                vector3(-473.4857, -93.98241, 39.70984),
                vector3(548.334, -202.5626, 54.47034),
                vector3(-169.833, 285.4022, 93.74731),
                vector3(-295.3451, -827.8417, 32.41394),
                vector3(-915.4945, -1168.971, 4.864502),
            },
            itens = {
                item = 'm-droga',
                quantity = 5
            },
            texts = {
                text = '~b~E~w~ - Pegar',
                progress = 'Pegando material para drogas...'
            },
            extras = {
                anim = 'pegar',
                police = 80,
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
                quantity = 5
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
                vector3(370.5099, -2452.299, 6.684204),
                vector3(226.7473, -1791.719, 28.65637),
                vector3(-174.1978, -1289.446, 31.28503),
                vector3(-365.156, -639.8242, 31.48718),
                vector3(-674.2286, -123.7582, 37.85645),
                vector3(-88.87912, 215.1297, 96.40955),
                vector3(253.4901, -343.8066, 44.51208),
                vector3(329.1692, -964.9451, 29.41467),
                vector3(243.9165, -1492.892, 29.27991),
                vector3(721.978, -2016.29, 29.41467),
                vector3(801.9692, -2503.213, 22.21973),
                vector3(247.0549, -2043.231, 17.97363),
                vector3(-128.1099, -1779.56, 29.81909),
                vector3(29.86813, -2637.758, 6.043945),
            },
            itens = {
                item = 'p-armas',
                quantity = 5
            },
            texts = {
                text = '~b~E~w~ - Pegar',
                progress = 'Coletando peças de arma...'
            },
            extras = {
                anim = 'pegar',
                police = 80,
                timeout = 5000,
            }
        },
        ['Municao'] = {
            name = 'Municao',
            points = 1,
            coords = {
                vector3(370.4572, -2452.299, 6.684204),
                vector3(174.9363, -2025.481, 18.31067),
                vector3(-156.3692, -1348.523, 29.90332),
                vector3(-272.4395, -602.0044, 33.54285),
                vector3(193.2264, 103.7407, 93.54504),
                vector3(1144.563, -299.1429, 68.87695),
                vector3(1218.435, -1235.802, 35.32898),
                vector3(787.0813, -1770.527, 29.27991),
                vector3(-111.0066, -1459.952, 33.57654),
                vector3(-582.6198, -1744.062, 22.43884),
                vector3(-1038.686, -756.4879, 19.82715),
                vector3(144.1846, -688.8659, 33.12158),
                vector3(520.4176, -1652.545, 29.29675),
                vector3(925.1736, -2349.864, 31.80737),
            },
            itens = {
                item = 'm-municoes',
                quantity = 5
            },
            texts = {
                text = '~b~E~w~ - Pegar',
                progress = 'Coletando materiais para munições...'
            },
            extras = {
                anim = 'pegar',
                police = 80,
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
                quantity = 5
            },
            texts = {
                text = '~b~E~w~ - Pegar',
                progress = 'Coletando materiais para mecânica...'
            },
            extras = {
                anim = 'pegar',
                police = 80,
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
        { coord = vector3(146.611, -3007.859, 7.038086), config = 'Mecanica', cooldown = 300, perm = 'zeromecanica.permissao' },
        { coord = vector3(-1086.646, -247.8461, 37.75537), config = 'Lavagem', cooldown = 300, perm = { '+Hospital.Medico', 'lavagem.permissao' } },
    }
}