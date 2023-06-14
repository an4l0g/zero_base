sHospital = {} 
Tunnel.bindInterface('zero_hospital',sHospital)
cHospital = Tunnel.getInterface('zero_hospital')

zero = Proxy.getInterface('zero')

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



