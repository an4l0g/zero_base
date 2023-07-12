config = {}

config.general = {
    incomeActive = true, -- Redimento | true or false
    incomeTime = 60 * 60 * 1000, -- 1 Hora
    income = 0.001 -- Valor que irá receber
}

config.bank = {
    { coord = vector3(149.8945, -1040.835, 29.36414), perm = nil  },
    { coord = vector3(148.3517, -1040.242, 29.36414), perm = nil  },
    { coord = vector3(314.38,-278.72,54.17), perm = nil  },
    { coord = vector3(1174.90,2706.57,38.09), perm = nil  },
    { coord = vector3(-2962.58,482.83,15.71), perm = nil  },
    { coord = vector3(-112.91,6469.72,31.63), perm = nil  }
}

Tunnel = module('zero', 'lib/Tunnel')
Proxy = module('zero', 'lib/Proxy')
zero = Proxy.getInterface('zero')

if IsDuplicityVersion() then
    zeroClient = Tunnel.getInterface('zero')
else
    zeroServer = Tunnel.getInterface('zero')
end