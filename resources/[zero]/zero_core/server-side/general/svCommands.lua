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
                vRPclient.killGod(nPlayer)
                vRPclient.setHealth(nPlayer, 400) 
                zero.varyHunger(other_id, -100)     
                zero.varyThirst(other_id, -100)          
			end
        else
            vRPclient.killGod(source)
			vRPclient.setHealth(source, 400)
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
		vRPclient.toggleNoclip(source) 
        zero.webhook(webhooks.nc, '```prolog\n[/NC]\n[STAFF]: #'.._userId..' '.._identity.firstname..' '.._identity.lastname..' \n[NOCLIP]: '..tostring(vRPclient.isNoclip(source))..'\n[COORD]: '..tostring(GetEntityCoords(GetPlayerPed(source)))..os.date('\n[DATA]: %d/%m/%Y [HORA]: %H:%M:%S')..' \r```')    
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