local Tunnel = module('zero','lib/Tunnel')
local Proxy = module('zero','lib/Proxy')
zero = Proxy.getInterface('zero')

srv = {}
Tunnel.bindInterface(GetCurrentResourceName(), srv)
Proxy.addInterface(GetCurrentResourceName(), srv)

srv.checkPermission = function(permissions)
    local user_id = zero.getUserId(source)
    if user_id then
        if permissions then
            if type(permissions) == 'table' then
                for i, perm in pairs(permissions) do
                    if zero.hasPermission(user_id, perm) then
                        return true
                    end
                end
                return false
            end
            return zero.hasPermission(user_id, permissions)
        end
        return true
    end
end