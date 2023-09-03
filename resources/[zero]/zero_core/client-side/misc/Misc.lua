Citizen.CreateThread(function()
	local Pid = PlayerId()
	local ped = PlayerPedId()

	NetworkSetFriendlyFireOption(true)
	SetCanAttackFriendly(ped, true, true)
	SetWeaponDamageModifier(GetHashKey('WEAPON_UNARMED'), 0.2)
	ReplaceHudColour(116, 9)
    AddTextEntry('FE_THDR_GTAO', 'ZERO')
	StartAudioScene('CHARACTER_CHANGE_IN_SKY_SCENE')
	SetAudioFlag('PoliceScannerDisabled', true)
	SetPlayerCanUseCover(Pid, false)
	DistantCopCarSirens(false)
	ForceAmbientSiren(false)
	DisableVehicleDistantlights(true)
	StopAudioScenes()
	SetPlayerTargetingMode(3)
	SetMaxWantedLevel(0)
	SetRandomBoats(false)
	SetRandomTrains(false)
	SetGarbageTrucks(false)
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
	SetPedCanLosePropsOnDamage(ped, false, 0)
	SetAudioFlag('PlayerOnDLCHeist4Island', true)
	SetAmbientZoneListStatePersistent('AZL_DLC_Hei4_Island_Zones', true, true)
	SetAmbientZoneListStatePersistent('AZL_DLC_Hei4_Island_Disabled_Zones', false, true)
	SetDeepOceanScaler(0.0)
	RemovePickups(Pid)

	local _idle = 1000
	while (true) do
		_idle = 1000
		SetPlayerHealthRechargeMultiplier(PlayerId(), 0.0)
		if (IsPauseMenuActive()) then
			_idle = 1
			SetRadarAsExteriorThisFrame()
			SetRadarAsInteriorThisFrame('h4_fake_islandx', vec(4700.0, -5145.0), 0, 0)
		end
		Citizen.Wait(_idle)
	end
end)

Citizen.CreateThread(function()
	while (true) do
		local coords = GetEntityCoords(PlayerPedId())
		RemoveVehiclesFromGeneratorsInArea(coords.x-9999.0,coords.y-9999.0,coords.z-9999.0,coords.x+9999.0,coords.y+9999.0,coords.z+9999.0)
		Citizen.Wait(5)
	end
end)

