if IsDuplicityVersion() then
    webhook = function(link, message)
        if link and message and link ~= '' then
            PerformHttpRequest(link, function(err, text, headers) end, 'POST', json.encode({ content = message }), { ['Content-Type'] = 'application/json' })
        end
    end

    getUserId = function(source)
        return zero.getUserId(source)
    end

    getUserIdentity = function(user_id)
        return zero.getUserIdentity(user_id)
    end

    getIdentity = function(identity)
        return identity['firstname']..' '..identity['lastname']
    end

    hasPermission = function(user_id, permission)
        return zero.hasPermission(user_id, permission)
    end

    getGroupTitle = function(permission)
        return zero.getGroupTitle(permission)
    end

    giveWeapons = function(source, weapons, clear)
        return zeroclient.giveWeapons(source, weapons, clear, GlobalState.weaponToken)
    end

    getWeapons = function(source)
        return zeroclient.getWeapons(source)
    end

    getInventoryItemAmount = function(user_id, item)
        return zero.getInventoryItemAmount(user_id, item)
    end

    giveInventoryItem = function(user_id, item, quantity)
        return zero.giveInventoryItem(user_id, item, quantity)
    end

    itemNameList = function(item)
        return zero.itemNameList(item)
    end

    getInventoryWeight = function(user_id)
        return zero.getInventoryWeight(user_id)
    end

    getItemWeight = function(item)
        return zero.getItemWeight(item)
    end

    getInventoryMaxWeight = function(user_id)
        return zero.getInventoryMaxWeight(user_id)
    end

    serverNotify = function(source, message)
        TriggerClientEvent('notifyArsenal', source, message, 3000)
    end
else
    getWeapons = function()
        return zero.getWeapons()
    end

    threadMarker = function(config)
        Text3D(config.coord.xyz, '~g~E~w~ - ABRIR ARSENAL')
    end

    openFunction = function()
        TriggerEvent('Notify:Toogle', false) 
        TriggerEvent('s9_hud:toggleHud', false)
    end

    closeFunction = function()
        TriggerEvent('Notify:Toogle', true) 
        TriggerEvent('s9_hud:toggleHud', true)
    end

    clientNotify = function(message)
        TriggerEvent('notifyArsenal', message, 3000)
    end

    Text3D = function(coords, text)
        local onScreen, _x, _y = World3dToScreen2d(coords.x, coords.y, coords.z)
        SetTextFont(4)
        SetTextScale(0.35, 0.35)
        SetTextColour(255, 255, 255, 155)
        SetTextEntry("STRING")
        SetTextCentre(1)
        AddTextComponentString(text)
        DrawText(_x, _y)

        local factor = (string.len(text))/400
        DrawRect(_x, _y+0.0125, 0.01+factor, 0.03, 0, 0, 0, 80)
    end
end