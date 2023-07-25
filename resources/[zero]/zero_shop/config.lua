Tunnel = module('zero', 'lib/Tunnel')
Proxy = module('zero', 'lib/Proxy')
zero = Proxy.getInterface('zero')

config = {}

config.general = {
    ['departament'] = {
        ['algema'] = {
            name = 'Algema', index = 'algema',
            price = {
                buy = 5000,
                sell = 2000
            },
            method = 'legal'
        },
        ['spray'] = {
            name = 'Spray', index = 'spray',
            price = {
                buy = 5000,
                sell = 2000
            },
            method = 'legal'
        },
        ['nitro'] = {
            name = 'Nitro', index = 'nitro',
            price = {
                buy = 5000,
                sell = 2000
            },
            method = 'ilegal'
        }
    }
}

config.shops = {
    { name = 'Supermarket', type = 'all', coord = vector3(-291.8242, -887.3143, 31.06592), config = 'departament' }
}