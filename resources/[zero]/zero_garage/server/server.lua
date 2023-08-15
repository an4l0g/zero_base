local srv = {}
Tunnel.bindInterface('Garage', srv)
local vCLIENT = Tunnel.getInterface('Garage')

local garagesConfig = config.garages
local rulesConfig = config.rules

zero._prepare('zero_garage/getVehicles', 'select * from user_vehicles where user_id = @user_id')
zero._prepare('zero_garage/getVehiclesWithVeh', 'select * from user_vehicles where user_id = @user_id and vehicle = @vehicle')
zero._prepare('zero_garage/getVehiclesWithPlate', 'select * from user_vehicles where plate = @plate')
zero._prepare('zero_garage/getVehiclesWithChassis', 'select * from user_vehicles where chassis = @chassis')
zero._prepare('zero_garage/setDetained', 'update user_vehicles set detained = @detained where user_id = @user_id and vehicle = @vehicle')
zero._prepare('zero_garage/setIPVA', 'update user_vehicles set ipva = @ipva where user_id = @user_id and vehicle = @vehicle')
zero._prepare('zero_garage/updateState', 'update user_vehicles set state = @state where user_id = @user_id and vehicle = @vehicle')
zero._prepare('zero_garage/getVehiclePlate', 'select plate from user_vehicles where user_id = @user_id and vehicle = @vehicle')
zero._prepare('zero_garage/delVehicle', 'delete from user_vehicles where user_id = @user_id and vehicle = @vehicle')
zero._prepare('zero_garage/setRented', 'update user_vehicles set rented = @rented where user_id = @user_id and vehicle = @vehicle')
zero._prepare('zero_garage/getVehicleWithPlate', 'select user_id, vehicle from user_vehicles where plate = @plate')
zero._prepare('zero_garage/updatePlate', 'update user_vehicles set plate = @plate where user_id = @user_id and vehicle = @vehicle')
zero._prepare('zero_garage/getVehicleOwn', 'select * from user_vehicles where user_id = @user_id and service = 0')
zero._prepare('zero_garage/getGarages', 'select garages from users where id = @id')
zero._prepare('zero_garage/getVehByPlate', 'select * from user_vehicles where plate = @plate')
zero._prepare('zero_garage/getVehByChassis', 'select * from user_vehicles where chassis = @chassis')
zero._prepare('zero_garage/getRented', 'select user_id, vehicle, rented from user_vehicles where rented != ""')
zero._prepare('zero_garage/addVehicle', 'insert ignore into user_vehicles (user_id, vehicle, plate, chassis, service, ipva, state, custom) values (@user_id, @vehicle, @plate, @chassis, @service, @ipva, @state, @custom)')

Citizen.CreateThread(function()
    Citizen.Wait(1000)
	for user_id, source in pairs(zero.getUsers()) do
		local myHomes = zero.query('zero_homes/userHomesList', { user_id = user_id })
        for k,v in ipairs(myHomes) do
            local gar = zero.query('zero_homes/getGarage', { home = v.home })[1]
            if (gar) then
                local blip = json.decode(gar.blip)
                local spawn = json.decode(gar.spawn)
                addGarage(source, v.home, blip, spawn )
            end
        end
		Citizen.Wait(1)
	end
end)

local permission = {
    ['perm'] = function(user_id, perm, home)
        return zero.checkPermissions(user_id, perm)
    end,
    ['home'] = function(user_id, perm, home)
        return exports['zero_homes']:checkHomePermission(user_id, home)
    end
}

srv.checkPermissions = function(perm, home)
    local source = source
    local user_id = zero.getUserId(source)
    if (user_id) then
        local isHome = (home and 'home' or 'perm')
        return permission[isHome](user_id, perm, home)
    end
end

srv.getVehiclePlate = function(vehicle)
    local source = source
    local user_id = zero.getUserId(source)
    if (user_id) then
        local query = zero.query('zero_garage/getVehiclePlate', { user_id = user_id, vehicle = vehicle })[1]
        if (query) then
            return query.plate
        end
    end
end

srv.getVehicleData = function(vehnet)
	if (vehnet and NetworkGetEntityFromNetworkId(vehnet)) then
		local vehicle = NetworkGetEntityFromNetworkId(vehnet)
		if (DoesEntityExist(vehicle)) then
			local stateBag = Entity(vehicle).state
			local statePlate = stateBag['veh:plate']
			local stateChassis = stateBag['veh:chassis']
			local stateUser = stateBag['veh:user_id']
			local stateModel = stateBag['veh:model']
			local stateService = stateBag['veh:service']
			local stateClone = stateBag['veh:clone']
			local spawning = stateBag['veh:spawning']
			return { user_id = stateUser, model = stateModel, plate = statePlate, chassis = stateChassis,  service = stateService, clone = stateClone, spawning = spawning }
		end
	end
	return {}
end
exports('getVehicleData', srv.getVehicleData)

srv.processState = function(state)
    if (state and state.data and state.data.engineHealth) then return state; end;
    return { windows = {}, doors = {}, tyres = {}, data = {} }
end

getMods = function(custom, mod)
    local data = json.decode(custom)
    if (data) and data.mods then
        return countMods(data.mods[mod].mod, mod)
    end
end

getCarTrunkWeight = function(user_id, vehicle, capacity)
    local bag = exports['zero_inventory']:getBag('trunk:'..vehicle..':'..user_id)
    local weight = 0
    for _, v in pairs(bag) do
        weight = weight + v.weight * v.amount
    end
    if (weight > 0) then return (parseInt((weight / capacity) * 100)); end;
end

countMods = function(value, mod)
    if (value == -1) then value = 0; end;
    local mods = {
        ['12'] = function(value)
            return parseInt(value * 50)
        end,
        ['13'] = function(value)
            return parseInt(value * 50)
        end,
        ['15'] = function(value)
            return parseInt(value * 33.3333333333)
        end
    }
    return mods[mod](value)
end

