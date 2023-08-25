cacheInteractions = {}

local setPed = {
    [GetHashKey('mp_m_freemode_01')] = {
        _Handcuff = { 7, 41, 0, 2 }
    },
    [GetHashKey('mp_f_freemode_01')] = {
        _Handcuff = {  7, 25, 0, 2 }
    }
}

RegisterKeyMapping('+algemar', 'Interação - Algemar', 'keyboard', 'G')
RegisterCommand('+algemar', function() if (not IsPedInAnyVehicle(PlayerPedId())) then TriggerServerEvent('zero_interactions:handcuff') end; end)

cacheInteractions['zero:attach:src'] = nil
cacheInteractions['zero:attach:active'] = false

RegisterNetEvent('zero:attach', function(_source, boneIndex, xPos, yPos, zPos, xRot, yRot, zRot, p9, useSoftPinning, collision, isPed, rotationOrder, syncRot)
    cacheInteractions['zero:attach:src'] = _source
    cacheInteractions['zero:attach:active'] = (not cacheInteractions['zero:attach:active'])
    local ped = PlayerPedId()
	if (cacheInteractions['zero:attach:active']) then
		local player = GetPlayerFromServerId(cacheInteractions['zero:attach:src'])
		if (player > -1) then
			AttachEntityToEntity(ped, GetPlayerPed(player), boneIndex, xPos, yPos, zPos, xRot, yRot, zRot, p9, useSoftPinning, collision, isPed, rotationOrder, syncRot)
		end
	else
		DetachEntity(ped, true, false)
	end
end)

RegisterNetEvent('zero_interactions:algemas', function(action)
    local ped = PlayerPedId()
    if (action == 'colocar') then
        local Handcuff = setPed[GetEntityModel(ped)]
        if (Handcuff) and Handcuff._Handcuff then Handcuff = Handcuff._Handcuff SetPedComponentVariation(ped, Handcuff[1], Handcuff[2], Handcuff[3], Handcuff[4]); end;
    else
        SetPedComponentVariation(ped, 7, 0, 0, 2)
    end
end)

RegisterKeyMapping('+carregar', 'Interação - Carregar', 'keyboard', 'H')
RegisterCommand('+carregar', function() if (not IsPedInAnyVehicle(PlayerPedId())) then TriggerServerEvent('zero_interactions:carregar') end; end)

cacheInteractions['carregar:src'] = nil
cacheInteractions['carregar:active'] = false

RegisterNetEvent('carregar', function(_source)
	if (LocalPlayer.state.Appearance) then return; end;
    cacheInteractions['carregar:src'] = _source
    cacheInteractions['carregar:active'] = (not cacheInteractions['carregar:active'])
    local ped = PlayerPedId()
	if (cacheInteractions['carregar:active']) then
		local player = GetPlayerFromServerId(cacheInteractions['carregar:src'])
		if (player > -1) then
			AttachEntityToEntity(ped, GetPlayerPed(player), 4103, -0.65816, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, false, false, false, false, 2, true)
		end
	else
		DetachEntity(ped, true, false)
	end
end)

local PlayerData = {}
PlayerData['temp:wins'] = false

RegisterCommand('wins', function()
	local vehicle = zero.getNearestVehicle(5)
	if (IsEntityAVehicle(vehicle)) then
		PlayerData['temp:wins'] = (not PlayerData['temp:wins'])
		TriggerServerEvent('trywins', VehToNet(vehicle), PlayerData['temp:wins'])
	end
end)

RegisterNetEvent('zero_interactions:carWins', function()
    local vehicle = zero.getNearestVehicle(5)
	if (IsEntityAVehicle(vehicle)) then
		PlayerData['temp:wins'] = (not PlayerData['temp:wins'])
		TriggerServerEvent('trywins', VehToNet(vehicle), PlayerData['temp:wins'])
	end
end)

RegisterNetEvent('syncwins', function(index, open)
	if NetworkDoesNetworkIdExist(index) then
		local v = NetToVeh(index)
		if DoesEntityExist(v) then
			if IsEntityAVehicle(v) then
				if open then
					RollDownWindow(v,0)
					RollDownWindow(v,1)
					RollDownWindow(v,2)
					RollDownWindow(v,3)
				else
					RollUpWindow(v,0)
					RollUpWindow(v,1)
					RollUpWindow(v,2)
					RollUpWindow(v,3)
				end
			end
		end
	end
end)

