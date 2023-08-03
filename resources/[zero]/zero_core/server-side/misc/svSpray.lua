local srv = {}
Tunnel.bindInterface('Spray', srv)
local vCLIENT = Tunnel.getInterface('Spray')

local config = module('zero_core', 'cfg/cfgSpray')
local configSpray = config.spray

zero.prepare('zero_spray/createSprays', 'insert zero_spray (interior, x, y, z, rx, ry, rz, scale, spray_text, font, color) values (@interior, @x, @y, @z, @rx, @ry, @rz, @scale, @spray_text, @font, @color)')
zero.prepare('zero_spray/selectSprays', 'select interior, x, y, z, rx, ry, rz, scale, spray_text, font, color from zero_spray')
zero.prepare('zero_spray/deleteSprays', 'delete from zero_spray where x = @x and y = @y and z = @z limit 1')

-- FAZER FUNÇÃO PRA REMOVER NO RR

local sprays = {}

local GetSprayAtCoords = function(pos)
    for _, spray in pairs(sprays) do
        if (spray.location == pos) then return spray; end;
    end
end

Citizen.CreateThread(function()
    local result = zero.query('zero_spray/selectSprays')
    for _, s in pairs(result) do
        table.insert(sprays, {
            location = vector3(s.x + 0.00, s.y + 0.00, s.z + 0.00),
            realRotation = vector3(s.rx + 0.00, s.ry + 0.00, s.rz + 0.00),
            scale = tonumber(s.scale) + 0.0,
            text = s.spray_text,
            font = s.font,
            originalColor = s.color,
            color = configSpray.colors[s.color]['color'].hex,
            interior = ((s.interior == 1) and true or false),
        })
    end
    Citizen.Wait(1000)
    TriggerClientEvent('zero_spray:setSprays', -1, sprays)
end)

AddEventHandler('vRP:playerSpawn', function(user_id, source)
    TriggerClientEvent('zero_spray:setSprays', source, sprays)
end)

srv.getItem = function(item)
    local source = source
    local user_id = zero.getUserId(source)
    if (user_id) then
        zero.tryGetInventoryItem(user_id, item, 1)
    end
end

startSpray = function(source)
    local user_id = zero.getUserId(source)
    if (user_id) then
        local sprayText = zero.prompt(source, { 'Texto' })
        if (sprayText) then
            sprayText = sprayText[1]
            if (configSpray.blacklist[sprayText]) then
                LocalPlayer.state.BlockTasks = false
                TriggerClientEvent('notify', source, 'Spray', 'Este <b>texto</b> não é permitido.')
            else
                if (sprayText:len() <= 9) then
                    LocalPlayer.state.BlockTasks = true
                    vCLIENT.createSpray(source, sprayText)
                else
                    LocalPlayer.state.BlockTasks = false
                    TriggerClientEvent('notify', source, 'Spray', 'O <b>texto</b> pode ter até 9 caracteres')
                end
            end
        else
            LocalPlayer.state.BlockTasks = false
        end
    end
end
exports('startSpray', startSpray)

removeSpray = function(source)
    local source = source
    local user_id = zero.getUserId(source)
    if (user_id) then
        LocalPlayer.state.BlockTasks = true
        TriggerClientEvent('zero_spray:removeClosestSpray', source)        
    end
end
exports('removeSpray', removeSpray)

srv.addSpray = function(spray)
    local source = source
    local user_id = zero.getUserId(source)
    if (user_id) then
        table.insert(sprays, spray)
        PersistSpray(spray)
        TriggerClientEvent('zero_spray:setSprays', -1, sprays)
    end
end

RegisterNetEvent('zero_spray:remove', function(pos)
    local source = source
    local sprayAtCoords = GetSprayAtCoords(pos)
    zero.execute('zero_spray/deleteSprays', { x = pos.x, y = pos.y, z = pos.z })
    for idx, s in pairs(sprays) do
        if (s.location.x == pos.x and s.location.y == pos.y and s.location.z == pos.z) then
            sprays[idx] = nil
        end
    end
    Citizen.Wait(1000)
    TriggerClientEvent('zero_spray:setSprays', -1, sprays)
end)

PersistSpray = function(spray)
    zero.execute('zero_spray/createSprays', { interior = spray.interior, x = spray.location.x, y = spray.location.y, z = spray.location.z, rx = spray.realRotation.x, ry = spray.realRotation.y, rz = spray.realRotation.z, scale = spray.scale, spray_text = spray.text, font = spray.font, color = spray.originalColor })
end