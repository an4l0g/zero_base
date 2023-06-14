cacheInteractions = {}

local setPed = {
    [GetHashKey('mp_m_freemode_01')] = {
        Handcuff = {
            { 7, 41, 0, 2 }
        }
    },
    [GetHashKey('mp_f_freemode_01')] = {
        Handcuff = {
            { 7, 25, 0, 2 }
        }
    }
}

RegisterKeyMapping('+algemar', 'Interação - Algemar', 'keyboard', 'G')
RegisterCommand('+algemar', function() if (not IsPedInAnyVehicle(PlayerPedId())) then TriggerServerEvent('zero_interactions:handcuff') end; end)

RegisterNetEvent('zero_interactions:algemas', function(action)
    local ped = PlayerPedId()
    if (action == 'colocar') then
        local Handcuff = setPed[GetEntityModel(ped)].Handcuff
        if (Handcuff) then SetPedComponentVariation(ped, Handcuff[1], Handcuff[2], Handcuff[3], Handcuff[4]); end;
    else
        SetPedComponentVariation(ped, 7, 0, 0, 2)
    end
end)

RegisterKeyMapping('+carregar', 'Interação - Carregar', 'keyboard', 'H')
RegisterCommand('+carregar', function() if (not IsPedInAnyVehicle(PlayerPedId())) then TriggerServerEvent('zero_interactions:carregar') end; end)

cacheInteractions['carregar:src'] = nil
cacheInteractions['carregar:active'] = false

RegisterNetEvent('carregar', function(_source)
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