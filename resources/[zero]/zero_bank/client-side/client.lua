cli = {}
Tunnel.bindInterface(GetCurrentResourceName(), cli)
vSERVER = Tunnel.getInterface(GetCurrentResourceName())

local configBank = config.bank
local configGeneral = config.general

-- local generalConfig = {
--     ['logoPNG'] = 'https://cdn.discordapp.com/attachments/995837649254363136/1050540552686403664/logo-sem-efeito-v2.png',
--     ['propCaixas'] = {
--         'prop_atm_01',
--         'prop_atm_02',
--         'prop_atm_03',
--         'prop_fleeca_atm'
--     }
-- } 

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
                if (dist <= 1.5) then
                    local config = configBank[index]
                    DrawMarker(0, config.coord.x, config.coord.y, config.coord.z, 0, 0, 0, 0, 0, 0, 0.2, 0.2, 0.2, 0, 153, 255, 155, 1, 0, 0, 1)
                    if (dist <= 0.5 and IsControlJustPressed(0, 38) and GetEntityHealth(ped) > 100 and not IsPedInAnyVehicle(ped)) then
                        openBank(config) 
                    end
                end
            end
            Citizen.Wait(1)
        end
        _markerThread = false
    end)
end

Citizen.CreateThread(function()
    addBlips()
    StopScreenEffect('MenuMGSelectionIn')
    while (true) do
        local ped = PlayerPedId()
        local pCoord = GetEntityCoords(ped)
        nearestBlips = {}
        for k, v in pairs(configBank) do
            local distance = #(pCoord - v.coord)
            if (distance <= 1.5) then
                nearestBlips[k] = distance
            end
        end
        if (countTable(nearestBlips) > 0) then markerThread(); end;
        Citizen.Wait(1000)
    end
end)

openBank = function(config)
    if (vSERVER.checkPermission(config.perm)) then
        local carteira, banco, nome = vSERVER.playerInfo()
        TriggerEvent('zero_hud:toggleHud', false)
        StartScreenEffect('MenuMGSelectionIn', 0, true)
        SetNuiFocus(true, true)
        SendNUIMessage({
            type = 'show',
            nome = nome,
            bank = banco,
            money = carteira,
            logo = 'https://cdn.discordapp.com/attachments/922885255386517535/1128411705173627060/k1ZAtQdPi240HwV0A5CZgx4aftxdZUfgl8NaNraL.png',
            key_pix = vSERVER.getPix(),
            rendimentos = vSERVER.getRendimento()
        })
    end
end

RegisterNUICallback('ws:update_key', function(data, cb)
    local key = vSERVER.getPix()
    if (key) then cb({ chave = key }) end
end)

RegisterNUICallback('register_pix',function(data, cb)
    local key = data.key if (key) then vSERVER.createPix(key:upper()) end
end)

RegisterNUICallback('edit_pix',function(data, cb)
    local key = data.key if (key) then vSERVER.editPix(key:upper()) end
end)

RegisterNUICallback('remove_pix',function(data, cb)
    vSERVER.removePix()
end)

RegisterNUICallback('ws:sacar',function(data, cb)
    local value = tonumber(data.value)
    if (value ~= nil and value > 0) then vSERVER.sacar(value); end;
end)

RegisterNUICallback('ws:depositar',function(data, cb)
    local value = tonumber(data.value)
    if (value ~= nil and value > 0) then vSERVER.depositar(value); end;
end)

RegisterNUICallback('ws:transferir',function(data, cb)
    local id, value = tonumber(data.id), tonumber(data.value)
    if (id ~= nil and id > 0 and value ~= nil and value > 0) then vSERVER.transferir(id, value); end;
end)

RegisterNUICallback('ws:limpar_transferencia',function(data, cb)
    vSERVER.clearTransferencia()
end)

RegisterNUICallback('get_multas',function(data, cb)
    local multas = vSERVER.getMultas()
    if (multas) then cb({ multas = multas }); end;
end)

RegisterNUICallback('gerate_grafico',function(data, cb)
    local ganhou,perdeu,multas,total,rendimento = vSERVER.generateData()
    if (ganhou and perdeu and multas and total and rendimento) then
        cb({ ganhou = ganhou, perdeu = perdeu, multas = multas, total = total, rendimento = rendimento})
    end
end)

RegisterNUICallback('pagar_multa',function(data)
    local id = tonumber(data.id_multa)
    if id then vSERVER.pagarMultas(id); end;
end)

RegisterNUICallback('ws:get_trans',function(data, cb)
    local historyCache = vSERVER.getHistoricoBank()
    if (historyCache) then cb({ trans = historyCache }); end;
end)

RegisterNUICallback('ws:update_money',function(data, cb)
    local wallet,bank = vSERVER.updateMoney()
    if (wallet and bank) then cb({ money = wallet,bank = bank }); end;
end)

RegisterNUICallback('ws:close',function(data, cb)
    StopScreenEffect('MenuMGSelectionIn')
    SetNuiFocus(false, false)
    TriggerEvent('zero_hud:toggleHud', true)
end)

RegisterNetEvent('bank_notify', function(type, title, message)
    SendNUIMessage({
        type = 'notify',
        mode = type,
        title = title,
        message = message,
    })
end)

Citizen.CreateThread(function()
    while (true) do
        Citizen.Wait(configGeneral.incomeTime)
        vSERVER.giveRendimento()
    end
end)

addBlips = function()
    for _, v in pairs(configBank) do
        if (v.blip) then
            local blip = AddBlipForCoord(v.coord.x,v.coord.y,v.coord.z)
            SetBlipSprite(blip, 207)
            SetBlipAsShortRange(blip, true)
            SetBlipColour(blip, 0)
            SetBlipScale(blip, 0.7)
            BeginTextCommandSetBlipName('STRING')
            AddTextComponentString('Banco')
            EndTextCommandSetBlipName(blip)
        end
    end
end