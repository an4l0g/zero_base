zero.checkWhitelist = function()
	local source = source
	local user_id = zero.getUserId(source)
	if (user_id) then return zero.isWhitelisted(user_id); end;
end

zero.isWhitelisted = function(user_id)
	local rows = zero.query('zero_framework/getWhitelist', { user_id = user_id })[1]
	if (rows.whitelist == 1) then
		return true
	end
	return false
end
exports('isWhitelisted', zero.isWhitelisted)

zero.setWhitelisted = function(user_id, whitelisted)
	zero.execute('zero_framework/setWhitelist', { user_id = user_id, whitelisted = whitelisted })
end
exports('setWhitelisted', zero.setWhitelisted)

RegisterNetEvent('zero_whitelist:server', function()
	local source = source
	local user_id = zero.getUserId(source)
    if (not zero.checkWhitelist()) then
        TriggerClientEvent('zero_whitelist:open', zero.getUserSource(user_id), user_id)
    end
end)