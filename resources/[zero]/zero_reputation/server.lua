sRep = {}
cRep = Tunnel.getInterface('zero_reputation')
Tunnel.bindInterface('zero_reputation', sRep)
tableName = 'reputations'

zero.prepare('rep/insertRep', 'insert into '..tableName..' (org, description, points, created_at) values (:org, :description, :points, :createdAt)');
zero.prepare('rep/getRanking', 'select org, sum(points) as total_points from '..tableName..' group by org order by total_points desc');
zero.prepare('rep/getReps', 'select * from '..tableName..' where org = :org order by id desc limit 30');
zero.prepare('rep/clearReps', 'DELETE FROM '..tableName..' where id <> 0');

sRep.getRanking = function()
    return zero.query('rep/getRanking')
end

sRep.getReps = function(org)
    return zero.query('rep/getReps', { org = org }) or {}
end

sRep.addRep = function(org, description, points)
    zero.execute('rep/insertRep', { org = org, description = description, points = points, createdAt = os.date('%Y-%m-%d %H:%M:%S') })
end
exports('addRep', sRep.addRep)

RegisterCommand('rep', function(source, args)
    local user_id = zero.getUserId(source)
    if zero.hasPermission(user_id, 'staff.permissao') then
        local response = zero.prompt(source, { 'Facção/organização', 'Descrição', 'Pontuação' });    
        if #response == 3 then
            local org = response[1]
            local description = response[2]
            local points = parseInt(response[3])
            
            if exports.zero_setGroups:itsAJob(org) then
                if zero.request(source, 'Deseja realmente setar '..points..' pontos para '..org..'?') then
                    sRep.addRep(org, description, points)
                    TriggerClientEvent('notify', source, 'Sistema de Reputação', 'Reputação adicionada com sucesso.')    
                end
            else
                TriggerClientEvent('notify', source, 'Sistema de Reputação', 'Não existe essa organização.')    
            end
        else
            TriggerClientEvent('notify', source, 'Sistema de Reputação', 'Você precisa preencher todos os campos para adicionar reputação.')
        end
    else
        TriggerClientEvent('notify', source, 'Sistema de Reputação', 'Você não tem permissão para fazer isso.')
    end 
end)

RegisterCommand('rank', function(source, args)
    cRep.openNui(source, {
        action = 'open',
        rankList = sRep.getRanking()
    })
end)

RegisterCommand('clearreps', function(source, args)
    local user_id = zero.getUserId(source)
    if zero.hasPermission(user_id, 'staff.permissao') then
        if zero.request(source, 'Deseja realmente limpar todos os pontos de reputação?') then
            zero.execute('rep/clearReps')
            TriggerClientEvent('notify', source, 'Sistema de Reputação', 'Reputações limpas com sucesso.')
        end
    else
        TriggerClientEvent('notify', source, 'Sistema de Reputação', 'Você não tem permissão para fazer isso.')
    end
end)

sRep.addAutoRep = function(source, description, points)
    local user_id = zero.getUserId(source)

    local job, jobInfo = zero.getUserGroupByType(user_id, 'job')
    sRep.addRep(job, description, points)
    TriggerClientEvent('notify', source, 'Sistema de Reputação', 'Você ganhou 1 de reputação para sua organização.')
end
exports('addAutoRep', sRep.addAutoRep)