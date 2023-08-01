Citizen.CreateThread(function()
	ReplaceHudColour(116, 9)
    AddTextEntry('FE_THDR_GTAO', 'ZERO')
	StartAudioScene('CHARACTER_CHANGE_IN_SKY_SCENE')
	SetAudioFlag('PoliceScannerDisabled', true)
	SetPlayerCanUseCover(PlayerId(), false)
	DistantCopCarSirens(false)
	ForceAmbientSiren(false)
	DisableVehicleDistantlights(true)

	-- [ Cayo Perico ] --
	SetAudioFlag('PlayerOnDLCHeist4Island', true)
	SetAmbientZoneListStatePersistent('AZL_DLC_Hei4_Island_Zones', true, true)
	SetAmbientZoneListStatePersistent('AZL_DLC_Hei4_Island_Disabled_Zones', false, true)
	SetDeepOceanScaler(0.0)
	while (true) do
		HideHudComponentThisFrame(2)
		DisablePlayerVehicleRewards(PlayerId())
		SetPlayerTargetingMode(3)
		Citizen.Wait(1)
	end
end)

Citizen.CreateThread(function()
	local _idle = 1000
	while (true) do
		_idle = 1000
		local ped = PlayerPedId()

		SetPlayerHealthRechargeMultiplier(PlayerId(), 0.0)
		if (IsPauseMenuActive()) then
			_idle = 5
			SetRadarAsExteriorThisFrame()
			SetRadarAsInteriorThisFrame('h4_fake_islandx', vec(4700.0, -5145.0), 0, 0)
		end
		Citizen.Wait(_idle)
	end
end)