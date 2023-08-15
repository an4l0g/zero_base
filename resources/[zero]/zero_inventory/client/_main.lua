zero = Proxy.getInterface('zero')

cInventory = {}
Tunnel.bindInterface('zero_inventory', cInventory)
sInventory = Tunnel.getInterface('zero_inventory')

disableActions = false
currentChestType = nil
currentLootId = nil

RegisterKeyMapping("openInventory", "Abrir inventario", 'KEYBOARD', "Oem_3")
RegisterCommand("openInventory", function()
    local playerPed = PlayerPedId()
    if (not disableActions and GetEntityHealth(playerPed) > 100 and not LocalPlayer.state.BlockTasks and not LocalPlayer.state.Handcuff) then
        disableActions = true
        cInventory.openInventory('open', 'ground')
    end
end)

RegisterNetEvent('updateInventory', function()
    cInventory.openInventory('update', currentChestType, currentLootId)
end)

RegisterNuiCallback('closeInventory', function(data)
    disableActions = false
    cInventory.closeInventory(data)
end)

RegisterNetEvent('zero_inventory:enableActions', function()
    disableActions = false
end)

RegisterNetEvent('zero_inventory:disableActions', function()
    disableActions = true
end)




local coordenadas = {
    vector3(-1269.666, -1913.934, 5.858643),
    vector3(-1811.156, -1225.569, 13.01978),
    vector3(-1453.306, 417.2703, 109.8557),
    vector3(190.0088, 309.1516, 105.3737),
    vector3(-740.9275, 5571.93, 36.69373),
    vector3(1154.532, -785.3538, 57.58752),
    vector3(869.7231, -2326.932, 30.59412),
    vector3(-517.4374, -2904.277, 5.993408),
    vector3(-1079.143, -2726.202, 14.38464),
    vector3(-546.0527, -873.5472, 27.19043),
    vector3(313.5428, -174.5275, 58.10986),
    vector3(-85.7934, 357.1121, 112.4337),
    vector3(-1649.604, 248.7692, 62.38977),
    vector3(-191.3802, -1179.02, 23.06226),
}

Citizen.CreateThread(function()
    for _, coord in pairs(coordenadas) do
        local blip = AddBlipForCoord(coord.x, coord.y, coord.z)

        SetBlipSprite(blip, 1) -- Configurar o ícone, substitua 1 pelo ID do ícone desejado
        SetBlipDisplay(blip, 4)
        SetBlipScale(blip, 0.5) -- Configurar o tamanho
        SetBlipColour(blip, 2) -- Configurar a cor
        SetBlipAsShortRange(blip, true)

        BeginTextCommandSetBlipName("STRING")
        AddTextComponentString("Nome do Blip") -- Configurar o nome do blip
        EndTextCommandSetBlipName(blip)
    end
end)