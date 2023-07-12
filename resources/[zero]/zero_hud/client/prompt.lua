cli.createPrompt = function(questions)
    SetNuiFocus(true, true)
    SendNUIMessage({
        method = 'prompt',
        data = {
            questions = questions
        }
    })
end

local response = false

RegisterNuiCallback('promptResult', function(data)
    response = true
    srv.resultPrompt(data.responses)
    SetNuiFocus(false, false)
end)

RegisterNuiCallback('closePrompt', function()
    if (not response) then
        srv.resultPrompt(false)
        SetNuiFocus(false, false)
    else
        response = false
    end
end)