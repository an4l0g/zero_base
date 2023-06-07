cInventory.create3DText = function(x, y, z, text, size)
	local onScreen,_x,_y = World3dToScreen2d(x,y,z)
	SetTextFont(4)
	SetTextScale(0.35,0.35)
	SetTextColour(255,255,255,155)
	SetTextEntry('STRING')
	SetTextCentre(1)
	AddTextComponentString(text)
	DrawText(_x,_y)
	local factor = (string.len(text))/size
	DrawRect(_x,_y+0.0125,0.01+factor,0.03,0,0,0,80)
end

cInventory.animation = function(dict, anim)
    local playerPed = PlayerPedId()

    RequestAnimDict(dict)
    while not HasAnimDictLoaded(anim) do
        Citizen.Wait(100)
    end

    TaskPlayAnim(playerPed, dict, anim, 8.0, -8.0, -1, 0, 0, false, false, false)
end