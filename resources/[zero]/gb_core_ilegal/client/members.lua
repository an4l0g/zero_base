RegisterNUICallback('getAllMembers', function(data, cb)
    cb(json.encode(gbMembers.getAllMembers(data.fac)))
end)

RegisterNUICallback('searchUser', function(data, cb)
    cb(json.encode(gbMembers.searchUser(data.user_id)))
end)

RegisterNUICallback('admit', function(data, cb)
    cb(json.encode(gbMembers.admit(data.fac, data.user_id)))
end)

RegisterNUICallback('dismiss', function(data, cb)
    cb(json.encode(gbMembers.dismiss(data.fac, data.user_id)))
end)

RegisterNUICallback('updateRole', function(data, cb)
    cb(json.encode(gbMembers.updateRole(data.fac, data.user_id, data.method)))
end)

RegisterNUICallback('getMembersAmount', function(data, cb)
    cb(json.encode(gbMembers.getMembersAmount(data.fac)))
end)
