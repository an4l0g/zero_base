cRep = {}
Tunnel.bindInterface('zero_reputation', cRep)
sRep = Tunnel.getInterface('zero_reputation')

cRep.openNui = function(data)
    SetNuiFocus(true, true)
    SendNUIMessage(data)
end

RegisterNUICallback('selectOrg', function(data)
    SetNuiFocus(true, true)
    SendNUIMessage({
        action = 'selectOrg',
        org = data.org,
        activityList = sRep.getReps(data.org)
    })
end)

RegisterNUICallback('close', function()
    SetNuiFocus(false, false)
end)