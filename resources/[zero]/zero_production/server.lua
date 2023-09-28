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
    zero.formatWebhook(configs.productions[org].webhook, 'Enviar item', {
        { 'item', zero.itemNameList(index) },
        { 'id', user_id },
        { 'qtd', amount }
    })
    TriggerClientEvent("notify", _source, 'Produção', 'Você produziu '..amount..' '..zero.itemNameList(index)..'!')
end

sProduction.hasPermission = function(perm)
    local _source = source
    local user_id = zero.getUserId(_source)

    return zero.checkPermissions(user_id, perm)
end

sProduction.moneyLaundry = function(production)
    local moneyPerFical = configs.moneyPerFiscal
    local governTax = configs.governTax
    if production.buff then
        governTax = configs.governTaxWithBuff
    end

    local _source = source
    local user_id = zero.getUserId(_source)
    local response = exports.zero_hud:prompt(_source, {
        'Valor em dinheiro sujo:'
    })

    if response then
        response = parseInt(response[1])
        if response > 0 and response % moneyPerFical == 0 then
            local totalBeforeLaundry = response - response * governTax
            if exports.zero_hud:request(_source, 'Você deseja lavar R$'..zero.format(response)..' de dinheiro sujo?', 15000) then
                if zero.getInventoryItemAmount(user_id, 'dinheirosujo') >= response then
                    if zero.tryGetInventoryItem(user_id, "dinheirosujo", response) then
                        local ped = GetPlayerPed(_source)
                        TriggerClientEvent('zero_animations:setAnim', _source, 'mexer')
                        Player(_source).state.BlockTasks = true
                        FreezeEntityPosition(ped, true) 
                        TriggerClientEvent('progressBar', _source, 'Lavando dinheiro', 10000)
                        Wait(10000)    
                        FreezeEntityPosition(ped, false)
                        ClearPedTasks(ped)
                        zero.givePaypalMoney(user_id, totalBeforeLaundry)
                        Player(_source).state.BlockTasks = false
                        TriggerClientEvent('notify', _source, 'Lavagem de Dinheiro', 'Foram adicionados R$'..zero.format(totalBeforeLaundry)..' na sua conta do Paypal!', 10000);
                        zero.formatWebhook(production.webhook, 'Lavagem', {
                            { 'id', user_id },
                            { 'Dinheiro Sujo', 'R$'..zero.format(response) },
                            { 'Notas Fiscais', response/moneyPerFical },
                            { 'Dinheiro enviado ao Paypal', 'R$'..zero.format(response - response * governTax) },
                        })
                    else
                        DropPlayer(_source, 'Transação ilegal! Abra ticket.')
                        exports.zero_core:setBanned(user_id, true)
                        exports.zero_core:insertBanRecord(user_id, true, -1, '[PRODUCTION] Transação ilegal!')
                    end
                else
                    TriggerClientEvent('notify', _source, 'Lavagem de Dinheiro', 'Você não possui <b>dinheiro sujo</b> suficiente!', 10000);
                end
            end
        else 
            TriggerClientEvent('notify', _source, 'Lavagem de Dinheiro', 'O valor inserido precisa ser multiplo de 100000. Exemplos: 100000, 200000, 500000...', 20000);
        end
    end
end

sProduction.openSellDrugs = function(production)
    local drugs = {'maconha', 'metanfetamina', 'cocaina', 'lanca-perfume'}
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
                        zero.giveInventoryItem(user_id, 'dinheirosujo', response * 1400)
                        zero.formatWebhook(production.webhook, 'Venda de droga ao NPC', {
                            { 'id', user_id },
                            { 'Qtd de Drogas', response},
                            { 'Valor recebido', 'R$'..zero.format(response * 1400)},
                        })
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

sProduction.openSellGuns = function(production)
    local drugs = {'m-belico'}
    local _source = source
    local user_id = zero.getUserId(_source)

    local response = exports.zero_hud:prompt(_source, {
        'Quantidade material bélico: (min: 1/max: 10)'
    })

    if response then
        response = tonumber(response[1])
        if response ~= nil then
            if response >= 1 and response <= 10 then
                if exports.zero_hud:request(_source, 'Você deseja vender '..response..' materias bélicos?', 15000) then
                    if zero.tryGetInventoryItem(user_id, 'm-belico', response) then
                        zero.giveInventoryItem(user_id, 'dinheirosujo', response * 19600)
                        zero.formatWebhook(production.webhook, 'Venda materiais bélicos ao NPC', {
                            { 'id', user_id },
                            { 'Qtd de M. Bélico', response},
                            { 'Valor recebido', 'R$'..zero.format(response * 19600)},
                        })
                        TriggerClientEvent('notify', _source, 'Ammunation', 'Você vendeu uns produtinhos!')
                    else
                        TriggerClientEvent('notify', _source, 'Ammunation', 'Você não possui material bélico suficiente!')
                    end
                end
            else
                TriggerClientEvent('notify', _source, 'Ammunation', 'Você precisa digitar um número inteiro entre 1 e 10!')
            end
        else
            TriggerClientEvent('notify', _source, 'Ammunation', 'Você precisa digitar um número inteiro entre 1 e 10!')
        end
    end
end