Tunnel = module('zero', 'lib/Tunnel')
Proxy = module('zero', 'lib/Proxy')
zero = Proxy.getInterface('zero')

list = config.list
works = config.works
lang = config.lang
productions = config.locProduction
product = config.production

if IsDuplicityVersion() then
    onPayment = function(user_id, givedMoney, blip_coord, payment_config, job_name, blip_step)
        -- if exports['gb_gamepass']:checkPass(user_id) then 
        --     exports['gb_gamepass']:GivePassXP(user_id, 20) 
        -- end
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
            if (IsVehicleModel(_lastVehicle, GetHashKey(vehicle))) then
                return true
            end
            return false
        end
        return true
    end

    blips = false
    createBlip = function(routes, selection, route)
        blips = AddBlipForCoord((selection and routes[selection] or routes))
        SetBlipSprite(blips, 1)
        SetBlipColour(blips, 38)
        SetBlipScale(blips, 0.5)
        SetBlipAsShortRange(blips, false)
        SetBlipRoute(blips, true)
        BeginTextCommandSetBlipName('STRING')
        AddTextComponentString((route and 'Entregar a encomenda' or 'Empresa'))
        EndTextCommandSetBlipName(blips)
    end

    stopWork = function(text)
        TriggerEvent('notify', 'Emprego', text) 
        Citizen.SetTimeout(500, function()
            if (DoesBlipExist(blips)) then 
                RemoveBlip(blips) 
            end
            selection = 0
            inWork = false
            task = false
            _stage = 0
        end)
    end

    TextFloating = function(text, coord)
        AddTextEntry('FloatingHelpText', text)
        SetFloatingHelpTextWorldPosition(0, coord)
        SetFloatingHelpTextStyle(0, true, 2, -1, 3, 0)
        BeginTextCommandDisplayHelp('FloatingHelpText')
        EndTextCommandDisplayHelp(1, false, false, -1)
    end

    Text2D = function(font, x, y, text, scale)
        SetTextFont(font)
        SetTextProportional(7)
        SetTextScale(scale, scale)
        SetTextColour(255, 255, 255, 255)
        SetTextDropShadow(0, 0, 0, 0,255)
        SetTextEdge(4, 0, 0, 0, 255)
        SetTextEntry("STRING")
        AddTextComponentString(text)
        DrawText(x, y)
    end
end