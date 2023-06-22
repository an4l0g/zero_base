local srv = {}
Tunnel.bindInterface('Commands', srv)
local vCLIENT = Tunnel.getInterface('Commands')
---------------------------------------
-- GOD
---------------------------------------
RegisterCommand('god', function(source, args)
    local _userId = zero.getUserId(source)
    if (_userId) and zero.hasPermission(_userId, 'staff.permissao') then
        local _identity = zero.getUserIdentity(_userId)
        if (args[1]) then
            local nPlayer = zero.getUserSource(args[1])
            if (nPlayer) then
                zeroClient.killGod(nPlayer)
                zeroClient.setHealth(nPlayer, 400) 
                zero.varyHunger(other_id, -100)     
                zero.varyThirst(other_id, -100)          
			end
        else
            zeroClient.killGod(source)
			zeroClient.setHealth(source, 400)
            zero.varyHunger(_userId, -100)     
            zero.varyThirst(_userId, -100)    
        end
        zero.webhook(webhooks.god, '```prolog\n[/GOD]\n[STAFF]: #'.._userId..' '.._identity.firstname..' '.._identity.lastname..' \n[REVIVEU]: '..(args[1] or _userId)..'\n[COORD]: '..tostring(GetEntityCoords(GetPlayerPed(source)))..os.date('\n[DATA]: %d/%m/%Y [HORA]: %H:%M:%S')..' \r```')
    end
end)

---------------------------------------
-- GODALL
---------------------------------------
RegisterCommand('godall', function(source)
    local source = source
    local user_id = zero.getUserId(source)
    local identity = zero.getUserIdentity(user_id)
    if (user_id) and zero.hasPermission(user_id, 'admin.permissao') then
        local users = zero.getUsers()
        for k, v in pairs(users) do
            local id = zero.getUserSource(parseInt(k))
            if (id) then
            	zeroClient._killGod(id)
				zeroClient._setHealth(id, 400)
            end
        end
        zero.webhook(webhooks.godAll, '```prolog\n[/GODALL]\n[STAFF]: #'..user_id..' '..identity.firstname..' '..identity.lastname..' \n[REVIVEU]: TODOS!\n[COORD]: '..tostring(GetEntityCoords(GetPlayerPed(source)))..os.date('\n[DATA]: %d/%m/%Y [HORA]: %H:%M:%S')..' \r```')
    end
end)

---------------------------------------
-- GODALL
---------------------------------------
RegisterCommand('godarea', function(source)
    local source = source
    local user_id = zero.getUserId(source)
    local identity = zero.getUserIdentity(user_id)
    if (user_id) and zero.hasPermission(user_id, 'admin.permissao') then
        local radius = zero.prompt(source, { 'Distancia' })
        radius[1] = parseInt(radius[1])
        if (radius[1]) and radius[1] > 0 then
            local players = zeroClient.getNearestPlayers(source, radius[1])
            for k, v in pairs(players) do
                zeroClient._killGod(k)
				zeroClient._setHealth(k, 400) 
            end
            zero.webhook(webhooks.godArea, '```prolog\n[/GODAREA]\n[STAFF]: #'..user_id..' '..identity.firstname..' '..identity.lastname..' \n[ÁREA]: '..radius[1]..'\n[COORD]: '..tostring(GetEntityCoords(GetPlayerPed(source)))..os.date('\n[DATA]: %d/%m/%Y [HORA]: %H:%M:%S')..' \r```')
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
    if (user_id) and zero.hasPermission(user_id, 'mod.permissao') then
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
        zero.webhook(webhooks.kill, '```prolog\n[ID]: #'..user_id..' '..identity.firstname..' '..identity.lastname..' \n[MATOU]: '..(args[1] or user_id)..os.date('\n[DATA]: %d/%m/%Y [HORA]: %H:%M:%S')..' \r```')
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
            if (prompt[1]) then
                local nPlayer = zero.getUserSource(parseInt(args[1]))
                if (nPlayer) then
                    DropPlayer(nPlayer, 'Você foi kikado da nossa cidade.\nSeu passaporte: #'..args[1]..'\n Motivo: '..prompt[1]..'\nAutor: '..identity.firstname..' '..identity.lastname)
                    TriggerClientEvent('notify', source, 'Kick', 'Voce kickou o passaporte <b>'..args[1]..'</b> da cidade.')
                    zero.webhook(webhooks.kick, '```prolog\n[/KICK]\n[STAFF]: #'..user_id..' '..identity.firstname..' '..identity.lastname..' \n[KICKOU]: '..args[1]..'\n[MOTIVO]: '..prompt[1]..os.date('\n[DATA]: %d/%m/%Y [HORA]: %H:%M:%S')..' \r```')
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
    if (user_id) and zero.hasPermission(user_id, 'admin.permissao') then
        TriggerClientEvent('announcement', -1, 'Alerta', 'Foi detectado um terremoto de <b>magnitude 8</b> na <b>Escala Richter</b> chegando em nossa cidade. Mantenha a calma e procure um abrigo.', 'Governo', true, 30000)
        Citizen.Wait(5000)
        TriggerClientEvent('zero_core:terremoto', -1)
        Citizen.Wait(15000)
        local players = zero.getUsers()
        for k, v in pairs(players) do
            local nSource = zero.getUserSource(parseInt(k))
            if (nSource) then
                DropPlayer(nSource, 'Você foi vítima de um terremoto.')
                zero.webhook(webhooks.kickAll, '```prolog\n[/KICKALL]\n[STAFF]: #'..user_id..' '..identity.firstname..' '..identity.lastname..' \n[KICKOU]: TODOS!'..os.date('\n[DATA]: %d/%m/%Y [HORA]: %H:%M:%S')..' \r```')
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
    if (user_id) and zero.hasPermission(user_id, 'mod.permissao') then
        local nUser = parseInt(args[1])
        if (nUser) then
            exports['zero']:setWhitelisted(nUser, true)
            TriggerClientEvent('notify', source, 'Whitelist', 'Você aprovou o passaporte <b>'..nUser..'</b> na whitelist.')
            zero.webhook(webhooks.whitelist, '```prolog\n[/WL]\n[STAFF]: #'..user_id..' '..identity.firstname..' '..identity.lastname..' \n[APROVOU WL]: '..args[1]..os.date('\n[DATA]: %d/%m/%Y [HORA]: %H:%M:%S')..' \r```')
        end
    end
end)

