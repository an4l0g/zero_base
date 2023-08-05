local vSERVER = Tunnel.getInterface('barberShop')
local config = module('zero_appearance', 'cfg/cfgBarber')

local locsConfig = config.locs
local generalConfig =  config.general

local getDrawables = function(playerModel)
    local ped = PlayerPedId()
    local custom = LocalPlayer.state.pedCustom
    local pedDrawables = {
        [GetHashKey('mp_m_freemode_01')] = {
            { blemishes = GetNumHeadOverlayValues(0), model = custom.blemishesModel, opacity = custom.blemishesOpacity },
            { beard = GetNumHeadOverlayValues(1), model = custom.beardModel, main_color = custom.beardColor, opacity = custom.beardOpacity },
            { eyebrows = GetNumHeadOverlayValues(2), model = custom.eyebrowsModel, main_color = custom.eyebrowsColor, opacity = custom.eyebrowsOpacity },
            { hair = GetNumberOfPedDrawableVariations(ped, 2), model = custom.hairModel, main_color = custom.firstHairColor, secondary_color = custom.secondHairColor },
            { ageing = GetNumHeadOverlayValues(3), model = custom.ageingModel, opacity = custom.ageingOpacity },
            { makeup = GetNumHeadOverlayValues(4), model = custom.makeupModel, opacity = custom.makeupOpacity },
            { blush = GetNumHeadOverlayValues(5), model = custom.blushModel, main_color = custom.blushColor, opacity = custom.blushOpacity },
            { complexion = GetNumHeadOverlayValues(6), model = custom.complexionModel, opacity = custom.complexionOpacity },
            { sundamage = GetNumHeadOverlayValues(7), model = custom.sundamageModel, opacity = custom.sundamageOpacity },
            { lipstick = GetNumHeadOverlayValues(8), model = custom.lipstickModel, main_color = custom.lipstickColor, opacity = custom.lipstickOpacity },
            { freckles = GetNumHeadOverlayValues(9), model = custom.frecklesModel, opacity = custom.frecklesOpacity },
            { chestModel = GetNumHeadOverlayValues(10), model = custom.chestModel, main_color = custom.chestColor, opacity = custom.chestOpacity },
        },
        [GetHashKey('mp_f_freemode_01')] = {
            { blemishes = GetNumHeadOverlayValues(0), model = custom.blemishesModel, opacity = custom.blemishesOpacity },
            { eyebrows = GetNumHeadOverlayValues(2), model = custom.eyebrowsModel, main_color = custom.eyebrowsColor, opacity = custom.eyebrowsOpacity },
            { hair = GetNumberOfPedDrawableVariations(ped, 2), model = custom.hairModel, main_color = custom.firstHairColor, secondary_color = custom.secondHairColor },
            { ageing = GetNumHeadOverlayValues(3), model = custom.ageingModel, opacity = custom.ageingOpacity },
            { makeup = GetNumHeadOverlayValues(4), model = custom.makeupModel, opacity = custom.makeupOpacity },
            { blush = GetNumHeadOverlayValues(5), model = custom.blushModel, main_color = custom.blushColor, opacity = custom.blushOpacity },
            { complexion = GetNumHeadOverlayValues(6), model = custom.complexionModel, opacity = custom.complexionOpacity },
            { sundamage = GetNumHeadOverlayValues(7), model = custom.sundamageModel, opacity = custom.sundamageOpacity },
            { lipstick = GetNumHeadOverlayValues(8), model = custom.lipstickModel, main_color = custom.lipstickColor, opacity = custom.lipstickOpacity },
            { freckles = GetNumHeadOverlayValues(9), model = custom.frecklesModel, opacity = custom.frecklesOpacity },
            { chestModel = GetNumHeadOverlayValues(10), model = custom.chestModel, main_color = custom.chestColor, opacity = custom.chestOpacity },
        },
    }
    return pedDrawables[playerModel]
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
                        openBarberShop(index)  
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

openBarberShop = function(locs)
    local location = locsConfig[locs]
    local general = generalConfig[location.config]

    SetNuiFocus(true, true)

    LocalPlayer.state.pedCustom = vSERVER.getCharacter()
    inMenu = true
    
    local ped = PlayerPedId()
    local model = GetEntityModel(ped)

    oldCustom = zero.getCustomization()
    SetEntityCoords(ped, location.coord.xyz)
    SetEntityHeading(ped, location.coord.w)
    ClearPedTasks(ped)

    if (general.hidePlayers) then setPlayersVisible(false); end;

    local drawables = getDrawables(model)
    SendNUIMessage({
        action = 'openBarberShop',
        data = {
            type = general.shopType,
            config = general.shopConfig,
            sex = (model == GetHashKey('mp_m_freemode_01') and 'male' or 'female'),
            drawables = drawables
        }
    })
    
    
    Citizen.Wait(500) 
    if (not DoesCamExist(tempCam)) then createCam('body'); end;
    if (general.clothes) then setClothes(general.clothes); end;
    FreezeEntityPosition(ped, true)
