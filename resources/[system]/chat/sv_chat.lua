vCLIENT = Tunnel.getInterface('chat')

local webhookChat = 'https://discord.com/api/webhooks/1121126378612473966/Gf93900hWsmaZs3cLVLmxSVU7eX_JbRJsgC07KqcrE0p9I4AXjgnloC4-Ts_I0zgb1BG'

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
        zero.webhook(webhookChat, '```prolog\n[CHATS GERAL]\n[JOGADOR]: #'..user_id..' '..identity.firstname..' '..identity.lastname..'\n[MENSAGEM]: '..message..'\n[COORDENADA]: '..tostring(GetEntityCoords(GetPlayerPed(source)))..' '..os.date('\n[DATA]: %d/%m/%Y [HORA]: %H:%M:%S')..' \r```')
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