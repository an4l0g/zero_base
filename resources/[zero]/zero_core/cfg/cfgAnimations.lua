local config = {}

local cancelKeyMapping = false

config.animations = {
    ['keyMapping'] = {
        ['cruzarBraco'] = {
            key = 'f1',
            text = 'Animação - Cruzar o Braço',
            action = function()
                local ped = PlayerPedId()
                if (not IsPedInAnyVehicle(ped) and GetEntityHealth(ped) > 100 and not cancelKeyMapping) then
                    if (IsEntityPlayingAnim(ped, 'anim@heists@heist_corona@single_team', 'single_team_loop_boss', 3)) then
                        zero.DeletarObjeto()
                    else
                        zero.DeletarObjeto()
                        zero.playAnim(true, {{ 'anim@heists@heist_corona@single_team', 'single_team_loop_boss' }}, true)
                    end
                end
            end
        },
        ['aguardar'] = {
            key = 'f2',
            text = 'Animação - Aguardar',
            action = function()
                local ped = PlayerPedId()
                local menuCelular = zero.getMenuCelular()
                if (not IsPedInAnyVehicle(ped) and GetEntityHealth(ped) > 100 and not menuCelular and not cancelKeyMapping) then
                    if (IsEntityPlayingAnim(ped, 'mini@strip_club@idles@bouncer@base', 'base', 3)) then
                        zero.DeletarObjeto()
                    else
                        zero.DeletarObjeto()
                        zero.playAnim(true, {{ 'mini@strip_club@idles@bouncer@base', 'base' }}, true)
                    end
                end
            end
        },
        ['dedoMeio'] = {
            key = 'f3',
            text = 'Animação - Dedo do meio',
            action = function()
                local ped = PlayerPedId()
                local menuCelular = zero.getMenuCelular()
                if (not IsPedInAnyVehicle(ped) and GetEntityHealth(ped) > 100 and not menuCelular and not cancelKeyMapping) then
                    if (IsEntityPlayingAnim(ped, 'anim@mp_player_intselfiethe_bird', 'idle_a', 3)) then
                        zero.DeletarObjeto()
                    else
                        zero.DeletarObjeto()
                        zero.playAnim(true, {{ 'anim@mp_player_intselfiethe_bird', 'idle_a' }}, true)
                    end
                end
            end
        },
        ['render'] = {
            key = 'f5',
            text = 'Animação - Se render',
            action = function()
                local ped = PlayerPedId()
                local menuCelular = zero.getMenuCelular()
                if (not IsPedInAnyVehicle(ped) and GetEntityHealth(ped) > 100 and not menuCelular and not cancelKeyMapping) then
                    if IsEntityPlayingAnim(ped, 'random@arrests@busted', 'idle_a', 3) then
                        zero.DeletarObjeto()
                    else
                        zero.DeletarObjeto()
                        zero.CarregarAnim('random@arrests')
                        zero.CarregarAnim('random@arrests@busted')
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
                local menuCelular = zero.getMenuCelular()
                TriggerEvent('zero_animations:cancelSharedAnimation')
                cancelKeyMapping = false
                if (GetEntityHealth(ped) > 100 and not menuCelular) then
                    disableActions(false)
                    zero.DeletarObjeto()
                    ClearPedTasks(ped)
                end
            end
        },
        ['maoCabeca'] = {
            key = 'f10',
            text = 'Animação - Mãos na cabeça',
            action = function()
                local ped = PlayerPedId()
                local menuCelular = zero.getMenuCelular()
                if (GetEntityHealth(ped) > 100 and not menuCelular and not cancelKeyMapping) then
                    if IsEntityPlayingAnim(ped, 'random@arrests@busted', 'idle_a', 3) then
                        zero.DeletarObjeto()
                    else
                        zero.DeletarObjeto()
                        zero.playAnim(true, {{'random@arrests@busted', 'idle_a'}}, true)    
                    end            
                end
            end
        },
        ['levantarMaos'] = {
            key = 'x',
            text = 'Animação - Levantar as mãos',
            action = function()
                local ped = PlayerPedId()
                local menuCelular = zero.getMenuCelular()
                if (GetEntityHealth(ped) > 100 and not menuCelular and not cancelKeyMapping) then
                    if IsEntityPlayingAnim(ped, 'random@mugging3', 'handsup_standing_base', 3) then
                        zero.DeletarObjeto()
                    else
                        zero.DeletarObjeto()
                        zero.playAnim(true, {{'random@mugging3', 'handsup_standing_base'}}, true)
                    end
                end
            end
        },
        ['delete'] = {
            key = 'delete',
            text = 'Animação - Joia duplo',
            action = function()
                local ped = PlayerPedId()
                local menuCelular = zero.getMenuCelular()
                if (not IsPedInAnyVehicle(ped) and GetEntityHealth(ped) > 100 and not menuCelular and not cancelKeyMapping) then
                    zero.playAnim(true, {{ 'anim@mp_player_intincarthumbs_upbodhi@ps@', 'enter' }}, false)
                end
            end
        },
        ['assobiar'] = {
            key = 'down',
            text = 'Animação - Assobiar',
            action = function()
                local ped = PlayerPedId()
                local menuCelular = zero.getMenuCelular()
                if (not IsPedInAnyVehicle(ped) and GetEntityHealth(ped) > 100 and not menuCelular and not cancelKeyMapping) then
                    zero.playAnim(true, {{ 'rcmnigel1c', 'hailing_whistle_waive_a' }}, false)
                end
            end
        },
        ['saudacao'] = {
            key = 'up',
            text = 'Animação - Saudação',
            action = function()
                local ped = PlayerPedId()
                local menuCelular = zero.getMenuCelular()
                if (not IsPedInAnyVehicle(ped) and GetEntityHealth(ped) > 100 and not menuCelular and not cancelKeyMapping) then
                    zero.playAnim(true, {{ 'anim@mp_player_intcelebrationmale@salute', 'salute' }}, false)
                end
            end
        },
        ['joia'] = {
            key = 'left',
            text = 'Animação - Joia',
            action = function()
                local ped = PlayerPedId()
                local menuCelular = zero.getMenuCelular()
                if (not IsPedInAnyVehicle(ped) and GetEntityHealth(ped) > 100 and not menuCelular and not cancelKeyMapping) then
                    zero.playAnim(true, {{ 'anim@mp_player_intselfiethumbs_up', 'idle_a' }}, false)
                end
            end
        },
        ['facepalm'] = {
            key = 'right',
            text = 'Animação - Facepalm',
            action = function()
                local ped = PlayerPedId()
                local menuCelular = zero.getMenuCelular()
                if (not IsPedInAnyVehicle(ped) and GetEntityHealth(ped) > 100 and not menuCelular and not cancelKeyMapping) then
                    zero.playAnim(true, {{ 'anim@mp_player_intupperface_palm', 'idle_a' }}, false)
                end
            end
        },
        ['apontar'] = {
            key = 'b',
            text = 'Animação - Apontar',
            action = function()
                local ped = PlayerPedId()
                local menuCelular = zero.getMenuCelular()

                if (IsPedArmed(ped, 4)) then return; end;

                if (GetEntityHealth(ped) > 100 and not menuCelular and not cancelKeyMapping) then
                    zero.CarregarAnim('anim@mp_point')
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
                        zero.DeletarObjeto()
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
        ['otoscopio'] = {
            category = 'medic',
            title = '[Médico] - Otoscopia',
            dict = 'gndostopiomedic@animations',
            anim = 'gndostopiomedic_clip',
            prop = 'gnd_ostopio_medic_prop',
            flag = 50,
            hand = 28422,
            pos = { 0.06, 0.07, 0.01, -104.0, 182.0, 24.4 },
            andar = false,
            loop = true,
            extra = function()
                cancelKeyMapping = true
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
            otherAnim = 'otoscopio2',
            perm = 'hospital.permissao'
        },
        ['otoscopio2'] = {
            category = 'medic',
            title = '[Paciente] - Otoscopia',
            dict = 'gndostopiopacient@animations',
            anim = 'gndostopiopacient_clip',
            andar = false,
            loop = true,
            otherAnim = 'otoscopio',
        },
        ['otoscopio3'] = {
            category = 'medic',
            title = '[Médico] - Otoscopia criança',
            dict = 'gndkidotoscopiomedic@animations',
            anim = 'gndkidotoscopiomedic_clip',
            prop = 'gnd_ostopio_medic_prop',
            flag = 50,
            hand = 28422,
            pos = { 0.07, 0.1, -0.01, -93.73, -189.5, 30.0 },
            andar = false,
            loop = true,
            extra = function()
                cancelKeyMapping = true
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
            otherAnim = 'otoscopio4',
            perm = 'hospital.permissao'
        },
        ['otoscopio4'] = {
            category = 'medic',
            title = '[Paciente] - Otoscopia criança',
            dict = 'gndkidotoscopiopacient@animations',
            anim = 'gndkidotoscopiopacient_clip',
            andar = false,
            loop = true,
            otherAnim = 'otoscopio3',
        },
        ['cadeiraderodas'] = {
            category = 'medic',
            title = '[Médico] - Cadeira de rodas',
            dict = 'gndempurrandochairwhell@animations',
            anim = 'gndempurrandochairwhell_clip',
            prop = 'gnd_cadeira_de_rodas_prop',
            flag = 50,
            hand = 28422,
            pos = { 0.81, 0.09, -0.24, 51.64, -91.5, 160.97 },
            andar = true,
            loop = true,
            extra = function()
                cancelKeyMapping = true
                RequestAnimDict('gndempurrandochairwhell@animations')
                while (not HasAnimDictLoaded('gndempurrandochairwhell@animations')) do Citizen.Wait(0); end;
                TaskPlayAnim(PlayerPedId(), 'gndempurrandochairwhell@animations', 'gndempurrandochairwhell_clip', 4.0, 4.0, -1, 50, 0.0)
                disableActions(true)
            end,
            syncOption = {
                attachTo = false,
                bone = 28442,
                xPos = 0.81,
                yPos = 0.09,
                zPos = -0.24,
                xRot = 51.64,
                yRot = 0.0,
                zRot = 0.0
            },
            otherAnim = 'cadeiraderodas2',
            perm = 'hospital.permissao'  
        },
        ['cadeiraderodas2'] = {
            category = 'medic',
            title = '[Paciente] - Cadeira de rodas',
            dict = 'gndcadeirantepernaquebrada@animations',
            anim = 'gndcadeirantepernaquebrada_clip',
            andar = false,
            loop = true,
            syncOption = {
                attachTo = true,
                bone = 28442,
                xPos = 0.0,
                yPos = 0.8,
                zPos = 0.0,
                xRot = -49.31,
                yRot = 0.0,
                zRot = 0.0
            },
            otherAnim = 'cadeiraderodas',
        },
        ['casal'] = {
            category = 'couple',
            title = '[Mulher] - Holdface',
            dict = 'genesismods@bmv_holdfacef',
            anim = 'holdfacef',
            andar = false,
            loop = true,
            extra = function()
                cancelKeyMapping = true
            end,
            syncOption = {
                attachTo = true,
                bone = 28442,
                xPos = 0.0,
                yPos = 0.37,
                zPos = 0.0,
                xRot = 0.0,
                yRot = 0.0,
                zRot = 180.0
            },
            otherAnim = 'casal2',
        },
        ['casal2'] = {
            category = 'couple',
            title = '[Homem] - Holdface',
            dict = 'genesismods@bmv_holdfacem',
            anim = 'holdfacem',
            andar = false,
            loop = true,
            extra = function()
                cancelKeyMapping = true
            end,
            otherAnim = 'casal',
        },
        ['casal3'] = {
            category = 'couple',
            title = '[Mulher] - Holdhands',
            dict = 'genesismods@bmv_holdhandsf',
            anim = 'holdhandsf',
            andar = false,
            loop = true,
            extra = function()
                cancelKeyMapping = true
            end,
            syncOption = {
                attachTo = true,
                bone = 28442,
                xPos = 0.0,
                yPos = 0.61,
                zPos = 0.0,
                xRot = 0.0,
                yRot = 0.0,
                zRot = 180.0
            },
            otherAnim = 'casal4',
        },
        ['casal4'] = {
            category = 'couple',
            title = '[Homem] - Holdhands',
            dict = 'genesismods@bmv_holdhandsm',
            anim = 'holdhandsm',
            andar = false,
            loop = true,
            extra = function()
                cancelKeyMapping = true
            end,
            otherAnim = 'casal3',
        },
        ['casal5'] = {
            category = 'couple',
            title = '[Mulher] - Hug',
            dict = 'genesismods@bmv_hugf',
            anim = 'hugf',
            andar = false,
            loop = true,
            extra = function()
                cancelKeyMapping = true
            end,
            syncOption = {
                attachTo = true,
                bone = 28442,
                xPos = -0.22,
                yPos = -0.15,
                zPos = -0.01,
                xRot = 0.0,
                yRot = 0.0,
                zRot = 0.0
            },
            otherAnim = 'casal6',
        },
        ['casal6'] = {
            category = 'couple',
            title = '[Homem] - Hug',
            dict = 'genesismods@bmv_hugm',
            anim = 'hugm',
            andar = false,
            loop = true,
            extra = function()
                cancelKeyMapping = true
            end,
            otherAnim = 'casal5',
        },
        ['casal7'] = {
            category = 'couple',
            title = '[Mulher] - Hug 2',
            dict = 'genesismods@bmv_hug2f',
            anim = 'hug2f',
            andar = false,
            loop = true,
            extra = function()
                cancelKeyMapping = true
            end,
            syncOption = {
                attachTo = true,
                bone = 28442,
                xPos = 0.075,
                yPos = 0.35,
                zPos = 0.0,
                xRot = 0.0,
                yRot = 0.0,
                zRot = 180.0
            },
            otherAnim = 'casal8',
        },
        ['casal8'] = {
            category = 'couple',
            title = '[Homem] - Hug 2',
            dict = 'genesismods@bmv_hug2m',
            anim = 'hug2m',
            andar = false,
            loop = true,
            extra = function()
                cancelKeyMapping = true
            end,
            otherAnim = 'casal7',
        },
        ['casal9'] = {
            category = 'couple',
            title = '[Mulher] - Kissing hand',
            dict = 'genesismods@bmv_kissinghandf',
            anim = 'kissinghandf',
            andar = false,
            loop = true,
            extra = function()
                cancelKeyMapping = true
            end,
            syncOption = {
                attachTo = true,
                bone = 28442,
                xPos = 0.3,
                yPos = 0.4,
                zPos = 0.0,
                xRot = 0.0,
                yRot = 0.0,
                zRot = 180.0
            },
            otherAnim = 'casal10',
        },
        ['casal10'] = {
            category = 'couple',
            title = '[Homem] - Kissing hand',
            dict = 'genesismods@bmv_kissinghandm',
            anim = 'kissinghandm',
            andar = false,
            loop = true,
            extra = function()
                cancelKeyMapping = true
            end,
            otherAnim = 'casal9',
        },
        ['casal11'] = {
            category = 'couple',
            title = '[Mulher] - Laying',
            dict = 'genesismods@bmv_layingf',
            anim = 'layingf',
            andar = false,
            loop = true,
            extra = function()
                cancelKeyMapping = true
            end,
            syncOption = {
                attachTo = true,
                bone = 28442,
                xPos = 1.4,
                yPos = -0.005,
                zPos = 0.0,
                xRot = 0.0,
                yRot = 0.0,
                zRot = 0.0
            },
            otherAnim = 'casal12',
        },
        ['casal12'] = {
            category = 'couple',
            title = '[Homem] - Laying',
            dict = 'genesismods@bmv_layingm',
            anim = 'layingm',
            andar = false,
            loop = true,
            extra = function()
                cancelKeyMapping = true
            end,
            otherAnim = 'casal11',
        },
        ['casal13'] = {
            category = 'couple',
            title = '[Mulher] - Stare',
            dict = 'genesismods@bmv_staref',
            anim = 'staref',
            andar = false,
            loop = true,
            extra = function()
                cancelKeyMapping = true
            end,
            syncOption = {
                attachTo = true,
                bone = 28442,
                xPos = -0.05,
                yPos = -0.4,
                zPos = 0.0,
                xRot = 0.0,
                yRot = 0.0,
                zRot = 180.0
            },
            otherAnim = 'casal14',
        },
        ['casal14'] = {
            category = 'couple',
            title = '[Homem] - Stare',
            dict = 'genesismods@bmv_starem',
            anim = 'starem',
            andar = false,
            loop = true,
            extra = function()
                cancelKeyMapping = true
            end,
            otherAnim = 'casal13',
        },
        ['casal15'] = {
            category = 'couple',
            title = '[Mulher] - Pedido',
            dict = 'genesismods@bmv_proposalf',
            anim = 'proposalf',
            andar = false,
            loop = true,
            extra = function()
                cancelKeyMapping = true
            end,
            syncOption = {
                attachTo = true,
                bone = 28442,
                xPos = -0.2,
                yPos = 1.0,
                zPos = 0.0,
                xRot = 0.0,
                yRot = 0.0,
                zRot = 180.0
            },
            otherAnim = 'casal16',
        },
        ['casal16'] = {
            category = 'couple',
            title = '[Homem] - Pedido',
            dict = 'genesismods@bmv_proposalm',
            anim = 'proposalm',
            prop = 'love_anel_genesis',
            flag = 50,
            hand = 28422,
            pos = { 0.08, 0.03, -0.08, 220.0, 11.51, 280.0 },
            andar = false,
            loop = true,
            extra = function()
                cancelKeyMapping = true
            end,
            otherAnim = 'casal15',
        },
        ['sexo'] = {
            category = 'sex',
            title = '[Mulher] - 69',
            dict = 'genesismods@oralfixation_69f',
            anim = '69f',
            andar = false,
            loop = true,
            extra = function()
                cancelKeyMapping = true
            end,
            syncOption = {
                attachTo = true,
                bone = 28442,
                xPos = -0.6,
                yPos = 0.0,
                zPos = 0.1,
                xRot = 0.0,
                yRot = 0.0,
                zRot = 0.0
            },
            otherAnim = 'sexo2',
        },
        ['sexo2'] = {
            category = 'sex',
            title = '[Homem] - 69',
            dict = 'genesismods@oralfixation_69m',
            anim = '69m',
            andar = false,
            loop = true,
            extra = function()
                cancelKeyMapping = true
            end,
            otherAnim = 'sexo',
        },
        ['sexo3'] = {
            category = 'sex',
            title = '[Mulher] - Blowjob',
            dict = 'genesismods@oralfixation_blowjobf',
            anim = 'blowjobf',
            andar = false,
            loop = true,
            extra = function()
                cancelKeyMapping = true
            end,
            syncOption = {
                attachTo = true,
                bone = 28442,
                xPos = 0.0,
                yPos = -0.6,
                zPos = 0.0,
                xRot = 0.0,
                yRot = 0.0,
                zRot = 0.0
            },
            otherAnim = 'sexo4',
        },
        ['sexo4'] = {
            category = 'sex',
            title = '[Homem] - Blowjob',
            dict = 'genesismods@oralfixation_blowjobm',
            anim = 'blowjobm',
            andar = false,
            loop = true,
            otherAnim = 'sexo3',
        },
        ['sexo5'] = {
            category = 'sex',
            title = '[Mulher] - Deepthroat',
            dict = 'genesismods@oralfixation_deepthroatf',
            anim = 'deepthroatf',
            andar = false,
            loop = true,
            extra = function()
                cancelKeyMapping = true
            end,
            syncOption = {
                attachTo = true,
                bone = 28442,
                xPos = 0.0,
                yPos = -0.6,
                zPos = 0.0,
                xRot = 0.0,
                yRot = 0.0,
                zRot = 0.0
            },
            otherAnim = 'sexo6',
        },
        ['sexo6'] = {
            category = 'sex',
            title = '[Homem] - Deepthroat',
            dict = 'genesismods@oralfixation_deepthroatm',
            anim = 'deepthroatm',
            andar = false,
            loop = true,
            otherAnim = 'sexo5',
        },
        ['sexo7'] = {
            category = 'sex',
            title = '[Mulher] - Licking',
            dict = 'genesismods@oralfixation_lickingf',
            anim = 'lickingf',
            andar = false,
            loop = true,
            extra = function()
                cancelKeyMapping = true
            end,
            syncOption = {
                attachTo = true,
                bone = 28442,
                xPos = 0.0,
                yPos = -0.8,
                zPos = 0.0,
                xRot = 0.0,
                yRot = 0.0,
                zRot = 0.0
            },
            otherAnim = 'sexo8',
        },
        ['sexo8'] = {
            category = 'sex',
            title = '[Homem] - Licking',
            dict = 'genesismods@oralfixation_lickingm',
            anim = 'lickingm',
            andar = false,
            loop = true,
            otherAnim = 'sexo7',
        },
    },
    ['animations'] = {
        ['continencia'] = {
            category = 'animations',
            title = 'Continência vibrante',
            dict = 'genesismodssalute',
            anim = 'salute',
            andar = false,
            loop = false,
        },
        ['continencia2'] = {
            category = 'animations',
            title = 'Continência',
            dict = 'mp_player_int_uppersalute',
            anim = 'mp_player_int_salute',
            andar = true,
            loop = true,
        },
        ['raiox'] = {
            category = 'medic',
            title = 'Raio X',
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
        },
        ['testededo'] = {
            category = 'medic',
            title = 'Teste de dedo',
            prop = 'gnd_test_dedo_prop',
            flag = 50,
            hand = 28422,
            pos = { 0.14, 0.03, -0.03, -34.12, 11.51, -108.09 },
            andar = false,
            loop = true,
        },
        ['soro'] = {
            category = 'medic',
            title = 'Soro',
            dict = 'gndpacientecarregandosoro@animations',
            anim = 'gndpacientecarregandosoro_clip',
            prop = 'gnd_prop_soro',
            flag = 50,
            hand = 60309,
            pos = { 0.0, -0.28, 0.04, -97.4, -98.66, 10.89 },
            extra = function()
                RequestAnimDict('gndpacientecarregandosoro@animations')
                while not HasAnimDictLoaded('gndpacientecarregandosoro@animations') do Citizen.Wait(0); end;
	            TaskPlayAnim(PlayerPedId(), 'gndpacientecarregandosoro@animations', 'gndpacientecarregandosoro_clip', 4.0, 4.0, -1, 49, 0.0)
                disableActions(true)
            end,
            andar = true,
            loop = true,
        },
        ['inalacao'] = {
            category = 'medic',
            title = 'Inalação',
            dict = 'gndinalacaopacientepackhospital@animations',
            anim = 'gndinalacaopacientepackhospital_clip',
            prop = 'gnd_inalacao_prop',
            flag = 50,
            hand = 60309,
            pos = { 0.09, 0.01, 0.04, -191.18, -2.42, 113.74 },
            extra = function()
                RequestAnimDict('gndinalacaopacientepackhospital@animations')
                while not HasAnimDictLoaded('gndinalacaopacientepackhospital@animations') do Citizen.Wait(0); end;
	            TaskPlayAnim(PlayerPedId(), 'gndinalacaopacientepackhospital@animations', 'gndinalacaopacientepackhospital_clip', 4.0, 4.0, -1, 15, 0.0)
            end,
            andar = true,
            loop = true,
        },
        ['medico'] = {
            category = 'medic',
            title = 'Maleta de utensílios',
            prop = 'gnd_bag_paramedic',
            flag = 50,
            hand = 28422,
            pos = { 0.19, -0.01, 0.03, 6.04, -87.58, -124.32 },
            extra = function()
                RequestModel(GetHashKey('gnd_bag_paramedic'))
                while not HasModelLoaded(GetHashKey('gnd_bag_paramedic')) do Citizen.Wait(10); end;
            end,
            andar = true,
            loop = true,
            perm = 'hospital.permissao'
        },
        ['medico2'] = {
            category = 'medic',
            title = 'Maleta do desfribilador',
            prop = 'gnd_desfribilador_maleta',
            flag = 50,
            hand = 28422,
            pos = { 0.2, 0.0, 0.04, -14.52, -84.7, 68.97 },
            extra = function()
                RequestModel(GetHashKey('gnd_desfribilador_maleta'))
                while not HasModelLoaded(GetHashKey('gnd_desfribilador_maleta')) do Citizen.Wait(10); end;
            end,
            andar = true,
            loop = true,
        },
        ['mexer'] = {
            dict = 'amb@prop_human_parking_meter@female@idle_a',
            anim = 'idle_a_female',
            andar = true,
            loop = true
        }
    } 
}

return config