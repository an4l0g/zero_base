config = {}

config.general = {
    ['pm'] = {
        name = 'Elevador Polícia',
        locations = {
            { coord = vector4(-2276.242, 346.7077, 174.5927, 22.67716), text = 'Andar 1°' },
            { coord = vector4(-2268.343, 378.567, 188.7466, 25.51181), text = 'H' },
        }
    },
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
            { coord = vector4(-320.9407, 209.7231, 87.91724, 274.9606), text = 'Térreo' },
            { coord = vector4(-304.1143, 192.4088, 144.3641, 96.37794), text = 'Cobertura' },
            { coord = vector4(-320.8484, 209.7758, 81.76709, 283.4646), text = 'Subsolo' },
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
    { coord = vector3(-777.8901, -1219.16, 7.324585-0.97), config = 'hospital', perm = { 'staff.permissao', 'hospital.permissao' } },
    { coord = vector3(-777.1121, -1220.492, 15.54724-0.97), config = 'hospital', perm = { 'staff.permissao', 'hospital.permissao' } },

    { coord = vector3(-321.0857, 209.5517, 87.91724-0.97), config = 'lux', }, -- perm = { 'staff.permissao' } },
    { coord = vector3(-304.0483, 192.356, 144.3641-0.97), config = 'lux', }, -- perm = { 'staff.permissao' } },
    { coord = vector3(-320.8879, 209.6967, 81.76709-0.97), config = 'lux', }, -- perm = { 'staff.permissao' } },

    { coord = vector3(5012.532, -5748.962, 28.94287-0.97), config = 'ordem', }, -- perm = { 'staff.permissao' } },
    { coord = vector3(5012.466, -5746.734, 15.47986-0.97), config = 'ordem', }, -- perm = { 'staff.permissao' } },

    { coord = vector3(-776.9143, 319.622, 85.6593-0.97), config = 'eclipse', }, -- perm = { 'staff.permissao' } },
    { coord = vector3(-768.8176, 336.778, 243.3737-0.97), config = 'eclipse', }, -- perm = { 'staff.permissao' } },

    { coord = vector3(-305.0242, -721.1605, 28.01611-0.97), config = 'cobertura', }, -- perm = { 'staff.permissao' } },
    { coord = vector3(-288.2769, -722.4264, 125.4586-0.97), config = 'cobertura', }, -- perm = { 'staff.permissao' } },

    { coord = vector3(-2268.356, 378.5934, 188.7466-0.97), config = 'pm' }, -- perm = { 'staff.permissao' } },
    { coord = vector3(-2276.308, 346.8396, 174.5927-0.97), config = 'pm' }, -- perm = { 'staff.permissao' } },
    { coord = vector3(-2279.815, 345.2703, 174.5927-0.97), config = 'pm' }, -- perm = { 'staff.permissao' } },
}

Tunnel = module('zero', 'lib/Tunnel')
Proxy = module('zero', 'lib/Proxy')
zero = Proxy.getInterface('zero')