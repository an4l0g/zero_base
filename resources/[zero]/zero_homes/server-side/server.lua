srv = {}
Tunnel.bindInterface(GetCurrentResourceName(), srv)
vCLIENT = Tunnel.getInterface(GetCurrentResourceName())

-- Habilitar opção de comprar a casa com Credits
-- adicionar segurança. Alarme na porta e no bau

local tempHome = {}
homeOpened = {}

local setHouseBlip = function(source, name, coord)
    vCLIENT.setBlipsOwner(source, name, coord.x, coord.y, coord.z)
end

local _home = {
    ['home'] = function(source, user_id, index)
        local homes = configHomes[index]
        local homesType = configType[homes.type]

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
        else
            if (exports['zero_bank']:verifyMultas(user_id) > 0) then
                serverNotify(source, 'Você não pode comprar uma <b>residência</b> tendo multas pendentes.')
                homesActions[index] = nil
                return
            end

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
                                type = homes.type,
                                decorations = 0
                            }
                            
                            zero.execute('zero_homes/buyHome', { user_id = user_id, home = index, home_owner = 1, garages = 0, tax = tax, configs = json.encode(table), vip = 0 })
                            zero.webhook('buyHouse', '```prolog\n[ZERO HOMES]\n[ACTION]: (BUY HOUSE)\n[USER]: '..user_id..'\n[HOME]: '..index:upper()..'\n[TYPE]: '..homes.type..'\n[TAX IN]: '..(tax ~= -1 and tax..'('..os.date('%d/%m/%Y - %H:%M', tax)..')' or 'null')..'\n[TABLE]: '..json.encode(table)..os.date('\n[DATA]: %d/%m/%Y [HORA]: %H:%M:%S')..' \r```')
                            serverNotify(source, 'A residência <b>'..index..'</b> foi adquirida por R$'..zero.format(price[2])..'.')
                            local coord = configHomes[index].coord
                            TriggerEvent('zero_homes:registerOwnerBlips', source, false, { index, coord })
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
        end
    end,
    ['apartament'] = function(source, user_id, index)
        homeName = index..'%'
        local ownerConsult = zero.query('zero_homes/getApartamentOwner', { user_id = user_id, home = homeName })[1]
        vCLIENT.openNui(source, ownerConsult, index)
    end,
    ['my-apartament'] = function(source, user_id, index)
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

            if (taxTime >= 0) then serverNotify(source, 'O <b>IPTU</b> vence em: '..zero.getDayHours(generalConfig.lateFee * 24 * 60 * 60 - (os.time() - taxTime)), 10000); end;
            tempHome[source] = { oldCoords = GetEntityCoords(GetPlayerPed(source)) }
            
            vCLIENT.enterHome(source, homeConfig.interior, homeConfig.decorations, index)
        end
    end,
    ['buy-apartament'] = function(source, user_id, index, homes)
        local homes = configHomes[index]
        local homesType = configType[homes.type]
        if (not homesActions[index]) then
            homesActions[index] = true

            if (exports['zero_bank']:verifyMultas(user_id) > 0) then
                serverNotify(source, 'Você não pode comprar uma <b>residência</b> tendo multas pendentes.')
                homesActions[index] = nil
                return
            end

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
                                type = homes.type
                            }

                            local decoration = configInterior[homesType.interior._default]
                            if (decoration) then table.decorations = (decoration.decorations and decoration.decorations._default or 0); end;

                            local name = generateApartamentName(index)
                            if (name) then 
                                zero.execute('zero_homes/buyHome', { user_id = user_id, home = name, home_owner = 1, garages = 0, tax = tax, configs = json.encode(table), vip = 0 }) 
                                zero.webhook('buyHouse', '```prolog\n[ZERO HOMES]\n[ACTION]: (BUY HOUSE)\n[USER]: '..user_id..'\n[HOME]: '..name:upper()..'\n[TYPE]: '..homes.type..'\n[TAX IN]: '..tax..' ('..os.date('%d/%m/%Y - %H:%M', tax)..')\n[TABLE]: '..json.encode(table)..os.date('\n[DATA]: %d/%m/%Y [HORA]: %H:%M:%S')..' \r```')
                                serverNotify(source, 'A residência <b>'..name..'</b> foi adquirida por R$'..zero.format(price[2])..'.')
                                local coord = configHomes[index].coord
                                TriggerEvent('zero_homes:registerOwnerBlips', source, false, { name, coord })
                            end
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
    end,
    ['other-apartament'] = function(source, user_id)
        local prompt = zero.prompt(source, { 'Nome da Residência' })
        if (not prompt) then return; end;

        local home = capitalizeString(prompt[1])
        local ownerConsult = zero.query('zero_homes/getHomeOwner', { home = home })[1]
        if (ownerConsult) then
            local homeConfig = json.decode(ownerConsult.configs)

            local taxTime = (ownerConsult.tax == -1 and ownerConsult.tax or parseInt(ownerConsult.tax))
            if (taxTime >= 0) then
                if (os.time() >= parseInt((taxTime + generalConfig.lateFee) * 24 * 60 * 60)) then
                    serverNotify(source, 'O <b>IPTU</b> da residência se encontra atrasado.')
                    return false
                end
            end

            local homeConsult = zero.query('zero_homes/homePermissions', { home = home, user_id = user_id })[1]
            if (homeConsult) then
                if (taxTime >= 0) then serverNotify(source, 'O <b>IPTU</b> vence em: '..zero.getDayHours(generalConfig.lateFee * 24 * 60 * 60 - (os.time() - taxTime)), 10000); end;
                tempHome[source] = { oldCoords = GetEntityCoords(GetPlayerPed(source)) }
                vCLIENT.enterHome(source, homeConfig.interior, false, home)
            else
                if (homeOpened[home]) then
                    tempHome[source] = { oldCoords = GetEntityCoords(GetPlayerPed(source)) }
                    vCLIENT.enterHome(source, homeConfig.interior, homeConfig.decorations, home)
                else
                    serverNotify(source, 'Esta <b>residência</b> se encontra trancada.')
                end
            end
        end
    end,
    ['invade-home'] = function(source, user_id, index)
        local ownerConsult = zero.query('zero_homes/getHomeOwner', { home = index })[1]
        if (ownerConsult) then
            if (zero.tryGetInventoryItem(user_id, 'mandado-241', 1)) then
                local homeConfig = json.decode(ownerConsult.configs)
                local items = exports['zero_inventory']:getBag('homes:'..index)

                tempHome[source] = { oldCoords = GetEntityCoords(GetPlayerPed(source)) }
                vCLIENT.enterHome(source, homeConfig.interior, false, index)
                homeOpened[index] = true
                zero.webhook('invadeHouse', '```prolog\n[ZERO HOMES]\n[ACTION]: (INVADE HOUSE)\n[OWNER]: '..ownerConsult.user_id..'\n[OFFICER]: '..user_id..'\n[HOME]: '..index:upper()..'\n[TYPE]: '..homeConfig.type..'\n[ITEMS]: '..json.encode(items, { indent = true })..'\n[TABLE]: '..json.encode(homeConfig, { indent = true })..os.date('\n[DATA]: %d/%m/%Y [HORA]: %H:%M:%S')..' \r```')
            else
                serverNotify(source, 'Você não possui um <b>mandado de busca e apreensão</b> para invadir esta residência.')
            end
        else
            serverNotify(source, 'Você não pode invadir uma residência que não possui <b>dono</b>.')
        end
    end,
    ['invade-apartament'] = function(source, user_id)
        local prompt = zero.prompt(source, { 'Nome da Residência' })
        if (not prompt) then return; end;

        local homeName = capitalizeString(prompt[1])
        local ownerConsult = zero.query('zero_homes/getHomeOwner', { home = homeName })[1]
        if (ownerConsult) then
            if (zero.tryGetInventoryItem(user_id, 'mandado-241', 1)) then
                local items = exports['zero_inventory']:getBag('homes:'..homeName)
                local homeConfig = json.decode(ownerConsult.configs)

                tempHome[source] = { oldCoords = GetEntityCoords(GetPlayerPed(source)) }
                vCLIENT.enterHome(source, homeConfig.interior, false, homeName)
                homeOpened[homeName] = true
                zero.webhook('invadeHouse', '```prolog\n[ZERO HOMES]\n[ACTION]: (INVADE HOUSE)\n[OWNER]: '..ownerConsult.user_id..'\n[OFFICER]: '..user_id..'\n[HOME]: '..homeName:upper()..'\n[TYPE]: '..homeConfig.type..'\n[ITEMS]: '..json.encode(items, { indent = true })..'\n[TABLE]: '..json.encode(homeConfig, { indent = true })..os.date('\n[DATA]: %d/%m/%Y [HORA]: %H:%M:%S')..' \r```')
            else
                serverNotify(source, 'Você não possui um <b>mandado de busca e apreensão</b> para invadir esta residência.')
            end
        else
            serverNotify(source, 'Você não pode invadir uma residência que não possui <b>dono</b>.')
        end
    end
}

