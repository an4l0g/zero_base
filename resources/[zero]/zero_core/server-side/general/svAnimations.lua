local config = module('zero_core', 'cfg/cfgAnimations')
local configAnimations = config.animations

local checkAnimPermissions = function(_source, _userId, permission)
    if (_userId) then
        if (permission) then
            if (type(permission) == 'table') then
                for index, value in pairs(permission) do
                    if zero.hasPermission(_userId, value) then
                        return true
                    end
                end
                return false
            end
            return zero.hasPermission(_userId, permission)
        end
        return true
    end
end

RegisterCommand('e', function(source, args)
    local _source = source
    local _userId = zero.getUserId(source)
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
    local _userId = zero.getUserId(source)
    if (GetEntityHealth(GetPlayerPed(_source)) > 101) then
        local animation = configAnimations.shared[args[1]]
        if (animation) then
            if checkAnimPermissions(_source, _userId, animation.perm) then
                local nSource = zeroClient.getNearestPlayer(source, 2)
                if (GetEntityHealth(GetPlayerPed(nSource)) > 101) then 
                    TriggerClientEvent('zero_animations:setAnimShared', _source, args[1], nSource)
                    TriggerClientEvent('zero_animations:setAnimShared2', nSource, animation.otherAnim, _source)
                end
            end
        end
    end
end)

RegisterNetEvent('zero_animation:sharedServer', function(target)
    TriggerClientEvent('zero_animation:sharedClearAnimation', target)
end)