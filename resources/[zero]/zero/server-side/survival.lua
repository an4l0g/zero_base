------------------------------------------------------------------
-- GET HUNGER
------------------------------------------------------------------
zero.getHunger = function(user_id)
	local data = zero.getUserDataTable(user_id)
	if (data) then
		return data.hunger
	end
	return 0
end
------------------------------------------------------------------

------------------------------------------------------------------
-- GET THIRST
------------------------------------------------------------------
zero.getThirst = function(user_id)
	local data = zero.getUserDataTable(user_id)
	if (data) then
		return data.thirst
	end
	return 0
end
------------------------------------------------------------------

------------------------------------------------------------------
-- VARY HUNGER
------------------------------------------------------------------
zero.varyHunger = function(user_id, variation)
	local data = zero.getUserDataTable(user_id)
	if (data) then
		if (not data.hunger) then data.hunger = 0 end
		data.hunger = data.hunger + variation
		local overflow = (data.hunger - 100)
		if (overflow > 0) then
			zeroClient._varyHealth(zero.getUserSource(user_id), (-overflow * survivalConfig.overflow_damage_factor))
		end

		if (data.hunger < 0) then 
			data.hunger = 0
		elseif (data.hunger > 100) then 
			data.hunger = 100 
		end
		TriggerClientEvent('vrp_hud:updateBasics', zero.getUserSource(user_id), data.hunger, data.thirst, data.stress, data.toxic)
	end
end
------------------------------------------------------------------

------------------------------------------------------------------
-- VARY THIRST
------------------------------------------------------------------
zero.varyThirst = function(user_id, variation)
	local data = zero.getUserDataTable(user_id)
	if (data) then
		if (not data.thirst) then data.thirst = 0 end
		data.thirst = data.thirst + variation
		local overflow = data.thirst-100
		if (overflow > 0) then
			zeroClient._varyHealth(zero.getUserSource(user_id), (-overflow * survivalConfig.overflow_damage_factor))
		end

		if (data.thirst < 0) then 
			data.thirst = 0
		elseif (data.thirst > 100) then 
			data.thirst = 100 
		end
		TriggerClientEvent('vrp_hud:updateBasics', zero.getUserSource(user_id), data.hunger, data.thirst, data.stress, data.toxic)
	end
end
------------------------------------------------------------------

stask_update = function()
	for index, value in pairs(cacheUsers.users) do
		zero.varyHunger(value, survivalConfig.hunger_per_minute)
		zero.varyThirst(value, survivalConfig.thirst_per_minute)
	end
  	SetTimeout(60000, stask_update)
end

async(stask_update)

AddEventHandler('zero:playerJoin', function(source, user_id)
	local data = zero.getUserDataTable(user_id)
	if (not data.hunger) then data.hunger = 0; end;
	if (not data.thirst) then data.thirst = 0; end;
end)