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
                    TriggerClientEvent('announcement', nSource, 'Disparos de arma de fogo', 'Atenção <b>unidades</b> foram avistados disparos de arma de fogo próximo as suas regiões, tomem cuidado!', 'Delegacia Zero', true, 10000)
                    TriggerClientEvent('zero_core:shotingBlip', nSource, coord, user_id)
                end)
            end
        end
    end
end)