local srv = {}
Tunnel.bindInterface('Commands', srv)
local vCLIENT = Tunnel.getInterface('Commands')

---------------------------------------
-- ME
---------------------------------------
srv.checkPermission = function(perm)
    local source = source
    local user_id = zero.getUserId(source)
    return zero.checkPermissions(user_id, perm)
end

---------------------------------------
-- ME
---------------------------------------
local meWebhook = 'https://discord.com/api/webhooks/1149090557696679966/DM9FgQRU_lXFMkaqYVdZJaPyKwEaCQlVcBewYJWgHre_JUJ2r0t5zkeFE55p5RwERfZ_'
RegisterCommand('me', function(source, args, raw)
    local user_id = zero.getUserId(source)
    if (user_id) then
        if (GetEntityHealth(GetPlayerPed(source)) > 101) then
            TriggerClientEvent('DisplayMe', -1, raw:sub(3), source)
            zero.webhook(meWebhook, '```prolog\n[/ME]\n[USER]: '..user_id..'\n[TEXT]:'..raw:sub(3)..'\n[COORD]: '..tostring(GetEntityCoords(GetPlayerPed(source)))..os.date('\n[DATE]: %d/%m/%Y [HOUR]: %H:%M:%S')..' \r```')
        end
    end
end)

---------------------------------------
-- GIVE INVENTORY ITEM
---------------------------------------
srv.giveInventoryItem = function(item)
    local source = source
    local user_id = zero.getUserId(source)
    zero.giveInventoryItem(user_id, item, 1)
end

---------------------------------------
-- DELETE ALL OBJECTS
---------------------------------------
RegisterCommand('dobjall', function(source, args)
    local source = source
    local user_id = zero.getUserId(source)
    if (user_id) and zero.hasPermission(user_id, '+Staff.Moderador') then
        local count = 0
        for _, v in pairs(GetAllObjects()) do
            if (DoesEntityExist(v)) then
                DeleteEntity(v)
                count = count + 1
            end
        end
        TriggerClientEvent('announcement', -1, 'Alerta', 'Foi deletado <b>'..count..' objetos</b> da nossa cidade.', 'Governo', true, 30000)
    end
end)

---------------------------------------
-- GOD
---------------------------------------
RegisterCommand('god', function(source, args)
    local _userId = zero.getUserId(source)
    if (_userId) and zero.hasPermission(_userId, 'staff.permissao') then
        local _identity = zero.getUserIdentity(_userId)
        if (args[1]) then
            local other_id = parseInt(args[1])
            local nPlayer = zero.getUserSource(other_id)
            if (nPlayer) then
                zeroClient.killGod(nPlayer)
                zeroClient.setHealth(nPlayer, 200) 
                zero.varyHunger(other_id, -100)     
                zero.varyThirst(other_id, -100)          
			end
        else
            zeroClient.killGod(source)
			zeroClient.setHealth(source, 200)
            zero.varyHunger(_userId, -100)     
            zero.varyThirst(_userId, -100)    
        end
        zero.webhook('God', '```prolog\n[/GOD]\n[STAFF]: #'.._userId..' '.._identity.firstname..' '.._identity.lastname..' \n[REVIVEU]: '..(args[1] or _userId)..'\n[COORD]: '..tostring(GetEntityCoords(GetPlayerPed(source)))..os.date('\n[DATA]: %d/%m/%Y [HORA]: %H:%M:%S')..' \r```')
    end
end)

---------------------------------------
-- GODALL
---------------------------------------
RegisterCommand('godall', function(source)
    local source = source
    local user_id = zero.getUserId(source)
    local identity = zero.getUserIdentity(user_id)
    if (user_id) and zero.hasPermission(user_id, '+Staff.Administrador') then
        local users = zero.getUsers()
        for k, v in pairs(users) do
            local id = zero.getUserSource(parseInt(k))
            if (id) then
            	zeroClient._killGod(id)
				zeroClient._setHealth(id, 200)
            end
        end
        zero.webhook('GodAll', '```prolog\n[/GODALL]\n[STAFF]: #'..user_id..' '..identity.firstname..' '..identity.lastname..' \n[REVIVEU]: TODOS!\n[COORD]: '..tostring(GetEntityCoords(GetPlayerPed(source)))..os.date('\n[DATA]: %d/%m/%Y [HORA]: %H:%M:%S')..' \r```')
    end
end)

---------------------------------------
-- GODALL
---------------------------------------
RegisterCommand('godarea', function(source)
    local source = source
    local user_id = zero.getUserId(source)
    local identity = zero.getUserIdentity(user_id)
    if (user_id) and zero.hasPermission(user_id, '+Staff.Administrador') then
        local radius = zero.prompt(source, { 'Distancia' })
        radius[1] = parseInt(radius[1])
        if (radius[1]) and radius[1] > 0 then
            local players = zeroClient.getNearestPlayers(source, radius[1])
            for k, v in pairs(players) do
                zeroClient._killGod(k)
				zeroClient._setHealth(k, 200) 
            end
            zero.webhook('GodArea', '```prolog\n[/GODAREA]\n[STAFF]: #'..user_id..' '..identity.firstname..' '..identity.lastname..' \n[ÁREA]: '..radius[1]..'\n[COORD]: '..tostring(GetEntityCoords(GetPlayerPed(source)))..os.date('\n[DATA]: %d/%m/%Y [HORA]: %H:%M:%S')..' \r```')
        end
    end
end)

---------------------------------------
-- FREEZE
---------------------------------------
RegisterCommand('freeze', function(source, args)
    local source = source
    local user_id = zero.getUserId(source)
    if (user_id) and zero.hasPermission(user_id, 'staff.permissao') then
        if (args[1]) then
            local nSource = zero.getUserSource(parseInt(args[1]))
            if (nSource) then
                local ped = GetPlayerPed(nSource)
                TriggerClientEvent('notify', source, 'Freeze', 'Você <b>freezou</b> o jogador!')
                TriggerClientEvent('notify', nSource, 'Freeze', 'Você foi <b>freezado</b> por um staff!')
                FreezeEntityPosition(ped, true)
            end
        else
            local ped = GetPlayerPed(source)
            TriggerClientEvent('notify', source, 'Freeze', 'Você se <b>freezou</b>!')
            FreezeEntityPosition(ped, true)
        end

        zero.webhook('Freeze', '```prolog\n[/FREEZE]\n[USER]: '..user_id..'\n[TARGET]: '..(args[1] and args[1] or user_id)..os.date('\n[DATE]: %d/%m/%Y [HOUR]: %H:%M:%S')..' \r```')
    end
end)

RegisterCommand('unfreeze', function(source, args)
    local source = source
    local user_id = zero.getUserId(source)
    if (user_id) and zero.hasPermission(user_id, 'staff.permissao') then
        if (args[1]) then
            local nSource = zero.getUserSource(parseInt(args[1]))
            if (nSource) then
                local ped = GetPlayerPed(nSource)
                TriggerClientEvent('notify', source, 'Freeze', 'Você <b>desfreezou</b> o jogador!')
                TriggerClientEvent('notify', nSource, 'Freeze', 'Você foi <b>desfreezado</b> por um staff!')
                FreezeEntityPosition(ped, false)
            end
        else
            local ped = GetPlayerPed(source)
            TriggerClientEvent('notify', source, 'Freeze', 'Você se <b>desfreezou</b>!')
            FreezeEntityPosition(ped, false)
        end

        zero.webhook('Freeze', '```prolog\n[/UNFREEZE]\n[USER]: '..user_id..'\n[TARGET]: '..(args[1] and parseInt(args[1]) or user_id)..os.date('\n[DATE]: %d/%m/%Y [HOUR]: %H:%M:%S')..' \r```')
    end
end)

---------------------------------------
-- NEYMAR
---------------------------------------
RegisterCommand('ney', function(source, args)
    local source = source
    local user_id = zero.getUserId(source)
    if (user_id) and zero.hasPermission(user_id, 'staff.permissao') then
        if (args[1]) then
            local nSource = zero.getUserSource(parseInt(args[1]))
            if (nSource) then
                TriggerClientEvent('ney', nSource)
                TriggerClientEvent('notify', source, 'Neymar', 'Você <b>derrubou</b> o jogador!')
                zero.webhook('Neymar', '```prolog\n[/FREEZE]\n[USER]: '..user_id..'\n[TARGET]: '..(args[1] and args[1] or user_id)..os.date('\n[DATE]: %d/%m/%Y [HOUR]: %H:%M:%S')..' \r```')
            end
        end
    end
end)

---------------------------------------
-- WALL
---------------------------------------
srv.getWallId = function(sourceplayer)
    if (sourceplayer ~= nil and parseInt(sourceplayer) > 0) then
        return zero.getUserId(sourceplayer), Player(sourceplayer).state.Cam
    end
end

RegisterCommand('ids', function(source)
    local source = source
    local user_id = zero.getUserId(source)
    if (user_id) and zero.hasPermission(user_id, 'staff.permissao') then
        if (Player(source).state.Wall) then
            Player(source).state.Wall = false
            TriggerClientEvent('notify', source, 'Wall', 'Você desativou o <b>wall</b>!')
            zero.webhook('Ids', '```prolog\n[IDS]\n[ACTION]: (DISABLE WALL)\n[USER]: '..user_id..'\n[COORD]: '..GetEntityCoords(GetPlayerPed(source))..os.date('\n[DATE]: %d/%m/%y [HOUR]: %X')..'```')
        else
            Player(source).state.Wall = true
            TriggerClientEvent('notify', source, 'Wall', 'Você ativou o <b>wall</b>!')
            zero.webhook('Ids', '```prolog\n[IDS]\n[ACTION]: (ACTIVE WALL)\n[USER]: '..user_id..'\n[COORD]: '..GetEntityCoords(GetPlayerPed(source))..os.date('\n[DATE]: %d/%m/%y [HOUR]: %X')..'```')
        end
    end
end)

---------------------------------------
-- KILL
---------------------------------------
RegisterCommand('kill', function(source, args)
    local source = source
    local user_id = zero.getUserId(source)
    local identity = zero.getUserIdentity(user_id)
    if (user_id) and zero.hasPermission(user_id, '+Staff.Moderador') then
        if (args[1]) then
            local nPlayer = zero.getUserSource(parseInt(args[1]))
            if (nPlayer) then
                zeroClient.killGod(nPlayer)
                zeroClient.setHealth(nPlayer, 0)
                zeroClient.setArmour(nPlayer, 0)
            end
        else
            zeroClient.killGod(source)
            zeroClient.setHealth(source, 0)
            zeroClient.setArmour(source, 0)
        end
        zero.webhook('Kill', '```prolog\n[ID]: #'..user_id..' '..identity.firstname..' '..identity.lastname..' \n[MATOU]: '..(args[1] or user_id)..os.date('\n[DATA]: %d/%m/%Y [HORA]: %H:%M:%S')..' \r```')
    end
end)

---------------------------------------
-- KICK
---------------------------------------
RegisterCommand('kick', function(source, args)
    local source = source
    local user_id = zero.getUserId(source)
    local identity = zero.getUserIdentity(user_id)
    if (user_id) and zero.hasPermission(user_id, 'staff.permissao') then
        if (args[1]) then
            local prompt = zero.prompt(source, { 'Motivo' })
            if (prompt) then
                prompt = prompt[1]
                local nPlayer = zero.getUserSource(parseInt(args[1]))
                if (nPlayer) then
                    DropPlayer(nPlayer, 'Você foi kikado da nossa cidade.\nSeu passaporte: #'..args[1]..'\n Motivo: '..prompt..'\nAutor: '..identity.firstname..' '..identity.lastname)
                    TriggerClientEvent('notify', source, 'Kick', 'Voce kickou o passaporte <b>'..args[1]..'</b> da cidade.')
                    zero.webhook('Kick', '```prolog\n[/KICK]\n[STAFF]: #'..user_id..' '..identity.firstname..' '..identity.lastname..' \n[KICKOU]: '..args[1]..'\n[MOTIVO]: '..prompt..os.date('\n[DATA]: %d/%m/%Y [HORA]: %H:%M:%S')..' \r```')
                end
            end
        end
    end
end)

---------------------------------------
-- KICKALL
---------------------------------------
RegisterCommand('kickall', function(source)
    local source = source
    local user_id = zero.getUserId(source)
    local identity = zero.getUserIdentity(user_id)
    if (user_id) and zero.hasPermission(user_id, '+Staff.Administrador') then
        TriggerClientEvent('announcement', -1, 'Alerta', 'Foi detectado um terremoto de <b>magnitude 8</b> na <b>Escala Richter</b> chegando em nossa cidade. Mantenha a calma e procure um abrigo.', 'Governo', true, 30000)
        Citizen.Wait(5000)
        TriggerClientEvent('zero_core:terremoto', -1)
        Citizen.Wait(15000)
        local players = zero.getUsers()
        for k, v in pairs(players) do
            local nSource = zero.getUserSource(parseInt(k))
            if (nSource) then
                DropPlayer(nSource, 'Você foi vítima de um terremoto.')
                zero.webhook('KickAll', '```prolog\n[/KICKALL]\n[STAFF]: #'..user_id..' '..identity.firstname..' '..identity.lastname..' \n[KICKOU]: TODOS!'..os.date('\n[DATA]: %d/%m/%Y [HORA]: %H:%M:%S')..' \r```')
            end
        end
    end
end)

