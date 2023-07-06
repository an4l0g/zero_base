local vehiclesConfig = config.vehicles

vehicleName = function(vehicle)
	if (vehiclesConfig[vehicle].name) then return vehiclesConfig[vehicle].name; end;
	print('^5[Zero Garage] Vehicle ['..tostring(vehicle)..'] not found.^0')
end
exports('vehicleName', vehicleName)

vehicleMaker = function(vehicle)
	if (vehiclesConfig[vehicle].maker) then return vehiclesConfig[vehicle].maker; end;
	print('^5[Zero Garage] Vehicle ['..tostring(vehicle)..'] not found.^0')
end
exports('vehicleMaker', vehicleMaker)

vehicleType = function(vehicle)
	if (vehiclesConfig[vehicle].type) then return vehiclesConfig[vehicle].type; end;
	print('^5[Zero Garage] Vehicle ['..tostring(vehicle)..'] not found.^0')
end
exports('vehicleType', vehicleType)

vehicleSize = function(vehicle)
	if (vehiclesConfig[vehicle].trunk) then return vehiclesConfig[vehicle].trunk; end;
	print('^5[Zero Garage] Vehicle ['..tostring(vehicle)..'] not found.^0')
    return 0
end
exports('vehicleSize', vehicleSize)

vehicleClass = function(vehicle)
	if (vehiclesConfig[vehicle].class) then return vehiclesConfig[vehicle].class; end;
	print('^5[Zero Garage] Vehicle ['..tostring(vehicle)..'] not found.^0')
end
exports('vehicleClass', vehicleClass)

vehicleGlove = function(vehicle)
	if (vehiclesConfig[vehicle].glove) then return vehiclesConfig[vehicle].glove; end;
	print('^5[Zero Garage] Vehicle ['..tostring(vehicle)..'] not found.^0')
	return 0
end
exports('vehicleGlove', vehicleGlove)

vehiclePrice = function(vehicle)
	if (vehiclesConfig[vehicle].price) then return vehiclesConfig[vehicle].price; end;
	print('^5[Zero Garage] Vehicle ['..tostring(vehicle)..'] not found.^0')
end
exports('vehiclePrice', vehiclePrice)

vehicleBanned = function(vehicle)
	if (vehiclesConfig[vehicle].banned) then return vehiclesConfig[vehicle].banned; end;
	print('^5[Zero Garage] Vehicle ['..tostring(vehicle)..'] not found.^0')
end
exports('vehicleBanned', vehicleBanned)

vehicleData = function(vehicle)
    if (vehiclesConfig[vehicle]) then return vehiclesConfig[vehicle]; end;
	print('^5[Zero Garage] Vehicle ['..tostring(vehicle)..'] not found.^0')
end
exports('vehicleData', vehicleData)

local hashesConfig = config.hashes

vehHashData = function(hash, displayName)
	if (hashesConfig[hash]) then
		local vname = hashesConfig[hash]
		return vname, vehiclesConfig[vname]
	end
	print('^5[Zero Garage] Vehicle ['..hash..'/'..tostring(displayName)..'] not found.^0')
end
exports('vehHashData', vehHashData)

local forms = {
    plate = 'LLL DLDD',
    chassi = 'AALLLDDLDALDDDDDD'
}

local idGenerator = function(format)
	local num = {'0','1','2','3','4','5','6','7','8','9'}
	local alg = {'A','B','C','D','E','F','G','H','J','K','L','M','N','P','R','S','T','U','V','W','X','Y','Z'}
	local all = {'0','1','2','3','4','5','6','7','8','9','A','B','C','D','E','F','G','H','J','K','L','M','N','P','R','S','T','U','V','W','X','Y','Z'}
	local number = ''
	for i=1,#format do
		local char = string.sub(format,i,i)
    	if char == 'D' then number = number..num[math.random(#num)]
		elseif char == 'L' then number = number..alg[math.random(#alg)]
		elseif char == 'A' then number = number..all[math.random(#all)]
		else number = number..char end
	end
	return number
end

getPlateOwner = function(plate)
	if plate and (plate ~= '') then
		local car = zero.query('zero_garage/getVehiclesWithPlate', { plate = plate })[1]
		if (car) then return car.user_id, car.vehicle; end;
	end
end

generatePlate = function()
	local user_id = nil
	local nplate = ''
	repeat
		nplate = idGenerator(forms.plate)
		user_id = getPlateOwner(nplate)
	until not user_id
	return nplate
end
exports('generatePlate', generatePlate)

getChassisOwner = function(chassi)
	if chassi and (chassi ~= '') then
		local car = zero.query('zero_garage/getVehiclesWithChassis', { chassis = chassi })[1]
		if (car) then return car.user_id, car.vehicle; end;
	end
end

generateChassis = function()
	local user_id = nil
	local nchassi = ''
	repeat
		nchassi = idGenerator(forms.chassi)
		user_id = getChassisOwner(nchassi)
	until not user_id
	return nchassi
end
exports('generateChassis', generateChassis)

addVehicle = function(user_id, vehicle, service)
	zero.execute('zero_garage/addVehicle', { user_id = user_id, vehicle = vehicle, plate = generatePlate(), chassis = generateChassis(), ipva = os.time(), service = service })
end
exports('addVehicle', addVehicle)

delVehicle = function(user_id, vehicle)
	zero.execute('zero_garage/delVehicle', { user_id = user_id, vehicle = vehicle })
end
exports('delVehicle', delVehicle)

setRentedVehicle = function(user_id, vehicle, days)
	local timing = (((days > 0) and (os.time() + math.floor(days*24*60*60))) or 0)
	zero.execute('zero_garage/setRented', { user_id = user_id, vehicle = vehicle, rented = timing })
end
exports('setRentedVehicle', setRentedVehicle)

updateVehiclePlate = function(source, user_id, vehicle, plate)
	local query = zero.query('zero_garage/getVehicleWithPlate', { plate = plate })[1]
	if (not query) then
		zero.execute('zero_garage/updatePlate', { user_id = user_id, vehicle = vehicle, plate = plate })
		TriggerClientEvent('notify', source, 'Garagem', 'A placa do seu <b>veículo</b> foi alterada com sucesso.')
	else
		TriggerClientEvent('notify', source, 'Garagem', 'Já possui um <b>veículo</b> com esta placa.')
	end
end
exports('updateVehiclePlate', updateVehiclePlate)

getVehicleInfosWithPlate = function(plate)
	local vehData = zero.query('zero_garage/getVehByPlate', { plate = (plate or '') })[1]
    if (vehData) then return vehData.user_id, vehData.vehicle, vehData.chassis; end;
end
exports('getVehicleInfosWithPlate', getVehicleInfosWithPlate)