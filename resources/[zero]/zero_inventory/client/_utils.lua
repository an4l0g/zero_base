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

RegisterNetEvent('zero_inventory:LockpickAnim', function(vehicle)
	SetVehicleNeedsToBeHotwired(vehicle, true)
	IsVehicleNeedsToBeHotwired(vehicle)
end)