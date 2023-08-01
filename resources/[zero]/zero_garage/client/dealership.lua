local vSERVER = Tunnel.getInterface('Dealership')

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
                SendNUIMessage({
                    action = 'dealership',
                    cars = vSERVER.getStock()
                })
            end
        end
        Citizen.Wait(_idle)
    end
end)