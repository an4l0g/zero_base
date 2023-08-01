local Weapons = {
	-- MELEE
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
    [GetHashKey('WEAPON_CANDYCANE')] = true,

    -- HANDGUNS
    [GetHashKey('WEAPON_PISTOL')] = true,
    [GetHashKey('WEAPON_PISTOL_MK2')] = true,
    [GetHashKey('WEAPON_COMBATPISTOL')] = true,
    [GetHashKey('WEAPON_APPISTOL')] = true,
    [GetHashKey('WEAPON_STUNGUN')] = true,
    [GetHashKey('WEAPON_PISTOL50')] = true,
    [GetHashKey('WEAPON_SNSPISTOL')] = true,
    [GetHashKey('WEAPON_SNSPISTOL_MK2')] = true,
    [GetHashKey('WEAPON_HEAVYPISTOL')] = true,
    [GetHashKey('WEAPON_VINTAGEPISTOL')] = true,
    [GetHashKey('WEAPON_FLAREGUN')] = true,
    [GetHashKey('WEAPON_MARKSMANPISTOL')] = true,
    [GetHashKey('WEAPON_REVOLVER')] = true,
    [GetHashKey('WEAPON_REVOLVER_MK2')] = true,
    [GetHashKey('WEAPON_DOUBLEACTION')] = true,
    [GetHashKey('WEAPON_RAYPISTOL')] = true,
    [GetHashKey('WEAPON_CERAMICPISTOL')] = true,
    [GetHashKey('WEAPON_NAVYREVOLVER')] = true,
    [GetHashKey('WEAPON_GADGETPISTOL')] = true,
    [GetHashKey('WEAPON_STUNGUN_MP')] = true,
    [GetHashKey('WEAPON_PISTOLXM3')] = true,

    -- SUBMACHINE GUNS
    [GetHashKey('WEAPON_MICROSMG')] = true,
    [GetHashKey('WEAPON_SMG')] = true,
    [GetHashKey('WEAPON_SMG_MK2')] = true,
    [GetHashKey('WEAPON_ASSAULTSMG')] = true,
    [GetHashKey('WEAPON_COMBATPDW')] = true,
    [GetHashKey('WEAPON_MACHINEPISTOL')] = true,
    [GetHashKey('WEAPON_MINISMG')] = true,
    [GetHashKey('WEAPON_RAYCARBINE')] = true,
    [GetHashKey('WEAPON_TECPISTOL')] = true,

    -- SHOTGUNS
    [GetHashKey('WEAPON_PUMPSHOTGUN')] = true,
    [GetHashKey('WEAPON_PUMPSHOTGUN_MK2')] = true,
    [GetHashKey('WEAPON_SAWNOFFSHOTGUN')] = true,
    [GetHashKey('WEAPON_ASSAULTSHOTGUN')] = true,
    [GetHashKey('WEAPON_BULLPUPSHOTGUN')] = true,
    [GetHashKey('WEAPON_MUSKET')] = true,
    [GetHashKey('WEAPON_HEAVYSHOTGUN')] = true,
    [GetHashKey('WEAPON_DBSHOTGUN')] = true,
    [GetHashKey('WEAPON_AUTOSHOTGUN')] = true,
    [GetHashKey('WEAPON_COMBATSHOTGUN')] = true,

    -- ASSAULT RIFLE
    [GetHashKey('WEAPON_ASSAULTRIFLE')] = true,
    [GetHashKey('WEAPON_ASSAULTRIFLE_MK2')] = true,
    [GetHashKey('WEAPON_CARBINERIFLE')] = true,
    [GetHashKey('WEAPON_CARBINERIFLE_MK2')] = true,
    [GetHashKey('WEAPON_ADVANCEDRIFLE')] = true,
    [GetHashKey('WEAPON_SPECIALCARBINE')] = true,
    [GetHashKey('WEAPON_SPECIALCARBINE_MK2')] = true,
    [GetHashKey('WEAPON_BULLPUPRIFLE')] = true,
    [GetHashKey('WEAPON_BULLPUPRIFLE_MK2')] = true,
    [GetHashKey('WEAPON_COMPACTRIFLE')] = true,
    [GetHashKey('WEAPON_MILITARYRIFLE')] = true,
    [GetHashKey('WEAPON_HEAVYRIFLE')] = true,
    [GetHashKey('WEAPON_TACTICALRIFLE')] = true,

    -- LIGHT MACHINE GUNS
    [GetHashKey('WEAPON_MG')] = true,
    [GetHashKey('WEAPON_COMBATMG')] = true,
    [GetHashKey('WEAPON_COMBATMG_MK2')] = true,
    [GetHashKey('WEAPON_GUSENBERG')] = true,

    -- SNIPER RIFLES
    [GetHashKey('WEAPON_SNIPERRIFLE')] = true,
    [GetHashKey('WEAPON_HEAVYSNIPER')] = true,
    [GetHashKey('WEAPON_HEAVYSNIPER_MK2')] = true,
    [GetHashKey('WEAPON_MARKSMANRIFLE')] = true,
    [GetHashKey('WEAPON_MARKSMANRIFLE_MK2')] = true,
    [GetHashKey('WEAPON_PRECISIONRIFLE')] = true,

    -- HEAVY WEAPONS
    [GetHashKey('WEAPON_RPG')] = true,
    [GetHashKey('WEAPON_GRENADELAUNCHER')] = true,
    [GetHashKey('WEAPON_GRENADELAUNCHER_SMOKE')] = true,
    [GetHashKey('WEAPON_MINIGUN')] = true,
    [GetHashKey('WEAPON_FIREWORK')] = true,
    [GetHashKey('WEAPON_RAILGUN')] = true,
    [GetHashKey('WEAPON_HOMINGLAUNCHER')] = true,
    [GetHashKey('WEAPON_COMPACTLAUNCHER')] = true,
    [GetHashKey('WEAPON_RAYMINIGUN')] = true,
    [GetHashKey('WEAPON_EMPLAUNCHER')] = true,
    [GetHashKey('WEAPON_RAILGUNXM3')] = true,
    
    -- THROWABLES
    [GetHashKey('WEAPON_GRENADE')] = true,
    [GetHashKey('WEAPON_BZGAS')] = true,
    [GetHashKey('WEAPON_MOLOTOV')] = true,
    [GetHashKey('WEAPON_STICKYBOMB')] = true,
    [GetHashKey('WEAPON_PROXMINE')] = true,
    [GetHashKey('WEAPON_SNOWBALL')] = true,
    [GetHashKey('WEAPON_PIPEBOMB')] = true,
    [GetHashKey('WEAPON_BALL')] = true,
    [GetHashKey('WEAPON_SMOKEGRENADE')] = true,
    [GetHashKey('WEAPON_FLARE')] = true,
    [GetHashKey('WEAPON_ACIDPACKAGE')] = true,

    -- MISC
    [GetHashKey('WEAPON_PETROLCAN')] = true,
    [GetHashKey('GADGET_PARACHUTE')] = true,
    [GetHashKey('WEAPON_FIREEXTINGUISHER')] = true,
    [GetHashKey('WEAPON_HAZARDCAN')] = true,
    [GetHashKey('WEAPON_FERTILIZERCAN')] = true
}

