srv = {}
Tunnel.bindInterface(GetCurrentResourceName(), srv)

srv.checkItem = function(_require, production)
    local _source = source
    local _userId = vRP.getUserId(source)
    if (_userId) then
        if (production) then
            if (_require) then
                for index, value in pairs(_require) do
                    local quantity = math.random(value['min'], value['max'])
                    if vRP.getInventoryWeight(_userId) + vRP.getItemWeight(index) *quantity <= vRP.getInventoryMaxWeight(_userId) then
                        if (vRP.getInventoryItemAmount(_userId, index) >= quantity) then
                            if vRP.tryGetInventoryItem(_userId, index, quantity) then
                                return true
                            end
                        end
                        TriggerClientEvent('Notify', _source, 'aviso', 'Você não possui <b>'..quantity..'x</b> de <b>'..vRP.itemNameList(index)..'</b>.')
                        return false
                    end
                    TriggerClientEvent('Notify', _source, 'aviso', 'Você não possui <b>espaço</b> na mochila.')
                    return false
                end
            end
            return true
        elseif (_require) then
            if vRP.getInventoryWeight(_userId) + vRP.getItemWeight(_require['spawn']) * _require['quantity'] <= vRP.getInventoryMaxWeight(_userId) then
                if (vRP.getInventoryItemAmount(_userId, _require['spawn']) >= _require['quantity']) then
                    if vRP.tryGetInventoryItem(_userId, _require['spawn'], _require['quantity']) then
                        return true
                    end
                end
                TriggerClientEvent('Notify', _source, 'aviso', 'Você não possui <b>'.._require['quantity']..'x</b> de <b>'..vRP.itemNameList(_require['spawn'])..'</b>.')
                return false
            end
            TriggerClientEvent('Notify', _source, 'aviso', 'Você não possui <b>espaço</b> na mochila.')
            return false
        end
        return true
    end
end

srv.givePayment = function(location, _payment, work, selection)
    local _source = source
    local _userId = vRP.getUserId(source)
    if (_userId) then
        if (#(GetEntityCoords(GetPlayerPed(_source)) - location) <= 5.0) then
            local randomMoney = math.random(_payment['money']['min'], _payment['money']['max'])
            local bonus = 1.0
            if (selection >= _payment['bonus']['after']) then
                bonus = _payment['bonus']['multiply']
                vRP.giveMoney(_userId, parseInt(randomMoney * bonus))
                onPayment(_userId,  parseInt(randomMoney * bonus),  location, _payment, work, selection)
            else
                vRP.giveMoney(_userId, parseInt(randomMoney * bonus))
                onPayment(_userId,  parseInt(randomMoney * bonus),  location, _payment, work, selection)
            end
            TriggerClientEvent('Notify', _source, 'sucesso', 'Entrega feita com sucesso!<br>A empresa <b>'..work..'</b> efetuou um pagamento em sua conta.<br><br>Valor Recebido: <b>R$'..parseInt(randomMoney * bonus)..'</b>.', 8000)
            return true
        else
            DropPlayer(_source, 'Proteção anti-dump bluenzzz.')
            return false
        end
    end
end

srv.giveItem = function(_receive)
    local _source = source
    local _userId = vRP.getUserId(source)
    if (_userId) then
        if (_receive) then
            for index, value in pairs(_receive) do
                local quantity = math.random(value['min'], value['max'])
                if vRP.getInventoryWeight(_userId) + vRP.getItemWeight(index) * quantity <= vRP.getInventoryMaxWeight(_userId) then
                    vRP.giveInventoryItem(_userId, index, quantity)
                    TriggerClientEvent('Notify', _source, 'sucesso', 'Você recebeu <b>'..quantity..'x</b> de <b>'..vRP.itemNameList(index)..'</b>.')
                    return true
                end
                TriggerClientEvent('Notify', _source, 'aviso', 'Você não possui <b>espaço</b> na mochila.')
                return false
            end
        end
        return true
    end
end