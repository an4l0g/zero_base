cli.createPrompt = function(questions)
    SetNuiFocus(true, true)
    SendNUIMessage({
        method = 'prompt',
        data = {
            questions = questions
        }
    })
end

RegisterNUICallback('promptResponse', function(data, cb)
    vSERVER.resultPrompt(data['response'])
end)