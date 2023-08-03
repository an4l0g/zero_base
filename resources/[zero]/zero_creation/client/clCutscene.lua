local pedsList = {
    [0] = 'MP_Plane_Passenger_1',
    [1] = 'MP_Plane_Passenger_2',
    [2] = 'MP_Plane_Passenger_3',
    [3] = 'MP_Plane_Passenger_4',
    [4] = 'MP_Plane_Passenger_5',
    [5] = 'MP_Plane_Passenger_6',
    [6] = 'MP_Plane_Passenger_7'
}

local ComponentsTypes = { 
    [0] = { 
        [0] = 21, 
        [1] = 13, 
        [2] = 15, 
        [3] = 14, 
        [4] = 18, 
        [5] = 27, 
        [6] = 16 
    },
    [1] = { 
        [0] = 0, 
        [1] = 0, 
        [2] = 0, 
        [3] = 0, 
        [4] = 0, 
        [5] = 0, 
        [6] = 0 
    },
    [2] = { 
        [0] = 9, 
        [1] = 5, 
        [2] = 1, 
        [3] = 5, 
        [4] = 15, 
        [5] = 7, 
        [6] = 15
    },
    [3] = {
        [0] = 1, 
        [1] = 1, 
        [2] = 1, 
        [3] = 3, 
        [4] = 15, 
        [5] = 11, 
        [6] = 3 
    },
    [4] = {
        [0] = 9, 
        [1] = 10, 
        [2] = 0, 
        [3] = 1, 
        [4] = 2, 
        [5] = 4, 
        [6] = 5 
    },
    [5] = { 
        [0] = 0, 
        [1] = 0, 
        [2] = 0, 
        [3] = 0, 
        [4] = 0, 
        [5] = 0, 
        [6] = 0 
    },
    [6] = {
        [0] = 4, 
        [1] = 10, 
        [2] = 1 ,
        [3] = 11, 
        [4] = 4, 
        [5] = 13, 
        [6] = 2 
    },
    [7] = {
        [0] = 0, 
        [1] = 11, 
        [2] = 0, 
        [3] = 0, 
        [4] = 4, 
        [5] = 5, 
        [6] = 0
    },
    [8] = {
        [0] = 15, 
        [1] = 13, 
        [2] = 2, 
        [3] = 2, 
        [4] = 3, 
        [5] = 3, 
        [6] = 2 
    },
    [9] = { 
        [0] = 0, 
        [1] = 0, 
        [2] = 0, 
        [3] = 0, 
        [4] = 0, 
        [5] = 0, 
        [6] = 0 
    },
    [10] = { 
        [0] = 0, 
        [1] = 0, 
        [2] = 0, 
        [3] = 0, 
        [4] = 0, 
        [5] = 0, 
        [6] = 0 
    },
    [11] = { 
        [0] = 10, 
        [1] = 10, 
        [2] = 6, 
        [3] = 3, 
        [4] = 4, 
        [5] = 2, 
        [6] = 3
    }
}

RegisterNetEvent('introCinematic:start')
AddEventHandler('introCinematic:start', function()
    local playerId = PlayerPedId()
	PrepareMusicEvent('FM_INTRO_START')
	TriggerMusicEvent('FM_INTRO_START') 
	if IsMale(playerId) then 
        RequestCutsceneWithPlaybackList('MP_INTRO_CONCAT', 31, 8)
    else 
        print('aqui')
        RequestCutsceneWithPlaybackList('MP_INTRO_CONCAT', 103, 8)
    end
    
    while (not HasCutsceneLoaded()) do Citizen.Wait(10); end;
	if IsMale(playerId) then 
        RegisterEntityForCutscene(0, 'MP_Male_Character', 3, GetEntityModel(PlayerPedId()), 0)
		RegisterEntityForCutscene(PlayerPedId(), 'MP_Male_Character', 0, 0, 0)
		SetCutsceneEntityStreamingFlags('MP_Male_Character', 0, 1) 
		local female = RegisterEntityForCutscene(0,'MP_Female_Character',3,0,64) 
		NetworkSetEntityInvisibleToNetwork(female, true)
	else 
        print('aqui')
        RegisterEntityForCutscene(0, 'MP_Female_Character', 3, GetEntityModel(PlayerPedId()), 0)
		RegisterEntityForCutscene(PlayerPedId(), 'MP_Female_Character', 0, 0, 0)
		SetCutsceneEntityStreamingFlags('MP_Female_Character', 0, 1) 
		local male = RegisterEntityForCutscene(0,'MP_Male_Character',3,0,64) 
		NetworkSetEntityInvisibleToNetwork(male, true)
    end

	local peds = {}
	for pedIdx = 0, 6, 1 do
		if (pedIdx == 1 or pedIdx == 2 or pedIdx == 4 or pedIdx == 6) then
			peds[pedIdx] = CreatePed(26, 'mp_f_freemode_01', -1117.77783203125, -1557.6248779296875, 3.3819, 0.0, 0, 0)
		else
			peds[pedIdx] = CreatePed(26, 'mp_m_freemode_01', -1117.77783203125, -1557.6248779296875, 3.3819, 0.0, 0, 0)
		end
        if (not IsEntityDead(peds[pedIdx])) then
		    HandlePassengersClothes(peds[pedIdx], pedIdx)
            FinalizeHeadBlend(peds[pedIdx])
            RegisterEntityForCutscene(peds[pedIdx], pedsList[pedIdx], 0, 0, 64)
        end
    end
	
	NewLoadSceneStartSphere(-1212.79, -1673.52, 7, 1000, 0)
    SetWeatherTypeNow('EXTRASUNNY')
    StartCutscene(4)
    Wait(31520)
	for pedIdx = 0, 6, 1 do DeleteEntity(peds[pedIdx]); end;
	PrepareMusicEvent('AC_STOP')
	TriggerMusicEvent('AC_STOP')
    Wait(50000)
    DoScreenFadeOut(500)
    Citizen.Wait(1500)
    TriggerEvent('zero_hud:toggleHud', true)
    Citizen.Wait(1000)
    DoScreenFadeIn(500)
    zero.teleport(generalConfig.spawnLocation.xyz)
    SetEntityHeading(ped, generalConfig.spawnLocation.w)
end)

ClearPedProps = function(ped)
    for i = 0, 8, 1 do
        ClearPedProp(ped, i)
    end
end

HandleRandomPeds = function(ped)
    SetPedRandomComponentVariation(ped, 0) 
    ClearPedProps(ped)
end

HandlePassengersClothes = function(ped, pedIdx)
    if (pedIdx >= 0 and pedIdx <= 6) then HandleRandomPeds(ped) end
end
