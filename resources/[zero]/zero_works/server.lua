srv = {}
Tunnel.bindInterface(GetCurrentResourceName(), srv)

srv.checkItem = function(_require, production)
    local _source = source
    local _userId = zero.getUserId(source)
    if (_userId) then
        if (production) then
            if (_require) then
                for index, value in pairs(_require) do
                    local quantity = math.random(value['min'], value['max'])
                    if zero.getInventoryWeight(_userId) + zero.getItemWeight(index) *quantity <= zero.getInventoryMaxWeight(_userId) then
                        if (zero.getInventoryItemAmount(_userId, index) >= quantity) then
                            if zero.tryGetInventoryItem(_userId, index, quantity) then
                                return true
                            end
                        end
                        TriggerClientEvent('notify', _source, 'Emprego', 'Você não possui <b>'..quantity..'x</b> de <b>'..zero.itemNameList(index)..'</b>.')
                        return false
                    end
                    TriggerClientEvent('notify', _source, 'Emprego', 'Você não possui <b>espaço</b> na mochila.')
                    return false
                end
            end
            return true
        elseif (_require) then
            if zero.getInventoryWeight(_userId) + zero.getItemWeight(_require['spawn']) * _require['quantity'] <= zero.getInventoryMaxWeight(_userId) then
                if (zero.getInventoryItemAmount(_userId, _require['spawn']) >= _require['quantity']) then
                    if zero.tryGetInventoryItem(_userId, _require['spawn'], _require['quantity']) then
                        return true
                    end
                end
                TriggerClientEvent('notify', _source, 'Emprego', 'Você não possui <b>'.._require['quantity']..'x</b> de <b>'..zero.itemNameList(_require['spawn'])..'</b>.')
                return false
            end
            TriggerClientEvent('notify', _source, 'Emprego', 'Você não possui <b>espaço</b> na mochila.')
            return false
        end
        return true
    end
end

srv.givePayment = function(location, _payment, work, selection)
    local _source = source
    local _userId = zero.getUserId(source)
    if (_userId) then
        if (#(GetEntityCoords(GetPlayerPed(_source)) - location) <= 5.0) then
            local randomMoney = math.random(_payment['money']['min'], _payment['money']['max'])
            local bonus = 1.0
            if (selection >= _payment['bonus']['after']) then
                bonus = _payment['bonus']['multiply']
                zero.giveMoney(_userId, parseInt(randomMoney * bonus))
                onPayment(_userId,  parseInt(randomMoney * bonus),  location, _payment, work, selection)
            else
                zero.giveMoney(_userId, parseInt(randomMoney * bonus))
                onPayment(_userId,  parseInt(randomMoney * bonus),  location, _payment, work, selection)
            end
            exports.zero_bank:extrato(_userId, work, parseInt(randomMoney * bonus))
            TriggerClientEvent('notify', _source, 'Emprego', 'Entrega feita com sucesso!<br>A empresa <b>'..work..'</b> efetuou um pagamento em sua conta.<br><br>Valor Recebido: <b>R$'..parseInt(randomMoney * bonus)..'</b>.', 8000)
            return true
        else
            DropPlayer(_source, 'Proteção anti-dump bluenzzz.')
            return false
        end
    end
end

srv.giveItem = function(_receive)
    local _source = source
    local _userId = zero.getUserId(source)
    if (_userId) then
        if (_receive) then
            for index, value in pairs(_receive) do
                local quantity = math.random(value['min'], value['max'])
                if zero.getInventoryWeight(_userId) + zero.getItemWeight(index) * quantity <= zero.getInventoryMaxWeight(_userId) then
                    zero.giveInventoryItem(_userId, index, quantity)
                    TriggerClientEvent('notify', _source, 'Emprego', 'Você recebeu <b>'..quantity..'x</b> de <b>'..zero.itemNameList(index)..'</b>.')
                    return true
                end
                TriggerClientEvent('notify', _source, 'Emprego', 'Você não possui <b>espaço</b> na mochila.')
                return false
            end
        end
        return true
    end
end