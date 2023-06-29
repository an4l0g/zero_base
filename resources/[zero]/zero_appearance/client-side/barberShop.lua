local vSERVER = Tunnel.getInterface('barberShop')
local config = module('zero_appearance', 'cfg/cfgBarber')

local locsConfig = config.locs
local generalConfig =  config.general

local inBarberShop = false
local nearestBarbershop = {}
local barberId

-- local getBlips = function()
--     local ped = PlayerPedId()
--     local pCoord = GetEntityCoords(ped)
--     local nearestBlip, nearestBlipIndex
--     for k, v in ipairs(config.locs) do
--         local coords = v.coord
--         local distance = #(pCoord - coords)
--         if (distance < 2) then
--             nearestBlip = coord
--         end
--     end
--     return nearestBlip, nearestBlipIndex
-- end

-- nearBarber = function()
--     while (nearestBarbershop) do
--         local idle = 500
--         if (not inMenu) then
--             local ped = PlayerPedId()
--             local pCoord = GetEntityCoords(ped)
--             local distance = #(pCoord - nearestBarbershop.coord)

--             if (distance >= 6 or GetEntityHealth(ped) <= 101) then
--                 nearestBarbershop = nil
--                 barberId = nil
--                 if (inMenu) then inMenu = false; end;
--                 break
--             end

--             -- drawMarkers
--             nearestBlip, nearestBlipIndex = getBlips()
--             if (nearestBlip) then
--                 if (IsControlJustPressed(0, 38) and GetEntityHealth(ped) > 101) then

--                 end
--             end
--         end
--         Citizen.Wait(500)
--     end
-- end

local barberIndex;
local barberValue;
local barberMarkers = {}

local mainThread = function()
    SetNuiFocus(false, false)
    FreezeEntityPosition(PlayerPedId(), false)
    getNearestBarber = function()
        local ped = PlayerPedId()
        local pCoord = GetEntityCoords(ped)
        local barberCoords = {}
        for k, v in ipairs(locsConfig) do
            local distance = #(pCoord - v.coord.xyz)
            if (distance <= 10) then
                table.insert(barberCoords, v)
            end
        end
        return barberCoords
    end

    createMarkers = function(coords)
        DrawMarker(27, coords.x, coords.y, coords.z-0.97, 0, 0, 0, 0, 0, 0, 1.0, 1.0, 1.0, 0, 153, 255, 155, 0, 0, 0, 1)
    end

    while (true) do
        local idle = 1000
        if (not inMenu) then   
            local nearestBarber = getNearestBarber() 
            if (nearestBarber) then
                local ped = PlayerPedId()
                local pCoord = GetEntityCoords(ped)
                for k, v in pairs(nearestBarber) do
                    local coord = vector3(v.coord.xyz)
                    local distance = #(pCoord - coord)
                    if (distance > 10 or GetEntityHealth(ped) <= 101) then
                        nearestBarber = nil
                        break
                    else
                        idle = 5
                        createMarkers(coord)
                        if (distance <= 1.2 and IsControlJustPressed(0, 38) and GetEntityHealth(ped) > 101) then
                            openBarberShop(k)
                        end
                    end
                end
            end
        end
        Citizen.Wait(idle)
    end
end

CreateThread(mainThread)

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

openBarberShop = function(locs)
    local location = locsConfig[locs]
    local general = generalConfig[location.config]

    SetNuiFocus(true, true)

    LocalPlayer.state.pedCustom = vSERVER.getCharacter()
    inMenu = true

    local ped = PlayerPedId()
    local model = GetEntityModel(ped)

    -- oldCustom = getCustomization()
    TaskGoToCoordAnyMeans(ped, location.coord.x, location.coord.y, location.coord.z, 1.0, 0, 0, 786603, 0xbf800000)
    ClearPedTasks(ped)

    if (general.hidePlayers) then setPlayersVisible(true); end;

    local drawables = getDrawables()
    SendNUIMessage({
        action = 'openBarberShop',
        data = {
            type = general.shopType,
            config = general.shopConfig,
            sex = (model == GetHashKey('mp_m_freemode_01') and 'male' or 'female'),
            drawables = drawables
        }
    })
    
    SetCameraCoords('all', true)

    Citizen.Wait(1000) 
    FreezeEntityPosition(ped, true)
    SetEntityHeading(ped, location.coord.w)

    -- setBarberRoupa(config.roupaPelado)
    -- 
end

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

local setBarberRoupa = function(roupaPelado)
    local ped = PlayerPedId()
    local model = GetEntityModel(ped)
    local idleCopy = {}
    for l,w in pairs(roupaPelado[model]) do
        idleCopy[l] = w
    end

    setCustomization(idleCopy)
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