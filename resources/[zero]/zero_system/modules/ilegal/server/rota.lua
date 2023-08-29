local srv = {}
Tunnel.bindInterface('Routes', srv)

local routeTime = {}

local selection = {}

srv.startUpdateRoute = function()
    local source = source
    selection[zero.getUserId(source)] = 1
end

srv.resetUpdateRoute = function()
    local source = source
    selection[zero.getUserId(source)] = nil
end

local updateRoute = function(source, routes)
    local user_id = zero.getUserId(source)
    
    selection[user_id] = selection[user_id] + 1
    if (selection[user_id] > #routes) then
        selection[user_id] = 1 
    end
end

srv.checkRoutes = function(index)
    local _config = Routes.locations[index]
    local source = source
    local user_id = zero.getUserId(source)
    if (user_id) and zero.checkPermissions(user_id, _config.perm) then
        if (GetPlayerRoutingBucket(source) ~= 0) then
            TriggerClientEvent('notify', source, 'Rotas', 'Você não pode iniciar uma rota em outro <b>mundo</b>.')
            return false
        end

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
            return true
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

srv.routePayment = function(coords, _config, drug, name)
    local source = source
    local user_id = zero.getUserId(source)
    if (user_id) then
        local distance = #(GetEntityCoords(GetPlayerPed(source)) - coords[selection[user_id]])
        if (distance <= 8.0) then
            local itens = _config.itens
            if (drug) then
                for k, v in pairs(itens) do
                    if (CheckWeight(user_id, v.item, v.quantity, v.receive, v.payment)) then
                        if (zero.tryGetInventoryItem(user_id, v.item, v.quantity)) then
                            zero.giveInventoryItem(user_id, v.receive, v.payment)
                            TriggerClientEvent('notify', source, 'Rotas', 'Você vendeu <b>'..v.quantity..'x</b> de <b>'..zero.itemNameList(v.item)..'</b> e recebeu <b>R$'..zero.format(v.payment)..'</b> de dinheiro sujo pela sua venda!')
                            zero.webhook('Rotas', '```prolog\n[ROUTES]\n[NAME]: '..name..'\n[USER]: '..user_id..'\n[TYPE]: DRUG\n[ITEM SELL]: '..zero.itemNameList(v.item)..'\n[QUANTITY SELL]: '..v.quantity..'\n[ITEM RECEIVED]: '..zero.itemNameList(v.receive)..'\n[VALUE RECEIVED]: R$'..zero.format(v.payment)..' dinheiro sujo\n[COORDENADA]: '..tostring(GetEntityCoords(GetPlayerPed(source)))..' '..os.date('\n[DATE]: %d/%m/%Y [HOUR]: %H:%M:%S')..' \r```')
                            updateRoute(source, coords)
                            return true
                        end
                        TriggerClientEvent('notify', source, 'Rotas', 'Você não possui <b>'..v.quantity..'x</b> de <b>'..zero.itemNameList(v.item)..'</b> em sua mochila!')
                    end
                end
            else
                if (CheckWeight(user_id, itens.item, itens.quantity)) then
                    zero.giveInventoryItem(user_id, itens.item, itens.quantity)
                    TriggerClientEvent('notify', source, 'Rotas', 'Você recebeu <b>'..itens.quantity..'x</b> de <b>'..zero.itemNameList(itens.item)..'</b>!')
                    zero.webhook('Rotas', '```prolog\n[ROUTES]\n[NAME]: '..name..'\n[USER]: '..user_id..'\n[ITEM RECEIVED]: '..zero.itemNameList(itens.item)..'\n[QUANTITY RECEIVED]: '..itens.quantity..'\n[COORDENADA]: '..tostring(GetEntityCoords(GetPlayerPed(source)))..' '..os.date('\n[DATE]: %d/%m/%Y [HOUR]: %H:%M:%S')..' \r```')
                    updateRoute(source, coords)
                    return true
                end
            end
        else
            TriggerClientEvent('notify', source, 'Rotas', 'Você caiu no nosso sistema de <b>anti-dump</b> e não recebeu os itens da rota. Por gentileza, na próxima rota não saia de perto do blip!')
            updateRoute(source, coords)
            zero.webhook('AntiDump', '```prolog\n[ANTI DUMP]\n[USER]: '..user_id..'\n[SCRIPT]: '..GetCurrentResourceName()..'\n[ALERT]: provavelmente este jogador está tentando dumpar em um dos nossos sistemas!'..os.date('\n[DATA]: %d/%m/%Y [HORA]: %H:%M:%S')..'\n```'..'@everyone')
            print('^5[Zero Anti]^7 o usuário '..user_id..' está provavelmente tentando dumpar!')
        end
    end
    return false
end

srv.callPolice = function(porcentage, name)
    local source = source
    local user_id = zero.getUserId(source)
    local pCoord = GetEntityCoords(GetPlayerPed(source))
    local porcentagem = math.random(100)
    if (porcentagem >= porcentage) then
        local police = zero.getUsersByPermission('policia.permissao')
        for k, v in pairs(police) do
            local nSource = zero.getUserSource(parseInt(v))
            if (nSource) then
                async(function()
                    TriggerClientEvent('zero_routes:Blip', nSource, pCoord, user_id)
                    TriggerClientEvent('announcement', nSource, 'Tráfico avistado', 'Atenção <b>unidades</b> foram avistados tráficos de drogas próximo as suas regiões, tomem cuidado!', 'Delegacia Zero', true, 10000)
                end)
            end
        end
        zero.webhook('RotasDenuncia', '```prolog\n[ROUTES]\n[NAME]: '..name..'\n[USER]: '..user_id..'\n[PORCENTAGE]: '..porcentage..'\n[COORDENADA]: '..tostring(GetEntityCoords(GetPlayerPed(source)))..' '..os.date('\n[DATE]: %d/%m/%Y [HOUR]: %H:%M:%S')..' \r```')
        TriggerClientEvent('notify', source, 'Rotas', 'Os <b>coxinhas</b> foram alertados, saia do local imediatamente.')
    end
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