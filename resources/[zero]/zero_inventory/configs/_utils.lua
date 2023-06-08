split = function(s, delimiter)
    result = {};
    for match in (s..delimiter):gmatch("(.-)"..delimiter) do
        table.insert(result, match);
    end
    return result;
end

sPairs = function(t)
    local keys = {}
    for k in pairs(t) do
        table.insert(keys, k)
    end
    table.sort(keys)

    local i = 0
    return function()
        i = i + 1
        local key = keys[i]
        if key then
            return key, t[key]
        end
    end
end