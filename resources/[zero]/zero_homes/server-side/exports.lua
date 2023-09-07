homesActions = {}

local permission = {
    ['apartament'] = function(user_id, homeName)
        homeName = homeName..'%'
        local homeConsult = zero.query('zero_homes/apartamentPermissions', { home = homeName, user_id = user_id })[1]
        if (homeConsult) then
            return true
        end
        return false
    end,
    ['home'] = function(user_id, homeName)
        local homeConsult = zero.query('zero_homes/homePermissions', { home = homeName, user_id = user_id })[1]
        if (homeConsult) then
            return true
        end
        return false
    end
}

local checkHomePermission = function(user_id, homeName)
    local _config = configHomes[homeName]
    if (_config) then
        local isApartament = (_config.type == 'apartament' and 'apartament' or 'home')
        return permission[isApartament](user_id, homeName)
    end
end
exports('checkHomePermission', checkHomePermission)

local checkHomeOwner = function(user_id, prompt)
    local homeName = capitalizeString(prompt)
    local homeConsult = zero.query('zero_homes/homePermissions', { home = homeName, user_id = user_id })[1]
    if (homeConsult) and homeConsult.home_owner == 1 then
        local homeConfig = json.decode(homeConsult.configs)
        return true, homeName, homeConfig, configType[homeConfig.type], homeConfig.type, homeConsult
    end
    serverNotify(zero.getUserSource(user_id), 'Você não é o <b>proprietário</b> desta residência.')
    return false
end

generateApartamentName = function(name)
    local newName = ''
    local suffix = ''
    local counter = 1
    repeat
        suffix = string.format('%04d', counter)
        local apartamentName = name..suffix  
        local existingApartament = zero.query('zero_homes/selectHomes', { home = apartamentName })[1]
        if (not existingApartament) then newName = apartamentName end;
        counter = (counter + 1)
    until (newName ~= '')
    return newName
end
exports('generateApartamentName', generateApartamentName)

insideHome = function(source)
    local homeName = vCLIENT.homeName(source)
    if (homeName ~= '') then
        return true, homeName
    end
    return false
end
exports('insideHome', insideHome)

nearestHomes = function(source)
    local name = false
    for k, v in pairs(configHomes) do
        local distance = #(GetEntityCoords(GetPlayerPed(source)) - v.coord)
        if (distance <= 0.5) then
            name = k
        end
    end
    return name
end
exports('nearestHomes', nearestHomes)

homesAdd = function(source)
    local user_id = zero.getUserId(source)
    if (user_id) and not homesActions[user_id] then
        homesActions[user_id] = true

        local prompt = zero.prompt(source, { 'Nome da Residência', 'Passaporte' })
        if (not prompt) then homesActions[user_id] = nil; return; end;

        local nUser = tonumber(prompt[2])
        local nIdentity = zero.getUserIdentity(nUser)
        if (nUser ~= user_id and nIdentity) then  
            local response, homeName, homeConfig, homesType, homeType, homeConsult = checkHomeOwner(user_id, prompt[1])
            if (response) then
                local homesCount = zero.query('zero_homes/countPermissions', { home = homeName })[1]
                if (homesCount.qtd > homeConfig.residents) then
                    homesActions[user_id] = nil
                    serverNotify(source, 'A sua residência <b>'..homeName..'</b> atingiu o máximo de moradores.')
                    return false
                end

                local userConsult = zero.query('zero_homes/homePermissions', { home = homeName, user_id = nUser })[1]
                if (userConsult) then
                    serverNotify(source, 'O <b>'..nIdentity.firstname..' '..nIdentity.lastname..'</b> já é morador desta residência.')
                else
                    local table = {
                        price = homesType.price,
                        residents = (homesType.residents[1] and homesType.residents[2] or 0),
                        chest = homesType.chest.min,
                        interior = homesType.interior._default,
                        type = homeType
                    }
                    
                    local decoration = configInterior[homesType.interior._default]
                    if (decoration) then table.decorations = (decoration.decorations and decoration.decorations._default or 0); end;
                    
                    zero.execute('zero_homes/newPermissions', { user_id = nUser, home = homeName, home_owner = 0, tax = 0, garages = 0, configs = json.encode(table), vip = 0 })
                    zero.webhook('addHouse', '```prolog\n[ZERO HOMES]\n[ACTION]: (ADD RESIDENT)\n[USER]: '..user_id..'\n[ADD]: '..nUser..'\n[HOME]: '..homeName:upper()..'\n[TYPE]: '..homeType..'\n[TABLE]: '..json.encode(homeConfig, { indent = true })..os.date('\n[DATA]: %d/%m/%Y [HORA]: %H:%M:%S')..' \r```')
                    serverNotify(source, 'O <b>'..nIdentity.firstname..' '..nIdentity.lastname..'</b> foi adicionado em sua residência <b>'..homeName..'.')

                    local nSource = zero.getUserSource(nUser)
                    if (homeConsult.garages == 1) then
                        local gar = zero.query('zero_homes/getGarage', { home = homeName })[1]
			            if (gar) then
                            local blip = json.decode(gar.blip)
				            local spawn = json.decode(gar.spawn)
                            TriggerEvent('zero_homes:addGarage', nSource, homeName, blip, spawn)
                        end
                    end
                end
            end
        else
            local text = (nUser == user_id and 'Você não pode se adicionar na <b>residência</b>.' or 'Este <b>passaporte</b> não existe em nossa cidade.')
            serverNotify(source, text)
        end      
        homesActions[user_id] = nil
    end
