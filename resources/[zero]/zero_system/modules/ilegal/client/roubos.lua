local cli = {}
Tunnel.bindInterface('Robberys', cli)
local vSERVER = Tunnel.getInterface('Robberys')

local inRobbery = false
local seconds = 0
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
                local _config = Robberys.locations[index]
                if (not inRobbery) then
                    TextFloating('~b~E~w~ - Roubar', _config.coord.xyz)
                else
                    local text = (seconds > 1 and 'Aguarde ~b~'..seconds..'~w~ segundos\n\nPressione ~b~M~w~ para cancelar' or 'Finalizando o ~b~roubo~w~...')
                    TextFloating(text, _config.coord.xyz)
                end
                if (dist <= 1.2 and IsControlJustPressed(0, 38) and GetEntityHealth(ped) > 100 and not IsPedInAnyVehicle(ped)) then
                    vSERVER.checkRobbery(index)
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
        for k, v in pairs(Robberys.locations) do
            local distance = #(pCoord - v.coord.xyz)
            if (distance <= 2) then
                nearestBlips[k] = distance
            end
        end
        if (countTable(nearestBlips) > 0) then markerThread(); end;
        Citizen.Wait(1000)
    end
end)

cli.startRobbery = function(robbery, location)
    local ped = PlayerPedId()

    inRobbery = true
    LocalPlayer.state.BlockTasks = true
    SetCurrentPedWeapon(ped, GetHashKey('WEAPON_UNARMED'), true)
    startRobbery(robbery.seconds, location.name)
    SetEntityHeading(ped, location.coord.w)
    SetEntityCoords(ped, location.coord.xyz)
    Citizen.Wait(500)
    FreezeEntityPosition(ped, true)
    SetPedComponentVariation(ped, 5, 45, 0, 2)
    zero._playAnim(false, {{ 'anim@heists@ornate_bank@grab_cash_heels','grab' }}, true)
end

local blips = {}

startRobbery = function(time, name)
    Citizen.CreateThread(function()
        seconds = time
        while (seconds > 0) do
            Citizen.Wait(1000)
            seconds = (seconds - 1)
            vSERVER.robberyPayment(time)
        end
        seconds = 0
        inRobbery = false
        LocalPlayer.state.BlockTasks = false
        FreezeEntityPosition(PlayerPedId(), false)
        ClearPedTasks(PlayerPedId())
    end)

    Citizen.CreateThread(function()
        while (seconds > 0) do
            local ped = PlayerPedId()
            if (IsPedInAnyVehicle(ped)) or IsControlJustPressed(0, 244) or GetEntityHealth(ped) <= 100 then
                seconds = 0
                inRobbery = false
                LocalPlayer.state.BlockTasks = false
                ClearPedTasks(ped)
                FreezeEntityPosition(ped, false)
                vSERVER.cancelRobbery(name)
            end
            Citizen.Wait(5)
        end
    end)
end

RegisterNetEvent('zero_robberys:Blip', function(coord, name)
    blips[name] = AddBlipForCoord(coord)
    SetBlipSprite(blips[name], 161)
    SetBlipAsShortRange(blips[name], true)
    SetBlipColour(blips[name], 1)
    SetBlipScale(blips[name], 0.3)
    BeginTextCommandSetBlipName('STRING')
    AddTextComponentString('Roubo ao(a): '..name)
    EndTextCommandSetBlipName(blips[name])
    Citizen.SetTimeout(60000, function()
        if (DoesBlipExist(blips[name])) then
            RemoveBlip(blips[name])
            blips[name] = nil
        end
    end)
end)