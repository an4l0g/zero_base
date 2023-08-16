vSERVER = Tunnel.getInterface(GetCurrentResourceName())

Citizen.CreateThread(function()
	if (not LocalPlayer.state.spawned) then
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

        local spawnCoords = vector4(724.9, 1200.53, 326.16,161.57479858398)
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
		LocalPlayer.state.spawned = true
	end
end)

RegisterNetEvent('zero_spawn:selector', function(bool)
    ShutdownLoadingScreenNui()
	ShutdownLoadingScreen()
	DoScreenFadeIn(500)
	while (IsScreenFadingIn()) do
		Citizen.Wait(1)
	end

    local ped = PlayerPedId()
    if (bool) then
        SetEntityVisible(ped, false)
        FreezeEntityPosition(ped, true)

        SetNuiFocus(true, true)
        SendNUIMessage({
            action = 'open',
            listSpawns = config.spawns
        })
    else
        LocalPlayer.state.spawnSelected = true
    end
end)

RegisterNuiCallback('setSpawn', function(data)
    local index = data.index
    if (index) then
        local ped = PlayerPedId()

        DoScreenFadeOut(3000)
		Citizen.Wait(3000)

        if (index ~= 'lastLocation') then
            SetEntityCoords(ped, config.spawns[index].coord.xyz)
            SetEntityHeading(ped, config.spawns[index].coord.w)
        else
            local coord = vSERVER.getLastPosition()
            SetEntityCoords(ped, coord)
        end

        DoScreenFadeIn(3000)
        SetEntityVisible(ped, true)
        FreezeEntityPosition(ped, false)
        SetNuiFocus(false, false)
        
        LocalPlayer.state.spawnSelected = true
    end
end)

RegisterNuiCallback('close', function()
    SetNuiFocus(false, false)
end)
