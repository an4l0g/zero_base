vSERVER = Tunnel.getInterface(GetCurrentResourceName())

RegisterKeyMapping('openCodes', '[Zero Police] - Códigos Q', 'keyboard', 'J')
RegisterCommand('openCodes', function()
    if (vSERVER.checkPermission({ 'policia.permissao', 'deic.permissao' })) then
        SetNuiFocus(true, true)
        SendNUIMessage({ action = 'OPEN_TENCODE' })
    end
end)

RegisterNUICallback('code', function(data, cb)
    vSERVER.executeCode(data.code)
end)

RegisterNUICallback('close', function(data, cb)
    SetNuiFocus(false, false)
end)