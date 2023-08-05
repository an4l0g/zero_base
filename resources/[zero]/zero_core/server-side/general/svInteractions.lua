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
                zero.webhook('PoliceCommands', '```prolog\n[/RMASCARA]\n[USER_ID]: #'..user_id..' '..identity.name..' '..identity.firstname..'\n[RETIROU A MASCARA DO]\n[JOGADOR]: #'..nUser..' '..nIdentity.name..' '..nIdentity.firstname..' '..os.date('\n[DATA]: %d/%m/%Y [HORA]: %H:%M:%S')..' \r```')
            elseif (value == 'rchapeu') then
                TriggerClientEvent('zero_commands_police:clothes', nplayer, 'rchapeu')
			    zero.webhook('PoliceCommands', '```prolog\n[/RCHAPEU]\n[USER_ID]: #'..user_id..' '..identity.name..' '..identity.firstname..'\n[RETIROU O CHAPEU DO]\n[JOGADOR]: #'..nUser..' '..nIdentity.name..' '..nIdentity.firstname..' '..os.date('\n[DATA]: %d/%m/%Y [HORA]: %H:%M:%S')..' \r```')
            elseif (value == 'rcapuz') then
                if (zeroClient.isCapuz(nplayer)) then
                    zeroClient.setCapuz(nplayer) 
                    zero.webhook('PoliceCommands', '```prolog\n[/RCAPUZ]\n[USER_ID]: #'..user_id..' '..identity.firstname..' '..identity.lastname..'\n[RETIROU O CAPUZ DO]\n[JOGADOR]: #'..nUser..' '..nIdentity.firstname..' '..nIdentity.lastname..' '..os.date('\n[DATA]: %d/%m/%Y [HORA]: %H:%M:%S')..' \r```')
                else
                    TriggerClientEvent('notify', source, 'Remover Capuz', 'O <b>cidadão</b> não está com o capuz na cabeça.')
                end
            end
        else
            TriggerClientEvent('notify', source, 'Interação Policia', 'Você não se encontra próximo de um <b>cidadão</b>.')
        end
	end
end)

RegisterNetEvent('zero_interactions:acessorios', function(value)
    local source = source
    local user_id = zero.getUserId(source)
    local identity = zero.getUserIdentity(user_id)
	if (user_id) and zero.hasPermission(user_id, 'polpar.permissao') then
        local coord = GetEntityCoords(GetPlayerPed(source))
        if (value == 'cone') then
            TriggerClientEvent('cone', source)
            zero.webhook('PoliceCommands', '```prolog\n[/CONE]\n[USER_ID]: #'..user_id..' '..identity.firstname..' '..identity.lastname..'\n[CRIOU UM CONE NA]\n[COORDENADA]: '..tostring(coord)..' '..os.date('\n[DATA]: %d/%m/%Y [HORA]: %H:%M:%S')..' \r```')
        elseif (value == 'coned') then
            TriggerClientEvent('cone', source, 'd')
            zero.webhook('PoliceCommands', '```prolog\n[/CONE]\n[USER_ID]: #'..user_id..' '..identity.firstname..' '..identity.lastname..'\n[DELETOU UM CONE NA]\n[COORDENADA]: '..tostring(coord)..' '..os.date('\n[DATA]: %d/%m/%Y [HORA]: %H:%M:%S')..' \r```')
        elseif (value == 'barreira') then
            TriggerClientEvent('barreira', source)
		    zero.webhook('PoliceCommands', '```prolog\n[/BARREIRA]\n[USER_ID]: #'..user_id..' '..identity.firstname..' '..identity.lastname..'\n[CRIOU UMA BARREIRA NA]\n[COORDENADA]: '..tostring(coord)..' '..os.date('\n[DATA]: %d/%m/%Y [HORA]: %H:%M:%S')..' \r```')
        elseif (value == 'barreirad') then
            TriggerClientEvent('barreira', source, 'd')
		    zero.webhook('PoliceCommands', '```prolog\n[/BARREIRA]\n[USER_ID]: #'..user_id..' '..identity.firstname..' '..identity.lastname..'\n[DELETOU UMA BARREIRA NA]\n[COORDENADA]: '..tostring(coord)..' '..os.date('\n[DATA]: %d/%m/%Y [HORA]: %H:%M:%S')..' \r```')
        elseif (value == 'spike') then
            TriggerClientEvent('spike', source)
		    zero.webhook('PoliceCommands', '```prolog\n[/SPIKE]\n[USER_ID]: #'..user_id..' '..identity.firstname..' '..identity.lastname..'\n[CRIOU UMA SPIKE NA]\n[COORDENADA]: '..tostring(coord)..' '..os.date('\n[DATA]: %d/%m/%Y [HORA]: %H:%M:%S')..' \r```')
        elseif (value == 'spiked') then
            TriggerClientEvent('spike', source, 'd')
		    zero.webhook('PoliceCommands', '```prolog\n[/SPIKE]\n[USER_ID]: #'..user_id..' '..identity.firstname..' '..identity.lastname..'\n[DELETOU UMA SPIKE NA]\n[COORDENADA]: '..tostring(coord)..' '..os.date('\n[DATA]: %d/%m/%Y [HORA]: %H:%M:%S')..' \r```')
        end        
    end
end)

