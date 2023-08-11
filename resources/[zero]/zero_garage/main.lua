Proxy = module('zero', 'lib/Proxy')
Tunnel = module('zero', 'lib/Tunnel')

config = {}

if (IsDuplicityVersion()) then
    zero = Proxy.getInterface('zero')
    zeroClient = Tunnel.getInterface('zero')
else
    zero = Proxy.getInterface('zero')
    zeroServer = Tunnel.getInterface('zero')

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
end
