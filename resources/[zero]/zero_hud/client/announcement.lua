RegisterNetEvent('announcement', function(title, message, author, playAudio, time)
    if not time then time = 5000 end
    SendNUIMessage({
        method = 'announcement',
        data = {
            title = title,
            message = message,
            author = author,
            playAudio = playAudio,
            time = time
        }
    })
end)

RegisterCommand('anuncio', function()
    TriggerEvent('announcement', 'Prefeitura', 'Olá Zero!! Chupa meu cu', 'An4log', false)
end)