RemovePickups = function(Pid)
	local Pickups = {
		`PICKUP_AMMO_BULLET_MP`,
		`PICKUP_AMMO_FIREWORK`,
		`PICKUP_AMMO_FLAREGUN`,
		`PICKUP_AMMO_GRENADELAUNCHER`,
		`PICKUP_AMMO_GRENADELAUNCHER_MP`,
		`PICKUP_AMMO_HOMINGLAUNCHER`,
		`PICKUP_AMMO_MG`,
		`PICKUP_AMMO_MINIGUN`,
		`PICKUP_AMMO_MISSILE_MP`,
		`PICKUP_AMMO_PISTOL`,
		`PICKUP_AMMO_RIFLE`,
		`PICKUP_AMMO_RPG`,
		`PICKUP_AMMO_SHOTGUN`,
		`PICKUP_AMMO_SMG`,
		`PICKUP_AMMO_SNIPER`,
		`PICKUP_ARMOUR_STANDARD`,
		`PICKUP_CAMERA`,
		`PICKUP_CUSTOM_SCRIPT`,
		`PICKUP_GANG_ATTACK_MONEY`,
		`PICKUP_HEALTH_SNACK`,
		`PICKUP_HEALTH_STANDARD`,
		`PICKUP_MONEY_CASE`,
		`PICKUP_MONEY_DEP_BAG`,
		`PICKUP_MONEY_MED_BAG`,
		`PICKUP_MONEY_PAPER_BAG`,
		`PICKUP_MONEY_PURSE`,
		`PICKUP_MONEY_SECURITY_CASE`,
		`PICKUP_MONEY_VARIABLE`,
		`PICKUP_MONEY_WALLET`,
		`PICKUP_PARACHUTE`,
		`PICKUP_PORTABLE_CRATE_FIXED_INCAR`,
		`PICKUP_PORTABLE_CRATE_UNFIXED`,
		`PICKUP_PORTABLE_CRATE_UNFIXED_INCAR`,
		`PICKUP_PORTABLE_CRATE_UNFIXED_INCAR_SMALL`,
		`PICKUP_PORTABLE_CRATE_UNFIXED_LOW_GLOW`,
		`PICKUP_PORTABLE_DLC_VEHICLE_PACKAGE`,
		`PICKUP_PORTABLE_PACKAGE`,
		`PICKUP_SUBMARINE`,
		`PICKUP_VEHICLE_ARMOUR_STANDARD`,
		`PICKUP_VEHICLE_CUSTOM_SCRIPT`,
		`PICKUP_VEHICLE_CUSTOM_SCRIPT_LOW_GLOW`,
		`PICKUP_VEHICLE_HEALTH_STANDARD`,
		`PICKUP_VEHICLE_HEALTH_STANDARD_LOW_GLOW`,
		`PICKUP_VEHICLE_MONEY_VARIABLE`,
		`PICKUP_VEHICLE_WEAPON_SNIPERRIFLE`,
		`PICKUP_VEHICLE_WEAPON_APPISTOL`,
		`PICKUP_VEHICLE_WEAPON_ASSAULTSMG`,
		`PICKUP_VEHICLE_WEAPON_COMBATPISTOL`,
		`PICKUP_VEHICLE_WEAPON_GRENADE`,
		`PICKUP_VEHICLE_WEAPON_MICROSMG`,
		`PICKUP_VEHICLE_WEAPON_MOLOTOV`,
		`PICKUP_VEHICLE_WEAPON_PISTOL`,
		`PICKUP_VEHICLE_WEAPON_PISTOL50`,
		`PICKUP_VEHICLE_WEAPON_SAWNOFF`,
		`PICKUP_VEHICLE_WEAPON_SMG`,
		`PICKUP_VEHICLE_WEAPON_SMOKEGRENADE`,
		`PICKUP_VEHICLE_WEAPON_STICKYBOMB`,
		`PICKUP_WEAPON_ADVANCEDRIFLE`,
		`PICKUP_WEAPON_APPISTOL`,
		`PICKUP_WEAPON_ASSAULTRIFLE`,
		`PICKUP_WEAPON_ASSAULTSHOTGUN`,
		`PICKUP_WEAPON_ASSAULTSMG`,
		`PICKUP_WEAPON_AUTOSHOTGUN`,
		`PICKUP_WEAPON_BAT`,
		`PICKUP_WEAPON_BATTLEAXE`,
		`PICKUP_WEAPON_BOTTLE`,
		`PICKUP_WEAPON_BULLPUPRIFLE`,
		`PICKUP_WEAPON_BULLPUPSHOTGUN`,
		`PICKUP_WEAPON_CARBINERIFLE`,
		`PICKUP_WEAPON_COMBATMG`,
		`PICKUP_WEAPON_COMBATPDW`,
		`PICKUP_WEAPON_COMBATPISTOL`,
		`PICKUP_WEAPON_COMPACTLAUNCHER`,
		`PICKUP_WEAPON_COMPACTRIFLE`,
		`PICKUP_WEAPON_CROWBAR`,
		`PICKUP_WEAPON_DAGGER`,
		`PICKUP_WEAPON_DBSHOTGUN`,
		`PICKUP_WEAPON_FIREWORK`,
		`PICKUP_WEAPON_FLAREGUN`,
		`PICKUP_WEAPON_FLASHLIGHT`,
		`PICKUP_WEAPON_GRENADE`,
		`PICKUP_WEAPON_GRENADELAUNCHER`,
		`PICKUP_WEAPON_GUSENBERG`,
		`PICKUP_WEAPON_GOLFCLUB`,
		`PICKUP_WEAPON_HAMMER`,
		`PICKUP_WEAPON_HATCHET`,
		`PICKUP_WEAPON_HEAVYPISTOL`,
		`PICKUP_WEAPON_HEAVYSHOTGUN`,
		`PICKUP_WEAPON_HEAVYSNIPER`,
		`PICKUP_WEAPON_HOMINGLAUNCHER`,
		`PICKUP_WEAPON_KNIFE`,
		`PICKUP_WEAPON_KNUCKLE`,
		`PICKUP_WEAPON_MACHETE`,
		`PICKUP_WEAPON_MACHINEPISTOL`,
		`PICKUP_WEAPON_MARKSMANPISTOL`,
		`PICKUP_WEAPON_MARKSMANRIFLE`,
		`PICKUP_WEAPON_MG`,
		`PICKUP_WEAPON_MICROSMG`,
		`PICKUP_WEAPON_MINIGUN`,
		`PICKUP_WEAPON_MINISMG`,
		`PICKUP_WEAPON_MOLOTOV`,
		`PICKUP_WEAPON_MUSKET`,
		`PICKUP_WEAPON_NIGHTSTICK`,
		`PICKUP_WEAPON_PETROLCAN`,
		`PICKUP_WEAPON_PIPEBOMB`,
		`PICKUP_WEAPON_PISTOL`,
		`PICKUP_WEAPON_PISTOL50`,
		`PICKUP_WEAPON_POOLCUE`,
		`PICKUP_WEAPON_PROXMINE`,
		`PICKUP_WEAPON_PUMPSHOTGUN`,
		`PICKUP_WEAPON_RAILGUN`,
		`PICKUP_WEAPON_REVOLVER`,
		`PICKUP_WEAPON_RPG`,
		`PICKUP_WEAPON_SAWNOFFSHOTGUN`,
		`PICKUP_WEAPON_SMG`,
		`PICKUP_WEAPON_SMOKEGRENADE`,
		`PICKUP_WEAPON_SNIPERRIFLE`,
		`PICKUP_WEAPON_SNSPISTOL`,
		`PICKUP_WEAPON_SPECIALCARBINE`,
		`PICKUP_WEAPON_STICKYBOMB`,
		`PICKUP_WEAPON_STUNGUN`,
		`PICKUP_WEAPON_SWITCHBLADE`,
		`PICKUP_WEAPON_VINTAGEPISTOL`,
		`PICKUP_WEAPON_WRENCH`,
		`PICKUP_WEAPON_RAYCARBINE`
	}

	for Number = 1,#Pickups do
		ToggleUsePickupsForPlayer(Pid,Pickups[Number],false)
	end
