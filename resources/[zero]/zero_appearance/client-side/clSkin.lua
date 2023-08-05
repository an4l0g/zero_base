local vSERVER = Tunnel.getInterface('skinShop')
local config = module('zero_appearance', 'cfg/cfgSkin')

local locsConfig = config.locs
local generalConfig =  config.general

local checkVariation = function(value)
    if (value >= 0) then return value; end;
    return 0
end

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
        { amount = GetNumberOfPedPropDrawableVariations(ped, 0), type = 'p0', model = GetPedPropIndex(ped, 0), var = checkVariation(GetPedPropTextureIndex(ped, 0)) },
        { amount = GetNumberOfPedPropDrawableVariations(ped, 1), type = 'p1', model = GetPedPropIndex(ped, 1), var = checkVariation(GetPedPropTextureIndex(ped, 1)) },
        { amount = GetNumberOfPedPropDrawableVariations(ped, 2), type = 'p2', model = GetPedPropIndex(ped, 2), var = checkVariation(GetPedPropTextureIndex(ped, 2)) },
        { amount = GetNumberOfPedPropDrawableVariations(ped, 6), type = 'p6', model = GetPedPropIndex(ped, 6), var = checkVariation(GetPedPropTextureIndex(ped, 6)) },
        { amount = GetNumberOfPedPropDrawableVariations(ped, 7), type = 'p7', model = GetPedPropIndex(ped, 7), var = checkVariation(GetPedPropTextureIndex(ped, 7)) }
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
                    if (dist <= 1.2 and IsControlJustPressed(0, 38) and GetEntityHealth(ped) > 100 and not IsPedInAnyVehicle(ped)) then
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
    TriggerEvent('zero_hud:toggleHud', false)
    local location = locsConfig[locs]
    local general = generalConfig[location.config]

    SetNuiFocus(true, true)

    inMenu = true

    local ped = PlayerPedId()
    local model = GetEntityModel(ped)

    oldCustom = zero.getCustomization()
    SetEntityCoords(ped, location.coord.xyz)
    SetEntityHeading(ped, location.coord.w)
    ClearPedTasks(ped)

    if (general.hidePlayers) then setPlayersVisible(false); end;

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
    createCam('body')
    FreezeEntityPosition(ped, true)
end

RegisterNuiCallback('changeSkinshopDemo', function(data)
    local ped = PlayerPedId()
    local draw = data.drawables
    local variations = {}
    if (data.drawables) then
        -- Mascara
        SetPedComponentVariation(ped, 1, draw['1'].model, draw['1'].var)
        variations['1'] = GetNumberOfPedTextureVariations(ped, 1, draw['1'].model)

        -- Mãos
        SetPedComponentVariation(ped, 3, draw['3'].model, draw['3'].var)
        variations['3'] = GetNumberOfPedTextureVariations(ped, 3, draw['3'].model)

        -- Calça
        SetPedComponentVariation(ped, 4, draw['4'].model, draw['4'].var)
        variations['4'] = GetNumberOfPedTextureVariations(ped, 4, draw['4'].model)

        -- Mochila
        SetPedComponentVariation(ped, 5, draw['5'].model, draw['5'].var)
        variations['5'] = GetNumberOfPedTextureVariations(ped, 5, draw['5'].model)

        -- Sapatos
        SetPedComponentVariation(ped, 6, draw['6'].model, draw['6'].var)
        variations['6'] = GetNumberOfPedTextureVariations(ped, 6, draw['6'].model)

        -- Colar
        SetPedComponentVariation(ped, 7, draw['7'].model, draw['7'].var)
        variations['7'] = GetNumberOfPedTextureVariations(ped, 7, draw['7'].model)

        -- Camisa
        SetPedComponentVariation(ped, 8, draw['8'].model, draw['8'].var)
        variations['8'] = GetNumberOfPedTextureVariations(ped, 8, draw['8'].model)

        -- Colete
        SetPedComponentVariation(ped, 9, draw['9'].model, draw['9'].var)
        variations['9'] = GetNumberOfPedTextureVariations(ped, 9, draw['9'].model)

        -- Jaqueta
        SetPedComponentVariation(ped, 11, draw['11'].model, draw['11'].var)
        variations['11'] = GetNumberOfPedTextureVariations(ped, 11, draw['11'].model)

        -- Chapeu
        SetPedPropIndex(ped, 0, draw['p0'].model, draw['p0'].var)
        variations['p0'] = GetNumberOfPedPropTextureVariations(ped, 0, draw['p0'].model)

        -- Oculos
        SetPedPropIndex(ped, 1, draw['p1'].model, draw['p1'].var)
        variations['p1'] = GetNumberOfPedPropTextureVariations(ped, 1, draw['p1'].model)
        
        -- Brincos
        SetPedPropIndex(ped, 2, draw['p2'].model, draw['p2'].var)
        variations['p2'] = GetNumberOfPedPropTextureVariations(ped, 2, draw['p2'].model)

        -- Relogio
        SetPedPropIndex(ped, 6, draw['p6'].model, draw['p6'].var)
        variations['p6'] = GetNumberOfPedPropTextureVariations(ped, 6, draw['p6'].model)

        -- Bracelete
        SetPedPropIndex(ped, 7, draw['p7'].model, draw['p7'].var)
        variations['p7'] = GetNumberOfPedPropTextureVariations(ped, 7, draw['p7'].model)

        SendNUIMessage({
            action = 'setVariations',
            data = variations
        })
    end
end)

RegisterNuiCallback('buySkinshopCustomizations', function(data)
    if (data.drawables and data.total > 0) then
        data.drawables.pedModel = GetEntityModel(PlayerPedId())
        if (vSERVER.tryPayment(data.total, data.drawables)) then
            oldCustom = nil
        end
    end
    closeNui()
end)