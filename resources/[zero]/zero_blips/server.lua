local systemBlips = {}
local userState = {}

RegisterCommand('register',function(source)
    tracePlayer(source, 'Policia', { ['Policia'] = true })
end)

Citizen.CreateThread(function()
    while true do
        for group, users in pairs(systemBlips) do
            for src, mode in pairs(users) do
                if (GetPlayerPing(src) > 0) then
                    local ped = GetPlayerPed(src)
                    mode.coords = vector4( GetEntityCoords(ped), GetEntityHeading(ped) )
                    
                    local syncTree = {}
                    for gview,_ in pairs(userState[src].views) do syncTree[gview] = systemBlips[gview]; end;
                    TriggerLatentClientEvent('zero_blips:update', src, 1024, syncTree)
                else
                    unTracePlayer(src)
                end
            end
        end
        Citizen.Wait(2000)
    end
end)

RegisterNetEvent('zero_blips:updateType',function(group, btype)
    local source = source
    if (systemBlips[group] and systemBlips[group][source]) then
        systemBlips[group][source].btype = btype
    end
end)

tracePlayer = function(source, group, viewGroups)
    if (not userState[source]) then
        if (not systemBlips[group]) then
            systemBlips[group] = {}
        end
        systemBlips[group][source] = { btype = 'foot' }
        userState[source] = { group = group, views = viewGroups }
        TriggerClientEvent('zero_blips:setEnabled', source, group)
    end
end
exports('tracePlayer', tracePlayer)

unTracePlayer = function(source)
    local data = userState[source]
    if (data) then
        systemBlips[data.group][source] = nil
        userState[source] = nil 
        TriggerClientEvent('zero_blips:playerRemoved',-1,source)
        TriggerClientEvent('zero_blips:setEnabled', source, false)
    end
end
exports('unTracePlayer', unTracePlayer)

AddEventHandler('playerDropped', function()
    local source = source
	local data = userState[source]
    if (data) then
        systemBlips[data.group][source] = nil
        userState[source] = nil 
        TriggerClientEvent('zero_blips:playerRemoved',-1,source)
    end
end)