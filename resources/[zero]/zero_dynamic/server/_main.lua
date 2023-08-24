sDynamic = {}
interactions = {}
zero = Proxy.getInterface('zero')
dbTable = 'dynamic'

Tunnel.bindInterface('zero_dynamic', sDynamic)
cDynamic = Tunnel.getInterface('zero_dynamic')

zero.prepare('zero_dynamic:getFavorites', 'select * from '..dbTable..' where user_id = @user_id');
zero.prepare('zero_dynamic:setFavorite', 'insert into '..dbTable..' (user_id, action) values (@user_id, @action)');
zero.prepare('zero_dynamic:deleteFavorite', 'delete from '..dbTable..' where user_id = @user_id and action = @action');


sDynamic.handleAction = function(action, value)
    interactions[action](value)
end

sDynamic.setFavorite = function(action)
    local _source = source
    local user_id = zero.getUserId(_source)

    zero.execute('zero_dynamic:setFavorite', { action = action, user_id = user_id })
    cDynamic.openOrUpdateNui(_source)
end

sDynamic.getFavorites = function() -- DANIEL OTIMIZA ISSO AQUI
    local _source = source
    local user_id = zero.getUserId(_source)

    local favorites = zero.query('zero_dynamic:getFavorites', { user_id = user_id })
    local favoritesList = {}
    for k,v in pairs(favorites) do
        table.insert(favoritesList, v.action)
    end

    return favoritesList
end

sDynamic.deleteFavorite = function(action)
    local _source = source
    local user_id = zero.getUserId(_source)

    zero.execute('zero_dynamic:deleteFavorite', { action = action, user_id = user_id })
    cDynamic.openOrUpdateNui(_source)
end

sDynamic.checkPermission = function(permission)
    local _source = source
    local user_id = zero.getUserId(_source)
    return zero.hasPermission(user_id, permission)
end