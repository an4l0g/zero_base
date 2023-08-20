local cli = {}
Tunnel.bindInterface('CarsEvent', cli) 

local inVehicle = false

Citizen.CreateThread(function()
    SetBlipAlpha(GetNorthRadarBlip(), 0)
    RequestStreamedTextureDict('circlemap', false)
	while (not HasStreamedTextureDictLoaded('circlemap')) do Citizen.Wait(1); end;
	AddReplaceTexture('platform:/textures/graphics', 'radarmasksm', 'circlemap', 'radarmasksm')
	SetMinimapClipType(1)
	SetMinimapComponentPosition('minimap_blur', 'L', 'B', -0.015, 0.007, 0.21, 0.25)
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
            LocalPlayer.state.inVehicle = true
            
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

            Citizen.Wait(3500)
            ClearPedTasks(PlayerPedId())
        end
    end
end)

cli.getCarDoorCoord = function(dist, door)
    local ped = PlayerPedId()
    local pCoord = GetEntityCoords(ped)
    local pVehicle = GetClosestVehicle(pCoord, 2.5, 0, 71)
    if (pVehicle and not IsPedInAnyVehicle(ped)) then
        local engine = GetWorldPositionOfEntityBone(pVehicle, GetEntityBoneIndexByName(pVehicle, door))
        local distance = #(pCoord - engine)
        if (distance <= dist) then
            return true
        end
    end
    return false
end
exports('carDoor', getCarDoorCoord)

cli.setVehicleAlarm = function()
    local ped = PlayerPedId()
    local pCoord = GetEntityCoords(ped)
    local vehicle = GetClosestVehicle(pCoord, 2.5, 0, 71)
    if (vehicle and not IsPedInAnyVehicle(ped)) then
        SetVehicleAlarm(vehicle, true)
        SetVehicleAlarmTimeLeft(vehicle, 10000)
    end
end
exports('vehicleAlarm', setVehicleAlarm)

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
                
                if (IsPedShooting(ped) and not IsPedInAnyHeli(ped)) then
                    idle = 5
                    ShakeGameplayCam('SMALL_EXPLOSION_SHAKE', 0.3)
                end

                if (GetPedInVehicleSeat(vehicle, -1) == ped or GetPedInVehicleSeat(vehicle, 0) == ped) then
                    idle = 5
                    -- RETIRAR O CHUTE DA MOTO
                    if (GetVehicleClass(vehicle) == 8) then
                        DisableControlAction(0, 345, true)
                        SetPedConfigFlag(ped, 35, false) 
                    end
                    
                    -- SEAT SHUFFLE
                    if (not GetIsTaskActive(ped, 164) and GetIsTaskActive(ped, 165)) then
                        SetPedIntoVehicle(ped, vehicle, 0)
                    end
				end    
            end
            Citizen.Wait(idle)
        end
        LocalPlayer.state.inVehicle = false
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

                if (healthEngineCurrent > 100.0) then SetVehicleUndriveable(vehicle, false); end;
	
				if (healthEngineCurrent <= 100.0) then SetVehicleUndriveable(vehicle, true); end;
	
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

local fov_max = 80.0
local fov_min = 5.0 -- max zoom level (smaller fov is more zoom)
local zoomspeed = 3.0 -- camera zoom speed
local speed_lr = 4.0 -- speed by which the camera pans left-right 
local speed_ud = 4.0 -- speed by which the camera pans up-down

local toggle_helicam = 51 -- control id of the button by which to toggle the helicam mode. Default: INPUT_CONTEXT (E)
local toggle_vision = 25 -- control id to toggle vision mode. Default: INPUT_AIM (Right mouse btn)
local toggle_rappel = 154 -- control id to rappel out of the heli. Default: INPUT_DUCK (X)
local toggle_spotlight = 183 -- control id to toggle the various spotlight states Default: INPUT_PhoneCameraGrid (G)
local toggle_lock_on = 22 -- control id to lock onto a vehicle with the camera or unlock from vehicle (with or without camera). Default is INPUT_SPRINT (spacebar)
local toggle_display = 44 -- control id to toggle vehicle info display. Default: INPUT_COVER (Q)
local lightup_key = 246 -- control id to increase spotlight brightness. Default: INPUT_MP_TEXT_CHAT_TEAM (Y)
local lightdown_key = 173 -- control id to decrease spotlight brightness. Default: INPUT_CELLPHONE_DOWN  (ARROW-DOWN)
local radiusup_key = 137 -- control id to increase manual spotlight radius. Default: INPUT_VEH_PUSHBIKE_SPRINT (CAPSLOCK)
local radiusdown_key = 21 -- control id to decrease spotlight radius. Default: INPUT_SPRINT (LEFT-SHIFT)

