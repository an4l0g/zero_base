local cooldown = {}
CreateCooldown = function(target, time)
    target = tostring(target)
    Citizen.CreateThread(function()
        cooldown[target] = time
        while (cooldown[target] > 0) do
            Citizen.Wait(1000)
            cooldown[target] = cooldown[target] - 1
        end
        cooldown[target] = nil
    end)
end
exports('CreateCooldown', CreateCooldown)

GetCooldown = function(target)
    return cooldown[target]
end
exports('GetCooldown', GetCooldown)