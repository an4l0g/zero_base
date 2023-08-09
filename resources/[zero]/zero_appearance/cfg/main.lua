Tunnel = module('zero', 'lib/Tunnel')
Proxy = module('zero', 'lib/Proxy')
zero = Proxy.getInterface('zero')

if (IsDuplicityVersion()) then
    zeroClient = Tunnel.getInterface('zero')
end