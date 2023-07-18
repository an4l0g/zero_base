cHospital = {} --lista vazia (table lua)
service = {}
page = 1
search = ''
typeSearch = 'patient_id'

Tunnel.bindInterface('zero_hospital',cHospital)
sHospital = Tunnel.getInterface('zero_hospital')

cHospital.updateNui = function()
  SendNUIMessage({
    action = 'open',
    pendingServicesAmount = sHospital.getServicesPendingsAmount(),
    currentService = service,
    prices = config.prices,
    servicesAmount = sHospital.servicesAmount(page, search, typeSearch),
    services = sHospital.listServices(page, search, typeSearch),
    filter = { page = page, search = search, typeSearch = typeSearch }
  })
end

RegisterNUICallback('close', function() 
  SetNuiFocus(false, false)
  page = 1
  search = ''
  typeSearch = 'patient_id'
  TriggerEvent('zero_core:stopTabletAnim')
end)

cHospital.open = function()
  SetNuiFocus(true, true)
  TriggerEvent('zero_core:tabletAnim')
  cHospital.updateNui()
end

Citizen.CreateThread(function() 
  local _sleep = 1000
  while true do
    local playerPed = PlayerPedId()
    local playerCoords = GetEntityCoords(playerPed)    

    if #(playerCoords - config.serviceBlipCoords) < 3 then
      _sleep = 1
      DrawMarker(27,config.serviceBlipCoords.x,config.serviceBlipCoords.y,config.serviceBlipCoords.z - 0.97,0,0,0,0,0,130.0,0.5,0.5,0.5,0,153, 255,200,0,0,0,1)
      if IsControlJustPressed(0, 38) then
        sHospital.requestService()
      end
    else
      _sleep = 1000
    end  
    Wait(_sleep)
  end
end)