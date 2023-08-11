gbMembers = Tunnel.getInterface('gb_core_ilegal/members')
gbGoals = Tunnel.getInterface('gb_core_ilegal/goals')
gbMessage = Tunnel.getInterface('gb_core_ilegal/message')
gbProduction = Tunnel.getInterface('gb_core_ilegal/production')

blips = { 
	{ 
		label = 'ENTREGAR PRODUTOS',
		coords = vec3(-1791.7, -1199.07, 13.02),
		cb = function()
			local permissions = gbMembers.getPermissions()
			if permissions ~= nil then 
				SetNuiFocus(true, true)
				SendNUIMessage({
					action = 'openGoalsSender',
					userData = permissions,
					productsAndStorage = gbGoals.getStorageAndProducts(permissions.fac)
				})
			else
				TriggerEvent('Notify', 'negado', 'Você não deveria estar aqui!')
			end
		end
	},
	{ 
		label = 'ENCOMENDAR PRODUTOS',
		coords = vec3(-1816.53, -1193.58, 14.31), 
		cb = function()
			local permissions = gbMembers.getPermissions()
			if permissions ~= nil then 
				SetNuiFocus(true, true)
				SendNUIMessage({
					action = 'openFabrication',
					userData = permissions,
					productsAndStorage = gbGoals.getStorageAndProducts(permissions.fac)
				})
			else
				TriggerEvent('Notify', 'negado', 'Você não deveria estar aqui!')
			end
		end
	},
	{ 
		label = 'RECOLHER PRODUTOS',
		coords = vec3(-1803.62, -1197.99, 13.02), 
		cb = function()
			local permissions = gbMembers.getPermissions()
			if permissions ~= nil then 
				gbProduction.getOrders(permissions.fac)
			else
				TriggerEvent('Notify', 'negado', 'Você não deveria estar aqui!')
			end
		end
	}
}

Citizen.CreateThread(function()
	exports["vrp_target"]:RemoveTargetModel({ "csb_chin_goon" }, "Entregar Produtos")
	exports["vrp_target"]:RemoveTargetModel({ "s_m_m_janitor" }, "Encomendar Produtos")
    exports["vrp_target"]:RemoveTargetModel({ "s_m_m_chemsec_01" }, "Recolher Produtos")
	
	exports["vrp_target"]:AddTargetModel({ "csb_chin_goon" }, { options = { 
        { icon = "fas fa-mask", label = "Entregar Produtos", distance = 1.5, action = blips[1].cb }
	}})
	exports["vrp_target"]:AddTargetModel({ "s_m_m_janitor" }, { options = { 
        { icon = "fas fa-mask", label = "Encomendar Produtos", distance = 1.5, action = blips[2].cb }
	}})
	exports["vrp_target"]:AddTargetModel({ "s_m_m_chemsec_01" }, { options = { 
        { icon = "fas fa-mask", label = "Recolher Produtos", distance = 1.5, action = blips[3].cb }
	}})
end)

-- Citizen.CreateThread(function()
-- 	TransitionFromBlurred(1000)
-- 	SetNuiFocus(false,false)
-- 	while true do
-- 		local idle = 1000
-- 		local pCDS = GetEntityCoords(PlayerPedId())
-- 		for k,v in pairs(blips) do
-- 			local distance = #(pCDS - v.coords)
-- 			if distance <= 5.0 then
-- 				idle = 1
-- 				Text3D(v.coords.x,v.coords.y,v.coords.z,'~g~E~w~ - '..v.label,400)
-- 				if distance <= 1.2 and IsControlJustPressed(0,38) then
-- 					v.cb()
-- 				end 
-- 			end 
-- 		end 
-- 		Wait(idle)
-- 	end 
-- end)

RegisterCommand('painel', function()
    local permissions = gbMembers.getPermissions()
    if permissions ~= nil then
		TriggerEvent('GrupoBrazuca:tabletAnim')
        SetNuiFocus(true, true)
        SendNUIMessage({
            action = 'openPanel',
            userData = permissions
        })
    else 
        TriggerEvent('Notify', 'negado', 'Você não faz parte de uma organização!')
    end 
end)

Text3D = function(x,y,z,text,size)
	local onScreen,_x,_y = World3dToScreen2d(x,y,z)
	SetTextFont(4)
	SetTextScale(0.35,0.35)
	SetTextColour(255,255,255,155)
	SetTextEntry("STRING")
	SetTextCentre(1)
	AddTextComponentString(text)
	DrawText(_x,_y)
	local factor = (string.len(text))/size
	DrawRect(_x,_y+0.0125,0.01+factor,0.03,0,0,0,80)
end

RegisterNUICallback('close', function(data)
	TriggerEvent('GrupoBrazuca:stopTabletAnim')
    SetNuiFocus(false, false)
end)            