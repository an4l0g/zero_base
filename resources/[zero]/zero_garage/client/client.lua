local cli = {}
Tunnel.bindInterface('Garage', cli)
local vSERVER = Tunnel.getInterface('Garage')

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
    DrawMarker(markers[(config.marker or 'car')], config.coords.x, config.coords.y, config.coords.z+0.1, 0, 0, 0, 0, 0, 0, 0.8, 0.8, 0.8, 0, 153, 255, 155, 1, 0, 0, 1)
    DrawMarker(27, config.coords.x, config.coords.y, config.coords.z-0.97, 0, 0, 0, 0, 0, 0, 1.2, 1.2, 1.2, 0, 153, 255, 155, 0, 0, 0, 1)
end

local nearestBlips = {}

local _markerThread = false
local markerThread = function()
    if (_markerThread) then return; end;
    _markerThread = true
    Citizen.CreateThread(function()
        while (countTable(nearestBlips) > 0) do
            local ped = PlayerPedId()
            local _cache = nearestBlips
            for index, dist in pairs(_cache) do
                if (dist <= 10) then
					local config = garagesConfig[index]
                    createMarker(config)
                    if (dist <= 1.2 and IsControlJustPressed(0, 38) and GetEntityHealth(ped) > 100 and not IsPedInAnyVehicle(ped)) then
                        openGarage(index) 
						CheckNui(ped, GetEntityCoords(PlayerPedId()), 1.3)
                    end
                end
            end
            Citizen.Wait(1)
        end
        _markerThread = false
    end)
end

Citizen.CreateThread(function()
	CreateBlip()
    while (true) do
        local ped = PlayerPedId()
        local pCoord = GetEntityCoords(ped)
        nearestBlips = {}
        for k, v in pairs(garagesConfig) do
            local distance = #(pCoord - v.coords)
            if (distance <= 10) then
                nearestBlips[k] = distance
            end
        end
        if (countTable(nearestBlips) > 0) then markerThread(); end;
        Citizen.Wait(500)
    end
end)

local nearestGarageId = 0

openGarage = function(index)
	nearestGarageId = index
	local config = garagesConfig[index]
    if (vSERVER.checkPermissions(config.permission, config.home)) then
		inGarage = true
		TriggerEvent('zero_core:tabletAnim')
        SetNuiFocus(true, true)
        SendNUIMessage({
            action = 'open',
            cars = vSERVER.getMyVehicles(index)
        })
    end
end

cli.addGarage = function(name, data)
	garagesConfig[name] = data
	if (nearestBlips[name] ~= nil) then nearestBlips[name] = nil; end;
end

RegisterNetEvent('zero_garage:removeGarage', function(name)
	garagesConfig[name] = nil
	if (nearestBlips[name] ~= nil) then nearestBlips[name] = nil; end;
end)

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
    -- local timeOut = (GetGameTimer() + 4000)
    while (not NetworkDoesEntityExistWithNetworkId(vnet)) do
        Citizen.Wait(100)
        -- if (GetGameTimer() > timeOut) then return; end;
    end

	local vehicle = NetToVeh(vnet)
	while (not DoesEntityExist(vehicle)) do Citizen.Wait(100) end

	if (DoesEntityExist(vehicle)) then
    -- local nveh = NetworkGetEntityFromNetworkId(vnet)
    -- if (nveh) then
        -- local timeOut = (GetGameTimer() + 4000)
        -- NetworkRequestControlOfEntity(nveh)
		-- while (not NetworkHasControlOfEntity(nveh)) do
		-- 	NetworkRequestControlOfEntity(nveh)
		-- 	Citizen.Wait(10)
		-- 	if (GetGameTimer() > timeOut) then return; end;
		-- end

		SetVehicleNumberPlateText(vehicle, plate)
        SetVehicleIsConsideredByPlayer(vehicle, true)
        SetVehicleHasBeenOwnedByPlayer(vehicle, true)
		SetVehicleIsStolen(vehicle,false)
		SetVehicleNeedsToBeHotwired(vehicle, false)
		SetVehicleOnGroundProperly(vehicle)
		SetEntityAsMissionEntity(vehicle, true, true)
		SetVehRadioStation(vehicle, 'OFF')
		SetVehicleEngineOn(vehicle, false, true, true)

        if (DecorIsRegisteredAsType('Player_Vehicle', 3)) then DecorSetInt(vehicle, 'Player_Vehicle', -1); end;
        
        Entity(vehicle).state:set('veh:spawning', nil, true)
		TriggerEvent('zero_bennys:applymods', vnet, custom)

		if (state.data.fuel) then 
			cli.setVehicleState(vehicle, state, false) 
		else
			SetVehicleFuelLevel(vehicle, 100.0)
		end
        return true
    -- end
	end
end

cli.returnToNet = function(vehicle)
    return VehToNet(vehicle)
end

cli.tryDeleteVehicle = function(vnet)
	if (NetworkDoesNetworkIdExist(vnet)) then
		local vehicle = NetToVeh(vnet)
		if (IsEntityAVehicle(vehicle)) then
			vSERVER.tryDelete(vnet, cli.getVehicleState(vnet, false))
		end
	end
