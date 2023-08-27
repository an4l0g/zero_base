local _isDied = false
local deathTimer = 0
local _spawn = vector4(-784.4176, -1262.123, 5.690063, 235.2756)

zero.varyHealth = function(variation)
	local ped = PlayerPedId()
	local n = math.floor(GetEntityHealth(ped) + variation)
	SetEntityHealth(ped, n)
end

zero.getHealth = function()
	return GetEntityHealth(PlayerPedId())
end

zero.setHealth = function(health)
	SetEntityHealth(PlayerPedId(), parseInt(health))
end

zero.setFriendlyFire = function(flag)
	NetworkSetFriendlyFireOption(flag)
	SetCanAttackFriendly(PlayerPedId(),flag,flag)
end

zero.isInComa = function()
	return (GetEntityHealth(PlayerPedId()) <= 100)
end

zero.setDeathTime = function(time)
	if (_isDied) then
		deathTimer = parseInt(time)
	end
	return false
end

zero.killGod = function()
    local ped = PlayerPedId()
    _isDied = false
    deathTimer = 0

    if (GetEntityHealth(ped) <= 100) then
		local pCDS = GetEntityCoords(ped)
		NetworkResurrectLocalPlayer(pCDS.x,pCDS.y,pCDS.z,true,true,false)
	end

    TransitionFromBlurred(1000)
    
    SetEntityHealth(ped, 200)
    SetPedArmour(ped, 0)
    zeroServer._updateHealth(200)
    zeroServer._updateArmour(0)

    SetEntityInvincible(ped, false)
    ClearPedDamageDecalByZone(ped, 0, 'ALL')
 	ClearPedDamageDecalByZone(ped, 1, 'ALL')
 	ClearPedDamageDecalByZone(ped, 2, 'ALL')
 	ClearPedDamageDecalByZone(ped, 3, 'ALL')
 	ClearPedDamageDecalByZone(ped, 4, 'ALL')
 	ClearPedDamageDecalByZone(ped, 5, 'ALL')
    ClearPedBloodDamage(ped)    
    ClearPedTasks(ped)
	ClearPedSecondaryTask(ped)    
end

local _disableActions = function()
    DisablePlayerFiring(PlayerPedId(), true)
    DisableControlAction(0, 21, true)
    DisableControlAction(0, 22, true)
    DisableControlAction(0, 23, true)
    DisableControlAction(0, 24, true)
    DisableControlAction(0, 25, true)
    DisableControlAction(0, 29, true)
    DisableControlAction(0, 32, true)
    DisableControlAction(0, 33, true)
    DisableControlAction(0, 34, true)
    DisableControlAction(0, 35, true)
    DisableControlAction(0, 47, true)
    DisableControlAction(0, 56, true)
    DisableControlAction(0, 58, true)
    DisableControlAction(0, 73, true)
    DisableControlAction(0, 75, true)
    DisableControlAction(0, 137, true)
    DisableControlAction(0, 140, true)
    DisableControlAction(0, 141, true)
    DisableControlAction(0, 142, true)
    DisableControlAction(0, 143, true)
    DisableControlAction(0, 166, true)
    DisableControlAction(0, 167, true)
    DisableControlAction(0, 168, true)
    DisableControlAction(0, 169, true)
    DisableControlAction(0, 170, true)
    DisableControlAction(0, 177, true)
    DisableControlAction(0, 182, true)
    DisableControlAction(0, 187, true)
    DisableControlAction(0, 188, true)
    DisableControlAction(0, 189, true)
    DisableControlAction(0, 190, true)
    DisableControlAction(0, 243, true)
    DisableControlAction(0, 257, true)
    DisableControlAction(0, 263, true)
    DisableControlAction(0, 264, true)
    DisableControlAction(0, 268, true)
    DisableControlAction(0, 269, true)
    DisableControlAction(0, 270, true)
    DisableControlAction(0, 271, true)
    DisableControlAction(0, 288, true)
    DisableControlAction(0, 289, true)
    DisableControlAction(0, 311, true)
    DisableControlAction(0, 344, true)
end

local mainSurvival = function()
	if (_isDied) then return; end;
	_isDied = true
    cooldownSurvival(30)
    TriggerServerEvent('zero_hospital:CitizenDeath')
    TriggerEvent('vRP:onPlayerDied')
	TriggerServerEvent('vRP:onPlayerDied')
    if (LocalPlayer.state.GPS) then LocalPlayer.state.GPS = false; DisplayRadar(false); TriggerServerEvent('zero_system:gps_server') end;
	Citizen.CreateThread(function()
        SetEntityHealth(PlayerPedId(), 0)
		zeroServer._updateHealth(0)
        TransitionToBlurred(1000)
		while (_isDied) do
			local ped = PlayerPedId()
            SetEntityInvincible(ped, true)
            _disableActions() 
            if (deathTimer > 0) then
                Text2D(0, 0.39, 0.9, 'NOCAUTEADO, AGUARDE ~b~'..deathTimer..' SEGUNDOS', 0.4)
            else
                Text2D(0, 0.43, 0.9, 'PRESSIONE ~b~E~w~ PARA DESISTIR', 0.4)
                if (IsControlJustPressed(0, 38)) then
                    reviveSurvival(ped)
                end
            end
			Citizen.Wait(1)
		end
	end)
end

reviveSurvival = function(ped)
    if (zeroServer.clearAfterDie()) then
        Citizen.Wait(1000)
        DoScreenFadeOut(1000)
		Citizen.Wait(1000)

        FreezeEntityPosition(ped, true)
        SetEntityCoords(ped, _spawn.xyz)
        SetEntityHeading(ped, _spawn.w)

        zero.killGod()

        Citizen.SetTimeout(5000, function()
            SetEntityHealth(ped, 150)
            FreezeEntityPosition(ped, false)
            Citizen.Wait(1000)
            DoScreenFadeIn(1000)
            TriggerEvent('notify', 'Prefeitura', 'Você acabou de acordar de um <b>coma</b> profundo...')
        end)
    end
end

cooldownSurvival = function(time)
    Citizen.CreateThread(function()
        deathTimer = time
        while (deathTimer > 0) do
            deathTimer = (deathTimer - 1)
            Citizen.Wait(1000)
        end
        deathTimer = 0
    end)
end

AddEventHandler('gameEventTriggered', function (name, args)
	if (name == 'CEventNetworkEntityDamage')  then
		local ped = PlayerPedId()
		if (args[1] == ped and args[6] == 1) then 
            if (GetEntityHealth(ped) <= 101) then mainSurvival(); end;
		end
	end
end) 

zero.isDied = function()
	return _isDied
end

zero.getSpeed = function()
	local speed = GetEntityVelocity(PlayerPedId())
	return math.sqrt(speed.x*speed.x+speed.y*speed.y+speed.z*speed.z)
end

Text2D = function(font, x, y, text, scale)
    SetTextFont(font)
    SetTextProportional(7)
    SetTextScale(scale, scale)
    SetTextColour(255, 255, 255, 255)
    SetTextDropShadow(0, 0, 0, 0,255)
    SetTextEdge(4, 0, 0, 0, 255)
    SetTextEntry('STRING')
    AddTextComponentString(text)
    DrawText(x, y)
end