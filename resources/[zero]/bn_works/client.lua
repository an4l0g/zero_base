vSERVER = Tunnel.getInterface(GetCurrentResourceName())

works = config.works
locs = config.locs
lang = config.lang
productions = config.locProduction
product = config.production

inWork = false
selection = 0

Citizen.CreateThread(function()
    addBlips()
    while true do
        local idle = 1000
        local ped = PlayerPedId()
        if not (inWork) then
            for _, value in pairs(locs) do
                local distance = #(GetEntityCoords(ped) - value['coord'])
                if distance <= 3 then
                    idle = 4
                    Text3D(value['coord'], '~g~E~w~ - INICIAR EMPREGO', 400)
                    if distance <= 1.2 and IsControlJustPressed(0, 38) and GetEntityHealth(ped) > 101 and not IsPedInAnyVehicle(ped) then
                        SetNuiFocus(true, true)
                        SendNUIMessage({
                            action = 'open',
                            work = works[value['work']]['name'],
                            payment = 'R$'..works[value['work']]['payment']['money']['min']..'/R$'..works[value['work']]['payment']['money']['max'],
                            routes = #works[value['work']]['routes'],
                            image = value['url'],
                            job = value['work']
                        })
                    end
                end
            end
        end
        Citizen.Wait(idle)
    end
end)

startWork = function(work)
    Wait(100)
    inWork = true
    selection = 1
    SendNUIMessage({ action = 'inWork', show = true })
    TriggerEvent('Notify', 'sucesso', lang[work]['startWorking'](work))

    local config = works[work]
    local task = false
    createBlip(config['routes'], selection)
    Citizen.CreateThread(function()
        while (inWork) do
            local idle = 1000
            local ped = PlayerPedId()
            local distance = #(GetEntityCoords(ped) - config['routes'][selection])
            if distance <= 30 then
                idle = 4
                Text3D(config['routes'][selection], config['text'], 400)
                if distance <= 1.2 and IsControlJustPressed(0, 38) and GetEntityHealth(ped) > 101 and checkVehicleFunctions(ped, config) and not task then
                    RemoveBlip(blips)
                    task = true
                    if (lastVehicleModel(GetPlayersLastVehicle(), config['vehicle'])) then
                        if (vSERVER.checkItem(config['requireItem'])) then
                            TriggerEvent('cancelando', true)

                            if (config['anim']) then
                                ExecuteCommand('e '..config['anim'])
                            end

                            if (config['blipWithCar']) then
                                SetEntityCoords(GetVehiclePedIsIn(ped), config['routes'][selection])
                                Wait(1000)
                                FreezeEntityPosition(GetVehiclePedIsIn(ped), true)
                            else
                                SetEntityCoords(ped, config['routes'][selection])
                                Wait(1000)
                                FreezeEntityPosition(ped, true)
                            end

                            TriggerEvent('progress', parseInt(config['setTimeOut']/1000), lang[work]['progressBar'])
                            Citizen.SetTimeout(config['setTimeOut'], function()
                                TriggerEvent('cancelando', false)
                                if (config['blipWithCar']) then
                                    FreezeEntityPosition(GetVehiclePedIsIn(ped), false)
                                else
                                    FreezeEntityPosition(ped, false)
                                end

                                vSERVER.givePayment(config['routes'][selection], config['payment'], config['name'], selection)
                                vRP.DeletarObjeto()
                                ClearPedTasks(ped)

                                selection = selection + 1
                                if (selection > #config['routes']) then
                                    selection = 1 
                                    TriggerEvent('Notify', 'aviso', lang[work]['resetRoutes'])
                                end
                                Wait(500)
                                task = false
                                TriggerEvent('Notify', 'aviso', lang[work]['newRoute'], 8000)
                                createBlip(config['routes'], selection)
                            end)
                        else
                            stopWork(config['name'], lang[work]['backBusiness'](config['name']))
                        end
                    else
                        TriggerEvent('Notify', 'aviso', lang[work]['noVehicleBusiness'](config['name']))
                        stopWork(config['name'], lang[work]['backBusinessVehicle'](config['name']))
                    end
                end
            end
            Citizen.Wait(idle)
        end
    end)

    Citizen.CreateThread(function()
        while (inWork) do
            if (IsControlJustPressed(0, 168)) then
                stopWork(config['name'], lang[work]['stopWork'](config['name']))
            end
            Citizen.Wait(5)
        end
    end)

    Citizen.CreateThread(function()
        while (inWork) do
            local idle = 1000
            local ped = PlayerPedId()
            for _, value in pairs(productions[work]) do
                local distance = #(GetEntityCoords(ped) - value['coord'].xyz)
                if distance <= 1.5 then
                    idle = 4
                    Text3D(value['coord'].xyz, '~g~E~w~ - '..product[value['config']]['blipText'], 400)
                    if distance <= 1.2 and IsControlJustPressed(0, 38) and GetEntityHealth(ped) > 101 and not task and not IsPedInAnyVehicle(ped) then
                        task = true
                        if vSERVER.checkItem(product[value['config']]['requireItems'], true) then
                            SetEntityCoords(ped, value['coord'].xyz)
                            SetEntityHeading(ped, value['coord'].w)
                            Wait(1000)
                            if (product[value['config']]['anim']) then
                                ExecuteCommand('e '..product[value['config']]['anim'])
                            end

                            TriggerEvent('cancelando', true)
                            FreezeEntityPosition(ped, true)
                            TriggerEvent('progress', product[value['config']]['duration'], product[value['config']]['progressBarText'])
                            Citizen.SetTimeout(product[value['config']]['duration'] * 1000, function()
                                task = false
                                TriggerEvent('cancelando', false)
                                FreezeEntityPosition(ped, false)
                                vSERVER.giveItem(product[value['config']]['receiveItems'])
                                ClearPedTasks(ped)
                            end)
                        else
                            task = false
                        end
                    end
                end
            end
            Citizen.Wait(idle)
        end
    end)
end

RegisterNUICallback('startJob', function(data, cb)
    SetNuiFocus(false, false)
    startWork(data['works'])
end)

RegisterNUICallback('close', function()
    SetNuiFocus(false, false)
end)