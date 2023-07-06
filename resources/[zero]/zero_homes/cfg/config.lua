Tunnel = module('zero', 'lib/Tunnel')
Proxy = module('zero', 'lib/Proxy')
zero = Proxy.getInterface('zero')

config = {}

config.general = {
    lateFee = 15, -- TAXA ATRASADA (PADRÃO 15 DIAS)
}

config.homes = {
    ['Home0001'] = { coord = vector3(996.77, -729.57, 57.82), type = 'basic', perm = { 'staff.permissao' }  },
    ['Home0002'] = { coord = vector3(-213.38,-1618.15,38.05), type = 'basic', perm = { 'staff.permissao' }  },
    ['Home0003'] = { coord = vector3(-210.03,-1607.10,38.04), type = 'basic', perm = { 'staff.permissao' }  },
    ['Home0004'] = { coord = vector3(-212.10,-1617.38,38.05), type = 'basic', perm = { 'staff.permissao' } }
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
            _default = 'simple',
            ['simple'] = {
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
        door = vector3(266.0176, -1007.42, -101.0198),
        vault = vector3(265.8857, -999.4286, -99.01465),
        closet = vector3(259.67, -1003.97, -100.0)
    }
}