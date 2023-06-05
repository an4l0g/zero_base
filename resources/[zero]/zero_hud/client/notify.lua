RegisterNetEvent('notify', function(title, message, time)
    if not time then time = 5000 end
    SendNUIMessage({
        method = 'notify',
        data = {
            title = title,
            message = message,
            time = time
        }
    })
end)

RegisterCommand('notify', function()
    TriggerEvent('notify', 'Equipe Zero', 'Este é um teste de notificação!', 5000)
end)