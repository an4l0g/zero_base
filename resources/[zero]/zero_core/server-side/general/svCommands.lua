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
        local nplayer = vRPclient.getNearestPlayer(source, 2)
		if (nplayer) then
            local nUser = vRP.getUserId(nplayer)
			local nIdentity = vRP.getUserIdentity(nUser)
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
                    zero.webhook(webhooks.enviar, '```prolog\n[/ENVIAR]\n[ID]: #'..user_id..' '..identity.firstname..' '..identity.lastname..' \n[ENVIOU]: R$'..vRP.format(amount)..' \n[PARA O ID]: #'..nUser..' '..nIdentity.firstname..' '..nIdentity.lastname..os.date('\n[DATA]: %d/%m/%Y [HORA]: %H:%M:%S')..' \r```')
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
        local nPlayer = zero.getUserSource(parseInt(args[1]))
        if (nPlayer) then
            local nUser = zero.getUserId(nPlayer)
            local nIdentity = zero.getUserIdentity(nUser)
            
        end
    end
end)

---------------------------------------
-- TRY DELETE OBJ
---------------------------------------
RegisterNetEvent('trydeleteobj', function(index)
    local entity = NetworkGetEntityFromNetworkId(index)
    if (entity and entity ~= 0) then DeleteEntity(entity) end
end)