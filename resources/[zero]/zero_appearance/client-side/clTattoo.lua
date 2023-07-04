local config = module('zero_appearance', 'cfg/cfgTattoo')

local locsConfig = config.locs
local generalConfig =  config.general

local tattooIndex;
local tattooValue;
local tattooMarkers = {}

local mainThread = function()
    getNearestTattoo = function()
        local ped = PlayerPedId()
        local pCoord = GetEntityCoords(ped)
        local tattooCoords = {}
        for k, v in ipairs(locsConfig) do
            local distance = #(pCoord - v.coord.xyz)
            if (distance <= 10) then
                table.insert(tattooCoords, v)
            end
        end
        return tattooCoords
    end
    
    addBlips(locsConfig, generalConfig)
    
    while (true) do
        local idle = 1000
        if (not inMenu) then   
            local nearestTattoo = getNearestTattoo() 
            if (nearestTattoo) then
                local ped = PlayerPedId()
                local pCoord = GetEntityCoords(ped)
                for k, v in pairs(nearestTattoo) do
                    local coord = vector3(v.coord.xyz)
                    local distance = #(pCoord - coord)
                    if (distance > 10 or GetEntityHealth(ped) <= 101) then
                        nearestTattoo = nil
                        closeNui()
                        break
                    else
                        idle = 5
                        createMarkers(coord)
                        if (distance <= 1.2 and IsControlJustPressed(0, 38) and GetEntityHealth(ped) > 101) then
                            openTattooShop(k)
                        end
                    end
                end
            end
        end
        Citizen.Wait(idle)
    end
end

CreateThread(mainThread)

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

    SendNUIMessage({ 
        method = 'openTattooShop', 
        data = {
            config = (model == GetHashKey('mp_m_freemode_01') and general.shopConfig.male or general.shopConfig.female), 
            sex = (model == GetHashKey('mp_m_freemode_01') and 'male' or 'female'), 
        }
    })

    Citizen.Wait(500) 
    if (not DoesCamExist(tempCam)) then createCam('body'); end;
    if (general.clothes) then setClothes(general.clothes); end;
    FreezeEntityPosition(ped, true)
end