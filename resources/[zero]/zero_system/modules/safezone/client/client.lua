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
        LocalPlayer.state.SafeZone = true
        TriggerEvent('notify', 'Zona Segura', 'Você entrou em uma <b>Zona Segura</b>.')
        -- SetCurrentPedWeapon(ped, GetHashKey('WEAPON_UNARMED'), true) 
        while (inSafe) do
            -- DisableControlAction(2, 37, true) 
			DisablePlayerFiring(PlayerId(), true) 
			DisableControlAction(0, 106, true)
			DisableControlAction(0, 140, true)
			DisableControlAction(0, 263, true)
            Citizen.Wait(1)
        end
        NetworkSetFriendlyFireOption(true)
        LocalPlayer.state.SafeZone = false
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