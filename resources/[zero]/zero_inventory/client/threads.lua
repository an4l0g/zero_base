_sleep = 100
nearbyItemsGroups = {}
nextToAnyChest = false

renderDroppedItems = function()
    local playerCoords = GetEntityCoords(PlayerPedId())
    nearbyItemsGroups = {}
    for i,v in pairs(droppedItems) do
        if #(playerCoords - v.coords) <= config.marker_dropped_item_distance then
            table.insert(nearbyItemsGroups, v)
        end
    end
    local item = nearbyItemsGroups[1]
    if item ~= nil then
        if #(playerCoords - item.coords) <= config.marker_dropped_item_distance then
            if (not item.cdz) then
                local _,cdz = GetGroundZFor_3dCoord(item.coords.x,item.coords.y,item.coords.z)
                nearbyItemsGroups[1].cdz = cdz
            end
            item = nearbyItemsGroups[1]
            DrawMarker(0,item.coords.x,item.coords.y,item.cdz+0.3,0,0,0,0,0,130.0,0.15,0.15,0.15,0,153, 255,200,1,0,0,0)
        end
    end
end

renderChests = function()
    local playerPed = PlayerPedId()
    local playerCoords = GetEntityCoords(playerPed)
    nextToAnyChest = false
    for k,v in pairs(config.chests) do
        local nextToChest = false 
        local cdsChest = nil
        for icds, vcds in pairs(v.cds) do
            if #(playerCoords - vcds) <= 2 then
                nextToChest = true
                nextToAnyChest = true
                cdsChest = vcds
            end
        end

        if nextToChest then
            _sleep = 1
            cInventory.TextFloating('~b~[E]~w~ - '..v.title, cdsChest)
            if IsControlJustPressed(0,38) then
                local currentType = v.type
                local isPrivate = false
                if split(v.type, ':')[1] == 'priv' then
                    currentType = v.type..sInventory.getUserId()
                    isPrivate = true
                elseif v.type == 'cla' then
                    currentType = k
                end 
                if not zero.getNearestPlayer(config.marker_dropped_item_distance) or isPrivate then
                    if v.permission == nil then
                        cInventory.openInventory('open', currentType)
                    else
                        local hasPermission = sInventory.hasPermission(v.permission)
                        if hasPermission then 
                            cInventory.openInventory('open', currentType)
                        else 
                            config.functions.clientNotify(config.texts.notify_title, config.texts.notify_no_has_permission, 5000)
                        end
                    end
                else 
                    config.functions.clientNotify(config.texts.notify_title, config.texts.notify_nearest_player, 5000)
                end
            end
        else
            _sleep = 100
        end
    end
end

hotkeys = {
    [157] = 0,
    [158] = 1,
    [160] = 2,
    [164] = 3,
    [165] = 4
}

hotbarListener = function()
    if GetEntityHealth(PlayerPedId()) <= 100 then
        verifyNearest = false
        disableActions = false
        exports.zero_inventory:closeInventory()
    end
end

trunkDistanceControl = function()
    if nearbyVehicle ~= nil then 
        local vehicle = zero.vehList(5)
        
        if nearbyVehicle ~= vehicle then
            cInventory.closeInventory()
        end
    end
end

Citizen.CreateThread(function()
    while true do
        renderDroppedItems()
        renderChests()
        trunkDistanceControl()
        if nextToAnyChest or #nearbyItemsGroups > 0 or nearbyVehicle ~= nil then
            _sleep = 1
        else 
            _sleep = 100
        end
        Wait(_sleep)
    end
end)

Citizen.CreateThread(function()
    while (true) do
        DisableControlAction(1, 157, false) -- bind 1
        DisableControlAction(1, 158, false) -- bind 2
        DisableControlAction(1, 160, false) -- bind 3
        DisableControlAction(1, 164, false) -- bind 4
        DisableControlAction(1, 165, false) -- bind 5
        Citizen.Wait(1)
    end
end)

local useMiddleware = function(bind)
    local hotbar = sInventory.getHotbar()
    local currentIndex = nil

    currentIndex = hotbar[tostring(bind)]

    if currentIndex ~= nil and not (disableActions) then
        if (LocalPlayer.state.Handcuff) then return; end;
        if (LocalPlayer.state.BlockTasks) then return; end;
        sInventory.useItem(currentIndex.index, amount)
    end
end

RegisterCommand('+invbind01',function(source) useMiddleware(0); end)
RegisterCommand('+invbind02',function(source) useMiddleware(1); end)
RegisterCommand('+invbind03',function(source) useMiddleware(2); end)
RegisterCommand('+invbind04',function(source) useMiddleware(3); end)
RegisterCommand('+invbind05',function(source) useMiddleware(4); end)

RegisterKeyMapping('+invbind01', 'Bind Inventario 1', 'keyboard', '1')
RegisterKeyMapping('+invbind02', 'Bind Inventario 2', 'keyboard', '2')
RegisterKeyMapping('+invbind03', 'Bind Inventario 3', 'keyboard', '3')
RegisterKeyMapping('+invbind04', 'Bind Inventario 4', 'keyboard', '4')
RegisterKeyMapping('+invbind05', 'Bind Inventario 5', 'keyboard', '5')