local maxtargetdistance = 700 -- max distance at which target lock is maintained
local brightness = 1.0 -- default spotlight brightness
local spotradius = 4.0 -- default manual spotlight radius
local speed_measure = "Km/h" -- default unit to measure vehicle speed but can be changed to "MPH". Use either exact string, "Km/h" or "MPH", or else functions break.

-- Script starts here
local target_vehicle = nil
local manual_spotlight = false
local tracking spotlight = false
local vehicle_display = 0 -- 0 is default full vehicle info display with speed/model/plate, 1 is model/plate, 2 turns off display
local helicam = false
local fov = (fov_max+fov_min)*0.5
local vision_state = 0 -- 0 is normal, 1 is nightmode, 2 is thermal vision

heliCam = function()
    Citizen.CreateThread(function()
        while (inVehicle) do
            local idle = 5000
            local ped = PlayerPedId()
            inVehicle = IsPedInAnyVehicle(ped)
            if (getHeliWithCam()) then
                local vehicle = GetVehiclePedIsIn(ped)
                idle = 5

                if (IsControlJustPressed(0, 38)) then 
                    helicam = true 
                    PlaySoundFrontend(-1, 'SELECT', 'HUD_FRONTEND_DEFAULT_SOUNDSET', false) 
                end
                
                if (IsControlJustPressed(0, 154)) then
                    if (GetPedInVehicleSeat(vehicle, 1) == ped or GetPedInVehicleSeat(vehicle, 2) == ped) then
                        PlaySoundFrontend(-1, 'SELECT', 'HUD_FRONTEND_DEFAULT_SOUNDSET', false)
						TaskRappelFromHeli(ped,  1)
                    else
                        PlaySoundFrontend(-1, '5_Second_Timer', 'DLC_HEISTS_GENERAL_FRONTEND_SOUNDS', false) 
                        TriggerEvent('notify', 'Rapel', 'Você não pode usar o <b>Rapel</b> neste acento.')
                    end
                end

                if (IsControlJustPressed(0, 183) and GetPedInVehicleSeat(vehicle, -1) == ped and not helicam) then
                    if (target_vehicle) then
                        if (tracking_spotlight) then
                            if (not pause_Tspotlight) then
                                pause_Tspotlight = true
                                TriggerServerEvent('heli:pause.tracking.spotlight', pause_Tspotlight)
                            else
                                pause_Tspotlight = false
                                TriggerServerEvent('heli:pause.tracking.spotlight', pause_Tspotlight)
                            end
                            PlaySoundFrontend(-1, 'SELECT', 'HUD_FRONTEND_DEFAULT_SOUNDSET', false)
                        else
                            if (Fspotlight_state) then
                                Fspotlight_state = false	
                                TriggerServerEvent('heli:forward.spotlight', Fspotlight_state)
                            end

                            local target_netID = VehToNet(target_vehicle)
                            local target_plate = GetVehicleNumberPlateText(target_vehicle)
                            local targetpos = GetEntityCoords(target_vehicle)
                            pause_Tspotlight = false
                            tracking_spotlight = true
                            TriggerServerEvent('heli:tracking.spotlight', target_netID, target_plate, targetpos.x, targetpos.y, targetpos.z)
                            PlaySoundFrontend(-1, 'SELECT', 'HUD_FRONTEND_DEFAULT_SOUNDSET', false)
                        end
                    else
                        if (tracking_spotlight) then
                            pause_Tspotlight = false
                            tracking_spotlight = false
                            TriggerServerEvent("heli:tracking.spotlight.toggle")
                        end
                        Fspotlight_state = not Fspotlight_state
                        TriggerServerEvent("heli:forward.spotlight", Fspotlight_state)
                        PlaySoundFrontend(-1, "SELECT", "HUD_FRONTEND_DEFAULT_SOUNDSET", false)
                    end
                end

                if (IsControlJustPressed(0, 44) and GetPedInVehicleSeat(vehicle, -1) == ped) then 
                    ChangeDisplay()
                end

                if (target_vehicle and GetPedInVehicleSeat(vehicle, -1) == ped) then
                    local coords1 = GetEntityCoords(vehicle)
                    local coords2 = GetEntityCoords(target_vehicle)
                    local target_distance = GetDistanceBetweenCoords(coords1.x, coords1.y, coords1.z, coords2.x, coords2.y, coords2.z, false)
                    if (IsControlJustPressed(0, 22) or target_distance > maxtargetdistance) then
                        DecorRemove(target_vehicle, "Target")
                        if (tracking_spotlight) then
                            TriggerServerEvent("heli:tracking.spotlight.toggle")
                        end
                        tracking_spotlight = false
                        pause_Tspotlight = false
                        target_vehicle = nil					
                        PlaySoundFrontend(-1, "SELECT", "HUD_FRONTEND_DEFAULT_SOUNDSET", false)
                    end
                end
            end

            if (helicam) then
                SetTimecycleModifier("heliGunCam")
                SetTimecycleModifierStrength(0.3)

                local scaleform = RequestScaleformMovie("HELI_CAM")
                while (not HasScaleformMovieLoaded(scaleform)) do
                    Citizen.Wait(0)
                end

                ttachCamToEntity(cam, vehicle, 0.0,0.0,-1.5, true)
                SetCamRot(cam, 0.0,0.0,GetEntityHeading(vehicle))
                SetCamFov(cam, fov)
                RenderScriptCams(true, false, 0, 1, 0)
                PushScaleformMovieFunction(scaleform, "SET_CAM_LOGO")
                PushScaleformMovieFunctionParameterInt(0)
                PopScaleformMovieFunctionVoid()

                local locked_on_vehicle = nil
                while (helicam and not IsEntityDead(ped) and (GetVehiclePedIsIn(ped) == vehicle) and IsHeliHighEnough(vehicle)) do
                    if (IsControlJustPressed(0, 51)) then
                        PlaySoundFrontend(-1, "SELECT", "HUD_FRONTEND_DEFAULT_SOUNDSET", false)
                        if manual_spotlight and target_vehicle then -- If exiting helicam while manual spotlight is locked on a target, transition to non-helicam auto tracking spotlight
                            TriggerServerEvent("heli:manual.spotlight.toggle")
                            local target_netID = VehToNet(target_vehicle)
                            local target_plate = GetVehicleNumberPlateText(target_vehicle)
                            local targetposx, targetposy, targetposz = table.unpack(GetEntityCoords(target_vehicle))
                            pause_Tspotlight = false
                            tracking_spotlight = true
                            TriggerServerEvent("heli:tracking.spotlight", target_netID, target_plate, targetposx, targetposy, targetposz)
                            PlaySoundFrontend(-1, "SELECT", "HUD_FRONTEND_DEFAULT_SOUNDSET", false)
                        end
                        manual_spotlight = false
                        helicam = false
                    end

                    if IsControlJustPressed(0, toggle_vision) then
                        PlaySoundFrontend(-1, "SELECT", "HUD_FRONTEND_DEFAULT_SOUNDSET", false)
                        ChangeVision()
				    end

                    if IsControlJustPressed(0, 25) then -- Spotlight_toggles within helicam
                        if tracking_spotlight then -- If tracking spotlight active, pause it & toggle manual spotlight
                            pause_Tspotlight = true
                            TriggerServerEvent("heli:pause.tracking.spotlight", pause_Tspotlight)
                            manual_spotlight = not manual_spotlight
                            if manual_spotlight then
                                local rotation = GetCamRot(cam, 2)
                                local forward_vector = RotAnglesToVec(rotation)
                                local SpotvectorX, SpotvectorY, SpotvectorZ = table.unpack(forward_vector)
                                DecorSetInt(ped, "SpotvectorX", SpotvectorX)
                                DecorSetInt(ped, "SpotvectorY", SpotvectorY)
                                DecorSetInt(ped, "SpotvectorZ", SpotvectorZ)
                                PlaySoundFrontend(-1, "SELECT", "HUD_FRONTEND_DEFAULT_SOUNDSET", false)
                                TriggerServerEvent("heli:manual.spotlight")
                            else
                                TriggerServerEvent("heli:manual.spotlight.toggle")
                            end
                        elseif Fspotlight_state then -- If forward spotlight active, disable it & toggle manual spotlight
                            Fspotlight_state = false
                            TriggerServerEvent("heli:forward.spotlight", Fspotlight_state)
                            manual_spotlight = not manual_spotlight
                            if manual_spotlight then
                                PlaySoundFrontend(-1, "SELECT", "HUD_FRONTEND_DEFAULT_SOUNDSET", false)
                                TriggerServerEvent("heli:manual.spotlight")
                            else
                                TriggerServerEvent("heli:manual.spotlight.toggle")
                            end
                        else -- If no other spotlight mode active, toggle manual spotlight
                            manual_spotlight = not manual_spotlight
                            if manual_spotlight then
                                PlaySoundFrontend(-1, "SELECT", "HUD_FRONTEND_DEFAULT_SOUNDSET", false)
                                TriggerServerEvent("heli:manual.spotlight")
                            else
                                TriggerServerEvent("heli:manual.spotlight.toggle")
                            end
                        end
                    end

                    if IsControlJustPressed(0, 246) then
                        TriggerServerEvent("heli:light.up")
                    end

                    if IsControlJustPressed(0, 173) then
                        TriggerServerEvent("heli:light.down")
                    end

                    if IsControlJustPressed(0, 137) then
                        TriggerServerEvent("heli:radius.up")
                    end

                    if IsControlJustPressed(0, 21) then
                        TriggerServerEvent("heli:radius.down")
                    end

                    if IsControlJustPressed(0, 44) then 
                        ChangeDisplay()
                    end
          
                    if locked_on_vehicle then
                        if DoesEntityExist(locked_on_vehicle) then
                            PointCamAtEntity(cam, locked_on_vehicle, 0.0, 0.0, 0.0, true)
                            RenderVehicleInfo(locked_on_vehicle)
                            local coords1 = GetEntityCoords(vehicle)
                            local coords2 = GetEntityCoords(locked_on_vehicle)
                            local target_distance = GetDistanceBetweenCoords(coords1.x, coords1.y, coords1.z, coords2.x, coords2.y, coords2.z, false)
                            if IsControlJustPressed(0, toggle_lock_on) or target_distance > maxtargetdistance then
                                --Citizen.Trace("Heli: locked_on_vehicle unlocked or lost")
                                PlaySoundFrontend(-1, "SELECT", "HUD_FRONTEND_DEFAULT_SOUNDSET", false)
                                DecorRemove(target_vehicle, "Target")
                                if tracking_spotlight then
                                    TriggerServerEvent("heli:tracking.spotlight.toggle")
                                    tracking_spotlight = false
                                end
                                target_vehicle = nil
                                locked_on_vehicle = nil
                                local rot = GetCamRot(cam, 2) -- All this because I can't seem to get the camera unlocked from the entity
                                local fov = GetCamFov(cam)
                                local old cam = cam
                                DestroyCam(old_cam, false)
                                cam = CreateCam("DEFAULT_SCRIPTED_FLY_CAMERA", true)
                                AttachCamToEntity(cam, vehicle, 0.0,0.0,-1.5, true)
                                SetCamRot(cam, rot, 2)
                                SetCamFov(cam, fov)
                                RenderScriptCams(true, false, 0, 1, 0)
                            end
                        else
                            locked_on_vehicle = nil -- Cam will auto unlock when entity doesn't exist anyway
						    target_vehicle = nil
                        end
                    else
                        local zoomvalue = (1.0/(fov_max-fov_min))*(fov-fov_min)
                        CheckInputRotation(cam, zoomvalue)
                        local vehicle_detected = GetVehicleInView(cam)
                        if DoesEntityExist(vehicle_detected) then
                            RenderVehicleInfo(vehicle_detected)
                            if IsControlJustPressed(0, toggle_lock_on) then
                                PlaySoundFrontend(-1, "SELECT", "HUD_FRONTEND_DEFAULT_SOUNDSET", false)
                                locked_on_vehicle = vehicle_detected
                
                                if target_vehicle then -- If previous target exists, remove old target decorator before updating target vehicle
                                    DecorRemove(target_vehicle, "Target")
                                end
                                
                                target_vehicle = vehicle_detected
                                NetworkRequestControlOfEntity(target_vehicle)
                                local target_netID = VehToNet(target_vehicle) 
                                SetNetworkIdCanMigrate(target_netID, true)
                                NetworkRegisterEntityAsNetworked(VehToNet(target_vehicle))
                                SetNetworkIdExistsOnAllMachines(target_vehicle, true) 
                                SetEntityAsMissionEntity(target_vehicle, true, true) 
                                target_plate = GetVehicleNumberPlateText(target_vehicle)
                                DecorSetInt(locked_on_vehicle, "Target", 2)

                                if tracking_spotlight then -- If tracking previous target, terminate and start tracking new target
                                    TriggerServerEvent("heli:tracking.spotlight.toggle")
                                    target_vehicle = locked_on_vehicle
                                    
                                    if not pause_Tspotlight then -- If spotlight was paused when tracking old target, 
                                        local target_netID = VehToNet(target_vehicle)
                                        local target_plate = GetVehicleNumberPlateText(target_vehicle)
                                        local targetposx, targetposy, targetposz = table.unpack(GetEntityCoords(target_vehicle))
                                        pause_Tspotlight = false
                                        tracking_spotlight = true
                                        TriggerServerEvent("heli:tracking.spotlight", target_netID, target_plate, targetposx, targetposy, targetposz)
                                        PlaySoundFrontend(-1, "SELECT", "HUD_FRONTEND_DEFAULT_SOUNDSET", false)
                                    else
                                        tracking_spotlight = false
                                        pause_Tspotlight = false
                                    end
                                end
                            end
                        end
                    end

                    HandleZoom(cam)
                    PushScaleformMovieFunction(scaleform, "SET_ALT_FOV_HEADING")
                    PushScaleformMovieFunctionParameterFloat(GetEntityCoords(vehicle).z)
                    PushScaleformMovieFunctionParameterFloat(zoomvalue)
                    PushScaleformMovieFunctionParameterFloat(GetCamRot(cam, 2).z)
                    PopScaleformMovieFunctionVoid()
                    DrawScaleformMovieFullscreen(scaleform, 255, 255, 255, 255)
                    Citizen.Wait(0)

                    if manual_spotlight then -- Continuously update manual spotlight direction, sync client-client with decorators
                        local rotation = GetCamRot(cam, 2)
                        local forward_vector = RotAnglesToVec(rotation)
                        local SpotvectorX, SpotvectorY, SpotvectorZ = table.unpack(forward_vector)
                        local camcoords = GetCamCoord(cam)

                        DecorSetInt(ped, "SpotvectorX", SpotvectorX)
                        DecorSetInt(ped, "SpotvectorY", SpotvectorY)
                        DecorSetInt(ped, "SpotvectorZ", SpotvectorZ)
                        DrawSpotLight(camcoords, forward_vector, 255, 255, 255, 800.0, 10.0, brightness, spotradius, 1.0, 1.0)
                    else
                        TriggerServerEvent("heli:manual.spotlight.toggle")
                    end
                end

                if manual_spotlight then
                    manual_spotlight = false
                    TriggerServerEvent("heli:manual.spotlight.toggle")
                end
                helicam = false
                ClearTimecycleModifier()
                fov = (fov_max+fov_min)*0.5 -- reset to starting zoom level
                RenderScriptCams(false, false, 0, 1, 0) -- Return to gameplay camera
                SetScaleformMovieAsNoLongerNeeded(scaleform) -- Cleanly release the scaleform
                DestroyCam(cam, false)
                SetNightvision(false)
                SetSeethrough(false)
            end

            if (getHeliWithCam() and target_vehicle and not helicam and vehicle_display ~=2) then
                RenderVehicleInfo(target_vehicle)
            end
            Citizen.Wait(idle)
        end
    end)
