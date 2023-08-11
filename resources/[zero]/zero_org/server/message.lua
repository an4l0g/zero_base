gbMessage = {}

Tunnel.bindInterface('gb_core_ilegal/message', gbMessage)

gbMessage.sendMessageToFac = function(fac, type_message, message)
    local allMembers = gbMembers.getAllMembers(fac)
    local currentMember
    for k,v in pairs(allMembers) do
        currentMember = vRP.getUserSource(v.user_id)
        if currentMember then
            TriggerClientEvent('Notify', currentMember, type_message, message, 20000)
        end
    end
    return { result = 'success', message = 'Mensagem geral enviada para a organização!' }
end