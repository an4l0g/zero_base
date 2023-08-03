local vCLIENT = Tunnel.getInterface('CarsEvent')

getCarDoorCoord = function(source, dist, door)
    return vCLIENT.getCarDoorCoord(source, dist, door)
end
exports('carDoor', getCarDoorCoord)

setVehicleAlarm = function(source)
    return vCLIENT.setVehicleAlarm(source)
end
exports('vehicleAlarm', setVehicleAlarm)