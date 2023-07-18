local inVehicle = false

Citizen.CreateThread(function()
    SetBlipAlpha(GetNorthRadarBlip(), 0)
    RequestStreamedTextureDict('circlemap', false)
	while (not HasStreamedTextureDictLoaded('circlemap')) do Citizen.Wait(1); end;
	AddReplaceTexture('platform:/textures/graphics', 'radarmasksm', 'circlemap', 'radarmasksm')
	SetMinimapClipType(1)
	SetMinimapComponentPosition('minimap_blur', 'L', 'B', -0.015, 0.007, 0.21, 0.25)
	Citizen.Wait(0)
    SetBigmapActive(true, false)
	SetBigmapActive(false, false)

    while (true) do
        local idle = 5000
        local ped = PlayerPedId()
        if (not IsPedInAnyVehicle(ped)) then
            local veh = GetVehiclePedIsTryingToEnter(ped)
            if (veh > 0) then
                idle = 5     
                local pedVeh = GetPedInVehicleSeat(veh, -1)         
                if (pedVeh) then SetPedCanBeDraggedOut(pedVeh, false); end;             
            end  
        end
        Citizen.Wait(idle)
    end        
end)

local blackVehicles = {
    [GetHashKey('minitank')] = { 'Mini Tanque', true },
    [GetHashKey('oppressor2')] = { 'Oppressor 2', true },
	[GetHashKey('khanjali')] = { 'Khanjali', true },
	[GetHashKey('rhino')] = { 'Rhino', true },
	[GetHashKey('hydra')] = { 'Hydra', true },
	[GetHashKey('lazer')] = { 'Lazer', true },    
}

AddEventHandler('gameEventTriggered', function(event, args)
    if (event == 'CEventNetworkPlayerEnteredVehicle') then
        local id = args[1]
        local vehicle = args[2]
        if (id == PlayerId()) then
            if (inVehicle) then return; end;
            TriggerEvent('zero_core:spikeThread')

            inVehicle = true

            ExecuteCommand('-drift')

            local model = GetEntityModel(vehicle)
            if (blackVehicles[model]) then 
                if (blackVehicles[model][2]) then TriggerServerEvent('zero_anticheat', 'vehicles', blackVehicles[model][1]);  end;
            end
            drivingVehicle(model)

            local class = GetVehicleClass(vehicle)
            if (class ~= 14 and class ~= 13) then damageCar(class); end;

            if (class == 18) then radarPolice(); end;

            if (class == 15) then heliCam(); end;
        end
    end
end)

local keyPressed = false

RegisterKeyMapping('+drift', 'Garagem - Drift', 'keyboard', 'LSHIFT')
RegisterCommand('+drift', function()
    keyPressed = true
    local ped = PlayerPedId()
	if (IsPedInAnyVehicle(ped)) then
		local vehicle = GetVehiclePedIsIn(ped)
		local speed = (GetEntitySpeed(vehicle) * 3.6)
		if (GetPedInVehicleSeat(vehicle, -1) == ped) then
			if (speed <= 160.0) then
				if (keyPressed) then SetVehicleReduceGrip(vehicle, true); end;
			end
		end
	end
end)

RegisterCommand('-drift', function()
	local vehicle = GetVehiclePedIsIn(PlayerPedId())
	SetVehicleReduceGrip(vehicle, false)
    keyPressed = false
end)

local weaponLock = {
    [GetHashKey('kuruma2')] = true
}

