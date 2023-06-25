local cli = {}
Tunnel.bindInterface('Nitro', cli)
local vSERVER = Tunnel.getInterface('Nitro')

local display = false

DecorRegister('ND_NITRO_STATUS', 2)
DecorRegister('ND_NITRO_NOS', 1)
DecorRegister('ND_NITRO_PURGE', 1)

local hasNitro = function(veh)
    if (not DecorExistOn(veh, 'ND_NITRO_STATUS')) then; return false; end;
    return DecorGetBool(veh, 'ND_NITRO_STATUS')
end

local setNitro = function(veh, status)
    DecorSetBool(veh, 'ND_NITRO_STATUS', status)
end

local getValuesNitro = function(veh)
    return DecorGetFloat(veh, 'ND_NITRO_NOS'), DecorGetFloat(veh, 'ND_NITRO_PURGE')
end

local install = false

cli.installNitro = function()
    install = true
    local installing = false
    Citizen.CreateThread(function()
        while (install) do
            local idle = 1500
            local ped = PlayerPedId()
            local pCoord = GetEntityCoords(ped)
            local pVehicle = GetClosestVehicle(pCoord, 3.001, 0, 71)
            if (pVehicle and not IsPedInAnyVehicle(ped)) then
                local engine = GetWorldPositionOfEntityBone(pVehicle, GetEntityBoneIndexByName(pVehicle, 'engine'))
                local distance = #(pCoord - engine)
                idle = 4
                if (distance <= 3.0) then
                    DrawMarker(0, engine.x, engine.y, engine.z+0.7, 0, 0, 0, 0, 0, 0, 0.3, 0.3, 0.3, 0, 153, 255, 155, 1, 0, 0, 1)
                    if (distance <= 1.5 and IsControlJustPressed(0, 38) and vSERVER.getNitro()) then
                        installing = true
                        zero._playAnim(false, {{ 'mini@repair', 'fixing_a_player' }}, true)
                        PlaySoundFromEntity(-1, 'Bar_Unlock_And_Raise', pVehicle, 'DLC_IND_ROLLERCOASTER_SOUNDS', 0, 0)
                        SetVehicleDoorOpen(pVehicle, 4, 0, 0)
                        SetEntityHeading(ped, (GetEntityHeading(pVehicle) - 180))
                        
                        TriggerEvent('cancelando', true)
                        FreezeEntityPosition(ped, true)
                        FreezeEntityPosition(pVehicle, true)
                        TriggerEvent('progressBar', 'Instalando o nitro...', 5000)
                        Citizen.SetTimeout(5000, function()
                            ClearPedTasks(ped)
                            PlaySoundFrontend(-1, 'Lowrider_Upgrade', 'Lowrider_Super_Mod_Garage_Sounds', 1)
                            TriggerEvent('cancelando', false)
                            FreezeEntityPosition(ped, false)
                            FreezeEntityPosition(pVehicle, false)
                            SetVehicleDoorShut(pVehicle, 4, 0)
                            setNitro(pVehicle, true)
                            DecorSetFloat(pVehicle, 'ND_NITRO_NOS', 100.0)
                            DecorSetFloat(pVehicle, 'ND_NITRO_PURGE', 0.0)

                            SendNUIMessage({ type = 'nosLevel', nos = 100 })
                            SendNUIMessage({ type = 'purgeLevel', purge = 0 })
                            install = false
                        end)
                    end      
                end
                if (IsControlJustPressed(0, 168) and not installing) then install = false; end;
            end
            Citizen.Wait(idle)
        end
    end)
end

local activated = false
local purging = false
local screen = false
local purge = {}

RegisterKeyMapping('+purge', 'Nitro - Purge', 'keyboard', 'LMENU')

RegisterCommand('+purge', function()
    if (not activated) then
        local ped = PlayerPedId()
        local veh = GetVehiclePedIsIn(ped)
        purging = true
        if (veh) then
            local seatPed = GetPedInVehicleSeat(veh, -1)
            if (seatPed == ped and hasNitro(veh)) then
                TriggerServerEvent('ND_Nitro:purge', true)
            end
        end
    end
end)

RegisterCommand('-purge', function()
    if (not activated) then
        local ped = PlayerPedId()
        local veh = GetVehiclePedIsIn(ped)
        purging = false
        if (veh) then
            local seatPed = GetPedInVehicleSeat(veh, -1)
            if (seatPed == ped and hasNitro(veh)) then
                TriggerServerEvent('ND_Nitro:purge', false)
            end
        end
    end
end)

RegisterKeyMapping('+nitro', 'Nitro - Boost', 'keyboard', 'RSHIFT')

