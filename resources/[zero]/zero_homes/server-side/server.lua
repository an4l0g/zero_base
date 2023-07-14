srv = {}
Tunnel.bindInterface(GetCurrentResourceName(), srv)
vCLIENT = Tunnel.getInterface(GetCurrentResourceName())

-- Habilitar opção de comprar a casa com Credits
-- adicionar segurança. Alarme na porta e no bau

local tempHome = {}
homeOpened = {}

local _home = {
    ['enter-home'] = function(source, user_id, index)
        local ownerConsult = zero.query('zero_homes/getHomeOwner', { home = index })[1]
        if (ownerConsult) then
            local homeConfig = json.decode(ownerConsult.configs)
            
            local taxTime = (ownerConsult.tax == -1 and ownerConsult.tax or parseInt(ownerConsult.tax))
            if (taxTime >= 0) then
                if (os.time() >= parseInt((taxTime + generalConfig.lateFee) * 24 * 60 * 60)) then
                    serverNotify(source, 'O <b>IPTU</b> da residência se encontra atrasado.')
                    return false
                end
            end

            local homeName = ownerConsult.home
            local homeConsult = zero.query('zero_homes/homePermissions', { home = homeName, user_id = user_id })[1]
            if (homeConsult) then
                if (taxTime >= 0) then serverNotify(source, 'O <b>IPTU</b> vence em: '..zero.getDayHours(generalConfig.lateFee * 24 * 60 * 60 - (os.time() - taxTime)), 10000); end;
                tempHome[source] = { oldCoords = GetEntityCoords(GetPlayerPed(source)) }
                vCLIENT.enterHome(source, homeConfig.interior, false, homeName)
            else
                if (homeOpened[homeName]) then
                    tempHome[source] = { oldCoords = GetEntityCoords(GetPlayerPed(source)) }
                    vCLIENT.enterHome(source, homeConfig.interior, false, homeName)
                else
                    serverNotify(source, 'Esta <b>residência</b> se encontra trancada.')
                end
            end
            return false
        end
        return true
    end,
    ['enter-apartament'] = function(source, user_id, index)
        index = index..'%'
        local ownerConsult = zero.query('zero_homes/getApartamentOwner', { user_id = user_id, home = index })[1]
        if (ownerConsult) then
            local taxTime = (ownerConsult.tax == -1 and ownerConsult.tax or parseInt(ownerConsult.tax))
            if (taxTime >= 0) then
                if (os.time() >= parseInt((taxTime + generalConfig.lateFee) * 24 * 60 * 60)) then
                    serverNotify(source, 'O <b>IPTU</b> da residência se encontra atrasado.')
                    return false
                end
            end

            local homeName = ownerConsult.home
            local homeConsult = zero.query('zero_homes/homePermissions', { home = homeName, user_id = user_id })[1]
            if (homeConsult) then
                if (taxTime >= 0) then serverNotify(source, 'O <b>IPTU</b> vence em: '..zero.getDayHours(generalConfig.lateFee * 24 * 60 * 60 - (os.time() - taxTime)), 10000); end;
                local homeConfig = json.decode(homeConsult.configs)
                
                tempHome[source] = { oldCoords = GetEntityCoords(GetPlayerPed(source)) }
                vCLIENT.enterHome(source, homeConfig.interior, homeConfig.decorations, homeName)
            else
                if (homeOpened[homeName]) then
                    tempHome[source] = { oldCoords = GetEntityCoords(GetPlayerPed(source)) }
                    vCLIENT.enterHome(source, homeConfig.interior, homeConfig.decorations, homeName)
                else
                    serverNotify(source, 'Esta <b>residência</b> se encontra trancada.')
                end
            end
            return false
        end
        return true
    end,
    ['buy-home'] = function(user_id, index, tax, table)
        zero.execute('zero_homes/buyHome', { user_id = user_id, home = index, home_owner = 1, garages = 0, tax = tax, configs = json.encode(table), vip = 0 })
    end,
    ['buy-apartament'] = function(user_id, index, tax, table)
        local name = generateApartamentName(index)
        if (name) then zero.execute('zero_homes/buyHome', { user_id = user_id, home = name, home_owner = 1, garages = 0, tax = tax, configs = json.encode(table), vip = 0 }); end;
    end
}

