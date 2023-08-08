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

srv.finishFuel = function(veh, atualFuel, newFuel, price)
    local source = source
    local user_id = zero.getUserId(source)
    if (user_id) then
        if (zero.tryFullPayment(user_id, price)) then
            TriggerClientEvent('notify', source, 'Posto de Gasolina', 'Você fez um pagamento de <b>R$'..zero.format(tonumber(price))..'</b>.')
            local nFuel = (atualFuel + newFuel)
            if (nFuel > 99.99) then
                nFuel = 99.99
            end
            vehicleGlobal[veh] = nFuel
            return true
        end
        TriggerClientEvent('notify', source, 'Posto de Gasolina', 'Dinheiro <b>insuficiente</b>.')
        return false
    end
end