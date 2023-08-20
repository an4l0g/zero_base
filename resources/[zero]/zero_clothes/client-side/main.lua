cClothes = {}
Tunnel.bindInterface('zero_clothes', cClothes)
sClothes = Tunnel.getInterface('zero_clothes')

local checkValues = function(value)
    if (value >= 0) then return value; end;
    return 0
end

cClothes.getCurrentPreset = function()
    local ped = PlayerPedId()
    local currentPreset = {
        ['1'] = { model = checkValues(GetPedDrawableVariation(ped, 1)), var = checkValues(GetPedTextureVariation(ped, 1)) },
        ['3'] = { model = checkValues(GetPedDrawableVariation(ped, 3)), var = checkValues(GetPedTextureVariation(ped, 3)) },
        ['4'] = { model = checkValues(GetPedDrawableVariation(ped, 4)), var = checkValues(GetPedTextureVariation(ped, 4)) },
        ['5'] = { model = checkValues(GetPedDrawableVariation(ped, 5)), var = checkValues(GetPedTextureVariation(ped, 5)) },
        ['6'] = { model = checkValues(GetPedDrawableVariation(ped, 6)), var = checkValues(GetPedTextureVariation(ped, 6)) },
        ['7'] = { model = checkValues( GetPedDrawableVariation(ped, 7)), var = checkValues(GetPedTextureVariation(ped, 7)) },
        ['8'] = { model = checkValues(GetPedDrawableVariation(ped, 8)), var = checkValues(GetPedTextureVariation(ped, 8)) },
        ['9'] = { model = checkValues(GetPedDrawableVariation(ped, 9)), var = checkValues(GetPedTextureVariation(ped, 9)) },
        ['11'] = { model = checkValues(GetPedDrawableVariation(ped, 11)), var = checkValues(GetPedTextureVariation(ped, 11)) },
        ['p0'] = { model = checkValues(GetPedPropIndex(ped, 0)), var = checkValues(GetPedPropTextureIndex(ped, 0)) },
        ['p1'] = { model = checkValues(GetPedPropIndex(ped, 1)), var = checkValues(GetPedPropTextureIndex(ped, 1)) },
        ['p2'] = { model = checkValues(GetPedPropIndex(ped, 2)), var = checkValues(GetPedPropTextureIndex(ped, 2)) },
        ['p6'] = { model = checkValues(GetPedPropIndex(ped, 6)), var = checkValues(GetPedPropTextureIndex(ped, 6)) },
        ['p7'] = { model = checkValues(GetPedPropIndex(ped, 7)), var = checkValues(GetPedPropTextureIndex(ped, 7)) },
    }
    print(json.encode(currentPreset))
    return currentPreset
end

cClothes.setClothes = function(clothes)
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

cClothes.getClothesPresets = function()
    return sClothes.getAllPresets()
end
exports('getClothesPresets', cClothes.getClothesPresets)