end

ChangeDisplay = function()
	if (vehicle_display == 0) then
		vehicle_display = 1
	elseif (vehicle_display == 1) then
		vehicle_display = 2
	else
		vehicle_display = 0
	end
end

RenderVehicleInfo = function(vehicle)
	if DoesEntityExist(vehicle) then
		local model = GetEntityModel(vehicle)
		local vehname = GetLabelText(GetDisplayNameFromVehicleModel(model))
		local licenseplate = GetVehicleNumberPlateText(vehicle)
		if speed_measure == "MPH" then
			vehspeed = GetEntitySpeed(vehicle)*2.236936
		else
			vehspeed = GetEntitySpeed(vehicle)*3.6
		end
		SetTextFont(0)
		SetTextProportional(1)
		if vehicle_display == 0 then
			SetTextScale(0.0, 0.49)
		elseif vehicle_display == 1 then
			SetTextScale(0.0, 0.55)
		end
		SetTextColour(255, 255, 255, 255)
		SetTextDropshadow(0, 0, 0, 0, 255)
		SetTextEdge(1, 0, 0, 0, 255)
		SetTextDropShadow()
		SetTextOutline()
		SetTextEntry("STRING")
		if vehicle_display == 0 then
			AddTextComponentString("Speed: " .. math.ceil(vehspeed) .. " " .. speed_measure .. "\nModel: " .. vehname .. "\nPlate: " .. licenseplate)
		elseif vehicle_display == 1 then
			AddTextComponentString("Model: " .. vehname .. "\nPlate: " .. licenseplate)
		end
		DrawText(0.45, 0.9)
	end
