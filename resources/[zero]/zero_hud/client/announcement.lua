RegisterNetEvent('announcement', function(questions)
    SendNUIMessage({
        method = 'announcement',
        data = {
            questions = questions
        }
    })
end)

RegisterCommand('anuncio', function()
    TriggerEvent('announcement', {
        'Qual seu nome?',
        'Qual sua idade?',
        'Com o que você trabalha?'
    })
end)
