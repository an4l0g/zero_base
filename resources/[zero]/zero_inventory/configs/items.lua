cInventory = Tunnel.getInterface('zero_inventory')

bandagemCooldown = {}

config.itemTypes = { 'common', 'weapon', 'wammo' }
this = exports[GetCurrentResourceName()]

config.items = {
----------------------------------------------------------------------------
-- LEGAL
----------------------------------------------------------------------------
    ['par-alianca'] = { name = 'Par de Alianças', type = 'common', weight = 0.0 },
    ['alianca-casamento'] = { name = 'Aliança de Casamento', type = 'common', weight = 0.0 },
    ['celular'] = { name = 'Celular', type = 'common', weight = 0.5 },
    ['algema'] = { name = 'Algema', type = 'common', weight = 0.5 },
    ['chave-algema'] = { name = 'Chave da Algema', type = 'common', weight = 0.5 },
    ['nitro'] = { name = 'Nitro', type = 'common', weight = 1.0, usable = true,
        interaction = function(source, user_id)
            cInventory.closeInventory(source)
            exports['zero_tunings']:startInstallNitro(source)
        end
    },
    ['spray'] = { name = 'Lata de Spray', type = 'common', weight = 0.5, usable = true, 
        interaction = function(source, user_id)
            local inside, homeName = exports['zero_homes']:insideHome(source)
            if (inside) then TriggerClientEvent('notify', source, 'Spray', 'Você não pode utilizar spray de dentro da sua <b>residência</b>.') return; end;
            
            cInventory.closeInventory(source)
            exports['zero_core']:startSpray(source)
        end
    },
    ['removedor-spray'] = { name = 'Kit de remoção de spray', type = 'common', weight = 0.5, usable = true, 
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
----------------------------------------------------------------------------
-- ILEGAL
----------------------------------------------------------------------------
    ['maconha'] = { name = 'Maconha', type = 'common', weight = 1.5 },
    ['metanfetamina'] = { name = 'Metanfetamina', type = 'common', weight = 1.5 },
    ['cocaina'] = { name = 'Cocaína', type = 'common', weight = 1.5 },
    ['dinheirosujo'] = { name = 'Dinheiro Sujo', type = 'common', weight = 0 },
    ['nota-fiscal'] = { name = 'Nota fiscal', type = 'common', weight = 1 },
    ['lockpick'] = { name = 'Lockpick', type = 'common', weight = 1.0, usable = true, 
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
                                    username = identity.name,
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
    ['capuz'] = { name = 'Capuz', type = 'common', weight = 0.5, usable = true },
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

config.blacklist = {
    ['alianca-casamento'] = true
}

function consumableItem(index)
   local _source = source
   local user_id = zero.getUserId(_source)
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

   if zero.tryGetInventoryItem(user_id, index, 1) then
    TriggerClientEvent('progress', _source, customTimeout, 'Consumindo '..zero.itemNameList(index)..'...')
    if cItem.animation then 
        if cItem.animation.prop then
            zeroClient._CarregarObjeto(_source, cItem.animation.anim[1], cItem.animation.anim[2], cItem.animation.prop, cItem.animation.anim[3], cItem.animation.anim[4])
        end
        zeroClient._playAnim(_source, true, { cItem.animation.anim }, true)
    end
    
    SetTimeout(customTimeout, function()
        zeroClient._DeletarObjeto(_source)
        -- Sede, fome e Toxicidade
        local consumable = cItem.consumable
        
        if consumable.hunger and consumable.hunger ~= 0 then
            zero.varyHunger(user_id, consumable.hunger)
        end
        if consumable.thirst and consumable.thirst ~= 0 then
            zero.varyThirst(user_id, consumable.thirst)
        end
        if consumable.toxic > 0 then
            zero.varyToxic(user_id, consumable.toxic)
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
            zero.giveInventoryItem(user_id, cItem.afterItem, 1)
        end
        
        if consumable.buff then
            zeroClient._playAnim(_source, false, {{'mini@triathlon', 'idle_e'}}, false)
            zero.addUserGroup(user_id, consumable.buff, consumable.buff)
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
            'Você consumiu ' .. zero.itemNameList(index) .. '.',
            5000
        )
    end)
   end
end

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

function setupCumpfire()
	if exports['zBrazuca']:isSafe() then
        return false
    end
    
    local modelhash = GetHashKey('prop_hobo_stove_01')
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
    local user_id = zero.getUserId(_source)
    if zero.tryGetInventoryItem(user_id, pet, 1) then
        local pet_type = splitString(pet,'-')[2]
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
            if zero.tryGetInventoryItem(user_id, 'isca', 1) then
                LocalPlayer.state.BlockTasks = true
                TriggerClientEvent('zero_inventory:disableActions', source, true)
                TriggerClientEvent('emotes', source, 'pescar')
                cInventory.closeInventory(source)
                local taskResult = cTASKBAR.taskLockpick(source)
                if taskResult then
                    local currentFish = ''
                    for k, fish in pairs(fishes) do
                        local random = math.random(0, 100)
                        local chance = fish['chance']
                        if zero.getInventoryItemAmount(user_id, 'pe-coelho') then
                            chance = chance + 5
                        end

                        if random <= chance then
                            currentFish = fish['name']
                            break
                        end
                    end

                    if currentFish == '' then currentFish = 'tilapia' end

                    if (zero.getItemWeight(currentFish)+zero.getInventoryWeight(user_id)) <= zero.getInventoryMaxWeight(user_id) then
                        TriggerClientEvent('Notify', source, 'Inventário', 'Pesca', 'Você pescou um(a) <b>'..currentFish..'</b>!', 5000)
                        zero.giveInventoryItem(user_id, currentFish, 1)
                    else 
                        TriggerClientEvent('Notify', source, 'Inventário', 'Inventário', 'Você não possui espaço na mochila!', 5000)
                    end
                end
                TriggerClientEvent('zero_inventory:enableActions', source, true)
                LocalPlayer.state.BlockTasks = false
                zeroClient._stopAnim(source, false)
                zeroClient._DeletarObjeto(source)
            end
        end
    else
        TriggerClientEvent('Notify', source, 'Inventário', 'Proficiência', 'Você não possui conhecimento em pesca para fazer isso!!', 5000)
    end
end

getItem = function(index)
    return config.items[index]
end
exports('getItem', getItem)