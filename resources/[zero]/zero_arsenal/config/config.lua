Tunnel = module('zero', 'lib/Tunnel')
Proxy = module('zero', 'lib/Proxy')
zero = Proxy.getInterface('zero')
zeroClient = Tunnel.getInterface('zero')

config = {}

config.permissions = {
    ['vippm.permissao'] = 'VipPolicia'
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
    }
}

config.training = {
    ['Policia'] = { 
        ['active'] = true,
        ['perm'] = nil
    }
}

config.arsenal = {
    ['Policia'] = {
        ['name'] = 'Arsenal Policia', ['description'] = 'Departamento de Polícia principal',
        ['weapons'] = {
            ['cooldownWeapons'] = { ['time'] = 30, ['noCooldown'] = 'vippm.permissao' },
            { ['spawn'] = 'WEAPON_COMBATPISTOL', ['name'] = 'HK P200', ['ammo'] = 250, ['perm'] = nil },
            { ['spawn'] = 'WEAPON_COMBATPDW', ['name'] = 'Sig Sauer MPX-SD', ['ammo'] = 250, ['perm'] = nil },
            { ['spawn'] = 'WEAPON_SMG', ['name'] = 'MP5A3', ['ammo'] = 250, ['perm'] = nil },
            { ['spawn'] = 'WEAPON_PUMPSHOTGUN', ['name'] = 'Mossberg 590', ['ammo'] = 250, ['perm'] = nil },
            { ['spawn'] = 'WEAPON_PUMPSHOTGUN_MK2', ['name'] = 'Remington 870', ['ammo'] = 250, ['perm'] = 'vippm.permissao' },
            { ['spawn'] = 'WEAPON_CARBINERIFLE', ['name'] = 'AR-15', ['ammo'] = 250, ['perm'] = 'vippm.permissao' },
            { ['spawn'] = 'WEAPON_SPECIALCARBINE', ['name'] = 'H&K G36K', ['ammo'] = 250, ['perm'] = 'vippm.permissao' },
            { ['spawn'] = 'WEAPON_SNIPERRIFLE', ['name'] = 'AWP', ['ammo'] = 250, ['perm'] = 'vippm.permissao' },
            { ['spawn'] = 'WEAPON_CARBINERIFLE_MK2', ['name'] = 'R5 RGP', ['ammo'] = 250, ['perm'] = nil },
        },
        ['utilitarys'] =  {
            ['cooldownUtilitarys']  = { ['time'] = 30, ['noCooldown'] = 'vippm.permissao' },
            { ['spawn'] = 'radio', ['name'] = 'Rádio', ['quantity'] = 1, ['perm'] = nil },
            { ['spawn'] = 'colete-militar', ['name'] = 'Colete Militar', ['quantity'] = 1, ['perm'] = nil },
            { ['spawn'] = 'wbody|WEAPON_GADGETPARACHUTE', ['name'] = 'Paraquedas', ['quantity'] = 1, ['perm'] = nil },
            { ['type'] = 'arma', ['spawn'] = 'WEAPON_NIGHTSTICK', ['name'] = 'Cassetete', ['ammo'] = 0, ['perm'] = nil },
            { ['type'] = 'arma', ['spawn'] = 'WEAPON_STUNGUN', ['name'] = 'Taser', ['ammo'] = 0, ['perm'] = nil },
        },
        ['kits'] = {
            -- ['cooldownKits'] = { ['time'] = 30, ['noCooldown'] = 'vippm.permissao' },
            -- {
            --     ['name'] = 'Ração Operacional', 
            --     ['itens'] = {
            --         ['cola'] = { ['quantity'] = 10 },
            --         ['copodecafe'] = { ['quantity'] = 10 },
            --         ['donut'] = { ['quantity'] = 20 },
            --         ['agua'] = { ['quantity'] = 15 },
            --         ['hamburger'] = { ['quantity'] = 10 },
            --     },
            --     ['perm'] = 'vippm.permissao'
            -- },
            -- {
            --     ['name'] = 'Kit Energético', 
            --     ['itens'] = {
            --         ['energetico'] = { ['quantity'] = 5 },
            --     },
            --     ['perm'] = nil
            -- },
        },
        ['canExtraAmmo'] = { 
            ['active'] = true, 
            ['quantity'] = { ['min'] = 50, ['max'] = 250 }, 
            ['perm'] = nil 
        },
        ['webhooks'] = {
            ['weapons'] = '',
            ['utilitarys'] = '',
            ['kits'] = '',
            ['ammo'] = ''
        }
    }
}

config.locs = {
    { 
        ['coord'] = vector3(180.2637, -860.7165, 31.06592), 
        ['config'] = 'Policia', 
        ['ped'] = {
            ['coord'] = vector4(180.2242, -860.6769, 31.06592, 34.01575),
            ['skin'] = 's_f_y_cop_01'
        },
        ['perm'] = 'staff.permissao'
    }
}