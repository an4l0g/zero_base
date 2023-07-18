vSERVER = Tunnel.getInterface(GetCurrentResourceName())

RegisterKeyMapping('openIdentity', 'Abrir identidade', 'keyboard', 'F11')
RegisterCommand('openIdentity', function()
    SetNuiFocus(true, true)
    animIdentity()
    updateNui()
end)

updateNui = function()
    local infos = vSERVER.getUserIdentity()
    SendNUIMessage({
        action = 'open',
        userInfo = infos
    })
end

local tablet
animIdentity = function()
    tablet = 'p_ld_id_card_01'
    RequestAnimDict('')
    TaskPlayAnim(PlayerPedId(), '', 'enter', 8.0, 1.0, -1, 50, 0, 0, 0, 0)
    zero._CarregarObjeto('amb@world_human_clipboard@male@base', 'base', tablet, 49, 60309)
end

RegisterNuiCallback('close', function()
    closeNui()
end)

closeNui = function()
    SetNuiFocus(false, false)
    zero._DeletarObjeto(tablet)
    TaskClearLookAt(PlayerPedId())
end

RegisterNuiCallback('changeImage', function(data)
    vSERVER.updatePhoto(data.image)
    updateNui()
end)