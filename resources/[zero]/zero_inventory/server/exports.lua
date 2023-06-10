sInventory.giveBagItem = function(bagType, item, amount)
    local _source = source
    item = string.lower(item)
    if config.items[item] then
        local slots = nil
        local items = zero.query('zero_inventory:getBag', { bag_type = bagType })
        if #items > 0 then slots = json.decode(items[1].slots) end
        local updatedSlots = {}

        if slots ~= nil then
            local currentPos = sInventory.hasItem(slots, item)
            if currentPos ~= nil then 
                updatedSlots = sInventory.addAmount(slots, currentPos, amount)
            else
                local max_slots = nil
                if split(bagType, ':')[1] == 'hotbar' then
                    max_slots = config.max_slots_hotbar
                else 
                    max_slots = config.max_slots
                end
                local result = sInventory.addNewItem(slots, max_slots, item, amount)
                if result ~= nil then
                    updatedSlots = result
                else
                    config.functions.serverNotify(_source, config.texts.notify_title, config.texts.notify_full_bag_error)
                end
            end
            if updatedSlots then
                sInventory.modifyBag(bagType, updatedSlots)
                return true
            end
        else
            updatedSlots[0] = { index = item, amount = amount }
            zero.execute('zero_inventory:insertBag', { slots = json.encode(updatedSlots), bag_type = bagType, weight = 0 })
            return true
        end
    else
        config.functions.serverNotify(_source, config.texts.notify_title, config.texts.notify_non_existent_item)
    end
end
exports("giveBagItem", sInventory.giveBagItem)

local tasking = {}

sInventory.giveInventoryItem = function(user_id, item, amount)
    local _source = source
    if user_id == 0 then
        user_id = zero.getUserId(_source)
    end

    while tasking[user_id] do
        Wait(10)
    end
    tasking[user_id] = true

    local ok, fail = pcall(function()       
        item = string.lower(item)
        if config.items[item] then
            local slots = nil
            local items = zero.query('zero_inventory:getBag', { bag_type = 'bag:'..user_id })
            if #items > 0 then slots = json.decode(items[1].slots) end
            local updatedSlots = {}
            
            if slots ~= nil then
                local currentPos = sInventory.hasItem(slots, item)
                if currentPos ~= nil then 
                    updatedSlots = sInventory.addAmount(slots, currentPos, amount)
                else
                    local result = sInventory.addNewItem(slots, config.max_slots, item, amount)
                    if result ~= nil then
                        updatedSlots = result
                    else
                        config.functions.serverNotify(_source, config.texts.notify_title, config.texts.notify_full_bag_error)
                    end
                end
                sInventory.modifyBag('bag:'..user_id, updatedSlots)
            else
                updatedSlots[0] = { index = item, amount = amount }
                zero.execute('zero_inventory:insertBag', { slots = json.encode(updatedSlots), bag_type = 'bag:'..user_id, weight = config.bag_max_weight })
            end
        else
            config.functions.serverNotify(_source, config.texts.notify_title, config.texts.notify_non_existent_item)
        end
    end)
    if (not ok) then
        print(fail)
    end
    tasking[user_id] = nil
end
exports("giveInventoryItem", sInventory.giveInventoryItem)

sInventory.tryGetInventoryItem = function(user_id, index, amount)
    index = string.lower(index)
    
    local items = zero.query('zero_inventory:getBag', { bag_type = 'bag:'..user_id })
    local hotbarItems = zero.query('zero_inventory:getBag', { bag_type = 'hotbar:'..user_id })
    local slots = {}
    local hotbarSlots = {}
    if #items > 0 then slots = json.decode(items[1].slots) end
    if #hotbarItems > 0 then hotbarSlots = json.decode(hotbarItems[1].slots) end
    local isRemovedItem = false

    for k,v in pairs(slots) do
        if v.index == index and tonumber(v.amount) >= tonumber(amount) then
            local currentAmount = tonumber(v.amount) - tonumber(amount)
            if currentAmount > 0 then
                slots[tostring(k)].amount = currentAmount
            else 
                slots[tostring(k)] = nil
            end
            isRemovedItem = true
            break;
        end
    end

    if not isRemovedItem then
        for k,v in sPairs(hotbarSlots) do
            if v.index == index and tonumber(v.amount) >= tonumber(amount) then
                local currentAmount = tonumber(v.amount) - tonumber(amount)
                if currentAmount > 0 then
                    hotbarSlots[tostring(k)].amount = currentAmount
                else 
                    hotbarSlots[tostring(k)] = nil
                end
                isRemovedItem = true
                break;
            end
        end
    end

    zero.execute('zero_inventory:updateBag', { slots = json.encode(slots), bag_type = 'bag:'..user_id })
    zero.execute('zero_inventory:updateBag', { slots = json.encode(hotbarSlots), bag_type = 'hotbar:'..user_id })
    return isRemovedItem;
end
exports("tryGetInventoryItem", sInventory.tryGetInventoryItem)

sInventory.getInventoryItemAmount = function(user_id, index)
    local bag = sInventory.getBag('bag:'..user_id)
    local amount = 0

    for k,v in sPairs(bag) do
        if v.index == index then
            amount = amount + v.amount
        end
    end

    return amount
end
exports('getInventoryItemAmount', sInventory.getInventoryItemAmount)

