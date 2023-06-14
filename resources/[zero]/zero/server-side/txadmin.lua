------------------------------------------------------------------
-- TXADMIN SAVE
------------------------------------------------------------------
AddEventHandler('txAdmin:events:scheduledRestart', function(eventData)
    if (eventData.secondsRemaining == 60) then
		SetTimeout(45000,function()
			for k, v in pairs(cacheUsers['user_tables']) do
				zero.setUData(k, 'vRP:datatable', json.encode(v))
			end
		end)
    end
end)

AddEventHandler('txAdmin:events:serverShuttingDown', function(eventData)
	for k, v in pairs(cacheUsers['user_tables']) do
		zero.setUData(k, 'vRP:datatable', json.encode(v))
	end
end)
------------------------------------------------------------------