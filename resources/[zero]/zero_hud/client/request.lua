requests = {}

cli.createRequest = function(id, title, time)
    if (time < 1000) then time = (time * 1000); end;

    table.insert(requests, id)
    SendNUIMessage({
        method = 'request',
        data = {
            id = id, 
            title = title,
            time = time
        }
    })
end

cli.resultRequest = function(result)
    if #requests > 0 and requests[#requests] ~= nil then
        local currentRequest = requests[#requests]
        SendNUIMessage({
            method = 'removeRequest',
            data = {
                id = currentRequest
            }
        })
        srv.resultRequest(currentRequest, result)
        table.remove(requests, #requests)
    end
end

RegisterNuiCallback('onAutoCloseRequest', function(data)
    srv.resultRequest(data.id, false)
    for k,v in pairs(requests) do
        if v == data.id then
            table.remove(requests, k)
        end
    end
end)

RegisterKeyMapping('accept_request', 'Aceitar requisição', 'keyboard', 'y')
RegisterCommand('accept_request', function()
    cli.resultRequest(true)
end)

RegisterKeyMapping('reject_request', 'Rejeitar requisição', 'keyboard', 'u')
RegisterCommand('reject_request', function()
    cli.resultRequest(false)
end)