cli = {}
Tunnel.bindInterface(GetCurrentResourceName(), cli)
vSERVER = Tunnel.getInterface(GetCurrentResourceName())

local configHomes = config.homes
local configInterior = config.interior 

local inHome = false

local mainThread = function()
    getNearestHome = function()
        local ped = PlayerPedId()
        local pCoord = GetEntityCoords(ped)
        local homeCoords = {}
        for k, v in pairs(configHomes) do
            local distance = #(pCoord - v.coord)
            if (distance <= 5) then
                table.insert(homeCoords, k)
            end
        end
        return homeCoords
    end
    
    while (true) do
        local idle = 1000
        if (not inHome) then   
            local nearestHome = getNearestHome() 
            if (nearestHome) then
                local ped = PlayerPedId()
                local pCoord = GetEntityCoords(ped)
                for k, v in pairs(nearestHome) do
                    local homeConfig = configHomes[v]
                    local coord = homeConfig.coord
                    local distance = #(pCoord - coord)
                    if (distance > 5 or GetEntityHealth(ped) <= 101) then
                        nearestHome = nil
                        break
                    else
                        idle = 5
                        DrawMarker(1, coord.x, coord.y, coord.z - 0.97, 0, 0, 0, 0, 0, 0, 0.8, 0.8, 0.5, 0, 153, 255, 155, 0, 0, 0, 1)
                        if (distance <= 0.5 and IsControlJustPressed(0, 38) and GetEntityHealth(ped) > 101 and not IsPedInAnyVehicle(ped)) then
                            vSERVER.tryEnterHome(v)   
                        end
                    end
                end
            end
        end
        Citizen.Wait(idle)
    end
end

CreateThread(mainThread)

local internLocates = {}
local homeName = ''

cli.enterHome = function(interior, name)
    threadInHome()

    homeName = name
    interior = configInterior[interior]
    local ped = PlayerPedId()

    DoScreenFadeOut(100)
    TriggerEvent('zero_sound:source', 'enterexithouse', 0.7)
    Citizen.Wait(500)

    FreezeEntityPosition(ped, true)
    SetEntityCoords(ped, interior.door)
    
    table.insert(internLocates, { interior.door.x, interior.door.y, interior.door.z, 'exit' })
    table.insert(internLocates, { interior.vault.x, interior.vault.y, interior.vault.z, 'vault' })

    Citizen.Wait(1000)
	FreezeEntityPosition(ped, false)
	DoScreenFadeIn(1000)
end

threadInHome = function()
    inHome = true
    Citizen.CreateThread(function()
        while (inHome) do
            local idle = 1000
            local ped = PlayerPedId()
            local pCoord = GetEntityCoords(ped)
            if (inHome) then
                for k, v in pairs(internLocates) do
                    local coord = vector3(v[1], v[2], v[3])
                    local distance = #(pCoord - coord)
                    if (distance <= 5.0) then
                        idle = 4
                        DrawMarker(0, coord.x, coord.y, coord.z, 0, 0, 0, 0, 0, 0, 0.3, 0.3, 0.3, 0, 153, 255, 155, 1, 0, 0, 1)
                        if (distance <= 1.2 and IsControlJustPressed(0, 38) and GetEntityHealth(ped) > 101) then
                            if (v[4] == 'exit') then
                                exitHome()
                            elseif (v[4] == 'vault') then
                                exports['zero_inventory']:openInventory('open', 'homes:'..homeName)
                            end
                        end
                    end
                end
            end
            Citizen.Wait(idle)
        end
    end)
end

exitHome = function()
    inHome = false
    
    local ped = PlayerPedId()
    DoScreenFadeOut(100)
	Citizen.Wait(500)

    TriggerEvent('zero_sound:source', 'enterexithouse', 0.5)
    internLocates = {}

    FreezeEntityPosition(ped, true)
    vSERVER.cacheHomes()
	Citizen.Wait(2000)
	FreezeEntityPosition(ped, false)
	DoScreenFadeIn(1000)
end

local homeList = false
local homesBlips = {}
local buyedHomes = {}
local blipsColor = { basic = 8, modern = 3, high = 46 }

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
            homesBlips[index] = AddBlipForCoord(value.coord)
            SetBlipSprite(homesBlips[index], 350)
			SetBlipAsShortRange(homesBlips[index], true)
			SetBlipColour(homesBlips[index], blipsColor[value.type])			
			SetBlipScale(homesBlips[index], 0.2)
            BeginTextCommandSetBlipName('STRING')
            AddTextComponentString('Propriedade à venda | '..string.upper(value.type))
		    EndTextCommandSetBlipName(homesBlips[index])

            if (buyedHomes[index]) then
                SetBlipSprite(homesBlips[index], 411)
                SetBlipColour(homesBlips[index], 1)
                BeginTextCommandSetBlipName('STRING')
                AddTextComponentString('Propriedade vendida')
                EndTextCommandSetBlipName(homesBlips[index])
            end
        end
    end
end)