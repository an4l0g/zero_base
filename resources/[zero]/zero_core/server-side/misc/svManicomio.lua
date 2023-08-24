local typeManicomio = {
    ['colocar'] = function(source, user_id)
        local prompt = exports.zero_hud:prompt(source, {
            'Passaporte do jogador', 'Motivo da prisão', 'Tempo da prisão'
        })

        if (prompt) and prompt[1] and prompt[2] and prompt[3] then
            local nUser = parseInt(prompt[1])
            local Reason = prompt[2]
            local Time = parseInt(prompt[3])

            local nIdentity = zero.getUserIdentity(nUser)
            local request = exports.zero_hud:request(source, 'Você tem certeza que deseja prender o '..nIdentity.firstname..' '..nIdentity.lastname..' por '..Time..' meses?', 60000)
            if (request) then
                local nSource = zero.getUserSource(nUser)
                if (nSource) then
                    local oldTime = (json.decode(zero.getUData(user_id, 'zero:prison_adm')) or 0)
                    zero.setUData(nUser, 'zero:prison_adm', json.encode(parseInt(oldTime + Time)))

                    if (zeroClient.isHandcuffed(nSource)) then
                        Player(nSource).state.Handcuff = false
                        zeroClient.setHandcuffed(nSource, false)
                        TriggerClientEvent('zero_core:uncuff', nSource)
                    end
                    
                    local prisonCoord = vector4(-110.6769, 7488.092, 5.808105, 201.2598)
                    SetEntityHeading(GetPlayerPed(nSource), prisonCoord.w)
                    zeroClient.teleport(nSource, prisonCoord.x, prisonCoord.y, prisonCoord.z)
                    TriggerClientEvent('zero_animations:setAnim', nSource, 'deitar3')
                    TriggerClientEvent('zero_prison:setClothes', nSource)

                    manicomioLock(nSource, nUser)
                    
                    TriggerClientEvent('zero_sound:source', nSource, 'jaildoor', 0.3)
					TriggerClientEvent('zero_sound:source', source, 'jaildoor', 0.3)

                    TriggerClientEvent('notify', source, 'Manicômio', 'Você prendeu o <b>'..nIdentity.firstname..' '..nIdentity.lastname..'</b> por <b>'..Time..' meses</b>.')
                    TriggerClientEvent('notify', nSource, 'Manicômio', 'Você foi preso por <b>'..Time..' meses</b>.')

                    Player(nSource).state.Asylum = true

                    zeroClient.playSound(source, 'Hack_Success', 'DLC_HEIST_BIOLAB_PREP_HACKING_SOUNDS')

                    zero.webhook('Manicomio', '```prolog\n[ASYLUM]\n[ACTION]: (LEARN)\n[STAFF]: '..user_id..'\n[TARGET]: '..nUser..'\n[REASON]: '..Reason..'\n[TIME]: '..Time..' months'..os.date('\n[DATE]: %d/%m/%Y [HOUR]: %H:%M:%S')..' \r```')
                else
                    TriggerClientEvent('notify', source, 'Manicômio', 'O mesmo se encontra <b>offline</b>!')
                end
            end
        end
    end,
    ['retirar'] = function(source, user_id)
        local prompt = exports.zero_hud:prompt(source, {
            'Passaporte do jogador', 'Motivo'
        })

        if (prompt) and prompt[1] and prompt[2] then
            local nUser = parseInt(prompt[1])
            local Reason = prompt[2]

            local nIdentity = zero.getUserIdentity(nUser)
            local request = exports.zero_hud:request(source, 'Você tem certeza que deseja soltar o '..nIdentity.firstname..' '..nIdentity.lastname..'?', 60000)
            if (request) then
                local nSource = zero.getUserSource(nUser)
                if (nSource) then
                    Player(nSource).state.Asylum = false
                    zero.setUData(nUser, 'zero:prison_adm', json.encode(-1))
                    SetEntityHeading(GetPlayerPed(nSource), 201.2598)
                    zeroClient.teleport(nSource, -110.6769, 7488.092, 5.808105)

                    TriggerClientEvent('notify', nSource, 'Manicômio', 'Você foi <b>solto</b>!')
                    TriggerClientEvent('notify', source, 'Manicômio', 'Você soltou o <b>'..nIdentity.firstname..' '..nIdentity.lastname..'</b>.')

                    zero.webhook('Manicomio', '```prolog\n[ASYLUM]\n[ACTION]: (UNFASTEN)\n[STAFF]: '..user_id..'\n[TARGET]: '..nUser..'\n[REASON]: '..Reason..os.date('\n[DATE]: %d/%m/%Y [HOUR]: %H:%M:%S')..' \r```')
                else
                    TriggerClientEvent('notify', source, 'Manicômio', 'O mesmo se encontra <b>offline</b>!')
                end
            end
        end        
    end
}

RegisterCommand('manicomio', function(source, args)
    local user_id = zero.getUserId(source)
    if (user_id) and zero.checkPermissions(user_id, { 'staff.permissao' }) then
        if (args[1]) then
            if (typeManicomio[args[1]]) then
                typeManicomio[args[1]](source, user_id)
            else
                TriggerClientEvent('notify', source, 'Manicômio', 'Você não especificou o que deseja fazer, tente novamente com: <br><br><b>- /manicomio colocar<br>- /manicomio retirar', 6000)
            end
        else
            TriggerClientEvent('notify', source, 'Manicômio', 'Você não especificou o que deseja fazer, tente novamente com: <br><br><b>- /manicomio colocar<br>- /manicomio retirar', 6000)
        end
    end
end)

RegisterNetEvent('zero_interactions:manicomio', function()
    local source = source
    local user_id = zero.getUserId(source)
    if (user_id) and zero.checkPermissions(user_id, { 'staff.permissao' }) then
        typeManicomio['colocar'](source, user_id)
    end
end)

RegisterNetEvent('zero_interactions:rmanicomio', function()
    local source = source
    local user_id = zero.getUserId(source)
    if (user_id) and zero.checkPermissions(user_id, { 'staff.permissao' }) then
        typeManicomio['retirar'](source, user_id)
    end
end)

manicomioLock = function(source, user_id)
    Citizen.SetTimeout(60000, function()
        local time = (json.decode(zero.getUData(user_id, 'zero:prison_adm')) or 0)
        time = parseInt(time)
        if (time > 0) then
            zero.setUData(user_id, 'zero:prison_adm', json.encode(time - 1))
            TriggerClientEvent('notify',source, 'Manicômio', 'Você ainda vai passar <b>'..time..' meses</b> preso.')
            manicomioLock(source, user_id)
        else
            Player(source).state.Asylum = false
            zero.setUData(user_id, 'zero:prison_adm', json.encode(-1))
            SetEntityHeading(GetPlayerPed(source), 201.2598)
            zeroClient.teleport(source, -110.6769, 7488.092, 5.808105)
            TriggerClientEvent('notify', source, 'Manicômio', 'Sua <b>sentença</b> terminou.')
        end
        zeroClient.killGod(source)
    end)
end