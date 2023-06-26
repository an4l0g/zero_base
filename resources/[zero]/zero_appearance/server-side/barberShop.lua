local srv = {}
Tunnel.bindInterface('barberShop', srv)

zero._prepare('zero_character/getCharacter', 'select user_character from zero_creation where user_id = @user_id')

srv.getCharacter = function()
    local _source = source
    local _userId = vRP.getUserId(_source)
    if (_userId) then
        local value = vRP.query('zero_character/getCharacter', { user_id = _userId })[1]
        if (value['user_character']) then
            local custom = (json.decode(value['user_character']) or {})
            return custom
        end
    end
end

srv.tryPayment = function(price, data)
    local _source = source
    local _userId = vRP.getUserId(_source)
    if (_userId) then
        local _sucess = vRP.tryFullPayment(_userId, price)
        if (_sucess) then
            vRP.execute('zero_character/saveUser', { user_id = _userId, user_character = data } )
            TriggerClientEvent('notify', _source, 'Barbearia', 'Pagamento <b>efetuado</b> com sucesso!')
        else
            TriggerClientEvent('notify', _source, 'Barbearia', 'Pagamento <b>negado</b>!<br>Saldo <b>insuficiente</b>.')
        end
        return _sucess
    end
end

RegisterNetEvent('zero_appearance_barbershop:init', function(user_id)
    local _source = vRP.getUserSource(user_id)
    if (_source) then
        local value = vRP.query('zero_character/getCharacter', { user_id = _userId })[1]
        if (value['user_character']) then
            local custom = json.decode(value['user_character']) or {}
            TriggerClientEvent('barbershop:init', _source, custom)
        end
    end
end)