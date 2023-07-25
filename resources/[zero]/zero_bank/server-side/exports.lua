multarPlayer = function(user_id, motivo, valor, descricao)
    if (user_id and motivo and valor and descricao) then
        zero.execute('zero_bank/addMultas', { user_id = user_id, reason = motivo, value = parseInt(valor), time = os.time(), description = descricao })
    end
end
exports('multar', multarPlayer)

verifyMultas = function(user_id)
    if (user_id) then
        local query = zero.query('zero_bank/getMultas', { user_id = user_id })
        if (query) then
            local totalValue = 0
            for k, v in ipairs(query) do
                totalValue = (totalValue + v.fine_value)
            end
            return totalValue
        end
    end
end
exports('verifyMultas', verifyMultas)

registerTrans = function(user_id, type, value)
    print(user_id, type, value)
    local data = (json.decode(zero.getUData(user_id, 'zero_bank:historico')) or {})
    if (data) then
        if (value < 0) then
            value = (value * -1)
            value = '-R$'..value
        else
            value = '+R$'..value
        end
        table.insert(data, { type = type, value = zero.format(value) })
        zero.setUData(user_id, 'zero_bank:historico', json.encode(data))
    end
end
exports('extrato', registerTrans)

registerRendimento = function(user_id, value)
    if (user_id) then
        local uData = zero.getUData(user_id, 'zero_bank:rendimento')
        local data = (json.decode(uData) or {})
        if (data) then
            if (#data >= 20) then data = {}; end;
            table.insert(data, value)
            zero.setUData(user_id, 'zero_bank:rendimento', json.encode(data))
        end
    end
end
exports('registerRendimento', registerRendimento)