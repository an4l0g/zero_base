cli = {}
Tunnel.bindInterface('Creation', cli)
vSERVER = Tunnel.getInterface('Creation')

local setGender = function(gender) 
    local ped = PlayerPedId()

    local model = 'mp_m_freemode_01'
    if (gender == 'female') then model = 'mp_f_freemode_01' end

    local modelHash = GetHashKey(model)
    RequestModel(modelHash) 
    while (not HasModelLoaded(modelHash)) do 
        RequestModel(modelHash) 
        Citizen.Wait(10) 
    end
    SetPlayerModel(PlayerId(), modelHash)
    SetModelAsNoLongerNeeded(modelHash)

    if (HasModelLoaded(modelHash)) then
        ped = PlayerPedId()
        
        local currentHealth, currentArmour = GetEntityHealth(ped), GetPedArmour(ped)
        SetPedMaxHealth(ped, 200)
        SetEntityHealth(ped, currentHealth)
        SetPedArmour(ped, currentArmour)
    end

    local weapons = (zero.getWeapons() or {})
    zero.giveWeapons(weapons, true, GlobalState.weaponToken)

    resetClothes()

    SetPedHeadBlendData(ped, 0, 21, 0, 0, 0, 0, 0.6, 0.0, 0.0, false)
end

local povCam = {
    ['body'] = function()
        Cam({ x = 0, y = 0.9, z = 0.65 }, { x = 1.0, y = 0.0, z = 0.0 })
    end,
    ['head'] = function()
        Cam({ x = 0, y = 0.6, z = 0.65 }, { x = 1.0, y = 0.0, z = 0.0 })
    end
}

atualCam = ''
local createCam = function(pov)
    atualCam = pov
    povCam[pov]()
end

cli.createCharacter = function()
    cli.loadingPlayer(true)
    vSERVER.changeSession(GetPlayerServerId(PlayerId()))
    local ped = PlayerPedId()

    TriggerEvent('zero_hud:toggleHud', false)
    TriggerEvent('zero_weather:staticTime', { 
        weather = 'EXTRASUNNY', 
        hours = 14, 
        minutes = 0 
    })

    Citizen.Wait(1000)
    DoScreenFadeOut(500)
    zero.teleport(generalConfig.creatorLocation.xyz)
    SetEntityHeading(ped, generalConfig.creatorLocation.w)
    setGender('male') 
    SetEntityHealth(ped, 200)
    Citizen.Wait(1000)
    DoScreenFadeIn(500)
    FreezeEntityPosition(ped, true)
    SetNuiFocus(true, true)
    SendNUIMessage({ action = 'open' })
end

resetClothes = function()
    local clothes = {
        [GetHashKey('mp_m_freemode_01')] = {
            ['mask'] = { 0, 0, 0 }, -- 1
            ['hair'] = { 0, 0, 0 }, -- 2
            ['torso'] = { 15, 0, 2 }, -- 3
            ['leg'] = { 21, 0, 2 }, -- 4
            ['bag'] = { 0, 0, 0 }, -- 5
            ['shoes'] = { 34, 0, 2 }, -- 6
            ['acessory'] = { 0, 0, 0 }, -- 7
            ['undershirt'] = { 15, 0, 2 }, -- 8
            ['kevlar'] = { 0, 0, 0 }, -- 9
            ['badge'] = { 0, 0, 0 }, -- 10
            ['torso2'] = { 15, 0, 2 }, -- 11
            ['hat'] = { -1, 0 }, -- p0
            ['glass'] = { -1, 0 }, --p1
            ['ear'] = { -1, 0 }, -- p2
            ['watch'] = { -1, 0 }, --p6
            ['bracelet'] = { -1, 0 } --p7
        },
        [GetHashKey('mp_f_freemode_01')] = {
            ['mask'] = { 0, 0, 0 }, -- 1
            ['hair'] = { 0, 0, 0 }, -- 2
            ['torso'] = { 15, 0, 1 }, -- 3
            ['leg'] = { 15, 0, 1 }, -- 4
            ['bag'] = { 0, 0, 0 }, -- 5
            ['shoes'] = { 35, 0, 1 }, -- 6
            ['acessory'] = { 0, 0, 0 }, -- 7
            ['undershirt'] = { 2, 0, 1 }, -- 8
            ['kevlar'] = { 0, 0, 0 }, -- 9
            ['badge'] = { 0, 0, 0 }, -- 10
            ['torso2'] = { 15, 0, 1 }, -- 11
            ['hat'] = { -1, 0 }, -- p0
            ['glass'] = { -1, 0 }, --p1
            ['ear'] = { -1, 0 }, -- p2
            ['watch'] = { -1, 0 }, --p6
            ['bracelet'] = { -1, 0 } --p7
        }
    }
    local model = GetEntityModel(PlayerPedId())
    setClothing(clothes[model] or {})