srv.tryEnterHome = function(index)
    local source = source
    local user_id = zero.getUserId(source)
    if (user_id and index) and not homesActions[index] then
        homesActions[index] = true
        local homes = configHomes[index]

        if (tempHome[source]) then 
            serverNotify(source, 'Você está <b>bugado</b> o seu cache foi resetado.')
            tempHome[source] = nil
            homesActions[index] = nil
            return
        end
        
        local isApartament = (homes.type == 'apartament' and 'apartament' or 'home')
        _home[isApartament](source, user_id, index)
        homesActions[index] = nil
    end
end


srv.tryEnterApartament = function(value, index)
    local source = source
    local user_id = zero.getUserId(source)
    if (user_id) then
        _home[value](source, user_id, index)
    end
end

srv.invadeHome = function(index)
    local source = source
    local user_id = zero.getUserId(source)
    if (user_id and index) and zero.hasPermission(user_id, generalConfig.invadePermission) then
        if (zero.getInventoryItemAmount(user_id, 'mandado-241') >= 1) then
            local homes = configHomes[index]

            if (tempHome[source]) then 
                serverNotify(source, 'Você está <b>bugado</b> o seu cache foi resetado.')
                tempHome[source] = nil
                return
            end
            
            local isApartament = (homes.type == 'apartament' and 'apartament' or 'home')
            _home['invade-'..isApartament](source, user_id, index, homes)
        else
            serverNotify(source, 'Você não possui um <b>mandado de busca e apreensão</b> para invadir esta residência.')
        end
        homesActions[index] = nil
    end
