checkActions = function()
    return disableActions
end

exports('checkActions', checkActions)

cInventory.openInventory = function(action, chestType, lootId)
    disableActions = true
    local ped = PlayerPedId() 

    local playerBagType = 'bag:'..sInventory.getUserId()
    local playerHotbarType = 'hotbar:'..sInventory.getUserId()

    local player = sInventory.getBag(playerBagType)
    local hotbar = sInventory.getBag(playerHotbarType)

    currentChestType = chestType
    local chest = cInventory.getChestInfo(chestType, lootId)

    if action == 'open' then
        SetNuiFocus(true,true)
    end
    SendNUIMessage({
        action = action, 
        item_types = config.itemTypes,
        weapons = cInventory.getWeaponsBag(),
        bag = { slots = player, max_weight = sInventory.getOwnMaxWeight(), title = 'Mochila', bag_type = playerBagType, drop_type = 'bag' },
        hotbar = { slots = hotbar, bag_type = playerHotbarType, drop_type = 'hotbar' },
        chest = chest,
    })
    
end
exports('openInventory', cInventory.openInventory)

cInventory.closeInventory = function()
    verifyNearest = false
    disableActions = false
    SendNUIMessage({ action = 'close' })
    SetNuiFocus(false, false)
    FreezeEntityPosition(PlayerPedId(), false)

    local ped = PlayerPedId()
    if (pedCache[ped]) then
        sInventory.callBackInteractions(pedCache[ped].receiveRequest, pedCache[ped].sendRequest)
        pedCache[ped] = nil
    else
        sInventory.checkAction()
    end
end
exports('closeInventory', cInventory.closeInventory)