local vehicles = {
    ['service'] = function(source, user_id, myVehicles, gInfo)
        for _, v in pairs(gInfo.vehicles) do
            local vehicleInfos = {
                vname = vehicleName(v),
                vmaker = vehicleMaker(v),
                vtype = vehicleType(v), 
                vtrunk = vehicleSize(v), 
                engine = 1000, 
                body = 1000, 
                fuel = 100
            }

            local data = zero.query('zero_garage/getVehiclesWithVeh', { user_id = user_id, vehicle = v })
            if (data) then
                local state = srv.processState(json.decode(data.state))
                if (state.data) and state.data.engineHealth then 
                    vehicleInfos.engine, vehicleInfos.body, vehicleInfos.fuel = state.data.engineHealth, state.data.bodyHealth, state.data.fuel 
                end

                table.insert(myVehicles, {
                    type = vehicleInfos.vtype,
                    spawn = v,
                    name = vehicleInfos.vname,
                    maker = vehicleInfos.vmaker,
                    trunk_capacity = vehicleInfos.vtrunk, 
                    trunk = getCarTrunkWeight(user_id, v, vehicleInfos.vtrunk), 
                    engine = vehicleInfos.engine, 
                    breaker = getMods(data.custom, '12'), 
                    transmission = getMods(data.custom, '13'), 
                    suspension = getMods(data.custom, '15'),
                    fuel = vehicleInfos.fuel
                })
            end
        end
        return myVehicles
    end,
    ['normal'] = function(source, user_id, myVehicles, gInfo)
        local vehicles = zero.query('zero_garage/getVehicles', { user_id = user_id })
        for _, v in pairs(vehicles) do
            if (v.service == 0) then
                local add = true
                if (gInfo.rule and rulesConfig[gInfo.rule]) then
                    local gRule = rulesConfig[gInfo.rule]
                    local vclass = vehicleClass(v.vehicle)
                    if (gRule.show_classes) then
                        add = false
                        if (gRule.show_classes[vclass]) then add = true; end;
                    end
                    if (add and gRule.hide_classes) then
                        if (gRule.hide_classes[vclass]) then add = false; end;
                    end
                end

                if (add) then
                    local vehicleInfos = { 
                        vname = vehicleName(v.vehicle), 
                        vmaker = vehicleMaker(v.vehicle), 
                        vtype = vehicleType(v.vehicle), 
                        vtrunk = vehicleSize(v.vehicle), 
                        engine = 1000, 
                        body = 1000, 
                        fuel = 100 
                    }

                    local state = srv.processState(json.decode(v.state))
                    if (state.data.engineHealth) then 
                        vehicleInfos.engine, vehicleInfos.body, vehicleInfos.fuel = state.data.engineHealth, state.data.bodyHealth, state.data.fuel 
                    end

                    table.insert(myVehicles, {
                        type = vehicleInfos.vtype,
                        spawn = v.vehicle,
                        name = vehicleInfos.vname,
                        maker = vehicleInfos.vmaker,
                        trunk_capacity = vehicleInfos.vtrunk, 
                        trunk = getCarTrunkWeight(user_id, v.vehicle, vehicleInfos.vtrunk), 
                        engine = vehicleInfos.engine, 
                        breaker = getMods(v.custom, '12'), 
                        transmission = getMods(v.custom, '13'), 
                        suspension = getMods(v.custom, '15'),
                        fuel = vehicleInfos.fuel
                    })
                end
            end
        end
        return myVehicles
    end,
}

srv.getMyVehicles = function(id)
    local source = source
    local user_id = zero.getUserId(source)
    local myVehicles = {}
    if (user_id) then
        if (garagesConfig[id]) then
            local gInfo = garagesConfig[id]
            local variable = (gInfo.vehicles and 'service' or 'normal')
            return vehicles[variable](source, user_id, myVehicles, gInfo)
        end
    end
end

local findVehicle = function(user_id, model)
    for _, vehicle in ipairs(GetAllVehicles()) do
        local state = Entity(vehicle).state
        if (state['veh:user_id'] == user_id) and (state['veh:model'] == model) then return vehicle; end;
    end
end

local setDetained = function(user_id, vehicle, number)
    zero.execute('zero_garage/setDetained', { user_id = user_id, vehicle = vehicle, detained = number })
end

local spawnTasks = {}
local vehicleDetained = {
    [0] = function()
        return true
    end,
    [1] = function(source, user_id, vehicle)
        TriggerClientEvent('notify', source, 'Garagem', 'O seu veículo foi desmanchado e perdeu <b>tunagem</b>', 15000)
        local value = parseInt(vehiclePrice(vehicle) * config.taxDetained)
        local request = zero.request(source, 'Veículo na detenção, deseja acionar o seguro pagando R$'..zero.format(value)..'?', 60000)
        if (request) then
            if (zero.tryFullPayment(user_id, value)) then
                setDetained(user_id, vehicle, 0)
                TriggerClientEvent('notify', source, 'Garagem', 'O <b>pagamento</b> foi efetuado com sucesso.')
                return true
            end
            TriggerClientEvent('notify', source, 'Garagem', 'Você não possui <b>dinheiro</b> suficiente para este pagamento.')
        end
        return false
    end,
    [2] = function(source, user_id, vehicle)
        local value = parseInt(vehiclePrice(vehicle) * config.taxSafe)
        local request = zero.request(source, 'Veículo na retenção, deseja acionar o seguro pagando R$'..zero.format(value)..'?', 60000)
        if (request) then
            if (zero.tryFullPayment(user_id, value)) then
                setDetained(user_id, vehicle, 0)
                TriggerClientEvent('notify', source, 'Garagem', 'O <b>pagamento</b> foi efetuado com sucesso.')
                return true
            end
            TriggerClientEvent('notify', source, 'Garagem', 'Você não possui <b>dinheiro</b> suficiente para este pagamento.')
        end
        return false
    end
}

