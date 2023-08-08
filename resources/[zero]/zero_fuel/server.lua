local srv = {}
Tunnel.bindInterface('Fuel', srv)

local vehicleGlobal = {}

srv.getVehicleSyncFuel = function(source, vehicle)
    if (vehicleGlobal[vehicle] ~= nil) then
        return vehicleGlobal[vehicle]
    end
    return false
end

srv.syncCombustivel = function(vehicle, newFuel)
    if (newFuel > 100.00) then
        newFuel = 99.99
    end
    vehicleGlobal[vehicle] = newFuel
end

srv.GetUserMoney = function()
    local source = source
    local user_id = zero.getUserId(source)
    if (user_id) then
        return zero.getAllMoney(user_id)
    end
    return 0
end