end

setPedCustom = function()
    Citizen.Wait(100)
    local ped = PlayerPedId()
    local data = LocalPlayer.state.pedCustom

    -- PARENTES
    SetPedHeadBlendData(ped, data.fatherId , data.motherId, 0, data.colorMother, data.colorFather, 0, data.shapeMix, data.skinMix, 0, false)

    -- OLHOS
    SetPedEyeColor(ped, data.eyesColor)
    SetPedFaceFeature(ped, 11, data.eyesOpening)
    SetPedFaceFeature(ped, 6, data.eyebrowsHeight)
	SetPedFaceFeature(ped, 7, data.eyebrowsWidth)
    SetPedHeadOverlay(ped, 2, data.eyebrowsModel, (data.eyebrowsOpacity or 0.99))
    SetPedHeadOverlayColor(ped, 2, 1, data.eyebrowsColor, data.eyebrowsColor)

    -- Nariz
    SetPedFaceFeature(ped, 0, data.noseWidth)
    SetPedFaceFeature(ped, 1, data.noseHeight)
    SetPedFaceFeature(ped, 2, data.noseLength)
    SetPedFaceFeature(ped, 3, data.noseBridge)
    SetPedFaceFeature(ped, 4, data.noseTip)
    SetPedFaceFeature(ped, 5, data.noseShift)

    -- BOCHECHAS
    SetPedFaceFeature(ped, 8, data.cheekboneHeight)
    SetPedFaceFeature(ped, 9, data.cheekboneWidth)
    SetPedFaceFeature(ped, 10, data.cheeksWidth)

    -- BOCA/MANDIBULA
    SetPedFaceFeature(ped, 12, data.lips)
    SetPedFaceFeature(ped, 13, data.jawWidth)
    SetPedFaceFeature(ped, 14, data.jawHeight)

    -- QUEIXO
    SetPedFaceFeature(ped, 15, data.chinLength)
    SetPedFaceFeature(ped, 16, data.chinPosition)
    SetPedFaceFeature(ped, 17, data.chinWidth)
    SetPedFaceFeature(ped, 18, data.chinShape)

    -- CABELO
    SetPedComponentVariation(ped, 2, data.hairModel, 0, 0)
    SetPedHairColor(ped, data.firstHairColor, data.secondHairColor)
    
    -- BARBA
    SetPedHeadOverlay(ped, 1, data.beardModel, (data.beardOpacity or 0.99))
    SetPedHeadOverlayColor(ped, 1, 1, data.beardColor, data.beardColor)

    -- PELO CORPORAL
    SetPedHeadOverlay(ped, 10, data.chestModel, (data.chestOpacity or 0.99))
    SetPedHeadOverlayColor(ped, 10, 1, data.chestColor, data.chestColor)

    -- BLUSH
    SetPedHeadOverlay(ped, 5, data.blushModel, (data.blushOpacity or 0.99))
    SetPedHeadOverlayColor(ped, 5, 1, data.blushColor, data.blushColor)

    -- BATTOM
    SetPedHeadOverlay(ped, 8, data.lipstickModel, (data.lipstickOpacity or 0.99))
    SetPedHeadOverlayColor(ped, 8, 1, data.lipstickColor, data.lipstickColor)

    -- MANCHAS
    SetPedHeadOverlay(ped, 0, data.blemishesModel, (data.blemishesOpacity or 0.99))
    SetPedHeadOverlayColor(ped, 0, 0, 0, 0)

    -- ENVELHECIMENTO
    SetPedHeadOverlay(ped, 3, data.ageingModel, (data.ageingOpacity or 0.99))
    SetPedHeadOverlayColor(ped, 3, 0, 0, 0)

    -- ASPECTO
    SetPedHeadOverlay(ped, 6, data.complexionModel, (data.complexionOpacity or 0.99))
    SetPedHeadOverlayColor(ped, 6, 0, 0, 0)

    -- PELE
    SetPedHeadOverlay(ped, 7, data.sundamageModel, (data.sundamageOpacity or 0.99))
    SetPedHeadOverlayColor(ped, 7, 0, 0, 0)

    -- SARDAS
    SetPedHeadOverlay(ped, 9, data.frecklesModel, (data.frecklesOpacity or 0.99))
    SetPedHeadOverlayColor(ped, 9, 0, 0, 0)

    -- MAQUIAGEM
    SetPedHeadOverlay(ped, 4, data.makeupModel, (data.makeupOpacity or 0.99))
    SetPedHeadOverlayColor(ped, 4, 0, 10, 15)