end

finishClothes = function()
    local clothes = {
        [GetHashKey('mp_m_freemode_01')] = {
            ['mask'] = { 0, 0, 0 }, -- 1
            ['hair'] = { 0, 0, 0 }, -- 2
            ['torso'] = { 8, 0, 0 }, -- 3
            ['leg'] = { 26, 0, 0 }, -- 4
            ['bag'] = { 0, 0, 2 }, -- 5
            ['shoes'] = { 1, 0, 0 }, -- 6
            ['acessory'] = { 0, 0, 2 }, -- 7
            ['undershirt'] = { 15, 0, 0 }, -- 8
            ['kevlar'] = { 0, 0, 2 }, -- 9
            ['badge'] = { 0, 0, 2 }, -- 10
            ['torso2'] = { 38, 0, 0 }, -- 11
            ['hat'] = { -1, 0 }, -- p0
            ['glass'] = { -1, 0 }, --p1
            ['ear'] = { -1, 0 }, -- p2
            ['watch'] = { -1, 0 }, --p6
            ['bracelet'] = { -1, 0 } --p7
        },
        [GetHashKey('mp_f_freemode_01')] = {
            ['mask'] = { -1, 0, 0 }, -- 1
            ['hair'] = { 0, 0, 0 }, -- 2
            ['torso'] = { 9, 0, 1 }, -- 3
            ['leg'] = { 73, 0, 1 }, -- 4
            ['bag'] = { 0, 0, 0 }, -- 5
            ['shoes'] = { 3, 0, 1 }, -- 6
            ['acessory'] = { 0, 0, 0 }, -- 7
            ['undershirt'] = { 2, 0, 1 }, -- 8
            ['kevlar'] = { 0, 0, 0 }, -- 9
            ['badge'] = { 0, 0, 0 }, -- 10
            ['torso2'] = { 75, 0, 1 }, -- 11
            ['hat'] = { -1, 0 }, -- p0
            ['glass'] = { -1, 0 }, --p1
            ['ear'] = { -1, 0 }, -- p2
            ['watch'] = { -1, 0 }, --p6
            ['bracelet'] = { -1, 0 } --p7
        }
    }
    local model = GetEntityModel(PlayerPedId())
    setClothing(clothes[model] or {})
end

setClothing = function(clothes)
    local ped = PlayerPedId()
    local components = {
        ['mask'] = 1,
        ['hair'] = 0,
        ['torso'] = 3,
        ['leg'] = 4,
        ['bag'] = 5,
        ['shoes'] = 6,
        ['acessory'] = 7,
        ['undershirt'] = 8,
        ['kevlar'] = 9,
        ['badge'] = 10,
        ['torso2'] = 11,
    }
    local props = {
        ['hat'] = 0,
        ['glass'] = 1,
        ['ear'] = 2,
        ['watch'] = 6,
        ['bracelet'] = 7
    }
    if (clothes) then
        for index, value in pairs(clothes) do
            if (components[index]) then
                SetPedComponentVariation(ped, components[index], value[1], value[2], 2)
            end
        end
        for index, value in pairs(clothes) do
            if (props[index]) then
                SetPedPropIndex(ped, props[index], value[1], value[2], 2)
            end
        end
    end
end

cli.loadingPlayer = function(stats)
    local ped = PlayerPedId()
    SetEntityVisible(ped, stats)
    FreezeEntityPosition(ped, (not stats))
end

