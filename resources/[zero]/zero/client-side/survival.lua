local nocauteado = false
local timer_default = 180
local deathtimer = timer_default
--============================================

function zero.varyHealth(variation)
	local ped = PlayerPedId()
	local n = math.floor(GetEntityHealth(ped)+variation)
	SetEntityHealth(ped,n)
end

function zero.getHealth()
	return GetEntityHealth(PlayerPedId())
end

function zero.setHealth(health)
	SetEntityHealth(PlayerPedId(),parseInt(health))
end

function zero.setFriendlyFire(flag)
	NetworkSetFriendlyFireOption(flag)
	SetCanAttackFriendly(PlayerPedId(),flag,flag)
end

function zero.isInComa()
	return nocauteado
end

function zero.getDeathTimer()
	return deathtimer
end

function zero.setTimeComa(t)
	if nocauteado then
		deathtimer = parseInt(t)
		return true
	end
end

function zero.killComa(time)
	return zero.setTimeComa(time or 60)
end

function zero.killGod()
	nocauteado = false
	deathtimer = timer_default
	local ped = PlayerPedId()
	if GetEntityHealth(ped) <= 101 then
		local pCDS = GetEntityCoords(ped)
		NetworkResurrectLocalPlayer(pCDS.x,pCDS.y,pCDS.z,true,true,false)
	end
	TransitionFromBlurred(1000)
	SetEntityHealth(ped,130)
	vRPserver._updateHealth(130)
	SetEntityInvincible(ped,false)
	ClearPedBloodDamage(ped)	
	ClearPedTasks(ped)
	ClearPedSecondaryTask(ped)
end

function zero.PrisionGod()
	nocauteado = false
	deathtimer = timer_default
	local ped = PlayerPedId()
	if GetEntityHealth(ped) <= 101 then
		local pCDS = GetEntityCoords(ped)
		NetworkResurrectLocalPlayer(pCDS.x,pCDS.y,pCDS.z,true,true,false)
		TransitionFromBlurred(1000)
		SetEntityHealth(ped,120)
		vRPserver._updateHealth(120)
		SetEntityInvincible(ped,false)
		ClearPedBloodDamage(ped)	
		ClearPedTasks(ped)
		ClearPedSecondaryTask(ped)
	end
end
--========================================================================================
-- COMA THREAD
--========================================================================================
local hospital = vector4(364.31, -591.31, 28.69, 246.61416625977)

Citizen.CreateThread(function()
	while true do		
		if (not nocauteado) then
			local ped = PlayerPedId()
			if (GetEntityHealth(ped) <= 101) then
				deathtimer = timer_default
				nocauteado = true
				
				local pCDS = GetEntityCoords(ped)
				NetworkResurrectLocalPlayer(pCDS.x,pCDS.y,pCDS.z,true,true,false)		
				
				vRPserver._updateHealth(101)
				SetEntityHealth(ped,101)
				SetEntityInvincible(ped,true)
				if IsPedInAnyVehicle(ped) then
					TaskLeaveVehicle(ped,GetVehiclePedIsIn(ped),4160)
				end

				TransitionToBlurred(1000)
				
				TriggerEvent("vRP:onPlayerDied")
				TriggerServerEvent("vRP:onPlayerDied")
				
				threadNocauted()			
			end
		end
		Citizen.Wait(100)
	end
end)