srv.spawnVehicle = function(vehicle, id)
    local source = source
    local user_id = zero.getUserId(source)
    local identity = zero.getUserIdentity(user_id)
    if vehicle and (not spawnTasks[source]) then
        spawnTasks[source] = true
        if (user_id) then
            if (not findVehicle(user_id, vehicle)) then
                local veh = zero.query('zero_garage/getVehiclesWithVeh', { user_id = user_id, vehicle = vehicle })[1]
                if (not veh) then
                    addVehicle(user_id, vehicle, 1)
                    veh = zero.query('zero_garage/getVehiclesWithVeh', { user_id = user_id, vehicle = vehicle })[1]
                end

                if (veh.service == 0) then
                    if (exports['zero_bank']:verifyMultas(user_id) > 0) then
                        TriggerClientEvent('notify', source, 'Garagem', 'Você não pode retirar um veículo da garagem tendo multas em sua conta.')
                        return
                    end

                    local detained = vehicleDetained[(veh.detained)](source, user_id, vehicle)
                    if (not detained) then return; end;

                    if (os.time() >= parseInt(veh.ipva + (config.ipvaDays * 24 * 60 * 60))) then
                        local priceTax = parseInt(vehiclePrice(vehicle) * config.taxIPVA)
                        local request = zero.request(source, 'Deseja pagar o Vehicle Tax do veículo '..vehicleName(vehicle)..' por R$'..zero.format(priceTax)..'?', 60000)
                        if (request) then
                            if (zero.tryFullPayment(user_id, priceTax)) then
                                zero.execute('zero_garage/setIPVA', { user_id = user_id, vehicle = vehicle, ipva = os.time() })
                                TriggerClientEvent('notify', source, 'Garagem', 'O <b>pagamento</b> foi efetuado com sucesso.')
                            end
                            TriggerClientEvent('notify', source, 'Garagem', 'Você não possui <b>dinheiro</b> suficiente para este pagamento.')
                        end
                        return
                    end
                end

                local vehicleFuel = 100.0
                local state = srv.processState(json.decode(veh.state))
                if (state.data.fuel) then vehicleFuel = state.data.fuel; end;

                local loadModel = vCLIENT.loadModel(source, vehicle, 30000, 60000)
                if (loadModel) then
                    local slot, coords, heading = vCLIENT.getFreeSlot(source, id)
                    if (slot) then
                        local vehHandle;
                        if (garagesConfig.clientSpawn or garagesConfig.clientSpawnForced) then
                            local vehNet = vCLIENT.clientSpawn(source, GetHashKey(vehicle), vector3(coords.x, coords.y, coords.z - 0.5), heading, veh.plate)
                            vehHandle = NetworkGetEntityFromNetworkId(vehNet)
                            while (vehHandle == 0) do vehHandle = NetworkGetEntityFromNetworkId(vehNet) Citizen.Wait(40) end;
                        else
                            vehHandle = Citizen.InvokeNative(`CREATE_AUTOMOBILE`, GetHashKey(vehicle), vector3(coords.x, coords.y, coords.z - 0.3), heading)
                        end

                        if vehHandle and (vehHandle > 0) then
                            if _Regis then _Regis(vehHandle) end

                            local owner = NetworkGetEntityOwner(vehHandle)
                            while (owner == -1) do
                                owner = (DoesEntityExist(vehHandle) and NetworkGetEntityOwner(vehHandle))
                                Citizen.Wait(1)
                            end
                            if (not owner) then return; end;

                            SetVehicleNumberPlateText(vehHandle, veh.plate)
                            SetVehicleDoorsLocked(vehHandle, 2)

                            local netHandle;
                            local timeOut = (GetGameTimer() + 2000)
                            while (DoesEntityExist(vehHandle) and not netHandle and GetGameTimer() < timeOut) do
                                netHandle = DoesEntityExist(vehHandle) and NetworkGetNetworkIdFromEntity(vehHandle)
                                Citizen.Wait(1)
                            end
                            if (not netHandle) then return; end;

                            Entity(vehHandle).state['veh:plate'] = veh.plate
                            Entity(vehHandle).state['veh:chassis'] = veh.chassis
                            Entity(vehHandle).state['veh:user_id'] = user_id
                            Entity(vehHandle).state['veh:model'] = vehicle
                            Entity(vehHandle).state['veh:service'] = (veh.service == 1)
                            Entity(vehHandle).state['veh:fuel'] = vehicleFuel
                            Entity(vehHandle).state['veh:spawning'] = true

                            TriggerClientEvent('notify', source, 'Garagem', 'O <b>veículo</b> foi liberado com sucesso.')
                            vCLIENT.syncBlips(source, netHandle, vehicle)
                            vCLIENT.settingVehicle(source, netHandle, state, veh.plate, json.decode(veh.custom))
                        end
                    else
                        TriggerClientEvent('notify', source, 'Garagem', 'Todas as <b>vagas</b> se encontram ocupadas no momento.')
                    end
                else
                    TriggerClientEvent('notify', source, 'Garagem', 'O <b>veículo</b> se encontra indisponível no momento.')
                end
            else
                TriggerClientEvent('notify', source, 'Garagem', 'Você já possui um <b>veículo</b> deste modelo fora da garagem.')
            end
        end
    end
    spawnTasks[source] = nil
end

srv.tryDelete = function(vehnet, state)
	if vehnet then
		local vehState = srv.getVehicleData(vehnet)
		if (vehState.user_id) then
			local player = zero.getUserSource(vehState.user_id)
			if player then vCLIENT.removeGPSVehicle(player, vehState.model); end;
			if state and (not vehState.spawning) then
				local vehicle = zero.query('zero_garage/getVehiclesWithVeh', { user_id = vehState.user_id, vehicle = vehState.model })
				if (vehicle[1]) then
					zero.execute('zero_garage/updateState', { user_id = vehState.user_id, vehicle = vehState.model, state = json.encode(state) })
				end
			end
		end
	end
	deleteVehicle(vehnet)
end

deleteVehicle = function(vehnet)
    local entity = NetworkGetEntityFromNetworkId(vehnet)
    if entity and (GetEntityType(entity) == 2) then
        DeleteEntity(entity)
    end
end

carKeys = {}

srv.vehicleLock = function()
    local source = source
    local user_id = zero.getUserId(source)
    if (user_id) then
        local cveh, vnetid, placa, vname, lock, banned = zeroClient.vehList(source, 7.5)
        if (vnetid and vname) then
            local vehState = srv.getVehicleData(vnetid)
            if (user_id == vehState.user_id) or (user_id == carKeys[vnetid]) then
                vCLIENT.vehicleClientLock(-1, vnetid, lock)
                if (not zeroClient.isInVehicle(source)) then zeroClient._playAnim(source, true, {{ 'anim@mp_player_intmenu@key_fob@', 'fob_click' }}, false); end;
                TriggerClientEvent('zero_sound:vehicle', -1, vnetid, 15.0, 'lock', 0.05)
                if (lock == 1) then
                    TriggerClientEvent('notify', source, 'Garagem', 'O veículo foi <b>trancado</b> com sucesso.', 1000)
                else
                    TriggerClientEvent('notify', source, 'Garagem', 'O veículo foi <b>destrancado</b> com sucesso.', 1000)
                end
            end
        end
    end
