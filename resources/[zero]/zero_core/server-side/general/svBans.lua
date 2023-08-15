zero.prepare('zero_hwid/setUserTokens', 'replace into hwid (token, user_id) values (@token, @user_id)')
zero.prepare('zero_hwid/getUserTokens', 'select * from hwid where token = @token')
zero.prepare('zero_hwid/getUserIpBanned', 'select id from users where ip = @ip and banned = 1')
zero.prepare('zero_hwid/userIsBanned', 'select banned from users where id = @user_id')
zero.prepare('zero_hwid/setUserBanned', 'update users set banned = @banned where id = @user_id')

local userIsBanned = function(user_id)
    local getBanned = zero.query('zero_hwid/userIsBanned', { user_id = user_id })[1]
    if (getBanned) and getBanned.banned == 1 then 
        return true
    end
    return false
end
exports('isBanned', userIsBanned)

local setUserBanned = function(user_id, banned)
    zero.execute('zero_hwid/setUserBanned', { user_id = user_id, banned = banned } )
end
exports('setBanned', setUserBanned)

AddEventHandler('vRP:playerSpawn', function(user_id, source, firstSpawn)
    local userTokens = GetNumPlayerTokens(source)
    local identifiers = zero.getIdentifiers(source)
    if (identifiers.ip) then
        local playerIP = identifiers.ip:gsub('ip:', '')
        local rows = zero.query('zero_hwid/getUserIpBanned', { ip = playerIP })
        if (#rows > 0) then
            local users = ''
            for _, value in ipairs(rows) do
                users = users..value.id..', '
            end
            print('^5[ZERO SYSTEM]^7 IP BANIDO: '..playerIP..' | PLAYER: '..user_id..' | IDS: '..users)
            zero.webhook('IpBanned', '```prolog\n[ZERO SYSTEM - IP BANNED]\n[PASSAPORTE]: '..user_id..'\n[IP BANNED]: '..(playerIP or '0.0.0')..'\n\n[USERS]: '..users..'\n'..((banido and '[BANIDO AUTOMATICAMENTE]\n') or '')..os.date('\n[DATA]: %d/%m/%Y [HORA]: %H:%M:%S')..'\n```')
        end
    end
    for i = 0, userTokens do
        local token = GetPlayerToken(source, i)
        if (token) then
            local getUserTokens = zero.query('zero_hwid/getUserTokens', { token = token })[1]
            if (getUserTokens) then
                if (userIsBanned(getUserTokens.user_id)) then
                    setUserBanned(user_id, true)
                    DropPlayer(source, '[ZERO SYSTEM] Você já foi banido neste servidor.\n[ID ANTIGO]: '..getUserTokens.user_id..'\n[ID ATUAL]: '..user_id..'\nEntre em contato conosco em nosso discord. discord.gg/example')
                    zero.webhook('Hwid', '```prolog\n[ZERO SYSTEM - HWID BANNED]\n[PASSAPORTE]: '..user_id..'\n[ID BANNED]: '..getUserTokens.user_id..os.date('\n[DATA]: %d/%m/%Y [HORA]: %H:%M:%S')..'\n```')
                end
            else
                zero.execute('zero_hwid/setUserTokens', { token = token, user_id = user_id } )
            end
        end
    end
end)