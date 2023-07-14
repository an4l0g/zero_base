local vSERVER = Tunnel.getInterface('skinShop')
local config = module('zero_appearance', 'cfg/cfgSkin')

local locsConfig = config.locs
local generalConfig =  config.general

local getDrawables = function()
    local ped = PlayerPedId()
    local pedDrawables = {
        { torso = GetNumberOfPedDrawableVariations(ped, 3), '3' },
        { legs = GetNumberOfPedDrawableVariations(ped, 4), '4' },
        { hands = GetNumberOfPedDrawableVariations(ped, 5), '5' },
        { fool = GetNumberOfPedDrawableVariations(ped, 6), '6' },
        { accessories = GetNumberOfPedDrawableVariations(ped, 8), '8' },
        { acessories2 = GetNumberOfPedDrawableVariations(ped, 9), '9' },
        { decals = GetNumberOfPedDrawableVariations(ped, 10), '10' },
        { torso2 = GetNumberOfPedDrawableVariations(ped, 11), '11' },
        { helmet = GetNumberOfPedPropDrawableVariations(ped, 0), 'p0' },
        { glasses = GetNumberOfPedPropDrawableVariations(ped, 1), 'p1' },
        { ear = GetNumberOfPedPropDrawableVariations(ped, 2), 'p2' }
    }
    return pedDrawables
end

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
                    local coord = locsConfig[index].coord
                    createMarkers(coord)
                    if (dist <= 0.5 and IsControlJustPressed(0, 38) and GetEntityHealth(ped) > 101 and not IsPedInAnyVehicle(ped)) then
                        openSkinShop(index)  
                    end
                end
            end
            Citizen.Wait(5)
        end
        _markerThread = false
    end)
end

Citizen.CreateThread(function()
    addBlips(locsConfig, generalConfig)
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

openSkinShop = function(locs)
    local location = locsConfig[locs]
    local general = generalConfig[location.config]

    SetNuiFocus(true, true)

    inMenu = true

    local ped = PlayerPedId()
    local model = GetEntityModel(ped)

    oldCustom = getCustomization()
    SetEntityCoords(ped, location.coord.xyz)
    SetEntityHeading(ped, location.coord.w)
    ClearPedTasks(ped)

    if (general.hidePlayers) then setPlayersVisible(true); end;

    local sex;
    if (model == GetHashKey('mp_m_freemode_01')) then sex = 'male';
    elseif (model == GetHashKey('mp_f_freemode_01')) then sex = 'female';
    else
        local peds = general.customPeds
        if (peds) then
            local allowed = peds[model]
            if (allowed) then
                if (type(allowed) == 'string') then sex = allowed;
                else sex = 'male';
                end
            end
        end
    end

    local drawables = getDrawables()
    SendNUIMessage({
        action = 'openSkinShop',
        data = {
            type = general.shopType,
            config = general.shopConfig,
            sex = (model == GetHashKey('mp_m_freemode_01') and 'male' or 'female'),
            drawables = drawables
        }
    })

    Citizen.Wait(500) 
    if (not DoesCamExist(tempCam)) then createCam('body'); end;
    FreezeEntityPosition(ped, true)
end