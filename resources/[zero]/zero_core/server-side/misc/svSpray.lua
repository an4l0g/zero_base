local srv = {}
Tunnel.bindInterface('Spray', srv)
local vCLIENT = Tunnel.getInterface('Spray')

local config = module('zero_core', 'cfg/cfgSpray')
local configSpray = config.spray

zero.prepare('zero_spray/createSprays', 'insert zero_spray (config) values (@config)')
-- zero.prepare('zero_spray/deleteSprays', 'delete from zero_spray where ')

RegisterCommand('spray', function(source)
    local source = source
    local user_id = zero.getUserId(source)
    if (user_id) then
        local sprayText = zero.prompt(source, { 'Texto' })
        if (sprayText) then
            sprayText = sprayText[1]
            if (configSpray.blacklist[sprayText]) then
                TriggerClientEvent('notify', source, 'Spray', 'Este <b>texto</b> não é permitido.')
            else
                if (sprayText:len() <= 9) then
                    vCLIENT.createSpray(source, sprayText)
                else
                    TriggerClientEvent('notify', source, 'Spray', 'O <b>texto</b> pode ter até 9 caracteres')
                end
            end
        end
    end
end)

function GetSprayAtCoords(pos)
    for _, spray in pairs(SPRAYS) do
        if spray.location == pos then
            return spray
        end
    end
end

RegisterCommand('remover', function(source)
    local source = source
    local user_id = zero.getUserId(source)
    if (user_id) then
        local sprayAtCoords = GetSprayAtCoords(pos)
         
    end
end)

local sprays = {}

srv.addSpray = function(spray)
    local source = source
    local user_id = zero.getUserId(source)
    if (user_id) then
        CreateThread(function()
            local count = 1
            while (true) do
                if (not sprays[count]) then
                    sprays[count] = spray
                    break
                else
                    count = (count + 1)
                end 
                Citizen.Wait(1)
            end
        end)

        PersistSpray(spray)
        TriggerClientEvent('zero_spray:setSprays', -1, sprays)
    end
end

PersistSpray = function(spray)
    zero.execute('zero_spray/createSprays', { config = json.encode(spray) })
end