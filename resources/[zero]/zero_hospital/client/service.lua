RegisterNUICallback('cancelService', function()
    SetNuiFocus(false, false)
    local response = sHospital.requestCancelService()
    if response then
        service = {}
        TriggerEvent('notify', 'Centro Médico', 'Você cancelou o atendimento atual!')
    end
end)

RegisterNUICallback('acceptService', function()
    service = sHospital.acceptService()
    cHospital.updateNui()
end)

RegisterNUICallback('registerService', function(data)
    sHospital.registerService(data)
    service = {}
    cHospital.updateNui()
    TriggerEvent('notify', 'Centro Médico', 'Você registrou o atendimento!')
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
    SendNuiMessage({
        action = 'updateDoctorServices',
        value = sHospital.listDoctorServices(data.doctor_id)
    })
end)

RegisterNUICallback('listMedicalFile', function(data)
    SendNuiMessage({
        action = 'updateMedicalFile',
        value = sHospital.listMedicalFile(data.patient_id)
    })
end)