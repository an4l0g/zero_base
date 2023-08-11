Tunnel = module('zero','lib/Tunnel')
Proxy = module('zero','lib/Proxy')

if (IsDuplicityVersion()) then
    vRP = Proxy.getInterface('zero')
    vRPClient = Tunnel.getInterface('zero')
else
    vRP = Proxy.getInterface('zero')
    vRPserver = Tunnel.getInterface('zero')
end