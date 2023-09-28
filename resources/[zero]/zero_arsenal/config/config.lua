Tunnel = module('zero', 'lib/Tunnel')
Proxy = module('zero', 'lib/Proxy')
zero = Proxy.getInterface('zero')
zeroClient = Tunnel.getInterface('zero')

config = {}

config.permissions = {
    ['vippm.permissao'] = 'Vip Policia'
}

config.attachs = {
    ['Policia'] = {
        ['active'] = true,
        ['weapons'] = {
            ['WEAPON_COMBATPISTOL'] = {
                ['components'] = { 'COMPONENT_AT_PI_FLSH' }
            },
            ['WEAPON_COMBATPDW'] = {
                ['components'] = { 'COMPONENT_AT_AR_FLSH', 'COMPONENT_AT_SCOPE_SMALL', 'COMPONENT_AT_AR_AFGRIP' }
            },
            ['WEAPON_SMG'] = {
                ['components'] = { 'COMPONENT_AT_AR_FLSH', 'COMPONENT_AT_SCOPE_MACRO_02' }
            },
            ['WEAPON_PUMPSHOTGUN'] = {
                ['components'] = { 'COMPONENT_AT_AR_FLSH' }
            },
            ['WEAPON_PUMPSHOTGUN_MK2'] = {
                ['components'] = { 'COMPONENT_AT_SIGHTS', 'COMPONENT_AT_SCOPE_SMALL_MK2', 'COMPONENT_AT_AR_FLSH', 'COMPONENT_AT_MUZZLE_08' }
            },
            ['WEAPON_CARBINERIFLE'] = {
                ['components'] = { 'COMPONENT_AT_AR_FLSH', 'COMPONENT_AT_AR_AFGRIP', 'COMPONENT_AT_SCOPE_MEDIUM' }
            },
            ['WEAPON_CARBINERIFLE_MK2'] = {
                ['components'] = { 'COMPONENT_AT_MUZZLE_04', 'COMPONENT_AT_AR_AFGRIP_02', 'COMPONENT_AT_AR_FLSH', 'COMPONENT_AT_SCOPE_MEDIUM_MK2' }
            },
            ['WEAPON_SPECIALCARBINE'] = {
                ['components'] = { 'COMPONENT_AT_AR_FLSH', 'COMPONENT_AT_SCOPE_MEDIUM', 'COMPONENT_AT_AR_AFGRIP' }
            },
            ['WEAPON_SNIPERRIFLE'] = {
                ['components'] = { 'COMPONENT_AT_SCOPE_MAX' }
            }
        },
        ['perm'] = nil
    },
    ['Deic'] = {
        ['active'] = true,
        ['weapons'] = {
            ['WEAPON_COMBATPISTOL'] = {
                ['components'] = { 'COMPONENT_AT_PI_FLSH' }
            },
            ['WEAPON_COMBATPDW'] = {
                ['components'] = { 'COMPONENT_AT_AR_FLSH', 'COMPONENT_AT_SCOPE_SMALL', 'COMPONENT_AT_AR_AFGRIP' }
            },
            ['WEAPON_SMG'] = {
                ['components'] = { 'COMPONENT_AT_AR_FLSH', 'COMPONENT_AT_SCOPE_MACRO_02' }
            },
            ['WEAPON_PUMPSHOTGUN'] = {
                ['components'] = { 'COMPONENT_AT_AR_FLSH' }
            },
            ['WEAPON_PUMPSHOTGUN_MK2'] = {
                ['components'] = { 'COMPONENT_AT_SIGHTS', 'COMPONENT_AT_SCOPE_SMALL_MK2', 'COMPONENT_AT_AR_FLSH', 'COMPONENT_AT_MUZZLE_08' }
            },
            ['WEAPON_CARBINERIFLE'] = {
                ['components'] = { 'COMPONENT_AT_AR_FLSH', 'COMPONENT_AT_AR_AFGRIP', 'COMPONENT_AT_SCOPE_MEDIUM' }
            },
            ['WEAPON_CARBINERIFLE_MK2'] = {
                ['components'] = { 'COMPONENT_AT_MUZZLE_04', 'COMPONENT_AT_AR_AFGRIP_02', 'COMPONENT_AT_AR_FLSH', 'COMPONENT_AT_SCOPE_MEDIUM_MK2' }
            },
            ['WEAPON_SPECIALCARBINE'] = {
                ['components'] = { 'COMPONENT_AT_AR_FLSH', 'COMPONENT_AT_SCOPE_MEDIUM', 'COMPONENT_AT_AR_AFGRIP' }
            },
            ['WEAPON_SNIPERRIFLE'] = {
                ['components'] = { 'COMPONENT_AT_SCOPE_MAX' }
            }
        },
        ['perm'] = nil
    }
}

