Tunnel = module('zero', 'lib/Tunnel')
Proxy = module('zero', 'lib/Proxy')
Tools = module('zero', 'lib/Tools')

zero = {}
Proxy.addInterface('zero', zero)
Tunnel.bindInterface('zero', zero)
exportTable(zero)

config = {}

if (IsDuplicityVersion()) then
    zeroClient = Tunnel.getInterface('zero')
else
    zeroServer = Tunnel.getInterface('zero')
end