RegisterCommand('+nitro', function()
    if (not IsControlPressed(0, 71)) then Citizen.Wait(10); end;
    if (not purging) then
        local ped = PlayerPedId()
        local veh = GetVehiclePedIsIn(ped)
         if (veh) then
            local seatPed = GetPedInVehicleSeat(veh, -1)
            if (seatPed == ped and hasNitro(veh)) then
                while (not HasNamedPtfxAssetLoaded('veh_xs_vehicle_mods')) do
                    RequestNamedPtfxAsset('veh_xs_vehicle_mods')
                    Citizen.Wait(10)
                end

                activated = true
                EnableVehicleExhaustPops(veh, false)
                SetVehicleBoostActive(veh, activated)
                TriggerServerEvent('ND_Nitro:flames', true)
            end
        end
    end
end)

RegisterCommand('-nitro', function()
    if (not purging) then
        local ped = PlayerPedId()
        local veh = GetVehiclePedIsIn(ped)
        if (veh) then
            local seatPed = GetPedInVehicleSeat(veh, -1)
            if (seatPed == ped and hasNitro(veh)) then
                activated = false
                TriggerServerEvent('ND_Nitro:flames', false)
                SetVehicleBoostActive(veh, activated)
                SetVehicleCheatPowerIncrease(veh, 1.0)

                screen = false
                StopGameplayCamShaking(true)
                SetTransitionTimecycleModifier('default', 0.35)
                Citizen.Wait(1000)
                EnableVehicleExhaustPops(veh, true)
            end
        end
    end
end)

AddEventHandler('gameEventTriggered', function(event, args)
    if (event == 'CEventNetworkPlayerEnteredVehicle') then
        local id = args[1]
        if (id == PlayerId()) then
            local ped = PlayerPedId()
            local veh = GetVehiclePedIsIn(ped)
            if (veh and GetPedInVehicleSeat(veh, -1) == ped) then
                if (not display and hasNitro(veh)) then
                    Citizen.Wait(500)
                    display = true

                    local nosLevel, purgeLevel = getValuesNitro(veh)
                    SendNUIMessage({ type = 'nosLevel', nos = nosLevel })
                    SendNUIMessage({ type = 'purgeLevel', purge = purgeLevel })
                    SendNUIMessage({ type = 'status', display = display })
                end
                nitroThread(ped)
            end
        end
    end
end)

local thread = false

nitroThread = function(ped)
    thread = true
    Citizen.CreateThread(function()
        local veh
        while (thread) do
            local idle = 1500
            local veh = GetVehiclePedIsIn(ped)
            if (IsPedInAnyVehicle(ped) and GetEntityHealth(ped) > 101) then
                if (veh and hasNitro(veh)) then
                    idle = 500
                    nosLevel, purgeLevel = getValuesNitro(veh)
                    if (nosLevel < 1) then
                        setNitro(veh, false)
                        
                        display = false
                        SendNUIMessage({ type = 'status', display = display })

                        activated = false
                        TriggerServerEvent('ND_Nitro:flames', false)
                        SetVehicleBoostActive(veh, activated)
                        SetVehicleCheatPowerIncrease(veh, 1.0)
                        screen = false
                        StopGameplayCamShaking(true)
                        SetTransitionTimecycleModifier('default', 0.35)
                        EnableVehicleExhaustPops(veh, true)
                    end

                    if (activated and nosLevel > 0) then
                        local lvl = nosLevel - 1.0
                        DecorSetFloat(veh, 'ND_NITRO_NOS', lvl)
                        SendNUIMessage({ type = 'nosLevel', nos = lvl })

                        if (purgeLevel < 100) then
                            local lvl = purgeLevel + 4.0
                            DecorSetFloat(veh, 'ND_NITRO_PURGE', lvl)
                            SendNUIMessage({ type = 'purgeLevel', purge = lvl })
                        end
                    end

                    if (purging and purgeLevel > 0) then
                        local lvl = purgeLevel - 15.0
                        DecorSetFloat(veh, 'ND_NITRO_PURGE', lvl)
                        SendNUIMessage({ type = 'purgeLevel', purge = lvl })
                    elseif (purging and purgeLevel < 0) then
                        local lvl = nosLevel - 5.0
                        DecorSetFloat(veh, 'ND_NITRO_NOS', lvl)
                        SendNUIMessage({ type = 'nosLevel', nos = lvl })
                    end

                    if (nosLevel > 0 and purgeLevel < 100) then
                        if (activated) then
                            local model = GetEntityModel(veh)
                            local maxSpeed = GetVehicleModelMaxSpeed(model)
                            local speed = GetEntitySpeed(veh)
                            local kmh = math.floor(speed * 3.6)
                            local multiplier =  (6.0 * maxSpeed / speed)
                            SetVehicleCheatPowerIncrease(veh, multiplier)

                            if screen and kmh < 96.0 then
                                screen = false
                                StopGameplayCamShaking(true)
                                SetTransitionTimecycleModifier('default', 0.35)
                            elseif not screen and kmh > 96.0 then
                                screen = true
                                SetTimecycleModifier('rply_motionblur')
                                ShakeGameplayCam('SKY_DIVING_SHAKE', 0.25)
                            end

                            EnableVehicleExhaustPops(veh, false)
                        end
                    elseif (activated) then
                        activated = false
                        TriggerServerEvent('ND_Nitro:flames', false)
                        SetVehicleBoostActive(veh, activated)
                        SetVehicleCheatPowerIncrease(veh, 1.0)
                        screen = false
                        StopGameplayCamShaking(true)
                        SetTransitionTimecycleModifier('default', 0.35)
                        EnableVehicleExhaustPops(veh, true)
                    end
                end
            else
                thread = false
            end
            Citizen.Wait(idle)
        end
        if (display) then
            display = false
            SendNUIMessage({ type = 'status', display = display })
        end
        if (activated) then
            activated = false
            TriggerServerEvent('ND_Nitro:flames', false, VehToNet(veh))
            SetVehicleBoostActive(veh, activated)
            SetVehicleCheatPowerIncrease(veh, 1.0)
        end
        if (screen) then
            screen = false
            StopGameplayCamShaking(true)
            SetTransitionTimecycleModifier('default', 0.35)
            Citizen.Wait(1000)
            EnableVehicleExhaustPops(veh, true)
        end
        if (purging) then
            purging = false
            TriggerServerEvent('ND_Nitro:purge', false, VehToNet(veh))
        end
        veh = nil
    end)
