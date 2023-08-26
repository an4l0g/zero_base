local cli = {}
Tunnel.bindInterface('Clothes', cli)
local vSERVER = Tunnel.getInterface('Clothes')

local checkValues = function(value, prop)
    if numero < 0 then
        ClearPedProp(ped, 7) -- 7 é o index do prop
    end
end

cli.getCurrentPreset = function()
    local ped = PlayerPedId()
    local currentPreset = {
        ['1'] = { model = GetPedDrawableVariation(ped, 1), var = GetPedTextureVariation(ped, 1) },
        ['3'] = { model = GetPedDrawableVariation(ped, 3), var = GetPedTextureVariation(ped, 3) },
        ['4'] = { model = GetPedDrawableVariation(ped, 4), var = GetPedTextureVariation(ped, 4) },
        ['5'] = { model = GetPedDrawableVariation(ped, 5), var = GetPedTextureVariation(ped, 5) },
        ['6'] = { model = GetPedDrawableVariation(ped, 6), var = GetPedTextureVariation(ped, 6) },
        ['7'] = { model =  GetPedDrawableVariation(ped, 7), var = GetPedTextureVariation(ped, 7) },
        ['8'] = { model = GetPedDrawableVariation(ped, 8), var = GetPedTextureVariation(ped, 8) },
        ['9'] = { model = GetPedDrawableVariation(ped, 9), var = GetPedTextureVariation(ped, 9) },
        ['11'] = { model = GetPedDrawableVariation(ped, 11), var = GetPedTextureVariation(ped, 11) },
        ['p0'] = { model = checkValues(GetPedPropIndex(ped, 0)), var = GetPedPropTextureIndex(ped, 0) },
        ['p1'] = { model = checkValues(GetPedPropIndex(ped, 1)), var = GetPedPropTextureIndex(ped, 1) },
        ['p2'] = { model = checkValues(GetPedPropIndex(ped, 2)), var = GetPedPropTextureIndex(ped, 2) },
        ['p6'] = { model = checkValues(GetPedPropIndex(ped, 6)), var = GetPedPropTextureIndex(ped, 6) },
        ['p7'] = { model = checkValues(GetPedPropIndex(ped, 7)), var = GetPedPropTextureIndex(ped, 7) },
    }
    return currentPreset
end

cli.setClothes = function(clothes)
    local ped = PlayerPedId()
    zero._playAnim(true, {{'clothingshirt','try_shirt_positive_d'}}, false)
    Wait(2000)
    ClearPedTasks(ped)
    for k, v in pairs(clothes) do
        local isProp, index = exports.zero:parsePart(k)
        if (isProp) then
            SetPedPropIndex(ped, index, v.model, v.var, 0)
        else
            SetPedComponentVariation(ped, parseInt(k), v.model, v.var,  0)
        end
    end
end

cli.getClothesPresets = function()
    return vSERVER.getAllPresets()
end
exports('getClothesPresets', cli.getClothesPresets)