end

lockVehicle = function(vnetid, lock)
    vCLIENT.vehicleClientLock(-1, vnetid, lock)
end
exports('vehicleLock', lockVehicle)

RegisterCommand('dv', function(source)
    local user_id = zero.getUserId(source)
    local identity = zero.getUserIdentity(user_id)
    if (user_id) and zero.hasPermission(user_id, 'staff.permissao') then
        local vehicle, vnetid = zeroClient.vehList(source, 7)
        if (vnetid) then
            local vehState = srv.getVehicleData(vnetid)
            vCLIENT.tryDeleteVehicle(source, vnetid)
            zero.webhook('DeleteVehicle', '```prolog\n[PASSAPORTE]: #'..user_id..' '..identity.firstname..' '..identity.lastname..' \n[USOU]: /dv\n[EM]: '..vehState.model..' \n[DONO]: '..vehState.user_id..'\n[XYZ]: '..tostring(GetEntityCoords(GetPlayerPed(source)))..os.date('\n[DATA]: %d/%m/%Y [HORA]: %H:%M:%S')..' \r```')
        end
    end
end)

RegisterCommand('dvarea', function(source)
    local source = source
    local user_id = zero.getUserId(source)
    local identity = zero.getUserIdentity(source)
    if (user_id) and zero.hasPermission(user_id, 'staff.permissao') then
        local prompt = zero.prompt(source, { 'Distância' })
        if (prompt[1]) then
            prompt[1] = parseInt(prompt[1])
            local getVehicles = zeroClient.getNearestVehicles(source, prompt[1])
            local deleteCount = 0
            for veh, _ in pairs(getVehicles) do
                local vnetid = vCLIENT.returnToNet(source, veh)
                local vehicle = NetworkGetEntityFromNetworkId(vnetid)
                local ped = GetPedInVehicleSeat(vehicle, -1)
                if (not ped or ped <= 0) then
                    vCLIENT.tryDeleteVehicle(source, vnetid)
                    deleteCount = deleteCount + 1
                end
            end
            TriggerClientEvent('notify', source, 'Garagem', 'Foram deletados <b>'..deleteCount..'</b> veículos.')
            zero.webhook('DVArea', '```prolog\n[/DVAREA]\n[STAFF]: #'..user_id..' '..identity.firstname..' '..identity.lastname..'\n[DELETOU]: '..deleteCount..' veículos\n[RADIUS]: '..prompt[1]..'\n[XYZ]: '..tostring(GetEntityCoords(GetPlayerPed(source)))..os.date('\n[DATA]: %d/%m/%Y [HORA]: %H:%M:%S')..' \r```')
        end
    end
end)

RegisterCommand('dvall', function(source)
    local source = source
    local user_id = zero.getUserId(source)
    local identity = zero.getUserIdentity(user_id)
    if (user_id) and zero.hasPermission(user_id, 'staff.permissao') then
        TriggerClientEvent('announcement', -1, 'Garagem', 'Todos os <b>veículos</b> que não possuem alguém dentro, serão deletados em <b>60 segundos</b>.', 'Prefeitura', true, 10000)
        Citizen.Wait(30000)
        TriggerClientEvent('announcement', -1, 'Garagem', 'Todos os <b>veículos</b> que não possuem alguém dentro, serão deletados em <b>30 segundos</b>.', 'Prefeitura', true, 10000)
        Citizen.Wait(30000)
        local deleteCount = 0
        for _, veh in ipairs(GetAllVehicles()) do
            local ped = GetPedInVehicleSeat(veh, -1)
            if (not ped or ped <= 0) then 
                DeleteEntity(veh)     
                deleteCount = deleteCount + 1
            end
        end
        TriggerClientEvent('announcement', -1, 'Garagem', 'Foram deletados <b>'..deleteCount..'</b> veículos.')
        zero.webhook('DVAll', '```prolog\n[/DVALL]\n[STAFF]: #'..user_id..' '..identity.firstname..' '..identity.lastname..'\n[DELETOU]: '..deleteCount..' veículos\n[XYZ]: '..tostring(GetEntityCoords(GetPlayerPed(source)))..os.date('\n[DATA]: %d/%m/%Y [HORA]: %H:%M:%S')..' \r```')
    end
end)

RegisterCommand('addcar', function(source)
    local source = source
    local user_id = zero.getUserId(source)
    local identity = zero.getUserIdentity(source)
    if (user_id) and zero.hasPermission(user_id, '+Staff.COO') then
        local prompt = zero.prompt(source, { 'Passaporte', 'Veículo' })
        if (prompt) then
            if (prompt[1] and prompt[2]) then
                prompt[1] = parseInt(prompt[1])
                if (vehiclesConfig[prompt[2]]) then
                    addVehicle(prompt[1], prompt[2])
                    TriggerClientEvent('notify', source, 'Garagem', 'Você adicionou o veículo <b>'..prompt[2]..'</b> para o id <b>'..prompt[1]..'</b>.')
                    local nIdentity = zero.getUserIdentity(prompt[1])
                    zero.webhook('AddCar', '```prolog\n[/ADDCAR]\n[STAFF]: #'..user_id..' '..identity.firstname..' '..identity.lastname..'\n[JOGADOR]: #'..prompt[1]..' '..nIdentity.firstname..' '..nIdentity.lastname..'\n[ADICIONOU O VEÍCULO]: '..prompt[2]..os.date('\n[DATA]: %d/%m/%Y [HORA]: %H:%M:%S')..' \r```')
                else
                    TriggerClientEvent('notify', source, 'Garagem', 'Não foi possível encontrar o <b>'..capitalizeString(prompt[2])..'</b> em nossa cidade.')
                end
            end
        end
    end
end)