WeaponsHash = function()
    return Weapons
end
exports('WeaponsHash', WeaponsHash)

local Holster = false
local HolsterAnim = { 'amb@world_human_sunbathe@female@back@idle_a', 'idle_a' }
local LastWeapon = nil

local _disableActions = false
disableActions = function(bool)
    _disableActions = bool
    while (_disableActions == true) do
        DisablePlayerFiring(PlayerPedId(), true) 
        DisableControlAction(0, 140, true) 
        DisableControlAction(0, 263, true)
        Citizen.Wait(5)
    end
end
RegisterNetEvent('disableActionsWeapon', disableActions)

Citizen.CreateThread(function()
	while (true) do
        local ped = PlayerPedId()
        if (GetEntityHealth(ped) > 100) then
            if (not IsPedInAnyVehicle(ped)) then
                if (Weapons[GetSelectedPedWeapon(ped)]) then
                    LastWeapon = GetSelectedPedWeapon(ped)
                    if (not Holster) then
                        TriggerEvent('disableActionsWeapon', true)
                        SetCurrentPedWeapon(ped, GetHashKey('WEAPON_UNARMED'), true)
                        TaskPlayAnim(ped, 'reaction@intimidation@1h', 'intro', 8.0,8.0,-1,48,10,0,0,0)
                        Citizen.Wait(1200)
                        SetCurrentPedWeapon(ped, LastWeapon, true)
                        Citizen.Wait(1300)
					    ClearPedTasks(ped)
                        TriggerEvent('disableActionsWeapon', false)
                        Holster = true
                    end
                else
                    if (Holster) then
                        TriggerEvent('disableActionsWeapon', true)
                        SetCurrentPedWeapon(ped, LastWeapon, true)
                        TaskPlayAnim(ped, 'reaction@intimidation@1h', 'outro', 8.0,8.0,-1,48,10,0,0,0)
                        Citizen.Wait(1400)
                        SetCurrentPedWeapon(ped, GetHashKey('WEAPON_UNARMED'), true)
                        Citizen.Wait(600)
					    ClearPedTasks(ped)
                        LastWeapon = nil
                        TriggerEvent('disableActionsWeapon', false)
                        Holster = false
                    end
                end
            end

            -- if (IsPedArmed(ped, 6)) then threadWeapons(); end;
        else
            if (Holster) then Holster = false; end;
            SetCurrentPedWeapon(ped, GetHashKey('WEAPON_UNARMED'), true)
        end
		Citizen.Wait(100)
	end
end)

local _isPedArmed = false
threadWeapons = function()
	if (_isPedArmed) then return; end;
	_isPedArmed = true
end