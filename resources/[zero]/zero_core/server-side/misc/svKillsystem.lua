local srv = {}
Tunnel.bindInterface('Killsystem', srv)

local config = module('zero_core','cfg/cfgKillsystem')

local cooldownKillSystem = {}

srv.playerDeath = function(weapon, killerSource, headShot)
    killerSource = parseInt(killerSource)
    local source = source
    local user_id = zero.getUserId(source)	
    if (not cooldownKillSystem[user_id]) then
        cooldownKillSystem[user_id] = true
        if user_id and (source ~= killerSource) then
            local killer_id = zero.getUserId(killerSource)
            if killer_id then
                local sPed, nPed = GetPlayerPed(source), GetPlayerPed(killerSource)
                if (not DoesEntityExist(sPed)) or (not DoesEntityExist(nPed)) then return; end;

                local victimCoord = GetEntityCoords(sPed)
                local killerCoord = GetEntityCoords(nPed)
                local weaponName = (config.weapons[weapon] and config.weapons[weapon]['name'] or 'Desconhecido')
                local killer_identity = zero.getUserIdentity(killer_id)
                local victim_identity = zero.getUserIdentity(user_id)
                
                zero.webhook('KillSystem', '```prolog\n[ID]: '..killer_id..' - '..killer_identity.firstname..' \n[MATOU O ID]: '..user_id..' - '..victim_identity.firstname..' \n[ARMA]: '..weaponName..' [HASH]: '..weapon..'\n[LOCAL ASSASSINO]: '..tostring(killerCoord)..'\n[LOCAL VITIMA]: '..tostring(victimCoord)..'\n'..os.date('[DATA]: %d/%m/%y   [HORA]: %X')..'```')
                Citizen.SetTimeout(500, function() cooldownKillSystem[user_id] = false end)
                
                local admin = zero.getUsersByPermission('staff.permissao')
                for l,w in pairs(admin) do
                    local player = zero.getUserSource(parseInt(w))
                    if player then
                        TriggerClientEvent('chatMessage', player, '[KILLSYSTEM]', {0, 153, 255}, '[ID]: '..killer_id..' [MATOU O ID]: '..user_id..' [ARMA]: '..weaponName)
                        TriggerClientEvent('notify', player, 'Kill System', '[ID]: '..killer_id..' [MATOU O ID]: '..user_id..' [ARMA]: '..weaponName, 10000)
                    end
                end
            end
        end
    end
end