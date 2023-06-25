Tunnel = module('zero', 'lib/Tunnel')
Proxy = module('zero', 'lib/Proxy')

if IsDuplicityVersion() then
    zero = Proxy.getInterface('zero')
    zeroClient = Tunnel.getInterface('zero')
else
    zero = Proxy.getInterface('zero')
    zeroServer = Tunnel.getInterface('zero')
end