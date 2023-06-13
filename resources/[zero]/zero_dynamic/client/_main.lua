sDynamic = Tunnel.getInterface('zero_dynamic')
cDynamic = {}

Tunnel.bindInterface('zero_dynamic', cDynamic)

RegisterKeyMapping("openDynamic", "Abrir ações possíveis", 'KEYBOARD', "F9")
RegisterCommand("openDynamic", function()
    -- DANIEL, VERIFICA AQUI SE A PESSOA TA MORTA
    cDynamic.openOrUpdateNui()
end)

cDynamic.openOrUpdateNui = function()
    SetNuiFocus(true, true)
    SendNUIMessage({
        action = 'open',
        favorites = sDynamic.getFavorites(),
        status = { -- FAZ ESSA MERDA AQUI DANIEL
            isHandcuffed = false,
            isMedic = true,
            isPolice = false,
            isCriminal = false,
            isInsideCar = false,
            isCloseCar = true,
            isClosePlayer = true,
        }
    })
end

RegisterNuiCallback('close', function()
    SetNuiFocus(false, false)
end)

RegisterNuiCallback('handleAction', function(data)
    sDynamic.handleAction(data.action, data.value)
end)

RegisterNuiCallback('setFavorite', function(data)
    sDynamic.setFavorite(data.action)
end)

RegisterNuiCallback('deleteFavorite', function(data)
    sDynamic.deleteFavorite(data.action)
end)