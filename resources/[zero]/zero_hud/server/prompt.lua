local prompts = {}

srv.prompt = function(source, questions)
    local async = async()
    prompts[source] = async
    cli.createPrompt(source, questions)
    return async:wait()
end
exports('prompt', srv.prompt)

srv.resultPrompt = function(response)
    local prompt = prompts[source]
    if (prompt) then
        prompt(response)
        prompts[source] = nil
    end
end