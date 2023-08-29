Tunnel = module('zero','lib/Tunnel')
Proxy = module('zero','lib/Proxy')
Tools = module('zero','lib/Tools')

zero = Proxy.getInterface('zero')

if (IsDuplicityVersion()) then
    zeroClient = Tunnel.getInterface('zero')
end