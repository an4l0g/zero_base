local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")
vRP = Proxy.getInterface("vRP")

local baseGroups = {}

function painelSysGroups()
    baseGroups = {}
    for group, groupData in pairs(vRP.getGroups()) do
        if groupData._config and groupData._config.grades then
            local grades = {}
            for k,_ in pairs(groupData._config.grades) do
                table.insert(grades,k)
            end
            table.insert(baseGroups,{ group = group, grades = grades })
        else
            table.insert(baseGroups,{ group = group, grades = { group } })
        end
    end
end
Citizen.CreateThread(painelSysGroups)
AddEventHandler("vRP:groupsRefresh",painelSysGroups)

function painelUserGroups(user_id)
    local cb = {}
    for group, info in pairs(vRP.getUserGroups(user_id)) do
        table.insert(cb,{ group = group, grade = info.grade })
    end
    return cb
end

RegisterCommand("setgroup", function(source, args)
    local source = source
    local user_id = vRP.getUserId(source)
    if args[1] and vRP.hasPermission(user_id,"admin.permissao") then
        local nuser_id = parseInt(args[1])
        local usergroups = painelUserGroups(nuser_id)
        local identity = vRP.getUserIdentity(nuser_id) or { name = "[ Sem", firstname = "Identidade ]" }
        TriggerClientEvent("vrp_setgroup:openPanel", source, identity, usergroups, baseGroups)
    end
end)

RegisterNetEvent("vrp_setgroup:add",function(other_id,group,grade)
    local source = source
    local user_id = vRP.getUserId(source)
    if vRP.hasPermission(user_id,"admin.permissao") and other_id then
        vRP.addUserGroup(other_id,group,grade)
        local usergroups = painelUserGroups(other_id)
        TriggerClientEvent("vrp_setgroup:update",source,usergroups)
    end
end)

RegisterNetEvent("vrp_setgroup:del",function(other_id,group,grade)
    local source = source
    local user_id = vRP.getUserId(source)
    if vRP.hasPermission(user_id,"admin.permissao") and other_id then
        vRP.removeUserGroup(other_id,group)
        local usergroups = painelUserGroups(other_id)
        TriggerClientEvent("vrp_setgroup:update",source,usergroups)
    end
end)