RegisterCommand('remcar', function(source)
    local source = source
    local user_id = zero.getUserId(source)
    local identity = zero.getUserIdentity(source)
    if (user_id) and zero.hasPermission(user_id, '+Staff.COO') then
        local prompt = zero.prompt(source, { 'Passaporte', 'Veículo' })
        if (prompt) then
            if (prompt[1] and prompt[2]) then
                prompt[1] = parseInt(prompt[1])
                if (vehiclesConfig[prompt[2]]) then
                    delVehicle(prompt[1], prompt[2])
                    TriggerClientEvent('notify', source, 'Garagem', 'Você removeu o veículo <b>'..prompt[2]..'</b> do id <b>'..prompt[1]..'</b>.')
                    local nIdentity = zero.getUserIdentity(prompt[1])
                    zero.webhook('RemCar', '```prolog\n[/REMCAR]\n[STAFF]: #'..user_id..' '..identity.firstname..' '..identity.lastname..'\n[JOGADOR]: #'..prompt[1]..' '..nIdentity.firstname..' '..nIdentity.lastname..'\n[REMOVEU O VEÍCULO]: '..prompt[2]..os.date('\n[DATA]: %d/%m/%Y [HORA]: %H:%M:%S')..' \r```')
                else
                    TriggerClientEvent('notify', source, 'Garagem', 'Não foi possível encontrar o <b>'..capitalizeString(prompt[2])..'</b> em nossa cidade.')
                end
            end
        end
    end
end)

RegisterCommand('car', function(source, args)
    local source = source
    local user_id = zero.getUserId(source)
    local identity = zero.getUserIdentity(user_id)
    if (user_id) and zero.hasPermission(user_id, '+Staff.Administrador') then
        if (args[1]) then
            local spawn = string.lower(args[1])
            local loadModel = vCLIENT.loadModel(source, spawn, 30000, 60000)
            if (loadModel) then
                local ped = GetPlayerPed(source)
                local pCoord = GetEntityCoords(ped)
                local heading = GetEntityHeading(ped)
                local bucket = GetPlayerRoutingBucket(source)

                local userVehicle = (zero.query('zero_garage/getVehiclesWithVeh', { user_id = user_id, vehicle = spawn })[1] or {})
                local plate = (userVehicle.plate or identity.registration)

                local vehHandle;
                if config.client_spawn then
                    local vehnet = vCLIENT.clientSpawn(source, GetHashKey(spawn), vector3(pCoord.x, pCoord.y, pCoord.z - 0.5), heading, plate)
                    vehHandle = NetworkGetEntityFromNetworkId(vehnet)
                    while (vehHandle == 0) do
                        vehHandle = NetworkGetEntityFromNetworkId(vehnet)
                        Citizen.Wait(1)
                    end
                else
                    vehHandle = Citizen.InvokeNative(`CREATE_AUTOMOBILE`, GetHashKey(spawn), vector3(pCoord.x, pCoord.y, pCoord.z - 0.3), heading)
                end
                
                if vehHandle and (vehHandle > 0) then
                    if _Regis then _Regis(vehHandle) end
                    
                    local owner = NetworkGetEntityOwner(vehHandle)
                    while (owner == 1) do
                        owner = DoesEntityExist(vehHandle) and NetworkGetEntityOwner(vehHandle)
                        Citizen.Wait(1)
                    end
                    if (not owner) then return; end;
                    
                    SetVehicleNumberPlateText(vehHandle, plate)
                    SetVehicleDoorsLocked(vehHandle, 2)
                    
                    if (bucket > 0) then SetEntityRoutingBucket(vehHandle, bucket); end;
                    
                    local stateBag = Entity(vehHandle).state
                    stateBag['veh:plate'] = plate
                    stateBag['veh:user_id'] = user_id
                    stateBag['veh:model'] = spawn
                    
                    local netHandle = NetworkGetNetworkIdFromEntity(vehHandle)
                    
                    vCLIENT.settingVehicle(source, netHandle, srv.processState({}), plate, json.decode(userVehicle.custom))
                    SetPedIntoVehicle(ped, vehHandle, -1)
                    
                    zero.webhook('Car', '```prolog\n[/CAR]\n[STAFF]: #'..user_id..' '..identity.firstname..' '..identity.lastname..'\n[SPAWNOU]: '..spawn..'\n[COORDS]: '..pCoord..os.date('\n[DATA]: %d/%m/%Y [HORA]: %H:%M:%S')..' \r```')
                end
            end
        end
    end
end)

RegisterCommand('hash', function(source)
    local source = source
    local user_id = zero.getUserId(source)
    if (user_id) and zero.hasPermission(user_id, 'staff.permissao') then
        TriggerClientEvent('clipboard', source, 'Hash do Veículo', vCLIENT.getHash(source))
    end
end)

RegisterNetEvent('zero_interactions:carTrancar', function()
    local source = source
	local user_id = zero.getUserId(source)
	if (user_id) and zero.hasPermission(user_id, 'policia.permissao') then
        if (zeroClient.isInVehicle(source)) then
            local vehicle, vnetid = zeroClient.vehList(source, -1)
            if (vnetid) then
                local _, notify = vCLIENT.getVehicleAnchor(source)
                TriggerClientEvent('progressBar', source, notify, 5000)
                SetTimeout(5000, function() vCLIENT.vehicleAnchor(source, vnetid) end)
            end
        else
            TriggerClientEvent('notify', source, 'Garagem', 'Você tem que estar dentro de um <b>veículo</b> para utilizar este comando.')
        end
    else
        TriggerClientEvent('notify', source, 'Garagem', 'Somente <b>policial</b> pode utilizar essa interação.')
	end
end)

RegisterNetEvent('zero_interactions:carAncorar', function()
    local source = source
    if (zeroClient.isInVehicle(source)) then
        local vehicle = zeroClient.vehList(source, -1)
        if (vehicle) then vCLIENT.boatAnchor(source, vehicle); end;
    else
        TriggerClientEvent('notify', source, 'Garagem', 'Você tem que estar dentro de um <b>barco</b> para utilizar este comando.')
    end
end)

