zero.getNearestVehicles = function(radius, network)
	local r = {}
	local pCDS = GetEntityCoords(PlayerPedId())
	for _,veh in pairs(GetGamePool('CVehicle')) do
		local vCDS = GetEntityCoords(veh)
		local distance = #(pCDS - vCDS)
		if distance <= radius then
			if network then
				local netId = NetworkGetNetworkIdFromEntity(veh)
				if netId then
				  	r[netId] = distance
				end
			else
				r[veh] = distance
			end
		end
	end
	return r
end

zero.getNearestVehicle = function(radius, network)
	local veh
	local vehs = zero.getNearestVehicles(radius,network)
	local min = radius+0.0001
	for _veh,dist in pairs(vehs) do
		if dist < min then
			min = dist
			veh = _veh
		end
	end
	return veh 
end

zero.ejectVehicle = function()
	local ped = PlayerPedId()
	if IsPedSittingInAnyVehicle(ped) then
		TaskLeaveVehicle(ped,GetVehiclePedIsIn(ped),4160)
	end
end

zero.isInVehicle = function()
	return IsPedSittingInAnyVehicle(PlayerPedId())
end

zero.GetVehicleSeat = function()
	local ped = PlayerPedId()
	local vehicle = GetVehiclePedIsIn(ped)
	if vehicle > 0 then
    	local seats = GetVehicleModelNumberOfSeats(GetEntityModel(vehicle))
		for i=-1,seats do
			if (GetPedInVehicleSeat(vehicle, i) == ped) then
				return i
			end
		end
	end
end

local vehicles = {}
RegisterNetEvent('zero:clearVehicleCache', function() vehicles = {}; end)

zero.vehList = function(radius)
	local ped = PlayerPedId()
	local veh = GetVehiclePedIsUsing(ped)
	if (not IsPedInAnyVehicle(ped)) then veh = zero.getNearestVehicle(radius); end;
	if IsEntityAVehicle(veh) then
		local hash = GetEntityModel(veh)
		local displayName = GetDisplayNameFromVehicleModel(hash)

		if (not vehicles[hash]) then 
			local model, info = zeroServer.vehHashData(hash, displayName)
			if model then 
				vehicles[hash] = info
				vehicles[hash].model = model
			end
		end
		
		local data = vehicles[hash]
		if data and data.model then
			local lock = GetVehicleDoorLockStatus(veh)
			local trunk = GetVehicleDoorAngleRatio(veh,5)
			local vehcoords = GetEntityCoords(veh)
			local tuning = { GetNumVehicleMods(veh,13),GetNumVehicleMods(veh,12),GetNumVehicleMods(veh,15),GetNumVehicleMods(veh,11),GetNumVehicleMods(veh,16) }
			return veh,VehToNet(veh),GetVehicleNumberPlateText(veh),data.model,lock,data.banned,trunk,displayName,GetStreetNameFromHashKey(GetStreetNameAtCoord(vehcoords.x,vehcoords.y,vehcoords.z)),tuning
		end
		print('^5[Zero Garage] Vehicle ['..hash..'] -> ['..displayName..']^0')
		return veh,VehToNet(veh)
	end
end