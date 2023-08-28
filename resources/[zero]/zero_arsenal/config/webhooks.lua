config.webhooks = {
    ['weapons'] = function(source, link, arsenalName, user_id, spawn, weaponName, ammo)
        webhook(link, '```prolog\n[BN ARSENAL]\n[ARSENAL]: '..arsenalName..'\n[POLICIAL]: '..user_id..' | '..getIdentity(getUserIdentity(user_id))..'\n[PEGOU ARMAMENTO]\n[INFORMAÇÕES]\n[ARMAMENTO RETIRADO]: '..spawn..'\n[NOME]: '..weaponName..'\n[MUNIÇÃO]: '..ammo..'\n[COORD]: '..tostring(GetEntityCoords(GetPlayerPed(source)))..' '..os.date('\n[DATA]: %d/%m/%Y - [HORA]: %H:%M:%S')..' \r```')
    end,
    ['utilitaryWeapon'] = function(source, link, arsenalName, user_id, spawn, name, ammo)
        webhook(link, '```prolog\n[BN ARSENAL]\n[ARSENAL]: '..arsenalName..'\n[POLICIAL]: '..user_id..' | '..getIdentity(getUserIdentity(user_id))..'\n[PEGOU UTILITARÍO]\n[INFORMAÇÕES]\n[UTILITÁRIO RETIRADO]: '..spawn..'\n[NOME]: '..name..'\n[MUNIÇÃO]: '..ammo..'\n[COORD]: '..tostring(GetEntityCoords(GetPlayerPed(source)))..' '..os.date('\n[DATA]: %d/%m/%Y - [HORA]: %H:%M:%S')..' \r```')
    end,
    ['utilitaryItem'] = function(source, link, arsenalName, user_id, spawn, name, quantity)
        webhook(link, '```prolog\n[BN ARSENAL]\n[ARSENAL]: '..arsenalName..'\n[POLICIAL]: '..user_id..' | '..getIdentity(getUserIdentity(user_id))..'\n[PEGOU UTILITARÍO]\n[INFORMAÇÕES]\n[UTILITÁRIO RETIRADO]: '..spawn..'\n[NOME]: '..name..'\n[QUANTIDADE]: '..quantity..'\n[COORD]: '..tostring(GetEntityCoords(GetPlayerPed(source)))..' '..os.date('\n[DATA]: %d/%m/%Y - [HORA]: %H:%M:%S')..' \r```')
    end,
    ['kits'] = function(source, link, arsenalName, user_id, name)
        webhook(link, '```prolog\n[BN ARSENAL]\n[ARSENAL]: '..arsenalName..'\n[POLICIAL]: '..user_id..' | '..getIdentity(getUserIdentity(user_id))..'\n[PEGOU KIT]\n[INFORMAÇÕES]\n[KIT RETIRADO]: '..name..'\n[COORD]: '..tostring(GetEntityCoords(GetPlayerPed(source)))..' '..os.date('\n[DATA]: %d/%m/%Y - [HORA]: %H:%M:%S')..' \r```')
    end,
    ['ammo'] = function(source, link, arsenalName, user_id, spawn, ammoExtra)
        webhook(link, '```prolog\n[BN ARSENAL]\n[ARSENAL]: '..arsenalName..'\n[POLICIAL]: '..user_id..' | '..getIdentity(getUserIdentity(user_id))..'\n[PEGOU MUNIÇÃO EXTRA]\n[INFORMAÇÕES]\n[MUNIÇÃO RETIRADA]: '..spawn..'\n[NOME]: '..spawn..'\n[QUANTIDADE]: '..ammoExtra..'\n[COORD]: '..tostring(GetEntityCoords(GetPlayerPed(source)))..' '..os.date('\n[DATA]: %d/%m/%Y - [HORA]: %H:%M:%S')..' \r```')
    end
}