end

RegisterNetEvent('zero:barberUpdate', function()
    if (LocalPlayer.state.pedCustom == nil) then 
        LocalPlayer.state.pedCustom = vSERVER.getCharacter()             
        setPedCustom()
    else 
        setPedCustom()
    end
end)

RegisterNetEvent('zero:refreshBarber', function()
    setPedCustom()
end)

RegisterNetEvent('barbershop:init', function(custom)
    LocalPlayer.state.pedCustom = custom
    setPedCustom()    
end)

RegisterNuiCallback('changeBarbershopDemo', function(data)
    local ped = PlayerPedId()
    if (data.drawables) then
        -- SOBRANCELHA
        SetPedHeadOverlay(ped, 2, data.drawables.eyebrows.model, (data.drawables.eyebrows.opacity or 0.99))
        SetPedHeadOverlayColor(ped, 2, 1, data.drawables.eyebrows.main_color, data.drawables.eyebrows.main_color)

        -- CABELO
        SetPedComponentVariation(ped, 2, data.drawables.hair.model, 0, 0)
        SetPedHairColor(ped, data.drawables.hair.main_color, data.drawables.hair.secondary_color)
        
        -- BARBA
        SetPedHeadOverlay(ped, 1, data.drawables.beard.model, (data.drawables.beard.opacity or 0.99))
        SetPedHeadOverlayColor(ped, 1, 1, data.drawables.beard.main_color, data.drawables.beard.main_color)

        -- PELO CORPORAL
        if (data.drawables.chestModel) then
            SetPedHeadOverlay(ped, 10, data.drawables.chestModel.model, (data.drawables.chestModel.opacity or 0.99))
            SetPedHeadOverlayColor(ped, 10, 1, data.drawables.chestModel.main_color, data.drawables.chestModel.main_color)
        end

        -- BLUSH
        SetPedHeadOverlay(ped, 5, data.drawables.blush.model, (data.drawables.blush.opacity or 0.99))
        SetPedHeadOverlayColor(ped, 5, 1, data.drawables.blush.main_color, data.drawables.blush.main_color)

        -- BATTOM
        SetPedHeadOverlay(ped, 8, data.drawables.lipstick.model, (data.drawables.lipstick.opacity or 0.99))
        SetPedHeadOverlayColor(ped, 8, 1, data.drawables.lipstick.main_color, data.drawables.lipstick.main_color)

        -- MANCHAS
        SetPedHeadOverlay(ped, 0, data.drawables.blemishes.model, (data.drawables.blemishes.opacity or 0.99))
        SetPedHeadOverlayColor(ped, 0, 0, 0, 0)

        -- ENVELHECIMENTO
        SetPedHeadOverlay(ped, 3, data.drawables.ageing.model, (data.drawables.ageing.opacity or 0.99))
        SetPedHeadOverlayColor(ped, 3, 0, 0, 0)

        -- ASPECTO
        SetPedHeadOverlay(ped, 6, data.drawables.complexion.model, (data.drawables.complexion.opacity or 0.99))
        SetPedHeadOverlayColor(ped, 6, 0, 0, 0)

        -- PELE
        SetPedHeadOverlay(ped, 7, data.drawables.sundamage.model, (data.drawables.sundamage.opacity or 0.99))
        SetPedHeadOverlayColor(ped, 7, 0, 0, 0)

        -- SARDAS
        SetPedHeadOverlay(ped, 9, data.drawables.freckles.model, (data.drawables.freckles.opacity or 0.99))
        SetPedHeadOverlayColor(ped, 9, 0, 0, 0)

        -- MAQUIAGEM
        SetPedHeadOverlay(ped, 4, data.drawables.makeup.model, (data.drawables.makeup.opacity or 0.99))
        SetPedHeadOverlayColor(ped, 4, 0, 10, 15)
    end
end)

