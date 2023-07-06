local vSERVER = Tunnel.getInterface('skinShop')
local config = module('zero_appearance', 'cfg/cfgSkin')

local locsConfig = config.locs
local generalConfig =  config.general

local getDrawables = function()
    local ped = PlayerPedId()
    local pedDrawables = {
        { torso = GetNumberOfPedDrawableVariations(ped, 3), '3' },
        { legs = GetNumberOfPedDrawableVariations(ped, 4), '4' },
        { hands = GetNumberOfPedDrawableVariations(ped, 5), '5' },
        { fool = GetNumberOfPedDrawableVariations(ped, 6), '6' },
        { accessories = GetNumberOfPedDrawableVariations(ped, 8), '8' },
        { acessories2 = GetNumberOfPedDrawableVariations(ped, 9), '9' },
        { decals = GetNumberOfPedDrawableVariations(ped, 10), '10' },
        { torso2 = GetNumberOfPedDrawableVariations(ped, 11), '11' },
        { helmet = GetNumberOfPedPropDrawableVariations(ped, 0), 'p0' },
        { glasses = GetNumberOfPedPropDrawableVariations(ped, 1), 'p1' },
        { ear = GetNumberOfPedPropDrawableVariations(ped, 2), 'p2' }
    }
    return pedDrawables
end

local skinIndex;
local skinValue;
local skinMarkers = {}

local mainThread = function()
    SetNuiFocus(false, false)
    FreezeEntityPosition(PlayerPedId(), false)
    getNearestSkin = function()
        local ped = PlayerPedId()
        local pCoord = GetEntityCoords(ped)
        local skinCoords = {}
        for k, v in ipairs(locsConfig) do
            local distance = #(pCoord - v.coord.xyz)
            if (distance <= 10) then
                table.insert(skinCoords, v)
            end
        end
        return skinCoords
    end

    addBlips(locsConfig, generalConfig)

    while (true) do
        local idle = 1000
        if (not inMenu) then   
            local nearestSkin = getNearestSkin() 
            if (nearestSkin) then
                local ped = PlayerPedId()
                local pCoord = GetEntityCoords(ped)
                for k, v in pairs(nearestSkin) do
                    local coord = vector3(v.coord.xyz)
                    local distance = #(pCoord - coord)
                    if (distance > 10 or GetEntityHealth(ped) <= 101) then
                        nearestSkin = nil
                        closeNui()
                        break
                    else
                        idle = 5
                        createMarkers(coord)
                        if (distance <= 1.2 and IsControlJustPressed(0, 38) and GetEntityHealth(ped) > 101) then
                            openSkinShop(k)
                        end
                    end
                end
            end
        end
        Citizen.Wait(idle)
    end
end

CreateThread(mainThread)

openSkinShop = function(locs)
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

    local sex;
    if (model == GetHashKey('mp_m_freemode_01')) then sex = 'male';
    elseif (model == GetHashKey('mp_f_freemode_01')) then sex = 'female';
    else
        local peds = general.customPeds
        if (peds) then
            local allowed = peds[model]
            if (allowed) then
                if (type(allowed) == 'string') then sex = allowed;
                else sex = 'male';
                end
            end
        end
    end

    local drawables = getDrawables()
    SendNUIMessage({
        action = 'openSkinShop',
        data = {
            type = general.shopType,
            config = general.shopConfig,
            sex = (model == GetHashKey('mp_m_freemode_01') and 'male' or 'female'),
            drawables = drawables
        }
    })

    Citizen.Wait(500) 
    if (not DoesCamExist(tempCam)) then createCam('body'); end;
    FreezeEntityPosition(ped, true)
end