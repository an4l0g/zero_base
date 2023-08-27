local vSERVER = Tunnel.getInterface('tattooShop')

local locsConfig = config.locs
local generalConfig = config.general['tattooshop']

local getTattoos = function(_tattoos, model)
    local ped = PlayerPedId()
    local custom = LocalPlayer.state.pedTattoo
    local pedTattoos = {
        [GetHashKey('mp_m_freemode_01')] = {
            { part = _tattoos.male.torso.tattoo, model = (custom['0'] or {}), type = 'torso' },
            { part = _tattoos.male.head.tattoo, model = (custom['1'] or {}), type = 'head' },
            { part = _tattoos.male.leftarm.tattoo, model = (custom['2'] or {}), type = 'leftarm' },
            { part = _tattoos.male.rightarm.tattoo, model = (custom['3'] or {}), type = 'rightarm' },
            { part = _tattoos.male.leftleg.tattoo, model = (custom['4'] or {}), type = 'leftleg' },
            { part = _tattoos.male.rightleg.tattoo, model = (custom['5'] or {}), type = 'rightleg' },
            { part = _tattoos.male.overlay.tattoo, model = (custom['6'] or {}), type = 'overlay' },
        },
        [GetHashKey('mp_f_freemode_01')] = {
            { part = _tattoos.female.torso.tattoo, model = (custom['0'] or {}), type = 'torso' },
            { part = _tattoos.female.head.tattoo, model = (custom['1'] or {}), type = 'head' },
            { part = _tattoos.female.leftarm.tattoo, model = (custom['2'] or {}), type = 'leftarm' },
            { part = _tattoos.female.rightarm.tattoo, model = (custom['3'] or {}), type = 'rightarm' },
            { part = _tattoos.female.leftleg.tattoo, model = (custom['4'] or {}), type = 'leftleg' },
            { part = _tattoos.female.rightleg.tattoo, model = (custom['5'] or {}), type = 'rightleg' },
            { part = _tattoos.female.overlay.tattoo, model = (custom['6'] or {}), type = 'overlay' },
        }
    }
    return pedTattoos[model]
end

openTattooShop = function(locs)
    local ped = PlayerPedId()
    local model = GetEntityModel(ped)
    if (model ~= GetHashKey('mp_m_freemode_01') and model ~= GetHashKey('mp_f_freemode_01')) then return; end;

    TriggerEvent('zero_hud:toggleHud', false)
    local location = locsConfig[locs]
    local general = generalConfig[location.config]

    SetNuiFocus(true, true)

    inMenu = true

    oldCustom = zero.getCustomization()
    SetEntityCoords(ped, location.coord.xyz)
    SetEntityHeading(ped, location.coord.w)
    ClearPedTasks(ped)

    if (general.hidePlayers) then setPlayersVisible(false); end;

    local tattoos = getTattoos(general.shopConfig, model)
    SendNUIMessage({ 
        action = 'openTattooShop', 
        data = {
            drawables = tattoos, 
            sex = (model == GetHashKey('mp_m_freemode_01') and 'male' or 'female'), 
        }
    })

    Citizen.Wait(500) 
    if (not DoesCamExist(tempCam)) then createCam('body'); end;
    if (general.clothes) then setClothes(general.clothes); end;
    FreezeEntityPosition(ped, true)
end

RegisterNetEvent('zero:tattooUpdate', function()
    if (LocalPlayer.state.pedTattoo == nil) then 
        LocalPlayer.state.pedTattoo = vSERVER.getTattoo()      
        setPedTattoos()
    else 
        setPedTattoos()
    end
end)

setPedTattoos = function()
    Citizen.Wait(100)
    local ped = PlayerPedId()
    local data = LocalPlayer.state.pedTattoo

    if (data) then
        ClearPedDecorations(ped)
        for k, table in pairs(data) do
            for _, v in pairs(table) do
                AddPedDecorationFromHashes(ped, GetHashKey(v.part), GetHashKey(v.name))
            end
        end
    end
end

RegisterNuiCallback('changeTattooDemo', function(data)
    print('MEXEU TATTOO')
    local ped = PlayerPedId()
    if (data.drawables) then
        ClearPedDecorations(ped)
        for k, table in pairs(data.drawables) do
            for _, v in pairs(table) do
                AddPedDecorationFromHashes(ped, GetHashKey(v.part), GetHashKey(v.name))
            end
        end
    end
end)

RegisterNuiCallback('buyTattooshopCustomizations', function(data)
    local ped = PlayerPedId()
    local Drawables = data.drawables
    if (Drawables) then
        if (vSERVER.tryPayment(data.total, Drawables)) then
            LocalPlayer.state.pedTattoo = Drawables
            setPedTattoos()
        end
    end
    closeNui()
    setPedTattoos() 
end)