RegisterCommand('unwl', function(source, args)
    local source = source
    local user_id = zero.getUserId(source)
    local identity = zero.getUserIdentity(user_id)
    if (user_id) and zero.hasPermission(user_id, 'staff.permissao') then
        local nUser = parseInt(args[1])
        if (nUser) then
            exports['zero']:setWhitelisted(nUser, false)
            TriggerClientEvent('notify', source, 'Whitelist', 'Você retirou o passaporte <b>'..nUser..'</b> da whitelist.')
            zero.webhook(webhooks.whitelist, '```prolog\n[/UNWL]\n[STAFF]: #'..user_id..' '..identity.firstname..' '..identity.lastname..' \n[RETIROU WL]: '..args[1]..os.date('\n[DATA]: %d/%m/%Y [HORA]: %H:%M:%S')..' \r```')
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
    if (user_id) and zero.hasPermission(user_id, 'staff.permissao') then
        local nUser = parseInt(args[1])
        local nPlayer = zero.getUserSource(nUser)
        if (nUser > 0) then
            local prompt = zero.prompt(source, { 'Motivo' })
            if (prompt[1]:gsub(' ','') == '') then return; end;
            if (prompt[1]) then
                exports[GetCurrentResourceName()]:setBanned(nUser, true)
                DropPlayer(nPlayer, 'Você foi banido da nossa cidade.\nSeu passaporte: #'..nUser..'\n Motivo: '..prompt[1]..'\nAutor: '..identity.firstname..' '..identity.lastname)
                TriggerClientEvent('notify', source, 'Banimento', 'Você baniu o passaporte <b>'..nUser..'</b> da cidade.')
                zero.webhook(webhooks.ban, '```prolog\n[/BAN]\n[STAFF]: #'..user_id..' '..identity.firstname..' '..identity.lastname..' \n[BANIU]: '..nUser..'\n[MOTIVO]: '..prompt[1]..os.date('\n[DATA]: %d/%m/%Y [HORA]: %H:%M:%S')..' \r```')
            end
        end
    end
end)

