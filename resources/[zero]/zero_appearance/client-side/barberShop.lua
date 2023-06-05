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
                DrawText3D(nearestBlip['coord'].x, nearestBlip['coord'].y, nearestBlip['coord'].z+0.7, '~b~[E]~w~ - Barbearia')
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
    parts = {
        ['Defeitos'] = 0,
        ['Barba'] = 1,
        ['Sobrancelhas'] = 2,
        ['Envelhecimento'] = 3,
        ['Maquiagem'] = 4,
        ['Blush'] = 5,
        ['Rugas'] = 6,
        ['Batom'] = 8,
        ['Sardas'] = 9,
        ['Cabelo no Peito'] = 10,
        ['Manchas no Corpo'] = 11,
        ['Cabelo'] = 12,
        ['Cor Sec. do Cabelo'] = 13
    },

    character = {

    },

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
    },

    carroCompras = {
        ['0'] = false,
        ['1'] = false,
        ['2'] = false,
        ['3'] = false,
        ['4'] = false,
        ['5'] = false,
        ['6'] = false,
        ['8'] = false,
        ['9'] = false,              
        ['10'] = false,
        ['12'] = false,
        ['13'] = false,              
    }
}

local value = 0
local totalValue = 0
local barberReset = false
local oldCustom = {}
local oldC

local updateBarberCompras = function()
    value = 0 
    for index, value in pairs(barberData['carroCompras']) do
        if barberData['carroCompras'][index] == true then
            local amount = configShop[tonumber(index)]['price']
            valor = (valor + amount)
        end
    end
    totalValue = value
    return value
end

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

local getBarberShopDrawables = function(part)
    ped = PlayerPedId()
    if (part == 12) then
        return tonumber(GetNumberOfPedDrawableVariations(ped, 2))
    elseif (part == -1) then
        return tonumber(GetNumberOfPedDrawableVariations(ped, 0))
    elseif (part == -2) then
        return 64
    else
        return tonumber(GetNumHeadOverlayValues(part))
    end
end

local getBarberShopTextures = function(part)
    if (part == -1) then
        return tonumber(GetNumHairColors())
    else
        return 64
    end
end

local getBarberOverlay = function()
    local bConfig = LocalPlayer.state['pedCustom']
    local overlay = {
        ['0'] = { bConfig.blemishesModel, 0 },
        ['1'] = { bConfig.beardModel, bConfig.beardColor },            
        ['2'] = { bConfig.eyebrowsModel, bConfig.eyebrowsColor },            
        ['3'] = { bConfig.ageingModel, 0 },            
        ['4'] = { bConfig.makeupModel, 0 },            
        ['5'] = { bConfig.blushModel, bConfig.blushColor },
        ['6'] = { bConfig.complexionModel, 0 },
        ['8'] = { bConfig.lipstickModel, bConfig.lipstickColor },
        ['9'] = { bConfig.frecklesModel, 0 },            
        ['10'] = { bConfig.chestModel, bConfig.chestColor },
        ['12'] = { bConfig.hairModel, bConfig.firstHairColor },
        ['13'] = { bConfig.hairModel, bConfig.secondHairColor },
    }
    return overlay
end

local setBarberRoupa = function()
    local modelHash = old_custom.modelhash
    local idleCopy = {}
    for l,w in pairs(configShop.roupaPelado[modelHash]) do
        idleCopy[l] = w
    end

    setCustomization(idleCopy)
end

openBarberShop = function(config, coords, heading)
    local ped = PlayerPedId()
    local model = GetEntityModel(ped)

    SetNuiFocus(true, true)
    barberReset = true
    inBarberShop = true
    oldCustom = getCustomization()

    SetEntityCoords(ped, coords)
    SetEntityHeading(ped, heading)
    ClearPedTasks(ped)

    local drawables = getBarberShopDrawables(12)
    local textures = getBarberShopTextures(12)

    LocalPlayer.state['oldPedCustom'] = LocalPlayer.state['pedCustom']

    if (config['hidePlayers']) then setPlayersVisible(true); end;

    oldC = getBarberOverlay()
    barberData['oldCharacter'] = LocalPlayer.state['oldPedCustom']

    SendNUIMessage({
        method = 'openBarberShop',
        data = {
            type = config['shopType'],
            config = config['shopConfig'],
            oldPart = oldC,
            sex = (model == `mp_m_freemode_01` and 'Male' or 'Female'),
            prefix = (model == `mp_f_freemode_01` and 'M' or 'F'),
            category = 12,
            drawables = drawables,
            textures = textures
        }
    })

    setBarberRoupa()
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