end
exports('deleteVehicle', cli.tryDeleteVehicle)

local gps = {}
local vehBlips = {}

cli.syncBlips = function(vnet, vname, plate)
    gps[vname] = true
    Citizen.CreateThread(function()
        while (gps[vname]) do
            if (NetworkDoesNetworkIdExist(vnet)) then
                local nveh = NetToVeh(vnet)
                if (GetBlipFromEntity(nveh) == 0) then
                    vehBlips[vname] = AddBlipForEntity(nveh)
                    SetBlipSprite(vehBlips[vname], 161)
					SetBlipAsShortRange(vehBlips[vname], false)
					SetBlipColour(vehBlips[vname], 3)
					SetBlipScale(vehBlips[vname], 0.4)
					BeginTextCommandSetBlipName('STRING')
					AddTextComponentString('Rastreador: ~b~'..plate)
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
RegisterCommand('+lockVehicle', function() vSERVER.vehicleLock() end)

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

cli.getHash = function(vehiclehash)
    local vehicle = zero.getNearestVehicle(7.0)
    local vehiclehash = GetEntityModel(vehicle)
    return vehiclehash
end

local vehAnchor = false

cli.getVehicleAnchor = function()
    return vehAnchor, (vehAnchor and 'Destravando o veículo...' or 'Travando o veículo...')
end

cli.vehicleAnchor = function(vnet, bool)
	if (NetworkDoesNetworkIdExist(vnet)) then
		local vehicle = NetToVeh(vnet)
		if (IsEntityAVehicle(vehicle)) then
			if (bool ~= nil) then
				TriggerEvent('notify', 'Garagem', 'O veículo foi <b>'..((bool and 'travado') or 'destravado')..'</b>.')
				FreezeEntityPosition(vehicle, (bool == true))
			else
				vehAnchor = (not vehAnchor)
				TriggerEvent('notify', 'Garagem', 'O veículo foi <b>'..((vehAnchor and 'travado') or 'destravado')..'</b>.')
				FreezeEntityPosition(vehicle, (vehAnchor == true))
			end
		end
	end
end

local boatanchor = false

cli.boatAnchor = function(vehicle)
	if (IsEntityAVehicle(vehicle) and GetVehicleClass(vehicle) == 14) then
		if (boatanchor) then
			TriggerEvent('notify', 'Garagem', 'O <b>barco</b> foi desancorado.')
			FreezeEntityPosition(vehicle, false)
			boatanchor = false
		else
			TriggerEvent('notify', 'Garagem', 'O <b>barco</b> foi ancorado.')
			FreezeEntityPosition(vehicle, true)
			boatanchor = true
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
    vSERVER.spawnVehicle(data.spawn, nearestGarageId, GlobalState.vehicleToken)
end)

RegisterNuiCallback('close', function()
    SetNuiFocus(false, false)
	TriggerEvent('zero_core:stopTabletAnim')
end)

RegisterNetEvent('syncreparar', function(index)
	if (NetworkDoesNetworkIdExist(index)) then
		local v = NetToVeh(index)
		if (DoesEntityExist(v)) then
			local fuel = GetVehicleFuelLevel(v)
			if (IsEntityAVehicle(v)) then
				SetVehicleFixed(v)
				SetVehicleDirtLevel(v, 0.0)
				SetVehicleUndriveable(v, false)
				Citizen.InvokeNative(0xAD738C3085FE7E11, v, true, true)
				SetVehicleOnGroundProperly(v)
				SetVehicleFuelLevel(v, fuel)
			end
		end
	end
end)

local vehicleTrunk, vehNetTrunk = nil

updateTrunkInfos = function()
	vehicleTrunk, vehNetTrunk = zero.vehList(5.0)
end

local inTrunk = false

RegisterNetEvent('zero_garage:enterTrunk')
AddEventHandler('zero_garage:enterTrunk', function()
    local ped = PlayerPedId()
	local vehicle, vehNet, vehPlate, vehName, vehLock, vehBlock, vehHealth = zero.vehList(5.0)
    if (not inTrunk) then
		local isopen = GetVehicleDoorAngleRatio(vehicle, 4)
		if (DoesEntityExist(vehicle) and not IsPedInAnyVehicle(ped)) then
			if (vSERVER.checkTrunk(vehNet)) then
				if (GetVehicleDoorLockStatus(vehicle) == 1) then
					local trunk = GetEntityBoneIndexByName(vehicle, 'boot')
					if (trunk ~= -1) then
						local coords = GetEntityCoords(ped)
						local coordsEnt = GetWorldPositionOfEntityBone(vehicle, trunk)
						local distance = #(coords - coordsEnt)
						if (distance <= 3.0) then
							if (GetVehicleDoorAngleRatio(vehicle, 5) < 0.9 and GetVehicleDoorsLockedForPlayer(vehicle, PlayerId()) ~= 1) then
								vSERVER.insertTrunk(vehNet)
								updateTrunkInfos()
								SetCarBootOpen(vehicle)
								SetEntityVisible(ped, false, false)
								Citizen.Wait(750)
								AttachEntityToEntity(ped, vehicle, -1, 0.0, -2.2, 0.5, 0.0, 0.0, 0.0, false, false, false, false, 20, true)
								inTrunk = true
								trunkThread()
								Citizen.Wait(500)
								SetVehicleDoorShut(vehicle, 5)
							end
						end
					end
				else
					TriggerEvent('notify', 'Garagem', 'O <b>veículo</b> se encontra trancado.')
				end
			end
		end
	else
		vSERVER.removeTrunk(vehNet)
    end
end)

