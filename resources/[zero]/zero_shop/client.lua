vSERVER = Tunnel.getInterface(GetCurrentResourceName())

local configShops = config.shops
local configGeneral = config.general

local nearestBlips = {}

local _markerThread = false
local markerThread = function()
    if (_markerThread) then return; end;
    _markerThread = true
    Citizen.CreateThread(function()
        while (countTable(nearestBlips) > 0) do
            local ped = PlayerPedId()
            local _cache = nearestBlips
            for index, dist in pairs(_cache) do
                if (dist <= 2) then
                    local coord = configShops[index].coord
                    DrawMarker(29, coord.x, coord.y, coord.z, 0, 0, 0, 0, 0, 0, 1.0, 1.0, 1.0, 0, 153, 255, 155, 1, 0, 0, 1)
                    if (dist <= 0.5 and IsControlJustPressed(0, 38) and GetEntityHealth(ped) > 101 and not IsPedInAnyVehicle(ped)) then
                        openShop(index)
                    end
                end
            end
            Citizen.Wait(5)
        end
        _markerThread = false
    end)
end

Citizen.CreateThread(function()
    while (true) do
        local ped = PlayerPedId()
        local pCoord = GetEntityCoords(ped)
        nearestBlips = {}
        for k, v in pairs(configShops) do
            local distance = #(pCoord - v.coord)
            if (distance <= 2) then
                nearestBlips[k] = distance
            end
        end
        if (countTable(nearestBlips) > 0) then markerThread(); end;
        Citizen.Wait(500)
    end
end)

local _index;
openShop = function(index)
    _index = index
    local _list = configGeneral[configShops[index].config]
    local _config = configShops[index]

    SetNuiFocus(true, true)
    SendNUIMessage({
        action = 'open',
        list = _list,
        shopMode = _config.type,
        shopName = _config.name,
        shopIdentity = vSERVER.getUserIdentity()
    })
end

RegisterNUICallback('buy', function(data, cb)
    local carrinho = data.cart
    if (carrinho) then
        local convert = {}
        for k, v in pairs(carrinho) do
            if (k and v ~= nil) then convert[k] = { amount = v }; end;
        end
        vSERVER.shopTransaction(convert, data.method, _index)
    end
    _index = nil
end)

RegisterNUICallback('close', function()
    SetNuiFocus(false, false)
end)