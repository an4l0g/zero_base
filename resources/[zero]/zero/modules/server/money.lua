zero.getAllMoney = function(user_id)
	local query = zero.query('zero_framework/getAllMoney', { user_id = user_id })[1]
	if (query) then
		local totalValue = 0
		totalValue = parseInt(query.wallet + query.bank + query.paypal)
		return (totalValue or 0)
	end
	return 0
end
exports('getAllMoney', zero.getAllMoney)

zero.getMoney = function(user_id)
	local query = zero.query('zero_framework/getWalletMoney', { user_id = user_id })[1]
	if (query) then
		return (query.wallet or 0)
	end
	return 0
end
exports('getMoney', zero.getMoney)

zero.getBankMoney = function(user_id)
	local query = zero.query('zero_framework/getBankMoney', { user_id = user_id })[1]
	if (query) then
		return (query.bank or 0)
	end
	return 0
end
vRP.getBankMoney = zero.getBankMoney
exports('getBankMoney', zero.getBankMoney)

zero.getPaypalMoney = function(user_id)
	local query = zero.query('zero_framework/getPaypalMoney', { user_id = user_id })[1]
	if (query) then
		return (query.paypal or 0)
	end
	return 0
end
exports('getPaypalMoney', zero.getPaypalMoney)

zero.setMoney = function(user_id, value)
	zero.execute('zero_framework/setMoney', { user_id = user_id, wallet = value } )
end
exports('setMoney', zero.setMoney)

zero.setBankMoney = function(user_id, value)
	zero.execute('zero_framework/setBankMoney', { user_id = user_id, bank = value } )
end
vRP.setBankMoney = zero.setBankMoney

zero.setPaypalMoney = function(user_id, value)
	zero.execute('zero_framework/setPaypalMoney', { user_id = user_id, paypal = value } )
end

zero.tryPayment = function(user_id, value)
	local money = zero.getMoney(user_id)
	if (money >= value) then
		zero.setMoney(user_id, parseInt(money - value))
		return true
	end
	return false
end
exports('tryPayment', zero.tryPayment)

zero.giveMoney = function(user_id, value)
	if (value > 0) then
		local money = zero.getMoney(user_id)
		zero.setMoney(user_id, parseInt(money + value))
	end
end
exports('giveMoney', zero.giveMoney)

zero.giveBankMoney = function(user_id, value)
	if (value > 0) then
		local money = zero.getBankMoney(user_id)
		zero.setBankMoney(user_id, parseInt(money + value))
	end
end
vRP.giveBankMoney = zero.giveBankMoney
exports('giveBankMoney', zero.giveBankMoney)

zero.givePaypalMoney = function(user_id, value)
	if (value > 0) then
		local money = zero.getPaypalMoney(user_id)
		zero.setPaypalMoney(user_id, parseInt(money + value))
	end
end
exports('givePaypalMoney', zero.givePaypalMoney)

zero.tryBankPayment = function(user_id, value)
	local money = zero.getBankMoney(user_id)
	if (money >= value) then
		zero.setBankMoney(user_id, parseInt(money - value))
		return true
	end
	return false
end
exports('tryBankPayment', zero.tryBankPayment)

zero.tryPaypalPayment = function(user_id, value)
	local money = zero.getPaypalMoney(user_id)
	if (money >= value) then
		zero.setPaypalMoney(user_id, parseInt(money - value))
		return true
	end
	return false
end
exports('tryBankPayment', zero.tryBankPayment)

zero.tryWithdraw = function(user_id, value)
	if (value > 0) then
		local money = zero.getBankMoney(user_id)
		if (money >= value) then
			zero.setBankMoney(user_id, parseInt(money - value))
			zero.giveMoney(user_id, value)
			return true
		end
	end
	return false
end
exports('tryWithdraw', zero.tryWithdraw)

zero.tryDeposit = function(user_id, value)
	if (value > 0) then
		if zero.tryPayment(user_id, value) then
			zero.giveBankMoney(user_id, value)
			return true
		end
	end
	return false
end
exports('tryDeposit', zero.tryDeposit)

zero.tryFullPayment = function(user_id, value)
	if (user_id and value) and value >= 0 then
		if (zero.getMoney(user_id) >= value) then
			return zero.tryPayment(user_id, value)
		elseif (zero.getBankMoney(user_id) >= value) then
			return zero.tryBankPayment(user_id, value)
		else
			if (zero.getPaypalMoney(user_id) >= value) then
				return zero.tryPaypalPayment(user_id, value)
			end
		end
	end
	return false
end
exports('tryFullPayment', zero.tryFullPayment)