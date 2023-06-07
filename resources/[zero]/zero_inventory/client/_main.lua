vRP = Proxy.getInterface('vRP')

sInventory = Tunnel.getInterface('zero_inventory')

cInventory = {}
Tunnel.bindInterface('zero_inventory', cInventory)

disableActions = false
currentChestType = nil
currentLootId = nil

RegisterKeyMapping("openInventory", "Abrir mochila", 'KEYBOARD', "Oem_3")
RegisterCommand("openInventory", function()
    local playerPed = PlayerPedId()
    if not disableActions and GetEntityHealth(playerPed) > 101 then
        cInventory.openInventory('open', 'ground')
    end
end)

RegisterNetEvent('updateInventory', function()
    cInventory.openInventory('update', currentChestType, currentLootId)
end)

RegisterNuiCallback('closeInventory', function(data)
    verifyNearest = false
    if data.message then
        config.functions.clientNotify('-', config.texts.notify_title, data.message, 5000)
    end
    disableActions = false
    SetNuiFocus(false, false)
    SendNUIMessage({
        action = 'close'
    })

    local ped = PlayerPedId()
    if (pedCache[ped]) then
        sInventory.callBackInteractions(sendersTable[1], sendersTable[2])
        pedCache[ped] = nil
    else
        sInventory.checkAction()
    end
end)

RegisterNetEvent('zero_inventory:enableActions', function()
    disableActions = false
end)

RegisterNetEvent('zero_inventory:disableActions', function()
    disableActions = true
end)

RegisterCommand('cds', function()
    print(GetEntityCoords(PlayerPedId()))
end)