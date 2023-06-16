local srv = {}
Tunnel.bindInterface('zeroGarage', srv)
local vCLIENT = Tunnel.getInterface('zeroGarage')

local garagesConfig = config.garages
local rulesConfig = config.rules

zero._prepare('zero_garage/getVehicles', 'select * from zero_user_vehicles where user_id = @user_id')
zero._prepare('zero_garage/getVehiclesWithVeh', 'select * from zero_user_vehicles where user_id = @user_id and vehicle = @vehicle')
zero._prepare('zero_garage/getVehiclesWithPlate', 'select * from zero_user_vehicles where plate = @plate')
zero._prepare('zero_garage/getVehiclesWithChassis', 'select * from zero_user_vehicles where chassis = @chassis')
zero._prepare('zero_garage/addVehicle', 'insert ignore into zero_user_vehicles (user_id, vehicle, plate, chassis, service, ipva, detained, rented, state, custom) values (@user_id, @vehicle, @plate, @chassis, @service, @ipva, 0, 0, "{}", "{}")')
zero._prepare('zero_garage/setDetained', 'update zero_user_vehicles set detained = @detained where user_id = @user_id and vehicle = @vehicle')
zero._prepare('zero_garage/setIPVA', 'update zero_user_vehicles set ipva = @ipva where user_id = @user_id and vehicle = @vehicle')
zero._prepare('zero_garage/updateState', 'update zero_user_vehicles set state = @state where user_id = @user_id and vehicle = @vehicle')

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

