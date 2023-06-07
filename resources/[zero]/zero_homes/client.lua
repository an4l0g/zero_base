local configHomes = config.homes

local inHome = false
local nearestBlip = {}
local nearestBlipName = ''

mainThread = function()
    local getNearestHomes = function()
        while true do
            if (not inHome) then 
                local pedCoords = GetEntityCoords(PlayerPedId())
                if (nearestBlip) and nearestBlip[1] then
                    local distance = #(pedCoords - nearestBlip[1].xyz)
                    if (distance >= 0.6) then
                        nearestBlip = false
                    elseif (distance <= 0.5) then
                        nearestBlip.close = true
                    else
                        nearestBlip.close = false
                    end
                else
                    for k, v in pairs(configHomes) do
                        local distance = #(pedCoords - v[1].xyz)
                        if (distance <= 0.5) then
                            nearestBlip = configHomes[k]
                            nearestBlipName = k
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
                Text3D(nearestBlip[1].xyz+0.3, '~b~['..string.upper(nearestBlipName)..']~w~\n~b~E~w~ - Entrar')
                if (IsControlJustPressed(0, 38) and GetEntityHealth(ped) > 101 and not IsPedInAnyVehicle(ped)) then

                end
            end
        end
        Citizen.Wait(idle)
    end
end

CreateThread(mainThread)

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