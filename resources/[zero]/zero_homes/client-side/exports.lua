insideHome = function(source)
    local homeName = cli.homeName()
    if (homeName ~= '') then
        return true
    end
    return false
end
exports('insideHome', insideHome)