function threadNocauted()
	Citizen.CreateThread(function()
		while nocauteado do
			local ped = PlayerPedId()
			-- if deathtimer > 0 then
			-- 	drawTxt("AGUARDE ~r~"..deathtimer.." ~w~SEGUNDOS",4,0.5,0.92,0.5,255,255,255,255)
			-- else
			-- 	drawTxt("PRESSIONE ~g~E ~w~PARA VOLTAR AO AEROPORTO OU AGUARDE POR SOCORRO MÉDICO",4,0.5,0.92,0.5,255,255,255,255)
			-- 	if IsControlJustPressed(0,38) and (not IsEntityAttached(ped)) then
			-- 		if vRPserver.clearAfterDie() then
			-- 			DoScreenFadeOut(1000)
			-- 			TransitionFromBlurred(1000)

			-- 			FreezeEntityPosition(ped,true)
			-- 			SetEntityCoords(ped, hospital.x, hospital.y, hospital.z + 0.20,1,0,0,1)
			-- 			SetEntityHeading(ped, hospital.w )

			-- 			SetEntityInvincible(ped,false)
			-- 			ClearPedBloodDamage(ped)

			-- 			zero.killGod()
			-- 			zero.setHealth(400)
			-- 			TriggerEvent("carrinho",0)						

			-- 			SetTimeout(5000,function()
			-- 				FreezeEntityPosition(ped,false)
			-- 				Citizen.Wait(1000)
			-- 				DoScreenFadeIn(1000)
			-- 				TriggerEvent("Notify","importante","Você acabou de acordar de um coma profundo...",4000)
			-- 			end)
			-- 			return
			-- 		end
			-- 	end
			-- end
			if not IsPedInAnyVehicle(ped) then
				if not IsEntityPlayingAnim(ped,"misslamar1dead_body", "dead_idle",3) then
					zero.playAnim(false,{{"misslamar1dead_body", "dead_idle"}},true)
				end
			else
				if IsEntityPlayingAnim(ped,"misslamar1dead_body", "dead_idle",3) then
					ClearPedTasks(ped)	
				end
				SetPedToRagdoll(ped,1000,1000,0,0,0,0)
			end
			SetEntityHealth(ped,101)
			DisablePlayerFiring(PlayerId(),true)
			DisableControlAction(0,21,true)
			DisableControlAction(0,22,true)
			DisableControlAction(0,23,true)
			DisableControlAction(0,24,true)
			DisableControlAction(0,25,true)
			DisableControlAction(0,29,true)
			DisableControlAction(0,32,true)
			DisableControlAction(0,33,true)
			DisableControlAction(0,34,true)
			DisableControlAction(0,35,true)
			DisableControlAction(0,47,true)
			DisableControlAction(0,56,true)
			DisableControlAction(0,58,true)
			DisableControlAction(0,73,true)
			DisableControlAction(0,75,true)
			DisableControlAction(0,137,true)
			DisableControlAction(0,140,true)
			DisableControlAction(0,141,true)
			DisableControlAction(0,142,true)
			DisableControlAction(0,143,true)
			DisableControlAction(0,166,true)
			DisableControlAction(0,167,true)
			DisableControlAction(0,168,true)
			DisableControlAction(0,169,true)
			DisableControlAction(0,170,true)
			DisableControlAction(0,177,true)
			DisableControlAction(0,182,true)
			DisableControlAction(0,187,true)
			DisableControlAction(0,188,true)
			DisableControlAction(0,189,true)
			DisableControlAction(0,190,true)
			DisableControlAction(0,243,true)
			DisableControlAction(0,257,true)
			DisableControlAction(0,263,true)
			DisableControlAction(0,264,true)
			DisableControlAction(0,268,true)
			DisableControlAction(0,269,true)
			DisableControlAction(0,270,true)
			DisableControlAction(0,271,true)
			DisableControlAction(0,288,true)
			DisableControlAction(0,289,true)
			DisableControlAction(0,311,true)
			DisableControlAction(0,344,true)
			Citizen.Wait(1)
		end
	end)
end

reviveNocuted = function()
	local ped = PlayerPedId()
	if (not IsEntityAttached(ped)) then
		if vRPserver.clearAfterDie() then

			DoScreenFadeOut(1000)
			TransitionFromBlurred(1000)

			while (not IsScreenFadedOut()) do
                Citizen.Wait(100)
            end

			FreezeEntityPosition(ped,true)
			SetEntityCoords(ped, hospital.x, hospital.y, hospital.z + 0.20,1,0,0,1)
			SetEntityHeading(ped, hospital.w )

			SetEntityInvincible(ped,false)
			ClearPedBloodDamage(ped)

			zero.killGod()
			zero.setHealth(400)
			vRPserver._updateHealth(400)
			TriggerEvent("carrinho",0)						

			SetTimeout(5000,function()
				FreezeEntityPosition(ped,false)
				Citizen.Wait(1000)
				DoScreenFadeIn(1000)
				TriggerEvent("Notify","importante","Você acabou de acordar de um coma profundo...",4000)
			end)
		end
	end
end
exports('reviveNocuted',reviveNocuted)
--========================================================================================
-- REMOVE RECHARGE THREAD
--========================================================================================
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1000)
		SetPlayerHealthRechargeMultiplier(PlayerId(),0.0)
	end
end)
--========================================================================================
-- NOCAUTED THREAD
--========================================================================================
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1000)
		if nocauteado and deathtimer > 0 then
			deathtimer = deathtimer - 1
		end
	end
end)
--========================================================================================
-- HUNGER / THIRST
--========================================================================================
function zero.getSpeed()
	local speed = GetEntityVelocity(PlayerPedId())
	return math.sqrt(speed.x*speed.x+speed.y*speed.y+speed.z*speed.z)
end

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(5000)
		if IsPlayerPlaying(PlayerId()) then
			local ped = PlayerPedId()
			-- variations for one minute
			local vthirst = 0
			local vhunger = 0

			-- on foot, increase thirst/hunger in function of velocity
			if IsPedOnFoot(ped) and not zero.isNoclip() then
				local factor = math.min(zero.getSpeed(),10)
				vthirst = vthirst+1*factor
				vhunger = vhunger+0.5*factor
			end

			-- in melee combat, increase
			if IsPedInMeleeCombat(ped) then
				vthirst = vthirst+10
				vhunger = vhunger+5
			end

			-- injured, hurt, increase
			if IsPedHurt(ped) or IsPedInjured(ped) then
				vthirst = vthirst+2
				vhunger = vhunger+1
			end

			-- do variation
			if vthirst ~= 0 then
				vRPserver._varyThirst(vthirst/12.0)
			end
			if vhunger ~= 0 then
				vRPserver._varyHunger(vhunger/12.0)
			end
		end
	end
end)
--========================================================================================
-- DRAW TEXT
--========================================================================================
function drawTxt(text,font,x,y,scale,r,g,b,a)
	SetTextFont(font)
	SetTextScale(scale,scale)
	SetTextColour(r,g,b,a)
	SetTextOutline()
	SetTextCentre(1)
	SetTextEntry("STRING")
	AddTextComponentString(text)
	DrawText(x,y)
end