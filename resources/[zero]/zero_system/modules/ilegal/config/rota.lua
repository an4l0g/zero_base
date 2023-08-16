Routes = {
    general = {
        ['Aviaozinho'] = {
            name = 'Aviãozinho',
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
                progress = 'Entregando a sua mãe...'
            },
            extras = {
                anim = 'mexer',
                drug = true,
                police = 70,
                timeout = 5000,
            }
        },
        ['Maconha'] = {
            name = 'Maconha',
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
                item = 'maconha',
                quantity = 1
            },
            texts = {
                text = '~b~E~w~ - Pegar',
                progress = 'Entregando a sua mãe AQUELA GOXTOSAAAA KKKKK...'
            },
            extras = {
                anim = 'mexer',
                police = 70,
                timeout = 5000,
            }
        }
    },

    locations = {
        { coord = vector3(2.69011, -1215.073, 26.88721), config = 'Maconha', cooldown = 900 }
    }
}