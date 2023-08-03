local cli = {}
Tunnel.bindInterface('Safezone', cli)

local safeZones = {
    ['Praca'] = PolyZone:Create({
        vector2(125.38, -995.45),
        vector2(152.65, -1004.92),
        vector2(155.30, -1013.26),
        vector2(209.85, -1029.92),
        vector2(220.83, -1010.23),
        vector2(268.18, -875.00),
        vector2(253.79, -864.02),
        vector2(209.47, -848.48),
        vector2(189.77, -841.29),
        vector2(182.95, -845.45),
        vector2(162.12, -889.39)
    },
    {
        minZ = 20.0,
        maxZ = 70.0,
    })
}

local inSafe = false
local _threadSafe = false

cli.inSafe = function()
    return inSafe
end

threadSafe = function()
    if (_threadSafe) then return; end;
    _threadSafe = true
    Citizen.CreateThread(function()
        local ped = PlayerPedId()
        NetworkSetFriendlyFireOption(false)
        TriggerEvent('notify', 'Zona Segura', 'Você entrou em uma <b>Zona Segura</b>.')
        SetCurrentPedWeapon(ped, GetHashKey('WEAPON_UNARMED'), true) 
        while (inSafe) do
            ped = PlayerPedId()
            DisableControlAction(2, 37, true) 
			DisablePlayerFiring(ped, true) 
			DisableControlAction(0, 106, true)
			DisableControlAction(0, 140, true)
			DisableControlAction(0, 263, true)
            Citizen.Wait(5)
        end
        NetworkSetFriendlyFireOption(true)
        TriggerEvent('notify', 'Zona Segura', 'Você saiu de uma <b>Zona Segura</b>.')
        _threadSafe = false
    end)
end

Citizen.CreateThread(function()
    while (true) do
        local ped = PlayerPedId()
        local pCoord = GetEntityCoords(ped)
        local status = false
        for name, zone in pairs(safeZones) do
            local inside = zone:isPointInside(pCoord)
            if (not status) and inside then status = inside; end;

            inSafe = status
            if (inSafe) and not _threadSafe then threadSafe(); end;
        end
        Citizen.Wait(500)
    end
end)