end

RegisterNetEvent('heli:forward.spotlight')
AddEventHandler('heli:forward.spotlight', function(serverID, state)
	local heli = GetVehiclePedIsIn(GetPlayerPed(GetPlayerFromServerId(serverID)), false)
	SetVehicleSearchlight(heli, state, false)
end)

RegisterNetEvent('heli:Tspotlight')
AddEventHandler('heli:Tspotlight', function(serverID, target_netID, target_plate, targetposx, targetposy, targetposz)

	-- Client target identification and verification, with fail-safes until FiveM code around global networked entities is sorted out
	if GetVehicleNumberPlateText(NetToVeh(target_netID)) == target_plate then
		Tspotlight_target = NetToVeh(target_netID)
	elseif GetVehicleNumberPlateText(DoesVehicleExistWithDecorator("Target")) == target_plate then
		Tspotlight_target = DoesVehicleExistWithDecorator("Target")
		--Citizen.Trace("Client target ID by primary netID method failed! Secondary decorator-based method worked.")
	elseif GetVehicleNumberPlateText(GetClosestVehicle(targetposx, targetposy, targetposz, 25.0, 0, 70)) == target_plate then
		Tspotlight_target = GetClosestVehicle(targetposx, targetposy, targetposz, 25.0, 0, 70)
		--Citizen.Trace("Heli: client target ID methods based on netID and decorator both failed! Tertiary method using target coordinates worked.")
	else 
		vehicle_match = FindVehicleByPlate(target_plate)
		if vehicle_match then
			Tspotlight_target = vehicle_match
			--Citizen.Trace("Heli: client target ID methods based on netID, decorator and coords all failed! Final method of searching vehicles by plate worked.")
		else 
			Tspotlight_target = nil
			--Citizen.Trace("Heli: all methods of client target ID failed!!")
		end
	end

	local heli = GetVehiclePedIsIn(GetPlayerPed(GetPlayerFromServerId(serverID)), false)
	local heliPed = GetPlayerPed(GetPlayerFromServerId(serverID))
	Tspotlight_toggle = true
	Tspotlight_pause = false
	tracking_spotlight = true
	while not IsEntityDead(heliPed) and (GetVehiclePedIsIn(heliPed) == heli) and Tspotlight_target and Tspotlight_toggle do
		Citizen.Wait(1)
		local helicoords = GetEntityCoords(heli)
		local targetcoords = GetEntityCoords(Tspotlight_target)
		local spotVector = targetcoords - helicoords
		local target_distance = Vdist(targetcoords, helicoords)
		if Tspotlight_target and Tspotlight_toggle and not Tspotlight_pause then -- Redundant condition seems needed here or a function breaks
			DrawSpotLight(helicoords['x'], helicoords['y'], helicoords['z'], spotVector['x'], spotVector['y'], spotVector['z'], 255, 255, 255, (target_distance+20), 10.0, brightness, 4.0, 1.0, 0.0)
		end
		if Tspotlight_target and Tspotlight_toggle and target_distance > maxtargetdistance then -- Ditto for this target loss section
			--Citizen.Trace("Heli: tracking spotlight target lost")
			DecorRemove(Tspotlight_target, "Target")			
			target_vehicle = nil
			tracking_spotlight = false
			TriggerServerEvent("heli:tracking.spotlight.toggle")
			Tspotlight_target = nil
			break
		end
	end
	Tspotlight_toggle = false
	Tspotlight_pause = false
	Tspotlight_target = nil
	tracking_spotlight = false
end)