RegisterNuiCallback('changeCharacter', function(data)
    local ped = PlayerPedId()

    -- IDENTITY
    identity.firstname = data.name
    identity.lastname = data.surname
    identity.age = data.age

    -- GENDER
    currentCharacter.gender = data.gender
    if (currentGender ~= data.gender) then
        currentGender = data.gender
        if (data.gender == 'masculino') then setGender('male'); else setGender('female'); end;
    end

    -- PARENTES
    currentCharacter.gender = data.gender
    currentCharacter.fatherId = data.fatherId 
    currentCharacter.motherId = data.motherId
    currentCharacter.colorMother = data.colorMother
    currentCharacter.colorFather = data.colorFather
    currentCharacter.shapeMix = data.shapeMix 
    currentCharacter.skinMix = data.skinMix
    SetPedHeadBlendData(ped, data.fatherId , data.motherId, 0, data.colorMother, data.colorFather, 0, data.shapeMix, data.skinMix, 0, false)

    -- OLHOS
    currentCharacter.eyesColor = data.eyesColor
    currentCharacter.eyesOpening = data.eyesOpening
    currentCharacter.eyebrowsHeight = data.eyebrowsHeight
    currentCharacter.eyebrowsWidth = data.eyebrowsWidth
    currentCharacter.eyebrowsModel = data.eyebrowsModel
    currentCharacter.eyebrowsOpacity = data.eyebrowsOpacity
    currentCharacter.eyebrowsColor = data.eyebrowsColor
    SetPedEyeColor(ped, data.eyesColor)
    SetPedFaceFeature(ped, 11, data.eyesOpening)
    SetPedFaceFeature(ped, 6, data.eyebrowsHeight)
	SetPedFaceFeature(ped, 7, data.eyebrowsWidth)
    SetPedHeadOverlay(ped, 2, data.eyebrowsModel, (data.eyebrowsOpacity or 0.99))
    SetPedHeadOverlayColor(ped, 2, 1, data.eyebrowsColor, data.eyebrowsColor)

    -- Nariz
    currentCharacter.noseWidth = data.noseWidth 
    currentCharacter.noseHeight = data.noseHeight  
    currentCharacter.noseLength = data.noseLength  
    currentCharacter.noseBridge = data.noseBridge  
    currentCharacter.noseTip = data.noseTip  
    currentCharacter.noseShift = data.noseShift 
    SetPedFaceFeature(ped, 0, data.noseWidth)
    SetPedFaceFeature(ped, 1, data.noseHeight)
    SetPedFaceFeature(ped, 2, data.noseLength)
    SetPedFaceFeature(ped, 3, data.noseBridge)
    SetPedFaceFeature(ped, 4, data.noseTip)
    SetPedFaceFeature(ped, 5, data.noseShift)

    -- BOCHECHAS
    currentCharacter.cheekboneHeight = data.cheekboneHeight
    currentCharacter.cheekboneWidth = data.cheekboneWidth
    currentCharacter.cheeksWidth = data.cheeksWidth
    SetPedFaceFeature(ped, 8, data.cheekboneHeight)
    SetPedFaceFeature(ped, 9, data.cheekboneWidth)
    SetPedFaceFeature(ped, 10, data.cheeksWidth)

    -- BOCA/MANDIBULA
    currentCharacter.lips = data.lips
    currentCharacter.jawWidth = data.jawWidth
    currentCharacter.jawHeight = data.jawHeight
    SetPedFaceFeature(ped, 12, data.lips)
    SetPedFaceFeature(ped, 13, data.jawWidth)
    SetPedFaceFeature(ped, 14, data.jawHeight)

    -- QUEIXO
    currentCharacter.chinLength = data.chinLength
    currentCharacter.chinPosition = data.chinPosition
    currentCharacter.chinWidth = data.chinWidth
    currentCharacter.chinShape = data.chinShape
    SetPedFaceFeature(ped, 15, data.chinLength)
    SetPedFaceFeature(ped, 16, data.chinPosition)
    SetPedFaceFeature(ped, 17, data.chinWidth)
    SetPedFaceFeature(ped, 18, data.chinShape)

    -- CABELO
    currentCharacter.hairModel = data.hairModel
    currentCharacter.firstHairColor = data.firstHairColor
    currentCharacter.secondHairColor = data.secondHairColor
    SetPedComponentVariation(ped, 2, data.hairModel, 0, 0)
    SetPedHairColor(ped, data.firstHairColor, data.secondHairColor)
    
    -- BARBA
    currentCharacter.beardModel = data.beardModel
    currentCharacter.beardColor = data.beardColor
    currentCharacter.beardOpacity = data.beardOpacity
    SetPedHeadOverlay(ped, 1, data.beardModel, (data.beardOpacity or 0.99))
    SetPedHeadOverlayColor(ped, 1, 1, data.beardColor, data.beardColor)

    -- PELO CORPORAL
    currentCharacter.chestModel = data.chestModel
    currentCharacter.chestColor = data.chestColor
    currentCharacter.chestOpacity = data.chestOpacity
    SetPedHeadOverlay(ped, 10, data.chestModel, (data.chestOpacity or 0.99))
    SetPedHeadOverlayColor(ped, 10, 1, data.chestColor, data.chestColor)

    -- BLUSH
    currentCharacter.blushModel = data.blushModel
    currentCharacter.blushColor = data.blushColor
    currentCharacter.blushOpacity = data.blushOpacity
    SetPedHeadOverlay(ped, 5, data.blushModel, (data.blushOpacity or 0.99))
    SetPedHeadOverlayColor(ped, 5, 1, data.blushColor, data.blushColor)

    -- BATTOM
    currentCharacter.lipstickModel = data.lipstickModel
    currentCharacter.lipstickColor = data.lipstickColor
    currentCharacter.lipstickOpacity = data.lipstickOpacity
    SetPedHeadOverlay(ped, 8, data.lipstickModel, (data.lipstickOpacity or 0.99))
    SetPedHeadOverlayColor(ped, 8, 1, data.lipstickColor, data.lipstickColor)

    -- MANCHAS
    currentCharacter.blemishesModel = data.blemishesModel
    currentCharacter.blemishesOpacity = data.blemishesOpacity
    SetPedHeadOverlay(ped, 0, data.blemishesModel, (data.blemishesOpacity or 0.99))
    SetPedHeadOverlayColor(ped, 0, 0, 0, 0)

    -- ENVELHECIMENTO
    currentCharacter.ageingModel = data.ageingModel
    currentCharacter.ageingOpacity = data.ageingOpacity
    SetPedHeadOverlay(ped, 3, data.ageingModel, (data.ageingOpacity or 0.99))
    SetPedHeadOverlayColor(ped, 3, 0, 0, 0)

    -- ASPECTO
    currentCharacter.complexionModel = data.complexionModel
    currentCharacter.complexionOpacity = data.complexionOpacity
    SetPedHeadOverlay(ped, 6, data.complexionModel, (data.complexionOpacity or 0.99))
    SetPedHeadOverlayColor(ped, 6, 0, 0, 0)

    -- PELE
    currentCharacter.sundamageModel = data.sundamageModel
    currentCharacter.sundamageOpacity = data.sundamageOpacity
    SetPedHeadOverlay(ped, 7, data.sundamageModel, (data.sundamageOpacity or 0.99))
    SetPedHeadOverlayColor(ped, 7, 0, 0, 0)

    -- SARDAS
    currentCharacter.frecklesModel = data.frecklesModel
    currentCharacter.frecklesOpacity = data.frecklesOpacity
    SetPedHeadOverlay(ped, 9, data.frecklesModel, (data.frecklesOpacity or 0.99))
    SetPedHeadOverlayColor(ped, 9, 0, 0, 0)

    -- MAQUIAGEM
    currentCharacter.makeupModel = data.makeupModel
    currentCharacter.makeupOpacity = data.makeupOpacity
    SetPedHeadOverlay(ped, 4, data.makeupModel, (data.makeupOpacity or 0.99))
    SetPedHeadOverlayColor(ped, 4, 0, 10, 15)
end)