-- RegisterNetEvent('vRP:Active')
-- AddEventHandler('vRP:Active',function(Passport,Name)
-- 	LocalPlayer['state']:set('Name',Name,true)
-- 	LocalPlayer['state']:set('Active',true,true)
-- 	LocalPlayer['state']:set('Invincible',false,true)
-- 	LocalPlayer['state']:set('Passport',Passport,true)

-- 	LocalPlayer['state']['Name'] = Name
-- 	LocalPlayer['state']['Active'] = true
-- 	LocalPlayer['state']['Passport'] = Passport
-- 	LocalPlayer['state']['Player'] = GetPlayerServerId(PlayerId())
-- 	SetDiscordAppId(RichPresenceConfig.AppId)
-- 	SetRichPresence('#'..Passport..' '..Name)
-- 	SetDiscordRichPresenceAsset(RichPresenceConfig.Asset)
-- 	SetDiscordRichPresenceAssetSmall(RichPresenceConfig.AssetSmall)
-- 	SetDiscordRichPresenceAssetSmallText(RichPresenceConfig.AssetSmallText)
-- 	SetDiscordRichPresenceAssetText(RichPresenceConfig.AssetText)
-- 	SetDiscordRichPresenceAction(0,RichPresenceConfig.Button[1],RichPresenceConfig.Button[2])
-- 	SetDiscordRichPresenceAction(1,RichPresenceConfig.Button2[1],RichPresenceConfig.Button2[2])

-- 	local Pid = PlayerId()
-- 	local Ped = PlayerPedId()

-- 	FreezeEntityPosition(Ped,false)
-- 	NetworkSetFriendlyFireOption(true)
-- 	SetCanAttackFriendly(Ped,true,false)

-- 	StopAudioScenes()
-- 	RemovePickups(Pid)
-- 	SetMaxWantedLevel(0)
-- 	SetRandomBoats(false)
-- 	SetRandomTrains(false)
-- 	SetGarbageTrucks(false)
-- 	SetPedHelmet(Ped,false)
-- 	SetDeepOceanScaler(0.0)
-- 	SetPlayerTargetingMode(0)
-- 	SetRandomEventFlag(false)
-- 	SetPoliceRadarBlips(false)
-- 	DistantCopCarSirens(false)
-- 	SetWeaponsNoAutoswap(true)
-- 	ClearPlayerWantedLevel(Pid)
-- 	SetPoliceIgnorePlayer(Ped,true)
-- 	SetArtificialLightsState(false)
-- 	SetPlayerCanUseCover(Pid,false)
-- 	SetPedSteersAroundPeds(Ped,true)
-- 	DisableVehicleDistantlights(true)
-- 	SetDispatchCopsForPlayer(Ped,false)
-- 	SetAllVehicleGeneratorsActive(true)
-- 	SetFlashLightKeepOnWhileMoving(true)
-- 	SetPedDropsWeaponsWhenDead(Ped,false)
-- 	SetPedCanLosePropsOnDamage(Ped,false,0)
-- 	SetPedCanBeKnockedOffVehicle(Ped,false)
-- 	SetPedCanRagdollFromPlayerImpact(Ped,false)

-- 	SetPedConfigFlag(Ped,48,true)
-- 	SetPedConfigFlag(Ped,33,false)
-- 	SetPedConfigFlag(Ped,461,true)
-- 	SetPedConfigFlag(Ped,438,true)
-- 	SetPedConfigFlag(Ped,434,true)

-- 	SetEntityDrawOutlineShader(1)
-- 	SetBlipAlpha(GetNorthRadarBlip(),0)
-- 	SetEntityDrawOutlineColor(65,130,226,255)
-- 	ReplaceHudColourWithRgba(116,65,130,226,255)

-- 	SetAudioFlag('DisableFlightMusic',true)
-- 	SetAudioFlag('PoliceScannerDisabled',true)
-- 	SetScenarioGroupEnabled('Heist_Island_Peds',true)
-- 	SetScenarioTypeEnabled('WORLD_VEHICLE_EMPTY',false)
-- 	SetScenarioTypeEnabled('WORLD_VEHICLE_SALTON',false)
-- 	SetScenarioTypeEnabled('WORLD_VEHICLE_MECHANIC',false)
-- 	SetScenarioTypeEnabled('WORLD_VEHICLE_DRIVE_SOLO',true)
-- 	SetScenarioTypeEnabled('WORLD_VEHICLE_POLICE_CAR',false)
-- 	SetScenarioTypeEnabled('WORLD_VEHICLE_STREETRACE',false)
-- 	SetScenarioTypeEnabled('WORLD_VEHICLE_POLICE_BIKE',false)
-- 	SetScenarioTypeEnabled('WORLD_VEHICLE_BUSINESSMEN',false)
-- 	SetScenarioTypeEnabled('WORLD_VEHICLE_SALTON_DIRT_BIKE',false)
-- 	SetScenarioTypeEnabled('WORLD_VEHICLE_BIKE_OFF_ROAD_RACE',false)
-- 	SetScenarioTypeEnabled('WORLD_VEHICLE_POLICE_NEXT_TO_CAR',false)
-- 	SetScenarioTypeEnabled('WORLD_VEHICLE_MILITARY_PLANES_BIG',false)
-- 	SetScenarioTypeEnabled('WORLD_VEHICLE_MILITARY_PLANES_SMALL',false)
-- 	SetStaticEmitterEnabled('LOS_SANTOS_VANILLA_UNICORN_01_STAGE',false)
-- 	SetStaticEmitterEnabled('LOS_SANTOS_VANILLA_UNICORN_02_MAIN_ROOM',false)
-- 	SetStaticEmitterEnabled('LOS_SANTOS_VANILLA_UNICORN_03_BACK_ROOM',false)
-- 	SetAmbientZoneListStatePersistent('AZL_DLC_Hei4_Island_Zones',true,true)
-- 	SetAmbientZoneListStatePersistent('AZL_DLC_Hei4_Island_Disabled_Zones',false,true)

-- 	SetWeaponDamageModifierThisFrame('WEAPON_BAT',0.25)
-- 	SetWeaponDamageModifierThisFrame('WEAPON_KATANA',0.25)
-- 	SetWeaponDamageModifierThisFrame('WEAPON_HAMMER',0.25)
-- 	SetWeaponDamageModifierThisFrame('WEAPON_WRENCH',0.25)
-- 	SetWeaponDamageModifierThisFrame('WEAPON_UNARMED',0.25)
-- 	SetWeaponDamageModifierThisFrame('WEAPON_HATCHET',0.25)
-- 	SetWeaponDamageModifierThisFrame('WEAPON_CROWBAR',0.25)
-- 	SetWeaponDamageModifierThisFrame('WEAPON_MACHETE',0.25)
-- 	SetWeaponDamageModifierThisFrame('WEAPON_POOLCUE',0.25)
-- 	SetWeaponDamageModifierThisFrame('WEAPON_KNUCKLE',0.25)
-- 	SetWeaponDamageModifierThisFrame('WEAPON_KARAMBIT',0.25)
-- 	SetWeaponDamageModifierThisFrame('WEAPON_GOLFCLUB',0.25)
-- 	SetWeaponDamageModifierThisFrame('WEAPON_BATTLEAXE',0.25)
-- 	SetWeaponDamageModifierThisFrame('WEAPON_FLASHLIGHT',0.25)
-- 	SetWeaponDamageModifierThisFrame('WEAPON_NIGHTSTICK',0.35)
-- 	SetWeaponDamageModifierThisFrame('WEAPON_SMOKEGRENADE',0.0)
-- 	SetWeaponDamageModifierThisFrame('WEAPON_STONE_HATCHET',0.25)

-- 	for Number = 0,121 do
-- 		EnableDispatchService(Number,false)
-- 	end

-- 	SetTimeout(10000,function()
-- 		LocalPlayer['state']:set('Invincible',false,true)
-- 	end)
-- end)