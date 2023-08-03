gbGoals = {}

Tunnel.bindInterface('gb_core_ilegal/goals', gbGoals)

vRP._prepare("goals/registerGoal", "insert into gb_facs_goals (product, product_index, qtd, fac) values (@product, @product_index, @qtd, @fac)")
vRP._prepare("goals/getCurrentGoals", "select * from gb_facs_goals where fac = @fac")
vRP._prepare("goals/getCurrentGoalsByProduct", "select * from gb_facs_goals where fac = @fac and product = @product")
vRP._prepare("goals/getProductGoal", "select * from gb_facs_goals where fac = @fac and product = @product")
vRP._prepare("goals/deleteProductGoal", "delete from gb_facs_goals where id = @id")
vRP._prepare("storage/getProducts", "select * from gb_facs_storage where fac = @fac")
vRP._prepare("storage/sendGoal", "insert into gb_facs_storage (fac, product, qtd) values (@fac, @product, @qtd)")
vRP._prepare("storage/getProductGoal", "select * from gb_facs_storage where fac = @fac and product = @product")
vRP._prepare("storage/updateGoal", "UPDATE gb_facs_storage SET qtd = @qtd where fac = @fac and product = @product")
vRP._prepare("goals/registerUserGoal", "insert into gb_facs_user_goals (product, qtd, user_id, fac) values (@product, @qtd, @user_id, @fac)")
vRP._prepare("goals/getUserGoals", "select * from gb_facs_user_goals where user_id = @id and fac = @fac")
vRP._prepare("goals/deleteAllMembersGoals", "delete from gb_facs_user_goals where fac = @fac")

gbGoals.getProducts = function(fac)
    return config.facs[fac].products
end

gbGoals.registerCurrentGoal = function(fac, product, qtd)
    local currentGoals = gbGoals.getCurrentGoals(fac)
    local productGoal = gbGoals.getProductGoal(fac, product)
    if #productGoal == 0 then
        if #currentGoals < 4 then
            vRP.execute("goals/registerGoal", { product = vRP.itemNameList(product), product_index = product, fac = fac, qtd = qtd })
            gbMessage.sendMessageToFac(fac, 'sucesso', 'Nova meta registrada na organização <b>'..fac..'</b>.')
            return { result = 'success', message = 'Nova meta registrada com sucesso!' }
        else
            return { result = 'error', message = 'Você atingiu o limite de 4 metas ativas!' }
        end
    else 
        return { result = 'error', message = 'Você já registrou uma meta para este produto!' }
    end
end

gbGoals.getCurrentGoals = function(fac)
    return vRP.query("goals/getCurrentGoals", { fac = fac }) or {}
end

gbGoals.getProductGoal = function(fac, product)
    return vRP.query("goals/getProductGoal", { fac = fac, product = product })
end

gbGoals.deleteCurrentGoal = function(fac, id)
    vRP.execute("goals/deleteProductGoal", { id = id })
    gbMessage.sendMessageToFac(fac, 'aviso', 'Meta excluída na organização <b>'..fac..'</b>.')
    return { result = 'success', message = 'Meta excluida com sucesso!' }
end

gbGoals.getStorageAndProducts = function(fac)
    local storageProducts = vRP.query('storage/getProducts', { fac = fac })
    local products = config.facs[fac].products
    local usageWeight = 0
    if products ~= nil then
        for k,v in pairs(storageProducts) do
            usageWeight = usageWeight + vRP.getItemWeight(v.product) * v.qtd
            storageProducts[k].name = vRP.itemNameList(v.product)
        end

        for k,v in pairs(products) do
            products[k].weight = vRP.getItemWeight(v.index)
        end

        return { products = products, storageWeightTotal = config.facs[fac].storage, storageWeightFree = config.facs[fac].storage - usageWeight, fabricationProducts = config.facs[fac].fabricationProducts, storage = storageProducts }
    end
end

gbGoals.sendGoal = function(fac, product, amount)
    local _source = source
    local user_id = vRP.getUserId(_source)
    local storage = gbGoals.getStorageAndProducts(fac)
    if (not amount) then return end
    if storage.storageWeightFree >= vRP.getItemWeight(product) * amount then
        if vRP.tryGetInventoryItem(user_id, product, amount) then
            local currentGoalProduct = vRP.query("storage/getProductGoal", { product = product, fac = fac })[1]
            if currentGoalProduct ~= nil then
                vRP.execute("storage/updateGoal", { product = product, fac = fac, qtd = tonumber(currentGoalProduct.qtd) + tonumber(amount) })
            else 
                vRP.execute("storage/sendGoal", { product = product, fac = fac, qtd = amount })
            end 
            vRP.execute("goals/registerUserGoal", { product = product, fac = fac, qtd = amount, user_id = user_id })
            gbMessage.sendMessageToFac(fac, 'aviso', 'O passaporte <b>#'..user_id..'</b> enviou <b>'..amount..' '..vRP.itemNameList(product)..'(s)</b> para o armazém da organização <b>'..fac..'</b>.')
            return { result = 'success', message = 'Produto enviado para o armazém!' }
        else
            return { result = 'error', message = 'Você não possui esta quantidade de produto!' }
        end
    else
        gbMessage.sendMessageToFac(fac, 'aviso', 'O passaporte <b>#'..user_id..'</b> tentou enviar <b>'..amount..' '..vRP.itemNameList(product)..'(s)</b> mas o armazém da organização <b>'..fac..'</b> está <b>LOTADO</b>.')
        return { result = 'error', message = 'O armazém da organização está lotado!' }
    end
end

gbGoals.getAllMembersGoals = function(fac)
    local members = gbMembers.getAllMembers(fac)
    for k,v in pairs(members) do
        local goals = vRP.query("goals/getUserGoals", { id = v.user_id, fac = fac})
        members[k].goals = goals
    end 
    return members
end

gbGoals.deleteAllMembersGoals = function(fac)
    vRP.execute('goals/deleteAllMembersGoals', { fac = fac })
    gbMessage.sendMessageToFac(fac, 'aviso', 'Todas as metas da organização <b>'..fac..'</b> foram zeradas.')
    return { result = 'success', message = 'Metas zeradas com sucesso!!' }
end