local vSERVER = Tunnel.getInterface('State')

LocalPlayer.state:set('BlockTasks', false, true)
LocalPlayer.state:set('inVehicle', false, true)
LocalPlayer.state:set('patrolHospital', false, true)
LocalPlayer.state:set('holdingHostage', false, true)
LocalPlayer.state:set('victimHostage', false, true)
LocalPlayer.state:set('FPS', false, true)
LocalPlayer.state:set('Handcuff', false, true)
LocalPlayer.state:set('Capuz', false, true)
LocalPlayer.state:set('SafeZone', false, true)
LocalPlayer.state:set('Energetico', false, true)
LocalPlayer.state:set('Cam', false, true)
LocalPlayer.state:set('Control', false, true)
LocalPlayer.state:set('Armed', false, true)
LocalPlayer.state:set('Prison', false, true)

local disableActions = function(ply)
    BlockWeaponWheelThisFrame()
    DisableControlAction(0, 29, true)
    DisableControlAction(0, 47, true)
    DisableControlAction(0, 56, true)
    DisableControlAction(0, 57, true)
    DisableControlAction(0, 73, true)
    DisableControlAction(0, 137, true)
    DisableControlAction(0, 166, true)
    DisableControlAction(0, 167, true)
    DisableControlAction(0, 169, true)
    DisableControlAction(0, 170, true)
    DisableControlAction(0, 182, true)
    DisableControlAction(0, 187, true)
    DisableControlAction(0, 188, true)
    DisableControlAction(0, 189, true)
    DisableControlAction(0, 190, true)
    DisableControlAction(0, 243, true)
    DisableControlAction(0, 245, true)
    DisableControlAction(0, 257, true)
    DisableControlAction(0, 288, true)
    DisableControlAction(0, 289, true)
    DisableControlAction(0, 311, true)
    DisableControlAction(0, 344, true)		
    DisablePlayerFiring(ply, true)
    DisableControlAction(0,24,true) -- disable attack
    DisableControlAction(0,25,true) -- disable aim
    DisableControlAction(0,47,true) -- disable weapon
    DisableControlAction(0,58,true) -- disable weapon
    DisableControlAction(0, 37, true) -- Tecla Tab
    DisableControlAction(0, 21, true)
    DisableControlAction(0, 22, true)
end

AddStateBagChangeHandler('BlockTasks', nil, function(bagName, key, value) 
    local entity = GetPlayerFromStateBagName(bagName)
    if (entity == 0) then return; end;

    if (value) then
        Citizen.CreateThread(function()
            while (LocalPlayer.state.BlockTasks) do
                BlockWeaponWheelThisFrame()
                DisableControlAction(0, 29, true)
                DisableControlAction(0, 47, true)
                DisableControlAction(0, 56, true)
                DisableControlAction(0, 57, true)
                DisableControlAction(0, 73, true)
                DisableControlAction(0, 137, true)
                DisableControlAction(0, 166, true)
                DisableControlAction(0, 167, true)
                DisableControlAction(0, 169, true)
                DisableControlAction(0, 170, true)
                DisableControlAction(0, 182, true)
                DisableControlAction(0, 187, true)
                DisableControlAction(0, 188, true)
                DisableControlAction(0, 189, true)
                DisableControlAction(0, 190, true)
                DisableControlAction(0, 243, true)
                DisableControlAction(0, 245, true)
                DisableControlAction(0, 257, true)
                DisableControlAction(0, 288, true)
                DisableControlAction(0, 289, true)
                DisableControlAction(0, 311, true)
                DisableControlAction(0, 344, true)		
                DisablePlayerFiring(PlayerPedId(), true)
                Citizen.Wait(1)
            end
        end)
    end
end)

AddStateBagChangeHandler('Handcuff', nil, function(bagName, key, value) 
    local entity = GetPlayerFromStateBagName(bagName)
    if (entity == 0) then return; end;

    if (value) then
        local ped = PlayerPedId()
        Citizen.CreateThread(function()
            SetCurrentPedWeapon(ped, GetHashKey('WEAPON_UNARMED'), true)
            while (LocalPlayer.state.Handcuff) do
                if (GetEntityHealth(ped) > 100) then
                    if (not IsEntityPlayingAnim(ped, "mp_arresting", "idle",3 )) then
                        if (LoadAnim('mp_arresting')) then
                            TaskPlayAnim(ped, 'mp_arresting', 'idle', 8.0, 8.0, -1, 49, 0, 0, 0, 0)
                        end          
                    end
                    disableActions(ped)
                end
                Citizen.Wait(1)
            end
            ClearPedTasks(ped)
        end)

        Citizen.CreateThread(function()
            local lastRagdoll = IsPedRunningRagdollTask(ped)
            while (LocalPlayer.state.Handcuff) do
                if (not IsPedRunningRagdollTask(ped)) then 
                    if (lastRagdoll ~= IsPedRunningRagdollTask(ped)) then
                        ClearPedTasks(ped)
                    end
                end
                lastRagdoll = IsPedRunningRagdollTask(ped)
                Citizen.Wait(1000)
            end
        end)
    end
end)

