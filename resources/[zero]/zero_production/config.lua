Proxy = module('zero', 'lib/Proxy')
Tunnel = module('zero', 'lib/Tunnel')
zero = Proxy.getInterface('zero')

configs = {}

configs.moneyPerFiscal = 20000
configs.governTax = 0.30
configs.governTaxWithBuff = 0.20
configs.blipDistance = 3

configs.products = {
    ['guns'] = {
        ['weapon_pistol_mk2'] = { 
            order = 1,
            name = 'Five-SeveN',
            amount = 1,
            delay = 10000,
            materials = {
                ['p-armas'] = { name = 'P. Armas', amount = 21 },
            }
        },
        ['weapon_snspistol_mk2'] = { 
            order = 2,
            name = 'HK 45',
            amount = 1,
            delay = 10000,
            materials = {
                ['p-armas'] = { name = 'P. Armas', amount = 21 },
            }
        },
        ['weapon_revolver_mk2'] = { 
            order = 3,
            name = 'R8',
            amount = 1,
            delay = 10000,
            materials = {
                ['p-armas'] = { name = 'P. Armas', amount = 21 },
            }
        },
        ['weapon_tecpistol'] = { 
            order = 4,
            name = 'Uzi',
            amount = 1,
            delay = 10000,
            materials = {
                ['p-armas'] = { name = 'P. Armas', amount = 35 },
            }
        },
        ['weapon_machinepistol'] = { 
            order = 5,
            name = 'Tec-9',
            amount = 1,
            delay = 10000,
            materials = {
                ['p-armas'] = { name = 'P. Armas', amount = 35 },
            }
        },
        ['weapon_minismg'] = { 
            order = 6,
            name = 'S VZ 61',
            amount = 1,
            delay = 10000,
            materials = {
                ['p-armas'] = { name = 'P. Armas', amount = 35 },
            }
        },
        ['weapon_specialcarbine_mk2'] = { 
            order = 7,
            name = 'H&K G36C',
            amount = 1,
            delay = 10000,
            materials = {
                ['p-armas'] = { name = 'P. Armas', amount = 49 },
            }
        },
        ['weapon_heavyrifle'] = { 
            order = 7,
            name = 'FN Scar',
            amount = 1,
            delay = 10000,
            materials = {
                ['p-armas'] = { name = 'P. Armas', amount = 49 },
            }
        },
        ['weapon_bullpuprifle_mk2'] = { 
            order = 7,
            name = 'Type-97',
            amount = 1,
            delay = 10000,
            materials = {
                ['p-armas'] = { name = 'P. Armas', amount = 49 },
            }
        },
    },
    ['wammos'] = {
        ['m_weapon_pistol_mk2'] = { 
            order = 1,
            name = 'M. Five-SeveN',
            amount = 50,
            delay = 10000,
            materials = {
                ['m-municoes'] = { name = 'M. Munições', amount = 7 },
            }
        },
        ['m_weapon_snspistol_mk2'] = { 
            order = 2,
            name = 'M. HK 45',
            amount = 50,
            delay = 10000,
            materials = {
                ['m-municoes'] = { name = 'M. Munições', amount = 7 },
            }
        },
        ['m_weapon_revolver_mk2'] = { 
            order = 3,
            name = 'M. R8',
            amount = 50,
            delay = 10000,
            materials = {
                ['m-municoes'] = { name = 'M. Munições', amount = 7 },
            }
        },
        ['m_weapon_tecpistol'] = { 
            order = 4,
            name = 'M. Uzi',
            amount = 50,
            delay = 10000,
            materials = {
                ['m-municoes'] = { name = 'M. Munições', amount = 14 },
            }
        },
        ['m_weapon_machinepistol'] = { 
            order = 5,
            name = 'M. Tec-9',
            amount = 50,
            delay = 10000,
            materials = {
                ['m-municoes'] = { name = 'M. Munições', amount = 14 },
            }
        },
        ['m_weapon_minismg'] = { 
            order = 6,
            name = 'M. S VZ 61',
            amount = 50,
            delay = 10000,
            materials = {
                ['m-municoes'] = { name = 'M. Munições', amount = 14 },
            }
        },
        ['m_weapon_compactrifle'] = { 
            order = 7,
            name = 'M. K. Compact',
            amount = 50,
            delay = 10000,
            materials = {
                ['m-municoes'] = { name = 'M. Munições', amount = 21 },
            }
        },
        ['m_weapon_heavyrifle'] = { 
            order = 7,
            name = 'M. FN Scar',
            amount = 50,
            delay = 10000,
            materials = {
                ['m-municoes'] = { name = 'M. Munições', amount = 21 },
            }
        },
        ['m_weapon_bullpuprifle_mk2'] = { 
            order = 7,
            name = 'M. Type-97',
            amount = 50,
            delay = 10000,
            materials = {
                ['m-municoes'] = { name = 'M. Munições', amount = 21 },
            }
        },
    },
    ['mec'] = {
        ['nitro'] = {
            order = 1,
            name = 'Nitro',
            amount = 14,
            delay = 10000,
            materials = {
                ['m-mec'] = { name = 'M. Mecânica', amount = 14 },
            }
        },
        ['kit-reparo'] = {
            order = 1,
            name = 'Kit Reparo',
            amount = 1,
            delay = 10000,
            materials = {
                ['m-mec'] = { name = 'M. Mecânica', amount = 0 },
            }
        }
    },
    ['smuggling'] = {
        ['lockpick'] = {
            order = 1,
            name = 'Lockpick',
            amount = 1,
            delay = 1000,
            materials = {
                ['dinheirosujo'] = { name = 'Dinheiro Sujo', amount = 2100 },
            }
        },
        ['keycard'] = {
            order = 2,
            name = 'Keycard',
            amount = 1,
            delay = 1000,
            materials = {
                ['dinheirosujo'] = { name = 'Dinheiro Sujo', amount = 1050 },
            }
        },
        ['pendrive'] = {
            order = 3,
            name = 'Pendrive',
            amount = 1,
            delay = 1000,
            materials = {
                ['dinheirosujo'] = { name = 'Dinheiro Sujo', amount = 1050 },
            }
        },
        ['c4'] = {
            order = 3,
            name = 'C4',
            amount = 1,
            delay = 1000,
            materials = {
                ['dinheirosujo'] = { name = 'Dinheiro Sujo', amount = 1050 },
            }
        },
        ['colete-ilegal'] = {
            order = 5,
            name = 'Colete Ilegal',
            amount = 1,
            delay = 1000,
            materials = {
                ['dinheirosujo'] = { name = 'Dinheiro Sujo', amount = 7350 },
            }
        },
        ['adrenalina'] = {
            order = 5,
            name = 'Adrenalina',
            amount = 1,
            delay = 1000,
            materials = {
                ['dinheirosujo'] = { name = 'Dinheiro Sujo', amount = 4500 },
            }
        },
        ['weapon_crowbar'] = {
            order = 5,
            name = 'Pé de cabra',
            amount = 1,
            delay = 1000,
            materials = {
                ['dinheirosujo'] = { name = 'Dinheiro Sujo', amount = 1250 },
            }
        },
    },
    ['cook'] = {
        ['combo-camarao'] = {
            order = 1,
            name = 'Camarão de Laurinha',
            amount = 4,
            delay = 10000,
            materials = {
                ['c-ingredientes'] = { name = 'C. Ingredientes', amount = 1 },
            }
        },
        ['combo-milho'] = {
            order = 2,
            name = 'Larissa Manuela',
            amount = 4,
            delay = 10000,
            materials = {
                ['c-ingredientes'] = { name = 'C. Ingredientes', amount = 1 },
            }
        },
        ['combo-chocolate'] = {
            order = 3,
            name = 'Tudo isso, aceito o desafio',
            amount = 4,
            delay = 10000,
            materials = {
                ['c-ingredientes'] = { name = 'C. Ingredientes', amount = 1 },
            }
        },
        ['combo-caviar'] = {
            order = 4,
            name = 'Pra aralho',
            amount = 4,
            delay = 10000,
            materials = {
                ['c-ingredientes'] = { name = 'C. Ingredientes', amount = 1 },
            }
        },
        ['energetico'] = {
            order = 5,
            name = 'Energético',
            amount = 2,
            delay = 10000,
            materials = {
                ['c-ingredientes'] = { name = 'C. Ingredientes', amount = 1 },
            }
        },
        ['cafe'] = {
            order = 5,
            name = 'Café',
            amount = 2,
            delay = 10000,
            materials = {
                ['c-ingredientes'] = { name = 'C. Ingredientes', amount = 1 },
            }
        },
    },
    ['drugs'] = {
        ['maconha'] = {
            order = 1,
            name = 'Maconha',
            amount = 28,
            delay = 10000,
            materials = {
                ['m-droga'] = { name = 'Material para Drogas', amount = 14 },
            }
        },
        ['cocaina'] = {
            order = 1,
            name = 'Cocaína',
            amount = 28,
            delay = 10000,
            materials = {
                ['m-droga'] = { name = 'Material para Drogas', amount = 14 },
            }
        },
        ['metanfetamina'] = {
            order = 1,
            name = 'Metanfetamina',
            amount = 28,
            delay = 10000,
            materials = {
                ['m-droga'] = { name = 'Material para Drogas', amount = 14 },
            }
        },
    },
    ['lanca'] = {
        ['lanca-perfume'] = {
            order = 1,
            name = 'Lança Perfume',
            amount = 28,
            delay = 10000,
            materials = {
                ['m-droga'] = { name = 'Material para Drogas', amount = 14 },
            }
        },
    },
    ['maconha'] = {
        ['maconha'] = {
            order = 1,
            name = 'Maconha',
            amount = 28,
            delay = 10000,
            materials = {
                ['m-droga'] = { name = 'Material para Drogas', amount = 14 },
            }
        },
    },
    ['cocaina'] = {
        ['cocaina'] = {
            order = 1,
            name = 'Cocaína',
            amount = 28,
            delay = 10000,
            materials = {
                ['m-droga'] = { name = 'Material para Drogas', amount = 14 },
            }
        },
    },
    ['hospital'] = {
        ['bandagem'] = {
            order = 1,
            name = 'Bandagem',
            amount = 1,
            delay = 5000,
            materials = {
                ['m-hp'] = { name = 'M. Hospital', amount = 1 },
            }
        },
    }
}

