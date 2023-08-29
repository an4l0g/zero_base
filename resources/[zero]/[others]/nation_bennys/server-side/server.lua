srv = {}
Tunnel.bindInterface(GetCurrentResourceName(), srv)
vCLIENT = Tunnel.getInterface(GetCurrentResourceName())

zero._prepare('zero_bennys/setCustom', 'update user_vehicles set custom = @custom where user_id = @user_id and plate = @plate')

srv.checkPermission = function(perm)
    local source = source
    local user_id = zero.getUserId(source)
    if (user_id) then
        return zero.hasPermission(user_id, perm)
    end
end

srv.checkPayment = function(value)
    local source = source
    local user_id = zero.getUserId(source)
    if (user_id) then
        if (zero.tryFullPayment(user_id, value)) then
            exports.zero_bank:extrato(user_id, 'Bennys', -value)
            return true
        end
        TriggerClientEvent('notify', source, 'Zero Mecânica', 'Você não possui <b>dinheiro</b> o suficiente para pagar esta tunagem.')
        return false
    end
end

srv.saveVehicle = function(plate, custom)
    local user_id = zero.getUserByPlate(plate)
    if (user_id and plate and custom) then
        print('^5[Zero Bennys]^7 salvou o tuning do id '..user_id..' placa '..plate)
        zero.execute('zero_bennys/setCustom', { user_id = user_id, plate = plate, custom = json.encode(custom) })
        return true
    end
    return false
end

local usingBennys = {}

srv.checkVehicle = function(vehicle)
    if (not usingBennys[vehicle]) then
        usingBennys[vehicle] = true
        return true
    end
    return false
end

srv.removeVehicle = function(vehicle)
    usingBennys[vehicle] = nil
end

RegisterServerEvent('zero_bennys:syncApplyMods')
AddEventHandler('zero_bennys:syncApplyMods', function(vehicle_tuning, vehicle)
    TriggerClientEvent('zero_bennys:applymods_sync', -1, vehicle_tuning, vehicle)
end)