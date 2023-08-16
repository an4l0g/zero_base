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

zero._prepare('zero_relationship/getUser', 'select * from relationship where user_1 = @user')
zero._prepare('zero_relationship/updateRelation', 'update relationship set relation = @relation where user_1 = @user')
zero._prepare('zero_relationship/createRelation', 'insert into relationship (user_1, user_2, relation, start_relationship) values (@user_1, @user_2, @relation, @start_relationship)')
zero._prepare('zero_relationship/deleteRelation', 'delete from relationship where user_1 = @user')

local CheckUser = function(user_id)
    local query = zero.query('zero_relationship/getUser', { user = user_id })[1]
    if (query) then
        return true, query.user_2, query.relation, query.start_relationship
    end
    return false
end
exports('CheckUser', CheckUser)

RegisterNetEvent('zero_interactions:relacionamento', function()
    local source = source
    local user_id = zero.getUserId(source)
	if (user_id) then
        local relation, couple, status, date = CheckUser(user_id)
        if (not relation) then TriggerClientEvent('notify', source, 'Checar relacionamento', 'Você não está em um <b>relacionamento</b> 🤣.') return; end;

        local nIdentity = zero.getUserIdentity(couple)
        TriggerClientEvent('notify', source, 'Checar relacionamento', 'Informações do seu relacionamento: <br><br>- Você está: <b>'..status..'</b><br>- Cônjugue: <b>'..nIdentity.firstname..' '..nIdentity.lastname..'</b><br>- Início do seu relacionamento: ( <b>'..os.date('\n%d/%m/%Y', tonumber(date))..'</b> )', 10000)
    end
end)

RegisterNetEvent('zero_interactions:noivar', function()
    local source = source
    local user_id = zero.getUserId(source)
	if (user_id) then
        local relation, couple, status = CheckUser(user_id)
        if (not relation) then TriggerClientEvent('notify', source, 'Pedido de casamento', 'Você não está em um <b>relacionamento</b> 🤣.') return; end;
        if (status == 'Noivo(a)') then TriggerClientEvent('notify', source, 'Pedido de casamento', 'Você já está <b>noivado(a)</b> criatura.') return; end;

        local identity = zero.getUserIdentity(user_id)
        local nPlayer = zeroClient.getNearestPlayer(source, 2.0)
        if (nPlayer) then
            local nUser = zero.getUserId(nPlayer)
            if (couple ~= nUser) then TriggerClientEvent('notify', source, 'Pedido de casamento', 'Você não é <b>namorado(a)</b> desta pessoa talarico(a).') return; end;
            if (nUser) then
                local nIdentity = zero.getUserIdentity(nUser)
                if (zero.request(source, 'Você gostaria de pedir o(a) '..nIdentity.firstname..' '..nIdentity.lastname..' em casamento?', 30000)) then
                    if (zero.request(nPlayer, 'Você gostaria de aceitar o pedido de casamento de '..identity.firstname..' '..identity.lastname..'?', 30000)) then
                        TriggerClientEvent('notify', nPlayer, 'Pedido de casamento', 'Parabéns aos pombinhos! Agora vocês são <b>noivos</b>.')
                        TriggerClientEvent('notify', source, 'Pedido de casamento', 'Parabéns aos pombinhos! Agora vocês são <b>noivos</b>.')

                        zero.execute('zero_relationship/updateRelation', { user = user_id, relation = 'Noivo(a)' })
                        zero.execute('zero_relationship/updateRelation', { user = nUser, relation = 'Noivo(a)' })

                        zero.webhook('Noivar', '```prolog\n[RELATION SHIP]\n[ACTION]: (MARRIAGE PROPOSAL)\n[USER]: '..user_id..'\n[TARGET]: '..nUser..os.date('\n[DATE]: %d/%m/%Y [HOUR]: %H:%M:%S')..' \r```')
                    else
                        TriggerClientEvent('notify', source, 'Pedido de casamento', 'O seu pedido de <b>casamento</b> foi negado.')
                    end
                end
            end
        end
    end
end)

