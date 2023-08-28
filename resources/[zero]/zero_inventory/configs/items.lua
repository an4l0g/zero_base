bandagemCooldown = {}

config.itemTypes = { 'common', 'weapon', 'wammo' }
this = exports[GetCurrentResourceName()]

comboFood = function(index)
    local _source = source
    local user_id = zero.getUserId(_source)
    if zero.tryGetInventoryItem(user_id, index, 1) then
        for k,v in pairs(config.items[index].combo) do
            zero.giveInventoryItem(user_id, v.index, v.qtd)
        end
        TriggerClientEvent('notify', _source, 'Inventário', 'Você abriu o combo: <b>'..config.items[index].name..'</b>.')
    end
end

newPet = function(source, user_id, item, petType)
    if zero.tryGetInventoryItem(user_id, item, 1) then
        TriggerClientEvent('createPet', source, petType)
    else
        TriggerClientEvent('notify', source, 'Inventário', 'Você não possui este pet!')
    end
end

useBag = function(source, user_id, index, weight) 
    if weight > exports.zero_inventory:getInventoryMaxWeight(user_id) then
        if zero.tryGetInventoryItem(user_id, index, 1) then
            exports.zero_inventory:setInventoryMaxWeight(user_id, weight)
            zeroClient._playAnim(source, true, {{'clothingshirt','try_shirt_positive_d'}}, false)
            TriggerClientEvent('notify', source, 'Inventário', 'Você utilizou a mochila com sucesso!')
        else
            TriggerClientEvent('notify', source, 'Inventário', 'Você não possui esta mochila!')
        end
    else
        TriggerClientEvent('notify', source, 'Inventário', 'Você já utilizou uma mochila desta ou melhor!')
    end
end

useColete = function(source, user_id, item)
    if zero.tryGetInventoryItem(user_id, item, 1) then
        local ped = GetPlayerPed(source)
        Player(source).state.BlockTasks = true
        cInventory.closeInventory(source)
        zeroClient._playAnim(source, true, {{'clothingshirt','try_shirt_positive_d'}}, false)
        TriggerClientEvent('progressBar', source, 'Equipando colete...', 10000)
        Wait(10000)
        SetPedArmour(ped, 100)
        ClearPedTasks(source)
        Player(source).state.BlockTasks = false
        TriggerClientEvent('notify', source, 'Inventário', 'Colete utilizado com sucesso!')
    end
end

