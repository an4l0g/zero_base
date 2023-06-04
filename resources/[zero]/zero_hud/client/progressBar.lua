RegisterNetEvent('progressBar', function(title, time)
    SendNUIMessage({
        method = 'progress',
        data = {
            title = title,
            time = time
        }
    })
end)

RegisterCommand('pbar', function()
    TriggerEvent('progressBar', 'Equipe Zero', 5000)
end)