RegisterNetEvent('zero_interactions:namorar', function()
    local source = source
    local user_id = zero.getUserId(source)
	if (user_id) then
        if (CheckUser(user_id)) then TriggerClientEvent('notify', source, 'Pedido de namoro', 'Você já está <b>namorando</b> sapeca.') return; end;
        local identity = zero.getUserIdentity(user_id)
        local nPlayer = zeroClient.getNearestPlayer(source, 2.0)
        if (nPlayer) then
            local nUser = zero.getUserId(nPlayer)
            if (CheckUser(nUser)) then TriggerClientEvent('notify', source, 'Pedido de namoro', 'Está pessoa já está <b>namorando</b> talarico(a).') return; end;
            if (nUser) then
                local nIdentity = zero.getUserIdentity(nUser)
                if (zero.request(source, 'Você gostaria de pedir o(a) '..nIdentity.firstname..' '..nIdentity.lastname..' em namoro?', 30000)) then
                    if (zero.request(nPlayer, 'Você gostaria de aceitar o pedido de namoro de '..identity.firstname..' '..identity.lastname..'?', 30000)) then
                        TriggerClientEvent('notify', nPlayer, 'Pedido de namoro', 'Parabéns aos pombinhos! Agora vocês estão <b>namorando</b>.')
                        TriggerClientEvent('notify', source, 'Pedido de namoro', 'Parabéns aos pombinhos! Agora vocês estão <b>namorando</b>.')

                        zero.execute('zero_relationship/createRelation', { user_1 = user_id, user_2 = nUser, relation = 'Namorando', start_relationship = os.time() })
                        zero.execute('zero_relationship/createRelation', { user_1 = nUser, user_2 = user_id, relation = 'Namorando', start_relationship = os.time() })

                        zero.webhook('Namorar', '```prolog\n[RELATION SHIP]\n[ACTION]: (START RELATION)\n[USER]: '..user_id..'\n[TARGET]: '..nUser..os.date('\n[DATE]: %d/%m/%Y [HOUR]: %H:%M:%S')..' \r```')
                    else
                        TriggerClientEvent('notify', source, 'Pedido de namoro', 'O seu pedido de <b>namoro</b> foi negado.')
                    end
                end
            end
        end
    end
end)

RegisterNetEvent('zero_interactions:terminar', function()
    local source = source
    local user_id = zero.getUserId(source)
	if (user_id) then
        local relation, couple, status = CheckUser(user_id)
        if (not relation) then TriggerClientEvent('notify', source, 'Terminar relacionamento', 'Você não está em um <b>relacionamento</b> 🤣.') return; end;

        local text = (status == 'Namorando' and 'namoro' or 'noivado')
        local identity = zero.getUserIdentity(couple)
        if (zero.request(source, 'Você tem certeza que deseja terminar o seu '..text..' com o(a) '..identity.firstname..' '..identity.lastname..'?', 30000)) then
            TriggerClientEvent('notify', source, 'Terminar relacionamento', 'Parabéns parceiro(a)! Agora você está na <b>pista</b>.')
            TriggerClientEvent('notify', zero.getUserSource(couple), 'Terminar relacionamento', 'Parabéns parceiro(a)! Agora você está na <b>pista</b>.')

            zero.execute('zero_relationship/deleteRelation', { user = user_id })
            zero.execute('zero_relationship/deleteRelation', { user = couple })

            zero.webhook('Terminar', '```prolog\n[RELATION SHIP]\n[ACTION]: (STOP RELATION)\n[USER]: '..user_id..'\n[TARGET]: '..couple..os.date('\n[DATE]: %d/%m/%Y [HOUR]: %H:%M:%S')..' \r```')
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
	if (user_id) and zero.hasPermission(user_id, 'staff.permissao') then
        if (Player(source).state.Handcuff) then return; end;
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