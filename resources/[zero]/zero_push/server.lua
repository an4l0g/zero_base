srv = {}
Tunnel.bindInterface(GetCurrentResourceName(), srv)

srv.checkPermission = function(perm)
    local source = source
    local user_id = zero.getUserId(source)
    if (user_id) then
        return zero.checkPermissions(user_id, perm)
    end
    return false
end