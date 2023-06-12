sDynamic = Tunnel.getInterface('zero_dynamic')

RegisterKeyMapping("openDynamic", "Abrir ações possíveis", 'KEYBOARD', "F9")
RegisterCommand("openDynamic", function()
    SetNuiFocus(true, true)
    SendNUIMessage({
        action = 'open'
    })
end)

RegisterNuiCallback('close', function()
    SetNuiFocus(false, false)
end)

RegisterNuiCallback('handleAction', function(data)
    sDynamic.handleAction(data.action, data.value)
end)