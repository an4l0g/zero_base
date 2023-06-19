local srv = {}
Tunnel.bindInterface('skinShop', srv)

srv.tryPayment = function(price, customization)
    local _source = source
    local _userId = vRP.getUserId(_source)
    if (_userId) then
        local _sucess = vRP.tryFullPayment(_userId, price)
        if (_sucess) then
            TriggerClientEvent('notify', _source, 'Loja de Roupas', 'Pagamento <b>efetuado</b> com sucesso!')
        else
            TriggerClientEvent('notify', _source, 'Loja de Roupas', 'Pagamento <b>negado</b>!<br>Saldo <b>insuficiente</b>.')
        end
        return _sucess
    end
end