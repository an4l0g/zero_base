cli = {}
Tunnel.bindInterface(GetCurrentResourceName(), cli)
vSERVER = Tunnel.getInterface(GetCurrentResourceName())

local generalConfig = config.general

local float = function(number)
	number = (number + 0.00000)
	return number
end

local tempCam = nil

local cameras = {
    ['body'] = {
        ['coords'] = vector3(generalConfig['spawnCreator']['x']-1.2, generalConfig['spawnCreator']['y']+0.4, generalConfig['spawnCreator']['z']),
        ['anim'] = function()
            freezeAnim('move_f@multiplayer', 'idle')
        end
    },
    ['head'] = {
        ['coords'] = vector3(generalConfig['spawnCreator']['x']+0.5, generalConfig['spawnCreator']['y']-0.18, generalConfig['spawnCreator']['z']+0.15),
        ['anim'] = function()
            freezeAnim('mp_sleep', 'bind_pose_180', 1, true)
        end
    },
    ['eye'] = {
        ['coords'] = vector3(generalConfig['spawnCreator']['x']+0.85, generalConfig['spawnCreator']['y']-0.3, generalConfig['spawnCreator']['z']+0.17),
        ['anim'] = function()
            freezeAnim('mp_sleep', 'bind_pose_180', 1, true)
        end
    },
    ['mouth'] = {
        ['coords'] = vector3(generalConfig['spawnCreator']['x']+0.85, generalConfig['spawnCreator']['y']-0.3, generalConfig['spawnCreator']['z']+0.12),
        ['anim'] = function()
            freezeAnim('mp_sleep', 'bind_pose_180', 1, true)
        end
    },
    ['chest'] = {
        ['coords'] = vector3(generalConfig['spawnCreator']['x']+0.1, generalConfig['spawnCreator']['y']-0.05, generalConfig['spawnCreator']['z']-0.2),
        ['anim'] = function()
            freezeAnim('mp_sleep', 'bind_pose_180', 1, true)
        end
    }
}

local createCam = function(cameraName)
    ClearFocus()

    local ped = PlayerPedId()
    local cam = cameras[cameraName]
    local x, y, z = (cameras[cameraName]['coords']['x'] + GetEntityForwardX(ped) * 1.2), (cameras[cameraName]['coords']['y'] + GetEntityForwardY(ped) * 1.2), (cameras[cameraName]['coords']['z'] + 0.52)
    
    tempCam = CreateCamWithParams('DEFAULT_SCRIPTED_CAMERA', vector3(x, y, z), (GetEntityRotation(ped, 2) + vector3(0.0, 0.0, 180)), GetGameplayCamFov())
    SetCamActive(tempCam, true)
    RenderScriptCams(true, true, 1000, true, false)

    if (cam['anim']) then cam['anim']() end
end

cli.createCharacter = function()
    initCreator()
    cli.loadingPlayer(true)
    if (not DoesCamExist(cam)) then
        createCam('body')
    end
    FreezeEntityPosition(PlayerPedId(), true)
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

local currentCharacter = { 
    -- INICIO
    gender = 1,
    fatherId = 0, 
    motherId = 21,
    colorMother = 0, 
    colorFather = 0,  
    shapeMix = 0, 
    skinMix = 0,

    --

    eyesColor = 0, 
    eyebrowsHeight = 0, 
    eyebrowsWidth = 0, 
    noseWidth = 0, 
    noseHeight = 0, 
    noseLength = 0, 
    noseBridge = 0, 
    noseTip = 0, 
    noseShift = 0, 
    cheekboneHeight = 0, 
    cheekboneWidth = 0, 
    cheeksWidth = 0, 
    lips = 0, 
    jawWidth = 0, 
    jawHeight = 0, 
    chinLength = 0, 
    chinPosition = 0, 
    chinWidth = 0, 
    chinShape = 0, 
    neckWidth = 0, 
    hairModel = 4, 
    firstHairColor = 0, 
    secondHairColor = 0, 
    eyebrowsModel = 0, 
    eyebrowsColor = 0, 
    beardModel = -1, 
    beardColor = 0, 
    chestModel = -1, 
    chestColor = 0, 
    blushModel = -1, 
    blushColor = 0, 
    lipstickModel = -1, 
    lipstickColor = 0, 
    blemishesModel = -1, 
    ageingModel = -1, 
    complexionModel = -1, 
    sundamageModel = -1, 
    frecklesModel = -1, 
    makeupModel = -1 
}

