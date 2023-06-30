inMenu = false
oldCustom = {}

parsePart = function(key)
    if (type(key) == 'string' and string.sub(key, 1, 1) == 'p') then
        return true, tonumber(string.sub(key, 2))
    else
        return false, tonumber(key)
    end
end

setCustomization = function(custom, update)
    local ped = PlayerPedId()
    for index, value in pairs(custom) do
        if (index ~= 'model' and index ~= 'modelhash') then
            local isProp, index = parsePart(index)
            if (isProp) then
                if (value[1] < 0) then
                    ClearPedProp(ped, index)
                else
                    SetPedPropIndex(ped, index, value[1], value[2], (value[3] or 1))
                end
            else
                SetPedComponentVariation(ped, index, value[1], value[2], (value[3] or 1))
            end
            -- if (update) then TriggerEvent('zero:barberUpdate'); end;
            if (update) then TriggerEvent('zero:barberUpdate'); TriggerEvent('zero:tattooUpdate'); end;
        end
    end
end 
    
getCustomization = function()
    local ped = PlayerPedId()
    local custom = {}
    custom.modelhash = GetEntityModel(ped)

    for i = 0, 20 do
        custom[i] = { GetPedDrawableVariation(ped, i), GetPedTextureVariation(ped, i), GetPedPaletteVariation(ped, i) }
    end

    for i = 0, 10 do
        custom['p'..i] = { GetPedPropIndex(ped, i), math.max(GetPedPropTextureIndex(ped, i), 0) }
    end
    return custom
end

setClothes = function(clothes)
    local ped = PlayerPedId()
    local model = GetEntityModel(ped)
    local idleCopy = {}
    for l, w in pairs(clothes[model]) do
        idleCopy[l] = w
    end
    setCustomization(idleCopy)
end

atualCam = ''
tempCam = nil

local cameras = {
    ['body'] = {
        ['coords'] = function()
            local ped = PlayerPedId()
            local pCoord = GetEntityCoords(ped)
            return vector3(pCoord.x-0.7, pCoord.y+0.8, pCoord.z+0.5)
        end,
        ['heading'] = function()
            local ped = PlayerPedId()
            SetEntityHeading(ped, (GetEntityHeading(ped) - 10.0))
        end,
        ['anim'] = function()
            freezeAnim('mp_sleep', 'bind_pose_180', 1, true)
        end
    },
    ['head'] = {
        ['coords'] = function()
            local ped = PlayerPedId()
            local pCoord = GetEntityCoords(ped)
            return vector3(pCoord.x-0.5, pCoord.y+0.75, pCoord.z+0.7)
        end,
        ['heading'] = function()
            local ped = PlayerPedId()
            SetEntityHeading(ped, (GetEntityHeading(ped) - 10.0))
        end,
        ['anim'] = function()
            freezeAnim('mp_sleep', 'bind_pose_180', 1, true)
        end
    },
}

createCam = function(cameraName)
    atualCam = cameraName
    ClearFocus()

    local ped = PlayerPedId()
    local cam = cameras[cameraName]
    local x, y, z = cameras[cameraName].coords().x, cameras[cameraName].coords().y, cameras[cameraName].coords().z
    tempCam = CreateCamWithParams('DEFAULT_SCRIPTED_CAMERA', vector3(x, y, z), vector3(0, 0, 230), GetGameplayCamFov())
    SetCamActive(tempCam, true)
    RenderScriptCams(true, true, 1000, true, false)

    if (cam['anim']) then cam['anim']() end
    if (cam['heading']) then cam['heading']() end
end

deleteCam = function(render)
    SetCamActive(tempCam, false)
    if (render) then RenderScriptCams(false, true, 0, true, true); end;
	tempCam = nil
end

setPlayersVisible = function(bool)
    local ped = PlayerPedId()
    -- FreezeEntityPosition(ped, not bool)
    if (bool) then
        for _, player in ipairs(GetActivePlayers()) do
            local otherPlayer = GetPlayerPed(player)
            if (ped ~= otherPlayer) then
                SetEntityVisible(otherPlayer, bool)
            end
        end
    else
        CreateThread(function()
            while (inMenu) do
                for _, player in ipairs(GetActivePlayers()) do
                    local otherPlayer = GetPlayerPed(player)
                    if (ped ~= otherPlayer) then
                        SetEntityVisible(otherPlayer, bool)
                    end
                end
                InvalidateIdleCam()
                Citizen.Wait(1)
            end
        end)
    end
end

addBlips = function(config)
    for _, v in pairs(config) do
        if (v.blip) then
            local coords = v.coord
            if (coords) then
                local blip = AddBlipForCoord(coords.xyz)
                SetBlipSprite(blip, v.blip.id)
                SetBlipColour(blip, v.blip.color)
                SetBlipScale(blip, v.blip.scale)
                SetBlipAsShortRange(blip, true)
                BeginTextCommandSetBlipName('STRING')
                AddTextComponentString(v.blip.name)
                EndTextCommandSetBlipName(blip)
            end
        end
    end
end

RegisterNuiCallback('close', function()
    closeNui()
    setPedCustom()
end)

RegisterNuiCallback('changeCam', function(data)
    if (inMenu) then
        local newPov = data.type
        local newHeading = (data.rotation + 0.00)
        SetEntityHeading(PlayerPedId(), newHeading)
        if (atualCam ~= newPov) then deleteCam(); createCam(newPov); end;
    end
end)

closeNui = function()
    setPlayersVisible(false)
    SetNuiFocus(false, false)
    deleteCam(true)
    inMenu = false
    local ped = PlayerPedId()
    FreezeEntityPosition(ped, false)
    ClearPedTasks(ped)
    if (oldCustom) then setCustomization(oldCustom); end;
end

LoadAnim = function(dict)
    while (not HasAnimDictLoaded(dict)) do
        RequestAnimDict(dict)
        Citizen.Wait(10)
    end
end

freezeAnim = function(dict, anim, flag, keep)
    local ped = PlayerPedId()
    if (not keep) then ClearPedTasks(ped) end
    LoadAnim(dict)
    TaskPlayAnim(ped, dict, anim, 2.0, 2.0, -1, flag or 1, 0, false, false, false)
    RemoveAnimDict(dict)
end