Tunnel = module('zero','lib/Tunnel')

cli = {}
Tunnel.bindInterface(GetCurrentResourceName(), cli)
srv = Tunnel.getInterface(GetCurrentResourceName())

hud = true

local toggleSeatbelt = function()
    if inVehicle and vehicleHudOn and hasSeatbelt then
        seatbeltOn = not seatbeltOn
        updateSeatbelt(seatbeltOn)
        if not (LocalPlayer.state.GPS) then checkRadar(seatbeltOn) end
        SetPedConfigFlag(ped, 32, not seatbeltOn)
        if seatbeltOn then TriggerEvent('zero_sound:source','belt',0.5) else TriggerEvent('zero_sound:source','unbelt',0.5) end
    end
end
RegisterCommand('zero_hud:seatBelt', toggleSeatbelt)
RegisterKeyMapping('zero_hud:seatBelt', '', 'keyboard', 'G')

local toggleHud = function()
    hud = not hud
    TriggerEvent('zero_hud:toggleHud', hud)
end

RegisterCommand('hud', toggleHud)

checkRadar = function(bool)
    local vehicle = GetVehiclePedIsIn(ped, false)
    local hasSeatbelt = doesVehicleHasSeatbelt(vehicle)
    if bool and (seatbeltOn or not hasSeatbelt) and IsPedInAnyVehicle(ped,false) then
        DisplayRadar(true)
    else
        DisplayRadar(false)
    end
    return
    DisplayRadar(bool)
end

local checkComponents = function()
    while (true) do
        local idle = 1000
        if inVehicle and hasSeatbelt then
            if seatbeltOn then
                idle = 1
                DisableControlAction(1,75,true)
            end
        end
        Citizen.Wait(idle)
	end
end

local startUpdateVehicleSpeed = function()
    local ped = PlayerPedId()
    local veh = GetVehiclePedIsIn(ped, false)
    local currentSpeed = getSpeed(veh)
    updateVehicleSpeed(currentSpeed)
    while vehicleHudOn and inVehicle do
        local speed = getSpeed(veh)
        if currentSpeed ~= speed then
            currentSpeed = speed
            updateVehicleSpeed(currentSpeed)
        end
        Wait(250)
    end
end

doesVehicleHasSeatbelt = function(veh)
    local vehClass = GetVehicleClass(veh or vehicle)
    return (vehClass >= 0 and vehClass <= 7) or (vehClass >= 9 and vehClass <= 12) or (vehClass >= 17 and vehClass <= 20)
end

startVehicle = function()
    local ped = PlayerPedId()
    local vehicle = GetVehiclePedIsIn(ped, false)
    beltSpeed = 0
    updateSeatbelt(seatbeltOn)
    if not DoesEntityExist(vehicle) then return end
    CreateThread(startUpdateVehicleSpeed) 
    hasSeatbelt = doesVehicleHasSeatbelt(vehicle)
    SetFlyThroughWindscreenParams(25.0, 2.0, 15.0, 15.0)
    SetPedConfigFlag(ped, 32, hasSeatbelt)
end

statusVehicle = function(bool,veh)
    seatbeltOn = false
    if bool then
        vehicleHudOn = true
        startVehicle()
        TriggerEvent('zero_hud:updateVehicleHud', true)
        if not (LocalPlayer.state.GPS) then checkRadar( not doesVehicleHasSeatbelt(veh) ) end
    else
        inVehicle = false
        vehicleHudOn = false
        if not (LocalPlayer.state.GPS) then checkRadar(false) end
        TriggerEvent('zero_hud:updateVehicleHud', false)
    end
end

