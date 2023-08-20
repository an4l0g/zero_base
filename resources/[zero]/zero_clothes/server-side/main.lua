sClothes = {}
zero = Proxy.getInterface('zero')
cZero = Tunnel.getInterface('zero')
Tunnel.bindInterface('zero_clothes', sClothes) 
cClothes = Tunnel.getInterface('zero_clothes')

zero.prepare('zero_clothes:insertPreset', 'insert into clothes (title, preset, user_id) values (@title, @preset, @user_id)')
zero.prepare('zero_clothes:getAllPresets', 'select * from clothes where user_id = @user_id')
zero.prepare('zero_clothes:getPreset', 'select * from clothes where user_id = @user_id and title = @title')
zero.prepare('zero_clothes:deletePreset', 'delete from clothes where title = @title and user_id = @user_id')
zero.prepare('zero_clothes:deleteAllPreset', 'delete from clothes where user_id = @user_id')

sClothes.getAllPresets = function()
    local _source = source
    local user_id = zero.getUserId(_source)

    return zero.query('zero_clothes:getAllPresets', { user_id = user_id })
end

sClothes.verifyVip = function(user_id)
    local groups = zero.getUserGroups(user_id)
    local maxPresets = cfg.vips['default'];

    for k,v in pairs(groups) do
        local currentGroup = cfg.vips[v.grade]
        if currentGroup and currentGroup > maxPresets then
            maxPresets = currentGroup
        end 
    end

    return maxPresets
end

sClothes.verifyTitlePreset = function(presets, title)
    local titleExists = false
    for k,v in pairs(presets) do
        print(json.encode(v.title == title), title, v.title)
        if v.title == title then 
            titleExists = true
        end 
    end
    return titleExists
end

sClothes.addPreset = function()
    local _source = source
    local user_id = zero.getUserId(_source)
    local result = exports.zero_hud:prompt(_source, {
        'Escolha um nome para o seu novo preset!'
    })
    if result then
        result = result[1]
        local presets = zero.query('zero_clothes:getAllPresets', { user_id = user_id })
        if #presets < sClothes.verifyVip(user_id) then
            if sClothes.verifyTitlePreset(presets, result) then
                TriggerClientEvent('notify', _source, 'Roupas', 'Você já possui um preset com esse nome!')
            else
                local currentPreset = cClothes.getCurrentPreset(_source)
                zero.execute('zero_clothes:insertPreset', { title = result, user_id = user_id, preset = json.encode(currentPreset) })
                TriggerClientEvent('notify', _source, 'Roupas', 'Preset de roupas <b>'..result..'</b> salvo com sucesso!')
            end
        else
            TriggerClientEvent('notify', _source, 'Roupas', 'Você não possui slots suficientes para cadastrar um novo preset de roupas!')
        end
    end
end
RegisterNetEvent('zero_interactions:addPreset', sClothes.addPreset)

sClothes.usePreset = function(presetTitle)
    local _source = source
    local user_id = zero.getUserId(_source)

    local savedPreset = zero.query('zero_clothes:getPreset', { user_id = user_id, title = presetTitle })

    if savedPreset then
        savedPreset = savedPreset[1]
        cClothes.setClothes(_source, json.decode(savedPreset.preset))
        zero.execute('zero_appearance/saveClothes', { user_id = user_id, user_clothes = json.encode(savedPreset.preset) })
    end
end
RegisterNetEvent('zero_interactions:usePreset', sClothes.usePreset)

sClothes.deletePreset = function()
    local _source = source
    local user_id = zero.getUserId(_source)

    local result = exports.zero_hud:prompt(_source, {
        'Qual o nome do preset que você deseja deletar?'
    })
    
    if result then
        result = result[1]
        zero.execute('zero_clothes:deletePreset', { title = result, user_id = user_id })
        TriggerClientEvent('notify', _source, 'Roupas', 'Preset deletado com sucesso!')
    end
end
RegisterNetEvent('zero_interactions:deletePreset', sClothes.deletePreset)

sClothes.deleteAllPreset = function()
    local _source = source
    local user_id = zero.getUserId(_source)

    local request = zero.request(_source, 'Você deseja realmente deletar todos os presets de roupa?', 15000)
    if request then
        zero.execute('zero_clothes:deleteAllPreset', { user_id = user_id })
        TriggerClientEvent('notify', _source, 'Roupas', 'Presets deletados com sucesso!')
    end
end
RegisterNetEvent('zero_interactions:deleteAllPreset', sClothes.deleteAllPreset)