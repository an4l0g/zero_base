gbMembers = Tunnel.getInterface('gb_core_ilegal/members')
gbGoals = Tunnel.getInterface('gb_core_ilegal/goals')
gbMessage = Tunnel.getInterface('gb_core_ilegal/message')
gbProduction = Tunnel.getInterface('gb_core_ilegal/production')

RegisterCommand('painel', function()
    local permissions = gbMembers.getPermissions()
    if permissions ~= nil then
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
    print('oi')
	TriggerEvent('GrupoBrazuca:stopTabletAnim')
    SetNuiFocus(false, false)
end)            