vSERVER = Tunnel.getInterface(GetCurrentResourceName())

inWork = false
selection = 0

local jobs
local createJobs = function()
    if (not jobs) then
        jobs = {}
        for k, v in ipairs(list) do
            local cfg = works[v.work]
            table.insert(jobs, {
                business = cfg.name,
                name = v.work,
                price = 'R$'..cfg.payment.money.min..'/'..cfg.payment.money.max,
                routes = #cfg.routes,
                description = cfg.description,
                url = v.url
            })
        end
    end
    return jobs
end

local _coord = config.agency
Citizen.CreateThread(function()
    while (true) do
        local _idle = 1000
        if (not inWork) then
            local ped = PlayerPedId()
            local distance = #(GetEntityCoords(ped) - _coord)
            if (distance <= 5.0) then
                _idle = 1
                DrawMarker(1, _coord.x, _coord.y, _coord.z-0.97, 0, 0, 0, 0, 0, 0, 0.6, 0.6, 0.4, 0, 153, 255, 155, 0, 0, 0, 1)
                if (distance <= 1.2 and IsControlJustPressed(0, 38) and GetEntityHealth(ped) > 100 and not IsPedInAnyVehicle(ped)) then
                    local list = createJobs()
                    TriggerEvent('zero_hud:toggleHud', false)
                    SetNuiFocus(true, false)
                    SendNUIMessage({
                        action = 'open',
                        jobs = list
                    })
                end
            end
        end
        Citizen.Wait(_idle)
    end
end)

local _tempCam;
createCam = function(coords, rotX, rotY, rotZ)
    TriggerEvent('zero_hud:toggleHud', false)
    Citizen.Wait(1000)
    DoScreenFadeOut(500)
    Citizen.Wait(500)
    if (not DoesCamExist(_tempCam)) then 
        _tempCam = CreateCam('DEFAULT_SCRIPTED_CAMERA', true)  
    end
    SetCamCoord(_tempCam, coords)
    SetCamRot(_tempCam, rotX, rotY, rotZ, 2)
    SetCamActive(_tempCam, true)
    RenderScriptCams(true, true, 0, true, true)
    DoScreenFadeIn(500)
end

destroyCam = function()
    Citizen.Wait(1000)
    DoScreenFadeOut(500)
    Citizen.Wait(500)
    RenderScriptCams(false, false, 0, true, false)
    DestroyCam(_tempCam, false)
    _tempCam = nil
    DoScreenFadeIn(500)
    TriggerEvent('zero_hud:toggleHud', true)
end

_stage = 0
task = false

