srv = {}
Tunnel.bindInterface(GetCurrentResourceName(), srv)

srv.getLastPosition = function()
    local source = source
    local coords = vector3(-1648.84, -994.1143, 13.00293)
    if (source) then
        local datatable = zero.getUserDataTable(zero.getUserId(source))
        if (datatable) and datatable.position then
            local position = datatable.position
            coords = vector3(position.x, position.y, position.z)
        end
    end
    return coords
end