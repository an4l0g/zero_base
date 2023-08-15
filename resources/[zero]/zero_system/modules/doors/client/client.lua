local vSERVER = Tunnel.getInterface('Doors')

RegisterNetEvent('zero_doors:statusSend')
AddEventHandler('zero_doors:statusSend',function(i,status)
	if (i ~= nil and status ~= nil) then
		Doors[i].lock = status
	end
end)

local nearestBlips = {}

local _markerThread = false
local markerThread = function()
    if (_markerThread) then return; end;
    _markerThread = true
    Citizen.CreateThread(function()
        while (countTable(nearestBlips) > 0) do
            local ped = PlayerPedId()
            local _cache = nearestBlips
            for index, dist in pairs(_cache) do
                local _config = Doors[index]
                if (dist <= 1.8) then
                    if (_config.text) then
                        if (_config.lock) then
                            TextFloating('~b~E~w~ - Destrancar', _config.coord)
                        else
                            TextFloating('~b~E~w~ - Trancar', _config.coord)
                        end
                    end
                    if (dist <= 1.2 and IsControlJustPressed(0, 38) and vSERVER.checkPermissions(_config.perm, _config.home) and GetEntityHealth(ped) > 100) then
                        TriggerServerEvent('zero_doors:open', index, _config.autoLock)
                    end
                end
            end
            Citizen.Wait(5)
        end
        _markerThread = false
    end)
end

Citizen.CreateThread(function()
    while (true) do
        local ped = PlayerPedId()
        local pCoord = GetEntityCoords(ped)
        nearestBlips = {}
        for k, v in pairs(Doors) do
            local distance = #(pCoord - v.coord)
            if (distance <= v.distance) then
                nearestBlips[k] = distance
                if (not v.other) then
                    local door = GetClosestObjectOfType(v.coord.x, v.coord.y, v.coord.z, v.distance, v.hash, false, false, false)
                    if (door ~= 0) then
                        local lock, heading = GetStateOfClosestDoorOfType(v.hash, v.coord.x, v.coord.y, v.coord.z, lock, heading)
                        HandleDoorState(door, v.lock, heading)
                    end
                else
                    local door1 = GetClosestObjectOfType(v.door_1.x, v.door_1.y, v.door_1.z, v.distance, v.hash, false, false, false)
                    local door2 = GetClosestObjectOfType(v.door_2.x, v.door_2.y, v.door_2.z, v.distance, v.other, false, false, false)
                    if (door1 ~= 0) then
                        local lock, heading = GetStateOfClosestDoorOfType(v.hash, v.door_1.x, v.door_1.y, v.door_1.z, lock, heading)
                        HandleDoorState(door1, v.lock, heading)
                    end
                    
                    if (door2 ~= 0) then
                        local lock, heading = GetStateOfClosestDoorOfType(v.other, v.door_2.x, v.door_2.y, v.door_2.z, lock, heading)
                        HandleDoorState(door2, v.lock, heading)
                    end
                end
            end
        end
        if (countTable(nearestBlips) > 0) then markerThread(); end;
        Citizen.Wait(500)
    end
end)

HandleDoorState = function(door, lock, heading)
    if (heading > -0.02 and heading < 0.02) then
        FreezeEntityPosition(door, lock)
        NetworkRequestControlOfEntity(door)
    end
end