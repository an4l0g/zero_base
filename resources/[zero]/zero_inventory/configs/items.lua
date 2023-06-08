cGARAGE = Tunnel.getInterface('zGarages')
cTASKBAR = Tunnel.getInterface('zTaskbar')

cInventory = Tunnel.getInterface('zero_inventory')

bandagemCooldown = {}

config.itemTypes = { 'common', 'weapon', 'wammo' }
this = exports['zero_inventory']

config.items = {
    ['agua'] = {
        name = 'Água',
        type = 'common',
        weight = 0.5,
        progressDescription = 'Bebendo água...',
        afterItem = 'garrafa-vazia',
        usable = true,
        consumable = {
            health = 0,
            armor = 0,
            thirst = -35,
            hunger = 0,
            toxic = 0,
            timeout = 10000
        },
        animation = {
            anim = {"amb@world_human_drinking@beer@male@idle_a","idle_a",49,28422}, 
            prop = 'prop_ld_flow_bottle',
        },
    },
    ['mao-zumbi'] = {
        name = 'Mão Zumbi',
        type = 'common',
        weight = 0,
        model = nil,

        usable = true,
        interaction = function(source, user_id)
        end
    },
    ['garrafa-vazia'] = {
        name = 'Garrafa vazia',
        type = 'common',
        weight = 0.3,
        model = nil,

        usable = true,
        interaction = function(source, user_id)
            local inWater = cInventory.getWaterHeight(source)
            if inWater then
                if vRP.tryGetInventoryItem(user_id, 'garrafa-vazia', 1) then
                    TriggerClientEvent('zero_inventory:disableActions', source)
                    TriggerClientEvent('cancelando', source, true)
                    vRPclient._playAnim(source, true, {{'amb@medic@standing@kneel@base', 'base'}}, true)
                    SetTimeout(
                        3000,
                        function()
                            TriggerClientEvent('zero_inventory:enableActions', source)
                            vRP.giveInventoryItem(user_id, 'agua-contaminada', 1)
                            vRPclient._stopAnim(source, true)
                            TriggerClientEvent('cancelando', source, false)
                        end
                    )
                end
            end
        end
    },
    ['isca'] = {
        name = 'Isca',
        type = 'common',
        weight = 0.3,
        model = nil,

        usable = true,
        interaction = function(source, user_id)
        end
    },
    ['frango-ensopado'] = {
        name = 'Frango Ensopado',
        type = 'common',
        weight = 0.5,
        model = nil,

        usable = true,
        consumable = {
            health = 0,
            armor = 100,
            thirst = 0,
            hunger = -100,
            toxic = -100,
            timeout = 10000
        },
        animation = {
            anim = {"mp_player_inteat@burger","mp_player_int_eat_burger",49,60309}, 
            prop = 'prop_cs_steak',
        }
    },
    ['file-coelho'] = {
        name = 'Filé Coelho',
        type = 'common',
        weight = 0.7,
        model = nil,

        usable = true,
        consumable = {
            health = 0,
            armor = 0,
            thirst = 0,
            hunger = -50,
            toxic = 0,
            timeout = 10000
        },
        animation = {
            anim = {"mp_player_inteat@burger","mp_player_int_eat_burger",49,60309}, 
            prop = 'prop_cs_steak',
        }
    },
    ['pirao-atum'] = {
        name = 'Pirão de atum',
        type = 'common',
        weight = 1.0,
        model = nil,

        usable = true,
        consumable = {
            health = 0,
            armor = 0,
            thirst = -20,
            hunger = -50,
            toxic = 0,
            timeout = 10000,
            buff = 'infec50',
            buffTitleNotify = 'Infecção',
            buffNotify = 'Zumbis te infectam 50% menos ao te atacar.',
        },
        animation = {
            anim = {"mp_player_inteat@burger","mp_player_int_eat_burger",49,60309}, 
            prop = 'prop_cs_steak',
        }
    },
    ['veh-suspensao'] = {
    name = 'Suspensao para Carro',
    type = 'common',
    weight = 5,
    model = nil,
    usable = true,
    interaction = function(source, user_id)
    end
    },
    ['salitre'] = {
    name = 'Salitre',
    type = 'common',
    weight = 1,
    model = nil,
    usable = true,
    interaction = function(source, user_id)
    end
    },
    ['bateria-descarregada'] = {
    name = 'Bateria descarregada',
    type = 'common',
    weight = 0.5,
    model = nil,
    usable = true,
    interaction = function(source, user_id)
    end
    },
    ['sopa-abobora'] = {
        name = 'Sopa Abóbora',
        type = 'common',
        weight = 1.0,
        model = nil,

        usable = true,
        consumable = {
            health = 0,
            armor = 0,
            thirst = -20,
            hunger = -100,
            toxic = 0,
            timeout = 10000,
            buff = 'xp200',
            buffTitleNotify = 'Experiência',
            buffNotify = 'Você recebeu um buff de experiência, aproveite!',
        },
        animation = {
            anim = {"amb@world_human_drinking@beer@male@idle_a","idle_a",49,28422}, 
            prop = 'v_res_fa_tintomsoup',
        }
    },
    ['salmao'] = {
        name = 'Salmão',
        type = 'common',
        weight = 1,
        model = nil,


        usable = true,
    },
    ['compattachs'] = {
        name = 'Componentes Armas',
        type = 'common',
        weight = 1,
        model = nil,


        usable = true,
        interaction = function(source, user_id)
            TriggerClientEvent('zPlayer:attachs', source)
        end
    },
    ['bcereal'] = {
        name = 'Barra de Cereal',
        type = 'common',
        weight = 0.5,
        model = nil,

        usable = true,
        consumable = {
            health = 0,
            armor = 0,
            thirst = 0,
            hunger = -20,
            toxic = 10,
            timeout = 10000,
        },
        animation = {
            anim = {'mp_player_inteat@burger','mp_player_int_eat_burger',49,60309}, 
            prop = 'prop_cs_steak',
        }
    },
    ['gps-descarregado'] = {
    name = 'GPS descarregado',
    type = 'common',
    weight = 0.5,
    model = nil,
    usable = true,
    interaction = function(source, user_id)
    end
    },
    ['analgesico'] = {
        name = 'Analgésico',
        type = 'common',
        weight = 0.5,
        model = nil,

        usable = true,
        drug = {
            heal = 20,
            heal_times = 5,
            heal_toxic = 0,
            heal_toxic_times = 0
        }
    },
    ['cola'] = {
        name = 'Cola',
        type = 'common',
        weight = 0.5,
        model = nil,

        usable = true,
        consumable = {
            health = 0,
            armor = 0,
            thirst = -35,
            hunger = 0,
            toxic = 5,
            timeout = 10000,
        },
        animation = {
            anim = {'amb@world_human_drinking@beer@male@idle_a','idle_a',49,60309}, 
            prop = 'ng_proc_sodacan_01a',
        }
    },
    ['bolsa-sangue-infectado'] = {
        name = 'B. Sangue Infectado',
        type = 'common',
        weight = 0,
        model = nil,

        usable = true,
        consumable = {
            health = 0,
            armor = 0,
            thirst = 0,
            hunger = 0,
            toxic = -100,
            timeout = 10000,
        },
        animation = {
            anim = {'amb@world_human_drinking@beer@male@idle_a','idle_a',49,28422}, 
            prop = 'stt_prop_lives_bottle',
        }
    },
    ['carvao'] = {
        name = 'Carvão',
        type = 'common',
        weight = 1,
        model = nil,

        usable = true,
    },
    ['escvip'] = {
        name = 'Esconderijo VIP',
        type = 'common',
        weight = 0,
        model = nil,

        usable = true,
        interaction = function(source, user_id)
        end
    },
    ['seringa-sangue-infectado'] = {
        name = 'Seringa Sangue Infectado',
        type = 'common',
        weight = 0,
        model = nil,

        usable = true,
        interaction = function(source, user_id)
        end
    },
    ['relogio'] = {
        name = 'Relógio',
        type = 'common',
        weight = 0.3,
        model = nil,

        usable = true,
        interaction = function(source, user_id)
            TriggerClientEvent('zSkinShop:open', source, 'relogio')
        end
    },
    ['bau-medio'] = {
        name = 'Baú Medio',
        type = 'common',
        weight = 25,
        model = nil,

        usable = true,
        interaction = function(source, user_id)
            if vRP.tryGetInventoryItem(user_id, 'bau-medio', 1) then
                if (not exports["zBrazuca"]:homesUpdateChest(user_id, 50)) then
                    vRP.giveInventoryItem(user_id, 'bau-medio', 1)
                end
            end
        end
    },
    ['pernil-assado'] = {
        name = 'Pernil Assado',
        type = 'common',
        weight = 0.5,
        model = nil,

        usable = true,
        consumable = {
            health = 0,
            armor = 100,
            thirst = 0,
            hunger = -100,
            toxic = -100,
            timeout = 10000,
        },
        animation = {
            anim = {'mp_player_inteat@burger','mp_player_int_eat_burger',49,60309}, 
            prop = 'prop_cs_steak',
        }
    },
    ['mochila-pequena'] = {
        name = 'Mochila Escolar',
        type = 'common',
        weight = 1,
        model = nil,

        usable = true,
        interaction = function(source, user_id)
            if vRP.getInventoryMaxWeight(user_id) < 25 then
                if vRP.tryGetInventoryItem(user_id, 'mochila-pequena', 1) then
                    vRP.setInventoryMaxWeight(user_id, 25)
                    SetPedComponentVariation(GetPlayerPed(source), 5, 4, 0, 3);
                    TriggerClientEvent(
                        'Notify',
                        source,
                        'vermelho',
                        'Inventário',
                        'Mochila utilizada com sucesso!',
                        5000
                    )
                end
            else
                TriggerClientEvent(
                    'Notify',
                    source,
                    'vermelho',
                    'Inventário',
                    'Você já está utilizando uma mochila melhor ou igual a esta.',
                    5000
                )
            end
        end
    },
    ['flare'] = {
        name = 'Flare',
        type = 'common',
        weight = 1.5,
        model = nil,

        usable = true,
        interaction = function(source, user_id)
            if (not Player(source).state["zSafes:inside"]) then
                if vRP.tryGetInventoryItem(user_id, 'flare', 1) then
                    local coords = GetEntityCoords(GetPlayerPed(source))
                    if exports['zBrazuca']:createAirdrop(vector3(coords.x, coords.y, coords.z-0.7)) then
                        TriggerClientEvent(
                            'Notify',
                            source,
                            'AirDrop',
                            'O seu airdrop esta a caminho!',
                            5000
                        )
                    else
                        vRP.giveInventoryItem(user_id, 'flare', 1)
                        TriggerClientEvent(
                            'Notify',
                            source,
                            'vermelho',
                            'AirDrop',
                            'Ja existe um airdrop a caminho!',
                            5000
                        )
                    end
                end
            else
                TriggerClientEvent(
                    'Notify',
                    source,
                    'vermelho',
                    'AirDrop',
                    'Não pode fazer isso em Safes!',
                    5000
                )
            end
        end
    },
    ['repairkit'] = {
        name = 'Kit de Reparos',
        type = 'common',
        weight = 1,
        model = nil,

        usable = true,
            interaction = function(source, user_id)
                if vRP.hasPermission(user_id, "hab-mecanica") then
                    if vRP.tryGetInventoryItem(user_id, "repairkit", 1) then
                        if not vRPclient.isInVehicle(source) then
                            local cliVehicle, vehNet = vRPclient.vehList(source, 11)
                            if cliVehicle then
                                if (not cInventory.checkBurstTyres(source, vehNet)) then
                                    vRPclient._playAnim(source, false, {'mini@repair', 'fixing_a_player'}, true)
                                    TriggerClientEvent('zero_inventory:closeInventory', source)
                                    local taskResult = cTASKBAR.taskLockpick(source)
                                    if taskResult then
                                        local entity = NetworkGetEntityFromNetworkId(vehNet)
                                        if entity then
                                            Entity(entity).state['veh:canDefDamage'] = nil
                                            Wait(500)
                                            SetVehicleBodyHealth(entity,1000.0)
                                        end
                                        TriggerClientEvent('syncreparar', -1, vehNet)
                                        TriggerClientEvent('Notify', source, 'verde', 'Kit reparo', 'Arrumado com sucesso.', 5000)
                                        vRPclient._stopAnim(source, false)
                                    else
                                        TriggerClientEvent('Notify', source, 'vermelho', 'Kit reparo','Você infelizmente falhou e seu kit de reparos quebrou!', 5000)
                                        vRPclient._stopAnim(source, false)
                                    end
                                else
                                    TriggerClientEvent('Notify', source, 'vermelho', 'Kit reparo', 'Você precisa arrumar os pneus primeiro.', 5000)
                                end
                            end
                        end
                    end
                else
                    TriggerClientEvent('Notify', source, "Inventário", 'Proficiência', 'Você não possui conhecimento em mecânica para fazer isso!!', 5000)
                end
            end
    },
    ['pet-retriever'] = {
        name = 'Filhote Retriever',
        type = 'common',
        weight = 1,
        model = nil,

        usable = true,
        interaction = function(source, user_id)
            adoptPet('pet-retriever')
        end
    },
    ['algema'] = {
        name = 'Algema',
        type = 'common',
        weight = 0.5,
        model = nil,

        usable = true,
        interaction = function(source, user_id)
            TriggerEvent('vrp_policia:algemar', source, false, false)
        end
    },
    ['mola'] = {
        name = 'Mola',
        type = 'common',
        weight = 1,
        model = nil,

        usable = true,
        interaction = function(source, user_id)
        end
    },
    ['pet-rottweiler'] = {
        name = 'Filhote Rottweiler',
        type = 'common',
        weight = 1,
        model = nil,

        usable = true,
        interaction = function(source, user_id)
            adoptPet('pet-rottweiler')
        end
    },
    ['alcool'] = {
        name = 'Alcool',
        type = 'common',
        weight = 1,
        model = nil,

        usable = true,
        interaction = function(source, user_id)
    end
    },
    ['costelas'] = {
        name = 'Costelas',
        type = 'common',
        weight = 0.5,
        model = nil,

        usable = true,
        consumable = {
            health = 0,
            armor = 100,
            thirst = 0,
            hunger = -100,
            toxic = -100,
            timeout = 10000,
        },
        animation = {
            anim = {'mp_player_inteat@burger','mp_player_int_eat_burger',49,60309}, 
            prop = 'prop_cs_steak',
        }
    },
    ['pernil-coelho'] = {
        name = 'Pernil Coelho',
        type = 'common',
        weight = 0.5,
        model = nil,

        usable = true,
        consumable = {
            health = 0,
            armor = 100,
            thirst = 0,
            hunger = -10,
            toxic = 20,
            timeout = 10000,
        },
        animation = {
            anim = {'mp_player_inteat@burger','mp_player_int_eat_burger',49,60309}, 
            prop = 'prop_cs_steak',
        }
    },
    ['veh-luzes'] = {
        name = 'Luzes para Carro',
        type = 'common',
        weight = 5,
        model = nil,

        usable = true,
        interaction = function(source, user_id)
        end
    },
    ['panela'] = {
        name = 'Panela',
        type = 'common',
        weight = 1.5,
        model = nil,

        usable = true,
        interaction = function(source, user_id)
        end
    },
    ['veh-tinta'] = {
        name = 'Tinta para Carro',
        type = 'common',
        weight = 2,
        model = nil,

        usable = true,
        interaction = function(source, user_id)
        end
    },
    ['pneu'] = {
        name = 'Pneu',
        type = 'common',
        weight = 3.0,
        model = nil,

        usable = true,
        interaction = function(source, user_id)
            if not vRPclient.isInVehicle(source) then
                local vehicle, vehNet = vRPclient.vehList(source, 3)
                if vehicle then
                    TriggerClientEvent('cancelando', source, true)
                    vRPclient._playAnim(
                        source,
                        false,
                        {'anim@amb@clubhouse@tutorial@bkr_tut_ig3@', 'machinic_loop_mechandplayer'},
                        true
                    )
                    local taskResult = cTASKBAR.taskTwo(source)
                    if taskResult then
                        if vRP.tryGetInventoryItem(user_id, 'pneu', 1, true) then
                            fixBurstTyres(-1, vehNet)
                        end
                    end
                    TriggerClientEvent('cancelando', source, false)
                    vRPclient._stopAnim(source, false)
                end
            end
        end
    },
    ['chave-micha'] = {
        name = 'Chave Micha',
        type = 'common',
        weight = 0.8,
        model = nil,

        usable = true,
        interaction = function(source, user_id)
            if (not Player(source).state["zSafes:inside"]) then
                local vehicle,vehNet,vehPlate,vname,lock,banned,trunk,model,street = vRPclient.vehList(source,7)
                if vehicle and vehPlate then
                    if vRPclient.isInVehicle(source) then
                        TriggerClientEvent('cancelando', source, true)
                        startAnimHotwired(source)
                        local taskResult = cTASKBAR.taskLockpick(source)
                        if taskResult then
                            stopAnimHotwired(source, vehicle)
                        end
                    else           
                        TriggerClientEvent('cancelando', source, true)
                        vRPclient._playAnim(source, false, {'missfbi_s4mop', 'clean_mop_back_player'}, true)
                        local taskResult = cTASKBAR.taskLockpick(source)
                        if taskResult then
                            TriggerClientEvent('Notify', source, 'sucesso', 'Chave micha', 'Carro destrancado!', 5000)
                            cGARAGE.vehicleClientLock(-1, vehNet, 2)
                            vRPclient._stopAnim(source,false)

                            local coords = GetEntityCoords(GetPlayerPed(source))
                            local identity = vRP.getUserIdentity(user_id)
                            local data = exports["zGarages"]:getVehicleData(vehNet)
                            if data.user_id then
                                webhook(webhooks.lockpick,'```prolog\n[LOCKPICK SUCESSO]\n[LADRÃO]: '..user_id..' | '..identity.name..' '..identity.firstname..'\n[LOCALIZAÇÃO]: '..street..' \n[DONO DO VEÍCULO]: '..data.user_id..' \n[MODELO DO CARRO]: '..data.model..' \n[PLACA]: '..data.plate..' \n[CDS]: '..tostring(coords)..os.date('\n[DATA]: %d/%m/%Y - [HORA]: %H:%M:%S')..' \r```')
                            else
                                webhook(webhooks.lockpick,'```prolog\n[LOCKPICK SUCESSO]\n[LADRÃO]: '..user_id..' | '..identity.name..' '..identity.firstname..'\n[LOCALIZAÇÃO]: '..street..' \n[DONO DO VEÍCULO]: SPAWNER \n[MODELO DO CARRO]: '..data.model..' \n[PLACA]: '..data.plate..' \n[CDS]: '..tostring(coords)..os.date('\n[DATA]: %d/%m/%Y - [HORA]: %H:%M:%S')..' \r```')
                            end
                        end
                    end
                    if (math.random(1, 100) > 50) then
                        vRP.tryGetInventoryItem(user_id, 'chave-micha', 1)
                        TriggerClientEvent('Notify', source, 'aviso', 'Chave micha', 'Oh não! A chave quebrou!', 5000)
                    end
                    TriggerClientEvent('cancelando', source, false)
                    vRPclient._stopAnim(source, false)
                end
            else
                TriggerClientEvent(
                    'Notify',
                    source,
                    'vermelho',
                    'Chave Micha',
                    'Não pode fazer isso em Safes!',
                    5000
                )
            end
        end
    },
    ['maca'] = {
        name = 'Maçã',
        type = 'common',
        weight = 0.5,
        model = nil,

        usable = true,
        consumable = {
            health = 0,
            armor = 0,
            thirst = 0,
            hunger = -20,
            toxic = 10,
            timeout = 10000,
        },
        animation = {
            anim = {'mp_player_inteat@burger','mp_player_int_eat_burger',49,60309}, 
            prop = 'ng_proc_food_ornge1a',
        }
    },
    ['bchocolate'] = {
        name = 'Barra de Chocolate',
        type = 'common',
        weight = 0.5,
        model = nil,

        usable = true,
        consumable = {
            health = 0,
            armor = 0,
            thirst = 0,
            hunger = -20,
            toxic = 10,
            timeout = 10000,
        },
        animation = {
            anim = {'mp_player_inteat@burger','mp_player_int_eat_burger',49,60309}, 
            prop = 'prop_cs_steak',
        }
    },
    ['luvas'] = {
        name = 'Luvas',
        type = 'common',
        weight = 0.3,
        model = nil,

        usable = true,
        interaction = function(source, user_id)
            TriggerClientEvent('zSkinShop:open', source, 'mao')
        end
    },
    ['racao-animal'] = {
        name = 'Ração para Animais',
        type = 'common',
        weight = 0.8,
        model = nil,

        usable = true,
        interaction = function(source, user_id)
            if vRP.tryGetInventoryItem(user_id, "racao-animal", 1) then
                TriggerClientEvent('feedPet', source)
            end
        end
    },
    ['seda'] = {
    name = 'Seda',
    type = 'common',
    weight = 0.2,
    model = nil,
    usable = true,
    interaction = function(source, user_id)
    end
    },
    ['lagosta'] = {
    name = 'Lagosta',
    type = 'common',
    weight = 1.5,
    model = nil,
    usable = true,
    interaction = function(source, user_id)
    end
    },
    ['costelas-veado'] = {
        name = 'Costelas Veado',
        type = 'common',
        weight = 0.5,
        model = nil,

        usable = true,
        consumable = {
            health = 0,
            armor = 0,
            thirst = 0,
            hunger = -10,
            toxic = 20,
            timeout = 10000,
        },
        animation = {
            anim = {'mp_player_inteat@burger','mp_player_int_eat_burger',49,60309}, 
            prop = 'prop_cs_steak',
        }
    },
    ['salmao-assado'] = {
        name = 'Salmão assado',
        type = 'common',
        weight = 1.0,
        model = nil,

        usable = true,
        consumable = {
            health = 0,
            armor = 10,
            thirst = 0,
            hunger = -50,
            toxic = 0,
            timeout = 10000,
        },
        animation = {
            anim = {'mp_player_inteat@burger','mp_player_int_eat_burger',49,60309}, 
            prop = 'prop_cs_steak',
        }
    },
    ['couro'] = {
        name = 'Couro',
        type = 'common',
        weight = 1,
        model = nil,


        usable = true,
        interaction = function(source, user_id)
        end
    },
    ['bacon-frito'] = {
        name = 'Bacon Frito',
        type = 'common',
        weight = 0.5,
        model = nil,

        usable = true,
        consumable = {
            health = 0,
            armor = 100,
            thirst = 0,
            hunger = -100,
            toxic = -100,
            timeout = 10000,
        },
        animation = {
            anim = {'mp_player_inteat@burger','mp_player_int_eat_burger',49,60309}, 
            prop = 'prop_cs_steak',
        }
    },
    ['cigarro-organico'] = {
        name = 'Cigarro Orgânico',
        type = 'common',
        weight = 0.2,
        model = nil,

        usable = true,
        interaction = function(source, user_id)
            if vRP.tryGetInventoryItem(user_id, 'cigarro-organico', 1) then
                TriggerClientEvent('zero_inventory:disableActions', source)
                TriggerClientEvent('cancelando', source, false)
                TriggerClientEvent('progress', source, 20000, 'Fumando cigarro orgânico...')
                vRPclient._CarregarObjeto(source, 'amb@world_human_smoking@male@male_a@base', 'base', 'ng_proc_cigarette01a', 49, 28422)
                SetTimeout(
                    20000,
                    function()
                        TriggerClientEvent('zero_inventory:enableActions', source)
                        vRPclient._DeletarObjeto(source)
                        vRPclient._stopAnim(source, false)
                        vRP.setStress(user_id, 0)
                        TriggerClientEvent('Notify', source, 'Sanidade mental', 'Sua sanidade mental foi recuperada!', 5000)
                    end
                )   
            end
        end
    },
    ['serra'] = {
    name = 'Serra',
    type = 'common',
    weight = 1,
    model = nil,
    usable = true,
    interaction = function(source, user_id)
    end
    },

    ['lata-vazia'] = {
    name = 'Lata vazia',
    type = 'common',
    weight = 0.5,
    model = nil,
    usable = true,
    interaction = function(source, user_id)
    end
    },
    ['enxofre'] = {
    name = 'Enxofre',
    type = 'common',
    weight = 1,
    model = nil,
    usable = true,
    interaction = function(source, user_id)
    end
    },
    ['tempero'] = {
    name = 'Tempero',
    type = 'common',
    weight = 0.5,
    model = nil,
    usable = true,
    interaction = function(source, user_id)
    end
    },
    ['pulseira'] = {
        name = 'Pulseira',
        type = 'common',
        weight = 0.3,
        model = nil,

        usable = true,
        interaction = function(source, user_id)
            TriggerClientEvent('zSkinShop:open', source, 'bracelete')
        end
    },
    ['antiinflamatorio'] = {
        name = 'Anti Inflamatório',
        type = 'common',
        weight = 0.5,
        model = nil,

        usable = true,
        drug = {
            heal = 20,
            heal_times = 5,
            heal_toxic = 0,
            heal_toxic_times = 0
        }
    },
    ['pet-westy'] = {
        name = 'Filhote Westy',
        type = 'common',
        weight = 1,
        model = nil,
        usable = true,
        interaction = function(source, user_id)
            adoptPet('pet-westy')
        end
    },
    ['pet-rabbit'] = {
    name = 'Filhote Rabbit',
    type = 'common',
    weight = 1,
    model = nil,
    usable = true,
    interaction = function(source, user_id)
        adoptPet('pet-rabbit')
    end
    },
    ['tilapia-assada'] = {
        name = 'Tilápia assada',
        type = 'common',
        weight = 1.0,
        model = nil,

        usable = true,
        consumable = {
            health = 0,
            armor = 10,
            thirst = 0,
            hunger = -50,
            toxic = 0,
            timeout = 10000,
        },
        animation = {
            anim = {'mp_player_inteat@burger','mp_player_int_eat_burger',49,60309}, 
            prop = 'prop_cs_steak',
        }
    },
    ['erva-tratada'] = {
    name = 'Erva tratada',
    type = 'common',
    weight = 1,
    model = nil,
    usable = true,
    interaction = function(source, user_id)
    end
    },
    ['pe-coelho'] = {
        name = 'Pé Coelho',
        type = 'common',
        weight = 0.5,
        model = nil,

        usable = true,
        interaction = function(source, user_id)
        end
    },
    ['acessorio'] = {
        name = 'Acessório',
        type = 'common',
        weight = 0.3,
        model = nil,

        usable = true,
        interaction = function(source, user_id)
        end
    },
    ['file-vaca'] = {
        name = 'Filé Vaca',
        type = 'common',
        weight = 0.7,
        model = nil,

        usable = true,
        consumable = {
            health = 0,
            armor = 0,
            thirst = 0,
            hunger = -50,
            toxic = 0,
            timeout = 10000,
        },
        animation = {
            anim = {'mp_player_inteat@burger','mp_player_int_eat_burger',49,60309}, 
            prop = 'prop_cs_steak',
        }
    },
    ['erva-medicinal'] = {
    name = 'Erva medicinal',
    type = 'common',
    weight = 1,
    model = nil,
    usable = true,
    interaction = function(source, user_id)
    end
    },
    ['veh-roda'] = {
    name = 'Roda para Carro',
    type = 'common',
    weight = 2,
    model = nil,
    usable = true,
    interaction = function(source, user_id)
    end
    },
    ['veh-bodykit'] = {
    name = 'Bodykit para Carro',
    type = 'common',
    weight = 0.001,
    model = nil,
    usable = true,
    interaction = function(source, user_id)
    end
    },
    ['bandagem'] = {
        name = 'Bandagem',
        type = 'common',
        weight = 1,
        model = nil,

        usable = true,
        interaction = function(source, user_id)
            if vRPclient.getHealth(source) < 251 then
                if vRP.tryGetInventoryItem(user_id, 'bandagem', 1) then
                    TriggerClientEvent('zero_inventory:disableActions', source)
                    threadBandagem(user_id, 250)
                    vRPclient._CarregarObjeto(
                        source,
                        'amb@world_human_clipboard@male@idle_a',
                        'idle_c',
                        'v_ret_ta_firstaid',
                        49,
                        60309
                    )
                    TriggerClientEvent('cancelando', source, true)
                    TriggerClientEvent('progress', source, 10000, 'Usando a bandagem...')
                    SetTimeout(
                        10000,
                        function()
                            TriggerClientEvent('zero_inventory:enableActions', source)
                            if GetEntityHealth(GetPlayerPed(source)) > 101 then
                                vRPclient.setHealth(source, 251)
                                TriggerClientEvent('cancelando', source, false)
                                vRPclient._DeletarObjeto(source)
                                TriggerClientEvent(
                                    'Notify',
                                    source,
                                    'vermelho',
                                    'Medicina',
                                    'Bandagem utilizada com sucesso.',
                                    5000
                                )
                            end 
                        end
                    )
                else
                    TriggerClientEvent(
                        'Notify',
                        source,
                        'importante',
                        'Aguarde ' .. vRPclient.getTimeFunction(source, parseInt(bandagemCooldown[user_id])) .. '.'
                    )
                end
            else
                TriggerClientEvent(
                    'Notify',
                    source,
                    'vermelho',
                    'Medicina', 
                    'Bandagem só pode ser utilizada quando sua saúde estiver abaixo de 50%.',
                    5000
                )
            end
        end
    },
    ['veh-turbo'] = {
        name = 'Turbo para Carro',
        type = 'common',
        weight = 5,
        model = nil,

        usable = true,
        interaction = function(source, user_id)
        end
    },
    ['tecido'] = {
        name = 'Tecido',
        type = 'common',
        weight = 0.3,
        model = nil,

        usable = true,
        interaction = function(source, user_id)
        end
    },
    ['prego'] = {
        name = 'Prego',
        type = 'common',
        weight = 0.1,
        model = nil,

        usable = true,
        interaction = function(source, user_id)
        end
    },
    ['petkit'] = {
        name = 'Kit Veterinário',
        type = 'common',
        weight = 0,
        model = nil,

        usable = true,
        interaction = function(source, user_id)
        end
    },
    ['corda'] = {
        name = 'Corda',
        type = 'common',
        weight = 1,
        model = nil,

        usable = true,
        interaction = function(source, user_id)
        end
    },
    ['chave-algema'] = {
        name = 'Chave Algema',
        type = 'common',
        weight = 0.5,
        model = nil,

        usable = true,
        interaction = function(source, user_id)
            TriggerEvent('vrp_policia:algemar', source, false, true)
        end
    },
    ['rel-militar'] = {
        name = 'Relatório Militar',
        type = 'common',
        weight = 0.5,
        model = nil,

        usable = true,
        interaction = function(source, user_id)
        end
    },
    ['tabua'] = {
        name = 'Tábua',
        type = 'common',
        weight = 1,
        model = nil,

        usable = true,
        interaction = function(source, user_id)
        end
    },
    ['repolho-estragado'] = {
        name = 'Repolho estragado',
        type = 'common',
        weight = 0.5,
        model = nil,

        usable = true,
        interaction = function(source, user_id)
            if (vRP.tryGetInventoryItem(user_id, 'repolho-estragado', 1)) then
                TriggerClientEvent('zero_inventory:disableActions', source)
                vRPclient._CarregarObjeto(
                    source,
                    'mp_player_inteat@burger',
                    'mp_player_int_eat_burger',
                    'p_cs_leaf_s',
                    49,
                    60309
                )
                Wait(5000);
                TriggerClientEvent('zero_inventory:enableActions', source)
                vRPclient._DeletarObjeto(source)
                TriggerClientEvent(
                    'Notify',
                    source,
                    'vermelho',
                    'Inventário',
                    'Você comeu algo estragado.',
                    5000
                )
                vRPclient._playAnim(source, false, {{'missfam5_blackout', 'vomit'}}, false)
                local damageTimes = 0
                while damageTimes < 3 
                do
                    vRPclient.setHealth(source, vRPclient.getHealth(source) - 25)
                    damageTimes = damageTimes + 1
                    Wait(3000)
                end
            end
        end
    },
    ['sapato'] = {
        name = 'Sapato',
        type = 'common',
        weight = 0.3,
        model = nil,

        usable = true,
        interaction = function(source, user_id)
            TriggerClientEvent('zSkinShop:open', source, 'sapato')
        end
    },
    ['lagosta-frita'] = {
        name = 'Lagosta Frita',
        type = 'common',
        weight = 1.0,
        model = nil,

        usable = true,
        consumable = {
            health = 0,
            armor = 0,
            thirst = -20,
            hunger = -100,
            toxic = 0,
            timeout = 10000,
        },
        animation = {
            anim = {'mp_player_inteat@burger','mp_player_int_eat_burger',49,60309}, 
            prop = 'prop_cs_steak',
        }
    },
    ['radio-descarregado'] = {
        name = 'Rádio descarregado',
        type = 'common',
        weight = 0.5,
        model = nil,

        usable = true,
        interaction = function(source, user_id)
        end
    },
    ['bacalhau'] = {
        name = 'Bacalhau',
        type = 'common',
        weight = 1,
        model = nil,

        usable = true,
        interaction = function(source, user_id)
        end
    },
    ['veh-janela'] = {
        name = 'Janela para Carro',
        type = 'common',
        weight = 5,
        model = nil,

        usable = true,
        interaction = function(source, user_id)
        end
    },
    ['gps'] = {
        name = 'GPS',
        type = 'common',
        weight = 0.5,
        model = nil,

        usable = true,
        interaction = function(source, user_id)
            TriggerClientEvent('zGps:interface', source)
        end
    },
    ['sprunk'] = {
        name = 'Sprunk',
        type = 'common',
        weight = 0.5,
        model = nil,

        usable = true,
        consumable = {
            health = 0,
            armor = 0,
            thirst = -35,
            hunger = 0,
            toxic = 5,
            timeout = 10000,
        },
        animation = {
            anim = {'amb@world_human_drinking@beer@male@idle_a','idle_a',49,28422}, 
            prop = 'ng_proc_sodacan_01b',
        }
    },
    ['tomate'] = {
    name = 'Tomate',
    type = 'common',
    weight = 0.5,
    model = nil,
    usable = true,
    interaction = function(source, user_id)
    end
    },
    ['polvora'] = {
    name = 'Pólvora',
    type = 'common',
    weight = 0.5,
    model = nil,
    usable = true,
    interaction = function(source, user_id)
    end
    },
    ['veh-hidraulica'] = {
    name = 'Hidraulica para Carro',
    type = 'common',
    weight = 10,
    model = nil,
    usable = true,
    interaction = function(source, user_id)
    end
    },
    ['melancia'] = {
        name = 'Melancia',
        type = 'common',
        weight = 0.5,
        model = nil,

        usable = true,
        consumable = {
            health = 0,
            armor = 0,
            thirst = 5,
            hunger = -20,
            toxic = 10,
            timeout = 10000,
        },
        animation = {
            anim = {'mp_player_inteat@burger','mp_player_int_eat_burger',49,60309}, 
            prop = 'ng_proc_food_ornge1a',
        }
    },
    ['dogtag-ordem'] = {
    name = 'Id. Ordem',
    type = 'common',
    weight = 0.5,
    model = nil,
    usable = true,
    interaction = function(source, user_id)
    end
    },
    ['medkit'] = {
        name = 'Med Kit',
        type = 'common',
        weight = 2,
        model = nil,


        usable = true,
        interaction = function(source, user_id)
            local nplayer = vRPclient.getNearestPlayer(source, 2)
            local timeout = 10000

            if nplayer then
                if vRPclient.isInComa(nplayer) then
                    if vRP.tryGetInventoryItem(user_id, 'medkit', 1) then
                        TriggerClientEvent('zero_inventory:disableActions', source)
                        TriggerClientEvent('progress', source, timeout, 'Reanimando...')
                        TriggerClientEvent('cancelando', source, true)
                        vRPclient._playAnim(source, false, {'mini@cpr@char_a@cpr_str', 'cpr_pumpchest'}, true)
                        SetTimeout(
                            timeout,
                            function()
                                TriggerClientEvent('zero_inventory:enableActions', source)
                                TriggerClientEvent('cancelando', source, false)
                                vRPclient._stopAnim(source, false)
                                if GetEntityHealth(GetPlayerPed(source)) > 101 then
                                    local nuser_id = vRP.getUserId(nplayer)
                                    vRPclient.killGod(nplayer)
                                    vRPclient.setHealth(nplayer, 110)    
                                    vRP.varyToxic(nuser_id, -100)                      
                                end  
                            end
                        )
                    end
                else
                    TriggerClientEvent(
                        'Notify',
                        source,
                        'vermelho',
                        'Medicina',
                        'Kit medico so pode ser utilizado em voce ou em um sobrevivente desmaiado.',
                        5000
                    )
                end
            else
                if vRP.tryGetInventoryItem(user_id, 'medkit', 1) then
                    TriggerClientEvent('progress', source, timeout, 'Utilizando kit medico...')
                    TriggerClientEvent('cancelando', source, true)
                    vRPclient._CarregarObjeto(
                        source,
                        'amb@world_human_clipboard@male@idle_a',
                        'idle_c',
                        'v_ret_ta_firstaid',
                        49,
                        60309
                    )
                    SetTimeout(
                        timeout,
                        function()
                            TriggerClientEvent('zero_inventory:enableActions', source)
                            TriggerClientEvent('cancelando', source, false)
                            vRPclient._stopAnim(source, false)
                            vRPclient._DeletarObjeto(source)
                            if GetEntityHealth(GetPlayerPed(source)) > 101 then
                                vRPclient.killGod(source)
                                vRPclient.setHealth(source, 400)
                                vRP.varyToxic(user_id, -100)
                            end
                        end
                    )
                end
            end
        end
    },
    ['pet-poodle'] = {
        name = 'Filhote Poodle',
        type = 'common',
        weight = 1,
        model = nil,

        usable = true,
        interaction = function(source, user_id)
            adoptPet('pet-poodle')
        end
    },
    ['pente'] = {
        name = 'Pente',
        type = 'common',
        weight = 2,
        model = nil,

        usable = true,
        interaction = function(source, user_id)
        end
    },
    ['veh-transmissao'] = {
        name = 'Transmissão para Carro',
        type = 'common',
        weight = 5,
        model = nil,

        usable = true,
        interaction = function(source, user_id)
        end
    },
    ['macarico'] = {
        name = 'Maçarico',
        type = 'common',
        weight = 1,
        model = nil,

        usable = true,
        interaction = function(source, user_id)
        end
    },
    ['capsula'] = {
    name = 'Capsula',
    type = 'common',
    weight = 0.5,
    model = nil,
    usable = true,
    interaction = function(source, user_id)
    end
    },
    ['mascara-gas'] = {
        name = 'Máscara de Gás',
        type = 'common',
        weight = 1,
        model = nil,

        usable = true,
        interaction = function(source, user_id)
            if vRP.tryGetInventoryItem(user_id, 'mascara-gas', 1) then
                SetPedComponentVariation(GetPlayerPed(source), 1, 175);
                TriggerClientEvent(
                    'Notify',
                    source,
                    'vermelho',
                    'Inventário',
                    'Máscara equipada com sucesso!',
                    5000
                )
            end 
        end
    },
    ['laranja'] = {
        name = 'Laranja',
        type = 'common',
        weight = 0.5,
        model = nil,

        usable = true,
        consumable = {
            health = 0,
            armor = 0,
            thirst = -5,
            hunger = -20,
            toxic = 10,
            timeout = 10000,
        },
        animation = {
            anim = {'mp_player_inteat@burger','mp_player_int_eat_burger',49,60309}, 
            prop = 'ng_proc_food_ornge1a',
        }
    },
    ['seringa'] = {
    name = 'Seringa',
    type = 'common',
    weight = 0,
    model = nil,
    usable = true,
    interaction = function(source, user_id)
    end
    },
    ['dogtag'] = {
    name = 'Id. Militar',
    type = 'common',
    weight = 0.5,
    model = nil,
    usable = true,
    interaction = function(source, user_id)
    end
    },
    ['file-porco'] = {
        name = 'Filé Porco',
        type = 'common',
        weight = 0.7,
        model = nil,

        usable = true,
        consumable = {
            health = 0,
            armor = 0,
            thirst = 0,
            hunger = -50,
            toxic = 0,
            timeout = 10000,
        },
        animation = {
            anim = {'mp_player_inteat@burger','mp_player_int_eat_burger',49,60309}, 
            prop = 'prop_cs_steak',
        }
    },
    ['veh-pneu'] = {
    name = 'Pneu para Carro',
    type = 'common',
    weight = 2,
    model = nil,
    usable = true,
    interaction = function(source, user_id)
    end
    },
    ['cebola'] = {
    name = 'Cebola',
    type = 'common',
    weight = 0.5,
    model = nil,
    usable = true,
    interaction = function(source, user_id)
    end
    },
    ['b-mama'] = {
    name = 'Biscoito Mama',
    type = 'common',
    weight = 0,
    model = nil,
    usable = true,
    interaction = function(source, user_id)
    end
    },
    ['atum'] = {
    name = 'Atum',
    type = 'common',
    weight = 1,
    model = nil,
    usable = true,
    interaction = function(source, user_id)
    end
    },
    ['colete'] = {
    name = 'Colete',
    type = 'common',
    weight = 5,
    model = nil,
    usable = true,
    interaction = function(source, user_id)
    end
    },
    ['calca'] = {
        name = 'Calça',
        type = 'common',
        weight = 0.3,
        model = nil,

        usable = true,
        interaction = function(source, user_id)
            TriggerClientEvent('zSkinShop:open', source, 'calca')
        end
    },
    ['file-veado'] = {
        name = 'Filé Veado',
        type = 'common',
        weight = 0.7,
        model = nil,

        usable = true,
        consumable = {
            health = 0,
            armor = 0,
            thirst = 0,
            hunger = -50,
            toxic = 0,
            timeout = 10000,
        },
        animation = {
            anim = {'mp_player_inteat@burger','mp_player_int_eat_burger',49,60309}, 
            prop = 'prop_cs_steak',
        }
    },
    ['pet-jaguatirica'] = {
        name = 'Filhote Jaguatirica',
        type = 'common',
        weight = 1,
        model = nil,

        usable = true,
        interaction = function(source, user_id)
            adoptPet('pet-jaguatirica')
        end
    },
    ['carticket'] = {
        name = 'Ticket Veículo',
        type = 'common',
        weight = 0,
        model = nil,


        usable = true,
        interaction = function(source, user_id)
            if vRP.tryGetInventoryItem(user_id, 'carticket', 1) then
                exports['zGarages']:giveRandomVehicle(source, user_id)
            end
        end
    },
    ['tesoura-jardineiro'] = {
    name = 'Tesoura Jardineiro Velha',
    type = 'common',
    weight = 1.5,
    model = nil,
    usable = true,
    interaction = function(source, user_id)
    end
    },
    ['pimentao'] = {
        name = 'Pimentão',
        type = 'common',
        weight = 0.5,
        model = nil,


        usable = true,
        interaction = function(source, user_id)
        end
    },
    ['pedaco-plastico'] = {
    name = 'Pedaço Plástico',
    type = 'common',
    weight = 0.5,
    model = nil,
    usable = true,
    interaction = function(source, user_id)
    end
    },
    ['farinha'] = {
    name = 'Farinha',
    type = 'common',
    weight = 1,
    model = nil,
    usable = true,
    interaction = function(source, user_id)
    end
    },
    ['veh-freios'] = {
        name = 'Freios para Carro',
        type = 'common',
        weight = 5,
        model = nil,

        usable = true,
        interaction = function(source, user_id)
        end
    },
    ['coxa-frango'] = {
        name = 'Coxa Frango',
        type = 'common',
        weight = 0.5,
        model = nil,

        usable = true,
        consumable = {
            health = 0,
            armor = 0,
            thirst = 0,
            hunger = -10,
            toxic = 20,
            timeout = 10000,
        },
        animation = {
            anim = {'mp_player_inteat@burger','mp_player_int_eat_burger',49,60309}, 
            prop = 'prop_cs_steak',
        }
    },
    ['agua-contaminada'] = {
        name = 'Água suja',
        type = 'common',
        weight = 0.5,
        model = nil,
        afterItem = 'garrafa-vazia',
        usable = true,
        consumable = {
            health = 0,
            armor = 0,
            thirst = -20,
            hunger = 0,
            toxic = 30,
            timeout = 10000,
        },
        animation = {
            anim = {'amb@world_human_drinking@beer@male@idle_a','idle_a',49,28422}, 
            prop = 'prop_ld_flow_bottle',
        }
    },
    ['torso'] = {
        name = 'Torso',
        type = 'common',
        weight = 0.3,
        model = nil,

        usable = true,
        interaction = function(source, user_id)
            TriggerClientEvent('zSkinShop:open', source, 'gravata')
        end
    },
    ['erva-moida'] = {
    name = 'Erva moída',
    type = 'common',
    weight = 0.5,
    model = nil,
    usable = true,
    interaction = function(source, user_id)
    end
    },
    ['molinete'] = {
    name = 'Molinete',
    type = 'common',
    weight = 1,
    model = nil,
    usable = true,
    interaction = function(source, user_id)
    end
    },
    ['pet-husky'] = {
    name = 'Filhote Husky',
    type = 'common',
    weight = 1,
    model = nil,
    usable = true,
    interaction = function(source, user_id)
        adoptPet('pet-husky')
    end
    },
    ['moeda-prata'] = {
    name = 'Moeda de Prata',
    type = 'common',
    weight = 0,
    model = nil,
    usable = true,
    interaction = function(source, user_id)
    end
    },
    ['veh-motor'] = {
    name = 'Motor para Carro',
    type = 'common',
    weight = 10,
    model = nil,
    usable = true,
    interaction = function(source, user_id)
    end
    },
    ['jaqueta'] = {
        name = 'Jaqueta',
        type = 'common',
        weight = 0.3,
        model = nil,


        usable = true,
        interaction = function(source, user_id)
            TriggerClientEvent('zSkinShop:open', source, 'jaqueta')
        end
    },
    ['filtro-de-ar'] = {
    name = 'Filtro de Ar',
    type = 'common',
    weight = 1,
    model = nil,
    usable = true,
    interaction = function(source, user_id)
    end
    },
    ['radio'] = {
        name = 'Rádio',
        type = 'common',
        weight = 0.5,
        model = nil,


        usable = true,
        interaction = function(source, user_id)
            TriggerClientEvent('radio:use', source)
        end
    },
    ['mira'] = {
    name = 'Mira',
    type = 'common',
    weight = 2,
    model = nil,
    usable = true,
    interaction = function(source, user_id)
    end
    },
    ['chapeu'] = {
        name = 'Chapéu',
        type = 'common',
        weight = 0.3,
        model = nil,


        usable = true,
        interaction = function(source, user_id)
            TriggerClientEvent('zSkinShop:open', source, 'bone')
        end
    },
    ['anzol'] = {
    name = 'Anzol',
    type = 'common',
    weight = 0.1,
    model = nil,
    usable = true,
    interaction = function(source, user_id)
    end
    },
    ['camiseta'] = {
        name = 'Camiseta',
        type = 'common',
        weight = 0.3,
        model = nil,


        usable = true,
        interaction = function(source, user_id)
            TriggerClientEvent('zSkinShop:open', source, 'camisa')
        end
    },
    ['gas-macarico'] = {
    name = 'Gas Maçarico',
    type = 'common',
    weight = 0.5,
    model = nil,
    usable = true,
    interaction = function(source, user_id)
    end
    },
    ['mochila-grande'] = {
        name = 'Mochila Militar',
        type = 'common',
        weight = 2,
        model = nil,


        usable = true,
        interaction = function(source, user_id)
            if vRP.getInventoryMaxWeight(user_id) < 90 then
                if vRP.tryGetInventoryItem(user_id, 'mochila-grande', 1) then
                    vRP.setInventoryMaxWeight(user_id, 90)
                    SetPedComponentVariation(GetPlayerPed(source), 5, 82, 15);
                    TriggerClientEvent(
                        'Notify',
                        source,
                        'vermelho',
                        'Inventário',
                        'Mochila utilizada com sucesso!',
                        5000
                    )
                end
            else
                TriggerClientEvent(
                    'Notify',
                    source,
                    'vermelho',
                    'Inventário',
                    'Você já está utilizando uma mochila melhor ou igual a esta.',
                    5000
                )
            end
        end
    },
    ['carne-vaca'] = {
        name = 'Carne Vaca',
        type = 'common',
        weight = 1,
        model = nil,

        usable = true,
        consumable = {
            health = 0,
            armor = 0,
            thirst = 0,
            hunger = -10,
            toxic = 20,
            timeout = 10000,
        },
        animation = {
            anim = {'mp_player_inteat@burger','mp_player_int_eat_burger',49,60309}, 
            prop = 'prop_cs_steak',
        }
    },
    ['sopa-repolho'] = {
        name = 'Sopa Repolho',
        type = 'common',
        weight = 1.0,
        model = nil,

        usable = true,
        consumable = {
            health = 0,
            armor = 0,
            thirst = -20,
            hunger = -100,
            toxic = 0,
            timeout = 10000,
            buff = 'xp100',
            buffTitleNotify = 'Experiência',
            buffNotify = 'Você recebeu um buff de experiência, aproveite!',
        },
        animation = {
            anim = {'amb@world_human_drinking@beer@male@idle_a','idle_a',49,28422}, 
            prop = 'v_res_fa_tintomsoup',
        }
    },
    ['mascara'] = {
        name = 'Máscara',
        type = 'common',
        weight = 0.3,
        model = nil,

        usable = true,
        interaction = function(source, user_id)
            TriggerClientEvent('zSkinShop:open', source, 'mascara')
        end
    },
    ['carne-veado'] = {
        name = 'Carne Veado',
        type = 'common',
        weight = 1,
        model = nil,

        usable = true,
        consumable = {
            health = 0,
            armor = 0,
            thirst = 0,
            hunger = -10,
            toxic = 20,
            timeout = 10000,
        },
        animation = {
            anim = {'mp_player_inteat@burger','mp_player_int_eat_burger',49,60309}, 
            prop = 'prop_cs_steak',
        }
    },
    ['abobora-estragada'] = {
        name = 'Abóbora estragada',
        type = 'common',
        weight = 1,
        model = nil,

        usable = true,
        interaction = function(source, user_id)
            if (vRP.tryGetInventoryItem(user_id, 'abobora-estragada', 1)) then
                TriggerClientEvent('zero_inventory:disableActions', source)
                vRPclient._CarregarObjeto(
                    source,
                    'mp_player_inteat@burger',
                    'mp_player_int_eat_burger',
                    'ng_proc_food_ornge1a',
                    49,
                    60309
                )
                Wait(5000);
                TriggerClientEvent('zero_inventory:enableActions', source)
                TriggerClientEvent(
                    'Notify',
                    source,
                    'vermelho',
                    'Inventário',
                    'Você comeu algo estragado.',
                    5000
                )
                vRPclient._DeletarObjeto(source)
                vRPclient._playAnim(source, false, {{'missfam5_blackout', 'vomit'}}, false)
                local damageTimes = 0
                while damageTimes < 3 
                do
                    vRPclient.setHealth(source, vRPclient.getHealth(source) - 25)
                    damageTimes = damageTimes + 1
                    Wait(3000)
                end
            end
        end
    },
    ['carne-porco'] = {
        name = 'Carne Porco',
        type = 'common',
        weight = 1,
        model = nil,

        usable = true,
        consumable = {
            health = 0,
            armor = 0,
            thirst = 0,
            hunger = -10,
            toxic = 20,
            timeout = 10000,
        },
        animation = {
            anim = {'mp_player_inteat@burger','mp_player_int_eat_burger',49,60309}, 
            prop = 'prop_cs_steak',
        }
    },
    ['pedaco-metal'] = {
    name = 'Pedaço Metal',
    type = 'common',
    weight = 1,
    model = nil,
    usable = true,
    interaction = function(source, user_id)
    end
    },
    ['filtro'] = {
    name = 'filtro',
    type = 'common',
    weight = 1,
    model = nil,
    usable = true,
    interaction = function(source, user_id)
    end
    },
    ['torta-sardinha'] = {
        name = 'Torta de sardinha',
        type = 'common',
        weight = 1.0,
        model = nil,

        usable = true,
        consumable = {
            health = 0,
            armor = 0,
            thirst = -20,
            hunger = -50,
            toxic = 0,
            timeout = 10000,
            buff = 'infec50',
            buffTitleNotify = 'Infecção',
            buffNotify = 'Zumbis te infectam 50% menos ao te atacar.',
        },
        animation = {
            anim = {'mp_player_inteat@burger','mp_player_int_eat_burger',49,60309}, 
            prop = 'prop_cs_steak',
        }
    },
    ['couro-refinado'] = {
    name = 'Couro refinado',
    type = 'common',
    weight = 1,
    model = nil,
    usable = true,
    interaction = function(source, user_id)
    end
    },
    ['madeira'] = {
    name = 'Madeira',
    type = 'common',
    weight = 2,
    model = nil,
    usable = true,
    interaction = function(source, user_id)
    end
    },
    ['linha'] = {
    name = 'Linha',
    type = 'common',
    weight = 0.5,
    model = nil,
    usable = true,
    interaction = function(source, user_id)
    end
    },
    ['banana'] = {
        name = 'Banana',
        type = 'common',
        weight = 0.5,
        model = nil,

        usable = true,
        consumable = {
            health = 0,
            armor = 0,
            thirst = 0,
            hunger = -10,
            toxic = 20,
            timeout = 10000,
        },
        animation = {
            anim = {'mp_player_inteat@burger','mp_player_int_eat_burger',49,60309}, 
            prop = 'v_res_tre_banana',
        }
    },
    ['cano'] = {
    name = 'Cano',
    type = 'common',
    weight = 2,
    model = nil,
    usable = true,
    interaction = function(source, user_id)
    end
    },
    ['bateria'] = {
    name = 'Bateria',
    type = 'common',
    weight = 0.5,
    model = nil,
    usable = true,
    interaction = function(source, user_id)
    end
    },
    ['antibiotico'] = {
        name = 'Antibiótico',
        type = 'common',
        weight = 0.5,
        model = nil,
        usable = true,
        drug = {
            heal = nil,
            heal_times = 0,
            heal_toxic = -20,
            heal_toxic_times = 5
        }
    },
    ['caixa-vazia'] = {
    name = 'Caixa vazia',
    type = 'common',
    weight = 0.5,
    model = nil,
    usable = true,
    interaction = function(source, user_id)
    end
    },
    ['chave-fenda'] = {
    name = 'Chave Fenda',
    type = 'common',
    weight = 0.5,
    model = nil,
    usable = true,
    interaction = function(source, user_id)
    end
    },
    ['moeda-ouro'] = {
    name = 'Moeda de Ouro',
    type = 'common',
    weight = 0,
    model = nil,
    usable = true,
    interaction = function(source, user_id)
    end
    },
    ['carne-coelho'] = {
        name = 'Carne Coelho',
        type = 'common',
        weight = 1,
        model = nil,

        usable = true,
        consumable = {
            health = 0,
            armor = 0,
            thirst = 0,
            hunger = -10,
            toxic = 20,
            timeout = 10000,
        },
        animation = {
            anim = {'mp_player_inteat@burger','mp_player_int_eat_burger',49,60309}, 
            prop = 'prop_cs_steak',
        }
    },
    ['pederneira'] = {
        name = 'Pederneira',
        type = 'common',
        weight = 0.5,
        model = nil,

        usable = true,
        interaction = function(source, user_id)
            if vRP.tryGetInventoryItem(user_id, 'carvao', 5) and vRP.tryGetInventoryItem(user_id, 'pedaco-metal', 1) then
                local broke = math.random(0, 10)
                if broke <= 3 then
                    if vRP.tryGetInventoryItem(user_id, 'pederneira', 1) then
                        TriggerClientEvent('Notify', source, 'Inventário', 'Sua pederneira quebrou!', 5000)
                    end
                end
                
                if setupCumpfire(source) then
                    TriggerClientEvent('Notify', source, 'Inventário', 'Fogueira posicionada com sucesso!', 5000)
                else
                    TriggerClientEvent('Notify', source, 'Inventário', 'Você não pode colocar uma fogueira aqui!', 5000)
                end
            else
                TriggerClientEvent('Notify', source, 'Inventário', 'Você precisa de 5 pedaços de carvão e 1 pedaço de metal!', 5000)
            end
        end
    },
    ['bau-pequeno'] = {
        name = 'Baú Pequeno',
        type = 'common',
        weight = 12,
        model = nil,

        usable = true,
        interaction = function(source, user_id)
            if vRP.tryGetInventoryItem(user_id, 'bau-pequeno', 1) then
                if (not exports["zBrazuca"]:homesUpdateChest(user_id, 25)) then
                    vRP.giveInventoryItem(user_id, 'bau-pequeno', 1)
                end
            end
        end
    },
    ['bau-grande'] = {
        name = 'Baú Grande',
        type = 'common',
        weight = 50,
        model = nil,

        usable = true,
        interaction = function(source, user_id)
              if vRP.tryGetInventoryItem(user_id, 'bau-grande', 1) then
                if (not exports["zBrazuca"]:homesUpdateChest(user_id, 100)) then
                    vRP.giveInventoryItem(user_id, 'bau-grande', 1)
                end
            end
        end
    },
    ['sardinha'] = {
    name = 'Sardinha',
    type = 'common',
    weight = 1,
    model = nil,
    usable = true,
    interaction = function(source, user_id)
    end
    },
    ['cadeado'] = {
    name = 'Cadeado',
    type = 'common',
    weight = 1,
    model = nil,
    usable = true,
    interaction = function(source, user_id)
    end
    },
    ['embalagem'] = {
    name = 'Embalagem',
    type = 'common',
    weight = 0.1,
    model = nil,
    usable = true,
    interaction = function(source, user_id)
    end
    },
    ['batata'] = {
    name = 'Batata',
    type = 'common',
    weight = 0.5,
    model = nil,
    usable = true,
    interaction = function(source, user_id)
    end
    },
    ['oculos'] = {
        name = 'Óculos',
        type = 'common',
        weight = 0.3,
        model = nil,


        usable = true,
        interaction = function(source, user_id)
            TriggerClientEvent('zSkinShop:open', source, 'oculos')
        end
    },
    ['pet-pug'] = {
    name = 'Filhote Pug',
    type = 'common',
    weight = 1,
    model = nil,
    usable = true,
    interaction = function(source, user_id)
        TriggerClientEvent('createPet', source, 'pug')
    end
    },
    ['chips'] = {
        name = 'Batata Chips',
        type = 'common',
        weight = 0.5,
        model = nil,

        usable = true,
        consumable = {
            health = 0,
            armor = 0,
            thirst = 0,
            hunger = -20,
            toxic = 10,
            timeout = 10000,
        },
        animation = {
            anim = {'mp_player_inteat@burger','mp_player_int_eat_burger',49,60309}, 
            prop = 'prop_food_cb_chips',
        }
    },
    ['mochila-extra-grande'] = {
        name = 'Mochila Trekking',
        type = 'common',
        weight = 2.5,
        model = nil,

        usable = true,
        interaction = function(source, user_id)
            if vRP.getInventoryMaxWeight(user_id) < 125 then
                if vRP.tryGetInventoryItem(user_id, 'mochila-extra-grande', 1) then
                    vRP.setInventoryMaxWeight(user_id, 125)
                    SetPedComponentVariation(GetPlayerPed(source), 5, 86, 18);
                    TriggerClientEvent(
                        'Notify',
                        source,
                        'vermelho',
                        'Inventário',
                        'Mochila utilizada com sucesso!',
                        5000
                    )
                end
            else
                TriggerClientEvent(
                    'Notify',
                    source,
                    'vermelho',
                    'Inventário',
                    'Você já está utilizando uma mochila melhor ou igual a esta.',
                    5000
                )
            end
        end
    },
    ['tilapia'] = {
    name = 'Tilapia',
    type = 'common',
    weight = 1,
    model = nil,
    usable = true,
    interaction = function(source, user_id)
    end
    },
    ['macarico-quebrado'] = {
    name = 'Maçarico Quebrado',
    type = 'common',
    weight = 1,
    model = nil,
    usable = true,
    interaction = function(source, user_id)
    end
    },
    ['mochila-media'] = {
        name = 'Mochila de Viagem',
        type = 'common',
        weight = 1.5,
        model = nil,

        usable = true,
        interaction = function(source, user_id)
            if vRP.getInventoryMaxWeight(user_id) < 55 then
                if vRP.tryGetInventoryItem(user_id, 'mochila-media', 1) then
                    vRP.setInventoryMaxWeight(user_id, 55)
                    SetPedComponentVariation(GetPlayerPed(source), 5, 53, 6, 3);
                    TriggerClientEvent(
                        'Notify',
                        source,
                        'vermelho',
                        'Inventário',
                        'Mochila utilizada com sucesso!',
                        5000
                    )
                end
            else
                TriggerClientEvent(
                    'Notify',
                    source,
                    'vermelho',
                    'Inventário',
                    'Você já está utilizando uma mochila melhor ou igual a esta.',
                    5000
                )
            end
        end
    },
    ['fogueira'] = {
    name = 'Fogueira',
    type = 'common',
    weight = 3,
    model = nil,
    usable = true,
    interaction = function(source, user_id)
    end
    },
    ['vara-pesca'] = {
        name = 'Vara Pesca',
        type = 'common',
        weight = 2,
        model = nil,

        usable = true,
        interaction = function(source, user_id)
            pescar(source, user_id, 'vara-pesca', 1)
        end
    },
    ['pet-shepherd'] = {
    name = 'Filhote Shepherd',
    type = 'common',
    weight = 1,
    model = nil,
    usable = true,
    interaction = function(source, user_id)
        adoptPet('pet-shepherd')
    end
    },
    ['vara-pesca-pro'] = {
        name = 'Vara Pesca Pro',
        type = 'common',
        weight = 5,
        model = nil,

        usable = true,
        interaction = function(source, user_id)
            pescar(source, user_id, 'vara-pesca-pro', 1)
        end
    },
    ['cadarco'] = {
    name = 'Cadarço',
    type = 'common',
    weight = 0.5,
    model = nil,
    usable = true,
    interaction = function(source, user_id)
    end
    },
    ['bacalhoada'] = {
        name = 'Bacalhoada',
        type = 'common',
        weight = 1.0,
        model = nil,

        usable = true,
        consumable = {
            health = 0,
            armor = 0,
            thirst = -20,
            hunger = -100,
            toxic = 0,
            timeout = 10000,
            buff = 'infec100',
            buffTitleNotify = 'Infecção',
            buffNotify = 'Zumbis não te infectam mais ao te atacar.',
        },
        animation = {
            anim = {'mp_player_inteat@burger','mp_player_int_eat_burger',49,60309}, 
            prop = 'prop_cs_steak',
        }
    },
    ['pele-jaguatirica'] = {
    name = 'Pele Jaguatirica',
    type = 'common',
    weight = 1,
    model = nil,
    usable = true,
    interaction = function(source, user_id)
    end
    },
    ['brincos'] = {
        name = 'Brincos',
        type = 'common',
        weight = 0.3,
        model = nil,

        usable = true,
        interaction = function(source, user_id)
            TriggerClientEvent('zSkinShop:open', source, 'brinco')
        end
    },
    ['mangueira'] = {
    name = 'Mangueira',
    type = 'common',
    weight = 1,
    model = nil,
    usable = true,
    interaction = function(source, user_id)
    end
    },
    ['agulha'] = {
    name = 'Agulha',
    type = 'common',
    weight = 0.1,
    model = nil,
    usable = true,
    interaction = function(source, user_id)
    end
    },
    ['pilao'] = {
    name = 'Pilão',
    type = 'common',
    weight = 5,
    model = nil,
    usable = true,
    interaction = function(source, user_id)
    end
    },
    ['pibwassen'] = {
        name = 'Pibwassen',
        type = 'common',
        weight = 0.5,
        model = nil,

        usable = true,
        consumable = {
            health = 0,
            armor = 0,
            thirst = -35,
            hunger = 0,
            toxic = 5,
            timeout = 10000,
        },
        animation = {
            anim = {'amb@world_human_drinking@beer@male@idle_a','idle_a',49,28422}, 
            prop = 'prop_beer_bar',
        }
    },
    ['roupas'] = {
        name = 'Roupas',
        type = 'common',
        weight = 1.0,
        model = nil,

        usable = true,
        interaction = function(source, user_id)
            TriggerClientEvent('zSkinShop:open', source)
        end
    },
    ['bacon'] = {
        name = 'Bacon',
        type = 'common',
        weight = 0.5,
        model = nil,

        usable = true,
        consumable = {
            health = 0,
            armor = 0,
            thirst = 0,
            hunger = -10,
            toxic = 20,
            timeout = 10000,
        },
        animation = {
            anim = {'mp_player_inteat@burger','mp_player_int_eat_burger',49,60309}, 
            prop = 'prop_cs_steak',
        }
    },
    ['repolho'] = {
    name = 'Repolho',
    type = 'common',
    weight = 0.5,
    model = nil,
    usable = true,
    interaction = function(source, user_id)
    end
    },
    ['veh-acessorios'] = {
    name = 'Acessorios para Carro',
    type = 'common',
    weight = 5,
    model = nil,
    usable = true,
    interaction = function(source, user_id)
    end
    },
    ['abobora'] = {
    name = 'Abóbora',
    type = 'common',
    weight = 1,
    model = nil,
    usable = true,
    interaction = function(source, user_id)
    end
    },
    ['gatilho'] = {
    name = 'Gatilho',
    type = 'common',
    weight = 2,
    model = nil,
    usable = true,
    interaction = function(source, user_id)
    end
    },
    ['pet-cat'] = {
    name = 'Filhote Gato',
    type = 'common',
    weight = 1,
    model = nil,
    usable = true,
    interaction = function(source, user_id)
        adoptPet('pet-cat')
    end
    },
    ['bolsa-sangue-vazia'] = {
    name = 'B. Sangue Vazia',
    type = 'common',
    weight = 0,
    model = nil,
    usable = true,
    interaction = function(source, user_id)
    end
    },
    ['kit-ferramentas'] = {
    name = 'Kit Ferramentas',
    type = 'common',
    weight = 1.5,
    model = nil,
    usable = true,
    interaction = function(source, user_id)
    end
    },
    ['moeda-bronze'] = {
    name = 'Moeda de Bronze',
    type = 'common',
    weight = 0,
    model = nil,
    usable = true,
    interaction = function(source, user_id)
    end
    },
    ['doc01'] = {
    name = 'Carta #001',
    type = 'common',
    weight = 0,
    model = nil,
    usable = true,
    interaction = function(source, user_id)
        TriggerClientEvent("an4log_events:openDocument", source, "doc01")
    end
    },
    ----------------------------------------------------------------------------
    -- Armas
    ----------------------------------------------------------------------------
    ['weapon_doubleaction'] = {
        name = 'Dourada',
        type = 'weapon',
        weight = 1,
        model = nil,
    },
    ['m_weapon_doubleaction'] = {
        name = 'M. Dourada',
        type = 'wammo',
        weight = 0.5,
        model = nil,
    },
    ['weapon_combatpistol'] = {
        name = 'Glock',
        type = 'weapon',
        weight = 1,
        model = nil,
    },
    ['m_weapon_combatpistol'] = {
        name = 'M. Glock',
        type = 'wammo',
        weight = 0.5,
        model = nil,
    },
    ['weapon_pistol'] = {
        name = 'M1911',
        type = 'weapon',
        weight = 1,
        model = nil,
    },
    ['m_weapon_pistol'] = {
        name = 'M. M1911',
        type = 'wammo',
        weight = 0.5,
        model = nil,
    },
    ['weapon_revolver_mk2'] = {
        name = 'R8 Revolver',
        type = 'weapon',
        weight = 1.5,
        model = nil,
    },
    ['m_weapon_revolver_mk2'] = {
        name = 'M. R8 Revolver',
        type = 'wammo',
        weight = 0.5,
        model = nil,
    },
    ['weapon_smg'] = {
        name = 'MP5',
        type = 'weapon',
        weight = 2.5,
        model = nil,
    },
    ['m_weapon_smg'] = {
        name = 'M. MP5',
        type = 'wammo',
        weight = 0.5,
        model = nil,
    },
    ['weapon_gusenberg'] = {
        name = 'Thompson',
        type = 'weapon',
        weight = 2.5,
        model = nil,
    },
    ['m_weapon_gusenberg'] = {
        name = 'M. Thompson',
        type = 'wammo',
        weight = 0.5,
        model = nil,
    },
    ['weapon_microsmg'] = {
        name = 'Uzi',
        type = 'weapon',
        weight = 2.5,
        model = nil,
    },
    ['m_weapon_microsmg'] = {
        name = 'M. Uzi',
        type = 'wammo',
        weight = 0.5,
        model = nil,
    },
    ['weapon_carbinerifle_mk2'] = {
        name = 'M4A1',
        type = 'weapon',
        weight = 3,
        model = nil,
    },
    ['m_weapon_carbinerifle_mk2'] = {
        name = 'M. M4A1',
        type = 'wammo',
        weight = 0.5,
        model = nil,
    },
    ['weapon_assaultrifle'] = {
        name = 'AK-47',
        type = 'weapon',
        weight = 3,
        model = nil,
    },
    ['m_weapon_assaultrifle'] = {
        name = 'M. AK-47',
        type = 'wammo',
        weight = 0.5,
        model = nil,
    },
    ['weapon_assaultrifle'] = {
        name = 'AK-47',
        type = 'weapon',
        weight = 3,
        model = nil,
    },
    ['m_weapon_assaultrifle'] = {
        name = 'M. AK-47',
        type = 'wammo',
        weight = 0.5,
        model = nil,
    },
    ['weapon_sniperrifle'] = {
        name = 'Scout',
        type = 'weapon',
        weight = 4,
        model = nil,
    },
    ['m_weapon_sniperrifle'] = {
        name = 'M. Scout',
        type = 'wammo',
        weight = 0.7,
        model = nil,
    },
    ['weapon_heavysniper_mk2'] = {
        name = 'AWP',
        type = 'weapon',
        weight = 4,
        model = nil,
    },
    ['m_weapon_heavysniper_mk2'] = {
        name = 'M. AWP',
        type = 'wammo',
        weight = 0.7,
        model = nil,
    },
    ['weapon_heavysniper_mk2'] = {
        name = 'AWP',
        type = 'weapon',
        weight = 4,
        model = nil,
    },
    ['m_weapon_heavysniper_mk2'] = {
        name = 'M. AWP',
        type = 'wammo',
        weight = 0.7,
        model = nil,
    },
    ['weapon_pumpshotgun_mk2'] = {
        name = 'Remington',
        type = 'weapon',
        weight = 4,
        model = nil,
    },
    ['m_weapon_pumpshotgun_mk2'] = {
        name = 'M. Remington',
        type = 'wammo',
        weight = 0.7,
        model = nil,
    },
    ['weapon_musket'] = {
        name = 'Mosquete',
        type = 'weapon',
        weight = 4,
        model = nil,
    },
    ['m_weapon_musket'] = {
        name = 'M. Mosquete',
        type = 'wammo',
        weight = 0.7,
        model = nil,
    },
    ['weapon_wrench'] = {
        name = 'Chave Inglesa',
        type = 'weapon',
        weight = 1,
        model = nil,
    },
    ['weapon_hammer'] = {
        name = 'Martelo',
        type = 'weapon',
        weight = 1,
        model = nil,
    },
    ['weapon_bat'] = {
        name = 'Bastão',
        type = 'weapon',
        weight = 1,
        model = nil,
    },
    ['weapon_dagger'] = {
        name = 'Adaga',
        type = 'weapon',
        weight = 1,
        model = nil,
    },
    ['weapon_bottle'] = {
        name = 'Garrafa',
        type = 'weapon',
        weight = 1,
        model = nil,
    },
    ['weapon_flashlight'] = {
        name = 'Lanterna',
        type = 'weapon',
        weight = 1,
        model = nil,
    },
    ['weapon_petrolcan'] = {
        name = 'Galão',
        type = 'weapon',
        weight = 1,
        model = nil,
    },
    ['m_weapon_petrolcan'] = {
        name = 'Combustivel',
        type = 'wammo',
        weight = 0.001,
        model = nil,
    },
    ['weapon_hatchet'] = {
        name = 'Machado',
        type = 'weapon',
        weight = 1,
        model = nil,
    },
    ['weapon_crowbar'] = {
        name = 'Pé de Cabra',
        type = 'weapon',
        weight = 1,
        model = nil,
    },
    ['weapon_knuckle'] = {
        name = 'Soco Inglês',
        type = 'weapon',
        weight = 1,
        model = nil,
    },
    ['weapon_knife'] = {
        name = 'Faca',
        type = 'weapon',
        weight = 1,
        model = nil,
    },
    ['weapon_machete'] = {
        name = 'Machete',
        type = 'weapon',
        weight = 1,
        model = nil,
    },
    ['weapon_switchblade'] = {
        name = 'Canivete',
        type = 'weapon',
        weight = 1,
        model = nil,
    },
    ['weapon_stone_hatchet'] = {
        name = 'Machado de Pedra',
        type = 'weapon',
        weight = 1,
        model = nil,
    },
    ['weapon_poolcue'] = {
        name = 'Taco de sinuca',
        type = 'weapon',
        weight = 1,
        model = nil,
    },
    ['weapon_golfclub'] = {
        name = 'Taco de golf',
        type = 'weapon',
        weight = 1,
        model = nil,
    },
    ['weapon_ball'] = {
        name = 'Bolinha',
        type = 'weapon',
        weight = 1,
        model = nil,
    },
}