local setGender = function(gender)    
    currentCharacter['gender'] = gender

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
    TriggerEvent('s9_hud:toggleHud', false)
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

RegisterNUICallback('changeHeading', function(data, callback)
    local ped = PlayerPedId()
    if (data['left']) then
        SetEntityHeading(ped, (GetEntityHeading(ped) - 10.0))
    elseif (data['right']) then
        SetEntityHeading(ped, (GetEntityHeading(ped) + 10.0))
    end
end)

-----------------------------------------------------------
-- ALTERAR GENÊRO
-----------------------------------------------------------
-- RegisterNUICallback('changeGender', function(data, callback)
--     currentCharacter['gender'] = data['gender']
--     if (data['gender'] == 1) then
--         setGender('male')
--     else
--         setGender('female')
--     end
--     updateSkin()
--     callback('ok')
-- end)

-----------------------------------------------------------
-- ALTERAR PAIS
-----------------------------------------------------------
RegisterNUICallback('changeParent', function(data, callback)
    if (data['fatherId']) then currentCharacter['fatherId'] = data['fatherId'] end
    if (data['motherId']) then currentCharacter['motherId'] = data['motherId'] end
    updateSkin()
    callback('ok')
end)

updateSkin = function()
    local data = currentCharacter
    SetPedHeadBlendData(PlayerPedId(), data['fatherId'], data['motherId'], 0, data['colorMother'], data['colorFather'], 0, data['shapeMix'], data['skinMix'], 0, false)
end

function TaskUpdateFaceOptions()
	local ped = PlayerPedId()
	local data = currentCharacterMode

	-- Olhos
	SetPedEyeColor(ped,data.eyesColor)
	-- Sobrancelha
	SetPedFaceFeature(ped,6,data.eyebrowsHeight)
	SetPedFaceFeature(ped,7,data.eyebrowsWidth)
	-- Nariz
	SetPedFaceFeature(ped,0,data.noseWidth)
	SetPedFaceFeature(ped,1,data.noseHeight)
	SetPedFaceFeature(ped,2,data.noseLength)
	SetPedFaceFeature(ped,3,data.noseBridge)
	SetPedFaceFeature(ped,4,data.noseTip)
	SetPedFaceFeature(ped,5,data.noseShift)
	-- Bochechas
	SetPedFaceFeature(ped,8,data.cheekboneHeight)
	SetPedFaceFeature(ped,9,data.cheekboneWidth)
	SetPedFaceFeature(ped,10,data.cheeksWidth)
	-- Boca/Mandibula
	SetPedFaceFeature(ped,12,data.lips)
	SetPedFaceFeature(ped,13,data.jawWidth)
	SetPedFaceFeature(ped,14,data.jawHeight)
	-- Queixo
	SetPedFaceFeature(ped,15,data.chinLength)
	SetPedFaceFeature(ped,16,data.chinPosition)
	SetPedFaceFeature(ped,17,data.chinWidth)
	SetPedFaceFeature(ped,18,data.chinShape)
	-- Pescoço
	SetPedFaceFeature(ped, 19, data.neckWidth)
end

local spawnCoords = vector4(724.9, 1200.53, 326.16,161.57479858398)