end
exports('homesAdd', homesAdd)

homesRem = function(source)
    local user_id = zero.getUserId(source)
    if (user_id) and not homesActions[user_id] then
        homesActions[user_id] = true
        local prompt = zero.prompt(source, { 'Nome da Residência', 'Passaporte' })
        if (not prompt) then homesActions[user_id] = nil; return; end;

        local nUser = tonumber(prompt[2])
        local nIdentity = zero.getUserIdentity(nUser)
        if (nUser ~= user_id and nIdentity) then  
            local response, homeName, homeConfig, homesType, homeType, homeConsult = checkHomeOwner(user_id, prompt[1])
            if (response) then
                local userConsult = zero.query('zero_homes/homePermissions', { home = homeName, user_id = nUser })[1]
                if (userConsult) then
                    zero.execute('zero_homes/removePermissions', { home = homeName, user_id = nUser })
                    serverNotify(source, 'O <b>'..nIdentity.firstname..' '..nIdentity.lastname..'</b> foi removido de sua residência.')
                    zero.webhook('remHouse', '```prolog\n[ZERO HOMES]\n[ACTION]: (REM RESIDENT)\n[USER]: '..user_id..'\n[REM]: '..nUser..'\n[HOME]: '..homeName:upper()..'\n[TYPE]: '..homeType..'\n[TABLE]: '..json.encode(homeConfig, { indent = true })..os.date('\n[DATA]: %d/%m/%Y [HORA]: %H:%M:%S')..' \r```')
                    
                    local nSource = zero.getUserSource(nUser)
                    if (homeConsult.garages == 1) then
                        TriggerClientEvent('zero_garage:removeGarage', nSource, homeName)
                    end
                else
                    serverNotify(source, 'O <b>'..nIdentity.firstname..' '..nIdentity.lastname..'</b> não é morador desta residência.')
                end
            end
        else
            local text = (nUser == user_id and 'Você não pode se remover da <b>residência</b>.' or 'Este <b>passaporte</b> não existe em nossa cidade.')
            serverNotify(source, text)
        end
        homesActions[user_id] = nil
    end
end
exports('homesRem', homesRem)

local _homesTrancar = {
    ['near'] = function(source, nearHomes, inside, homeName)
        if (nearHomes) then
            if (homeOpened[nearHomes]) then
                homeOpened[nearHomes] = nil
                serverNotify(source, 'A residência <b>'..nearHomes..'</b> foi trancada.')
            else
                homeOpened[nearHomes] = true
                serverNotify(source, 'A residência <b>'..nearHomes..'</b> foi destrancada.')
            end
        end
    end,
    ['inside'] = function(source, nearHomes, inside, homeName)
        if (inside) then
            if (homeOpened[homeName]) then
                homeOpened[homeName] = nil
                serverNotify(source, 'A residência <b>'..homeName..'</b> foi trancada.')
            else
                homeOpened[homeName] = true
                serverNotify(source, 'A residência <b>'..homeName..'</b> foi destrancada.')
            end
        else
            serverNotify(source, 'Você não se encontra na porta ou dentro da <b>residência</b>.')
        end
    end,
}

