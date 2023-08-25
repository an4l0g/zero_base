vSERVER = Tunnel.getInterface(GetCurrentResourceName())

local cam = nil

Citizen.CreateThread(function()
    SetNuiFocus(false, false)
    TriggerScreenblurFadeOut(0)
	if (not LocalPlayer.state.spawned) then
		local ped = PlayerPedId()
        local pCoord = GetEntityCoords(ped)

        SetEntityVisible(ped, false)
        SetEntityCollision(ped, false)
        FreezeEntityPosition(ped, true)
        SetPlayerInvincible(PlayerId(), true)

        local model = GetHashKey('mp_m_freemode_01')
		RequestModel(model)
		while not HasModelLoaded(model) do
			RequestModel(model)
			Citizen.Wait(0)
		end
		SetPlayerModel(PlayerId(), model)
		SetModelAsNoLongerNeeded(model)
        
        ped = PlayerPedId()

		RequestCollisionAtCoord(pCoord.x, pCoord.y, pCoord.z)
        SetEntityCoordsNoOffset(ped, pCoord.x, pCoord.y, pCoord.z, false, false, false, true)
        NetworkResurrectLocalPlayer(pCoord.x, pCoord.y, pCoord.z, GetEntityHeading(ped), true, true, false)

		SetPedDefaultComponentVariation(ped)
        ClearPedTasksImmediately(ped)
        RemoveAllPedWeapons(ped)

        local time = GetGameTimer()
        while (not HasCollisionLoadedAroundEntity(ped) and (GetGameTimer() - time) < 5000) do
            Citizen.Wait(0)
        end

        SetEntityCollision(ped, true)
        FreezeEntityPosition(ped, true)
        SetEntityVisible(ped, true)

        ShutdownLoadingScreenNui()
        ShutdownLoadingScreen()
        DoScreenFadeIn(500)
        while (IsScreenFadingIn()) do
            Citizen.Wait(1)
        end

        SetBigmapActive(true, false)
	    SetBigmapActive(false, false)

        TriggerEvent('playerSpawned')
		LocalPlayer.state.spawned = true
	end
end)

RegisterNetEvent('zero_spawn:selector', function(bool)
    local ped = PlayerPedId()
    local pCoord = GetEntityCoords(ped)

    if (not DoesCamExist(cam)) then
        cam = CreateCam('DEFAULT_SCRIPTED_CAMERA')
        SetCamCoord(cam, pCoord.x, pCoord.y, pCoord.z + 5000.0)
        SetCamActive(cam, true)
        RenderScriptCams(true, true, 500, true, true)
    end

    if (bool) then
        SetNuiFocus(true, true)
        SendNUIMessage({
            action = 'open',
            listSpawns = config.spawns
        })
    else
        if (DoesCamExist(cam)) then
            SetCamActive(cam, false)
            RenderScriptCams(false, true, 5000, true, true)
	        cam = nil
        end

        FreezeEntityPosition(ped, false)
        SetPlayerInvincible(PlayerId(), false)
        SetNuiFocus(false, false)
                
        LocalPlayer.state.spawnSelected = true
    end
end)

RegisterNuiCallback('setSpawn', function(data)
    local index = data.index
    if (index) then
        local ped = PlayerPedId()

        SetNuiFocus(false, false)
        DoScreenFadeOut(500)
		Citizen.Wait(1500)

        if (index ~= 'lastLocation') then
            SetEntityCoords(ped, config.spawns[index].coord.xyz)
            SetEntityHeading(ped, config.spawns[index].coord.w)
        else
            local coord = vSERVER.getLastPosition()
            SetEntityCoords(ped, coord)
        end

        Citizen.Wait(1000)
        DoScreenFadeIn(500)

        if (DoesCamExist(cam)) then
            SetCamActive(cam, false)
            RenderScriptCams(false, true, 5000, true, true)
	        cam = nil
        end

        FreezeEntityPosition(ped, false)
        SetPlayerInvincible(PlayerId(), false)
        
        LocalPlayer.state.spawnSelected = true
    end
end)

RegisterNuiCallback('close', function()
    SetNuiFocus(false, false)

    local ped = PlayerPedId()

    -- DoScreenFadeOut(500)
    -- Citizen.Wait(1500)

    local coord = vSERVER.getLastPosition()
    SetEntityCoords(ped, coord)

    -- Citizen.Wait(1000)
    -- DoScreenFadeIn(500)

    if (DoesCamExist(cam)) then
        SetCamActive(cam, false)
        RenderScriptCams(false, true, 5000, true, true)
        cam = nil
    end

    FreezeEntityPosition(ped, false)
    SetPlayerInvincible(PlayerId(), false)
    SetNuiFocus(false, false)
            
    LocalPlayer.state.spawnSelected = true
end)