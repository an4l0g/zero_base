local vSERVER = Tunnel.getInterface('tattooShop')

local locsConfig = config.locs
local generalConfig =  config.general['tattooshop']

local getTattoos = function(_tattoos, model)
    local ped = PlayerPedId()
    local custom = LocalPlayer.state.pedTattoo
    local pedTattoos = {
        [GetHashKey('mp_m_freemode_01')] = {
            { part = _tattoos.male.torso.tattoo, model = (custom.torso or 0), type = 'torso' },
            { part = _tattoos.male.head.tattoo, model = (custom.head or 0), type = 'head' },
            { part = _tattoos.male.leftarm.tattoo, model = (custom.leftarm or 0), type = 'leftarm' },
            { part = _tattoos.male.rightarm.tattoo, model = (custom.rightarm or 0), type = 'rightarm' },
            { part = _tattoos.male.leftleg.tattoo, model = (custom.leftleg or 0), type = 'leftleg' },
            { part = _tattoos.male.rightleg.tattoo, model = (custom.rightleg or 0), type = 'rightleg' },
            { part = _tattoos.male.overlay.tattoo, model = (custom.overlay or 0), type = 'overlay' },
        },
        [GetHashKey('mp_f_freemode_01')] = {
            { part = _tattoos.male.torso.tattoo, model = (custom.torso or 0), type = 'torso' },
            { part = _tattoos.male.head.tattoo, model = (custom.head or 0), type = 'head' },
            { part = _tattoos.male.leftarm.tattoo, model = (custom.leftarm or 0), type = 'leftarm' },
            { part = _tattoos.male.rightarm.tattoo, model = (custom.rightarm or 0), type = 'rightarm' },
            { part = _tattoos.male.leftleg.tattoo, model = (custom.leftleg or 0), type = 'leftleg' },
            { part = _tattoos.male.rightleg.tattoo, model = (custom.rightleg or 0), type = 'rightleg' },
            { part = _tattoos.male.overlay.tattoo, model = (custom.overlay or 0), type = 'overlay' },
        }
    }
    return pedTattoos[model]
end

openTattooShop = function(locs)
    TriggerEvent('zero_hud:toggleHud', false)
    local location = locsConfig[locs]
    local general = generalConfig[location.config]

    SetNuiFocus(true, true)

    inMenu = true

    local ped = PlayerPedId()
    local model = GetEntityModel(ped)
    
    oldCustom = zero.getCustomization()
    SetEntityCoords(ped, location.coord.xyz)
    SetEntityHeading(ped, location.coord.w)
    ClearPedTasks(ped)

    if (general.hidePlayers) then setPlayersVisible(false); end;

    local tattoos = getTattoos(general.shopConfig, model)
    SendNUIMessage({ 
        method = 'openTattooShop', 
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
        -- setPedTattoo()
    else 
        -- setPedTattoo()
    end
end)