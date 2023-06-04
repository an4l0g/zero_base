------------------------------------------------------------------
-- GET MONEY
------------------------------------------------------------------
vRP.getMoney = function(user_id)
	local tmp = vRP.getUserTmpTable(user_id)
	if (tmp) then
		return (tmp.wallet or 0)
	end
	return 0
end
------------------------------------------------------------------

------------------------------------------------------------------
-- SET MONEY
------------------------------------------------------------------
vRP.setMoney = function(user_id, value)
	local tmp = vRP.getUserTmpTable(user_id)
	if (tmp) then tmp.wallet = value end
end
------------------------------------------------------------------

------------------------------------------------------------------
-- TRY PAYMENT
------------------------------------------------------------------
vRP.tryPayment = function(user_id, amount)
	if (amount >= 0) then
		local money = vRP.getMoney(user_id)
		if (money >= amount) then
			vRP.setMoney(user_id, (money - amount))
			return true			
		end
	end
	return false
end
------------------------------------------------------------------

------------------------------------------------------------------
-- GIVE MONEY
------------------------------------------------------------------
vRP.giveMoney = function(user_id, amount)
	user_id = parseInt(user_id)
	if (amount >= 0) then
		vRP.setMoney(user_id, (vRP.getMoney(user_id) + amount))
	end
end
------------------------------------------------------------------

------------------------------------------------------------------
-- GIVE BANK MONEY
------------------------------------------------------------------
vRP.getBankMoney = function(user_id)
	local tmp = vRP.getUserTmpTable(user_id)
	if (tmp) then
		return (tmp.bank or 0)
	end
	return 0
end
------------------------------------------------------------------

------------------------------------------------------------------
-- SET BANK MONEY
------------------------------------------------------------------
vRP.setBankMoney = function(user_id, value)
	user_id = parseInt(user_id)
	local tmp = vRP.getUserTmpTable(user_id)
	if (tmp) then tmp.bank = value end
end
------------------------------------------------------------------

------------------------------------------------------------------
-- TRY BANK PAYMENT
------------------------------------------------------------------
vRP.tryBankPayment = function(user_id, amount)
	if (amount >= 0) then
		local money = vRP.getBankMoney(user_id)
		if (money >= amount) then
			vRP.setBankMoney(user_id, (money - amount))
			return true
		end
	end
	return false
end
------------------------------------------------------------------

------------------------------------------------------------------
-- GIVE BANK MONEY
------------------------------------------------------------------
vRP.giveBankMoney = function(user_id, amount)
	user_id = parseInt(user_id)
	if (amount >= 0) then
		vRP.setBankMoney(user_id, (vRP.getBankMoney(user_id) + amount))
	end
end
------------------------------------------------------------------

------------------------------------------------------------------
-- TRY WITHDRAW
------------------------------------------------------------------
vRP.tryWithdraw = function(user_id, amount)
	if (amount >= 0) then
		local money = vRP.getBankMoney(user_id)
		if (money >= amount) then
			vRP.setBankMoney(user_id, (money - amount))
			vRP.giveMoney(user_id, amount)
			return true
		end
	end
	return false
end
------------------------------------------------------------------

------------------------------------------------------------------
-- TRY DEPOSIT
------------------------------------------------------------------
vRP.tryDeposit = function(user_id, amount)
	if amount >= 0 then
		if vRP.tryPayment(user_id, amount) then
			vRP.giveBankMoney(user_id, amount)
			return true
		end
	end
	return false
end
------------------------------------------------------------------

------------------------------------------------------------------
-- TRY FULL PAYMENT
------------------------------------------------------------------
vRP.tryFullPayment = function(user_id, amount)
	if (amount >= 0) then
		local money = vRP.getMoney(user_id)
		if (money >= amount) then
			return vRP.tryPayment(user_id, amount)
		else
			if (vRP.tryWithdraw(user_id, (amount - money))) then
				return vRP.tryPayment(user_id, amount)
			end
		end
	end
	return false
end
------------------------------------------------------------------

AddEventHandler('vRP:playerJoin', function(user_id, source, name)
	vRP.execute('vRP/money_init_user', { user_id = user_id, wallet = config['initMoney']['wallet'], bank = config['initMoney']['bank'] })
	
	local tmp = vRP.getUserTmpTable(user_id)
	if tmp then
		local rows = vRP.query("vRP/get_money",{ user_id = user_id })
		if (#rows > 0) then
			tmp.bank = rows[1].bank
			tmp.wallet = rows[1].wallet
		end
	end
end)

AddEventHandler('vRP:playerLeave', function(user_id, source)
	local tmp = vRP.getUserTmpTable(user_id)
	if (tmp and tmp.wallet and tmp.bank) then
		vRP.execute('vRP/set_money', { user_id = user_id, wallet = tmp.wallet, bank = tmp.bank })
	end
end)

AddEventHandler('vRP:save', function()
	for index, value in pairs(cacheUsers['user_tmp_tables']) do
		if (value.wallet and value.bank) then
			vRP.execute("vRP/set_money",{ user_id = index, wallet = value.wallet, bank = value.bank })
		end
	end
end)