requests = {}

RegisterNetEvent('request', function(title, time)
    local id = 'request:'..os.time()
    requests[id] = nil

    SendNUIMessage({
        method = 'request',
        data = {
            title = title,
            time = time
        }
    })
end)

RegisterCommand('request', function()
    TriggerEvent('request', 'Você quer casar comigo?', 5000)
end)
