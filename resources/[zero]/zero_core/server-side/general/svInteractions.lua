RegisterNetEvent('zero_interactions:handcuff', function()
    local source = source
    local user_id = zero.getUserId(source)
    if (user_id) then
        if (zeroClient.isHandcuffed(source)) then return; end;
        if (GetSelectedPedWeapon(GetPlayerPed(source)) ~= GetHashKey('WEAPON_UNARMED')) then TriggerClientEvent('notify', source, 'Interação Algemar', 'Sua <b>mão</b> está ocupada.') return; end;
        local nPlayer = zeroClient.getNearestPlayer(source, 2.0)
        if (nPlayer) then
            local cooldown = 'algemar:'..nPlayer
            if (exports[GetCurrentResourceName()]:GetCooldown(cooldown)) then
                TriggerClientEvent('notify', source, 'Interação Algemar', 'Aguarde <b>'..exports[GetCurrentResourceName()]:GetCooldown(cooldown)..' segundos</b> para algemar novamente.')
                return
            end
            exports[GetCurrentResourceName()]:CreateCooldown(cooldown, 10)

            if (zeroClient.getNoCarro(nPlayer)) then return; end;
            
            local ply = GetPlayerPed(nPlayer)
            if (zeroClient.isHandcuffed(nPlayer)) then
                if (zero.hasPermission(user_id, 'staff.permissao') or zero.tryGetInventoryItem(user_id, 'chave-algema', 1)) then
                    TriggerClientEvent('zero:attach', nPlayer, source, 4103, 0.1, 0.6, 0.0, 0.0, 0.0, 0.0, 0.0, false, false, false, 2, true)

                    Player(source).state.BlockTasks = true
                    Player(nPlayer).state.BlockTasks = true

                    zeroClient.playAnim(source, false, {
                        { 'mp_arresting', 'a_uncuff' }
                    }, false)
                    zeroClient.playAnim(nPlayer, false, {
                        { 'mp_arresting', 'b_uncuff' }
                    }, false)

                    Citizen.SetTimeout(5000, function()
                        TriggerClientEvent('zero:attach', nPlayer, source)

                        Player(source).state.BlockTasks = false
                        Player(nPlayer).state.BlockTasks = false

                        ClearPedTasks(ply)
                        ClearPedTasks(GetPlayerPed(source))
                        
                        Player(nPlayer).state.Handcuff = false
                        zeroClient.setHandcuffed(nPlayer, false)

                        TriggerClientEvent('zero_sound:source', source, 'uncuff', 0.1)
                        TriggerClientEvent('zero_sound:source', nPlayer, 'uncuff', 0.1)
                        TriggerClientEvent('zero_interactions:algemas', nPlayer)

                        zero.giveInventoryItem(user_id, 'algema', 1)
                    end)
                elseif (zero.tryGetInventoryItem(user_id, 'lockpick', 1)) then
                    if (exports['zero_system']:Task(source, 3, 8000)) then
                        TriggerClientEvent('zero:attach', nPlayer, source, 4103, 0.1, 0.6, 0.0, 0.0, 0.0, 0.0, 0.0, false, false, false, 2, true)

                        Player(source).state.BlockTasks = true
                        Player(nPlayer).state.BlockTasks = true

                        zeroClient.playAnim(source, false, {
                            { 'mp_arresting', 'a_uncuff' }
                        }, false)
                        zeroClient.playAnim(nPlayer, false, {
                            { 'mp_arresting', 'b_uncuff' }
                        }, false)

                        Citizen.SetTimeout(5000, function()
                            TriggerClientEvent('zero:attach', nPlayer, source)

                            Player(source).state.BlockTasks = false
                            Player(nPlayer).state.BlockTasks = false

                            ClearPedTasks(ply)
                            ClearPedTasks(GetPlayerPed(source))
                            
                            Player(nPlayer).state.Handcuff = false
                            zeroClient.setHandcuffed(nPlayer, false)

                            TriggerClientEvent('zero_sound:source', source, 'uncuff', 0.1)
                            TriggerClientEvent('zero_sound:source', nPlayer, 'uncuff', 0.1)
                            TriggerClientEvent('zero_interactions:algemas', nPlayer)

                            zero.giveInventoryItem(user_id, 'algema', 1)
                        end)
                    end
                else
                    TriggerClientEvent('notify', source, 'Interação Algemar', 'Você não possui uma <b>lockpick</b> ou <b>chave de algema</b>.')
                end
            else
                if (zero.hasPermission(user_id, 'staff.permissao') or zero.tryGetInventoryItem(user_id, 'algema', 1)) then
                    TriggerClientEvent('zero:attach', nPlayer, source, 4103, 0.0, 0.6, 0.0, 0.0, 0.0, 0.0, 0.0, false, false, false, 2, true)

                    Player(source).state.BlockTasks = true
                    Player(nPlayer).state.BlockTasks = true

                    zeroClient.playAnim(source, false, {
                        { 'mp_arrest_paired', 'cop_p2_back_left' }
                    }, false)
                    zeroClient.playAnim(nPlayer, false, {
                        { 'mp_arrest_paired', 'crook_p2_back_left' }
                    }, false)
                    
                    Citizen.SetTimeout(3500, function()
                        TriggerClientEvent('zero:attach', nPlayer, source)

                        Player(source).state.BlockTasks = false
                        Player(nPlayer).state.BlockTasks = false

                        ClearPedTasks(ply)
                        ClearPedTasks(GetPlayerPed(source))
                        
                        Player(nPlayer).state.Handcuff = true
                        zeroClient.setHandcuffed(nPlayer, true)

                        TriggerClientEvent('zero_sound:source', source, 'cuff', 0.1)
                        TriggerClientEvent('zero_sound:source', nPlayer, 'cuff', 0.1)
                        TriggerClientEvent('zero_interactions:algemas', nPlayer, 'colocar')

                        zero.giveInventoryItem(user_id, 'chave-algema', 1)
                    end)
                else
                    TriggerClientEvent('notify', source, 'Interação Algemar', 'Você não possui uma <b>algema</b>.')
                end
            end
        end
    end
end)

