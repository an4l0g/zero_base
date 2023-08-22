config = {}

config.general = {
    ['hospital'] = {
        name = 'Elevador Hospital',
        locations = {
            { coord = vector4(-777.8373, -1219.134, 7.324585, 51.02362), text = 'Andar 1°' },
            { coord = vector4(-777.1121, -1220.479, 15.54724, 138.8976), text = 'Andar 2°' },
        }
    },
    ['lux'] = {
        name = 'Elevador Lux',
        locations = {
            { coord = vector4(-323.4198, 209.4066, 87.95093, 280.6299), text = 'Térreo' },
            { coord = vector4(-301.833, 192, 144.4147, 82.20473), text = 'Cobertura' },
            { coord = vector4(-323.222, 209.4725, 81.83447, 280.6299), text = 'Subsolo' },
        }
    },
    ['ordem'] = {
        name = 'Elevador Ordem',
        locations = {
            { coord = vector4(5012.229, -5748.896, 28.94287, 138.8976), text = 'Andar 1°' },
            { coord = vector4(5012.479, -5746.734, 15.47986, 150.2362), text = 'Subsolo' },
        }
    },
    ['eclipse'] = {
        name = 'Elevador Eclipse',
        locations = {
            { coord = vector4(-776.9011, 319.622, 85.6593, 0), text = 'Andar 1°' },
            { coord = vector4(-768.8176, 336.7912, 243.3737, 87.87402), text = 'Andar 2°' },
        }
    },
    ['cobertura'] = {
        name = 'Elevador Cobertura',
        locations = {
            { coord = vector4(-305.011, -721.1473, 28.01611, 158.7402), text = 'Andar 1°' },
            { coord = vector4(-288.2637, -722.4264, 125.4586, 249.4488), text = 'Andar 2°' },
        }
    },
}

config.location = {
    { coord = vector4(-777.8373, -1219.134, 7.324585, 51.02362), config = 'hospital', perm = { 'staff.permissao', 'hospital.permissao' } },
    { coord = vector4(-777.1121, -1220.479, 15.54724, 138.8976), config = 'hospital', perm = { 'staff.permissao', 'hospital.permissao' } },

    { coord = vector4(-323.4198, 209.4066, 87.95093, 280.6299), config = 'lux' }, -- perm = { 'staff.permissao' } },
    { coord = vector4(-301.833, 192, 144.4147, 82.20473), config = 'lux' }, -- perm = { 'staff.permissao' } },
    { coord = vector4(-323.222, 209.4725, 81.83447, 280.6299), config = 'lux' }, -- perm = { 'staff.permissao' } },

    { coord = vector4(5012.229, -5748.896, 28.94287, 138.8976), config = 'ordem' }, -- perm = { 'staff.permissao' } },
    { coord = vector4(5012.479, -5746.734, 15.47986, 150.2362), config = 'ordem' }, -- perm = { 'staff.permissao' } },

    { coord = vector4(-776.9011, 319.622, 85.6593, 0), config = 'eclipse' }, -- perm = { 'staff.permissao' } },
    { coord = vector4(-768.8176, 336.7912, 243.3737, 87.87402), config = 'eclipse' }, -- perm = { 'staff.permissao' } },

    { coord = vector4(-305.011, -721.1473, 28.01611, 158.7402), config = 'cobertura' }, -- perm = { 'staff.permissao' } },
    { coord = vector4(-288.2637, -722.4264, 125.4586, 249.4488), config = 'cobertura' }, -- perm = { 'staff.permissao' } },
}

Tunnel = module('zero', 'lib/Tunnel')
Proxy = module('zero', 'lib/Proxy')
zero = Proxy.getInterface('zero')