local config = module('zero_core', 'cfg/cfgAnimations')
local configAnimations = config.animations

for index, value in pairs(configAnimations.keyMapping) do
    RegisterKeyMapping('+'..index, value.text, 'keyboard', value.key)
    RegisterCommand('+'..index, function() if (not LocalPlayer.state.BlockTasks and not LocalPlayer.state.Cam and not LocalPlayer.state.Handcuff and not IsPedReloading(PlayerPedId()) and not IsPedFalling(PlayerPedId())) then value.action() end; end)
end

RegisterNetEvent('zero_animations:setAnim', function(anim)
    if (LocalPlayer.state.BlockTasks and LocalPlayer.state.Handcuff and IsPedFalling(PlayerPedId())) then return; end;
    local ped = PlayerPedId()
    local emote = configAnimations.animations[anim]
    zero.DeletarObjeto()
    if (not IsPedInAnyVehicle(ped) and not emote.carros) then       
        if (emote.extra) then emote.extra(); end;
        if emote.pos then
            local emoteDict = emote.dict or nil
            local emoteAnim = emote.anim or nil
            if (emoteDict) then zero._playAnim(emote.andar, {{ emote.dict, emote.anim }}, emote.loop); end;
            if (type(emote.prop) == 'table') then
                zero.CarregarObjeto('', '', emote.prop[1], emote.flag, emote.hand[1], emote.pos[1], emote.pos[2], emote.pos[3], emote.pos[4], emote.pos[5], emote.pos[6])
                zero.CarregarObjeto('', '', emote.prop[2], emote.flag, emote.hand[2], emote.pos2[1], emote.pos[2], emote.pos2[3], emote.pos2[4], emote.pos2[5], emote.pos2[6])
            else
                zero.CarregarObjeto('', '', emote.prop, emote.flag, emote.hand, emote.pos[1], emote.pos[2], emote.pos[3], emote.pos[4], emote.pos[5], emote.pos[6])
            end
        elseif (emote.prop) then
            zero.CarregarObjeto(emote.dict, emote.anim, emote.prop, emote.flag, emote.hand)
        elseif (emote.dict) then
            zero._playAnim(emote.andar, {{emote.dict,emote.anim}}, emote.loop)
        else
            zero._playAnim(false, { task = emote.anim }, false)
        end
    else
        if (IsPedInAnyVehicle(ped) and emote.carros) then
            local vehicle = GetVehiclePedIsIn(ped,false)
            if (GetPedInVehicleSeat(vehicle,-1) == ped or GetPedInVehicleSeat(vehicle,1) == ped) and (anim == 'sexo4') then
                zero._playAnim(emote.andar, {{emote.dict,emote.anim}}, emote.loop)
            elseif (GetPedInVehicleSeat(vehicle, 0) == ped or GetPedInVehicleSeat(vehicle,2) == ped) and (anim == 'sexo5' or anim == 'sexo6') then
                zero._playAnim(emote.andar, {{emote.dict,emote.anim}}, emote.loop)
            end
        end
    end
end)

local sharedAnimation

RegisterNetEvent('zero_animations:cancelSharedAnimation', function()
    local ped = PlayerPedId()
    ClearPedTasks(ped); DetachEntity(ped, true, false);
    if (sharedAnimation) then
        TriggerServerEvent('zero_animation:sharedServer', sharedAnimation)
        sharedAnimation = nil
    end
end)

RegisterNetEvent('zero_animation:sharedClearAnimation', function()
    local ped = PlayerPedId()
    zero.DeletarObjeto()
    ClearPedTasks(ped); DetachEntity(ped, true, false);
end)

RegisterNetEvent('zero_animations:setAnimShared', function(anim, target)
    if (LocalPlayer.state.BlockTasks and LocalPlayer.state.Handcuff and IsPedFalling(PlayerPedId())) then return; end;
    sharedAnimation = target
    local ped = PlayerPedId()
    local emote = configAnimations.shared[anim]

    zero.DeletarObjeto()
    local syncOption = emote.syncOption
    local pedTarget = GetPlayerPed(GetPlayerFromServerId(target))
    if (syncOption) then
        if (syncOption.attachTo) then
            AttachEntityToEntity(ped, pedTarget, GetPedBoneIndex(pedTarget, syncOption.bone),
            syncOption.xPos, syncOption.yPos, syncOption.zPos, syncOption.xRot, syncOption.yRot, syncOption.zRot, true, true, false, false, 2, true)
        end
    end

    if (emote.extra) then emote.extra() end
    if (emote.pos) then
        local emoteDict = emote.dict or nil
        local emoteAnim = emote.anim or nil
        if (emoteDict) then zero._playAnim(emote.andar, {{ emote.dict, emote.anim }}, emote.loop); end;
        if (type(emote.prop) == 'table') then
            zero.CarregarObjeto('', '', emote.prop[1], emote.flag, emote.hand[1], emote.pos[1], emote.pos[2], emote.pos[3], emote.pos[4], emote.pos[5], emote.pos[6])
            zero.CarregarObjeto('', '', emote.prop[2], emote.flag, emote.hand[2], emote.pos2[1], emote.pos[2], emote.pos2[3], emote.pos2[4], emote.pos2[5], emote.pos2[6])
        else
            zero.CarregarObjeto('', '', emote.prop, emote.flag, emote.hand, emote.pos[1], emote.pos[2], emote.pos[3], emote.pos[4], emote.pos[5], emote.pos[6])
        end
    elseif emote.prop then
        zero.CarregarObjeto(emote.dict, emote.anim, emote.prop, emote.flag, emote.hand)
    elseif emote.dict then
        zero._playAnim(emote.andar, {{ emote.dict, emote.anim }}, emote.loop)
    else
        zero._playAnim(false, { task = emote.anim }, false)
    end
end)

