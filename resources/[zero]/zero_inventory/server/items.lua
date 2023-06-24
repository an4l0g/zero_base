
-- Adiciona um novo item na bag na primeira posição disponível
-- -- Se houver posição disponível, retorna a bag atualizada
-- -- Se não houver posição disponível, retorna nil
sInventory.addNewItem = function(slots, max_slots, item, amount)
    
    local updatedSlots = slots
    local createdItem = false 
    for i=0,tonumber(max_slots - 1) do
        local usedPos = false
        if slots[tostring(i)] then
            usedPos = true
        end
        if not usedPos then
            updatedSlots[i] = { index = item, amount = amount }
            createdItem = true
            break;
        end
    end

    if not createdItem then
        return false
    end

    return updatedSlots
end

-- Verifica se já existe um item em uma bag
-- -- Se já existir, ele retorna a posição
-- -- Se não existir, ele retorna nil
sInventory.hasItem = function(slots, item)
    local currentPos = nil
    for i,v in pairs(slots) do
        if v.index == item then
            currentPos = i
        end
    end
    
    return currentPos 
end

-- Adicionar um item que já existe em uma bag
sInventory.addAmount = function(slots, pos, amount)
    local updatedSlots = slots 
    local cItem = updatedSlots[pos]
    updatedSlots[pos] = {
        index = cItem.index,
        amount = cItem.amount + amount
    }

    return updatedSlots
end

sInventory.sendItem = function(user_source, index, amount)
    local _source = source
    local id = zero.getUserId(_source)
    local user_id = zero.getUserId(user_source)

    
    if sInventory.tryGetInventoryItem(id, index, amount) then
        if sInventory.tryAddInventoryItem(user_id, index, amount) then
            cInventory.animation(_source, 'mp_common', 'givetake1_a', false)
            cInventory.animation(user_source, 'mp_common', 'givetake1_a', false)
            config.functions.serverNotify(_source, config.texts.notify_title, config.texts.notify_send_item(amount, config.items[index].name))
            config.functions.serverNotify(user_source, config.texts.notify_title, config.texts.notify_receive_item(amount, config.items[index].name))
        else
            sInventory.giveBagItem('bag:'..id, index, amount)
            config.functions.serverNotify(_source, config.texts.notify_title, config.texts.notify_player_no_weight)
        end
    else
        config.functions.serverNotify(_source, config.texts.notify_title, config.texts.notify_player_no_item)
    end
    TriggerClientEvent('inventory:close', _source)
end

sInventory.useItem = function(index, amount)
    local _source = source
    local user_id = zero.getUserId(_source)
    local item = config.items[index]

    zero.formatWebhook(url, 'Utilizar Item', {
        { 'Id', user_id },
        { 'item', index },
        { 'Qtd', amount or '1' },
    })

    webhook(config.webhooks.useItems, '```prolog\n[Utilizar Item]\n[ID]: '..user_id..'\n[Item]: '..(index or 'ND')..'\n[Qtd]: '..(amount or '1')..'```')

    if item.consumable then
        consumableItem(index)
    end

    if item.drug then
        healing(index)
    end

    if item.interaction then
        item.interaction(_source, user_id)
    end

    if item.type == 'weapon' or item.type == 'wammo' then
        local weapons = zeroClient.getWeapons(_source)

        if item.type == 'weapon' then
            if weapons[string.upper(index)] == nil then
                if zero.tryGetInventoryItem(user_id, index, 1) then
                    zeroClient.giveWeapons(_source, {[index] = { ammo = ammo }}, false, GlobalState.weaponToken)
                    config.functions.serverNotify(_source, config.texts.notify_title, config.texts.notify_equip_weapon(zero.itemNameList(index)), 5000)
                else 
                    config.functions.serverNotify(_source, config.texts.notify_title, config.texts.notify_non_existent_item, 5000)
                end
            else
                config.functions.serverNotify(_source, config.texts.notify_title, config.texts.notify_weapon_already_equiped, 5000)
            end
        end
        
        if item.type == 'wammo' then
            local newIndex = string.gsub(index, 'm_', '')
            local currentWeapon = weapons[string.upper(newIndex)]
            
            if currentWeapon ~= nil then
                local customTotalAmmo = 250
                if newIndex == 'weapon_petrolcan' then
                    customTotalAmmo = 4000
                end
                local freeAmmo = customTotalAmmo - tonumber(currentWeapon.ammo)
                local currentAmmo = 0
                
                if tonumber(freeAmmo) >= tonumber(amount) then
                    currentAmmo = amount
                else
                    currentAmmo = freeAmmo
                end
                if zero.tryGetInventoryItem(user_id, index, currentAmmo) then
                    cInventory.addAmmo(_source, newIndex, currentAmmo)
                    config.functions.serverNotify(_source, config.texts.notify_title, config.texts.notify_equip_weapon(zero.itemNameList(index)), 5000)
                else
                    config.functions.serverNotify(_source, config.texts.notify_title, config.texts.notify_non_existent_item, 5000)
                end
            else
                config.functions.serverNotify(_source, config.texts.notify_title, config.texts.notify_no_weapon_ammo, 5000)
            end
        end
    end

    cInventory.closeInventory(_source)
