gbProduction = {}

Tunnel.bindInterface('gb_core_ilegal/production', gbProduction)

vRP._prepare("production/orderProducts", "insert into gb_facs_orders (user_id, product, qtd, fac) values (@id, @product, @qtd, @fac)")
vRP._prepare("production/getCurrentOrder", "select * from gb_facs_orders where fac = @fac and product = @product ")
vRP._prepare("production/getCurrentUserOrder", "select * from gb_facs_orders where fac = @fac and product = @product and user_id = @user_id")
vRP._prepare("production/getUserOrders", "select * from gb_facs_orders where fac = @fac and user_id = @user_id ")
vRP._prepare("production/deleteOrder", "delete from gb_facs_orders where id = @id")

local webhookStartOrder = "https://discord.com/api/webhooks/1063177293117259826/1eIG8ldbOR-XBl77l0-TwQT1UEVZKc3md0naUFEx3LguopWHYtUNdD4KfeP27mEONRmb"
local webhookGetOrder = "https://discord.com/api/webhooks/1063177158006157392/a42IfhvyYTFSDyNhuRg7uFmcxPtQBVmk0-iuTasgHhOprAR_h13G-oOOGRfsvvoi2ZDT"

local taskingUser = {}

gbProduction.orderProducts = function(fac, product, qtd) -- OTIMIZAR
    local _source = source
    local user_id = vRP.getUserId(_source)

    if (not taskingUser[user_id]) then
        taskingUser[user_id] = true

        local identity = vRP.getUserIdentity(user_id)
        local productAmount = parseInt(qtd)
        if (productAmount < 1) then productAmount = 1; end;

        local currentOrder = vRP.query("production/getCurrentUserOrder", { fac = fac, product = product, user_id = user_id })
        if #currentOrder > 0 then
            taskingUser[user_id] = nil
            return { result = 'error', message = 'Você já fez uma encomenda deste produto. Vá buscar no porto!' }
        else
            local storage = vRP.query("storage/getProducts", { fac = fac })
            local currentProductInfos

            for k,v in pairs(config.facs[fac].fabricationProducts) do
                if v.spawn == product then currentProductInfos = v end
            end
            local hasItemsInStorage = true
            for k,v in pairs(currentProductInfos.materials) do
                local hasCurrentItemInStorage = false
                for i,s in pairs(storage) do
                    if s.product == v.index then
                        hasCurrentItemInStorage = true
                        if v.qtd * productAmount > s.qtd then
                            hasItemsInStorage = false
                        end
                    end
                end

                if not hasCurrentItemInStorage then hasItemsInStorage = false end
            end

            if hasItemsInStorage then
                if vRP.tryFullPayment(user_id,currentProductInfos.coastPerUnit * productAmount) then
                    for k,v in pairs(currentProductInfos.materials) do
                        local currentStorageProduct = vRP.query("storage/getProductGoal", { product = v.index, fac = fac })[1]
                        if currentStorageProduct ~= nil then
                            vRP.execute("storage/updateGoal", { product = v.index, fac = fac, qtd = tonumber(currentStorageProduct.qtd) - tonumber(v.qtd * productAmount) })
                        end
                    end
                    local data = vRP.query("production/orderProducts", { id = user_id, product = product, qtd = productAmount, fac = fac })
                    vRP._webhook(webhookStartOrder,"```prolog\n[ID]: "..user_id.." "..identity.name.." "..identity.firstname.."\n[FAC]: "..fac.."\n[ID-PEDIDO]: "..(data.insertId or -1).."\n[PRODUTO]: "..product.."\n[QTD]: "..productAmount..os.date('\n[DATA]: %d/%m/%Y [HORA]: %H:%M:%S ```'))
                    gbMessage.sendMessageToFac(fac, 'aviso', 'O passaporte <b>#'..user_id..'</b> fez encomendas de produtos para a organização <b>'..fac..'</b>.')
                    taskingUser[user_id] = nil
                else
                    taskingUser[user_id] = nil
                    return { result = 'error', message = 'Você não possui dinheiro suficiente para esta encomenda!' }
                end
            else 
                taskingUser[user_id] = nil
                return { result = 'error', message = 'Você não possui material suficiente para esta encomenda!' }
            end
        end
    end

    return { result = 'error', message = 'Você já fez uma solicitação!' }
end

gbProduction.getOrders = function(fac)
    local _source = source
    local user_id = vRP.getUserId(_source)
    local identity = vRP.getUserIdentity(user_id)

    local orders = vRP.query("production/getUserOrders", { fac = fac, user_id = user_id })

    if #orders > 0 then
        for k,v in pairs(orders) do
            local affected = vRP.execute("production/deleteOrder", { id = v.id })
            if affected > 0 then
                if (v.qtd < 1) then v.qtd = 1; end;

                vRP.giveInventoryItem(user_id, v.product, v.qtd)
                vRP._webhook(webhookGetOrder,"```prolog\n[ID]: "..user_id.." "..identity.name.." "..identity.firstname.."\n[FAC]: "..fac.."\n[ID-PEDIDO]: "..v.id.."\n[PRODUTO]: "..v.product.."\n[QTD]: "..v.qtd..os.date('\n[DATA]: %d/%m/%Y [HORA]: %H:%M:%S ```'))
            end
        end
        TriggerClientEvent('Notify', _source, 'sucesso', 'Você recolheu todas as suas encomendas ativas!')
    else
        TriggerClientEvent('Notify', _source, 'negado', 'Você não possui encomendas ativas!')
    end
end