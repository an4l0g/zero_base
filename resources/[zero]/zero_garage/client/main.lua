RegisterCommand('garage', function()
    SetNuiFocus(true, true)
    SendNUIMessage({
        action = 'open',
        cars = {
            { type = 'car', spawn = 'amarok', name = 'Amarok', maker = 'Volkswagen', trunk_capacity = 100, trunk = 85, engine = 20, breaker = 90, transmission = 75, suspension = 90, fuel = 10 },
            { type = 'motocycle', spawn = 'xj6', name = 'xj6', maker = 'Xablau', trunk_capacity = 100, trunk = 40, engine = 100, breaker = 10, transmission = 10, suspension = 20, fuel = 30 },
            { type = 'motocycle', spawn = 'hornet', name = 'hornet', maker = 'Xablau 2', trunk_capacity = 100, trunk = 10, engine = 55, breaker = 40, transmission = 30, suspension = 50, fuel = 45 },
            { type = 'car', spawn = 'ferrariitalia', name = 'Italia', maker = 'Ferrari', trunk_capacity = 100, trunk = 30, engine = 70, breaker = 30, transmission = 45, suspension = 10, fuel = 35 },
            { type = 'car', spawn = 'xebureca', name = 'Xebureca', maker = 'Claudin', trunk_capacity = 100, trunk = 30, engine = 70, breaker = 30, transmission = 45, suspension = 10, fuel = 35 },
            { type = 'motocycle', spawn = 'motinha', name = 'Motinha', maker = 'Fernandinho', trunk_capacity = 100, trunk = 30, engine = 70, breaker = 30, transmission = 45, suspension = 10, fuel = 35 },
        }
    })
end)

RegisterNuiCallback('saveNextVeh', function()
    print("Guardar veículo próximo")
end)

RegisterNuiCallback('saveVeh', function(data)
    print("Guardar veículo: "..data.spawn)
end)

RegisterNuiCallback('useVeh', function(data)
    print("Retirar veículo: "..data.spawn)
end)

RegisterNuiCallback('close', function()
    SetNuiFocus(false, false)
end)