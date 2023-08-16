open = function()
    SetNuiFocus(true, true)
    SendNUIMessage({
        action = 'open',
        listSpawns = cfg.spawns
    })
end

RegisterCommand('spawn', open)

RegisterNuiCallback('setSpawn', function(data)
    print(data.index) -- data.index
    SetNuiFocus(false, false)
    -- Index options: paleto, sandy, praca, pier, lastLocation
end)

RegisterNuiCallback('close', function()
    SetNuiFocus(false, false)
end)
