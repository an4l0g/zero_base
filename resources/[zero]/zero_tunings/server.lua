local vCLIENT = Tunnel.getInterface('Nitro')

startNitro = function()
    local source = source
    vCLIENT.installNitro(source)
end

exports('installNitro', startNitro)

RegisterNetEvent('ND_Nitro:purge', function(status, vehid)
    local source = source
    if (vehid) then
        local veh = NetworkGetEntityFromNetworkId(vehid)
        Entity(veh).state.purge = status
    else
        local ped = GetPlayerPed(source)
        local veh = GetVehiclePedIsIn(ped)
        if (veh) then
            Entity(veh).state.purge = status
        end
    end
end)

RegisterNetEvent('ND_Nitro:flames', function(status, vehid)
    local source = source
    if (vehid) then
        local veh = NetworkGetEntityFromNetworkId(vehid)
        Entity(veh).state.flames = status
    else
        local ped = GetPlayerPed(source)
        local veh = GetVehiclePedIsIn(ped)
        if (veh) then
            Entity(veh).state.flames = status
        end
    end
end)

RegisterCommand('teste', function(source)

    vCLIENT.installNitro(source)
end)