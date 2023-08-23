local srv = {}
Tunnel.bindInterface('State', srv)

srv.diminuirPena = function()
    local source = source
    zero.antiflood(source, 'Flodando diminuir pena',1)

    local user_id = zero.getUserId(source)
    if (user_id) then
        local time = (json.decode(zero.getUData(user_id, 'zero:prison')) or 0)
        if (time > 5) then
            zero.setUData(user_id, 'zero:prison', json.encode(parseInt(time) - 1))
            TriggerClientEvent('notify', source, 'Prisão', 'Sua pena foi reduzida em <b>1 mês</b>.')
        else
            TriggerClientEvent('notify', source, 'Prisão', 'Você atingiu o <b>limite</b> de reduzação da pena.')
        end
    end
end