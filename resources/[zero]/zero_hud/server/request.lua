Tools = module('vrp','lib/Tools')
requests = {}

idGenerator = Tools.newIDGenerator()

srv.request = function(source, title, time)
    if not time then time = 5000 end
    local id = source..':'..idGenerator:gen()
    local async_response = async()
    requests[id] = async_response
    cli.createRequest(source, id, title, time)

    SetTimeout(time, function()
        async_response(false)
        requests[id] = nil
    end)

    return async_response:wait()
end
exports('request', srv.request)

srv.resultRequest = function(id, response)
    local currentRequest = requests[id]
    currentRequest(response)
    requests[id] = nil
end

RegisterCommand('request', function(source, args)
    local result = srv.request(source, 'Você quer casar comigo?')
end)