RegisterNuiCallback('changePov', function(data)
    local newPov = data.pov
    local newHeading = (data.rotate + 0.00)
    
    SetEntityHeading(PlayerPedId(), newHeading)
    if (atualCam ~= newPov) then 
        DeleteCam()
        createCam(newPov)
    end
end)

RegisterNuiCallback('finish', function(data)
    if (vSERVER.verifyIdentity(identity)) then
        SetNuiFocus(false, false)
        vSERVER.saveCharacter(currentCharacter)
        SendNUIMessage({ action = 'close' })
        finishCreator()
    end
end)

finishCreator = function()
    vSERVER.changeSession(0)
    local ped = PlayerPedId()

    TriggerEvent('zero_weather:staticTime', false)
    Citizen.Wait(1000)
    DoScreenFadeOut(500)
    SetEntityHealth(ped, 200)
    FreezeEntityPosition(ped, false)
    
    DeleteCam(true)
    finishClothes()
    TriggerEvent('introCinematic:start')
    Citizen.Wait(1000)
    DoScreenFadeIn(500)
end

tempCam = nil
Cam = function(offset, bone)
    if (not DoesCamExist(tempCam)) then
        local ped = PlayerPedId()
        local coordsCam = GetOffsetFromEntityInWorldCoords(ped, offset.x, offset.y, offset.z)
        
        tempCam = CreateCam('DEFAULT_SCRIPTED_CAMERA')
        SetCamCoord(tempCam, coordsCam)
        Citizen.SetTimeout(1000, callbafck)
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