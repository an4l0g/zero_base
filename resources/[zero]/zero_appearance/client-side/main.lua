inMenu = false
oldCustom = {}

countTable = function(tab)
    local c = 0
    for _,_ in pairs(tab) do c = c + 1 end
    return c
end

createMarkers = function(coords)
    DrawMarker(27, coords.x, coords.y, coords.z, 0, 0, 0, 0, 0, 0, 1.0, 1.0, 1.0, 0, 153, 255, 155, 0, 0, 0, 1)
end

setClothes = function(clothes)
    local ped = PlayerPedId()
    local model = GetEntityModel(ped)
    local idleCopy = {}
    for l, w in pairs(clothes[model]) do
        idleCopy[l] = w
    end
    zero.setCustomization(idleCopy)
end

local povCam = {
    ['body'] = function()
       Cam({ x = 0, y = 1.5, z = 0.65 }, { x = 0.0, y = 0.0, z = -0.5 })
    end,
    ['head'] = function()
        Cam({ x = 0, y = 0.5, z = 0.65 }, { x = 0.0, y = 0.0, z = 0.0 })
    end
}

atualCam = ''
createCam = function(pov)
    atualCam = pov
    povCam[pov]()
end

tempCam = nil
Cam = function(offset, bone)
    if (not DoesCamExist(tempCam)) then
        local ped = PlayerPedId()
        local coordsCam = GetOffsetFromEntityInWorldCoords(ped, offset.x, offset.y, offset.z)
        
        tempCam = CreateCam('DEFAULT_SCRIPTED_CAMERA')
        SetCamCoord(tempCam, coordsCam)
        PointCamAtPedBone(tempCam, ped, 31086, bone.x, bone.y, bone.z, false)

        SetCamActive(tempCam, true)
        RenderScriptCams(true, true, 500, true, true)
    end
end

DeleteCam = function(render)
    SetCamActive(tempCam, false)
    if (render) then 
        RenderScriptCams(false, true, 0, true, true)
    end
	tempCam = nil
end

setPlayersVisible = function(bool)
    local ped = PlayerPedId()
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

addBlips = function(locs, general)
    for _, v in pairs(locs) do
        if (v.blip) then
            local coords = v.coord
            local blipConfig = general[v.config].blip
            if (coords) then
                local blip = AddBlipForCoord(coords.xyz)
                SetBlipSprite(blip, blipConfig.id)
                SetBlipColour(blip, blipConfig.color)
                SetBlipScale(blip, blipConfig.scale)
                SetBlipAsShortRange(blip, true)
                BeginTextCommandSetBlipName('STRING')
                AddTextComponentString(blipConfig.name)
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
        if (atualCam ~= newPov) then 
            DeleteCam()
            createCam(newPov)
        end
    end
end)

closeNui = function()
    setPlayersVisible(true)
    SetNuiFocus(false, false)
    DeleteCam(true)
    inMenu = false
    local ped = PlayerPedId()
    FreezeEntityPosition(ped, false)
    ClearPedTasks(ped)
    if (oldCustom) then zero.setCustomization(oldCustom); end;
end