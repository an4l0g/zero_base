local srv = {}
Tunnel.bindInterface('barberShop', srv)

zero._prepare('zero_character/getCharacter', 'select user_character from creation where user_id = @user_id')

srv.getCharacter = function()
    local _source = source
    local _userId = zero.getUserId(_source)
    if (_userId) then
        local value = zero.query('zero_character/getCharacter', { user_id = _userId })[1]
        if (value['user_character']) then
            local custom = (json.decode(value['user_character']) or {})
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
            exports.zero_bank:extrato(_userId, 'Barbearia', -price)
            zero.execute('zero_character/saveUser', { user_id = _userId, user_character = json.encode(data) } )
            TriggerClientEvent('notify', _source, 'Barbearia', 'Pagamento <b>efetuado</b> com sucesso!')
        else
            TriggerClientEvent('notify', _source, 'Barbearia', 'Pagamento <b>negado</b>!<br>Saldo <b>insuficiente</b>.')
        end
        return _sucess
    end
end

RegisterNetEvent('zero_appearance_barbershop:init', function(user_id)
    local _source = zero.getUserSource(user_id)
    if (_source) then
        local value = zero.query('zero_character/getCharacter', { user_id = user_id })[1]
        if (value['user_character']) then
            local custom = json.decode(value['user_character']) or {}
            TriggerClientEvent('barbershop:init', _source, custom)
        end
    end
end)