RegisterNetEvent('zero_garage:checkTrunk')
AddEventHandler('zero_garage:checkTrunk', function()
	local ped = PlayerPedId()
	if (inTrunk) then
		local vehicle = GetEntityAttachedTo(ped)
		if (DoesEntityExist(vehicle)) then
			SetCarBootOpen(vehicle)
			Citizen.Wait(750)
			inTrunk = false
			vSERVER.removeTrunk(vehNetTrunk)
			vehicleTrunk, vehNetTrunk = nil
			DetachEntity(ped, false, false)
			SetEntityVisible(ped, true, false)
			SetEntityCoords(ped, GetOffsetFromEntityInWorldCoords(ped, 0.0, -1.5, -0.75))
			Citizen.Wait(500)
			SetVehicleDoorShut(vehicle, 5)
		end
	end
end)

trunkThread = function()
	Citizen.CreateThread(function()
		while (inTrunk) do
			local idle = 100
			if (inTrunk) then
				local ped = PlayerPedId()
				local vehicle = GetEntityAttachedTo(ped)
				if (DoesEntityExist(vehicle)) then
					idle = 1

					Text2D(0, 0.375, 0.9, 'PRESSIONE ~b~E~w~ PARA SAIR DO PORTA-MALAS', 0.4)

					DisableControlAction(1,73,true)
					DisableControlAction(1,29,true)
					DisableControlAction(1,47,true)
					DisableControlAction(1,187,true)
					DisableControlAction(1,189,true)
					DisableControlAction(1,190,true)
					DisableControlAction(1,188,true)
					DisableControlAction(1,311,true)
					DisableControlAction(1,245,true)
					DisableControlAction(1,257,true)
					DisableControlAction(1,167,true)
					DisableControlAction(1,140,true)
					DisableControlAction(1,141,true)
					DisableControlAction(1,142,true)
					DisableControlAction(1,137,true)
					DisableControlAction(1,37,true)
					DisablePlayerFiring(ped,true)

					if (IsEntityVisible(ped)) then SetEntityVisible(ped, false, false); end;

					if (IsControlJustPressed(1, 38)) then
						SetCarBootOpen(vehicle)
						Citizen.Wait(750)
						inTrunk = false
						vSERVER.removeTrunk(vehNetTrunk)
						vehicleTrunk, vehNetTrunk = nil
						DetachEntity(ped, false, false)
						SetEntityVisible(ped, true, false)
						SetEntityCoords(ped, GetOffsetFromEntityInWorldCoords(ped, 0.0, -1.5, -0.75))
						Citizen.Wait(500)
						SetVehicleDoorShut(vehicle, 5)
					end
				else
					inTrunk = false
					vSERVER.removeTrunk(vehNetTrunk)
					vehicleTrunk, vehNetTrunk = nil
					DetachEntity(ped, false, false)
					SetEntityVisible(ped, true, false)
					SetEntityCoords(ped, GetOffsetFromEntityInWorldCoords(ped, 0.0, -1.5, -0.75))
				end
			end
			Citizen.Wait(timeDistance)
		end
	end)
end

local _checkNui = false
CheckNui = function(entity, location, dist)
	Citizen.CreateThread(function()
		_checkNui = true
		while (_checkNui) do
			local distance = #(GetEntityCoords(entity) - location)
			if (distance > dist) then
				SetNuiFocus(true, true)
				SendNUIMessage({ action = 'close' })
				_checkNui = false
				break
			end
			Citizen.Wait(1000)
		end
	end)
end

Text2D = function(font, x, y, text, scale)
	SetTextFont(font)
	SetTextProportional(7)
	SetTextScale(scale, scale)
	SetTextColour(255, 255, 255, 255)
	SetTextDropShadow(0, 0, 0, 0,255)
	SetTextEdge(4, 0, 0, 0, 255)
	SetTextEntry("STRING")
	AddTextComponentString(text)
	DrawText(x, y)
end

CreateBlip = function()
	for k, v in pairs(config.garages) do
		if (v.showBlip) then
			local _config = config.blips[v.rule]

			local blip = AddBlipForCoord(v.coords.x,v.coords.y,v.coords.z)
			SetBlipSprite(blip,_config.sprite)
			SetBlipAsShortRange(blip,true)
			SetBlipColour(blip,_config.color)
			SetBlipScale(blip,_config.scale)
			BeginTextCommandSetBlipName('STRING')
			AddTextComponentString('Garagem')
			EndTextCommandSetBlipName(blip)
		end
	end
end