RegisterCommand('seat', function(source, args)
	local ped = PlayerPedId()
	local vehicle = GetVehiclePedIsUsing(ped)
	if (IsEntityAVehicle(vehicle) and IsPedInAnyVehicle(ped)) then
		local seat = 0
		if (parseInt(args[1]) <= 1) then
			seat = -1
		else
			seat = parseInt(args[1])-2
		end
		if (IsVehicleSeatFree(vehicle, seat)) then
			SetPedIntoVehicle(ped, vehicle, seat)
		else
			TriggerEvent('notify', 'Seat', 'Este <b>assento</b> está ocupado.')
		end
	else
		TriggerEvent('notify', 'Seat', 'Você não está dentro de um <b>veículo</b>.')
	end
end)

RegisterCommand('doors', function(source, args)
	local vehicle = zero.getNearestVehicle(7.0)
	if (IsEntityAVehicle(vehicle)) then
		TriggerServerEvent('trydoors', VehToNet(vehicle), parseInt(args[1]))
	end
end)

RegisterNetEvent('zero_interactions:carDoors', function(value)
    local vehicle = zero.getNearestVehicle(7.0)
	if (IsEntityAVehicle(vehicle)) then
		TriggerServerEvent('trydoors', VehToNet(vehicle), value)
	end
end)

RegisterNetEvent('syncdoors', function(index, door)
	if (NetworkDoesNetworkIdExist(index)) then
		local v = NetToVeh(index)
		if (DoesEntityExist(v)) then
			if (IsEntityAVehicle(v)) then
				if (door == 1) then
					if (GetVehicleDoorAngleRatio(v, 0) == 0) then
						SetVehicleDoorOpen(v, 0, 0, 0)
					else
						SetVehicleDoorShut(v, 0, 0)
					end
				elseif (door == 2) then
					if (GetVehicleDoorAngleRatio(v, 1) == 0) then
						SetVehicleDoorOpen(v, 1, 0, 0)
					else
						SetVehicleDoorShut(v, 1, 0)
					end
				elseif (door == 3) then
					if (GetVehicleDoorAngleRatio(v, 2) == 0) then
						SetVehicleDoorOpen(v, 2, 0, 0)
					else
						SetVehicleDoorShut(v, 2, 0)
					end
				elseif (door == 4) then
					if (GetVehicleDoorAngleRatio(v, 3) == 0) then
						SetVehicleDoorOpen(v, 3, 0, 0)
					else
						SetVehicleDoorShut(v, 3, 0)
					end
                elseif (door == 5) then
                    if (GetVehicleDoorAngleRatio(v,5) == 0) then
                        SetVehicleDoorOpen(v,5,0,0)
                    else
                        SetVehicleDoorShut(v,5,0)
                    end
                elseif (door == 6) then
                    if (GetVehicleDoorAngleRatio(v,4) == 0) then
                        SetVehicleDoorOpen(v,4,0,0)
                    else
                        SetVehicleDoorShut(v,4,0)
                    end
				else
                    local isopen = (GetVehicleDoorAngleRatio(v, 0) and GetVehicleDoorAngleRatio(v, 1))
					if (isopen == 0) then
						SetVehicleDoorOpen(v, 0 ,0 ,0)
						SetVehicleDoorOpen(v, 1 ,0 ,0)
						SetVehicleDoorOpen(v, 2 ,0 ,0)
						SetVehicleDoorOpen(v, 3 ,0 ,0)
                        SetVehicleDoorOpen(v, 4, 0, 0)
                        SetVehicleDoorOpen(v, 5, 0, 0)
					else
						SetVehicleDoorShut(v, 0, 0)
						SetVehicleDoorShut(v, 1, 0)
						SetVehicleDoorShut(v, 2, 0)
						SetVehicleDoorShut(v, 3, 0)
                        SetVehicleDoorShut(v, 4, 0)
                        SetVehicleDoorShut(v, 5, 0)
					end
				end
			end
		end
	end
end)