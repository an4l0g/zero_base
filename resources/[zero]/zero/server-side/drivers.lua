Citizen.CreateThreadNow(function()
    -- oxmysql
    local ox_queries = {}
    
    local function ox_init(cfg)
        return (GetResourceState('oxmysql') ~= 'missing')
    end
    
    local function ox_prepare(name, query)
        ox_queries[name] = query
    end
    
    local function ox_query(name, params, mode)
        local query = ox_queries[name]
        if query then
            local response = async()

            if mode == 'execute' then
                exports['oxmysql']:update(query, params, function(affectedRows)
                    response( affectedRows or 0 )
                end)
            elseif mode == 'scalar' then
                exports['oxmysql']:scalar(query, params, function(scalar)
                    response(scalar)
                end)
            elseif mode == 'insert' then
                exports['oxmysql']:insert(query, params, function(insertId)
                    response(insertId)
                end)
            else
                exports['oxmysql']:query(query, params, function(rows)
                    response(rows, #rows)
                end)
            end

            return response:wait()
        end

        print( debug.traceback('^1[vRP] Not prepared query: '..tostring(name)..'') )
    end
    
    vRP.registerDBDriver('oxmysql', ox_init, ox_prepare, ox_query)
end)