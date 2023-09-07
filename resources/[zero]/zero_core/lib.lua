-- Libraries
Tunnel = module('zero','lib/Tunnel')
Proxy = module('zero','lib/Proxy')
Tools = module('zero','lib/Tools')

-- Proxies
if IsDuplicityVersion() then
    zero = Proxy.getInterface('zero')
    zeroClient = Tunnel.getInterface('zero')
    idgens = Tools.newIDGenerator()
else
    zero = Proxy.getInterface('zero')
    zeroServer = Tunnel.getInterface('zero')

    drawTxt = function(text,font,x,y,scale,r,g,b,a)
        SetTextFont(font)
        SetTextScale(scale,scale)
        SetTextColour(r,g,b,a)
        SetTextOutline()
        SetTextCentre(1)
        SetTextEntry('STRING')
        AddTextComponentString(text)
        DrawText(x,y)
    end
    
    TextFloating = function(text, coord)
        AddTextEntry('FloatingHelpText', text)
        SetFloatingHelpTextWorldPosition(0, coord)
        SetFloatingHelpTextStyle(0, true, 2, -1, 3, 0)
        BeginTextCommandDisplayHelp('FloatingHelpText')
        EndTextCommandDisplayHelp(1, false, false, -1)
    end

    DrawText3Ds = function(x, y, z, text)
        local onScreen, _x, _y = World3dToScreen2d(x, y, z)
        if onScreen then
            SetTextScale(0.3, 0.3)
            SetTextFont(4)
            SetTextProportional(1)
            SetTextOutline(1)
            SetTextColour(255, 255, 255, 215)
            SetTextEntry("STRING")
            SetTextCentre(1)
            AddTextComponentString(text)
            DrawText(_x, _y)
            local factor = (string.len(text)) / 370
        end
    end
end