cli = {}
Tunnel.bindInterface(GetCurrentResourceName(), cli)
vSERVER = Tunnel.getInterface(GetCurrentResourceName())

local inHome = false
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
                if (dist <= 5) then
                    local coord = configHomes[index].coord
                    DrawMarker(1, coord.x, coord.y, coord.z-0.97, 0, 0, 0, 0, 0, 0, 0.8, 0.8, 0.5, 0, 153, 255, 155, 0, 0, 0, 1)
                    if (dist <= 0.5 and IsControlJustPressed(0, 38) and GetEntityHealth(ped) > 101 and not IsPedInAnyVehicle(ped)) then
                        vSERVER.tryEnterHome(index)   
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
        for k, v in pairs(configHomes) do
            local distance = #(pCoord - v.coord)
            if (distance <= 5) then
                nearestBlips[k] = distance
            end
        end
        if (countTable(nearestBlips) > 0) then markerThread(); end;
        Citizen.Wait(500)
    end
end)

local tmpHomes = {
    homeName = '',
    internLocates = {},
    interiorId = 0,
    decorationsId = 0
}

loadInteriors = function(interior, decorations)
    tmpHomes.interiorId = (interior.interiorId or 0)
    if (tmpHomes.interiorId > 0) then SetInteriorActive(tmpHomes.interiorId, true); end;

    if (decorations) then
        if (decorations > 0) then
            local decorations = interior.decorations[decorations]
            tmpHomes.decorationsId = (decorations.interiorId or 0)
            if (tmpHomes.decorationsId > 0) then SetInteriorActive(tmpHomes.decorationsId, true); end;
            if (decorations.ipls) then
                for _, ipl in ipairs(decorations.ipls) do
                    if ipl:sub(1, 1) == '-' then
                        RemoveIpl(ipl:sub(2))
                    else    
                        RequestIpl(ipl)
                    end
                end
            end
        end
    end
end

unloadInteriors = function(interiorId, decorationsId)
    if (interiorId > 0) then SetInteriorActive(interiorId, false); interiorId = 0; end;
    if (decorationsId > 0) then SetInteriorActive(decorationsId, false); decorationsId = 0; end;
end

local _homes = {
    ['enter-mlo'] = function(interior, decorations, homeName)
        mloConfig = configHomes[homeName]
        tmpHomes.internLocates = {
            { mloConfig.door.x, mloConfig.door.y, mloConfig.door.z, 'exit' },
            { mloConfig.vault.x, mloConfig.vault.y, mloConfig.vault.z, 'vault' }
        }
    end,
    ['enter-other'] = function(interior, decorations, homeName)
        loadInteriors(interior, decorations)
        tmpHomes.internLocates = {
            { interior.door.x, interior.door.y, interior.door.z, 'exit' },
            { interior.vault.x, interior.vault.y, interior.vault.z, 'vault' }
        }
    end
}

cli.enterHome = function(interior, decorations, name)
    local ped = PlayerPedId()

    tmpHomes.homeName = name
    isMLO = (interior == 'mlo' and 'enter-mlo' or 'enter-other')
    interior = configInterior[interior]

    _homes[isMLO](interior, decorations, tmpHomes.homeName)
    vSERVER.setBucket(tmpHomes.homeName, true)

    DoScreenFadeOut(100)
    TriggerEvent('zero_sound:source', 'enterexithouse', 0.7)
    Citizen.Wait(500)
    FreezeEntityPosition(ped, true)
    SetEntityCoords(ped, vector3(tmpHomes.internLocates[1][1], tmpHomes.internLocates[1][2], tmpHomes.internLocates[1][3]))
    threadInHome(interior)
    Citizen.Wait(1000)
	FreezeEntityPosition(ped, false)
	DoScreenFadeIn(1000)
end

exitHome = function()
    inHome = false
    
    local ped = PlayerPedId()
    DoScreenFadeOut(100)
	Citizen.Wait(500)
    TriggerEvent('zero_sound:source', 'enterexithouse', 0.5)
    unloadInteriors(tmpHomes.interiorId, tmpHomes.decorationsId)
    vSERVER.setBucket(tmpHomes.homeName, false)

    tmpHomes = {
        homeName = '',
        internLocates = {},
        interiorId = 0,
        decorationsId = 0
    }

    FreezeEntityPosition(ped, true)
    vSERVER.cacheHomes()
	Citizen.Wait(2000)
	FreezeEntityPosition(ped, false)
	DoScreenFadeIn(1000)
end

cli.homeName = function() return tmpHomes.homeName; end;

