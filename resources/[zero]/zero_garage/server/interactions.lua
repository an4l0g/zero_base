local keys = {
    ['add'] = function(source, nSource, vnetid, vname, nIdentity, identity, nuserId, user_id)
        local request = zero.request(source, 'Dar a chave reserva do veículo '..vehicleName(vname)..' para '..nIdentity.firstname..' '..nIdentity.lastname..'?', 60000)
        if (request) then
            carKeys[vnetid] = nuserId
            zeroClient._playAnim(source, true, {{ 'mp_common', 'givetake1_a' }}, false)
            zeroClient._playAnim(nSource, true, {{ 'mp_common', 'givetake1_a' }}, false)
            TriggerClientEvent('notify', source, 'Garagem', 'Você deu a chave reserva do veiculo <b>'..vehicleName(vname)..'</b> para <b>'..nIdentity.firstname..' '..nIdentity.lastname..'</b>.', 8000)
            TriggerClientEvent('notify', nSource, 'Garagem', 'Você recebeu a chave reserva do veiculo <b>'..vehicleName(vname)..'</b> de <b>'..identity.firstname..' '..identity.lastname..'</b>.', 8000)
            zero.webhook('Chave', '```prolog\n[JOGADOR]: #'..user_id..' '..identity.firstname..' '..identity.lastname..' \n[EMPRESTOU CHAVE RESERVA]: '..vehicleName(vname)..' \n[PARA]: #'..nuserId..' '..nIdentity.firstname..' '..nIdentity.lastname..os.date('\n[DATA]: %d/%m/%Y [HORA]: %H:%M:%S')..' \r```')
        end
    end,
    ['rem'] = function(source, nSource, vnetid, vname, nIdentity, identity, nuserId, user_id)
        carKeys[vnetid] = nil
        zeroClient._playAnim(nSource, true, {{ 'mp_common', 'givetake1_a' }}, false)
        zeroClient._playAnim(source, true, {{ 'mp_common', 'givetake1_a' }}, false)
        TriggerClientEvent('notify', source, 'Garagem', 'Você removeu a chave reserva do veiculo <b>'..vehicleName(vname)..'</b> para <b>'..nIdentity.firstname..' '..nIdentity.lastname..'</b>.', 8000)
        TriggerClientEvent('notify', nSource, 'Garagem', 'Você perdeu a chave reserva do veiculo <b>'..vehicleName(vname)..'</b> de <b>'..identity.firstname..' '..identity.lastname..'</b>.', 8000)
        zero.webhook('Chave', '```prolog\n[JOGADOR]: #'..user_id..' '..identity.firstname..' '..identity.lastname..' \n[RECOLHEU CHAVE RESERVA]: '..vehicleName(vname)..' \n[PARA]: #'..nuserId..' '..nIdentity.firstname..' '..nIdentity.lastname..os.date('\n[DATA]: %d/%m/%Y [HORA]: %H:%M:%S')..' \r```')
    end
}

RegisterNetEvent('zero_interactions:carKeys', function(value)
    local source = source
    local user_id = zero.getUserId(source)
    if (user_id) then
        local identity = zero.getUserIdentity(user_id)
        local nPlayer = zeroClient.getNearestPlayer(source, 2.0)
        if (nPlayer) then
            local nUser = zero.getUserId(nSource)
            local nIdentity = zero.getUserIdentity(nUser)
            local vehicle, vnetid, placa, vname = zeroClient.vehList(source, 3.0)
            if (vnetid and vname) then
                local vehState = srv.getVehicleData(vnetid)
                if (vehState.user_id == user_id) then
                    keys[value](source, nPlayer, vnetid, vname, nIdentity, identity, nUser, user_id)
                end
            end
        else
            TriggerClientEvent('notify', source, 'Garagem', 'Não possui uma pessoa <b>próximo</b> a você.')
        end
    end
end)

