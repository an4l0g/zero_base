local vSERVER = Tunnel.getInterface('barberShop')

local locsConfig = configBarberShop.locs
local generalConfig =  configBarberShop.general

local inBarberShop = false
local nearestBlip = {}

local mainThread = function()
    local getNearestBarberShops = function()
        while true do
            if (not inBarberShop and not inMenu) then
                local pedCoords = GetEntityCoords(PlayerPedId())
                if (nearestBlip) and nearestBlip['coord'] then
                    local distance = #(pedCoords - nearestBlip['coord'].xyz)
                    if (distance >= 6.0) then
                        nearestBlip = false
                    elseif (distance <= 1.2) then
                        nearestBlip['close'] = true
                    else
                        nearestBlip['close'] = false
                    end
                else
                    for k, v in pairs(locsConfig) do
                        local distance = #(pedCoords - v['coord'].xyz)
                        if (distance <= 5.0) then
                            nearestBlip = locsConfig[k]
                        end
                    end
                end
            end
            Citizen.Wait(500)
        end
    end

    CreateThread(getNearestBarberShops)
    addBlips(locsConfig)

    while true do
        local idle = 500
        local ped = PlayerPedId()
        if (not inBarberShop and not inMenu) then
            if (nearestBlip) and nearestBlip['coord'] then
                idle = 4
                DrawMarker(27, nearestBlip.coord.x, nearestBlip.coord.y, nearestBlip.coord.z, 0, 0, 0, 0, 0, 0, 1.0, 1.0, 1.0, 0, 153, 255, 155, 0, 0, 0, 1)
                if (IsControlJustPressed(0, 38) and GetEntityHealth(ped) > 101 and not IsPedInAnyVehicle(ped)) then
                    openBarberShop(generalConfig[nearestBlip['config']], nearestBlip['coord'].xyz, nearestBlip['coord'].w)
                end
            end
        end
        Citizen.Wait(idle)
    end
end

CreateThread(mainThread)

local barberData = {
    oldCharacter = {
        ['0'] = 0,
        ['1'] = 0,
        ['2'] = 0,
        ['3'] = 0,
        ['4'] = 0,
        ['5'] = 0,
        ['6'] = 0,
        ['8'] = 0,
        ['9'] = 0,                
        ['10'] = 0,
        ['12'] = 0,
        ['13'] = 0,                
    }
}

local oldCustom = {}
local old_custom = {}

local setPedCustom = function()
    local ped = PlayerPedId()
    local data = LocalPlayer.state['pedCustom']

    -- Aspectos visuais
    SetPedHeadBlendData(ped, data.fathersID, data.mothersID, 0, data.skinColor, 0, 0, (data.shapeMix and data.shapeMix + 0.0 or 0.99), 0, 0, false)

    -- Olhos
    SetPedEyeColor(ped, data.eyesColor)

    -- Sobrancelha
    SetPedFaceFeature(ped, 6, data.eyebrowsHeight)
    SetPedFaceFeature(ped, 7, data.eyebrowsWidth)

    -- Nariz
    SetPedFaceFeature(ped, 0, data.noseWidth)
    SetPedFaceFeature(ped, 1, data.noseHeight)
    SetPedFaceFeature(ped, 2, data.noseLength)
    SetPedFaceFeature(ped, 3, data.noseBridge)
    SetPedFaceFeature(ped, 4, data.noseTip)
    SetPedFaceFeature(ped, 5, data.noseShift)

    -- Bochechas
    SetPedFaceFeature(ped, 8, data.cheekboneHeight)
    SetPedFaceFeature(ped, 9, data.cheekboneWidth)
    SetPedFaceFeature(ped, 10, data.cheeksWidth)

    -- Boca/Mandibula
    SetPedFaceFeature(ped, 12, data.lips)
    SetPedFaceFeature(ped, 13, data.jawWidth)
    SetPedFaceFeature(ped, 14, data.jawHeight)

    -- Queixo
    SetPedFaceFeature(ped, 15, data.chinLength)
    SetPedFaceFeature(ped, 16, data.chinPosition)
    SetPedFaceFeature(ped, 17, data.chinWidth)
    SetPedFaceFeature(ped, 18, data.chinShape)

    -- Pescoço
    SetPedFaceFeature(ped, 19, data.neckWidth)

    -- Cabelo
    SetPedComponentVariation(ped, 2, data.hairModel, 0, 0)
    SetPedHairColor(ped, data.firstHairColor, data.secondHairColor)

    -- Sobrancelha 
    SetPedHeadOverlay(ped, 2, data.eyebrowsModel, (data.eyebrowsOpacity or 0.99))
    SetPedHeadOverlayColor(ped, 2, 1, data.eyebrowsColor, data.eyebrowsColor)

    -- Barba
    SetPedHeadOverlay(ped, 1, data.beardModel, (data.bardOpacity or 0.99))
    SetPedHeadOverlayColor(ped, 1, 1, data.beardColor, data.beardColor)

    -- Pelo Corporal
    SetPedHeadOverlay(ped, 10, data.chestModel, (data.chestOpacity or 0.99))
    SetPedHeadOverlayColor(ped, 10, 1, data.chestColor, data.chestColor)

    -- Blush
    SetPedHeadOverlay(ped, 5, data.blushModel, (data.blushOpacity or 0.99))
    SetPedHeadOverlayColor(ped, 5, 1, data.blushColor, data.blushColor)

    -- Battom
    SetPedHeadOverlay(ped, 8, data.lipstickModel, (data.lipstickOpacity or 0.99))
    SetPedHeadOverlayColor(ped, 8, 1, data.lipstickColor, data.lipstickColor)

    -- Manchas
    SetPedHeadOverlay(ped, 0, data.blemishesModel, (data.blemishesOpacity or 0.99))
    SetPedHeadOverlayColor(ped, 0, 0, 0, 0)

    -- Envelhecimento
    SetPedHeadOverlay(ped, 3, data.ageingModel, (data.ageingOpacity or 0.99))
    SetPedHeadOverlayColor(ped,3,0,0,0)

    -- Aspecto
    SetPedHeadOverlay(ped, 6, data.complexionModel, (data.complexionopacity or 0.99))
    SetPedHeadOverlayColor(ped, 6, 0, 0, 0)

    -- Pele
    SetPedHeadOverlay(ped, 7, data.sundamageModel, (data.sundamageOpacity or 0.99))
    SetPedHeadOverlayColor(ped, 7, 0, 0, 0)

    -- Sardas
    SetPedHeadOverlay(ped, 9, data.frecklesModel, (data.frecklesOpacity or 0.99))
    SetPedHeadOverlayColor(ped,9,0,0,0)

    -- Maquiagem
    SetPedHeadOverlay(ped, 4, data.makeupModel, (data.makeUpOpacity or 0.99))
    SetPedHeadOverlayColor(ped, 4, 0, 10, 15)
