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