Citizen.CreateThread(function()
	SetNuiFocus(false, false)
    TriggerScreenblurFadeOut(0)
	if not LocalPlayer.state.spawned then

		local ped = PlayerPedId()

        SetEntityVisible(ped, false)
        SetEntityCollision(ped, false)
        FreezeEntityPosition(ped, true)

        local model = GetHashKey('mp_m_freemode_01')
		RequestModel(model)
		while not HasModelLoaded(model) do
			RequestModel(model)
			Citizen.Wait(0)
		end
		SetPlayerModel(PlayerId(), model)
		SetModelAsNoLongerNeeded(model)
        
        ped = PlayerPedId()

		RequestCollisionAtCoord(spawnCoords.x, spawnCoords.y, spawnCoords.z)
        SetEntityCoordsNoOffset(ped, spawnCoords.x, spawnCoords.y, spawnCoords.z, false, false, false, true)
        NetworkResurrectLocalPlayer(spawnCoords.x, spawnCoords.y, spawnCoords.z, spawnCoords.w, true, true, false)

		SetPedDefaultComponentVariation(ped)
        ClearPedTasksImmediately(ped)
        RemoveAllPedWeapons(ped)

        local time = GetGameTimer()
        while (not HasCollisionLoadedAroundEntity(ped) and (GetGameTimer() - time) < 5000) do
            Citizen.Wait(0)
        end

        SetEntityVisible(ped, true)
        SetEntityCollision(ped, true)
        FreezeEntityPosition(ped, false)
        SetPlayerInvincible(PlayerId(), false)

        TriggerEvent('playerSpawned',{})
		LocalPlayer.state.spawned = true
	else
		print("Ready spawned? Report to Developers.")
	end
end)

RegisterNetEvent('zero:SpawnSelector', function(select)

	ShutdownLoadingScreenNui()
	ShutdownLoadingScreen()
	DoScreenFadeIn(500)
	while IsScreenFadingIn() do
		Citizen.Wait(1)
	end

	if select then

		local ped = PlayerPedId()
		local coords = GetEntityCoords(ped)

		cam = CreateCamWithParams('DEFAULT_SCRIPTED_CAMERA',coords['x'],coords['y'],coords['z'] + 200.0,270.00,0.0,0.0,80.0,0,0)
		SetCamActive(cam,true)
		RenderScriptCams(true, false, 1, true, true)

		SetEntityVisible(ped, false)
		FreezeEntityPosition(ped, false)

		SetNuiFocus(true, true)
		TriggerScreenblurFadeIn(0)
		SendNUIMessage({ method = 'open' })

	else
		LocalPlayer.state.spawnSelected = true
	end
end)

RegisterNUICallback('lastLocation', function()
	local lastLocation = vSERVER.getLastPosition()
	if lastLocation then
		DoScreenFadeOut(3000)
		Citizen.Wait(3000)
		SetEntityCoords(PlayerPedId(), lastLocation, 0, 0, 0, 0)

		renderFunction()

		DoScreenFadeIn(3000)
		closeNui()
		LocalPlayer.state.spawnSelected = true
	end
end)

RegisterNUICallback('selectSpawn', function(data)
	local ped = PlayerPedId()
	local location = data['location']
	if location then
		local dataLoc = generalConfig['spawnLocations'][location]
		if dataLoc then
			if vSERVER.spawnPermission(dataLoc['permission']) then
				DoScreenFadeOut(3000)
				Citizen.Wait(3000)
				SetEntityCoords(ped, dataLoc['coord'].x, dataLoc['coord'].y, dataLoc['coord'].z, 0, 0, 0, 0)
				SetEntityHeading(ped, dataLoc['coord'].w)
				
				renderFunction()

				DoScreenFadeIn(3000)
				closeNui()
				LocalPlayer.state.spawnSelected = true
			else
				SendNUIMessage({ method = 'open' })
			end
		end
	end
end)

renderFunction = function()
	local ped = PlayerPedId()
	RenderScriptCams(false, false, 0, true, true)
	SetEntityVisible(ped, true, false)
	FreezeEntityPosition(ped, false)
	SetCamActive(cam, false)
	DestroyCam(cam, true)
	cam = nil
end

freezePlayer = function(id, freeze)
    local player = id
    SetPlayerControl(player, not freeze, false)
    local ped = GetPlayerPed(player)
    if not freeze then
        if not IsEntityVisible(ped) then
            SetEntityVisible(ped, true)
        end
        if not IsPedInAnyVehicle(ped) then
            SetEntityCollision(ped, true)
        end
        FreezeEntityPosition(ped, false)
        SetPlayerInvincible(player, false)
    else
        if IsEntityVisible(ped) then
            SetEntityVisible(ped, false)
        end
        SetEntityCollision(ped, false)
        FreezeEntityPosition(ped, true)
        SetPlayerInvincible(player, true)
        if not IsPedFatallyInjured(ped) then
            ClearPedTasksImmediately(ped)
        end
    end
end

closeNui = function()
	SetNuiFocus(false, false)
    TriggerScreenblurFadeOut(0)
end