local typePrender = {
    ['colocar'] = function(source)
        local prompt = exports.zero_hud:prompt(source, {
            'Passaporte do criminoso', 'Motivo da prisão', 'Listar itens ilegais encontrados com o criminoso', 'Tempo da prisão'
        })

        if (prompt) and prompt[1] and prompt[2] and prompt[3] then
            local nUser = parseInt(prompt[1])
            local Reason = prompt[2]
            local Itens = prompt[3]
            local Time = parseInt(prompt[4])
            
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
                    zeroClient.teleport(nSource, prisonCoord.x, prisonCoord.y, prisonCoord.z)
                    SetEntityHeading(GetPlayerPed(nSource), prisonCoord.w)
                    TriggerClientEvent('zero_animations:setAnim', nSource, 'deitar3')

                    prisonLock(nSource, nUser)
                    exports.zero_inventory:clearInventory(nUser)
                    
                    TriggerClientEvent('zero_sound:source', nSource, 'jaildoor', 0.3)
					TriggerClientEvent('zero_sound:source', source, 'jaildoor', 0.3)

                    TriggerClientEvent('notify', source, 'Prisão', 'Você prendeu o <b>'..nIdentity.firstname..' '..nIdentity.lastname..'</b> por <b>'..Time..' meses</b>.')
                    TriggerClientEvent('notify', nSource, 'Prisão', 'Você foi preso por <b>'..Time..' meses</b>.')

                    Player(nSource).state.Prison = true

                    zeroClient.playSound(source, 'Hack_Success', 'DLC_HEIST_BIOLAB_PREP_HACKING_SOUNDS')
                else
                    TriggerClientEvent('notify', source, 'Prisão', 'O mesmo se encontra <b>offline</b>!')
                end
            end
        end
    end,
    ['retirar'] = function(source)
        
    end
}

RegisterCommand('prender', function(source, args)
    local source = source
    local user_id = zero.getUserId(source)
    if (user_id) and zero.checkPermissions(user_id, { 'staff.permissao', 'policia.permissao' }) then
        if (args[1]) then
            if (typePrender[args[1]]) then
                typePrender[args[1]](source)
            else
                TriggerClientEvent('notify', source, 'Prender', 'Você não especificou o que deseja fazer, tente novamente com: <br><br><b>- /prender colocar<br>- /prender retirar', 6000)
            end
        else
            TriggerClientEvent('notify', source, 'Prender', 'Você não especificou o que deseja fazer, tente novamente com: <br><br><b>- /prender colocar<br>- /prender retirar', 6000)
        end
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
            zeroClient.teleport(source, 1853.604, 2608.272, 45.65784)
            TriggerClientEvent('notify', source, 'Prisão', 'Sua <b>sentença</b> terminou.')
        end
        zeroClient.killGod(source)
    end)
end