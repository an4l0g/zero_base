local typePrender = {
    ['colocar'] = function(source, user_id)
        local prompt = exports.zero_hud:prompt(source, {
            'Passaporte do criminoso', 'Motivo da prisão', 'Listar itens ilegais encontrados com o criminoso', 'Tempo da prisão'
        })

        if (prompt) and prompt[1] and prompt[2] and prompt[3] and prompt[4] then
            local nUser = parseInt(prompt[1])
            local Reason = prompt[2]
            local Itens = prompt[3]
            local Time = parseInt(prompt[4])
            
            if (user_id == nUser) then TriggerClientEvent('notify', source, 'Prisão', 'Você não pode se <b>prender</b>!') return; end;

            local nIdentity = zero.getUserIdentity(nUser)
            local request = exports.zero_hud:request(source, 'Você tem certeza que deseja prender o '..nIdentity.firstname..' '..nIdentity.lastname..' por '..Time..' meses?', 60000)
            if (request) then
                local nSource = zero.getUserSource(nUser)
                if (nSource) then
                    zero.setUData(nUser, 'zero:prison', json.encode(Time))
                    zero.setUData(nUser, 'zero:ficha_suja', json.encode(1))

                    if (zeroClient.isHandcuffed(nSource)) then
                        Player(nSource).state.Handcuff = false
                        zeroClient.setHandcuffed(nSource, false)
                        TriggerClientEvent('zero_core:uncuff', nSource)
                    end
                    
                    local prisonCoord = vector4(1753.358, 2470.998, 47.39343, 28.34646)
                    SetEntityHeading(GetPlayerPed(nSource), prisonCoord.w)
                    zeroClient.teleport(nSource, prisonCoord.x, prisonCoord.y, prisonCoord.z)
                    TriggerClientEvent('zero_animations:setAnim', nSource, 'deitar3')
                    TriggerClientEvent('zero_prison:setClothes', nSource)

                    prisonLock(nSource, nUser)
                    exports.zero_inventory:clearInventory(nUser)
                    
                    TriggerClientEvent('zero_sound:source', nSource, 'jaildoor', 0.3)
					TriggerClientEvent('zero_sound:source', source, 'jaildoor', 0.3)

                    TriggerClientEvent('notify', source, 'Prisão', 'Você prendeu o <b>'..nIdentity.firstname..' '..nIdentity.lastname..'</b> por <b>'..Time..' meses</b>.')
                    TriggerClientEvent('notify', nSource, 'Prisão', 'Você foi preso por <b>'..Time..' meses</b>.')

                    Player(nSource).state.Prison = true

                    zeroClient.playSound(source, 'Hack_Success', 'DLC_HEIST_BIOLAB_PREP_HACKING_SOUNDS')

                    zero.webhook('Prender', '```prolog\n[PRISON]\n[ACTION]: (LEARN)\n[OFFICER]: '..user_id..'\n[TARGET]: '..nUser..'\n[REASON]: '..Reason..'\n[ITENS]: '..Itens..'\n[TIME]: '..Time..' months'..os.date('\n[DATE]: %d/%m/%Y [HOUR]: %H:%M:%S')..' \r```')
                else
                    TriggerClientEvent('notify', source, 'Prisão', 'O mesmo se encontra <b>offline</b>!')
                end
            end
        end
    end,
    ['retirar'] = function(source, user_id)
        local prompt = exports.zero_hud:prompt(source, {
            'Passaporte do criminoso', 'Motivo'
        })

        if (prompt) and prompt[1] and prompt[2] then
            local nUser = parseInt(prompt[1])
            local Reason = prompt[2]

            if (user_id == nUser) then TriggerClientEvent('notify', source, 'Prisão', 'Você não pode se retirar da <b>prisão</b>!') return; end;

            local nIdentity = zero.getUserIdentity(nUser)
            local request = exports.zero_hud:request(source, 'Você tem certeza que deseja soltar o '..nIdentity.firstname..' '..nIdentity.lastname..'?', 60000)
            if (request) then
                local nSource = zero.getUserSource(nUser)
                if (nSource) then
                    Player(nSource).state.Prison = false
                    zero.setUData(nUser, 'zero:prison', json.encode(-1))
                    SetEntityHeading(GetPlayerPed(nSource), 266.45669555664)
                    zeroClient.teleport(nSource, 1853.604, 2608.272, 45.65784)

                    TriggerClientEvent('notify', nSource, 'Prisão', 'Você foi <b>solto</b>!')
                    TriggerClientEvent('notify', source, 'Prisão', 'Você soltou o <b>'..nIdentity.firstname..' '..nIdentity.lastname..'</b>.')

                    zero.webhook('RetirarPrisao', '```prolog\n[PRISON]\n[ACTION]: (UNFASTEN)\n[OFFICER]: '..user_id..'\n[TARGET]: '..nUser..'\n[REASON]: '..Reasonos.date('\n[DATE]: %d/%m/%Y [HOUR]: %H:%M:%S')..' \r```')
                else
                    TriggerClientEvent('notify', source, 'Prisão', 'O mesmo se encontra <b>offline</b>!')
                end
            end
        end        
    end
}

