config = {}

config.homes = {
    ['Homes0001'] = { vector4(996.77, -729.57, 57.82, 0.0), type = 'basic', perm = nil  },
    ['Homes0002'] = { vector4(-213.38,-1618.15,38.05, 0.0), type = 'basic', perm = nil  },
    ['Homes0003'] = { vector4(-210.03,-1607.10,38.04, 0.0), type = 'basic', perm = nil  }
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
        door = vector4(266.17, -1006.88, -102.0, 0.0),
        vault = vector3(265.91, -999.46, -100.0),
        closet = vector3(259.67, -1003.97, -100.0)
    }
}