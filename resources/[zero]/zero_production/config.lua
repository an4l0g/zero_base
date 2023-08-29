Proxy = module('zero', 'lib/Proxy')
Tunnel = module('zero', 'lib/Tunnel')
zero = Proxy.getInterface('zero')

configs = {}

configs.moneyLaundryMax = 50000
configs.blipDistance = 3

configs.products = {
    ['guns'] = {
        ['weapon_pistol_mk2'] = { 
            order = 1,
            name = 'Five-SeveN',
            min_amount = 1,
            max_amount = 1,
            delay = 10000,
            materials = {
                ['p-armas'] = { name = 'P. Armas', amount = 42 },
            }
        },
        ['weapon_snspistol_mk2'] = { 
            order = 2,
            name = 'HK 45',
            min_amount = 1,
            max_amount = 1,
            delay = 10000,
            materials = {
                ['p-armas'] = { name = 'P. Armas', amount = 42 },
            }
        },
        ['weapon_revolver_mk2'] = { 
            order = 3,
            name = 'R8',
            min_amount = 1,
            max_amount = 1,
            delay = 10000,
            materials = {
                ['p-armas'] = { name = 'P. Armas', amount = 42 },
            }
        },
        ['weapon_tecpistol'] = { 
            order = 4,
            name = 'Uzi',
            min_amount = 1,
            max_amount = 1,
            delay = 10000,
            materials = {
                ['p-armas'] = { name = 'P. Armas', amount = 70 },
            }
        },
        ['weapon_machinepistol'] = { 
            order = 5,
            name = 'Tec-9',
            min_amount = 1,
            max_amount = 1,
            delay = 10000,
            materials = {
                ['p-armas'] = { name = 'P. Armas', amount = 70 },
            }
        },
        ['weapon_minismg'] = { 
            order = 6,
            name = 'S VZ 61',
            min_amount = 1,
            max_amount = 1,
            delay = 10000,
            materials = {
                ['p-armas'] = { name = 'P. Armas', amount = 70 },
            }
        },
        ['weapon_compactrifle'] = { 
            order = 7,
            name = 'K. Compact',
            min_amount = 1,
            max_amount = 1,
            delay = 10000,
            materials = {
                ['p-armas'] = { name = 'P. Armas', amount = 98 },
            }
        },
        ['weapon_heavyrifle'] = { 
            order = 7,
            name = 'FN Scar',
            min_amount = 1,
            max_amount = 1,
            delay = 10000,
            materials = {
                ['p-armas'] = { name = 'P. Armas', amount = 98 },
            }
        },
        ['weapon_bullpuprifle_mk2'] = { 
            order = 7,
            name = 'Type-97',
            min_amount = 1,
            max_amount = 1,
            delay = 10000,
            materials = {
                ['p-armas'] = { name = 'P. Armas', amount = 98 },
            }
        },
    },
    ['wammos'] = {
        ['m_weapon_pistol_mk2'] = { 
            order = 1,
            name = 'M. Five-SeveN',
            min_amount = 25,
            max_amount = 25,
            delay = 10000,
            materials = {
                ['c-muni'] = { name = 'C. Munição', amount = 14 },
            }
        },
        ['m_weapon_snspistol_mk2'] = { 
            order = 2,
            name = 'M. HK 45',
            min_amount = 25,
            max_amount = 25,
            delay = 10000,
            materials = {
                ['c-muni'] = { name = 'C. Munição', amount = 14 },
            }
        },
        ['m_weapon_revolver_mk2'] = { 
            order = 3,
            name = 'M. R8',
            min_amount = 25,
            max_amount = 25,
            delay = 10000,
            materials = {
                ['c-muni'] = { name = 'C. Munição', amount = 14 },
            }
        },
        ['m_weapon_tecpistol'] = { 
            order = 4,
            name = 'M. Uzi',
            min_amount = 25,
            max_amount = 25,
            delay = 10000,
            materials = {
                ['c-muni'] = { name = 'C. Munição', amount = 28 },
            }
        },
        ['m_weapon_machinepistol'] = { 
            order = 5,
            name = 'M. Tec-9',
            min_amount = 25,
            max_amount = 25,
            delay = 10000,
            materials = {
                ['c-muni'] = { name = 'C. Munição', amount = 28 },
            }
        },
        ['m_weapon_minismg'] = { 
            order = 6,
            name = 'M. S VZ 61',
            min_amount = 25,
            max_amount = 25,
            delay = 10000,
            materials = {
                ['c-muni'] = { name = 'C. Munição', amount = 28 },
            }
        },
        ['m_weapon_compactrifle'] = { 
            order = 7,
            name = 'M. K. Compact',
            min_amount = 25,
            max_amount = 25,
            delay = 10000,
            materials = {
                ['c-muni'] = { name = 'C. Munição', amount = 42 },
            }
        },
        ['m_weapon_heavyrifle'] = { 
            order = 7,
            name = 'M. FN Scar',
            min_amount = 25,
            max_amount = 25,
            delay = 10000,
            materials = {
                ['c-muni'] = { name = 'C. Munição', amount = 42 },
            }
        },
        ['m_weapon_bullpuprifle_mk2'] = { 
            order = 7,
            name = 'M. Type-97',
            min_amount = 25,
            max_amount = 25,
            delay = 10000,
            materials = {
                ['c-muni'] = { name = 'C. Munição', amount = 42 },
            }
        },
    },
    ['mec'] = {
        ['nitro'] = {
            order = 1,
            name = 'Nitro',
            min_amount = 7,
            max_amount = 7,
            delay = 10000,
            materials = {
                ['c-mec'] = { name = 'C. Mecânica', amount = 14 },
            }
        },
        ['kit-reparo'] = {
            order = 1,
            name = 'Kit Reparo',
            min_amount = 1,
            max_amount = 1,
            delay = 10000,
            materials = {
                ['c-mec'] = { name = 'C. Mecânica', amount = 0 },
            }
        }
    },
    ['smuggling'] = {
        ['lockpick'] = {
            order = 1,
            name = 'Lockpick',
            min_amount = 1,
            max_amount = 1,
            delay = 1000,
            materials = {
                ['dinheirosujo'] = { name = 'Dinheiro Sujo', amount = 2100 },
            }
        },
        ['keycard'] = {
            order = 2,
            name = 'Keycard',
            min_amount = 1,
            max_amount = 1,
            delay = 1000,
            materials = {
                ['dinheirosujo'] = { name = 'Dinheiro Sujo', amount = 1050 },
            }
        },
        ['pendrive'] = {
            order = 3,
            name = 'Pendrive',
            min_amount = 1,
            max_amount = 1,
            delay = 1000,
            materials = {
                ['dinheirosujo'] = { name = 'Dinheiro Sujo', amount = 1050 },
            }
        },
        ['c4'] = {
            order = 3,
            name = 'C4',
            min_amount = 1,
            max_amount = 1,
            delay = 1000,
            materials = {
                ['dinheirosujo'] = { name = 'Dinheiro Sujo', amount = 1050 },
            }
        },
        ['colete-ilegal'] = {
            order = 5,
            name = 'Colete Ilegal',
            min_amount = 1,
            max_amount = 1,
            delay = 1000,
            materials = {
                ['dinheirosujo'] = { name = 'Dinheiro Sujo', amount = 7350 },
            }
        },
        ['weapon_crowbar'] = {
            order = 5,
            name = 'Pé de cabra',
            min_amount = 1,
            max_amount = 1,
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
            min_amount = 2,
            max_amount = 2,
            delay = 10000,
            materials = {
                ['c-ingredientes'] = { name = 'C. Ingredientes', amount = 1 },
            }
        },
        ['combo-milho'] = {
            order = 2,
            name = 'Larissa Manuela',
            min_amount = 2,
            max_amount = 2,
            delay = 10000,
            materials = {
                ['c-ingredientes'] = { name = 'C. Ingredientes', amount = 1 },
            }
        },
        ['combo-chocolate'] = {
            order = 3,
            name = 'Tudo isso, aceito o desafio',
            min_amount = 2,
            max_amount = 2,
            delay = 10000,
            materials = {
                ['c-ingredientes'] = { name = 'C. Ingredientes', amount = 1 },
            }
        },
        ['combo-caviar'] = {
            order = 4,
            name = 'Pra aralho',
            min_amount = 2,
            max_amount = 2,
            delay = 10000,
            materials = {
                ['c-ingredientes'] = { name = 'C. Ingredientes', amount = 1 },
            }
        },
        ['energetico'] = {
            order = 5,
            name = 'Energético',
            min_amount = 1,
            max_amount = 1,
            delay = 10000,
            materials = {
                ['c-ingredientes'] = { name = 'C. Ingredientes', amount = 1 },
            }
        },
        ['cafe'] = {
            order = 5,
            name = 'Café',
            min_amount = 1,
            max_amount = 1,
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
            min_amount = 1,
            max_amount = 1,
            delay = 5000,
            materials = {
                ['m-droga'] = { name = 'M. Droga', amount = 1 },
            }
        },
        ['metanfetamina'] = {
            order = 1,
            name = 'Metanfetamina',
            min_amount = 1,
            max_amount = 1,
            delay = 5000,
            materials = {
                ['m-droga'] = { name = 'M. Droga', amount = 1 },
            }
        },
        ['cocaina'] = {
            order = 1,
            name = 'Cocaína',
            min_amount = 1,
            max_amount = 1,
            delay = 5000,
            materials = {
                ['m-droga'] = { name = 'M. Droga', amount = 1 },
            }
        },
    }
}

