Proxy = module('zero', 'lib/Proxy')
zero = Proxy.getInterface('zero')

exports('getFines', function(user_id)
  local multas = {}
  local query = zero.query('zero_bank/getMultas', { user_id = user_id })
  if (query) then
    for _, v in ipairs(query) do 
      table.insert(multas, {
        id = v.id,
        total = v.fine_value,
        description = v.fine_description
      })
    end;
    return multas
  end
end)

exports('payFine', function(user_id, id)
  local query = zero.query('zero_bank/getMulta', { multa_id = id })[1]
  if (query) then
    if (zero.tryBankPayment(user_id, query.fine_value)) then
      zero.execute('zero_bank/delMulta', { user_id = user_id, multa_id = id })
      zero.webhook('PayFine', '```prolog\n[ZERO BANK]\n[ACTION]: (PAY FINE)\n[USER]: '..user_id..'\n[FINE VALUE]: '..zero.format(query.fine_value)..'\n[FINE ID]: '..query.id..os.date('\n[DATA]: %d/%m/%Y [HORA]: %H:%M:%S')..'\n```')
      exports.zero_bank:extrato(user_id, 'Multas', -query.fine_value)
      return
    else
      return { error = 'Saldo insuficiente' }
    end
  end
  return { error = 'Multa não encontrada' }
end)

exports('getTotalFines', function(user_id)
  local totalMultas = 0
  local query = zero.query('zero_bank/getMultas', { user_id = user_id })
  if (query) then
    for _, v in ipairs(query) do totalMultas = (totalMultas + v.fine_value); end;
    return totalMultas
  end
end)
