local cli = {}
Tunnel.bindInterface('Dismantle', cli)
local vSERVER = Tunnel.getInterface('Dismantle')

local inDismantle = false
local nearestBlips = {}

local _markerThread = false
local markerThread = function()
    if (_markerThread) then return; end;
    _markerThread = true
    Citizen.CreateThread(function()
        while (countTable(nearestBlips) > 0) do
            local ped = PlayerPedId()
            local _cache = nearestBlips
            if (IsPedInAnyVehicle(ped) and not inDismantle) then
                for index, dist in pairs(_cache) do
                    local coord = Dismantle[index].coord
                    DrawMarker(27, coord.x, coord.y, coord.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 5.0, 5.0, 5.0, 0, 153, 255, 155, 0, 0, 0, 1)
                    if (dist <= 5 and IsControlJustPressed(0, 38) and GetEntityHealth(ped) > 100) then
                        vSERVER.checkDismantle(index)  
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
        for k, v in pairs(Dismantle) do
            local distance = #(pCoord - v.coord)
            if (distance <= 10) then
                nearestBlips[k] = distance
            end
        end
        if (countTable(nearestBlips) > 0) then markerThread(); end;
        Citizen.Wait(1000)
    end
end)

local vehicleCache = {}

local parts = {
    ['door_dside_f'] = {
        type = 'door',
        id = 0,
        time = 10000,
        status = function(vehicle, id)
            return IsVehicleDoorDamaged(vehicle, id)
        end,
        action = function(vehicle, vehicletype, id, time, name, plate)
            LocalPlayer.state.BlockTasks = true
            propConsaw(true)
            SetVehicleDoorOpen(vehicle, id, false, false)

            Citizen.SetTimeout(time, function()
                TriggerServerEvent('syncVehicleDoorBroken', VehToNet(vehicle), id)
                LocalPlayer.state.BlockTasks = false
                propConsaw(false)
                return true
            end)
        end
    },
    ['door_pside_f'] = {
        type = 'door',
        id = 1,
        time = 10000,
        status = function(vehicle, id)
            return IsVehicleDoorDamaged(vehicle, id)
        end,
        action = function(vehicle, vehicletype, id, time, name, plate)
            LocalPlayer.state.BlockTasks = true
            propConsaw(true)
            SetVehicleDoorOpen(vehicle, id, false, false)

            Citizen.SetTimeout(time, function()
                TriggerServerEvent('syncVehicleDoorBroken', VehToNet(vehicle), id)
                LocalPlayer.state.BlockTasks = false
                propConsaw(false)
                return true
            end)
        end
    },
    ['door_dside_r'] = {
        type = 'door',
        id = 2,
        time = 10000,
        status = function(vehicle, id)
            return IsVehicleDoorDamaged(vehicle, id)
        end,
        action = function(vehicle, vehicletype, id, time, name, plate)
            LocalPlayer.state.BlockTasks = true
            propConsaw(true)
            SetVehicleDoorOpen(vehicle, id, false, false)

            Citizen.SetTimeout(time, function()
                TriggerServerEvent('syncVehicleDoorBroken', VehToNet(vehicle), id)
                LocalPlayer.state.BlockTasks = false
                propConsaw(false)
                return true
            end)
        end
    },
    ['door_pside_r'] = {
        type = 'door',
        id = 3,
        time = 10000,
        status = function(vehicle, id)
            return IsVehicleDoorDamaged(vehicle, id)
        end,
        action = function(vehicle, vehicletype, id, time, name, plate)
            LocalPlayer.state.BlockTasks = true
            propConsaw(true)
            SetVehicleDoorOpen(vehicle, id, false, false)

            Citizen.SetTimeout(time, function()
                TriggerServerEvent('syncVehicleDoorBroken', VehToNet(vehicle), id)
                LocalPlayer.state.BlockTasks = false
                propConsaw(false)
                return true
            end)
        end
    },
    ['bonnet'] = {
        type = 'door',
        id = 4,
        time = 10000,
        status = function(vehicle, id)
            return IsVehicleDoorDamaged(vehicle, id)
        end,
        action = function(vehicle, vehicletype, id, time, name, plate)
            LocalPlayer.state.BlockTasks = true
            propConsaw(true)
            SetVehicleDoorOpen(vehicle, id, false, false)

            Citizen.SetTimeout(time, function()
                TriggerServerEvent('syncVehicleDoorBroken', VehToNet(vehicle), id)
                LocalPlayer.state.BlockTasks = false
                propConsaw(false)
                return true
            end)
        end
    },
    ['wheel_lf'] = {
        type = 'tyre',
        id = 0,
        time = 10000,
        status = function(vehicle, id)
            return IsVehicleTyreBurst(vehicle, id, false)
        end,
        action = function(vehicle, vehicletype, id, time, name, plate)
            LocalPlayer.state.BlockTasks = true
            zero.playAnim(false, 
                { 'anim@amb@clubhouse@tutorial@bkr_tut_ig3@', 'machinic_loop_mechandplayer', 1 }, 
            false)
             
            Citizen.SetTimeout(time, function()
                TriggerServerEvent('syncVehicleTireBroken', VehToNet(vehicle), id, 'wheel_lf')
                LocalPlayer.state.BlockTasks = false
                zero.stopAnim(true)
                return true
            end)
        end
    },
    ['wheel_rf'] = {
        type = 'tyre',
        id = 1,
        time = 10000,
        status = function(vehicle, id)
            return IsVehicleTyreBurst(vehicle, id, false)
        end,
        action = function(vehicle, vehicletype, id, time, name, plate)
            LocalPlayer.state.BlockTasks = true
            zero.playAnim(false, 
                { 'anim@amb@clubhouse@tutorial@bkr_tut_ig3@', 'machinic_loop_mechandplayer', 1 }, 
            false)
             
            Citizen.SetTimeout(time, function()
                TriggerServerEvent('syncVehicleTireBroken', VehToNet(vehicle), id, 'wheel_rf')
                LocalPlayer.state.BlockTasks = false
                zero.stopAnim(true)
                return true
            end)
        end
    },
    ['wheel_lm1'] = {
        type = 'tyre',
        id = 2,
        time = 10000,
        status = function(vehicle, id)
            return IsVehicleTyreBurst(vehicle, id, false)
        end,
        action = function(vehicle, vehicletype, id, time, name, plate)
            LocalPlayer.state.BlockTasks = true
            zero.playAnim(false, 
                { 'anim@amb@clubhouse@tutorial@bkr_tut_ig3@', 'machinic_loop_mechandplayer', 1 }, 
            false)
             
            Citizen.SetTimeout(time, function()
                TriggerServerEvent('syncVehicleTireBroken', VehToNet(vehicle), id, 'wheel_lm1')
                LocalPlayer.state.BlockTasks = false
                zero.stopAnim(true)
                return true
            end)
        end
    },
    ['wheel_rm1'] = {
        type = 'tyre',
        id = 3,
        time = 10000,
        status = function(vehicle, id)
            return IsVehicleTyreBurst(vehicle, id, false)
        end,
        action = function(vehicle, vehicletype, id, time, name, plate)
            LocalPlayer.state.BlockTasks = true
            zero.playAnim(false, 
                { 'anim@amb@clubhouse@tutorial@bkr_tut_ig3@', 'machinic_loop_mechandplayer', 1 }, 
            false)
             
            Citizen.SetTimeout(time, function()
                TriggerServerEvent('syncVehicleTireBroken', VehToNet(vehicle), id, 'wheel_rm1')
                LocalPlayer.state.BlockTasks = false
                zero.stopAnim(true)
                return true
            end)
        end
    },
    ['wheel_lm2'] = {
        type = 'tyre',
        id = 45,
        time = 10000,
        status = function(vehicle, id)
            return IsVehicleTyreBurst(vehicle, id, false)
        end,
        action = function(vehicle, vehicletype, id, time, name, plate)
            LocalPlayer.state.BlockTasks = true
            zero.playAnim(false, 
                { 'anim@amb@clubhouse@tutorial@bkr_tut_ig3@', 'machinic_loop_mechandplayer', 1 }, 
            false)
             
            Citizen.SetTimeout(time, function()
                TriggerServerEvent('syncVehicleTireBroken', VehToNet(vehicle), id, 'wheel_lm2')
                LocalPlayer.state.BlockTasks = false
                zero.stopAnim(true)
                return true
            end)
        end
    },
    ['wheel_rm2'] = {
        type = 'tyre',
        id = 47,
        time = 10000,
        status = function(vehicle, id)
            return IsVehicleTyreBurst(vehicle, id, false)
        end,
        action = function(vehicle, vehicletype, id, time, name, plate)
            LocalPlayer.state.BlockTasks = true
            zero.playAnim(false, 
                { 'anim@amb@clubhouse@tutorial@bkr_tut_ig3@', 'machinic_loop_mechandplayer', 1 }, 
            false)
             
            Citizen.SetTimeout(time, function()
                TriggerServerEvent('syncVehicleTireBroken', VehToNet(vehicle), id, 'wheel_rm2')
                LocalPlayer.state.BlockTasks = false
                zero.stopAnim(true)
                return true
            end)
        end
    },
    ['wheel_lm3'] = {
        type = 'tyre',
        id = 46,
        time = 10000,
        status = function(vehicle, id)
            return IsVehicleTyreBurst(vehicle, id, false)
        end,
        action = function(vehicle, vehicletype, id, time, name, plate)
            LocalPlayer.state.BlockTasks = true
            zero.playAnim(false, 
                { 'anim@amb@clubhouse@tutorial@bkr_tut_ig3@', 'machinic_loop_mechandplayer', 1 }, 
            false)
             
            Citizen.SetTimeout(time, function()
                TriggerServerEvent('syncVehicleTireBroken', VehToNet(vehicle), id, 'wheel_lm3')
                LocalPlayer.state.BlockTasks = false
                zero.stopAnim(true)
                return true
            end)
        end
    },
    ['wheel_rm3'] = {
        type = 'tyre',
        id = 48,
        time = 10000,
        status = function(vehicle, id)
            return IsVehicleTyreBurst(vehicle, id, false)
        end,
        action = function(vehicle, vehicletype, id, time, name, plate)
            LocalPlayer.state.BlockTasks = true
            zero.playAnim(false, 
                { 'anim@amb@clubhouse@tutorial@bkr_tut_ig3@', 'machinic_loop_mechandplayer', 1 }, 
            false)
             
            Citizen.SetTimeout(time, function()
                TriggerServerEvent('syncVehicleTireBroken', VehToNet(vehicle), id, 'wheel_rm3')
                LocalPlayer.state.BlockTasks = false
                zero.stopAnim(true)
                return true
            end)
        end
    },
    ['wheel_lr'] = {
        type = 'tyre',
        id = 4,
        time = 10000,
        status = function(vehicle, id)
            return IsVehicleTyreBurst(vehicle, id, false)
        end,
        action = function(vehicle, vehicletype, id, time, name, plate)
            LocalPlayer.state.BlockTasks = true
            zero.playAnim(false, 
                { 'anim@amb@clubhouse@tutorial@bkr_tut_ig3@', 'machinic_loop_mechandplayer', 1 }, 
            false)
             
            Citizen.SetTimeout(time, function()
                TriggerServerEvent('syncVehicleTireBroken', VehToNet(vehicle), id, 'wheel_lr')
                LocalPlayer.state.BlockTasks = false
                zero.stopAnim(true)
                return true
            end)
        end
    },
    ['wheel_rr'] = {
        type = 'tyre',
        id = 5,
        time = 10000,
        status = function(vehicle, id)
            return IsVehicleTyreBurst(vehicle, id, false)
        end,
        action = function(vehicle, vehicletype, id, time, name, plate)
            LocalPlayer.state.BlockTasks = true
            zero.playAnim(false, 
                { 'anim@amb@clubhouse@tutorial@bkr_tut_ig3@', 'machinic_loop_mechandplayer', 1 }, 
            false)
             
            Citizen.SetTimeout(time, function()
                TriggerServerEvent('syncVehicleTireBroken', VehToNet(vehicle), id, 'wheel_rr')
                LocalPlayer.state.BlockTasks = false
                zero.stopAnim(true)
                return true
            end)
        end
    },
    ['engine'] = {
        type = 'part',
        id = 5,
        time = 10000,
        status = function(vehicle, id)
            local engine = GetVehicleEngineHealth(vehicle)            
            if (engine <= 200.0 )then
                return true
            end
            return false
        end,
        action = function(vehicle, vehicletype, id, time, name, plate)
            LocalPlayer.state.BlockTasks = true
            zero.playAnim(false, 
                { 'mini@repair', 'fixing_a_player', 1 }, 
            false)
            SetVehicleEngineOn(vehicle, false, true, true)
            SetVehicleEngineCanDegrade(vehicle, true)
            TriggerServerEvent('syncVehicleEngineBroken', VehToNet(vehicle))

            Citizen.SetTimeout(time, function()    
                LocalPlayer.state.BlockTasks = false
                zero.stopAnim(true)
                return true
            end)
        end
    }
}