local checkPlayerLevels = function()
    Wait(1000)
    local veh = GetVehiclePedIsIn(ped, false)
    local ped = PlayerPedId()
    local currentHealth = getHealth(ped)
    local currentArmour = getArmour(ped)
    local currentOxygen = getOxygen(ped) 
    local currentLocked = GetVehicleDoorLockStatus(veh)
    local currentFuel = 0.0
    local currentEngineHealth = 0.0
    local currentGear = 0
    local currentTime = getTime()
    vehicleHudOn = false

    updateHealth(currentHealth)
    updateArmour(currentArmour) 
    updateTime(currentTime)
    if not (LocalPlayer.state.GPS) then checkRadar(false) end

    while true do
        ped = PlayerPedId()
        veh = GetVehiclePedIsIn(ped, false)

        local health = getHealth(ped)
        local armour = getArmour(ped)
        local oxygen = getOxygen(ped) 
        local time = getTime()
        local locked = GetVehicleDoorLockStatus(veh)

        if currentHealth ~= health then currentHealth = health; updateHealth(currentHealth); end
        if currentArmour ~= armour then currentArmour = armour; updateArmour(currentArmour); end
        if currentOxygen ~= oxygen then currentOxygen = oxygen; updateOxygen(currentOxygen); end
        if currentTime ~= time then currentTime = time; updateTime(currentTime); end
        if currentLocked ~= locked then currentLocked = locked; updateLocked(currentLocked == 2); end

        inVehicle = IsPedInAnyVehicle(ped,false)

        if inVehicle and not vehicleHudOn then statusVehicle(true,veh)
        elseif (not inVehicle and vehicleHudOn) or (inVehicle and GetVehiclePedIsIn(ped) ~= GetVehiclePedIsIn(ped)) then statusVehicle(false,veh) end

        if vehicleHudOn then
            if veh and DoesEntityExist(veh) then
                local fuel = getFuel(veh)
                local engineHealth = getEngineHealth(veh)
                local gear = GetVehicleCurrentGear(veh)
                if currentFuel ~= fuel then currentFuel = fuel updateFuel(currentFuel)  end
                if currentEngineHealth ~= engineHealth then currentEngineHealth = engineHealth updateEngineFuel(currentEngineHealth) end
                if currentGear ~= gear then currentGear = gear updateCurrentGear(currentGear) end
            end
        end
        
        -- DESAPARECER A HUD NO MENU ( PAUSE ) | ( ESC )
        if IsPauseMenuActive() then
			if not isPauseMenu then isPauseMenu = not isPauseMenu TriggerEvent('zero_hud:toggleHud', false)  end
		else
			if isPauseMenu then isPauseMenu = not isPauseMenu TriggerEvent('zero_hud:toggleHud', true) end
		end
        Wait(500)
    end
end

local needs = { hunger = 0, thirst = 0 }

Citizen.CreateThread(function()
    while (true) do
        Citizen.Wait(10000)
        if needs.hunger >= 85 then
            SetTimecycleModifier('spectator5')
			ShakeGameplayCam('FAMILY5_DRUG_TRIP_SHAKE',1.0)
            TriggerEvent('Notify', 'importante', 'Você precisa <b>comer</b> urgentemente.')
        elseif needs.thirst >= 80 then
            SetTimecycleModifier('spectator5')
			ShakeGameplayCam('FAMILY5_DRUG_TRIP_SHAKE',1.0)
            TriggerEvent('Notify', 'importante', 'Você precisa <b>beber</b> urgentemente.')
        elseif needs.hunger < 85 then
            if (LocalPlayer.state.FPS) then
                SetTimecycleModifier('cinema')
            else
                SetTimecycleModifier('default')
            end
            StopGameplayCamShaking()
        elseif needs.thirst < 80 then
            if (LocalPlayer.state.FPS) then
                SetTimecycleModifier('cinema')
            else
                SetTimecycleModifier('default')
            end
            StopGameplayCamShaking()
        end
    end
end)

CreateThread(checkPlayerLevels)
CreateThread(checkComponents)

RegisterNetEvent('vrp_hud:updateBasics',function(hunger, thirst)
    if needs.hunger ~= hunger then needs.hunger = hunger; updateHunger(needs.hunger) end
    if needs.thirst ~= thirst then needs.thirst = thirst; updateThirst(needs.thirst) end  
end)

RegisterNetEvent('pma-voice:setTalkingMode',function(mode)
    SendNUIMessage({ method = 'updateVoice', data = mode })
end)

RegisterNetEvent('pma-listners:setFrequency',function(radio)
    SendNUIMessage({ method = 'updateRadioChannel', data = radio })
end)

RegisterNetEvent('zero_hud:updateVehicleHud',function(bool)
    SendNUIMessage({ method = 'updateHudVehicle', data = bool })
end)

RegisterNetEvent('zero_hud:toggleHud',function(bool)
    SendNUIMessage({ method = 'updateHud', data = bool })
end)

RegisterNetEvent('zero_system:gps', function()
    LocalPlayer.state.GPS = true
    DisplayRadar(true)
end)

RegisterNuiCallback('close', function()
    SetNuiFocus(false, false)
end)