function consumableItem(index)
   local _source = source
   local user_id = vRP.getUserId(_source)
   local customTimeout = 10000

   local cItem = config.items[index]

--    if index == 'agua' and exports['an4log_pets']:petIsClose(_source) then
--         TriggerClientEvent('waterToPet', _source)
--         return 
--     end

--    if cItem.consumable.hunger ~= 0 and exports['an4log_pets']:petIsClose(_source) then
--         TriggerClientEvent('feedPet', _source)
--         return 
--     end

   if vRP.tryGetInventoryItem(user_id, index, 1) then
    TriggerClientEvent('progress', _source, customTimeout, "Consumindo "..vRP.itemNameList(index).."...")
    if cItem.animation then 
        if cItem.animation.prop then
            vRPclient._CarregarObjeto(_source, cItem.animation.anim[1], cItem.animation.anim[2], cItem.animation.prop, cItem.animation.anim[3], cItem.animation.anim[4])
        end
        vRPclient._playAnim(_source, true, { cItem.animation.anim }, true)
    end
    
    SetTimeout(customTimeout, function()
        vRPclient._DeletarObjeto(_source)
        -- Sede, fome e Toxicidade
        local consumable = cItem.consumable
        
        if consumable.hunger and consumable.hunger ~= 0 then
            vRP.varyHunger(user_id, consumable.hunger)
        end
        if consumable.thirst and consumable.thirst ~= 0 then
            vRP.varyThirst(user_id, consumable.thirst)
        end
        if consumable.toxic > 0 then
            vRP.varyToxic(user_id, consumable.toxic)
            TriggerClientEvent(
                'Notify',
                _source,
                'sucesso',
                'Infecção',
                'O seu nível de infecção aumentou.',
                5000
            )
        end
        if cItem.afterItem then 
            vRP.giveInventoryItem(user_id, cItem.afterItem, 1)
        end
        
        if consumable.buff then
            vRPclient._playAnim(_source, false, {{'mini@triathlon', 'idle_e'}}, false)
            vRP.addUserGroup(user_id, consumable.buff, consumable.buff)
            TriggerClientEvent(
                'Notify',
                _source,
                'vermelho',
                consumable.buffTitleNotify,
                consumable.buffNotify,
                5000
            )
        end
        
        if consumable.armor ~= 0 and consumable.armor ~= nil then 
            local newArmor = cl.getArmor(_source) + consumable.armor
            if newArmor > 100 then newArmor = 100; end;
            cl.setArmour(_source,newArmor)
            TriggerClientEvent(
                'Notify',
                _source,
                'sucesso',
                'Shield',
                'Você recebeu mais '..consumable.armor..'% de shield.',
                5000
            )
        end

        TriggerClientEvent(
            'Notify',
            _source,
            'sucesso',
            'Inventário',
            'Você consumiu ' .. vRP.itemNameList(index) .. '.',
            5000
        )
    end)
   end
