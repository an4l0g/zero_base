sProduction = {}
Tunnel.bindInterface('zero_production', sProduction);

sProduction.validateProduction = function(index, amount, org)
    local _source = source
    local user_id = zero.getUserId(_source)

    local validatedProduction = true
    local materials = configs.productions[org].products[index].materials
    for k,v in pairs(materials) do
        if zero.getInventoryItemAmount(user_id, k) < v.amount then
            validatedProduction = false
            break;
        end
    end

    if validatedProduction then 
        for k,v in pairs(materials) do
            zero.tryGetInventoryItem(user_id, k, v.amount)
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
    zero.webhook('Production', '```prolog\n[LOG]: Produção \n[ID]: '..user_id..'\n[ITEM]: '..zero.itemNameList(index)..'\n[QTD]: '..amount..'\n[DATA]: '..os.date('%d/%m/%Y %H:%M:%S')..'```')
    zero.webhook(configs.productions[org].webhook, '```prolog\n[LOG]: Produção \n[ID]: '..user_id..'\n[ITEM]: '..zero.itemNameList(index)..'\n[QTD]: '..amount..'\n[DATA]: '..os.date('%d/%m/%Y %H:%M:%S')..'```')
    TriggerClientEvent("notify", _source, 'Produção', 'Você produziu '..amount..' '..zero.itemNameList(index)..'!')
end

sProduction.hasPermission = function(perm)
    local _source = source
    local user_id = zero.getUserId(_source)

    return zero.checkPermissions(user_id, perm)
end

sProduction.moneyLaundry = function(production)
    local _source = source
    local user_id = zero.getUserId(_source)
    local response = exports.zero_hud:prompt(_source, {
        'Valor em dinheiro sujo:'
    })

    if response then
        response = parseInt(response[1])
        if response > 0 and response % 1000 == 0 then
            if response <= configs.moneyLaundryMax then
                if exports.zero_hud:request(_source, 'Você deseja lavar R$'..zero.format(response)..' de dinheiro sujo gastando '..parseInt(response/1000)..' notas fiscais?', 15000) then
                    if zero.getInventoryItemAmount(user_id, 'dinheirosujo') >= response then
                        if zero.getInventoryItemAmount(user_id, 'nota-fiscal') >= parseInt(response/1000) then
                            if zero.tryGetInventoryItem(user_id, "dinheirosujo", response) and zero.tryGetInventoryItem(user_id, "nota-fiscal", parseInt(response/1000)) then
                                local ped = GetPlayerPed(_source)
                                TriggerClientEvent('zero_animations:setAnim', _source, 'mexer')
                                Player(_source).state.BlockTasks = true
                                FreezeEntityPosition(ped, true) 
                                TriggerClientEvent('progressBar', _source, 'Lavando dinheiro', response)
                                Wait(response)    
                                FreezeEntityPosition(ped, false)
                                ClearPedTasks(ped)
                                zero.givePaypalMoney(user_id, response)
                                Player(_source).state.BlockTasks = false
                                TriggerClientEvent('notify', _source, 'Lavagem de Dinheiro', 'Foram adicionados R$'..zero.format(response)..' na sua conta do Paypal! Não se esqueça de entregar 60% do valor ao cliente.', 10000);
                            else
                                DropPlayer(_source, 'Transação ilegal! Abra ticket.')
                                exports.zero_core:setBanned(user_id, true)
                                exports.zero_core:insertBanRecord(user_id, true, -1, '[PRODUCTION] Transação ilegal!')
                            end
                        else
                            TriggerClientEvent('notify', _source, 'Lavagem de Dinheiro', 'Você não possui <b>notas fiscais</b> suficientes!', 10000);
                        end
                    else
                        TriggerClientEvent('notify', _source, 'Lavagem de Dinheiro', 'Você não possui <b>dinheiro sujo</b> suficiente!', 10000);
                    end
                end
            else
                TriggerClientEvent('notify', _source, 'Lavagem de Dinheiro', 'Você não pode lavar mais que R$'..zero.format(configs.moneyLaundryMax)..' em uma única lavagem!', 10000);
            end
        else 
            TriggerClientEvent('notify', _source, 'Lavagem de Dinheiro', 'O valor inserido precisa ser multiplo de 1000. Exemplos: 1000, 10000, 20000...', 20000);
        end
    end
end

sProduction.openSellDrugs = function()
    local drugs = {'maconha', 'metanfetamina', 'cocaina'}
    local _source = source
    local user_id = zero.getUserId(_source)

    local response = exports.zero_hud:prompt(_source, {
        'Quantidade de droga: (min: 10/max: 125)'
    })

    if response then
        response = tonumber(response[1])
        if response ~= nil then
            if response >= 10 and response < 126 then
                if exports.zero_hud:request(_source, 'Você deseja vender '..response..' droga?', 15000) then
                    local hasDrugs = false
                    for k,v in pairs(drugs) do
                        if zero.tryGetInventoryItem(user_id, v, response) then
                            hasDrugs = true
                            break
                        end
                    end 

                    if hasDrugs then
                        zero.giveInventoryItem(user_id, 'dinheirosujo', response * 750)
                        TriggerClientEvent('notify', _source, 'Tráfico', 'Você vendeu uns produtinhos!')
                    else    
                        TriggerClientEvent('notify', _source, 'Tráfico', 'Você não possui essa quantidade de droga!')
                    end
                end
            else
                TriggerClientEvent('notify', _source, 'Tráfico', 'Você precisa digitar um número inteiro entre 10 e 126!')
            end
        else
            TriggerClientEvent('notify', _source, 'Tráfico', 'Você precisa digitar um número inteiro entre 10 e 126!')
        end
    end
end