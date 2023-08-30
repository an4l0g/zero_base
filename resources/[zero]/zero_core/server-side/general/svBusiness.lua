local config = module('zero_core', 'cfg/cfgBusiness').empresa

local srv = {}
Tunnel.bindInterface('Business', srv)

zero.prepare('getBusiness', 'SELECT * FROM business WHERE business_owner = @user_id AND business_name = @name')
zero.prepare('getOwners', 'SELECT business_owner FROM business')
zero.prepare('setMoneyBusiness', 'UPDATE business SET business_safe = @safe WHERE business_name = @name AND business_owner = @user_id')
zero.prepare('setBusiness', 'INSERT INTO business(business_owner, business_name, business_safe) VALUES(@user_id, @name, @safe)')

local webhooks = {
    ['salario'] = 'https://discord.com/api/webhooks/1145784458121838723/2UvfV02Hp3y8GFvek0cNTVl-bhWtc5OIZ_osDTRaLPQZEnZgCa1VbO5Wai-Sc0MIMZAY',
    ['renovar'] = 'https://discord.com/api/webhooks/1145784804210638918/lZJ7tmy0FtckmoUpVr4JagRppyoSAR7g-RMHQUAOixI_PPch-zIjn2gr18rZ783aXby3',
    ['add'] = 'https://discord.com/api/webhooks/1145784942241005759/BfA7hskNPdaxn99buFg1ZrjnaoOs9EdUphFKueSXpv2Gx7f40m8zaervDbMACGPhbiKY'
}

local  tempBusiness = {}

srv.checkBusiness = function(business)
    local source = source
    local user_id = zero.getUserId(source)
    if (user_id) then
        local query = zero.query('getBusiness', { user_id = user_id, name = business })[1]
        if (query) then
            if (business == query['business_name']) and (user_id == query['business_owner']) then
                return true
            end           
        end
        TriggerClientEvent('notify', source, 'Empresa', 'Esta empresa não te <b>pertence</b>!')
        return false
    end
end

srv.saveTemp = function()
    local source = source
    local user_id = zero.getUserId(source)
    if (user_id) then 
        if (not tempBusiness[user_id]) then
            tempBusiness[user_id] = {
                oldCoords = GetEntityCoords(GetPlayerPed(source))
            }
        end
    end
end

srv.deleteTemp = function()
    local source = source
    local user_id = zero.getUserId(source)
    if (user_id) then 
        if (not tempBusiness[user_id]) then
            tempBusiness[user_id] = {
                oldCoords = GetEntityCoords(GetPlayerPed(source))
            }
        end
    end
end

srv.setBucket = function(amount)
    local source = source
    SetPlayerRoutingBucket(source, parseInt(amount))
end

local businessCooldown = {}

srv.getMoney = function(business)
    local source = source
    local user_id = zero.getUserId(source)
    if (user_id) then
        local identity = zero.getUserIdentity(user_id)
        if (not businessCooldown[business]) then
            busCooldown(business, parseInt(config[business]['cooldown']))
            local query = zero.query('getBusiness', { user_id = user_id, name = business })[1]
            if (query) then
                local random = math.random(config[business]['salary']['min'], config[business]['salary']['max'])
        
                zero.giveBankMoney(user_id, query['business_safe'])
                TriggerClientEvent('notify', source, 'Empresa', 'Você resgatou <b>R$'..query['business_safe']..'</b> da sua empresa.')   
                zero.webhook(webhooks['salario'],'```prolog\n[EMPRESAS BRAZUCA]\n[RESGATAR SALÁRIO]\n[NOME DA EMPRESA]: '..config[business].name..' \n[DONO DA EMPRESA]: '..user_id..' | '..identity.name..' '..identity.firstname..'\n[SACOU DA EMPRESA]: '..query['business_safe']..' '..os.date('\n[DATA]: %d/%m/%Y - [HORA]: %H:%M:%S')..' \r```')      
                zero.execute('setMoneyBusiness', { safe = random, name = business, user_id = user_id })
                zero.webhook(webhooks['renovar'],'```prolog\n[EMPRESAS BRAZUCA]\n[GERAR SALÁRIO]\n[NOME DA EMPRESA]: '..config[business].name..' \n[DONO DA EMPRESA]: '..user_id..' | '..identity.name..' '..identity.firstname..'\n[RENOVADO O FUNDO DA EMPRESA]: '..random..' '..os.date('\n[DATA]: %d/%m/%Y - [HORA]: %H:%M:%S')..' \r```')      
            end
        else
            TriggerClientEvent('notify', source, 'Empresa', 'Aguarde <b>'..businessCooldown[business]..'</b> segundos para resgatar o dinheiro da <b>empresa</b> novamente!')
        end
    end
end

addBusiness = function(playerId, business)
    local user_id = playerId
    if (user_id) then
        local identity = zero.getUserIdentity(playerId)
        local random = (math.random(config[business]['salary']['min'], config[business]['salary']['max']) or 0)
        zero.execute('setBusiness', { user_id = user_id, name = business, safe = random })
        zero.webhook(webhooks['add'],'```prolog\n[EMPRESAS BRAZUCA]\n[GANHOU A EMPRESA]\n[NOME DA EMPRESA]: '..config[business].name..' \n[NOVO DONO]: '..user_id..' | '..identity.name..' '..identity.firstname..'\n[FUNDO GERADO]: '..random..' '..os.date('\n[DATA]: %d/%m/%Y - [HORA]: %H:%M:%S')..' \r```')      
    end
end
exports('addBusiness', addBusiness)

busCooldown = function(business, time)
    Citizen.CreateThread(function()
        businessCooldown[business] = time
        while (businessCooldown[business] > 0) do
            Citizen.Wait(1000)
            businessCooldown[business] = businessCooldown[business] - 1
        end
        businessCooldown[business] = nil
    end)
end

RegisterNetEvent('zero_business:CacheExecute', function(source, user_id, quit)
    SetPlayerRoutingBucket(source, 0)
    local coord = tempBusiness[user_id].oldCoords
    if (tempBusiness[user_id]) then
        if (quit) then
            zero.setKeyDataTable(user_id, 'position', { x = coord.x, y = coord.y, z = coord.z })
        else
            zeroClient.teleport(source, coord.x, coord.y, coord.z)
        end
        tempBusiness[user_id] = nil
    end
end)

AddEventHandler('onResourceStop', function(resourceName)
  	if (GetCurrentResourceName() == resourceName) then 
		print('^5[Zero Business]^7 sistema stopado/reiniciado.')
        for k, _ in pairs(tempBusiness) do
            local user_id = k
            local _source = zero.getUserSource(user_id)
            if (user_id) then
                TriggerEvent('zero_business:CacheExecute', _source, k)
                TriggerClientEvent('notify', _source, 'Empresa', 'O sistema de <b>empresa</b> da nossa cidade foi reiniciado.')
                print('^5[Zero Business]^7 o user_id ^5('..user_id..')^7 foi retirado da empresa.')
            end
        end
	end
end)

AddEventHandler('zero:playerLeave', function(user_id, source)
	if (tempBusiness[user_id]) then
        TriggerEvent('zero_business:CacheExecute', source, user_id, true)
        print('^5[Zero Business]^7 o user_id ^5('..user_id..')^7 foi retirado da empresa.')
    end
end)