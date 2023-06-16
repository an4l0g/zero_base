RegisterCommand('cds',function()
    print(GetEntityCoords(PlayerPedId()), GetEntityHeading(PlayerPedId()))
    print(GetVehiclePedIsIn(PlayerPedId()))
end)

local cli = {}
Tunnel.bindInterface('zeroGarage', cli)
local vSERVER = Tunnel.getInterface('zeroGarage')

local garagesConfig = config.garages

local markers = {
    ['plane'] = 33,
    ['heli'] = 34,
    ['boat'] = 35,
    ['car'] = 36,
    ['motor'] = 37,
    ['bike'] = 38,
    ['truck'] = 39
}

createMarker = function(config)
    DrawMarker(markers[(config.marker or 'car')], config.coords.x, config.coords.y, config.coords.z+0.1, 0, 0, 0, 0, 0, 0, 0.7, 0.7, 0.7, 0, 153, 255, 155, 1, 0, 0, 1)
    DrawMarker(27, config.coords.x, config.coords.y, config.coords.z-0.97, 0, 0, 0, 0, 0, 0, 1.0, 1.0, 1.0, 0, 153, 255, 155, 0, 0, 0, 1)
end

local nearestGarages = {}
local inGarage = false

mainThread = function()
    SetNuiFocus(false, false)
    local getNearestGarages = function()
        while true do
            if (not inGarage) then
                local playerCoords = GetEntityCoords(PlayerPedId())
                if (nearestGarages and nearestGarages.coords) then
                    local distance = #(playerCoords - nearestGarages.coords)
                    if (distance > 10) then
                        nearestGarages = false
                    elseif (distance <= 1.2) then
                        nearestGarages.close = true
                    else
                        nearestGarages.close = false
                    end
                else
                    for k, v in ipairs(garagesConfig) do
                        local distance = #(playerCoords - v.coords)
                        if distance <= 10 then
                            nearestGarages = garagesConfig[k]
                            nearestGarages.id = k
                        end
                    end
                end
            end
            Citizen.Wait(800)
        end
    end

    CreateThread(getNearestGarages)

    while true do
        local idle = 1000
        local ped = PlayerPedId()
        if (nearestGarages and nearestGarages.coords and not inGarage) then
            idle = 4
            createMarker(nearestGarages)
            if (nearestGarages.close and IsControlJustPressed(0, 38) and GetEntityHealth(ped) > 101 and not IsPedInAnyVehicle(ped)) then
                openGarage(nearestGarages)
            end
        end
        Citizen.Wait(idle)
    end
end

CreateThread(mainThread)

openGarage = function(config)
    if (vSERVER.checkPermissions(config.permission)) then
        SetNuiFocus(true, true)
        SendNUIMessage({
            action = 'open',
            cars = vSERVER.getMyVehicles(config.id)
        })
    end
end

cli.clientSpawn = function(model, coords, heading, plate)
    local vehicle = CreateVehicle(model, coords.x, coords.y, coords.z, heading, true, true)

    local timeOut = (GetGameTimer() + 4000)
    while (not DoesEntityExist(vehicle)) do
        Citizen.Wait(1)
        if (GetGameTimer() > timeOut) then break; end;
    end
    SetVehicleNumberPlateText(vehicle, plate)
	SetEntityAsMissionEntity(vehicle, true, true)

	local netid = VehToNet(vehicle)
	SetNetworkIdExistsOnAllMachines(netid, true)
	for _, i in ipairs(GetActivePlayers()) do
		SetNetworkIdSyncToPlayer(netid, i, true)
	end
	return netid
end

