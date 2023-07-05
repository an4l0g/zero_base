cInventory.openInventory = function(action, chestType, lootId)
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

cInventory.closeInventory = function(data)
    verifyNearest = false
    nearbyVehicle = nil
    if data and data.message then
        config.functions.clientNotify(config.texts.notify_title, data.message, 5000)
    end

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
end
exports('closeInventory', cInventory.closeInventory)