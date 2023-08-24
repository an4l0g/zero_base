sDynamic = Tunnel.getInterface('zero_dynamic')
cDynamic = {}
Tunnel.bindInterface('zero_dynamic', cDynamic)
zero = Proxy.getInterface('zero')


RegisterKeyMapping("openDynamic", "Abrir ações possíveis", 'KEYBOARD', "F9")
RegisterCommand("openDynamic", function()
    local ped = PlayerPedId()
    if (GetEntityHealth(ped) > 100 and not zero.isHandcuffed()) then
        cDynamic.openOrUpdateNui()
    end
end)

cDynamic.openOrUpdateNui = function()
    SetNuiFocus(true, true)
    SendNUIMessage({
        action = 'open',
        favorites = sDynamic.getFavorites(),
        clothes = exports.zero_system:getClothesPresets(),
        animations = exports.zero_core:getAllAnimations(),
        permissions = {
            hospital = sDynamic.checkPermission('hospital.permissao'),
            policia = sDynamic.checkPermission('policia.permissao'),
            staff = sDynamic.checkPermission('staff.permissao'),
            mecanica = sDynamic.checkPermission('zeromecanica.permissao'),
        }
    })
end

RegisterNuiCallback('close', function()
    SetNuiFocus(false, false)
end)

RegisterNuiCallback('handleAction', function(data)
    if (data.side == 'client') then
        TriggerEvent('zero_interactions:'..data.action, data.value)
    else
        TriggerServerEvent('zero_interactions:'..data.action, data.value)
    end
end)

RegisterNuiCallback('setFavorite', function(data)
    sDynamic.setFavorite(data.action)
end)

RegisterNuiCallback('deleteFavorite', function(data)
    sDynamic.deleteFavorite(data.action)
end)