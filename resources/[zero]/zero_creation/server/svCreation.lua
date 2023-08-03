srv = {}
Tunnel.bindInterface('Creation', srv)
vCLIENT = Tunnel.getInterface('Creation')

zero._prepare('zero_character/createUser', 'INSERT IGNORE INTO zero_creation (user_id, controller, user_character, user_tattoo, rh) VALUES (@user_id, @controller, @user_character, @user_tattoo, @rh)')
zero._prepare('zero_character/verifyUser', 'SELECT controller FROM zero_creation WHERE user_id = @user_id')
zero._prepare('zero_character/saveUser', 'UPDATE zero_creation SET user_character = @user_character, controller = 1 WHERE user_id = @user_id')

srv.changeSession = function(bucket)
    local _source = source
    SetPlayerRoutingBucket(_source, bucket)
end

srv.verifyName = function(firstname, lastname)
    local _source = source
    if (generalConfig.blacklistNames[firstname]) then
        TriggerClientEvent('notify', _source, 'Criação de Personagem', '<b>'..firstname..'</b> esse nome é inválido!')
        return false
    elseif (generalConfig.blacklistNames[lastname]) then
        TriggerClientEvent('notify', _source, 'Criação de Personagem', '<b>'..firstname..'</b> esse sobrenome é inválido!')
        return false
    end
    return true
end

srv.saveIdentity = function(table)
    local _source = source
    local _userId = zero.getUserId(_source)
    if (_userId) then
        zero.execute('vRP/update_user_first_spawn', { user_id = _userId, firstname = table.firstname, lastname = table.lastname, age = table.age  } )
        zero.execute('zero_framework/money_init_user', { user_id = user_id, wallet = 5000, bank = 25000 })
    end
end

srv.saveCharacter = function(table)
    local _source = source
    local _userId = zero.getUserId(_source)
    if (_userId) then
        zero.execute('zero_character/saveUser', { user_id = _userId, user_character = json.encode(table) })
    end
end

local userLogin = {}
AddEventHandler('vRP:playerSpawn', function(user_id, source)    
    local bloodGroup = generalConfig.bloodGroup
    
    zero.execute('zero_character/createUser', { 
        user_id = user_id, 
        controller = 0, 
        user_character = json.encode({}), 
        user_tattoo = json.encode({}), 
        rh = bloodGroup[math.random(#bloodGroup)] 
    })

    vCLIENT.loadingPlayer(source, false) 
    local query = zero.query('zero_character/verifyUser', { user_id = user_id })[1]
    if (query) then
        Citizen.Wait(1000)
        if (query.controller == 0) then
            if (not userLogin[user_id]) then
                userLogin[user_id] = true
                playerSpawn(source, user_id, true)
            else
                playerSpawn(source, user_id, false)
            end
        else
            userLogin[user_id] = true
            vCLIENT.createCharacter(source)
        end
    end
end)

playerSpawn = function(source, user_id, firstSpawn)
    vCLIENT.loadingPlayer(source, true) 
    if (firstSpawn) then
        Citizen.Wait(8000)
        -- TriggerClientEvent('gb_spawn:SpawnSelector', source, false)
    else
        Citizen.Wait(5000)
        -- TriggerClientEvent('gb_spawn:SpawnSelector', source, true)
    end
    TriggerEvent('zero_appearance_barbershop:init', user_id)
end