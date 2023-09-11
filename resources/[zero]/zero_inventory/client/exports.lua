cInventory.openInventory = function(action, chestType, disabledBag)
    local ped = PlayerPedId() 

    local playerBagType = 'bag:'..sInventory.getUserId()
    local playerHotbarType = 'hotbar:'..sInventory.getUserId()

    local player = sInventory.getBag(playerBagType)
    local hotbar = sInventory.getBag(playerHotbarType)
    local chest = cInventory.getChestInfo(chestType, nil)

    if action == 'open' then
        SetNuiFocus(true,true)
    end

    if disabledBag then 
        SendNUIMessage({
            action = action, 
            item_types = config.itemTypes,
            weapons = cInventory.getWeaponsBag(),
            bag = { slots = player, max_weight = 0, title = 'Mochila', bag_type = playerBagType, drop_type = 'bag' },
            hotbar = { slots = hotbar, bag_type = playerHotbarType, drop_type = 'hotbar' },
            chest = chest,
        })
    else 
        SendNUIMessage({
            action = action, 
            item_types = config.itemTypes,
            weapons = cInventory.getWeaponsBag(),
            bag = { slots = player, max_weight = sInventory.getOwnMaxWeight(), title = 'Mochila', bag_type = playerBagType, drop_type = 'bag' },
            hotbar = { slots = hotbar, bag_type = playerHotbarType, drop_type = 'hotbar' },
            chest = chest,
        })
    end
    
end
exports('openInventory', cInventory.openInventory)

cInventory.closeInventory = function(data)
    disableActions = false
    verifyNearest = false
    nearbyVehicle = nil
    if data and data.message then
        config.functions.clientNotify(config.texts.notify_title, data.message, 5000)
    end

    SetNuiFocus(false, false)
    SendNUIMessage({
        action = 'close'
    })

    if (LocalPlayer.state.Revistar) then TriggerServerEvent('zero_inventory:closeRevistar'); end;
    if (LocalPlayer.state.Saquear) then TriggerServerEvent('zero_inventory:closeSaquear'); end;
end
exports('closeInventory', cInventory.closeInventory)

cInventory.GetVehicleClass = function(vehicle)
    return GetVehicleClass(vehicle)
end