sDynamic = {}
interactions = {}
vRP = Proxy.getInterface('vRP')
dbTable = 'zero_dynamic'

Tunnel.bindInterface('zero_dynamic', sDynamic)
cDynamic = Tunnel.getInterface('zero_dynamic')

vRP.prepare('zero_dynamic:getFavorites', 'select * from '..dbTable..' where user_id = @user_id');
vRP.prepare('zero_dynamic:setFavorite', 'insert into '..dbTable..' (user_id, action) values (@user_id, @action)');
vRP.prepare('zero_dynamic:deleteFavorite', 'delete from '..dbTable..' where user_id = @user_id and action = @action');


sDynamic.handleAction = function(action, value)
    interactions[action](value)
end

sDynamic.setFavorite = function(action)
    local _source = source
    local user_id = vRP.getUserId(_source)

    vRP.execute('zero_dynamic:setFavorite', { action = action, user_id = user_id })
    cDynamic.openOrUpdateNui(_source)
end

sDynamic.getFavorites = function() -- DANIEL OTIMIZA ISSO AQUI
    local _source = source
    local user_id = vRP.getUserId(_source)

    local favorites = vRP.query('zero_dynamic:getFavorites', { user_id = user_id })
    local favoritesList = {}
    for k,v in pairs(favorites) do
        table.insert(favoritesList, v.action)
    end

    return favoritesList
end

sDynamic.deleteFavorite = function(action)
    local _source = source
    local user_id = vRP.getUserId(_source)

    vRP.execute('zero_dynamic:deleteFavorite', { action = action, user_id = user_id })
    cDynamic.openOrUpdateNui(_source)
end