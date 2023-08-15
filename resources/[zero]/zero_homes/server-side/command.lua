gerarNome = function(nomeBase, contador)
    return nomeBase .. string.format("%04d", contador)
end

local nomeBase = ''
local contador = 1
local criados = {}
local tipoBase = ''
local oldName = ''

RegisterCommand('criar',function(source)
    local user_id = zero.getUserId(source)
    if (not user_id) and not zero.hasPermission(user_id, 'staff.permissao') then return; end;
    if (nomeBase == '') then
        local prompt = zero.prompt(source, { 'Nome da Residência', 'Tipo' })
        if (prompt) then
            nomeBase = prompt[1]
            tipoBase = prompt[2]
        end
        local nomeCompleto = gerarNome(nomeBase, contador)
        oldName = nomeCompleto
        table.insert(criados, {
            [nomeCompleto] = { coord = GetEntityCoords(GetPlayerPed(source)), type = tipoBase }
        })
        zeroClient.addBlip(source, GetEntityCoords(GetPlayerPed(source)).x, GetEntityCoords(GetPlayerPed(source)).y, GetEntityCoords(GetPlayerPed(source)).z, 1, 1, 'Marcou Aqui', 0.5, false)
        contador = contador + 1
    else
        local nomeCompleto = gerarNome(nomeBase, contador)
        oldName =  nomeCompleto
        table.insert(criados, {
            [nomeCompleto] = { coord = GetEntityCoords(GetPlayerPed(source)), type = tipoBase }
        })
        contador = contador + 1
        zeroClient.addBlip(source, GetEntityCoords(GetPlayerPed(source)).x, GetEntityCoords(GetPlayerPed(source)).y, GetEntityCoords(GetPlayerPed(source)).z, 1, 1, 'Marcou Aqui', 0.5, false)
    end
    serverNotify(source, 'Você criou a residência <b>'..oldName..'</b>.')
end)

RegisterCommand('pegar', function(source)
    local user_id = zero.getUserId(source)
    if (not user_id) and not zero.hasPermission(user_id, 'staff.permissao') then return; end;
    local linha = ''
    for nome, info in pairs(criados) do
        for k, v in pairs(info) do
            linha = linha.."\n ['"..k.."'] = { coord = "..tostring(v.coord)..", type = '"..v.type.."' },"
        end
    end
    TriggerClientEvent('clipboard', source, 'Pegar', linha)
end)