RegisterNetEvent('zero_interactions:capuz', function(value)
    local source = source
    local user_id = zero.getUserId(source)
    if (user_id) then
        if (value == 'colocar') then
            if (zeroClient.getNoCarro(source)) then return; end;
            if (zeroClient.isHandcuffed(source)) then return; end;
            if (GetSelectedPedWeapon(GetPlayerPed(source)) ~= GetHashKey('WEAPON_UNARMED')) then TriggerClientEvent('notify', source, 'Interação Algemar', 'Sua <b>mão</b> está ocupada.') return; end;

            local nPlayer = zeroClient.getNearestPlayer(source, 2.0)
            if (nPlayer) then
                local cooldown = 'capuz:'..nPlayer
                if (exports.zero_core:GetCooldown(cooldown)) then
                    TriggerClientEvent('notify', source, 'Interação Capuz', 'Aguarde <b>'..exports.zero_core:GetCooldown(cooldown)..' segundos</b> para encapuzar novamente.')
                    return
                end
                exports.zero_core:CreateCooldown(cooldown, 10)

                if (zeroClient.getNoCarro(nPlayer)) then return; end;
                if (not zeroClient.isHandcuffed(nPlayer)) then TriggerClientEvent('notify', source, 'Interação Capuz', 'Você não pode <b>encapuzar</b> uma pessoa desalgemada.') return; end;
                if (zeroClient.isCapuz(nPlayer)) then TriggerClientEvent('notify', source, 'Interação Capuz', 'O mesmo já está <b>encapuzado</b>.') return; end;
                
                if (not zero.tryGetInventoryItem(user_id, 'capuz', 1)) then TriggerClientEvent('notify', source, 'Interação Capuz', 'Você não possui um <b>capuz</b> em seu inventário.') return; end;

                Player(nPlayer).state.Capuz = true
                zeroClient.setCapuz(nPlayer, true)
            end
        else
            if (zeroClient.getNoCarro(source)) then return; end;
            if (GetSelectedPedWeapon(GetPlayerPed(source)) ~= GetHashKey('WEAPON_UNARMED')) then TriggerClientEvent('notify', source, 'Interação Algemar', 'Sua <b>mão</b> está ocupada.') return; end;
            
            local nPlayer = zeroClient.getNearestPlayer(source, 2.0)
            if (nPlayer) then
                if (zeroClient.getNoCarro(nPlayer)) then return; end;
                if (not zeroClient.isCapuz(nPlayer)) then TriggerClientEvent('notify', source, 'Interação Capuz', 'O mesmo não está <b>encapuzado</b>') return; end;

                Player(nPlayer).state.Capuz = false
                zeroClient.setCapuz(nPlayer, false)
                zero.giveInventoryItem(user_id, 'capuz', 1)
            end
        end
    end
end)

