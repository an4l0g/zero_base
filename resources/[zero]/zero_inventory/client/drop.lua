droppedItems = {}
nearbyItemsGroups = {}

cInventory.getGroundItems = function()
    local currentItems = {}
    for i,v in pairs(nearbyItemsGroups) do
        local currentItem = v.item
        currentItem.id = v.id
        currentItems[i] = currentItem
        currentItems[i].pos = i - 1
    end
    return currentItems
end


RegisterNetEvent('updateDroppedItems', function(newDroppedItems)
    droppedItems = newDroppedItems
    Wait(200)
    if currentChestType == 'ground' then
        cInventory.openInventory('update', currentChest)
    end
end)

RegisterNuiCallback('dropItem', function(data)
    sInventory.dropItem(data.item, data.pos, data.amount)
    cInventory.animation('pickup_object', 'pickup_low', false)
end)

RegisterNuiCallback('getDroppedItem', function(data)
    sInventory.getDroppedItem(data.id, data.amount)
    cInventory.animation('pickup_object', 'pickup_low', false)
end)