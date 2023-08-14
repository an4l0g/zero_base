local srv = {}
Tunnel.bindInterface('Wedding', srv)

srv.startWedding = function()
    local source = source
    local user_id = zero.getUserId(source)
    if (user_id) then
        local identity = zero.getUserIdentity(user_id)
        local relation, couple, status = exports[GetCurrentResourceName()]:CheckUser(user_id)
        if (not relation) then TriggerClientEvent('notify', source, 'Casamento', 'Você não está em um <b>relacionamento</b> 🤣.') return; end;
        if (status ~= 'Noivo(a)') then TriggerClientEvent('notify', source, 'Casamento', 'Você precisa ser <b>noivo</b> pra casar precipitado(a) :/.') return; end;
        
        if (zero.getInventoryItemAmount(user_id, 'par-alianca') >= 1) then
            local prompt = zero.prompt(source, { 'Passaporte do(a) noivo(a)' })
            if (prompt) then
                prompt = parseInt(prompt[1])
                if (couple ~= prompt) then TriggerClientEvent('notify', source, 'Casamento', 'Você não é <b>noivo(a)</b> desta pessoa talarico(a).') return; end;
                local nIdentity = zero.getUserIdentity(prompt)
                local nPlayer = zero.getUserSource(prompt)
                if (nPlayer) then
                    if (zero.request(source, 'Você realmente deseja se casar com o(a) '..nIdentity.firstname..' '..nIdentity.lastname..'?', 30000)) then
                        if (zero.request(nPlayer, 'Você aceita se casar com o(a) '..identity.firstname..' '..identity.lastname..'?', 30000)) then
                            TriggerClientEvent('notify', nPlayer, 'Casamento', 'Parabéns aos pombinhos! Agora vocês são <b>casados</b>.')
                            TriggerClientEvent('notify', source, 'Casamento', 'Parabéns aos pombinhos! Agora vocês são <b>casados</b>.')
                            TriggerClientEvent('chatMessage', -1, '[CARTÓRIO]', { 0, 153, 255 }, 'Parabéns aos pombinhos! Agora '..identity.firstname..' '..identity.lastname..' e '..nIdentity.firstname..' '..nIdentity.lastname..' são casados 😍💕')

                            zero.tryGetInventoryItem(user_id, 'par-alianca', 1)
                            zero.giveInventoryItem(user_id, 'alianca-casamento', 1)
                            zero.giveInventoryItem(prompt, 'alianca-casamento', 1)

                            zero.execute('zero_relationship/updateRelation', { user = user_id, relation = 'Casado(a)' })
                            zero.execute('zero_relationship/updateRelation', { user = prompt, relation = 'Casado(a)' })

                            zero.webhook('Casar', '```prolog\n[RELATION SHIP]\n[ACTION]: (WEDDING)\n[USER]: '..user_id..'\n[TARGET]: '..prompt..os.date('\n[DATE]: %d/%m/%Y [HOUR]: %H:%M:%S')..' \r```')
                        else
                            TriggerClientEvent('notify', source, 'Casamento', 'O(a) mesmo(a) se negou a <b>casar</b> com você.')
                        end
                    end
                else
                    TriggerClientEvent('notify', source, 'Casamento', 'O(a) mesmo(a) se encontra <b>offline</b>.')
                end
            end
        else
            TriggerClientEvent('notify', source, 'Casamento', 'Você não possui um <b>par de alianças</b>.')
        end
    end
end

srv.startDivorce = function()
    local source = source
    local user_id = zero.getUserId(source)
    if (user_id) then
        local identity = zero.getUserIdentity(user_id)
        local relation, couple, status = exports[GetCurrentResourceName()]:CheckUser(user_id)
        if (not relation) then TriggerClientEvent('notify', source, 'Divórcio', 'Você não está em um <b>relacionamento</b> 🤣.') return; end;
        if (status ~= 'Casado(a)') then TriggerClientEvent('notify', source, 'Divórcio', 'Você precisa ser <b>casado</b> para se divórcia de alguém.') return; end;
        
        local prompt = zero.prompt(source, { 'Passaporte do(a) esposo(a)' })
        if (prompt) then
            prompt = parseInt(prompt[1])
            if (couple ~= prompt) then TriggerClientEvent('notify', source, 'Divórcio', 'Você não é <b>casado(a)</b> com esta pessoa.') return; end;
            local nIdentity = zero.getUserIdentity(prompt)
            local nPlayer = zero.getUserSource(prompt)
            if (nPlayer) then
                if (zero.request(source, 'Você tem certeza que deseja se divorciar do(a) '..nIdentity.firstname..' '..nIdentity.lastname..'?', 30000)) then
                    TriggerClientEvent('notify', nPlayer, 'Casamento', 'Parabéns aos pombinhos! Agora vocês não tem mais um <b>peso</b> nas costas.')
                    TriggerClientEvent('notify', source, 'Casamento', 'Parabéns aos pombinhos! Agora vocês não tem mais um <b>peso</b> nas costas.')

                    zero.tryGetInventoryItem(user_id, 'alianca-casamento', 1)
                    zero.tryGetInventoryItem(prompt, 'alianca-casamento', 1)
                    
                    zero.execute('zero_relationship/deleteRelation', { user = user_id })
                    zero.execute('zero_relationship/deleteRelation', { user = prompt })

                    zero.webhook('Divorciar', '```prolog\n[RELATION SHIP]\n[ACTION]: (DIVORCE)\n[USER]: '..user_id..'\n[TARGET]: '..prompt..os.date('\n[DATE]: %d/%m/%Y [HOUR]: %H:%M:%S')..' \r```')
                end
            else
                TriggerClientEvent('notify', source, 'Casamento', 'O(a) mesmo(a) se encontra <b>offline</b>.')
            end
        end
    end
end