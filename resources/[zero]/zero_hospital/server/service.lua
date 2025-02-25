tableName = 'hospital'
zero.prepare('zero_hospital:registerService','insert into '..tableName..' (doctor_id, patient_id, total_price, service_date, request, description) values (@doctor_id, @patient_id, @total_price, @service_date, @request, @description)');
zero.prepare('zero_hospital:listServicesByPatient','select * from ' ..tableName.. ' where patient_id like @search order by service_date desc limit 7 offset @offset');
zero.prepare('zero_hospital:listServicesByDoctor','select * from ' ..tableName.. ' where doctor_id like @search order by service_date desc limit 7 offset @offset');
zero.prepare('zero_hospital:countServicesByPatient','select COUNT(*) from ' .. tableName ..' where patient_id like @search');
zero.prepare('zero_hospital:countServicesByDoctor','select COUNT(*) from ' .. tableName ..' where doctor_id like @search');

sHospital.servicesAmount = function(page, search, typeSearch)
    if typeSearch == 'patient_id' then
        return zero.query('zero_hospital:countServicesByPatient', { search = '%' .. search .. '%' })[1]['COUNT(*)']
    end
    if typeSearch == 'doctor_id' then
        return zero.query('zero_hospital:countServicesByDoctor', { search = '%' .. search .. '%' })[1]['COUNT(*)']
    end
end

sHospital.registerService = function(data)
    local _source = source
    local doctor_id = zero.getUserId(_source)
    local patient = zero.getUserIdentity(data.patient_id)

    zero.execute('zero_hospital:registerService', { 
        doctor_id = doctor_id,
        patient_id = data.patient_id,
        patient_name = patient.firstname ..' '..patient.lastname,
        total_price = data.total_price,
        service_date = os.date("%Y-%m-%d %H:%M:%S"),
        request = data.request, 
        description = data.description
    })

    zero.formatWebhook('registerService', 'Registrar serviço', {
        { 'id Medico', doctor_id },
        { 'id Paciente', data.patient_id },
        { 'Valor total', data.total_price },
        { 'Descricao', data.description },
        { 'Solicitacao', data.request },
    })
end

--Serviços feitos no dia
sHospital.listServices = function(page, search, typeSearch) 
    local services = {}
    if typeSearch == 'patient_id' then
        services = zero.query('zero_hospital:listServicesByPatient', { offset = (tonumber(page) - 1) * 7, search = '%' .. search .. '%' })
    end
    if typeSearch == 'doctor_id' then
        services = zero.query('zero_hospital:listServicesByDoctor', { offset = (tonumber(page) - 1) * 7, search = '%' .. search .. '%' })
    end
    for k,v in pairs(services) do
        local patient = zero.getUserIdentity(v.patient_id) or { firstname = '', lastname = '' }
        local doctor = zero.getUserIdentity(v.doctor_id) or { firstname = '', lastname = '' }

        services[k].patient_name = patient.firstname..' '..patient.lastname
        services[k].doctor_name = doctor.firstname..' '..doctor.lastname
    end

    return services
end

sHospital.requestCancelService = function()
    local _source = source
    return zero.request(_source,'Deseja realmente cancelar este atendimento?', 20000)
end

sHospital.alert = function()
    local users = zero.getUsersByPermission('hospital.permissao') 
    for k,v in pairs(users) do
        local userSource = zero.getUserSource(v)
        if userSource then
            async(function()
                TriggerClientEvent('announcement', userSource, 'Centro Médico', 'Uma nova solicitação de atendimento foi aberta!', 'Centro Médico Zero', true)
            end)
        end
    end
end

sHospital.requestService = function()
    local _source = source
    local user_id = zero.getUserId(_source)
    local user_identity = zero.getUserIdentity(user_id)
    local request = zero.prompt(_source,{'Bem vindo(a) ao Centro Médico ZERO, em que podemos te ajudar?'})

    if request then
        if services['id:'..user_id] == nil then
            services['id:'..user_id] = {
                patient_name = user_identity.firstname .. ' ' .. user_identity.lastname,
                patient_id = user_id,
                request = request[1],
                pos = servicePosition
            }
            servicePosition = servicePosition + 1 
            servicesCount = servicesCount + 1
            TriggerClientEvent('notify', _source, 'Centro Médico', 'Uma nova solicitação de atendimento foi aberta.')
            sHospital.alert()
            zero.formatWebhook('requestService', 'solicitacao de atendimento', {
                { 'id', user_id },
                { 'Solicitacao', request[1] },
            })
        else
            TriggerClientEvent('notify', _source, 'Centro Médico','Você já possui uma solicitação de atendimento aberta.')
        end   
    end
end

sHospital.acceptService = function() 
    local _source = source
    local user_id = zero.getUserId(_source)
    local firstService = nil
    local firstPos = nil
    for key,value in pairs(services) do 
        if firstService == nil or value.pos < firstPos then
            firstService = value
            firstPos = value.pos
        end
    end

    zero.formatWebhook('acceptService', 'Aceitar solicitacao', {
        { 'id Medico', user_id },
        { 'id Paciente', firstService.patient_id },
        { 'Solicitacao', firstService.request },
    })

    local patient_source = zero.getUserSource(user_id)
    local doctor = zero.getUserIdentity(user_id)
    if patient_source then
        TriggerClientEvent('announcement', patient_source, 'Centro Médico', 'Você será atendido por: <b>'..doctor.firstname ..' '..doctor.lastname..'</b>. Dirija-se à sala de emergência!', 'Centro Médico Zero', true)
    end

    services['id:'..firstService.patient_id] = nil
    servicesCount = servicesCount - 1
    return firstService
end


sHospital.getServicesPendingsAmount = function() 
    return servicesCount
end

sHospital.cancelLog = function(service)
    local _source = source
    local user_id = zero.getUserId(_source)
    local patient_source = zero.getUserSource(service.patient_id)
    if patient_source then
        TriggerClientEvent('announcement', patient_source, 'Centro Médico', 'A sua solicitação de serviço atual foi cancelada!', 'Centro Médico Zero', true)
    end
    zero.formatWebhook('cancelService', 'Cancelar servico', {
        { 'id Medico', user_id },
        { 'id Paciente', service.patient_id },
        { 'Solicitacao', service.request },
    })
end