RegisterNetEvent('zero_interactions:cv', function()
    local source = source
	local user_id = zero.getUserId(source)
    local identity = zero.getUserIdentity(user_id)
	if (zero.hasPermission(user_id, 'polpar.permissao') and not zeroClient.isInVehicle(source)) then
		local nplayer = zeroClient.getNearestPlayer(source, 10)
		if (nplayer) then
			local nUser = zero.getUserId(nplayer)
			local nIdentity = zero.getUserIdentity(nUser)
            zeroClient.putInNearestVehicleAsPassenger(nplayer, 7)
			zero.webhook('PoliceCommands', '```prolog\n[/CV]\n[USER_ID]: #'..user_id..' '..identity.firstname..' '..identity.lastname..'\n[DEU CV NO]\n[JOGADOR]: #'..nUser..' '..nIdentity.firstname..' '..nIdentity.lastname..' '..os.date('\n[DATA]: %d/%m/%Y [HORA]: %H:%M:%S')..' \r```')
        else
            TriggerClientEvent('notify', source, 'Interação Policia', 'Você não se encontra próximo de um <b>cidadão</b>.')
        end
	end
end)

RegisterNetEvent('zero_interactions:rv', function()
    local source = source
	local user_id = zero.getUserId(source)
    local identity = zero.getUserIdentity(user_id)
	if (zero.hasPermission(user_id, 'polpar.permissao')) then
		local nplayer = zeroClient.getNearestPlayer(source, 10)
		if (nplayer) then
			local nUser = zero.getUserId(nplayer)
			local nIdentity = zero.getUserIdentity(nUser)
            zeroClient.ejectVehicle(nplayer)
			zero.webhook('PoliceCommands', '```prolog\n[/RV]\n[USER_ID]: #'..user_id..' '..identity.firstname..' '..identity.lastname..'\n[DEU RV NO]\n[JOGADOR]: #'..nUser..' '..nIdentity.firstname..' '..nIdentity.lastname..' '..os.date('\n[DATA]: %d/%m/%Y [HORA]: %H:%M:%S')..' \r```')
        else
            TriggerClientEvent('notify', source, 'Interação Policia', 'Você não se encontra próximo de um <b>cidadão</b>.')
        end
	end
end)

RegisterNetEvent('zero_interactions:tow', function()
    local source = source
	local user_id = zero.getUserId(source)
	if (user_id) and zero.hasPermission(user_id, 'mecanico.permissao') then
		TriggerClientEvent('vTow', source)
	end
end)

