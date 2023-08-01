RegisterNUICallback('registerCurrentGoal', function(data, cb)
    cb(json.encode(gbGoals.registerCurrentGoal(data.fac, data.product, data.qtd)))
end)

RegisterNUICallback('getCurrentGoals', function(data, cb)
    cb(json.encode(gbGoals.getCurrentGoals(data.fac)))
end)

RegisterNUICallback('deleteCurrentGoal', function(data, cb)
    cb(json.encode(gbGoals.deleteCurrentGoal(data.fac, data.id)))
end)

RegisterNUICallback('getProducts', function(data, cb)
    cb(json.encode(gbGoals.getProducts(data.fac)))
end)

RegisterNUICallback('sendGoal', function(data, cb)
    SetNuiFocus(false, false)
    cb(json.encode(gbGoals.sendGoal(data.fac, data.product, data.amount)))
end)

RegisterNUICallback('getAllMembersGoals', function(data, cb)
    cb(json.encode(gbGoals.getAllMembersGoals(data.fac)))
end)

RegisterNUICallback('deleteAllMembersGoals', function(data, cb)
    cb(json.encode(gbGoals.deleteAllMembersGoals(data.fac)))
end)
