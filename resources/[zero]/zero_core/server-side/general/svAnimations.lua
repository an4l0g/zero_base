local configAnimations = config.animations

local checkAnimPermissions = function(_source, _userId, permission)
    if (_userId) then
        if (permission) then
            if (type(permission) == 'table') then
                for index, value in pairs(permission) do
                    if vRP.hasPermission(_userId, value) then
                        return true
                    end
                end
                return false
            end
            return vRP.hasPermission(_userId, permission)
        end
        return true
    end
end

RegisterCommand('e', function(source, args)
    local _source = source
    local _userId = vRP.getUserId(source)
    if (GetEntityHealth(GetPlayerPed(_source)) > 101) then
        local animation = configAnimations.animations[args[1]]
        if (animation) then
            if checkAnimPermissions(_source, _userId, animation.perm) then
                TriggerClientEvent('zero_animations:setAnim', _source, args[1])
            end
        end
    end
end)

RegisterCommand('ec', function(source, args)
    local _source = source
    local _userId = vRP.getUserId(source)
    if (GetEntityHealth(GetPlayerPed(_source)) > 101) then
        local animation = configAnimations.shared[args[1]]
        if (animation) then
            if checkAnimPermissions(_source, _userId, animation.perm) then
                local nSource = vRPclient.getNearestPlayer(source, 2)
                if (GetEntityHealth(GetPlayerPed(nSource)) > 101) then 
                    TriggerClientEvent('zero_animations:setAnimShared', _source, args[1])
                    TriggerClientEvent('zero_animations:setAnimShared2', nSource, anim.otherAnim, _source)
                end
            end
        end
    end
end)