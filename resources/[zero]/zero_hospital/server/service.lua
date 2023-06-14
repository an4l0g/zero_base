services = {}

RegisterCommand('atendimento',function(source,args)
    local user_id = zero.getUserId(source)
    local user_identity = zero.getUserIdentity(user_id)
    local description = zero.prompt(source,{'O que você está sentindo?'})

    if services[user_id] == nil then

        services[user_id] = {
            firstname = user_identity.firstname,
            lastname = user_identity.lastname,
            age = user_identity.age,
            user_id = user_id,
            description = description[1]
        }
        TriggerClientEvent('notify', source, 'Centro Médico','Uma nova solicitação de atendimento foi aberta.')
    else
        TriggerClientEvent('notify', source, 'Centro Médico','Você já possui uma solicitação de atendimento aberta.')

    end    
    
end)

RegisterCommand('lista',function() 
print(json.encode(services))
end)