end

-- se o slot estiver vazio na mesma mochila, apenas mostrar modal
-- se o slot estiver cheio na mesma mochila, apenas trocar de lugar
-- mochilas diferentes, mostrar modal
-- se os itens forem iguais, apenas somar as quantidades mostrando modal
sInventory.validateItem = function(slots, item, pos)
    local isValidated = false
    local checkPos = false
    local currentItem = slots[tostring(pos)]

    if currentItem ~= nil then
        if item.index and currentItem.index == item.index then
            checkPos = true
            if currentItem.amount == item.amount then
                isValidated = true
            end
        end
    end
    if not item.index and not checkPos then
        isValidated = true
    end

    return isValidated
end

sInventory.changeItemPosition = function(cItem, cPos, nItem, nPos, amount)
    local _source = source
    local cSlots = sInventory.getBag(cItem.bagType)
    
    if not sInventory.validateItem(cSlots, cItem, cPos) then 
        config.functions.serverNotify(_source, config.texts.notify_title, config.texts.notify_non_existent_item, 5000)
        cInventory.closeInventory(_source)
    end
    if cItem.bagType == nItem.bagType then
        if not sInventory.validateItem(cSlots, nItem, nPos) then 
            config.functions.serverNotify(_source, config.texts.notify_title, config.texts.notify_non_existent_item, 5000)
            cInventory.closeInventory(_source)
        end
        
        if cItem.index == nItem.index then
            if tonumber(cItem.amount) == tonumber(amount) then
                cSlots[tostring(nPos)].amount = nItem.amount + amount
                cSlots[tostring(cPos)] = nil
            else
                cSlots[tostring(cPos)].amount = cItem.amount - amount
                cSlots[tostring(nPos)].amount = nItem.amount + amount
            end
        else
            if not nItem.index then 
                if tonumber(cItem.amount) == tonumber(amount) then
                    cSlots[tostring(cPos)] = nil
                    cSlots[tostring(nPos)] = cItem
                else
                    cSlots[tostring(cPos)].amount = cItem.amount - amount
                    local newItem = cItem
                    newItem.amount = amount
                    cSlots[tostring(nPos)] = newItem
                end
            else 
                cSlots[tostring(cPos)] = nItem
                cSlots[tostring(nPos)] = cItem 
            end
        end
    else
        nSlots = sInventory.getBag(nItem.bagType)
        
        if not sInventory.validateItem(nSlots, nItem, nPos) then 
            config.functions.serverNotify(_source, config.texts.notify_title, config.texts.notify_non_existent_item, 5000)
            cInventory.closeInventory(_source)
            return 
        end
        
        local max_slots = 0
        
        if tonumber(cItem.amount) == tonumber(amount) then 
            local result = sInventory.giveBagItem(nItem.bagType, cItem.index, amount)
            if result then
                cSlots[tostring(cPos)] = nil
            else
                config.functions.serverNotify(_source, config.texts.notify_title, config.texts.no_space, 5000)
                cInventory.closeInventory(_source)
                return
            end
        else
            local result = sInventory.giveBagItem(nItem.bagType, cItem.index, amount)
            if result then 
                cSlots[tostring(cPos)].amount = cItem.amount - amount
            else
                config.functions.serverNotify(_source, config.texts.notify_title, config.texts.no_space, 5000)
                cInventory.closeInventory(_source)
                return
            end
        end
    end
    
    sInventory.modifyBag(cItem.bagType, cSlots)
    itemsMoveLog(cItem, nItem, amount)
    TriggerClientEvent('updateInventory', _source)
end

itemsMoveLog = function(cItem, nItem, amount)
    local url = nil
    local title = 'Movimentar Itens'
    if config.chests[cItem.bagType] ~= nil then
        url = config.chests[cItem.bagType].log
        title = 'Retirar Item'
    elseif config.chests[nItem.bagType] ~= nil then 
        url = config.chests[nItem.bagType].log
        title = 'Colocar Item'
    else
        url = config.webhooks.moveItem
    end
    zero.formatWebhook(url, title, {
        { 'De', (sInventory.extract(cItem.bagType) or 'ND') },
        { 'Para', (sInventory.extract(nItem.bagType) or 'ND') },
        { 'Item', (cItem.index or 'ND') },
        { 'Qtd', (amount or 'ND') },
    })
end

