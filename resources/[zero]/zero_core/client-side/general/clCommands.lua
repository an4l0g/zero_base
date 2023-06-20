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

---------------------------------------
-- CONE
---------------------------------------
RegisterNetEvent('cone', function(arg)
    local ped = PlayerPedId()
	local coord = GetOffsetFromEntityInWorldCoords(ped,0.0,1.0,-0.94)
	local heading = GetEntityHeading(ped)
    
	local prop = `prop_mp_cone_02`
	RequestModel(prop)
	while not HasModelLoaded(prop) do
		RequestModel(prop)
		Citizen.Wait(100)
	end

	if (not arg) then
		local cone = CreateObject(prop,coord.x,coord.y,coord.z-0.5,true,true,true)
		SetEntityHeading(cone,heading)
		PlaceObjectOnGroundProperly(cone)
		SetEntityAsMissionEntity(cone,true,true)
		FreezeEntityPosition(cone,true)
		SetModelAsNoLongerNeeded(cone)
	else
		if DoesObjectOfTypeExistAtCoords(coord.x,coord.y,coord.z,1.9,prop,true) then
			local cone = GetClosestObjectOfType(coord.x,coord.y,coord.z,1.9,prop,false,false,false)
			if (cone > 0) then
				TriggerServerEvent('trydeleteobj',ObjToNet(cone))
			end
		end
	end
end)

---------------------------------------
-- BARREIRA
---------------------------------------
RegisterNetEvent('barreira', function(arg)
    local ped = PlayerPedId()
	local coord = GetOffsetFromEntityInWorldCoords(ped,0.0,1.0,-0.94)
	local heading = GetEntityHeading(ped)
	local prop = `prop_mp_barrier_02b`
	RequestModel(prop)
	while not HasModelLoaded(prop) do
		RequestModel(prop)
		Citizen.Wait(100)
	end
	if (not arg) then
		local barrier = CreateObject(prop,coord.x,coord.y,coord.z-0.5,true,true,true)
		SetEntityHeading(barrier,heading)
		PlaceObjectOnGroundProperly(barrier)
		SetEntityAsMissionEntity(barrier,true,true)
		FreezeEntityPosition(barrier,true)
		SetModelAsNoLongerNeeded(barrier)
	else
		if DoesObjectOfTypeExistAtCoords(coord.x,coord.y,coord.z-0.5,1.9,prop,true) then
			local barrier = GetClosestObjectOfType(coord.x,coord.y,coord.z,1.9,prop,false,false,false)
			if (barrier > 0) then
				TriggerServerEvent('trydeleteobj',ObjToNet(barrier))
			end
		end
	end
end)

---------------------------------------
-- SPIKE
---------------------------------------
RegisterNetEvent('spike', function(arg)
    local ped = PlayerPedId()
	local coord = GetOffsetFromEntityInWorldCoords(ped,0.0,1.0,-0.94)
	local heading = GetEntityHeading(ped)
	local prop = `p_ld_stinger_s`
	RequestModel(prop)
	while not HasModelLoaded(prop) do
		RequestModel(prop)
		Citizen.Wait(100)
	end
	if (not arg) then
		local spike = CreateObject(prop,coord.x,coord.y,coord.z-0.5,true,true,true)
		SetEntityHeading(spike,heading)
		PlaceObjectOnGroundProperly(spike)
		SetEntityAsMissionEntity(spike,true,true)
		FreezeEntityPosition(spike,true)
		SetModelAsNoLongerNeeded(spike)
	else
		if DoesObjectOfTypeExistAtCoords(coord.x,coord.y,coord.z,1.9,prop,true) then
			local spike = GetClosestObjectOfType(coord.x,coord.y,coord.z,1.9,prop,false,false,false)
			if (spike > 0) then
				TriggerServerEvent('trydeleteobj',ObjToNet(spike))
			end
		end
	end
end)

Citizen.CreateThread(function()
	local spikeHash = GetHashKey('p_ld_stinger_s')
	while true do
		local _sleep = 1000
		local ped = PlayerPedId()
		local veh = GetVehiclePedIsIn(ped,false)
		if (veh > 0) then
			local vcoord = GetEntityCoords(veh)
			local spike = GetClosestObjectOfType(vcoord.x,vcoord.y,vcoord.z,1.0,spikeHash,false,false,false)
			if (spike > 0) then
				SetVehicleTyreBurst(veh, 0, true, 1000.0)
				SetVehicleTyreBurst(veh, 1, true, 1000.0)
				SetVehicleTyreBurst(veh, 2, true, 1000.0)
				SetVehicleTyreBurst(veh, 3, true, 1000.0)
				SetVehicleTyreBurst(veh, 4, true, 1000.0)
				SetVehicleTyreBurst(veh, 5, true, 1000.0)
				SetVehicleTyreBurst(veh, 6, true, 1000.0)
				SetVehicleTyreBurst(veh, 7, true, 1000.0)
				TriggerServerEvent('trydeleteobj',ObjToNet(spike))
				Citizen.Wait(2000)
			end
			_sleep = 5
		end
		Citizen.Wait(_sleep)
	end
end)

local PlayerData = {}

PlayerData['mec:tow'] = nil
PlayerData['mec:towed'] = nil

RegisterNetEvent('vTow',function()
	local vehicle = GetPlayersLastVehicle()
	if IsVehicleModel(vehicle,GetHashKey('flatbed')) and not IsPedInAnyVehicle(GetPlayerPed(-1)) then
		PlayerData['mec:towed'] = vRP.getNearestVehicle(7)
		if IsEntityAVehicle(vehicle) and IsEntityAVehicle(PlayerData['mec:towed']) then
			if PlayerData['mec:tow'] then
				TriggerServerEvent('trytow',VehToNet(vehicle),VehToNet(PlayerData['mec:tow']),'out')
				PlayerData['mec:towed'] = nil
				PlayerData['mec:tow'] = nil
			else
				if (vehicle ~= PlayerData['mec:towed']) then
					TriggerServerEvent('trytow',VehToNet(vehicle),VehToNet(PlayerData['mec:towed']),'in')
					PlayerData['mec:tow'] = PlayerData['mec:towed']
				end
			end
		end
	end
end)

RegisterNetEvent('synctow',function(vehid01,vehid02,mod)
	if NetworkDoesNetworkIdExist(vehid01) and NetworkDoesNetworkIdExist(vehid02) then
		local vehicle = NetToEnt(vehid01)
		local towed = NetToEnt(vehid02)
		if DoesEntityExist(vehicle) and DoesEntityExist(towed) then
			if mod == 'in' then
				local min,max = GetModelDimensions(GetEntityModel(towed))
				AttachEntityToEntity(towed,vehicle,GetEntityBoneIndexByName(vehicle,'bodyshell'),0,-2.2,0.4-min.z,0,0,0,1,1,0,1,0,1)
			elseif mod == 'out' then
				AttachEntityToEntity(towed,vehicle,20,-0.5,-14.0,-0.2,0.0,0.0,0.0,false,false,true,false,20,true)
				DetachEntity(towed,false,false)
			end
		end
	end
end)