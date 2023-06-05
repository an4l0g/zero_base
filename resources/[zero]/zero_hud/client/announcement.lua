RegisterNetEvent('announcement', function(title, message, author, playAudio, time)
    SendNUIMessage({
        method = 'announcement',
        data = {
            title = title,
            message = message,
            author = author,
            playAudio = playAudio,
            time = (time or 5000)
        }
    })
end)

