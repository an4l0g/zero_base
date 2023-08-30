sInventory.getUserId = function()
    local _source = source
    return zero.getUserId(_source)
end

sInventory.getGloveSize = function(vname)
    return zero.vehicleGlove(vname)
end

sInventory.getTrunkSize = function(vname)
    return zero.vehicleChest(vname)
end

zero._prepare('zero_homes/getVault', 'select configs from homes where home = @home')

sInventory.getVaultSize = function(hname)
    local query = zero.query('zero_homes/getVault', { home = hname })[1].configs
    if (query) then
        query = json.decode(query)
        return query.chest
    end
end

sInventory.getVehOwnerId = function(vnetid)
    local data = exports["zero_garage"]:getVehicleData(vnetid)
    if data then return data.user_id; end;
end

local permission = {
    ['perm'] = function(user_id, perm, home)
        return zero.checkPermissions(user_id, perm)
    end,
    ['home'] = function(user_id, perm, home)
        return exports['zero_homes']:checkHomePermission(user_id, home)
    end
}

sInventory.hasPermission = function(perm, home)
    local source = source
    local user_id = zero.getUserId(source)
    if (user_id) then
        local isHome = (home and 'home' or 'perm')
        return permission[isHome](user_id, perm, home)
    end
end

sInventory.extract = function(string, method)
    if method == 'pre' then 
        return string:match("(.*):")
    else 
        return string:match(":(.*)")
    end
end