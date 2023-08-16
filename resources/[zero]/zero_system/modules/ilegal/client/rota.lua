local vSERVER = Tunnel.getInterface('Routes')

local inRoute = false
local nearestBlips = {}

local _markerThread = false
local markerThread = function()
    if (_markerThread) then return; end;
    _markerThread = true
    Citizen.CreateThread(function()
        while (countTable(nearestBlips) > 0) do
            local ped = PlayerPedId()
            local _cache = nearestBlips
            if (not inRoute) then
                for index, dist in pairs(_cache) do
                    local coord = Routes.locations[index].coord
                    TextFloating('~b~E~w~ - Iniciar rota', coord)
                    if (dist <= 1.2 and IsControlJustPressed(0, 38) and GetEntityHealth(ped) > 100 and not IsPedInAnyVehicle(ped)) then
                        if (vSERVER.checkRoutes(index)) then
                            startRoute(index)
                        end
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
        for k, v in pairs(Routes.locations) do
            local distance = #(pCoord - v.coord)
            if (distance <= 5) then
                nearestBlips[k] = distance
            end
        end
        if (countTable(nearestBlips) > 0) then markerThread(); end;
        Citizen.Wait(1000)
    end
end)

local selected = 0
local blip = nil
local action = false

startRoute = function(index)
    local _config = Routes.general[Routes.locations[index].config]

    inRoute = true
    selected = 1

    CreateBlip(_config.coords, selected)
    TriggerEvent('notify', 'Rotas', 'Você iniciou a sua rota de <b>'.._config.name..'</b>.<br>Todas as localizações já se encontram em seu <b>GPS</b>.')
    Citizen.CreateThread(function()
        while (inRoute) do
            local idle = 1000
            local ped = PlayerPedId()
            local pCoord = GetEntityCoords(ped)

            local coords = _config.coords[selected]
            local distance = #(pCoord - coords)
            if (distance <= 10 and not action) then
                idle = 5
                TextFloating(_config.texts.text, coords)
                if (distance <= 1.2 and IsControlJustPressed(0, 38) and GetEntityHealth(ped) > 100 and not IsPedInAnyVehicle(ped)) then
                    action = true
                    if (vSERVER.checkBackpack(_config.itens, _config.extras.drug)) then
                        RemoveBlip(blip)

                        if (_config.extras.police) then end;
                        if (_config.texts.progress) then TriggerEvent('progressBar', _config.texts.progress, _config.extras.timeout) end;
                        if (_config.extras.anim) then ExecuteCommand('e '.._config.extras.anim) end;

                        LocalPlayer.state.BlockTasks = true
                        FreezeEntityPosition(ped, true)
                        Citizen.SetTimeout(_config.extras.timeout, function()
                            LocalPlayer.state.BlockTasks = false
                            FreezeEntityPosition(ped, false)
                            ClearPedTasks(ped)
                            vSERVER.routePayment(coords, _config.itens, _config.extras.drug)

                            selected = (selected + 1)
                            if (selected > #coords) then selected = 1; end;

                            TriggerEvent('notify', 'Rotas', 'Olá, foi adicionada uma nova <b>localização</b> em seu <b>GPS</b>.')
                            CreateBlip(_config.coords, selected)
                            action = false
                        end)
                    else
                        RemoveBlip(blip)
                        
                        if (_config.extras.police) then end;

                        selected = (selected + 1)
                        if (selected > #coords) then selected = 1; end;
                        
                        TriggerEvent('notify', 'Rotas', 'Olá, foi adicionada uma nova <b>localização</b> em seu <b>GPS</b>.')
                        CreateBlip(_config.coords, selected)
                        action = false
                    end
                end
            end
            Citizen.Wait(idle)
        end
    end)

    Citizen.CreateThread(function()
        while (inRoute and GetEntityHealth(PlayerPedId()) > 100) do
            Text2D(0, 0.42, 0.95, '~b~F7~w~ PARA CANCELAR A ~b~ROTA~w~', 0.4)
            if (IsControlJustPressed(0, 168)) then
                inRoute = false
                TriggerEvent('notify', 'Rotas', 'Você finalizou a sua rota de <b>'.._config.name..'</b>. Todas as localizações marcadas foram retiradas de seu <b>GPS</b>.')
            end
            Citizen.Wait(5)
        end
        selected = 0
        blip = nil
    end)
end

CreateBlip = function(coord, selected)
    blip = AddBlipForCoord(coord[selected])
    SetBlipSprite(blip, 478)
    SetBlipColour(blip, 74)
    SetBlipScale(blip, 0.5)
    SetBlipAsShortRange(blip, true)
    SetBlipRoute(blip, true)
    BeginTextCommandSetBlipName('STRING')
    AddTextComponentString('Entrega')
    EndTextCommandSetBlipName(blip)
end