local keys = {
    ['add'] = function(source, nSource, vnetid, vname, nIdentity, identity, nuserId, user_id)
        local request = zero.request(source, 'Dar a chave reserva do veículo '..vehicleName(vname)..' para '..nIdentity.firstname..' '..nIdentity.lastname..'?', 60000)
        if (request) then
            carKeys[vnetid] = nuserId
            zeroClient._playAnim(source, true, {{ 'mp_common', 'givetake1_a' }}, false)
            zeroClient._playAnim(nSource, true, {{ 'mp_common', 'givetake1_a' }}, false)
            TriggerClientEvent('notify', source, 'Garagem', 'Você deu a chave reserva do veiculo <b>'..vehicleName(vname)..'</b> para <b>'..nIdentity.firstname..' '..nIdentity.lastname..'</b>.', 8000)
            TriggerClientEvent('notify', nSource, 'Garagem', 'Você recebeu a chave reserva do veiculo <b>'..vehicleName(vname)..'</b> de <b>'..identity.firstname..' '..identity.lastname..'</b>.', 8000)
            zero.webhook('Chave', '```prolog\n[JOGADOR]: #'..user_id..' '..identity.firstname..' '..identity.lastname..' \n[EMPRESTOU CHAVE RESERVA]: '..vehicleName(vname)..' \n[PARA]: #'..nuserId..' '..nIdentity.firstname..' '..nIdentity.lastname..os.date('\n[DATA]: %d/%m/%Y [HORA]: %H:%M:%S')..' \r```')
        end
    end,
    ['rem'] = function(source, nSource, vnetid, vname, nIdentity, identity, nuserId, user_id)
        carKeys[vnetid] = nil
        zeroClient._playAnim(nSource, true, {{ 'mp_common', 'givetake1_a' }}, false)
        zeroClient._playAnim(source, true, {{ 'mp_common', 'givetake1_a' }}, false)
        TriggerClientEvent('notify', source, 'Garagem', 'Você removeu a chave reserva do veiculo <b>'..vehicleName(vname)..'</b> para <b>'..nIdentity.firstname..' '..nIdentity.lastname..'</b>.', 8000)
        TriggerClientEvent('notify', nSource, 'Garagem', 'Você perdeu a chave reserva do veiculo <b>'..vehicleName(vname)..'</b> de <b>'..identity.firstname..' '..identity.lastname..'</b>.', 8000)
        zero.webhook('Chave', '```prolog\n[JOGADOR]: #'..user_id..' '..identity.firstname..' '..identity.lastname..' \n[RECOLHEU CHAVE RESERVA]: '..vehicleName(vname)..' \n[PARA]: #'..nuserId..' '..nIdentity.firstname..' '..nIdentity.lastname..os.date('\n[DATA]: %d/%m/%Y [HORA]: %H:%M:%S')..' \r```')
    end
}

RegisterNetEvent('zero_interactions:carKeys', function(value)
    local source = source
    local user_id = zero.getUserId(source)
    if (user_id) then
        local identity = zero.getUserIdentity(user_id)
        local nPlayer = zeroClient.getNearestPlayer(source, 2.0)
        if (nPlayer) then
            local nUser = zero.getUserId(nPlayer)
            local nIdentity = zero.getUserIdentity(nUser)
            local vehicle, vnetid, placa, vname = zeroClient.vehList(source, 3.0)
            if (vnetid and vname) then
                local vehState = srv.getVehicleData(vnetid)
                if (vehState.user_id == user_id) then
                    keys[value](source, nPlayer, vnetid, vname, nIdentity, identity, nUser, user_id)
                end
            end
        else
            TriggerClientEvent('notify', source, 'Garagem', 'Não possui uma pessoa <b>próximo</b> a você.')
        end
    end
end)

RegisterNetEvent('zero_interactions:carVehs', function()
    local source = source
    local user_id = zero.getUserId(source)
    if (user_id) then
        local prompt = zero.prompt(source, { 'Veículo que você deseja vender', 'Valor do veículo', 'Passaporte do jogador que irá receber o veículo' })
        if (prompt) then
            if (prompt[1] and prompt[2] and prompt[3]) then
                prompt[2] = parseInt(prompt[2])
                prompt[3] = parseInt(prompt[3])

                local model = prompt[1]
                local vname = vehicleName(model)
                local myVehicle = zero.query('zero_garage/getVehiclesWithVeh', { user_id = user_id, vehicle = model })[1]
                if (myVehicle) then
                    if ((vehicleType(model) == 'exclusive') or (vehicleType(model) == 'vip') or (myVehicle.rented ~= '')) then
                        TriggerClientEvent('notify', source, 'Garagem', 'Este <b>veículo</b> não pode ser vendido.')
                    else
                        local nUser = prompt[3]
                        local price = prompt[2]
                        local nSource = zero.getUserSource(nUser)
                        local identity = zero.getUserIdentity(user_id)
                        local nIdentity = zero.getUserIdentity(nUser)
                        if (price > 0) then
                            if (zero.request(source, 'Deseja vender um '..vname..' para '..nIdentity.firstname..' '..nIdentity.lastname..' por R$'..zero.format(price)..' ?', 60000)) then
                                if (zero.request(nSource, 'Aceita comprar um '..vname..' de '..identity.firstname..' '..identity.lastname..' por R$'..zero.format(price)..'?', 60000)) then
                                    local userVehicle = zero.query('zero_garage/getVehiclesWithVeh', { user_id = nUser, vehicle = model })[1]
                                    if (userVehicle) then
                                        TriggerClientEvent('notify', source, 'Garagem', 'O <b>'..nIdentity.firstname..' '..nIdentity.lastname..'</b> já possui este modelo de veículo')
                                    else
                                        local vqtd = 0
                                        local vehicles = zero.query('zero_garage/getVehicleOwn', { user_id = nUser })
                                        for _, v in ipairs(vehicles) do
                                            local vtype = vehicleType(v.vehicle)
                                            if (vtype ~= 'exclusive' and vtype ~= 'vip') then vqtd = vqtd + 1; end;

                                            local maxGarages = zero.query('zero_garage/getGarages', { id = nUser })[1]
                                            maxGarages = maxGarages.garages
                                            if (vqtd < maxGarages) then
                                                if (zero.tryFullPayment(nUser, price)) then
                                                    addVehicle(nUser, model, 0)
                                                    delVehicle(user_id, model)

                                                    TriggerClientEvent('notify', source, 'Garagem', 'Você vendeu <b>'..vname..'</b> e recebeu <b>R$'..zero.format(price)..'</b>.')
                                                    TriggerClientEvent('notify', nSource, 'Garagem', 'Você recebeu as chaves do veículo <b>'..vname..'</b> de <b>'..identity.firstname..' '..identity.lastname..'</b> e pagou <b>R$'..zero.format(price)..'</b>.')
                                                    
                                                    zeroClient.playSound(source, 'Hack_Success', 'DLC_HEIST_BIOLAB_PREP_HACKING_SOUNDS')
                                                    zeroClient.playSound(nSource, 'Hack_Success', 'DLC_HEIST_BIOLAB_PREP_HACKING_SOUNDS')
                                                    
                                                    zero.giveBankMoney(user_id, nUser)
                                                    zero.webhook('Vehs', '```prolog\n[JOGADOR]: #'..user_id..' '..identity.firstname..' '..identity.lastname..' \n[VENDEU]: '..vehicleName(vname)..' \n[PARA]: #'..nuserId..' '..nIdentity.firstname..' '..nIdentity.lastname..'\n[POR]: '..zero.format(price)..os.date('\n[DATA]: %d/%m/%Y [HORA]: %H:%M:%S')..' \r```')
                                                    local vehEntity = findVehicle(user_id, model)
                                                    if (vehEntity) then srv.tryDelete(NetworkGetNetworkIdFromEntity(vehEntity), false); end;
                                                else
                                                    TriggerClientEvent('notify', nSource, 'Garagem', 'Você não possui <b>dinheiro</b> o suficiente.')
                                                    TriggerClientEvent('notify', source, 'Garagem', 'O mesmo não possui <b>dinheiro</b> o suficiente.')
                                                end
                                            else
                                                TriggerClientEvent('notify', nSource, 'Garagem', 'Você não possui <b>vagas</b> em sua garagem.')
                                                TriggerClientEvent('notify', source, 'Garagem', 'O mesmo não <b>vagas</b> em sua garagem.')
                                            end
                                        end
                                    end
                                end
                            end
                        end 
                    end
                else
                    TriggerClientEvent('notify', source, 'Garagem', 'Você não possui esse <b>veículo</b> em sua garagem.')
                end
            end
        end
    end
end)

