local vSERVER = Tunnel.getInterface('Killsystem')
local config = module('zero_core','cfg/cfgKillsystem')

AddEventHandler('gameEventTriggered', function(name, args)
    if name == 'CEventNetworkEntityDamage' then
        local ped = PlayerPedId()
        if IsPedAPlayer(args[1]) and (ped == args[1]) and (ped ~= args[2]) then   
            local died = (GetEntityHealth(args[1]) <= 100)
            
            local weapon = args[7]
            if (not weapon) then _, weapon = GetCurrentPedWeapon(args[2]); end;
            
            local _, pedWeapon = GetCurrentPedWeapon(args[1])
            local _, bone = GetPedLastDamageBone(args[1])
            ClearPedLastDamageBone(ped)

            if (not died) then
                if (bone == 31086) then
                    if config.weapons[weapon]['headshot'] then
                        died = true
                        SetEntityHealth(ped, 0)
                    end
                end
            end

            if died then
                local index = NetworkGetPlayerIndexFromPed(args[2])
                local killerSource = GetPlayerServerId(index)
                if (killerSource) then
                    if (IsPedAPlayer(args[2])) then
                        vSERVER.playerDeath(weapon, killerSource)
                    end
                end
            end
        end
    end
end)