local cli = {}
Tunnel.bindInterface('Commands', cli) 
local vSERVER = Tunnel.getInterface('Commands')

local CommandsData = {}

---------------------------------------
-- ANTI CL
---------------------------------------
local pExitCDS = vector3(0.0,0.0,-100.0)
Citizen.CreateThread(function()
	while (true) do
		pExitCDS = GetEntityCoords(PlayerPedId())
		Citizen.Wait(1000)
	end
end)

RegisterNetEvent('zero:playerExit', function(user_id, reason, drawCDS)
	if (drawCDS) then
		if reason and #(pExitCDS - drawCDS) <= 500 then
			local draw = true
			local str = '~b~[ZERO - QUIT]~w~\nPASSAPORTE: ~b~'..user_id..'~w~\nMOTIVO: ~b~'..reason..'~w~'
			if (string.len(str) >= 94) then
				str = string.sub(str,1,94)..'...'
			end
			Citizen.SetTimeout(15000, function() draw = false; end)	
			while (draw) do
				local _sleep = 500
				if #(pExitCDS - drawCDS) <= 15 then
					_sleep = 1
					DrawText3Ds(drawCDS.x, drawCDS.y, drawCDS.z, str)
				end
				Citizen.Wait(_sleep)
			end
		end
	end
end)

---------------------------------------
-- ME
---------------------------------------
local DisplayMe = false

RegisterNetEvent('DisplayMe',function(text, source)
	if (DisplayMe) then return; end;
    DisplayMe = true

	local id = GetPlayerFromServerId(source)
    if id == -1 then return end
    Citizen.CreateThread(function()
        while (DisplayMe) do
            local ped = PlayerPedId()
            local coordsMe = GetEntityCoords(GetPlayerPed(id),false)
            local coords = GetEntityCoords(ped,false)
            local distance = #(coordsMe - coords)
            if distance <= 30 then
                TextFloating(text, coordsMe)
            end
			Citizen.Wait(5)
        end
    end)
    Citizen.Wait(7000)
    DisplayMe = false
end)

MeText = function(x,y,z,text)
	local onScreen,_x,_y = World3dToScreen2d(x,y,z)
	SetTextFont(0)
	SetTextScale(0.50,0.50)
	SetTextColour(255,255,255,255)
	SetTextEntry('STRING')
	SetTextCentre(1)
	AddTextComponentString(text)
	DrawText(_x,_y)
	local factor = (string.len(text))/300
	--DrawRect(_x,_y+0.0125,0.01+factor,0.1,0,0,0,80)
end

---------------------------------------
-- NEYMAR
---------------------------------------
RegisterNetEvent('ney')
AddEventHandler('ney',function()
	local ped = PlayerPedId()
	SetPedToRagdollWithFall(ped, 1500, 2000, 0, GetEntityForwardVector(ped), 1.0, 0, 0, 0, 0, 0, 0)
end)

---------------------------------------
-- WALL
---------------------------------------
LocalPlayer.state:set('Wall', false, true)

CommandsData['players'] = {}
AddStateBagChangeHandler('Wall', nil, function(bagName, key, value) 
    local entity = GetPlayerFromStateBagName(bagName)
    if (entity == 0) then return; end;

    if (value) then
        Citizen.CreateThread(function()
            while (LocalPlayer.state.Wall) do
                for _, id in ipairs(GetActivePlayers()) do
                    local ply = GetPlayerPed(id)
                    if (NetworkIsPlayerActive(id) and ply ~= PlayerPedId()) then
                        local pCoord = GetEntityCoords(PlayerPedId())
                        local eCoord = GetEntityCoords(ply)

                        local distance = #(pCoord - eCoord)
                        if (distance <= 150) then
                            if (ply ~= -1 and CommandsData['players'][id] ~= nil) then
								local text = (CommandsData['players'][id][2] and '\n~b~CAM:~w~ ATIVADO' or '')
                                DrawText3Ds(eCoord.x, eCoord.y, eCoord.z+1.3, '~b~ID:~w~ '..CommandsData['players'][id][1]..'\n~b~VIDA:~w~ '..GetEntityHealth(ply)..'\n~b~NOME:~w~ '..(GetPlayerName(id) or 'NÃO IDENTIFICADO')..text)
                            end
                        end
                    end
                end
                Citizen.Wait(1)
            end
        end)

		Citizen.CreateThread(function()
            while (LocalPlayer.state.Wall) do
                for _, id in ipairs(GetActivePlayers()) do
					if id == -1 or id == nil or id == 0 then return end
					local pid, cam = vSERVER.getWallId(GetPlayerServerId(id))
					if pid == -1 then
						return
					end
					if CommandsData['players'][id] ~= pid or not CommandsData['players'][id] then
						CommandsData['players'][id] = { pid, cam } 
					end
				end
                Citizen.Wait(1500)
            end
        end)
    end
end)

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
				vSERVER.giveInventoryItem('cone')
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
				vSERVER.giveInventoryItem('barreira')
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
				vSERVER.giveInventoryItem('spike')
			end
		end
	end
