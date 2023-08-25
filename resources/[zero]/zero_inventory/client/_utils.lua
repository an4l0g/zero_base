cInventory.TextFloating = function(text, coord)
    AddTextEntry('FloatingHelpText', text)
    SetFloatingHelpTextWorldPosition(0, coord)
    SetFloatingHelpTextStyle(0, true, 2, -1, 3, 0)
    BeginTextCommandDisplayHelp('FloatingHelpText')
    EndTextCommandDisplayHelp(1, false, false, -1)
end

cInventory.animation = function(dict, anim, loop)
    zero.playAnim(true,{{dict,anim}},loop)
end

cInventory.getVehicleDamage = function()
    local pVehicle = GetClosestVehicle(GetEntityCoords(PlayerPedId()), 10.0, 0, 71)
    if (DoesEntityExist(vehicle)) then
        return GetVehicleEngineHealth(pVehicle)
    end
    return 0.0
end

RegisterNetEvent('zero_inventory:LockpickAnim', function(vehicle)
	SetVehicleNeedsToBeHotwired(vehicle, true)
	IsVehicleNeedsToBeHotwired(vehicle)
end)