end

local Crouched = false
local CrouchedForce = false
local Aimed = false
local Cooldown = false
local CoolDownTime = 500 -- in ms
local actionTime = 0.25 -- tempo  para abaixar e levantar
NormalWalk = function() 
    local Player = PlayerPedId()
    SetPedMaxMoveBlendRatio(Player, 1.0)
    ResetPedMovementClipset(Player, actionTime)
    ResetPedStrafeClipset(Player)
    SetPedCanPlayAmbientAnims(Player, true)
    SetPedCanPlayAmbientBaseAnims(Player, true)
    ResetPedWeaponMovementClipset(Player)
    ResetPedMovementClipset(Player,0.25)

    Crouched = false
end

SetupCrouch = function()
    while not HasAnimSetLoaded('move_ped_crouched') do
        Citizen.Wait(1)
        RequestAnimSet('move_ped_crouched')
    end
end

RemoveCrouchAnim = function()
    RemoveAnimDict('move_ped_crouched')
end

CanCrouch = function()
    local PlayerPed = PlayerPedId()
    if IsPedOnFoot(PlayerPed) and not IsPedJumping(PlayerPed) and not IsPedFalling(PlayerPed) and not IsPedDeadOrDying(PlayerPed) then
        return true
    else
        return false
    end
end

CrouchPlayer = function()
    local Player = PlayerPedId()
    SetPedUsingActionMode(Player, false, -1, 'DEFAULT_ACTION')
    SetPedMovementClipset(Player, 'move_ped_crouched', actionTime)
    SetPedMovementClipset(Player,'move_ped_crouched',1.50) -- moovespeed
    SetPedStrafeClipset(Player, 'move_ped_crouched_strafing') -- it force be on third person if not player will freeze but this func make player can shoot with good anim on crouch if someone know how to fix this make request :D
    SetWeaponAnimationOverride(Player, 'Ballistic')
    Crouched = true
    Aimed = false
end

SetPlayerAimSpeed = function()
    local Player = PlayerPedId()
    SetPedMaxMoveBlendRatio(Player, 10.0)
    Aimed = true
end

IsPlayerFreeAimed = function()
    local PlayerID = GetPlayerIndex()
    if IsPlayerFreeAiming(PlayerID) or IsAimCamActive() or IsAimCamThirdPersonActive() then
        return true
    else
        return false
    end
end

CrouchLoop = function()
    SetupCrouch()
    while CrouchedForce do
        local CanDo = CanCrouch()
        if Crouched then 
            DisablePlayerFiring(PlayerPedId(), true) -- desabilita atirar
        end
        if CanDo and Crouched and IsPlayerFreeAimed() then
            SetPlayerAimSpeed()
        elseif CanDo and (not Crouched or Aimed) then
            CrouchPlayer()
        elseif not CanDo and Crouched then
            CrouchedForce = false
            NormalWalk()
        end
        local sleep = 15
        if Crouched then sleep = 1 end

        if IsPedInAnyVehicle(PlayerPedId()) then 
            CrouchedForce = false
        end

        Citizen.Wait(1)
    end
    NormalWalk()
    RemoveCrouchAnim()
