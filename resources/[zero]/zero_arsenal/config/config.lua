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
            { ['spawn'] = 'weapon_pistol_mk2', ['name'] = 'Five-SeveN', ['ammo'] = 250, ['perm'] = 'vippm.permissao', price = 50 },
            { ['spawn'] = 'weapon_combatpistol', ['name'] = 'Glock', ['ammo'] = 250, ['perm'] = nil, price = 50 },
            { ['spawn'] = 'weapon_smg_mk2', ['name'] = 'MP9', ['ammo'] = 250, ['perm'] = nil, price = 50 },
            { ['spawn'] = 'weapon_combatpdw', ['name'] = 'MPX', ['ammo'] = 250, ['perm'] = nil, price = 50 },
            { ['spawn'] = 'weapon_assaultsmg', ['name'] = 'M-TAR', ['ammo'] = 250, ['perm'] = 'vippm.permissao', price = 50 },
            { ['spawn'] = 'weapon_pumpshotgun_mk2', ['name'] = 'Remington', ['ammo'] = 250, ['perm'] = nil, price = 50 },
            { ['spawn'] = 'weapon_combatshotgun', ['name'] = 'Rogerio', ['ammo'] = 250, ['perm'] = 'vippm.permissao', price = 50 },
            { ['spawn'] = 'weapon_carbinerifle_mk2', ['name'] = 'M4A4', ['ammo'] = 250, ['perm'] = nil, price = 50 },
            { ['spawn'] = 'weapon_militaryrifle', ['name'] = 'AUG', ['ammo'] = 250, ['perm'] = nil, price = 50 },
            { ['spawn'] = 'weapon_tacticalrifle', ['name'] = 'M16', ['ammo'] = 250, ['perm'] = nil, price = 50 },
            { ['spawn'] = 'm_weapon_sniperrifle', ['name'] = 'M16', ['ammo'] = 250, ['perm'] = 'vippm.permissao', price = 50 },
        },
        ['utilitarys'] =  {
            ['cooldownUtilitarys']  = { ['time'] = 30, ['noCooldown'] = 'vippm.permissao', price = 50 },
            { ['spawn'] = 'radio', ['name'] = 'Rádio', ['quantity'] = 1, ['perm'] = nil, price = 50 },
            { ['spawn'] = 'spike', ['name'] = 'Spike', ['quantity'] = 1, ['perm'] = nil, price = 50 },
            { ['spawn'] = 'barreira', ['name'] = 'barreira', ['quantity'] = 1, ['perm'] = nil, price = 50 },
            { ['spawn'] = 'cone', ['name'] = 'cone', ['quantity'] = 1, ['perm'] = nil, price = 50 },
            { ['spawn'] = 'colete-militar', ['name'] = 'Colete Militar', ['quantity'] = 1, ['perm'] = nil, price = 50 },
            { ['spawn'] = 'gadget_parachute', ['name'] = 'Paraquedas', ['quantity'] = 1, ['perm'] = nil, price = 50 },
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
            ['weapons'] = 'https://discord.com/api/webhooks/1144487701572231260/OhjqS-c6N0SFySxbhRQ4ufvrOXgnCNUMeRFYabyw4OGKe7VgsXCKdku3pt23JAMJb4rz',
            ['utilitarys'] = 'https://discord.com/api/webhooks/1144487883101716572/2XiVVPl2WBg2xG62MK-EuU4YFZjkN5kjSun0P-ecFvvQbd7-GQARocQDZZ-xzrOoXP1E',
            ['kits'] = 'https://discord.com/api/webhooks/1144488253471330394/pzXdlIFTisu13914mrhXusOoVSDjfL7XWMPKfAsZhiIp-86DQ-V_lKtTckjamkQGaO-2',
            ['ammo'] = 'https://discord.com/api/webhooks/1144488454936350780/gtySgevhYIFaNsqFJFxY8chBgQw24i5OC2FBCpy64S3gBrfKnIuoTb1X9-WJf6wdOBZc'
        }
    }
}

config.locs = {
    { 
        ['coord'] = vector3(505.5824, -2756.149, 3.061523), 
        ['config'] = 'Policia', 
        ['ped'] = {
            ['coord'] = vector4(505.5824, -2756.149, 3.061523, 53.85),
            ['skin'] = 's_m_m_fiboffice_01'
        },
        ['perm'] = 'deic.permissao'
    }
}