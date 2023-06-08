webhook = function(link, message)
	if link and message and link ~= "" then
		PerformHttpRequest(link, function(err, text, headers) end, 'POST', json.encode({content = message}), { ['Content-Type'] = 'application/json' })
	end
end

sInventory.getUserId = function()
    local _source = source
    return vRP.getUserId(_source)
end

sInventory.getGloveSize = function(vname)
    return vRP.vehicleGlove(vname)
end

sInventory.getTrunkSize = function(vname)
    return vRP.vehicleChest(vname)
end

sInventory.getVehOwnerId = function(vnetid)
    local data = exports["zGarages"]:getVehicleData(vnetid)
    if data then return data.user_id; end;
end

sInventory.hasPermission = function(permission)
    local _source = source
    local user_id = vRP.getUserId(_source)

    return vRP.hasPermission(user_id, permission)
end