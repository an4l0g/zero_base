local locsConfig = config.locsSkinShop
local generalConfig =  config.generalSkinShop

local inSkinShop = false
local nui = false
local nearestBlip = {}

Citizen.CreateThread(function()
    while true do
        if (not inSkinShop and not nui) then
            local pedCoords = GetEntityCoords(PlayerPedId())
            if (nearestBlip) and nearestBlip['coord'] then
                local distance = #(pedCoords - nearestBlip['coord'].xyz)
                if (distance >= 6.0) then
                    nearestBlip = false
                elseif (distance <= 1.2) then
                    nearestBlip['close'] = true
                else
                    nearestBlip['close'] = false
                end
            else
                for k, v in pairs(locsConfig) do
                    local distance = #(pedCoords - v['coord'].xyz)
                    if (distance <= 5.0) then
                        nearestBlip = locsConfig[k]
                    end
                end
            end
        end
        Citizen.Wait(500)
    end
end)

Citizen.CreateThread(function()
    while true do
        local idle = 500
        local ped = PlayerPedId()
        if (not inSkinShop and not nui) then
            if (nearestBlip) and nearestBlip['coord'] then
                idle = 4
                if (IsControlJustPressed(0, 38) and GetEntityHealth(ped) > 101 and not IsPedInAnyVehicle(ped)) then
                    openSkinShop(generalConfig[nearestBlip['config']], nearestBlip['coord'].xyz, nearestBlip['coord'].w)
                end
            end
        end
        Citizen.Wait(idle)
    end
end)

local oldCustom = {}
local value = 0
local totalValue = 0

local getCustomization = function()
    local ped = plyPed
    local custom = {}
    custom.modelhash = GetEntityModel(ped)

    for i = 0, 20 do
        custom[i] = { GetPedDrawableVariation(ped, i), GetPedTextureVariation(ped, i), GetPedPaletteVariation(ped, i) }
    end

    for i = 0, 10 do
        custom['p'..i] = { GetPedPropIndex(ped, i), math.max(GetPedPropTextureIndex(ped, i), 0) }
    end
    return custom
end

local shopProvador = function() 
    Citizen.CreateThread(function()
        while (inSkinShop) do
            DisableControlAction(1, 1, true)
            DisableControlAction(1, 2, true)
            DisableControlAction(1, 24, true)
            DisablePlayerFiring(PlayerPedId(), true)
            DisableControlAction(1, 142, true)
            DisableControlAction(1, 106, true)
            DisableControlAction(1, 37, true)
            Citizen.Wait(4)
        end
    end)
end

local parsePart = function(key)
    if (type(key) == 'string' and string.sub(key, 1, 1) == 'p') then
        return true, tonumber(string.sub(key, 2))
    else
        return false, tonumber(key)
    end
end

local getSkinShopDrawables = function(part)
    local ped = PlayerPedId()
    local isProp, index = parsePart(part)
    if (isProp) then
        return GetNumberOfPedPropDrawableVariations(ped, index)
    else
        return GetNumberOfPedDrawableVariations(ped, index)
    end
end

local openNuiShop = function(config, _oldCustom)
    local ped = PlayerPedId()
    -- SetNuiFocus(true, true)

    local pedModel = GetEntityModel(ped)
    local sex = ''
    local prefix = ''
    if (pedModel == GetHashKey('mp_m_freemode_01')) then
        sex = 'Male'; prefix = 'M';
    elseif (pedModel == GetHashKey('mp_f_freemode_01')) then
        sex = 'Female'; prefix = 'F';
    else
        local customPeds = config['customPeds']
        if (customPeds) then
            local allowed = customPeds[pedModel]
            if (allowed) then
                if type(allowed) == 'string' then
                    sex = allowed
                    prefix = allowed:sub(1,1)
                else
                    sex = 'Male'
                    prefix = 'M'   
                end
            end
        end
    end

    drawVariations = getSkinShopDrawables(1)
    drawProps = getSkinShopDrawables('p1')
end

openSkinShop = function(config, coords, heading)
    local ped = PlayerPedId()
    inSkinShop = true
    value = 0
    totalValue = 0
    oldCustom = getCustomization()

    shopProvador()

    SetEntityCoords(ped, coords)
    SetEntityHeading(ped, heading)
    ClearPedTasks(ped)
    -- FreezeEntityPosition(ped, true)
    IsEntityStatic(ped)

    openNuiShop(config, oldCustom)
end