local consaw_object = nil
local consaw_hash = GetHashKey('prop_tool_consaw')

propConsaw = function(use)
    local ped = PlayerPedId()
    if (use) then      
        if (consaw_object) then propConsaw(false); end;

        consaw_object = true
        FreezeEntityPosition(ped, true)

        RequestAnimDict('weapons@heavy@minigun')
        while (not HasAnimDictLoaded('weapons@heavy@minigun')) do
            Citizen.Wait(10)
        end
        TaskPlayAnim(ped, 'weapons@heavy@minigun', 'idle_2_aim_right_med', 1.0, -1, -1, 50, 0, 0, 0, 0)

        Citizen.CreateThread(function()
            while (consaw_object) do
                if (not IsEntityPlayingAnim(ped, 'weapons@heavy@minigun', 'idle_2_aim_right_med', 3)) then
                    TaskPlayAnim(ped, 'weapons@heavy@minigun', 'idle_2_aim_right_med', 1.0, -1, -1, 50, 0, 0, 0, 0)
                end
                Citizen.Wait(100)
            end
        end)

    else    
        consaw_object = nil
        ClearPedTasks(ped)
        FreezeEntityPosition(ped,false)
    end
end

cli.generateParts = function(vehicle, vtype, vname, vplate)
    local ped = PlayerPedId()
    if (vehicle and vtype) and DoesEntityExist(vehicle) then
        vehicleCache.vehicle = vehicle
        vehicleCache.parts = {}
        for k, v in pairs(parts) do
            local ebone = GetEntityBoneIndexByName(vehicle, k)
            if (ebone ~= -1 and ebone ~= 25 and not parts[k].status(vehicle, v.id)) then
                vehicleCache.parts[k] = {}
                vehicleCache.parts[k].vehicle = vehicle
                vehicleCache.parts[k].name = vname
                vehicleCache.parts[k].type = vtype
                vehicleCache.parts[k].id = v.id
                vehicleCache.parts[k].time = v.time
                vehicleCache.parts[k].plate = vplate
                vehicleCache.parts[k].destroy = parts[k].status(vehicle, v.id)
            end
        end
        print(json.encode(vehicleCache))
        FreezeEntityPosition(vehicle, true)
        startDismantle()
    end
