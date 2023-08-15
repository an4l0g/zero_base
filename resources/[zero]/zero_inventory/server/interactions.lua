local inAction = {}

-- RegisterCommand('saquear', function(source)
--     if (GetEntityHealth(GetPlayerPed(source)) > 100) then
--         local user_id = zero.getUserId(source)
--         if (user_id) then
--             if not (inAction[user_id]) then
--                 local nearestPlayerSource = zeroClient.getNearestPlayer(source, 2.0)
--                 if (nearestPlayerSource) then
--                     local nearestPlayerId = zero.getUserId(nearestPlayerSource)
--                     if not (inAction[nearestPlayerId]) then
--                         inAction[user_id] = nearestPlayerSource
--                         inAction[nearestPlayerId] = true
--                         if GetEntityHealth(GetPlayerPed(nearestPlayerSource)) <= 100 then
--                             TriggerClientEvent('emotes', source, 'verificar')
--                             TriggerClientEvent('zero_inventory:disableActions', nearestPlayerSource)
--                             cInventory.openInventory(source, 'open', 'bag:'..nearestPlayerId)
--                         else
--                             TriggerClientEvent('Notify', source, 'negado', 'Saquear', 'Você não pode saquear um sobrevivente vivo!')
--                         end
--                     else
--                         TriggerClientEvent('Notify', source, 'negado', 'Saquear', 'Esse jogador já se encontra sendo saqueado por um outro sobrevivente!')
--                     end
--                 end
--             else
--                 TriggerClientEvent('Notify', source, 'negado', 'Saquear', 'Você já está saqueando um sobrevivente!')
--             end
--         end
--     end
-- end)

-- RegisterCommand('roubar', function(source)
--     if (GetEntityHealth(GetPlayerPed(source)) > 100) then
--         local user_id = zero.getUserId(source)
--         if (user_id) then
--             if not (inAction[user_id]) then
--                 local nearestPlayerSource = zeroClient.getNearestPlayer(source, 2.0)
--                 if (nearestPlayerSource) then
--                     local nearestPlayerId = zero.getUserId(nearestPlayerSource)
--                     if GetEntityHealth(GetPlayerPed(nearestPlayerSource)) > 100 then
--                         if not (inAction[nearestPlayerId]) then
--                             if zero.request(nearestPlayerSource, 'Você está sendo roubado, deseja aceitar?', 10000) then
--                                 inAction[user_id] = nearestPlayerSource
--                                 inAction[nearestPlayerId] = true
--                                 FreezeEntityPosition(GetPlayerPed(source), true)
--                                 TriggerClientEvent('emotes', source, 'mexer')
--                                 zeroClient.playAnim(nearestPlayerSource, true,{{'random@arrests@busted','idle_a'}},true)
--                                 TriggerClientEvent('zero_inventory:disableActions', nearestPlayerSource)
--                                 cInventory.openInventory(source, 'open', 'bag:'..nearestPlayerId)
--                                 cInventory.checkNui(nearestPlayerSource, { nearestPlayerSource, source }, GetEntityCoords(GetPlayerPed(source)), 1.8)
--                             else
--                                 TriggerClientEvent('notify', source, 'Roubar', 'O mesmo se encontra resistindo ao roubo!')
--                             end
--                         else
--                             TriggerClientEvent('notify', source, 'Roubar', 'Esse jogador já se encontra sendo roubado por um outro sobrevivente!')
--                         end
--                     else
--                         TriggerClientEvent('notify', source, 'Roubar', 'Você não pode roubar um sobrevivente morto!')
--                     end
--                 end
--             else
--                 TriggerClientEvent('Notify', source, 'negado', 'Roubar', 'Você já está roubando um sobrevivente!')
--             end
--         end
--     end
-- end)

RegisterCommand('revistar', function(source)
    if (GetEntityHealth(GetPlayerPed(source)) > 100) then
        local user_id = zero.getUserId(source)
        if (user_id) then
            if not (inAction[user_id]) then
                local nearestPlayerSource = zeroClient.getNearestPlayer(source, 2.0)
                if (nearestPlayerSource) then
                    local nearestPlayerId = zero.getUserId(nearestPlayerSource)
                    if not (inAction[nearestPlayerId]) then
                        if zero.request(nearestPlayerSource, 'Você está sendo revistado, deseja aceitar?', 60) then
                            inAction[user_id] = nearestPlayerSource
                            inAction[nearestPlayerId] = true
                            if GetEntityHealth(GetPlayerPed(nearestPlayerSource)) > 100 then
                                TriggerClientEvent('zero_inventory:disableActions', nearestPlayerSource)
                                TriggerClientEvent('emotes', source, 'mexer')
                                zeroClient.playAnim(nearestPlayerSource, true,{{'random@arrests@busted','idle_a'}},true)
                                cInventory.openInventory(source, 'open', 'bag:'..nearestPlayerId)
                                cInventory.checkNui(nearestPlayerSource, { nearestPlayerSource, source }, GetEntityCoords(GetPlayerPed(source)), 1.8)
                            else
                                TriggerClientEvent('Notify', source, 'negado', 'Revistar', 'Você não pode revistar um sobrevivente morto!')
                            end
                        else
                            TriggerClientEvent('Notify', source, 'negado', 'Revistar', 'O mesmo se encontra resistindo a revista!')
                        end
                    else
                        TriggerClientEvent('Notify', source, 'negado', 'Revistar', 'Esse jogador já se encontra sendo revistado por um outro sobrevivente!')
                    end
                end
            else
                TriggerClientEvent('Notify', source, 'negado', 'Revistar', 'Você já está revistando um sobrevivente!')
            end
        end
    end
end)

sInventory.callBackInteractions = function(receiveRequest, sendRequest)
    FreezeEntityPosition(GetPlayerPed(sendRequest), false)
    ClearPedTasks(GetPlayerPed(receiveRequest))
    ClearPedTasks(GetPlayerPed(sendRequest))
    TriggerClientEvent('zero_inventory:enableActions', receiveRequest)
    inAction[zero.getUserId(receiveRequest)] = nil
    inAction[zero.getUserId(sendRequest)] = nil
    cInventory.closeInventory(sendRequest)
end

sInventory.checkAction = function()
    FreezeEntityPosition(GetPlayerPed(source), false)
    ClearPedTasks(GetPlayerPed(source))
    if (inAction[zero.getUserId(source)]) then
        ClearPedTasks(GetPlayerPed(inAction[zero.getUserId(source)]))
        TriggerClientEvent('zero_inventory:enableActions', inAction[zero.getUserId(source)])
        inAction[zero.getUserId(inAction[zero.getUserId(source)])] = nil
    end
    inAction[zero.getUserId(source)] = nil
end