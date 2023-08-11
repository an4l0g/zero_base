local cli = {}
Tunnel.bindInterface('Dealership', cli)
local vSERVER = Tunnel.getInterface('Dealership')

local configTest = config.testdrive

Citizen.CreateThread(function()
    local dealerShip = config.dealership
    while (true) do
        local _idle = 1000
        local ped = PlayerPedId()
        local distance = #(GetEntityCoords(ped) - dealerShip)
        if (distance <= 5.0) then
            _idle = 5
            DrawMarker(0, dealerShip.x, dealerShip.y, dealerShip.z, 0, 0, 0, 0, 0, 0, 0.3, 0.3, 0.3, 0, 153, 255, 155, 1, 0, 0, 1)
            if (distance <= 1.2 and IsControlJustPressed(0, 38) and GetEntityHealth(ped) > 100 and not IsPedInAnyVehicle(ped)) then
                SetNuiFocus(true, true)
                TriggerEvent('zero_core:tabletAnim')
                SendNUIMessage({
                    action = 'dealership',
                    cars = vSERVER.getStock()
                })
            end
        end
        Citizen.Wait(_idle)
    end
end)

RegisterNuiCallback('testDrive', function(data)
    vSERVER.testDrive(data.spawn)
end)

RegisterNuiCallback('buyCar', function(data)
    vSERVER.buyVehicle(data.spawn)
end)

cli.startTest = function(spawn)
    DoScreenFadeOut(500)
    Wait(500)

    if IsWaypointActive() then
        DeleteWaypoint()
        Wait(3000)
    end

    local ped = PlayerPedId()
    local random = configTest[math.random(#configTest)]
    SetEntityCoords(ped, random.xyz)

    RequestModel(spawn)
    while not HasModelLoaded(spawn) do
        Wait(50)
    end

    local vehicle = CreateVehicle(spawn, random.xyz, random.w, false)
    SetModelAsNoLongerNeeded(spawn)
    SetPedIntoVehicle(ped, vehicle, -1)

    DoScreenFadeIn(500)

    while (IsPedInVehicle(ped, vehicle)) do
        Text2D(0, 0.35, 0.95, 'SAIA DO ~b~VEÍCULO~w~ PARA CANCELAR O ~b~TEST DRIVE~w~', 0.4)
        Citizen.Wait(5)
    end

    DoScreenFadeOut(500)
    Wait(500)

    DeleteEntity(vehicle)
    vSERVER.exitTestDrive()

    DoScreenFadeIn(500)
end