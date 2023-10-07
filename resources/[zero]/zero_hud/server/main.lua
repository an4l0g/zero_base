local Tunnel = module("zero","lib/Tunnel")
local Proxy = module("zero","lib/Proxy")
vRP = Proxy.getInterface("vRP")

srv = {}
Tunnel.bindInterface(GetCurrentResourceName(), srv)
cli = Tunnel.getInterface(GetCurrentResourceName())

srv.checkPermission = function(permission)
    local _source = source
    local _userId = zero.getUserId(_source)
    if (_userId) and zero.hasPermission(_userId, permission) then
        return true
    end
    return false
end

RegisterCommand('facs', function(source, args)
    print('teste', source)
    local user_id = zero.getUserId(source)
    print(user_id)
    if (user_id and zero.checkPermissions(user_id, { '+Staff.Manager' })) then
        local holanda = zero.getUsersByPermission('holanda.permissao')
        local polonia = zero.getUsersByPermission('polonia.permissao')
        local russia = zero.getUsersByPermission('russia.permissao')
        local inglaterra = zero.getUsersByPermission('inglaterra.permissao')
        local tropa = zero.getUsersByPermission('tropa.permissao')
        local helipa = zero.getUsersByPermission('helipa.permissao')
        local camorra = zero.getUsersByPermission('camorra.permissao')
        local colombia = zero.getUsersByPermission('colombia.permissao')
        local canada = zero.getUsersByPermission('canada.permissao')
        local alemanha = zero.getUsersByPermission('alemanha.permissao')
        local zeromecanica = zero.getUsersByPermission('zeromecanica.permissao')

        TriggerClientEvent('notify', source, 'Prefeitura', 'Status das facções: <br> <br> <b>Holanda</b>: '..#holanda..' <br> <b>Polônia</b>: '..#polonia..'  <br> <b>Russia</b>: '..#russia..'  <br> <b>Inglaterra</b>: '..#inglaterra..'  <br> <b>Tropa</b>: '..#tropa..'  <br> <b>Helipa</b>: '..#helipa..' <br> <b>Camorra</b>: '..#camorra..' <br> <b>Colombia</b>: '..#colombia..' <br> <b>Canada</b>: '..#canada..' <br> <b>Alemanha</b>: '..#alemanha..' <br> <b>Zero Mecânica</b>: '..#zeromecanica)
    end
end)