RegisterCommand('unban', function(source, args)
    local source = source
    local user_id = zero.getUserId(source)
    local identity = zero.getUserIdentity(user_id)
    if (user_id) and zero.hasPermission(user_id, 'manager.permissao') then
        local nUser = parseInt(args[1])
        if (nUser > 0) then
            local prompt = zero.prompt(source, { 'Motivo' })
            if (prompt[1]:gsub(' ','') == '') then return; end;
            if (prompt[1]) then
                exports[GetCurrentResourceName()]:setBanned(nUser, false)
                TriggerClientEvent('notify', source, 'Desbanimento', 'Você desbaniu o passaporte <b>'..nUser..'</b> da cidade.')
                zero.webhook(webhooks.ban, '```prolog\n[/UNBAN]\n[STAFF]: #'..user_id..' '..identity.firstname..' '..identity.lastname..' \n[DESBANIU]: '..nUser..'\n[MOTIVO]: '..prompt[1]..os.date('\n[DATA]: %d/%m/%Y [HORA]: %H:%M:%S')..' \r```')
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
    if (user_id) and zero.hasPermission(user_id, 'dono.permissao') then
        if (not user_id == 1 and not user_id == 2 and not user_id == 3) then return; end;
        local amount = parseInt(args[1])
		if (amount) then
			zero.giveBankMoney(user_id, amount)
            TriggerClientEvent('notify', source, 'Money', 'Você spawnou <b>R$'..zero.format(amount)..'</b>.')
			zero.webhook(webhooks.money, '```prolog\n[/MONEY]\n[STAFF]: #'..user_id..' '..identity.firstname..' '..identity.lastname..' \n[MONEY]: R$'..zero.format(amount)..os.date('\n[DATA]: %d/%m/%Y [HORA]: %H:%M:%S')..' \r```')
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
                print('^5[ZERO MONEY]^7 Voce setou ^2R$'..zero.format(money)..'^7 para o passaporte ^2'..nUser..'^7.')
                TriggerClientEvent('notify', nSource, 'Money', 'Você recebeu <b>R$'..zero.format(money)..'</b> da <b>Prefeitura</b>.', 10000)
                zero.webhook(webhooks.money, '```prolog\n[/MONEY2]\n[STAFF]: CONSOLE\n[JOGADOR]: #'..nUser..' '..nIdentity.firstname..' '..nIdentity.lastname..'\n[RECEBEU]: R$'..zero.format(money)..' '..os.date('\n[DATA]: %d/%m/%Y [HORA]: %H:%M:%S')..' \r```')
            end
        else
            local user_id = zero.getUserId(source)
            local identity = zero.getUserIdentity(user_id)
            if (user_id) and zero.hasPermission(user_id, 'dono.permissao') then
                if (not user_id == 1 and not user_id == 2 and not user_id == 3) then return; end;
                if (nUser and money) then
                    zero.giveBankMoney(nUser, money)
                    TriggerClientEvent('notify', source, 'Money', 'Você spawnou <b>R$'..zero.format(money)..'</b>, para o jogador <b>#'..nUser..' '..nIdentity.firstname..' '..nIdentity.lastname..'</b>.')
                    TriggerClientEvent('notify', nSource, 'Money', 'Você recebeu <b>R$'..zero.format(money)..'</b> da <b>Prefeitura</b>.', 10000)
                    zero.webhook(webhooks.money, '```prolog\n[/MONEY2]\n[STAFF]: #'..user_id..' '..identity.firstname..' '..identity.lastname..' \n[JOGADOR]: #'..nUser..' | '..nIdentity.firstname..' '..nIdentity.lastname..'\n[RECEBEU]: R$'..zero.format(money)..' '..os.date('\n[DATA]: %d/%m/%Y [HORA]: %H:%M:%S')..' \r```')
                end
            end
        end
    end
end)

RegisterCommand('moneyall', function(source, args)
    local source = source
    local user_id = zero.getUserId(source)
    local identity = zero.getUserIdentity(user_id)
    if (user_id) and zero.hasPermission(user_id, 'dono.permissao') then
        if (not user_id == 1 and not user_id == 2 and not user_id == 3) then return; end;
        local amount = parseInt(args[1])
		if (amount) then
            local players = zero.getUsers()
            for k, v in pairs(players) do
                local nSource = zero.getUserSource(parseInt(k))
                local nUser = zero.getUserId(nSource)
                if (nSource) then
                    zero.giveBankMoney(nUser, amount)
                    TriggerClientEvent('notify', nSource, 'Money', 'Você recebeu <b>R$'..zero.format(amount)..'</b> da <b>Prefeitura</b>.', 10000)
                end
            end
			zero.webhook(webhooks.money, '```prolog\n[/MONEYALL]\n[STAFF]: #'..user_id..' '..identity.firstname..' '..identity.lastname..' \n[MONEY]: R$'..zero.format(amount)..os.date('\n[DATA]: %d/%m/%Y [HORA]: %H:%M:%S')..' \r```')
		end
	end
end)

