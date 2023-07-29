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
    if not disableActions and GetEntityHealth(playerPed) > 100 then
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
