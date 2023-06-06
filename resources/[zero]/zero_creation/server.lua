srv = {}
Tunnel.bindInterface(GetCurrentResourceName(), srv)
vCLIENT = Tunnel.getInterface(GetCurrentResourceName())

vRP._prepare('zero_character/createUser', 'INSERT IGNORE INTO zero_creation (user_id, controller, user_character) VALUES (@user_id, @controller, @user_character)')
vRP._prepare('zero_character/verifyUser', 'SELECT controller FROM zero_creation WHERE user_id = @user_id')
vRP._prepare('zero_character/saveUser', 'UPDATE zero_creation SET user_character = @user_character WHERE user_id = @user_id')

srv.changeSession = function(bucket)
    local _source = source
    SetPlayerRoutingBucket(_source, bucket)
end

srv.saveCharacter = function(table)
    local _source = source
    local _userId = vRP.getUserId(_source)
    if (_userId) then
        vRP.execute('zero_character/saveUser', { user_id = _userId, user_character = table })
    end
end

local userLogin = {}

AddEventHandler('vRP:playerSpawn', function(user_id, source)
    vRP.execute('zero_character/createUser', { user_id = user_id, controller = 0, user_character = '{}' })

    vCLIENT.loadingPlayer(source, false) 
    local query = vRP.query('zero_character/verifyUser', { user_id = user_id })[1]
    if (query) then
        Citizen.Wait(1000)
        if (query['controller'] == 1) then
            if (not userLogin[user_id]) then
                userLogin[user_id] = true
                print('FIRST SPAWN')
            else

            end
        elseif (query['controller'] == 0) then
            userLogin[user_id] = true
            vCLIENT.createCharacter(source)
        end
    end
end)

playerSpawn = function(source, user_id, firstSpawn)
    if (firstSpawn) then
        Citizen.Wait(8000)
        TriggerClientEvent('zero:SpawnSelector', source, false)
    else
        Citizen.Wait(5000)
        TriggerClientEvent('zero:SpawnSelector', source, true)
    end
    TriggerEvent('vrp_barbershop:init', user_id)
end

srv.spawnPermission = function(permission)
    local source = source
    local user_id = vRP.getUserId(source)
    if permission then
        if vRP.hasPermission(user_id, permission) then
            return true
        end
        return false
    end
    return true
end

srv.getLastPosition = function()
    local datatable = vRP.getUserDataTable(vRP.getUserId(source))
    local coords = vec3(-797.19,-97.96,37.66)
    if datatable and datatable['position'] then
        local position = datatable['position']
        coords = vec3(position.x, position.y, position.z)
    end
    return coords
end