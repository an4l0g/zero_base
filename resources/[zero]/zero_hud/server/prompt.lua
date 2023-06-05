prompts = {}

srv.createPrompt = function(source, questions)
    local async_response = async()
    prompts[source] = async_response
    cli.createPrompt(source, questions)

    return async_response:wait()
end

srv.resultPrompt = function(responses)
    local _source = source
    prompts[_source](responses)
    prompts[_source] = nil
end

RegisterCommand('prompt', function(source, args)
    local result = srv.createPrompt(source, {
        'Qual seu nome?',
        'Qual seu sobrenome?',
        'Qual sua idade?'
    })
end)
