Citizen.CreateThread(function()
	local Pid = PlayerId()
	local ped = PlayerPedId()

	ReplaceHudColour(116, 9)
    AddTextEntry('FE_THDR_GTAO', 'ZERO')
	StartAudioScene('CHARACTER_CHANGE_IN_SKY_SCENE')
	SetAudioFlag('PoliceScannerDisabled', true)
	SetPlayerCanUseCover(Pid, false)
	DistantCopCarSirens(false)
	ForceAmbientSiren(false)
	DisableVehicleDistantlights(true)
	StopAudioScenes()
	SetMaxWantedLevel(0)
	SetRandomBoats(false)
	SetRandomTrains(false)
	SetGarbageTrucks(false)
	SetPlayerTargetingMode(0)
	SetRandomEventFlag(false)
	SetPoliceRadarBlips(false)
	DistantCopCarSirens(false)
	ClearPlayerWantedLevel(Pid)
	SetPoliceIgnorePlayer(ped, true)
	SetArtificialLightsState(false)
	SetPedSteersAroundPeds(ped, true)
	DisableVehicleDistantlights(true)
	SetDispatchCopsForPlayer(ped, false)
	SetFlashLightKeepOnWhileMoving(true)
	SetPedDropsWeaponsWhenDead(ped,false)
	SetPedCanBeKnockedOffVehicle(ped, false)
	SetPedCanRagdollFromPlayerImpact(ped, false)
	SetPedConfigFlag(ped, 35, false) 
	SetAudioFlag('PlayerOnDLCHeist4Island', true)
	SetAmbientZoneListStatePersistent('AZL_DLC_Hei4_Island_Zones', true, true)
	SetAmbientZoneListStatePersistent('AZL_DLC_Hei4_Island_Disabled_Zones', false, true)
	SetDeepOceanScaler(0.0)

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