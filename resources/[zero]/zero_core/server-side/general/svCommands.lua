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
	local user_id = vRP.getUserId(source)
    local identity = vRP.getUserIdentity(user_id)
	if (user_id and vRP.hasPermission(user_id, 'polpar.permissao')) then
		local nplayer = vRPclient.getNearestPlayer(source, 2)
		if (nplayer) then
            local nUser = vRP.getUserId(nplayer)
			local nIdentity = vRP.getUserIdentity(nUser)
			TriggerClientEvent('rmascara', nplayer)
			vRP.webhook(webhooks.policeCommands, '```prolog\n[/RMASCARA]\n[USER_ID]: '..user_id..' | '..identity.name..' '..identity.firstname..'\n[RETIROU A MASCARA DO]\n[JOGADOR]: '..nUser..' | '..nIdentity.name..' '..nIdentity.firstname..' '..os.date('\n[DATA]: %d/%m/%Y [HORA]: %H:%M:%S')..' \r```')
		end
	end
end)