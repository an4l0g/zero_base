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
end