startJob = function(work)
    inWork = true
    _config = works[work]
    TriggerEvent('notify', 'Emprego', lang[work].startJob(work))

    local ped = PlayerPedId()
    local pCoord = GetEntityCoords(ped)
    Citizen.CreateThread(function()
        _stage = 1
        createBlip(_config.coords.start)
        while (_stage == 1) do
            ped = PlayerPedId()
            pCoord = GetEntityCoords(ped)

            Text2D(0, 0.43, 0.95, 'Vá até o local da ~f~Empresa~w~', 0.4)
            local distance = #(pCoord - _config.coords.start)
            if (distance <= 10.0) then
                DrawMarker(1, _config.coords.start.x, _config.coords.start.y, _config.coords.start.z-0.97, 0, 0, 0, 0, 0, 0, 0.6, 0.6, 0.4, 0, 153, 255, 155, 0, 0, 0, 1)
                if (distance <= 1.2 and not IsPedInAnyVehicle(ped)) then 
                    PlaySoundFrontend(-1, 'CONFIRM_BEEP', 'HUD_MINI_GAME_SOUNDSET', 1)
                    _stage = 2
                    secondStage()
                end
            end
            Citizen.Wait(1)
        end
    end)

    Citizen.CreateThread(function()
        while (inWork) do
            if (IsControlJustPressed(0, 168)) then
                stopWork(lang[work]['stopWork'](_config.name))
            end
            Citizen.Wait(1)
        end
    end)
    
    local nearestBlips = {}

    local _markerThread = false
    local productionThread = function()
        if (_markerThread) then return; end;
        _markerThread = true
        Citizen.CreateThread(function()
            while (countTable(nearestBlips) > 0) do
                local _cache = nearestBlips
                for index, dist in pairs(_cache) do
                    local configProductions = productions[work][index]
                    if (dist <= 2.0) then
                        local _coord = vector3(configProductions.coord.x, configProductions.coord.y, configProductions.coord.z)
                        TextFloating('Pressione E para '..product[configProductions.config].blipText, _coord)
                        if (dist <= 1.2 and IsControlJustPressed(0, 38) and GetEntityHealth(ped) > 100 and not IsPedInAnyVehicle(ped) and not task) then
                            _functionProduction(configProductions)
                        end
                    end
                end
                Citizen.Wait(1)
            end
        end)
    end

    secondStage = function()
        RemoveBlip(blips)
        createCam(_config.cams[1][1], _config.cams[1][2], _config.cams[1][3], _config.cams[1][4])
        PlaySoundFrontend(-1, 'Hack_Success', 'DLC_HEIST_BIOLAB_PREP_HACKING_SOUNDS', false)
        ShowAdvancedNotification('CHAR_ANTONIA', 'Antonia', _config.name, lang[work].jobStage(work))
        Citizen.Wait(10000)
        destroyCam()

        createCam(_config.cams[2][1], _config.cams[2][2], _config.cams[2][3], _config.cams[2][4])
        PlaySoundFrontend(-1, 'Hack_Success', 'DLC_HEIST_BIOLAB_PREP_HACKING_SOUNDS', false)
        ShowAdvancedNotification('CHAR_ANTONIA', 'Antonia', _config.name, lang[work].jobStart(work))
        Citizen.Wait(10000)
        destroyCam()

        if (productions[work]) then
            Citizen.CreateThread(function()
                while (_stage == 2) do
                    ped = PlayerPedId()
                    pCoord = GetEntityCoords(ped)
                    for k, v in pairs(productions[work]) do
                        local distance = #(pCoord - v.coord.xyz)
                        if (distance <= 5.0) then
                            nearestBlips[k] = distance
                        end
                    end
                    if (countTable(nearestBlips) > 0) then productionThread(); end;
                    Citizen.Wait(500)
                end
            end)
        end

        Citizen.CreateThread(function()
            while (_stage == 2) do
                if (not productions[work]) then
                    ped = PlayerPedId()
                    pCoord = GetEntityCoords(ped)
                end
                
                local _idle = 1000
                local distance = #(pCoord - _config.coords.route)
                if (distance <= 3.0) then
                    _idle = 1
                    DrawMarker(1, _config.coords.route.x, _config.coords.route.y, _config.coords.route.z-0.97, 0, 0, 0, 0, 0, 0, 0.6, 0.6, 0.4, 0, 153, 255, 155, 0, 0, 0, 1)
                    if (distance <= 1.2 and IsControlJustPressed(0, 38) and GetEntityHealth(ped) > 100 and not IsPedInAnyVehicle(ped)) then
                        _startWork()
                    end
                end
                Citizen.Wait(_idle)
            end
        end)
    end

    _startWork = function()
        _stage = 0
        selection = 1
        TriggerEvent('notify', 'Emprego', lang[work]['startRoute'](work))
        createBlip(_config.routes, selection, true)
        while (inWork) do
            ped = PlayerPedId()
            pCoord = GetEntityCoords(ped)

            local _idle = 1000 
            local distance = #(pCoord - _config.routes[selection])
            if (distance <= 5.0) then
                _idle = 1
                TextFloating('Pressione E para '.._config.text, _config.routes[selection])
                if (distance <= 1.2 and IsControlJustPressed(0, 38) and GetEntityHealth(ped) > 100 and checkVehicleFunctions(ped, config) and not task) then
                    RemoveBlip(blips)
                    task = true
                    if (lastVehicleModel(GetPlayersLastVehicle(), _config.vehicle)) then
                        if (vSERVER.checkItem(_config.requireItem)) then
                            LocalPlayer.state.BlockTasks = true

                            if (_config.anim) then ExecuteCommand('e '.._config.anim); end;

                            if (_config.blipWithCar) then
                                SetEntityCoords(GetVehiclePedIsIn(ped), _config.routes[selection])
                                Wait(1000)
                                FreezeEntityPosition(GetVehiclePedIsIn(ped), true)
                            else
                                SetEntityCoords(ped, _config.routes[selection])
                                Wait(1000)
                                FreezeEntityPosition(ped, true)
                            end

                            TriggerEvent('progress', lang[work]['progressBar'], _config.setTimeOut)
                            Citizen.SetTimeout(_config.setTimeOut, function()
                                LocalPlayer.state.BlockTasks = false
                                if (_config.blipWithCar) then
                                    FreezeEntityPosition(GetVehiclePedIsIn(ped), false)
                                else
                                    FreezeEntityPosition(ped, false)
                                end

                                vSERVER.givePayment(_config.routes[selection], _config.payment, _config.name, selection)
                                zero.DeletarObjeto()
                                ClearPedTasks(ped)

                                selection = selection + 1
                                if (selection > #_config.routes) then
                                    selection = 1 
                                    TriggerEvent('notify', 'Emprego', lang[work]['resetRoutes'])
                                end
                                Citizen.Wait(500)
                                task = false
                                TriggerEvent('notify', 'Emprego', lang[work]['newRoute'], 8000)
                                createBlip(_config.routes, selection, true)
                            end)
                        else
                            stopWork(_config.name, lang[work]['backBusiness'](_config.name))
                        end
                    else
                        TriggerEvent('notify', 'Emprego', lang[work]['noVehicleBusiness'](_config.name))
                        stopWork(_config.name, lang[work]['backBusinessVehicle'](_config.name))
                    end
                end
            end
            Citizen.Wait(_idle)
        end
    end

    _functionProduction = function(_production)
        task = true
        if (vSERVER.checkItem(product[_production['config']]['requireItems'], true)) then
            SetEntityCoords(ped, _production['coord'].xyz)
            SetEntityHeading(ped, _production['coord'].w)
            Citizen.Wait(1000)

            if (product[_production['config']]['anim']) then
                ExecuteCommand('e '..product[_production['config']]['anim'])
            end

            LocalPlayer.state.BlockTasks = true
            FreezeEntityPosition(ped, true)
            TriggerEvent('progressBar', product[_production['config']]['progressBarText'], product[_production['config']]['duration'])
            Citizen.SetTimeout(product[_production['config']]['duration'], function()
                task = false
                LocalPlayer.state.BlockTasks = false
                FreezeEntityPosition(ped, false)
                vSERVER.giveItem(product[_production['config']]['receiveItems'])
                ClearPedTasks(ped)
            end)
        else
            task = false
        end
    end
end

ShowAdvancedNotification = function(icon, sender, title, text)
    SetNotificationTextEntry('STRING')
    AddTextComponentString(text)
    SetNotificationMessage(icon, icon, true, 4, sender, title, text)
    DrawNotification(false, true)
end

RegisterNUICallback('startJob', function(data, cb)
    SetNuiFocus(false, false)
    startJob(data['works'])
end)

RegisterNUICallback('close', function()
    TriggerEvent('zero_hud:toggleHud', true)
    SetNuiFocus(false, false)
end)