RegisterNetEvent('heli:Tspotlight.toggle')
AddEventHandler('heli:Tspotlight.toggle', function(serverID)
	Tspotlight_toggle = false
	tracking_spotlight = false
end)

RegisterNetEvent('heli:pause.Tspotlight')
AddEventHandler('heli:pause.Tspotlight', function(serverID, pause_Tspotlight)
	if pause_Tspotlight then
		Tspotlight_pause = true
	else
		Tspotlight_pause = false
	end
end)

RegisterNetEvent('heli:Mspotlight')
AddEventHandler('heli:Mspotlight', function(serverID)
	if GetPlayerServerId(PlayerId()) ~= serverID then -- Skip event for the source, since heli pilot already sees a more responsive manual spotlight
		local heli = GetVehiclePedIsIn(GetPlayerPed(GetPlayerFromServerId(serverID)), false)
		local heliPed = GetPlayerPed(GetPlayerFromServerId(serverID))
		Mspotlight_toggle = true
		while not IsEntityDead(heliPed) and (GetVehiclePedIsIn(heliPed) == heli) and Mspotlight_toggle do
			Citizen.Wait(0) 
			local helicoords = GetEntityCoords(heli)
			spotoffset = helicoords + vector3(0.0, 0.0, -1.5)
			SpotvectorX = DecorGetInt(heliPed, "SpotvectorX")
			SpotvectorY = DecorGetInt(heliPed, "SpotvectorY")
			SpotvectorZ = DecorGetInt(heliPed, "SpotvectorZ")
			if SpotvectorX then
				DrawSpotLight(spotoffset['x'], spotoffset['y'], spotoffset['z'], SpotvectorX, SpotvectorY, SpotvectorZ, 255, 255, 255, 800.0, 10.0, brightness, spotradius, 1.0, 1.0)
			end
		end
		Mspotlight_toggle = false
		DecorSetInt(heliPed, "SpotvectorX", nil)
		DecorSetInt(heliPed, "SpotvectorY", nil)
		DecorSetInt(heliPed, "SpotvectorZ", nil)
	end
end)

