-- Adicionar item ao inventário do staff que executou o item
RegisterCommand('item', function(source, args) 
    local _source = source
    local user_id = zero.getUserId(_source)
    local item = args[1]
    local amount = (args[2] or 1)
    
    if zero.hasPermission(user_id, 'admin.permissao') then
        if config.items[item] then
            sInventory.giveInventoryItem(user_id, item, amount)    
            configs.functions.serverNotify(_source, config.texts.notify_title, config.texts.notify_receive_item(amount, item))
        else
            config.functions.serverNotify(_source, config.texts.notify_title, config.texts.notify_non_existent_item)
        end

        local identity = zero.getUserIdentity(user_id)
        zero.webhook(config.webhooks.addItem,"```prolog\n[zero_inventory]\n[/ADDITEM]\n[PLAYER]: "..user_id.." | "..identity.name.." "..identity.firstname.." \n[ADICIONOU ITEM NO INVENTÁRIO]\n[ITEM] "..item.."\n[QUANTIDADE]: "..amount.."\n[NOME]: "..zero.itemNameList(item).." "..os.date("\n[DATA]: %d/%m/%Y [HORA]: %H:%M:%S").." \r```")
    end
end)

-- Limpa hotbar e bag do player
RegisterCommand('cinv', function(source, args)
    local user_id = (args[1] or zero.getUserId(source))
    if zero.hasPermission(user_id, 'dono.permissao') then
        sInventory.clearInventory(user_id)
        zero.webhook(config.webhooks.delBag,"```prolog\n[zero_inventory]\n[/DELBAG]\n[PLAYER]: "..user_id.." | "..identity.name.." "..identity.firstname.." \n[DELETOU UMA BAG]\n[BAG_TYPE]: "..bag_type.." "..os.date("\n[DATA]: %d/%m/%Y [HORA]: %H:%M:%S").." \r```")
    end
end)

-- Limpa todos os grops do chão
RegisterCommand('clearground', function(source, args)
    local user_id = zero.getUserId(source)
    if zero.hasPermission(user_id, "admin.permissao") then
        droppedItems = {}
        TriggerClientEvent('updateDroppedItems', -1, droppedItems)
    else
        config.functions.serverNotify(source, config.texts.notify_title, config.texts.notify_no_has_permission)
    end
end)