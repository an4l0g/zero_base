local carryingBackInProgress = false

RegisterCommand('carregar', function(source)
	local ped = PlayerPedId()
	if not carryingBackInProgress and GetEntityHealth(ped) > 101 then	
		TriggerServerEvent('vrp_carry:carryStart')
	else
		TriggerServerEvent("vrp_carry:carryTryStop")
	end
end)

RegisterNetEvent('vrp_carry:carryMe', function(animationLib, animation,length,controlFlag,animFlag)
	local playerPed = PlayerPedId()
	carryingBackInProgress = true

	RequestAnimDict(animationLib)
	while not HasAnimDictLoaded(animationLib) do
		Citizen.Wait(10)
	end

	Wait(500)
	if controlFlag == nil then controlFlag = 0 end
	TaskPlayAnim(playerPed, animationLib, animation, 8.0, -8.0, length, controlFlag, 0, false, false, false)
end)

RegisterNetEvent('vrp_carry:carryTarget', function(target, animationLib, animation2, distans, distans2, height, length,spin,controlFlag)
	local playerPed = PlayerPedId()
	carryingBackInProgress = true

	RequestAnimDict(animationLib)
	while not HasAnimDictLoaded(animationLib) do
		Citizen.Wait(10)
	end
	
	if spin == nil then spin = 180.0 end
	if controlFlag == nil then controlFlag = 0 end

	local targetPed = GetPlayerPed(GetPlayerFromServerId(target))	
	AttachEntityToEntity(playerPed, targetPed, 0, distans2, distans, height, 0.5, 0.5, spin, false, false, false, false, 2, false)	
	TaskPlayAnim(playerPed, animationLib, animation2, 8.0, -8.0, length, controlFlag, 0, false, false, false)
end)


RegisterNetEvent('vrp_carry:carryStop', function()
	carryingBackInProgress = false
	ClearPedSecondaryTask(GetPlayerPed(-1))
	DetachEntity(GetPlayerPed(-1), true, false)
end)