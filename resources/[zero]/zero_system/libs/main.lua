-- Libraries
Tunnel = module('zero','lib/Tunnel')
Proxy = module('zero','lib/Proxy')

PolyZone = {}

-- Proxies
local _ServerSide = IsDuplicityVersion()
if (_ServerSide) then
    zero = Proxy.getInterface('zero')
    zeroClient = Tunnel.getInterface('zero')
else
    zero = Proxy.getInterface('zero')
    zeroServer = Tunnel.getInterface('zero')

    LoadAnim = function(Dict)
        while (not HasAnimDictLoaded(Dict)) do
            RequestAnimDict(Dict)
            Citizen.Wait(1)
        end
        return true
    end
    
    TextFloating = function(text, coord)
        AddTextEntry('FloatingHelpText', text)
        SetFloatingHelpTextWorldPosition(0, coord)
        SetFloatingHelpTextStyle(0, true, 2, -1, 3, 0)
        BeginTextCommandDisplayHelp('FloatingHelpText')
        EndTextCommandDisplayHelp(1, false, false, -1)
    end

    Text2D = function(font, x, y, text, scale)
        SetTextFont(font)
        SetTextProportional(7)
        SetTextScale(scale, scale)
        SetTextColour(255, 255, 255, 255)
        SetTextDropShadow(0, 0, 0, 0,255)
        SetTextEdge(4, 0, 0, 0, 255)
        SetTextEntry("STRING")
        AddTextComponentString(text)
        DrawText(x, y)
    end

    DrawText3Ds = function(x, y, z, text)
        local onScreen, _x, _y = World3dToScreen2d(x, y, z)
        if onScreen then
            SetTextScale(0.25, 0.25)
            SetTextFont(4)
            SetTextProportional(1)
            SetTextColour(255, 255, 255, 215)
            SetTextEntry("STRING")
            SetTextCentre(1)
            AddTextComponentString(text)
            DrawText(_x, _y)
            local factor = (string.len(text)) / 370
            -- DrawRect(_x, _y + 0.0125, 0.015 + factor, 0.03, 41, 11, 41, 68)
        end
    end
end