configs.productions = {
    ['zerofome1'] = { 
        type = 'production',
        coords = vector3(-1843.661, -1186.18, 14.30042), 
        label = 'Produção de Alimentos', 
        products = configs.products.cook, 
        webhook = 'https://discord.com/api/webhooks/1121532883631345834/5G3EmWD3QFjdVtE728_dKZT9wB3Av40XDkuIfUbsooWh1Hql8UrznHgkLomjuIRZ-Qzq' 
    },
    ['zerofome2'] = { 
        type = 'production',
        coords = vector3(-1839.969, -1188.026, 14.30042), 
        label = 'Produção de Alimentos', 
        products = configs.products.cook, 
        webhook = 'https://discord.com/api/webhooks/1121532883631345834/5G3EmWD3QFjdVtE728_dKZT9wB3Av40XDkuIfUbsooWh1Hql8UrznHgkLomjuIRZ-Qzq' 
    },
    ['zeromec1'] = { 
        type = 'production',
        coords = vector3(-310.8, -113.433, 39.0022), 
        label = 'Produção de Mecânica', 
        permission = 'zeromecanica.permissao',
        products = configs.products.mec, 
        webhook = 'https://discord.com/api/webhooks/1121532883631345834/5G3EmWD3QFjdVtE728_dKZT9wB3Av40XDkuIfUbsooWh1Hql8UrznHgkLomjuIRZ-Qzq' 
    },
    ['zeromec2'] = { 
        type = 'production',
        coords = vector3(-322.7736, -146.3473, 39.0022), 
        label = 'Produção de Mecânica', 
        permission = 'zeromecanica.permissao',
        products = configs.products.mec, 
        webhook = 'https://discord.com/api/webhooks/1121532883631345834/5G3EmWD3QFjdVtE728_dKZT9wB3Av40XDkuIfUbsooWh1Hql8UrznHgkLomjuIRZ-Qzq' 
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
        products = configs.products.drugs, 
        permission = 'russia.permissao',
        webhook = 'https://discord.com/api/webhooks/1121532883631345834/5G3EmWD3QFjdVtE728_dKZT9wB3Av40XDkuIfUbsooWh1Hql8UrznHgkLomjuIRZ-Qzq' 
    },
    ['Espanha'] = { 
        type = 'production',
        coords = vector3(412.022, 3.679121, 84.91797), 
        label = 'Produção de Armas', 
        products = configs.products.guns, 
        permission = 'espanha.permissao',
        webhook = 'https://discord.com/api/webhooks/1121532883631345834/5G3EmWD3QFjdVtE728_dKZT9wB3Av40XDkuIfUbsooWh1Hql8UrznHgkLomjuIRZ-Qzq' 
    },
    ['Yakuza'] = { 
        type = 'production',
        coords = vector3(572.334, -3127.213, 18.76563), 
        label = 'Produção de Drogas', 
        products = configs.products.drugs, 
        permission = 'yakuza.permissao',
        webhook = 'https://discord.com/api/webhooks/1121532883631345834/5G3EmWD3QFjdVtE728_dKZT9wB3Av40XDkuIfUbsooWh1Hql8UrznHgkLomjuIRZ-Qzq' 
    },
    ['Cosanostra'] = { 
        type = 'production',
        coords = vector3(1645.411, -2119.45, 102.2227), 
        label = 'Produção de Drogas', 
        products = configs.products.drugs, 
        permission = 'cosanostra.permissao',
        webhook = 'https://discord.com/api/webhooks/1121532883631345834/5G3EmWD3QFjdVtE728_dKZT9wB3Av40XDkuIfUbsooWh1Hql8UrznHgkLomjuIRZ-Qzq' 
    },
    ['Finish'] = { 
        type = 'production',
        coords = vector3(1281.059, -1016.743, 51.30261), 
        label = 'Produção de Drogas', 
        products = configs.products.drugs, 
        permission = 'finish.permissao',
        webhook = 'https://discord.com/api/webhooks/1121532883631345834/5G3EmWD3QFjdVtE728_dKZT9wB3Av40XDkuIfUbsooWh1Hql8UrznHgkLomjuIRZ-Qzq' 
    },
    ['Colombia'] = { 
        type = 'production',
        coords = vector3(-1486.299, 835.8461, 176.9854), 
        products = configs.products.guns, 
        label = 'Produção de Armas', 
        webhook = 'https://discord.com/api/webhooks/1121532883631345834/5G3EmWD3QFjdVtE728_dKZT9wB3Av40XDkuIfUbsooWh1Hql8UrznHgkLomjuIRZ-Qzq' 
    },
    ['Canada'] = { 
        type = 'production',
        coords = vector3(-1834.497, 425.1693, 118.3649), 
        label = 'Produção de Munições', 
        products = configs.products.wammos, 
        permission = 'canada.permissao',
        webhook = 'https://discord.com/api/webhooks/1121532883631345834/5G3EmWD3QFjdVtE728_dKZT9wB3Av40XDkuIfUbsooWh1Hql8UrznHgkLomjuIRZ-Qzq' 
    },
    ['Tropa'] = { 
        type = 'production',
        coords = vector3(1335.429, -2541.758, 48.25281), 
        label = 'Produção de Drogas', 
        products = configs.products.drugs, 
        permission = 'tropa.permissao',
        webhook = 'https://discord.com/api/webhooks/1121532883631345834/5G3EmWD3QFjdVtE728_dKZT9wB3Av40XDkuIfUbsooWh1Hql8UrznHgkLomjuIRZ-Qzq' 
    },
    ['Inglaterra'] = { 
        type = 'production',
        coords = vector3(-282.3956, 1564.246, 361.5247), 
        label = 'Produção de Drogas', 
        products = configs.products.drugs, 
        permission = 'inglaterra.permissao',
        webhook = 'https://discord.com/api/webhooks/1121532883631345834/5G3EmWD3QFjdVtE728_dKZT9wB3Av40XDkuIfUbsooWh1Hql8UrznHgkLomjuIRZ-Qzq' 
    },
    ['Mafia'] = { 
        type = 'production',
        coords = vector3(-221.8286, -284.0308, 29.24609), 
        label = 'Lavagem de dinheiro', 
        type = 'moneyLaundry',
        permission = 'mafia.permissao',
        webhook = 'https://discord.com/api/webhooks/1121532883631345834/5G3EmWD3QFjdVtE728_dKZT9wB3Av40XDkuIfUbsooWh1Hql8UrznHgkLomjuIRZ-Qzq' 
    },
    ['Alemanha'] = { 
        type = 'production',
        coords = vector3(-1834.497, 425.1693, 118.3649), 
        label = 'Produção de Munições', 
        products = configs.products.wammos, 
        permission = 'alemanha.permissao',
        webhook = 'https://discord.com/api/webhooks/1121532883631345834/5G3EmWD3QFjdVtE728_dKZT9wB3Av40XDkuIfUbsooWh1Hql8UrznHgkLomjuIRZ-Qzq' 
    },
    ['Holanda'] = { 
        type = 'production',
        coords = vector3(1793.578, 447.4154, 172.537), 
        label = 'Produção de Drogas', 
        products = configs.products.drugs, 
        permission = 'holanda.permissao',
        webhook = 'https://discord.com/api/webhooks/1121532883631345834/5G3EmWD3QFjdVtE728_dKZT9wB3Av40XDkuIfUbsooWh1Hql8UrznHgkLomjuIRZ-Qzq' 
    },
    ['Helipa'] = { 
        type = 'production',
        coords = vector3(1793.578, 447.4154, 172.537), 
        label = 'Produção de Drogas', 
        products = configs.products.drugs, 
        permission = 'helipa.permissao',
        webhook = 'https://discord.com/api/webhooks/1121532883631345834/5G3EmWD3QFjdVtE728_dKZT9wB3Av40XDkuIfUbsooWh1Hql8UrznHgkLomjuIRZ-Qzq' 
    },
    ['Egito'] = { 
        type = 'production',
        coords = vector3(1278.396, -197.1297, 105.0703), 
        label = 'Produção de Drogas', 
        products = configs.products.drugs, 
        permission = 'egito.permissao',
        webhook = 'https://discord.com/api/webhooks/1121532883631345834/5G3EmWD3QFjdVtE728_dKZT9wB3Av40XDkuIfUbsooWh1Hql8UrznHgkLomjuIRZ-Qzq' 
    },
}