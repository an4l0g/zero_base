local shootingWebhook = 'https://discord.com/api/webhooks/1147712991643582474/ESs65wF2eSWa-N855upmTxOj-UBoo8sFV7x3155-jHmGTodkpy36lDzmTH-msNA6LFw8'

RegisterNetEvent('zero_core:shoting', function(coord)
    local source = source
    local user_id = zero.getUserId(source)
    if (user_id) then
        zero.webhook(shootingWebhook, '```prolog\n[DISPAROS]\n[USER]: '..user_id..'\n[COORD]: '..tostring(coord)..os.date('\n[DATE]: %d/%m/%Y [HOUR]: %H:%M:%S')..' \r```')
        if (GetPlayerRoutingBucket(source) ~= 0) then return; end;
        if (zero.checkPermissions(user_id, { 'policia.permissao', 'staff.permissao', 'attachs2.permissao' })) then return; end;

        local police = zero.getUsersByPermission('policia.permissao')
        for k, v in pairs(police) do
            local nSource = zero.getUserSource(parseInt(v))
            if (nSource) then
                async(function()
                    TriggerClientEvent('notifypush', nSource, {
                        code = 'QRU',
                        title = 'Disparos de arma de fogo',
                        description = 'Denúncia Anônima',
                        coords = coord
                    })
                    TriggerClientEvent('zero_core:shotingBlip', nSource, coord, user_id)
                end)
            end
        end
    end
end)

local blacklistAnti = 'https://discord.com/api/webhooks/1154152630470332527/UGKg-PC_hjgr5lkMJOpjP40rjX_r8z4PkbsmjnpGqDSUSpIcsbKyh58qkkQWJeNtq_bh'

local AntiCheat = {
    ['vehicles'] = function(source, user_id, identity, model)
        zero.kick(source,'Você foi banido da cidade pelo AntiCheat.\nMotivo: spawn de veículos.\nSeu passaporte: #'..user_id..'.')    
        zero.setBanned(user_id, true)
        exports.zero_core:insertBanRecord(user_id, true, -1, '[BLACKLIST] spawn de veículo!')
        zero.webhook(blacklistAnti, '```prolog\n[ZERO CITY - BLACKLIST]\n[ACTION]: (SPAWN VEHICLE)\n[VEHICLE]: '..model..'\n[HACK]: '..user_id..' | '..identity.firstname..' '..identity.lastname..'\n[COORD]: '..tostring(GetEntityCoords(GetPlayerPed(source)))..os.date('\n[DATE]: %d/%m/%Y [HOUR]: %H:%M:%S')..' \r```')
    end
}

RegisterNetEvent('zero_anticheat', function(detected, model)
    local source = source
    local user_id = zero.getUserId(source)
    local identity = zero.getUserIdentity(user_id)

    if (AntiCheat[detected]) then
        AntiCheat[detected](source, user_id, identity, model)
    end
end)