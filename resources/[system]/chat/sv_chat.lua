vCLIENT = Tunnel.getInterface('chat')

local webhookChat = ''

RegisterServerEvent('chat:messageEntered')
AddEventHandler('chat:messageEntered', function(message)
	local source = source
	local user_id = zero.getUserId(source)
	if user_id then
		local identity = zero.getUserIdentity(user_id)
		if identity then
			TriggerClientEvent('chatMessage', source, 'Bruce Wayne', { 0, 153, 255 },message)
			local players = zeroClient.getNearestPlayers(source, 35)
			for k,v in pairs(players) do
				async(function()
					TriggerClientEvent('chatMessage', k, identity.firstname..' '..identity.lastname, { 0, 153, 255 },message)
				end)
			end
		end
        local coord = GetEntityCoords(GetPlayerPed(source))
		zero.webhook(webhookChat,'```prolog\n[CHATS ORG]\n[GLOBAL]\n[JOGADOR]: #'..user_id..' '..identity.firstname..' '..identity.lastname..'\n[MENSAGEM]: '..message..'\n[COORDENADA]: '..tostring(coord)..' '..os.date('\n[DATA]: %d/%m/%Y [HORA]: %H:%M:%S')..' \r```')
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
        if zero.hasPermission(user_id, 'admin.permissao') then
            TriggerClientEvent('chat:clear', -1);
        else
            TriggerClientEvent('chat:clear', source);
        end
    end
end)

function statusChat(source)
	return vCLIENT.statusChat(source)
end

exports('statusChat',statusChat)