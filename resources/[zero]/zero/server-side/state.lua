local config = module('zero', 'cfg/player_state')

AddEventHandler('vRP:playerSpawn', function(user_id, source, _firstSpawn)
	local data = zero.getUserDataTable(user_id)
	if (_firstSpawn) then
		if (data.customization == nil) then data.customization = config.default_customization end
		zeroClient.setCustomization(source, data.customization) 

		if (data.position) then zeroClient.teleport(source, data.position.x, data.position.y, data.position.z) end

		if (data.health) then
			zeroClient.setHealth(source, data.health)
			Citizen.SetTimeout(10000, function()
				if (zeroClient.isInComa(source)) then
					zeroClient.killComa(source)
				end
			end)
		end

		if (data.weapons) then zeroClient.giveWeapons(source, data.weapons, true, GlobalState.weaponToken) end		

		if (data.armour) then
			Citizen.SetTimeout(10000, function()
				zeroClient.setArmour(source, data.armour)
			end)
		end
	else
		if (zeroClient.isHandcuffed(source)) then
			zeroClient._setHandcuffed(source, true)
		else
			zeroClient._setHandcuffed(source, false)
		end
	
		-- VERIFICAR ESSE CODIGO DA MOCHILA
		-- if (not zero.hasPermission(user_id, 'mochila.permissao')) then zero.setInventoryMaxWeight(user_id,6) end

		if (data.customization) then zeroClient.setCustomization(source, data.customization) end
	end

	zeroClient._setFriendlyFire(source, true)
	zeroClient._playerStateReady(source, true)
end)

------------------------------------------------------------------
-- UPDATE POS
------------------------------------------------------------------
zero.updatePos = function(x, y, z)
	local user_id = zero.getUserId(source)
	if user_id then
		local data = zero.getUserDataTable(user_id)
		local tmp = zero.getUserTmpTable(user_id)
		if data and (not tmp or not tmp.home_stype) then
			data.position = { x = tonumber(x), y = tonumber(y), z = tonumber(z) }
		end
	end
end
------------------------------------------------------------------

------------------------------------------------------------------
-- UPDATE POS
------------------------------------------------------------------
zero.updateArmor = function(armor)
	local user_id = zero.getUserId(source)
	if user_id then
		local data = zero.getUserDataTable(user_id)
		if (data) then data.armour = armor end
	end
end
------------------------------------------------------------------

------------------------------------------------------------------
-- UPDATE WEAPONS
------------------------------------------------------------------
zero.updateWeapons = function(weapons)
	local user_id = zero.getUserId(source)
	if user_id then
		local data = zero.getUserDataTable(user_id)
		if (data) then data.weapons = weapons end
	end
end
------------------------------------------------------------------

------------------------------------------------------------------
-- UPDATE CUSTOMIZATION
------------------------------------------------------------------
zero.updateCustomization = function(customization)
	local user_id = zero.getUserId(source)
	if user_id then
		local data = zero.getUserDataTable(user_id)
		if (data) then data.customization = customization end
	end
end
------------------------------------------------------------------

------------------------------------------------------------------
-- UPDATE CUSTOMIZATION
------------------------------------------------------------------
zero.updateHealth = function(health)
	local user_id = zero.getUserId(source)
	if user_id then
		local data = zero.getUserDataTable(user_id)
		if (data) then data.health = health end
	end
end
------------------------------------------------------------------

------------------------------------------------------------------
-- CLEAR AFTER DIE
------------------------------------------------------------------
-- tzero.clearAfterDie = function()
--     local source = source
--     local user_id = zero.getUserId(source)
--     if user_id then
		
-- 		zero.setMoney(user_id,0)
-- 		zeroClient._clearWeapons(source)
-- 		zeroClient._setHandcuffed(source,false)

-- 		zero.varyThirst(user_id,-100)
-- 		zero.varyHunger(user_id,-100)

-- 		local alicaPrata = (zero.getInventoryItemAmount(user_id,'aliancaprata') > 0)
-- 		local alicaOuro = (zero.getInventoryItemAmount(user_id,'aliancaouro') > 0)

-- 		zero.clearInventory(user_id)