RegisterNetEvent('zero_interactions:carPlate', function()
    local source = source
    local user_id = zero.getUserId(source)
	if (user_id and zero.hasPermission(user_id, 'staff.permissao') or zero.hasPermission(user_id, 'policia.permissao') or zero.hasPermission(user_id, 'desmanche.permissao')) then
        local vehicle, vnetid, placa, vname, lock, banned = zeroClient.vehList(source, 7.0)
        if (vnetid) then
            local vehState = srv.getVehicleData(vnetid)
            if (vehState.user_id) then
                local identity = zero.getUserIdentity(vehState.user_id)
                if (identity) then
                    local vehicleName = vehicleMaker(vehState.model)..' '..vehicleName(vehState.model)
                    zeroClient.playSound(source, 'Event_Message_Purple', 'GTAO_FM_Events_Soundset')
                    TriggerClientEvent('notify', source, 'Garagem', '<b>Placa:</b> '..placa..'</center><br><b>Proprietário: </b>'..identity.firstname..' '..identity.lastname..'<br><b>Telefone: </b>'..identity.phone..'<br><br><b>Chassis</b>: '..(vehState.chassis or 'Não encontrado')..'<br><b>Modelo: </b>'..vehicleName, 20000)
                end
            else
                TriggerClientEvent('notify', source, 'Garagem','A <b>placa</b> é inválida ou veículo de um americano.')
            end
        end
    else
        TriggerClientEvent('notify', source, 'Garagem', 'Você não tem <b>permissão</b>.')
    end
end)

RegisterCommand('fix', function(source)
    local source = source
    local user_id = zero.getUserId(source)
    local identity = zero.getUserIdentity(user_id)
    if (user_id) and zero.hasPermission(user_id, 'staff.permissao') then
        local vehicle = zeroClient.getNearestVehicle(source, 12.0)
        if (vehicle) then
            local vehicle, vnetid, placa, vname, lock, banned = zeroClient.vehList(source, 3.0)
            if (vnetid) then
                local vehState = srv.getVehicleData(vnetid)
                TriggerClientEvent('syncreparar', -1, vnetid)
                zero.webhook('Fix', '```prolog\n[/FIX]\n[STAFF]: #'..user_id..' '..identity.firstname..' '..identity.lastname..'\n[FIX]: '..vehState.model..'\n[DONO]: '..vehState.user_id..' \n[COORDS]: '..tostring(GetEntityCoords(GetPlayerPed(source)))..os.date('\n[DATA]: %d/%m/%Y [HORA]: %H:%M:%S')..' \r```')
            end
        end
    end
end)

RegisterCommand('placa', function(source, args, rawCommand)
    local source = source
	local user_id = zero.getUserId(source)
	if (user_id and zero.hasPermission(user_id, 'staff.permissao') or zero.hasPermission(user_id, 'policia.permissao') or zero.hasPermission(user_id, 'desmanche.permissao')) then
		if (args[1]) then
			local placa = sanitizeString(rawCommand:sub(7), '<>', false)
			local user_id, model, chassis = getVehicleInfosWithPlate(placa)
			if (user_id) then
				local identity = zero.getUserIdentity(user_id)
				if (identity) then
					local vehicleName = vehicleMaker(model)..' '..vehicleName(model)
					zeroClient.playSound(source, 'Event_Message_Purple', 'GTAO_FM_Events_Soundset')
					TriggerClientEvent('notify', source, 'Garagem','<b>Placa:</b> '..placa..'</center><br><b>Proprietário: </b>'..identity.firstname..' '..identity.lastname..'<br><b>Telefone: </b>'..identity.phone..'<br><br><b>Chassis</b>: '..(chassis or 'Não encontrado')..'<br><b>Modelo: </b>'..vehicleName, 20000)
				end
			else
				TriggerClientEvent('notify', source, 'Garagem','A <b>placa</b> é inválida ou veículo de um americano.')
			end
		else
			local vehicle, vnetid, placa, vname, lock, banned = zeroClient.vehList(source, 7.0)
			if (vnetid) then
				local vehState = srv.getVehicleData(vnetid)
				if (vehState.user_id) then
					local identity = zero.getUserIdentity(vehState.user_id)
					if (identity) then
						local vehicleName = vehicleMaker(vehState.model)..' '..vehicleName(vehState.model)
                        zeroClient.playSound(source, 'Event_Message_Purple', 'GTAO_FM_Events_Soundset')
                        TriggerClientEvent('notify', source, 'Garagem', '<b>Placa:</b> '..placa..'</center><br><b>Proprietário: </b>'..identity.firstname..' '..identity.lastname..'<br><b>Telefone: </b>'..identity.phone..'<br><br><b>Chassis</b>: '..(vehState.chassis or 'Não encontrado')..'<br><b>Modelo: </b>'..vehicleName, 20000)
					end
				else
					TriggerClientEvent('notify', source, 'Garagem','A <b>placa</b> é inválida ou veículo de um americano.')
				end
			end
		end
	end
end)

