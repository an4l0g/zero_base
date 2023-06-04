local cam = nil

local model = GetHashKey('a_m_y_hipster_02')
local spawnCoords = vector4(724.9, 1200.53, 326.16,161.57479858398)

Citizen.CreateThread(function()
	TriggerEvent('gb_spawn:SpawnSelector', false)
	ShutdownLoadingScreenNui()
	ShutdownLoadingScreen()
	DoScreenFadeIn(500)
	while IsScreenFadingIn() do
		Citizen.Wait(1)
	end
	if not LocalPlayer.state.spawned then
		RequestModel(model)
		while not HasModelLoaded(model) do
			RequestModel(model)
			Citizen.Wait(0)
		end
		SetPlayerModel(PlayerId(), model)
		SetModelAsNoLongerNeeded(model)
        TriggerEvent('playerSpawned',{})
		LocalPlayer.state.spawned = true
	else
		print("Ready spawned? Report to Developers.")
	end
end)

Citizen.CreateThread(function()
	Citizen.Wait(8000)
	while not HasModelLoaded(model) do
        RequestModel(model)
        Citizen.Wait(10)
    end
    if HasModelLoaded(model) then
        SetPlayerModel(PlayerId(),model)     
        SetPedDefaultComponentVariation(PlayerPedId())
    end
    SetModelAsNoLongerNeeded(model)
end)