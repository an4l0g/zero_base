Proxy = module('zero', 'lib/Proxy')
Tunnel = module('zero', 'lib/Tunnel')
zero = Proxy.getInterface('zero')

configs = {}

configs.webhook = "https://discord.com/api/webhooks/1121327499863928842/Q0qKwIWLK9sWz53yjb41Zse1xfAjEBLFfiG6qCaC_s_mCQPmqEdLOfNQXe0zRenphc_b"

configs.products = {
    ['guns'] = {
        ['weapon_assaultrifle'] = { 
            name = 'AK-47',
            min_amount = 1,
            max_amount = 5,
            delay = 1000,
            materials = {
                ['agua'] = { name = 'Agua', amount = 1 },
            }
        }
    }
}

configs.productions = {
    ['fac1'] = { coords = vec3(-68.56, -823.24, 326.23), products = configs.products.guns, label = 'Armas', webhook = 'https://discord.com/api/webhooks/1121532883631345834/5G3EmWD3QFjdVtE728_dKZT9wB3Av40XDkuIfUbsooWh1Hql8UrznHgkLomjuIRZ-Qzq' },
}