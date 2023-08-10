local srv = {}
Tunnel.bindInterface('Refem', srv)

srv.getClosetPedSource = function()
    local source = source
    local targetSrc = zeroClient.getNearestPlayer(source, 1.2)
    return (targetSrc or 0.0)
end

RegisterCommand('prefem', function(source)
    local targetSrc = zeroClient.getNearestPlayer(source, 1.5)
    if (targetSrc) then
        local ply = GetPlayerPed(source)
        local targetPly = GetPlayerPed(targetSrc)

        if (GetEntityHealth(ply) <= 100 or GetEntityHealth(targetPly) <= 100) then return; end;
        if (zeroClient.isHandcuffed(source)) then return; end;
        
        -- if (zeroClient.isHandcuffed(source) and)
        --     and zeroClient.getNoCarro(source) and zeroClient.getNoCarro(targetPly) then
        --     return
        -- end

        print('aqui')
    end
end)

RegisterServerEvent('zero_prefem:sync')
AddEventHandler('zero_prefem:sync', function(target, animationLib,animationLib2, animation, animation2, distans, distans2, height,length,spin,controlFlagSrc,controlFlagTarget,animFlagTarget,attachFlag)
	local source = source
    local targetSrc = zeroClient.getNearestPlayer(source, 2.0)
    if (targetSrc) then
        Player(source).state.BlockTasks = true
        Player(targetSrc).state.BlockTasks = true
        TriggerClientEvent('zero_prefem:syncTarget', targetSrc, source, animationLib2, animation2, distans, distans2, height, length,spin,controlFlagTarget,animFlagTarget,attachFlag)
        TriggerClientEvent('zero_prefem:syncMe', source, animationLib, animation,length,controlFlagSrc,animFlagTarget)
    end
end)

RegisterServerEvent('zero_prefem:stop')
AddEventHandler('zero_prefem:stop', function(targetSrc)
    local source = source    
    TriggerClientEvent('zero_prefem:cl_stop', source)
	TriggerClientEvent('zero_prefem:cl_stop', targetSrc)
end)