RegisterNetEvent('vrp_setgroup:openPanel',function(useridentity, usergroups, sysgroups)
  	SetNuiFocus(true, true)
  	SendNUIMessage({ type = 'openNUI', user_identity = useridentity, usergroups = usergroups, sysgroups = sysgroups  })
end)

RegisterNetEvent('vrp_setgroup:update',function(usergroups)
  	SendNUIMessage({ type = 'attUserGroups', usergroups = usergroups  })
end)

RegisterNUICallback('close', function(data, cb)
  	SetNuiFocus(false)
end)

RegisterNUICallback('addGroup', function(data, cb)
    TriggerServerEvent("vrp_setgroup:add", data.user_id, data.group, data.grade)
end)

RegisterNUICallback('delGroup', function(data, cb)
    TriggerServerEvent("vrp_setgroup:del", data.user_id, data.group, data.grade)
end)