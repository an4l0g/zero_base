requests = {}

cli.createRequest = function(id, title, time)
    local currentRequest = { id = id, response = nil }
    table.insert(requests, currentRequest)
    SendNUIMessage({
        method = 'request',
        data = {
            id = id, 
            title = title,
            time = time
        }
    })
end

RegisterKeyMapping('+request_response', 'Aceitar requisição', 'keyboard', 'y')
RegisterCommand('+request_response', function()
    print(requests[#requests])
end)

RegisterKeyMapping('-request_response', 'Rejeitar requisição', 'keyboard', 'y')
RegisterCommand('-request_response', function()

end)