RegisterCommand('prender', function(source, args)
    local user_id = zero.getUserId(source)
    if (user_id) and zero.checkPermissions(user_id, { 'staff.permissao', 'policia.permissao' }) then
        if (args[1]) then
            if (typePrender[args[1]]) then
                typePrender[args[1]](source, user_id)
            else
                TriggerClientEvent('notify', source, 'Prender', 'Você não especificou o que deseja fazer, tente novamente com: <br><br><b>- /prender colocar<br>- /prender retirar', 6000)
            end
        else
            TriggerClientEvent('notify', source, 'Prender', 'Você não especificou o que deseja fazer, tente novamente com: <br><br><b>- /prender colocar<br>- /prender retirar', 6000)
        end
    end
end)

RegisterNetEvent('zero_interactions:prender', function()
    local source = source
    local user_id = zero.getUserId(source)
    if (user_id) and zero.checkPermissions(user_id, { 'staff.permissao', 'policia.permissao' }) then
        typePrender['colocar'](source, user_id)
    end
end)

RegisterNetEvent('zero_interactions:tirarprisao', function()
    local source = source
    local user_id = zero.getUserId(source)
    if (user_id) and zero.checkPermissions(user_id, { 'staff.permissao', 'policia.permissao' }) then
        typePrender['retirar'](source, user_id)
    end
end)

prisonLock = function(source, user_id)
    Citizen.SetTimeout(60000, function()
        local time = (json.decode(zero.getUData(user_id, 'zero:prison')) or 0)
        time = parseInt(time)
        if (time > 0) then
            zero.setUData(user_id, 'zero:prison', json.encode(time - 1))
            TriggerClientEvent('notify',source, 'Prisão', 'Você ainda vai passar <b>'..time..' meses</b> preso.')
            prisonLock(source, user_id)
        else
            Player(source).state.Prison = false
            zero.setUData(user_id, 'zero:prison', json.encode(-1))
            SetEntityHeading(GetPlayerPed(source), 266.45669555664)
            zeroClient.teleport(source, 1853.604, 2608.272, 45.65784)
            TriggerClientEvent('notify', source, 'Prisão', 'Sua <b>sentença</b> terminou.')
        end
        zeroClient.killGod(source)
    end)
end

AddEventHandler('vRP:playerSpawn', function(user_id, source, first_spawn)
    local tempo = (json.decode(zero.getUData(parseInt(user_id),'zero:prison')) or -1)
    if (tempo == -1) then return; end;

    if (tempo > 0) then
        local prisonCoord = vector4(1753.358, 2470.998, 47.39343, 28.34646)
        SetEntityHeading(GetPlayerPed(source), prisonCoord.w)
        zeroClient.teleport(source, prisonCoord.x, prisonCoord.y, prisonCoord.z)
        TriggerClientEvent('zero_animations:setAnim', source, 'deitar3')

        Citizen.SetTimeout(5000, function()    
            TriggerClientEvent('zero_prison:setClothes', source)
            prisonLock(source, user_id)
            Player(source).state.Prison = true
        end)
    end
end)