end

srv.vaultPermissions = function(homeName)
    local source = source
    local user_id = zero.getUserId(source)
    if (user_id) then
        local consult = zero.query('zero_homes/homePermissions', { home = homeName, user_id = user_id })[1]
        if (consult or zero.hasPermission(user_id, generalConfig.openVaultPermission)) then
            return true
        end
        return false
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

RegisterNetEvent('zero_homes:CacheExecute', function(source)
    SetPlayerRoutingBucket(source, 0)
    local coord = tempHome[source].oldCoords
    if (coord ~= nil) then
        zeroClient.teleport(source, coord.x, coord.y, coord.z)
        coord = nil
    end
end)

srv.cacheHomes = function()
    local source = source
    if (source) and tempHome[source] then
        TriggerEvent('zero_homes:CacheExecute', source)
        tempHome[source] = nil
    end
end

AddEventHandler('onResourceStop', function(resourceName)
  	if (GetCurrentResourceName() == resourceName) then 
		print('^5[Zero Homes]^7 sistema stopado/reiniciado.')
        for k, _ in pairs(tempHome) do
            local _source = k
            if (_source) then
                TriggerEvent('zero_homes:CacheExecute', _source)
                serverNotify(_source, 'O sistema de <b>homes</b> de nossa cidade foi reiniciado.')
                print('^5[Zero Homes]^7 o user_id ^5('..zero.getUserId(_source)..')^7 foi retirado de dentro da casa.')
                tempHome[source] = nil
            end
        end
	end
end)