---------------------------------------
-- WL
---------------------------------------
RegisterCommand('wl', function(source, args)
    local source = source
    local user_id = zero.getUserId(source)
    local identity = zero.getUserIdentity(user_id)
    if (user_id) and zero.hasPermission(user_id, 'staff.permissao') and args[1] then
        local nUser = parseInt(args[1])
        if (nUser) then
            exports['zero']:setWhitelisted(nUser, true)
            TriggerClientEvent('notify', source, 'Whitelist', 'Você aprovou o passaporte <b>'..nUser..'</b> na whitelist.')
            zero.webhook('Whitelist', '```prolog\n[/WL]\n[STAFF]: #'..user_id..' '..identity.firstname..' '..identity.lastname..' \n[APROVOU WL]: '..args[1]..os.date('\n[DATA]: %d/%m/%Y [HORA]: %H:%M:%S')..' \r```')
        end
    end
end)

RegisterCommand('unwl', function(source, args)
    local source = source
    local user_id = zero.getUserId(source)
    local identity = zero.getUserIdentity(user_id)
    if (user_id) and zero.hasPermission(user_id, 'staff.permissao') and args[1] then
        local nUser = parseInt(args[1])
        if (nUser) then
            exports['zero']:setWhitelisted(nUser, false)
            TriggerClientEvent('notify', source, 'Whitelist', 'Você retirou o passaporte <b>'..nUser..'</b> da whitelist.')
            zero.webhook('Whitelist', '```prolog\n[/UNWL]\n[STAFF]: #'..user_id..' '..identity.firstname..' '..identity.lastname..' \n[RETIROU WL]: '..args[1]..os.date('\n[DATA]: %d/%m/%Y [HORA]: %H:%M:%S')..' \r```')
        end
    end
end)

---------------------------------------
-- BANIMENTO
---------------------------------------
RegisterCommand('ban', function(source, args)
    local source = source
    local user_id = zero.getUserId(source)
    local identity = zero.getUserIdentity(user_id)
    if (user_id) and zero.hasPermission(user_id, 'staff.permissao') and args[1] then
        local nUser = parseInt(args[1])
        if (zero.isBanned(nUser)) then TriggerClientEvent('notify', source, 'Desbanimento', 'Este <b>jogador</b> já está banido seu noia!') return; end;
        local prompt = zero.prompt(source, { 'Motivo' })
        if (prompt) then
            prompt = prompt[1]

            local nPlayer = zero.getUserSource(nUser)
            if (nPlayer) then
                DropPlayer(nPlayer, 'Você foi banido da nossa cidade.\nSeu passaporte: #'..nUser..'\n Motivo: '..prompt..'\nAutor: '..identity.firstname..' '..identity.lastname)
            end
            exports[GetCurrentResourceName()]:setBanned(nUser, true)
            exports[GetCurrentResourceName()]:insertBanRecord(nUser, true, user_id, '[BAN] '..prompt..'!')
            TriggerClientEvent('notify', source, 'Banimento', 'Você baniu o passaporte <b>'..nUser..'</b> da cidade.')
            zero.webhook('Ban', '```prolog\n[/BAN]\n[STAFF]: #'..user_id..' '..identity.firstname..' '..identity.lastname..' \n[BANIU]: '..nUser..'\n[MOTIVO]: '..prompt..os.date('\n[DATA]: %d/%m/%Y [HORA]: %H:%M:%S')..' \r```')
        end
    end
end)

RegisterCommand('unban', function(source, args)
    local source = source
    local user_id = zero.getUserId(source)
    local identity = zero.getUserIdentity(user_id)
    if (user_id) and zero.hasPermission(user_id, '+Staff.Manager') and args[1] then
        local nUser = parseInt(args[1])
        if (nUser > 0) then
            if (not zero.isBanned(nUser)) then TriggerClientEvent('notify', source, 'Desbanimento', 'Este <b>jogador</b> não está banido seu noia!') return; end;

            local prompt = zero.prompt(source, { 'Motivo' })
            if (prompt) then
                prompt = prompt[1]
                
                exports[GetCurrentResourceName()]:setBanned(nUser, false)
                exports.zero_core:insertBanRecord(nUser, false, user_id, '[UNBAN] desbanido!')
                TriggerClientEvent('notify', source, 'Desbanimento', 'Você desbaniu o passaporte <b>'..nUser..'</b> da cidade.')
                zero.webhook('Ban', '```prolog\n[/UNBAN]\n[STAFF]: #'..user_id..' '..identity.firstname..' '..identity.lastname..' \n[DESBANIU]: '..nUser..'\n[MOTIVO]: '..prompt..os.date('\n[DATA]: %d/%m/%Y [HORA]: %H:%M:%S')..' \r```')
            end
        end
    end
end)

---------------------------------------
-- MONEY
---------------------------------------
RegisterCommand('money', function(source, args)
	local source = source
    local user_id = zero.getUserId(source)
    local identity = zero.getUserIdentity(user_id)
    if (user_id) and zero.hasPermission(user_id, '+Staff.COO') then
        if (not user_id == 1 and not user_id == 2 and not user_id == 3) then return; end;
        local amount = parseInt(args[1])
		if (amount) then
			zero.giveBankMoney(user_id, amount)
            exports.zero_bank:extrato(user_id, 'Prefeitura', amount)
            TriggerClientEvent('notify', source, 'Money', 'Você spawnou <b>R$'..zero.format(amount)..'</b>.')
			zero.webhook('Money', '```prolog\n[/MONEY]\n[STAFF]: #'..user_id..' '..identity.firstname..' '..identity.lastname..' \n[MONEY]: R$'..zero.format(amount)..os.date('\n[DATA]: %d/%m/%Y [HORA]: %H:%M:%S')..' \r```')
		end
	end
end)

