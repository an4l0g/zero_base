local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")

srv = {}
Tunnel.bindInterface(GetCurrentResourceName(), srv)
cli = Tunnel.getInterface(GetCurrentResourceName())

srv.checkPermission = function(permission)
    local _source = source
    local _userId = vRP.getUserId(_source)
    if (_userId) and vRP.hasPermission(_userId, permission) then
        return true
    end
    return false
end