prompts = {}

srv.prompt = function(source, questions)
    local async_response = async()
    prompts[source] = async_response
    cli.createPrompt(source, questions)

    return async_response:wait()
end
exports('prompt', srv.prompt)

srv.resultPrompt = function(responses)
    local _source = source
    prompts[_source](responses)
    prompts[_source] = nil
end