end

function healing(item)
    local _source = source
    local user_id = vRP.getUserId(source)
    local drug = config.items[item]
    if (user_id) and drug then
        local currentHealth = vRPclient.getHealth(_source)
        if (currentHealth > 250) or item == 'antibiotico' then
            if vRP.tryGetInventoryItem(user_id, item, 1) then
                TriggerClientEvent('zero_inventory:closeInventory', _source)
                TriggerClientEvent('progress', _source, 6000, 'Tomando '..vRP.itemNameList(item))
                vRPclient._CarregarObjeto(_source, 'amb@world_human_drinking@beer@male@idle_a', 'idle_a', 'ng_proc_drug01a002', 48, 28422)
                Citizen.SetTimeout(6000, function()
                    vRPclient._DeletarObjeto(_source)
                    vRPclient._stopAnim(_source, false)
                end)   

                local healTimes = 0
                local toxicHealTimes = 0
                
                local drugsConfig = drug.drug
                while (healTimes < drugsConfig.heal_times) do
                    currentHealth = vRPclient.getHealth(_source)
                    if (currentHealth == 400) then
                        healTimes = drugsConfig.heal_times
                    else
                        vRPclient.setHealth(_source, currentHealth + drugsConfig.heal)
                    end
                    healTimes = healTimes + 1
                    Citizen.Wait(3000)
                end

                if (drugsConfig.heal_toxic) then
                    while toxicHealTimes < drugsConfig.heal_toxic_times do
                        vRP._varyToxic(user_id, drugsConfig.heal_toxic)
                        toxicHealTimes = toxicHealTimes + 1
                        Citizen.Wait(3000)
                    end
                end
            end
        else
            TriggerClientEvent(
                'Notify',
                _source,
                'negado',
                'Medicina', 
                'Este medicamento só pode ser utilizado quando sua saúde estiver acima de 50%.',
                5000
            )
        end
    end
