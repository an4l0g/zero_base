

srv = {}
Tunnel.bindInterface(GetCurrentResourceName(), srv)
vCLIENT = Tunnel.getInterface(GetCurrentResourceName())

srv.checkPermission = function(perm)
    local source = source
    local user_id = zero.getUserId(source)
    return zero.checkPermissions(user_id, perm)
end

local blips = {}
local dispatchIDS = Tools.newIDGenerator()
local cooldown = {}

local codes = {
    [1] = function(identity, coord, ids, player)
        TriggerClientEvent('announcement', player, 'QTH - Localização', identity.firstname..' '..identity.lastname..'  acabou de atualizar o QTH.', 'Delegacia Zero', true, 10000)
        blips[ids] = zeroClient.addBlip(player, coord.x, coord.y, coord.z, 622, 77, 'QTH - Localização', 0.5, true)
    end,
    [2] = function(identity, coord, ids, player)
        TriggerClientEvent('announcement', player, 'QRR - Reforço solicitado', identity.firstname..' '..identity.lastname..'  acabou de pedir QRR.', 'Delegacia Zero', true, 10000)                
        blips[ids] = zeroClient.addBlip(player, coord.x, coord.y, coord.z, 622, 51, 'QRR - Reforço solicitado', 0.5, true)
    end,
    [3] = function(identity, coord, ids, player)
        TriggerClientEvent('announcement', player, 'QRU - Ocorrência', identity.firstname..' '..identity.lastname..'  acabou de reportar uma ocorrência.', 'Delegacia Zero', true, 10000)
        blips[ids] = zeroClient.addBlip(player, coord.x, coord.y, coord.z, 622, 59, 'QRU - Ocorrência', 0.5, true)
    end,
    [4] = function(identity, coord, ids, player)
        TriggerClientEvent('announcement', player, 'QTI - A caminho', identity.firstname..' '..identity.lastname..' está a caminho.', 'Delegacia Zero', true, 10000)
    end,
    [5] = function(identity, coord, ids, player)
        TriggerClientEvent('announcement', player, 'QTA - Cancelar última mensagem', identity.firstname..' '..identity.lastname..'  acabou de cancelar a última mensagem.', 'Delegacia Zero', true, 10000)
    end,
    [6] = function(identity, coord, ids, player)
        TriggerClientEvent('announcement', player, 'QSM - Mensagem com interferência', identity.firstname..' '..identity.lastname..'  acabou de enviar uma mensagem com interferência.', 'Delegacia Zero', true, 10000)
        blips[ids] = zeroClient.addBlip(player, coord.x, coord.y, coord.z, 622, 61, 'QSM - Mensagem com interferência', 0.5, true)
    end,
    ['qth'] = function(identity, coord, ids, player)
        TriggerClientEvent('announcement', player, 'QTH - Localização', identity.firstname..' '..identity.lastname..'  acabou de atualizar o QTH.', 'Delegacia Zero', true, 10000)
        blips[ids] = zeroClient.addBlip(player, coord.x, coord.y, coord.z, 622, 77, 'QTH - Localização', 0.5, true)
    end,
    ['qrr'] = function(identity, coord, ids, player)
        TriggerClientEvent('announcement', player, 'QRR - Reforço solicitado', identity.firstname..' '..identity.lastname..'  acabou de pedir QRR.', 'Delegacia Zero', true, 10000)                
        blips[ids] = zeroClient.addBlip(player, coord.x, coord.y, coord.z, 622, 51, 'QRR - Reforço solicitado', 0.5, true)
    end,
    ['qru'] = function(identity, coord, ids, player)
        TriggerClientEvent('announcement', player, 'QRU - Ocorrência', identity.firstname..' '..identity.lastname..'  acabou de reportar uma ocorrência.', 'Delegacia Zero', true, 10000)
        blips[ids] = zeroClient.addBlip(player, coord.x, coord.y, coord.z, 622, 59, 'QRU - Ocorrência', 0.5, true)
    end,
    ['qti'] = function(identity, coord, ids, player)
        TriggerClientEvent('announcement', player, 'QTI - A caminho', identity.firstname..' '..identity.lastname..' está a caminho.', 'Delegacia Zero', true, 10000)
    end,
    ['qta'] = function(identity, coord, ids, player)
        TriggerClientEvent('announcement', player, 'QTA - Cancelar última mensagem', identity.firstname..' '..identity.lastname..'  acabou de cancelar a última mensagem.', 'Delegacia Zero', true, 10000)
    end,
    ['qsm'] = function(identity, coord, ids, player)
        TriggerClientEvent('announcement', player, 'QSM - Mensagem com interferência', identity.firstname..' '..identity.lastname..'  acabou de enviar uma mensagem com interferência.', 'Delegacia Zero', true, 10000)
        blips[ids] = zeroClient.addBlip(player, coord.x, coord.y, coord.z, 622, 61, 'QSM - Mensagem com interferência', 0.5, true)
    end,
}

srv.executeCode = function(code)
    local source = source
    local user_id = zero.getUserId(source)
    if (user_id) then
        local identity = zero.getUserIdentity(user_id)
        local coord = GetEntityCoords(GetPlayerPed(source))
        if (cooldown[user_id]) then
            TriggerClientEvent('notify', source, 'Código Q', 'Aguarde <b>'..cooldown[user_id]..' segundos</b>.')
            return
        end

        cooldownCode(user_id, 30)
        for l,w in pairs(zero.getUsersByPermission('policia.permissao')) do
            local player = zero.getUserSource(parseInt(w))
            if player then
                async(function()
                    local ids = dispatchIDS:gen()
                    zeroClient.playSound(player,'Oneshot_Final', 'MP_MISSION_COUNTDOWN_SOUNDSET')
                    codes[code](identity, coord, ids, player)
                    SetTimeout(30 * 1000, function() zeroClient.removeBlip(player, blips[ids]) dispatchIDS:free(ids) end)
                end)
            end
        end
    end
end

RegisterCommand('notificacao', function(source, args)
    local source = source
    local user_id = zero.getUserId(source)
    if user_id and zero.checkPermissions(user_id, { 'policia.permissao', 'deic.permissao' }) and args[1] then
        code = string.lower(args[1])

        local identity = zero.getUserIdentity(user_id)
        local coord = GetEntityCoords(GetPlayerPed(source))
        if (cooldown[user_id]) then
            TriggerClientEvent('notify', source, 'Código Q', 'Aguarde <b>'..cooldown[user_id]..' segundos</b>.')
            return
        end
        
        cooldownCode(user_id, 30)
        for l,w in pairs(zero.getUsersByPermission('policia.permissao')) do
            local player = zero.getUserSource(parseInt(w))
            if player then
                async(function()
                    local ids = dispatchIDS:gen()
                    zeroClient.playSound(player,'Oneshot_Final', 'MP_MISSION_COUNTDOWN_SOUNDSET')
                    if (codes[code]) then codes[code](identity, coord, ids, player); end;   
                    SetTimeout(30 * 1000, function() zeroClient.removeBlip(player, blips[ids]) dispatchIDS:free(ids) end)
                end)
            end
        end
    end
end)

cooldownCode = function(user_id, time)
    Citizen.CreateThread(function()
        cooldown[user_id] = time
        while (cooldown[user_id] > 0) do
            Citizen.Wait(1000)
            cooldown[user_id] = cooldown[user_id] - 1
        end
        cooldown[user_id] = nil
    end)
end