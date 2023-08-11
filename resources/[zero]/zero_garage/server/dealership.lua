local srv = {}
Tunnel.bindInterface('Dealership', srv)
local vCLIENT = Tunnel.getInterface('Dealership')

zero._prepare('zero_dealership/setStock', 'insert ignore into zero_dealership (car, stock) values (@car, @stock)')
zero._prepare('zero_dealership/getAll', 'select * from zero_dealership')
zero._prepare('zero_dealership/getVehStock', 'select stock from zero_dealership where car = @car')
zero._prepare('zero_dealership/updateVehStock', 'update zero_dealership set stock = @stock where car = @car')

local allVehicles = false

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
                    breaker = 100, 
                    transmission = 100, 
                    suspension = 100,
                    fuel = vehicleInfos.fuel,
                    stock = v.stock,
                    price = vehicleInfos.price
                })
            end
        end
        return allVehicles
    end
end

srv.buyVehicle = function(vehicle)
    local source = source
    local user_id = zero.getUserId(source)
    if (user_id) then
        local verifyVehicle = zero.query('zero_garage/getVehiclePlate', { user_id = user_id, vehicle = vehicle })[1]
        if (verifyVehicle) then TriggerClientEvent('notify', source, 'Concessionára', 'Você já possui este <b>veículo</b> em sua garagem.') return; end;

        local query = zero.query('zero_dealership/getVehStock', { car = vehicle })[1]
        if (query) then
            local _config = config.vehicles[vehicle]
            if (_config.type == 'vip') then return; end;
            if (_config) then
                if (zero.tryFullPayment(user_id, _config.price)) then
                    addVehicle(user_id, vehicle, 0)
                    TriggerClientEvent('notify', source, 'Concessionária', 'Sua compra foi <b>efetuada</b> com sucesso. Parabéns pela a sua nova requisiçao! O <b>'.._config.name..'</b> já se encontra em sua garagem.')
                    zero.execute('zero_dealership/updateVehStock', { stock = parseInt(query.stock - 1), car = vehicle })
                    zero.webhook('buyVehicle', '```prolog\n[DEALERSHIP]\n[ACTION] (BUY VEHICLE)\n[USER]: '..user_id..'\n[VEHICLE SPAWN]: '..vehicle..'\n[VEHICLE NAME] '.._config.name..'\n[VEHICLE MAKER]: '.._config.maker..'\n[PRICE]: '..zero.format(_config.price)..os.date('\n[DATA]: %d/%m/%Y [HORA]: %H:%M:%S')..' \r```')
                else
                    TriggerClientEvent('notify', source, 'Concessionária', 'Dinheiro <b>insuficiente</b>.')
                end
            end
        end
    end
end

local inTest = {}
srv.testDrive = function(vehicle)
    local source = source
    local user_id = zero.getUserId(source)
    if user_id then
        if not (inTest[user_id]) then
            local ply = GetPlayerPed(source)
            inTest[user_id] = {
                bucket = GetPlayerRoutingBucket(source),
                origin = GetEntityCoords(ply),
                health = GetEntityHealth(ply)
            }

            SetPlayerRoutingBucket(source, parseInt(1000 + user_id))
            vCLIENT.startTest(source, vehicle)
        end
    end
end

srv.exitTestDrive = function()
    local source = source
    local user_id = zero.getUserId(source)
    if (user_id) and inTest[user_id] then
        zeroClient.killComa(source)
        zeroClient.setHealth(source, inTest[user_id].health)
        SetPlayerRoutingBucket(source, inTest[user_id].bucket)
        SetEntityCoords(GetPlayerPed(source), inTest[user_id].origin)
        inTest[user_id] = nil
    end
end

RegisterNetEvent('zero_garage:CacheExecute', function(source, user_id, quit)
    SetPlayerRoutingBucket(source, 0)
    local health = inTest[user_id].health
    local coord = inTest[user_id].origin
    if (inTest[user_id]) then
        if (quit) then
            zero.updatePos(coord.x, coord.y, coord.z)
            zero.updateHealth(health)
        else
            zeroClient.teleport(source, coord.x, coord.y, coord.z)
            zeroClient.killComa(source)
            zeroClient.setHealth(source, health)
        end
    end
end)

AddEventHandler('onResourceStop', function(resourceName)
  	if (GetCurrentResourceName() == resourceName) then 
		print('^5[Zero Garage]^7 sistema stopado/reiniciado.')
        for k, _ in pairs(inTest) do
            local user_id = k
            local _source = zero.getUserSource(user_id)
            if (user_id) then
                TriggerEvent('zero_garage:CacheExecute', _source, k)
                TriggerClientEvent('notify', _source, 'Concessionária', 'O sistema de <b>garagem</b> da nossa cidade foi reiniciado.')
                print('^5[Zero Homes]^7 o user_id ^5('..user_id..')^7 foi retirado de dentro do test drive.')
                inTest[user_id] = nil
            end
        end
	end
end)

AddEventHandler('zero:playerLeave', function(user_id, source)
	if (inTest[user_id]) then
        TriggerEvent('zero_garage:CacheExecute', source, user_id, true)
        print('^5[Zero Homes]^7 o user_id ^5('..user_id..')^7 foi retirado de dentro do test drive.')
        inTest[user_id] = nil
    end
end)