srv.getVehicleData = function(vehnet)
	if vehnet and NetworkGetEntityFromNetworkId(vehnet) then
		local vehicle = NetworkGetEntityFromNetworkId(vehnet)
		if DoesEntityExist(vehicle) then
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
            if (gInfo.vehicles) then
                for _, value in pairs(gInfo.vehicles) do
                    local vehicleInfos = { vname = vehicleName(value), vmaker = vehicleMaker(value), vtype = vehicleType(value), vtrunk = vehicleSize(value), engine = 1000, body = 1000, fuel = 100 }
                    local data = zero.query('zero_garage/getVehiclesWithVeh', { user_id = user_id, vehicle = value })
                    if (data) then
                        local state = srv.processState(json.decode(data.state))
                        if (state.data.engineHealth) then vehicleInfos.engine, vehicleInfos.body, vehicleInfos.fuel = state.data.engineHealth, state.data.bodyHealth, state.data.fuel end;
                        table.insert(myVehicles, {
                            type = vehicleInfos.vtype,
                            spawn = value,
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
                return myVehicles
            else
                local vehicles = zero.query('zero_garage/getVehicles', { user_id = user_id })
                for _, value in pairs(vehicles) do
                    if (value.service == 0) then
                        local add = true
                        if (gInfo.rule and rulesConfig[gInfo.rule]) then
                            local gRule = rulesConfig[gInfo.rule]
                            local vclass = vehicleClass(value.vehicle)
                            if (gRule.show_classes) then
                                add = false
                                if (gRule.show_classes[vclass]) then add = true; end;
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
                    zero.execute('zero_garage/addVehicle', { user_id = user_id, vehicle = vehicle, plate = generatePlate(), chassis = generateChassis(), ipva = os.time(), service = 1 })
                    veh = zero.query('zero_garage/getVehiclesWithVeh', { user_id = user_id, vehicle = vehicle })[1]
                end

                if (veh.service == 0) then
                    -- CHECAR MULTAS
                    if (veh.detained == 1) then
                        local value = parseInt(vehiclePrice(vehicle) * config.taxDetained)
                        local request = zero.request(source, 'Veículo na detenção, deseja acionar o seguro pagando <b>R$'..zero.format(value)..'</b>?', 60)
                        if (request) then
                            if (zero.tryFullPayment(user_id, value)) then
                                setDetained(user_id, vehicle, 0)
                                TriggerClientEvent('notify', source, 'Garagem', 'O <b>pagamento</b> foi efetuado com sucesso.')
                            else
                                TriggerClientEvent('notify', source, 'Garagem', 'Você não possui <b>dinheiro</b> suficiente para este pagamento.')
                                return
                            end
                        else
                            return
                        end
                    elseif (veh.detained == 2) then
                        local value = parseInt(vehiclePrice(vehicle) * config.taxSafe)
                        local request = zero.request(source, 'Veículo na retenção, deseja acionar o seguro pagando <b>R$'..zero.format(value)..'</b>?', 60)
                        if (request) then
                            if (zero.tryFullPayment(user_id, value)) then
                                setDetained(user_id, vehicle, 0)
                                TriggerClientEvent('notify', source, 'Garagem', 'O <b>pagamento</b> foi efetuado com sucesso.')
                            else
                                TriggerClientEvent('notify', source, 'Garagem', 'Você não possui <b>dinheiro</b> suficiente para este pagamento.')
                                return
                            end
                        else
                            return
                        end
                    end

                    if (os.time() >= parseInt(veh.ipva + config.ipvaDays)) then
                        local priceTax = parseInt(vehiclePrice(vehicle) * config.taxIPVA)
                        local request = zero.request(source, 'Deseja pagar o <b>Vehicle Tax</b> do veículo <b>'..vehicleName(vehicle)..'</b> por <b>R$'..zero.format(priceTax)..'</b>?', 60)
                        if (request) then
                            if (zero.tryFullPayment(user_id, priceTax)) then
                                zero.execute('zero_garage/setIPVA', { user_id = user_id, vehicle = vehicle, ipva = os.time() })
                                TriggerClientEvent('notify', source, 'Garagem', 'O <b>pagamento</b> foi efetuado com sucesso.')
                            else
                                TriggerClientEvent('notify', source, 'Garagem', 'Você não possui <b>dinheiro</b> suficiente para este pagamento.')
                                return
                            end
                        else
                            return
                        end
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

local carKeys = {}

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
                    TriggerClientEvent('notify', source, 'Garagem', 'O veículo foi <b>trancado</b> com sucesso.')
                else
                    TriggerClientEvent('notify', source, 'Garagem', 'O veículo foi <b>destrancado</b> com sucesso.')
                end
            end
        end
    end
end

local keys = {
    ['add'] = function(source, vname)
        local request = zero.request(source, 'Dar a chave reserva do veículo <b>'..vehicleName(vname)..'</b>')
    end,
    ['rem'] = function()
    end
}

RegisterCommand('chaves', function(source, args)
    local source = source
    local user_id = zero.getUserId(source)
    if (args[1]) then
        args[1] = string.lower(args[1])

        local identity = zero.getUserIdentity(user_id)
        local vehicle, vnetid, placa, vname, lock, banned = zeroClient.vehList(source, 3.0)
        local nSource = zeroClient.getNearestPlayer(source, 2.0)
        local vehState = srv.getVehicleData(vnetid)
        if (nSource) then
            local nuserId = zero.getUserId(nSource)
            local nIdentity = zero.getUserIdentity(nuserId)
            if (vehState.user_id == user_id) then
                if (args[1] == 'add') then
                    keys[args[1]]()
                elseif (args[1] == 'rem') then
                    if (nuser_id == carKeys[vnetid]) then
                        keys[args[1]]()
                    end
                end
            end
        end
    end
end)

local webhooks = {}
webhooks.dv = 'https://discord.com/api/webhooks/1119095962812559370/qkEqSfOScED9MnYoTvFEvWwTYLvmKMEnt473zKfsvw2Oe0NuXza2OKSYaWlopZ2W4rJF'

RegisterCommand('dv', function(source)
    local user_id = zero.getUserId(source)
    local identity = zero.getUserIdentity(user_id)
    if (user_id) and zero.hasPermission(user_id, 'staff.permissao') then
        local vehicle, vnetid = zeroClient.vehList(source, 7)
        if (vnetid) then
            local vehState = srv.getVehicleData(vnetid)
            vCLIENT.tryDeleteVehicle(source, vnetid)
            zero.webhook(webhooks.dv, '```prolog\n[PASSAPORTE]: '..user_id..' | '..identity.firstname..' '..identity.lastname..' \n[USOU]: /dv\n[EM]: '..vehState.model..' \n[DONO]: '..vehState.user_id..'\n[XYZ]: '..tostring(GetEntityCoords(GetPlayerPed(source)))..os.date('\n[DATA]: %d/%m/%Y [HORA]: %H:%M:%S')..' \r```')
        end
    end
end)