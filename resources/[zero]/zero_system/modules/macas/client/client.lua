local cli = {}
Tunnel.bindInterface('Macas', cli)
local vSERVER = Tunnel.getInterface('Macas')

local inMaca = false
local usageMaca = {}
local tempIndex = nil
local nearestBlips = {}

local _markerThread = false
local markerThread = function()
    if (_markerThread) then return; end;
    _markerThread = true
    Citizen.CreateThread(function()
        while (countTable(nearestBlips) > 0) do
            local ped = PlayerPedId()
            local _cache = nearestBlips
            for index, dist in pairs(_cache) do
                if (not inMaca) then
                    local coord = Macas[index].coord 
                    TextFloating('~b~E~w~ - Deitar\n~b~F~w~ - Tratamento', coord)
                    if (dist <= 1.2 and GetEntityHealth(ped) > 100 and not IsPedInAnyVehicle(ped)) then
                        if (IsControlJustPressed(0, 38)) then
                            if (not vSERVER.verifyMaca(index)) then
                                vSERVER.saveMaca(index)
                                SetPlayerInMaca(index)
                            else
                                TriggerEvent('notify', 'Hospital', 'A <b>maca</b> já está em uso!')
                            end
                        elseif (IsControlJustPressed(0, 75)) then
                            if (not vSERVER.verifyMaca(index)) then
                                if (GetEntityHealth(ped) < 200) then 
                                    vSERVER.saveMaca(index)
                                    vSERVER.startTratamento(index)
                                else
                                    TriggerEvent('notify', 'Hospital', 'Você não pode iniciar um <b>tratamento</b> com a vida cheia!')
                                end
                            else
                                TriggerEvent('notify', 'Hospital', 'A <b>maca</b> já está em uso!')
                            end
                        end
                    end
                end
            end
            Citizen.Wait(1)
        end
        _markerThread = false
    end)
end

Citizen.CreateThread(function()
    while (true) do
        local ped = PlayerPedId()
        local pCoord = GetEntityCoords(ped)
        nearestBlips = {}
        for k, v in pairs(Macas) do
            local distance = #(pCoord - v.coord)
            if (distance <= 2) then
                nearestBlips[k] = distance
            end
        end
        if (countTable(nearestBlips) > 0) then markerThread(); end;
        Citizen.Wait(1000)
    end
end)

SetPlayerInMaca = function(index)
    local _config = Macas[index]

    inMaca = index
    local ped = PlayerPedId()
    SetEntityCoords(ped, _config.bed.xyz)
    SetEntityHeading(ped, _config.bed.w)
    Citizen.Wait(700)
    FreezeEntityPosition(ped, true)
    TriggerEvent('zero_animations:setAnim', _config.anim)
end

cli.checkMaca = function()
    return inMaca
end

local inTratamento = false

AddEventHandler('zero:CancelAnimations',function()
	if (not inTratamento) and inMaca then
		inMaca = false
		local ped = PlayerPedId()	
		FreezeEntityPosition(ped, false)
		ClearPedTasks(ped)			
        vSERVER.deleteMaca()
	end
end)

cli.setTratamento = function(index)
    if (inTratamento) then return; end;
    inTratamento = true
    
    if (index) then SetPlayerInMaca(index); end;

    local ped = PlayerPedId()

    LocalPlayer.state.BlockTasks = true

    TriggerEvent('notify', 'Hospital', 'O seu tratamento foi iniciado com sucesso! Aguarde a liberação do <b>médico</b>.')

    repeat
        Citizen.Wait(600)
        SetEntityHealth(ped, (GetEntityHealth(ped) + 3))
    until (GetEntityHealth(ped) >= GetEntityMaxHealth(ped))

    TriggerEvent('notify', 'Hospital', 'O seu <b>tratamento</b> foi um sucesso!')

    inTratamento = false
    LocalPlayer.state.BlockTasks = false
end

local anestesia = 0
cli.setAnestesia = function(time)
    local ped = PlayerPedId()
	DoScreenFadeOut(5000)
    Citizen.Wait(5000)
    startEffect(time)
    SetPedMotionBlur(ped, true) 
    SetPedIsDrunk(ped, true)
    DoScreenFadeIn(5000)
    FreezeEntityPosition(ped,true)
    TriggerEvent('progressBar', 'Sua anestesia acaba em '..time..' segundos...', time * 1000)
    Citizen.Wait(time * 1000)
    anestesia = 0
    FreezeEntityPosition(ped, false)
    ResetScenarioTypesEnabled()
    ResetPedMovementClipset(ped, 0)
    SetPedIsDrunk(ped, false)
    SetPedMotionBlur(ped, false)
end

startEffect = function(time)
    Citizen.CreateThread(function()
        anestesia = time
        while (anestesia > 0) do
            SetTimecycleModifier('spectator5')
            Citizen.Wait(1)
        end
        ClearTimecycleModifier()
    end)
end

RegisterNetEvent('zero_macas:reanimar', function(time)
    local coords = GetEntityCoords(PlayerPedId())
    local foundGround, z = GetGroundZFor_3dCoord(coords.x, coords.y, 1000.0, 0.0)
    object = CreateObject(GetHashKey('gnd_desfribilador_maleta'), coords.x+0.5, coords.y+0.5, z, false,false,false)
    Citizen.Wait(time * 1000)
    DeleteObject(object)
end)