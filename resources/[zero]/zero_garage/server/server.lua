local srv = {}
Tunnel.bindInterface('zeroGarage', srv)
local vCLIENT = Tunnel.getInterface('zeroGarage')

local garagesConfig = config.garages
local rulesConfig = config.rules

zero._prepare('zero_garage/getVehicles', 'select * from zero_user_vehicles where user_id = @user_id')

srv.checkPermissions = function(perm)
    local source = source
    local user_id = zero.getUserId(source)
    if (user_id) then
        if (perm) then
            if (type(perm) == 'table') then
                for _, perm in pairs(perm) do
                    if (zero.hasPermission(user_id, perm)) then
                        return true
                    end
                end
                return false
            end
            return zero.hasPermission(user_id, perm)
        end
        return true
    end
end

srv.processState = function(state)
    if (state and state.data and state.data.engineHealth) then return state; end;
    return { windows = {}, doors = {}, tyres = {}, data = {} }
end

srv.getMyVehicles = function(id)
    local source = source
    local user_id = zero.getUserId(source)
    local myVehicles = {}
    if (user_id) then
        if (garagesConfig[id]) then
            local gInfo = garagesConfig[id]
            local vehicles = zero.query('zero_garage/getVehicles', { user_id = user_id })
            for index, value in pairs(vehicles) do
                if (value.service == 0) then
                    local add = true
                    if (gInfo.rule and rulesConfig[gInfo.rule]) then
                        local gRule = rulesConfig[gInfo.rule]
                        local vclass = vehicleClass(value.vehicle)
                        if (gRule.show_classes) then
                            add = false
                            if (gRule.show_classes[vclass´]) then add = true; end;
                        end
                        if (add and gRule.hide_classes) then
                            if (gRule.hide_classes[vclass]) then add = false; end;
                        end
                    end

                    if (add) then
                        local vehicleInfos = { vname = vehicleName(value.vehicle), vmaker = vehicleMaker(value.vehicle), vtype = vehicleType(value.vehicle), vtrunk = vehicleSize(value.vehicle), engine = 1000, body = 1000, fuel = 100 }
                        local state = srv.processState(json.decode(value.state))
                        if (state.data.engineHealth) then vehicleInfos.engine, vehicleInfos.body, vehicleInfos.fuel = state.data.engineHealth, state.data.bodyHealth, state.data.fuel end;
                        table.insert(myVehicles, {
                            type = vehicleInfos.vtype,
                            spawn = value.vehicle,
                            name = vehicleInfos.vname,
                            maker = vehicleInfos.vmaker,
                            trunk_capacity = vehicleInfos.vtrunk, 
                            trunk = 85, 
                            engine = vehicleInfos.engine, 
                            breaker = 90, 
                            transmission = 75, 
                            suspension = 90, 
                            fuel = vehicleInfos.fuel
                        })
                    end
                end
            end
            return myVehicles
        end
    end
end

local vehiclesConfig = config.vehicles

vehicleName = function(vehicle)
    return (vehiclesConfig[vehicle].name or 'Não identificado')
end
exports('vehicleName', vehicleName)

vehicleMaker = function(vehicle)
    return (vehiclesConfig[vehicle].maker or 'Não identificado')
end
exports('vehicleMaker', vehicleMaker)

vehicleType = function(vehicle)
    return (vehiclesConfig[vehicle].type or 'Não identificado')
end
exports('vehicleType', vehicleType)

vehicleSize = function(vehicle)
    return (vehiclesConfig[vehicle].trunk or 0)
end
exports('vehicleSize', vehicleSize)

vehicleClass = function(vehicle)
    return (vehiclesConfig[vehicle].class or 'Não identificado')
end
exports('vehicleClass', vehicleClass)