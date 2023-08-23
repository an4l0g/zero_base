local srv = {}
Tunnel.bindInterface('Refem', srv)
local vCLIENT = Tunnel.getInterface('Refem')

srv.getClosetPedSource = function()
    local source = source
    local targetSrc = zeroClient.getNearestPlayer(source, 1.5)
    return (targetSrc or 0.0)
end

RegisterCommand('prefem', function(source)
    local targetSrc = zeroClient.getNearestPlayer(source, 1.5)
    if (targetSrc) then
        local ply = GetPlayerPed(source)
        local targetPly = GetPlayerPed(targetSrc)

        if (GetEntityHealth(ply) <= 100 or GetEntityHealth(targetPly) <= 100) then return; end;
        if (zeroClient.isHandcuffed(source)) then return; end;
        if (zeroClient.getNoCarro(source) or  zeroClient.getNoCarro(targetSrc)) then return; end;
        if (Player(source).state.holdingHostage or Player(targetSrc).state.victimHostage) then return; end;
        
        local result = vCLIENT.takeHostage(source, targetSrc)
        if (result) then
            Player(source).state.holdingHostage = true
            Player(targetSrc).state.victimHostage = true
        end
    end
end)

RegisterServerEvent('zero_prefem:killHostage')
AddEventHandler('zero_prefem:killHostage', function()
    local source = source
    local nPlayer = zeroClient.getNearestPlayer(source, 2)
    if (nPlayer) then
        zeroClient.killGod(nPlayer)
        zeroClient.setHealth(nPlayer, 0)
        zeroClient.setArmour(nPlayer, 0)
    end
end)

RegisterServerEvent('zero_prefem:sync')
AddEventHandler('zero_prefem:sync', function(targetSrc, animationLib,animationLib2, animation, animation2, distans, distans2, height,length,spin,controlFlagSrc,controlFlagTarget,animFlagTarget,attachFlag)
    Player(source).state.BlockTasks = true
    Player(targetSrc).state.BlockTasks = true
    TriggerClientEvent('zero_prefem:syncTarget', targetSrc, source, animationLib2, animation2, distans, distans2, height, length,spin,controlFlagTarget,animFlagTarget,attachFlag)
    TriggerClientEvent('zero_prefem:syncMe', source, animationLib, animation,length,controlFlagSrc,animFlagTarget)
end)

RegisterServerEvent('zero_prefem:stop')
AddEventHandler('zero_prefem:stop', function(targetSrc)
    local source = source    

    Player(source).state.holdingHostage = false
    Player(targetSrc).state.victimHostage = false

    TriggerClientEvent('zero_prefem:cl_stop', source)
    TriggerClientEvent('zero_prefem:cl_stop', targetSrc)
end)