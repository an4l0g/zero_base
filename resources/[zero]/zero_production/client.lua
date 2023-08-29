sProduction = Tunnel.getInterface('zero_production')

nearbyProduction = nil

openProduction = function(products, title, org)
    SetNuiFocus(true, true)
    SendNUIMessage({
        action = 'open',
        title = title,
        org = org,
        products = products
    })
end

RegisterNuiCallback('close', function()
    SetNuiFocus(false, false)
end)

RegisterNuiCallback('production', function(data)
    if sProduction.validateProduction(data.index, data.amount, data.org) then 
        local cfg = configs.productions[data.org]
        local product = configs.productions[data.org].products[data.index]
        local delay = product.delay
        local amount = data.amount

        print(json.encode(cfg), cfg.buff)

        if cfg.buff then
            amount = amount * 2
        end

        TriggerEvent('blockPed', true)
        zero.playAnim(false, {{'amb@prop_human_parking_meter@female@idle_a', 'idle_a_female'}}, true)
        TriggerEvent('progressBar', 'Produzindo/comprando...', delay)
        Wait(delay)
        TriggerEvent('blockPed', false)
        ClearPedTasks(PlayerPedId())
        sProduction.giveItem(data.index, amount, data.org)
    else
        TriggerEvent("notify", 'Produção', 'Você não possui material suficiente!')
    end
end)

TextFloating = function(text, coord)
    AddTextEntry('FloatingHelpText', text)
    SetFloatingHelpTextWorldPosition(0, coord)
    SetFloatingHelpTextStyle(0, true, 2, -1, 3, 0)
    BeginTextCommandDisplayHelp('FloatingHelpText')
    EndTextCommandDisplayHelp(1, false, false, -1)
end

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
                local _config = configs.productions[index]
                if _config.type == 'shop' or _config.type == 'sellDrugs' then
                    TextFloating('~b~[E]~w~ - Negociar', _config.coords)
                else
                    TextFloating('~b~[E]~w~ - Produzir', _config.coords)
                end
                if (IsControlJustPressed(0, 38) and GetEntityHealth(ped) > 100 and not IsPedInAnyVehicle(ped)) then
                    if (sProduction.hasPermission(_config.permission)) then
                        if (_config.type == 'moneyLaundry') then
                            sProduction.moneyLaundry()
                        end

                        if (_config.type == 'production') then
                            openProduction(_config.products, _config.label, index)
                        end

                        if (_config.type == 'sellDrugs') then
                            sProduction.openSellDrugs()
                        end
                    else
                        if _config.type == 'shop' then
                            TriggerEvent('notify', 'Negociação', 'Você não pode negociar aqui!')
                        else
                            TriggerEvent('notify', 'Produção', 'Você não pode produzir aqui!')
                        end
                    end
                end
            end
            Citizen.Wait(1)
        end
        _markerThread = false
    end)
end

Citizen.CreateThread(function()
    while (true) do
        local ped = PlayerPedId()
        local pCoord = GetEntityCoords(ped)
        nearestBlips = {}
        for k, v in pairs(configs.productions) do
            local distance = #(pCoord - v.coords)
            if (distance <= configs.blipDistance) then
                nearestBlips[k] = distance
            end
        end
        if (countTable(nearestBlips) > 0) then markerThread(); end;
        Citizen.Wait(1000)
    end
end)