end

function setupCumpfire()
	if exports["zBrazuca"]:isSafe() then
        return false
    end
    
    local modelhash = GetHashKey("prop_hobo_stove_01")
	RequestModel(modelhash)
	while not HasModelLoaded(modelhash) do
		Wait(50)
	end
	local coords = GetOffsetFromEntityInWorldCoords(PlayerPedId(), 0.0, 2.0, - 0.94)
	local heading = GetEntityHeading(PlayerPedId())
	local object = CreateObject(modelhash, coords.x, coords.y - 0.5, coords.z, true, true, true)
	while not DoesEntityExist(object) do
		Wait(10)
	end
    SetEntityAsMissionEntity(object, true, true)
	SlideObject(object, coords.x, coords.y - 0.5, coords.z - GetEntityHeightAboveGround(object - 0.1), 10.0, 10.0, 10.0, true)	
	SetEntityHeading(object, heading)
    SetModelAsNoLongerNeeded(modelhash)
	FreezeEntityPosition(object, true)

    return true
end

threadBandagem = function(user_id, time)
    Citizen.CreateThread(function()
        bandagemCooldown[user_id] = time
        while (bandagemCooldown[user_id] > 0) do
            Citizen.Wait(1000)
            bandagemCooldown[user_id] = bandagemCooldown[user_id] - 1
        end
        bandagemCooldown[user_id] = false
    end)
