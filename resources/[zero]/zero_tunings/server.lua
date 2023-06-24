local srv = {}
Tunnel.bindInterface('Nitro', srv)
local vCLIENT = Tunnel.getInterface('Nitro')

srv.getNitro = function()
    local source = source
    local user_id = zero.getUserId(source)
    if (user_id) then
        if (zero.tryGetInventoryItem(user_id, 'nitro', 1)) then
            return true
        end
        TriggerClientEvent('notify', source, 'Nitro', 'Você não possui <b>nitro</b> em sua mochila.')
        return false
    end
end

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

startInstallNitro = function(source)
    local user_id = zero.getUserId(source)
    if (zero.getInventoryItemAmount(user_id, 'nitro') > 0) then
        vCLIENT.installNitro(source)
        TriggerClientEvent('notify', source, 'Nitro', 'Caso queira <b>cancelar</b> a instalação, pressione <b>F7</b>.', 10000)
    else
        TriggerClientEvent('notify', source, 'Nitro', 'Você não possui <b>nitro</b> em sua mochila.')
    end
end
exports('startInstallNitro', startInstallNitro)