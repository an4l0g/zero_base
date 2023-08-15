Proxy = module('zero', 'lib/Proxy')
Tunnel = module('zero', 'lib/Tunnel')
zero = Proxy.getInterface('zero')

configs = {}

configs.products = {
    ['guns'] = {
        ['weapon_pistol_mk2'] = { 
            order = 1,
            name = 'Five-SeveN',
            min_amount = 1,
            max_amount = 1,
            delay = 10000,
            materials = {
                ['p-armas'] = { name = 'P. Armas', amount = 28 },
            }
        },
        ['weapon_snspistol_mk2'] = { 
            order = 2,
            name = 'HK 45',
            min_amount = 1,
            max_amount = 1,
            delay = 10000,
            materials = {
                ['p-armas'] = { name = 'P. Armas', amount = 28 },
            }
        },
        ['weapon_revolver_mk2'] = { 
            order = 3,
            name = 'R8',
            min_amount = 1,
            max_amount = 1,
            delay = 10000,
            materials = {
                ['p-armas'] = { name = 'P. Armas', amount = 28 },
            }
        },
        ['weapon_tecpistol'] = { 
            order = 4,
            name = 'Uzi',
            min_amount = 1,
            max_amount = 1,
            delay = 10000,
            materials = {
                ['p-armas'] = { name = 'P. Armas', amount = 56 },
            }
        },
        ['weapon_machinepistol'] = { 
            order = 5,
            name = 'Tec-9',
            min_amount = 1,
            max_amount = 1,
            delay = 10000,
            materials = {
                ['p-armas'] = { name = 'P. Armas', amount = 56 },
            }
        },
        ['weapon_minismg'] = { 
            order = 6,
            name = 'S VZ 61',
            min_amount = 1,
            max_amount = 1,
            delay = 10000,
            materials = {
                ['p-armas'] = { name = 'P. Armas', amount = 56 },
            }
        },
        ['weapon_compactrifle'] = { 
            order = 7,
            name = 'K. Compact',
            min_amount = 1,
            max_amount = 1,
            delay = 10000,
            materials = {
                ['p-armas'] = { name = 'P. Armas', amount = 84 },
            }
        },
        ['weapon_heavyrifle'] = { 
            order = 7,
            name = 'FN Scar',
            min_amount = 1,
            max_amount = 1,
            delay = 10000,
            materials = {
                ['p-armas'] = { name = 'P. Armas', amount = 84 },
            }
        },
        ['weapon_bullpuprifle_mk2'] = { 
            order = 7,
            name = 'Type-97',
            min_amount = 1,
            max_amount = 1,
            delay = 10000,
            materials = {
                ['p-armas'] = { name = 'P. Armas', amount = 84 },
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
    }
}

configs.productions = {
    ['fac1'] = { 
        coords = vec3(-68.56, -823.24, 326.23), 
        products = configs.products.wammos, 
        label = 'Munições', 
        webhook = 'https://discord.com/api/webhooks/1121532883631345834/5G3EmWD3QFjdVtE728_dKZT9wB3Av40XDkuIfUbsooWh1Hql8UrznHgkLomjuIRZ-Qzq' 
    },
}