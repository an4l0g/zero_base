getTime = function()
    local hours = GetClockHours()
	local minutes = GetClockMinutes()
    if hours <= 9 then hours = '0'..hours end
    if minutes <= 9 then minutes = '0'..minutes end
    return hours..':'..minutes
end

getHealth = function(ped)
    return (100 * (GetEntityHealth(ped) - 100) / (200 - 100))
end

getArmour = function(ped)
    return GetPedArmour(ped)
end

getOxygen = function(ped)
    if IsEntityInWater(ped) then
        local remain = GetPlayerUnderwaterTimeRemaining(PlayerId())*10
        return ((remain > 0) and remain) or 0
    end
    return -1
end

getSpeed = function(veh)
    return math.floor(GetEntitySpeed(veh) * 3.6)
end

getFuel = function(veh)
    return GetVehicleFuelLevel(veh)
end

getEngineHealth = function(veh)
    return GetVehicleEngineHealth(veh) / 10
end

updateHealth = function(currentHealth)
    SendNUIMessage({ method = 'updateHealth', data = currentHealth })
end

updateOxygen = function(currentOxygen)
    SendNUIMessage({ method = 'updateOxygen', data = currentOxygen })
end

updateArmour = function(currentArmour)
    SendNUIMessage({ method = 'updateArmour', data = currentArmour })
end

updateHunger = function(currentHunger)
    SendNUIMessage({ method = 'updateHunger', data = currentHunger })
end

updateThirst = function(currentThirst)
    SendNUIMessage({ method = 'updateThirst', data = currentThirst })
end

updateStreet = function(currentStreet)
    SendNUIMessage({ method = 'updateStreet', data = currentStreet })
end

updateTime = function(currentTime)
    SendNUIMessage({ method = 'updateTime', data = currentTime })
end

updateFuel = function(currentFuel)
    SendNUIMessage({ method = 'updateFuel', data = currentFuel })
end

updateEngineFuel = function(currentEngineHealth)
    SendNUIMessage({ method = 'updateEngineHealth', data = currentEngineHealth })
end

updateCurrentGear = function(currentGear)
    SendNUIMessage({ method = 'updateGear', data = currentGear })
end

updateSeatbelt = function(seatbeltOn)
    SendNUIMessage({method = 'updateSeatbelt', data = seatbeltOn })
end

updateLocked = function(currentLocked)
    SendNUIMessage({method = 'updateLocked', data = currentLocked })
end

updateVehicleSpeed = function(currentSpeed)
    SendNUIMessage({ method = 'updateSpeed', data = currentSpeed })
end

updateCupom = function(currentCupom)
    SendNUIMessage({ method = 'updateCupom', data = currentCupom })
end