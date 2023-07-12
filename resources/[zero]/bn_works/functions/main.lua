Tunnel = module('vrp', 'lib/Tunnel')
Proxy = module('vrp', 'lib/Proxy')
vRP = Proxy.getInterface('vRP')

if IsDuplicityVersion() then
    onPayment = function(user_id, givedMoney, blip_coord, payment_config, job_name, blip_step)
        if exports['gb_gamepass']:checkPass(user_id) then 
            exports['gb_gamepass']:GivePassXP(user_id, 20) 
        end
    end
else
    checkVehicleFunctions = function(ped, config)
        if (config['blipWithCar']) then
            return IsPedInAnyVehicle(ped)
        end
        return not IsPedInAnyVehicle(ped)
    end

    lastVehicleModel = function(_lastVehicle, vehicle)
        if (vehicle) then
            if IsVehicleModel(_lastVehicle, GetHashKey(vehicle)) then
                return true
            end
            return false
        end
        return true
    end

    blips = false
    createBlip = function(routes, selection)
        blips = AddBlipForCoord(routes[selection])
        SetBlipSprite(blips, 1)
        SetBlipColour(blips, 43)
        SetBlipScale(blips, 0.5)
        SetBlipAsShortRange(blips, false)
        SetBlipRoute(blips, true)
        BeginTextCommandSetBlipName('STRING')
        AddTextComponentString('Entregar a encomenda')
        EndTextCommandSetBlipName(blips)
    end

    addBlips = function()
        for _, value in pairs(config.locs) do
            local blip = AddBlipForCoord(value['coord'])
            SetBlipSprite(blip, 457)
            SetBlipAsShortRange(blip, true)
            SetBlipColour(blip, 3)
            SetBlipScale(blip, 0.7)
            BeginTextCommandSetBlipName('STRING')
            AddTextComponentString('Emprego | '..value['work'])
            EndTextCommandSetBlipName(blip)
        end
    end

    stopWork = function(work, text)
        RemoveBlip(blips)
        Wait(500)
        selection = 0
        inWork = false
        task = false
        SendNUIMessage({ action = 'inWork', show = false })
        TriggerEvent('Notify', 'aviso', text) 
    end

    Text3D = function(coords, text, size)
        local onScreen,_x,_y = World3dToScreen2d(coords.x, coords.y, coords.z)
        SetTextFont(4)
        SetTextScale(0.35,0.35)
        SetTextColour(255,255,255,155)
        SetTextEntry('STRING')
        SetTextCentre(1)
        AddTextComponentString(text)
        DrawText(_x,_y)
        local factor = (string.len(text))/size
        DrawRect(_x,_y+0.0125,0.01+factor,0.03,0,0,0,80)
    end
end