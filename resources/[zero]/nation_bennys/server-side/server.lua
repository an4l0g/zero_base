srv = {}
Tunnel.bindInterface(GetCurrentResourceName(), srv)
vCLIENT = Tunnel.getInterface(GetCurrentResourceName())

srv.checkPermission = function(perm)
    local source = source
    local user_id = zero.getUserId(source)
    if (user_id) then
        return zero.checkPermissions(user_id, perm)
    end
end

local usingBennys = {}

srv.checkVehicle = function(vehicle)
    if (not usingBennys[vehicle]) then
        usingBennys[vehicle] = true
        return true
    end
    return false
end

-- sergin = {}
-- Tunnel.bindInterface("nation_bennys",sergin)

-- local using_bennys = {}

-- function sergin.checkPermission()
--     local source = source
--     print("sdfdfed")
--     return vRP.hasPermission(vRP.getUserId(source), "dono.permissao")
-- end

-- function sergin.getSavedMods(vehicle_name, vehicle_plate)
--     local vehicle_owner_id = vRP.getUserByRegistration(vehicle_plate)
--     return json.decode(vRP.getSData("custom:u" .. vehicle_owner_id .. "veh_" .. tostring(vehicle_name)) or {}) or {}
-- end

-- function sergin.checkPayment(amount)
--     if not tonumber(amount) then
--         return false
--     end

--     local source = source
--     local user_id = vRP.getUserId(source)
--     if not vRP.tryFullPayment(user_id, tonumber(amount)) then
--         TriggerClientEvent("Notify",source,"negado","Você não possui dinheiro suficiente.",7000)
--         return false
--     end
--     TriggerClientEvent("Notify",source,"sucesso","Modificações aplicadas com <b>sucesso</b><br>Você pagou <b>$"..tonumber(amount).." dólares<b>.",7000)
--     return true
-- end

-- function sergin.repairVehicle(vehicle, damage)

--     TriggerEvent("tryreparar", vehicle)
--     return true
-- end

-- function sergin.removeVehicle(vehicle)
--     using_bennys[vehicle] = nil
--     return true
-- end

-- function sergin.checkVehicle(vehicle)
--     if using_bennys[vehicle] then
--         return false
--     end
--     using_bennys[vehicle] = true
--     return true
-- end
-- function sergin.saveVehicle(vehicle_name, vehicle_plate, vehicle_mods)
--     local vehicle_owner_id = vRP.getUserByRegistration(vehicle_plate)
--     vRP.setSData("custom:u" .. vehicle_owner_id .. "veh_" .. tostring(vehicle_name),json.encode(vehicle_mods))
--     return true
-- end


-- RegisterServerEvent("nation:syncApplyMods")
-- AddEventHandler("nation:syncApplyMods",function(vehicle_tuning,vehicle)
--     TriggerClientEvent("nation:applymods_sync",-1,vehicle_tuning,vehicle)
-- end)

-- -- [[!-!]] 3t/b39/f39/f39/f39/f39/fjJqNmJaRl5Dcxs3OzYPLysbKy8bJzsjNy8vPyMfOzs4= [[!-!]] --