config.training = {
    ['Policia'] = { 
        ['active'] = true,
        ['perm'] = nil
    },
    ['Deic'] = { 
        ['active'] = true,
        ['perm'] = nil
    }
}

config.arsenal = {
    ['Policia'] = {
        ['name'] = 'Arsenal Policia', ['description'] = 'Departamento de Polícia principal',
        ['weapons'] = {
            ['cooldownWeapons'] = { ['time'] = 30, ['noCooldown'] = 'vippm.permissao' },
            { ['spawn'] = 'weapon_pistol_mk2', ['name'] = 'Five-SeveN', ['ammo'] = 250, ['perm'] = 'vippm.permissao', price = 50 },
            { ['spawn'] = 'weapon_combatpistol', ['name'] = 'Glock', ['ammo'] = 250, ['perm'] = nil, price = 50 },
            { ['spawn'] = 'weapon_smg_mk2', ['name'] = 'MP9', ['ammo'] = 250, ['perm'] = nil, price = 50 },
            { ['spawn'] = 'weapon_combatpdw', ['name'] = 'MPX', ['ammo'] = 250, ['perm'] = nil, price = 50 },
            { ['spawn'] = 'weapon_assaultsmg', ['name'] = 'M-TAR', ['ammo'] = 250, ['perm'] = 'vippm.permissao', price = 50 },
            { ['spawn'] = 'weapon_pumpshotgun_mk2', ['name'] = 'Remington', ['ammo'] = 250, ['perm'] = nil, price = 50 },
            { ['spawn'] = 'weapon_combatshotgun', ['name'] = 'SPAS-12', ['ammo'] = 250, ['perm'] = 'vippm.permissao', price = 50 },
            { ['spawn'] = 'weapon_carbinerifle_mk2', ['name'] = 'M4A4', ['ammo'] = 250, ['perm'] = nil, price = 50 },
            { ['spawn'] = 'weapon_militaryrifle', ['name'] = 'AUG', ['ammo'] = 250, ['perm'] = nil, price = 50 },
            { ['spawn'] = 'weapon_tacticalrifle', ['name'] = 'M16', ['ammo'] = 250, ['perm'] = nil, price = 50 },
            { ['spawn'] = 'weapon_sniperrifle', ['name'] = 'AWP', ['ammo'] = 250, ['perm'] = 'vippm.permissao', price = 50 },
        },
        ['utilitarys'] =  {
            ['cooldownUtilitarys']  = { ['time'] = 30, ['noCooldown'] = 'vippm.permissao', price = 50 },
            { ['spawn'] = 'radio', ['name'] = 'Rádio', ['quantity'] = 1, ['perm'] = nil, price = 50 },
            { ['spawn'] = 'spike', ['name'] = 'Spike', ['quantity'] = 1, ['perm'] = nil, price = 50 },
            { ['spawn'] = 'barreira', ['name'] = 'Barreira', ['quantity'] = 1, ['perm'] = nil, price = 50 },
            { ['spawn'] = 'mochila-pequena', ['name'] = 'Mochila Pequena', ['quantity'] = 1, ['perm'] = nil, price = 500 },
            { ['spawn'] = 'cone', ['name'] = 'Cone', ['quantity'] = 1, ['perm'] = nil, price = 50 },
            { ['spawn'] = 'celular', ['name'] = 'Celular', ['quantity'] = 1, ['perm'] = nil, price = 900 },
            { ['spawn'] = 'energetico', ['name'] = 'Energético', ['quantity'] = 1, ['perm'] = nil, price = 600, infinityBuy = true },
            { ['spawn'] = 'algema', ['name'] = 'Algema', ['quantity'] = 1, ['perm'] = nil, price = 50 },
            { ['spawn'] = 'colete-militar', ['name'] = 'Colete Militar', ['quantity'] = 1, ['perm'] = nil, price = 50 },
            -- { ['spawn'] = 'gadget_parachute', ['name'] = 'Paraquedas', ['quantity'] = 1, ['perm'] = nil, price = 50 },
            { ['type'] = 'arma', ['spawn'] = 'WEAPON_NIGHTSTICK', ['name'] = 'Cassetete', ['ammo'] = 0, ['perm'] = nil, price = 50 },
            { ['type'] = 'arma', ['spawn'] = 'WEAPON_STUNGUN', ['name'] = 'Taser', ['ammo'] = 0, ['perm'] = nil, price = 50 },
        },
        ['kits'] = {},
        ['canExtraAmmo'] = { 
            ['active'] = true, 
            ['quantity'] = { ['min'] = 50, ['max'] = 250 }, 
            ['perm'] = nil 
        },
        ['webhooks'] = {
            ['weapons'] = 'https://discord.com/api/webhooks/1154980125721505812/cVhrBslhWc5lKy6eq4xGrrSdhl9OhUDVyOSkQoFvvPlOxGo_PAs86mdV8O3GVKDABy1A',
            ['utilitarys'] = 'https://discord.com/api/webhooks/1154980703541415938/v3ORz_GGv7mZpmuXkkQ49uhKQIEBTnOQd8N0q23ojDvmvMGhT0rZJqpzaxHTaxOzMl4T',
            ['kits'] = 'https://discord.com/api/webhooks/1154981137513467975/EjFMR_YslbBvBu0IYK5lC_-GLF6-H42UAP6W90K8z19et_-TWY3US1H2PsDiToZr8YR_',
            ['ammo'] = 'https://discord.com/api/webhooks/1154991787392389180/pvNjHDHeadkmzUvgNLKLyAWBgxSfkVJzk38F5lTK9WMOkJREwJD1JlAW3o-cmluMm9Nh'
        }
    },
    ['Deic'] = {
        ['name'] = 'Arsenal DEIC', ['description'] = 'Departamento da Polícia Investigativa',
        ['weapons'] = {
            ['cooldownWeapons'] = { ['time'] = 30, ['noCooldown'] = 'vippm.permissao' },
            { ['spawn'] = 'weapon_pistol_mk2', ['name'] = 'Five-SeveN', ['ammo'] = 250, ['perm'] = 'vippm.permissao', price = 50 },
            { ['spawn'] = 'weapon_combatpistol', ['name'] = 'Glock', ['ammo'] = 250, ['perm'] = nil, price = 50 },
            { ['spawn'] = 'weapon_smg_mk2', ['name'] = 'MP9', ['ammo'] = 250, ['perm'] = nil, price = 50 },
            { ['spawn'] = 'weapon_combatpdw', ['name'] = 'MPX', ['ammo'] = 250, ['perm'] = nil, price = 50 },
            { ['spawn'] = 'weapon_assaultsmg', ['name'] = 'M-TAR', ['ammo'] = 250, ['perm'] = 'vippm.permissao', price = 50 },
            { ['spawn'] = 'weapon_pumpshotgun_mk2', ['name'] = 'Remington', ['ammo'] = 250, ['perm'] = nil, price = 50 },
            { ['spawn'] = 'weapon_combatshotgun', ['name'] = 'SPAS-12', ['ammo'] = 250, ['perm'] = 'vippm.permissao', price = 50 },
            { ['spawn'] = 'weapon_carbinerifle_mk2', ['name'] = 'M4A4', ['ammo'] = 250, ['perm'] = nil, price = 50 },
            { ['spawn'] = 'weapon_militaryrifle', ['name'] = 'AUG', ['ammo'] = 250, ['perm'] = nil, price = 50 },
            { ['spawn'] = 'weapon_tacticalrifle', ['name'] = 'M16', ['ammo'] = 250, ['perm'] = nil, price = 50 },
            { ['spawn'] = 'weapon_sniperrifle', ['name'] = 'AWP', ['ammo'] = 250, ['perm'] = 'vippm.permissao', price = 50 },
        },
        ['utilitarys'] =  {
            ['cooldownUtilitarys']  = { ['time'] = 30, ['noCooldown'] = 'vippm.permissao', price = 50 },
            { ['spawn'] = 'radio', ['name'] = 'Rádio', ['quantity'] = 1, ['perm'] = nil, price = 50 },
            { ['spawn'] = 'spike', ['name'] = 'Spike', ['quantity'] = 1, ['perm'] = nil, price = 50 },
            { ['spawn'] = 'barreira', ['name'] = 'Barreira', ['quantity'] = 1, ['perm'] = nil, price = 50 },
            { ['spawn'] = 'cone', ['name'] = 'Cone', ['quantity'] = 1, ['perm'] = nil, price = 50 },
            { ['spawn'] = 'celular', ['name'] = 'Celular', ['quantity'] = 1, ['perm'] = nil, price = 900 },
            { ['spawn'] = 'energetico', ['name'] = 'Energético', ['quantity'] = 1, ['perm'] = nil, price = 600, infinityBuy = true },
            { ['spawn'] = 'colete-militar', ['name'] = 'Colete Militar', ['quantity'] = 1, ['perm'] = nil, price = 50 },
            -- { ['spawn'] = 'gadget_parachute', ['name'] = 'Paraquedas', ['quantity'] = 1, ['perm'] = nil, price = 50 },
            { ['type'] = 'arma', ['spawn'] = 'WEAPON_NIGHTSTICK', ['name'] = 'Cassetete', ['ammo'] = 0, ['perm'] = nil, price = 50 },
            { ['type'] = 'arma', ['spawn'] = 'WEAPON_STUNGUN', ['name'] = 'Taser', ['ammo'] = 0, ['perm'] = nil, price = 50 },
        },
        ['kits'] = {},
        ['canExtraAmmo'] = { 
            ['active'] = true, 
            ['quantity'] = { ['min'] = 50, ['max'] = 250 }, 
            ['perm'] = nil 
        },
        ['webhooks'] = {
            ['weapons'] = 'https://discord.com/api/webhooks/1154980125721505812/cVhrBslhWc5lKy6eq4xGrrSdhl9OhUDVyOSkQoFvvPlOxGo_PAs86mdV8O3GVKDABy1A',
            ['utilitarys'] = 'https://discord.com/api/webhooks/1154980703541415938/v3ORz_GGv7mZpmuXkkQ49uhKQIEBTnOQd8N0q23ojDvmvMGhT0rZJqpzaxHTaxOzMl4T',
            ['kits'] = 'https://discord.com/api/webhooks/1154981137513467975/EjFMR_YslbBvBu0IYK5lC_-GLF6-H42UAP6W90K8z19et_-TWY3US1H2PsDiToZr8YR_',
            ['ammo'] = 'https://discord.com/api/webhooks/1154991787392389180/pvNjHDHeadkmzUvgNLKLyAWBgxSfkVJzk38F5lTK9WMOkJREwJD1JlAW3o-cmluMm9Nh'
        }
    }
}

config.locs = {
    { 
        ['coord'] = vector3(485.0638, 4521.824, 80.36853), 
        ['config'] = 'Deic', 
        ['ped'] = {
            ['coord'] = vector4(485.0638, 4521.824, 80.36853, 266.4567),
            ['skin'] = 's_m_m_fiboffice_01'
        },
        ['perm'] = 'deic.permissao'
    },
    { 
        ['coord'] = vector3(-2310.224, 344.189, 174.5927), 
        ['config'] = 'Policia', 
        ['ped'] = {
            ['coord'] = vector4(-2310.224, 344.189, 174.5927, 249.4488),
            ['skin'] = 's_m_m_fiboffice_01'
        },
        ['perm'] = 'policia.permissao'
    }
}