Citizen.CreateThread(function()
    ReplaceHudColourWithRgba(0, 0, 153, 255, 255)
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
		local ped = PlayerPedId()
		local pCoord = GetEntityCoords(ped)

		-- [ Cayo Perico ] --
		SetRadarAsExteriorThisFrame()
		SetRadarAsInteriorThisFrame('h4_fake_islandx', vec(4700.0, -5145.0), 0, 0)
		
		HideHudComponentThisFrame(2)
		DisablePlayerVehicleRewards(PlayerId())
		N_0xf4f2c0d4ee209e20()
		SetPlayerTargetingMode(3)
		Citizen.Wait(1)
	end
end)