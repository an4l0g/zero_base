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
            exports.zero_bank:extrato(_userId, 'loja de Roupas', -price)
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
    if (query) and query.user_clothes then
        zeroClient.setCustomization(source, json.decode(query.user_clothes))
        return true
    end
    print('^5[Zero Appearance]^5 não foi encontrado o user_clothes do USER_ID ^5('..user_id..')^7')
    return false
end
exports('setCustomization', setCustomization)