RegisterCommand('delmoney', function(source, args)
    if (#args > 0) then
        local nSource = zero.getUserSource(parseInt(args[1]))
        local nUser = zero.getUserId(nSource)
        local nIdentity = zero.getUserIdentity(nUser)
        local money = parseInt(args[2])
        if (source == 0) then
            if (nUser and money) then
                zero.tryFullPayment(nUser, money)
                print('^5[ZERO MONEY]^7 Voce tirou ^2R$'..zero.format(money)..'^7 do passaporte ^2'..nUser..'^7.')
                TriggerClientEvent('notify', nSource, 'Money', 'Você perdeu <b>R$'..zero.format(money)..'</b> pra <b>Prefeitura</b>.', 10000)
                zero.webhook(webhooks.money, '```prolog\n[/DELMONEY]\n[STAFF]: CONSOLE\n[JOGADOR]: #'..nUser..' '..nIdentity.firstname..' '..nIdentity.lastname..'\n[PERDEU]: R$'..zero.format(money)..' '..os.date('\n[DATA]: %d/%m/%Y [HORA]: %H:%M:%S')..' \r```')
            end
        else
            local user_id = zero.getUserId(source)
            local identity = zero.getUserIdentity(user_id)
            if (user_id) and zero.hasPermission(user_id, 'dono.permissao') then
                if (not user_id == 1 and not user_id == 2 and not user_id == 3) then return; end;
                if (nUser and money) then
                    zero.tryFullPayment(nUser, money)
                    TriggerClientEvent('notify', source, 'Money', 'Você retirou <b>R$'..zero.format(money)..'</b>, do jogador <b>#'..nUser..' '..nIdentity.firstname..' '..nIdentity.lastname..'</b>.')
                    TriggerClientEvent('notify', nSource, 'Money', 'Você perdeu <b>R$'..zero.format(money)..'</b> pra <b>Prefeitura</b>.', 10000)
                    zero.webhook(webhooks.money, '```prolog\n[/DELMONEY]\n[STAFF]: #'..user_id..' '..identity.firstname..' '..identity.lastname..' \n[JOGADOR]: #'..nUser..' | '..nIdentity.firstname..' '..nIdentity.lastname..'\n[PERDEU]: R$'..zero.format(money)..' '..os.date('\n[DATA]: %d/%m/%Y [HORA]: %H:%M:%S')..' \r```')
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
        zero.webhook(webhooks.nc, '```prolog\n[/NC]\n[STAFF]: #'.._userId..' '.._identity.firstname..' '.._identity.lastname..' \n[NOCLIP]: '..tostring(zeroClient.isNoclip(source))..'\n[COORD]: '..tostring(GetEntityCoords(GetPlayerPed(source)))..os.date('\n[DATA]: %d/%m/%Y [HORA]: %H:%M:%S')..' \r```')    
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
    if (user_id) and zero.hasPermission(user_id, 'staff.permissao') then
        TriggerClientEvent('clipboard', source, 'Seu ID', user_id)
    end
end)

RegisterCommand('mysource', function(source)
    local source = source
    local user_id = zero.getUserId(source)
    if (user_id) and zero.hasPermission(user_id, 'staff.permissao') then
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
            if (k ~= #users) then
                players = players..', '
            end
            players = players..k
            quantidade = quantidade + 1
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
        zero.webhook(webhooks.tpway, '```prolog\n[/TPWAY]\n[STAFF]: #'.._userId..' '.._identity.firstname..' '.._identity.lastname..'\n[TELEPORTOU]: PARA WAYPOINT\n[COORD]: '..tostring(GetEntityCoords(GetPlayerPed(source)))..os.date('\n[DATA]: %d/%m/%Y [HORA]: %H:%M:%S')..' \r```')
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
        zero.webhook(webhooks.tpcds, '```prolog\n[/TPCDS]\n[STAFF]: #'.._userId..' '.._identity.firstname..' '.._identity.lastname..'\n[TELEPORTOU]: '..tostring(vector3((coords[1] or 0), (coords[2] or 0), (coords[3] or 0)))..os.date('\n[DATA]: %d/%m/%Y [HORA]: %H:%M:%S')..' \r```')
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
            local nUser = zero.getUserId(nPlayer)
            local nIdentity = zero.getUserIdentity(nUser)
            if (nPlayer) then
                local nCoords = GetEntityCoords(GetPlayerPed(nPlayer))
                zero.webhook(webhooks.tpto, '```prolog\n[/TPTO]\n[STAFF]: #'..user_id..' '..identity.firstname..' '..identity.lastname..' \n[FOI ATÉ]: #'..nUser..' '..nIdentity.firstname..' '..nIdentity.lastname..'\n[COORDENADA]: '..tostring(nCoords)..os.date('\n[DATA]: %d/%m/%Y [HORA]: %H:%M:%S')..' \r```')    
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
            local nUser = zero.getUserId(nPlayer)
            local nIdentity = zero.getUserIdentity(nUser)
            if (nPlayer) then
                local pCoords = GetEntityCoords(GetPlayerPed(source))
                zero.webhook(webhooks.tpto, '```prolog\n[/TPTOME]\n[STAFF]: #'..user_id..' '..identity.firstname..' '..identity.lastname..' \n[PUXOU]: #'..nUser..' '..nIdentity.firstname..' '..nIdentity.lastname..'\n[COORDENADA]: '..tostring(pCoords)..os.date('\n[DATA]: %d/%m/%Y [HORA]: %H:%M:%S')..' \r```')    
                SetEntityCoords(nPlayer, pCoords)
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
			zero.webhook(webhooks.policeCommands, '```prolog\n[/RMASCARA]\n[USER_ID]: #'..user_id..' '..identity.firstname..' '..identity.lastname..'\n[RETIROU A MASCARA DO]\n[JOGADOR]: #'..nUser..' '..nIdentity.firstname..' '..nIdentity.lastname..' '..os.date('\n[DATA]: %d/%m/%Y [HORA]: %H:%M:%S')..' \r```')
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
			zero.webhook(webhooks.policeCommands, '```prolog\n[/RCHAPEU]\n[USER_ID]: #'..user_id..' '..identity.firstname..' '..identity.lastname..'\n[RETIROU O CHAPEU DO]\n[JOGADOR]: #'..nUser..' '..nIdentity.firstname..' '..nIdentity.lastname..' '..os.date('\n[DATA]: %d/%m/%Y [HORA]: %H:%M:%S')..' \r```')
        else
            TriggerClientEvent('notify', source, 'Remover Chápeu', 'Você não se encontra próximo de um <b>cidadão</b>.')
        end
	end
end)

---------------------------------------
-- CONE
---------------------------------------
RegisterCommand('cone', function(source, args)
	local user_id = zero.getUserId(source)
    local identity = zero.getUserIdentity(user_id)
	if (user_id) and zero.hasPermission(user_id, 'polpar.permissao') then
		TriggerClientEvent('cone', source, args[1])
		zero.webhook(webhooks.policeCommands, '```prolog\n[/CONE]\n[USER_ID]: #'..user_id..' '..identity.firstname..' '..identity.lastname..'\n['..(args[1] and 'DELETOU' or 'CRIOU')..' UM CONE NA]\n[COORDENADA]: '..tostring(GetEntityCoords(GetPlayerPed(source)))..' '..os.date('\n[DATA]: %d/%m/%Y [HORA]: %H:%M:%S')..' \r```')
	end
end)

---------------------------------------
-- BARREIRA
---------------------------------------
RegisterCommand('barreira', function(source, args)
	local user_id = zero.getUserId(source)
    local identity = zero.getUserIdentity(user_id)
	if (user_id) and zero.hasPermission(user_id, 'polpar.permissao') then
		TriggerClientEvent('barreira', source, args[1])
		zero.webhook(webhooks.policeCommands, '```prolog\n[/BARREIRA]\n[USER_ID]: #'..user_id..' '..identity.firstname..' '..identity.lastname..'\n['..(args[1] and 'DELETOU' or 'CRIOU')..' UMA BARREIRA NA]\n[COORDENADA]: '..tostring(GetEntityCoords(GetPlayerPed(source)))..' '..os.date('\n[DATA]: %d/%m/%Y [HORA]: %H:%M:%S')..' \r```')
	end
end)

---------------------------------------
-- SPIKE
---------------------------------------
RegisterCommand('spike', function(source, args)
	local user_id = zero.getUserId(source)
    local identity = zero.getUserIdentity(user_id)
	if (user_id) and zero.hasPermission(user_id, 'polpar.permissao') then
		TriggerClientEvent('spike', source, args[1])
		zero.webhook(webhooks.policeCommands, '```prolog\n[/SPIKE]\n[USER_ID]: #'..user_id..' '..identity.firstname..' '..identity.lastname..'\n['..(args[1] and 'DELETOU' or 'CRIOU')..' UMA SPIKE NA]\n[COORDENADA]: '..tostring(GetEntityCoords(GetPlayerPed(source)))..' '..os.date('\n[DATA]: %d/%m/%Y [HORA]: %H:%M:%S')..' \r```')
	end
end)

---------------------------------------
-- RCAPUZ
---------------------------------------
RegisterCommand('rcapuz', function(source)
	local user_id = zero.getUserId(source)
    local identity = zero.getUserIdentity(user_id)
	if (user_id) and zero.hasPermission(user_id, 'polpar.permissao') then
        local nplayer = zeroClient.getNearestPlayer(source, 2)
		if (nplayer) then
            local nUser = zero.getUserId(nplayer)
			local nIdentity = zero.getUserIdentity(nUser)
            if (zeroClient.isCapuz(nplayer)) then
                zeroClient.setCapuz(nplayer) 
				zero.webhook(webhooks.policeCommands, '```prolog\n[/RCAPUZ]\n[USER_ID]: #'..user_id..' '..identity.firstname..' '..identity.lastname..'\n[RETIROU O CAPUZ DO]\n[JOGADOR]: #'..nUser..' '..nIdentity.firstname..' '..nIdentity.lastname..' '..os.date('\n[DATA]: %d/%m/%Y [HORA]: %H:%M:%S')..' \r```')
            else
                TriggerClientEvent('notify', source, 'Remover Capuz', 'O <b>cidadão</b> não está com o capuz na cabeça.')
            end
        else
            TriggerClientEvent('notify', source, 'Remover Capuz', 'Você não se encontra próximo de um <b>cidadão</b>.')
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
	if (zero.hasPermission(user_id, 'polpar.permissao') and not zeroClient.isInVehicle(source)) then
		local nplayer = zeroClient.getNearestPlayer(source, 10)
		if (nplayer) then
			local nUser = zero.getUserId(nplayer)
			local nIdentity = zero.getUserIdentity(nUser)
            zeroClient.putInNearestVehicleAsPassenger(nplayer, 7)
			zero.webhook(webhooks.policeCommands, '```prolog\n[/CV]\n[USER_ID]: #'..user_id..' '..identity.firstname..' '..identity.lastname..'\n[DEU CV NO]\n[JOGADOR]: #'..nUser..' '..nIdentity.firstname..' '..nIdentity.lastname..' '..os.date('\n[DATA]: %d/%m/%Y [HORA]: %H:%M:%S')..' \r```')
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
		local nplayer = zeroClient.getNearestPlayer(source, 10)
		if (nplayer) then
			local nUser = zero.getUserId(nplayer)
			local nIdentity = zero.getUserIdentity(nUser)
            zeroClient.ejectVehicle(nplayer)
			zero.webhook(webhooks.policeCommands, '```prolog\n[/RV]\n[USER_ID]: #'..user_id..' '..identity.firstname..' '..identity.lastname..'\n[DEU RV NO]\n[JOGADOR]: #'..nUser..' '..nIdentity.firstname..' '..nIdentity.lastname..' '..os.date('\n[DATA]: %d/%m/%Y [HORA]: %H:%M:%S')..' \r```')
        else
            TriggerClientEvent('notify', source, 'Retirar Veículo', 'Você não se encontra próximo de um <b>cidadão</b>.')
        end
	end
end)

---------------------------------------
-- TOW
---------------------------------------
RegisterCommand('tow', function(source)
    local source = source
	local user_id = zero.getUserId(source)
	if (user_id) and zero.hasPermission(user_id, 'mecanico.permissao') then
		TriggerClientEvent('vTow', source)
	end
end)

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
            zero.webhook(webhooks.chat, '```prolog\n[CHATS ORG]\n[MEC]\n[JOGADOR]: #'..user_id..' '..identity.firstname..' '..identity.lastname..'\n[MENSAGEM]: '..raw:sub(4)..'\n[COORDENADA]: '..tostring(GetEntityCoords(GetPlayerPed(source)))..' '..os.date('\n[DATA]: %d/%m/%Y [HORA]: %H:%M:%S')..' \r```')
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
                        zero.webhook(webhooks.chat, '```prolog\n[CHATS ORG]\n[MEC CENTRAL]\n[JOGADOR]: '..user_id..' | '..identity.firstname..' '..identity.lastname..'\n[MENSAGEM]: '..raw:sub(4)..'\n[COORDENADA]: '..tostring(GetEntityCoords(GetPlayerPed(source)))..' '..os.date('\n[DATA]: %d/%m/%Y [HORA]: %H:%M:%S')..' \r```')
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
            zero.webhook(webhooks.chat, '```prolog\n[CHATS ORG]\n[PREFEITURA]\n[JOGADOR]: #'..user_id..' '..identity.firstname..' '..identity.lastname..'\n[MENSAGEM]: '..raw:sub(4)..'\n[COORDENADA]: '..tostring(GetEntityCoords(GetPlayerPed(source)))..' '..os.date('\n[DATA]: %d/%m/%Y [HORA]: %H:%M:%S')..' \r```')
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
                        TriggerClientEvent('chatMessage', -1, '[CENTRAL PREFEITURA] '..identity.firstname..' '..identity.lastname, { 0, 153, 255 }, raw:sub(4))
                        zero.webhook(webhooks.chat, '```prolog\n[CHATS ORG]\n[PREFEITURA CENTRAL]\n[JOGADOR]: '..user_id..' | '..identity.firstname..' '..identity.lastname..'\n[MENSAGEM]: '..raw:sub(4)..'\n[COORDENADA]: '..tostring(GetEntityCoords(GetPlayerPed(source)))..' '..os.date('\n[DATA]: %d/%m/%Y [HORA]: %H:%M:%S')..' \r```')
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
            zero.webhook(webhooks.chat, '```prolog\n[CHATS ORG]\n[190]\n[JOGADOR]: #'..user_id..' '..identity.firstname..' '..identity.lastname..'\n[MENSAGEM]: '..raw:sub(4)..'\n[COORDENADA]: '..tostring(GetEntityCoords(GetPlayerPed(source)))..' '..os.date('\n[DATA]: %d/%m/%Y [HORA]: %H:%M:%S')..' \r```')
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
                        TriggerClientEvent('chatMessage', -1, '[CENTRAL POLÍCIA] '..identity.firstname..' '..identity.lastname, { 0, 153, 255 }, raw:sub(4))
                        zero.webhook(webhooks.chat, '```prolog\n[CHATS ORG]\n[POLÍCIA CENTRAL]\n[JOGADOR]: '..user_id..' | '..identity.firstname..' '..identity.lastname..'\n[MENSAGEM]: '..raw:sub(4)..'\n[COORDENADA]: '..tostring(GetEntityCoords(GetPlayerPed(source)))..' '..os.date('\n[DATA]: %d/%m/%Y [HORA]: %H:%M:%S')..' \r```')
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
            zero.webhook(webhooks.chat, '```prolog\n[CHATS ORG]\n[192]\n[JOGADOR]: #'..user_id..' '..identity.firstname..' '..identity.lastname..'\n[MENSAGEM]: '..raw:sub(4)..'\n[COORDENADA]: '..tostring(GetEntityCoords(GetPlayerPed(source)))..' '..os.date('\n[DATA]: %d/%m/%Y [HORA]: %H:%M:%S')..' \r```')
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
                        zero.webhook(webhooks.chat, '```prolog\n[CHATS ORG]\n[HOSPITAL CENTRAL]\n[JOGADOR]: '..user_id..' | '..identity.firstname..' '..identity.lastname..'\n[MENSAGEM]: '..raw:sub(4)..'\n[COORDENADA]: '..tostring(GetEntityCoords(GetPlayerPed(source)))..' '..os.date('\n[DATA]: %d/%m/%Y [HORA]: %H:%M:%S')..' \r```')
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
                    zeroClient._playAnim(source, true, {{ 'mp_common', 'givetake1_a' }}, false)
			        zeroClient._playAnim(nPlayer, true, {{ 'mp_common', 'givetake1_a' }}, false)
                    TriggerClientEvent('notify', source, 'Enviar', 'Você enviou <b>R$'..zero.format(amount)..'</b>.')
                    TriggerClientEvent('notify', nPlayer, 'Enviar', 'Você recebeu <b>R$'..zero.format(amount)..'</b>.')
                    zero.webhook(webhooks.enviar, '```prolog\n[/ENVIAR]\n[ID]: #'..user_id..' '..identity.firstname..' '..identity.lastname..' \n[ENVIOU]: R$'..zero.format(amount)..' \n[PARA O ID]: #'..nUser..' '..nIdentity.firstname..' '..nIdentity.lastname..os.date('\n[DATA]: %d/%m/%Y [HORA]: %H:%M:%S')..' \r```')
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
        if (message[1]) then
            TriggerClientEvent('announcement', -1, 'Prefeitura', message[1], identity.firstname, true, 30000)
            zero.webhook(webhooks.anuncios, '```prolog\n[/ADM]\n[USER_ID]: #'..user_id..' '..identity.firstname..' '..identity.lastname..'\n[MENSAGEM]: '..message[1]..' \n[COORDENADA]: '..tostring(GetEntityCoords(GetPlayerPed(source)))..' '..os.date('\n[DATA]: %d/%m/%Y [HORA]: %H:%M:%S')..' \r```')
        end
    end
end)

RegisterCommand('anuncio', function(source)
    local source = source
    local user_id = zero.getUserId(source)
    local identity =  zero.getUserIdentity(user_id)
    if (user_id) and zero.hasPermission(user_id, 'polpar.permissao') or zero.hasPermission(user_id, 'mecanico.permissao') then
        local message = zero.prompt(source, { 'Título', 'Mensagem' })
        if (message[1]) then
            TriggerClientEvent('announcement', -1, message[1], message[2], identity.firstname, true, 30000)
            zero.webhook(webhooks.anuncios, '```prolog\n[/ANUNCIO]\n[USER_ID]: #'..user_id..' '..identity.firstname..' '..identity.lastname..'\n[TÍTULO]: '..message[1]..'\n[MENSAGEM]: '..message[2]..' \n[COORDENADA]: '..tostring(GetEntityCoords(GetPlayerPed(source)))..' '..os.date('\n[DATA]: %d/%m/%Y [HORA]: %H:%M:%S')..' \r```')
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
    if (user_id) and zero.hasPermission(user_id, 'admin.permissao') then
        local vehicle = zeroClient.getNearestVehicle(source, 7.0)
        if (vehicle) then
            local prompt = zero.prompt(source, { 'RGB Color(255, 255, 255)' })
            if (prompt[1]) then
                local rgb = sanitizeString(prompt[1], '0123456789,', true)
                local r, g, b = table.unpack(splitString(rgb, ','))
                TriggerClientEvent('zero_core:carcolor', source, vehicle, parseInt(r), parseInt(g), parseInt(b), (args[1] ~= '2') )   
                TriggerClientEvent('notify', source, 'Car Color','A cor do <b>veículo</b> foi alterada.')
                zero.webhook(webhooks.carColor, '```prolog\n[/CARCOLOR]\n[STAFF]: #'..user_id..' '..identity.firstname..' '..identity.lastname..'\n[RGB]: '..prompt[1]..' \n[COORDS]: '..tostring(GetEntityCoords(GetPlayerPed(source)))..'\n'..os.date('[DATA]: %d/%m/%Y [HORA]: %H:%M:%S')..' \r```')
            end
        end
    end
end)

---------------------------------------
-- UNCUFF
---------------------------------------
RegisterCommand('uncuff', function(source)
    local source = source
    local user_id = zero.getUserId(source)
    local identity = zero.getUserIdentity(user_id)
    if (user_id) and zero.hasPermission(user_id, 'admin.permissao') then
        if (zero.isHandcuffed(source)) then
            TriggerClientEvent('zero_core:uncuff', source)
            zero.webhook(webhooks.unCuff, '```prolog\n[/UNCUFF]\n[STAFF]: #'..user_id..' '..identity.firstname..' '..identity.lastname..'\n[SE DESALGEMOU] \n[COORDS]: '..tostring(GetEntityCoords(GetPlayerPed(source)))..'\n'..os.date('[DATA]: %d/%m/%Y [HORA]: %H:%M:%S')..' \r```')
        else
            TriggerClientEvent('notify', source, 'Uncuff', 'Você não se encontra <b>algemado</b>.')
        end
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
        zero.webhook(webhooks.limparArea, '```prolog\n[/LIMPARAREA]\n[STAFF]: #'..user_id..' '..identity.firstname..' '..identity.lastname..'\n[COORDS]: '..tostring(pCoord)..'\n'..os.date('[DATA]: %d/%m/%Y [HORA]: %H:%M:%S')..' \r```')
    end
end)

---------------------------------------
-- SKIN
---------------------------------------
RegisterCommand('skin', function(source, args)
    local source = source
    local user_id = zero.getUserId(source)
    local identity = zero.getUserIdentity(user_id)
    if (user_id) and zero.hasPermission(user_id, 'dono.permissao') then
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
        zero.webhook(webhooks.skins, '```prolog\n[/SKIN]\n[STAFF]: #'..user_id..' '..identity.firstname..' '..identity.lastname..'\n[JOGADOR]: '..text..os.date('\n[DATA]: %d/%m/%Y [HORA]: %H:%M:%S')..' \r```')
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
	if (user_id) and zero.hasPermission(user_id, 'admin.permissao') then
		TriggerClientEvent('zero_core:delnpcs', source)
        zero.webhook(webhooks.delNpcs, '```prolog\n[/DELNPCS]\n[STAFF]: #'..user_id..' '..identity.firstname..' '..identity.lastname..os.date('\n[DATA]: %d/%m/%Y [HORA]: %H:%M:%S')..' \r```')
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
    if (user_id) and zero.hasPermission(user_id, 'dono.permissao') then
        TriggerClientEvent('zero_core:tuning', source)
        zero.webhook(webhooks.tuning, '```prolog\n[/TUNING]\n[STAFF]: #'..user_id..' '..identity.firstname..' '..identity.lastname..os.date('\n[DATA]: %d/%m/%Y [HORA]: %H:%M:%S')..' \r```')
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
    if (user_id) and zero.hasPermission(user_id, 'admin.permissao') then
        local text = ''
        if (args[1]) then
            local nSource = zero.getUserSource(parseInt(args[1]))
            local nUser = zero.getUserId(nSource)
            local nIdentity = zero.getUserIdentity(nUser)
            if (nSource) then
                zeroClient.giveWeapons(nSource, {}, true, GlobalState.weaponToken)
                TriggerClientEvent('notify', source, 'Clear Weapon', 'Você limpou os <b>armamentos</b> do passaporte <b>'..nUser..'</b>.')
                text = '#'..nUser..' '..nIdentity.firstname..' '..nIdentity.lastname
            end
        else
            zeroClient.giveWeapons(source, {}, true, GlobalState.weaponToken)
            TriggerClientEvent('notify', source, 'Clear Weapon', 'Você limpou os seus <b>armamentos</b>')
            text = '#'..user_id..' '..identity.firstname..' '..identity.lastname
        end
        zero.webhook(webhooks.clearWeapons, '```prolog\n[/CLEARWEAPONS]\n[STAFF]: #'..user_id..' '..identity.firstname..' '..identity.lastname..'\n[LIMPOU AS ARMAS DO]: '..text..os.date('\n[DATA]: %d/%m/%Y [HORA]: %H:%M:%S')..' \r```')
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
            table.insert(content, k..' => '..json.encode(v)) 
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
            if (message[1]) then
                local nPlayer = zero.getUserSource(parseInt(args[1]))
                local nUser = zero.getUserId(nPlayer)
                local nIdentity = zero.getUserIdentity(nUser)
                if (nPlayer) then
                    TriggerClientEvent('notify', nPlayer, 'Mensagem Privada', 'O staff <b>'..identity.firstname..' '..identity.lastname..'</b> te enviou uma mensagem: <br /><br />'..message[1], 10000)
                    TriggerClientEvent('notify', source, 'Mensagem Privada', 'A mensagem foi enviada com <b>sucesso</b>.')
                    zeroClient.playSound(source, 'Event_Message_Purple', 'GTAO_FM_Events_Soundset')
					zeroClient.playSound(nPlayer, 'Event_Message_Purple', 'GTAO_FM_Events_Soundset')
					Citizen.Wait(100)
					zeroClient.playSound(nPlayer, 'Event_Message_Purple', 'GTAO_FM_Events_Soundset')
					Citizen.Wait(100)
					zeroClient.playSound(nPlayer, 'Event_Message_Purple', 'GTAO_FM_Events_Soundset')
                    zero.webhook(webhooks.umsg, '```prolog\n[/UMSG]\n[STAFF]: #'..user_id..' '..identity.firstname..' '..identity.lastname..' \n[FALOU COM]: #'..nUser..' '..nIdentity.firstname..' '..nIdentity.lastname..' \n[MENSAGEM]: '..message[1]..os.date('\n[DATA]: %d/%m/%Y - [HORA]: %H:%M:%S')..' \r```')
                end
            end
        end
    end
end)