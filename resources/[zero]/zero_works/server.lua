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

local selection = {}

srv.startUpdateRoute = function()
    local source = source
    selection[zero.getUserId(source)] = 1
end

srv.resetUpdateRoute = function()
    local source = source
    selection[zero.getUserId(source)] = nil
end

local updateRoute = function(source, work, routes)
    local user_id = zero.getUserId(source)
    
    selection[user_id] = selection[user_id] + 1
    if (selection[user_id] > #routes) then
        selection[user_id] = 1 
        if (lang[work]) then TriggerClientEvent('notify', source, 'Emprego', lang[work]['resetRoutes']); end;
    end
end

srv.givePayment = function(location, _payment, work)
    local _source = source
    local _userId = zero.getUserId(source)
    if (_userId) then
        if (#(GetEntityCoords(GetPlayerPed(_source)) - location[selection[_userId]]) <= 5.0) then
            local randomMoney = math.random(_payment['money']['min'], _payment['money']['max'])
            local bonus = 1.0
            if (selection[_userId] >= _payment['bonus']['after']) then
                bonus = _payment['bonus']['multiply']
                zero.giveMoney(_userId, parseInt(randomMoney * bonus))
                onPayment(_userId,  parseInt(randomMoney * bonus),  location, _payment, work, selection[_userId])
            else
                zero.giveMoney(_userId, parseInt(randomMoney * bonus))
                onPayment(_userId,  parseInt(randomMoney * bonus),  location, _payment, work, selection[_userId])
            end
            updateRoute(_source, work, location)
            exports.zero_bank:extrato(_userId, work, parseInt(randomMoney * bonus))
            TriggerClientEvent('notify', _source, 'Emprego', 'Entrega feita com sucesso!<br>A empresa <b>'..work..'</b> efetuou um pagamento em sua conta.<br><br>Valor Recebido: <b>R$'..parseInt(randomMoney * bonus)..'</b>.', 8000)
            return true
        else
            -- DropPlayer(_source, 'Proteção anti-dump bluenzzz.')
            zero.webhook('AntiDump', '```prolog\n[ANTI DUMP]\n[USER]: '.._userId..'\n[SCRIPT]: '..GetCurrentResourceName()..'\n[ALERT]: provavelmente este jogador está tentando dumpar em um dos nossos sistemas!'..os.date('\n[DATA]: %d/%m/%Y [HORA]: %H:%M:%S')..'\n```'..'@everyone')
            print('^5[Zero Anti]^7 o usuário '.._userId..' está provavelmente tentando dumpar!')
        end
    end
    return false
end

local active = {}

srv.giveItem = function(config, pCoord)
    local _source = source
    local _userId = zero.getUserId(source)
    if (#(GetEntityCoords(GetPlayerPed(source)) - pCoord) <= 2.0) then
        if (_userId) then
            if (product[config] and not active[_userId]) then
                active[_userId] = true

                local _receive = product[config]['receiveItems']
                for index, value in pairs(_receive) do
                    local quantity = math.random(value['min'], value['max'])
                    if zero.getInventoryWeight(_userId) + zero.getItemWeight(index) * quantity <= zero.getInventoryMaxWeight(_userId) then
                        zero.giveInventoryItem(_userId, index, quantity)
                        TriggerClientEvent('notify', _source, 'Emprego', 'Você recebeu <b>'..quantity..'x</b> de <b>'..zero.itemNameList(index)..'</b>.')
                        WorkTimeout(product[config].duration, _userId)
                        return true
                    end
                    TriggerClientEvent('notify', _source, 'Emprego', 'Você não possui <b>espaço</b> na mochila.')
                    WorkTimeout(product[config].duration, _userId)
                    return false
                end
            end
            return true
        end
    else
        print('ANTI-DUMP')
    end
end

-- [ Pega trouxa ] --
WorkTimeout = function(time, id)
    Citizen.SetTimeout(time, function()
        active[id] = false
    end)
end