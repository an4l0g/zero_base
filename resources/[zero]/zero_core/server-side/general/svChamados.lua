local callBlips = {}

local callType = {
    ['adm'] = function(source, user_id, cooldown, pCoord, identity)
        local answered = false
        local answeredBy = false

        zeroClient._CarregarObjeto(source, 'cellphone@', 'cellphone_call_to_text', 'prop_amb_phone', 50, 28422)

        local prompt = exports.zero_hud:prompt(source, { 
            'Descrição do chamado'
        })

        if (prompt) then
            prompt = tostring(prompt[1])

            exports[GetCurrentResourceName()]:CreateCooldown(cooldown, 300)

            local perm = zero.getUsersByPermission('staff.permissao')
            if (#perm == 0) then
                TriggerClientEvent('notify', source, 'Chamados', 'Não há <b>STAFF</b> em serviço no momento.')
            else
                zeroClient.playSound(source, 'Event_Message_Purple', 'GTAO_FM_Events_Soundset')
                TriggerClientEvent('notify', source, 'Chamados', 'O <b>chamado</b> foi enviado com sucesso!')
                
                for k, v in pairs(perm) do
                    local nSource = zero.getUserSource(parseInt(v))
                    if (nSource) then
                        local nUser = zero.getUserId(nSource)
                        local nIdentity = zero.getUserIdentity(nUser)

                        async(function()
                            zeroClient.playSound(nSource, 'Out_Of_Area', 'DLC_Lowrider_Relay_Race_Sounds')
                            TriggerClientEvent('chatMessage', nSource, '[CHAMADO ADM] '..user_id..' | '..identity.firstname..' '..identity.lastname, {0, 153, 255}, tostring(prompt))
                            
                            local request = exports.zero_hud:request(nSource, 'Você deseja aceitar o chamado de '..identity.firstname..' '..identity.lastname..'?', 15000)
                            if (request) then
                                if (not answered) then
                                    answered = true
                                    answeredBy = nUser

                                    zeroClient.playSound(source, 'Event_Message_Purple', 'GTAO_FM_Events_Soundset')
                                    TriggerClientEvent('notify', source, 'Chamados', 'O seu chamado foi atendido por <b>'..nIdentity.firstname..' '..nIdentity.lastname..'</b>, aguarde no local.')
                                else
                                    TriggerClientEvent('notify', nSource, 'Chamados', 'Este <b>chamado</b> ja foi atendido por outro staff.')
									zeroClient.playSound(nSource, 'CHECKPOINT_MISSED', 'HUD_MINI_GAME_SOUNDSET')
                                end
                            end

                            local id = idgens:gen()
							callBlips[id] = zeroClient.addBlip(nSource, pCoord.x, pCoord.y, pCoord.z, 358, 71, 'Chamado ~b~STAFF~w~', 0.6, false)
							Citizen.SetTimeout(30000, function() zeroClient.removeBlip(nSource, callBlips[id]) idgens:free(id) end)
                        end)
                    end
                end
            end

            Citizen.SetTimeout(35000, function()
                if (not answeredBy) then answeredBy = 'Não atendido'; end;
                zero.webhook('Chamados', '```prolog\n[CHAMADOS]\n[CALL TYPE]: (STAFF)\n[USER]: '..user_id..'\n[SERVERD BY]: '..answeredBy..'\n[ADMINS IN SERVICE]: '..#perm..' \n[COORD]: '..tostring(pCoord)..os.date('\n[DATE]: %d/%m/%Y [HOUR]: %H:%M:%S')..' \r```')
            end)
        end

        zeroClient.DeletarObjeto(source)
    end,
    ['hp'] = function(source, user_id, cooldown, pCoord, identity)
        if (GetEntityHealth(GetPlayerPed(source)) <= 100) then
            TriggerClientEvent('notify', source, 'Chamados', 'Você não pode realizar um <b>chamado</b> morto!')
            return false
        end

        local answered = false
        local answeredBy = false

        zeroClient._CarregarObjeto(source, 'cellphone@', 'cellphone_call_to_text', 'prop_amb_phone', 50, 28422)

        local prompt = exports.zero_hud:prompt(source, { 
            'Descrição do chamado'
        })

        if (prompt) then
            prompt = tostring(prompt[1])

            exports[GetCurrentResourceName()]:CreateCooldown(cooldown, 300)

            local perm = zero.getUsersByPermission('hospital.permissao')
            if (#perm == 0) then
                TriggerClientEvent('notify', source, 'Chamados', 'Não há <b>PARAMÉDICOS</b> em serviço no momento.')
            else
                zeroClient.playSound(source, 'Event_Message_Purple', 'GTAO_FM_Events_Soundset')
                TriggerClientEvent('notify', source, 'Chamados', 'O <b>chamado</b> foi enviado com sucesso!')
                
                for k, v in pairs(perm) do
                    local nSource = zero.getUserSource(parseInt(v))
                    if (nSource) then
                        local nUser = zero.getUserId(nSource)
                        local nIdentity = zero.getUserIdentity(nUser)

                        async(function()
                            zeroClient.playSound(nSource, 'Out_Of_Area', 'DLC_Lowrider_Relay_Race_Sounds')
                            TriggerClientEvent('chatMessage', nSource, '[CHAMADO HOSPITAL] '..user_id..' | '..identity.firstname..' '..identity.lastname, {0, 153, 255}, tostring(prompt))
                            
                            local request = exports.zero_hud:request(nSource, 'Você deseja aceitar o chamado de '..identity.firstname..' '..identity.lastname..'?', 15000)
                            if (request) then
                                if (not answered) then
                                    answered = true
                                    answeredBy = nUser

                                    zeroClient.playSound(source, 'Event_Message_Purple', 'GTAO_FM_Events_Soundset')
                                    TriggerClientEvent('notify', source, 'Chamados', 'O seu chamado foi atendido por <b>'..nIdentity.firstname..' '..nIdentity.lastname..'</b>, aguarde no local.')
                                else
                                    TriggerClientEvent('notify', nSource, 'Chamados', 'Este <b>chamado</b> ja foi atendido por outro paramédico.')
									zeroClient.playSound(nSource, 'CHECKPOINT_MISSED', 'HUD_MINI_GAME_SOUNDSET')
                                end
                            end

                            local id = idgens:gen()
							callBlips[id] = zeroClient.addBlip(nSource, pCoord.x, pCoord.y, pCoord.z, 358, 71, 'Chamado ~b~HOSPITAL~w~', 0.6, false)
							Citizen.SetTimeout(30000, function() zeroClient.removeBlip(nSource, callBlips[id]) idgens:free(id) end)
                        end)
                    end
                end
            end

            Citizen.SetTimeout(35000, function()
                if (not answeredBy) then answeredBy = 'Não atendido'; end;
                zero.webhook('Chamados', '```prolog\n[CHAMADOS]\n[CALL TYPE]: (PARAMEDIC)\n[USER]: '..user_id..'\n[SERVERD BY]: '..answeredBy..'\n[PARAMEDICS IN SERVICE]: '..#perm..' \n[COORD]: '..tostring(pCoord)..os.date('\n[DATE]: %d/%m/%Y [HOUR]: %H:%M:%S')..' \r```')
            end)
        end

        zeroClient.DeletarObjeto(source)
    end,
    ['pm'] = function(source, user_id, cooldown, pCoord, identity)
        if (GetEntityHealth(GetPlayerPed(source)) <= 100) then
            TriggerClientEvent('notify', source, 'Chamados', 'Você não pode realizar um <b>chamado</b> morto!')
            return false
        end

        local answered = false
        local answeredBy = false

        zeroClient._CarregarObjeto(source, 'cellphone@', 'cellphone_call_to_text', 'prop_amb_phone', 50, 28422)

        local prompt = exports.zero_hud:prompt(source, { 
            'Descrição do chamado'
        })

        if (prompt) then
            prompt = tostring(prompt[1])

            exports[GetCurrentResourceName()]:CreateCooldown(cooldown, 300)

            local perm = zero.getUsersByPermission('policia.permissao')
            if (#perm == 0) then
                TriggerClientEvent('notify', source, 'Chamados', 'Não há <b>POLICIAS</b> em serviço no momento.')
            else
                zeroClient.playSound(source, 'Event_Message_Purple', 'GTAO_FM_Events_Soundset')
                TriggerClientEvent('notify', source, 'Chamados', 'O <b>chamado</b> foi enviado com sucesso!')
                
                for k, v in pairs(perm) do
                    local nSource = zero.getUserSource(parseInt(v))
                    if (nSource) then
                        local nUser = zero.getUserId(nSource)
                        local nIdentity = zero.getUserIdentity(nUser)

                        async(function()
                            zeroClient.playSound(nSource, 'Out_Of_Area', 'DLC_Lowrider_Relay_Race_Sounds')
                            TriggerClientEvent('chatMessage', nSource, '[CHAMADO POLICIA] '..user_id..' | '..identity.firstname..' '..identity.lastname, {0, 153, 255}, tostring(prompt))
                            
                            local request = exports.zero_hud:request(nSource, 'Você deseja aceitar o chamado de '..identity.firstname..' '..identity.lastname..'?', 15000)
                            if (request) then
                                if (not answered) then
                                    answered = true
                                    answeredBy = nUser

                                    zeroClient.playSound(source, 'Event_Message_Purple', 'GTAO_FM_Events_Soundset')
                                    TriggerClientEvent('notify', source, 'Chamados', 'O seu chamado foi atendido por <b>'..nIdentity.firstname..' '..nIdentity.lastname..'</b>, aguarde no local.')
                                else
                                    TriggerClientEvent('notify', nSource, 'Chamados', 'Este <b>chamado</b> ja foi atendido por outro policial.')
									zeroClient.playSound(nSource, 'CHECKPOINT_MISSED', 'HUD_MINI_GAME_SOUNDSET')
                                end
                            end

                            local id = idgens:gen()
							callBlips[id] = zeroClient.addBlip(nSource, pCoord.x, pCoord.y, pCoord.z, 358, 71, 'Chamado ~b~POLICIA~w~', 0.6, false)
							Citizen.SetTimeout(30000, function() zeroClient.removeBlip(nSource, callBlips[id]) idgens:free(id) end)
                        end)
                    end
                end
            end

            Citizen.SetTimeout(35000, function()
                if (not answeredBy) then answeredBy = 'Não atendido'; end;
                zero.webhook('Chamados', '```prolog\n[CHAMADOS]\n[CALL TYPE]: (POLICE)\n[USER]: '..user_id..'\n[SERVERD BY]: '..answeredBy..'\n[POLICES IN SERVICE]: '..#perm..' \n[COORD]: '..tostring(pCoord)..os.date('\n[DATE]: %d/%m/%Y [HOUR]: %H:%M:%S')..' \r```')
            end)
        end

        zeroClient.DeletarObjeto(source)
    end,
    ['mec'] = function(source, user_id, cooldown, pCoord, identity)
        if (GetEntityHealth(GetPlayerPed(source)) <= 100) then
            TriggerClientEvent('notify', source, 'Chamados', 'Você não pode realizar um <b>chamado</b> morto!')
            return false
        end

        local answered = false
        local answeredBy = false

        zeroClient._CarregarObjeto(source, 'cellphone@', 'cellphone_call_to_text', 'prop_amb_phone', 50, 28422)

        local prompt = exports.zero_hud:prompt(source, { 
            'Descrição do chamado'
        })

        if (prompt) then
            prompt = tostring(prompt[1])

            exports[GetCurrentResourceName()]:CreateCooldown(cooldown, 300)

            local perm = zero.getUsersByPermission('zeromecanica.permissao')
            if (#perm == 0) then
                TriggerClientEvent('notify', source, 'Chamados', 'Não há <b>MECÂNICOS</b> em serviço no momento.')
            else
                zeroClient.playSound(source, 'Event_Message_Purple', 'GTAO_FM_Events_Soundset')
                TriggerClientEvent('notify', source, 'Chamados', 'O <b>chamado</b> foi enviado com sucesso!')
                
                for k, v in pairs(perm) do
                    local nSource = zero.getUserSource(parseInt(v))
                    if (nSource) then
                        local nUser = zero.getUserId(nSource)
                        local nIdentity = zero.getUserIdentity(nUser)

                        async(function()
                            zeroClient.playSound(nSource, 'Out_Of_Area', 'DLC_Lowrider_Relay_Race_Sounds')
                            TriggerClientEvent('chatMessage', nSource, '[CHAMADO MECÂNICA] '..user_id..' | '..identity.firstname..' '..identity.lastname, {0, 153, 255}, tostring(prompt))
                            
                            local request = exports.zero_hud:request(nSource, 'Você deseja aceitar o chamado de '..identity.firstname..' '..identity.lastname..'?', 15000)
                            if (request) then
                                if (not answered) then
                                    answered = true
                                    answeredBy = nUser

                                    zeroClient.playSound(source, 'Event_Message_Purple', 'GTAO_FM_Events_Soundset')
                                    TriggerClientEvent('notify', source, 'Chamados', 'O seu chamado foi atendido por <b>'..nIdentity.firstname..' '..nIdentity.lastname..'</b>, aguarde no local.')
                                else
                                    TriggerClientEvent('notify', nSource, 'Chamados', 'Este <b>chamado</b> ja foi atendido por outro mecânico.')
									zeroClient.playSound(nSource, 'CHECKPOINT_MISSED', 'HUD_MINI_GAME_SOUNDSET')
                                end
                            end

                            local id = idgens:gen()
							callBlips[id] = zeroClient.addBlip(nSource, pCoord.x, pCoord.y, pCoord.z, 358, 71, 'Chamado ~b~MECÂNICA~w~', 0.6, false)
							Citizen.SetTimeout(30000, function() zeroClient.removeBlip(nSource, callBlips[id]) idgens:free(id) end)
                        end)
                    end
                end
            end

            Citizen.SetTimeout(35000, function()
                if (not answeredBy) then answeredBy = 'Não atendido'; end;
                zero.webhook('Chamados', '```prolog\n[CHAMADOS]\n[CALL TYPE]: (MECHANIC)\n[USER]: '..user_id..'\n[SERVERD BY]: '..answeredBy..'\n[MECHANICS IN SERVICE]: '..#perm..' \n[COORD]: '..tostring(pCoord)..os.date('\n[DATE]: %d/%m/%Y [HOUR]: %H:%M:%S')..' \r```')
            end)
        end

        zeroClient.DeletarObjeto(source)
    end,
    ['zerofome'] = function(source, user_id, cooldown, pCoord, identity)
        if (GetEntityHealth(GetPlayerPed(source)) <= 100) then
            TriggerClientEvent('notify', source, 'Chamados', 'Você não pode realizar um <b>chamado</b> morto!')
            return false
        end
        
        local answered = false
        local answeredBy = false

        zeroClient._CarregarObjeto(source, 'cellphone@', 'cellphone_call_to_text', 'prop_amb_phone', 50, 28422)

        local prompt = exports.zero_hud:prompt(source, { 
            'Descrição do chamado'
        })

        if (prompt) then
            prompt = tostring(prompt[1])

            exports[GetCurrentResourceName()]:CreateCooldown(cooldown, 300)

            local perm = zero.getUsersByPermission('zerofome.permissao')
            if (#perm == 0) then
                TriggerClientEvent('notify', source, 'Chamados', 'Não há <b>DELIVERYS</b> em serviço no momento.')
            else
                zeroClient.playSound(source, 'Event_Message_Purple', 'GTAO_FM_Events_Soundset')
                TriggerClientEvent('notify', source, 'Chamados', 'O <b>chamado</b> foi enviado com sucesso!')
                
                for k, v in pairs(perm) do
                    local nSource = zero.getUserSource(parseInt(v))
                    if (nSource) then
                        local nUser = zero.getUserId(nSource)
                        local nIdentity = zero.getUserIdentity(nUser)

                        async(function()
                            zeroClient.playSound(nSource, 'Out_Of_Area', 'DLC_Lowrider_Relay_Race_Sounds')
                            TriggerClientEvent('chatMessage', nSource, '[CHAMADO ZERO FOME] '..user_id..' | '..identity.firstname..' '..identity.lastname, {0, 153, 255}, tostring(prompt))
                            
                            local request = exports.zero_hud:request(nSource, 'Você deseja aceitar o chamado de '..identity.firstname..' '..identity.lastname..'?', 15000)
                            if (request) then
                                if (not answered) then
                                    answered = true
                                    answeredBy = nUser

                                    zeroClient.playSound(source, 'Event_Message_Purple', 'GTAO_FM_Events_Soundset')
                                    TriggerClientEvent('notify', source, 'Chamados', 'O seu chamado foi atendido por <b>'..nIdentity.firstname..' '..nIdentity.lastname..'</b>, aguarde no local.')
                                else
                                    TriggerClientEvent('notify', nSource, 'Chamados', 'Este <b>chamado</b> ja foi atendido por outro atendente.')
									zeroClient.playSound(nSource, 'CHECKPOINT_MISSED', 'HUD_MINI_GAME_SOUNDSET')
                                end
                            end

                            local id = idgens:gen()
							callBlips[id] = zeroClient.addBlip(nSource, pCoord.x, pCoord.y, pCoord.z, 358, 71, 'Chamado ~b~ZERO FOME~w~', 0.6, false)
							Citizen.SetTimeout(30000, function() zeroClient.removeBlip(nSource, callBlips[id]) idgens:free(id) end)
                        end)
                    end
                end
            end

            Citizen.SetTimeout(35000, function()
                if (not answeredBy) then answeredBy = 'Não atendido'; end;
                zero.webhook('Chamados', '```prolog\n[CHAMADOS]\n[CALL TYPE]: (ZERO FOME)\n[USER]: '..user_id..'\n[SERVERD BY]: '..answeredBy..'\n[ATENDENTS IN SERVICE]: '..#perm..' \n[COORD]: '..tostring(pCoord)..os.date('\n[DATE]: %d/%m/%Y [HOUR]: %H:%M:%S')..' \r```')
            end)
        end

        zeroClient.DeletarObjeto(source)
    end
}

RegisterCommand('call', function(source, args)
    local user_id = zero.getUserId(source)
    local identity = zero.getUserIdentity(user_id)
    local pCoord = GetEntityCoords(GetPlayerPed(source))
    if (user_id) then
        if (args[1]) then
            local call = args[1]:lower()
            if (callType[call]) then
                local cooldown = tostring(call..'-'..user_id)
                if (exports[GetCurrentResourceName()]:GetCooldown(cooldown)) then
                    TriggerClientEvent('notify', source, 'Chamados', 'Aguarde <b>'..exports[GetCurrentResourceName()]:GetCooldown(cooldown)..' segundos</b> para fazer chamado novamente.')
                    return
                end

                callType[call](source, user_id, cooldown, pCoord, identity)
            else
                TriggerClientEvent('notify', source, 'Chamados', 'Você tentou iniciar um <b>chamado</b> para um número inexistente.<br><br>Tente novamente digitando: <b><br>- /call adm<br>- /call mec<br>- /call hp<br>- /call pm')
            end
        else
            TriggerClientEvent('notify', source, 'Chamados', 'Você tentou iniciar um <b>chamado</b> para um número inexistente.<br><br>Tente novamente digitando: <b><br>- /call adm<br>- /call mec<br>- /call hp<br>- /call pm')
        end
    end
end)