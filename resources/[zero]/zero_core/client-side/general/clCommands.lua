local cli = {}
Tunnel.bindInterface('Commands', cli) 
---------------------------------------
-- TPWAY
---------------------------------------
cli.tpToWayFunction = function()
	local entity = PlayerPedId()
	if IsPedInAnyVehicle(entity) then entity = GetVehiclePedIsUsing(entity); end;
	local waypointBlip = GetFirstBlipInfoId(8)
	local x,y,z = table.unpack(Citizen.InvokeNative(0xFA7C7F0AADF25D09,waypointBlip,Citizen.ResultAsVector()))
    local ground
    local groundFound = false
    local groundCheckHeights = { 0.0,50.0,100.0,150.0,200.0,250.0,300.0,350.0,400.0,450.0,500.0,550.0,600.0,650.0,700.0,750.0,800.0,850.0,900.0,950.0,1000.0,1050.0,1100.0 }

    for i,height in ipairs(groundCheckHeights) do
        SetEntityCoordsNoOffset(entity,x,y,height,0,0,1)

        RequestCollisionAtCoord(x,y,z)
        while not HasCollisionLoadedAroundEntity(entity) do
            RequestCollisionAtCoord(x,y,z)
            Citizen.Wait(1)
        end
        Citizen.Wait(20)

        ground,z = GetGroundZFor_3dCoord(x,y,height)
        if ground then
            z = z + 1.0
            groundFound = true
            break;
        end
    end

    if not groundFound then
        z = 1200
        GiveDelayedWeaponToPed(PlayerPedId(),0xFBAB5776,1,0)
    end

    RequestCollisionAtCoord(x,y,z)
    while not HasCollisionLoadedAroundEntity(entity) do
        RequestCollisionAtCoord(x,y,z)
        Citizen.Wait(1)
    end

    SetEntityCoordsNoOffset(entity,x,y,z,0,0,1)
end

---------------------------------------
-- COMMANDS
---------------------------------------
RegisterNetEvent('zero_commands_police:clothes', function(part)
    local ped = PlayerPedId()
    if (part == 'rmascara') then
	    SetPedComponentVariation(ped, 1, 0, 0, 2)
    elseif (part == 'rchapeu') then
        ClearPedProp(ped, 0)
    end
end)