end)

spikeThread = function()
	Citizen.CreateThread(function()
		local spikeHash = GetHashKey('p_ld_stinger_s')
		local ped = PlayerPedId()
		local inVehicle = IsPedInAnyVehicle(ped)
		while (inVehicle) do
			local _sleep = 1000
			local veh = GetVehiclePedIsIn(ped,false)
			inVehicle = IsPedInAnyVehicle(ped)
			if (veh > 0) then
				_sleep = 100
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
				end
			end
			Citizen.Wait(_sleep)
		end
	end)
end
RegisterNetEvent('zero_core:spikeThread', spikeThread)

---------------------------------------
-- TOW
---------------------------------------
CommandsData['mec:tow'] = nil
CommandsData['mec:towed'] = nil

local BlacklistHash = {
	-- [GetHashKey('zentorno')] = 'Zentorno'
}

RegisterNetEvent('vTow',function()
	local vehicle = GetPlayersLastVehicle()
	if IsVehicleModel(vehicle,GetHashKey('flatbed3')) and not IsPedInAnyVehicle(GetPlayerPed(-1)) then
		CommandsData['mec:towed'] = zero.getNearestVehicle(7)
		if (not CommandsData['mec:tow']) then
			if (GetPedInVehicleSeat(CommandsData['mec:towed'], -1) ~= 0) then 
				return TriggerEvent('notify', 'Rebocar', 'Este <b>veículo</b> possui uma pessoa dentro!') 
			end

			if (BlacklistHash[GetEntityModel(CommandsData['mec:towed'])]) then
				return TriggerEvent('notify', 'Rebocar', 'Você não pode rebocar o <b>'..BlacklistHash[GetEntityModel(CommandsData['mec:towed'])]..'</b>.')
			end
		else
			if (GetPedInVehicleSeat(CommandsData['mec:tow'], -1) ~= 0) then 
				return TriggerEvent('notify', 'Rebocar', 'Este <b>veículo</b> possui uma pessoa dentro!') 
			end

			if (BlacklistHash[GetEntityModel(CommandsData['mec:tow'])]) then
				return TriggerEvent('notify', 'Rebocar', 'Você não pode rebocar o <b>'..BlacklistHash[GetEntityModel(CommandsData['mec:tow'])]..'</b>.')
			end
		end

		if IsEntityAVehicle(vehicle) and IsEntityAVehicle(CommandsData['mec:towed']) then
			if CommandsData['mec:tow'] then
				TriggerServerEvent('trytow',VehToNet(vehicle),VehToNet(CommandsData['mec:tow']),'out')
				CommandsData['mec:towed'] = nil
				CommandsData['mec:tow'] = nil
			else
				if (vehicle ~= CommandsData['mec:towed']) then
					TriggerServerEvent('trytow',VehToNet(vehicle),VehToNet(CommandsData['mec:towed']),'in')
					CommandsData['mec:tow'] = CommandsData['mec:towed']
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
CommandsData['debug'] = false
RegisterNetEvent('zero_core:debug', function()
	CommandsData['debug'] = not CommandsData['debug']
    if (CommandsData['debug']) then
        debugThread()
		TriggerEvent('notify', 'Debug', 'O <b>debug</b> foi ativado.')
    else
        TriggerEvent('notify', 'Debug', 'O <b>debug</b> foi desativado.')
    end
end)

CommandsData['closestObject'] = 0

RegisterCommand('debugobj', function()
    if (CommandsData['debug']) then TriggerEvent('clipboard', 'Nearest Hash', tostring(CommandsData['closestObject'])); end;
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
	    		DebugDrawText3Ds(pos['x'],pos['y'],pos['z']+1, 'Veh: ' .. ped .. ' Model: ' .. GetEntityModel(ped) .. ' IN CONTACT' )
	    	else
	    		DebugDrawText3Ds(pos['x'],pos['y'],pos['z']+1, 'Veh: ' .. ped .. ' Model: ' .. GetEntityModel(ped) .. '' )
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
                CommandsData['closestObject'] = GetEntityModel(ped)
            end

            rped = ped

	    	if IsEntityTouchingEntity(GetPlayerPed(-1), ped) then
	    		DebugDrawText3Ds(pos['x'],pos['y'],pos['z']+1, 'Obj: ' .. ped .. ' Model: ' .. GetEntityModel(ped) .. ' IN CONTACT' )
	    	else
	    		DebugDrawText3Ds(pos['x'],pos['y'],pos['z']+1, 'Obj: ' .. ped .. ' Model: ' .. GetEntityModel(ped) .. '' )
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
	    		DebugDrawText3Ds(pos['x'],pos['y'],pos['z'], 'Ped: ' .. ped .. ' Model: ' .. GetEntityModel(ped) .. ' Relationship HASH: ' .. GetPedRelationshipGroupHash(ped) .. ' IN CONTACT' )
	    	else
	    		DebugDrawText3Ds(pos['x'],pos['y'],pos['z'], 'Ped: ' .. ped .. ' Model: ' .. GetEntityModel(ped) .. ' Relationship HASH: ' .. GetPedRelationshipGroupHash(ped) )
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
        while (CommandsData['debug']) do 
            local idle = 1000 
            if (CommandsData['debug']) then
                idle = 1
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

                DebugdrawTxtS(0.8, 0.50, 0.4,0.4,0.30, 'Heading: ' .. GetEntityHeading(GetPlayerPed(-1)), 55, 155, 55, 255)
                DebugdrawTxtS(0.8, 0.52, 0.4,0.4,0.30, 'Coords: ' .. pos, 55, 155, 55, 255)
                DebugdrawTxtS(0.8, 0.54, 0.4,0.4,0.30, 'Attached Ent: ' .. GetEntityAttachedTo(GetPlayerPed(-1)), 55, 155, 55, 255)
                DebugdrawTxtS(0.8, 0.56, 0.4,0.4,0.30, 'Health: ' .. GetEntityHealth(GetPlayerPed(-1)), 55, 155, 55, 255)
                DebugdrawTxtS(0.8, 0.58, 0.4,0.4,0.30, 'H a G: ' .. GetEntityHeightAboveGround(GetPlayerPed(-1)), 55, 155, 55, 255)
                DebugdrawTxtS(0.8, 0.60, 0.4,0.4,0.30, 'Model: ' .. GetEntityModel(GetPlayerPed(-1)), 55, 155, 55, 255)
                DebugdrawTxtS(0.8, 0.62, 0.4,0.4,0.30, 'Speed: ' .. GetEntitySpeed(GetPlayerPed(-1)), 55, 155, 55, 255)
                DebugdrawTxtS(0.8, 0.64, 0.4,0.4,0.30, 'Frame Time: ' .. GetFrameTime(), 55, 155, 55, 255)
                DebugdrawTxtS(0.8, 0.66, 0.4,0.4,0.30, 'Street: ' .. currentStreetName, 55, 155, 55, 255)
                
                
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
    SetTextEntry('STRING')
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
    SetTextEntry('STRING')
    SetTextCentre(1)
    AddTextComponentString(text)
    DrawText(_x,_y)
    local factor = (string.len(text)) / 370
    DrawRect(_x,_y+0.0125, 0.015+ factor, 0.03, 41, 11, 41, 68)
end

---------------------------------------
-- TERREMOTO
---------------------------------------
CommandsData['terremoto'] = false

RegisterNetEvent('zero_core:terremoto', function()
	CommandsData['terremoto'] = true
	Citizen.CreateThread(function()
		while (CommandsData['terremoto']) do
			ShakeGameplayCam('SMALL_EXPLOSION_SHAKE', 0.2)
			Citizen.Wait(500)
		end
	end)
end)

---------------------------------------
-- RICH PRESENCE
---------------------------------------
RegisterNetEvent('zero_core:discord', function(status)
    SetDiscordAppId(1118989230266404976)
    SetDiscordRichPresenceAsset('logo')
	SetDiscordRichPresenceAssetSmall('logo')
	SetDiscordRichPresenceAssetSmallText('Zero City')
    SetRichPresence(status)
    SetDiscordRichPresenceAction(0, 'JOGAR', 'https://cfx.re/join/la77xo')
    SetDiscordRichPresenceAction(1, 'DISCORD', 'https://discord.gg/zerocity')
end)

---------------------------------------
-- FPS
---------------------------------------
RegisterCommand('fps', function(source, args)
	if (args[1]) then
		local command = string.lower(args[1])
		if (command == 'on') then
			LocalPlayer.state.FPS = true
			SetTimecycleModifier('cinema')
			RopeDrawShadowEnabled(false)
			CascadeShadowsClearShadowSampleType()
			CascadeShadowsSetAircraftMode(false)
			CascadeShadowsEnableEntityTracker(true)
			CascadeShadowsSetDynamicDepthMode(false)
			CascadeShadowsSetEntityTrackerScale(0.0)
			CascadeShadowsSetDynamicDepthValue(0.0)
			CascadeShadowsSetCascadeBoundsScale(0.0)
			SetFlashLightFadeDistance(0.0)
			SetLightsCutoffDistanceTweak(0.0)
			TriggerEvent('notify', 'FPS', 'Boost de <b>FPS</b> ligado.')
		elseif (command == 'off') then
			LocalPlayer.state.FPS = false
			SetTimecycleModifier('default')
			RopeDrawShadowEnabled(true)
			CascadeShadowsSetAircraftMode(true)
			CascadeShadowsEnableEntityTracker(false)
			CascadeShadowsSetDynamicDepthMode(true)
			CascadeShadowsSetEntityTrackerScale(5.0)
			CascadeShadowsSetDynamicDepthValue(5.0)
			CascadeShadowsSetCascadeBoundsScale(5.0)
			SetFlashLightFadeDistance(10.0)
			SetLightsCutoffDistanceTweak(10.0)
			TriggerEvent('notify', 'FPS', 'Boost de <b>FPS</b> desligado.')
		else
			TriggerEvent('notify', 'FPS', 'Você não digitou o comando corretamente, tente novamente!<br><br>- <b>/fps on</b><br>- <b>/fps off</b>')
		end
	else
		TriggerEvent('notify', 'FPS', 'Você não digitou o comando corretamente, tente novamente!<br><br>- <b>/fps on</b><br>- <b>/fps off</b>')
	end
end)

---------------------------------------
-- VTUNING
---------------------------------------
RegisterCommand('vtuning', function()
	local ped = PlayerPedId()
	local vehicle = GetVehiclePedIsUsing(ped)
	if (IsEntityAVehicle(vehicle)) then
		local body = GetVehicleBodyHealth(vehicle)
		local engine = GetVehicleEngineHealth(vehicle)
		local fuel = GetVehicleFuelLevel(vehicle)

		local motor = GetVehicleMod(vehicle, 11)
		if (motor == -1) then
			motor = 'Desativado'
		else
			motor = 'Nível '..(motor + 1)..' / '..GetNumVehicleMods(vehicle, 11)
		end

		local freio = GetVehicleMod(vehicle, 12)
		if (freio == -1) then
			freio = 'Desativado'
		else
			freio = 'Nível '..(freio + 1)..' / '..GetNumVehicleMods(vehicle, 12)
		end

		local transmissao = GetVehicleMod(vehicle, 13)
		if (transmissao == -1) then
			transmissao = 'Desativado'
		else
			transmissao = 'Nível '..(transmissao + 1)..' / '..GetNumVehicleMods(vehicle, 13)
		end

		local suspensao = GetVehicleMod(vehicle, 15)
		if (suspensao == -1) then
			suspensao = 'Desativado'
		else
			suspensao = 'Nível '..(suspensao + 1)..' / '..GetNumVehicleMods(vehicle, 15)
		end

		local blindagem = GetVehicleMod(vehicle, 16)
		if (blindagem == -1) then
			blindagem = 'Desativado'
		else
			blindagem = 'Nível '..(blindagem + 1)..' / '..GetNumVehicleMods(vehicle, 16)
		end

		TriggerEvent('notify', 'Ver Tunagens', '<b>Motor:</b> '..motor..'<br><b>Freio:</b> '..freio..'<br><b>Transmissão:</b> '..transmissao..'<br><b>Suspensão:</b> '..suspensao..'<br><b>Blindagem:</b> '..blindagem..'<br><b>Chassi:</b> '..parseInt(body/10)..'%<br><b>Engine:</b> '..parseInt(engine/10)..'%<br><b>Gasolina:</b> '..parseInt(fuel)..'%', 15000)
	end
end)

---------------------------------------
-- ROCKSTAR EDITOR
---------------------------------------
cli.stopAndSave = function()
	if (IsRecording()) then
		StopRecordingAndSaveClip()
	end
end

cli.openEditor = function()
	NetworkSessionLeaveSinglePlayer()
	ActivateRockstarEditor()
end

cli.Discard = function()
	if (IsRecording()) then
		StopRecordingAndDiscardClip()
	end
end

cli.StartEditor = function()
	StartRecording(1)
end

---------------------------------------
-- BVIDA
---------------------------------------
RegisterCommand('bvida', function()
	local ped = PlayerPedId()
	if (LocalPlayer.state.BlockTasks) then return; end;
	if (zero.isHandcuffed()) then return; end;

	if (zero.isMalas()) then
		TriggerEvent('notify', 'Bvida', 'Você não pode executar este <b>comando</b> dentro de um veículo')
		return
	end

	if (IsPedFalling(ped)) then
		TriggerEvent('notify', 'Bvida', 'Você não pode executar este comando em <b>queda livre</b>. <br><br>Boa queda amigão, tenha uma boa morte! ;)</b>')
		return
	end

	if (IsPedInAnyVehicle(ped)) then
		TriggerEvent('notify', 'Bvida', 'Você não pode executar este <b>comando</b> dentro de um veículo')
		return
	end

	if not IsEntityPlayingAnim(ped, 'anim@heists@ornate_bank@grab_cash_heels','grab', 3) and not IsEntityPlayingAnim(ped, 'mini@repair','fixing_a_player', 3) and not IsEntityPlayingAnim(ped, 'amb@medic@standing@tendtodead@idle_a','idle_a', 3) and not IsEntityPlayingAnim(ped, 'oddjobs@shop_robbery@rob_till','loop', 3) and not IsEntityPlayingAnim(ped, 'amb@world_human_sunbathe@female@back@idle_a','idle_a', 3) then
		if (vSERVER.Bvida()) then
			zero.DeletarObjeto()
			TriggerEvent('zero:barberUpdate')
			TriggerEvent('zero:tattooUpdate')
		end
	end
end)

---------------------------------------
-- SEQUESTRO
---------------------------------------
cli.checkSequestro = function()
	local pVehicle = GetClosestVehicle(GetEntityCoords(PlayerPedId()), 10.0, 0, 71)
    if (DoesEntityExist(pVehicle)) then
        local trunkBone = GetEntityBoneIndexByName(pVehicle, 'boot')
		return trunkBone
	end
end