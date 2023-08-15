-- -- Get all fines for an user_id
exports('getFines', function(user_id)
    print(user_id)
  return 300000
end)

exports('payFine', function(user_id, id)
    print(user_id, id)
  local fines = exports.smartphone:getFines(user_id)

  local balance = getBank(user_id)

  for key, v in pairs(fines) do
    if v.id == key then
      if balance < v.total then
        return { error = 'Saldo insuficiente' }
      else
        -- remover o dinheiro do jogador
        fines[key] = nil
        exports.oxmysql:executeSync('UPDATE bank SET invoices=? WHERE user_id=? LIMIT 1', { json.encode(fines), user_id })
        return
      end
    end
  end
  return { error = 'Multa n�o encontrada' }
end)

-- -- Return SUM(fines) by user_id
exports('getTotalFines', function(user_id)
    print(user_id)

  return 300000
end)
