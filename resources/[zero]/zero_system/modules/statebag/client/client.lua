LocalPlayer.state:set('BlockTasks', false, true)
LocalPlayer.state:set('inVehicle', false, true)
LocalPlayer.state:set('patrolHospital', false, true)
LocalPlayer.state:set('holdingHostage', false, true)
LocalPlayer.state:set('victimHostage', false, true)
LocalPlayer.state:set('FPS', false, true)
LocalPlayer.state:set('Handcuff', false, true)
LocalPlayer.state:set('Capuz', false, true)

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
                Citizen.Wait(5)
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
                Citizen.Wait(5)
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
                    idle = 5
                    disableActions(ped)
                end
                Citizen.Wait(idle)
            end
        end)
    end
end)