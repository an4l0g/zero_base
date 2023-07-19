local vSERVER = Tunnel.getInterface('skinShop')
local config = module('zero_appearance', 'cfg/cfgSkin')

local locsConfig = config.locs
local generalConfig =  config.general

local getDrawables = function()
    local ped = PlayerPedId()
    local pedDrawables = {
        { amount = GetNumberOfPedDrawableVariations(ped, 1), type = '1', model = GetPedDrawableVariation(ped, 1), var = GetPedTextureVariation(ped, 1)  },
        { amount = GetNumberOfPedDrawableVariations(ped, 3), type = '3', model = GetPedDrawableVariation(ped, 3), var = GetPedTextureVariation(ped, 3) },
        { amount = GetNumberOfPedDrawableVariations(ped, 4), type = '4', model = GetPedDrawableVariation(ped, 4), var = GetPedTextureVariation(ped, 4) },
        { amount = GetNumberOfPedDrawableVariations(ped, 5), type = '5', model = GetPedDrawableVariation(ped, 5), var = GetPedTextureVariation(ped, 5) },
        { amount = GetNumberOfPedDrawableVariations(ped, 6), type = '6', model = GetPedDrawableVariation(ped, 6), var = GetPedTextureVariation(ped, 6) },
        { amount = GetNumberOfPedDrawableVariations(ped, 7), type = '7', model = GetPedDrawableVariation(ped, 7), var = GetPedTextureVariation(ped, 7) },
        { amount = GetNumberOfPedDrawableVariations(ped, 8), type = '8', model = GetPedDrawableVariation(ped, 8), var = GetPedTextureVariation(ped, 8) },
        { amount = GetNumberOfPedDrawableVariations(ped, 9), type = '9', model = GetPedDrawableVariation(ped, 9), var = GetPedTextureVariation(ped, 9) },
        { amount = GetNumberOfPedDrawableVariations(ped, 11), type = '11', model = GetPedDrawableVariation(ped, 11), var = GetPedTextureVariation(ped, 11) },
        { amount = GetNumberOfPedPropDrawableVariations(ped, 0), type = 'p0', model = GetPedPropIndex(ped, 0), var = GetPedPropTextureIndex(ped, 0) },
        { amount = GetNumberOfPedPropDrawableVariations(ped, 1), type = 'p1', model = GetPedPropIndex(ped, 1), var = GetPedPropTextureIndex(ped, 1) },
        { amount = GetNumberOfPedPropDrawableVariations(ped, 2), type = 'p2', model = GetPedPropIndex(ped, 2), var = GetPedPropTextureIndex(ped, 2) },
        { amount = GetNumberOfPedPropDrawableVariations(ped, 6), type = 'p6', model = GetPedPropIndex(ped, 6), var = GetPedPropTextureIndex(ped, 6) },
        { amount = GetNumberOfPedPropDrawableVariations(ped, 7), type = 'p7', model = GetPedPropIndex(ped, 7), var = GetPedPropTextureIndex(ped, 7) }
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
                    if (dist <= 1.2 and IsControlJustPressed(0, 38) and GetEntityHealth(ped) > 101 and not IsPedInAnyVehicle(ped)) then
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

RegisterNUICallback('getSkinVariations', function(data, cb)
    local ped = PlayerPedId()

    local isProp, index = parsePart(data.type)
    if (isProp) then max = GetNumberOfPedPropTextureVariations(ped, index, data.model);
    else max = GetNumberOfPedTextureVariations(ped, 11, data.model);
    end

    SendNUIMessage({
        action = 'setSkinVariantions',
        data = max
    })
end)