end

AddStateBagChangeHandler('flames', nil, function(bagName, key, value, reserved, replicated)
    if value == nil then return end
    Wait(50)

    local netId = tonumber(bagName:gsub('entity:', ''), 10)
    local entity = NetworkDoesNetworkIdExist(netId) and NetworkGetEntityFromNetworkId(netId)
    if not entity then return end

    while not HasNamedPtfxAssetLoaded('veh_xs_vehicle_mods') do
        RequestNamedPtfxAsset('veh_xs_vehicle_mods')
        Wait(10)
    end

    SetVehicleNitroEnabled(entity, value)
end)

AddStateBagChangeHandler('purge', nil, function(bagName, key, value, reserved, replicated)
    if value == nil then return end
    Wait(50)

    local netId = tonumber(bagName:gsub('entity:', ''), 10)
    local entity = NetworkDoesNetworkIdExist(netId) and NetworkGetEntityFromNetworkId(netId)
    if not entity then return end

    if value then
        local bone = GetEntityBoneIndexByName(entity, 'bonnet')
        local pos = GetWorldPositionOfEntityBone(entity, bone)
        local off = GetOffsetFromEntityGivenWorldCoords(entity, pos.x, pos.y, pos.z)
        if bone ~= -1 then
            UseParticleFxAssetNextCall('core')
            local leftPurge = StartParticleFxLoopedOnEntity('ent_sht_steam', entity, off.x - 0.5, off.y + 0.05, off.z, 40.0, -20.0, 0.0, 0.3, false, false, false)
            UseParticleFxAssetNextCall('core')
            local rightPurge = StartParticleFxLoopedOnEntity('ent_sht_steam', entity, off.x + 0.5, off.y + 0.05, off.z, 40.0, 20.0, 0.0, 0.3, false, false, false)
            purge[entity] = {left = leftPurge, right = rightPurge}
            return
        end
        local bone = GetEntityBoneIndexByName(entity, 'engine')
        local pos = GetWorldPositionOfEntityBone(entity, bone)
        local off = GetOffsetFromEntityGivenWorldCoords(entity, pos.x, pos.y, pos.z)
        UseParticleFxAssetNextCall('core')
        local leftPurge = StartParticleFxLoopedOnEntity('ent_sht_steam', entity, off.x - 0.5, off.y - 0.2, off.z + 0.2, 40.0, -20.0, 0.0, 0.3, false, false, false)
        UseParticleFxAssetNextCall('core')
        local rightPurge = StartParticleFxLoopedOnEntity('ent_sht_steam', entity, off.x + 0.5, off.y - 0.2, off.z + 0.2, 40.0, 20.0, 0.0, 0.3, false, false, false)
        purge[entity] = {left = leftPurge, right = rightPurge}
    else
        if (purge[entity]) then
            StopParticleFxLooped(purge[entity].left)
            StopParticleFxLooped(purge[entity].right)
        end
        purge[entity] = nil
    end
end)