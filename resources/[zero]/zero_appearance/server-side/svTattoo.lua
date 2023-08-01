local srv = {}
Tunnel.bindInterface('tattooShop', srv)

zero._prepare('zero_character/saveTattoo', 'update zero_creation set user_tattoo = @user_tattoo where user_id = @user_id')

srv.getTattoo = function(data)
    local source = source
    local user_id = zero.getUserId(source)
    if (user_id) then
        zero.setUData(user_id, 'zero_appearance:Tattoos', json.encode(data))
    end
end

srv.tryPayment = function(price, data)
    local _source = source
    local _userId = zero.getUserId(_source)
    if (_userId) then
        local _sucess = zero.tryFullPayment(_userId, price)
        if (_sucess) then
            zero.execute('zero_character/saveTattoo', { user_id = _userId, user_tattoo = json.encode(data) } )
            TriggerClientEvent('notify', _source, 'Tatuagem', 'Pagamento <b>efetuado</b> com sucesso!')
        else
            TriggerClientEvent('notify', _source, 'Tatuagem', 'Pagamento <b>negado</b>!<br>Saldo <b>insuficiente</b>.')
        end
        return _sucess
    end
end