RegisterCommand('money2', function(source, args)
    if (#args > 0) then
        local nSource = zero.getUserSource(parseInt(args[1]))
        local nUser = zero.getUserId(nSource)
        local nIdentity = zero.getUserIdentity(nUser)
        local money = parseInt(args[2])
        if (source == 0) then
            if (nUser and money) then
                zero.giveBankMoney(nUser, money)
                exports.zero_bank:extrato(nUser, 'Prefeitura', money)
                print('^5[ZERO MONEY]^7 Voce setou ^2R$'..zero.format(money)..'^7 para o passaporte ^2'..nUser..'^7.')
                TriggerClientEvent('notify', nSource, 'Money', 'Você recebeu <b>R$'..zero.format(money)..'</b> da <b>Prefeitura</b>.', 10000)
                zero.webhook('Money', '```prolog\n[/MONEY2]\n[STAFF]: CONSOLE\n[JOGADOR]: #'..nUser..' '..nIdentity.firstname..' '..nIdentity.lastname..'\n[RECEBEU]: R$'..zero.format(money)..' '..os.date('\n[DATA]: %d/%m/%Y [HORA]: %H:%M:%S')..' \r```')
            end
        else
            local user_id = zero.getUserId(source)
            local identity = zero.getUserIdentity(user_id)
            if (user_id) and zero.hasPermission(user_id, '+Staff.COO') then
                if (not user_id == 1 and not user_id == 2 and not user_id == 3) then return; end;
                if (nUser and money) then
                    zero.giveBankMoney(nUser, money)
                    exports.zero_bank:extrato(nUser, 'Prefeitura', money)
                    TriggerClientEvent('notify', source, 'Money', 'Você spawnou <b>R$'..zero.format(money)..'</b>, para o jogador <b>#'..nUser..' '..nIdentity.firstname..' '..nIdentity.lastname..'</b>.')
                    TriggerClientEvent('notify', nSource, 'Money', 'Você recebeu <b>R$'..zero.format(money)..'</b> da <b>Prefeitura</b>.', 10000)
                    zero.webhook('Money', '```prolog\n[/MONEY2]\n[STAFF]: #'..user_id..' '..identity.firstname..' '..identity.lastname..' \n[JOGADOR]: #'..nUser..' | '..nIdentity.firstname..' '..nIdentity.lastname..'\n[RECEBEU]: R$'..zero.format(money)..' '..os.date('\n[DATA]: %d/%m/%Y [HORA]: %H:%M:%S')..' \r```')
                end
            end
        end
    end
end)

RegisterCommand('moneyall', function(source, args)
    local source = source
    local user_id = zero.getUserId(source)
    local identity = zero.getUserIdentity(user_id)
    if (user_id) and zero.hasPermission(user_id, '+Staff.COO') then
        if (not user_id == 1 and not user_id == 2 and not user_id == 3) then return; end;
        local amount = parseInt(args[1])
		if (amount) then
            local players = zero.getUsers()
            for k, v in pairs(players) do
                local nSource = zero.getUserSource(parseInt(k))
                local nUser = zero.getUserId(nSource)
                if (nSource) then
                    zero.giveBankMoney(nUser, amount)
                    exports.zero_bank:extrato(nUser, 'Prefeitura', amount)
                    TriggerClientEvent('notify', nSource, 'Money', 'Você recebeu <b>R$'..zero.format(amount)..'</b> da <b>Prefeitura</b>.', 10000)
                end
            end
			zero.webhook('Money', '```prolog\n[/MONEYALL]\n[STAFF]: #'..user_id..' '..identity.firstname..' '..identity.lastname..' \n[MONEY]: R$'..zero.format(amount)..os.date('\n[DATA]: %d/%m/%Y [HORA]: %H:%M:%S')..' \r```')
		end
	end
end)

RegisterCommand('delmoney', function(source, args)
    if (#args > 0) then
        local nSource = zero.getUserSource(parseInt(args[1]))
        if (nSource) then
            local nUser = zero.getUserId(nSource)
            local nIdentity = zero.getUserIdentity(nUser)
            local money = parseInt(args[2])
            if (source == 0) then
                if (nUser and money) then
                    if (zero.tryFullPayment(nUser, money)) then
                        exports.zero_bank:extrato(nUser, 'Prefeitura', -money)
                        print('^5[ZERO MONEY]^7 Voce tirou ^2R$'..zero.format(money)..'^7 do passaporte ^2'..nUser..'^7.')
                        TriggerClientEvent('notify', nSource, 'Money', 'Você perdeu <b>R$'..zero.format(money)..'</b> pra <b>Prefeitura</b>.', 10000)
                        zero.webhook('Money', '```prolog\n[/DELMONEY]\n[STAFF]: CONSOLE\n[JOGADOR]: #'..nUser..' '..nIdentity.firstname..' '..nIdentity.lastname..'\n[PERDEU]: R$'..zero.format(money)..' '..os.date('\n[DATA]: %d/%m/%Y [HORA]: %H:%M:%S')..' \r```')
                    else
                        print('^5[ZERO MONEY]^7 este jogador não possui esta quantia de dinheiro.')
                    end
                end
            else
                local user_id = zero.getUserId(source)
                local identity = zero.getUserIdentity(user_id)
                if (user_id) and zero.hasPermission(user_id, '+Staff.COO') then
                    if (not user_id == 1 and not user_id == 2 and not user_id == 3) then return; end;
                    if (nUser and money) then
                        if (zero.tryFullPayment(nUser, money)) then
                            exports.zero_bank:extrato(nUser, 'Prefeitura', -money)
                            TriggerClientEvent('notify', source, 'Money', 'Você retirou <b>R$'..zero.format(money)..'</b>, do jogador <b>#'..nUser..' '..nIdentity.firstname..' '..nIdentity.lastname..'</b>.')
                            TriggerClientEvent('notify', nSource, 'Money', 'Você perdeu <b>R$'..zero.format(money)..'</b> pra <b>Prefeitura</b>.', 10000)
                            zero.webhook('Money', '```prolog\n[/DELMONEY]\n[STAFF]: #'..user_id..' '..identity.firstname..' '..identity.lastname..' \n[JOGADOR]: #'..nUser..' | '..nIdentity.firstname..' '..nIdentity.lastname..'\n[PERDEU]: R$'..zero.format(money)..' '..os.date('\n[DATA]: %d/%m/%Y [HORA]: %H:%M:%S')..' \r```')
                        else
                            TriggerClientEvent('notify', source, 'Money', 'Este <b>jogador</b> não possui esta quantia de dinheiro!')
                        end
                    end
                end
            end
        end
    end
end)

---------------------------------------
-- NOCLIP
---------------------------------------
RegisterCommand('nc', function(source)
	local _userId = zero.getUserId(source)
    if (_userId) and zero.hasPermission(_userId, 'staff.permissao') then
        local _identity = zero.getUserIdentity(_userId)
		zeroClient.toggleNoclip(source) 
        zero.webhook('NoClip', '```prolog\n[/NC]\n[STAFF]: #'.._userId..' '.._identity.firstname..' '.._identity.lastname..' \n[NOCLIP]: '..tostring(zeroClient.isNoclip(source))..'\n[COORD]: '..tostring(GetEntityCoords(GetPlayerPed(source)))..os.date('\n[DATA]: %d/%m/%Y [HORA]: %H:%M:%S')..' \r```')    
	end
end)

---------------------------------------
-- COORDS
---------------------------------------
RegisterCommand('vec', function(source)
    local source = source
    local user_id = zero.getUserId(source)
    if (user_id) and zero.hasPermission(user_id, 'staff.permissao') then
        TriggerClientEvent('clipboard', source, 'Vector3', tostring(GetEntityCoords(GetPlayerPed(source))))
    end
end)

RegisterCommand('vec2', function(source)
    local source = source
    local user_id = zero.getUserId(source)
    if (user_id) and zero.hasPermission(user_id, 'staff.permissao') then
        local pCoord = GetEntityCoords(GetPlayerPed(source))
        TriggerClientEvent('clipboard', source, 'Vector2', 'vector2('..pCoord.x..', '..pCoord.y..')')
    end
end)

RegisterCommand('h', function(source)
    local source = source
    local user_id = zero.getUserId(source)
    if (user_id) and zero.hasPermission(user_id, 'staff.permissao') then
        TriggerClientEvent('clipboard', source, 'Heading', tostring(GetEntityHeading(GetPlayerPed(source))))
    end
end)

---------------------------------------
-- USER
---------------------------------------
RegisterCommand('myid', function(source)
    local source = source
    local user_id = zero.getUserId(source)
    if (user_id) then
        TriggerClientEvent('clipboard', source, 'Seu ID', user_id)
    end
end)

RegisterCommand('mysource', function(source)
    local source = source
    if (source) then
        TriggerClientEvent('clipboard', source, 'Sua Source', source)
    end
end)

---------------------------------------
-- PON
---------------------------------------
RegisterCommand('pon', function(source)
    local source = source
    local user_id = zero.getUserId(source)
	if (user_id) and zero.hasPermission(user_id, 'staff.permissao') then
        local players = ''
        local quantidade = 0
        local users = zero.getUsers()
        for k, v in pairs(users) do
            players = players..k..', '
            quantidade = (quantidade + 1)
        end
        TriggerClientEvent('chatMessage', source, 'TOTAL ONLINE', { 0, 153, 255 }, quantidade)
        TriggerClientEvent('chatMessage', source, "ID's ONLINE", { 0, 153, 255 }, players)
    end
end)

---------------------------------------
-- TPWAY
---------------------------------------
RegisterCommand('tpway', function(source)
	local _userId = zero.getUserId(source)
    if (_userId) and zero.hasPermission(_userId, 'staff.permissao') then
        local _identity = zero.getUserIdentity(_userId)
        vCLIENT.tpToWayFunction(source)
        zero.webhook('TpWay', '```prolog\n[/TPWAY]\n[STAFF]: #'.._userId..' '.._identity.firstname..' '.._identity.lastname..'\n[TELEPORTOU]: PARA WAYPOINT\n[COORD]: '..tostring(GetEntityCoords(GetPlayerPed(source)))..os.date('\n[DATA]: %d/%m/%Y [HORA]: %H:%M:%S')..' \r```')
    end
end)

---------------------------------------
-- TPCDS
---------------------------------------
RegisterCommand('tpcds', function(source)
    local _userId = zero.getUserId(source)
    if (_userId) and zero.hasPermission(_userId, 'staff.permissao') then
        local _identity = zero.getUserIdentity(_userId)
        local promptCoords = zero.prompt(source, { 'Coordenadas' })
        if (not promptCoords) then return; end;

        local coords = {}
        for coord in string.gmatch(sanitizeString(promptCoords[1], '0123456789,-.',true) ,'[^,]+') do
			table.insert(coords, (tonumber(coord) or 0))
		end

        SetEntityCoords(GetPlayerPed(source), (coords[1] or 0), (coords[2] or 0), (coords[3] or 0))
        zero.webhook('Teleport', '```prolog\n[/TPCDS]\n[STAFF]: #'.._userId..' '.._identity.firstname..' '.._identity.lastname..'\n[TELEPORTOU]: '..tostring(vector3((coords[1] or 0), (coords[2] or 0), (coords[3] or 0)))..os.date('\n[DATA]: %d/%m/%Y [HORA]: %H:%M:%S')..' \r```')
    end
end)

---------------------------------------
-- TPCDS
---------------------------------------
RegisterCommand('tpto', function(source, args)
    local source = source
    local user_id = zero.getUserId(source)
    local identity = zero.getUserIdentity(user_id)
    if (user_id) and zero.hasPermission(user_id, 'staff.permissao') then
        if (args[1]) then
            local nPlayer = zero.getUserSource(parseInt(args[1]))
            if (nPlayer) then
                local nUser = zero.getUserId(nPlayer)
                local nIdentity = zero.getUserIdentity(nUser)
                if (not nIdentity) then return; end;
                local nCoords = GetEntityCoords(GetPlayerPed(nPlayer))
                zero.webhook('TeleportTo', '```prolog\n[/TPTO]\n[STAFF]: #'..user_id..' '..identity.firstname..' '..identity.lastname..' \n[FOI ATÉ]: #'..nUser..' '..nIdentity.firstname..' '..nIdentity.lastname..'\n[COORDENADA]: '..tostring(nCoords)..os.date('\n[DATA]: %d/%m/%Y [HORA]: %H:%M:%S')..' \r```')    
                SetEntityCoords(source, nCoords)
            end
        end
    end
end)

---------------------------------------
-- TPTOME
---------------------------------------
RegisterCommand('tptome', function(source, args)
    local source = source
    local user_id = zero.getUserId(source)
    local identity = zero.getUserIdentity(user_id)
    if (user_id) and zero.hasPermission(user_id, 'staff.permissao') then
        if (args[1]) then
            local nPlayer = zero.getUserSource(parseInt(args[1]))
            if (nPlayer) then
                local nUser = zero.getUserId(nPlayer)
                local nIdentity = zero.getUserIdentity(nUser)
                local pCoords = GetEntityCoords(GetPlayerPed(source))
                zeroClient.teleport(nPlayer, pCoords.x, pCoords.y, pCoords.z)
                zero.webhook('TeleportTo', '```prolog\n[/TPTOME]\n[STAFF]: #'..user_id..' '..identity.firstname..' '..identity.lastname..' \n[PUXOU]: #'..nUser..' '..nIdentity.firstname..' '..nIdentity.lastname..'\n[COORDENADA]: '..tostring(pCoords)..os.date('\n[DATA]: %d/%m/%Y [HORA]: %H:%M:%S')..' \r```')    
            end
        end
    end
end)

---------------------------------------
-- ARMA
---------------------------------------
RegisterCommand('arma', function(source, args)
    local user_id = zero.getUserId(source)
    if (user_id) and zero.hasPermission(user_id, 'staff.permissao') then
        if (args[1]) then
            args[1] = string.upper(args[1])
            zeroClient.giveWeapons(source, { [args[1]] = { ammo = 250 } }, false, GlobalState.weaponToken)
        end
    end
end)

---------------------------------------
-- RMASCARA
---------------------------------------
RegisterCommand('rmascara', function(source)
	local user_id = zero.getUserId(source)
    local identity = zero.getUserIdentity(user_id)
	if (user_id) and zero.hasPermission(user_id, 'polpar.permissao') then
		local nplayer = zeroClient.getNearestPlayer(source, 2)
		if (nplayer) then
            local nUser = zero.getUserId(nplayer)
			local nIdentity = zero.getUserIdentity(nUser)
			TriggerClientEvent('zero_commands_police:clothes', nplayer, 'rmascara')
			zero.webhook('PoliceCommands', '```prolog\n[/RMASCARA]\n[USER_ID]: #'..user_id..' '..identity.firstname..' '..identity.lastname..'\n[RETIROU A MASCARA DO]\n[JOGADOR]: #'..nUser..' '..nIdentity.firstname..' '..nIdentity.lastname..' '..os.date('\n[DATA]: %d/%m/%Y [HORA]: %H:%M:%S')..' \r```')
        else
            TriggerClientEvent('notify', source, 'Remover Máscara', 'Você não se encontra próximo de um <b>cidadão</b>.')
        end
	end
end)

---------------------------------------
-- RMASCARA
---------------------------------------
RegisterCommand('rchapeu', function(source)
	local user_id = zero.getUserId(source)
    local identity = zero.getUserIdentity(user_id)
	if (user_id) and zero.hasPermission(user_id,'polpar.permissao') then
		local nplayer = zeroClient.getNearestPlayer(source,2)
		if (nplayer) then
            local nUser = zero.getUserId(nplayer)
			local nIdentity = zero.getUserIdentity(nUser)
            TriggerClientEvent('zero_commands_police:clothes', nplayer, 'rchapeu')
			zero.webhook('PoliceCommands', '```prolog\n[/RCHAPEU]\n[USER_ID]: #'..user_id..' '..identity.firstname..' '..identity.lastname..'\n[RETIROU O CHAPEU DO]\n[JOGADOR]: #'..nUser..' '..nIdentity.firstname..' '..nIdentity.lastname..' '..os.date('\n[DATA]: %d/%m/%Y [HORA]: %H:%M:%S')..' \r```')
        else
            TriggerClientEvent('notify', source, 'Remover Chápeu', 'Você não se encontra próximo de um <b>cidadão</b>.')
        end
	end
end)

---------------------------------------
-- CV
---------------------------------------
RegisterCommand('cv', function(source)
    local source = source
	local user_id = zero.getUserId(source)
    local identity = zero.getUserIdentity(user_id)
	if (zero.hasPermission(user_id, 'polpar.permissao')) then
        if (zeroClient.isInVehicle(source)) then
            TriggerClientEvent('notify', source, 'Colocar no veículo', 'Você não pode utilizar este comando de dentro de um <b>veículo</b>.')
            return
        end

		local nplayer = zeroClient.getNearestPlayer(source, 2.0)
		if (nplayer) then
			local nUser = zero.getUserId(nplayer)
			local nIdentity = zero.getUserIdentity(nUser)
            zeroClient.putInNearestVehicleAsPassenger(nplayer, 5)
			zero.webhook('PoliceCommands', '```prolog\n[/CV]\n[USER_ID]: #'..user_id..' '..identity.firstname..' '..identity.lastname..'\n[DEU CV NO]\n[JOGADOR]: #'..nUser..' '..nIdentity.firstname..' '..nIdentity.lastname..' '..os.date('\n[DATA]: %d/%m/%Y [HORA]: %H:%M:%S')..' \r```')
        else
            TriggerClientEvent('notify', source, 'Colocar Veículo', 'Você não se encontra próximo de um <b>cidadão</b>.')
        end
	end
end)

---------------------------------------
-- RV
---------------------------------------
RegisterCommand('rv', function(source)
    local source = source
	local user_id = zero.getUserId(source)
    local identity = zero.getUserIdentity(user_id)
	if (zero.hasPermission(user_id, 'polpar.permissao')) then
        if (zeroClient.isInVehicle(source)) then
            TriggerClientEvent('notify', source, 'Retirar do veículo', 'Você não pode utilizar este comando de dentro de um <b>veículo</b>.')
            return
        end

		local nplayer = zeroClient.getNearestPlayer(source, 2.0)
		if (nplayer) then
			local nUser = zero.getUserId(nplayer)
			local nIdentity = zero.getUserIdentity(nUser)
            zeroClient.ejectVehicle(nplayer)
			zero.webhook('PoliceCommands', '```prolog\n[/RV]\n[USER_ID]: #'..user_id..' '..identity.firstname..' '..identity.lastname..'\n[DEU RV NO]\n[JOGADOR]: #'..nUser..' '..nIdentity.firstname..' '..nIdentity.lastname..' '..os.date('\n[DATA]: %d/%m/%Y [HORA]: %H:%M:%S')..' \r```')
        else
            TriggerClientEvent('notify', source, 'Retirar Veículo', 'Você não se encontra próximo de um <b>cidadão</b>.')
        end
	end
end)

---------------------------------------
-- TOW
---------------------------------------
RegisterServerEvent('trytow', function(vehid01, vehid02, mod)
	TriggerClientEvent('synctow', -1, vehid01, vehid02, mod)
end)

---------------------------------------
-- CHATS
---------------------------------------
RegisterCommand('mec', function(source, args, raw)
    local source = source
	local user_id = zero.getUserId(source)
    local identity = zero.getUserIdentity(user_id)
	if (user_id) and zero.hasPermission(user_id, 'mecanico.permissao') then
        if (args[1]) then
            TriggerClientEvent('chatMessage', -1, '[ZERO MECÂNICA] '..identity.firstname..' '..identity.lastname, { 0, 153, 255 }, raw:sub(4))
            zero.webhook('ChatCore', '```prolog\n[CHATS ORG]\n[MEC]\n[JOGADOR]: #'..user_id..' '..identity.firstname..' '..identity.lastname..'\n[MENSAGEM]: '..raw:sub(4)..'\n[COORDENADA]: '..tostring(GetEntityCoords(GetPlayerPed(source)))..' '..os.date('\n[DATA]: %d/%m/%Y [HORA]: %H:%M:%S')..' \r```')
        end
	end
end)

RegisterCommand('mc', function(source, args, raw)
    local source = source
	local user_id = zero.getUserId(source)
    local identity = zero.getUserIdentity(user_id)
	if (user_id) and zero.hasPermission(user_id, 'mecanico.permissao') then
        if (args[1]) then
            local group = zero.getUsersByPermission('mecanico.permissao')
            for _, v in pairs(group) do
                local nSource = zero.getUserSource(parseInt(v))
                if (nSource) then
                    async(function()
                        TriggerClientEvent('chatMessage', -1, '[CENTRAL MEC] '..identity.firstname..' '..identity.lastname, { 0, 153, 255 }, raw:sub(4))
                        zero.webhook('ChatCore', '```prolog\n[CHATS ORG]\n[MEC CENTRAL]\n[JOGADOR]: '..user_id..' | '..identity.firstname..' '..identity.lastname..'\n[MENSAGEM]: '..raw:sub(4)..'\n[COORDENADA]: '..tostring(GetEntityCoords(GetPlayerPed(source)))..' '..os.date('\n[DATA]: %d/%m/%Y [HORA]: %H:%M:%S')..' \r```')
                    end)
                end
            end
        end
	end
end)

RegisterCommand('pre', function(source, args, raw)
    local source = source
	local user_id = zero.getUserId(source)
    local identity = zero.getUserIdentity(user_id)
	if (user_id) and zero.hasPermission(user_id, 'staff.permissao') then
        if (args[1]) then
            TriggerClientEvent('chatMessage', -1, '[ZERO PREFEITURA] '..identity.firstname..' '..identity.lastname, { 0, 153, 255 }, raw:sub(4))
            zero.webhook('ChatCore', '```prolog\n[CHATS ORG]\n[PREFEITURA]\n[JOGADOR]: #'..user_id..' '..identity.firstname..' '..identity.lastname..'\n[MENSAGEM]: '..raw:sub(4)..'\n[COORDENADA]: '..tostring(GetEntityCoords(GetPlayerPed(source)))..' '..os.date('\n[DATA]: %d/%m/%Y [HORA]: %H:%M:%S')..' \r```')
        end
	end
end)

RegisterCommand('pc', function(source, args, raw)
    local source = source
	local user_id = zero.getUserId(source)
    local identity = zero.getUserIdentity(user_id)
	if (user_id) and zero.hasPermission(user_id, 'staff.permissao') then
        if (args[1]) then
            local group = zero.getUsersByPermission('staff.permissao')
            for _, v in pairs(group) do
                local nSource = zero.getUserSource(parseInt(v))
                if (nSource) then
                    async(function()
                        TriggerClientEvent('chatMessage', nSource, '[CENTRAL PREFEITURA] '..identity.firstname..' '..identity.lastname, { 0, 153, 255 }, raw:sub(4))
                        zero.webhook('ChatCore', '```prolog\n[CHATS ORG]\n[PREFEITURA CENTRAL]\n[JOGADOR]: '..user_id..' | '..identity.firstname..' '..identity.lastname..'\n[MENSAGEM]: '..raw:sub(4)..'\n[COORDENADA]: '..tostring(GetEntityCoords(GetPlayerPed(source)))..' '..os.date('\n[DATA]: %d/%m/%Y [HORA]: %H:%M:%S')..' \r```')
                    end)
                end
            end
        end
	end
end)

RegisterCommand('190', function(source, args, raw)
    local source = source
	local user_id = zero.getUserId(source)
    local identity = zero.getUserIdentity(user_id)
	if (user_id) and zero.hasPermission(user_id, 'policia.permissao') then
        if (args[1]) then
            TriggerClientEvent('chatMessage', -1, '[ZERO POLÍCIA] '..identity.firstname..' '..identity.lastname, { 0, 153, 255 }, raw:sub(4))
            zero.webhook('ChatCore', '```prolog\n[CHATS ORG]\n[190]\n[JOGADOR]: #'..user_id..' '..identity.firstname..' '..identity.lastname..'\n[MENSAGEM]: '..raw:sub(4)..'\n[COORDENADA]: '..tostring(GetEntityCoords(GetPlayerPed(source)))..' '..os.date('\n[DATA]: %d/%m/%Y [HORA]: %H:%M:%S')..' \r```')
        end
	end
end)

RegisterCommand('pd', function(source, args, raw)
    local source = source
	local user_id = zero.getUserId(source)
    local identity = zero.getUserIdentity(user_id)
	if (user_id) and zero.hasPermission(user_id, 'policia.permissao') then
        if (args[1]) then
            local group = zero.getUsersByPermission('policia.permissao')
            for _, v in pairs(group) do
                local nSource = zero.getUserSource(parseInt(v))
                if (nSource) then
                    async(function()
                        TriggerClientEvent('chatMessage', nSource, '[CENTRAL POLÍCIA] '..identity.firstname..' '..identity.lastname, { 0, 153, 255 }, raw:sub(4))
                        zero.webhook('ChatCore', '```prolog\n[CHATS ORG]\n[POLÍCIA CENTRAL]\n[JOGADOR]: '..user_id..' | '..identity.firstname..' '..identity.lastname..'\n[MENSAGEM]: '..raw:sub(4)..'\n[COORDENADA]: '..tostring(GetEntityCoords(GetPlayerPed(source)))..' '..os.date('\n[DATA]: %d/%m/%Y [HORA]: %H:%M:%S')..' \r```')
                    end)
                end
            end
        end
	end
end)

RegisterCommand('192', function(source, args, raw)
    local source = source
	local user_id = zero.getUserId(source)
    local identity = zero.getUserIdentity(user_id)
	if (user_id) and zero.hasPermission(user_id, 'hospital.permissao') then
        if (args[1]) then
            TriggerClientEvent('chatMessage', -1, '[ZERO HOSPITAL] '..identity.firstname..' '..identity.lastname, { 0, 153, 255 }, raw:sub(4))
            zero.webhook('ChatCore', '```prolog\n[CHATS ORG]\n[192]\n[JOGADOR]: #'..user_id..' '..identity.firstname..' '..identity.lastname..'\n[MENSAGEM]: '..raw:sub(4)..'\n[COORDENADA]: '..tostring(GetEntityCoords(GetPlayerPed(source)))..' '..os.date('\n[DATA]: %d/%m/%Y [HORA]: %H:%M:%S')..' \r```')
        end
	end
end)

RegisterCommand('hp', function(source, args, raw)
    local source = source
	local user_id = zero.getUserId(source)
    local identity = zero.getUserIdentity(user_id)
	if (user_id) and zero.hasPermission(user_id, 'hospital.permissao') then
        if (args[1]) then
            local group = zero.getUsersByPermission('hospital.permissao')
            for _, v in pairs(group) do
                local nSource = zero.getUserSource(parseInt(v))
                if (nSource) then
                    async(function()
                        TriggerClientEvent('chatMessage', -1, '[CENTRAL HOSPITAL] '..identity.firstname..' '..identity.lastname, { 0, 153, 255 }, raw:sub(4))
                        zero.webhook('ChatCore', '```prolog\n[CHATS ORG]\n[HOSPITAL CENTRAL]\n[JOGADOR]: '..user_id..' | '..identity.firstname..' '..identity.lastname..'\n[MENSAGEM]: '..raw:sub(4)..'\n[COORDENADA]: '..tostring(GetEntityCoords(GetPlayerPed(source)))..' '..os.date('\n[DATA]: %d/%m/%Y [HORA]: %H:%M:%S')..' \r```')
                    end)
                end
            end
        end
	end
end)

---------------------------------------
-- ENVIAR
---------------------------------------
RegisterCommand('enviar', function(source, args)
    local source = source
    local user_id = zero.getUserId(source)
    local identity = zero.getUserIdentity(user_id)
    if (user_id) then
        local nPlayer = zeroClient.getNearestPlayer(source, 2.0)
        local nUser = zero.getUserId(nPlayer)
        local nIdentity = zero.getUserIdentity(nUser)
        if (nPlayer) then
            local amount = parseInt(args[1])
            if (amount > 0) then
                if (zero.tryPayment(user_id, amount)) then
                    zero.giveMoney(nUser, amount)
                    exports.zero_bank:extrato(user_id, 'Transferência', -amount)
                    exports.zero_bank:extrato(nUser, 'Transferência', amount)
                    zeroClient._playAnim(source, true, {{ 'mp_common', 'givetake1_a' }}, false)
			        zeroClient._playAnim(nPlayer, true, {{ 'mp_common', 'givetake1_a' }}, false)
                    TriggerClientEvent('notify', source, 'Enviar', 'Você enviou <b>R$'..zero.format(amount)..'</b>.')
                    TriggerClientEvent('notify', nPlayer, 'Enviar', 'Você recebeu <b>R$'..zero.format(amount)..'</b>.')
                    zero.webhook('Enviar', '```prolog\n[/ENVIAR]\n[ID]: #'..user_id..' '..identity.firstname..' '..identity.lastname..' \n[ENVIOU]: R$'..zero.format(amount)..' \n[PARA O ID]: #'..nUser..' '..nIdentity.firstname..' '..nIdentity.lastname..os.date('\n[DATA]: %d/%m/%Y [HORA]: %H:%M:%S')..' \r```')
                else
                    TriggerClientEvent('notify', source, 'Enviar', 'Você não possui essa quantia de <b>dinheiro</b> em mãos.')
                end
            end
        else
            TriggerClientEvent('notify', source, 'Enviar', 'Você não se encontra próximo de um <b>cidadão</b>.')
        end
    end
end)

---------------------------------------
-- ANÚNCIOS
---------------------------------------
RegisterCommand('adm', function(source)
    local source = source
    local user_id = zero.getUserId(source)
    local identity =  zero.getUserIdentity(user_id)
    if (user_id) and zero.hasPermission(user_id, 'staff.permissao') then
        local message = zero.prompt(source, { 'Mensagem' })
        if (message) then
            message = message[1]

            TriggerClientEvent('announcement', -1, 'Prefeitura', message, identity.firstname, true, 30000)
            zero.webhook('Anuncios', '```prolog\n[/ADM]\n[USER_ID]: #'..user_id..' '..identity.firstname..' '..identity.lastname..'\n[MENSAGEM]: '..message..' \n[COORDENADA]: '..tostring(GetEntityCoords(GetPlayerPed(source)))..' '..os.date('\n[DATA]: %d/%m/%Y [HORA]: %H:%M:%S')..' \r```')
        end
    end
end)

RegisterCommand('anuncio', function(source)
    local source = source
    local user_id = zero.getUserId(source)
    local identity =  zero.getUserIdentity(user_id)
    if (user_id) and zero.hasPermission(user_id, 'polpar.permissao') or zero.hasPermission(user_id, 'mecanico.permissao') then
        local message = zero.prompt(source, { 'Título', 'Mensagem' })
        if (message) then
            TriggerClientEvent('announcement', -1, message[1], message[2], identity.firstname, true, 30000)
            zero.webhook('Anuncios', '```prolog\n[/ANUNCIO]\n[USER_ID]: #'..user_id..' '..identity.firstname..' '..identity.lastname..'\n[TÍTULO]: '..message[1]..'\n[MENSAGEM]: '..message[2]..' \n[COORDENADA]: '..tostring(GetEntityCoords(GetPlayerPed(source)))..' '..os.date('\n[DATA]: %d/%m/%Y [HORA]: %H:%M:%S')..' \r```')
        end
    end
end)

---------------------------------------
-- CAR COLOR
---------------------------------------
RegisterCommand('carcolor', function(source, args)
    local source = source
    local user_id = zero.getUserId(source)
    local identity = zero.getUserIdentity(user_id)
    if (user_id) and zero.hasPermission(user_id, '+Staff.Administrador') then
        local vehicle = zeroClient.getNearestVehicle(source, 7.0)
        if (vehicle) then
            local prompt = zero.prompt(source, { 'Primary Color RGB (255, 255, 255)', 'Secondary Color RGB (255, 255, 255)' })
            if (prompt) then
                local primary = prompt[1]
                if (primary) then
                    local rgb = sanitizeString(primary, '0123456789,', true)
                    local r, g, b = table.unpack(splitString(rgb, ','))
                    TriggerClientEvent('zero_core:carcolor', source, vehicle, parseInt(r), parseInt(g), parseInt(b), true)   
                    TriggerClientEvent('notify', source, 'Car Color','A cor primária do <b>veículo</b> foi alterada.')
                end

                local secondary = prompt[2]
                if (secondary) then
                    local rgb = sanitizeString(secondary, '0123456789,', true)
                    local r, g, b = table.unpack(splitString(rgb, ','))
                    TriggerClientEvent('zero_core:carcolor', source, vehicle, parseInt(r), parseInt(g), parseInt(b), false)   
                    TriggerClientEvent('notify', source, 'Car Color','A cor secundária do <b>veículo</b> foi alterada.')
                end

                local text, text2 = (primary and primary or '(NONE)'), (secondary and secondary or '(NONE)')
                zero.webhook('CarColor', '```prolog\n[/CARCOLOR]\n[STAFF]: #'..user_id..' '..identity.firstname..' '..identity.lastname..'\n[RGB PRIMARY]: '..text..'\n[RGB SECONDARY]: '..text2..' \n[COORDS]: '..tostring(GetEntityCoords(GetPlayerPed(source)))..'\n'..os.date('[DATA]: %d/%m/%Y [HORA]: %H:%M:%S')..' \r```')
            end
        end
    end
end)

---------------------------------------
-- UNCUFF
---------------------------------------
RegisterCommand('uncuff', function(source, args)
    local source = source
    local user_id = zero.getUserId(source)
    if (user_id) and zero.hasPermission(user_id, '+Staff.Administrador') then
        if (args[1]) then
            local nSource = zero.getUserSource(parseInt(args[1]))
            if (zeroClient.isHandcuffed(nSource)) then
                Player(nSource).state.Handcuff = false
                zeroClient.setHandcuffed(nSource, false)
                TriggerClientEvent('zero_core:uncuff', nSource)
            else
                TriggerClientEvent('notify', source, 'Uncuff', 'O jogador não se encontra <b>algemado</b>.')
            end
        else
            if (zeroClient.isHandcuffed(source)) then
                Player(source).state.Handcuff = false
                zeroClient.setHandcuffed(source, false)
                TriggerClientEvent('zero_core:uncuff', source)
            else
                TriggerClientEvent('notify', source, 'Uncuff', 'Você não se encontra <b>algemado</b>.')
            end
        end

        local text = (not args[1] and user_id or args[1])
        zero.webhook('Uncuff', '```prolog\n[/UNCUFF]\n[USER]: '..user_id..'\n[TARGET]: '..text..' \n[COORDS]: '..tostring(GetEntityCoords(GetPlayerPed(source)))..'\n'..os.date('[DATA]: %d/%m/%Y [HORA]: %H:%M:%S')..' \r```')
    end
end)

---------------------------------------
-- RCAPUZ
---------------------------------------
RegisterCommand('rcapuz', function(source, args)
    local source = source
    local user_id = zero.getUserId(source)
    if (user_id) and zero.hasPermission(user_id, '+Staff.Administrador') then
        if (args[1]) then
            local nSource = zero.getUserSource(parseInt(args[1]))
            if (zeroClient.isCapuz(nSource)) then
                Player(nPlayer).state.Capuz = false
                zeroClient.setCapuz(nSource, false)
            else
                TriggerClientEvent('notify', source, 'Remover capuz', 'O jogador não se encontra <b>encapuzado</b>.')
            end
        else
            if (zeroClient.isCapuz(source)) then
                Player(source).state.Capuz = false
                zeroClient.setCapuz(source, false)
            else
                TriggerClientEvent('notify', source, 'Remover capuz', 'Você não se encontra <b>encapuzado</b>.')
            end
        end

        local text = (not args[1] and user_id or args[1])
        zero.webhook('Uncuff', '```prolog\n[/UNCUFF]\n[USER]: '..user_id..'\n[TARGET]: '..text..' \n[COORDS]: '..tostring(GetEntityCoords(GetPlayerPed(source)))..'\n'..os.date('[DATA]: %d/%m/%Y [HORA]: %H:%M:%S')..' \r```')
    end
end)

---------------------------------------
-- LIMPARAREA
---------------------------------------
RegisterCommand('limpararea', function(source)
    local source = source
    local user_id = zero.getUserId(source)
    local identity = zero.getUserIdentity(user_id)
    if (user_id) and zero.hasPermission(user_id, 'staff.permissao') then
        local pCoord = GetEntityCoords(GetPlayerPed(source))
        TriggerClientEvent('syncarea', -1, pCoord.x, pCoord.y, pCoord.z)
        zero.webhook('LimparArea', '```prolog\n[/LIMPARAREA]\n[STAFF]: #'..user_id..' '..identity.firstname..' '..identity.lastname..'\n[COORDS]: '..tostring(pCoord)..'\n'..os.date('[DATA]: %d/%m/%Y [HORA]: %H:%M:%S')..' \r```')
    end
end)

---------------------------------------
-- SKIN
---------------------------------------
RegisterCommand('skin', function(source, args)
    local source = source
    local user_id = zero.getUserId(source)
    local identity = zero.getUserIdentity(user_id)
    if (user_id) and zero.hasPermission(user_id, '+Staff.COO') then
        local text = ''
        local nPlayer = zero.getUserSource(parseInt(args[1]))
        if (args[2]) and nPlayer then  
            local nUser = zero.getUserId(nPlayer)
            local nIdentity = zero.getUserIdentity(nUser)
            vCLIENT.skinModel(nPlayer, args[2])
            TriggerClientEvent('notify', source, 'Skin', 'Você setou a skin <b>'..args[2]..'</b> no passaporte <b>'..nUser..'</b>.')
            text = '#'..nUser..' '..nIdentity.firstname..' '..nIdentity.lastname..'\n[SKIN]: '..args[2]
        else
            vCLIENT.skinModel(source, args[1])
            TriggerClientEvent('notify', source, 'Skin', 'Você setou a skin <b>'..args[1]..'</b> em si mesmo.')
            text = '#'..user_id..' '..identity.firstname..' '..identity.lastname..'\n[SKIN]: '..args[1]
        end
        zero.webhook('Skin', '```prolog\n[/SKIN]\n[STAFF]: #'..user_id..' '..identity.firstname..' '..identity.lastname..'\n[JOGADOR]: '..text..os.date('\n[DATA]: %d/%m/%Y [HORA]: %H:%M:%S')..' \r```')
    end
end)

---------------------------------------
-- TRY DELETE OBJ
---------------------------------------
RegisterNetEvent('trydeleteobj', function(index)
    local entity = NetworkGetEntityFromNetworkId(index)
    if (entity and entity ~= 0) then DeleteEntity(entity) end
end)

---------------------------------------
-- DEL NPCS
---------------------------------------
RegisterCommand('delnpcs',function(source)
    local source = source
	local user_id = zero.getUserId(source)
    local identity = zero.getUserIdentity(user_id)
	if (user_id) and zero.hasPermission(user_id, '+Staff.Administrador') then
		TriggerClientEvent('zero_core:delnpcs', source)
        zero.webhook('DeleteNpc', '```prolog\n[/DELNPCS]\n[STAFF]: #'..user_id..' '..identity.firstname..' '..identity.lastname..os.date('\n[DATA]: %d/%m/%Y [HORA]: %H:%M:%S')..' \r```')
	end
end)

RegisterNetEvent('trydeleteped', function(index)
	TriggerClientEvent('syncdeleteped', -1, index)
end)

---------------------------------------
-- TUNING
---------------------------------------
RegisterCommand('tuning', function(source)
    local source = source
    local user_id = zero.getUserId(source)
    local identity = zero.getUserIdentity(user_id)
    if (user_id) and zero.hasPermission(user_id, '+Staff.COO') then
        TriggerClientEvent('zero_core:tuning', source)
        zero.webhook('Tuning', '```prolog\n[/TUNING]\n[STAFF]: #'..user_id..' '..identity.firstname..' '..identity.lastname..os.date('\n[DATA]: %d/%m/%Y [HORA]: %H:%M:%S')..' \r```')
    end
end)

---------------------------------------
-- DEBUG
---------------------------------------
RegisterCommand('debug', function(source)
    local source = source
    local user_id = zero.getUserId(source)
    if (user_id) and zero.hasPermission(user_id, 'staff.permissao') then
        TriggerClientEvent('zero_core:debug', source)
    end
end)

---------------------------------------
-- CLEAR WEAPONS
---------------------------------------
RegisterCommand('clearweapons', function(source, args)
    local source = source
    local user_id = zero.getUserId(source)
    local identity = zero.getUserIdentity(user_id)
    if (user_id) and zero.hasPermission(user_id, '+Staff.Administrador') then
        local text = ''
        if (args[1]) then
            local nSource = zero.getUserSource(parseInt(args[1]))
            if (nSource) then
                local nUser = zero.getUserId(nSource)
                local nIdentity = zero.getUserIdentity(nUser)
                zeroClient.giveWeapons(nSource, {}, true, GlobalState.weaponToken)
                TriggerClientEvent('notify', source, 'Clear Weapon', 'Você limpou os <b>armamentos</b> do passaporte <b>'..nUser..'</b>.')
                text = '#'..nUser..' '..nIdentity.firstname..' '..nIdentity.lastname
            end
        else
            zeroClient.giveWeapons(source, {}, true, GlobalState.weaponToken)
            TriggerClientEvent('notify', source, 'Clear Weapon', 'Você limpou os seus <b>armamentos</b>')
            text = '#'..user_id..' '..identity.firstname..' '..identity.lastname
        end
        zero.webhook('ClearWeapons', '```prolog\n[/CLEARWEAPONS]\n[STAFF]: #'..user_id..' '..identity.firstname..' '..identity.lastname..'\n[LIMPOU AS ARMAS DO]: '..text..os.date('\n[DATA]: %d/%m/%Y [HORA]: %H:%M:%S')..' \r```')
    end
end)

---------------------------------------
-- VROUPAS
---------------------------------------
RegisterCommand('vroupas',function(source)
    local source = source
    local user_id = zero.getUserId(source)
    if (user_id) and zero.hasPermission(user_id, 'staff.permissao') then
        local custom = zeroClient.getCustomization(source)
        local content = {}
        for k, v in pairs(custom) do
            if (v ~= GetEntityModel(GetPlayerPed(source))) then
                if (string.sub(k, 1, 1) == 'p') then
                    k = "['"..k.."']"
                else
                    k = '['..k..']'
                end
                table.insert(content, k..' = { model = '..v.model..', var = '..v.var..', palette = '..v.palette..' },') 
            end
        end
        content = table.concat(content, '\n ')
        TriggerClientEvent('clipboard', source, 'Código da roupa', content)
    end
end)

---------------------------------------
-- UMSG
---------------------------------------
RegisterCommand('umsg', function(source, args)
    local source = source
    local user_id = zero.getUserId(source)
    local identity = zero.getUserIdentity(user_id)
    if (user_id) and zero.hasPermission(user_id, 'staff.permissao') then
        if (args[1]) then
            local message = zero.prompt(source, { 'Mensagem' })
            if (message) then
                message = message[1]

                local nPlayer = zero.getUserSource(parseInt(args[1]))
                if (nPlayer) then
                    local nUser = zero.getUserId(nPlayer)
                    local nIdentity = zero.getUserIdentity(nUser)
                    TriggerClientEvent('notify', nPlayer, 'Mensagem Privada', 'O staff <b>'..identity.firstname..' '..identity.lastname..'</b> te enviou uma mensagem: <br /><br />'..message, 10000)
                    TriggerClientEvent('notify', source, 'Mensagem Privada', 'A mensagem foi enviada com <b>sucesso</b>.')
                    zeroClient.playSound(source, 'Event_Message_Purple', 'GTAO_FM_Events_Soundset')
					zeroClient.playSound(nPlayer, 'Event_Message_Purple', 'GTAO_FM_Events_Soundset')
					Citizen.Wait(100)
					zeroClient.playSound(nPlayer, 'Event_Message_Purple', 'GTAO_FM_Events_Soundset')
					Citizen.Wait(100)
					zeroClient.playSound(nPlayer, 'Event_Message_Purple', 'GTAO_FM_Events_Soundset')
                    zero.webhook('Umsg', '```prolog\n[/UMSG]\n[STAFF]: #'..user_id..' '..identity.firstname..' '..identity.lastname..' \n[FALOU COM]: #'..nUser..' '..nIdentity.firstname..' '..nIdentity.lastname..' \n[MENSAGEM]: '..message..os.date('\n[DATA]: %d/%m/%Y - [HORA]: %H:%M:%S')..' \r```')
                end
            end
        end
    end
end)

---------------------------------------
-- BANSRC
---------------------------------------
RegisterCommand('bansrc', function(source, args)
    local source = source
    local user_id = zero.getUserId(source)
    local identity = zero.getUserIdentity(user_id)
    if (user_id) and zero.hasPermission(user_id, 'staff.permissao') then
        if (args[1]) then
            local nSource = parseInt(args[1])
            if (nSource) then
                if (GetPlayerName(nSource)) then
                    local nUser = zero.getUserIdByIdentifiers(GetPlayerIdentifiers(nSource))
                    if (nUser ~= -1) then
                        local prompt = zero.prompt(source, { 'Motivo' })

                        if (prompt) then
                            prompt[1] = prompt[1]
                            
                            exports[GetCurrentResourceName()]:setBanned(nUser, true)
                            exports.zero_core:insertBanRecord(nUser, true, user_id, '[BANSRC] source banida!')
                            DropPlayer(nSource, 'Você foi banido da nossa cidade.\nSeu passaporte: #'..nUser..'\n Motivo: '..prompt[1]..'\nAutor: '..identity.firstname..' '..identity.lastname)
                            TriggerClientEvent('notify', source, 'Banimento', 'Você baniu a source <b>'..nSource..'</b> da cidade.')
                            zero.webhook('BanSource', '```prolog\n[/BANSRC]\n[STAFF]: #'..user_id..' '..identity.firstname..' '..identity.lastname..'\n[BANIU SOURCE]: '..nSource..' \n[ID RELACIONADO]: '..nUser..'\n[MOTIVO]: '..prompt[1]..os.date('\n[DATA]: %d/%m/%Y [HORA]: %H:%M:%S')..' \r```')
                        end
                    end
                end
            end
        end
    end
end)

---------------------------------------
-- TPTO SRC
---------------------------------------
RegisterCommand('tptosrc', function(source, args)
    local source = source
    local user_id = zero.getUserId(source)
    local identity = zero.getUserIdentity(user_id)
    if (user_id) and zero.hasPermission(user_id, 'staff.permissao') then
        if (args[1]) then
            SetEntityCoords(source, GetEntityCoords(GetPlayerPed(parseInt(args[1]))))
        end
    end
end)

---------------------------------------
-- CHECK BUGADO
---------------------------------------
RegisterCommand('checkbugados', function(source)
    local source = source
    local user_id = zero.getUserId(source)
    local identity = zero.getUserIdentity(user_id)
    if (user_id) and zero.hasPermission(user_id, 'staff.permissao') then
        local message = ''
        for _, v in ipairs(GetPlayers()) do 
            local pName = GetPlayerName(v)
            local uId = zero.getUserId(tonumber(v))
            if (not uId) then 
                message = message .. string.format('</br> <b>%s</b> | Source: <b>%s</b> | Ready: %s',pName,v,((Player(v).state.ready) and 'Sim' or 'Não'))
            end
        end
        TriggerClientEvent('notify', source, 'Check Bugados', ((message ~= '') and message or 'Sem usuários bugados no momento!'))
    end
end)

---------------------------------------
-- SCREENSHOT SOURCE
---------------------------------------
RegisterCommand('screensrc', function(source, args)
    local source = source
    local user_id = zero.getUserId(source)
    if (user_id) and zero.hasPermission(user_id, 'staff.permissao') then
        local nSource = parseInt(args[1])
        if (nSource > 0) then
            local ids = zero.getIdentifiers(nSource)
            exports['discord-screenshot']:requestCustomClientScreenshotUploadToDiscord(nSource, 'https://discord.com/api/webhooks/1121626733418926170/Q1UTCU7A43sxGBGSfI-sa3muXCaYtYzsRNvY_TaoIqcEH7ZbsKP_nQD725b_WWKwcqcE', { encoding = 'jpg', quality = 0.7 },
                {
                    username = '[SCREENSHOT] Source',
                    content = '```prolog\n[SOURCE]: '..nSource..'\n[IDS]: '..json.encode(ids, { indent = true })..' \n[Admin]: '..GetPlayerName(source)..'```'
                }, 30000, function(error) end
            )
        end
    end
end)

---------------------------------------
-- KICK SOURCE
---------------------------------------
RegisterCommand('kicksrc', function(source, args)
    local source = source
    local user_id = zero.getUserId(source)
    local identity = zero.getUserIdentity(user_id)
    if (user_id) and zero.hasPermission(user_id, 'staff.permissao') then
        if (args[1]) then
            local nSource = parseInt(args[1])
            if (nSource) then
                if (GetPlayerName(nSource)) then
                    local prompt = zero.prompt(source, { 'Motivo' })
                    if (prompt[1]) then
                        DropPlayer(nSource, 'Você foi kikado da nossa cidade.\nSua source: #'..nSource..'\n Motivo: '..prompt[1]..'\nAutor: '..identity.firstname..' '..identity.lastname)
                        TriggerClientEvent('notify', source, 'Kick Source', 'Voce kickou o source <b>'..args[1]..'</b> da cidade.')
                        zero.webhook('KickSource', '```prolog\n[/KICKSRC]\n[STAFF]: #'..user_id..' '..identity.firstname..' '..identity.lastname..'\n[BANIU SOURCE]: '..nSource..' \n[MOTIVO]: '..prompt[1]..os.date('\n[DATA]: %d/%m/%Y [HORA]: %H:%M:%S')..' \r```')
                    end
                end
            end
        end
    end
end)

---------------------------------------
-- RESET PLAYER
---------------------------------------
local resetList = {}

local queries = {
    { query = 'DELETE FROM smartphone_blocks WHERE phone IN (SELECT phone FROM vrp_user_identities WHERE user_id = :user_id) OR user_id = :user_id'},
    { query = 'DELETE FROM smartphone_calls WHERE target IN (SELECT phone FROM vrp_user_identities WHERE user_id = :user_id) OR initiator IN (SELECT phone FROM vrp_user_identities WHERE user_id = :user_id)'},
    { query = 'DELETE FROM smartphone_contacts WHERE owner IN (SELECT phone FROM vrp_user_identities WHERE user_id = :user_id) OR phone IN (SELECT phone FROM vrp_user_identities WHERE user_id = :user_id)'},
    { query = 'DELETE FROM smartphone_gallery WHERE user_id = :user_id'},
    { query = 'DELETE FROM smartphone_bank_invoices WHERE payee_id = :user_id OR payer_id = :user_id'},
    { query = 'DELETE FROM smartphone_instagram_followers WHERE profile_id IN (SELECT id FROM smartphone_instagram WHERE user_id = :user_id) OR follower_id IN (SELECT id FROM smartphone_instagram WHERE user_id = :user_id)'},
    { query = 'DELETE FROM smartphone_instagram_likes WHERE post_id IN (SELECT id FROM smartphone_instagram_posts WHERE profile_id IN (SELECT id FROM smartphone_instagram WHERE user_id = :user_id) AND post_id IS NULL) OR profile_id IN (SELECT id FROM smartphone_instagram WHERE user_id = :user_id)'},
    { query = 'DELETE FROM smartphone_instagram_notifications WHERE profile_id IN (SELECT id FROM smartphone_instagram WHERE user_id = :user_id) OR author_id IN (SELECT id FROM smartphone_instagram WHERE user_id = :user_id)'},
    { query = 'DELETE FROM smartphone_instagram_posts WHERE profile_id IN (SELECT id FROM smartphone_instagram WHERE user_id = :user_id)'},
    { query = 'DELETE FROM smartphone_instagram WHERE user_id = :user_id'},
    { query = 'DELETE FROM smartphone_olx WHERE user_id = :user_id'},
    { query = 'DELETE FROM smartphone_tinder_messages WHERE sender IN (SELECT id FROM smartphone_tinder WHERE user_id = :user_id) OR target IN (SELECT id FROM smartphone_tinder WHERE user_id = :user_id)'},
    { query = 'DELETE FROM smartphone_tinder_rating WHERE profile_id IN (SELECT id FROM smartphone_tinder WHERE user_id = :user_id)'},
    { query = 'DELETE FROM smartphone_tinder WHERE user_id = :user_id'},
    { query = 'DELETE FROM smartphone_twitter_tweets WHERE profile_id IN (SELECT id FROM smartphone_twitter_profiles WHERE user_id = :user_id) OR tweet_id IN (SELECT id FROM smartphone_twitter_profiles WHERE user_id = :user_id)'},
    { query = 'DELETE FROM smartphone_twitter_likes WHERE profile_id IN (SELECT id FROM smartphone_twitter_profiles WHERE user_id = :user_id) OR tweet_id IN (SELECT id FROM smartphone_twitter_profiles WHERE user_id = :user_id)'},
    { query = 'DELETE FROM smartphone_twitter_profiles WHERE user_id = :user_id'},
    { query = 'DELETE FROM smartphone_whatsapp_groups WHERE owner IN (SELECT phone FROM vrp_user_identities WHERE user_id = :user_id)'},
    { query = 'DELETE FROM smartphone_whatsapp_messages WHERE channel_id IN (SELECT id FROM smartphone_whatsapp_channels WHERE sender IN (SELECT phone FROM vrp_user_identities WHERE user_id = :user_id) OR target IN (SELECT phone FROM vrp_user_identities WHERE user_id = :user_id))'},
    { query = 'DELETE FROM smartphone_whatsapp_channels WHERE sender IN (SELECT phone FROM vrp_user_identities WHERE user_id = :user_id) OR target IN (SELECT phone FROM vrp_user_identities WHERE user_id = :user_id)'},
    { query = 'DELETE FROM smartphone_whatsapp WHERE owner IN (SELECT phone FROM vrp_user_identities WHERE user_id = :user_id)'},
    { query = 'DELETE FROM vrp_user_identities WHERE user_id = :user_id'},
    { query = 'DELETE FROM vrp_homes WHERE user_id = :user_id'},
    { query = 'DELETE FROM gb_box WHERE user_id = :user_id'},
    { query = 'DELETE FROM gb_facs_user_goals WHERE user_id = :user_id'},
    { query = 'DELETE FROM gb_facs_user_goals WHERE user_id = :user_id'},
    { query = 'DELETE FROM gb_gamepass WHERE user_id = :user_id'},
    { query = 'DELETE FROM gb_identity WHERE user_id = :user_id'},
    { query = 'DELETE FROM gb_namoro WHERE user_id = :user_id OR relacionamentoCom = :user_id'},
    { query = 'DELETE FROM gb_register WHERE user_id = :user_id'},
    { query = 'DELETE FROM gb_reward WHERE user_id = :user_id'},
    -- { query = 'DELETE FROM vrp_banco WHERE user_id = :user_id'},
    -- { query = 'DELETE FROM core_killsystem WHERE user_id = :user_id'},
    { query = 'DELETE FROM vrp_user_groups WHERE user_id = :user_id'},
	{ query = 'DELETE FROM vrp_user_moneys WHERE user_id = :user_id'},
    { query = 'DELETE FROM vrp_user_data WHERE user_id = :user_id'},	
	{ query = 'DELETE FROM vrp_user_vehicles WHERE user_id = :user_id'},
    { query = 'DELETE FROM vrp_mdt WHERE user_id = :user_id'},
}

local reset_player = function(user_id)
	local _queries = queries
	for _id,_ in pairs(_queries) do
		_queries[_id].values = { ['user_id'] = user_id }
	end
	exports.oxmysql:transaction(_queries, function()
		zero.resetIdentity(user_id)
	end)
end

AddEventHandler('zero:playerLeave', function(user_id, source)
	local source = source
	if (resetList[source]) then
		print('RESETOU ('..user_id..')')
		reset_player(user_id)
	end
end)

RegisterCommand('resetplayer', function(source, args)
    local text = ''
    local user_id
	if (source ~= 0) then user_id = zero.getUserId(source) end
	if (source == 0 or user_id) then
        if (source == 0 or zero.hasPermission(user_id, '+Staff.COO')) then
            local nUser = tonumber(args[1])
            if (nUser <= 0) then return; end;

            local nIdentity = zero.getUserIdentity(nUser)
            if (nIdentity) then
                if (source == 0) or zero.request(source, 'Tem certeza em resetar o passaporte '..nUser..'?', 30000) then
                    local nSource = zero.getUserSource(nUser)
                    if (nSource) then
                        resetList[nSource] = true
                        DropPlayer(nSource, 'Você foi resetado.')
                    else
                        reset_player(nUser)
                    end
                    if (source == 0) then
                        text = 'CONSOLE'
                        print('^5[AVISO]^7 Voce resetou o ID #^5'..nUser..'^7 ^5'..nIdentity.firstname..' '..nIdentity.lastname..'^7')
                    else
                        text = '#'..user_id..' '..identity.firstname..' '..identity.lastname
                        TriggerClientEvent('notify', source, 'Reset Player', 'Você resetou o passaporte <b>'..nUser..'</b>.')
                    end
                    zero.webhook('ResetPlayer', '```prolog\n[/RESETPLAYER]\n[STAFF]: '..text..'\n[RESETADO]: '..nUser..os.date('\n[DATA]: %d/%m/%Y [HORA]: %H:%M:%S')..' \r```')
                end
            else
                if (source ~= 0) then TriggerClientEvent('notify', source, 'Reset Player', 'Jogador <b>inexistente</b>.') end
            end
        end
    end
end)

---------------------------------------
-- SC HACK
---------------------------------------
RegisterCommand('schack',function(source)
    local source = source
    local user_id = zero.getUserId(source)
    if (user_id) and zero.hasPermission(user_id, 'player.noclip') then
        TriggerClientEvent('MQCU:getfodido', source)
    end
end)

---------------------------------------
-- ROUTING BUCKETS
---------------------------------------
RegisterCommand('gbucket', function(source, args)
    local source = source
    local user_id = zero.getUserId(source)
    if (user_id) and zero.hasPermission(user_id, '+Staff.Administrador') then
        if (args[1]) then
            local nUser = parseInt(args[1])
            local nSource = zero.getUserSource(nUser)
            if (nSource) and GetPlayerName(nSource) then
                TriggerClientEvent('notify', source, 'Get Bucket', 'O jogador <b>'..nUser..'</b> está na Sessão <b>'..GetPlayerRoutingBucket(nSource)..'</b>.', 8000)
            else
                TriggerClientEvent('notify', source, 'Get Bucket', 'O jogador <b>'..nUser..'</b> não foi encontrado.', 8000)
            end
        else
            TriggerClientEvent('notify', source, 'Get Bucket', 'Você está na Sessão <b>'..GetPlayerRoutingBucket(source)..'</b>.', 8000)
        end
    end
end)

RegisterCommand('sbucket', function(source, args)
    local source = source
    local user_id = zero.getUserId(source)
    local identity = zero.getUserIdentity(user_id)
    if (user_id) and zero.hasPermission(user_id, '+Staff.Administrador') then
        if (args[1] and args[2]) then
            local nUser = parseInt(args[1])
            local nSource = zero.getUserSource(nUser)
            local bucket = parseInt(args[2])
            if (nSource and GetPlayerName(nSource)) and (bucket >= 0) then
                SetPlayerRoutingBucket(nSource, bucket)
                TriggerClientEvent('notify', source, 'Set Bucket', 'O jogador <b>'..nUser..'</b> foi setado na sessão <b>'..bucket..'</b>.', 8000)
                zero.webhook('Bucket', '```prolog\n[/SBUCKET]\n[STAFF]: #'..user_id..' '..identity.firstname..' '..identity.lastname..' \n[SETOU]: '..nUser..'\n[SESSÃO]: '..bucket..os.date('\n[DATA]: %d/%m/%Y [HORA]: %H:%M:%S')..' \r```')
            else
                TriggerClientEvent('notify', source, 'Set Bucket', 'O jogador <b>'..nUser..'</b> não foi encontrado.', 8000)
            end
        end
    end
end)

---------------------------------------
-- RG2
---------------------------------------
RegisterCommand('rg2', function(source, args)
    local source = source
    local user_id = zero.getUserId(source)
    if (user_id) and zero.hasPermission(user_id, 'staff.permissao') then
        if (args[1]) then
            local nUser = parseInt(args[1])
            local identity = zero.getUserIdentity(nUser)
            if (identity) then
                local bankMoney = zero.getBankMoney(nUser)
                local paypalMoney = zero.getPaypalMoney(nUser)
                local walletMoney = zero.getMoney(nUser)

                local groups = ''
                for gp, i in pairs(zero.getUserGroups(nUser)) do
                    groups = groups..'<br>'..gp..' ('..i.grade..')'
                end

                TriggerClientEvent('notify', source, 'Registro', 'Passaporte: <b>#'..nUser..'</b><br>Registro: <b>'..identity.registration..'</b><br>Nome: <b>'..identity.firstname..' '..identity.lastname..'</b><br>Idade: <b>'..identity.age..'</b><br>Telefone: <b>'..identity.phone..'</b><br>Carteira: <b>'..zero.format(parseInt(walletMoney))..'</b><br>Banco: <b>'..zero.format(parseInt(bankMoney))..'</b><br>Paypal: <b>'..zero.format(parseInt(paypalMoney))..'</b><br>Sets: <b>'..groups..'</b>', 25000)
            else
                TriggerClientEvent('notify', source, 'Registro', 'Este <b>ID</b> não fez personagem em nossa cidade!')
            end
        end
    end
end)

---------------------------------------
-- ID
---------------------------------------
RegisterCommand('id', function(source)
    local source = source
    local user_id = zero.getUserId(source)
    if (user_id) then
        local nPlayer = zeroClient.getNearestPlayer(source, 2.0)
        if (nPlayer) then
            local nUser = zero.getUserId(nPlayer)
            TriggerClientEvent('notify', nPlayer, 'Passaporte', 'O cidadão <b>'..user_id..'</b> está verificando o seu passaporte.')
            TriggerClientEvent('notify', source, 'Passaporte', 'Passaporte: <b>('..nUser..')</b>', 10000)
        end
    end
end)

---------------------------------------
-- RONDA HOSPITAL
---------------------------------------
local DeadCitizens = function(source)
    local blipUsers = {}
    Citizen.CreateThread(function()
        while (Player(source).state.patrolHospital) do
            local users = zero.getUsers()
            if (users) then
                for id, src in pairs(users) do
                    local ply = GetPlayerPed(src)
                    if (GetEntityHealth(ply) <= 100 and (not blipUsers[id])) then
                        local plyCoords = GetEntityCoords(ply)

                        blipUsers[id] = zeroClient.addBlip(source, plyCoords.x, plyCoords.y, plyCoords.z, 280, 27, 'Cidadão caído', 0.7, false)
                        Citizen.SetTimeout(30000, function() zeroClient.removeBlip(source, blipUsers[id]) blipUsers[id] = nil end)
                    end
                end
            end
            Citizen.Wait(15000)
        end
    end)
end

RegisterCommand('rondahp', function(source)
    local user_id = zero.getUserId(source)
    if (user_id) and zero.hasPermission(user_id, 'hospital.permissao') then
        local identity = zero.getUserIdentity(user_id)
        if (Player(source).state.patrolHospital) then
            Player(source).state.patrolHospital = false
            TriggerClientEvent('notify', source, 'Prefeitura', 'Você saiu de <b>patrulha</b>.')
        else
            DeadCitizens(source)
            Player(source).state.patrolHospital = { id = user_id, name = identity.firstname..' '..identity.lastname }
            TriggerClientEvent('notify', source, 'Prefeitura', 'Você entrou em <b>patrulha</b>.')
        end
    end
end)

RegisterCommand('listrhp', function(source)
    local user_id = zero.getUserId(source)
    if (user_id) and zero.hasPermission(user_id, 'hospital.permissao') or zero.hasPermission(user_id, 'staff.permissao') then
        local inService = zero.getUsersByPermission('hospital.permissao')
        local list, paramedics = '', 0
        for src, id in ipairs(inService) do
            local user = Player(src).state.patrolHospital
            if (user) then
                list = list..'<b>'..user.name..' ('..user.id..')</b> <br>'
                paramedics = (paramedics + 1)
            end
        end
        local text = (paramedics >= 1 and 'Paramédicos em patrulha: <br><br>'..list or 'Não possuem <b>paramédicos</b> em patrulha no momento.')
        TriggerClientEvent('notify', source, 'Prefeitura', text)
    end
end)

RegisterNetEvent('zero_hospital:CitizenDeath', function()
    local hospital = zero.getUsersByPermission('hospital.permissao')
    for k, v in pairs(hospital) do
        local nSource = zero.getUserSource(parseInt(v))
        if (Player(nSource).state.patrolHospital) then
            async(function()
                TriggerClientEvent('notify', nSource, 'Prefeitura', 'Um <b>cidadão</b> acabou de desmaiar!')
            end)
        end
    end
end)

---------------------------------------
-- RICH PRESENCE
---------------------------------------
AddEventHandler('vRP:playerSpawn', function(user_id, source)
    if (user_id) then
        local identity = zero.getUserIdentity(user_id)
        if (identity) then
            TriggerClientEvent('zero_core:discord', source, '#'..user_id..' '..identity.firstname..' '..identity.lastname)
        end

        Citizen.SetTimeout(8000, function()
            local userTable = zero.getUserDataTable(user_id)
            if (userTable) then
                if (userTable.Handcuff == true) then
                    Player(source).state.Handcuff = true
                    zeroClient.setHandcuffed(source, true)
                    TriggerClientEvent('zero_interactions:algemas', source, 'colocar')
                end

                if (userTable.Capuz == true) then
                    Player(source).state.Capuz = true
                    zeroClient.setCapuz(source, true)
                end

                if (userTable.GPS == true) then
                    Player(source).state.GPS = true
                    TriggerClientEvent('zero_system:gps', source)
                end
            end
        end)
    end
end)

RegisterNetEvent('zero_system:gps_server', function()
    local source = source
    Player(source).state.GPS = false
end)

---------------------------------------
-- ROCKSTAR EDITOR
---------------------------------------
local rockstarCommands = {
    ['start'] = function(source)
        vCLIENT.StartEditor(source)
    end,
    ['save'] = function(source)
        vCLIENT.stopAndSave(source)
    end,
    ['discard'] = function(source)
        vCLIENT.Discard(source)
    end,
    ['open'] = function(source)
        vCLIENT.openEditor(source)
    end
}

RegisterCommand('rockstar', function(source, args) 
    local user_id = zero.getUserId(source)
    if (user_id) and zero.hasPermission(user_id, 'staff.permissao') then
        if (args[1]) and rockstarCommands[args[1]] then
            rockstarCommands[args[1]](source)
        else
            TriggerClientEvent('notify', source, 'Prefeitura', 'Você não <b>especificou</b> o que gostaria de utilizar, tente novamente:<br><br><b>- /rockstar start<br>- /rockstar save<br>- /rockstar open<br>- /rockstar discard</b>')
        end
    end
end)

---------------------------------------
-- BVIDA
---------------------------------------
srv.Bvida = function()
    local source = source
    local user_id = zero.getUserId(source)
    if (user_id) then
        local cooldown = 'bvida-'..user_id
        if (exports[GetCurrentResourceName()]:GetCooldown(cooldown)) then
            TriggerClientEvent('notify', source, 'Bvida', 'Aguarde <b>'..exports[GetCurrentResourceName()]:GetCooldown(cooldown)..' segundos</b> para utilizar este comando novamente.')
            return
        end
        exports[GetCurrentResourceName()]:CreateCooldown(cooldown, 30)

        exports.zero_appearance:setCustomization(source, user_id)
    end
end

---------------------------------------
-- DETIDO
---------------------------------------
RegisterCommand('detido', function(source)
    local user_id = zero.getUserId(source)
    if (user_id) and zero.checkPermissions(user_id, { 'staff.permissao', 'policia.permissao' }) then
        local vehicle, vnetid = zeroClient.vehList(source, 5.0)
        if (vnetid) then
            local prompt = exports.zero_hud:prompt(source, {
                'Motivo'
            })

            if (prompt) then
                prompt = prompt[1]

                local vehState = exports.zero_garage:getVehicleData(vnetid)
                if (vehState.user_id) then
                    local veh = zero.query('zero_dismantle/getVehicleInfo', { user_id = vehState.user_id, vehicle = vehState.model })[1]
                    if (veh) then
                        if (parseInt(veh.detained) > 0) then
                            TriggerClientEvent('notify', source, 'Detido', 'Este <b>veículo</b> já se encontra detido.')
                        else
                            local nplayer = zero.getUserSource(vehState.user_id)
                            if (nplayer) then TriggerClientEvent('notify', nplayer, 'Detido', 'Seu veículo ('..zero.vehicleName(vehState.model)..') foi <b>detido</b>.', 10000); end;

                            zeroClient.playSound(source, 'Hack_Success', 'DLC_HEIST_BIOLAB_PREP_HACKING_SOUNDS')
                            TriggerClientEvent('notify', source, 'Detido', 'O <b>veículo</b> foi apreendido com sucesso.')
                            zero.execute('zero_garage/setDetained', { detained = 2, user_id = vehState.user_id, vehicle = vehState.model })
                            zero.webhook('Detido', '```prolog\n[/DETIDO]\n[OFFICER]: '..user_id..'\n[VEHICLE]: '..vehState.model..'\n[VEHICLE OWNER]: '..vehState.user_id..'\n[REASON]: '..prompt..' '..os.date('\n[DATE]: %d/%m/%Y [HOUR]: %H:%M:%S')..' \r```')
                        end
                    end
                end
            end
        end
    end
end)

---------------------------------------
-- TOOGLE
---------------------------------------
local _ToogleDefault = 'https://discord.com/api/webhooks/1144388223624282143/9o-TWD0hG26CnVCynfmNsk8dJeoqsDsgSy7Kzq_7Ab7UJ6pufUVGztbu8TRJZYPhoId_'
local _ToogleStaff = 'https://discord.com/api/webhooks/1144381802459447496/XE3lTagQ1PNW1e8_S8RVS2jBeKna_PCuvziPZKxwRxv7If8rru-HngXp1tuPAXzsIvAh'

local Toogle = {
    ['Policia'] = { 
        blip = { name = 'Policia', view = { ['Policia'] = true, ['Paramedico'] = true } },
        clearWeapons = true,
        webhook = 'https://discord.com/api/webhooks/1144480658899619860/BZXGIS4sb1q9yagZJiMjkGauApmkPsIS_DcY0FiaLUZAa0oQPU6HG1xh0rVG61qARbPP',
        toggleCoords = {
            { coord = vector3(-2286.699, 356.0967, 174.5927), radius = 70 },
        }
    },
    ['Hospital'] = { 
        blip = { name = 'Paramedico', view = { ['Paramedico'] = true, ['Policia'] = true } },
        webhook = 'https://discord.com/api/webhooks/1144480825119871086/vIH1P9fCuI_d8D6rv2E0w-KCJ0tQLGXh-2r8swqBVSX4vV3elJJuT80Y-WMcdWj7Xt4S',
        toggleCoords = {
            { coord = vector3(-816.1978, -1229.103, 7.324585), radius = 70 },
        }
    },
    ['Deic'] = { 
        blip = { name = 'DEIC', view = { ['Paramedico'] = true, ['Policia'] = true, ['Deic'] = true } },
        clearWeapons = true,
        webhook = 'https://discord.com/api/webhooks/1141426122660261988/Qr_S_oy9DTpjdTPjeMAB7VRdmLtCnvzKnU09Js4sXW7gW9L_asrkqxA3K2C8wedVoUX1',
        toggleCoords = {
            { coord = vector3(480.5011, 4539.547, 79.96411), radius = 70 },
        }
    },
    ['ZeroMecanica'] = { 
        -- webhook = 'https://discord.com/api/webhooks/1141426122660261988/Qr_S_oy9DTpjdTPjeMAB7VRdmLtCnvzKnU09Js4sXW7gW9L_asrkqxA3K2C8wedVoUX1',
        toggleCoords = {
            { coord = vector3(138.1582, -3029.723, 7.02124), radius = 70 },
        }
    },
}

local getPoliceWeapons = {
    'weapon_pistol_mk2',
    'm_weapon_pistol_mk2',
    'weapon_combatpistol',
    'm_weapon_combatpistol',
    'weapon_smg_mk2',
    'm_weapon_smg_mk2',
    'weapon_combatpdw',
    'm_weapon_combatpdw',
    'weapon_assaultsmg',
    'm_weapon_assaultsmg',
    'weapon_pumpshotgun_mk2',
    'm_weapon_pumpshotgun_mk2',
    'weapon_combatshotgun',
    'm_weapon_combatshotgun',
    'weapon_carbinerifle_mk2',
    'm_weapon_carbinerifle_mk2',
    'weapon_militaryrifle',
    'm_weapon_militaryrifle',
    'weapon_tacticalrifle',
    'm_weapon_tacticalrifle',
    'weapon_sniperrifle',
    'm_weapon_sniperrifle',
    'weapon_nightstick',
    'weapon_stungun',
    'colete-militar'
}

local givePoliceWeapons = {
    ['weapon_combatpistol'] = 1,
    ['m_weapon_combatpistol'] = 50
}

RegisterCommand('toogle', function(source)
    local user_id = zero.getUserId(source)
    local identity = zero.getUserIdentity(user_id)
    for k, v in pairs(Toogle) do
        local inGroup, inGrade = zero.hasGroup(user_id, k)
		if (inGroup) then

            local neartoggle = true	
			if (v.toggleCoords) then
				neartoggle = false
				local coords = GetEntityCoords(GetPlayerPed(source))
				for _, pos in pairs(v.toggleCoords) do
					if #(pos.coord - coords) <= pos.radius then
						neartoggle = true
					end
 				end
			end

            if (neartoggle) then
                local newState = (not zero.hasGroupActive(user_id, k))
				local groupName = zero.getGroupTitle(k, inGrade)

                zero.setGroupActive(user_id, k, newState)
                local logsmg = ''
				if (newState) then
					TriggerClientEvent('notify', source, 'Toogle', '<b>'..groupName..'</b> | Você entrou em serviço.')
					logmsg = '[STATUS]: JOIN'
					if (v.blip) then TriggerEvent("sw-blips:tracePlayer", source, v.blip.name, v.blip.view); end;
				else
					TriggerClientEvent('notify', source, 'Toogle', '<b>'..groupName..'</b> | Você saiu de serviço.')
					logmsg = '[STATUS]: LEAVE'
					if (v.blip) then TriggerEvent('sw-blips:unTracePlayer', source); end;
                    
                    if (v.clearWeapons) then
                        local weapons = zeroClient.replaceWeapons(source, {}, GlobalState.weaponToken)
                        zero.setKeyDataTable(user_id, 'weapons', {})

                        for k, v in pairs(weapons) do
                            local weapon = k:lower()
                            zero.giveInventoryItem(user_id, weapon, 1)
                            if (v.ammo > 0) then
                                zero.giveInventoryItem(user_id, 'm_'..weapon, v.ammo)
                            end
                        end

                        for _, item in pairs(getPoliceWeapons) do
                            local amount = zero.getInventoryItemAmount(user_id, item)
                            if (amount > 0) then
                                zero.tryGetInventoryItem(user_id, item, amount)
                                TriggerClientEvent('notify', source, 'Toogle', 'Retiramos <b>'..math.floor(amount)..'x</b> de <b>'..zero.itemNameList(item)..'</b> da sua mochila!')
                            end
                        end

                        -- for item, amount in pairs(givePoliceWeapons) do
                        --     zero.giveInventoryItem(user_id, item, amount)
                        --     TriggerClientEvent('notify', source, 'Toogle', 'Você recebeu <b>'..amount..'x</b> de <b>'..zero.itemNameList(item)..'</b>')
                        -- end                        
                    end
                end

                zero.webhook((v.webhook ~= '' and v.webhook or _ToogleDefault), '```prolog\n[/TOOGLE]\n[JOB]: '..string.upper(k)..' - '..string.upper(inGrade)..'\n[USER]: '..user_id..'# '..identity.firstname..' '..identity.lastname..'\n'..logmsg..os.date('\n[DATE]: %d/%m/%Y [HOUR]: %H:%M:%S')..' \r```')
            else
                TriggerClientEvent('notify', source, 'Toogle', 'Você só pode usar <b>/toogle</b> nos locais de Trabalho!')
            end
        end	
    end
end)

AddEventHandler('zero:playerLeave', function(user_id, source)
    local identity = zero.getUserIdentity(user_id)
	for k, v in pairs(Toogle) do
		local inGroup, inGrade = zero.hasGroup(user_id,k)
		if (inGroup) and zero.hasGroupActive(user_id,k) then		
			zero.setGroupActive(user_id, k, false)
			zero.webhook((v.webhook ~= '' and v.webhook or _ToogleDefault), '```prolog\n[/TOOGLE]\n[JOB]: '..string.upper(k)..' - '..string.upper(inGrade)..'\n[USER]: '..user_id..' '..identity.firstname..' '..identity.lastname..'\n[STATUS]: LEAVE'..os.date('\n[DATE]: %d/%m/%Y [HOUR]: %H:%M:%S')..' \r```')
		end
	end
end)

local prefeituraCoord = vector3(-550.9846, -193.2, 38.21021)
RegisterCommand('staff',function(source)
	local user_id = zero.getUserId(source)
    local identity = zero.getUserIdentity(user_id)
	local groupName, groupInfo = zero.getUserGroupByType(user_id, 'staff')
    if (groupName) then
        if (#(GetEntityCoords(GetPlayerPed(source)) - prefeituraCoord) <= 50) then
            zero.setGroupActive(user_id, groupName, (not groupInfo.active))

            local logmsg = ''
            if (not groupInfo.active) then
                TriggerClientEvent('notify', source, 'Toogle', '<b>'..groupName..'</b> | Você entrou em serviço.')	
                logmsg = '[STATUS]: JOIN'
            else
                TriggerClientEvent('notify', source, 'Toogle', '<b>'..groupName..'</b> | Você saiu de serviço.')
                logmsg = '[STATUS]: LEAVE'
            end

            zero.webhook(_ToogleStaff, '```prolog\n[/STAFF]\n[JOB]: '..string.upper(groupName)..'\n[USER]: '..user_id..' '..identity.firstname..' '..identity.lastname..'\n'..logmsg..os.date('\n[DATE]: %d/%m/%Y [HOUR]: %H:%M:%S')..' \r```')
        else
            TriggerClientEvent('notify', source, 'Toogle', 'Você não está na <b>prefeitura</b>!')
        end   
    end
end)

---------------------------------------
-- PTR
---------------------------------------
RegisterCommand('ptr', function(source)
    local user_id = zero.getUserId(source)
    if (user_id) then
        local count = 0
        local name = ''
        for k, v in pairs(zero.getUsersByPermission('policia.permissao')) do
            local identity = zero.getUserIdentity(v)
            if (identity) then
                name = name..'<b>'..v..'</b>: '..identity.firstname..' '..identity.lastname.. '<br>'
            end
            count = (count + 1)
        end

        TriggerClientEvent('notify', source, 'Prefeitura', 'Atualmente <b>'..count..' Oficiais</b> em serviço.')
        if (zero.checkPermissions(user_id, { 'staff.permissao', 'policia.permissao' }) and count > 0) then
            TriggerClientEvent('notify', source, 'Prefeitura', name)
        end
    end
end)

---------------------------------------
-- EMS
---------------------------------------
RegisterCommand('ems', function(source)
    local user_id = zero.getUserId(source)
    if (user_id) then
        local count = 0
        local name = ''
        for k, v in pairs(zero.getUsersByPermission('hospital.permissao')) do
            local identity = zero.getUserIdentity(v)
            if (identity) then
                name = name..'<b>'..v..'</b>: '..identity.firstname..' '..identity.lastname.. '<br>'
            end
            count = (count + 1)
        end

        TriggerClientEvent('notify', source, 'Prefeitura', 'Atualmente <b>'..count..' Paramédicos</b> em serviço.')
        if (zero.checkPermissions(user_id, { 'staff.permissao', 'hospital.permissao' }) and count > 0) then
            TriggerClientEvent('notify', source, 'Prefeitura', name)
        end
    end
end)

---------------------------------------
-- STATUS
---------------------------------------
RegisterCommand('status', function(source)
    local user_id = zero.getUserId(source)
    if (user_id) then
        local onlinePlayers = GetNumPlayerIndices()
        local staff = zero.getUsersByPermission('staff.permissao')
        local policias = zero.getUsersByPermission('policia.permissao')
        local ems = zero.getUsersByPermission('hospital.permissao')
        local mec = zero.getUsersByPermission('zeromecanica.permissao')
        local fome = zero.getUsersByPermission('zerofome.permissao')
        
        TriggerClientEvent('notify', source, 'Prefeitura', 'Status dos serviços da nossa cidade: <br> <br> <b>Prefeitura</b>: '..#staff..' <br> <b>Policia</b>: '..#policias..' <br> <b>Paramédico</b>: '..#ems..' <br> <b>Mecânico</b>: '..#mec..' <br> <b>Zero Fome</b>: '..#fome..' <br> <b>Cidadãos</b>: '..onlinePlayers)
    end
end)

---------------------------------------
-- ADMON
---------------------------------------
RegisterCommand('admon', function(source)
    local user_id = zero.getUserId(source)
    if (user_id and zero.checkPermissions(user_id, { '+Staff.Manager' })) then
        local count = 0
        local name = ''
        for k, v in pairs(zero.getUsersByPermission('staff.permissao')) do
            local identity = zero.getUserIdentity(v)
            if (identity) then
                name = name..'<b>'..v..'</b>: '..identity.firstname..' '..identity.lastname.. '<br>'
            end
            count = (count + 1)
        end

        TriggerClientEvent('notify', source, 'Prefeitura', 'Atualmente <b>'..count..' Staffs</b> em serviço.')
        if (count > 0) then
            TriggerClientEvent('notify', source, 'Prefeitura', name)
        end
    end
end)

---------------------------------------
-- SEQUESTRO
---------------------------------------
RegisterCommand('sequestro', function(source)
    local nPlayer = zeroClient.getNearestPlayer(source, 5)
	if (nPlayer) then
        if (vCLIENT.checkSequestro(source) == -1) then TriggerClientEvent('notify', source, 'Drumond', 'Este <b>veículo</b> não tem porta-malas.') return; end;
        if (GetEntityHealth(GetPlayerPed(source)) <= 100) then return; end;
        if (zeroClient.isHandcuffed(source)) then return; end;
		if (zeroClient.isHandcuffed(nPlayer)) then
			if (not zeroClient.getNoCarro(source)) then
				local vehicle = zeroClient.getNearestVehicle(source,7)
				if (vehicle) then
                    
					if zeroClient.getCarroClass(source,vehicle) then
						zeroClient.setMalas(nPlayer)
					end
				end
			elseif (zeroClient.isMalas(nPlayer)) then
				zeroClient.setMalas(nPlayer)
			end
		else
			TriggerClientEvent('notify', source, 'Drumond', 'A pessoa precisa estar algemada para colocar ou retirar do <b>porta-malas</b>.')
		end
	end
end)

---------------------------------------
-- APREENDER
---------------------------------------
local apreenderWebhook = 'https://discord.com/api/webhooks/1147703583047958568/1ue7-nqHnORbJOaBXKfbRr0E8m81Q3F3HXbCJg7hvJPYHrO9Oxn0ldEJwALJ0kGnkPAq'

RegisterCommand('apreender', function(source)
    local user_id = zero.getUserId(source)
    if (user_id) and zero.checkPermissions(user_id, { 'policia.permissao', 'staff.permissao' }) then
        local nPlayer = zeroClient.getNearestPlayer(source, 2.0)
        if (nPlayer) then
            if (GetEntityHealth(GetPlayerPed(nPlayer)) <= 100 or zeroClient.isHandcuffed(nPlayer)) then
                if (GetEntityHealth(GetPlayerPed(source)) <= 100) then return end;
                local nUser = zero.getUserId(nPlayer)
                if (nUser) then
                    local nIdentity = zero.getUserIdentity(nUser)
                    local request = exports.zero_hud:request(source, 'Você tem certeza que deseja apreender os itens ilegais do '..nIdentity.firstname..' '..nIdentity.lastname..'?', 30000)
                    if (request) then
                        local itens = {}
                        local weapons = zeroClient.replaceWeapons(nPlayer, {}, GlobalState.weaponToken)
                        zero.setKeyDataTable(nUser, 'weapons', {})
                        
                        for k, v in pairs(weapons) do
                            local weapon = k:lower()
                            zero.giveInventoryItem(nUser, weapon, 1)
                            if (v.ammo > 0) then
                                zero.giveInventoryItem(nUser, 'm_'..weapon, v.ammo)
                            end
                        end
                        
                        zeroClient._playAnim(source, true, {
                            { 'oddjobs@shop_robbery@rob_till', 'loop' }
                        }, true)
                        TriggerClientEvent('progressBar', source, 'Apreendendo...', 5000)
                        Wait(5000)
                        local inventory = zero.getInventory(nUser)
                        for k, v in pairs(inventory) do
                            local itemConfig = exports.zero_inventory:getItemInfo(k)
                            if (itemConfig.arrest) then
                                if (zero.tryGetInventoryItem(nUser, k, v.amount)) then
                                    table.insert(itens, v.amount..'x '..(zero.itemNameList(k) or k))		
                                end
                            end
                        end
                        local ped = GetPlayerPed(source)
                        ClearPedTasks(ped)

                        TriggerClientEvent('notify', nPlayer, 'Apreensão', 'Todos os seus itens ilegais foram <b>apreendidos</b> e enviados à prefeitura!')
                        TriggerClientEvent('notify', source, 'Apreensão', 'Você <b>apreendeu</b> todos os itens ilegais do cidadão!')
                        TriggerClientEvent('radio:outServers', nPlayer)
                        
                        zero.webhook(apreenderWebhook, '```prolog\n[APREENSÃO]\n[OFFICER]: '..user_id..'\n[TARGET]: '..nUser..'\n[ITENS]: '..json.encode(itens, { indent = true })..os.date('\n[DATE]: %d/%m/%Y [HOUR]: %H:%M:%S')..' \r```')
                    end
                end
            else
                TriggerClientEvent('notify', source, 'Apreensão', 'O cidadão precisa estar <b>algemado</b> ou <b>desmaiado</b>!');
            end
        end
    end
end)