end

local getDrawables = function()
    local ped = PlayerPedId()
    local playerModel = GetEntityModel(ped)
    local custom = LocalPlayer.state['pedCustom']
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
        },
    }
    return pedDrawables[playerModel]
end

local setBarberRoupa = function(roupaPelado)
    local ped = PlayerPedId()
    local model = GetEntityModel(ped)
    local idleCopy = {}
    for l,w in pairs(roupaPelado[model]) do
        idleCopy[l] = w
    end

    setCustomization(idleCopy)
end

openBarberShop = function(config, coords, heading)
    LocalPlayer.state['pedCustom'] = vSERVER.getCharacter()
    LocalPlayer.state['oldPedCustom'] = LocalPlayer.state['pedCustom']
    
    local ped = PlayerPedId()
    local model = GetEntityModel(ped)

    SetNuiFocus(true, true)
    inBarberShop = true
    oldCustom = getCustomization()

    FreezeEntityPosition(ped, true)
    SetEntityCoords(ped, coords)
    SetEntityHeading(ped, heading)
    ClearPedTasks(ped)

    local drawables = getDrawables()

    if (config['hidePlayers']) then setPlayersVisible(true); end;

    SendNUIMessage({
        action = 'openBarberShop',
        data = {
            type = config['shopType'],
            config = config['shopConfig'],
            sex = (model == GetHashKey('mp_m_freemode_01') and 'male' or 'female'),
            drawables = drawables
        }
    })

    setBarberRoupa(config.roupaPelado)
    SetCameraCoords('all', true)
end

RegisterNetEvent('zero:barberUpdate')
AddEventHandler('zero:barberUpdate', function(type)
    if (LocalPlayer.state['pedCustom'] == nil) then 
        if (type) then 
            -- RPC.triggerCallback('barberShop-getCharacter', function(custom, start)
            --     LocalPlayer.state.barberStart = start
            --     LocalPlayer.state.pedCustom = custom
            --     setPedCustom()    
            -- end)
        else                 
            setPedCustom()
        end
    else 
        setPedCustom()
    end
end)

RegisterNetEvent('zero:refreshBarber')
AddEventHandler('zero:refreshBarber',function()
    setPedCustom()
end)

RegisterNetEvent('barbershop:init', function()
    LocalPlayer.state['barberStart'] = true
    LocalPlayer.state['pedCustom'] = custom
    setPedCustom()    
end)

RegisterNuiCallback('changeBarbershopDemo', function(data)
    print("Alterou alguma coisa e precisa ser alterado no boneco", json.encode(data))
end)

RegisterNuiCallback('buyBarbershopCustomizations', function(data)
    print("Comprou customizações", json.encode(data))
    SetNuiFocus(false, false)
end)