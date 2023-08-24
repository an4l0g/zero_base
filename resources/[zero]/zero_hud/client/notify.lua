RegisterNetEvent('notify', function(title, message, time)
    SendNUIMessage({
        method = 'notify',
        data = {
            title = title,
            message = message,
            time = (time or 5000)
        }
    })
end)