RegisterNetEvent('zero_animations:setAnimShared2', function(anim, target)   
    if (LocalPlayer.state.BlockTasks and LocalPlayer.state.Handcuff and IsPedFalling(PlayerPedId())) then return; end;
    sharedAnimation = target
    local ped = PlayerPedId()
    local emote = configAnimations.shared[anim]

    zero.DeletarObjeto()
    local syncOption = emote.syncOption
    local pedTarget = GetPlayerPed(GetPlayerFromServerId(target))
    if (syncOption) then
        if (syncOption.attachTo) then
            AttachEntityToEntity(ped, pedTarget, GetPedBoneIndex(pedTarget, syncOption.bone),
            syncOption.xPos, syncOption.yPos, syncOption.zPos, syncOption.xRot, syncOption.yRot, syncOption.zRot, true, true, false, false, 2, true)
        end
    end

    if (emote.extra) then emote.extra() end
    if (emote.pos) then
        local emoteDict = emote.dict or nil
        local emoteAnim = emote.anim or nil
        if (emoteDict) then zero._playAnim(emote.andar, {{ emote.dict, emote.anim }}, emote.loop) end;
        zero.CarregarObjeto('', '', emote.prop, emote.flag, emote.hand, emote.pos[1], emote.pos[2],emote.pos[3], emote.pos[4], emote.pos[5], emote.pos[6])
    elseif (emote.prop) then
        zero.CarregarObjeto(emote.dict, emote.anim, emote.prop, emote.flag, emote.hand)
    elseif (emote.dict) then
        zero._playAnim(emote.andar, {{ emote.dict, emote.anim }}, emote.loop)
    else
        zero._playAnim(false, { task = emote.anim }, false)
    end
end)

local apontarStart = false

apontarThread = function(state) 
    apontarStart = state
    Citizen.CreateThread(function()
        while (apontarStart) do
            local ped = PlayerPedId()
            local camPitch = GetGameplayCamRelativePitch()
            if camPitch < -70.0 then
                camPitch = -70.0
            elseif camPitch > 42.0 then
                camPitch = 42.0
            end
            camPitch = (camPitch + 70.0) / 112.0

            local camHeading = GetGameplayCamRelativeHeading()
            local cosCamHeading = Cos(camHeading)
            local sinCamHeading = Sin(camHeading)
            if camHeading < -180.0 then
                camHeading = -180.0
            elseif camHeading > 180.0 then
                camHeading = 180.0
            end
            camHeading = (camHeading + 180.0) / 360.0

            local blocked = 0
            local nn = 0
            local coords = GetOffsetFromEntityInWorldCoords(ped,(cosCamHeading*-0.2)-(sinCamHeading*(0.4*camHeading+0.3)),(sinCamHeading*-0.2)+(cosCamHeading*(0.4*camHeading+0.3)),0.6)
            local ray = Cast_3dRayPointToPoint(coords.x,coords.y,coords.z-0.2,coords.x,coords.y,coords.z+0.2,0.4,95,ped,7);
            nn,blocked,coords,coords = GetRaycastResult(ray)

            Citizen.InvokeNative(0xD5BB4025AE449A4E,ped,'Pitch',camPitch)
            Citizen.InvokeNative(0xD5BB4025AE449A4E,ped,'Heading',camHeading*-1.0+1.0)
            Citizen.InvokeNative(0xB0A6CFD2C69C1088,ped,'isBlocked',blocked)
            Citizen.InvokeNative(0xB0A6CFD2C69C1088,ped,'isFirstPerson',Citizen.InvokeNative(0xEE778F8C7E1142E2,Citizen.InvokeNative(0x19CAFA3C87F7C2FF))==4)
            Citizen.Wait(1)
        end
    end)
end

local animations = {}
generateAnimations = function()
    local sharedList = {}
    for index, value in pairs(configAnimations.shared) do
        sharedList = {
            type = 'action',
            value = { 'shared', index }
        }
        table.insert(animations, sharedList)
    end

    local animList = {}
    for index, value in pairs(configAnimations.animations) do
        animList = {
            type = 'action',
            value = { 'animations', index }
        }
        table.insert(animations, animList)
    end

end

getAllAnimations = function()
    return animations
end
exports('getAllAnimations', getAllAnimations)

CreateThread(generateAnimations)

local disabled = false
disableActions = function(bool)
    Citizen.CreateThread(function()
        disabled = bool
        while (disabled) do
            BlockWeaponWheelThisFrame()
            DisableControlAction(0, 21, true)
            DisableControlAction(0, 37, true)
            DisableControlAction(0, 25, true)
            DisableControlAction(0, 24, true)
            DisableControlAction(0, 29, true)
            DisableControlAction(0, 47, true)
            DisableControlAction(0, 56, true)
            DisableControlAction(0, 57, true)
            DisableControlAction(0, 73, true)
            DisableControlAction(0, 137, true)
            DisableControlAction(0, 166, true)
            DisableControlAction(0, 167, true)
            DisableControlAction(0, 169, true)
            DisableControlAction(0, 170, true)
            DisableControlAction(0, 182, true)
            DisableControlAction(0, 187, true)
            DisableControlAction(0, 188, true)
            DisableControlAction(0, 189, true)
            DisableControlAction(0, 190, true)
            DisableControlAction(0, 243, true)
            DisableControlAction(0, 245, true)
            DisableControlAction(0, 257, true)
            DisableControlAction(0, 288, true)
            DisableControlAction(0, 289, true)
            DisableControlAction(0, 311, true)
            DisableControlAction(0, 344, true)		
            DisablePlayerFiring(PlayerPedId(), true)
            Citizen.Wait(5)
        end
    end)
end