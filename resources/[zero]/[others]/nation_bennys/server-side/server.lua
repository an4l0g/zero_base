srv = {}
Tunnel.bindInterface(GetCurrentResourceName(), srv)
vCLIENT = Tunnel.getInterface(GetCurrentResourceName())

zero._prepare('zero_bennys/setCustom', 'update user_vehicles set custom = @custom where plate = @plate')

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

local webhookTuning = 'https://discord.com/api/webhooks/1146159057774858320/63XRq7UWObN_XwDC3ZR6SGQnVlYYqKKUQrtMIZBe80-5IOqIHB6XIcm688zMWm3DKY9m'
srv.saveVehicle = function(plate, custom)
    local source = source
    local mechanicId = zero.getUserId(source)
    local user_id = zero.getUserByPlate(plate)
    if (user_id and plate and custom) then
        zero.execute('zero_bennys/setCustom', { plate = plate, custom = json.encode(custom) })
        zero.webhook(webhookTuning, '```prolog\n[ZERO BENNYS]\n[ACTION]: (TUNING)\n[MECHANIC]: '..mechanicId..'\n[VEHICLE OWNER]: '..(user_id or 'Não identificado!')..'\n[VEHICLE PLATE]: '..plate..'\n[CUSTOM]: '..json.encode(custom)..os.date('\n[DATA]: %d/%m/%Y [HORA]: %H:%M:%S')..'\r```' )
        return true
    end
    return false
end

srv.givePayment = function(price)
    local source = source
    local user_id = zero.getUserId(source)
    if (user_id) then
        zero.giveBankMoney(user_id, price)
        exports.zero_bank:extrato(user_id, 'Reembolso Bennys', price)
        TriggerClientEvent('notify', source, 'Zero Mecânica', 'Você foi reembolsado num valor de <b>R$'..zero.format(price)..'</b>.')
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

srv.removeVehicle = function(vehicle)
    usingBennys[vehicle] = nil
end

RegisterServerEvent('zero_bennys:syncApplyMods')
AddEventHandler('zero_bennys:syncApplyMods', function(vehicle_tuning, vehicle)
    TriggerClientEvent('zero_bennys:applymods_sync', -1, vehicle_tuning, vehicle)
end)