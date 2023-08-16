local srv = {}
Tunnel.bindInterface('Routes', srv)

local routeTime = {}

srv.checkRoutes = function(index)
    local _config = Routes.locations[index]
    local source = source
    local user_id = zero.getUserId(source)
    if (user_id) and zero.checkPermissions(user_id, _config.perm) then
        if (routeTime[user_id]) then
            TriggerClientEvent('notify', source, 'Rotas', 'Aguarde <b>'..routeTime[user_id]..' segundos</b> para iniciar uma rota novamente.')
            return false
        end
        registerRoutesTime(user_id, _config.cooldown)
        return true
    end
    return false
end

local check = {
    ['with-receive'] = function(user_id, item, quantity, receive, payment)
        if ((zero.getInventoryWeight(user_id) + (zero.getItemWeight(receive) * payment)) <= zero.getInventoryMaxWeight(user_id)) then
            if (zero.getInventoryItemAmount(user_id, item) >= quantity) then
                return true
            end
        end
        return false
    end,
    ['without-receive'] = function(user_id, item, quantity, receive, payment)
        if ((zero.getInventoryWeight(user_id) + (zero.getItemWeight(item) * quantity)) <= zero.getInventoryMaxWeight(user_id)) then
            if (zero.getInventoryItemAmount(user_id, item) >= quantity) then
                return true
            end
        end
        return false
    end
}

local CheckWeight = function(user_id, item, quantity, receive, payment)
    local _receive = (not receive and 'without-receive' or 'with-receive')
    return check[_receive](user_id, item, quantity, receive, payment)
end

srv.checkBackpack = function(itens, drug)
    local source = source
    local user_id = zero.getUserId(source)
    if (user_id) then
        if (drug) then
            for k, v in pairs(itens) do
                if (CheckWeight(user_id, v.item, v.quantity, v.receive, v.payment)) then
                    return true
                end
            end
        else
            if (CheckWeight(user_id, itens.item, itens.quantity)) then
                return true
            end
        end
    end
    TriggerClientEvent('notify', source, 'Rotas', 'Você não possui os <b>itens</b> necessários para realizar esta rota ou não possui espaço em sua <b>mochila</b>!')
    return false
end

srv.routePayment = function(coords, itens, drug)
    local source = source
    local user_id = zero.getUserId(source)
    if (user_id) then
        local distance = #(GetEntityCoords(GetPlayerPed(source)) - coords)
        if (distance <= 8.0) then
            if (drug) then
                for k, v in pairs(itens) do
                    if (CheckWeight(user_id, v.item, v.quantity, v.receive, v.payment)) then
                        if (zero.tryGetInventoryItem(user_id, v.item, v.quantity)) then
                            zero.giveInventoryItem(user_id, v.receive, v.payment)
                            TriggerClientEvent('notify', source, 'Rotas', 'Você vendeu <b>'..v.quantity..'x</b> de <b>'..zero.itemNameList(v.item)..'</b> e recebeu <b>R$'..zero.format(v.payment)..'</b> de dinheiro sujo pela sua venda!')
                            return true
                        end
                        TriggerClientEvent('notify', source, 'Rotas', 'Você não possui <b>'..v.quantity..'x</b> de <b>'..zero.itemNameList(v.item)..'</b> em sua mochila!')
                    end
                end
            else
                if (CheckWeight(user_id, itens.item, itens.quantity)) then
                    zero.giveInventoryItem(user_id, itens.item, itens.quantity)
                    TriggerClientEvent('notify', source, 'Rotas', 'Você recebeu <b>'..itens.quantity..'x</b> de <b>'..zero.itemNameList(itens.item)..'</b>!')
                    return true
                end
            end
        else
            DropPlayer('Você foi pego tentando dumpar na rota. (Esta mensagem é um aviso, você não foi banido!)')
        end
    end
    return false
end

registerRoutesTime = function(id, time)
    routeTime[id] = time
    Citizen.CreateThread(function()
        while (routeTime[id] > 0) do
            Citizen.Wait(1000)
            routeTime[id] = (routeTime[id] - 1)
        end
        routeTime[id] = nil
    end)
end