cli.getFreeSlot = function(garage)
    local gInfo = garagesConfig[garage]
    if (gInfo) then
        local checkSlot = 1
        while (true) do
            local checkPos = GetClosestVehicle(gInfo.points[checkSlot].x, gInfo.points[checkSlot].y, gInfo.points[checkSlot].z, 3.001, 0, 71)
            if (DoesEntityExist(checkPos)) then
                checkSlot = checkSlot + 1
                if (checkSlot > #gInfo.points) then checkSlot = -1; return false; end;
            else
                return checkSlot, gInfo.points[checkSlot].xyz, gInfo.points[checkSlot].w
            end
        end
    end
end

cli.loadModel = function(hash, tout, tunload)
    local mhash = hash
    if (type(hash) == 'string') then mhash = GetHashKey(hash); end;
    
    local timeOut = (tonumber(tout) or 30000)
    while (not HasModelLoaded(mhash) and timeOut >= 0) do
        RequestModel(mhash)
        timeOut = timeOut - 10
        Citizen.Wait(1)
    end

    if (HasModelLoaded(mhash)) then
        if (tunload) then
            Citizen.SetTimeout((tonumber(tunload) or 60000), function()
                SetModelAsNoLongerNeeded(mhash)
            end)
        end
        return true
    end
    return false
end

cli.getVehicleState = function(vnet, others)
	if (NetworkDoesNetworkIdExist(vnet)) then
		local vehicle = NetToVeh(vnet)
		if (DoesEntityExist(vehicle)) then
			local state = { windows = {}, doors = {}, tyres = {}, extras = {}, data = {} }
			for i = 0, 7 do
				state.windows[i] = IsVehicleWindowIntact(vehicle,i)
			end
			for i = 0, 5 do
				state.doors[i] = IsVehicleDoorDamaged(vehicle,i)
			end
			for i = 0, 7 do
				state.tyres[i] = IsVehicleTyreBurst(vehicle,i,false)
			end
			for i = 0, 15 do
				if (DoesExtraExist(vehicle, i)) then state.extras[i] = IsVehicleExtraTurnedOn(vehicle,i); end;
			end
			state.data.fuel = floatDec(GetVehicleFuelLevel(vehicle))
			state.data.dirt = floatDec(GetVehicleDirtLevel(vehicle))
			state.data.engineHealth = GetVehicleEngineHealth(vehicle)
			state.data.bodyHealth = GetVehicleBodyHealth(vehicle)
			state.data.livery = GetVehicleLivery(vehicle)
			if (others) then
				state.data.locked = GetVehicleDoorLockStatus(vehicle)
				state.data.running = GetIsVehicleEngineRunning(vehicle)
				state.data.lights = { GetVehicleLightsState(vehicle) }
				state.data.indicators = GetVehicleIndicatorLights(vehicle)
			end
			return state
		end
	end
	return {}
end

cli.setVehicleState = function(vnet, state, others)
	if (NetworkDoesNetworkIdExist(vnet)) then
		local vehicle = NetToVeh(vnet)
		if (DoesEntityExist(vehicle)) then
			for i, intact in pairs(state.windows) do
				if (not intact) then SmashVehicleWindow(vehicle, tonumber(i)); end;
			end
			for i, damaged in pairs(state.doors) do
				if damaged then SetVehicleDoorBroken(vehicle, tonumber(i),true); end;
			end
			for i, burst in pairs(state.tyres) do
				if burst then SetVehicleTyreBurst(vehicle, tonumber(i), true, 1000); end;
			end
			for i, active in pairs(state.extras) do
				SetVehicleExtra(vehicle, i, (not active))
			end
			SetVehicleFuelLevel(vehicle, state.data.fuel)
			SetVehicleDirtLevel(vehicle, state.data.dirt)
			SetVehicleEngineHealth(vehicle, state.data.engineHealth)
			SetVehicleBodyHealth(vehicle, state.data.bodyHealth)
			SetVehicleLivery(vehicle, state.data.livery)
			if (others) then
				SetVehicleDoorsLocked(vehicle, state.data.locked)
				SetVehicleEngineOn(vehicle, state.data.running, true, false)
				if (state.data.indicators == 3) or (state.data.lights[2] == 1) or (state.data.lights[3] == 1) then
					SetVehicleIndicatorLights(vehicle, 0, true)
					SetVehicleIndicatorLights(vehicle, 1, true)
				elseif (state.data.indicators == 2) then
					SetVehicleIndicatorLights(vehicle, 0, true)
					SetVehicleIndicatorLights(vehicle, 1, false)
				elseif (state.data.indicators == 1) then
					SetVehicleIndicatorLights(vehicle, 0, false)
					SetVehicleIndicatorLights(vehicle, 1, true)
				else
					SetVehicleIndicatorLights(vehicle, 0, false)
					SetVehicleIndicatorLights(vehicle, 1, false)
				end
			end
		end
    end
end

cli.settingVehicle = function(vnet, state, plate, custom)
    local timeOut = (GetGameTimer() + 4000)
    while (not NetworkDoesEntityExistWithNetworkId(vnet)) do
        Citizen.Wait(10)
        if (GetGameTimer() > timeout) then return; end;
    end

    local nveh = NetworkGetEntityFromNetworkId(vnet)
    if (nveh) then
        local timeOut = (GetGameTimer() + 4000)
        NetworkRequestControlOfEntity(nveh)
		while (not NetworkHasControlOfEntity(nveh)) do
			NetworkRequestControlOfEntity(nveh)
			Citizen.Wait(10)
			if (GetGameTimer() > timeOut) then return; end;
		end

        SetVehicleIsConsideredByPlayer(nveh, true)
        SetVehicleHasBeenOwnedByPlayer(nveh, true)
		SetVehicleIsStolen(nveh,false)
		SetVehicleNeedsToBeHotwired(nveh, false)
		SetVehicleOnGroundProperly(nveh)
		SetEntityAsMissionEntity(nveh, true, true)
		SetVehRadioStation(nveh, 'OFF')
		SetVehicleEngineOn(nveh, false, true, true)

        if (state.data.fuel) then cli.setVehicleState(vnet, state, false) end
        if (DecorIsRegisteredAsType('Player_Vehicle', 3)) then DecorSetInt(nveh, 'Player_Vehicle', -1); end;
        
        Entity(nveh).state:set('veh:spawning', nil, true)
        SetVehicleNumberPlateText(nveh, plate)
        -- EVENTO TUNING
        return true
    end
end

cli.tryDeleteVehicle = function(vnet)
	if (NetworkDoesNetworkIdExist(vnet)) then
		local vehicle = NetToVeh(vnet)
		if (IsEntityAVehicle(vehicle)) then
			vSERVER.tryDelete(vnet, cli.getVehicleState(vnet, false))
		end
	end
end

local gps = {}
local vehBlips = {}

cli.syncBlips = function(vnet, vname)
    gps[vname] = true
    Citizen.CreateThread(function()
        while (gps[vname]) do
            if (NetworkDoesNetworkIdExist(vnet)) then
                local nveh = NetToVeh(vnet)
                if (GetBlipFromEntity(nveh) == 0) then
                    vehBlips[vname] = AddBlipForEntity(nveh)
                    SetBlipSprite(vehBlips[vname], 225)
					SetBlipAsShortRange(vehBlips[vname], false)
					SetBlipColour(vehBlips[vname], 1)
					SetBlipScale(vehBlips[vname], 0.4)
					BeginTextCommandSetBlipName('STRING')
					AddTextComponentString('~b~Rastreador: ~g~'..vname)
					EndTextCommandSetBlipName(vehBlips[vname])
                end
            end
            Citizen.Wait(1000)
        end
    end)
end

cli.removeGPSVehicle = function(vname)
    if (gps[vname]) then RemoveBlip(vehBlips[vname]); gps[vname] = nil; end;
end

RegisterKeyMapping('+lockVehicle', 'Garagem - Trancar/Destrancar Veículo', 'keyboard', 'L')
RegisterCommand('+lockVehicle',function() vSERVER.vehicleLock() end)

cli.vehicleClientLock = function(vehid, lock)
	if (NetworkDoesNetworkIdExist(vehid)) then
		local vehicle = NetToVeh(vehid)
		if (DoesEntityExist(vehicle) and IsEntityAVehicle(vehicle)) then
			if (lock == 1) then
				SetVehicleDoorsLocked(vehicle, 2)
				SetVehicleDoorsLockedForAllPlayers(vehicle, false)
			elseif (lock == 2) then
				SetVehicleDoorsLocked(vehicle, 1)
				SetVehicleDoorsLockedForAllPlayers(vehicle, false)
			else
				SetVehicleDoorsLocked(vehicle, 2)
				SetVehicleDoorsLockedForAllPlayers(vehicle, false)
			end
			SetVehicleLights(vehicle, 2)
			Citizen.Wait(200)
			SetVehicleLights(vehicle, 0)
			Citizen.Wait(200)
			SetVehicleLights(vehicle, 2)
			Citizen.Wait(200)
			SetVehicleLights(vehicle, 0)
		end
	end
end

RegisterNuiCallback('saveNextVeh', function()
    local vehicle, vnetid = zero.vehList(15.0)
    if (vnetid) then cli.tryDeleteVehicle(vnetid); end;
end)

local getNetVeh = function(plate)
    for _, veh in pairs(GetGamePool('CVehicle')) do
        local vehPlate = GetVehicleNumberPlateText(veh)
        if (vehPlate == plate) then return VehToNet(veh); end;
    end
end

RegisterNuiCallback('saveVeh', function(data)
    local plate = vSERVER.getVehiclePlate(data.spawn)
    local netVeh = getNetVeh(plate)
    if (netVeh) then cli.tryDeleteVehicle(netVeh); end;
end)

RegisterNuiCallback('useVeh', function(data)
    vSERVER.spawnVehicle(data.spawn, nearestGarages.id)
end)

RegisterNuiCallback('close', function()
    SetNuiFocus(false, false)
end)