end

startDismantle = function()
    Citizen.CreateThread(function()
        while (inDismantle) do
            local ped = PlayerPedId()
            local vehicle = vehicleCache.vehicle
            for k, v in pairs(vehicleCache.parts) do
                local new_vehicle = GetVehiclePedIsIn(ped, false)
                if (new_vehicle > 0 and new_vehicle ~= vehicle) or not in_range then
                    vehicleCache = {}
                    TriggerServerEvent('vrp_garages:delete', VehToNet(vehicle))
                end

                local pCoord = GetEntityCoords(ped)
                local doors = GetNumberOfVehicleDoors(vehicle)
                local ebone = GetEntityBoneIndexByName(vehicle, k)
                local cbone = GetWorldPositionOfEntityBone(vehicle, ebone)

                local distance = #(pCoord - cbone)
                if (distance <= 1.5 and (not parts[k].status(vehicle, v.id)) and (not vehicleCache.parts[k].destroy) and (not IsPedInVehicle(ped, vehicle, false))) then
                    
                end
            end
            Citizen.Wait(5)
        end
    end)
end

RegisterNetEvent('setVehicleDoorBroken', function(vehNet, id)
    if (NetworkDoesEntityExistWithNetworkId(vehNet)) then
        local vehicle = NetToVeh(vehNet)
        if (vehicle) and DoesEntityExist(vehicle) then
            SetVehicleDoorBroken(vehicle, id, false)
        end
    end
end)

RegisterNetEvent('setVehicleTireBroken', function(vehNet, id, bone)
    if (NetworkDoesEntityExistWithNetworkId(vehNet)) then
        local vehicle = NetToVeh(vehNet)
        if (vehicle) and DoesEntityExist(vehicle) then
            SetVehicleTyreBurst(vehicle, id, true, 1000.0)
            DecorSetFloat(vehicle, bone, 1000.0)
        end
    end
end)

RegisterNetEvent('setVehicleEngineBroken', function(vehNet, id, bone)
    if (NetworkDoesEntityExistWithNetworkId(vehNet)) then
        local vehicle = NetToVeh(vehNet)
        if (vehicle) and DoesEntityExist(vehicle) then
            SetVehicleEngineHealth(vehicle, value)
        end
    end
end)