configs.productions = {
    ['hospital'] = {
        label = 'Produção de Hospital', 
        type = 'production',
        coords = vector3(-803.3275, -1205.749, 7.324585),
        products = configs.products.hospital, 
        permission = 'hospital.permissao',
        webhook = 'https://discord.com/api/webhooks/1150567600674316358/HAOk-sHKVgALJ-FCxvbuuAEoqn6kdzPLOGROyIgI_ooyYpMAoAQKXf7pyOsbXjYkGgu2'
    },
    ['zerofome1'] = { 
        type = 'production',
        coords = vector3(-1843.661, -1186.18, 14.30042), 
        label = 'Produção de Alimentos', 
        products = configs.products.cook, 
        permission = 'zerofome.permissao',
        webhook = 'https://discord.com/api/webhooks/1121532883631345834/5G3EmWD3QFjdVtE728_dKZT9wB3Av40XDkuIfUbsooWh1Hql8UrznHgkLomjuIRZ-Qzq' 
    },
    ['zerofome2'] = { 
        type = 'production',
        coords = vector3(-1839.969, -1188.026, 14.30042), 
        label = 'Produção de Alimentos', 
        products = configs.products.cook, 
        permission = 'zerofome.permissao',
        webhook = 'https://discord.com/api/webhooks/1121532883631345834/5G3EmWD3QFjdVtE728_dKZT9wB3Av40XDkuIfUbsooWh1Hql8UrznHgkLomjuIRZ-Qzq' 
    },
    ['zeromec1'] = { 
        type = 'production',
        coords = vector3(134.8747, -3050.611, 7.038086), 
        label = 'Produção de Mecânica', 
        permission = 'zeromecanica.permissao',
        products = configs.products.mec, 
        webhook = 'https://discord.com/api/webhooks/1146571244938985542/dgCac6qJ_DUVvMx6BzuR3q0w7bzGjs_SRy45TqiHy9bJkvETqsLbFwOEGKCZTMoFSS1Q' 
    },
    ['zeromec2'] = { 
        type = 'production',
        coords = vector3(138.8967, -3050.756, 7.038086), 
        label = 'Produção de Mecânica', 
        permission = 'zeromecanica.permissao',
        products = configs.products.mec, 
        webhook = 'https://discord.com/api/webhooks/1146571244938985542/dgCac6qJ_DUVvMx6BzuR3q0w7bzGjs_SRy45TqiHy9bJkvETqsLbFwOEGKCZTMoFSS1Q' 
    },
    ['smuggling'] = { 
        type = 'shop',
        coords = vector3(1273.358, -1708.391, 54.75684), 
        label = 'Negociações com Contrabandista', 
        products = configs.products.smuggling, 
        webhook = 'https://discord.com/api/webhooks/1121532883631345834/5G3EmWD3QFjdVtE728_dKZT9wB3Av40XDkuIfUbsooWh1Hql8UrznHgkLomjuIRZ-Qzq' 
    },

    ['Russia'] = { 
        type = 'production',
        coords = vector3(1368.026, -707.5121, 68.20288), 
        label = 'Produção de Drogas', 
        buff = true,
        products = configs.products.drugs, 
        permission = 'russia.permissao',
        webhook = 'https://discord.com/api/webhooks/1146572562705432637/JKZuwm-jQS8onvAfxpBzKMF9fDFDRHsmfRbiUx3XpUAMoUktbRqqh65_r0Nt7chbsP8J' 
    },
    ['Espanha'] = { 
        type = 'production',
        coords = vector3(412.022, 3.679121, 84.91797), 
        label = 'Produção de Armas', 
        products = configs.products.guns, 
        permission = 'espanha.permissao',
        webhook = 'https://discord.com/api/webhooks/1146573704155910305/5AeOVpXX7ujnX4t_T-nj4kpsTUP2ZaU_Pg8zr6mzRlzGfnUJIe7QYxhBob9S8hmk_TXN' 
    },
    ['Camorra'] = { 
        type = 'moneyLaundry',
        coords = vector3(95.4066, -1293.257, 29.75171), 
        label = 'Lavagem de dinheiro', 
        products = configs.products.drugs, 
        permission = 'camorra.permissao',
        webhook = 'https://discord.com/api/webhooks/1146572334614974565/q9HxlTNB73FF8ftNp6k6kkU6q_L7C1seHUBzTO0XgPluyuvbbp3TsMumJcoKynATWTdz' 
    },
    ['Cosanostra'] = { 
        type = 'production',
        coords = vector3(1645.411, -2119.45, 102.2227), 
        label = 'Produção de Drogas', 
        products = configs.products.drugs, 
        permission = 'cosanostra.permissao',
        webhook = 'https://discord.com/api/webhooks/1146573156627267655/SJ_mOs8jRRs6zIVjn0RE1lorWEWwW39LQ1SMzxPrRHCeQPjzsiGfOLh_HXgYPHdC3Bge' 
    },
    ['Finish'] = { 
        type = 'production',
        coords = vector3(1281.059, -1016.743, 51.30261), 
        label = 'Produção de Drogas', 
        products = configs.products.drugs, 
        permission = 'finish.permissao',
        webhook = 'https://discord.com/api/webhooks/1146572015977910282/MxhXmTxGFsYtr48UE5NHS9eZcBlLmRCLjmFY5A-cXNdic3Dl62_BFpJ-LuS42vFNcds7' 
    },
    ['Colombia'] = { 
        type = 'production',
        coords = vector3(-1486.299, 835.8461, 176.9854), 
        products = configs.products.guns, 
        label = 'Produção de Armas', 
        webhook = 'https://discord.com/api/webhooks/1146573638867365940/gSWhlBz5xsvN88rh2nX9uwX44vmbWarvprny4YiaBsixlCC247KyqAwfSJGl4WffqpcQ' 
    },
    ['Canada'] = { 
        type = 'production',
        coords = vector3(-1834.497, 425.1693, 118.3649), 
        label = 'Produção de Munições', 
        products = configs.products.wammos, 
        permission = 'canada.permissao',
        webhook = 'https://discord.com/api/webhooks/1146574251390947430/e69PlgY1Z5c0PXBEUVPxHY7HwTy9knAwlPnj8CgLblsJdJoX8_21bB-rQdogUFq10535' 
    },
    ['Alemanha'] = { 
        type = 'production',
        coords = vector3(978.8571, -94.37802, 74.85864), 
        label = 'Produção de Munições', 
        products = configs.products.wammos, 
        permission = 'alemanha.permissao',
        webhook = 'https://discord.com/api/webhooks/1146573767565377566/5ka63zdQECzyoLT4ixGl1HA9JWjm3UmYhCcPts6c0utiwZo_09TTYRhF4SZHs6nsSni7' 
    },
    ['Inglaterra'] = { 
        type = 'production',
        coords = vector3(-282.3956, 1564.246, 361.5247), 
        label = 'Produção de Maconha', 
        buff = true,
        products = configs.products.maconha, 
        permission = 'inglaterra.permissao',
        webhook = 'https://discord.com/api/webhooks/1146572784181452871/09uB5rzjOEl9VDME0SWjBF0A5yTi_K0DJifX6jBYQI2ac2p4GMMWf4U3HIUj3_djU2Ib' 
    },
    ['Tropa'] = { 
        coords = vector3(-221.8286, -284.0308, 29.24609), 
        label = 'Lavagem de dinheiro', 
        type = 'moneyLaundry',
        permission = 'tropa.permissao',
        webhook = 'https://discord.com/api/webhooks/1146573268162191491/hZMZIybnTjkfQnn25p9ig0g8_sDqpCaw4fAd0770Al5mREV4qdMO6dLZIkRJwEoM-PGl' 
    },
    ['Holanda'] = { 
        type = 'production',
        coords = vector3(1793.578, 447.4154, 172.537), 
        label = 'Produção de Arma', 
        products = configs.products.guns, 
        permission = 'holanda.permissao',
        webhook = 'https://discord.com/api/webhooks/1146571754756653096/Ymap_XGACoPMm5HcgFog-pm4qdy_iK10bPds6m_nz6NuRn1kuJwdorWPBG6Y7nqeJOgB' 
    },
    ['Helipa'] = { 
        type = 'production',
        coords = vector3(284.7297, 1863.442, 212.825), 
        label = 'Produção de Drogas', 
        buff = true,
        products = configs.products.drugs, 
        permission = 'helipa.permissao',
        webhook = 'https://discord.com/api/webhooks/1146572659921010709/-dqTAYOSMBkJrhJvOGua6HBajiQavdSX5zTbPWO8spQexuwb4Q-kDQsQ5oHup5nqFuAM' 
    },
    ['Egito'] = { 
        type = 'production',
        coords = vector3(1278.396, -197.1297, 105.0703), 
        label = 'Produção de Drogas', 
        products = configs.products.drugs, 
        permission = 'egito.permissao',
        webhook = 'https://discord.com/api/webhooks/1146571905713844374/6F6Iv4FP9nzLX9d2jZUOewDtDX2fCQMaiUNISu-MAhWZKMKT0-3EDNSN4Gmv0C9G3Td7' 
    },
    ['Polonia'] = { 
        type = 'production',
        coords = vector3(3028.299, 2705.987, 73.91504), 
        label = 'Produção de Lança', 
        products = configs.products.lanca, 
        permission = 'polonia.permissao',
        webhook = 'https://discord.com/api/webhooks/1146573369270079638/fQXruk51nszSAMwRErXjW0L2pYtcOBq6NwbGByudJYd9L7TgyhTzj2R1x-fcYNo2CA-k' 
    },
    ['sellDrugs'] = { 
        type = 'sellDrugs',
        coords = vector3(206.5451, -1851.521, 27.47693), 
        label = 'Vender drogas', 
        permission = 'droga.permissao',
        webhook = 'https://discord.com/api/webhooks/1145972996822007848/4PBMQVms1ppXl3RFnz-Fe205ooQapAvQt-5u38SH2W1qxllTD4Yjsx8Q3IFBze2jf-xO' 
    },
}