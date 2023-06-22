sProduction = Tunnel.getInterface('zero_production')

nearbyProduction = nil

openProduction = function(products, title, org)
    SetNuiFocus(true, true)
    SendNUIMessage({
        action = 'open',
        title = title,
        org = org,
        products = products
    })
end

RegisterNuiCallback('close', function()
    SetNuiFocus(false, false)
end)

RegisterNuiCallback('production', function(data)
    if sProduction.validateProduction(data.index, data.amount, data.org) then 
        local product = configs.productions[data.org].products[data.index]
        local delay = product.delay * data.amount
        TriggerEvent('blockPed', true)
        zero.playAnim(false, {{'amb@prop_human_parking_meter@female@idle_a', 'idle_a_female'}}, true)
        TriggerEvent('progressBar', 'Produzindo...', delay)
        Wait(delay)
        TriggerEvent('blockPed', false)
        ClearPedTasks(PlayerPedId())
        sProduction.giveItem(data.index, data.amount, data.org)
    else
        TriggerEvent("notify", 'Produção', 'Você não possui material suficiente!')
    end
end)

DrawText3D = function(x, y, z, text)
    local onScreen, _x, _y = World3dToScreen2d(x, y, z)
    local p = GetGameplayCamCoords()
    local distance = GetDistanceBetweenCoords(p.x, p.y, p.z, x, y, z, 1)
    local scale = (1 / distance) * 2
    local fov = (1 / GetGameplayCamFov()) * 100
    local scale = scale * fov
    if onScreen then
        SetTextScale(0.0 * scale, 0.35 * scale)
        SetTextFont(0)
        SetTextProportional(1)
        SetTextColour(255, 255, 255, 255)
        SetTextDropshadow(0, 0, 0, 0, 255)
        SetTextEdge(2, 0, 0, 0, 150)
        SetTextDropShadow()
        SetTextOutline()
        SetTextEntry('STRING')
        SetTextCentre(1)
        AddTextComponentString(text)
        DrawText(_x, _y)
    end
end

RegisterCommand('cds3', function()
    local playerPed = PlayerPedId() -- obtém o ped (personagem/npc) do jogador
    local coords = GetEntityCoords(playerPed)
end)

Citizen.CreateThread(function()
    while true do
        local idle = 500
        local ped = PlayerPedId()
        local pedCoords = GetEntityCoords(ped)
        for k, v in pairs(configs.productions) do
            local distance = #(pedCoords - v.coords)
            if (distance <= 5.0) then
                nearbyProduction = v
                nearbyProduction.index = k
            end
        end
        if (nearbyProduction) and nearbyProduction['coords'] then
            idle = 4
            DrawText3D(nearbyProduction.coords.x, nearbyProduction.coords.y, nearbyProduction.coords.z+0.07, '~b~[E]~w~ - ['..nearbyProduction.label..'] Produção')
            if (IsControlJustPressed(0, 38) and GetEntityHealth(ped) > 101 and not IsPedInAnyVehicle(ped)) then
                openProduction(nearbyProduction.products, nearbyProduction.label, nearbyProduction.index)
            end
        end
        Citizen.Wait(idle)
    end
end)