homesTrancar = function(source)
    local user_id = zero.getUserId(source)
    if (user_id) then
        local nearHomes = nearestHomes(source)
        local homes = configHomes[nearHomes]
        local nearHomesType = (homes and homes.type or false)
        if (nearHomesType ~= 'apartament') then
            local homeConsult = zero.query('zero_homes/homePermissions', { home = nearHomes, user_id = user_id })[1]
            if (homeConsult) and homeConsult.home_owner == 1 then
                local inside, homeName = insideHome(source)
                _homesTrancar[nearHomes and 'near' or 'inside'](source, nearHomes, inside, homeName)
            else
                serverNotify(source, 'Você não é o <b>proprietário</b> desta residência.')
            end
        else
            nearHomes = nearHomes..'%'
            local ownerConsult = zero.query('zero_homes/getApartamentOwner', { user_id = user_id, home = nearHomes })[1]
            if (ownerConsult) then
                local inside, homeName = insideHome(source)
                _homesTrancar[nearHomes and 'near' or 'inside'](source, ownerConsult.home, inside, ownerConsult.home)
            else
                serverNotify(source, 'Você não é o <b>proprietário</b> desta residência.')
            end
        end
    end
end
exports('homesTrancar', homesTrancar)

homesTrans = function(source)
    local user_id = zero.getUserId(source)
    if (user_id) and not homesActions[user_id] then
        homesActions[user_id] = true
        local prompt = zero.prompt(source, { 'Nome da Residência', 'Passaporte' })
        if (not prompt) then homesActions[user_id] = nil; return; end;

        local nUser = tonumber(prompt[2])
        local nIdentity = zero.getUserIdentity(nUser)
        if (nUser ~= user_id and nIdentity) then  
            local response, homeName, homeConfig, homesType, homeType, homeConsult = checkHomeOwner(user_id, prompt[1])
            if (response) then
                if (homeType == 'mlo' or homeConsult.vip > 0) then 
                    homesActions[user_id] = nil
                    serverNotify(source, 'Você não pode realizar esta interação numa residência <b>VIP</b>.') 
                    return
                end

                local request = zero.request(source, 'Você deseja transferir a residência '..homeName..' para o '..nIdentity.firstname..' '..nIdentity.lastname..'?', 30000)
                if (request) then
                    local items = exports['zero_inventory']:getBag('homes:'..homeName)
                    zero.execute('zero_homes/removeResidents', { home = homeName })
                    zero.execute('zero_homes/updateOwner', { home = homeName, user_id = user_id, nuser_id = nUser })
                    serverNotify(source, 'Você transferiu a sua <b>residência</b> para o '..nIdentity.firstname..' '..nIdentity.lastname..'.')
                    zero.webhook('transferHouse', '```prolog\n[ZERO HOMES]\n[ACTION]: (TRANSFER RESIDENT)\n[OLD OWNER]: '..user_id..'\n[NEW OWNER]: '..nUser..'\n[HOME]: '..homeName:upper()..'\n[TYPE]: '..homeType..'\n[TAX IN]: '..homeConsult.tax..' ('..os.date('%d/%m/%Y - %H:%M', homeConsult.tax)..')\n[ITEMS]: '..json.encode(items, { indent = true })..'\n[TABLE]: '..json.encode(homeConfig, { indent = true })..os.date('\n[DATA]: %d/%m/%Y [HORA]: %H:%M:%S')..' \r```')
                end
            end
        else
            local text = (nUser == user_id and 'Você não pode transferir a <b>residência</b> para si mesmo.' or 'Este <b>passaporte</b> não existe em nossa cidade.')
            serverNotify(source, text)
        end
        homesActions[user_id] = nil
    end
end
exports('homesTrans', homesTrans)

homesVender = function(source)
    local user_id = zero.getUserId(source)
    if (user_id) and not homesActions[user_id] then
        homesActions[user_id] = true

        local prompt = zero.prompt(source, { 'Nome da Residência' })
        if (not prompt) then homesActions[user_id] = nil; return; end;

        local response, homeName, homeConfig, homesType, homeType, homeConsult = checkHomeOwner(user_id, prompt[1])
        if (response) then
            local homePrice = parseInt(homeConfig.price * generalConfig.percentageSell)

            if (homeType == 'mlo' or homeConsult.vip > 0) then 
                homesActions[user_id] = nil
                serverNotify(source, 'Você não pode realizar esta interação numa residência <b>VIP</b>.') 
                return
            end

            local request = zero.request(source, 'Você deseja vender a residência '..homeName..' para a prefeitura por R$'..zero.format(homePrice)..'?', 30000)
            if (request) then
                local items = exports['zero_inventory']:getBag('homes:'..homeName)
                zero.execute('zero_homes/sellHome', { home = homeName })
                zero.execute('zero_homes/delGarage', { home = homeName })
                zero.execute('zero_inventory:deleteBag', { bag_type = 'homes:'..homeName })
                zero.giveBankMoney(user_id, homePrice)
                exports.zero_bank:extrato(user_id, 'Venda da casa', homePrice)
                TriggerClientEvent('zero_garage:removeGarage', source, homeName)
                zero.webhook('sellHouse', '```prolog\n[ZERO HOMES]\n[ACTION]: (SELL HOUSE)\n[USER]: '..user_id..'\n[HOME]: '..homeName:upper()..'\n[TYPE]: '..homeType..'\n[VALUE RECEIVED]: '..homePrice..'\n[ITEMS]: '..json.encode(items, { indent = true })..'\n[REMOVED HOUSE]: items and garages and upgrades\n[TABLE]: '..json.encode(homeConfig, { indent = true })..os.date('\n[DATA]: %d/%m/%Y [HORA]: %H:%M:%S')..' \r```')
                serverNotify(source, 'Você vendeu a residência <b>'..homeName..'</b> para a prefeitura por R$'..zero.format(homePrice)..'.')                    
            end
        end
        homesActions[user_id] = nil
    end