RegisterCommand('chassis',function(source, args, rawCommand)
    local source = source
	local user_id = zero.getUserId(source)
	if (user_id) and zero.hasPermission(user_id, 'policia.permissao') then
		if (args[1]) then
			local chassis = sanitizeString(rawCommand:sub(9), '<>', false)
			local vehQuery = zero.query('zero_garage/getVehByChassis', { chassis = chassis })[1]
			if (vehQuery.vehicle) then
				local identity = zero.getUserIdentity(vehQuery.user_id)
				if (identity) then
					local vehicleName = vehicleMaker(vehQuery.vehicle)..' '..vehicleName(vehQuery.vehicle)
					zeroClient.playSound(source, 'Event_Message_Purple', 'GTAO_FM_Events_Soundset')
					TriggerClientEvent('notify', source, 'Garagem', '<b>Chassis: </b>'..chassis..'<br><b>Proprietário: </b>'..identity.firstname..' '..identity.lastname..'<br><b>Telefone: </b>'..identity.phone..'<br><br><b>Placa:</b> '..vehQuery.plate..'<br><b>Modelo: </b>'..vehicleName, 20000)
				end
			else
				TriggerClientEvent('notify', source, 'Garagem', 'O <b>chassis</b> é inválido.')
			end
		end
	end
end)

RegisterCommand('vec3', function(source)
    local source = source
    local user_id = zero.getUserId(source)
    if (user_id) and zero.hasPermission(user_id, 'staff.permissao') then
        TriggerClientEvent('clipboard', source, 'Vector3', tostring(GetEntityCoords(GetPlayerPed(source))))
    end
end)

RegisterCommand('vec4', function(source)
    local source = source
    local user_id = zero.getUserId(source)
    if (user_id) and zero.hasPermission(user_id, 'staff.permissao') then
        local ped = GetPlayerPed(source)
        TriggerClientEvent('clipboard', source, 'Vector4', tostring(vector4(GetEntityCoords(ped), GetEntityHeading(ped))))
    end
end)

local trunkList = {}

srv.checkTrunk = function(vnet)
    if (parseInt(trunkList[vnet]) == 2) then
        TriggerClientEvent('notify', source, 'Garagem', 'O <b>porta-malas</b> deste veículo se encontra cheio.')
        return false
    end
    return true
end

srv.insertTrunk = function(vnet)
    if (trunkList[vnet] == nil) then
        trunkList[vnet] = 1
    else
        trunkList[vnet] = 2
    end
end

srv.removeTrunk = function(vehNet)
	if (trunkList[vnet] == nil) then return; end;
	if (trunkList[vehNet] == 2) then
		trunkList[vehNet] = (trunkList[vehNet] - 1)
	else
		trunkList[vehNet] = nil
	end
end

RegisterNetEvent('zero_interactions:carTrunkin', function()
    local source = source
    if (GetEntityHealth(GetPlayerPed(source)) > 100 and not zeroClient.isHandcuffed(source)) then
        TriggerClientEvent('zero_garage:enterTrunk', source)
    end
end)

RegisterCommand('trunkin', function(source)
    local source = source
    if (GetEntityHealth(GetPlayerPed(source)) > 100 and not zeroClient.isHandcuffed(source)) then
        TriggerClientEvent('zero_garage:enterTrunk', source)
    end
end)

RegisterCommand('checktrunk', function(source)
    if (GetEntityHealth(GetPlayerPed(source)) > 100 and not zeroClient.getNoCarro(source) and not zeroClient.isHandcuffed(source)) then
        local nplayer = zeroClient.getNearestPlayer(source, 2.0)
        if (nplayer) then 
            TriggerClientEvent('notify', source, 'Garagem', 'Retirando cidadão do <b>porta-malas</b>.')
            TriggerClientEvent('zero_garage:checkTrunk', nplayer)
        end
    end
end)

RegisterNetEvent('trywins', function(nveh, open)
	TriggerClientEvent('syncwins', -1, nveh, open)
end)

RegisterNetEvent('trydoors', function(nveh, door)
	TriggerClientEvent('syncdoors', -1, nveh, door)
end)

AddEventHandler('vRP:playerSpawn', function(user_id, source, first_spawn)
	if (first_spawn) then
		local myHomes = zero.query('zero_homes/userHomesList', { user_id = user_id })
        for k,v in ipairs(myHomes) do
            local gar = zero.query('zero_homes/getGarage', { home = v.home })[1]
            if (gar) then
                local blip = json.decode(gar.blip)
                local spawn = json.decode(gar.spawn)
                addGarage(source, v.home, blip, spawn)
            end
        end
	end
end)

RegisterNetEvent('homes:addGarage', function(source, homeName, blip, spawn)
    local homes = zero.query('zero_homes/permissions', { home = homeName })
    for _, v in ipairs(homes) do
        local source = zero.getUserSource(v.user_id)
        if (source) then addGarage(source, homeName, blip, spawn); end;
    end
end)

addGarage = function(src, name, blip, spawn)
    garagesConfig[name] = {
        coords = vector3(blip.x, blip.y, blip.z),
        rule = 'carOnly',
        points = { vector4(spawn.x, spawn.y, spawn.z, spawn.w) }
    }
    vCLIENT._addGarage(src, name, garagesConfig[name])
end

AddEventHandler('onResourceStart', function(resourceName)
  	if (GetCurrentResourceName() == resourceName) then 
        TriggerClientEvent('zero:clearVehicleCache', -1)

        local rentedVehs = zero.query('zero_garage/getRented')
        local nowClock = os.time()
        local count = 0
        for _, veh in pairs(rentedVehs) do
            if (parseInt(veh.rented) < nowClock) then
                delVehicle(veh.user_id, veh.vehicle)
                count = count + 1
            end
        end
        print('^5[Zero Garage]^7 foram deletados '..count..' veiculos alugado.')
	end
end)