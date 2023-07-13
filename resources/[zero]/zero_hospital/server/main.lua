sHospital = {} 
services = {}
servicesCount = 0
servicePosition = 0
Tunnel.bindInterface('zero_hospital',sHospital)
cHospital = Tunnel.getInterface('zero_hospital')
zero = Proxy.getInterface('zero')

RegisterCommand('ph', function(source)
    local user_id = zero.getUserId(source)
    if zero.hasPermission(user_id, 'hospital.permissao') then
        cHospital.open(source)
    else 
        TriggerClientEvent('notify', source, 'Centro Médico', 'Você não possui permissão para acessar o painel!')
    end
end)