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
                ['agua'] = { name = 'Agua', amount = 2 },
                ['frango-ensopado'] = { name = 'Frango Ensopado', amount = 3 },
            }
        }
    }
}

configs.productions = {
    { coords = vec3(-75.17, -819.11, 326.17), products = configs.products.guns, label = 'Armas', type = 'guns' }, -- Fac 1
}