local srv = {}
Tunnel.bindInterface('Dealership', srv)

zero._prepare('zero_dealership/getAll', 'select * from zero_dealership')

srv.getStock = function()
    local allVehicles = {}
    local query = zero.query('zero_dealership/getAll')
    if (query) then
        for _, v in pairs(query) do
            local vehicleInfos = { vname = vehicleName(v.car), vmaker = vehicleMaker(v.car), vtype = vehicleType(v.car), vtrunk = vehicleSize(v.car), engine = 1000, body = 1000, fuel = 100 }
            table.insert(allVehicles, {
                type = vehicleInfos.vtype,
                spawn = v.car,
                name = vehicleInfos.vname,
                maker = vehicleInfos.vmaker,
                trunk_capacity = vehicleInfos.vtrunk, 
                trunk = 85, 
                engine = vehicleInfos.engine, 
                breaker = 90, 
                transmission = 75, 
                suspension = 90, 
                fuel = vehicleInfos.fuel,
                stock = v.stock
            })
        end
        return allVehicles
    end
end