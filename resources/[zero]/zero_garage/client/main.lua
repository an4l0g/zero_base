RegisterCommand('cds',function()
    print(GetEntityCoords(PlayerPedId()), GetEntityHeading(PlayerPedId()))
end)

local cli = {}
Tunnel.bindInterface('zeroGarage', cli)
local vSERVER = Tunnel.getInterface('zeroGarage')

local garagesConfig = config.garages

local markers = {
    ['plane'] = 33,
    ['heli'] = 34,
    ['boat'] = 35,
    ['car'] = 36,
    ['motor'] = 37,
    ['bike'] = 38,
    ['truck'] = 39
}

createMarker = function(config)
    DrawMarker(markers[(config.marker or 'car')], config.coords.x, config.coords.y, config.coords.z+0.1, 0, 0, 0, 0, 0, 0, 0.7, 0.7, 0.7, 0, 153, 255, 155, 1, 0, 0, 1)
    DrawMarker(27, config.coords.x, config.coords.y, config.coords.z-0.97, 0, 0, 0, 0, 0, 0, 1.0, 1.0, 1.0, 0, 153, 255, 155, 0, 0, 0, 1)
end

local nearestGarages = {}
local inGarage = false
mainThread = function()
    SetNuiFocus(false, false)
    local getNearestGarages = function()
        while true do
            if (not inGarage) then
                local playerCoords = GetEntityCoords(PlayerPedId())
                if (nearestGarages and nearestGarages.coords) then
                    local distance = #(playerCoords - nearestGarages.coords)
                    if (distance > 10) then
                        nearestGarages = false
                    elseif (distance <= 1.2) then
                        nearestGarages.close = true
                    else
                        nearestGarages.close = false
                    end
                else
                    for k, v in ipairs(garagesConfig) do
                        local distance = #(playerCoords - v.coords)
                        if distance <= 10 then
                            nearestGarages = garagesConfig[k]
                            nearestGarages.id = k
                        end
                    end
                end
            end
            Citizen.Wait(800)
        end
    end

    CreateThread(getNearestGarages)

    while true do
        local idle = 1000
        local ped = PlayerPedId()
        if (nearestGarages and nearestGarages.coords and not inGarage) then
            idle = 4
            createMarker(nearestGarages)
            if (IsControlJustPressed(0, 38) and GetEntityHealth(ped) > 101 and not IsPedInAnyVehicle(ped)) then
                openGarage(nearestGarages)
            end
        end
        Citizen.Wait(idle)
    end
end

CreateThread(mainThread)


openGarage = function(config)
    if (vSERVER.checkPermissions(config.permission)) then
        SetNuiFocus(true, true)
        SendNUIMessage({
            action = 'open',
            cars = vSERVER.getMyVehicles(config.id)
        })
    end
end

-- RegisterCommand('garage', function()
--     SetNuiFocus(true, true)
--     SendNUIMessage({
--         action = 'open',
--         cars = {
--             { type = 'car', spawn = 'amarok', name = 'Amarok', maker = 'Volkswagen', trunk_capacity = 100, trunk = 85, engine = 20, breaker = 90, transmission = 75, suspension = 90, fuel = 10 },
--             { type = 'motocycle', spawn = 'xj6', name = 'xj6', maker = 'Xablau', trunk_capacity = 100, trunk = 40, engine = 100, breaker = 10, transmission = 10, suspension = 20, fuel = 30 },
--             { type = 'motocycle', spawn = 'hornet', name = 'hornet', maker = 'Xablau 2', trunk_capacity = 100, trunk = 10, engine = 55, breaker = 40, transmission = 30, suspension = 50, fuel = 45 },
--             { type = 'car', spawn = 'ferrariitalia', name = 'Italia', maker = 'Ferrari', trunk_capacity = 100, trunk = 30, engine = 70, breaker = 30, transmission = 45, suspension = 10, fuel = 35 },
--             { type = 'car', spawn = 'xebureca', name = 'Xebureca', maker = 'Claudin', trunk_capacity = 100, trunk = 30, engine = 70, breaker = 30, transmission = 45, suspension = 10, fuel = 35 },
--             { type = 'motocycle', spawn = 'motinha', name = 'Motinha', maker = 'Fernandinho', trunk_capacity = 100, trunk = 30, engine = 70, breaker = 30, transmission = 45, suspension = 10, fuel = 35 },
--         }
--     })
-- end)

RegisterNuiCallback('saveNextVeh', function()
    print("Guardar veículo próximo")
end)

RegisterNuiCallback('saveVeh', function(data)
    print("Guardar veículo: "..data.spawn)
end)

RegisterNuiCallback('useVeh', function(data)
    print("Retirar veículo: "..data.spawn)
end)

RegisterNuiCallback('close', function()
    SetNuiFocus(false, false)
end)