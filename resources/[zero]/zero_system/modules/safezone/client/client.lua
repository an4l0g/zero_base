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
    }),
    ['Hospital'] = PolyZone:Create({
        vector2(-860.98, -1196.59),
        vector2(-882.20, -1207.20),
        vector2(-867.42, -1232.58),
        vector2(-870.45, -1237.88),
        vector2(-834.85, -1266.67),
        vector2(-827.27, -1257.95),
        vector2(-819.32, -1265.53),
        vector2(-811.36, -1257.20),
        vector2(-794.32, -1271.59),
        vector2(-757.58, -1279.55),
        vector2(-720.83, -1239.39),
        vector2(-717.42, -1230.30),
        vector2(-796.21, -1162.50)
    },{}),
    ['Pier'] = PolyZone:Create({
        vector2(-1826.52, -1275.00),
        vector2(-1796.21, -1243.94),
        vector2(-1799.24, -1230.30),
        vector2(-1773.48, -1198.48),
        vector2(-1787.12, -1184.85),
        vector2(-1731.06, -1125.76),
        vector2(-1671.97, -1175.00),
        vector2(-1509.09, -977.27),
        vector2(-1532.58, -961.36),
        vector2(-1532.58, -948.48),
        vector2(-1550.76, -939.39),
        vector2(-1559.09, -915.15),
        vector2(-1588.64, -957.58),
        vector2(-1604.55, -942.42),
        vector2(-1627.27, -953.03),
        vector2(-1619.70, -968.94),
        vector2(-1644.70, -985.61),
        vector2(-1659.09, -976.52),
        vector2(-1668.94, -985.61),
        vector2(-1656.82, -1004.55),
        vector2(-1802.27, -1173.48),
        vector2(-1828.79, -1156.82),
        vector2(-1878.03, -1209.09),
        vector2(-1856.82, -1230.30),
        vector2(-1868.18, -1237.12)
    },{}),
    
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
        SetLocalPlayerAsGhost(true)
		SetGhostedEntityAlpha(254)
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
        SetLocalPlayerAsGhost(false)	
		ResetGhostedEntityAlpha()
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