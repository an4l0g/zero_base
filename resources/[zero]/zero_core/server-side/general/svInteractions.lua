RegisterNetEvent('zero_interactions:handcuff', function()
    local source = source
    local user_id = zero.getUserId(source)
    local nPlayer = zeroClient.getNearestPlayer(source, 2.0)
    if (user_id) and nPlayer then
        if (not zeroClient.isHandcuffed(source)) then 
            if (zero.hasPermission(user_id, 'staff.permissao')) then
                if (not zeroClient.isHandcuffed(nPlayer)) then
                    zeroClient.playAnim(source, false, {{ 'mp_arrest_paired', 'cop_p2_back_left' }}, false)
                    zeroClient.playAnim(nPlayer, false, {{ 'mp_arrest_paired', 'crook_p2_back_left' }}, false)
                    FreezeEntityPosition(GetPlayerPed(nPlayer), true)
                    Citizen.SetTimeout(3500, function()
                        FreezeEntityPosition(GetPlayerPed(nPlayer), false)
                        ClearPedTasks(GetPlayerPed(source))
                        ClearPedTasks(GetPlayerPed(nPlayer))
                        zeroClient.toggleHandcuff(nPlayer)
                        TriggerClientEvent('zero_sound:source', source, 'uncuff', 0.1)
						TriggerClientEvent('zero_sound:source', nPlayer, 'uncuff', 0.1)
                        TriggerClientEvent('zero_interactions:algemas', nPlayer, 'colocar')
                    end)
                else
                    FreezeEntityPosition(GetPlayerPed(nPlayer), true)
                    zeroClient.playAnim(source,false, {{ 'mp_arresting', 'a_uncuff' }}, false)
                    zeroClient.playAnim(nPlayer, false, {{ 'mp_arresting', 'b_uncuff' }}, false)
                    Citizen.SetTimeout(5000, function()
                        FreezeEntityPosition(GetPlayerPed(nPlayer), false)
                        zeroClient.toggleHandcuff(nPlayer)
                        ClearPedTasks(GetPlayerPed(source))
                        ClearPedTasks(GetPlayerPed(nPlayer))
                        TriggerClientEvent('zero_sound:source', source, 'uncuff', 0.1)
						TriggerClientEvent('zero_sound:source', nPlayer, 'uncuff', 0.1)
                        TriggerClientEvent('zero_interactions:algemas', nPlayer)
                    end)
                end
            else
                if (zero.getInventoryItemAmount(user_id, 'algema') >= 1) then
                    if (not zeroClient.isHandcuffed(nPlayer)) then
                        if (zero.tryGetInventoryItem(user_id, 'algema', 1)) then
                            zero.giveInventoryItem(user_id, 'chave-algema', 1)
                            zeroClient.playAnim(source, false, {{ 'mp_arrest_paired', 'cop_p2_back_left' }}, false)
                            zeroClient.playAnim(nPlayer, false, {{ 'mp_arrest_paired', 'crook_p2_back_left' }}, false)
                            FreezeEntityPosition(GetPlayerPed(nPlayer), true)
                            Citizen.SetTimeout(3500, function()
                                FreezeEntityPosition(GetPlayerPed(nPlayer), false)
                                ClearPedTasks(GetPlayerPed(source))
                                ClearPedTasks(GetPlayerPed(nPlayer))
                                zeroClient.toggleHandcuff(nPlayer)
                                TriggerClientEvent('zero_sound:source', source, 'uncuff', 0.1)
						        TriggerClientEvent('zero_sound:source', nPlayer, 'uncuff', 0.1)
                                TriggerClientEvent('zero_interactions:algemas', nPlayer, 'colocar')
                            end)
                        end
                    else
                        TriggerClientEvent('notify', source, 'Interação Algemar', 'Este <b>cidadão</b> já se encontra algemado.')
                    end
                elseif (zero.getInventoryItemAmount(user_id, 'chave-algema') >= 1) then
                    if (zeroClient.isHandcuffed(nPlayer)) then
                        if (zero.tryGetInventoryItem(user_id, 'chave-algema', 1)) then
                            zero.giveInventoryItem(user_id, 'algema', 1)
                            FreezeEntityPosition(GetPlayerPed(nPlayer), true)
                            zeroClient.playAnim(source,false, {{ 'mp_arresting', 'a_uncuff' }}, false)
                            zeroClient.playAnim(nPlayer, false, {{ 'mp_arresting', 'b_uncuff' }}, false)
                            Citizen.SetTimeout(5000, function()
                                FreezeEntityPosition(GetPlayerPed(nPlayer), false)
                                zeroClient.toggleHandcuff(nPlayer)
                                ClearPedTasks(GetPlayerPed(source))
                                ClearPedTasks(GetPlayerPed(nPlayer))
                                TriggerClientEvent('zero_sound:source', source, 'uncuff', 0.1)
						        TriggerClientEvent('zero_sound:source', nPlayer, 'uncuff', 0.1)
                                TriggerClientEvent('zero_interactions:algemas', nPlayer)
                            end)
                        end
                    else
                        TriggerClientEvent('notify', source, 'Interação Algemar', 'Este <b>cidadão</b> não se encontra algemado.')
                    end
                else
                    TriggerClientEvent('notify', source, 'Interação Algemar', 'Você não possui uma <b>algema</b>.')
                end    
            end    
        end
    end
end)

RegisterNetEvent('zero_interactions:carregar', function()
    local source = source
    local user_id = zero.getUserId(source)
    local nPlayer = zeroClient.getNearestPlayer(source, 2.0)
    if (user_id) and nPlayer then
        if (zero.hasPermission(user_id, 'staff.permissao') and zero.hasPermission(user_id, 'polpar.permissao')) then
            if (not zeroClient.isHandcuffed(source)) then
                TriggerClientEvent('carregar', nPlayer, source)
            end
        end
    end
end)

RegisterNetEvent('zero_interactions:vestimenta', function(value)
    local source = source
    local user_id = zero.getUserId(source)
    local identity = zero.getUserIdentity(user_id)
	if (user_id) and zero.hasPermission(user_id, 'polpar.permissao') then
        local nplayer = zeroClient.getNearestPlayer(source, 2)
        if (nplayer) then
            local nUser = zero.getUserId(nplayer)
            local nIdentity = zero.getUserIdentity(nUser)
            if (value == 'rmascara') then
                TriggerClientEvent('zero_commands_police:clothes', nplayer, 'rmascara')
                zero.webhook(webhooks.policeCommands, '```prolog\n[/RMASCARA]\n[USER_ID]: #'..user_id..' '..identity.name..' '..identity.firstname..'\n[RETIROU A MASCARA DO]\n[JOGADOR]: #'..nUser..' '..nIdentity.name..' '..nIdentity.firstname..' '..os.date('\n[DATA]: %d/%m/%Y [HORA]: %H:%M:%S')..' \r```')
            elseif (value == 'rchapeu') then
                TriggerClientEvent('zero_commands_police:clothes', nplayer, 'rchapeu')
			    zero.webhook(webhooks.policeCommands, '```prolog\n[/RCHAPEU]\n[USER_ID]: #'..user_id..' '..identity.name..' '..identity.firstname..'\n[RETIROU O CHAPEU DO]\n[JOGADOR]: #'..nUser..' '..nIdentity.name..' '..nIdentity.firstname..' '..os.date('\n[DATA]: %d/%m/%Y [HORA]: %H:%M:%S')..' \r```')
            end
        else
            TriggerClientEvent('notify', source, 'Interação Policia', 'Você não se encontra próximo de um <b>cidadão</b>.')
        end
	end
end)