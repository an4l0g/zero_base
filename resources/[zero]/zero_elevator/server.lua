local Tunnel = module('vrp','lib/Tunnel')
local Proxy = module('vrp','lib/Proxy')
vRP = Proxy.getInterface('vRP')

srv = {}
Tunnel.bindInterface(GetCurrentResourceName(), srv)
Proxy.addInterface(GetCurrentResourceName(), srv)

srv.checkPermission = function(permissions)
    local user_id = vRP.getUserId(source)
    if user_id then
        if permissions then
            if type(permissions) == 'table' then
                for i, perm in pairs(permissions) do
                    if vRP.hasPermission(user_id, perm) then
                        return true
                    end
                end
                return false
            end
            return vRP.hasPermission(user_id, permissions)
        end
        return true
    end
end