threadInHome = function(interior)
    inHome = true
    if (interior) and interior.action then interior.action(); end;
    Citizen.CreateThread(function()
        while (inHome) do
            local idle = 1000
            local ped = PlayerPedId()
            local pCoord = GetEntityCoords(ped)
            if (inHome) then
                for k, v in pairs(tmpHomes.internLocates) do
                    local coord = vector3(v[1], v[2], v[3])
                    local distance = #(pCoord - coord)
                    if (distance <= 5.0) then
                        idle = 4
                        DrawMarker(0, coord.x, coord.y, coord.z, 0, 0, 0, 0, 0, 0, 0.3, 0.3, 0.3, 0, 153, 255, 155, 1, 0, 0, 1)
                        if (distance <= 1.2 and IsControlJustPressed(0, 38) and GetEntityHealth(ped) > 101) then
                            if (v[4] == 'exit') then
                                exitHome()
                            elseif (v[4] == 'vault') then
                                exports['zero_inventory']:openInventory('open', 'homes:'..tmpHomes.homeName)
                            end
                        end
                    end
                end
            end
            Citizen.Wait(idle)
        end
    end)
end

local homeList = false
local homesBlips = {}
local buyedHomes = {}

local blips = { 
    _sprite = {
        bought = {
            basic = 411,
            modern = 411,
            high = 411,
            apartament = 475
        },
        sale = {
            basic = 350,
            modern = 350,
            high = 350,
            apartament = 476
        }
    },
    _colors = {
        basic = 8, 
        modern = 3, 
        high = 46, 
        apartament = 38 
    }
}

cli.setBuyedHomes = function(data)
    buyedHomes = data
end

RegisterNetEvent('zero_interactions:blips', function()
    if (homeList) then
        homeList = false
        TriggerEvent('notify', 'Residências', '<b>Marcações</b> desativadas.', 3000)
        for index, value in pairs(homesBlips) do
            if (DoesBlipExist(value)) then RemoveBlip(value); end;
        end
    else
        homeList = true
        TriggerEvent('notify', 'Residências', '<b>Marcações</b> ativadas.', 3000)
        for index, value in pairs(configHomes) do
            local homesType = value.type
            if (homesType ~= 'mlo') then
                homesBlips[index] = AddBlipForCoord(value.coord)
                SetBlipSprite(homesBlips[index], blips['_sprite']['sale'][homesType])
                SetBlipAsShortRange(homesBlips[index], true)
                SetBlipColour(homesBlips[index], blips['_colors'][homesType])			
                SetBlipScale(homesBlips[index], 0.5)
                BeginTextCommandSetBlipName('STRING')
                AddTextComponentString(homesType:upper())
                EndTextCommandSetBlipName(homesBlips[index])

                if (buyedHomes[index]) then
                    SetBlipSprite(homesBlips[index], blips['_sprite']['bought'][homesType])
                    SetBlipColour(homesBlips[index], 1)
                    BeginTextCommandSetBlipName('STRING')
                    AddTextComponentString('Propriedade vendida')
                    EndTextCommandSetBlipName(homesBlips[index])
                end
            end
        end
    end
end)

cli.createGarage = function(homeCoords)
    local finish = false
    local cacheCreation = {
        blip = vector3(0.0, 0.0, 0.0),
        spawn = vector4(0.0, 0.0, 0.0, 0.0)
    } 
    local stage = 1
    local stages = {
        [1] = function(ped, pCoord)
            drawTxt('PRESSIONE ~b~E~w~ PARA REGISTRAR O BLIP', 2, 0.5, 0.9, 0.5, 255, 255, 255, 255)
            DrawMarker(36, pCoord.x, pCoord.y, pCoord.z, 0, 0, 0, 0, 0, 0, 0.7, 0.7, 0.7, 0, 153, 255, 155, 1, 0, 0, 1)
            DrawMarker(27, pCoord.x, pCoord.y, pCoord.z-0.97, 0, 0, 0, 0, 0, 0, 1.0, 1.0, 1.0, 0, 153, 255, 155, 0, 0, 0, 1)
            if (IsControlJustPressed(0, 38)) then stage = 2; cacheCreation.blip = pCoord; end;
        end,
        [2] = function(ped, pCoord)
            local pRotation = GetEntityRotation(ped)
            drawTxt('PRESSIONE ~b~E~w~ PARA REGISTRAR O SPAWN', 2, 0.5, 0.9, 0.5, 255, 255, 255, 255)
            DrawMarker(26, pCoord.x, pCoord.y, pCoord.z, 0, 0, 0, pRotation.x, pRotation.y, pRotation.z, 1.0, 1.0, 1.0, 0, 153, 255, 155, 0 , 0, 0, 0)
            if (IsControlJustPressed(0, 38)) then finish = true; stage = 0; cacheCreation.spawn = vector4(pCoord, GetEntityHeading(ped)) end
        end
    }

    while (stage > 0) do
        local ped = PlayerPedId()
        local pCoord = GetEntityCoords(ped)
        local distance = #(pCoord - homeCoords)
        if (distance <= 50) then
            stages[stage](ped, pCoord)
        else
            stage = 0
            TriggerEvent('notify', 'Residências', 'Você saiu do raio máximo permitido de sua <b>residência</b>.')
        end
        Citizen.Wait(5)
    end
    return finish, cacheCreation
end