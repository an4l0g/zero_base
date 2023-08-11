Tunnel = module('zero','lib/Tunnel')
Proxy = module('zero','lib/Proxy')

if (IsDuplicityVersion()) then
    vRP = Tunnel.getInterface('zero')
    vRPClient = Proxy.getInterface('zero')
else
    vRP = Tunnel.getInterface('zero')
    vRPserver = Proxy.getInterface('zero')
end