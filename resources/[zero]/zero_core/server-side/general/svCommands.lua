local vCLIENT = Tunnel.getInterface('Commands')
---------------------------------------
-- GOD
---------------------------------------
RegisterCommand('god', function(source, args)
    local _userId = vRP.getUserId(source)
    if (_userId) and vRP.hasPermission(_userId, 'staff.permissao') then
        local _identity = vRP.getUserIdentity(_userId)
        if (args[1]) then
            local nPlayer = vRP.getUserSource(args[1])
            if (nPlayer) then
                vRPclient.killGod(nPlayer)
                vRPclient.setHealth(nPlayer, 400) 
                vRP.varyHunger(other_id, -100)     
                vRP.varyThirst(other_id, -100)          
			end
        else
            vRPclient.killGod(source)
			vRPclient.setHealth(source, 400)
            vRP.varyHunger(_userId, -100)     
            vRP.varyThirst(_userId, -100)    
        end
        vRP.webhook(webhooks.god, '```prolog\n[/GOD]\n[STAFF]: #'.._userId..' '.._identity.firstname..' '.._identity.lastname..' \n[REVIVEU]: '..(args[1] or _userId)..'\n[COORD]: '..tostring(GetEntityCoords(GetPlayerPed(source)))..os.date('\n[DATA]: %d/%m/%Y [HORA]: %H:%M:%S')..' \r```')
    end
end)

---------------------------------------
-- NOCLIP
---------------------------------------
RegisterCommand('nc', function(source)
	local _userId = vRP.getUserId(source)
    if (_userId) and vRP.hasPermission(_userId, 'staff.permissao') then
        local _identity = vRP.getUserIdentity(_userId)
		vRPclient.toggleNoclip(source)        
        vRP.webhook(webhooks.nc, '```prolog\n[/NC]\n[STAFF]: #'.._userId..' '.._identity.firstname..' '.._identity.lastname..' \n[NOCLIP]: '..tostring(vRPclient.isNoclip(source))..'\n[COORD]: '..tostring(GetEntityCoords(GetPlayerPed(source)))..os.date('\n[DATA]: %d/%m/%Y [HORA]: %H:%M:%S')..' \r```')    
	end
end)

---------------------------------------
-- TPWAY
---------------------------------------
RegisterCommand('tpway', function(source)
	local _userId = vRP.getUserId(source)
    if (_userId) and vRP.hasPermission(_userId, 'staff.permissao') then
        local _identity = vRP.getUserIdentity(_userId)
        vCLIENT.tpToWayFunction(source)
        vRP.webhook(webhooks.tpway, '```prolog\n[/TPWAY]\n[STAFF]: #'.._userId..' '.._identity.firstname..' '.._identity.lastname..'\n[TELEPORTOU]: PARA WAYPOINT\n[COORD]: '..tostring(GetEntityCoords(GetPlayerPed(source)))..os.date('\n[DATA]: %d/%m/%Y [HORA]: %H:%M:%S')..' \r```')
    end
end)

---------------------------------------
-- TPCDS
---------------------------------------
RegisterCommand('tpcds', function(source)
    local _userId = vRP.getUserId(source)
    if (_userId) and vRP.hasPermission(_userId, 'staff.permissao') then
        local _identity = vRP.getUserIdentity(_userId)
        local promptCoords = vRP.prompt(source, { 'Coordenadas' })
        if (not promptCoords) then return; end;

        local coords = {}
        for coord in string.gmatch(sanitizeString(promptCoords[1], '0123456789,-.',true) ,'[^,]+') do
			table.insert(coords, (tonumber(coord) or 0))
		end

        SetEntityCoords(GetPlayerPed(source), (coords[1] or 0), (coords[2] or 0), (coords[3] or 0))
        vRP.webhook(webhooks.tpcds, '```prolog\n[/TPCDS]\n[STAFF]: #'.._userId..' '.._identity.firstname..' '.._identity.lastname..'\n[TELEPORTOU]: '..tostring(vector3((coords[1] or 0), (coords[2] or 0), (coords[3] or 0)))..os.date('\n[DATA]: %d/%m/%Y [HORA]: %H:%M:%S')..' \r```')
    end
end)