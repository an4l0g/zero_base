RegisterNetEvent('clipboard', function(title, value)
    SetNuiFocus(true, true)
    SendNUIMessage({
        method = 'clipboard',
        data = {
            title = title,
            value = value
        }
    })
end)