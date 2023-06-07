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
    SetNuiFocus(false, false)
end)

RegisterNuiCallback('closePrompt', function()
    srv.resultPrompt(false)
    SetNuiFocus(false, false)
end)