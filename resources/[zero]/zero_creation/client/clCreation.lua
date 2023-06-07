cli = {}
Tunnel.bindInterface('Creation', cli)
vSERVER = Tunnel.getInterface('Creation')

local generalConfig = config.general

local float = function(number)
	number = (number + 0.00000)
	return number
end

local atualCam = ''
local tempCam = nil
local cameras = {
    ['body'] = {
        ['coords'] = vector3(generalConfig['spawnCreator']['x']-1, generalConfig['spawnCreator']['y']+0.9, generalConfig['spawnCreator']['z']),
        ['heading'] = function()
            local ped = PlayerPedId()
            SetEntityHeading(ped, (generalConfig['spawnCreator'].w - 20))
        end,
        ['anim'] = function()
            freezeAnim('move_f@multiplayer', 'idle')
        end
    },
    ['head'] = {
        ['coords'] = vector3(generalConfig['spawnCreator']['x']-0.7, generalConfig['spawnCreator']['y']+0.7, generalConfig['spawnCreator']['z']),
        ['heading'] = function()
            local ped = PlayerPedId()
            SetEntityHeading(ped, (generalConfig['spawnCreator'].w - 20.0))
        end,      
        ['anim'] = function()
            freezeAnim('mp_sleep', 'bind_pose_180', 1, true)
        end
    },
}

local createCam = function(cameraName)
    atualCam = cameraName
    ClearFocus()

    local ped = PlayerPedId()
    local cam = cameras[cameraName]
    local x, y, z = (cameras[cameraName]['coords']['x']), (cameras[cameraName]['coords']['y']), (cameras[cameraName]['coords']['z']+0.52)

    tempCam = CreateCamWithParams('DEFAULT_SCRIPTED_CAMERA', vector3(x, y, z), (vector3(0, -0, 70.86614) + vector3(0.0, 0.0, 180)), GetGameplayCamFov())
    SetCamActive(tempCam, true)
    RenderScriptCams(true, true, 1000, true, false)

    if (cam['anim']) then cam['anim']() end
    if (cam['heading']) then cam['heading']() end
end

local deleteCam = function()
    SetCamActive(tempCam, false)
    RenderScriptCams(false, true, 0, true, true)
	tempCam = nil
end

local getCharacterDrawable = function(part)
    local ped = PlayerPedId()
	if part == 12 then
		return tonumber(GetNumberOfPedDrawableVariations(ped, 2))
	elseif part == -1 then
		return tonumber(GetNumberOfPedDrawableVariations(ped, 0))
	elseif part == -2 then
		return 64
	else
		return tonumber(GetNumHeadOverlayValues(part))
	end
end

Citizen.CreateThread(function()
    cli.createCharacter()
end)

cli.createCharacter = function()
    initCreator()
    cli.loadingPlayer(true)
    if (not DoesCamExist(cam)) then
        createCam('body')
    end
    FreezeEntityPosition(PlayerPedId(), true)
    SetNuiFocus(true, true)
    SendNUIMessage({ action = 'open' })
end