RegisterNetEvent('zero_interactions:namorar', function()

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
                    Player(nPlayer).state.Capuz = false
                    zeroClient.setCapuz(nplayer, false)
                    zero.giveInventoryItem(user_id, 'capuz', 1)
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
	if (zero.hasPermission(user_id, 'polpar.permissao')) then
        if (zeroClient.isInVehicle(source)) then
            TriggerClientEvent('notify', source, 'Colocar no veículo', 'Você não pode utilizar este comando de dentro de um <b>veículo</b>.')
            return
        end

		local nplayer = zeroClient.getNearestPlayer(source, 2.0)
		if (nplayer) then
			local nUser = zero.getUserId(nplayer)
			local nIdentity = zero.getUserIdentity(nUser)
            zeroClient.putInNearestVehicleAsPassenger(nplayer, 5)
			zero.webhook('PoliceCommands', '```prolog\n[/CV]\n[USER_ID]: #'..user_id..' '..identity.firstname..' '..identity.lastname..'\n[DEU CV NO]\n[JOGADOR]: #'..nUser..' '..nIdentity.firstname..' '..nIdentity.lastname..' '..os.date('\n[DATA]: %d/%m/%Y [HORA]: %H:%M:%S')..' \r```')
        else
            TriggerClientEvent('notify', source, 'Colocar Veículo', 'Você não se encontra próximo de um <b>cidadão</b>.')
        end
	end
end)

RegisterNetEvent('zero_interactions:rv', function()
    local source = source
	local user_id = zero.getUserId(source)
    local identity = zero.getUserIdentity(user_id)
	if (zero.hasPermission(user_id, 'polpar.permissao')) then
        if (zeroClient.isInVehicle(source)) then
            TriggerClientEvent('notify', source, 'Retirar do veículo', 'Você não pode utilizar este comando de dentro de um <b>veículo</b>.')
            return
        end

		local nplayer = zeroClient.getNearestPlayer(source, 2.0)
		if (nplayer) then
			local nUser = zero.getUserId(nplayer)
			local nIdentity = zero.getUserIdentity(nUser)
            zeroClient.ejectVehicle(nplayer)
			zero.webhook('PoliceCommands', '```prolog\n[/RV]\n[USER_ID]: #'..user_id..' '..identity.firstname..' '..identity.lastname..'\n[DEU RV NO]\n[JOGADOR]: #'..nUser..' '..nIdentity.firstname..' '..nIdentity.lastname..' '..os.date('\n[DATA]: %d/%m/%Y [HORA]: %H:%M:%S')..' \r```')
        else
            TriggerClientEvent('notify', source, 'Retirar Veículo', 'Você não se encontra próximo de um <b>cidadão</b>.')
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