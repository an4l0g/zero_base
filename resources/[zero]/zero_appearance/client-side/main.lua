tempOpen = nil
inMenu = false
oldCustom = {}

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
exports('setClothes', setClothes)

local setCustomization = function(custom, mode)
    local ped = PlayerPedId()
    for k, v in pairs(custom) do
        if (k ~= 'pedModel') then
            local isProp, index = exports.zero:parsePart(k)
            if (isProp) then
                SetPedPropIndex(ped, index, v.model, v.var, (v.palette or 0))
            else
                SetPedComponentVariation(ped, parseInt(k), v.model, v.var, (v.palette or 0))
            end
        end
    end

    if (mode == 'barbershop' or mode == 'tattooshop') then
        TriggerEvent('zero:barberUpdate')
        TriggerEvent('zero:tattooUpdate')
    end
end 

local povCam = {
    ['body'] = function()
       Cam({ x = 0, y = 1.5, z = 0.65 }, { x = 0.2, y = 0.0, z = -0.5 })
    end,
    ['head'] = function()
        Cam({ x = 0, y = 0.5, z = 0.65 }, { x = 0.2, y = 0.0, z = 0.0 })
    end
}

atualCam = ''
createCam = function(pov)
    atualCam = pov
    povCam[pov]()
end

tempCam = nil
Cam = function(offset, bone)
    local ped = PlayerPedId()
    if (not DoesCamExist(tempCam)) then
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

addBlips = function(locs)
    for _, v in pairs(locs) do
        if (v.blip) then
            local coords = v.coord
            local blipConfig = config.general[v.type][v.config].blip
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
    LocalPlayer.state.Appearance = false
    if (tempOpen == 'barbershop') then setPedCustom(); end;
    closeNui()
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
    TriggerEvent('zero_hud:toggleHud', true)
    setPlayersVisible(true)
    SetNuiFocus(false, false)
    DeleteCam(true)
    inMenu = false
    local ped = PlayerPedId()
    FreezeEntityPosition(ped, false)
    ClearPedTasks(ped)
    if (oldCustom) then setCustomization(oldCustom, tempOpen); end;
    tempOpen  = nil
end

local locsConfig = config.locs

local openAppearance = {
    ['barbershop'] = function(index)
        tempOpen = 'barbershop'
        openBarberShop(index) 
    end,
    ['skinshop'] = function(index)
        tempOpen = 'skinshop'
        openSkinShop(index)
    end,
    ['tattooshop'] = function(index)
        tempOpen = 'tattooshop'
        openTattooShop(index)
    end
}

local nearestBlips = {}

local _markerThread = false
local markerThread = function()
    if (_markerThread) then return; end;
    _markerThread = true
    Citizen.CreateThread(function()
        while (countTable(nearestBlips) > 0) do
            local ped = PlayerPedId()
            local _cache = nearestBlips
            for index, dist in pairs(_cache) do
                if (dist <= 5) then
                    local config = locsConfig[index]
                    createMarkers(config.coord)
                    if (dist <= 1.2 and IsControlJustPressed(0, 38) and GetEntityHealth(ped) > 100 and not IsPedInAnyVehicle(ped)) then
                        LocalPlayer.state.Appearance = true
                        openAppearance[config.type](index)
                    end
                end
            end
            Citizen.Wait(1)
        end
        _markerThread = false
    end)
end

Citizen.CreateThread(function()
    addBlips(locsConfig)
    while (true) do
        local ped = PlayerPedId()
        local pCoord = GetEntityCoords(ped)
        nearestBlips = {}
        for k, v in ipairs(locsConfig) do
            local distance = #(pCoord - v.coord.xyz)
            if (distance <= 5) then
                nearestBlips[k] = distance
            end
        end
        if (countTable(nearestBlips) > 0) then markerThread(); end;
        Citizen.Wait(500)
    end
end)