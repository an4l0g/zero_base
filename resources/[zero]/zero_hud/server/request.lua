requests = {}

srv.request = function(source, title, time)
    local id = 'request:'..source..':'..os.time()
    requests[id] = nil

    cli.createRequest(source, id, title, time)
end
exports('request', srv.request)

RegisterCommand('request', function(source, args)
    srv.request(source, 'Você quer casar comigo?', 5000)
end)