srv.tryEnterHome = function(index)
    local source = source
    local user_id = zero.getUserId(source)
    if (user_id and index) and not homesActions[index] then
        homesActions[index] = true
        local homes = configHomes[index]
        local homesType = configType[homes.type]
        
        
        if (exports['zero_bank']:verifyMultas(user_id) > 0) then
            serverNotify(source, 'Você não pode comprar uma <b>residência</b> tendo multas pendentes.')
            homesActions[index] = nil
            return
        end

        if (tempHome[source]) then 
            serverNotify(source, 'Você está <b>bugado</b> o seu cache foi resetado.')
            tempHome[source] = nil
            homesActions[index] = nil
            return
        end
        
        local isApartament = (homes.type == 'apartament' and 'apartament' or 'home')
        if (not _home['enter-'..isApartament](source, user_id, index)) then homesActions[index] = nil return; end;
        
        if (zero.checkPermissions(user_id, homes.perm)) then
            local price = homesType.price 
            if (price[1]) then
                local request = zero.request(source, 'Esta propriedade '..index..' se encontra à venda. Deseja adquiri-lá por R$'..zero.format(price[2])..'?', 30000)
                if (request) then
                    local allow = false
                    if (not allow) then
                        -- allow = zero.tryFullPayment(user_id, price)
                        allow = true
                    end

                    if (allow) then
                        local tax = (homesType.tax[1] and os.time() or -1)
                        local table = {
                            price = price[2],
                            residents = (homesType.residents[1] and homesType.residents[2] or 0),
                            chest = homesType.chest.min,
                            interior = homesType.interior._default,
                        }
                        
                        local decoration = configInterior[homesType.interior._default]
                        if (decoration) then table.decorations = (decoration.decorations and decoration.decorations._default or 0); end;

                        _home['buy-'..isApartament](user_id, index, tax, table)
                        zero.webhook(configWebhooks.buyHouse, '```prolog\n[ZERO HOMES]\n[ACTION]: (BUY HOUSE)\n[USER]: '..user_id..'\n[HOME]: '..index:upper()..'\n[TYPE]: '..homes.type..'\n[TABLE]: '..json.encode(table)..os.date('\n[DATA]: %d/%m/%Y [HORA]: %H:%M:%S')..' \r```')
                        serverNotify(source, 'A residência <b>'..index..'</b> foi adquirida por R$'..zero.format(price[2])..'.')
                    else
                        serverNotify(source, 'Você não possui <b>dinheiro</b> o suficiente para adquirir esta residência.')
                    end
                end
            else
                serverNotify(source, 'Esta residência <b>'..index..'</b> não está disponível para venda.')
            end
        else
            serverNotify(source, 'Você não possui <b>permissão</b> para comprar esta residência.')
        end
        homesActions[index] = nil
    end
end

local homeBucket = {}

srv.setBucket = function(homeName, status)
    local source = source
    local user_id = zero.getUserId(source)
    if (user_id) then
        local bucket = homeBucket[homeName]
        if (not bucket) then
            bucket = (user_id + 1500)
            homeBucket[homeName] = bucket
        end 

        if (status) then
            SetPlayerRoutingBucket(source, bucket)
        else
            SetPlayerRoutingBucket(source, 0)
        end
    end
end

local cacheExecute = function(source)
    SetPlayerRoutingBucket(source, 0)
    local coord = tempHome[source].oldCoords
    if (coord ~= nil) then
        zeroClient.teleport(source, coord.x, coord.y, coord.z)
        coord = nil
    end
    tempHome[source] = nil
end

srv.cacheHomes = function()
    local source = source
    if (source) and tempHome[source] then
        cacheExecute(source)
    end
end

AddEventHandler('onResourceStop', function(resourceName)
  	if (GetCurrentResourceName() == resourceName) then 
		print('^5[Zero Homes]^7 sistema stopado/reiniciado.')
        for k, _ in pairs(tempHome) do
            TriggerClientEvent('notify', k, 'Residências', 'O sistema de <b>homes</b> de nossa cidade foi reiniciado.')
            print('^5[Zero Homes]^7 o user_id ^5('..zero.getUserId(k)..')^7 foi retirado de dentro da casa.')
			cacheExecute(k)
        end
	end
end)

AddEventHandler('vRP:playerSpawn', function(resourceName)
  	
end)

gerarNome = function(nomeBase, contador)
    return nomeBase .. string.format("%04d", contador)
end

local nomeBase = ''
local contador = 1
local criados = {}
local tipoBase = ''
local oldName = ''

RegisterCommand('criar',function(source)
    if (nomeBase == '') then
        local prompt = zero.prompt(source, { 'Nome da Residência', 'Tipo' })
        if (prompt) then
            nomeBase = prompt[1]
            tipoBase = prompt[2]
        end
        local nomeCompleto = gerarNome(nomeBase, contador)
        oldName = nomeCompleto
        table.insert(criados, {
            [nomeCompleto] = { coord = GetEntityCoords(GetPlayerPed(source)), type = tipoBase }
        })
        zeroClient.addBlip(source, GetEntityCoords(GetPlayerPed(source)).x, GetEntityCoords(GetPlayerPed(source)).y, GetEntityCoords(GetPlayerPed(source)).z, 1, 1, 'Marcou Aqui', 0.5, false)
        contador = contador + 1
    else
        local nomeCompleto = gerarNome(nomeBase, contador)
        oldName =  nomeCompleto
        table.insert(criados, {
            [nomeCompleto] = { coord = GetEntityCoords(GetPlayerPed(source)), type = tipoBase }
        })
        contador = contador + 1
        zeroClient.addBlip(source, GetEntityCoords(GetPlayerPed(source)).x, GetEntityCoords(GetPlayerPed(source)).y, GetEntityCoords(GetPlayerPed(source)).z, 1, 1, 'Marcou Aqui', 0.5, false)
    end
    serverNotify(source, 'Você criou a residência <b>'..oldName..'</b>.')
end)

RegisterCommand('pegar', function(source)
    local linha = ''
    for nome, info in pairs(criados) do
        for k, v in pairs(info) do
            linha = linha.."\n ['"..k.."'] = { coord = "..tostring(v.coord)..", type = '"..v.type.."' },"
        end
    end
    TriggerClientEvent('clipboard', source, 'Pegar', linha)
end)