local srv = {}
Tunnel.bindInterface('Dealership', srv)

zero._prepare('zero_dealership/setStock', 'insert ignore into zero_dealership (car, stock) values (@car, @stock)')
zero._prepare('zero_dealership/getAll', 'select * from zero_dealership')

local allVehicles;
srv.getStock = function()
    local query = zero.query('zero_dealership/getAll')
    if (query) then
        if (not allVehicles) then
            allVehicles = {}
            for _, v in pairs(query) do
                local vehicleInfos = { vname = vehicleName(v.car), vmaker = vehicleMaker(v.car), vtype = vehicleType(v.car), vtrunk = vehicleSize(v.car), price = vehiclePrice(v.car), engine = 1000, body = 1000, fuel = 100 }
                table.insert(allVehicles, {
                    type = vehicleInfos.vtype,
                    spawn = v.car,
                    name = vehicleInfos.vname,
                    maker = vehicleInfos.vmaker,
                    trunk_capacity = vehicleInfos.vtrunk, 
                    engine = vehicleInfos.engine, 
                    breaker = getMods(v.custom, '12'), 
                    transmission = getMods(v.custom, '13'), 
                    suspension = getMods(v.custom, '15'),
                    fuel = vehicleInfos.fuel,
                    stock = v.stock,
                    price = vehicleInfos.price
                })
            end
        end
        return allVehicles
    end
end