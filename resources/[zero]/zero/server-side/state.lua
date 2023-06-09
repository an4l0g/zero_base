AddEventHandler('vRP:playerSpawn', function(user_id, source, _firstSpawn)
	local data = vRP.getUserDataTable(user_id)
	if (_firstSpawn) then
		if (data.customization == nil) then data.customization = stateConfig.default_customization end
		vRPclient.setCustomization(source, data.customization) 

		if (data.position) then vRPclient.teleport(source, data.position.x, data.position.y, data.position.z) end

		if (data.health) then
			vRPclient.setHealth(source, data.health)
			Citizen.SetTimeout(10000, function()
				if (vRPclient.isInComa(source)) then
					vRPclient.killComa(source)
				end
			end)
		end

		if (data.weapons) then vRPclient.giveWeapons(source, data.weapons, true, GlobalState.weaponToken) end		

		if (data.armour) then
			Citizen.SetTimeout(10000, function()
				vRPclient.setArmour(source, data.armour)
			end)
		end
	else
		if (vRPclient.isHandcuffed(source)) then
			vRPclient._setHandcuffed(source, true)
		else
			vRPclient._setHandcuffed(source, false)
		end
	
		-- VERIFICAR ESSE CODIGO DA MOCHILA
		-- if (not vRP.hasPermission(user_id, 'mochila.permissao')) then vRP.setInventoryMaxWeight(user_id,6) end

		if (data.customization) then vRPclient.setCustomization(source, data.customization) end
	end

	vRPclient._setFriendlyFire(source, true)
	vRPclient._playerStateReady(source, true)
end)

------------------------------------------------------------------
-- UPDATE POS
------------------------------------------------------------------
vRP.updatePos = function(x, y, z)
	local user_id = vRP.getUserId(source)
	if user_id then
		local data = vRP.getUserDataTable(user_id)
		local tmp = vRP.getUserTmpTable(user_id)
		if data and (not tmp or not tmp.home_stype) then
			data.position = { x = tonumber(x), y = tonumber(y), z = tonumber(z) }
		end
	end
end
------------------------------------------------------------------

------------------------------------------------------------------
-- UPDATE POS
------------------------------------------------------------------
vRP.updateArmor = function(armor)
	local user_id = vRP.getUserId(source)
	if user_id then
		local data = vRP.getUserDataTable(user_id)
		if (data) then data.armour = armor end
	end
end
------------------------------------------------------------------

------------------------------------------------------------------
-- UPDATE WEAPONS
------------------------------------------------------------------
vRP.updateWeapons = function(weapons)
	local user_id = vRP.getUserId(source)
	if user_id then
		local data = vRP.getUserDataTable(user_id)
		if (data) then data.weapons = weapons end
	end
end
------------------------------------------------------------------

------------------------------------------------------------------
-- UPDATE CUSTOMIZATION
------------------------------------------------------------------
vRP.updateCustomization = function(customization)
	local user_id = vRP.getUserId(source)
	if user_id then
		local data = vRP.getUserDataTable(user_id)
		if (data) then data.customization = customization end
	end
end
------------------------------------------------------------------

------------------------------------------------------------------
-- UPDATE CUSTOMIZATION
------------------------------------------------------------------
vRP.updateHealth = function(health)
	local user_id = vRP.getUserId(source)
	if user_id then
		local data = vRP.getUserDataTable(user_id)
		if (data) then data.health = health end
	end
end
------------------------------------------------------------------

------------------------------------------------------------------
-- CLEAR AFTER DIE
------------------------------------------------------------------
-- tvRP.clearAfterDie = function()
--     local source = source
--     local user_id = vRP.getUserId(source)
--     if user_id then
		
-- 		vRP.setMoney(user_id,0)
-- 		vRPclient._clearWeapons(source)
-- 		vRPclient._setHandcuffed(source,false)

-- 		vRP.varyThirst(user_id,-100)
-- 		vRP.varyHunger(user_id,-100)

-- 		local alicaPrata = (vRP.getInventoryItemAmount(user_id,'aliancaprata') > 0)
-- 		local alicaOuro = (vRP.getInventoryItemAmount(user_id,'aliancaouro') > 0)

-- 		vRP.clearInventory(user_id)

-- 		if alicaPrata then
-- 			vRP.giveInventoryItem(user_id,'aliancaprata',1)
-- 		end
-- 		if aliancaOuro then
-- 			vRP.giveInventoryItem(user_id,'aliancaouro',1)
-- 		end

-- 		if vRP.hasPermission(user_id, 'vip.permissao') then
-- 			vRP.giveInventoryItem(user_id,'radio',1)
-- 			vRP.giveInventoryItem(user_id,'celular',1)
-- 		end

-- 		if (not vRP.hasPermission(user_id,"mochila.permissao")) then
-- 			vRP.setInventoryMaxWeight(user_id,6)
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

vRP.getUserTimer = function(user_id, timerType)
	if (user_id and timerType) then
		if timersCooldown[user_id] then
			return timersCooldown[user_id][timerType]
		end
	end
	return false
end

vRP.setUserTimer = function(user_id, timerType, seconds)
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
	local user_id = vRP.getUserId(source)
	if user_id then
		if (vRP.getUserTimer(user_id, 'wanted')) then
			TriggerClientEvent('Notify', source, 'sucesso', 'Você está sendo <b>procurado</b>! Tempo: <b>'..vRP.getUserTimer(user_id, 'wanted')..' segundos</b>.')
		else
			TriggerClientEvent('Notify', source, 'negado', 'Você não está sendo <b>procurado</b>!')
		end
	end
end)
------------------------------------------------------------------

------------------------------------------------------------------
-- WEAPON PROTECT
------------------------------------------------------------------
GlobalState.weaponToken = math.random(50000,70000)

vRP.checkToken = function(tokenSend, weapons)
	local source = source
	if (GlobalState.weaponToken ~= tokenSend) then
		local user_id = vRP.getUserId(source)
		local identifiers = vRP.getIdentifiers(source)

		DropPlayer(source, '[ZERO] - ANTI CHEAT')
		-- vRP.setBanned(user_id, true)
		exports['zero_core']:setBanned(user_id, true)
		vRP.webhook(config['webhooks'], '```prolog\n[PLAYER]: '..tostring(user_id)..'\n[TOKEN-ENVIADO]: '..tostring(tokenSend)..'\n[TOKEN-SISTEMA]: '..tostring(GlobalState.weaponToken)..'\n[ARMAS]:\n'..json.encode(weapons,{ indent = true })..'\n[IDENTIFIERS]:\n'..json.encode(ids,{ indent = true })..'```')	
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