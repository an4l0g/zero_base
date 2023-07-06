local generalConfig = config.general
local configHomes = config.homes
local configType = config.typeHomes 

srv = {}
Tunnel.bindInterface(GetCurrentResourceName(), srv)
vCLIENT = Tunnel.getInterface(GetCurrentResourceName())
zeroClient = Tunnel.getInterface('zero')


zero._prepare('zero_homes/getHomeOwner', 'select * from zero_homes where home = @home AND home_owner = 1')
zero._prepare('zero_homes/buyHome', 'insert into zero_homes (user_id, home, home_owner, garages, tax, configs, vip) values (@user_id, @home, @home_owner, @garages, @tax, @configs, @vip)')
zero._prepare('zero_homes/homePermissions', 'select * from zero_homes where home = @home AND user_id = @user_id')
zero._prepare('zero_homes/countPermissions', 'select count(*) as qtd from zero_homes where home = @home')
zero._prepare('zero_homes/newPermissions', 'insert into zero_homes (user_id, home, home_owner, tax, garages, configs, vip) values (@user_id, @home, @home_owner, @tax, @garages, @configs, @vip)')

local checkPermission = function(user_id, permission)
    if (permission) then
        if (type(permission) == 'table') then
            for _, perm in pairs (permission) do
                if (zero.hasPermission(user_id, perm)) then
                    return true
                end
            end
            return false
        end
        return zero.hasPermission(user_id, permission)
    end
    return true
end

local nearestHomes = function(source)
    local ped = GetPlayerPed(source)
    local pCoord = GetEntityCoords(ped)
    local name = false
    for k, v in pairs(configHomes) do
        local distance = #(pCoord - v.coord)
        if (distance <= 0.5) then
            name = k
        end
    end
    return name
end

-- Não poder comprar casa tendo multa
-- Habilitar opção de comprar a casa com Credits
-- Fazer máximo de residências / Quem comprar + de 1 casa vai receber um alerta antes de comprar outra avisando que o iptu será mais caro em tal %

local tempHome = {}
local homeOpened = {}

srv.tryEnterHome = function(index)
    local source = source
    local user_id = zero.getUserId(source)
    local homes = configHomes[index]
    local homesType = configType[homes.type]
    if (not tempHome[source]) then
        if (user_id and index) then
            local ownerConsult = zero.query('zero_homes/getHomeOwner', { home = index })[1]
            if (ownerConsult) then
                -- [ Verificar taxa da casa ] --
                local taxTime = (ownerConsult.tax == -1 and ownerConsult.tax or parseInt(ownerConsult.tax))
                if (taxTime >= 0) then
                    if (os.time() >= parseInt((taxTime + generalConfig.lateFee) * 24 * 60 * 60)) then
                        TriggerClientEvent('notify', source, 'Homes', 'O <b>IPTU</b> da residência se encontra atrasado.')
                        return false
                    end
                end

                local homeConsult = zero.query('zero_homes/homePermissions', { home = index, user_id = user_id })[1]
                if (homeConsult) then
                    if (taxTime >= 0) then TriggerClientEvent('notify', source, 'Homes', 'O <b>IPTU</b> vence em: '..zero.getDayHours(generalConfig.lateFee * 24 * 60 * 60 - (os.time() - taxTime)), 10000); end;
                    local homeConfig = json.decode(homeConsult.configs)
                    
                    tempHome[source] = { oldCoords = GetEntityCoords(GetPlayerPed(source)) }
                    vCLIENT.enterHome(source, homeConfig.interior, index)
                else
                    if (homeOpened[index]) then
                        vCLIENT.enterHome(source, homeConfig.interior, index)
                    else
                        TriggerClientEvent('notify', source, 'Homes', 'Esta <b>residência</b> se encontra trancada.')
                    end
                end
            else
                if (checkPermission(user_id, homes.perm)) then
                    local price = homesType.price 
                    local request = zero.request(source, 'Esta propriedade se encontra à venda. Deseja adquiri-lá por R$'..zero.format(price)..'?', 30000)
                    if (request) then
                        local allow = false
                        if (not allow) then
                            -- allow = zero.tryFullPayment(user_id, price)
                            allow = true
                        end

                        if (allow) then
                            local tax = (homesType.tax[1] and os.time() or -1)
                            local table = {
                                price = price,
                                residents = (homesType.residents[1] and homesType.residents[2] or 0),
                                outfit = homesType.outfit.min,
                                chest = homesType.chest.min,
                                interior = homesType.interior._default
                            }

                            zero.execute('zero_homes/buyHome', { user_id = user_id, home = index, home_owner = 1, garages = 0, tax = tax, configs = json.encode(table), vip = 0 })
                            TriggerClientEvent('notify', source, 'Homes', 'A residência <b>'..index..'</b> foi adquirida por R$'..zero.format(price)..'.')
                        else
                            TriggerClientEvent('notify', source, 'Homes', 'Você não possui <b>dinheiro</b> o suficiente para adquirir esta residência.')
                        end
                    end
                else
                    TriggerClientEvent('notify', source, 'Homes', 'Você não possui <b>permissão</b> para comprar esta residência.')
                end
            end
        end
    else
        TriggerClientEvent('notify', source, 'Homes', 'Você está <b>bugado</b> o seu cache foi resetado.')
        tempHome[source] = nil
    end
