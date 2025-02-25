RegisterCommand('revistar', function(source)
    local user_id = zero.getUserId(source)
    if (user_id) then
        local nPlayer = zeroClient.getNearestPlayer(source, 2.0)
        if (nPlayer) then
            local nUser = zero.getUserId(nPlayer)

            if (Player(nPlayer).state.Revistar) then TriggerClientEvent('notify', source, 'Revistar', 'Este <b>cidadão</b> já esta sendo revistado!') return; end;
            if (GetEntityHealth(GetPlayerPed(source)) <= 100) then return; end;
            if (GetEntityHealth(GetPlayerPed(nPlayer)) <= 100) then TriggerClientEvent('notify', source, 'Revistar', 'Você não pode <b>revistar</b> uma pessoa morta!') return; end;
            if (zeroClient.getNoCarro(nPlayer)) then return; end;
            
            if (zeroClient.isHandcuffed(nPlayer)) then
                Player(source).state.Revistar = true
                Player(nPlayer).state.Revistar = true

                Player(source).state.BlockTasks = true
                Player(nPlayer).state.BlockTasks = true

                zeroClient._playAnim(source, true, {
                    { 'oddjobs@shop_robbery@rob_till', 'loop' }
                }, true)

                TriggerClientEvent('zero:attach', nPlayer, source, 4103, 0.1, 0.6, 0.0, 0.0, 0.0, 0.0, 0.0, false, false, false, 2, true)

                local weapons = zeroClient.replaceWeapons(nPlayer, {}, GlobalState.weaponToken)
                zero.setKeyDataTable(nUser, 'weapons', {})

                for k, v in pairs(weapons) do
                    local weapon = k:lower()
                    zero.giveInventoryItem(nUser, weapon, 1)
                    if (v.ammo > 0) then
                        zero.giveInventoryItem(nUser, 'm_'..weapon, v.ammo)
                    end
                end
                
                cInventory.openInventory(source, 'open', 'bag:'..nUser, true)
            else
                TriggerClientEvent('notify', source, 'Revistar', 'Você não pode <b>revistar</b> uma pessoa desalgemada!')
            end
        end
    end
end)

RegisterCommand('saquear', function(source)
    local user_id = zero.getUserId(source)
    if (user_id) and zero.checkPermissions(user_id, { 'ilegal.permissao' }) then
        local nPlayer = zeroClient.getNearestPlayer(source, 2.0)
        if (nPlayer) then
            local nUser = zero.getUserId(nPlayer)

            if (Player(nPlayer).state.Saquear) then TriggerClientEvent('notify', source, 'Saquear', 'Este <b>cidadão</b> já esta sendo saqueado!') return; end;
            if (GetEntityHealth(GetPlayerPed(source)) <= 100) then return; end;
            if (GetEntityHealth(GetPlayerPed(nPlayer)) >= 100) then TriggerClientEvent('notify', source, 'Saquear', 'Você não pode <b>saquear</b> uma pessoa viva!') return; end;
            if (zeroClient.getNoCarro(nPlayer)) then return; end;
            
            Player(source).state.Saquear = true
            Player(nPlayer).state.Saquear = true

            Player(source).state.BlockTasks = true
            Player(nPlayer).state.BlockTasks = true

            zeroClient._playAnim(source, false, {
                { 'amb@medic@standing@tendtodead@idle_a', 'idle_a' }
            }, true)

            local weapons = zeroClient.replaceWeapons(nPlayer, {}, GlobalState.weaponToken)
            zero.setKeyDataTable(nUser, 'weapons', {})

            for k, v in pairs(weapons) do
                local weapon = k:lower()
                zero.giveInventoryItem(nUser, weapon, 1)
                if (v.ammo > 0) then
                    zero.giveInventoryItem(nUser, 'm_'..weapon, v.ammo)
                end
            end
            
            cInventory.openInventory(source, 'open', 'bag:'..nUser)
        end
    end
end)

RegisterNetEvent('zero_inventory:closeSaquear', function()
    local source = source
    local nPlayer = zeroClient.getNearestPlayer(source, 2.0)
    if (nPlayer) then
        Player(nPlayer).state.Saquear = false
        Player(nPlayer).state.BlockTasks = false
    end
    Player(source).state.Saquear = false
    Player(source).state.BlockTasks = false
    ClearPedTasks(GetPlayerPed(source))
end)

RegisterNetEvent('zero_inventory:closeRevistar', function()
    local source = source
    local nPlayer = zeroClient.getNearestPlayer(source, 2.0)
    if (nPlayer) then
        Player(nPlayer).state.Revistar = false
        Player(nPlayer).state.BlockTasks = false
        TriggerClientEvent('zero:attach', nPlayer, source)
    end
    Player(source).state.Revistar = false
    Player(source).state.BlockTasks = false
    ClearPedTasks(GetPlayerPed(source))
end)