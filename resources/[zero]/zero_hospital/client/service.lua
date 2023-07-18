RegisterNUICallback('changeFilter', function(data)
    page = data.page
    search = data.search
    typeSearch = data.typeSearch

    cHospital.updateNui()
end)

RegisterNUICallback('cancelService', function()
    SetNuiFocus(false, false)
    TriggerEvent('zero_core:stopTabletAnim')
    local response = sHospital.requestCancelService()
    if response then
        sHospital.cancelLog(service)
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
