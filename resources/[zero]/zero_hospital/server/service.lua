services = {}
servicePosition = 0

tableName = 'zero_hospital'
zero.prepare('zero_hospital:registerService','insert into '..tableName..' (doctor_id,service_type,patient_id,product,amount,total_price,service_date) values (@doctor_id,@service_type,@patient_id,@product,@amount,@total_price,@service_date)');
zero.prepare('zero_hospital:listDayServices','select * from ' ..tableName.. ' where DATE(service_date) = DATE(@service_date)');
zero.prepare('zero_hospital:listDayDoctorServices','select * from ' ..tableName.. ' where DATE(service_date) = DATE(@service_date) and doctor_id = @doctor_id');
zero.prepare('zero_hospital:listDoctorServices','select * from ' ..tableName.. ' where doctor_id = @doctor_id');
zero.prepare('zero_hospital:listMedicalFile','select * from ' ..tableName.. ' where patient_id = @patient_id');

sHospital.registerService = function(service_type,patient_id,product,amount,total_price)
    local _source = source
    local doctor_id = zero.getUserId(_source)

    zero.execute('zero_hospital:registerService', { 
        doctor_id = doctor_id,
        service_type = service_type,
        patient_id = patient_id,
        product = product,
        amount = amount,
        total_price = total_price,
        service_date = os.date("%Y-%m-%d %H:%M:%S")
    })
end

--Serviços feitos no dia
sHospital.listDayServices = function() 
    local services = zero.query('zero_hospital:listDayServices', { service_date = os.date("%Y-%m-%d")})
    return services
end


--Serviços do dia feitos por um médico específico
sHospital.listDayDoctorServices = function(doctor_id) 
    local servicesDoctorDay = zero.query('zero_hospital:listDayDoctorServices', { service_date = os.date("%Y-%m-%d"), doctor_id = doctor_id})
    return servicesDoctorDay
end

--Todos os Serviços feitos por um médico específico
sHospital.listDoctorServices = function(doctor_id) 
    local servicesDoctorDay = zero.query('zero_hospital:listDoctorServices', {doctor_id = doctor_id})
    return servicesDoctorDay
end

--Prontuário de um paciente específico
sHospital.listMedicalFile = function(patient_id) 
    local medicalFile = zero.query('zero_hospital:listMedicalFile', {patient_id = patient_id})
    return medicalFile
end

sHospital.requestService = function()
    local _source = source
    local user_id = zero.getUserId(_source)
    local user_identity = zero.getUserIdentity(user_id)
    local description = zero.prompt(_source,{'O que você está sentindo?'})

    if services[user_id] == nil then

        services[user_id] = {
            firstname = user_identity.firstname,
            lastname = user_identity.lastname,
            age = user_identity.age,
            user_id = user_id,
            description = description[1],
            pos = servicePosition
        }
        servicePosition = servicePosition + 1 
        TriggerClientEvent('notify', _source, 'Centro Médico','Uma nova solicitação de atendimento foi aberta.')
    else
        TriggerClientEvent('notify', _source, 'Centro Médico','Você já possui uma solicitação de atendimento aberta.')

    end   
end

sHospital.acceptService = function() 
    local firtService = nil
    local firstPos = nil
        for key,value in pairs(services) do 
            if firtService == nil or value.pos < firstPos then
                firtService = value
                firstPos = value.pos
            end
        end

    table.remove(services,firtService.user_id)
    return firtService
end


sHospital.getServicesPendingsAmount = function() 
    return #services -- services.Length
end