end

function adoptPet(pet)
    local _source = source 
    local user_id = vRP.getUserId(_source)
    if vRP.tryGetInventoryItem(user_id, pet, 1) then
        local pet_type = splitString(pet,"-")[2]
        if pet_type then
            TriggerClientEvent('createPet', _source, pet_type)
        end
    end
end

function pescar(source, user_id, item)
    if true then
        local lucky = 0
        if item == 'vara-pesca-pro' then
            lucky = 5
        end
        local fishes = {
            { name = 'lagosta', chance = 2 + lucky },
            { name = 'bacalhau', chance = 10 + lucky },
            { name = 'atum', chance = 40 + lucky },
            { name = 'sardinha', chance = 40 + lucky },
            { name = 'tilapia', chance = 30 + lucky },
            { name = 'salmao', chance = 30 + lucky },
        }
        
        local inWater, distance = cInventory.getWaterHeight(source)
        if inWater then
            if vRP.tryGetInventoryItem(user_id, 'isca', 1) then
                TriggerClientEvent('cancelando', source, true)
                TriggerClientEvent('zero_inventory:disableActions', source, true)
                TriggerClientEvent('emotes', source, 'pescar')
                cInventory.closeInventory(source)
                local taskResult = cTASKBAR.taskLockpick(source)
                if taskResult then
                    local currentFish = ''
                    for k, fish in pairs(fishes) do
                        local random = math.random(0, 100)
                        local chance = fish['chance']
                        if vRP.getInventoryItemAmount(user_id, "pe-coelho") then
                            chance = chance + 5
                        end

                        if random <= chance then
                            currentFish = fish['name']
                            break
                        end
                    end

                    if currentFish == '' then currentFish = 'tilapia' end

                    if (vRP.getItemWeight(currentFish)+vRP.getInventoryWeight(user_id)) <= vRP.getInventoryMaxWeight(user_id) then
                        TriggerClientEvent('Notify', source, "Inventário", 'Pesca', 'Você pescou um(a) <b>'..currentFish..'</b>!', 5000)
                        vRP.giveInventoryItem(user_id, currentFish, 1)
                    else 
                        TriggerClientEvent('Notify', source, "Inventário", 'Inventário', 'Você não possui espaço na mochila!', 5000)
                    end
                end
                TriggerClientEvent('zero_inventory:enableActions', source, true)
                TriggerClientEvent('cancelando', source, false)
                vRPclient._stopAnim(source, false)
                vRPclient._DeletarObjeto(source)
            end
        end
    else
        TriggerClientEvent('Notify', source, "Inventário", 'Proficiência', 'Você não possui conhecimento em pesca para fazer isso!!', 5000)
    end
end

getItem = function(index)
    return config.items[index]
end
exports('getItem', getItem)