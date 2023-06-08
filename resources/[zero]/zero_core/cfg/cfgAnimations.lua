configs = {}

configs.animations = {
    ['keyMapping'] = {
        ['cruzarBraco'] = {
            key = 'f1',
            text = 'Animação - Cruzar o Braço',
            action = function()
                local ped = PlayerPedId()
                if (not IsPedInAnyVehicle(ped) and GetEntityHealth(ped) > 101) then
                    if (IsEntityPlayingAnim(ped, 'anim@heists@heist_corona@single_team', 'single_team_loop_boss', 3)) then
                        vRP.DeletarObjeto()
                    else
                        vRP.DeletarObjeto()
                        vRP.playAnim(true, {{ 'anim@heists@heist_corona@single_team', 'single_team_loop_boss' }}, true)
                    end
                end
            end
        },
        ['aguardar'] = {
            key = 'f2',
            text = 'Animação - Aguardar',
            action = function()
                local ped = PlayerPedId()
                local menuCelular = vRP.getMenuCelular()
                if (not IsPedInAnyVehicle(ped) and GetEntityHealth(ped) > 101 and not menuCelular) then
                    if (IsEntityPlayingAnim(ped, 'mini@strip_club@idles@bouncer@base', 'base', 3)) then
                        vRP.DeletarObjeto()
                    else
                        vRP.DeletarObjeto()
                        vRP.playAnim(true, {{ 'mini@strip_club@idles@bouncer@base', 'base' }}, true)
                    end
                end
            end
        },
        ['dedoMeio'] = {
            key = 'f3',
            text = 'Animação - Dedo do meio',
            action = function()
                local ped = PlayerPedId()
                local menuCelular = vRP.getMenuCelular()
                if (not IsPedInAnyVehicle(ped) and GetEntityHealth(ped) > 101 and not menuCelular) then
                    if (IsEntityPlayingAnim(ped, 'anim@mp_player_intselfiethe_bird', 'idle_a', 3)) then
                        vRP.DeletarObjeto()
                    else
                        vRP.DeletarObjeto()
                        vRP.playAnim(true, {{ 'anim@mp_player_intselfiethe_bird', 'idle_a' }}, true)
                    end
                end
            end
        },
        ['render'] = {
            key = 'f5',
            text = 'Animação - Se render',
            action = function()
                local ped = PlayerPedId()
                local menuCelular = vRP.getMenuCelular()
                if (not IsPedInAnyVehicle(ped) and GetEntityHealth(ped) > 101 and not menuCelular) then
                    if IsEntityPlayingAnim(ped, 'random@arrests@busted', 'idle_a', 3) then
                        vRP.DeletarObjeto()
                    else
                        vRP.DeletarObjeto()
                        vRP.CarregarAnim('random@arrests')
                        vRP.CarregarAnim('random@arrests@busted')
                        TaskPlayAnim(ped, 'random@arrests', 'idle_2_hands_up', 8.0, 1.0, -1, 2, 0, 0, 0, 0)
                        Wait(4000)
                        TaskPlayAnim(ped, 'random@arrests', 'kneeling_arrest_idle', 8.0, 1.0, -1, 2, 0, 0, 0, 0)
                        Wait(500)
                        TaskPlayAnim(ped, 'random@arrests@busted', 'enter', 8.0, 1.0, -1, 2, 0, 0, 0, 0)
                        Wait(1000)
                        TaskPlayAnim(ped, 'random@arrests@busted', 'idle_a', 8.0, 1.0, -1, 9, 0, 0, 0, 0)
                        Wait(100)
                    end 
                end
            end
        },
        ['cancelar'] = {
            key = 'f6',
            text = 'Animação - Cancelar',
            action = function()
                local ped = PlayerPedId()
                local menuCelular = vRP.getMenuCelular()
                TriggerEvent('vRP:CancelAnimations')
                TriggerEvent('zero_animations:cancelSharedAnimation')
                if (GetEntityHealth(ped) > 101 and not menuCelular) then
                    vRP.DeletarObjeto()
                    ClearPedTasks(ped)
                end
            end
        },
        ['maoCabeca'] = {
            key = 'f10',
            text = 'Animação - Mãos na cabeça',
            action = function()
                local ped = PlayerPedId()
                local menuCelular = vRP.getMenuCelular()
                if (GetEntityHealth(ped) > 101 and not menuCelular) then
                    if IsEntityPlayingAnim(ped, 'random@arrests@busted', 'idle_a', 3) then
                        vRP.DeletarObjeto()
                    else
                        vRP.DeletarObjeto()
                        vRP.playAnim(true, {{'random@arrests@busted', 'idle_a'}}, true)    
                    end            
                end
            end
        },
        ['levantarMaos'] = {
            key = 'x',
            text = 'Animação - Levantar as mãos',
            action = function()
                local ped = PlayerPedId()
                local menuCelular = vRP.getMenuCelular()
                if (GetEntityHealth(ped) > 101 and not menuCelular) then
                    if IsEntityPlayingAnim(ped, 'random@mugging3', 'handsup_standing_base', 3) then
                        vRP.DeletarObjeto()
                    else
                        vRP.DeletarObjeto()
                        vRP.playAnim(true, {{'random@mugging3', 'handsup_standing_base'}}, true)
                    end
                end
            end
        },
        ['delete'] = {
            key = 'delete',
            text = 'Animação - Joia duplo',
            action = function()
                local ped = PlayerPedId()
                local menuCelular = vRP.getMenuCelular()
                if (not IsPedInAnyVehicle(ped) and GetEntityHealth(ped) > 101 and not menuCelular) then
                    vRP.playAnim(true, {{ 'anim@mp_player_intincarthumbs_upbodhi@ps@', 'enter' }}, false)
                end
            end
        },
        ['assobiar'] = {
            key = 'down',
            text = 'Animação - Assobiar',
            action = function()
                local ped = PlayerPedId()
                local menuCelular = vRP.getMenuCelular()
                if (not IsPedInAnyVehicle(ped) and GetEntityHealth(ped) > 101 and not menuCelular) then
                    vRP.playAnim(true, {{ 'rcmnigel1c', 'hailing_whistle_waive_a' }}, false)
                end
            end
        },
        ['saudacao'] = {
            key = 'up',
            text = 'Animação - Saudação',
            action = function()
                local ped = PlayerPedId()
                local menuCelular = vRP.getMenuCelular()
                if (not IsPedInAnyVehicle(ped) and GetEntityHealth(ped) > 101 and not menuCelular) then
                    vRP.playAnim(true, {{ 'anim@mp_player_intcelebrationmale@salute', 'salute' }}, false)
                end
            end
        },
        ['joia'] = {
            key = 'left',
            text = 'Animação - Joia',
            action = function()
                local ped = PlayerPedId()
                local menuCelular = vRP.getMenuCelular()
                if (not IsPedInAnyVehicle(ped) and GetEntityHealth(ped) > 101 and not menuCelular) then
                    vRP.playAnim(true, {{ 'anim@mp_player_intselfiethumbs_up', 'idle_a' }}, false)
                end
            end
        },
        ['facepalm'] = {
            key = 'right',
            text = 'Animação - Facepalm',
            action = function()
                local ped = PlayerPedId()
                local menuCelular = vRP.getMenuCelular()
                if (not IsPedInAnyVehicle(ped) and GetEntityHealth(ped) > 101 and not menuCelular) then
                    vRP.playAnim(true, {{ 'anim@mp_player_intupperface_palm', 'idle_a' }}, false)
                end
            end
        },
        ['apontar'] = {
            key = 'b',
            text = 'Animação - Apontar',
            action = function()
                local ped = PlayerPedId()
                local menuCelular = vRP.getMenuCelular()
                if (GetEntityHealth(ped) > 101 and not menuCelular) then
                    vRP.CarregarAnim('anim@mp_point')
                    if (not LocalPlayer.state.animApontar) then
                        SetPedCurrentWeaponVisible(ped, 0, 1, 1, 1)
                        SetPedConfigFlag(ped, 36, 1)
                        Citizen.InvokeNative(0x2D537BA194896636, ped, 'task_mp_pointing', 0.5, 0, 'anim@mp_point', 24)
                        LocalPlayer.state.animApontar = true
                        apontarThread(true)
                    else
                        Citizen.InvokeNative(0xD01015C7316AE176, ped, 'Stop')
                        if (not IsPedInjured(ped)) then ClearPedSecondaryTask(ped); end;
                        if (not IsPedInAnyVehicle(ped)) then SetPedCurrentWeaponVisible(ped, 1, 1, 1, 1); end;
                        SetPedConfigFlag(ped, 36, 0)
                        ClearPedSecondaryTask(ped)
                        LocalPlayer.state.animApontar = false
                        apontarThread(false)
                    end
                end
            end
        },
        ['motor'] = {
            key = 'z',
            text = 'Ligar veículo',
            action = function()
                local ped = PlayerPedId()
                if (IsPedInAnyVehicle(ped)) then
                    local vehicle = GetVehiclePedIsIn(ped,false)
                    if (GetPedInVehicleSeat(vehicle,-1) == ped) then
                        vRP.DeletarObjeto()
                        local running = Citizen.InvokeNative(0xAE31E7DF9B5B132E,vehicle)
                        SetVehicleEngineOn(vehicle,not running,true,true)
                        if (running) then
                            SetVehicleUndriveable(vehicle,true)
                        else
                            SetVehicleUndriveable(vehicle,false)
                        end
                    end
                end
            end
        },
    },
    ['shared'] = {
        ['giveostopio'] = {
            dict = 'gndostopiomedic@animations',
            anim = 'gndostopiomedic_clip',
            prop = 'gnd_ostopio_medic_prop',
            flag = 50,
            hand = 28422,
            pos = { 0.06, 0.07, 0.01, -104.0, 182.0, 24.4 },
            andar = false,
            loop = true,
            extra = function()
                RequestAnimDict('gndostopiomedic@animations')
                while (not HasAnimDictLoaded('gndostopiomedic@animations')) do Citizen.Wait(0); end;
                TaskPlayAnim(PlayerPedId(), 'gndostopiomedic@animations', 'gndostopiomedic_clip', 4.0, 4.0, -1, 50, 0.0)
            end,
            syncOption = {
                attachTo = true,
                xPos = -0.45,
                yPos = -0.05,
                zPos = 0.0,
                xRot = 0.0,
                yRot = 0.0,
                zRot = 280.0
            },
            otherAnim = 'receivepaciente',
            type = 'hospital',
            perm = 'hospital.permissao'
        },
        ['receivepaciente'] = {
            dict = 'gndostopiopacient@animations',
            anim = 'gndostopiopacient_clip',
            andar = false,
            loop = true,
            type = 'hospital',
            perm = 'hospital.permissao'
        },
        ['giveostopiokid'] = {
            dict = 'gndkidotoscopiomedic@animations',
            anim = 'gndkidotoscopiomedic_clip',
            prop = 'gnd_ostopio_medic_prop',
            flag = 50,
            hand = 28422,
            pos = { 0.07, 0.1, -0.01, -93.73, -189.5, 30.0 },
            andar = false,
            loop = true,
            extra = function()
                RequestAnimDict('gndkidotoscopiomedic@animations')
                while (not HasAnimDictLoaded('gndkidotoscopiomedic@animations')) do Citizen.Wait(0); end;
                TaskPlayAnim(PlayerPedId(), 'gndkidotoscopiomedic@animations', 'gndkidotoscopiomedic_clip', 4.0, 4.0, -1, 10, 0.0)
            end,
            syncOption = {
                attachTo = true,
                xPos = -0.18,
                yPos = -0.01,
                zPos = 0.0,
                xRot = 0.0,
                yRot = 0.0,
                zRot = 280.0
            },
            otherAnim = 'receivepacientekid',
            type = 'hospital',
            perm = 'hospital.permissao'
        },
        ['receivepacientekid'] = {
            dict = 'gndkidotoscopiopacient@animations',
            anim = 'gndkidotoscopiopacient_clip',
            andar = false,
            loop = true,
            type = 'hospital',
            perm = 'hospital.permissao'
        },
    },
    ['animations'] = {
        ['continencia'] = {
            dict = 'genesismodssalute',
            anim = 'idle',
            andar = true,
            loop = true,
            type = 'cumprimentos'
        },
        ['continencia2'] = {
            dict = 'mp_player_int_uppersalute',
            anim = 'mp_player_int_salute',
            andar = true,
            loop = true,
            type = 'cumprimentos'
        },
        ['raiox'] = {
            dict = 'gndraioxavaliando@animations',
            anim = 'gndraioxavaliando_clip',
            prop = 'gnd_raio_x_paper',
            flag = 50,
            hand = 28422,
            pos = { 0.07, 0.09, -0.16, -54.53, 89.82, 11.75 },
            extra = function()
                RequestAnimDict('gndraioxavaliando@animations')
                while not HasAnimDictLoaded('gndraioxavaliando@animations') do Citizen.Wait(0); end;
	            TaskPlayAnim(PlayerPedId(), 'gndraioxavaliando@animations', 'gndraioxavaliando_clip', 4.0, 4.0, -1, 50, 0.0)
            end,
            andar = false,
            loop = true,
            type = 'hospital'
        },
    } 
}