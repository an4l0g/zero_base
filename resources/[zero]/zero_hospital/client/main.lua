cHospital = {} --lista vazia (table lua)
Tunnel.bindInterface('zero_hospital',cHospital)
sHospital = Tunnel.getInterface('zero_hospital')

RegisterNUICallback('registerService', function(data)
    sHospital.registerService(data.service_type,data.patient_id,data.product,data.amount,data.total_price)
end)

RegisterNUICallback('listDayServices', function()
    sHospital.listDayServices()
end)

RegisterNUICallback('listDayDoctorServices', function(data)
    sHospital.listDayDoctorServices(data.doctor_id)
end)

RegisterNUICallback('listDoctorServices', function(data)
    sHospital.listDoctorServices(data.doctor_id)
end)

RegisterNUICallback('listMedicalFile', function(data)
    sHospital.listMedicalFile(data.patient_id)
end)

---------------------CHAMADA DE COMANDOS DE TESTE----------------------------------

  RegisterCommand('listadiamedico', function(source,args) 
    print(json.encode(sHospital.listDayDoctorServices(args[1])))
  end)

  RegisterCommand('listamedico', function(source,args) 
    print(json.encode(sHospital.listDoctorServices(args[1])))
  end)

  RegisterCommand('prontuario', function(source,args) 
    print(json.encode(sHospital.listMedicalFile(args[1])))
  end)

  -----------------------------------------------------

  RegisterCommand('coordenadas', function(source, args)

    -- Obtenha a posição do jogador (Vector3)
    local playerCoords = GetEntityCoords(PlayerPedId())

    -- Imprima as coordenadas
    print(playerCoords)
end, false)

--vec3(-2070.085205, -1019.913269, 11.910712)

------------------------------------------------------