sInventory.getInventory = function(user_id)
    local bag = sInventory.getBag('bag:'..user_id)
    local hotbar = sInventory.getBag('hotbar:'..user_id)
    local playerBag = {}

    for k,v in sPairs(bag) do
        table.insert(playerBag, v)
    end 

    for k,v in sPairs(hotbar) do
        table.insert(playerBag, v)
    end 

    return playerBag
end
exports('getInventory', sInventory.getInventory)

sInventory.getInventoryWeight = function(user_id)
    local bag = zero.query('zero_inventory:getBag', { bag_type = 'bag:'..user_id })[1]
    local hotbar = zero.query('zero_inventory:getBag', { bag_type = 'hotbar:'..user_id })[1]

    local totalWeight = 0
    
    for k,v in sPairs(json.decode(bag.slots)) do
        local cItem = config.items[v.index]
        totalWeight = totalWeight + (cItem.weight * v.amount)
    end 

    for k,v in sPairs(json.decode(hotbar.slots)) do
        local cItem = config.items[v.index]
        totalWeight = totalWeight + (cItem.weight * v.amount)
    end 

    return totalWeight
end
exports('getInventoryWeight', sInventory.getInventoryWeight)

sInventory.getInventoryMaxWeight = function(user_id)
    local bag = zero.query('zero_inventory:getBag', { bag_type = 'bag:'..user_id })[1] or { weight = config.bag_max_weight }
    return bag.weight
end
exports('getInventoryMaxWeight', sInventory.getInventoryMaxWeight)

sInventory.setInventoryMaxWeight = function(user_id, weight)
    zero.query('zero_inventory:updateBagWeight', { weight = weight, bag_type = 'bag:'..user_id })
end
exports('setInventoryMaxWeight', sInventory.setInventoryMaxWeight)

sInventory.clearInventory = function(user_id)
    local _source = zero.getUserSource(user_id)
    cInventory.unequipAllWeapons(_source)

    zero.execute('zero_inventory:deleteBag', { bag_type = 'bag:'..user_id })
    zero.execute('zero_inventory:deleteBag', { bag_type = 'hotbar:'..user_id })
    config.functions.serverNotify(source, config.texts.notify_title, config.texts.notify_success_delete_bag('USER_'..user_id))
end
exports('clearInventory', sInventory.clearInventory)

sInventory.tryAddInventoryItem = function(user_id, index, amount)
    local slots = nil
    local items = zero.query('zero_inventory:getBag', { bag_type = 'bag:'..user_id })
    if #items > 0 then slots = json.decode(items[1].slots) end

    local totalWeight = 0

    for k,v in sPairs(slots) do
        local cItem = config.items[v.index]
        totalWeight = totalWeight + (cItem.weight * v.amount)
    end 
    
    local currentItem = config.items[index]
    totalWeight = totalWeight + (currentItem.weight * amount)

    if items[1].weight >= totalWeight then
        sInventory.giveBagItem('bag:'..user_id, index, amount)
        return true
    else 
        return false
    end
end
exports('tryAddInventoryItem', sInventory.tryAddInventoryItem)

sInventory.getFullInventory = function(user_id)
    local bag = sInventory.getSlotsByBag('bag:'..user_id)
    local hotbar = sInventory.getSlotsByBag('hotbar:'..user_id)
    local playerBag = {}

    for k,v in sPairs(bag) do
        table.insert(playerBag, v)
    end 

    for k,v in sPairs(hotbar) do
        table.insert(playerBag, v)
    end 

    return playerBag
end
exports('getFullInventory', sInventory.getFullInventory)

sInventory.getItemInfo = function(index)
    return config.items[index]
end
exports('getItemInfo', sInventory.getItemInfo)

sInventory.getFuel = function(pid)
    local source = source
    if (not recent_pumps[pid]) then
        local user_id = zero.getUserId(source)
        if zero.getInventoryItemAmount(user_id, "mangueira") > 0 and zero.getInventoryItemAmount(user_id, "garrafa-vazia") > 0 then
            
            recent_pumps[pid] = true
            SetTimeout(30*60000,function() recent_pumps[pid] = nil; end)

            TriggerClientEvent('progress', source, 10000, 'Coletando combustível...')
            vRPclient._playAnim(source, false, {'amb@prop_human_parking_meter@female@idle_a', 'idle_a_female'}, true)
            SetTimeout(
                10000,
                function()
                    local randomFuel = math.random(1,100)
                    local randomHose = math.random(1,3)
                    if randomHose == 1 then 
                        zero.tryGetInventoryItem(user_id, "mangueira", 1)
                        TriggerClientEvent('Notify',source,"Inventário", 'Inventário','Sua mangueira furou e foi descartada!', 5000)
                    end
                    if randomFuel <= 20 then 
                        zero.tryGetInventoryItem(user_id, "garrafa-vazia", 1)
                        zero.giveInventoryItem(user_id, "wammo|WEAPON_PETROLCAN", 2250)
                        TriggerClientEvent('Notify',source,"Inventário", 'Inventário','Você encontrou uma quantidade satisfatória de combustível!', 5000)
                    else
                        TriggerClientEvent('Notify',source,"Inventário", 'Inventário','Nenhum combustível foi encontrado!', 5000)
                    end
                    vRPclient._stopAnim(source,false)
                end
            )
        else
            TriggerClientEvent('Notify',source,"Inventário",'Inventário','Você precisa de uma mangueira e uma garrafa vazia para coletar combustível!', 5000)
        end
    else
        TriggerClientEvent('Notify',source,"Inventário",'Inventário','Esta bomba está vazia!', 5000)
    end
end
exports('getFuel', sInventory.getFuel)