config.items = {
----------------------------------------------------------------------------
-- HOSPITAL
----------------------------------------------------------------------------
    ['bandagem'] = { 
        name = 'Bandagem', 
        type = 'common', 
        usable = true,
        weight = 2, 
        interaction = function(source, user_id)
            if bandagemCooldown[user_id] then 
                TriggerClientEvent('notify', source, 'Bandagem', 'Você ainda não pode utilizar a bandagem...')
            else 
                if zero.tryGetInventoryItem(user_id, "bandagem", 1) then
                    local countHeal = 0
                    TriggerClientEvent('progressBar', source, 'Utilizando bandagem...', 5000)
                    Player(source).state.BlockTasks = true
                    zeroClient._playAnim(source, true, {{'amb@world_human_gardener_plant@male@idle_a','idle_a'}}, false)
                    while countHeal < 3 do
                        if countHeal == 1 then
                            ClearPedTasks(source)
                            Player(source).state.BlockTasks = false
                        end
                        zeroClient.varyHealth(source, 20)
                        countHeal = countHeal + 1
                        cInventory.closeInventory(source)
                        Wait(5000)
                    end
                    threadBandagem(user_id, 600000) -- 10 minutos
                end
            end
        end 
    },
----------------------------------------------------------------------------
-- WORKS
----------------------------------------------------------------------------
    ['caixaroupas'] = { name = 'Caixa de roupas', type = 'common', weight = 1 },
    ['encomendapostop'] = { name = 'Encomenda PO', type = 'common', weight = 1 },
    ['encomendagopostal'] = { name = 'Encomenda GP', type = 'common', weight = 1 },
    ['caixabebidas'] = { name = 'Caixa de bebidas', type = 'common', weight = 1 },
    ['botijao-vazio'] = { name = 'Botijão Vázio', type = 'common', weight = 1 },
    ['botijao-cheio'] = { name = 'Botijão Cheio', type = 'common', weight = 1 },
    ['ferramentas'] = { name = 'Ferramentas', type = 'common', weight = 1 },
    ['tecidos'] = { name = 'Tecidos', type = 'common', weight = 0.5 },
    ['roupa'] = { name = 'Roupa', type = 'common', weight = 0.5 },
    ['tecidos'] = { name = 'Tecidos', type = 'common', weight = 0.5 },
    ['tecidos'] = { name = 'Tecidos', type = 'common', weight = 0.5 },
    ['tecidos'] = { name = 'Tecidos', type = 'common', weight = 0.5 },
----------------------------------------------------------------------------
-- COMIDAS
----------------------------------------------------------------------------
    ['c-ingredientes'] = { name = 'C. Ingredientes', type = 'common', weight = 2 },
    ['camarao'] = {
        name = 'Esp. Camarão', 
        type = 'common', 
        anim = { 'mp_player_inteat@burger', 'mp_player_int_eat_burger', 49, 60309 }, 
        prop = 'prop_peyote_chunk_01', 
        weight = 1,
        consumable = { hunger = -75, thirst = 0, timeout = 5000 }, 
        usable = true, 
    },
    ['milho'] = {
        name = 'Milho Cozido', 
        type = 'common', 
        anim = { 'mp_player_inteat@burger', 'mp_player_int_eat_burger', 49, 60309 }, 
        prop = 'prop_peyote_chunk_01', 
        weight = 1,
        consumable = { hunger = -75, thirst = 0, timeout = 5000 }, 
        usable = true, 
    },
    ['chocolate'] = {
        name = 'Chuculate', 
        type = 'common', 
        anim = { 'mp_player_inteat@burger', 'mp_player_int_eat_burger', 49, 60309 }, 
        prop = 'prop_peyote_chunk_01', 
        weight = 1,
        consumable = { hunger = -75, thirst = 0, timeout = 5000 }, 
        usable = true, 
    },
    ['caviar'] = {
        name = 'Aviar', 
        type = 'common', 
        anim = { 'mp_player_inteat@burger', 'mp_player_int_eat_burger', 49, 60309 }, 
        prop = 'prop_peyote_chunk_01', 
        weight = 1,
        consumable = { hunger = -75, thirst = 0, timeout = 5000 }, 
        usable = true, 
    },
    ['suco-morango'] = { 
        name = 'Suco Morango', 
        type = 'common',
        anim = { 'mp_player_intdrink', 'loop_bottle', 49, 60309 }, 
        prop = 'prop_food_bs_juice02', 
        weight = 1, 
        consumable = { hunger = 0, thirst = -25, timeout = 5000 }, 
        usable = true,
    },
    ['suco-abacaxi'] = { 
        name = 'Suco Abacaxi', 
        type = 'common',
        anim = { 'mp_player_intdrink', 'loop_bottle', 49, 60309 }, 
        prop = 'prop_food_bs_juice02', 
        weight = 1, 
        consumable = { hunger = 0, thirst = -25, timeout = 5000 }, 
        usable = true,
    },
    ['suco-kiwi'] = { 
        name = 'Suco Kiwi', 
        type = 'common',
        anim = { 'mp_player_intdrink', 'loop_bottle', 49, 60309 }, 
        prop = 'prop_food_bs_juice02', 
        weight = 1, 
        consumable = { hunger = 0, thirst = -25, timeout = 5000 }, 
        usable = true,
    },
    ['suco-caju'] = { 
        name = 'Suco Caju', 
        type = 'common',
        anim = { 'mp_player_intdrink', 'loop_bottle', 49, 60309 }, 
        prop = 'prop_food_bs_juice02', 
        weight = 1, 
        consumable = { hunger = 0, thirst = -25, timeout = 5000 }, 
        usable = true,
    },
    ['sanduiche'] = { 
        name = 'Sanduiche', 
        type = 'common', 
        anim = { 'mp_player_inteat@burger', 'mp_player_int_eat_burger', 49, 60309 }, 
        prop = 'prop_peyote_chunk_01',
        weight = 1, 
        consumable = { hunger = -25, thirst = 0, timeout = 5000 }, 
        usable = true, 
    },
    ['donut'] = { 
        name = 'Donut',
        type = 'common', 
        weight = 1, 
        anim = { 'mp_player_inteat@burger', 'mp_player_int_eat_burger', 49, 60309 }, 
        prop = 'prop_peyote_chunk_01',
        consumable = { hunger = -25, thirst = 0, timeout = 5000 }, 
        usable = true, 
    },
    ['pirulito'] = { 
        name = 'Pirulito', 
        type = 'common',
        anim = { 'mp_player_inteat@burger', 'mp_player_int_eat_burger', 49, 60309 }, 
        prop = 'prop_peyote_chunk_01',
        weight = 0.5, 
        consumable = { hunger = -25, thirst = 0, timeout = 5000 }, 
        usable = true, 
    },
    ['hotdog'] = { 
        name = 'Hotdog', 
        type = 'common',
        anim = { 'mp_player_inteat@burger', 'mp_player_int_eat_burger', 49, 60309 }, 
        prop = 'prop_peyote_chunk_01',
        weight = 1, 
        consumable = { hunger = -25, thirst = 0, timeout = 5000 }, 
        usable = true, 
    },
    ['cola'] = { 
        name = 'Cola', 
        type = 'common',
        anim = { 'mp_player_intdrink', 'loop_bottle', 49, 60309 }, 
        prop = 'prop_ecola_can', 
        weight = 1, 
        consumable = { hunger = 0, thirst = -25, timeout = 5000 }, 
        usable = true,
    },
    ['agua'] = { 
        name = 'Água', 
        type = 'common',
        weight = 1.0, 
        anim = { 'mp_player_intdrink', 'loop_bottle', 49, 60309 }, 
        prop = 'prop_energy_drink', 
        consumable = { hunger = 0, thirst = -25, timeout = 5000 }, 
        usable = true 
    },
    ['soda'] = { 
        name = 'Soda', 
        type = 'common', 
        anim = { 'mp_player_intdrink', 'loop_bottle', 49, 60309 }, 
        prop = 'ng_proc_sodacan_01b', 
        weight = 1, 
        consumable = { hunger = 0, thirst = -25, timeout = 5000 }, usable = true, 
    },
    ['vodka'] = { 
        name = 'Vodka', 
        type = 'common', 
        anim = { 'mp_player_intdrink', 'loop_bottle', 49, 60309 }, 
        prop = 'prop_drink_whtwine', 
        weight = 1, 
        consumable = { hunger = 0, thirst = -10, timeout = 5000 }, 
        usable = true, 
    },
    ['whisky'] = { 
        name = 'Whisky', 
        type = 'common', 
        anim = { 'mp_player_intdrink', 'loop_bottle', 49, 60309 }, 
        prop = 'prop_drink_whtwine', 
        weight = 1, 
        consumable = { hunger = 0, thirst = -10, timeout = 5000 }, 
        usable = true, 
    },
    ['cerveja'] = { 
        name = 'Cerveja', 
        type = 'common',
        anim = { 'mp_player_intdrink', 'loop_bottle', 49, 60309 }, 
        prop = 'prop_beer_bison', 
        weight = 1, 
        consumable = { hunger = 0, thirst = -10, timeout = 5000 }, 
        usable = true, 
    },
    ['conhaque'] = { 
        name = 'Conhaque',
        type = 'common', 
        anim = { 'mp_player_intdrink', 'loop_bottle', 49, 60309 }, 
        prop = 'prop_drink_whtwine', 
        weight = 1, 
        consumable = { hunger = 0, thirst = -10, timeout = 5000 }, 
        usable = true, 
    },
    ['tequila'] = {
        name = 'Tequila', 
        type = 'common', 
        anim = { 'mp_player_intdrink', 'loop_bottle', 49, 60309 }, 
        prop = 'prop_drink_whtwine', 
        weight = 1, 
        consumable = { hunger = 0, thirst = -10, timeout = 5000 }, 
        usable = true 
    },
    ['energetico'] = { name = 'Energético', type = 'common', weight = 1.0, usable = true,
        interaction = function(source, user_id)
            cInventory.closeInventory(source)

            zero.tryGetInventoryItem(user_id, 'energetico', 1)
            Player(source).state.BlockTasks = true
            
            zeroClient.CarregarObjeto(source, 'mp_player_intdrink', 'loop_bottle', 'prop_energy_drink', 49, 60309)
            TriggerClientEvent('progressBar', source, 'Bebendo energético...', 5000)
            Citizen.SetTimeout(5000, function()
                Player(source).state.Energetico = true
                Player(source).state.BlockTasks = false
                zeroClient.DeletarObjeto(source)
                TriggerClientEvent('notify', source, 'Inventário', 'O <b>energético</b> foi utilizado com sucesso!')
            end)

            Citizen.SetTimeout(60000, function()
                Player(source).state.Energetico = false
                TriggerClientEvent('notify', source, 'Inventário', 'O efeito do <b>energético</b> passou e o coração voltou a bater normalmente.')
            end)
        end
    },
    ['combo-camarao'] = { 
        name = 'Camarão da Laurinha', 
        combo = { 
            { index = 'camarao', qtd = 1 },
            { index = 'suco-morango', qtd = 1 }
        },  
        usable = true, 
        type = 'common', 
        weight = 2, 
        interaction = function()
            comboFood('combo-camarao')
        end
    },
    ['combo-milho'] = { 
        name = 'Larissa Manuela', 
        combo = { 
            { index = 'milho', qtd = 1 },
            { index = 'suco-abacaxi', qtd = 1 }
        },  
        usable = true, 
        type = 'common', 
        weight = 2, 
        interaction = function()
            comboFood('combo-milho')
        end
    },
    ['combo-chocolate'] = { 
        name = 'Tudo isso, aceito o desafio', 
        combo = { 
            { index = 'chocolate', qtd = 1 },
            { index = 'suco-kiwi', qtd = 1 }
        },  
        usable = true, 
        type = 'common', 
        weight = 2, 
        interaction = function()
            comboFood('combo-chocolate')
        end
    },
    ['combo-caviar'] = { 
        name = 'Pra aralho', 
        combo = { 
            { index = 'caviar', qtd = 1 },
            { index = 'suco-caju', qtd = 1 }
        },  
        usable = true, 
        type = 'common', 
        weight = 2, 
        interaction = function()
            comboFood('combo-caviar')
        end
    },
    ['cafe'] = { name = 'Café', type = 'common', weight = 1, usable = true, interaction = function(source, user_id)
        cInventory.closeInventory(source)

        zero.tryGetInventoryItem(user_id, 'cafe', 1)
        Player(source).state.BlockTasks = true
        
        zeroClient.CarregarObjeto(source, 'mp_player_intdrink', 'loop_bottle', 'prop_energy_drink', 49, 60309)
        TriggerClientEvent('progressBar', source, 'Bebendo café...', 5000)
        Citizen.SetTimeout(5000, function()
            Player(source).state.Energetico = true
            Player(source).state.BlockTasks = false
            zeroClient.DeletarObjeto(source)
            TriggerClientEvent('notify', source, 'Inventário', 'O <b>café</b> foi utilizado com sucesso!')
        end)

        Citizen.SetTimeout(60000, function()
            Player(source).state.Energetico = false
            TriggerClientEvent('notify', source, 'Inventário', 'O efeito do <b>café</b> passou e o coração voltou a bater normalmente.')
        end)
    end},
----------------------------------------------------------------------------
-- PETS
----------------------------------------------------------------------------
    ['pet-jaguatirica'] = { 
        name = 'Jaguatirica', 
        type = 'common', 
        weight = 0.0, 
        usable = true,  
        interaction = function(source, user_id)
            newPet(source, user_id, 'pet-jaguatirica', 'jaguatirica')
        end
    },
    ['pet-pantera'] = { 
        name = 'Pantera', 
        type = 'common', 
        weight = 0.0, 
        usable = true,  
        interaction = function(source, user_id)
            newPet(source, user_id, 'pet-pantera', 'pantera')
        end
    },
    ['pet-husky'] = { 
        name = 'Husky', 
        type = 'common', 
        weight = 0.0, 
        usable = true,  
        interaction = function(source, user_id)
            newPet(source, user_id, 'pet-husky', 'husky')
        end
    },
    ['pet-poodle'] = { 
        name = 'Poodle', 
        type = 'common', 
        weight = 0.0, 
        usable = true,  
        interaction = function(source, user_id)
            newPet(source, user_id, 'pet-poodle', 'poodle')
        end
    },
    ['pet-cat'] = { 
        name = 'Gato', 
        type = 'common', 
        weight = 0.0, 
        usable = true,  
        interaction = function(source, user_id)
            newPet(source, user_id, 'pet-cat', 'cat')
        end
    },
    ['pet-shepherd'] = { 
        name = 'Shepherd', 
        type = 'common', 
        weight = 0.0, 
        usable = true,  
        interaction = function(source, user_id)
            newPet(source, user_id, 'pet-shepherd', 'shepherd')
        end
    },
    ['pet-rottweiler'] = { 
        name = 'Rottweiler', 
        type = 'common', 
        weight = 0.0, 
        usable = true,  
        interaction = function(source, user_id)
            newPet(source, user_id, 'pet-rottweiler', 'rottweiler')
        end
    },
    ['pet-retriever'] = { 
        name = 'Retriever', 
        type = 'common', 
        weight = 0.0, 
        usable = true,  
        interaction = function(source, user_id)
            newPet(source, user_id, 'pet-retriever', 'retriever')
        end
    },
    ['racao'] = { 
        name = 'Ração', 
        type = 'common', 
        weight = 1, 
        usable = true,  
        interaction = function(source, user_id)
            TriggerClientEvent('feedPet', source)
        end
    },
    ['agua-animal'] = { 
        name = 'Água', 
        type = 'common', 
        weight = 1, 
        usable = true,  
        interaction = function(source, user_id)
            TriggerClientEvent('waterToPet', source)
        end
    },
    ['petkit'] = { 
        name = 'Kit Veterinário', 
        type = 'common', 
        weight = 1, 
    },
----------------------------------------------------------------------------
-- LEGAL
----------------------------------------------------------------------------
    ['radio'] = { name = 'Rádio', type = 'common', weight = 0.5 },
    ['gps'] = { name = 'GPS', type = 'common', weight = 2.5, usable = true, 
        interaction = function(source, user_id)
            cInventory.closeInventory(source)

            zero.tryGetInventoryItem(user_id, 'gps', 1)

            Player(source).state.GPS = true

            TriggerClientEvent('zero_system:gps', source)
            TriggerClientEvent('notify', source, 'Inventário', 'O <b>GPS</b> foi utilizado com sucesso.')
        end
    },
    ['mochila-pequena'] = { 
        name = 'Mochila Pequena', 
        type = 'common', 
        weight = 2, 
        usable = true, 
        interaction = function(source, user_id)
            useBag(source, user_id, 'mochila-pequena', 60)
        end
    },
    ['mochila-grande'] = { 
        name = 'Mochila Grande', 
        type = 'common', 
        weight = 2, 
        usable = true, 
        interaction = function(source, user_id)
            useBag(source, user_id, 'mochila-grande', 125)
        end
    },
    ['kit-reparo'] = { 
        name = 'Kit Reparo', 
        type = 'common', 
        weight = 2, 
        usable = true, 
        interaction = function(source, user_id)
            if (GetEntityHealth(GetPlayerPed(source)) <= 100) then return; end;
            if (zeroClient.isInVehicle(source)) then return; end;
            
            cInventory.closeInventory(source)

            local vehicle, vehnet = zeroClient.vehList(source,3.5)
            if (vehnet) then

                if (cInventory.getVehicleDamage(source) <= 0) then TriggerClientEvent('notify', source, 'Kit de Reparo', 'Este <b>veículo</b> infelizmente não tem conserto!') return; end;
                local time = 30000
                if (zero.hasPermission(user_id, 'zeromecanica.permissao')) then
                    time = 15000
                end

                Player(source).state.BlockTasks = true
                FreezeEntityPosition(GetPlayerPed(source), true)
                FreezeEntityPosition(vehicle, true)

                TriggerClientEvent('zero_animations:setAnim', source, 'mecanico2')                    
                TriggerClientEvent('progressBar', source, 'Reparando...', time)
                Citizen.SetTimeout(time, function()
                    Player(source).state.BlockTasks = false
                    FreezeEntityPosition(GetPlayerPed(source), false)
                    FreezeEntityPosition(vehicle, false)
                    ClearPedTasks(GetPlayerPed(source))
                    TriggerClientEvent('syncreparar', -1, vehnet)
                    zero.tryGetInventoryItem(user_id, 'kit-reparo', 1)
                end)
            end
        end
    },
    ['par-alianca'] = { name = 'Par de Alianças', type = 'common', weight = 0.0 },
    ['alianca-casamento'] = { name = 'Aliança de Casamento', type = 'common', weight = 0.0 },
    ['celular'] = { name = 'Celular', type = 'common', weight = 1 },
    ['key-apartament'] = { name = 'Chave Ap.', type = 'common', weight = 1 },
    ['algema'] = { name = 'Algema', type = 'common', weight = 1 },
    ['chave-algema'] = { name = 'Chave da Algema', type = 'common', weight = 0.5 },
    ['nitro'] = { name = 'Nitro', type = 'common', weight = 3.0, usable = true,
        interaction = function(source, user_id)
            cInventory.closeInventory(source)
            exports['zero_tunings']:startInstallNitro(source)
        end
    },
    ['spray'] = { name = 'Lata de Spray', type = 'common', weight = 1.5, usable = true, 
        interaction = function(source, user_id)
            local inside, homeName = exports['zero_homes']:insideHome(source)
            if (inside) then TriggerClientEvent('notify', source, 'Spray', 'Você não pode utilizar spray de dentro da sua <b>residência</b>.') return; end;
            
            cInventory.closeInventory(source)
            exports['zero_core']:startSpray(source)
        end
    },
    ['removedor-spray'] = { name = 'Kit de remoção de spray', type = 'common', weight = 1, usable = true, 
        interaction = function(source, user_id)
            local inside, homeName = exports['zero_homes']:insideHome(source)
            if (inside) then TriggerClientEvent('notify', source, 'Spray', 'Você não pode utilizar spray de dentro da sua <b>residência</b>.') return; end;

            cInventory.closeInventory(source)
            exports['zero_core']:removeSpray(source)
        end
    },
----------------------------------------------------------------------------
-- POLICIA
----------------------------------------------------------------------------
    ['mandado-241'] = { name = 'Mandado Art.241', type = 'common', weight = 0.1 },
    ['spike'] = { name = 'Spike', type = 'common', weight = 5.0 },
    ['barreira'] = { name = 'Barreira', type = 'common', weight = 5.0 },
    ['cone'] = { name = 'Cone', type = 'common', weight = 2.5 },
----------------------------------------------------------------------------
-- ILEGAL
----------------------------------------------------------------------------
    ['m-droga'] = { name = 'M. Droga', type = 'common', weight = 1 },
    ['m-municoes'] = { name = 'M. Munições', type = 'common', weight = 1 },
    ['c-mec'] = { name = 'M. Mecânica', type = 'common', weight = 1 },
    ['p-armas'] = { name = 'P. Armas', type = 'common', weight = 1 },
    ['colete-ilegal'] = { 
        name = 'Colete Ilegal', 
        type = 'common', 
        weight = 2.5, 
        usable = true,
        interaction = function(source, user_id)
            useColete(source, user_id, 'colete-ilegal')
        end 
    },
    ['pendrive'] = { name = 'Pen Drive', type = 'common', weight = 0.5 },
    ['c4'] = { name = 'C4', type = 'common', weight = 1 },
    ['keycard'] = { name = 'Keycard', type = 'common', weight = 0.5 },
    ['maconha'] = { name = 'Maconha', type = 'common', weight = 1 },
    ['metanfetamina'] = { name = 'Metanfetamina', type = 'common', weight = 1 },
    ['cocaina'] = { name = 'Cocaína', type = 'common', weight = 1 },
    ['dinheirosujo'] = { name = 'Dinheiro Sujo', type = 'common', weight = 0 },
    ['nota-fiscal'] = { name = 'Nota fiscal', type = 'common', weight = 1 },
    ['lockpick'] = { 
        name = 'Lockpick', 
        type = 'common', 
        weight = 1.5, 
        usable = true, 
        interaction = function(source, user_id)
            local identity = zero.getUserIdentity(user_id)
            
            cInventory.closeInventory(source)
            
            local Police = zero.getUsersByPermission('policia.permissao')
            if (#Police < 2) then
                TriggerClientEvent('notify', source, 'Prefeitura', 'O número de <b>políciais</b> no momento é insuficiente para efetuar o roubo.')
                return
            end

            if (exports['zero_system']:inSafe(source)) then
                TriggerClientEvent('notify', source, 'Zona Segura', 'Você não pode utilizar lockpick estando em uma <b>Zona Segura</b>.')
                return
            end
            
            local vehicle, vnetid, placa, vname, lock, banned, trunk, model, street = zeroClient.vehList(source, 2.5)
            if (vehicle and placa) then
                local vehState = exports['zero_garage']:getVehicleData(vnetid)
                if (vehState and vehState.plate) then
                    if (lock == 1) then
                        TriggerClientEvent('notify', source, 'Drumond', 'O <b>veículo</b> já está aberto.')
                        return
                    end
                    
                    if (exports['zero_garage']:carDoor(source, 1.5, 'door_dside_f') or exports['zero_garage']:carDoor(source, 1.5, 'door_dside_r') or exports['zero_garage']:carDoor(source, 1.5, 'door_pside_f') or exports['zero_garage']:carDoor(source, 1.5, 'door_pside_r')) then
                        local isPolice = zero.hasPermission(user_id, 'policia.permissao')
                        
                        local allow;
                        if (isPolice) then
                            allow = true
                        else
                            allow = zero.tryGetInventoryItem(user_id, 'lockpick', 1)
                        end
                        
                        if (allow) then
                            local Ped = GetPlayerPed(source)
                            local PedCoords = GetEntityCoords(Ped)
                            local text = ''
                            
                            LocalPlayer.state.BlockTasks = true

                            zeroClient._playAnim(source, false, {
                                { 'amb@prop_human_parking_meter@female@idle_a', 'idle_a_female' }
                            }, true)
                            
                            if (exports['zero_system']:Task(source, 3, 8000)) then
                                text = 'SUCCESS'
                                ClearPedTasks(Ped)
                                exports['zero_garage']:vehicleLock(vnetid, lock)
                                TriggerClientEvent('zero_inventory:LockpickAnim', source, vehicle)
                                TriggerClientEvent('zero_sound:source', -1, 'lock', 0.1)
                            else
                                text = 'FAIL'
                                ClearPedTasks(Ped)
                                exports['zero_garage']:vehicleAlarm(source)
                                TriggerClientEvent('notify', source, 'Drumond', 'Você falhou na <b>task</b>.')
                            end

                            exports['discord-screenshot']:requestCustomClientScreenshotUploadToDiscord(source, 'https://discord.com/api/webhooks/1136116707883237526/iRQQrUdANFOk2HFDV_IqWA1LImcD4dfWIZyeejwG7I6fkisMXHz8MjteR4fiqJ4f5Pgz', 
                            {
                                    encoding = 'jpg',
                                    quality = 0.80
                                },
                                {
                                    username = identity.firstname,
                                    avatar_url = 'https://cdn.discordapp.com/attachments/1098816084917891092/1136128680440102962/logo.png',
                                    content = '```prolog\n[ZERO INVENTORY]\n[ACTION]: (LOCKPICK)\n[USER]: '..user_id..'\n[RESULT]: '..text..'\n[STREET]: '..street..'\n[CAR OWNER]: '..vehState.user_id..'\n[CAR]: '..vehState.model..'\n[PLATE]: '..vehState.plate..'\n[COORD]: '..tostring(GetEntityCoords(Ped))..'\n'..os.date('[DATA]: %d/%m/%Y [HORA]: %H:%M:%S')..'```',
                                }
                            )
                            
                            LocalPlayer.state.BlockTasks = false
                        end
                    else
                        TriggerClientEvent('notify', source, 'Drumond', 'Você não está próxima da porta do <b>veículo</b>.')
                    end
                end
            end
        end
    },
    ['capuz'] = { name = 'Capuz', type = 'common', weight = 1 },
    ['modificador-armas'] = { name = 'Modificador de Armas', type = 'common', weight = 1.5 },
    ----------------------------------------------------------------------------
    -- Armas legais
    ----------------------------------------------------------------------------
    ['weapon_ceramicpistol'] = { name = 'Ceramic Pistol',type = 'weapon',weight = 1, model = nil },
    ['m_weapon_ceramicpistol'] = { name = 'M. Ceramic Pistol', type = 'wammo', weight = 0.7, model = nil },
    ['weapon_pistol_mk2'] = { name = 'Five-SeveN',type = 'weapon',weight = 1, model = nil },
    ['m_weapon_pistol_mk2'] = { name = 'M. Five-SeveN', type = 'wammo', weight = 0.7, model = nil },
    ['weapon_combatpistol'] = { name = 'Glock', type = 'weapon', weight = 1, model = nil },
    ['m_weapon_combatpistol'] = { name = 'M. Glock', type = 'wammo', weight = 0.7, model = nil },
    ['weapon_combatpistol'] = { name = 'Glock', type = 'weapon', weight = 1, model = nil },
    ['m_weapon_combatpistol'] = { name = 'M. Glock', type = 'wammo', weight = 0.7, model = nil },
    ['weapon_smg_mk2'] = { name = 'MP9', type = 'weapon', weight = 1, model = nil },
    ['m_weapon_smg_mk2'] = { name = 'M. MP9', type = 'wammo', weight = 0.7, model = nil },
    ['weapon_combatpdw'] = { name = 'MPX', type = 'weapon', weight = 1, model = nil },
    ['m_weapon_combatpdw'] = { name = 'M. MPX', type = 'wammo', weight = 0.7, model = nil },
    ['weapon_assaultsmg'] = { name = 'M-TAR', type = 'weapon', weight = 1, model = nil },
    ['m_weapon_assaultsmg'] = { name = 'M. M-TAR', type = 'wammo', weight = 0.7, model = nil },
    ['weapon_pumpshotgun_mk2'] = { name = 'Remington', type = 'weapon', weight = 1, model = nil },
    ['m_weapon_pumpshotgun_mk2'] = { name = 'M. Remington', type = 'wammo', weight = 0.7, model = nil },
    ['weapon_combatshotgun'] = { name = 'SPAS-12', type = 'weapon', weight = 1, model = nil },
    ['m_weapon_combatshotgun'] = { name = 'M. SPAS-12', type = 'wammo', weight = 0.7, model = nil },
    ['weapon_carbinerifle_mk2'] = { name = 'R5 RGP', type = 'weapon', weight = 1, model = nil },
    ['m_weapon_carbinerifle_mk2'] = { name = 'M. R5 RGP', type = 'wammo', weight = 0.7, model = nil },
    ['weapon_militaryrifle'] = { name = 'AUG', type = 'weapon', weight = 1, model = nil,},
    ['m_weapon_militaryrifle'] = { name = 'M. AUG', type = 'wammo', weight = 0.7, model = nil },
    ['weapon_tacticalrifle'] = { name = 'M16', type = 'weapon', weight = 1, model = nil },
    ['m_weapon_tacticalrifle'] = { name = 'M. M16', type = 'wammo', weight = 0.7, model = nil },
    ['weapon_sniperrifle'] = { name = 'AWM', type = 'weapon', weight = 1, model = nil },
    ['m_weapon_sniperrifle'] = { name = 'M. AWM', type = 'wammo', weight = 0.7, model = nil },
    ----------------------------------------------------------------------------
    -- Armas ilegais
    ----------------------------------------------------------------------------
    ['weapon_snspistol_mk2'] = { name = 'HK 45', type = 'weapon', weight = 1, model = nil },
    ['m_weapon_snspistol_mk2'] = { name = 'M. HK 45', type = 'wammo', weight = 0.7, model = nil },
    ['weapon_revolver_mk2'] = { name = 'R8', type = 'weapon', weight = 1, model = nil },
    ['m_weapon_revolver_mk2'] = { name = 'M. R8', type = 'wammo', weight = 0.7, model = nil },
    ['weapon_tecpistol'] = { name = 'Uzi', type = 'weapon', weight = 1, model = nil },
    ['m_weapon_tecpistol'] = { name = 'M. Uzi', type = 'wammo', weight = 0.7, model = nil },
    ['weapon_tecpistol'] = { name = 'Uzi', type = 'weapon', weight = 1, model = nil },
    ['m_weapon_tecpistol'] = { name = 'M. Uzi', type = 'wammo', weight = 0.7, model = nil },
    ['weapon_machinepistol'] = { name = 'Tec-9', type = 'weapon', weight = 1, model = nil },
    ['m_weapon_machinepistol'] = { name = 'M. Tec-9', type = 'wammo', weight = 0.7, model = nil },
    ['weapon_minismg'] = { name = 'S VZ 61', type = 'weapon', weight = 1, model = nil },
    ['m_weapon_minismg'] = { name = 'M. S VZ 61', type = 'wammo', weight = 0.7, model = nil },
    ['weapon_compactrifle'] = { name = 'K. Compact', type = 'weapon', weight = 1, model = nil },
    ['m_weapon_compactrifle'] = { name = 'M. K. Compact', type = 'wammo', weight = 0.7, model = nil },
    ['weapon_heavyrifle'] = { name = 'FN Scar', type = 'weapon', weight = 1, model = nil },
    ['m_weapon_heavyrifle'] = { name = 'M. FN Scar', type = 'wammo', weight = 0.7, model = nil },
    ['weapon_bullpuprifle_mk2'] = { name = 'Type-97', type = 'weapon', weight = 1, model = nil },
    ['m_weapon_bullpuprifle_mk2'] = { name = 'M. Type-97', type = 'wammo', weight = 0.7, model = nil },
    ----------------------------------------------------------------------------
    -- Armas Staff
    ----------------------------------------------------------------------------
    ['weapon_doubleaction'] = { name = 'Dourada', type = 'weapon', weight = 1, model = nil},
    ['m_weapon_doubleaction'] = { name = 'M. Dourada', type = 'wammo', weight = 0.7, model = nil },
    ['weapon_gusenberg'] = { name = 'Thompson', type = 'weapon', weight = 1, model = nil},
    ['m_weapon_gusenberg'] = { name = 'M. Thompson', type = 'wammo', weight = 0.7, model = nil },
    ----------------------------------------------------------------------------
    -- Utilitarios
    ----------------------------------------------------------------------------
    ['colete-militar'] = { 
        name = 'Colete Militar', 
        type = 'common', 
        weight = 2.5, 
        usable = true, 
        interaction = function(source, user_id)
            useColete(source, user_id, 'colete-militar')
        end
    },
    ['paraquedas'] = { name = 'gadget_parachute', type = 'weapon', weight = 5 },
    ['weapon_nightstick'] = { name = 'Cassetete', type = 'weapon', weight = 1 },
    ['weapon_stungun'] = { name = 'weapon_stungun', type = 'weapon', weight = 1 },
}

config.blacklist = {
    ['alianca-casamento'] = true
}


function healing(item)
    local _source = source
    local user_id = zero.getUserId(source)
    local drug = config.items[item]
    if (user_id) and drug then
        local currentHealth = zeroClient.getHealth(_source)
        if (currentHealth > 250) or item == 'antibiotico' then
            if zero.tryGetInventoryItem(user_id, item, 1) then
                TriggerClientEvent('zero_inventory:closeInventory', _source)
                TriggerClientEvent('progress', _source, 6000, 'Tomando '..zero.itemNameList(item))
                zeroClient._CarregarObjeto(_source, 'amb@world_human_drinking@beer@male@idle_a', 'idle_a', 'ng_proc_drug01a002', 48, 28422)
                Citizen.SetTimeout(6000, function()
                    zeroClient._DeletarObjeto(_source)
                    zeroClient._stopAnim(_source, false)
                end)   

                local healTimes = 0
                local toxicHealTimes = 0
                
                local drugsConfig = drug.drug
                while (healTimes < drugsConfig.heal_times) do
                    currentHealth = zeroClient.getHealth(_source)
                    if (currentHealth == 400) then
                        healTimes = drugsConfig.heal_times
                    else
                        zeroClient.setHealth(_source, currentHealth + drugsConfig.heal)
                    end
                    healTimes = healTimes + 1
                    Citizen.Wait(3000)
                end

                if (drugsConfig.heal_toxic) then
                    while toxicHealTimes < drugsConfig.heal_toxic_times do
                        zero._varyToxic(user_id, drugsConfig.heal_toxic)
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

local isServer = IsDuplicityVersion()
if (isServer) then
    consumableItem = function(source, user_id, index)
        local cItem = config.items[index]
        if (zero.tryGetInventoryItem(user_id, index, 1)) then
            Player(source).state.BlockTasks = true

            if (cItem.prop) then
                zeroClient.CarregarObjeto(source, cItem.anim[1], cItem.anim[2], cItem.prop, cItem.anim[3], cItem.anim[4])
            else
                zeroClient._playAnim(source, true, {
                    cItem.anim
                }, true)
            end

            local customTimeout = (cItem.timeout or 5000)
            TriggerClientEvent('progressBar', source, 'Consumindo '..zero.itemNameList(index)..'...', customTimeout)
            SetTimeout(customTimeout, function()
                local consumable = cItem.consumable
                
                if consumable.hunger and consumable.hunger ~= 0 then
                    zero.varyHunger(user_id, consumable.hunger)
                end

                if consumable.thirst and consumable.thirst ~= 0 then
                    zero.varyThirst(user_id, consumable.thirst)
                end

                if cItem.afterItem then 
                    zero.giveInventoryItem(user_id, cItem.afterItem, 1)
                end

                TriggerClientEvent('notify', source, 'Inventário', 'Você consumiu '..zero.itemNameList(index)..'.', 5000)
                Player(source).state.BlockTasks = false

                ClearPedTasks(GetPlayerPed(source))
                zeroClient.DeletarObjeto(source)
            end)
        end
    end
end
