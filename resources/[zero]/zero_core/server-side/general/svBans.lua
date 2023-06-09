vRP._prepare('zero_hwid/setUserTokens', 'replace into zero_hwid (token, user_id) values (@token, @user_id)')
vRP._prepare('zero_hwid/getUserTokens', 'select * from zero_hwid where token = @token')
vRP._prepare('zero_hwid/getUserIpBanned', 'select id from zero_users where ip = @ip and banned = 1')
vRP._prepare('zero_hwid/userIsBanned', 'select banned from zero_users where id = @user_id')
vRP._prepare('zero_hwid/setUserBanned', 'update zero_users set banned = @banned where id = @user_id')

webhooks = {}
webhooks.hwid = 'https://discord.com/api/webhooks/1116585321090523187/hQCrStNv5P6ofa-2liNyI2481-wj1daSztypXxvI-lwFKq5h5tlT1T2I7njCfchhAP-g'
webhooks.ipbanned = 'https://discord.com/api/webhooks/1116585370478456882/gM6V3HcFxMIsTTSZBGhs6whNafkB7Z9HiXF1bFAu2TYOAgnHIBy1P6hnbDxYLH3cEHjS'

local userIsBanned = function(user_id)
    local getBanned = vRP.query('zero_hwid/userIsBanned', { user_id = user_id })[1].banned
    if (getBanned == 1) then return true; end;
    return false
end
exports('isBanned', userIsBanned)

local setUserBanned = function(user_id, banned)
    vRP.execute('zero_hwid/setUserBanned', { user_id = user_id, banned = banned } )
end
exports('setBanned', userIsBanned)

AddEventHandler('vRP:playerSpawn', function(user_id, source, firstSpawn)
    local userTokens = GetNumPlayerTokens(source)
    local identifiers = vRP.getIdentifiers(source)
    if (identifiers.ip) then
        local playerIP = identifiers.ip:gsub('ip:', '')
        local rows = vRP.query('zero_hwid/getUserIpBanned', { ip = playerIP })
        if (#rows > 0) then
            local users = ''
            for _, value in ipairs(rows) do
                users = users..value.id..', '
            end
            print('^5[ZERO SYSTEM]^7 IP BANIDO: '..playerIP..' | PLAYER: '..user_id..' | IDS: '..users)
            zero.webhook(webhooks.ipbanned, '```prolog\n[ZERO SYSTEM - IP BANNED]\n[PASSAPORTE]: '..user_id..'\n[IP BANNED]: '..(playerIP or '0.0.0')..'\n\n[USERS]: '..users..'\n'..((banido and '[BANIDO AUTOMATICAMENTE]\n') or '')..os.date('\n[DATA]: %d/%m/%Y [HORA]: %H:%M:%S')..'\n```')
        end
    end
    for i = 0, userTokens do
        local token = GetPlayerToken(source, i)
        if (token) then
            local getUserTokens = vRP.query('zero_hwid/getUserTokens', { token = token })[1]
            if (getUserTokens) then
                if (userIsBanned(getUserTokens.user_id)) then
                    setUserBanned(user_id, true)
                    DropPlayer(source, '[ZERO SYSTEM] Você já foi banido neste servidor.\n[ID ANTIGO]: '..getUserTokens.user_id..'\n[ID ATUAL]: '..user_id..'\nEntre em contato conosco em nosso discord. discord.gg/example')
                    zero.webhook(webhooks.hwid, '```prolog\n[ZERO SYSTEM - HWID BANNED]\n[PASSAPORTE]: '..user_id..'\n[ID BANNED]: '..getUserTokens.user_id..os.date('\n[DATA]: %d/%m/%Y [HORA]: %H:%M:%S')..'\n```')
                end
            else
                vRP.execute('zero_hwid/setUserTokens', { token = token, user_id = user_id } )
            end
        end
    end
end)