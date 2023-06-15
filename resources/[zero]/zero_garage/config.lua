Proxy = module('zero', 'lib/Proxy')
Tunnel = module('zero', 'lib/Tunnel')
zero = Proxy.getInterface('zero')

config = {}

config.vehicles = {
    ['amarok'] = { name = 'Amarok', maker = 'Volkswagen', price = 1000000, trunk = 50, glove = 15, type = 'car', class = 'boats', banned = false },
    ['kuruma'] = { name = 'Kuruma', maker = 'GTA', price = 1000000, trunk = 50, glove = 15, type = 'car', class = 'boats', banned = false }
}

config.garages = {
    {
        coords = vector3(-809.3035, -2695.567, 13.80471), 
        rule = 'carOnly', permission = nil,
        points = {
            vector4(0, 0, 0, 0)
        }
    }
}

config.rules = {
    ['carOnly'] = {
        ['show_classes'] = nil,
        ['hide_classes'] = { ['planes'] = true, ['helicopters'] = true, ['boats'] = true }
    },
    ['heliOnly'] = {
        ['show_classes'] = { ['helicopters'] = true },
        ['hide_classes'] = nil
    },
    ['planeOnly'] = {
        ['show_classes'] = { ['planes'] = true },
        ['hide_classes'] = nil
    },
    ['boatsOnly'] = {
        ['show_classes'] = { ['boats'] = true },
        ['hide_classes'] = nil
    },
}