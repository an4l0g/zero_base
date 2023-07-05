vSERVER = Tunnel.getInterface(GetCurrentResourceName())

local configHomes = config.homes

local inHome = false
local nearestBlip = {}

mainThread = function()
    local getNearestHomes = function()
        while true do
            if (not inHome) then 
                local pedCoords = GetEntityCoords(PlayerPedId())
                if (nearestBlip) and nearestBlip[1] then
                    local distance = #(pedCoords - nearestBlip[1].xyz)
                    if (distance >= 0.4) then
                        nearestBlip = false
                    elseif (distance <= 0.3) then
                        nearestBlip.close = true
                    else
                        nearestBlip.close = false
                    end
                else
                    for k, v in pairs(configHomes) do
                        local distance = #(pedCoords - v[1].xyz)
                        if (distance <= 0.3) then
                            nearestBlip = configHomes[k]
                            nearestBlip.name = k
                        end
                    end
                end
            end
            Citizen.Wait(500)
        end
    end

    CreateThread(getNearestHomes)

    while true do
        local idle = 500
        local ped = PlayerPedId()
        if (not inHome) then
            if (nearestBlip) and nearestBlip[1] then
                idle = 4
                DrawMarker(1, nearestBlip[1].x, nearestBlip[1].y, (nearestBlip[1].z-0.97), 0, 0, 0, 0, 0, 0, 0.5, 0.5, 0.5, 0, 153, 255, 255, 0, 0, 0, 1)
                if (IsControlJustPressed(0, 38) and GetEntityHealth(ped) > 101 and not IsPedInAnyVehicle(ped)) then
                    vSERVER.tryEnterHome(nearestBlip.name)
                end
            end
        end
        Citizen.Wait(idle)
    end
end

CreateThread(mainThread)

local homeList = false
local homesBlips = {}
local buyedHomes = {}
local blipsColor = { basic = 8, modern = 3, high = 46 }

RegisterCommand('homes', function(source, args)
    if (args[1] == 'list') then TriggerEvent('zero_homes:blips'); end;
end)

RegisterNetEvent('zero_homes:blips', function()
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
            homesBlips[index] = AddBlipForCoord(value[1])
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

Text3D = function(coords, text)
    SetDrawOrigin(coords.x, coords.y, coords.z, 0); 
    SetTextFont(4)     
    SetTextProportional(0)     
    SetTextScale(0.35,0.35)    
    SetTextColour(255,255,255,150)   
    SetTextDropshadow(0, 0, 0, 0, 255)     
    SetTextEdge(2, 0, 0, 0, 150)     
    SetTextDropShadow()     SetTextOutline()     
    SetTextEntry('STRING')     SetTextCentre(1)     
    AddTextComponentString(text) 
    DrawText(0.0, 0.0)     
    ClearDrawOrigin() 
end