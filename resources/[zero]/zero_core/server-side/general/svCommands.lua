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
    end
end)