drivingVehicle = function(model)
    Citizen.CreateThread(function()
        while (inVehicle) do
            local ped = PlayerPedId()
            local idle = 5000
            inVehicle = IsPedInAnyVehicle(ped)
            if (inVehicle) then
                idle = 5000
                
                local vehicle = GetVehiclePedIsIn(ped)
                if (weaponLock[model]) then SetPlayerCanDoDriveBy(PlayerId(), false); end;

                if (GetPedInVehicleSeat(vehicle, -1) == ped or GetPedInVehicleSeat(vehicle, 0) == ped) then
                    idle = 5
                    -- RETIRAR O CHUTE DA MOTO
                    if (GetVehicleClass(vehicle) == 8) then
                        SetPedConfigFlag(ped, 35, false) 
                        DisableControlAction(0, 345, true)
                    end
                    -- SEAT SHUFFLE
                    if (not GetIsTaskActive(ped, 164) and GetIsTaskActive(ped, 165)) then
                        SetPedIntoVehicle(ped, vehicle, 0)
                    end
				end    
            end
            Citizen.Wait(idle)
        end
        SetPlayerCanDoDriveBy(PlayerId(), true)
    end)
end

local pedInSameVehicleLast = false
local vehicle = nil
local lastVehicle = nil
local vehicleClass = nil

local healthEngineLast = 1000.0
local healthEngineCurrent = 1000.0
local healthEngineNew = 1000.0
local healthEngineDelta = 0.0
local healthEngineDeltaScaled = 0.0

local healthBodyLast = 1000.0
local healthBodyCurrent = 1000.0
local healthBodyNew = 1000.0
local healthBodyDelta = 0.0
local healthBodyDeltaScaled = 0.0

local classDamageMultiplier = { 1.5, 1.5, 1.5, 1.5, 1.5, 1.5, 1.5, 1.5, 1.5, 1.5, 1.5, 1.5, 1.5, 0.0, 0.0, 1.0, 1.5, 1.5, 1.5, 1.5, 1.5, 1.5 }

