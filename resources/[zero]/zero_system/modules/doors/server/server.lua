local srv = {}
Tunnel.bindInterface('Doors', srv)

local doorTimeouts = {}

local permission = {
    ['perm'] = function(user_id, perm, home)
        return zero.checkPermissions(user_id, perm)
    end,
    ['home'] = function(user_id, perm, home)
        return exports['zero_homes']:checkHomePermission(user_id, home)
    end
}

srv.checkPermissions = function(perm, home)
    local source = source
    local user_id = zero.getUserId(source)
    if (user_id) then
        local isHome = (home and 'home' or 'perm')
        return permission[isHome](user_id, perm, home)
    end
end

RegisterServerEvent('zero_doors:open',function(id, autoLock)
	local source = source
	local user_id = zero.getUserId(source)

    setDoorState(id, not Doors[id].lock)
    if autoLock and (not Doors[id].lock) and (not doorTimeouts[id]) then
        doorTimeouts[id] = true
        SetTimeout(autoLock,function()
            if (not Doors[id].lock) then
                setDoorState(id,true)
            end
            doorTimeouts[id] = nil
        end)
    end
end)

setDoorState = function(id, state)
	Doors[id].lock = state
	TriggerClientEvent('zero_doors:statusSend', -1, id, state)
	if (Doors[id].other) then
		TriggerClientEvent('zero_doors:statusSend', -1, id, state)
	end
end