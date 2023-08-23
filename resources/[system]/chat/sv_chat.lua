vCLIENT = Tunnel.getInterface('chat')

RegisterServerEvent('chat:messageEntered')
AddEventHandler('chat:messageEntered', function(message)
	local source = source
	local user_id = zero.getUserId(source)
	if user_id then
		local identity = zero.getUserIdentity(user_id)
		if identity then
			TriggerClientEvent('chatMessage', source, identity.firstname..' '..identity.lastname, { 0, 153, 255 },message)
			local players = zeroClient.getNearestPlayers(source, 35)
			for k,v in pairs(players) do
				async(function()
					TriggerClientEvent('chatMessage', k, identity.firstname..' '..identity.lastname, { 0, 153, 255 },message)
				end)
			end
		end
        zero.webhook('Chat', '```prolog\n[CHATS GERAL]\n[JOGADOR]: #'..user_id..' '..identity.firstname..' '..identity.lastname..'\n[MENSAGEM]: '..message..'\n[COORDENADA]: '..tostring(GetEntityCoords(GetPlayerPed(source)))..' '..os.date('\n[DATA]: %d/%m/%Y [HORA]: %H:%M:%S')..' \r```')
	end
end)

RegisterServerEvent('__cfx_internal:commandFallback')
AddEventHandler('__cfx_internal:commandFallback',function(command)
	local name = GetPlayerName(source)
	if not command or not name then
		return
	end

	CancelEvent()
end)

RegisterCommand('clearchat', function(source)
    local user_id = zero.getUserId(source);
    if user_id ~= nil then
        if zero.hasPermission(user_id, '+Staff.Administrador') then
            TriggerClientEvent('chat:clear', -1);
        else
            TriggerClientEvent('chat:clear', source);
        end
    end
end)

RegisterCommand('togglechat', function(source)
	vCLIENT.disableChat(source)
end)

disableChat = function(source, bool)
	vCLIENT.desactiveChat(source, bool)
end
exports('DisableChat', disableChat)

function statusChat(source)
	return vCLIENT.statusChat(source)
end

exports('statusChat',statusChat)