damageCar = function(class)
    Citizen.CreateThread(function()
        while (inVehicle) do
            local ped = PlayerPedId()
            inVehicle = IsPedInAnyVehicle(ped)
            
            local idle = 1000
            if (pedInSameVehicleLast) then
				idle = 5
				local factor = 1.0
				if (healthEngineNew < 900) then factor = ((healthEngineNew + 200.0) / 1100); end;
				SetVehicleEngineTorqueMultiplier(vehicle, factor)
			end

            if (class ~= 15 and class ~= 16) then
                local roll = GetEntityRoll(vehicle)
                if ((roll > 75.0 or roll < -75.0) and GetEntitySpeed(vehicle) < 2) then
                    DisableControlAction(2, 59, true)
                    DisableControlAction(2, 60, true)
                end
            end
            Citizen.Wait(idle)
        end
    end)

    Citizen.CreateThread(function()
        while (inVehicle) do
            local ped = PlayerPedId()
            inVehicle = IsPedInAnyVehicle(ped)

            if (class ~= 15 and class ~= 16) then
                local roll = GetEntityRoll(vehicle)
                if (roll > 75.0 or roll < -75.0) then
                    local tyre = math.random(4)
                    if (math.random(100) <= 50) then
                        if (tyre == 1) then
                            if (not IsVehicleTyreBurst(vehicle, 0, false)) then SetVehicleTyreBurst(vehicle, 0, true, 1000.0); end;
                        elseif (tyre == 2) then
                            if (not IsVehicleTyreBurst(vehicle, 1, false)) then SetVehicleTyreBurst(vehicle, 1, true, 1000.0); end;
                        elseif (tyre == 3) then
                            if (not IsVehicleTyreBurst(vehicle, 4, false)) then SetVehicleTyreBurst(vehicle, 4, true, 1000.0); end;
                        elseif (tyre == 4) then
                            if (not IsVehicleTyreBurst(vehicle, 5, false)) then SetVehicleTyreBurst(vehicle, 5, true, 1000.0); end;
                        end
                    end
                end
            end
            Citizen.Wait(1000)
        end
    end)

    Citizen.CreateThread(function()
        while (inVehicle) do
            local ped = PlayerPedId()
            inVehicle = IsPedInAnyVehicle(ped)

            local idle = 1000
            if (GetPedInVehicleSeat(vehicle, -1) == ped) then
                idle = 100

                vehicle = GetVehiclePedIsIn(ped)
                vehicleClass = GetVehicleClass(vehicle)
                healthEngineCurrent = GetVehicleEngineHealth(vehicle)

                if (healthEngineCurrent >= 1000) then healthEngineLast = 1000.0; end;

                healthEngineNew = healthEngineCurrent
				healthEngineDelta = (healthEngineLast - healthEngineCurrent)
				healthEngineDeltaScaled = (healthEngineDelta * 1.2 * classDamageMultiplier[vehicleClass])
				healthBodyCurrent = GetVehicleBodyHealth(vehicle)

                if (healthBodyCurrent == 1000) then healthBodyLast = 1000.0; end;

                healthBodyNew = healthBodyCurrent
				healthBodyDelta = (healthBodyLast - healthBodyCurrent)
				healthBodyDeltaScaled = (healthBodyDelta * 1.2 * classDamageMultiplier[vehicleClass])

                if (healthEngineCurrent > 101.0) then SetVehicleUndriveable(vehicle, false); end;
	
				if (healthEngineCurrent <= 101.0) then SetVehicleUndriveable(vehicle, true); end;
	
				if (vehicle ~= lastVehicle) then pedInSameVehicleLast = false; end;

                if (pedInSameVehicleLast) then
					if (healthEngineCurrent ~= 1000.0 or healthBodyCurrent ~= 1000.0) then
						local healthEngineCombinedDelta = math.max(healthEngineDeltaScaled,healthBodyDeltaScaled)
						if (healthEngineCombinedDelta > (healthEngineCurrent - 100.0)) then healthEngineCombinedDelta = (healthEngineCombinedDelta * 0.7); end;
	
						if (healthEngineCombinedDelta > healthEngineCurrent) then healthEngineCombinedDelta = (healthEngineCurrent - (210.0 / 5)); end;
						healthEngineNew = (healthEngineLast - healthEngineCombinedDelta)
	
						if (healthEngineNew > (210.0 + 5) and healthEngineNew < 477.0) then healthEngineNew = (healthEngineNew-(0.038 * 3.2)); end;
	
						if (healthEngineNew < 210.0) then healthEngineNew = (healthEngineNew-(0.1 * 0.9)); end;
	
						if (healthEngineNew < 100.0) then healthEngineNew = 100.0; end;
	
						if (healthBodyNew < 0) then healthBodyNew = 0.0; end;
					end
				else
					if (healthBodyCurrent < 210.0) then healthBodyNew = 210.0; end;
					pedInSameVehicleLast = true
				end

                if (healthEngineNew ~= healthEngineCurrent) then SetVehicleEngineHealth(vehicle, healthEngineNew); end;
	
				if (healthBodyNew ~= healthBodyCurrent) then SetVehicleBodyHealth(vehicle, healthBodyNew); end;
	
				healthEngineLast = healthEngineNew
				healthBodyLast = healthBodyNew
				lastVehicle = vehicle
            else
                pedInSameVehicleLast = false
            end
            Citizen.Wait(idle)
        end
    end)
end

local radar = {
	shown = false,
	freeze = false,
	info = 'INICIANDO O SISTEMA DO RADAR',
	info2 = 'INICIANDO O SISTEMA DO RADAR'
}

