local Weapons = {
	-- MELEE
    [GetHashKey('WEAPON_DAGGER')] = 'WEAPON_DAGGER',
    [GetHashKey('WEAPON_BAT')] = 'WEAPON_BAT',
    [GetHashKey('WEAPON_BOTTLE')] = 'WEAPON_BOTTLE',
    [GetHashKey('WEAPON_CROWBAR')] = 'WEAPON_CROWBAR',
    [GetHashKey('WEAPON_FLASHLIGHT')] = 'WEAPON_FLASHLIGHT',
    [GetHashKey('WEAPON_GOLFCLUB')] = 'WEAPON_GOLFCLUB',
    [GetHashKey('WEAPON_HAMMER')] = 'WEAPON_HAMMER',
    [GetHashKey('WEAPON_HATCHET')] = 'WEAPON_HATCHET',
    [GetHashKey('WEAPON_KNUCKLE')] = 'WEAPON_KNUCKLE',
    [GetHashKey('WEAPON_KNIFE')] = 'WEAPON_KNIFE',
    [GetHashKey('WEAPON_MACHETE')] = 'WEAPON_MACHETE',
    [GetHashKey('WEAPON_SWITCHBLADE')] = 'WEAPON_SWITCHBLADE',
    [GetHashKey('WEAPON_NIGHTSTICK')] = 'WEAPON_NIGHTSTICK',
    [GetHashKey('WEAPON_WRENCH')] = 'WEAPON_WRENCH',
    [GetHashKey('WEAPON_BATTLEAXE')] = 'WEAPON_BATTLEAXE',
    [GetHashKey('WEAPON_POOLCUE')] = 'WEAPON_POOLCUE',
    [GetHashKey('WEAPON_STONE_HATCHET')] = 'WEAPON_STONE_HATCHET',
    [GetHashKey('WEAPON_CANDYCANE')] = 'WEAPON_CANDYCANE',

    -- HANDGUNS
    [GetHashKey('WEAPON_PISTOL')] = 'WEAPON_PISTOL',
    [GetHashKey('WEAPON_PISTOL_MK2')] = 'WEAPON_PISTOL_MK2',
    [GetHashKey('WEAPON_COMBATPISTOL')] = 'WEAPON_COMBATPISTOL',
    [GetHashKey('WEAPON_APPISTOL')] = 'WEAPON_APPISTOL',
    [GetHashKey('WEAPON_STUNGUN')] = 'WEAPON_STUNGUN',
    [GetHashKey('WEAPON_PISTOL50')] = 'WEAPON_PISTOL50',
    [GetHashKey('WEAPON_SNSPISTOL')] = 'WEAPON_SNSPISTOL',
    [GetHashKey('WEAPON_SNSPISTOL_MK2')] = 'WEAPON_SNSPISTOL_MK2',
    [GetHashKey('WEAPON_HEAVYPISTOL')] = 'WEAPON_HEAVYPISTOL',
    [GetHashKey('WEAPON_VINTAGEPISTOL')] = 'WEAPON_VINTAGEPISTOL',
    [GetHashKey('WEAPON_FLAREGUN')] = 'WEAPON_FLAREGUN',
    [GetHashKey('WEAPON_MARKSMANPISTOL')] = 'WEAPON_MARKSMANPISTOL',
    [GetHashKey('WEAPON_REVOLVER')] = 'WEAPON_REVOLVER',
    [GetHashKey('WEAPON_REVOLVER_MK2')] = 'WEAPON_REVOLVER_MK2',
    [GetHashKey('WEAPON_DOUBLEACTION')] = 'WEAPON_DOUBLEACTION',
    [GetHashKey('WEAPON_RAYPISTOL')] = 'WEAPON_RAYPISTOL',
    [GetHashKey('WEAPON_CERAMICPISTOL')] = 'WEAPON_CERAMICPISTOL',
    [GetHashKey('WEAPON_NAVYREVOLVER')] = 'WEAPON_NAVYREVOLVER',
    [GetHashKey('WEAPON_GADGETPISTOL')] = 'WEAPON_GADGETPISTOL',
    [GetHashKey('WEAPON_STUNGUN_MP')] = 'WEAPON_STUNGUN_MP',
    [GetHashKey('WEAPON_PISTOLXM3')] = 'WEAPON_PISTOLXM3',

    -- SUBMACHINE GUNS
    [GetHashKey('WEAPON_MICROSMG')] = 'WEAPON_MICROSMG',
    [GetHashKey('WEAPON_SMG')] = 'WEAPON_SMG',
    [GetHashKey('WEAPON_SMG_MK2')] = 'WEAPON_SMG_MK2',
    [GetHashKey('WEAPON_ASSAULTSMG')] = 'WEAPON_ASSAULTSMG',
    [GetHashKey('WEAPON_COMBATPDW')] = 'WEAPON_COMBATPDW',
    [GetHashKey('WEAPON_MACHINEPISTOL')] = 'WEAPON_MACHINEPISTOL',
    [GetHashKey('WEAPON_MINISMG')] = 'WEAPON_MINISMG',
    [GetHashKey('WEAPON_RAYCARBINE')] = 'WEAPON_RAYCARBINE',
    [GetHashKey('WEAPON_TECPISTOL')] = 'WEAPON_TECPISTOL',

    -- SHOTGUNS
    [GetHashKey('WEAPON_PUMPSHOTGUN')] = 'WEAPON_PUMPSHOTGUN',
    [GetHashKey('WEAPON_PUMPSHOTGUN_MK2')] = 'WEAPON_PUMPSHOTGUN_MK2',
    [GetHashKey('WEAPON_SAWNOFFSHOTGUN')] = 'WEAPON_SAWNOFFSHOTGUN',
    [GetHashKey('WEAPON_ASSAULTSHOTGUN')] = 'WEAPON_ASSAULTSHOTGUN',
    [GetHashKey('WEAPON_BULLPUPSHOTGUN')] = 'WEAPON_BULLPUPSHOTGUN',
    [GetHashKey('WEAPON_MUSKET')] = 'WEAPON_MUSKET',
    [GetHashKey('WEAPON_HEAVYSHOTGUN')] = 'WEAPON_HEAVYSHOTGUN',
    [GetHashKey('WEAPON_DBSHOTGUN')] = 'WEAPON_DBSHOTGUN',
    [GetHashKey('WEAPON_AUTOSHOTGUN')] = 'WEAPON_AUTOSHOTGUN',
    [GetHashKey('WEAPON_COMBATSHOTGUN')] = 'WEAPON_COMBATSHOTGUN',

    -- ASSAULT RIFLE
    [GetHashKey('WEAPON_ASSAULTRIFLE')] = 'WEAPON_ASSAULTRIFLE',
    [GetHashKey('WEAPON_ASSAULTRIFLE_MK2')] = 'WEAPON_ASSAULTRIFLE_MK2',
    [GetHashKey('WEAPON_CARBINERIFLE')] = 'WEAPON_CARBINERIFLE',
    [GetHashKey('WEAPON_CARBINERIFLE_MK2')] = 'WEAPON_CARBINERIFLE_MK2',
    [GetHashKey('WEAPON_ADVANCEDRIFLE')] = 'WEAPON_ADVANCEDRIFLE',
    [GetHashKey('WEAPON_SPECIALCARBINE')] = 'WEAPON_SPECIALCARBINE',
    [GetHashKey('WEAPON_SPECIALCARBINE_MK2')] = 'WEAPON_SPECIALCARBINE_MK2',
    [GetHashKey('WEAPON_BULLPUPRIFLE')] = 'WEAPON_BULLPUPRIFLE',
    [GetHashKey('WEAPON_BULLPUPRIFLE_MK2')] = 'WEAPON_BULLPUPRIFLE_MK2',
    [GetHashKey('WEAPON_COMPACTRIFLE')] = 'WEAPON_COMPACTRIFLE',
    [GetHashKey('WEAPON_MILITARYRIFLE')] = 'WEAPON_MILITARYRIFLE',
    [GetHashKey('WEAPON_HEAVYRIFLE')] = 'WEAPON_HEAVYRIFLE',
    [GetHashKey('WEAPON_TACTICALRIFLE')] = 'WEAPON_TACTICALRIFLE',

    -- LIGHT MACHINE GUNS
    [GetHashKey('WEAPON_MG')] = 'WEAPON_MG',
    [GetHashKey('WEAPON_COMBATMG')] = 'WEAPON_COMBATMG',
    [GetHashKey('WEAPON_COMBATMG_MK2')] = 'WEAPON_COMBATMG_MK2',
    [GetHashKey('WEAPON_GUSENBERG')] = 'WEAPON_GUSENBERG',

    -- SNIPER RIFLES
    [GetHashKey('WEAPON_SNIPERRIFLE')] = 'WEAPON_SNIPERRIFLE',
    [GetHashKey('WEAPON_HEAVYSNIPER')] = 'WEAPON_HEAVYSNIPER',
    [GetHashKey('WEAPON_HEAVYSNIPER_MK2')] = 'WEAPON_HEAVYSNIPER_MK2',
    [GetHashKey('WEAPON_MARKSMANRIFLE')] = 'WEAPON_MARKSMANRIFLE',
    [GetHashKey('WEAPON_MARKSMANRIFLE_MK2')] = 'WEAPON_MARKSMANRIFLE_MK2',
    [GetHashKey('WEAPON_PRECISIONRIFLE')] = 'WEAPON_PRECISIONRIFLE',

    -- HEAVY WEAPONS
    [GetHashKey('WEAPON_RPG')] = 'WEAPON_RPG',
    [GetHashKey('WEAPON_GRENADELAUNCHER')] = 'WEAPON_GRENADELAUNCHER',
    [GetHashKey('WEAPON_GRENADELAUNCHER_SMOKE')] = 'WEAPON_GRENADELAUNCHER_SMOKE',
    [GetHashKey('WEAPON_MINIGUN')] = 'WEAPON_MINIGUN',
    [GetHashKey('WEAPON_FIREWORK')] = 'WEAPON_FIREWORK',
    [GetHashKey('WEAPON_RAILGUN')] = 'WEAPON_RAILGUN',
    [GetHashKey('WEAPON_HOMINGLAUNCHER')] = 'WEAPON_HOMINGLAUNCHER',
    [GetHashKey('WEAPON_COMPACTLAUNCHER')] = 'WEAPON_COMPACTLAUNCHER',
    [GetHashKey('WEAPON_RAYMINIGUN')] = 'WEAPON_RAYMINIGUN',
    [GetHashKey('WEAPON_EMPLAUNCHER')] = 'WEAPON_EMPLAUNCHER',
    [GetHashKey('WEAPON_RAILGUNXM3')] = 'WEAPON_RAILGUNXM3',
    
    -- THROWABLES
    [GetHashKey('WEAPON_GRENADE')] = 'WEAPON_GRENADE',
    [GetHashKey('WEAPON_BZGAS')] = 'WEAPON_BZGAS',
    [GetHashKey('WEAPON_MOLOTOV')] = 'WEAPON_MOLOTOV',
    [GetHashKey('WEAPON_STICKYBOMB')] = 'WEAPON_STICKYBOMB',
    [GetHashKey('WEAPON_PROXMINE')] = 'WEAPON_PROXMINE',
    [GetHashKey('WEAPON_SNOWBALL')] = 'WEAPON_SNOWBALL',
    [GetHashKey('WEAPON_PIPEBOMB')] = 'WEAPON_PIPEBOMB',
    [GetHashKey('WEAPON_BALL')] = 'WEAPON_BALL',
    [GetHashKey('WEAPON_SMOKEGRENADE')] = 'WEAPON_SMOKEGRENADE',
    [GetHashKey('WEAPON_FLARE')] = 'WEAPON_FLARE',
    [GetHashKey('WEAPON_ACIDPACKAGE')] = 'WEAPON_ACIDPACKAGE',

    -- MISC
    [GetHashKey('WEAPON_PETROLCAN')] = 'WEAPON_PETROLCAN',
    [GetHashKey('GADGET_PARACHUTE')] = 'GADGET_PARACHUTE',
    [GetHashKey('WEAPON_FIREEXTINGUISHER')] = 'WEAPON_FIREEXTINGUISHER',
    [GetHashKey('WEAPON_HAZARDCAN')] = 'WEAPON_HAZARDCAN',
    [GetHashKey('WEAPON_FERTILIZERCAN')] = 'WEAPON_FERTILIZERCAN'
}

WeaponsHash = function()
    return Weapons
end
exports('WeaponsHash', WeaponsHash)

local Holster = false
local LastWeapon = nil

local _disableActions = false
local disableActions = function(bool)
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
                    zero.CarregarAnim('reaction@intimidation@1h')
                    if (not Holster and LastWeapon ~= GetHashKey(Weapons[GetSelectedPedWeapon(ped)]) and GetSelectedPedWeapon(ped) == GetHashKey(Weapons[GetSelectedPedWeapon(ped)])) then
                        LastWeapon = GetHashKey(Weapons[GetSelectedPedWeapon(ped)])
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

                    if (Holster and LastWeapon ~= GetHashKey(Weapons[GetSelectedPedWeapon(ped)])) then
                        if (GetSelectedPedWeapon(ped) == GetHashKey('WEAPON_UNARMED')) then
                            Holster = true
                        else
                            Holster = false
                        end
                    end
                else
                    if (Holster and GetSelectedPedWeapon(ped) == GetHashKey('WEAPON_UNARMED')) then
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
        else
            if (Holster) then Holster = false; end;
            SetCurrentPedWeapon(ped, GetHashKey('WEAPON_UNARMED'), true)
        end
		Citizen.Wait(100)
	end
end)