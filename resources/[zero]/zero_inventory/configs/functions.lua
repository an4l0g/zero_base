config.functions = {
    clientNotify = function(title, msg, time)
        TriggerEvent(
            'notify',
            title,
            msg,
            time
        )
    end,
    serverNotify = function(source, title, msg, time)
        local _source = source 
        TriggerClientEvent(
            'notify',
            _source,
            title,
            msg,
            time
        )
    end,
    getVehOwnerId = function(vnetid)
        local data = exports["zGarages"]:getVehicleData(vnetid)
        if data then return data.user_id; end;
    end,
    isHandcuffed = function()
        return zero.isHandcuffed()
    end,
    getGloveSize = function(vname)
        return zero.vehicleGlove(vname)
    end,
}