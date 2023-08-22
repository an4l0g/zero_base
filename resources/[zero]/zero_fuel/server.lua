local srv = {}
Tunnel.bindInterface('Fuel', srv)

local vehicleGlobal = {}

srv.getVehicleSyncFuel = function(vehicle)
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

RegisterCommand('addfuel', function(source, args)
    local source = source
    local user_id = zero.getUserId(source)
    if (user_id) and zero.hasPermission(user_id, '+Staff.COO') then 
        local dataVehicle, dataVnetId, dataVPlaca, dataVName = zeroClient.vehList(source, 5)
        if (dataVehicle) then 
            local fuel = 20.00
            if (args[1]) then 
                fuel = args[1] + 0.000000001
            else 
                fuel = 99.99
            end

            vehicleGlobal[dataVnetId] = fuel
            TriggerClientEvent('notify', source, 'Combustível', 'Valor do <b>combustível</b> foi alterado!')
        else 
            TriggerClientEvent('notify', source, 'Combustível', 'O veículo não foi <b>localizado</b>!')
        end
    end
end)