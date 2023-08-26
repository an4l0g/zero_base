zero.checkWhitelist = function(target)
	local source = source
	if (target) then source = target; end;
	local user_id = zero.getUserId(source)
	if (user_id) then return zero.isWhitelisted(user_id); end;
end

zero.isWhitelisted = function(user_id)
	if (user_id) then
		local rows = zero.query('zero_framework/getWhitelist', { user_id = user_id })[1]
		if (rows) and rows.whitelist == 1 then
			return true
		end
	end
	return false
end
exports('isWhitelisted', zero.isWhitelisted)

zero.setWhitelisted = function(user_id, whitelisted)
	zero.execute('zero_framework/setWhitelist', { user_id = user_id, whitelist = whitelisted })
end
exports('setWhitelisted', zero.setWhitelisted)

RegisterNetEvent('zero_whitelist:server', function(target)
	local source = source
	if (target) then source = target; end;
	local user_id = zero.getUserId(source)
    if (not zero.checkWhitelist(source)) then
        TriggerClientEvent('zero_whitelist:open', source, user_id)
    end
end)