resetClothes = function()
    local clothes = {
        [GetHashKey('mp_m_freemode_01')] = {
            ['gender'] = 'male',
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
            ['gender'] = 'female',
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
        },
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
        SetPedDefaultComponentVariation(ped)
	    ClearAllPedProps(ped)
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

local identity = {
    firstname = 'Individuo',
    lastname = 'Indigente',
    age = 18
}

local currentCharacter = { 
    -- INICIO
    gender = 'masculino',
    fatherId = 0, 
    motherId = 21,
    colorMother = 0, 
    colorFather = 0,  
    shapeMix = 0, 
    skinMix = 0,

    -- OLHOS
    eyesColor = 0,
    eyesOpening = 0,
    eyebrowsHeight = 0,
    eyebrowsWidth = 0,
    eyebrowsModel = 0,
    eyebrowsColor = 0,
    eyebrowsOpacity = 0.99,

    -- NARIZ
    noseWidth = 0, 
    noseHeight = 0, 
    noseLength = 0, 
    noseBridge = 0, 
    noseTip = 0, 
    noseShift = 0, 

    -- BOCHECHAS
    cheekboneHeight = 0, 
    cheekboneWidth = 0, 
    cheeksWidth = 0, 

    -- BOCA
    lips = 0, 
    jawWidth = 0, 
    jawHeight = 0, 

    -- Queixo
    chinLength = 0, 
    chinPosition = 0, 
    chinWidth = 0, 
    chinShape = 0, 

    -- Pescoço
    neckWidth = 0, 

    -- Cabelo
    hairModel = 4, 
    firstHairColor = 0, 
    secondHairColor = 0, 

    -- Barba
    beardModel = -1, 
    beardColor = 0, 
    beardOpacity = 0.99,

    -- Pelo Corporal
    chestModel = -1, 
    chestColor = 0, 
    chestOpacity = 0.99,

    -- Blush
    blushModel = -1, 
    blushColor = 0, 
    blushOpacity = 0.99,

    -- Batom
    lipstickModel = -1, 
    lipstickColor = 0, 
    lipstickOpacity = 0.99,

    -- Manchas
    blemishesModel = -1, 
    blemishesOpacity = 0.99,

    -- Envelhecimento
    ageingModel = -1, 
    ageingOpacity = 0.99,

    -- Aspecto
    complexionModel = -1, 
    complexionOpacity = 0.99,

    -- Pele
    sundamageModel = -1, 
    sundamageOpacity = 0.99,

    -- Sardas
    frecklesModel = -1, 
    frecklesOpacity = 0.99,

    -- Maquiage
    makeupModel = -1,
    makeupOpacity = 0.99,
}

local atualGender = 'masculino'

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

        local currentHealth, currentMaxHealth, currentArmour = GetEntityHealth(ped), GetPedMaxHealth(ped), GetPedArmour(ped)
        SetPedMaxHealth(ped, generalConfig['maxHealth'])
        SetEntityHealth(ped, currentHealth)
        SetPedArmour(ped, currentArmour)
    end

    local weapons = (vRP.getWeapons() or {})
    -- vRP.giveWeapons(weapons, true)

    resetClothes()

    if (gender == 'male') then
        SetPedHeadBlendData(ped, 21, 0, 0, 21, 0, 0, 0.8, 0.8, 0.0, false)
    else
        SetPedHeadBlendData(ped, 21, 0, 0, 21, 0, 0, 0.2, 0.2, 0.0, false)
    end
end

initCreator = function()
    local ped = PlayerPedId()
    TriggerEvent('zero_weather:staticTime', { weather = 'EXTRASUNNY', hours = 14, minutes = 0 })
    TriggerEvent('zero_hud:toggleHud', false)
    vSERVER.changeSession(GetPlayerServerId(PlayerId()))
    DoScreenFadeOut(500)
    Citizen.Wait(500)
    teleport(ped, generalConfig['spawnCreator'].xyz)
    SetEntityHeading(ped, generalConfig['spawnCreator'].w)
    SetEntityHealth(ped, GetPedMaxHealth(ped))
    setGender('male') 
    SetEntityHealth(ped, GetPedMaxHealth(ped))  
    SetFacialIdleAnimOverride(ped, 'pose_normal_1', 0)
    Citizen.Wait(1000)
    DoScreenFadeIn(1000)
end

finishCreator = function()
    local ped = PlayerPedId()
    TriggerEvent('zero_weather:staticTime', false)
    TriggerEvent('zero_hud:toggleHud', true)
    DoScreenFadeOut(500)
    Citizen.Wait(1500)
    TriggerEvent('introCinematic:start')
    teleport(ped, generalConfig.spawnAfterCreator.xyz)
    SetEntityHeading(ped, generalConfig.spawnAfterCreator.w)
    SetEntityHealth(ped, GetPedMaxHealth(ped))
    FreezeEntityPosition(ped, false)
    vSERVER.changeSession(0)
    deleteCam()
    Citizen.Wait(1000)
    DoScreenFadeIn(1000)
end

cli.loadingPlayer = function(stats)
    local ped = PlayerPedId()
    SetEntityInvincible(ped, false) -- MQCU
    SetEntityVisible(ped, stats)
    FreezeEntityPosition(ped, (not stats))
end

LoadAnim = function(dict)
    while (not HasAnimDictLoaded(dict)) do
        RequestAnimDict(dict)
        Citizen.Wait(10)
    end
end

freezeAnim = function(dict, anim, flag, keep)
    local ped = PlayerPedId()
    if (not keep) then ClearPedTasks(ped) end
    LoadAnim(dict)
    TaskPlayAnim(ped, dict, anim, 2.0, 2.0, -1, flag or 1, 0, false, false, false)
    RemoveAnimDict(dict)
end

teleport = function(ped, x, y, z)
    if (type(x) == 'vector3') then x, y, z = table.unpack(x) end
    FreezeEntityPosition(ped, true)
    SetEntityCoords(ped, x + 0.0001, y + 0.0001, z + 0.0001, 1, 0, 0, 1)
    while (not HasCollisionLoadedAroundEntity(ped)) do
        FreezeEntityPosition(ped, true)
        SetEntityCoords(ped, x + 0.0001, y + 0.0001, z + 0.0001, 1, 0, 0, 1)
        RequestCollisionAtCoord(x, y, z)
        Citizen.Wait(500)
    end
    SetEntityCoords(ped, x + 0.0001, y + 0.0001, z + 0.0001, 1, 0, 0, 1)
    FreezeEntityPosition(ped, false)
    Citizen.Wait(1000)
end

RegisterNuiCallback('changeCharacter', function(data)
    local ped = PlayerPedId()

    -- IDENTITY
    identity.firstname = data.name
    identity.lastname = data.surname
    identity.age = data.age

    -- GENDER
    currentCharacter.gender = data.gender
    if (atualGender ~= data.gender) then
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
    
    -- BARBAR
    currentCharacter.beardModel = data.beardModel
    currentCharacter.beardColor = data.beardColor
    currentCharacter.beardOpacity = data.beardOpacity
    SetPedHeadOverlay(ped, 1, data.beardModel, (data.beardOpacity or 0.99))
    SetPedHeadOverlayColor(ped, 1, 1, data.beardColor, data.beardColor)

    -- PELO CORPORAL
    currentCharacter.chestModel = data.chestModel
    currentCharacter.chestColor = data.chestColor
    currentCharacter.chestColor = data.chestOpacity
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
    if (atualCam ~= newPov) then deleteCam(); createCam(newPov); end;
end)

RegisterNuiCallback('finish', function(data)
    SetNuiFocus(false, false)
    if (vSERVER.verifyName(identity.firstname, identity.lastname)) then
        vSERVER.saveIdentity(identity)
        vSERVER.saveCharacter(currentCharacter)
        finishCreator()
    end
end)