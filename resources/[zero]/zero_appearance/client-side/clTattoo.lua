local vSERVER = Tunnel.getInterface('tattooShop')
local config = module('zero_appearance', 'cfg/cfgTattoo')

local locsConfig = config.locs
local generalConfig =  config.general

local getTattoos = function(_tattoos, model)
    local ped = PlayerPedId()
    local custom = LocalPlayer.state.pedTattoo
    local pedTattoos = {
        [GetHashKey('mp_m_freemode_01')] = {
            { torso = _tattoos.male.torso.tattoo, model = custom.torso },
            { head = _tattoos.male.head.tattoo, model = custom.head },
            { leftarm = _tattoos.male.leftarm.tattoo, model = custom.leftarm },
            { rightarm = _tattoos.male.rightarm.tattoo, model = custom.rightarm },
            { leftleg = _tattoos.male.leftleg.tattoo, model = custom.leftleg },
            { rightleg = _tattoos.male.rightleg.tattoo, model = custom.rightleg },
            { overlay = _tattoos.male.overlay.tattoo, model = custom.overlay },
        },
        [GetHashKey('mp_f_freemode_01')] = {
            { torso = _tattoos.female.torso.tattoo, model = custom.torso },
            { head = _tattoos.female.head.tattoo, model = custom.head },
            { leftarm = _tattoos.female.leftarm.tattoo, model = custom.leftarm },
            { rightarm = _tattoos.female.rightarm.tattoo, model = custom.rightarm },
            { leftleg = _tattoos.female.leftleg.tattoo, model = custom.leftleg },
            { rightleg = _tattoos.female.rightleg.tattoo, model = custom.rightleg },
            { overlay = _tattoos.female.overlay.tattoo, model = custom.overlay },
        }
    }
    return pedTattoos[model]
end

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
                if (dist <= 5) then
                    local coord = locsConfig[index].coord
                    createMarkers(coord)
                    if (dist <= 1.2 and IsControlJustPressed(0, 38) and GetEntityHealth(ped) > 101 and not IsPedInAnyVehicle(ped)) then
                        openTattooShop(index)  
                    end
                end
            end
            Citizen.Wait(5)
        end
        _markerThread = false
    end)
end

Citizen.CreateThread(function()
    addBlips(locsConfig, generalConfig)
    while (true) do
        local ped = PlayerPedId()
        local pCoord = GetEntityCoords(ped)
        nearestBlips = {}
        for k, v in ipairs(locsConfig) do
            local distance = #(pCoord - v.coord.xyz)
            if (distance <= 5) then
                nearestBlips[k] = distance
            end
        end
        if (countTable(nearestBlips) > 0) then markerThread(); end;
        Citizen.Wait(500)
    end
end)

openTattooShop = function(locs)
    local location = locsConfig[locs]
    local general = generalConfig[location.config]

    SetNuiFocus(true, true)

    inMenu = true

    local ped = PlayerPedId()
    local model = GetEntityModel(ped)
    
    oldCustom = getCustomization()
    SetEntityCoords(ped, location.coord.xyz)
    SetEntityHeading(ped, location.coord.w)
    ClearPedTasks(ped)

    if (general.hidePlayers) then setPlayersVisible(true); end;

    local tattoos = getTattoos(general.shopConfig, model)
    SendNUIMessage({ 
        method = 'openTattooShop', 
        data = {
            tattoos = tattoos, 
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
        LocalPlayer.state.pedTattoo = vSERVER.getCharacter()             
        -- setPedTattoo()
    else 
        -- setPedTattoo()
    end
end)