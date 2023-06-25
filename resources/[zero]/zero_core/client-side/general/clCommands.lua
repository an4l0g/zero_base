local cli = {}
Tunnel.bindInterface('Commands', cli) 
local vSERVER = Tunnel.getInterface('Commands')
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

---------------------------------------
-- TOW
---------------------------------------
local PlayerData = {}

PlayerData['mec:tow'] = nil
PlayerData['mec:towed'] = nil

RegisterNetEvent('vTow',function()
	local vehicle = GetPlayersLastVehicle()
	if IsVehicleModel(vehicle,GetHashKey('flatbed')) and not IsPedInAnyVehicle(GetPlayerPed(-1)) then
		PlayerData['mec:towed'] = zero.getNearestVehicle(7)
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

RegisterNetEvent('synctow', function(vehid01,vehid02,mod)
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

---------------------------------------
-- CAR COLOR
---------------------------------------
RegisterNetEvent('zero_core:carcolor', function(veh, r, g, b, prim)
    if (IsEntityAVehicle(veh)) then
        if (prim) then
            SetVehicleCustomPrimaryColour(veh, r, g, b)    
        else
            SetVehicleCustomSecondaryColour(veh, r, g, b)
        end
    end
end)

---------------------------------------
-- UNCUFF
---------------------------------------
RegisterNetEvent('zero_core:uncuff', function()
	local ped = PlayerPedId()
	zero._setHandcuffed(false)
	SetPedComponentVariation(ped,7,0,0,2)
end)

---------------------------------------
-- SYNCAREA
---------------------------------------
RegisterNetEvent('syncarea', function(x, y, z, radius)
    ClearAreaOfVehicles(x, y, z, (radius or 2000.0), false, false, false, false, false)
    ClearAreaOfEverything(x, y, z, (radius or 2000.0), false, false, false, false)
end)

---------------------------------------
-- SKIN
---------------------------------------
cli.skinModel = function(mhash)
    while (not HasModelLoaded(mhash)) do RequestModel(mhash); Citizen.Wait(1); end;
    if (HasModelLoaded(mhash)) then
        SetPlayerModel(PlayerId(), mhash)     
        SetPedDefaultComponentVariation(PlayerPedId())
    end
    SetModelAsNoLongerNeeded(mhash)
end

---------------------------------------
-- DELNPCS
---------------------------------------
RegisterNetEvent('zero_core:delnpcs', function()
    for _, ped in ipairs(GetGamePool('CPed')) do
        if (not IsPedAPlayer(ped)) then
			TriggerServerEvent('trydeleteped', PedToNet(ped))
		end
    end
end)

---------------------------------------
-- TUNING
---------------------------------------
RegisterNetEvent('zero_core:tuning', function()
	local ped = PlayerPedId()
	local vehicle = GetVehiclePedIsIn(ped)
	if (IsEntityAVehicle(vehicle)) then
		SetVehicleModKit(vehicle,0)
		--SetVehicleWheelType(vehicle,7)
		SetVehicleCustomPrimaryColour(vehicle, 0, 153, 255)    
		SetVehicleCustomSecondaryColour(vehicle, 0, 0, 0)
		SetVehicleMod(vehicle, 0, GetNumVehicleMods(vehicle, 0) - 1, false)
		SetVehicleMod(vehicle, 1, GetNumVehicleMods(vehicle, 1) - 1, false)
		SetVehicleMod(vehicle, 2, GetNumVehicleMods(vehicle, 2) - 1, false)
		SetVehicleMod(vehicle, 3, GetNumVehicleMods(vehicle, 3) - 1, false)
		SetVehicleMod(vehicle, 4, GetNumVehicleMods(vehicle, 4) - 1, false)
		SetVehicleMod(vehicle, 5, GetNumVehicleMods(vehicle, 5) - 1, false)
		SetVehicleMod(vehicle, 6, GetNumVehicleMods(vehicle, 6) - 1, false)
		SetVehicleMod(vehicle, 7, GetNumVehicleMods(vehicle, 7) - 1, false)
		SetVehicleMod(vehicle, 8, GetNumVehicleMods(vehicle, 8) - 1, false)
		SetVehicleMod(vehicle, 9, GetNumVehicleMods(vehicle, 9) - 1, false)
		SetVehicleMod(vehicle, 10, GetNumVehicleMods(vehicle, 10) -1, false)
		SetVehicleMod(vehicle, 11, GetNumVehicleMods(vehicle, 11) -1, false)
		SetVehicleMod(vehicle, 12, GetNumVehicleMods(vehicle, 12) -1, false)
		SetVehicleMod(vehicle, 13, GetNumVehicleMods(vehicle, 13) -1, false)
		SetVehicleMod(vehicle, 14, 16, false)
		SetVehicleMod(vehicle, 15, GetNumVehicleMods(vehicle, 15) -2, false)
		SetVehicleMod(vehicle, 16, GetNumVehicleMods(vehicle, 16) -1, false)
		ToggleVehicleMod(vehicle, 17, true)
		ToggleVehicleMod(vehicle, 18, true)
		ToggleVehicleMod(vehicle, 19, true)
		ToggleVehicleMod(vehicle, 20, true)
		ToggleVehicleMod(vehicle, 21, true)
		ToggleVehicleMod(vehicle, 22, true)
		--SetVehicleMod(vehicle,23,1,false)
		SetVehicleMod(vehicle, 24, 1, false)
		SetVehicleMod(vehicle, 25, GetNumVehicleMods(vehicle, 25) -1, false)
		SetVehicleMod(vehicle, 27, GetNumVehicleMods(vehicle, 27) -1, false)
		SetVehicleMod(vehicle, 28, GetNumVehicleMods(vehicle, 28) -1, false)
		SetVehicleMod(vehicle, 30, GetNumVehicleMods(vehicle, 30) -1, false)
		--SetVehicleMod(vehicle,33,GetNumVehicleMods(vehicle,33)-1,false)
		SetVehicleMod(vehicle, 34, GetNumVehicleMods(vehicle,34) -1, false)
		SetVehicleMod(vehicle, 35, GetNumVehicleMods(vehicle,35) -1, false)
		SetVehicleMod(vehicle, 38, GetNumVehicleMods(vehicle,38) -1, true)
        SetVehicleWindowTint(vehicle, 1)
        --SetVehicleTyresCanBurst(vehicle,false)
    	SetVehicleNumberPlateText(vehicle, 'zero')
        --SetVehicleNumberPlateTextIndex(vehicle,5)
	end
end)

---------------------------------------
-- DEBUG
---------------------------------------
local debug = false

RegisterNetEvent('zero_core:debug', function()
	debug = not debug
    if (debug) then
        debugThread()
		TriggerEvent('notify', 'Debug', 'O <b>debug</b> foi ativado.')
    else
        TriggerEvent('notify', 'Debug', 'O <b>debug</b> foi desativado.')
    end
end)

local closestObject = 0

RegisterCommand('debugobj', function()
    if (debug) then TriggerEvent('clipboard', 'Nearest Hash', tostring(closestObject)); end;
end)

function GetVehicle()
    local playerped = GetPlayerPed(-1)
    local playerCoords = GetEntityCoords(playerped)
    local handle, ped = FindFirstVehicle()
    local success
    local rped = nil
    local distanceFrom
    repeat
        local pos = GetEntityCoords(ped)
        local distance = GetDistanceBetweenCoords(playerCoords, pos, true)
        if canPedBeUsed(ped) and distance < 30.0 and (distanceFrom == nil or distance < distanceFrom) then
            distanceFrom = distance
            rped = ped

	    	if IsEntityTouchingEntity(GetPlayerPed(-1), ped) then
	    		DebugDrawText3Ds(pos["x"],pos["y"],pos["z"]+1, "Veh: " .. ped .. " Model: " .. GetEntityModel(ped) .. " IN CONTACT" )
	    	else
	    		DebugDrawText3Ds(pos["x"],pos["y"],pos["z"]+1, "Veh: " .. ped .. " Model: " .. GetEntityModel(ped) .. "" )
	    	end
        end
        success, ped = FindNextVehicle(handle)
    until not success
    EndFindVehicle(handle)
    return rped
end

function GetObject()
    local playerped = GetPlayerPed(-1)
    local playerCoords = GetEntityCoords(playerped)
    local handle, ped = FindFirstObject()
    local success
    local rped = nil
    local closestDist = 10
    repeat
        local pos = GetEntityCoords(ped)
        local distance = GetDistanceBetweenCoords(playerCoords, pos, true)
        if distance < 10.0 then

            if distance < closestDist then
                closestDist = distance
                closestObject = GetEntityModel(ped)
            end

            rped = ped

	    	if IsEntityTouchingEntity(GetPlayerPed(-1), ped) then
	    		DebugDrawText3Ds(pos["x"],pos["y"],pos["z"]+1, "Obj: " .. ped .. " Model: " .. GetEntityModel(ped) .. " IN CONTACT" )
	    	else
	    		DebugDrawText3Ds(pos["x"],pos["y"],pos["z"]+1, "Obj: " .. ped .. " Model: " .. GetEntityModel(ped) .. "" )
	    	end
        end
        success, ped = FindNextObject(handle)
    until not success
    EndFindObject(handle)
    return rped
end

function getNPC()
    local playerped = GetPlayerPed(-1)
    local playerCoords = GetEntityCoords(playerped)
    local handle, ped = FindFirstPed()
    local success
    local rped = nil
    local distanceFrom
    repeat
        local pos = GetEntityCoords(ped)
        local distance = GetDistanceBetweenCoords(playerCoords, pos, true)
        if canPedBeUsed(ped) and distance < 30.0 and (distanceFrom == nil or distance < distanceFrom) then
            distanceFrom = distance
            rped = ped

	    	if IsEntityTouchingEntity(GetPlayerPed(-1), ped) then
	    		DebugDrawText3Ds(pos["x"],pos["y"],pos["z"], "Ped: " .. ped .. " Model: " .. GetEntityModel(ped) .. " Relationship HASH: " .. GetPedRelationshipGroupHash(ped) .. " IN CONTACT" )
	    	else
	    		DebugDrawText3Ds(pos["x"],pos["y"],pos["z"], "Ped: " .. ped .. " Model: " .. GetEntityModel(ped) .. " Relationship HASH: " .. GetPedRelationshipGroupHash(ped) )
	    	end

        end
        success, ped = FindNextPed(handle)
    until not success
    EndFindPed(handle)
    return rped
end

function canPedBeUsed(ped)
    if ped == nil then
        return false
    end
    if ped == GetPlayerPed(-1) then
        return false
    end
    if not DoesEntityExist(ped) then
        return false
    end
    return true
end

function debugThread()
    Citizen.CreateThread(function()
        while (debug) do 
            local idle = 1000 
            if (debug) then
                idle = 4
                local pos = GetEntityCoords(GetPlayerPed(-1))

                local forPos = GetOffsetFromEntityInWorldCoords(GetPlayerPed(-1), 0, 1.0, 0.0)
                local backPos = GetOffsetFromEntityInWorldCoords(GetPlayerPed(-1), 0, -1.0, 0.0)
                local LPos = GetOffsetFromEntityInWorldCoords(GetPlayerPed(-1), 1.0, 0.0, 0.0)
                local RPos = GetOffsetFromEntityInWorldCoords(GetPlayerPed(-1), -1.0, 0.0, 0.0) 

                local forPos2 = GetOffsetFromEntityInWorldCoords(GetPlayerPed(-1), 0, 2.0, 0.0)
                local backPos2 = GetOffsetFromEntityInWorldCoords(GetPlayerPed(-1), 0, -2.0, 0.0)
                local LPos2 = GetOffsetFromEntityInWorldCoords(GetPlayerPed(-1), 2.0, 0.0, 0.0)
                local RPos2 = GetOffsetFromEntityInWorldCoords(GetPlayerPed(-1), -2.0, 0.0, 0.0)    

                local x, y, z = table.unpack(GetEntityCoords(GetPlayerPed(-1), true))
                local currentStreetHash, intersectStreetHash = GetStreetNameAtCoord(x, y, z, currentStreetHash, intersectStreetHash)
                currentStreetName = GetStreetNameFromHashKey(currentStreetHash)

                DebugdrawTxtS(0.8, 0.50, 0.4,0.4,0.30, "Heading: " .. GetEntityHeading(GetPlayerPed(-1)), 55, 155, 55, 255)
                DebugdrawTxtS(0.8, 0.52, 0.4,0.4,0.30, "Coords: " .. pos, 55, 155, 55, 255)
                DebugdrawTxtS(0.8, 0.54, 0.4,0.4,0.30, "Attached Ent: " .. GetEntityAttachedTo(GetPlayerPed(-1)), 55, 155, 55, 255)
                DebugdrawTxtS(0.8, 0.56, 0.4,0.4,0.30, "Health: " .. GetEntityHealth(GetPlayerPed(-1)), 55, 155, 55, 255)
                DebugdrawTxtS(0.8, 0.58, 0.4,0.4,0.30, "H a G: " .. GetEntityHeightAboveGround(GetPlayerPed(-1)), 55, 155, 55, 255)
                DebugdrawTxtS(0.8, 0.60, 0.4,0.4,0.30, "Model: " .. GetEntityModel(GetPlayerPed(-1)), 55, 155, 55, 255)
                DebugdrawTxtS(0.8, 0.62, 0.4,0.4,0.30, "Speed: " .. GetEntitySpeed(GetPlayerPed(-1)), 55, 155, 55, 255)
                DebugdrawTxtS(0.8, 0.64, 0.4,0.4,0.30, "Frame Time: " .. GetFrameTime(), 55, 155, 55, 255)
                DebugdrawTxtS(0.8, 0.66, 0.4,0.4,0.30, "Street: " .. currentStreetName, 55, 155, 55, 255)
                
                
                DrawLine(pos,forPos, 0,255,255,115)
                DrawLine(pos,backPos, 0,255,255,115)

                DrawLine(pos,LPos, 255,255,0,115)
                DrawLine(pos,RPos, 255,255,0,115)

                DrawLine(forPos,forPos2, 255,0,255,115)
                DrawLine(backPos,backPos2, 255,0,255,115)

                DrawLine(LPos,LPos2, 255,255,255,115)
                DrawLine(RPos,RPos2, 255,255,255,115)

                local nearped = getNPC()
                local veh = GetVehicle()
                local nearobj = GetObject()
            end
            Citizen.Wait(idle)
        end
    end)
end

DebugdrawTxtS = function(x,y ,width,height,scale, text, r,g,b,a)
    SetTextFont(0)
    SetTextProportional(0)
    SetTextScale(0.25, 0.25)
    SetTextColour(r, g, b, a)
    SetTextDropShadow(0, 0, 0, 0,255)
    SetTextEdge(1, 0, 0, 0, 255)
    SetTextDropShadow()
    SetTextOutline()
    SetTextEntry("STRING")
    AddTextComponentString(text)
    DrawText(x - width/2, y - height/2 + 0.005)
end

DebugDrawText3Ds = function(x,y,z, text)
    local onScreen,_x,_y=World3dToScreen2d(x,y,z)
    local px,py,pz=table.unpack(GetGameplayCamCoords())
    
    SetTextScale(0.35, 0.35)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 215)
    SetTextEntry("STRING")
    SetTextCentre(1)
    AddTextComponentString(text)
    DrawText(_x,_y)
    local factor = (string.len(text)) / 370
    DrawRect(_x,_y+0.0125, 0.015+ factor, 0.03, 41, 11, 41, 68)
end

---------------------------------------
-- TERREMOTO
---------------------------------------
local terremoto = false

RegisterNetEvent('zero_core:terremoto', function()
	terremoto = true
	Citizen.CreateThread(function()
		while (terremoto) do
			Citizen.Wait(500)
			ShakeGameplayCam('SMALL_EXPLOSION_SHAKE', 0.2)
		end
	end)
end)