local buyedHomes = {}
AddEventHandler('vRP:playerSpawn', function(user_id, source)
    TriggerEvent('zero_homes:registerBuyedHomes', source)
    if (user_id) then
        local myHomes = zero.query('zero_homes/userList', { user_id = user_id })
        if (parseInt(#myHomes) > 0) then
            Citizen.Wait(15000)
            for _, v in pairs(myHomes) do
                local homeName = v.home
                local homeConfig = json.decode(v.configs)
                if (v.home_owner == 1) then
                    local taxTime = parseInt(v.tax)
                    if (taxTime > 0) then
                        if (os.time() > parseInt(taxTime + generalConfig.wonFee * 24 * 60 * 60)) then
                            local homeConfig = json.decode(v.configs)
                            local items = exports['zero_inventory']:getBag('homes:'..homeName)
                            serverNotify(source, 'Você não pagou o <b>IPTU</b> de sua residência <b>'..homeName..'</b> e sua residencia foi liquidada.', 10000)
                            zero.execute('zero_homes/sellHome', { home = homeName })
                            zero.execute('zero_homes/delGarage', { home = homeName })
                            zero.execute('zero_inventory:deleteBag', { bag_type = 'homes:'..homeName })
                            zero.webhook('loseHouse', '```prolog\n[ZERO HOMES]\n[ACTION]: (CLEAN UP)\n[USER]: '..user_id..'\n[HOME]: '..homeName:upper()..'\n[TYPE]: '..homeConfig.type..'\n[TAX]: '..v.tax..' ('..os.date('%d/%m/%Y - %H:%M', v.tax)..')\n[ITEMS]:'..json.encode(items, { indent = true })..'\n[TABLE]: '..json.encode(homeConfig, { indent = true })..os.date('\n[DATA]: %d/%m/%Y [HORA]: %H:%M:%S')..' \r```')
                        end
                    end
                end

                if (homeConfig.type == 'apartament') then homeName = string.sub(homeName, 1, -5); end;
                local coord = configHomes[homeName].coord
                TriggerEvent('zero_homes:registerOwnerBlips', source, false, { homeName, coord })
				Citizen.Wait(10)
            end
        end
    end
end)

Citizen.CreateThread(function()
    Citizen.Wait(500)
    TriggerEvent('zero_homes:registerBuyedHomes', -1)
    TriggerEvent('zero_homes:registerOwnerBlips', -1, true)
    local query = zero.query('zero_homes/getAllHomesOwner')
    local cleanupHouses = 0
    for k, v in pairs(query) do
        local homeName = v.home
        local taxTime = parseInt(v.tax)
        if (taxTime) and taxTime > 0 then
            if (os.time() > parseInt(taxTime + generalConfig.wonFee * 24 * 60 * 60)) then
                local homeConfig = json.decode(v.configs)
                local items = exports['zero_inventory']:getBag('homes:'..homeName)
                zero.execute('zero_homes/sellHome', { home = homeName })
                zero.execute('zero_homes/delGarage', { home = homeName })
                zero.execute('zero_inventory:deleteBag', { bag_type = 'homes:'..homeName })
                
                zero.webhook('loseHouse', '```prolog\n[ZERO HOMES]\n[ACTION]: (CLEAN UP)\n[USER]: '..v.user_id..'\n[HOME]: '..homeName:upper()..'\n[TYPE]: '..homeConfig.type..'\n[TAX]: '..v.tax..' ('..os.date('%d/%m/%Y - %H:%M', v.tax)..')\n[ITEMS]:'..json.encode(items, { indent = true })..'\n[TABLE]: '..json.encode(homeConfig, { indent = true })..os.date('\n[DATA]: %d/%m/%Y [HORA]: %H:%M:%S')..' \r```')
                cleanupHouses = cleanupHouses + 1
            end
        end
    end
    print('^5[Zero Homes]^7 Casas liberadas: '..cleanupHouses)
end)

RegisterNetEvent('zero_homes:registerBuyedHomes', function(source)
    local query = zero.query('zero_homes/getHomes')
    for _, v in pairs(query) do buyedHomes[v.home] = true; end;
    vCLIENT.setBuyedHomes(source, buyedHomes)
end)

RegisterNetEvent('zero_homes:registerOwnerBlips', function(source, bool, table)
    if (bool) then
        for id, src in pairs(zero.getUsers()) do
            local myHomes = zero.query('zero_homes/userList', { user_id = id })
            if (parseInt(#myHomes) > 0) then
                for _, v in pairs(myHomes) do
                    local homeName = v.home
                    local homeConfig = json.decode(v.configs)

                    if (homeConfig.type == 'apartament') then homeName = string.sub(homeName, 1, -5); end;
                    local coord = configHomes[homeName].coord
                    setHouseBlip(src, homeName, coord)
                end
            end
            Citizen.Wait(5000)
        end
    else
        setHouseBlip(source, table[1], table[2])
    end
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