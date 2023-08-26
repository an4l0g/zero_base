srv = {}
Tunnel.bindInterface(GetCurrentResourceName(), srv)

local configGeneral = config.general
local configShops = config.shops

local checkInventory = function(user_id, item, amount)
    if ((zero.getInventoryWeight(user_id) + (zero.getItemWeight(item) * amount)) < zero.getInventoryMaxWeight(user_id)) then
        return true
    end
    TriggerClientEvent('notify', zero.getUserSource(user_id), 'Loja', 'Você não possui <b>espaço</b> o suficiente em sua mochila.')
    return false
end

srv.checkPermission = function(permissions)
    local source = source
    local user_id = getUserId(source)
    return zero.checkPermissions(user_id, permissions)
end

srv.getUserIdentity = function()
    local source = source
    local user_id = zero.getUserId(source)
    local identity = zero.getUserIdentity(user_id)
    if (user_id and identity) then
        return identity.firstname..' '..identity.lastname
    end
end

local amountSpent = 0
local earnedValue = 0

local paymentMethod = {
    ['legal'] = function(user_id, item, amount, config, method)
        local source = zero.getUserSource(user_id)
        local price = parseInt(config.price[method] * amount)
        if (method == 'buy') then
            if (checkInventory(user_id, item, amount)) then
                if (zero.tryFullPayment(user_id, price)) then
                    zero.giveInventoryItem(user_id, item, amount)
                    amountSpent = parseInt(amountSpent + price)
                    return true
                else
                    TriggerClientEvent('notify', source, 'Loja', 'Você não possui <b>dinheiro</b> o suficiente em sua conta.')
                end
            end
        else
            if (zero.tryGetInventoryItem(user_id, item, amount)) then
                zero.giveMoney(user_id, price)
                earnedValue = parseInt(earnedValue + price)
                return true
            else
                TriggerClientEvent('notify', source, 'Loja', 'Você não possui <b>item</b> o suficiente em seu inventário.')
            end
        end
        return false
    end,
    ['ilegal'] = function(user_id, item, amount, config, method)
        local source = zero.getUserSource(user_id)
        local price = parseInt(config.price[method] * amount)
        if (method == 'buy') then
            if (checkInventory(user_id, item, amount)) then
                if (zero.tryGetInventoryItem(user_id, 'dinheirosujo', price)) then
                    zero.giveInventoryItem(user_id, item, amount)
                    amountSpent = parseInt(amountSpent + price)
                    return true
                else
                    TriggerClientEvent('notify', source, 'Loja', 'Você não possui <b>dinheiro sujo</b> o suficiente em sua conta.')
                end
            end
        else
            if (zero.tryGetInventoryItem(user_id, item, amount)) then
                zero.giveInventoryItem(user_id, 'dinheirosujo', price)
                earnedValue = parseInt(earnedValue + price)
                return true
            else
                TriggerClientEvent('notify', source, 'Loja', 'Você não possui <b>item</b> o suficiente em seu inventário.')
            end
        end
        return false
    end,
}

local _finish = {
    ['buy'] = function(source, paidOut, name)
        local user_id = zero.getUserId(source)
        if (amountSpent > 0) then
            local text = table.concat(paidOut, ', <br>')
            TriggerClientEvent('notify', source, 'Loja', 'A sua compra foi um <b>sucesso</b>.<br><br><b>(Nota Fiscal)</b><br><br>'..text..'<br><br><b>Total: R$'..zero.format(amountSpent)..'</b>')
            exports['zero_bank']:extrato(user_id, name, -amountSpent)
            zero.webhook('ShopBuy', '```prolog\n[ZERO SHOP]\n[ACTION] (BUY)\n[USER]: '..user_id..' \n[TABLE]: '..json.encode(paidOut, { indent = true })..'\n[TOTAL]: R$'..zero.format(amountSpent)..os.date('\n[DATA]: %d/%m/%Y [HORA]: %H:%M:%S')..'\n```')
        end
        amountSpent = 0
    end,
    ['sell'] = function(source, paidOut, name)
        local user_id = zero.getUserId(source)
        if (earnedValue > 0) then
            local text = table.concat(paidOut, ', <br>')
            TriggerClientEvent('notify', source, 'Loja', 'A sua venda foi um <b>sucesso</b>.<br><br><b>(Nota Fiscal)</b><br><br>'..text..'<br><br><b>Total: R$'..zero.format(earnedValue)..'</b>')
            exports['zero_bank']:extrato(user_id, name, earnedValue)
            zero.webhook('ShopSell', '```prolog\n[ZERO SHOP]\n[ACTION] (SELL)\n[USER]: '..user_id..' \n[TABLE]: '..json.encode(paidOut, { indent = true })..'\n[TOTAL]: R$'..zero.format(earnedValue)..os.date('\n[DATA]: %d/%m/%Y [HORA]: %H:%M:%S')..'\n```')
        end
        earnedValue = 0
    end
}

srv.shopTransaction = function(cart, method, index)
    local source = source
    local user_id = zero.getUserId(source)
    if (user_id) then
        local paidOut = {}
        for k, v in pairs(cart) do
            local itemConfig = configGeneral[configShops[index].config][k] 
            if (zero.checkPermissions(user_id, itemConfig.perm)) then
                local itemMethod = itemConfig.method
                if (method == 'buy') then
                    if (paymentMethod[itemMethod](user_id, k, v.amount, itemConfig, 'buy')) then
                        table.insert(paidOut, v.amount..'x '..zero.itemNameList(k))
                    end
                else
                    if (paymentMethod[itemMethod](user_id, k, v.amount, itemConfig, 'sell')) then
                        table.insert(paidOut, v.amount..'x '..zero.itemNameList(k))
                    end
                end
            else
                TriggerClientEvent('notify', source, 'Loja', 'Você não tem <b>permissão</b> para comprar este item!')
            end
        end
        _finish[method](source, paidOut, configShops[index].name)
    end
end