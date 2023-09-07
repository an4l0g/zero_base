srv = {}
Tunnel.bindInterface(GetCurrentResourceName(), srv)
vCLIENT = Tunnel.getInterface(GetCurrentResourceName())

local baseGroups = {}

GetGroups = function()
    return config.groups
end
exports('GetGroups', GetGroups)

painelSysGroups = function()
    baseGroups = {}
    for group, groupData in pairs(config.groups) do
        if groupData.information and groupData.information.grades then
            local grades = {}
            for k,_ in pairs(groupData.information.grades) do
                table.insert(grades, k)
            end
            table.insert(baseGroups,{ group = group, grades = grades })
        else
            table.insert(baseGroups,{ group = group, grades = { group } })
        end
    end
end
Citizen.CreateThread(painelSysGroups)

painelUserGroups = function(user_id)
    local cb = {}
    for group, info in pairs(zero.getUserGroups(user_id)) do
        table.insert(cb, { group = group, grade = info.grade })
    end
    return cb
end

RegisterCommand('group', function(source, args)
    local user_id = zero.getUserId(source)
    if (user_id) and zero.hasPermission(user_id, '+Staff.Manager') then
        local prompt = zero.prompt(source, { 'Passaporte' })
        if (prompt) then
            prompt = prompt[1]
            
            local usergroups = painelUserGroups(prompt)
            local identity = (zero.getUserIdentity(prompt) or 'Indivíduo Indigente')
            vCLIENT.openNui(source, identity, usergroups, baseGroups)
        end
    end
end)

srv.addGroup = function(id, group, grade)
    local source = source
    zero.addUserGroup(id, group, grade)
    vCLIENT.updateNui(source, painelUserGroups(id))
    zero.webhook('Group', '```prolog\n[ZERO GROUPS]\n[ACTION]: (ADD GROUP)\n[USER]: '..zero.getUserId(source)..'\n[TARGET]: '..id..'\n[GROUP]: '..group..'\n[GRADE]: '..grade..os.date('\n[DATA]: %d/%m/%Y [HORA]: %H:%M:%S')..' \r```')
end

srv.delGroup = function(id, group, grade)
    local source = source
    zero.removeUserGroup(id, group)
    vCLIENT.updateNui(source, painelUserGroups(id))
    zero.webhook('UnGroup', '```prolog\n[ZERO GROUPS]\n[ACTION]: (UNGROUP)\n[USER]: '..zero.getUserId(source)..'\n[TARGET]: '..id..'\n[GROUP]: '..group..'\n[GRADE]: '..grade..os.date('\n[DATA]: %d/%m/%Y [HORA]: %H:%M:%S')..' \r```')
end

itsAJob = function(org)
    for k,v in pairs(config.groups) do
        if v.information.groupType == 'job' then
            if k == org then return true end
        end 
    end
    return false
end
exports('itsAJob', itsAJob)