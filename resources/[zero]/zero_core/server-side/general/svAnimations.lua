local config = module('zero_core', 'cfg/cfgAnimations')
local configAnimations = config.animations

RegisterCommand('e', function(source, args)
    local _source = source
    local _userId = zero.getUserId(source)
    if (GetEntityHealth(GetPlayerPed(_source)) > 100) then
        local animation = configAnimations.animations[args[1]]
        if (animation) then
            if (zero.checkPermissions(_userId, animation.perm)) then
                TriggerClientEvent('zero_animations:setAnim', _source, args[1])
            end
        end
    end
end)

RegisterCommand('ec', function(source, args)
    local _source = source
    local _userId = zero.getUserId(source)
    if (GetEntityHealth(GetPlayerPed(_source)) > 100) then
        local animation = configAnimations.shared[args[1]]
        if (animation) then
            if (zero.checkPermissions(_userId, animation.perm)) then
                local nSource = zeroClient.getNearestPlayer(source, 2)
                if (nSource) then
                    if (GetEntityHealth(GetPlayerPed(nSource)) > 100) then 
                        local identity = zero.getUserIdentity(_userId)
                        local request = exports.zero_hud:request(nSource, 'Você deseja aceitar a animação '..args[1]:upper()..' de '..identity.firstname..' '..identity.lastname..'?', 30000)
                        if (request) then
                            TriggerClientEvent('zero_animations:setAnimShared', _source, args[1], nSource)
                            TriggerClientEvent('zero_animations:setAnimShared2', nSource, animation.otherAnim, _source)
                        end
                    end
                end
            end
        end
    end
end)

RegisterCommand('andar', function(source, args)
    local user_id = zero.getUserId(source)
    if (user_id and args[1]) then
        local anim = configAnimations.walkAnim[parseInt(args[1])]
        if (anim) and zero.checkPermissions(user_id, anim.perm) then
            TriggerClientEvent('anim-setWalking', source, anim.anim)
        end
    end
end)

RegisterCommand('ex', function(source, args)
    local user_id = zero.getUserId(source)
    if (user_id and args[1]) then
        local anim = configAnimations.expression[args[1]]
        if (anim) and zero.checkPermissions(user_id, anim.perm) then
            TriggerClientEvent('anim-setExpression', source, anim.anim)
        end
    end
end)


RegisterNetEvent('zero_animation:sharedServer', function(target)
    TriggerClientEvent('zero_animation:sharedClearAnimation', target)
end)

RegisterNetEvent('zero_interactions:execAnimation', function(value)
    local _source = source
    local _userId = zero.getUserId(source)
    if (GetEntityHealth(GetPlayerPed(_source)) > 100) then
        if (value[1] == 'shared') then
            local animation = configAnimations.shared[value[2]]
            if (animation) then
                if (zero.checkPermissions(_userId, animation.perm)) then
                    local nSource = zeroClient.getNearestPlayer(_source, 2)
                    if (nSource) then
                        if (GetEntityHealth(GetPlayerPed(nSource)) > 100) then 
                            local identity = zero.getUserIdentity(_userId)
                            local request = exports.zero_hud:request(nSource, 'Você deseja aceitar a animação '..value[2]:upper()..' de '..identity.firstname..' '..identity.lastname..'?', 30000)
                            if (request) then
                                TriggerClientEvent('zero_animations:setAnimShared', _source, value[2], nSource)
                                TriggerClientEvent('zero_animations:setAnimShared2', nSource, animation.otherAnim, _source)
                            end
                        end
                    end
                end
            end
        else
            local animation = configAnimations.animations[value[2]]
            if (animation) then
                if (zero.checkPermissions(_userId, animation.perm)) then
                    TriggerClientEvent('zero_animations:setAnim', _source, value[2])
                end
            end
        end  
    end
end)