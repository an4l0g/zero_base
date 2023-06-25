nearbyVehicle = nil

cInventory.getChestInfo = function(chestType, lootId)
    local chest = {}
    local chestInfo = split(chestType, ':')
    local prefix = chestInfo[1]
    local prefixVip = chestInfo[2]
    chest.bag_type = chestType
    currentChest = chestType
    if chestType == 'loot' then
        currentLootId = lootId
    end
    chest.drop_type = prefix
    chest.slots = sInventory.getBag(chestType)
    
    if prefix == 'ground' then 
        chest.title = config.texts.ground_title
        chest.slots = cInventory.getGroundItems()
        chest.max_weight = 0
    elseif prefix == 'bag' then
        chest.title = config.texts.survival_title
        chest.max_weight = 0
    elseif prefix == 'glove' then
        local currentVehInfo = split(chestType, ':')
        chest.title = config.texts.gloveTitle
        chest.max_weight = sInventory.getGloveSize(currentVehInfo[2])
        chest.drop_type = 'chest'
    elseif prefix == 'trunk' then
        local currentVehInfo = split(chestType, ':')
        chest.title = config.texts.trunkTitle
        chest.max_weight = sInventory.getTrunkSize(currentVehInfo[2])
        chest.drop_type = 'chest'
    else
        chest.title = config.texts.chest_title
        chest.slots = sInventory.getBag(chestType)

        if prefix == 'priv' then
            chest.max_weight = config.chests['armazem'].weight
            if prefixVip == 'vip' then
                chest.max_weight = config.chests['armazemVip'].weight
            end
        else
            chest.max_weight = config.chests[chestType].weight
        end
        chest.drop_type = 'chest'
    end

    return chest
end


RegisterKeyMapping("openCarChest", "Abrir Porta Malas/Luvas", 'KEYBOARD', "pageup")
RegisterCommand("openCarChest", function()
    if zero.getNearestPlayer(config.marker_dropped_item_distance + 1) ~= nil then
        config.functions.clientNotify(config.texts.notify_title, config.texts.notify_nearest_player, 5000)
        return
    end
    local ped = PlayerPedId() 
    if GetEntityHealth(ped) > 101 and not config.functions.isHandcuffed() and not IsPedBeingStunned(ped) and not IsPlayerFreeAiming(ped) then
        local vehicle,vnetid,placa,vname,lock,banned,trunk  = zero.vehList(5)
        local veh = { isLocked = lock, carName = vname, ownerId = sInventory.getVehOwnerId(vnetid) } 
        if veh.isLocked == 1 then
            if veh.ownerId then
                SetNuiFocus(true, true)
                nearbyVehicle = vehicle
                if IsPedInAnyVehicle(ped) then
                    cInventory.openInventory('open', 'glove:'..veh.carName..':'..veh.ownerId)
                else
                    cInventory.openInventory('open', 'trunk:'..veh.carName..':'..veh.ownerId)
                end
            else
                config.functions.clientNotify(config.texts.notify_title, config.texts.notify_no_register_vehicle, 5000)
            end
        else 
            config.functions.clientNotify(config.texts.notify_title, config.texts.notify_locked_vehicle, 5000)
        end
    end
end)