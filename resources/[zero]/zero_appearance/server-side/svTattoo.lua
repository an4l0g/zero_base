local srv = {}
Tunnel.bindInterface('tattooShop', srv)

zero._prepare('zero_character/getTattoos', 'select user_tattoo from creation where user_id = @user_id')
zero._prepare('zero_character/saveTattoo', 'update creation set user_tattoo = @user_tattoo where user_id = @user_id')

srv.getTattoo = function()
    local _source = source
    local _userId = zero.getUserId(_source)
    if (_userId) then
        local value = zero.query('zero_character/getTattoos', { user_id = _userId })[1]
        if (value['user_tattoo']) then
            local custom = (json.decode(value['user_tattoo']) or {})
            return custom
        end
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