RegisterNetEvent('zero_interactions:enviar', function()
    local source = source
    local user_id = zero.getUserId(source)
    local identity = zero.getUserIdentity(user_id)
    if (user_id) then
        local nPlayer = zeroClient.getNearestPlayer(source, 2.0)
        local nUser = zero.getUserId(nPlayer)
        local nIdentity = zero.getUserIdentity(nUser)
        if (nPlayer) then
            local amount = parseInt(args[1])
            if (amount > 0) then
                if (zero.tryPayment(user_id, amount)) then
                    zero.giveMoney(nUser, amount)
                    zeroClient._playAnim(source, true, {{ 'mp_common', 'givetake1_a' }}, false)
			        zeroClient._playAnim(nPlayer, true, {{ 'mp_common', 'givetake1_a' }}, false)
                    TriggerClientEvent('notify', source, 'Interação Enviar', 'Você enviou <b>R$'..zero.format(amount)..'</b>.')
                    TriggerClientEvent('notify', nPlayer, 'Interação Enviar', 'Você recebeu <b>R$'..zero.format(amount)..'</b>.')
                    zero.webhook('Enviar', '```prolog\n[/ENVIAR]\n[ID]: #'..user_id..' '..identity.firstname..' '..identity.lastname..' \n[ENVIOU]: R$'..vRP.format(amount)..' \n[PARA O ID]: #'..nUser..' '..nIdentity.firstname..' '..nIdentity.lastname..os.date('\n[DATA]: %d/%m/%Y [HORA]: %H:%M:%S')..' \r```')
                else
                    TriggerClientEvent('notify', source, 'Interação Enviar', 'Você não possui essa quantia de <b>dinheiro</b> em mãos.')
                end
            end
        else
            TriggerClientEvent('notify', source, 'Interação Enviar', 'Você não se encontra próximo de um <b>cidadão</b>.')
        end
    end
end)

RegisterNetEvent('zero_interactions:homesAdd', function()
    local source = source    
    exports['zero_homes']:homesAdd(source)
end)

RegisterNetEvent('zero_interactions:homesRem', function()
    local source = source    
    exports['zero_homes']:homesRem(source)
end)

RegisterNetEvent('zero_interactions:homesTrans', function()
    local source = source    
    exports['zero_homes']:homesTrans(source)
end)

RegisterNetEvent('zero_interactions:homesVender', function()
    local source = source    
    exports['zero_homes']:homesVender(source)
end)

RegisterNetEvent('zero_interactions:homesChecar', function()
    local source = source    
    exports['zero_homes']:homesChecar(source)
end)

RegisterNetEvent('zero_interactions:homesTax', function()
    local source = source    
    exports['zero_homes']:homesTax(source)
end)

RegisterNetEvent('zero_interactions:homesOther', function()
    local source = source    
    exports['zero_homes']:homesOther(source)
end)

RegisterNetEvent('zero_interactions:homesTrancar', function()
    local source = source    
    exports['zero_homes']:homesTrancar(source)
end)

RegisterNetEvent('zero_interactions:homesInterior', function(value)
    local source = source    
    if (value ~= '') then exports['zero_homes']:updateInterior(source, value);
    else exports['zero_homes']:homesInterior(source); end;
end)

RegisterNetEvent('zero_interactions:homesDecoration', function(value)
    local source = source    
    if (value ~= '') then exports['zero_homes']:updateDecoration(source, value);
    else exports['zero_homes']:homesDecoration(source); end;
end)

RegisterNetEvent('zero_interactions:homesBau', function(value)
    local source = source    
    exports['zero_homes']:homesBau(source)
end)

RegisterNetEvent('zero_interactions:homesGaragem', function(value)
    local source = source    
    exports['zero_homes']:homesGaragem(source)
end)

RegisterNetEvent('zero_interactions:homesLacrar', function(value)
    local source = source    
    exports['zero_homes']:homesLacrar(source)
end)