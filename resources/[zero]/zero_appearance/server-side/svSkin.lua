local srv = {}
Tunnel.bindInterface('skinShop', srv)

zero._prepare('zero_appearance/saveClothes', 'update creation set user_clothes = @user_clothes where user_id = @user_id')
zero._prepare('zero_appearance/getClothes', 'select user_clothes from creation where user_id = @user_id')

srv.tryPayment = function(price, customization)
    local _source = source
    local _userId = zero.getUserId(_source)
    if (_userId) then
        local _sucess = zero.tryFullPayment(_userId, price)
        if (_sucess) then
            zero.execute('zero_appearance/saveClothes', { user_id = _userId, user_clothes = json.encode(customization) } )
            TriggerClientEvent('notify', _source, 'Loja de Roupas', 'Pagamento <b>efetuado</b> com sucesso!')
        else
            TriggerClientEvent('notify', _source, 'Loja de Roupas', 'Pagamento <b>negado</b>!<br>Saldo <b>insuficiente</b>.')
        end
        return _sucess
    end
end

setCustomization = function(source, user_id)
    local query = zero.query('zero_appearance/getClothes', { user_id = user_id })[1]
    if (query) then
        local clothes = json.decode(query.user_clothes)
        if (clothes) then
            zeroClient.setCustomization(source, clothes)
        end
    end
end
exports('setCustomization', setCustomization)