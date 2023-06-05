RegisterNetEvent('progressBar', function(title, time)
    SendNUIMessage({
        method = 'progress',
        data = {
            title = title,
            time = (time or 10000)
        }
    })
end)