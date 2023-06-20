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
-- TRY DELETE OBJ
---------------------------------------
RegisterNetEvent('trydeleteobj', function(index)
    local entity = NetworkGetEntityFromNetworkId(index)
    if (entity and entity ~= 0) then DeleteEntity(entity) end
end)