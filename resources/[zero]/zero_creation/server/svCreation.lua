srv = {}
Tunnel.bindInterface('Creation', srv)
vCLIENT = Tunnel.getInterface('Creation')

zero._prepare('zero_character/createUser', 'INSERT IGNORE INTO creation (user_id, controller, user_character, user_tattoo, user_clothes, rh) VALUES (@user_id, @controller, @user_character, @user_tattoo, @user_clothes, @rh)')
zero._prepare('zero_character/verifyUser', 'SELECT controller FROM creation WHERE user_id = @user_id')
zero._prepare('zero_character/saveUser', 'UPDATE creation SET user_character = @user_character, controller = 1 WHERE user_id = @user_id')

srv.changeSession = function(bucket)
    local _source = source
    SetPlayerRoutingBucket(_source, bucket)
end

srv.verifyIdentity = function(identity)
    local source = source

    if (generalConfig.blacklistNames[identity.firstname] or identity.firstname == '') then
        local text = (identity.firstname == '' and '<b>Nome</b> inválido!' or '<b>'..identity.firstname..'</b> este nome é inválido!')
        TriggerClientEvent('notify', source, 'Criação de Personagem', text)
        return false
    end

    if (string.len(identity.firstname) > 50) then
        TriggerClientEvent('notify', source, 'Criação de Personagem', 'O seu <b>nome</b> não pode passar de <b>50 caracteres</b>.')
        return false
    end

    if (generalConfig.blacklistNames[identity.lastname] or identity.lastname == '') then
        local text = (identity.lastname == '' and '<b>Sobrenome</b> inválido!' or '<b>'..identity.lastname..'</b> este sobrenome é inválido!')
        TriggerClientEvent('notify', source, 'Criação de Personagem', text)
        return false
    end

    if (string.len(identity.lastname) > 50) then
        TriggerClientEvent('notify', source, 'Criação de Personagem', 'O seu <b>sobrenome</b> não pode passar de <b>50 caracteres</b>.')
        return false
    end

    if (identity.age < 18) then
        TriggerClientEvent('notify', source, 'Criação de Personagem', '<b>Idade</b> inválida!')
        return false
    end

    local user_id = zero.getUserId(source)
    if (user_id) then
        zero.execute('vRP/update_user_first_spawn', { user_id = user_id, firstname = identity.firstname, lastname = identity.lastname, age = identity.age  } )
        zero.execute('zero_framework/money_init_user', { user_id = user_id, wallet = 5000, bank = 25000 })
        zero.resetIdentity(user_id)
        return true
    end
    return false
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
        user_clothes = json.encode({}), 
        rh = bloodGroup[math.random(#bloodGroup)] 
    })

    vCLIENT.loadingPlayer(source, false) 
    local query = zero.query('zero_character/verifyUser', { user_id = user_id })[1]
    if (query) then
        Citizen.Wait(1000)
        if (query.controller == 1) then
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
        TriggerClientEvent('zero_spawn:selector', source, true)
    else
        TriggerClientEvent('zero_spawn:selector', source, false)
    end
    TriggerEvent('zero_appearance_barbershop:init', user_id)
end