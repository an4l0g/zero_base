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
        TriggerEvent('progressBar', 'Produzindo/comprando...', delay)
        Wait(delay)
        TriggerEvent('blockPed', false)
        ClearPedTasks(PlayerPedId())
        sProduction.giveItem(data.index, data.amount, data.org)
    else
        TriggerEvent("notify", 'Produção', 'Você não possui material suficiente!')
    end
end)

TextFloating = function(text, coord)
    AddTextEntry('FloatingHelpText', text)
    SetFloatingHelpTextWorldPosition(0, coord)
    SetFloatingHelpTextStyle(0, true, 2, -1, 3, 0)
    BeginTextCommandDisplayHelp('FloatingHelpText')
    EndTextCommandDisplayHelp(1, false, false, -1)
end

openMoneyLaundry = function()
    sProduction.moneyLaundry()
end

Citizen.CreateThread(function()
    while true do
        local idle = 100
        local ped = PlayerPedId()
        local pedCoords = GetEntityCoords(ped)
        for k, v in pairs(configs.productions) do
            local distance = #(pedCoords - v.coords)
            if (distance <= configs.blipDistance) then
                if v.coords then
                    idle = 1
                    if v.type == 'shop' then
                        TextFloating('~b~[E]~w~ - Negociar', v.coords)
                    else
                        TextFloating('~b~[E]~w~ - Produzir', v.coords)
                    end
                    if (IsControlJustPressed(0, 38) and GetEntityHealth(ped) > 100 and not IsPedInAnyVehicle(ped)) then
                        if v.permission == nil or sProduction.hasPermission(v.permission) then
                            if v.type == 'moneyLaundry' then
                                openMoneyLaundry(v)
                            else
                                openProduction(v.products, v.label, k)
                            end
                        else
                            if v.type == 'shop' then
                                TriggerEvent('notify', 'Negociação', 'Você não pode negociar aqui!')
                            else
                                TriggerEvent('notify', 'Produção', 'Você não pode produzir aqui!')
                            end
                        end
                    end
                end
            end
        end
        Citizen.Wait(idle)
    end
end)

