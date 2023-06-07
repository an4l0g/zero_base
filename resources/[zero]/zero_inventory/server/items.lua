
-- Adiciona um novo item na bag na primeira posição disponível
-- -- Se houver posição disponível, retorna a bag atualizada
-- -- Se não houver posição disponível, retorna nil
sInventory.addNewItem = function(slots, max_slots, item, amount)
    local updatedSlots = slots
    local createdItem = false 
    for i=0,tonumber(max_slots) do
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
    local id = vRP.getUserId(_source)
    local user_id = vRP.getUserId(user_source)

    if sInventory.tryGetInventoryItem(id, index, amount) then
        if sInventory.tryAddInventoryItem(user_id, index, amount) then
            config.functions.serverNotify(_source, '-', config.texts.notify_title, config.texts.notify_send_item(amount, config.items[index].name))
            config.functions.serverNotify(user_source, '-', config.texts.notify_title, config.texts.notify_receive_item(amount, config.items[index].name))
        else
            sInventory.giveBagItem('bag:'..id, index, amount)
            config.functions.serverNotify(_source, '-', config.texts.notify_title, config.texts.notify_player_no_weight)
        end
    else
        config.functions.serverNotify(_source, '-', config.texts.notify_title, config.texts.notify_player_no_item)
    end
    TriggerClientEvent('inventory:close', _source)
end

sInventory.useItem = function(index, amount)
    local _source = source
    local user_id = vRP.getUserId(_source)
    local item = config.items[index]

    print('testeeee', amount)

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
        local weapons = vRPclient.getWeapons(_source)

        if item.type == 'weapon' then
            if weapons[string.upper(index)] == nil then
                if vRP.tryGetInventoryItem(user_id, index, 1) then
                    vRPclient.giveWeapons(_source, {[index] = { ammo = ammo }}, false, GlobalState.weaponToken)
                    config.functions.serverNotify(_source, '-', config.texts.notify_title, config.texts.notify_equip_weapon(vRP.itemNameList(index)), 5000)
                else 
                    config.functions.serverNotify(_source, '-', config.texts.notify_title, config.texts.notify_non_existent_item, 5000)
                end
            else
                config.functions.serverNotify(_source, '-', config.texts.notify_title, config.texts.notify_weapon_already_equiped, 5000)
            end
        end
        
        if item.type == 'wammo' then
            local newIndex = string.gsub(index, 'm_', '')
            local currentWeapon = weapons[string.upper(newIndex)]
            
            print(json.encode(weapons))
            if currentWeapon ~= nil then
                print("Passou")
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
                if vRP.tryGetInventoryItem(user_id, newIndex, currentAmmo) then
                    cInventory.addAmmo(_source, newIndex, currentAmmo)
                    config.functions.serverNotify(_source, '-', config.texts.notify_title, config.texts.notify_equip_weapon(vRP.itemNameList(index)), 5000)
                else
                    config.functions.serverNotify(_source, '-', config.texts.notify_title, config.texts.notify_non_existent_item, 5000)
                end
            else
                config.functions.serverNotify(_source, '-', config.texts.notify_title, config.texts.notify_no_weapon_ammo, 5000)
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
        config.functions.serverNotify(_source, '-', config.texts.notify_title, config.texts.notify_non_existent_item, 5000)
        cInventory.closeInventory(_source)
        return 
    end
    if cItem.bagType == nItem.bagType then
        if not sInventory.validateItem(cSlots, nItem, nPos) then 
            config.functions.serverNotify(_source, '-', config.texts.notify_title, config.texts.notify_non_existent_item, 5000)
            cInventory.closeInventory(_source)
            return 
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
                print("E6")
                cSlots[tostring(cPos)] = nItem
                cSlots[tostring(nPos)] = cItem 
            end
        end
    else
        print("E7")
        nSlots = sInventory.getBag(nItem.bagType)
        
        if not sInventory.validateItem(nSlots, nItem, nPos) then 
            print("E8")
            config.functions.serverNotify(_source, '-', config.texts.notify_title, config.texts.notify_non_existent_item, 5000)
            cInventory.closeInventory(_source)
            return 
        end
        
        local max_slots = 0
        
        if tonumber(cItem.amount) == tonumber(amount) then 
            cSlots[tostring(cPos)] = nil
            sInventory.giveBagItem(nItem.bagType, cItem.index, amount)
        else
            cSlots[tostring(cPos)].amount = cItem.amount - amount
            sInventory.giveBagItem(nItem.bagType, cItem.index, amount)
        end
    end
    
    sInventory.modifyBag(cItem.bagType, cSlots)
    itemsMoveLog(cItem, nItem, amount)
    TriggerClientEvent('updateInventory', _source)
end

itemsMoveLog = function(cItem, nItem, amount)
    if config.chests[cItem.bagType] ~= nil then
        webhook(config.chests[cItem.bagType].log, '```prolog\n[Movimentar Itens]\n[De]: '..(cItem.bagType or 'ND')..'\n[Item]: '..(cItem.index or 'ND')..'\n[Qtd]: '..(cItem.amount or 'ND')..'\n\n[Para]: '..nItem.bagType..'\n[Item]: '..(nItem.index or 'ND')..'\n[Qtd]: '..(nItem.amount or 'ND')..'```')
    elseif config.chests[nItem.bagType] ~= nil then 
        webhook(config.chests[nItem.bagType].log, '```prolog\n[Movimentar Itens]\n[De]: '..(cItem.bagType or 'ND')..'\n[Item]: '..(cItem.index or 'ND')..'\n[Qtd]: '..(cItem.amount or 'ND')..'\n\n[Para]: '..nItem.bagType..'\n[Item]: '..(nItem.index or 'ND')..'\n[Qtd]: '..(nItem.amount or 'ND')..'```')
    else
        webhook(config.webhooks.moveItem, '```prolog\n[Movimentar Itens]\n[De]: '..(cItem.bagType or 'ND')..'\n[Item]: '..(cItem.index or 'ND')..'\n[Qtd]: '..(cItem.amount or 'ND')..'\n\n[Para]: '..nItem.bagType..'\n[Item]: '..(nItem.index or 'ND')..'\n[Qtd]: '..(nItem.amount or 'ND')..'```')
    end
end

