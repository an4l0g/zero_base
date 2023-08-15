Tunnel = module('zero', 'lib/Tunnel')
Proxy = module('zero', 'lib/Proxy')
Tools = module('zero', 'lib/Tools')

zero = {}
Proxy.addInterface('zero', zero)
Tunnel.bindInterface('zero', zero)
exportTable(zero)

vRP = {}
Proxy.addInterface('vRP', vRP)
Tunnel.bindInterface('vRP', vRP)
exportTable(vRP)

config = {}

if (IsDuplicityVersion()) then
    zeroClient = Tunnel.getInterface('zero')
else
    zeroServer = Tunnel.getInterface('zero')
end