sProduction = {}
Tunnel.bindInterface('zero_production', sProduction);

sProduction.validateProduction = function(index, amount, org)
    local _source = source
    local user_id = zero.getUserId(_source)
    print(org)

    local validatedProduction = true
    local materials = configs.productions[org].products[index].materials
    for k,v in pairs(materials) do
        if zero.getInventoryItemAmount(user_id, k) < (v.amount * amount) then
            validatedProduction = false
            break;
        end
    end

    if validatedProduction then 
        for k,v in pairs(materials) do
            zero.tryGetInventoryItem(user_id, k, v.amount * amount)
        end
        return true
    else
        return false
    end
end

sProduction.giveItem = function(index, amount, org)
    local _source = source
    local user_id = zero.getUserId(_source)

    zero.giveInventoryItem(user_id, index, amount)
    zero.webhook(configs.webhook, '```prolog\n[LOG]: Produção \n[ID]: '..user_id..'\n[ITEM]: '..zero.itemNameList(index)..'\n[QTD]: '..amount..'\n[DATA]: '..os.date('%d/%m/%Y %H:%M:%S')..'```')
    zero.webhook(configs.productions[org].webhook, '```prolog\n[LOG]: Produção \n[ID]: '..user_id..'\n[ITEM]: '..zero.itemNameList(index)..'\n[QTD]: '..amount..'\n[DATA]: '..os.date('%d/%m/%Y %H:%M:%S')..'```')
    TriggerClientEvent("notify", _source, 'Produção', 'Você produziu '..amount..' '..zero.itemNameList(index)..'!')
end