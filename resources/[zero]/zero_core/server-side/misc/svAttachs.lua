local srv = {}
Tunnel.bindInterface('Attachs', srv)

srv.checkAttachs = function(perm, attachs2)
    local source = source
    local user_id = zero.getUserId(source)
    if (user_id) then
        if (attachs2) then
            if (zero.checkPermissions(user_id, perm)) then
                return true
            end
        else
            if (zero.getInventoryItemAmount(user_id, 'modificador-armas') >= 1 or zero.checkPermissions(user_id, perm)) then
                return true
            end
        end
        TriggerClientEvent('notify', source, 'Attachs', 'Você não possui <b>Modificador de Armas</b> para fazer esta ação.')
        return false
    end
end

srv.checkColor = function(perm)
    local source = source
    local user_id = zero.getUserId(source)
    if (user_id) then
        if (zero.checkPermissions(user_id, perm)) then
            return true
        end
        TriggerClientEvent('notify', source, 'Weapon Color', 'Você não possui <b>VIP</b> para fazer esta ação.')
        return false
    end
end