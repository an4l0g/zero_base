local Tunnel = module("zero","lib/Tunnel")
local Proxy = module("zero","lib/Proxy")
vRP = Proxy.getInterface("vRP")

srv = {}
Tunnel.bindInterface(GetCurrentResourceName(), srv)
cli = Tunnel.getInterface(GetCurrentResourceName())

srv.checkPermission = function(permission)
    local _source = source
    local _userId = zero.getUserId(_source)
    if (_userId) and zero.hasPermission(_userId, permission) then
        return true
    end
    return false
end