end

RegisterKeyMapping('Crouch', 'Agachar', 'keyboard', 'LCONTROL')
RegisterCommand('Crouch', function()
	if (not LocalPlayer.state.Control) then
		DisableControlAction(0, 36, true) -- magic
		if IsPedInAnyVehicle(PlayerPedId()) then 
			CrouchedForce = false
			return
		end
		if not Cooldown then
			CrouchedForce = not CrouchedForce

			if CrouchedForce then
				CreateThread(CrouchLoop) -- Magic Part 2 lamo
			end

			Cooldown = true
			SetTimeout(CoolDownTime, function()
				Cooldown = false
			end)
		end
	end
end, false)

IsCrouched = function()
    return Crouched
end
exports('IsCrouched', IsCrouched)

local BlacklistDispatch = {
	[GetHashKey('WEAPON_UNARMED')] = true,
	[GetHashKey('WEAPON_DAGGER')] = true,
	[GetHashKey('WEAPON_BAT')] = true,
	[GetHashKey('WEAPON_BOTTLE')] = true,
	[GetHashKey('WEAPON_CROWBAR')] = true,
	[GetHashKey('WEAPON_FLASHLIGHT')] = true,
	[GetHashKey('WEAPON_GOLFCLUB')] = true,
	[GetHashKey('WEAPON_HAMMER')] = true,
	[GetHashKey('WEAPON_HATCHET')] = true,
	[GetHashKey('WEAPON_KNUCKLE')] = true,
	[GetHashKey('WEAPON_KNIFE')] = true,
	[GetHashKey('WEAPON_MACHETE')] = true,
	[GetHashKey('WEAPON_SWITCHBLADE')] = true,
	[GetHashKey('WEAPON_NIGHTSTICK')] = true,
	[GetHashKey('WEAPON_WRENCH')] = true,
	[GetHashKey('WEAPON_BATTLEAXE')] = true,
	[GetHashKey('WEAPON_POOLCUE')] = true,
	[GetHashKey('WEAPON_STONE_HATCHET')] = true,
	[GetHashKey('WEAPON_STUNGUN')] = true,
	[GetHashKey('WEAPON_FLARE')] = true,
	[GetHashKey('GADGET_PARACHUTE')] = true,
	[GetHashKey('WEAPON_FIREEXTINGUISHER')] = true,
	[GetHashKey('WEAPON_PETROLCAN')] = true,
	[GetHashKey('WEAPON_FIREWORK')] = true,
	[GetHashKey('WEAPON_SNOWBALL')] = true,
	[GetHashKey('WEAPON_BZGAS')] = true,
	[GetHashKey('WEAPON_MUSKET')] = true
}

local Dispatch = false

Citizen.CreateThread(function()
	while (true) do
		local idle = 1000
		local ped = PlayerPedId()
		if (not Dispatch and IsPedArmed(ped, 4)) then
			idle = 1
			if (IsPedShooting(ped)) and not (BlacklistDispatch[GetSelectedPedWeapon(ped)]) then
				Dispatch = true
				TriggerServerEvent('zero_core:shoting', GetEntityCoords(ped))
				Citizen.SetTimeout(40000, function()
					Dispatch = false
				end)
			end
		end
		Citizen.Wait(idle)
	end
end)

local shot = {}
RegisterNetEvent('zero_core:shotingBlip', function(coord, user_id)
	if (not DoesBlipExist(shot[user_id])) then
		PlaySoundFrontend(-1, 'Enter_1st', 'GTAO_FM_Events_Soundset', false)

		shot[user_id] = AddBlipForCoord(coord)
		SetBlipScale(shot[user_id], 0.5)
		SetBlipSprite(shot[user_id], 10)
		SetBlipColour(shot[user_id], 3)
		BeginTextCommandSetBlipName('STRING')
		AddTextComponentString('Disparos de arma de fogo')
		EndTextCommandSetBlipName(shot[user_id])
		SetBlipAsShortRange(shot[user_id], false)

		Citizen.SetTimeout(35000,function()
			if (DoesBlipExist(shot[user_id])) then
				RemoveBlip(shot[user_id])
			end
		end)
	end
end)