end
exports('homesVender', homesVender)

homesChecar = function(source)
    local user_id = zero.getUserId(source)
    if (user_id) and not homesActions[user_id] then
        homesActions[user_id] = true

        local prompt = zero.prompt(source, { 'Nome da Residência' })
        if (not prompt) then homesActions[user_id] = nil; return; end;

        local response, homeName, homeConfig, homesType, homeType, homeConsult = checkHomeOwner(user_id, prompt[1])
        if (response) then
            local query = zero.query('zero_homes/selectHomes', { home = homeName })
            local permList = ''
            for k, v in pairs(query) do
                local identity = zero.getUserIdentity(v.user_id)
                if (identity) then
                    permList = permList..'Passaporte: <b>'..tostring(v.user_id)..'</b><br>Nome: <b>'..identity.firstname..' '..identity.lastname..'</b>'
                else
                    permList = permList..'Passaporte: <b>'..tostring(v.user_id)..'</b><br>Nome: <b>Indivíduo Indigente</b>'
                end
                if (k ~= #query) then permList = permList..' <br><br>'; end;
            end
            serverNotify(source, 'Moradores da residência <b>'..homeName..'</b>: <br><br>'..permList, 10000)
        end            
        homesActions[user_id] = nil
    end
end
exports('homesChecar', homesChecar)

homesTax = function(source)
    local user_id = zero.getUserId(source)
    if (user_id) and not homesActions[user_id] then
        homesActions[user_id] = true

        local prompt = zero.prompt(source, { 'Nome da Residência' })
        if (not prompt) then homesActions[user_id] = nil; return; end;

        local response, homeName, homeConfig, homesType, homeType, homeConsult = checkHomeOwner(user_id, prompt[1])
        if (response) then
            local homesTax = parseInt(homeConsult.tax)
            if (homesTax >= 0) then
                local taxPrice = parseInt(homeConfig.price * generalConfig.taxPrice)
                local request = zero.request(source, 'Deseja pagar o IPTU da residência '..homeName..' por R$'..zero.format(taxPrice)..'?', 30000)
                if (request) then
                    if (zero.tryFullPayment(user_id, taxPrice)) then
                        exports.zero_bank:extrato(user_id, 'IPTU', -taxPrice)
                        zero.execute('zero_homes/updateTax', { home = homeName, tax = os.time() })
                        serverNotify(source, 'O <b>IPTU</b> da sua residência foi pago com sucesso.')
                        zero.webhook('buyTax', '```prolog\n[ZERO HOMES]\n[ACTION]: (BUY TAX)\n[USER]: '..user_id..'\n[HOME]: '..homeName:upper()..'\n[TYPE]: '..homeType..'\n[PRICE]: '..taxPrice..'\n[TAX RENEWED]: '..homesTax..' ('..os.date('%d/%m/%Y - %H:%M', homesTax)..')\n[TABLE]: '..json.encode(homeConfig, { indent = true })..os.date('\n[DATA]: %d/%m/%Y [HORA]: %H:%M:%S')..' \r```')
                    else
                        serverNotify(source, 'Você não possui dinheiro suficiente para pagar o <b>IPTU</b> de sua residência.')
                    end
                end
            end
        end            
        homesActions[user_id] = nil
    end
end
exports('homesTax', homesTax)

homesOther = function(source)
    local user_id = zero.getUserId(source)
    if (user_id) then
        local result = zero.query('zero_homes/userList', { user_id = user_id })
        if (#result >= 1) then
            local permList = ''
            for k, v in pairs(result) do
                local taxTime = (v.tax == -1 and v.tax or parseInt(v.tax))
                permList = permList..'Residência: <b>'..v.home..'</b><br>IPTU: <b>'..zero.getDayHours(generalConfig.lateFee * 24 * 60 * 60 - (os.time() - taxTime))..'</b>'                
                if (k ~= #result) then permList = permList..' <br><br>'; end;
            end
            serverNotify(source, 'Suas residências:<br><br>'..permList, 10000)
        end
    end
end
exports('homesOther', homesOther)

homesInterior = function(source)
    local user_id = zero.getUserId(source)
    if (user_id) then
        local prompt = zero.prompt(source, { 'Nome da Residência' })
        if (not prompt) then return; end;

        local response, homeName, homeConfig, homesType, homeType, homeConsult = checkHomeOwner(user_id, prompt[1])
        if (response) then
            local homes = configHomes[homeName]
            local text = ''
            if (homeType == 'apartament') then homeName = string.sub(homeName, 1, -5); end;
            for k, v in pairs(configType[homeType].interior) do
                if (k ~= '_default') then 
                    local interiorName = configInterior[k].name
                    local interiorValue = (k == homeConfig.interior) and '(Atual)<br>Decoração: <b>'..(v.decoration and 'Disponível' or 'Indisponível')..'</b>' or '<br>Valor: <b>R$'..zero.format(v.value)..'</b><br>Decoração: <b>'..(v.decoration and 'Disponível' or 'Indisponível')..'</b>'
                    text = text..'<br><br>Interior: <b>'..interiorName..'</b> '..interiorValue
                end
            end
            serverNotify(source, 'Interiores disponíveis em sua <b>residência</b>:'..text, 30000)
        end
    end
end
exports('homesInterior', homesInterior)

updateInterior = function(source, interior)
    local user_id = zero.getUserId(source)
    if (user_id) and not homesActions[user_id] then
        homesActions[user_id] = true

        local prompt = zero.prompt(source, { 'Nome da Residência' })
        if (not prompt) then homesActions[user_id] = nil; return; end;

        local response, homeName, homeConfig, homesType, homeType, homeConsult = checkHomeOwner(user_id, prompt[1])
        if (response) then
            local interiorType = configType[homeType].interior[interior]
            if (interiorType) then
                if (zero.checkPermissions(user_id, interiorType.perm)) then
                    if (interior ~= homeConfig.interior) then
                        local request = zero.request(source, 'Você deseja alterar o interior da sua residência '..homeName..' para '..configInterior[interior].name..' por R$'..zero.format(interiorType.value)..'?', 30000)
                        if (request) then
                            if (zero.tryFullPayment(user_id, interiorType.value)) then
                                exports.zero_bank:extrato(user_id, 'Upgrade Homes', -interiorType.value)
                                local items = exports['zero_inventory']:getBag('homes:'..homeName)
                                zero.webhook('buyInterior', '```prolog\n[ZERO HOMES]\n[ACTION]: (BUY INTERIOR)\n[USER]: '..user_id..'\n[HOME]: '..homeName:upper()..'\n[TYPE]: '..homeType..'\n[PRICE]: '..interiorType.value..'\n[OLD INTERIOR]: '..homeConfig.interior..'\n[NEW INTERIOR]: '..interior..'\n[ITEMS]: '..json.encode(items, { indent = true })..'\n[TABLE]: '..json.encode(homeConfig, { indent = true })..os.date('\n[DATA]: %d/%m/%Y [HORA]: %H:%M:%S')..' \r```')
                                if (homeConfig.decorations ~= 0) then homeConfig.decorations = 0 end;
                                if (interior == 'eclip_penthouse') then homeConfig.decorations = 'executive' end;
                                homeConfig.interior = interior
                                zero.execute('zero_homes/updateConfig', { configs = json.encode(homeConfig), home = homeName })
                                serverNotify(source, 'O interior de sua residência <b>'..homeName..'</b> foi alterado com sucesso.')
                            else
                                serverNotify(source, 'Você não possui <b>dinheiro</b> o suficiente para atualizar o interior de sua residência.')
                            end
                        end
                    else
                        serverNotify(source, 'Este é o <b>interior</b> atual de sua residência. Por gentileza, escolha outro.')
                    end
                else
                    serverNotify(source, 'Você não tem <b>permissão</b> para atualizar o interior da sua residência.')
                end
            else
                serverNotify(source, 'Você não pode utilizar este interior numa residência <b>'..homeType:upper()..'</b>.')
            end
        end
        homesActions[user_id] = nil
    end
end
exports('updateInterior', updateInterior)

homesDecoration = function(source)
    local user_id = zero.getUserId(source)
    if (user_id) then

        local prompt = zero.prompt(source, { 'Nome da Residência' })
        if (not prompt) then homesActions[user_id] = nil; return; end;

        local response, homeName, homeConfig, homesType, homeType, homeConsult = checkHomeOwner(user_id, prompt[1])
        if (response) then
            local homeDecoration = configInterior[homeConfig.interior].decorations
            if (homeDecoration) then
                local text = ''
                for k, v in pairs(homeDecoration) do
                    if (k ~= '_default' and k ~= '_perm') then 
                        local interiorValue = (k == homeConfig.decorations) and '(Atual)' or '<br>Valor: <b>R$'..zero.format(v.value)..'</b>'
                        text = text..'<br><br>Interior: <b>'..v.name..'</b> '..interiorValue
                    end
                end
                serverNotify(source, 'Decorações disponíveis em sua residência <b>'..homeName..'</b>:'..text, 30000)
            else
                serverNotify(source, 'O interior atual de sua residência <b>'..homeName..'</b> não possui <b>decoração</b>. Saiba qual interior de sua residência possui decoração na lista de interiores.')
            end
        end
    end
end
exports('homesDecoration', homesDecoration)

updateDecoration = function(source, decoration)
    local user_id = zero.getUserId(source)
    if (user_id) and not homesActions[user_id] then
        homesActions[user_id] = true

        local prompt = zero.prompt(source, { 'Nome da Residência' })
        if (not prompt) then homesActions[user_id] = nil; return; end;

        local response, homeName, homeConfig, homesType, homeType, homeConsult = checkHomeOwner(user_id, prompt[1])
        if (response) then
            local homeDecoration = configInterior[homeConfig.interior].decorations
            if (homeDecoration) then
                if (homeDecoration[decoration]) then
                    if (zero.checkPermissions(user_id, homeDecoration['_perm'])) then
                        if (decoration ~= homeConfig.decorations) then
                            local request = zero.request(source, 'Você deseja alterar o interior da sua residência '..homeName..' para '..homeDecoration[decoration].name..' por R$'..zero.format(homeDecoration[decoration].value)..'?', 30000)
                            if (request) then
                                if (zero.tryFullPayment(user_id, homeDecoration[decoration].value)) then
                                    exports.zero_bank:extrato(user_id, 'Upgrade Homes', -homeDecoration[decoration].value)
                                    local items = exports['zero_inventory']:getBag('homes:'..homeName)
                                    zero.webhook('buyDecoration', '```prolog\n[ZERO HOMES]\n[ACTION]: (BUY DECORATION)\n[USER]: '..user_id..'\n[HOME]: '..homeName:upper()..'\n[TYPE]: '..homeType..'\n[PRICE]: '..homeDecoration[decoration].value..'\n[OLD DECORATION]: '..homeConfig.decorations..'\n[NEW DECORATION]: '..decoration..'\n[ITEMS]: '..json.encode(items, { indent = true })..'\n[TABLE]: '..json.encode(homeConfig, { indent = true })..os.date('\n[DATA]: %d/%m/%Y [HORA]: %H:%M:%S')..' \r```')
                                    homeConfig.decorations = decoration
                                    zero.execute('zero_homes/updateConfig', { configs = json.encode(homeConfig), home = homeName })
                                    serverNotify(source, 'A decoração de sua residência <b>'..homeName..'</b> foi alterada com sucesso.')
                                else
                                    serverNotify(source, 'Você não possui <b>dinheiro</b> o suficiente para atualizar a decoração de sua residência.')
                                end
                            end
                        else
                            serverNotify(source, 'Esta é a <b>decoração</b> atual de sua residência. Por gentileza, escolha outro.')
                        end
                    else
                        serverNotify(source, 'Você não tem <b>permissão</b> para atualizar a decoração da sua residência.')
                    end
                else
                    serverNotify(source, 'Esta decoração <b>'..decoration:upper()..'</b> é inexistente.')
                end
            else
                serverNotify(source, 'O interior atual de sua residência <b>'..homeName..'</b> não possui <b>decoração</b>. Saiba qual interior de sua residência possui <b>decoração</b> na lista de interiores.')
            end
        end
        homesActions[user_id] = nil
    end
end
exports('updateDecoration', updateDecoration)

homesBau = function(source)
    local user_id = zero.getUserId(source)
    if (user_id) then
        homesActions[user_id] = true

        local prompt = zero.prompt(source, { 'Nome da Residência' })
        if (not prompt) then homesActions[user_id] = nil; return; end;

        local response, homeName, homeConfig, homesType, homeType, homeConsult = checkHomeOwner(user_id, prompt[1])
        if (response) then
            local homes = configHomes[homeName]
            local chest = configType[homeType].chest
            if (zero.checkPermissions(user_id, chest.perm) and homes) then
                local _upgrade = zero.prompt(source, { 'Aumentar o baú (Atual: '..homeConfig.chest..' | Min: '..chest.min..'kg/Máx: '..chest.max..'kg)' })[1]
                if (_upgrade) then
                    _upgrade = tonumber(_upgrade)
                    if (_upgrade <= chest.max) then
                        if (_upgrade ~= homeConfig.chest and _upgrade > homeConfig.chest) then
                            local price = parseInt(_upgrade * chest.value)
                            local request = zero.request(source, 'Você deseja pagar R$'..zero.format(price)..', para aumentar o baú de sua residência '..homeName..'?', 30000)
                            if (request) then
                                if (zero.tryFullPayment(user_id, price)) then
                                    exports.zero_bank:extrato(user_id, 'Upgrade Homes', -price)
                                    local items = exports['zero_inventory']:getBag('homes:'..homeName)
                                    zero.webhook('buyChest', '```prolog\n[ZERO HOMES]\n[ACTION]: (BUY CHEST)\n[USER]: '..user_id..'\n[HOME]: '..homeName:upper()..'\n[TYPE]: '..homeType..'\n[PRICE]: '..price..'\n[OLD CHEST]: '..homeConfig.chest..'kg\n[NEW CHEST]: '.._upgrade..'kg\n[ITEMS]: '..json.encode(items, { indent = true })..'\n[TABLE]: '..json.encode(homeConfig, { indent = true })..os.date('\n[DATA]: %d/%m/%Y [HORA]: %H:%M:%S')..' \r```')
                                    homeConfig.chest = _upgrade
                                    zero.execute('zero_homes/updateConfig', { configs = json.encode(homeConfig), home = homeName })
                                    serverNotify(source, 'Você aumentou o baú da sua residência <b>'..homeName..'</b> com sucesso.')
                                else
                                    serverNotify(source, 'Você não possui <b>dinheiro</b> o suficiente para comprar upgrade para o seu baú.')
                                end
                            end
                        else
                            local text = (_upgrade < homeConfig.chest and 'Você não pode colocar um peso menor do que o atual de sua residência <b>'..homeName..'</b>' or 'Este já é o peso atual do baú de sua residência <b>'..homeName..'</b>.')
                            serverNotify(source, text)
                        end
                    else
                        serverNotify(source, 'Você pois um peso maior do que o máximo de sua residência <b>'..homeName..'</b> permite que seria de <b>'..chest.max..'kg</b>.')
                    end
                end
            else
                serverNotify(source, 'Você não tem <b>permissão</b> para aumentar o baú da sua residência.')
            end
        end
        homesActions[user_id] = nil
    end
end
exports('homesBau', homesBau)

homesGaragem = function(source)
    local inside, homeName = insideHome(source)
    if (inside) then serverNotify(source, 'Você não pode adicionar garagem dentro da sua <b>residência</b>.') return; end;

    local user_id = zero.getUserId(source)
    if (user_id) and not homesActions[user_id] then
        homesActions[user_id] = true
        
        local prompt = zero.prompt(source, { 'Nome da Residência' })
        if (not prompt) then homesActions[user_id] = nil; return; end;

        local response, homeName, homeConfig, homesType, homeType, homeConsult = checkHomeOwner(user_id, prompt[1])
        if (response) then
            local homes = configHomes[homeName]
            local garage = (configType[homeType] and configType[homeType].garage or false)
            if (garage[1]) then
                if (homeConsult.garages == 0) then
                    if (#(GetEntityCoords(GetPlayerPed(source)) - homes.coord) <= 15.0) then
                        local finish, coords = vCLIENT.createGarage(source, homes.coord)
                        if (finish and coords.spawn and coords.blip) then
                            local price = garage[2]
                            local request = zero.request(source, 'Você deseja pagar R$'..zero.format(price)..', para adicionar uma garagem em sua residência '..homeName..'?', 30000)
                            if (request) then
                                if (zero.tryFullPayment(user_id, price)) then
                                    exports.zero_bank:extrato(user_id, 'Upgrade Homes', -price)
                                    zero.execute('zero_homes/updateGarages', { home = homeName, garages = 1 })
                                    zero.execute('zero_homes/addGarage', { home = homeName, blip = json.encode(coords.blip), spawn = json.encode(coords.spawn) })
                                    serverNotify(source, 'Você comprou uma garagem para a sua residência <b>'..homeName..'</b>.')
                                    TriggerEvent('zero_homes:addGarage', source, homeName, coords.blip, coords.spawn)
                                    zero.webhook('buyGarage', '```prolog\n[ZERO HOMES]\n[ACTION]: (BUY GARAGE)\n[USER]: '..user_id..'\n[HOME]: '..homeName:upper()..'\n[TYPE]: '..homeType..'\n[PRICE]: '..price..'\n[COORDS]: '..json.encode({ blip = coords.blip, spawn = coords.spawn }, { indent = true })..'\n[TABLE]: '..json.encode(homeConfig, { indent = true })..os.date('\n[DATA]: %d/%m/%Y [HORA]: %H:%M:%S')..' \r```')
                                else
                                    serverNotify(source, 'Você não possui <b>dinheiro</b> o suficiente para comprar uma garagem.')
                                end
                            end
                        end
                    else
                        serverNotify(source, 'Você não se encontra próximo de sua residência <b>'..homeName..'</b>.')
                    end
                else
                    serverNotify(source, 'Você já possui uma garagem em sua residência <b>'..homeName..'</b>.')
                end
            else
                serverNotify(source, 'Você não pode adicionar garagem nesta residência <b>'..homeName..'</b>.')
            end
        end
        homesActions[user_id] = nil
    end
end
exports('homesGaragem', homesGaragem)

local _homesLacrar = {
    ['near'] = function(source, nearHomes, inside, homeName)
        if (nearHomes) then
            homeOpened[nearHomes] = nil
            serverNotify(source, 'A residência <b>'..nearHomes..'</b> foi lacrada.')

            local items = exports['zero_inventory']:getBag('homes:'..nearHomes)
            zero.webhook('sealHouse', '```prolog\n[ZERO HOMES]\n[ACTION]: (SEAL HOUSE)\n[OFFICER]: '..zero.getUserId(source)..'\n[HOME]: '..nearHomes:upper()..'\n[ITEMS]: '..json.encode(items, { indent = true })..os.date('\n[DATA]: %d/%m/%Y [HORA]: %H:%M:%S')..' \r```')
        end
    end,
    ['inside'] = function(source, nearHomes, inside, homeName)
        if (inside) then
            homeOpened[homeName] = nil
            serverNotify(source, 'A residência <b>'..homeName..'</b> foi lacrada.')

            local items = exports['zero_inventory']:getBag('homes:'..homeName)
            zero.webhook('sealHouse', '```prolog\n[ZERO HOMES]\n[ACTION]: (SEAL HOUSE)\n[OFFICER]: '..zero.getUserId(source)..'\n[HOME]: '..homeName:upper()..'\n[ITEMS]: '..json.encode(items, { indent = true })..os.date('\n[DATA]: %d/%m/%Y [HORA]: %H:%M:%S')..' \r```')
        else
            serverNotify(source, 'Você não se encontra na porta ou dentro da <b>residência</b>.')
        end
    end,
}

homesLacrar = function(source)
    local user_id = zero.getUserId(source)
    if (user_id) then
        local nearHomes = nearestHomes(source)
        local homes = configHomes[nearHomes]
        local nearHomesType = (homes and homes.type or false)
        if (nearHomesType ~= 'apartament') then
            local homeConsult = zero.query('zero_homes/getHomeOwner', { home = nearHomes })[1]
            if (homeConsult) then
                local inside, homeName = insideHome(source)
                _homesLacrar[nearHomes and 'near' or 'inside'](source, nearHomes, inside, homeName)
            else
                serverNotify(source, 'Você não pode lacrar uma residência que não possui <b>dono</b>.')
            end
        else
            nearHomes = nearHomes..'%'
            local ownerConsult = zero.query('zero_homes/getApartamentOwnerWithoutUser', { home = nearHomes })[1]
            if (ownerConsult) then
                local inside, homeName = insideHome(source)
                _homesLacrar[nearHomes and 'near' or 'inside'](source, ownerConsult.home, inside, ownerConsult.home)
            else
                serverNotify(source, 'Você não pode lacrar uma residência que não possui <b>dono</b>.')
            end
        end
    end
end
exports('homesLacrar', homesLacrar)