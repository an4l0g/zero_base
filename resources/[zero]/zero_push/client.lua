vSERVER = Tunnel.getInterface(GetCurrentResourceName())

local getHours = function()
	local year, month, day, hour, minute, second = GetLocalTime()
	if hour < 10 then hour = '0'..hour end
    if minute < 10 then minute = '0'..minute end
	return hour..':'..minute
end

RegisterKeyMapping('+notifypush', 'Notificação Policia', 'keyboard', 'F12')
RegisterCommand('+notifypush', function()
    if (GetEntityHealth(PlayerPedId()) > 100 and vSERVER.checkPermission('policia.permissao')) then
        SendNUIMessage({
            action = 'notifys',
        })
    end
end)

--[[
    data = {
        code,
        title,
        description,
        officer,
        car,
        title,
        coords
    }
]]--

RegisterNetEvent('notifypush', function(data)
    data.street = GetStreetNameFromHashKey(GetStreetNameAtCoord(data.coords.x, data.coords.y, data.coords.z));
    data.hours = getHours()
    SendNUIMessage({ action = 'show', data = data })
end)

RegisterNuiCallback('open', function(data, cb)
    SetNuiFocus(true, true)
end)

RegisterNuiCallback('close', function(data, cb)
    SetNuiFocus(false, false)
end)

RegisterNuiCallback('setWay', function(data, cb)
    SetNuiFocus(false, false)
    SetNewWaypoint(data['x'] + 0.0001, data['y'] + 0.0001)
end)