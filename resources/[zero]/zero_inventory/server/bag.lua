sInventory.getBag = function(bag_type)
    local items = {}    
    items = zero.query('zero_inventory:getBag', { bag_type = bag_type })
    if #items > 0 then
        local currentSlots = json.decode(items[1].slots)
        for i, v in pairs(currentSlots) do
            local currentItem = config.items[v.index]
            currentSlots[i].name = currentItem.name
            currentSlots[i].usable = (currentItem.usable ~= nil)
            currentSlots[i].type = currentItem.type
            currentSlots[i].weight = currentItem.weight
        end
        return currentSlots
    else
        return {}
    end 
end
exports('getBag', sInventory.getBag)

sInventory.getSlotsByBag = function(bag_type)
    return zero.query('zero_inventory:getBag', { bag_type = bag_type })[1].slots or {}
end
exports('getSlotsByBag', sInventory.getSlotsByBag)

sInventory.modifyBag = function(bagType, newBag)
    zero.execute('zero_inventory:updateBagWithoutId', { slots = json.encode(newBag), bag_type = bagType })
end

sInventory.getOwnMaxWeight = function()
    local _source = source
    local user_id = zero.getUserId(_source)
    local weight = sInventory.getInventoryMaxWeight(user_id) 
    if weight ~= nil and weight ~= 0 then
        return weight
    else
        return config.bag_max_weight
    end
end

sInventory.getHotbar = function()
    local _source = source
    local user_id = zero.getUserId(_source)

    return sInventory.getBag('hotbar:'..user_id)
end