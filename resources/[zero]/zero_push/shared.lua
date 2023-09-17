Tunnel = module('zero', 'lib/Tunnel')
Proxy = module('zero', 'lib/Proxy')
zero = Proxy.getInterface('zero')

if (IsDuplicityVersion()) then
    zero = Proxy.getInterface('zero')
else
    zero = Proxy.getInterface('zero')
end