RegisterNetEvent('heli:Mspotlight.toggle')
AddEventHandler('heli:Mspotlight.toggle', function(serverID)
	Mspotlight_toggle = false
end)

RegisterNetEvent('heli:light.up')
AddEventHandler('heli:light.up', function(serverID)
	if brightness < 10 then
		brightness = brightness + 1.0
		PlaySoundFrontend(-1, "SELECT", "HUD_FRONTEND_DEFAULT_SOUNDSET", false)
	end
end)

RegisterNetEvent('heli:light.down')
AddEventHandler('heli:light.down', function(serverID)
	if brightness > 1.0 then
		brightness = brightness - 1.0
		PlaySoundFrontend(-1, "SELECT", "HUD_FRONTEND_DEFAULT_SOUNDSET", false)
	end
end)

RegisterNetEvent('heli:radius.up')
AddEventHandler('heli:radius.up', function(serverID)
	if spotradius < 10.0 then
		spotradius = spotradius + 1.0
		PlaySoundFrontend(-1, "SELECT", "HUD_FRONTEND_DEFAULT_SOUNDSET", false)
	end
end)

RegisterNetEvent('heli:radius.down')
AddEventHandler('heli:radius.down', function(serverID)
	if spotradius > 4.0 then
		spotradius = spotradius - 1.0
		PlaySoundFrontend(-1, "SELECT", "HUD_FRONTEND_DEFAULT_SOUNDSET", false)
	end
end)