AddStateBagChangeHandler('Capuz', nil, function(bagName, key, value) 
    local entity = GetPlayerFromStateBagName(bagName)
    if (entity == 0) then return; end;

    if (value) then
        local ped = PlayerPedId()
        Citizen.CreateThread(function()
            while (LocalPlayer.state.Capuz) do
                local idle = 1000
                if (GetEntityHealth(ped) > 100 and not LocalPlayer.state.Handcuff) then
                    idle = 4
                    disableActions(ped)
                end
                Citizen.Wait(idle)
            end
        end)
    end
end)

AddStateBagChangeHandler('Energetico', nil, function(bagName, key, value) 
    local entity = GetPlayerFromStateBagName(bagName)
    if (entity == 0) then return; end;

    if (value) then
        local ped = PlayerPedId()
        Citizen.CreateThread(function()
            SetRunSprintMultiplierForPlayer(PlayerId(), 1.15)
            while (LocalPlayer.state.Energetico) do
                RestorePlayerStamina(PlayerId(), 1.0)
                Citizen.Wait(1)
            end
            SetRunSprintMultiplierForPlayer(PlayerId(), 1.0)
        end)
    end
end)

AddStateBagChangeHandler('Armed', nil, function(bagName, key, value) 
    local entity = GetPlayerFromStateBagName(bagName)
    if (entity == 0) then return; end;

    if (value) then
        Citizen.CreateThread(function()
            while (LocalPlayer.state.Armed) do
				SetPedSuffersCriticalHits(PlayerPedId(-1), true)
				DisableControlAction(0,140,true)
				DisableControlAction(0,141,true)
				DisableControlAction(0,142,true)
                Citizen.Wait(1)
            end
        end)
    end
end)

local prison = PolyZone:Create(
    {
        vector2(1843.56, 2677.65),
        vector2(1824.62, 2620.83),
        vector2(1821.97, 2570.45),
        vector2(1822.35, 2475.76),
        vector2(1826.52, 2463.64),
        vector2(1765.53, 2403.41),
        vector2(1657.95, 2379.17),
        vector2(1534.47, 2456.44),
        vector2(1526.52, 2576.52),
        vector2(1561.36, 2675.00),
        vector2(1640.91, 2754.55),
        vector2(1769.32, 2757.95),
        vector2(1845.83, 2693.56)
    }, 
    {
        name = 'Prisão',
        debugPoly = true,
        minZ = 35.0,
        maxZ = 100.0
    }
)

local lose_prison = PolyZone:Create(
    {
        vector2(1663.9384765625, 2541.4680175781),
        vector2(1648.589, 2554.958),
        vector2(1640.426, 2545.266),
        vector2(1656.3297119141, 2532.0791015625),
        vector2(1642.787, 2542.272),
        vector2(1629.653, 2526.725),
        vector2(1642.193, 2516.07),
        vector2(1656.053, 2532.013) 
    }, 
    {
        debugPoly = true,
        minZ = 40.0,
        maxZ = 70.0
    }
)

AddStateBagChangeHandler('Prison', nil, function(bagName, key, value) 
    local entity = GetPlayerFromStateBagName(bagName)
    if (entity == 0) then return; end;

    if (value) then
        Citizen.CreateThread(function()
            while (LocalPlayer.state.Prison) do
                local inside = prison:isPointInside(GetEntityCoords(PlayerPedId()))
                if (not inside) then
                    TriggerEvent('notify', 'Prisão', 'O <b> agente penitenciário</b> encontrou você tentando escapar.')
                    zero.teleport(1753.358, 2470.998, 47.39343)
                end
                Citizen.Wait(1500)
            end
        end)

        local workout = false
        Citizen.CreateThread(function()
            while (LocalPlayer.state.Prison) do
                local idle = 1500

                local ped = PlayerPedId()
                local pCoord = GetEntityCoords(ped)
                
                local inside = lose_prison:isPointInside(pCoord)
                if (inside) then
                    idle = 1
                    if (IsControlJustPressed(0, 38) and not workout) then
                        workout = true
                        LocalPlayer.state.BlockTasks = true
                        FreezeEntityPosition(ped, true)
                        TriggerEvent('zero_animations:setAnim', 'malhar')
                        TriggerEvent('progressBar', 'Malhando...', 30000)

                        Citizen.Wait(30000)
 
                        LocalPlayer.state.BlockTasks = false
                        FreezeEntityPosition(ped, false)
                        ClearPedTasks(ped)
                        zero.DeletarObjeto()
                        vSERVER.diminuirPena()
                        workout = false
                    end
                end
                Citizen.Wait(idle)
            end
        end)
    end
end)