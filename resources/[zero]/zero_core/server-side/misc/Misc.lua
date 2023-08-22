RegisterNetEvent('zero_core:shoting', function(coord)
    local source = source
    local user_id = zero.getUserId(source)
    if (user_id) then
        if (GetPlayerRoutingBucket(source) ~= 0) then return; end;
        if (zero.checkPermissions(user_id, { 'policia.permissao', 'attachs2.permissao' })) then return; end;

        local police = zero.getUsersByPermission('policia.permissao')
        for k, v in pairs(police) do
            local nSource = zero.getUserSource(k)
            if (nSource) then
                TriggerClientEvent('zero_core:shotingBlip', nSource, coord, user_id)
            end
        end
    end
end)