RegisterNetEvent('zero_interactions:carVehs', function()
    local source = source
    local user_id = zero.getUserId(source)
    if (user_id) then
        local prompt = zero.prompt(source, { 'Veículo que você deseja vender', 'Valor do veículo', 'Passaporte do jogador que irá receber o veículo' })
        if (prompt) then
            if (prompt[1] and prompt[2] and prompt[3]) then
                prompt[2] = parseInt(prompt[2])
                prompt[3] = parseInt(prompt[3])

                local model = prompt[1]
                local vname = vehicleName(model)
                local myVehicle = zero.query('zero_garage/getVehiclesWithVeh', { user_id = user_id, vehicle = model })[1]
                if (myVehicle) then
                    if ((vehicleType(model) == 'exclusive') or (vehicleType(model) == 'vip') or (myVehicle.rented ~= '')) then
                        TriggerClientEvent('notify', source, 'Garagem', 'Este <b>veículo</b> não pode ser vendido.')
                    else
                        local nUser = prompt[3]
                        local price = prompt[2]
                        local nSource = zero.getUserSource(nUser)
                        local identity = zero.getUserIdentity(user_id)
                        local nIdentity = zero.getUserIdentity(nUser)
                        if (price > 0) then
                            if (zero.request(source, 'Deseja vender um '..vname..' para '..nIdentity.firstname..' '..nIdentity.lastname..' por R$'..zero.format(price)..' ?', 60000)) then
                                if (zero.request(nSource, 'Aceita comprar um '..vname..' de '..identity.firstname..' '..identity.lastname..' por R$'..zero.format(price)..'?', 60000)) then
                                    local userVehicle = zero.query('zero_garage/getVehiclesWithVeh', { user_id = nUser, vehicle = model })[1]
                                    if (userVehicle) then
                                        TriggerClientEvent('notify', source, 'Garagem', 'O <b>'..nIdentity.firstname..' '..nIdentity.lastname..'</b> já possui este modelo de veículo')
                                    else
                                        local vqtd = 0
                                        local vehicles = zero.query('zero_garage/getVehicleOwn', { user_id = nUser })
                                        for _, v in ipairs(vehicles) do
                                            local vtype = vehicleType(v.vehicle)
                                            if (vtype ~= 'exclusive' and vtype ~= 'vip') then vqtd = vqtd + 1; end;

                                            local maxGarages = zero.query('zero_garage/getGarages', { id = nUser })[1]
                                            maxGarages = maxGarages.garages
                                            if (vqtd < maxGarages) then
                                                if (zero.tryFullPayment(nUser, price)) then
                                                    addVehicle(nUser, model, 0)
                                                    delVehicle(user_id, model)

                                                    TriggerClientEvent('notify', source, 'Garagem', 'Você vendeu <b>'..vname..'</b> e recebeu <b>R$'..zero.format(price)..'</b>.')
                                                    TriggerClientEvent('notify', nSource, 'Garagem', 'Você recebeu as chaves do veículo <b>'..vname..'</b> de <b>'..identity.firstname..' '..identity.lastname..'</b> e pagou <b>R$'..zero.format(price)..'</b>.')
                                                    
                                                    zeroClient.playSound(source, 'Hack_Success', 'DLC_HEIST_BIOLAB_PREP_HACKING_SOUNDS')
                                                    zeroClient.playSound(nSource, 'Hack_Success', 'DLC_HEIST_BIOLAB_PREP_HACKING_SOUNDS')
                                                    
                                                    zero.giveBankMoney(user_id, nUser)
                                                    zero.webhook('Vehs', '```prolog\n[JOGADOR]: #'..user_id..' '..identity.firstname..' '..identity.lastname..' \n[VENDEU]: '..vehicleName(vname)..' \n[PARA]: #'..nuserId..' '..nIdentity.firstname..' '..nIdentity.lastname..'\n[POR]: '..zero.format(price)..os.date('\n[DATA]: %d/%m/%Y [HORA]: %H:%M:%S')..' \r```')
                                                    local vehEntity = findVehicle(user_id, model)
                                                    if (vehEntity) then srv.tryDelete(NetworkGetNetworkIdFromEntity(vehEntity), false); end;
                                                else
                                                    TriggerClientEvent('notify', nSource, 'Garagem', 'Você não possui <b>dinheiro</b> o suficiente.')
                                                    TriggerClientEvent('notify', source, 'Garagem', 'O mesmo não possui <b>dinheiro</b> o suficiente.')
                                                end
                                            else
                                                TriggerClientEvent('notify', nSource, 'Garagem', 'Você não possui <b>vagas</b> em sua garagem.')
                                                TriggerClientEvent('notify', source, 'Garagem', 'O mesmo não <b>vagas</b> em sua garagem.')
                                            end
                                        end
                                    end
                                end
                            end
                        end 
                    end
                else
                    TriggerClientEvent('notify', source, 'Garagem', 'Você não possui esse <b>veículo</b> em sua garagem.')
                end
            end
        end
    end
end)