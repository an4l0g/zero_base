service = nil

RegisterNUICallback('cancelService', function()
 service = nil
 SetNuiFocus(false,false)
end)

RegisterNUICallback('acceptService', function()
    service = sHospital.acceptService()
end)

RegisterNUICallback('registerService', function(data)
    sHospital.registerService(data.service_type,data.patient_id,data.product,data.amount,data.total_price)
end)

RegisterNUICallback('listDayServices', function()
    SendNuiMessage{{
        action = 'updateDayServices',
        value = sHospital.listDayServices()
    }}
end)

RegisterNUICallback('listDayDoctorServices', function(data)
   SendNuiMessage{{
    action ='updateDayDoctorServices',
    value = sHospital.listDayDoctorServices(data.doctor_id)
   }} 
end)

RegisterNUICallback('listDoctorServices', function(data)
    SendNuiMessage{{
    action = 'updateDoctorServices'
    value = sHospital.listDoctorServices(data.doctor_id)
    }}
end)

RegisterNUICallback('listMedicalFile', function(data)
    SendNuiMessage{{
    action = 'updateMedicalFile'
    value = sHospital.listMedicalFile(data.patient_id)
    }}
end)