radarPolice = function()
    Citizen.CreateThread(function()
        while (inVehicle) do
            local ped = PlayerPedId()
            inVehicle = IsPedInAnyVehicle(ped)
            
            local idle = 1000
            if (IsPedInAnyPoliceVehicle(ped)) then
                idle = 4
                if (IsControlJustPressed(0, 306)) then radar.shown = (not radar.shown); end;
                if (IsControlJustPressed(0, 301)) then radar.freeze = (not radar.freeze); end;

                if (radar.shown and IsPedInAnyVehicle(ped)) then
                    if (not radar.freeze) then
                        local veh = GetVehiclePedIsIn(ped)
						local coordA = GetOffsetFromEntityInWorldCoords(veh, 0.0, 1.0, 1.0)
						local coordB = GetOffsetFromEntityInWorldCoords(veh, 0.0, 105.0, 0.0)
						local frontcar = StartShapeTestCapsule(coordA, coordB, 3.0, 10, veh, 7)
						local a, b, c, d, e = GetShapeTestResult(frontcar)

                        if (IsEntityAVehicle(e)) then
							local fmodel = GetDisplayNameFromVehicleModel(GetEntityModel(e))
							local fvspeed = (GetEntitySpeed(e) * 3.6)
							local fplate = GetVehicleNumberPlateText(e)
							radar.info = string.format('~b~PLACA: ~w~%s   ~b~MODELO: ~w~%s   ~b~VELOCIDADE: ~w~%s KMH', fplate, fmodel, math.ceil(fvspeed))
						end

                        local bcoordB = GetOffsetFromEntityInWorldCoords(veh, 0.0, -105.0, 0.0)
						local rearcar = StartShapeTestCapsule(coordA, bcoordB, 3.0, 10, veh, 7)
						local f,g,h,i,j = GetShapeTestResult(rearcar)

                        if (IsEntityAVehicle(j)) then
							local bmodel = GetDisplayNameFromVehicleModel(GetEntityModel(j))
							local bvspeed = (GetEntitySpeed(j) * 3.6)
							local bplate = GetVehicleNumberPlateText(j)
							radar.info2 = string.format('~b~PLACA: ~w~%s   ~b~MODELO: ~w~%s   ~b~VELOCIDADE: ~w~%s KMH', bplate, bmodel, math.ceil(bvspeed))
						end
                    end

                    drawTxt(radar.info, 7, 0.5, 0.905, 0.4, 255, 255, 255, 255)
                    drawTxt(radar.info, 7, 0.5, 0.93, 0.4, 255, 255, 255, 255)
                end
            end
            Citizen.Wait(idle)
        end
    end)
end

DecorRegister('SpotvectorX', 3)
DecorRegister('SpotvectorY', 3)
DecorRegister('SpotvectorZ', 3)
DecorRegister('Target', 3)

local allowHeli = {
	[GetHashKey('polmav')] = true,
}

local getHeliWithCam = function()
	local model = GetEntityModel(GetVehiclePedIsIn(PlayerPedId()))
	return (allowHeli[model] or false)
end

-- local helicam = false
-- local target_vehicle = nil
-- local manual_spotlight = false
-- local tracking spotlight = false
-- local vehicle_display = 0 
-- local fov = (fov_max+fov_min)*0.5
-- local vision_state = 0

-- heliCam = function()
--     Citizen.CreateThread(function()
--         while (inVehicle) do
--             local idle = 5000
--             local ped = PlayerPedId()
--             inVehicle = IsPedInAnyVehicle(ped)
--             if (getHeliWithCam()) then
--                 local vehicle = GetVehiclePedIsIn(ped)
--                 idle = 5

--                 if (IsControlJustPressed(0, 38)) then 
--                     helicam = true 
--                     PlaySoundFrontend(-1, 'SELECT', 'HUD_FRONTEND_DEFAULT_SOUNDSET', false) 
--                 end
                
--                 if (IsControlJustPressed(0, 154)) then
--                     if (GetPedInVehicleSeat(vehicle, 1) == ped or GetPedInVehicleSeat(vehicle, 2) == ped) then
--                         PlaySoundFrontend(-1, 'SELECT', 'HUD_FRONTEND_DEFAULT_SOUNDSET', false)
-- 						TaskRappelFromHeli(ped,  1)
--                     else
--                         PlaySoundFrontend(-1, '5_Second_Timer', 'DLC_HEISTS_GENERAL_FRONTEND_SOUNDS', false) 
--                         TriggerEvent('notify', 'Rapel', 'Você não pode usar o <b>Rapel</b> neste acento.')
--                     end
--                 end

--                 if (IsControlJustPressed(0, 183) and GetPedInVehicleSeat(vehicle, -1) == ped and not helicam) then
--                     if (target_vehicle) then

--                     else
                        
--                     end
--                 end
--             end
--             Citizen.Wait(idle)
--         end
--     end)
-- end