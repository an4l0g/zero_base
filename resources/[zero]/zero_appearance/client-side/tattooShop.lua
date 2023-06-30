local locsConfig = configTattooShop.locs
local generalConfig =  configTattooShop.general

local inTattooShop = false
local nearestBlip = {}

local mainThread = function()
    local getNearestSkinShops = function()
        while true do
            if (not inTattooShop and not inMenu) then
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
    end

    CreateThread(getNearestSkinShops)
    addBlips(locsConfig)

    while true do
        local idle = 500
        local ped = PlayerPedId()
        if (not inTattooShop and not inMenu) then
            if (nearestBlip) and nearestBlip['coord'] then
                idle = 4
                DrawMarker(27, nearestBlip.coord.x, nearestBlip.coord.y, nearestBlip.coord.z, 0, 0, 0, 0, 0, 0, 1.0, 1.0, 1.0, 0, 153, 255, 155, 0, 0, 0, 1)
                if (IsControlJustPressed(0, 38) and GetEntityHealth(ped) > 101 and not IsPedInAnyVehicle(ped)) then
                    openTattooShop(generalConfig[nearestBlip['config']], nearestBlip['coord'].xyz, nearestBlip['coord'].w)
                end
            end
        end
        Citizen.Wait(idle)
    end
end

CreateThread(mainThread)

local tattoos
local oldCustom = {}

openTattooShop = function(config, coords, headin)
    local ped = PlayerPedId()
    inTattooShop = true

    SetNuiFocus(true, true)

    local sex = ''
    local pedModel = GetEntityModel(ped)
    
    if (pedModel == GetHashKey('mp_m_freemode_01')) then
        sex = 'male'; tattoos = config.shopConfig.partsM
    elseif (pedModel == GetHashKey('mp_f_freemode_01')) then
        sex = 'female'; tattoos = config.shopConfig.partsF
    end
    
    oldCustom = getCustomization()

    if (config['hidePlayers']) then setPlayersVisible(true); end;

    SetEntityCoords(ped, coords)
    SetEntityHeading(ped, heading)
    ClearPedTasks(ped)
    FreezeEntityPosition(ped, true)
    IsEntityStatic(ped)

    SendNUIMessage({ 
        method = 'openSkinShop', 
        data = {
            config = tattoos, 
            sex = sex, 
        }
    })
end