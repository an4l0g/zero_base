-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP
-----------------------------------------------------------------------------------------------------------------------------------------
local Tunnel = module("zero","lib/Tunnel")
local Proxy = module("zero","lib/Proxy")
local Tools = module("zero","lib/Tools")
vRP = Proxy.getInterface("zero")
vRPclient = Tunnel.getInterface("zero")

nyoBSClient = Tunnel.getInterface("nyo_barbershop")
nyoBSServer = {}
Tunnel.bindInterface("nyo_barbershop",nyoBSServer)
srv = Proxy.getInterface("ws-bank")

-----------------------------------------------------------------
-- | Functions [1]
-----------------------------------------------------------------
function nyoBSServer.checkout(preco, custom)
	local source = source 
	local user_id = vRP.getUserId(source)
	if preco then 
		if vRP.tryFullPayment(user_id,parseInt(preco)) then
			vRP.setUData(user_id,"currentCharacterMode", custom)
			srv.register_trans(user_id,"Compra no Salão de Beleza.",preco)
			TriggerClientEvent('Notify',source,'sucesso',"Sucesso","[STYLE BARBERSHOP] Você pagou <b>R$"..preco.." reais</b>.",10000)
		else 
			nyoBSClient.resetBuy(source)	
			TriggerClientEvent('Notify',source,'negado',"Negado","[STYLE BARBERSHOP] Você não possui dinheiro.",10000)			
		end		
	else 
		TriggerClientEvent('Notify',source,'negado',"Negado","[STYLE BARBERSHOP] Ocorreu um Erro! Tente novamente.",10000)		
		nyoBSClient.resetBuy(source)
	end
end


function nyoBSServer.checkProcurado() 
    local user_id = vRP.getUserId(source)
	return vRP.searchReturn(source,user_id)
end




AddEventHandler("disney-barbershop:init", function(user_id)
	local player = vRP.getUserSource(user_id)
	if player then
		local value = vRP.getUData(user_id,"currentCharacterMode")
		if value ~= nil then
            local custom = json.decode(value) or {}
			nyoBSClient.setCharacter(player,custom)
		end
	end
end)

-- RegisterCommand('rbb', function(source, args, rawCommand)
--     local source = source 
--     local user_id = vRP.getUserId(source)
--     local player = vRP.getUserSource(user_id)
-- 	if player then
-- 		local value = vRP.getUData(user_id,"currentCharacterMode")
-- 		if value ~= nil then
--             local custom = json.decode(value) or {}
-- 			nyoBSClient.setCharacter(player,custom)
-- 		end
-- 	end
-- end)