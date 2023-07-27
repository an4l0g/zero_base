RegisterCommand('vec2', function(source)
    local source = source
    local user_id = zero.getUserId(source)
    if (user_id) and zero.hasPermission(user_id, 'staff.permissao') then
        local pCoord = GetEntityCoords(GetPlayerPed(source))
        TriggerClientEvent('clipboard', source, 'Vector2', tostring(vector2(pCoord.x, pCoord.y)))
    end
end)