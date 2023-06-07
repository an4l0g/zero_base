Tunnel = module('vrp', 'lib/Tunnel')
Proxy = module('vrp', 'lib/Proxy')
vRP = Proxy.getInterface('vRP')

config = {}

config.homes = {
    ['Homes0001'] = { vector3(996.77, -729.57, 57.82), type = 'modern', perm = nil  },
    ['Homes0002'] = { vector3(-213.38,-1618.15,38.05), type = 'high', perm = nil  },
    ['Homes0003'] = { vector3(-210.03,-1607.10,38.04), type = 'basic', perm = nil  },
    ['Homes0004'] = { vector3(-212.10,-1617.38,38.05), type = 'basic', perm = nil }
}

config.typeHomes = {
    ['basic'] = {
        ['price'] = 300000,
        ['tax'] = { true, 10 },
        ['residents'] = { true, 2 },
        ['outfit'] = { 
            min = 1, 
            max = 10, 
            value = 10000,
            perm = nil
        },
        ['chest'] = {
            min = 100,
            max = 1000,
            value = 10000,
        },
        ['interior'] = {
            ['simple'] = {
                default = true,
                value = 10000,
                perm = nil
            },
            ['simple'] = {
                value = 10000,
                perm = nil
            },
            ['simple'] = {
                value = 10000,
                perm = nil
            },
        },
    }
}

config.interior = {
    ['simple'] = {
        name = 'Simples',
        door = vector3(266.17, -1006.88, -102.0),
        vault = vector3(265.91, -999.46, -100.0),
        closet = vector3(259.67, -1003.97, -100.0)
    }
}