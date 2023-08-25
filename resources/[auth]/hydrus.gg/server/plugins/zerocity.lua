function Commands.addvehicle(user_id, model)
    local old = SQL('SELECT 1 FROM user_vehicles WHERE user_id=? AND vehicle=?', { user_id, model })
    if #old > 0 then
        return _('already.owned.self')
    end

    local data = { user_id = user_id, vehicle = model } 
    
    data.ipva = os.time()
    data.plate = exports["garages"]:generatePlate()
    data.chassis = exports["garages"]:generateChassis()

    SQL.insert('user_vehicles', data)
end

function Commands.completegamepass(user_id)
    exports["gb_gamepass"]:GivePassXP(user_id, 13000)
end

function Commands.addgamepass(user_id, gamepass)
    local row = SQL('SELECT gamepass FROM users WHERE id=?', { user_id })[1]
    if (row.gamepass == gamepass) then
        return _('already.owned.self')
    end
    SQL('UPDATE users SET gamepass=? WHERE id=?', { gamepass, user_id })
end

function Commands.remgamepass(user_id)
    local row = SQL('SELECT gamepass FROM users WHERE id=?', { user_id })[1]
    if (row.gamepass > 0) then
        SQL('UPDATE users SET gamepass=0 WHERE id=?', { user_id })
    end
end

function Commands.addhouse(user_id, name, interior)
    local old = SQL('SELECT user_id FROM homes WHERE owner=1 AND home=?', { name })[1]
        
    if old then
        if string.equals(user_id, old.user_id) then 
            return _('already.owned.self')
        end
        error(_('already.owned.someone'))
    end

    local homeDef = exports["homes"]:interiorDef(interior,true)

    SQL.insert('homes', {
        home = name,
        interior = homeDef.interior,
        tax = os.time(),
        user_id = user_id,
        price = homeDef.price,
        residents = homeDef.residents,
        vault = homeDef.vault,
        owner = 1,
       
    })
end

function Commands.delhouse(user_id, name)
    local exists = SQL('SELECT 1 FROM homes WHERE user_id=? AND home=?', { user_id, name })[1]
    if exists then
        SQL('DELETE FROM homes WHERE home=?', { name })
    end
end