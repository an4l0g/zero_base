inMenu = false

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
            if (update) then TriggerEvent('zero:barberUpdate'); TriggerEvent('zero:tattooUpdate'); end;
        end
    end
end 
    
getCustomization = function()
    local ped = plyPed
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

SetCameraCoords = function(type, start)
    local ped = PlayerPedId()

    if (start) then RenderScriptCams(false, false, 0, 1, 0); DestroyCam(cam, false); end
    
    if (not DoesCamExist(cam)) then
        cam = CreateCam('DEFAULT_SCRIPTED_CAMERA', true)
        SetCamActive(cam, true)
        RenderScriptCams(true, true, 500, true, true)   
        pos = GetEntityCoords(ped)
        camPos = GetOffsetFromEntityInWorldCoords(ped, 0.0, 2.0, 0.0)
        camPos2 = GetOffsetFromEntityInWorldCoords(ped, 0.0, 0.8, 0.0)       
    end

    if (type == 'all') then                                        
        SetCamCoord(cam, camPos.x, camPos.y, camPos.z+0.75)
        PointCamAtCoord(cam, pos.x, pos.y, pos.z+0.15)
    elseif (type == 'head') then 
        SetCamCoord(cam, camPos2.x, camPos2.y, camPos2.z+0.7)
        PointCamAtCoord(cam, pos.x, pos.y, pos.z+0.7)
    elseif (type == 'torso') then 
        SetCamCoord(cam, camPos2.x, camPos2.y, camPos2.z+0.40)
        PointCamAtCoord(cam, pos.x, pos.y, pos.z+0.20)
    elseif (type == 'shoes') then 
        SetCamCoord(cam, camPos2.x, camPos2.y, camPos2.z-0.30)
        PointCamAtCoord(cam, pos.x, pos.y, pos.z-0.30)
    elseif (type == 'foot') then 
        SetCamCoord(cam, camPos2.x, camPos2.y, camPos2.z-0.70)
        PointCamAtCoord(cam, pos.x, pos.y, pos.z-0.70)
    end        
end

DeleteCam = function()
    SetCamActive(cam, false)
    RenderScriptCams(false, true, 0, true, true)
    cam = nil
end

setPlayersVisible = function(bool)
    local ped = PlayerPedId()
    FreezeEntityPosition(ped, not bool)
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

DrawText3D = function(x, y, z, text)
    local onScreen, _x, _y = World3dToScreen2d(x, y, z)
    local p = GetGameplayCamCoords()
    local distance = GetDistanceBetweenCoords(p.x, p.y, p.z, x, y, z, 1)
    local scale = (1 / distance) * 2
    local fov = (1 / GetGameplayCamFov()) * 100
    local scale = scale * fov
    if onScreen then
        SetTextScale(0.0 * scale, 0.35 * scale)
        SetTextFont(0)
        SetTextProportional(1)
        SetTextColour(255, 255, 255, 255)
        SetTextDropshadow(0, 0, 0, 0, 255)
        SetTextEdge(2, 0, 0, 0, 150)
        SetTextDropShadow()
        SetTextOutline()
        SetTextEntry('STRING')
        SetTextCentre(1)
        AddTextComponentString(text)
        DrawText(_x, _y)
    end
end

RegisterNUICallback('shopCam', function(data)
    SetCameraCoords(data['type'], false)
end)

RegisterNuiCallback('changeHeading', function(data)
    local ped = PlayerPedId()
    if (data['left']) then
        SetEntityHeading(ped, (GetEntityHeading(ped) - 10.0))
    elseif (data['right']) then
        SetEntityHeading(ped, (GetEntityHeading(ped) + 10.0))
    end
end)

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