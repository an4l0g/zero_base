cli.createPrompt = function(questions)
    SetNuiFocus(true, true)
    SendNUIMessage({
        method = 'prompt',
        data = {
            questions = questions
        }
    })
end

RegisterNuiCallback('promptResult', function(data)
    srv.resultPrompt(data.responses)
end)

RegisterNuiCallback('closePrompt', function()
    SetNuiFocus(false, false)
end)