-- 		if alicaPrata then
-- 			zero.giveInventoryItem(user_id,'aliancaprata',1)
-- 		end
-- 		if aliancaOuro then
-- 			zero.giveInventoryItem(user_id,'aliancaouro',1)
-- 		end

-- 		if zero.hasPermission(user_id, 'vip.permissao') then
-- 			zero.giveInventoryItem(user_id,'radio',1)
-- 			zero.giveInventoryItem(user_id,'celular',1)
-- 		end

-- 		if (not zero.hasPermission(user_id,"mochila.permissao")) then
-- 			zero.setInventoryMaxWeight(user_id,6)
-- 		end

-- 		return true
--     end
-- 	return false
-- end
------------------------------------------------------------------

------------------------------------------------------------------
-- TIMER
------------------------------------------------------------------
local timersCooldown = {}

zero.getUserTimer = function(user_id, timerType)
	if (user_id and timerType) then
		if timersCooldown[user_id] then
			return timersCooldown[user_id][timerType]
		end
	end
	return false
end

zero.setUserTimer = function(user_id, timerType, seconds)
	if (user_id and timerType and seconds) then
		if not (timersCooldown[user_id]) then
			timersCooldown[user_id] = {}	
		end
		
		if not (timersCooldown[user_id][timerType]) then
			threadTimer(user_id, timerType, seconds)
		else
			local oldSecs = timersCooldown[user_id][timerType]
			if (oldSecs) then
				timersCooldown[user_id][timerType] = oldSecs + parseInt(seconds)
			end
		end
	end
end

threadTimer = function(user_id, timerType, time)
	Citizen.CreateThread(function()
		timersCooldown[user_id][timerType] = time
		while (timersCooldown[user_id][timerType] > 0) do
			Citizen.Wait(1000)
			timersCooldown[user_id][timerType] = timersCooldown[user_id][timerType] - 1
		end
		timersCooldown[user_id][timerType] = nil
	end)
end

RegisterCommand('procurado', function(source)
	local user_id = zero.getUserId(source)
	if user_id then
		if (zero.getUserTimer(user_id, 'wanted')) then
			TriggerClientEvent('Notify', source, 'sucesso', 'Você está sendo <b>procurado</b>! Tempo: <b>'..zero.getUserTimer(user_id, 'wanted')..' segundos</b>.')
		else
			TriggerClientEvent('Notify', source, 'negado', 'Você não está sendo <b>procurado</b>!')
		end
	end
end)
------------------------------------------------------------------

------------------------------------------------------------------
-- WEAPON PROTECT
------------------------------------------------------------------
GlobalState.weaponToken = 404
Citizen.SetTimeout(2000,function()
	math.randomseed(GetGameTimer())
	GlobalState.weaponToken = math.random(50000,70000)
end)

zero.checkToken = function(tokenSend, weapons)
	local source = source
	if (GlobalState.weaponToken ~= tokenSend) then
		local user_id = zero.getUserId(source)
		local identifiers = zero.getIdentifiers(source)

		DropPlayer(source, '[ZERO] - ANTI CHEAT')
		-- zero.setBanned(user_id, true)
		exports['zero_core']:setBanned(user_id, true)
		zero.webhook(config['webhooks'], '```prolog\n[PLAYER]: '..tostring(user_id)..'\n[TOKEN-ENVIADO]: '..tostring(tokenSend)..'\n[TOKEN-SISTEMA]: '..tostring(GlobalState.weaponToken)..'\n[ARMAS]:\n'..json.encode(weapons,{ indent = true })..'\n[IDENTIFIERS]:\n'..json.encode(ids,{ indent = true })..'```')	
	end
end

RegisterCommand('reloadtoken',function(source,args)
	if (source == 0) then
		GlobalState.weaponToken = math.random(50000,70000)
		print("^2[vRP] ^8[WARNING!] ^2Weapons Token Regenerated! <"..GlobalState.weaponToken..">^7")
	end
end)
------------------------------------------------------------------

RegisterNetEvent('trymala', function(nveh)
	TriggerClientEvent('syncmala', -1, nveh)
end)