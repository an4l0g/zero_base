Tunnel = module('zero', 'lib/Tunnel')
Proxy = module('zero', 'lib/Proxy')
zero = Proxy.getInterface('zero')

config = {
    tableName = 'rewards',
    creditRegisterTime = 30,
    registerTime = 5,
    exclusiveVehicle = 'gtrc',
    maxChance = 1000,
    rewards = {
        legend = {
            items = {
                { 
                    type = 'car',
                    spawn = 'gtrc',
                    name = 'GTR'
                },
            },
            chances = {
                min = 1,
                max = 1,
            }
        },
        epic = {
            items = {
                {
                    type = 'item',
                    index = 'mochila-zerofome',
                    name = 'Mochila 200KG',
                    amount = 1,
                },
            },
            chances = {
                min = 2,
                max = 50,
            }
        },
        ultrarare = {
            items = {
                {
                    type = 'item',
                    index = 'weapon_specialcarbine_mk2',
                    name = 'G3',
                    amount = 1,
                },
                {
                    type = 'item',
                    index = 'weapon_assaultsmg',
                    name = 'Mtar21',
                    amount = 1,
                },
                {
                    type = 'item',
                    index = 'weapon_pistol_mk2',
                    name = 'Five Seven',
                    amount = 1,
                },
                {
                    type = 'item',
                    index = 'weapon_revolver_mk2',
                    name = 'R8',
                    amount = 1,
                },
                {
                    type = 'item',
                    index = 'weapon_combatshotgun',
                    name = 'Shotgun',
                    amount = 1,
                }
            },
            chances = {
                min = 51,
                max = 200,
            }
        },
        rare = {
            items = {
                {
                    type = 'item',
                    index = 'm_weapon_specialcarbine_mk2',
                    name = 'Munição De G3',
                    amount = 50,
                },
                {
                    type = 'item',
                    index = 'm_weapon_assaultsmg',
                    name = 'Munição De Mtar21',
                    amount = 50,
                },
                {
                    type = 'item',
                    index = 'm_weapon_pistol_mk2',
                    name = 'Munição De Five Seven',
                    amount = 50,
                },
                {
                    type = 'item',
                    index = 'm_weapon_revolver_mk2',
                    name = 'Munição De R8',
                    amount = 50,
                },
                {
                    type = 'item',
                    index = 'm_weapon_combatshotgun',
                    name = 'Munição De Shotgun',
                    amount = 15,
                }
            },
            chances = {
                min = 201,
                max = 400,
            }
        },
        uncommon = {
            items = {
                {
                    type = 'item',
                    index = 'dinheirosujo',
                    name = 'Dinheiro Sujo',
                    amount = 50000,
                },
                {
                    type = 'item',
                    index = 'dinheirosujo',
                    name = 'Dinheiro Sujo',
                    amount = 100000,
                },
                {
                    type = 'item',
                    index = 'dinheirosujo',
                    name = 'Dinheiro Sujo',
                    amount = 150000,
                },
            },
            chances = {
                min = 401,
                max = 650,
            }
        },
        common = {
            items = {
                {
                    type = 'item',
                    index = 'combo-milho',
                    name = 'Combo Zero Fome',
                    amount = 5,
                },
                {
                    type = 'item',
                    index = 'energetico',
                    name = 'Energético',
                    amount = 10,
                },
                {
                    type = 'item',
                    index = 'celular',
                    name = 'Celular',
                    amount = 1,
                },
                {
                    type = 'item',
                    index = 'radio',
                    name = 'Rádio',
                    amount = 1,
                },

                {
                    type = 'item',
                    index = 'gps',
                    name = 'Gps',
                    amount = 5,
                },
                {
                    type = 'item',
                    index = 'mochila-grande',
                    name = 'Mochila Grande',
                    amount = 1,
                },
            },
            chances = {
                min = 651,
                max = 1000,
            }
        },
    },
}