srv = {}
Tunnel.bindInterface(GetCurrentResourceName(), srv)

srv.tryEnterHome = function(home)
    local _source = source
    local _userId = vRP.getUserId(_source)
    if (_userId and home) then
        -- local consultHome = 
    end
end