end

RegisterCommand('homes', function(source, args)
    local source = source
    local user_id = zero.getUserId(source)
    if (user_id and args[1]) then
        args[1] = string.lower(args[1])
        if (args[1] == 'list') then
            TriggerClientEvent('zero_interactions:blips', source)
        elseif (args[1] == 'add') then
            TriggerEvent('zero_interactions:add', source)
        elseif (args[1] == 'trancar') then
            TriggerEvent('zero_interactions:trancar', source)
        end
    end
end)

RegisterNetEvent('zero_interactions:add')
AddEventHandler('zero_interactions:add', function(source)
    local source = source
    local user_id = zero.getUserId(source)
    if (user_id) then
        local prompt = zero.prompt(source, { 'Nome da Residência', 'Passaporte' })
        if (prompt) then
            local nUser = parseInt(prompt[2])
            if (nUser ~= user_id) then  
                local nIdentity = zero.getUserIdentity(nUser)
                if (nIdentity) then
                    local homeName = string.lower(prompt[1]):gsub('^%l', string.upper)
                    local homeConsult = zero.query('zero_homes/homePermissions', { home = homeName, user_id = user_id })[1]
                    if (homeConsult) and homeConsult.home_owner == 1 then
                        local homeConfig = json.decode(homeConsult.configs)

                        local homesCount = zero.query('zero_homes/countPermissions', { home = homeName })[1]
                        if (homesCount.qtd > homeConfig.residents) then
                            TriggerClientEvent('notify', source, 'Homes', 'A sua <b>residência</b> atingiu o máximo de moradores.')
                            return false
                        end

                        local userConsult = zero.query('zero_homes/homePermissions', { home = homeName, user_id = nUser })[1]
                        if (userConsult) then
                            TriggerClientEvent('notify', source, 'Homes', 'O <b>'..nIdentity.firstname..' '..nIdentity.lastname..'</b> já é morador desta residência.')
                        else
                            local table = {
                                price = homeConfig.price,
                                residents = homeConfig.residents,
                                outfit = homeConfig.outfit,
                                chest = homeConfig.chest,
                                interior = homeConfig.interior
                            }
                            zero.execute('zero_homes/newPermissions', { user_id = nUser, home = homeName, home_owner = 0, tax = 0, garages = 0, configs = json.encode(table), vip = 0 })
                        end
                    else
                        TriggerClientEvent('notify',  source, 'Homes', 'Você não é o <b>proprietário</b> desta residência.')
                    end
                else
                    TriggerClientEvent('notify', source, 'Homes', 'Este <b>passaporte</b> não existe em nossa cidade.')
                end
            else
                TriggerClientEvent('notify', source, 'Homes', 'Você não pode se adicionar de <b>morador</b>.')
            end
        end
    end
end)

-- TRANCAR PODE TRANCAR E DESTRANCAR DE DENTRO DA CASA TAMBÉM E BOTAR NA INTERAÇÃO

RegisterNetEvent('zero_interactions:trancar')
AddEventHandler('zero_interactions:trancar', function(source)
    local source = source
    local user_id = zero.getUserId(source)
    if (user_id) then
        local nearHomes = nearestHomes(source)
        if (nearHomes) then
            local homeConsult = zero.query('zero_homes/homePermissions', { home = nearHomes, user_id = user_id })[1]
            if (homeConsult) and homeConsult.home_owner == 1 then
                if (homeOpened[nearHomes]) then
                    homeOpened[nearHomes] = nil
                    TriggerClientEvent('notify', source, 'Homes', 'A residência <b>'..nearHomes..'</b> foi trancada.')
                else
                    homeOpened[nearHomes] = true
                    TriggerClientEvent('notify', source, 'Homes', 'A residência <b>'..nearHomes..'</b> foi destrancada.')
                end
            else
                TriggerClientEvent('notify',  source, 'Homes', 'Você não é o <b>proprietário</b> desta residência.')
            end
        else
            TriggerClientEvent('notify', source, 'Homes', 'Você não se encontra na porta da <b>residência</b>.')
        end
    end
end)

local cacheExecute = function(source)
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
            TriggerClientEvent('notify', k, 'Homes', 'O sistema de <b>homes</b> de nossa cidade foi reiniciado.')
            print('^5[Zero Homes]^7 o user_id ^5('..zero.getUserId(k)..')^7 foi retirado de dentro da casa.')
			cacheExecute(k)
        end
	end
end)