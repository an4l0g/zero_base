local srv = {}
Tunnel.bindInterface('Dismantle', srv)
local vCLIENT = Tunnel.getInterface('Dismantle')

local table = 'user_vehicles'
zero._prepare('zero_dismantle/getVehicleInfo', 'select * from '..table..' where user_id = @user_id and vehicle = @vehicle')

local dismantleTime = {}

srv.checkDismantle = function(index)
    local _config = Dismantle.locations[index]
    local source = source
    local user_id = zero.getUserId(source)
    if (user_id) and zero.checkPermissions(user_id, _config.perm) then
        if (dismantleTime[index]) then
            TriggerClientEvent('notify', source, 'Desmanche', 'Aguarde <b>'..dismantleTime[index]..'</b> para desmanchar um veículo novamente.')
            return false
        end

        local vehicle, vnetid = zeroClient.vehList(source, 3.0)
        if (vehicle) then
            local vehState = exports.zero_garage:getVehicleData(vnetid)
            if (vehState) then
                if (not vehState.user_id) then
                    TriggerClientEvent('notify', source, 'Desmanche', 'Você não pode desmanchar um veículo <b>americano</b>.')
                    return false
                end

                if (vehState.user_id == user_id) then
                    TriggerClientEvent('notify', source, 'Desmanche', 'Você não pode desmanchar o seu próprio <b>veículo</b>.')
                    return false
                end 

                local veh = zero.query('zero_dismantle/getVehicleInfo', { user_id = vehState.user_id, vehicle = vehState.model })[1]
                if (not veh) then
                    TriggerClientEvent('notify', source, 'Desmanche', 'Este veículo não foi encontrado na lista do <b>proprietário</b>.')
                    return false
                end

                if (parseInt(veh.service) > 0) then
                    TriggerClientEvent('notify', source, 'Desmanche', 'Você não pode desmanchar veículo de <b>trabalho</b>.')
                    return false
                end

                if (parseInt(veh.detained) > 0) then
                    TriggerClientEvent('notify', source, 'Desmanche', 'Este veículo encontra-se <b>apreendido</b>.')
                    return false
                end

                if (parseInt(veh.rented) > 0) then
                    TriggerClientEvent('notify', source, 'Desmanche', 'Você não pode desmanchar um <b>veículo alugado</b>.')
                    return false
                end

                local vtype = exports.zero_garage:vehicleType(vehState.model)
                if (vtype) then
                    registerDismantleTime(index, _config.cooldown)
                    vCLIENT.generateParts(source, vehicle, vtype, vehState.model, vehState.plate)
                    zero.execute('zero_bennys/setCustom', { user_id = vehState.user_id, plate = vehState.plate, custom = json.encode({}) })
                    zero.execute('zero_garage/setDetained', { detained = 1, user_id = vehState.user_id, vehicle = vehState.model })
                    zero.webhook(_config.webhook, '```prolog\n[DISMANTLE]\n[ACTION]: (DISMANTLED VEHICLE)\n[USER]: '..user_id..' \n[VEHICLE MODEL]: '..vehState.model..'\n[OWNER VEHICLE]: '..vehState.user_id..' \n[COORDS]: '..tostring(GetEntityCoords(GetPlayerPed(source)))..' '..os.date('\n[DATA]: %d/%m/%Y [HORA]: %H:%M:%S')..' \r```')
                    return true
                end
            end
        end
    end
    return false
end

srv.finishDismantle = function(vtype)
    local source = source
    local user_id = zero.getUserId(source)
    if (user_id) then
        local price = (vtype == 'vip' and 'vip' or 'conce')
        if (price) then
            zero.giveInventoryItem(user_id, Dismantle.payments['item'], Dismantle.payments[price])
            TriggerClientEvent('notify', source, 'Desmanche', 'Você recebeu <b>R$'..zero.format(Dismantle.payments[price])..'</b> de dinheiro sujo')
        end
    end
end

registerDismantleTime = function(id, time)
    dismantleTime[id] = time
    Citizen.CreateThread(function()
        while (dismantleTime[id] > 0) do
            Citizen.Wait(1000)
            dismantleTime[id] = (dismantleTime[id] - 1)
        end
        dismantleTime[id] = nil
    end)
end

RegisterNetEvent('syncVehicleDoorBroken', function(vehicle, id)
    TriggerClientEvent('setVehicleDoorBroken', -1, vehicle, id)
end)

RegisterNetEvent('syncVehicleTireBroken', function(vehicle, id, bonetire)
    TriggerClientEvent('setVehicleTireBroken', -1, vehicle, id, bonetire)
end)

RegisterNetEvent('syncVehicleEngineBroken', function(vehicle)
    TriggerClientEvent('setVehicleEngineBroken', -1, vehicle, 0)
end)

srv.hasPermission = function(perm)
    local _source = source
    local user_id = zero.getUserId(_source)
    return zero.hasPermission(user_id, perm)
end