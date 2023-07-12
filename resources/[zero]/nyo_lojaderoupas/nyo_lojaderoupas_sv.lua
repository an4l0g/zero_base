local Tunnel = module("zero", "lib/Tunnel")
local Proxy = module("zero", "lib/Proxy")

vRP = Proxy.getInterface("zero")
vRPclient = Tunnel.getInterface("zero","nyo_lojaderoupas")
vRPloja = Tunnel.getInterface("nyo_lojaderoupas")
nyo = Proxy.getInterface("nyo")
srv = Proxy.getInterface("ws-bank")

-----------------------------------------------------------------------------------------------------------------------------------------
-- PREPARE
-----------------------------------------------------------------------------------------------------------------------------------------
vRP._prepare("nyoLojaRoupas/getGuardaRoupa", "SELECT * FROM vrp_user_data WHERE user_id = @user_id AND dkey = 'nyo:GuardaRoupa'")
vRP._prepare("nyoLojaRoupas/setGuardaRoupa", "REPLACE INTO vrp_user_data(user_id,dkey,dvalue) VALUES(@user_id,'nyo:GuardaRoupa',@value)")
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONEXÃO
-----------------------------------------------------------------------------------------------------------------------------------------
nyoLojaRoupaS = {}
Tunnel.bindInterface("nyo_lojaderoupas",nyoLojaRoupaS)

RegisterServerEvent("LojaDeRoupas:Comprar")
AddEventHandler("LojaDeRoupas:Comprar", function(preco, dataParts)
    local user_id = vRP.getUserId(source)
    local parts = json.decode(dataParts)
    if preco then
        if vRP.tryFullPayment(user_id,parseInt(preco)) then
            local dataParts = vRP.query("nyoLojaRoupas/getGuardaRoupa", {user_id = user_id})
            local playerParts = {}
                if #dataParts > 0 then 
                    playerParts = json.decode(dataParts[1]['dvalue'])
                end
            --local playerParts = vRP.getUData(user_id, "nyo:GuardaRoupa")
            srv.register_trans(user_id,"Compra na Loja de Roupas.",preco)
            TriggerClientEvent('Notify',source,'sucesso',"Sucesso","Você pagou <b>$"..preco.." dólares</b> em roupas e acessórios.",10000)
           -- local playerParts = json.decode(vRP.getUData(user_id, "nyo:GuardaRoupa"))

            for i = 1, 11 do 
                if(playerParts[tostring(i)]) then 
                    local partId = parts[tostring(i)][1]
                    if not playerParts[tostring(i)][tostring(partId)] then 
                        if parseInt(partId) >= 0 then
                            playerParts[tostring(i)][tostring(partId)] = true
                        end
                    end
                else
                    local partId = parts[tostring(i)][1]
                    if parseInt(partId) >= 0 then                     
                        playerParts[tostring(i)] = {}
                        playerParts[tostring(i)][tostring(partId)] = true
                    end
                end
            end   

            if(playerParts[tostring('p0')]) then 
                local partId = parts[tostring('p0')][1]
                if not playerParts[tostring('p0')][tostring(partId)] then 
                    if parseInt(partId) >= 0 then
                        playerParts[tostring('p0')][tostring(partId)] = true
                    end
                end
            else
                local partId = parts[tostring('p0')][1]
                if parseInt(partId) >= 0 then                     
                    playerParts[tostring('p0')] = {}
                    playerParts[tostring('p0')][tostring(partId)] = true
                end
            end

            if(playerParts[tostring('p1')]) then 
                local partId = parts[tostring('p1')][1]
                if not playerParts[tostring('p1')][tostring(partId)] then 
                    if parseInt(partId) >= 0 then
                        playerParts[tostring('p1')][tostring(partId)] = true
                    end
                end
            else
                local partId = parts[tostring('p1')][1]
                if parseInt(partId) >= 0 then                 
                    playerParts[tostring('p1')] = {}
                    playerParts[tostring('p1')][tostring(partId)] = true
                end
            end

            if(playerParts[tostring('p2')]) then 
                local partId = parts[tostring('p2')][1]
                if not playerParts[tostring('p2')][tostring(partId)] then 
                    if parseInt(partId) >= 0 then
                        playerParts[tostring('p2')][tostring(partId)] = true
                    end
                end
            else
                local partId = parts[tostring('p2')][1]
                if parseInt(partId) >= 0 then                     
                    playerParts[tostring('p2')] = {}
                    playerParts[tostring('p2')][tostring(partId)] = true
                end
            end

            if(playerParts[tostring('p6')]) then                 
                local partId = parts[tostring('p6')][1]                
                if not playerParts[tostring('p6')][tostring(partId)] then                    
                    if parseInt(partId) >= 0 then
                        playerParts[tostring('p6')][tostring(partId)] = true
                    end
                end
            else
                local partId = parts[tostring('p6')][1]
                if parseInt(partId) >= 0 then                     
                    playerParts[tostring('p6')] = {}
                    playerParts[tostring('p6')][tostring(partId)] = true
                end
            end

            if(playerParts[tostring('p7')]) then 
                local partId = parts[tostring('p7')][1]
                if not playerParts[tostring('p7')][tostring(partId)] then 
                    if parseInt(partId) >= 0 then
                        playerParts[tostring('p7')][tostring(partId)] = true
                    end
                end
            else
                local partId = parts[tostring('p7')][1]
                if parseInt(partId) >= 0 then                     
                    playerParts[tostring('p7')] = {}
                    playerParts[tostring('p7')][tostring(partId)] = true
                end
            end
            
          --  print(json.encode(playerParts['p1']))
            local setGuardaRoupa = vRP.execute("nyoLojaRoupas/setGuardaRoupa", { user_id = user_id, value = json.encode(playerParts)})
            
            if setGuardaRoupa == 1 or setGuardaRoupa == 2 then 
                local userSource = vRP.getUserSource(user_id)
                vRPloja.finalizarCompra(userSource, true)
            end
            
        else
            local userSource = vRP.getUserSource(user_id)
            TriggerClientEvent('Notify',source,'negado',"Negado","Você não tem dinheiro suficiente",10000)
            vRPloja.finalizarCompra(userSource, false)
        end 
    end
end)


--------------------------------------------------
-- Check Permission
--------------------------------------------------
function nyoLojaRoupaS.checkPermission(perm)
    local source = source 
    local user_id = vRP.getUserId(source)
    if user_id then 
        if vRP.hasPermission(user_id,perm) then
            return true
        end
    end
    return false
end
--------------------------------------------------
-- Check Procurado
--------------------------------------------------
function nyoLojaRoupaS.checkProcurado()
	local user_id = vRP.getUserId(source)
	return vRP.searchReturn(source,user_id)
end
--------------------------------------------------