CheckInputRotation = function(cam, zoomvalue)
	local rightAxisX = GetDisabledControlNormal(0, 220)
	local rightAxisY = GetDisabledControlNormal(0, 221)
	local rotation = GetCamRot(cam, 2)
	if rightAxisX ~= 0.0 or rightAxisY ~= 0.0 then
		new_z = rotation.z + rightAxisX*-1.0*(speed_ud)*(zoomvalue+0.1)
		new_x = math.max(math.min(20.0, rotation.x + rightAxisY*-1.0*(speed_lr)*(zoomvalue+0.1)), -89.5) -- Clamping at top (cant see top of heli) and at bottom (doesn't glitch out in -90deg)
		SetCamRot(cam, new_x, 0.0, new_z, 2)
	end
end

HandleZoom = function(cam)
	if IsControlJustPressed(0,241) then -- Scrollup
		fov = math.max(fov - zoomspeed, fov_min)
	end
	if IsControlJustPressed(0,242) then
		fov = math.min(fov + zoomspeed, fov_max) -- ScrollDown		
	end
	local current_fov = GetCamFov(cam)
	if math.abs(fov-current_fov) < 0.1 then -- the difference is too small, just set the value directly to avoid unneeded updates to FOV of order 10^-5
		fov = current_fov
	end
	SetCamFov(cam, current_fov + (fov - current_fov)*0.05) -- Smoothing of camera zoom
end

GetVehicleInView = function(cam)
	local coords = GetCamCoord(cam)
	local forward_vector = RotAnglesToVec(GetCamRot(cam, 2))
	--DrawLine(coords, coords+(forward_vector*100.0), 255,0,0,255) -- debug line to show LOS of cam
	local rayhandle = CastRayPointToPoint(coords, coords+(forward_vector*200.0), 10, GetVehiclePedIsIn(GetPlayerPed(-1)), 0)
	local _, _, _, _, entityHit = GetRaycastResult(rayhandle)
	if entityHit>0 and IsEntityAVehicle(entityHit) then
		return entityHit
	else
		return nil
	end
end

RenderVehicleInfo = function(vehicle)
	if DoesEntityExist(vehicle) then
		local model = GetEntityModel(vehicle)
		local vehname = GetLabelText(GetDisplayNameFromVehicleModel(model))
		local licenseplate = GetVehicleNumberPlateText(vehicle)
		if speed_measure == "MPH" then
			vehspeed = GetEntitySpeed(vehicle)*2.236936
		else
			vehspeed = GetEntitySpeed(vehicle)*3.6
		end
		SetTextFont(0)
		SetTextProportional(1)
		if vehicle_display == 0 then
			SetTextScale(0.0, 0.49)
		elseif vehicle_display == 1 then
			SetTextScale(0.0, 0.55)
		end
		SetTextColour(255, 255, 255, 255)
		SetTextDropshadow(0, 0, 0, 0, 255)
		SetTextEdge(1, 0, 0, 0, 255)
		SetTextDropShadow()
		SetTextOutline()
		SetTextEntry("STRING")
		if vehicle_display == 0 then
			AddTextComponentString("Speed: " .. math.ceil(vehspeed) .. " " .. speed_measure .. "\nModel: " .. vehname .. "\nPlate: " .. licenseplate)
		elseif vehicle_display == 1 then
			AddTextComponentString("Model: " .. vehname .. "\nPlate: " .. licenseplate)
		end
		DrawText(0.45, 0.9)
	end
end

RotAnglesToVec = function(rot) -- input vector3
	local z = math.rad(rot.z)
	local x = math.rad(rot.x)
	local num = math.abs(math.cos(x))
	return vector3(-math.sin(z)*num, math.cos(z)*num, math.sin(x))
end

-- Following two functions from IllidanS4's entity enuerator script:  https://gist.github.com/IllidanS4/9865ed17f60576425369fc1da70259b2
local entityEnumerator = {
  __gc = function(enum)
    if enum.destructor and enum.handle then
      enum.destructor(enum.handle)
    end
    enum.destructor = nil
    enum.handle = nil
  end
}

local EnumerateEntities = function(initFunc, moveFunc, disposeFunc)
    return coroutine.wrap(function()
        local iter, id = initFunc()
        if not id or id == 0 then
        disposeFunc(iter)
        return
        end
        
        local enum = {handle = iter, destructor = disposeFunc}
        setmetatable(enum, entityEnumerator)
        
        local next = true
        repeat
        coroutine.yield(id)
        next, id = moveFunc(iter)
        until not next
        
        enum.destructor, enum.handle = nil, nil
        disposeFunc(iter)
    end)
end

EnumerateVehicles = function()
  return EnumerateEntities(FindFirstVehicle, FindNextVehicle, EndFindVehicle)
end

FindVehicleByPlate = function(plate) -- Search existing vehicles enumerated above for target plate and return the matching vehicle
	for vehicle in EnumerateVehicles() do
		if GetVehicleNumberPlateText(vehicle) == plate then
			return vehicle
		end
	end
end