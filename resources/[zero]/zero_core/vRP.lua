-- Libraries
Tunnel = module('zero','lib/Tunnel')
Proxy = module('zero','lib/Proxy')
Tools = module('zero','lib/Tools')

--Globals
config = {}
webhooks = {}

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

    Text3D = function(x,y,z,text,size)
        local onScreen,_x,_y = World3dToScreen2d(x,y,z)
        SetTextFont(4)
        SetTextScale(0.35,0.35)
        SetTextColour(255,255,255,155)
        SetTextEntry('STRING')
        SetTextCentre(1)
        AddTextComponentString(text)
        DrawText(_x,_y)
        local factor = (string.len(text))/size
        DrawRect(_x,_y+0.0125,0.01+factor,0.03,0,0,0,80)
    end
end