RegisterNuiCallback('buyBarbershopCustomizations', function(data)
    local ped = PlayerPedId()
    local oldCustom = LocalPlayer.state.pedCustom
    if (data.drawables and data.total > 0) then
        -- SOBRANCELHA
        oldCustom.eyebrowsModel = data.drawables.eyebrows.model
        oldCustom.eyebrowsColor = data.drawables.eyebrows.main_color
        oldCustom.eyebrowsOpacity = data.drawables.eyebrows.opacity
        SetPedHeadOverlay(ped, 2, data.drawables.eyebrows.model, (data.drawables.eyebrows.opacity or 0.99))
        SetPedHeadOverlayColor(ped, 2, 1, data.drawables.eyebrows.main_color, data.drawables.eyebrows.main_color)

        -- CABELO
        oldCustom.hairModel = data.drawables.hair.model
        oldCustom.firstHairColor = data.drawables.hair.main_color
        oldCustom.secondHairColor = data.drawables.hair.secondary_color
        SetPedComponentVariation(ped, 2, data.drawables.hair.model, 0, 0)
        SetPedHairColor(ped, data.drawables.hair.main_color, data.drawables.hair.secondary_color)
        
        -- BARBA
        oldCustom.beardModel = data.drawables.beard.model
        oldCustom.beardColor = data.drawables.beard.main_color
        oldCustom.beardOpacity = data.drawables.beard.opacity
        SetPedHeadOverlay(ped, 1, data.drawables.beard.model, (data.drawables.beard.opacity or 0.99))
        SetPedHeadOverlayColor(ped, 1, 1, data.drawables.beard.main_color, data.drawables.beard.main_color)

        -- PELO CORPORAL
        oldCustom.chestModel = data.drawables.chestModel.model
        oldCustom.chestColor = data.drawables.chestModel.main_color
        oldCustom.chestOpacity = data.drawables.chestModel.opacity
        SetPedHeadOverlay(ped, 10, data.drawables.chestModel.model, (data.drawables.chestModel.opacity or 0.99))
        SetPedHeadOverlayColor(ped, 10, 1, data.drawables.chestModel.main_color, data.drawables.chestModel.main_color)

        -- BLUSH
        oldCustom.blushModel = data.drawables.blush.model
        oldCustom.blushColor = data.drawables.blush.main_color
        oldCustom.blushOpacity = data.drawables.blush.opacity
        SetPedHeadOverlay(ped, 5, data.drawables.blush.model, (data.drawables.blush.opacity or 0.99))
        SetPedHeadOverlayColor(ped, 5, 1, data.drawables.blush.main_color, data.drawables.blush.main_color)

        -- BATTOM
        oldCustom.lipstickModel = data.drawables.lipstick.model
        oldCustom.lipstickColor = data.drawables.lipstick.main_color
        oldCustom.lipstickOpacity = data.drawables.lipstick.opacity
        SetPedHeadOverlay(ped, 8, data.drawables.lipstick.model, (data.drawables.lipstick.opacity or 0.99))
        SetPedHeadOverlayColor(ped, 8, 1, data.drawables.lipstick.main_color, data.drawables.lipstick.main_color)

        -- MANCHAS
        oldCustom.blemishesModel = data.drawables.blemishes.model
        oldCustom.blemishesOpacity = data.drawables.blemishes.opacity
        SetPedHeadOverlay(ped, 0, data.drawables.blemishes.model, (data.drawables.blemishes.opacity or 0.99))
        SetPedHeadOverlayColor(ped, 0, 0, 0, 0)

        -- ENVELHECIMENTO
        oldCustom.ageingModel = data.drawables.ageing.model
        oldCustom.ageingOpacity = data.drawables.ageing.opacity
        SetPedHeadOverlay(ped, 3, data.drawables.ageing.model, (data.drawables.ageing.opacity or 0.99))
        SetPedHeadOverlayColor(ped, 3, 0, 0, 0)

        -- ASPECTO
        oldCustom.complexionModel = data.drawables.complexion.model
        oldCustom.complexionOpacity = data.drawables.complexion.opacity
        SetPedHeadOverlay(ped, 6, data.drawables.complexion.model, (data.drawables.complexion.opacity or 0.99))
        SetPedHeadOverlayColor(ped, 6, 0, 0, 0)

        -- PELE
        oldCustom.sundamageModel = data.drawables.sundamage.model
        oldCustom.sundamageOpacity = data.drawables.sundamage.opacity
        SetPedHeadOverlay(ped, 7, data.drawables.sundamage.model, (data.drawables.sundamage.opacity or 0.99))
        SetPedHeadOverlayColor(ped, 7, 0, 0, 0)

        -- SARDAS
        oldCustom.frecklesModel = data.drawables.freckles.model
        oldCustom.frecklesOpacity = data.drawables.freckles.opacity
        SetPedHeadOverlay(ped, 9, data.drawables.freckles.model, (data.drawables.freckles.opacity or 0.99))
        SetPedHeadOverlayColor(ped, 9, 0, 0, 0)

        -- MAQUIAGEM
        oldCustom.makeupModel = data.drawables.makeup.model
        oldCustom.makeupOpacity = data.drawables.makeup.opacity
        SetPedHeadOverlay(ped, 4, data.drawables.makeup.model, (data.drawables.makeup.opacity or 0.99))
        SetPedHeadOverlayColor(ped, 4, 0, 10, 15)

        if (vSERVER.tryPayment(data.total, oldCustom)) then
            LocalPlayer.state.pedCustom = oldCustom
            setPedCustom()
        end
    end
    closeNui()
    setPedCustom() 
end)